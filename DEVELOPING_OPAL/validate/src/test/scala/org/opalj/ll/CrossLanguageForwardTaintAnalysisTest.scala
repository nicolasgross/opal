/* BSD 2-Clause License - see OPAL/LICENSE for details. */
package org.opalj.ll

import org.opalj.br.analyses.Project
import org.opalj.fpcf.PropertiesTest
import org.opalj.fpcf.properties.taint_xlang.{XlangForwardFlowPath, XlangForwardFlowPathMcSemaX8664ClangO0, XlangForwardFlowPathMcSemaX8664ClangO2, XlangForwardFlowPathMcSemaAarch64ClangO0}
import org.opalj.ifds.IFDSFact
import org.opalj.ll.fpcf.analyses.ifds.NativeIFDSAnalysisScheduler
import org.opalj.ll.fpcf.analyses.ifds.taint.{JavaForwardTaintAnalysisScheduler, NativeForwardTaintAnalysisScheduler, NativeTaintFact}
import org.opalj.tac.cg.RTACallGraphKey
import org.opalj.tac.fpcf.analyses.ifds.taint.TaintNullFact

import java.net.URL

abstract class AbstractCrossLanguageForwardTaintAnalysisTest(llvmModule: String, validator: String, nativeScheduler: NativeIFDSAnalysisScheduler[NativeTaintFact]) extends PropertiesTest {
    override def init(p: Project[URL]): Unit = {
        p.updateProjectInformationKeyInitializationData(LLVMProjectKey)(
            current => List(llvmModule)
        )
        p.get(LLVMProjectKey)
        p.get(RTACallGraphKey)
    }

    describe("CrossLanguageForwardTaintAnalysis") {
        val testContext = executeAnalyses(JavaForwardTaintAnalysisScheduler, nativeScheduler)
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

class CrossLanguageForwardTaintAnalysisO0Test extends AbstractCrossLanguageForwardTaintAnalysisTest(
    "./DEVELOPING_OPAL/validate/src/test/resources/llvm/cross_language/taint/x86_64/TaintTest_O0.ll",
    XlangForwardFlowPath.PROPERTY_VALIDATOR_KEY,
    new NativeForwardTaintAnalysisScheduler(Map())
)

class CrossLanguageForwardTaintAnalysisO2Test extends AbstractCrossLanguageForwardTaintAnalysisTest(
    "./DEVELOPING_OPAL/validate/src/test/resources/llvm/cross_language/taint/x86_64/TaintTest_O2.ll",
    XlangForwardFlowPath.PROPERTY_VALIDATOR_KEY,
    new NativeForwardTaintAnalysisScheduler(Map())
)

class CrossLanguageForwardTaintAnalysisMcSemaX8664ClangO0Test extends AbstractCrossLanguageForwardTaintAnalysisTest(
    "./DEVELOPING_OPAL/validate/src/test/resources/llvm/cross_language/taint/x86_64/libtainttest_clang_O0_mcsema.ll",
    XlangForwardFlowPathMcSemaX8664ClangO0.PROPERTY_VALIDATOR_KEY,
    new NativeForwardTaintAnalysisScheduler(Map(
        "sub_1ff012b0_Java_org_opalj_fpcf_fixtures_taint_1xlang_TaintTest_propagate_1identity_1to_1sink" ->
            List(Set("%RAX_ptr", "%EAX_ptr")),
        "sub_1ff01270_Java_org_opalj_fpcf_fixtures_taint_1xlang_TaintTest_sanitize_1only_1a_1into_1sink" ->
            List(Set("%33", "%42", "%75")),
        "sub_1ff01330_Java_org_opalj_fpcf_fixtures_taint_1xlang_TaintTest_native_1array_1tainted" ->
            List(Set("%RAX_ptr", "%EAX_ptr")),
        "sub_1ff01190_Java_org_opalj_fpcf_fixtures_taint_1xlang_TaintTest_propagate_1source" ->
            List(Set("%RAX_ptr", "%EAX_ptr"))
    ))
)

class CrossLanguageForwardTaintAnalysisMcSemaX8664ClangO2Test extends AbstractCrossLanguageForwardTaintAnalysisTest(
    "./DEVELOPING_OPAL/validate/src/test/resources/llvm/cross_language/taint/x86_64/libtainttest_clang_O2_mcsema.ll",
    XlangForwardFlowPathMcSemaX8664ClangO2.PROPERTY_VALIDATOR_KEY,
    new NativeForwardTaintAnalysisScheduler(Map())
)

class CrossLanguageMcSemaAarch64ForwardTaintAnalysisTest extends AbstractCrossLanguageForwardTaintAnalysisTest(
    "./DEVELOPING_OPAL/validate/src/test/resources/llvm/cross_language/taint/aarch64/lifted_mcsema.ll",
    XlangForwardFlowPathMcSemaAarch64ClangO0.PROPERTY_VALIDATOR_KEY,
    new NativeForwardTaintAnalysisScheduler(Map(
        "sub_1ff00e3c_Java_org_opalj_fpcf_fixtures_taint_1xlang_TaintTest_propagate_1identity_1to_1sink" ->
            List(Set("%X0_ptr", "%W0_ptr")),
        "sub_1ff00df4_Java_org_opalj_fpcf_fixtures_taint_1xlang_TaintTest_sanitize_1only_1a_1into_1sink" ->
            List(Set("%10", "%16", "%25")),
        "sub_1ff00ed4_Java_org_opalj_fpcf_fixtures_taint_1xlang_TaintTest_native_1array_1tainted" ->
            List(Set("%X0_ptr", "%W0_ptr")),
        "sub_1ff00d2c_Java_org_opalj_fpcf_fixtures_taint_1xlang_TaintTest_propagate_1source" ->
            List(Set("%X0_ptr", "%W0_ptr")),
    ))
)

class CrossLanguageRetdecX8664ForwardTaintAnalysisTest extends AbstractCrossLanguageForwardTaintAnalysisTest(
    "./DEVELOPING_OPAL/validate/src/test/resources/llvm/cross_language/taint/x86_64/lifted_retdec.ll",
    XlangForwardFlowPath.PROPERTY_VALIDATOR_KEY,
    new NativeForwardTaintAnalysisScheduler(Map())
)
