/* BSD 2-Clause License - see OPAL/LICENSE for details. */
package org.opalj.ll;

import org.opalj.br.analyses.Project
import org.opalj.fpcf.PropertiesTest
import org.opalj.fpcf.properties.taint_xlang.{XlangBackwardFlowPath, XlangBackwardFlowPathMcSemaAarch64ClangO0, XlangBackwardFlowPathMcSemaAarch64ClangO2, XlangBackwardFlowPathMcSemaX8664ClangO0, XlangBackwardFlowPathMcSemaX8664ClangO2, XlangBackwardFlowPathMcSemaX8664GccO0, XlangBackwardFlowPathMcSemaX8664GccO2}
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

class CrossLanguageBackwardTaintAnalysisO0Test extends AbstractCrossLanguageBackwardTaintAnalysisTest(
    "./DEVELOPING_OPAL/validate/src/test/resources/llvm/cross_language/taint/x86_64/TaintTest_O0.ll",
    XlangBackwardFlowPath.PROPERTY_VALIDATOR_KEY,
    new NativeBackwardTaintAnalysisScheduler(Map())
)

class CrossLanguageBackwardTaintAnalysisO2Test extends AbstractCrossLanguageBackwardTaintAnalysisTest(
    "./DEVELOPING_OPAL/validate/src/test/resources/llvm/cross_language/taint/x86_64/TaintTest_O2.ll",
    XlangBackwardFlowPath.PROPERTY_VALIDATOR_KEY,
    new NativeBackwardTaintAnalysisScheduler(Map())
)

