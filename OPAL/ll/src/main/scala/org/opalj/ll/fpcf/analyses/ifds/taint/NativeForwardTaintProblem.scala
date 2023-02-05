/* BSD 2-Clause License - see OPAL/LICENSE for details. */
package org.opalj.ll.fpcf.analyses.ifds.taint

import org.opalj.br.Method
import org.opalj.br.analyses.SomeProject
import org.opalj.ifds.Callable
import org.opalj.ll.fpcf.analyses.ifds._
import org.opalj.ll.llvm.PointerType
import org.opalj.ll.llvm.value.{Alloca, Argument, BinaryOperation, Call, ConversionOperation, GetElementPtr, Load, PHI, Ret, Store}
import org.opalj.tac.ReturnValue
import org.opalj.tac.fpcf.analyses.ifds.taint._
import org.opalj.tac.fpcf.analyses.ifds.{JavaForwardICFG, JavaIFDSProblem, JavaStatement}

abstract class NativeForwardTaintProblem(project: SomeProject)
    extends NativeForwardIFDSProblem[NativeTaintFact, TaintFact](project)
    with TaintProblem[NativeFunction, LLVMStatement, NativeTaintFact] {
    override val javaICFG = new JavaForwardICFG(project)

    override def nullFact: NativeTaintFact = NativeTaintNullFact

    /**
     * Computes the data flow for a normal statement.
     *
     * @param statement   The analyzed statement.
     * @param in          The fact which holds before the execution of the `statement`.
     * @param predecessor The predecessor of the analyzed `statement`, for which the data flow shall be
     *                    computed. Used for phi statements to distinguish the flow.
     * @return The facts, which hold after the execution of `statement` under the assumption
     *         that the facts in `in` held before `statement` and `successor` will be
     *         executed next.
     */
    override def normalFlow(statement: LLVMStatement, in: NativeTaintFact, predecessor: Option[LLVMStatement]): Set[NativeTaintFact] = statement.instruction match {
        case _: Alloca => Set(in)
        case store: Store => in match {
            case NativeVariable(value) if value == store.src => store.dst match {
                case gep: GetElementPtr if gep.isConstant => Set(in, NativeArrayElement(gep.base, gep.constants)) ++
                    getPtrAliases(gep.base, statement.function).map(NativeArrayElement(_, gep.constants))
                case gep: GetElementPtr if !gep.isConstant => Set(in, NativeVariable(gep.base)) ++
                    getPtrAliases(gep.base, statement.function).map(NativeVariable)
                case _ => Set(in, NativeVariable(store.dst)) ++
                    getPtrAliases(store.dst, statement.function).map(NativeVariable)
            }
            case NativeVariable(value) if value == store.dst || getPtrAliases(value, statement.function).contains(store.dst) => Set()
            case NativeArrayElement(base, indices) => store.dst match {
                case gep: GetElementPtr if (gep.base == base || getPtrAliases(base, statement.function).contains(gep.base))
                    && gep.isConstant && gep.constants == indices => Set()
                case _ => Set(in)
            }
            case _ => Set(in)
        }
        case load: Load => in match {
            case NativeVariable(value) if value == load.src => Set(in, NativeVariable(load))
            case _                                          => Set(in)
        }
        case gep: GetElementPtr => in match {
            case NativeVariable(value) if value == gep.base =>
                Set(in, NativeVariable(gep)) ++ getPtrAliases(gep, statement.function).map(NativeVariable)
            case NativeArrayElement(base, indices) if gep.base == base && ((gep.isConstant && gep.constants == indices) || !gep.isConstant) =>
                // if base is tainted but indices are not constant, assume the value is tainted
                Set(in, NativeVariable(gep)) ++ getPtrAliases(gep, statement.function).map(NativeVariable)
            case _ => Set(in)
        }
        case binOp: BinaryOperation => in match {
            case NativeVariable(value) if value == binOp.op1 || value == binOp.op2 => Set(in, NativeVariable(binOp))
            case _ => Set(in)
        }
        case convOp: ConversionOperation => in match {
            case NativeVariable(value) if value == convOp.operand(0) => Set(in, NativeVariable(convOp))
            case _                                                   => Set(in)
        }
        case _ => Set(in)
    }

    /**
     * Computes the data flow for a call to start edge.
     *
     * @param call   The analyzed call statement.
     * @param callee The called method, for which the data flow shall be computed.
     * @param in     The fact which holds before the execution of the `call`.
     * @return The facts, which hold after the execution of `statement` under the assumption that
     *         the facts in `in` held before `statement` and `statement` calls `callee`.
     */
    override def callFlow(start: LLVMStatement, in: NativeTaintFact, call: LLVMStatement, callee: NativeFunction): Set[NativeTaintFact] = callee match {
        case LLVMFunction(callee) =>
            in match {
                // Taint formal parameter if actual parameter is tainted
                case NativeVariable(value) => call.instruction.asInstanceOf[Call].indexOfArgument(value) match {
                    case Some(index) => Set(NativeVariable(callee.argument(index)))
                    case None        => Set()
                }
                // TODO pass other java taints
                case NativeTaintNullFact => Set(in)
                case NativeArrayElement(base, indices) => call.instruction.asInstanceOf[Call].indexOfArgument(base) match {
                    case Some(index) => Set(NativeArrayElement(callee.argument(index), indices))
                    case None        => Set()
                }
                case _ => Set() // Nothing to do
            }
        case _ => throw new RuntimeException("this case should be handled by outsideAnalysisContext")
    }

    /**
     * Computes the data flow for an exit to return edge.
     *
     * @param call The statement, which called the `callee`.
     * @param exit The statement, which terminated the `callee`.
     * @param in   The fact which holds before the execution of the `exit`.
     * @return The facts, which hold after the execution of `exit` in the caller's context
     *         under the assumption that `in` held before the execution of `exit` and that
     *         `successor` will be executed next.
     */
    override def returnFlow(exit: LLVMStatement, in: NativeTaintFact, call: LLVMStatement, successor: Option[LLVMStatement],
                            unbCallChain: Seq[Callable]): Set[NativeTaintFact] = {
        val callee = exit.callable
        if (sanitizesReturnValue(callee)) return Set.empty
        val callInstr = call.instruction.asInstanceOf[Call]

        var flows: Set[NativeTaintFact] = in match {
            // check for tainted pass-by-reference parameters (pointer)
            case NativeVariable(value) => value match {
                case Argument(_, index) => value.typ match {
                    case PointerType(_) => Set(NativeVariable(callInstr.argument(index).get)) ++
                        getPtrAliases(callInstr.argument(index).get, call.function).map(NativeVariable).asInstanceOf[Set[NativeTaintFact]]
                    case _ => Set()
                }
                case _ => Set()
            }
            case NativeArrayElement(base, indices) => base match {
                case Argument(_, index) => base.typ match {
                    case PointerType(_) => Set(NativeArrayElement(callInstr.argument(index).get, indices)) ++
                        getPtrAliases(callInstr.argument(index).get, call.function).map(NativeArrayElement(_, indices)).asInstanceOf[Set[NativeTaintFact]]
                    case _ => Set()
                }
                case _ => Set()
            }
            case NativeTaintNullFact => Set(NativeTaintNullFact)
            case NativeFlowFact(flow) if !flow.contains(call.function) =>
                Set(NativeFlowFact(call.function +: flow))
            case _ => Set()
        }

        // taint return value in caller if tainted in callee
        exit.instruction match {
            case ret: Ret if ret.value.isDefined => in match {
                case NativeVariable(value) if ret.value.contains(value) =>
                    flows += NativeVariable(call.instruction)
                    flows ++= getPtrAliases(call.instruction, call.function).map(NativeVariable)
                case NativeArrayElement(base, indices) if ret.value.contains(base) =>
                    flows += NativeArrayElement(call.instruction, indices)
                    flows ++= getPtrAliases(call.instruction, call.function).map(NativeArrayElement(_, indices))
                case NativeTaintNullFact => flows ++= createTaints(callee, call)
                case _                   =>
            }
            case _ =>
        }

        flows ++= flows.filter(_.isInstanceOf[NativeArrayElement])
            .map(_.asInstanceOf[NativeArrayElement])
            .flatMap(arrElem => getPtrAliases(arrElem, call.function).map(NativeVariable))
        flows
    }

    /**
     * Computes the data flow for a call to return edge.
     *
     * @param call The statement, which invoked the call.
     * @param in   The facts, which hold before the `call`.
     * @return The facts, which hold after the call independently of what happens in the callee
     *         under the assumption that `in` held before `call`.
     */
    override def callToReturnFlow(call: LLVMStatement, in: NativeTaintFact, successor: Option[LLVMStatement],
                                  unbCallChain: Seq[Callable]): Set[NativeTaintFact] = createFlowFact(call, in) match {
        case Some(fact) => Set(in, fact)
        case None       => Set(in)
    }

    override def needsPredecessor(statement: LLVMStatement): Boolean = statement.instruction match {
        case PHI(_) => true
        case _      => false
    }

    override def outsideAnalysisContextUnbReturn(callee: NativeFunction): Option[OutsideAnalysisContextUnbReturnHandler] = None

    /**
     * Computes the data flow for a call to start edge.
     *
     * @param call The analyzed call statement.
     * @param callee The called method, for which the data flow shall be computed.
     * @param in The fact which holds before the execution of the `call`.
     * @param source The entity, which is analyzed.
     * @return The facts, which hold after the execution of `statement` under the assumption that
     *         the facts in `in` held before `statement` and `statement` calls `callee`.
     */
    override protected def javaCallFlow(
        start:  JavaStatement,
        call:   LLVMStatement,
        callee: Method,
        in:     NativeTaintFact
    ): Set[TaintFact] =
        in match {
            // Taint formal parameter if actual parameter is tainted
            case NativeVariable(value) => call.instruction.asInstanceOf[Call].indexOfArgument(value) match {
                case Some(index) => Set(Variable(JavaIFDSProblem.switchParamAndVariableIndex(
                    index - 2,
                    callee.isStatic
                )))
                case None => Set()
            }
            // TODO pass other java taints
            case NativeTaintNullFact => Set(TaintNullFact)
            case _                   => Set() // Nothing to do
        }

    /**
     * Computes the data flow for an exit to return edge.
     *
     * @param call The statement, which called the `callee`.
     * @param exit The statement, which terminated the `callee`.
     * @param in The fact which holds before the execution of the `exit`.
     * @return The facts, which hold after the execution of `exit` in the caller's context
     *         under the assumption that `in` held before the execution of `exit` and that
     *         `successor` will be executed next.
     */
    override protected def javaReturnFlow(
        exit:         JavaStatement,
        in:           TaintFact,
        call:         LLVMStatement,
        callFact:     NativeTaintFact,
        unbCallChain: Seq[Callable],
        successor:    Option[LLVMStatement]
    ): Set[NativeTaintFact] = {
        val callee = exit.callable
        if (sanitizesReturnValue(JNIMethod(callee))) return Set.empty
        var flows: Set[NativeTaintFact] = Set.empty
        in match {
            case StaticField(classType, fieldName) => flows += JavaStaticField(classType, fieldName)

            // Track the call chain to the sink back
            case FlowFact(flow) if !flow.contains(call.function) =>
                flows += NativeFlowFact(call.function +: flow)
            case _ =>
        }

        // Propagate taints of the return value
        if (exit.stmt.astID == ReturnValue.ASTID) {
            val returnValueDefinedBy = exit.stmt.asReturnValue.expr.asVar.definedBy
            in match {
                case Variable(index) if returnValueDefinedBy.contains(index) =>
                    flows += NativeVariable(call.instruction)
                case _ => // Nothing to do
            }
        }
        flows
    }

    /**
     * Creates a new variable fact for the callee, if the source was called.
     */
    protected def createTaints(callee: LLVMFunction, call: LLVMStatement): Set[NativeTaintFact]

    /**
     * Create a FlowFact, if sink is called with a tainted variable.
     */
    protected def createFlowFact(call: LLVMStatement, in: NativeTaintFact): Option[NativeFlowFact]
}