/* BSD 2-Clause License - see OPAL/LICENSE for details. */
package org.opalj.ll.fpcf.analyses.ifds.taint

import org.opalj.br.analyses.SomeProject
import org.opalj.fpcf.{PropertyBounds, PropertyKey, PropertyStore}
import org.opalj.ifds.{Callable, IFDSFact, IFDSPropertyMetaInformation}
import org.opalj.ll.fpcf.analyses.ifds.{LLVMFunction, LLVMStatement, McSemaUtil, NativeFunction, NativeIFDSAnalysis, NativeIFDSAnalysisScheduler}
import org.opalj.ll.fpcf.properties.NativeTaint
import org.opalj.ll.llvm.value.Call
import org.opalj.tac.fpcf.properties.Taint

class SimpleNativeForwardTaintProblem(ptrAliasDefs: Map[String, List[Set[String]]], p: SomeProject) extends NativeForwardTaintProblem(p) {
    /**
     * The analysis starts with all public methods in TaintAnalysisTestClass.
     */
    override val entryPoints: Seq[(NativeFunction, IFDSFact[NativeTaintFact, LLVMStatement])] = Seq.empty
    override val javaPropertyKey: PropertyKey[Taint] = Taint.key

    override val ptrAliasDefinitions: Map[String, List[Set[String]]] = ptrAliasDefs

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
        else if (McSemaUtil.matchesMcSemaFunctionName(callee.name, "source"))
            Set(NativeArrayElement(
                call.instruction.asInstanceOf[Call].argument(0).get, // state struct
                McSemaUtil.getReturnRegIndices(callee.function.module.targetTriple) // return reg indices
            ))
        else Set.empty

    override protected def createFlowFact(call: LLVMStatement, in: NativeTaintFact): Option[NativeFlowFact] = {
        icfg.getCalleesIfCallStatement(call).get.filter(_.isInstanceOf[LLVMFunction]).foreach(c => {
            val callee = c.asInstanceOf[LLVMFunction]
            val callInstr = call.instruction.asInstanceOf[Call]
            if (callee.name == "sink") in match {
                case NativeVariable(value) if value == callInstr.argument(0).get =>
                    return Some(NativeFlowFact(Seq(call.callable, callee)))
                case _ =>
            }
            else if (McSemaUtil.matchesMcSemaFunctionName(callee.name, "sink")) in match {
                case NativeArrayElement(base, indices) if base == callInstr.argument(0).get &&
                    indices == McSemaUtil.getFirstArgRegIndices(callee.function.module.targetTriple) =>
                    return Some(NativeFlowFact(Seq(call.callable, callee)))
                case _ =>
            }
        })
        None
    }

    override def createFlowFactAtExit(callee: NativeFunction, in: NativeTaintFact,
                                      unbCallChain: Seq[Callable]): Option[NativeTaintFact] = None
}

class SimpleNativeForwardTaintAnalysis(project: SomeProject)
    extends NativeIFDSAnalysis(project, new SimpleNativeForwardTaintProblem(Map(), project), NativeTaint)

class SimpleNativeMcSemaForwardTaintAnalysis(project: SomeProject)
    extends NativeIFDSAnalysis(project, new SimpleNativeForwardTaintProblem(Map(
        "sub_1ff012d0_Java_org_opalj_fpcf_fixtures_taint_1xlang_TaintTest_propagate_1zero_1to_1sink" ->
            List(Set("%RAX_ptr", "%EAX_ptr")),
        "sub_1ff01290_Java_org_opalj_fpcf_fixtures_taint_1xlang_TaintTest_propagate_1identity_1to_1sink" ->
            List(Set("%RAX_ptr", "%EAX_ptr")),
        "sub_1ff01250_Java_org_opalj_fpcf_fixtures_taint_1xlang_TaintTest_sanitize_1only_1a_1into_1sink" ->
            List(Set("%33", "%42", "%75")),
        "sub_1ff01310_Java_org_opalj_fpcf_fixtures_taint_1xlang_TaintTest_native_1array_1tainted" ->
            List(Set("%RAX_ptr", "%EAX_ptr")),
        "sub_1ff01190_Java_org_opalj_fpcf_fixtures_taint_1xlang_TaintTest_propagate_1source" ->
            List(Set("%RAX_ptr", "%EAX_ptr"))
    ), project), NativeTaint)

object NativeForwardTaintAnalysisScheduler extends NativeIFDSAnalysisScheduler[NativeTaintFact] {
    override def init(p: SomeProject, ps: PropertyStore) = new SimpleNativeForwardTaintAnalysis(p)
    override def property: IFDSPropertyMetaInformation[LLVMStatement, NativeTaintFact] = NativeTaint
    override val uses: Set[PropertyBounds] = Set() // ++ PropertyBounds.ub(Taint) TODO: we do not use the native taint yet
}

object NativeMcSemaForwardTaintAnalysisScheduler extends NativeIFDSAnalysisScheduler[NativeTaintFact] {
    override def init(p: SomeProject, ps: PropertyStore) = new SimpleNativeMcSemaForwardTaintAnalysis(p)
    override def property: IFDSPropertyMetaInformation[LLVMStatement, NativeTaintFact] = NativeTaint
    override val uses: Set[PropertyBounds] = Set() // ++ PropertyBounds.ub(Taint) TODO: we do not use the native taint yet
}
