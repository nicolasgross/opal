/* BSD 2-Clause License - see OPAL/LICENSE for details. */
package org.opalj.ll.fpcf.analyses.ifds.taint

import org.opalj.br.analyses.SomeProject
import org.opalj.fpcf.{PropertyBounds, PropertyKey, PropertyStore}
import org.opalj.ifds.{Callable, IFDSFact, IFDSPropertyMetaInformation}
import org.opalj.ll.fpcf.analyses.ifds.{LLVMFunction, LLVMStatement, McSemaUtil, NativeFunction, NativeIFDSAnalysis, NativeIFDSAnalysisScheduler}
import org.opalj.ll.fpcf.properties.NativeTaint
import org.opalj.tac.fpcf.properties.Taint

class SimpleNativeForwardTaintProblem(p: SomeProject) extends NativeForwardTaintProblem(p) {
    /**
     * The analysis starts with all public methods in TaintAnalysisTestClass.
     */
    override val entryPoints: Seq[(NativeFunction, IFDSFact[NativeTaintFact, LLVMStatement])] = Seq.empty
    override val javaPropertyKey: PropertyKey[Taint] = Taint.key

    /**
     * The sanitize method is a sanitizer.
     */
    override protected def sanitizesReturnValue(callee: NativeFunction): Boolean =
        callee.name == "sanitize" || McSemaUtil.matchesMcSemaFunctionName(callee.name, "sanitize")

    /**
     * We do not sanitize parameters.
     */
    override protected def sanitizesParameter(call: LLVMStatement, in: NativeTaintFact): Boolean = false

    override protected def createTaints(callee: LLVMFunction, call: LLVMStatement): Set[NativeTaintFact] =
        if (callee.name == "source") Set(NativeVariable(call.instruction))
        else Set.empty

    override protected def createFlowFact(callee: LLVMFunction, call: LLVMStatement, in: NativeTaintFact): Option[NativeFlowFact] =
        if (callee.name == "sink") in match {
            case NativeVariable(value) if value == callee.function.argument(0) =>
                Some(NativeFlowFact(Seq(call.callable, callee)))
            case _ => None
        }
        else None

    override def createFlowFactAtExit(callee: NativeFunction, in: NativeTaintFact,
                                      unbCallChain: Seq[Callable]): Option[NativeTaintFact] = None
}

class SimpleNativeForwardTaintAnalysis(project: SomeProject)
    extends NativeIFDSAnalysis(project, new SimpleNativeForwardTaintProblem(project), NativeTaint)

object NativeForwardTaintAnalysisScheduler extends NativeIFDSAnalysisScheduler[NativeTaintFact] {
    override def init(p: SomeProject, ps: PropertyStore) = new SimpleNativeForwardTaintAnalysis(p)
    override def property: IFDSPropertyMetaInformation[LLVMStatement, NativeTaintFact] = NativeTaint
    override val uses: Set[PropertyBounds] = Set() // ++ PropertyBounds.ub(Taint) TODO: we do not use the native taint yet
}