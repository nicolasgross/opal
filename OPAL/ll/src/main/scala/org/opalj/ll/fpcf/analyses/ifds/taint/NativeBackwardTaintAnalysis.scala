/* BSD 2-Clause License - see OPAL/LICENSE for details. */
package org.opalj.ll.fpcf.analyses.ifds.taint

import org.opalj.br.analyses.{ProjectInformationKeys, SomeProject}
import org.opalj.fpcf.{PropertyBounds, PropertyKey, PropertyStore}
import org.opalj.ifds.{Callable, IFDSFact, IFDSPropertyMetaInformation}
import org.opalj.ll.{LLVMProject, LLVMProjectKey}
import org.opalj.ll.fpcf.analyses.cg.SimpleNativeCallGraphKey
import org.opalj.ll.fpcf.analyses.ifds.{LLVMFunction, LLVMStatement, McSemaUtil, NativeFunction, NativeIFDSAnalysis, NativeIFDSAnalysisScheduler}
import org.opalj.ll.fpcf.properties.NativeTaint
import org.opalj.tac.fpcf.properties.Taint

class SimpleNativeBackwardTaintProblem(ptrAliasDefs: Map[String, List[Set[String]]], p: SomeProject) extends NativeBackwardTaintProblem(p) {

    override val javaPropertyKey: PropertyKey[Taint] = Taint.key
    val llvmProject: LLVMProject = p.get(LLVMProjectKey)

    override val ptrAliasDefinitions: Map[String, List[Set[String]]] = ptrAliasDefs

    /**
     * The analysis starts with the sink function.
     */
    override val entryPoints: Seq[(NativeFunction, IFDSFact[NativeTaintFact, LLVMStatement])] = {
        val sinkFuncs = llvmProject.functions.filter(f => f.name == "sink" ||
            McSemaUtil.matchesMcSemaFunctionName(f.name, "sink")).toSeq
        sinkFuncs.map(sinkFunc =>
            if (McSemaUtil.isMcSemaStateType(sinkFunc.argument(0).typ)) {
                // args are passed via state struct in McSema sub_... functions
                (LLVMFunction(sinkFunc), new IFDSFact(NativeTaintNullFact))
            } else (LLVMFunction(sinkFunc), new IFDSFact(NativeTaintNullFact)))
    }

    /**
     * The sanitize method is a sanitizer.
     */
    override protected def sanitizesReturnValue(callee: NativeFunction): Boolean =
        callee.name == "sanitize" || McSemaUtil.matchesMcSemaFunctionName(callee.name, "sanitize")

    /**
     * We do not sanitize parameters.
     */
    override protected def sanitizesParameter(call: LLVMStatement, in: NativeTaintFact): Boolean = false

    override protected def createFlowFactAtCall(call: LLVMStatement, in: NativeTaintFact,
                                                unbCallChain: Seq[Callable]): Option[NativeTaintFact] = {
        // create flow facts if callee is source
        val callees = icfg.getCalleesIfCallStatement(call).get
        if (callees.exists(callee => callee.name == "source" ||
            McSemaUtil.matchesMcSemaFunctionName(callee.name, "source"))) in match {
            // create flow fact if source is reached with tainted value
            case NativeVariable(value) if (value == call.instruction || McSemaUtil.mcSemaRetvalTainted(call, in)(p)) &&
                !unbCallChain.contains(call.callable) => Some(NativeFlowFact(unbCallChain.prepended(call.callable)))
            case _ => None
        }
        else None
    }

    /**
     * Add taint fact for sink function's first argument on exit, as it might get overridden when added at entry.
     */
    override def createFlowFactAtExit(callee: NativeFunction, in: NativeTaintFact,
                                      unbCallChain: Seq[Callable]): Option[NativeTaintFact] = callee match {
        case LLVMFunction(function) if function.name == "sink" =>
            Some(NativeVariable(function.argument(0)))
        case LLVMFunction(function) if McSemaUtil.matchesMcSemaFunctionName(function.name, "sink") &&
            McSemaUtil.isMcSemaStateType(function.argument(0).typ) =>
            Some(NativeArrayElement(function.argument(0), McSemaUtil.getFirstArgRegIndices(function.module.targetTriple)))
        case _ => None
    }
}

