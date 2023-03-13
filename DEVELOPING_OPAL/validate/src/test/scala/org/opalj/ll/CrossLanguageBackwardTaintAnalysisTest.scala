/* BSD 2-Clause License - see OPAL/LICENSE for details. */
package org.opalj.ll;

import org.opalj.br.analyses.Project
import org.opalj.fpcf.PropertiesTest
import org.opalj.fpcf.properties.taint_xlang.{XlangBackwardFlowPathMcSemaAarch64ClangO0, XlangBackwardFlowPath, XlangBackwardFlowPathMcSemaX8664ClangO0}
import org.opalj.ifds.IFDSFact
import org.opalj.ll.fpcf.analyses.cg.SimpleNativeCallGraphKey
import org.opalj.ll.fpcf.analyses.ifds.NativeIFDSAnalysisScheduler
import org.opalj.ll.fpcf.analyses.ifds.taint.{JavaBackwardTaintAnalysisScheduler, NativeBackwardTaintAnalysisScheduler, NativeTaintFact}
import org.opalj.tac.cg.RTACallGraphKey
import org.opalj.tac.fpcf.analyses.ifds.taint.TaintNullFact

import java.net.URL

abstract class AbstractCrossLanguageBackwardTaintAnalysisTest(llvmModule: String, validator: String, nativeScheduler: NativeIFDSAnalysisScheduler[NativeTaintFact]) extends PropertiesTest {
    override def init(p: Project[URL]): Unit = {
        p.updateProjectInformationKeyInitializationData(LLVMProjectKey)(
            current => List(llvmModule)
        )
        val llvmProject = p.get(LLVMProjectKey)

        // use all java native functions as entry points for native call graph analysis
        val cgEntryPoints = llvmProject.functions.filter(_.name.startsWith("Java_"))
        p.updateProjectInformationKeyInitializationData(SimpleNativeCallGraphKey)(
            current => cgEntryPoints.toSet
        )

        p.get(RTACallGraphKey)
    }

    describe("CrossLanguageBackwardTaintAnalysisTest") {
        val testContext = executeAnalyses(JavaBackwardTaintAnalysisScheduler, nativeScheduler)
        val project = testContext.project
        val eas = methodsWithAnnotations(project)
            .filter(_._1.classFile.thisType.fqn == "org/opalj/fpcf/fixtures/taint_xlang/TaintTest")
            .map {
                case (method, entityString, annotations) =>
                    ((method, new IFDSFact(TaintNullFact)), entityString, annotations)
            }
        testContext.propertyStore.shutdown()
        validateProperties(testContext, eas, Set(validator))
    }
}

class CrossLanguageO0BackwardTaintAnalysisTest extends AbstractCrossLanguageBackwardTaintAnalysisTest(
    "./DEVELOPING_OPAL/validate/src/test/resources/llvm/cross_language/taint/x86_64/TaintTest_O0.ll",
    XlangBackwardFlowPath.PROPERTY_VALIDATOR_KEY,
    new NativeBackwardTaintAnalysisScheduler(Map())
)

class CrossLanguageO2BackwardTaintAnalysisTest extends AbstractCrossLanguageBackwardTaintAnalysisTest(
    "./DEVELOPING_OPAL/validate/src/test/resources/llvm/cross_language/taint/x86_64/TaintTest_O2.ll",
    XlangBackwardFlowPath.PROPERTY_VALIDATOR_KEY,
    new NativeBackwardTaintAnalysisScheduler(Map())
)

class CrossLanguageMcSemaX8664BackwardTaintAnalysisTest extends AbstractCrossLanguageBackwardTaintAnalysisTest(
    "./DEVELOPING_OPAL/validate/src/test/resources/llvm/cross_language/taint/x86_64/libtainttest_clang_O0_mcsema.ll",
    XlangBackwardFlowPathMcSemaX8664ClangO0.PROPERTY_VALIDATOR_KEY,
    new NativeBackwardTaintAnalysisScheduler(Map(
        "sub_1ff012f0_Java_org_opalj_fpcf_fixtures_taint_1xlang_TaintTest_propagate_1zero_1to_1sink" ->
            List(Set("%RAX_ptr", "%EAX_ptr")),
        "sub_1ff012b0_Java_org_opalj_fpcf_fixtures_taint_1xlang_TaintTest_propagate_1identity_1to_1sink" ->
            List(Set("%RAX_ptr", "%EAX_ptr")),
        "sub_1ff01270_Java_org_opalj_fpcf_fixtures_taint_1xlang_TaintTest_sanitize_1only_1a_1into_1sink" ->
            List(Set("%33", "%42", "%75")),
    ))
)

class CrossLanguageMcSemaAarch64BackwardTaintAnalysisTest extends AbstractCrossLanguageBackwardTaintAnalysisTest(
    "./DEVELOPING_OPAL/validate/src/test/resources/llvm/cross_language/taint/aarch64/lifted_mcsema.ll",
    XlangBackwardFlowPathMcSemaAarch64ClangO0.PROPERTY_VALIDATOR_KEY,
    new NativeBackwardTaintAnalysisScheduler(Map(
        "sub_1ff00e3c_Java_org_opalj_fpcf_fixtures_taint_1xlang_TaintTest_propagate_1identity_1to_1sink" ->
            List(Set("%X0_ptr", "%W0_ptr")),
        "sub_1ff00bb0__identity" ->
            List(Set("%X0_ptr", "%W0_ptr")),
        "sub_1ff00df4_Java_org_opalj_fpcf_fixtures_taint_1xlang_TaintTest_sanitize_1only_1a_1into_1sink" ->
            List(Set("%10", "%16", "%25")),
    ))
)

class CrossLanguageRetdecX8664BackwardTaintAnalysisTest extends AbstractCrossLanguageBackwardTaintAnalysisTest(
    "./DEVELOPING_OPAL/validate/src/test/resources/llvm/cross_language/taint/x86_64/lifted_retdec.ll",
    XlangBackwardFlowPath.PROPERTY_VALIDATOR_KEY,
    new NativeBackwardTaintAnalysisScheduler(Map())
)