class CrossLanguageBackwardTaintAnalysisMcSemaX8664ClangO0Test extends AbstractCrossLanguageBackwardTaintAnalysisTest(
    "./DEVELOPING_OPAL/validate/src/test/resources/llvm/cross_language/taint/x86_64/libtainttest_clang_O0_mcsema.ll",
    XlangBackwardFlowPathMcSemaX8664ClangO0.PROPERTY_VALIDATOR_KEY,
    new NativeBackwardTaintAnalysisScheduler(Map(
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

class CrossLanguageBackwardTaintAnalysisMcSemaX8664ClangO2Test extends AbstractCrossLanguageBackwardTaintAnalysisTest(
    "./DEVELOPING_OPAL/validate/src/test/resources/llvm/cross_language/taint/x86_64/libtainttest_clang_O2_mcsema.ll",
    XlangBackwardFlowPathMcSemaX8664ClangO2.PROPERTY_VALIDATOR_KEY,
    new NativeBackwardTaintAnalysisScheduler(Map(
        "sub_1ff01200_Java_org_opalj_fpcf_fixtures_taint_1xlang_TaintTest_propagate_1identity_1to_1sink" ->
            List(Set("%RAX_ptr", "%EAX_ptr")),
        "sub_1ff011e0_Java_org_opalj_fpcf_fixtures_taint_1xlang_TaintTest_sanitize_1only_1a_1into_1sink" ->
            List(Set("%RBX_ptr", "%EBX_ptr")),
        "sub_1ff01240_Java_org_opalj_fpcf_fixtures_taint_1xlang_TaintTest_native_1array_1tainted" ->
            List(Set("%RAX_ptr", "%EAX_ptr")),
        "sub_1ff01170_Java_org_opalj_fpcf_fixtures_taint_1xlang_TaintTest_propagate_1source" ->
            List(Set("%RAX_ptr", "%EAX_ptr")),
        "sub_1ff013a0_Java_org_opalj_fpcf_fixtures_taint_1xlang_TaintTest_propagate_1java_1sanitize" ->
            List(Set("%R14_ptr", "%R14D_ptr")),
        "sub_1ff01280_Java_org_opalj_fpcf_fixtures_taint_1xlang_TaintTest_propagate_1to_1java_1sink" ->
            List(Set("%R14_ptr", "%R14D_ptr")),
        "sub_1ff012e0_Java_org_opalj_fpcf_fixtures_taint_1xlang_TaintTest_propagate_1to_1java_1static_1sink" ->
            List(Set("%R14_ptr", "%R14D_ptr"))
    ))
)

class CrossLanguageBackwardTaintAnalysisMcSemaX8664GccO0Test extends AbstractCrossLanguageBackwardTaintAnalysisTest(
    "./DEVELOPING_OPAL/validate/src/test/resources/llvm/cross_language/taint/x86_64/libtainttest_gcc_O0_mcsema.ll",
    XlangBackwardFlowPathMcSemaX8664GccO0.PROPERTY_VALIDATOR_KEY,
    new NativeBackwardTaintAnalysisScheduler(Map(
        "sub_1ff0120e_Java_org_opalj_fpcf_fixtures_taint_1xlang_TaintTest_propagate_1identity_1to_1sink" ->
            List(Set("%RAX_ptr", "%EAX_ptr")),
        "sub_1ff011d7_Java_org_opalj_fpcf_fixtures_taint_1xlang_TaintTest_sanitize_1only_1a_1into_1sink" ->
            List(Set("%33", "%44", "%80")),
        "sub_1ff01268_Java_org_opalj_fpcf_fixtures_taint_1xlang_TaintTest_native_1array_1tainted" ->
            List(Set("%RAX_ptr", "%EAX_ptr")),
        "sub_1ff01175_Java_org_opalj_fpcf_fixtures_taint_1xlang_TaintTest_propagate_1source" ->
            List(Set("%RAX_ptr", "%EAX_ptr"))
    ))
)

class CrossLanguageBackwardTaintAnalysisMcSemaX8664GccO2Test extends AbstractCrossLanguageBackwardTaintAnalysisTest(
    "./DEVELOPING_OPAL/validate/src/test/resources/llvm/cross_language/taint/x86_64/libtainttest_gcc_O2_mcsema.ll",
    XlangBackwardFlowPathMcSemaX8664GccO2.PROPERTY_VALIDATOR_KEY,
    new NativeBackwardTaintAnalysisScheduler(Map(
        "sub_1ff013c0_Java_org_opalj_fpcf_fixtures_taint_1xlang_TaintTest_propagate_1identity_1to_1sink" ->
            List(Set("%RAX_ptr", "%EAX_ptr")),
        "sub_1ff01450_Java_org_opalj_fpcf_fixtures_taint_1xlang_TaintTest_sanitize_1only_1a_1into_1sink" ->
            List(Set("%RBX_ptr", "%EBX_ptr")),
        "sub_1ff01400_Java_org_opalj_fpcf_fixtures_taint_1xlang_TaintTest_native_1array_1tainted" ->
            List(Set("%RAX_ptr", "%EAX_ptr")),
        "sub_1ff01380_Java_org_opalj_fpcf_fixtures_taint_1xlang_TaintTest_propagate_1source" ->
            List(Set("%RAX_ptr", "%EAX_ptr")),
        "sub_1ff01320_Java_org_opalj_fpcf_fixtures_taint_1xlang_TaintTest_propagate_1java_1sanitize" ->
            List(Set("%R13_ptr", "%R13D_ptr")),
        "sub_1ff011f0_Java_org_opalj_fpcf_fixtures_taint_1xlang_TaintTest_propagate_1to_1java_1sink" ->
            List(Set("%R13_ptr", "%R13D_ptr")),
        "sub_1ff01250_Java_org_opalj_fpcf_fixtures_taint_1xlang_TaintTest_propagate_1to_1java_1static_1sink" ->
            List(Set("%R13_ptr", "%R13D_ptr"))
    ))
)

class CrossLanguageBackwardTaintAnalysisMcSemaAarch64ClangO0Test extends AbstractCrossLanguageBackwardTaintAnalysisTest(
    "./DEVELOPING_OPAL/validate/src/test/resources/llvm/cross_language/taint/aarch64/libtainttest_clang_O0_mcsema.ll",
    XlangBackwardFlowPathMcSemaAarch64ClangO0.PROPERTY_VALIDATOR_KEY,
    new NativeBackwardTaintAnalysisScheduler(Map(
        "sub_1ff00fdc_Java_org_opalj_fpcf_fixtures_taint_1xlang_TaintTest_propagate_1identity_1to_1sink" ->
            List(Set("%X0_ptr", "%W0_ptr")),
        "sub_1ff00f94_Java_org_opalj_fpcf_fixtures_taint_1xlang_TaintTest_sanitize_1only_1a_1into_1sink" ->
            List(Set("%10", "%16", "%25")),
        "sub_1ff01074_Java_org_opalj_fpcf_fixtures_taint_1xlang_TaintTest_native_1array_1tainted" ->
            List(Set("%X0_ptr", "%W0_ptr")),
        "sub_1ff00eac_Java_org_opalj_fpcf_fixtures_taint_1xlang_TaintTest_propagate_1source" ->
            List(Set("%X0_ptr", "%W0_ptr"))
    ))
)

class CrossLanguageBackwardTaintAnalysisMcSemaAarch64ClangO2Test extends AbstractCrossLanguageBackwardTaintAnalysisTest(
    "./DEVELOPING_OPAL/validate/src/test/resources/llvm/cross_language/taint/aarch64/libtainttest_clang_O2_mcsema.ll",
    XlangBackwardFlowPathMcSemaAarch64ClangO2.PROPERTY_VALIDATOR_KEY,
    new NativeBackwardTaintAnalysisScheduler(Map(
        "sub_1ff00f2c_Java_org_opalj_fpcf_fixtures_taint_1xlang_TaintTest_sanitize_1only_1a_1into_1sink" ->
            List(Set("%X19_ptr", "%W19_ptr")),
        "sub_1ff00e8c_Java_org_opalj_fpcf_fixtures_taint_1xlang_TaintTest_propagate_1source" ->
            List(Set("%X0_ptr", "%W0_ptr")),
        "sub_1ff00fec_Java_org_opalj_fpcf_fixtures_taint_1xlang_TaintTest_propagate_1to_1java_1sink" ->
            List(Set("%X19_ptr", "%W19_ptr")),
        "sub_1ff01060_Java_org_opalj_fpcf_fixtures_taint_1xlang_TaintTest_propagate_1to_1java_1static_1sink" ->
            List(Set("%X19_ptr", "%W19_ptr"))
    ))
)