class SimpleNativeBackwardTaintAnalysis(project: SomeProject)
    extends NativeIFDSAnalysis(project, new SimpleNativeBackwardTaintProblem(Map(), project), NativeTaint)

class SimpleNativeMcSemaX8664BackwardTaintAnalysis(project: SomeProject)
    extends NativeIFDSAnalysis(project, new SimpleNativeBackwardTaintProblem(Map(
        "sub_1ff012f0_Java_org_opalj_fpcf_fixtures_taint_1xlang_TaintTest_propagate_1zero_1to_1sink" ->
            List(Set("%RAX_ptr", "%EAX_ptr")),
        "sub_1ff012b0_Java_org_opalj_fpcf_fixtures_taint_1xlang_TaintTest_propagate_1identity_1to_1sink" ->
            List(Set("%RAX_ptr", "%EAX_ptr")),
        "sub_1ff01270_Java_org_opalj_fpcf_fixtures_taint_1xlang_TaintTest_sanitize_1only_1a_1into_1sink" ->
            List(Set("%33", "%42", "%75")),
    ), project), NativeTaint)

class SimpleNativeMcSemaAarch64BackwardTaintAnalysis(project: SomeProject)
    extends NativeIFDSAnalysis(project, new SimpleNativeBackwardTaintProblem(Map(
        "sub_1ff00e3c_Java_org_opalj_fpcf_fixtures_taint_1xlang_TaintTest_propagate_1identity_1to_1sink" ->
            List(Set("%X0_ptr", "%W0_ptr")),
        "sub_1ff00bb0__identity" ->
            List(Set("%X0_ptr", "%W0_ptr")),
        "sub_1ff00df4_Java_org_opalj_fpcf_fixtures_taint_1xlang_TaintTest_sanitize_1only_1a_1into_1sink" ->
            List(Set("%10", "%16", "%25")),
    ), project), NativeTaint)

object NativeBackwardTaintAnalysisScheduler extends NativeIFDSAnalysisScheduler[NativeTaintFact] {
    override def init(p: SomeProject, ps: PropertyStore) = new SimpleNativeBackwardTaintAnalysis(p)
    override def property: IFDSPropertyMetaInformation[LLVMStatement, NativeTaintFact] = NativeTaint
    override val uses: Set[PropertyBounds] = Set()
    override def requiredProjectInformation: ProjectInformationKeys = SimpleNativeCallGraphKey +: super.requiredProjectInformation
}

object NativeMcSemaX8664BackwardTaintAnalysisScheduler extends NativeIFDSAnalysisScheduler[NativeTaintFact] {
    override def init(p: SomeProject, ps: PropertyStore) = new SimpleNativeMcSemaX8664BackwardTaintAnalysis(p)
    override def property: IFDSPropertyMetaInformation[LLVMStatement, NativeTaintFact] = NativeTaint
    override val uses: Set[PropertyBounds] = Set()
    override def requiredProjectInformation: ProjectInformationKeys = SimpleNativeCallGraphKey +: super.requiredProjectInformation
}

object NativeMcSemaAarch64BackwardTaintAnalysisScheduler extends NativeIFDSAnalysisScheduler[NativeTaintFact] {
    override def init(p: SomeProject, ps: PropertyStore) = new SimpleNativeMcSemaAarch64BackwardTaintAnalysis(p)
    override def property: IFDSPropertyMetaInformation[LLVMStatement, NativeTaintFact] = NativeTaint
    override val uses: Set[PropertyBounds] = Set()
    override def requiredProjectInformation: ProjectInformationKeys = SimpleNativeCallGraphKey +: super.requiredProjectInformation
}
