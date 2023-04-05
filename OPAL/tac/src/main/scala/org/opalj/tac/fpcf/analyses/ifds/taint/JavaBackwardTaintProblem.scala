/* BSD 2-Clause License - see OPAL/LICENSE for details. */
package org.opalj.tac.fpcf.analyses.ifds.taint

import org.opalj.br.analyses.SomeProject
import org.opalj.br.{Method, ObjectType}
import org.opalj.ifds.Callable
import org.opalj.ifds.Dependees.Getter
import org.opalj.tac._
import org.opalj.tac.fpcf.analyses.ifds.JavaIFDSProblem.V
import org.opalj.tac.fpcf.analyses.ifds.{JavaBackwardIFDSProblem, JavaIFDSProblem, JavaStatement}

/**
 * Implementation of a backward taint analysis for Java code.
 *
 * @author Nicolas Gross
 * @author others
 */
abstract class JavaBackwardTaintProblem(project: SomeProject)
    extends JavaBackwardIFDSProblem[TaintFact](project)
    with TaintProblem[Method, JavaStatement, TaintFact] {

    override def nullFact: TaintFact = TaintNullFact

    override def enableUnbalancedReturns: Boolean = true

    /**
     * Whenever an expression is assigned to a tainted variable, static field, object field, or array
     * element, the values in the expression must also be tainted. In case a tainted static field, object field, or
     * array element is assigned, the respective taint fact must be removed. This is irrelevant for variables as
     * the analysis is performed on code in SSA form, making reassignments of local variables impossible.
     *
     * @param statement   The analyzed statement.
     * @param in          The fact which holds before the execution of the `statement`.
     * @param predecessor The predecessor of the analyzed `statement`, for which the data flow shall be
     *                    computed. Used for phi statements to distinguish the flow.
     * @return The facts, which hold after the execution of `statement` under the assumption
     *         that the facts in `in` held before `statement` and `successor` will be
     *         executed next.
     */
    override def normalFlow(statement: JavaStatement, in: TaintFact, predecessor: Option[JavaStatement]): Set[TaintFact] = {
        statement.stmt.astID match {
            case Assignment.ASTID => if (in match {
                case Variable(index)        => index == statement.index
                case ArrayElement(index, _) => index == statement.index
                case _                      => false
            }) {
                createNewTaints(statement.stmt.asAssignment.expr, statement) + in
            } else Set(in)
            case ArrayStore.ASTID =>
                val arrayStore = statement.stmt.asArrayStore
                val arrayIndex = TaintProblem.getIntConstant(arrayStore.index, statement.code)
                val arrayDefinedBy = arrayStore.arrayRef.asVar.definedBy
                if (in match {
                    // check if array is tainted
                    case Variable(index) => arrayDefinedBy.contains(index) // whole variable/array is tainted
                    case ArrayElement(index, taintedElement) => arrayDefinedBy.contains(index) && // only specific array element is tainted
                        (arrayIndex.isEmpty || arrayIndex.get == taintedElement)
                    case _ => false
                }) {
                    if (arrayIndex.isDefined && arrayDefinedBy.size == 1 &&
                        in == ArrayElement(arrayDefinedBy.head, arrayIndex.get)) {
                        // tainted array element is overwritten -> untaint
                        createNewTaints(arrayStore.value, statement)
                    } else createNewTaints(arrayStore.value, statement) + in
                } else Set(in)
            case PutField.ASTID =>
                val putField = statement.stmt.asPutField
                val definedBy = putField.objRef.asVar.definedBy
                if (in match {
                    case InstanceField(index, classType, fieldName) =>
                        definedBy.contains(index) &&
                            putField.declaringClass == classType &&
                            putField.name == fieldName
                    case _ => false
                }) {
                    createNewTaints(putField.value, statement)
                } else Set(in)
            case PutStatic.ASTID =>
                val putStatic = statement.stmt.asPutStatic
                in match {
                    case StaticField(classType, fieldName) if putStatic.declaringClass == classType &&
                        putStatic.name == fieldName => createNewTaints(putStatic.value, statement)
                    case _ => Set(in)
                }
            case _ => Set(in)
        }
    }


    /**
     * If the return value is tainted in the caller context and the callee is not marked as sanitizer,
     * the return value must also be tainted in the callee context. Tainted pass-by-reference parameters and
     * static fields are always propagated to the callee.
     *
     * @param start  The statement, which starts the analysis of the 'callee'.
     * @param in     The fact which holds before the execution of the `call`.
     * @param call   The statement, which called the `callee`.
     * @param callee The called method, for which the data flow shall be computed.
     * @return The facts, which hold after the execution of `call` under the assumption that
     *         the fact `in` held before `call` and `call` calls `callee`.
     */
    override def callFlow(start: JavaStatement, in: TaintFact, call: JavaStatement, callee: Method): Set[TaintFact] = {
        // taint expression of return value in callee if return value in caller is tainted
        val callObject = JavaIFDSProblem.asCall(call.stmt)
        val flow = collection.mutable.Set.empty[TaintFact]
        if (!sanitizesReturnValue(callee)) {
            if (call.stmt.astID == Assignment.ASTID && start.stmt.astID == ReturnValue.ASTID) {
                in match {
                    case Variable(index) if index == call.index =>
                        flow ++= createNewTaints(start.stmt.asReturnValue.expr, start)
                    case ArrayElement(index, taintedElement) if index == call.index =>
                        flow ++= createNewArrayElementTaints(start.stmt.asReturnValue.expr, taintedElement,
                            call)
                    case InstanceField(index, declaringClass, name) if index == call.index =>
                        flow ++= createNewInstanceFieldTaints(start.stmt.asReturnValue.expr, declaringClass,
                            name, call)
                    case _ => // Nothing to do
                }
            }
        }

        // propagate static field taints
        in match {
            case staticField: StaticField => flow += staticField
            case _                        =>
        }

        // check for tainted 'this' and pass-by-reference parameters
        val thisOffset = if (callee.isStatic) 0 else 1
        callObject.allParams.iterator.zipWithIndex
            .filter(pair => (pair._2 == 0 && !callee.isStatic) || // this
                callObject.descriptor.parameterTypes(pair._2 - thisOffset).isReferenceType) // pass-by-reference parameters
            .foreach { pair =>
                val param = pair._1.asVar
                val paramIndex = pair._2
                in match {
                    case Variable(index) if param.definedBy.contains(index) =>
                        flow += Variable(JavaIFDSProblem.switchParamAndVariableIndex(paramIndex, callee.isStatic))
                    case ArrayElement(index, taintedElement) if param.definedBy.contains(index) =>
                        flow += ArrayElement(
                            JavaIFDSProblem.switchParamAndVariableIndex(paramIndex, callee.isStatic), taintedElement
                        )
                    case InstanceField(index, declaringClass, name) if param.definedBy.contains(index) =>
                        flow += InstanceField(
                            JavaIFDSProblem.switchParamAndVariableIndex(paramIndex, callee.isStatic),
                            declaringClass, name
                        )
                    case _ => // Nothing to do
                }
            }
        flow.toSet
    }

    /**
     * Each tainted parameter and static variable in the callee must also be tainted in the caller.
     * In case a tainted variable reached a source function via the callee, a FlowFact(flow) is created in the
     * caller, where flow holds the call chain from the caller to the respective sink function.
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
    override def returnFlow(exit: JavaStatement, in: TaintFact, call: JavaStatement, successor: Option[JavaStatement], unbCallChain: Seq[Callable]): Set[TaintFact] = {
        val callStatement = JavaIFDSProblem.asCall(call.stmt)
        val staticCall = exit.callable.isStatic
        val thisOffset = if (staticCall) 0 else 1
        val formalParameterIndices = (0 until callStatement.descriptor.parametersCount)
            .map(index => JavaIFDSProblem.switchParamAndVariableIndex(index + thisOffset, staticCall))
        val facts = collection.mutable.Set.empty[TaintFact]
        in match {
            case Variable(index) if formalParameterIndices.contains(index) =>
                facts.addAll(createNewTaints(
                    callStatement.allParams(JavaIFDSProblem.switchParamAndVariableIndex(index, staticCall)), call
                ))
            case ArrayElement(index, taintedElement) if formalParameterIndices.contains(index) =>
                facts.addAll(createNewArrayElementTaints(
                    callStatement.allParams(JavaIFDSProblem.switchParamAndVariableIndex(index, staticCall)),
                    taintedElement, call
                ))
            case InstanceField(index, declaringClass, name) if formalParameterIndices.contains(index) =>
                facts.addAll(createNewInstanceFieldTaints(
                    callStatement.allParams(JavaIFDSProblem.switchParamAndVariableIndex(index, staticCall)),
                    declaringClass, name, call
                ))
            case staticField: StaticField => facts.add(staticField)
            // If the source was reached in a callee, create a flow fact from this method to the sink.
            case calleeFact: FlowFact =>
                val callerFact = applyFlowFactFromCallee(calleeFact, call.callable, in, unbCallChain)
                if (callerFact.isDefined) facts.add(callerFact.get)
            case _ => // Nothing to do
        }
        facts
    }.toSet

    /**
     * Tainted variables are always propagated. Tainted instance fields and array elements
     * are only propagated if they are not passed as a pass-by-reference parameter to the callee. Otherwise, they
     * are propagated via call flow and return flow. Tainted static fields are never propagated. An exception is
     * made if the callee is outside the analysis context, meaning its code is not available. In that case, all taint
     * facts are propagated. In case a source function is called returning a tainted value, a new FlowFact(flow)
     * is created, where flow holds the call chain from the caller to the respective sink function.
     *
     * @param call The statement, which invoked the call.
     * @param callee The function that is called.
     * @param in The facts, which hold before the `call`.
     * @param successor The statement after the call within the caller.
     * @param unbCallChain The current call chain of unbalanced returns.
     *  @return The facts, which hold after the call independently of what happens in the callee
     *         under the assumption that `in` held before `call`.
     */
    override def callToReturnFlow(call: JavaStatement, callee: Option[Method], in: TaintFact, successor: Option[JavaStatement], unbCallChain: Seq[Callable]): Set[TaintFact] = {
        val result = collection.mutable.Set.empty[TaintFact]

        // do not propagate tainted pass-by-reference parameters and static fields, they are propagated via call flow and return flow
        val callObject = JavaIFDSProblem.asCall(call.stmt)
        val isStatic = callObject.allParams.length == callObject.params.length
        if (!sanitizesParameter(call, in)) {
            if (callObject.allParams.isEmpty ||
                (isStatic && !callObject.descriptor.parameterTypes.exists(_.isReferenceType))) in match {
                case _: StaticField if callee.isDefined =>
                case _                                  => result += in
            }
            else {
                val thisOffset = if (isStatic) 0 else 1
                callObject.allParams.iterator.zipWithIndex
                    .filter(pair => (pair._2 == 0 && !isStatic) || // this is always pass-by-reference
                        callObject.descriptor.parameterTypes(pair._2 - thisOffset).isReferenceType) // pass-by-reference parameters
                    .foreach { pair =>
                        val param = pair._1.asVar
                        in match {
                            case Variable(index) if param.definedBy.contains(index) && callee.isDefined =>
                            case ArrayElement(index, _) if param.definedBy.contains(index) && callee.isDefined =>
                            case InstanceField(index, _, _) if param.definedBy.contains(index) && callee.isDefined =>
                            case _: StaticField if callee.isDefined =>
                            case _ => result += in
                        }
                    }
            }
        }

        val flowFact = createFlowFactAtCall(call, in, unbCallChain)
        if (flowFact.isDefined) result += flowFact.get
        result.toSet
    }

    /**
     * Called in callToReturnFlow. Creates a fact if necessary.
     *
     * @param call The call.
     * @param in   The fact, which holds before the call.
     * @return Some fact, if necessary. Otherwise None.
     */
    protected def createFlowFactAtCall(call: JavaStatement, in: TaintFact, callChain: Seq[Callable]): Option[TaintFact] = None

    /**
     * If the returned value is tainted, all actual parameters will be tainted.
     */
    override def outsideAnalysisContextCall(callee: Method): Option[OutsideAnalysisContextCallHandler] = {
        super.outsideAnalysisContextCall(callee) match {
            case Some(_) => Some((call: JavaStatement, _: Option[JavaStatement], in: TaintFact, unbCallChain: Seq[Callable], _: Getter) => {
                val callStatement = JavaIFDSProblem.asCall(call.stmt)
                Set(in) ++ (in match {
                    case Variable(index) if index == call.index =>
                        callStatement.allParams.flatMap(createNewTaints(_, call))
                    case ArrayElement(index, _) if index == call.index =>
                        callStatement.allParams.flatMap(createNewTaints(_, call))
                    case InstanceField(index, _, _) if index == call.index =>
                        callStatement.allParams.flatMap(createNewTaints(_, call))
                })
            })
            case None => None
        }
    }

    /**
     * Taints all variables in an `expression`.
     *
     * @param expression The expression.
     * @param statement  The statement, which contains the expression.
     * @return The new taints.
     */
    private def createNewTaints(expression: Expr[V], statement: JavaStatement): Set[TaintFact] = {
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

    /**
     * Keeps information about the tainted array element when mapping params/retvals in/out-of methods.
     *
     * @param expression     The expression, referring to the array.
     * @param taintedElement The array element, which will be tainted.
     * @param statement      The statement, containing the expression.
     * @return a set of facts with preserved information about the tainted element of arrays.
     */
    private def createNewArrayElementTaints(expression: Expr[V], taintedElement: Int,
                                            statement: JavaStatement): Set[TaintFact] =
        createNewTaints(expression, statement).map {
            // Keep information about tainted array element
            case Variable(variableIndex) => ArrayElement(variableIndex, taintedElement)
            case taintFact               => taintFact
        }

    /**
     * Keeps information about the tainted instance field when mapping params/retvals in/out-of methods.
     *
     * @param expression the expression referring to the mapped instance.
     * @param declaringClass the declaring class of the instance.
     * @param name the name of the instance field.
     * @param statement the statement containing the expression.
     * @return a set of facts with preserved information about the tainted field of instances.
     */
    private def createNewInstanceFieldTaints(expression: Expr[V], declaringClass: ObjectType,
                                             name: String, statement: JavaStatement): Set[TaintFact] =
        createNewTaints(expression, statement).map {
            // keep information about instance field
            case Variable(variableIndex) => InstanceField(variableIndex, declaringClass, name)
            case taintFact               => taintFact
        }

    /**
     * Called, when a FlowFact holds at the index 0 node of a callee. Creates a FlowFact in the caller
     * context if necessary.
     *
     * @param calleeFact The FlowFact, which holds at the start node of the callee.
     * @param caller The caller.
     * @param in the fact
     * @param callChain the current call chain
     * @return Some FlowFact, if necessary. Otherwise None.
     */
    protected def applyFlowFactFromCallee(
        calleeFact: FlowFact,
        caller:     Method,
        in:         TaintFact,
        callChain:  Seq[Callable]
    ): Option[FlowFact]
}
