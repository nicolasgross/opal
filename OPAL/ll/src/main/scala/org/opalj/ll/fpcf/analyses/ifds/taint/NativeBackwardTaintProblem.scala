/* BSD 2-Clause License - see OPAL/LICENSE for details. */
package org.opalj.ll.fpcf.analyses.ifds.taint

import org.opalj.br.Method
import org.opalj.br.analyses.SomeProject
import org.opalj.ifds.Dependees.Getter
import org.opalj.ifds.{Callable, IFDSFact}
import org.opalj.ll.fpcf.analyses.ifds.{JNICallUtil, JNIMethod, LLVMFunction, LLVMStatement, McSemaUtil, NativeBackwardIFDSProblem, NativeFunction}
import org.opalj.ll.llvm.PointerType
import org.opalj.ll.llvm.value._
import org.opalj.tac.fpcf.analyses.ifds.JavaIFDSProblem.V
import org.opalj.tac.{ArrayLength, ArrayLoad, BinaryExpr, Compare, Expr, GetField, GetStatic, NewArray, PrefixExpr, PrimitiveTypecastExpr, ReturnValue, Var}
import org.opalj.tac.fpcf.analyses.ifds.{JavaBackwardICFG, JavaICFG, JavaIFDSProblem, JavaMethod, JavaStatement}
import org.opalj.tac.fpcf.analyses.ifds.taint.{ArrayElement, FlowFact, InstanceField, StaticField, TaintFact, TaintNullFact, TaintProblem, Variable}

/**
 * Implementation of the LLVM side of a Java-LLVM cross-language backward taint analysis.
 *
 * @author Nicolas Gross
 */
abstract class NativeBackwardTaintProblem(project: SomeProject)
    extends NativeBackwardIFDSProblem[NativeTaintFact, TaintFact](project)
    with TaintProblem[NativeFunction, LLVMStatement, NativeTaintFact] {
    override val javaICFG: JavaICFG = new JavaBackwardICFG(project)

    override def nullFact: NativeTaintFact = NativeTaintNullFact

    override def enableUnbalancedReturns: Boolean = true

    override def needsPredecessor(statement: LLVMStatement): Boolean = false

    /**
     * Whenever a value is stored in a tainted variable or array element, the value must be
     * tainted and the existing taint fact of the store destination must be removed. If a tainted variable is
     * loaded, the load source must be tainted. If a tainted variable is assigned the value of a GetElementPtr
     * statement, either a NativeVariable for the whole array or a NativeArrayElement taint fact must be created,
     * depending on whether the indices in the statement are constant or not. Whenever an expression, e.g.,
     * addition or typecast, is assigned to a tainted variable, the values in the expression must be tainted.
     *
     * @param statement   The analyzed statement.
     * @param in          The fact which holds before the execution of the `statement`.
     * @param predecessor The predecessor of the analyzed `statement`, for which the data flow shall be
     *                    computed. Used for phi statements to distinguish the flow.
     * @return The facts, which hold after the execution of `statement` under the assumption
     *         that the facts in `in` held before `statement` and `successor` will be
     *         executed next.
     */
    override def normalFlow(statement: LLVMStatement, in: NativeTaintFact,
                            predecessor: Option[LLVMStatement]): Set[NativeTaintFact] = statement.instruction match {
        case store: Store =>
            def handleArrayElem(base: Value, indices: Iterable[Long]): Set[NativeTaintFact] = store.dst match {
                // value is stored into tainted array element
                case gep: GetElementPtr if gep.base == base || getPtrAliases(base, statement.function).contains(gep.base) =>
                    if (gep.isConstant && gep.constants == indices)
                        Set(NativeVariable(store.src))
                    else if (!gep.isConstant)
                        // if indices are not constant, use over-approximation and taint both
                        Set(in, NativeVariable(store.src))
                    else Set(in)
                case _ => Set(in)
            }
            in match {
                // do not propagate in if in == store.dst, tainted value is overwritten
                case NativeVariable(value) if value == store.dst || getPtrAliases(value, statement.function).contains(store.dst) =>
                    Set(NativeVariable(store.src))
                case NativeGlobalVariable(value) if value == store.dst || getPtrAliases(value, statement.function).contains(store.dst) =>
                    Set(NativeVariable(store.src))
                case NativeArrayElement(base, indices)       => handleArrayElem(base, indices)
                case NativeGlobalArrayElement(base, indices) => handleArrayElem(base, indices)
                case _                                       => Set(in)
            }
        case load: Load =>
            def handleLoad: Set[NativeTaintFact] = {
                val srcTaint = load.src match {
                    case variable: GlobalVariable => Set(in, NativeGlobalVariable(variable))
                    case _                        => Set(in, NativeVariable(load.src))
                }
                srcTaint ++ getPtrAliases(load.src, statement.function).map {
                    case in: GlobalVariable => NativeGlobalVariable(in)
                    case in                 => NativeVariable(in)
                }
            }
            in match {
                case NativeVariable(value) if value == load      => handleLoad
                case NativeArrayElement(base, _) if base == load => handleLoad
                case _                                           => Set(in)
            }
        case gep: GetElementPtr =>
            def handleGep(gep: GetElementPtr): Set[NativeTaintFact] = {
                if (gep.isConstant) {
                    val baseTaint = gep.base match {
                        case base: GlobalVariable => Set(in, NativeGlobalArrayElement(base, gep.constants))
                        case _                    => Set(in, NativeArrayElement(gep.base, gep.constants))
                    }
                    baseTaint ++ getPtrAliases(gep.base, statement.function).map {
                        case in: GlobalVariable => NativeGlobalArrayElement(in, gep.constants)
                        case in                 => NativeArrayElement(in, gep.constants)
                    }
                } else {
                    val baseTaint = gep.base match {
                        case value: GlobalVariable => Set(in, NativeGlobalVariable(value))
                        case _                     => Set(in, NativeVariable(gep.base))
                    }
                    baseTaint ++ getPtrAliases(gep.base, statement.function).map {
                        case in: GlobalVariable => NativeGlobalVariable(in)
                        case in                 => NativeVariable(in)
                    }
                }
            }
            in match {
                case NativeVariable(value) if value == gep      => handleGep(gep)
                case NativeArrayElement(base, _) if base == gep => handleGep(gep) // nested arrays
                case _                                          => Set(in)
            }
        case fneg: FNeg => in match {
            case NativeVariable(value) if value == fneg => Set(in, NativeVariable(fneg.operand(0)))
            case _                                      => Set(in)
        }
        case binOp: BinaryOperation => in match {
            case NativeVariable(value) if value == binOp => Set(in, NativeVariable(binOp.op1), NativeVariable(binOp.op2))
            case _                                       => Set(in)
        }
        case convOp: ConversionOperation => in match {
            case NativeVariable(value) if value == convOp => Set(in, NativeVariable(convOp.convVal))
            case _                                        => Set(in)
        }
        case extrElem: ExtractElement =>
            def taintExtElemVec: Set[NativeTaintFact] = {
                if (extrElem.isConstant) Set(in, NativeArrayElement(extrElem.vec, Seq(0, extrElem.constant)))
                else Set(in, NativeVariable(extrElem.vec)) // taint whole array if index not constant
            }
            in match {
                case NativeVariable(value) if value == extrElem      => taintExtElemVec
                case NativeArrayElement(base, _) if base == extrElem => taintExtElemVec
                case _                                               => Set(in)
            }
        case insElem: InsertElement => in match {
            case NativeVariable(value) if insElem.vec == value => Set(in, NativeVariable(insElem.value)) // whole vector tainted
            case NativeArrayElement(base, indices) if insElem.vec == base => // specific vector element tainted
                // check if tainted element is written. if index is not constant, assume tainted element is written.
                if ((insElem.isConstant && indices == Seq(0, insElem.constant)) || !insElem.isConstant)
                    Set(in, NativeVariable(insElem.value))
                else Set(in)
            case _ => Set(in)
        }
        case shuffleVec: ShuffleVector => in match {
            // simplification: taint both input arrays as a whole
            case NativeVariable(value) if value == shuffleVec =>
                Set(in, NativeVariable(shuffleVec.vec1), NativeVariable(shuffleVec.vec2))
            case NativeArrayElement(base, _) if base == shuffleVec =>
                Set(in, NativeVariable(shuffleVec.vec1), NativeVariable(shuffleVec.vec2))
            case _ => Set(in)
        }
        case extrValue: ExtractValue => in match {
            case NativeVariable(value) if extrValue == value =>
                extrValue.constants.map(c => NativeArrayElement(extrValue.aggregVal, Seq(0, c))).toSet ++ Set(in)
            case NativeArrayElement(base, _) if base == extrValue =>
                // array loaded from array element -> nested arrays
                extrValue.constants.map(c => NativeArrayElement(extrValue.aggregVal, Seq(0, c))).toSet ++ Set(in)
            case _ => Set(in)
        }
        case insValue: InsertValue => in match {
            case NativeVariable(value) if insValue.aggregVal == value => Set(in, NativeVariable(insValue.value))
            // check if tainted element is written
            case NativeArrayElement(base, indices) if insValue.aggregVal == base && indices.head == 0 &&
                insValue.constants.contains(indices.toSeq(1)) => Set(in, NativeVariable(insValue.value))
            case _ => Set(in)
        }
        case _ => Set(in)
    }

    /**
     * If the return value is tainted in the caller context and the callee is not marked as sanitizer,
     * the return value must also be tainted in the callee context. Tainted pass-by-reference parameters and
     * global variables are always propagated to the callee.
     *
     * @param start  The statement, which starts the analysis of the 'callee'.
     * @param in     The fact which holds before the execution of the `call`.
     * @param call   The statement, which called the `callee`.
     * @param callee The called method, for which the data flow shall be computed.
     * @return The facts, which hold after the execution of `call` under the assumption that
     *         the fact `in` held before `call` and `call` calls `callee`.
     */
    override def callFlow(start: LLVMStatement, in: NativeTaintFact, call: LLVMStatement,
                          callee: NativeFunction): Set[NativeTaintFact] = {
        val callInstr = call.instruction.asInstanceOf[Call]
        val flows = collection.mutable.Set.empty[NativeTaintFact]
        callee match {
            case LLVMFunction(callee) =>
                // taint return value in callee, if tainted in caller
                if (!sanitizesReturnValue(start.callable)) {
                    start.instruction match {
                        case ret: Ret if ret.value.isDefined => in match {
                            case NativeVariable(value) if value == call.instruction => ret.value.get match {
                                case variable: GlobalVariable => flows += NativeGlobalVariable(variable)
                                case _                        => flows += NativeVariable(ret.value.get)
                            }
                            case NativeArrayElement(base, indices) if base == call.instruction => ret.value.get match {
                                case variable: GlobalVariable => flows += NativeGlobalArrayElement(variable, indices)
                                case _                        => flows += NativeArrayElement(ret.value.get, indices)
                            }
                            case _ =>
                        }
                        case _ =>
                    }
                }

                // TODO handle `byval` attribute or not? nested objects?
                in match {
                    // check for tainted pass-by-reference parameters (pointer)
                    case NativeVariable(value) => value match {
                        case gep: GetElementPtr if gep.isConstant => indexOfAliasedArg(gep.base, callInstr, call.function) match {
                            // dont propagate mcsema state return register if callee is sanitizer
                            case Some(index) if sanitizesReturnValue(start.callable) && index == 0 &&
                                gep.constants == McSemaUtil.getReturnRegIndices(start.callable.function.module.targetTriple) =>
                            case Some(index) => flows += NativeArrayElement(callee.argument(index), gep.constants)
                            case None        =>
                        }
                        case value => callInstr.indexOfArgument(value) match {
                            case Some(index) => callInstr.argument(index).get.typ match {
                                case PointerType(_) => flows += NativeVariable(callee.argument(index))
                                case _              =>
                            }
                            case None =>
                        }
                    }
                    // check for tainted pass-by-reference parameters (pointer)
                    case NativeArrayElement(base, indices) => indexOfAliasedArg(base, callInstr, call.function) match {
                        case Some(index) => callInstr.argument(index).get.typ match {
                            // dont propagate mcsema state return register if callee is sanitizer
                            case PointerType(_) if sanitizesReturnValue(start.callable) && index == 0 &&
                                indices == McSemaUtil.getReturnRegIndices(start.callable.function.module.targetTriple) =>
                            case PointerType(_) => flows += NativeArrayElement(callee.argument(index), indices)
                            case _              =>
                        }
                        case None =>
                    }
                    // keep global variable taint facts
                    case _: NativeGlobalVariable     => flows += in
                    case _: NativeGlobalArrayElement => flows += in
                    case NativeTaintNullFact         => flows += in
                    case _                           =>
                }

                flows.toSet ++ flows.filter(_.isInstanceOf[NativeArrayElement])
                    .map(_.asInstanceOf[NativeArrayElement])
                    .flatMap(arrElem => getPtrAliasesForArrElem(arrElem, LLVMFunction(callee)).map(NativeVariable))

            case _ => throw new RuntimeException("this case should be handled by outsideAnalysisContext")
        }
    }

    /**
     * Each tainted parameter in the callee must also be tainted in the caller. Besides, also tainted
     * global variables are mapped to the caller context. In case a tainted variable reached a source function
     * via the callee, a FlowFact(flow) is created in the caller, where flow holds the call chain from the caller to
     * the respective sink function.
     *
     * @param exit     The statement, which terminated the analysis of the `callee`.
     * @param in       The fact which holds before the execution of the `exit`.
     * @param call     The statement, which called the `callee`.
     * @param successor The successor statement of the call, might be None if unbalanced return.
     * @param unbCallChain The current call chain of unbalanced returns.
     * @return The facts, which hold after the execution of `exit` in the caller's context
     *         under the assumption that `in` held before the execution of `exit` and that
     *         `successor` will be executed next.
     */
    override def returnFlow(exit: LLVMStatement, in: NativeTaintFact, call: LLVMStatement,
                            successor: Option[LLVMStatement], unbCallChain: Seq[Callable]): Set[NativeTaintFact] = {
        val callee = exit.callable;

        val callInstr = call.instruction.asInstanceOf[Call]
        // taint parameters in caller context if they were tainted in the callee context
        val flows: Set[NativeTaintFact] = in match {
            case NativeVariable(value) => callee.function.arguments.find(_.address == value.address) match {
                case Some(arg) =>
                    val argInCall = callInstr.argument(arg.index).get
                    Set(NativeVariable(argInCall)) ++ getPtrAliases(argInCall, call.function).map(NativeVariable).map(_.asInstanceOf[NativeTaintFact])
                case None => Set.empty
            }
            case NativeArrayElement(base, indices) => callee.function.arguments.find(_.address == base.address) match {
                case Some(arg) =>
                    val argInCall = callInstr.argument(arg.index).get
                    Set(NativeArrayElement(argInCall, indices)) ++
                        getPtrAliases(argInCall, call.function).map(NativeArrayElement(_, indices)).map(_.asInstanceOf[NativeTaintFact])
                case None => Set.empty
            }
            // keep global variable taint facts
            case _: NativeGlobalVariable => Set(in)
            case _: NativeGlobalArrayElement => Set(in)
            case NativeTaintNullFact => Set(in)
            case NativeFlowFact(flow) if !flow.contains(call.function) => Set(NativeFlowFact(call.function +: flow))
            case _ => Set.empty
        }

        flows ++ flows.filter(_.isInstanceOf[NativeArrayElement])
            .map(_.asInstanceOf[NativeArrayElement])
            .flatMap(arrElem => getPtrAliasesForArrElem(arrElem, call.function).map(NativeVariable))
    }

    /**
     * Called in callToReturnFlow. Creates a fact if necessary.
     *
     * @param call The call.
     * @param in   The fact, which holds before the call.
     * @return Some fact, if necessary. Otherwise None.
     */
    protected def createFlowFactAtCall(call: LLVMStatement, in: NativeTaintFact,
                                       unbCallChain: Seq[Callable]): Option[NativeTaintFact] = None

    /**
     * Tainted variables and array elements are only propagated if they are not passed as
     * a pass-by-reference parameter to the callee. Otherwise, they are propagated via call flow and return
     * flow. Tainted global variables are only propagated if the call crosses the language boundary and calls a
     * Java method. An exception is made on external calls where the code is not available for analysis. In
     * that case, all taint facts are propagated. If a source function is called returning a tainted value, a new
     * FlowFact(flow) is created, where flow holds the call chain from the caller to the respective sink function.
     *
     * @param call The statement, which invoked the call.
     * @param callee The function that is called.
     * @param in The facts, which hold before the `call`.
     * @param successor The statement after the call within the caller.
     * @param unbCallChain The current call chain of unbalanced returns.
     * @return The facts, which hold after the call independently of what happens in the callee
     *         under the assumption that `in` held before `call`.
     */
    override def callToReturnFlow(call: LLVMStatement, callee: Option[NativeFunction], in: NativeTaintFact, successor: Option[LLVMStatement], unbCallChain: Seq[Callable]): Set[NativeTaintFact] = {
        val callInstr = call.instruction.asInstanceOf[Call]
        val isXlangCall = callee.isDefined && callee.get.isInstanceOf[JNIMethod]

        // tainted pointer values passed to callee are not propagated via callToReturn flow
        // instead, they are propagated via call flow and return flow because they might not be valid anymore after the call
        val propagatedIn: Set[NativeTaintFact] = in match {
            case NativeVariable(value) => indexOfAliasedArg(value, callInstr, call.function) match {
                case Some(index) => callInstr.argument(index).get.typ match {
                    case PointerType(_) => Set.empty
                    case _              => Set(in)
                }
                case None => Set(in)
            }
            case NativeArrayElement(base, _) => indexOfAliasedArg(base, callInstr, call.function) match {
                case Some(_) => Set.empty // array elem base is always a pointer
                case _       => Set(in)
            }
            // do not propagate global variables except if the callee is not within the analysis or it is a xlang call
            case _: NativeGlobalVariable =>
                if (callee.isEmpty || isXlangCall) Set(in)
                else Set.empty
            case _: NativeGlobalArrayElement =>
                if (callee.isEmpty || isXlangCall) Set(in)
                else Set.empty
            case _ => Set(in)
        }

        var result: Set[NativeTaintFact] = Set.empty
        if (!sanitizesParameter(call, in)) result ++= propagatedIn

        val flowFact = createFlowFactAtCall(call, in, unbCallChain)
        if (flowFact.isDefined) result + flowFact.get
        else result
    }

    /**
     * Handle native-to-Java unbalanced returns.
     */
    override def outsideAnalysisContextUnbReturn(callee: NativeFunction): Option[OutsideAnalysisContextUnbReturnHandler] = {
        def handleJavaUnbalancedReturn(callee: NativeFunction, in: NativeTaintFact, callChain: Seq[Callable],
                                       dependeesGetter: Getter): Unit = {
            // find calls of native function in java code
            val llvmCallee = callee.asInstanceOf[LLVMFunction]
            val (fqn, javaMethodName, signature) = JNICallUtil.resolveNativeMethodName(llvmCallee).get
            val javaCompanions = project.allProjectClassFiles
                .filter(classFile => classFile.thisType.fqn == fqn)
                .flatMap(_.methods)
                .filter(m => m.name == javaMethodName && (signature.isEmpty ||
                    (signature.isDefined && m.signature.descriptor.toArgJVMDescriptor == signature.get)))
            val javaCalls = javaCompanions.flatMap(comp => javaICFG.getCallers(comp).map((_, comp)))

            for ((callStmt, comp) <- javaCalls) {
                val unbalancedReturnFacts = javaUnbalancedReturnFlow(llvmCallee, comp, callStmt, in)
                    .map(new IFDSFact(_, true, Some(callStmt), Some(callChain.prepended(callee))))

                // Add the caller with the unbalanced return facts as a dependency to start its analysis
                for (unbRetFact <- unbalancedReturnFacts) {
                    val newEntity = (callStmt.callable, unbRetFact)
                    dependeesGetter(newEntity, javaPropertyKey)
                }
            }
        }

        callee match {
            case f: LLVMFunction if JNICallUtil.resolveNativeMethodName(f).isDefined =>
                Some(handleJavaUnbalancedReturn _)
            case _ => None
        }
    }

    /**
     * Each tainted parameter in the callee must also be tainted in the caller. In case a tainted variable
     * reached a source function via the callee, a FlowFact(flow) is created in the caller, where flow holds
     * the call chain from the caller to the respective sink function. In addition, tainted Java static fields
     * are propagated to the caller. The respective native taint facts are mapped to Java taint facts.
     */
    private def javaUnbalancedReturnFlow(callee: LLVMFunction, javaCallee: Method, call: JavaStatement, in: NativeTaintFact): Set[TaintFact] = {
        val callStatement = JavaIFDSProblem.asCall(call.stmt)

        def taintActualIfFormal(in: Value): Set[TaintFact] = {
            callee.function.arguments.find(_.address == in.address) match {
                case Some(arg) =>
                    val javaParamIndex = JNICallUtil.nativeParamIndexToJava(arg.index, javaCallee.isStatic)
                    if (javaParamIndex < 0) Set.empty
                    else callStatement.allParams(javaParamIndex).asVar.definedBy.map(Variable)
                case _ => Set.empty
            }
        }

        in match {
            // Taint actual parameter if formal parameter is tainted
            case NativeVariable(value)                 => taintActualIfFormal(value)
            case NativeArrayElement(base, _)           => taintActualIfFormal(base)
            // keep static field taints
            case JavaStaticField(classType, fieldName) => Set(StaticField(classType, fieldName))
            // propagate flow facts
            case NativeFlowFact(flow) if !flow.contains(JavaMethod(call.method)) =>
                Set(FlowFact(JavaMethod(call.method) +: flow))
            case NativeTaintNullFact => Set(TaintNullFact)
            case _                   => Set.empty
        }
    }

    /**
     * As with the other call flow functions, pass-by-reference parameters, including this, must be
     * tainted in the callee context if they are tainted in the caller context. If the return value is
     * tainted in the caller context, it is only tainted in the callee context if the callee is not marked
     * as sanitizer. In addition, tainted static fields are propagated to the callee. The respective Java
     * taint facts are mapped to native taint facts.
     *
     * @param start The start statement for the analysis.
     * @param call The analyzed call statement.
     * @param callee The called method, for which the data flow shall be computed.
     * @param in The fact which holds before the execution of the `call`.
     * @return The facts, which hold after the execution of `statement` under the assumption that
     *         the facts in `in` held before `statement` and `statement` calls `callee`.
     */
    override protected def javaCallFlow(start: JavaStatement, call: LLVMStatement, callee: Method,
                                        in: NativeTaintFact): Set[TaintFact] = {
        val flow = collection.mutable.Set.empty[TaintFact]
        val callInstr = call.instruction.asInstanceOf[Call]

        def createNewTaints(expression: Expr[V], statement: JavaStatement): Set[TaintFact] = {
            /* TODO alias references and nested objects are not correctly handled, same for forward analysis
             if new variable is tainted, check if it holds a reference type value, if yes:
              1. taint aliases of that variable
              2. taint variables holding references to inner objects/arrays
             repeat 1 and 2 for variables found in 1 and 2

             code example showcasing the problem:
             ============================================================
             def nested_ret_array():
                a = new int[4][4]               "
                b = a[3]                        "
                c = source()                    "
                b[0] = c                        "
                d = a[3]                        {d[2], a[3]}
                return d                        {arr[2] -> d[2]}

             arr = nested_ret_array()            {arr[2]}
             sink(arr[2])
             ============================================================
             */
            expression.astID match {
                case Var.ASTID => expression.asVar.definedBy.map(Variable)
                case ArrayLoad.ASTID =>
                    val arrayLoad = expression.asArrayLoad
                    val arrayIndex = TaintProblem.getIntConstant(arrayLoad.index, statement.code)
                    val arrayDefinedBy = arrayLoad.arrayRef.asVar.definedBy
                    if (arrayIndex.isDefined) arrayDefinedBy.map(ArrayElement(_, arrayIndex.get))
                    else arrayDefinedBy.map(Variable)
                case BinaryExpr.ASTID | PrefixExpr.ASTID | Compare.ASTID |
                    PrimitiveTypecastExpr.ASTID | NewArray.ASTID | ArrayLength.ASTID =>
                    (0 until expression.subExprCount).foldLeft(Set.empty[TaintFact])((acc, subExpr) =>
                        acc ++ createNewTaints(expression.subExpr(subExpr), statement))
                case GetField.ASTID =>
                    val getField = expression.asGetField
                    getField.objRef.asVar.definedBy
                        .map(InstanceField(_, getField.declaringClass, getField.name))
                case GetStatic.ASTID =>
                    val getStatic = expression.asGetStatic
                    Set(StaticField(getStatic.declaringClass, getStatic.name))
                case _ => Set.empty
            }
        }

        // taint return value in callee, if tainted in caller
        if (!sanitizesReturnValue(JNIMethod(callee))) {
            if (start.stmt.astID == ReturnValue.ASTID) in match {
                case NativeVariable(value) if value == callInstr      => flow ++= createNewTaints(start.stmt.asReturnValue.expr, start)
                case NativeArrayElement(base, _) if base == callInstr => flow ++= createNewTaints(start.stmt.asReturnValue.expr, start)
                case _                                                =>
            }
        }

        def taintRefParam(callInstr: Call, in: Value): Set[TaintFact] = callInstr.indexOfArgument(in) match {
            case Some(index) => callInstr.argument(index).get.typ match {
                case PointerType(_) =>
                    val tacIndex = JavaIFDSProblem.switchParamAndVariableIndex(index - 1, callee.isStatic) // -1 offset JNIEnv
                    Set(Variable(tacIndex))
                case _ => Set.empty
            }
            case None => Set.empty
        }

        // check for tainted pass-by-reference parameters (pointer)
        in match {
            case NativeVariable(value)                 => flow ++= taintRefParam(callInstr, value)
            case NativeArrayElement(base, _)           => flow ++= taintRefParam(callInstr, base)
            case NativeTaintNullFact                   => flow += TaintNullFact
            case JavaStaticField(classType, fieldName) => flow += StaticField(classType, fieldName)
            case _                                     =>
        }
        flow.toSet
    }

    /**
     * Each tainted parameter in the callee must also be tainted in the caller. In case a tainted variable
     * reached a source function via the callee, a FlowFact(flow) is created in the caller, where flow holds
     * the call chain from the caller to the respective sink function. In addition,tainted Java static fields
     * are propagated to the caller. The respective Java taint facts are mapped to native taint facts.
     *
     * @param exit the exit statement of the Java method.
     * @param in the fact which holds at the exit statement.
     * @param call the call instruction of the Java method in native code.
     * @param callFact the fact which held before the call.
     * @param unbCallChain the current callchain of unbalanced returns.
     * @param successor the successor statement of the call in native code.
     * @return the facts that hold after the return of the Java method to native code.
     */
    override protected def javaReturnFlow(exit: JavaStatement, in: TaintFact, call: LLVMStatement, callFact: NativeTaintFact,
                                          unbCallChain: Seq[Callable], successor: Option[LLVMStatement]): Set[NativeTaintFact] = {
        val callee = exit.callable
        val callInstr = call.instruction.asInstanceOf[Call]

        def taintActualIfFormal(index: Int): Set[NativeTaintFact] = {
            if (index > -1) Set.empty // tac parameter indices are < 0, index is no parameter
            val javaParamIndex = JavaIFDSProblem.switchParamAndVariableIndex(index, callee.isStatic)
            val nativeParamIndex = JNICallUtil.javaParamIndexToJNICall(javaParamIndex, callee.isStatic)
            Set(NativeVariable(callInstr.argument(nativeParamIndex).get))
        }

        in match {
            // Taint actual parameter if formal parameter is tainted
            case Variable(index)                   => taintActualIfFormal(index)
            case ArrayElement(index, _)            => taintActualIfFormal(index)
            case InstanceField(index, _, _)        => taintActualIfFormal(index)
            // also propagate tainted static fields
            case StaticField(classType, fieldName) => Set(JavaStaticField(classType, fieldName))
            case TaintNullFact                     => Set(NativeTaintNullFact)
            // Track the call chain to the sink back
            case FlowFact(flow)                    => Set(NativeFlowFact(unbCallChain.prepended(call.function)))
            case _                                 => Set.empty
        }
    }
}
