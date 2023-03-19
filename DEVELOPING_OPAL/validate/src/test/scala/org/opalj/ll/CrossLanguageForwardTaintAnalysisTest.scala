/* BSD 2-Clause License - see OPAL/LICENSE for details. */
package org.opalj.ll

import org.opalj.br.analyses.{Project, SomeProject}
import org.opalj.fpcf.PropertiesTest
import org.opalj.fpcf.properties.taint_xlang.{XlangForwardFlowPath, XlangForwardFlowPathMcSemaAarch64ClangO0, XlangForwardFlowPathMcSemaAarch64ClangO2, XlangForwardFlowPathMcSemaAarch64GccO0, XlangForwardFlowPathMcSemaAarch64GccO2, XlangForwardFlowPathMcSemaX8664ClangO0, XlangForwardFlowPathMcSemaX8664ClangO2, XlangForwardFlowPathMcSemaX8664GccO0, XlangForwardFlowPathMcSemaX8664GccO2}
import org.opalj.ifds.IFDSFact
import org.opalj.ll.fpcf.analyses.ifds.NativeIFDSAnalysisScheduler
import org.opalj.ll.fpcf.analyses.ifds.taint.{JavaForwardTaintAnalysisScheduler, NativeForwardTaintAnalysisScheduler, NativeTaintFact}
import org.opalj.tac.{LazyDetachedTACAIKey, TACode}
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

        printTargetCodeMetrics(project)

        val eas = methodsWithAnnotations(project)
            .filter(_._1.classFile.thisType.fqn == "org/opalj/fpcf/fixtures/taint_xlang/TaintTest")
            .map {
                case (method, entityString, annotations) =>
                    ((method, new IFDSFact(TaintNullFact)), entityString, annotations)
            }
        testContext.propertyStore.shutdown()
        validateProperties(testContext, eas, Set(validator))
    }

    private def printTargetCodeMetrics(project: SomeProject): Unit = {
        // count java bytecode instructions
        val javaBcInstructionsCount = project.allProjectClassFiles
            .filter(_.thisType.fqn == "org/opalj/fpcf/fixtures/taint_xlang/TaintTest")
            .flatMap(_.methods)
            .filter(_.body.isDefined)
            .map(_.body.get.instructionsCount)
            .sum

        // count java TAC instructions
        val tacai = project.get(LazyDetachedTACAIKey)
        val javaTACInstructionsCount = project.allProjectClassFiles
            .filter(_.thisType.fqn == "org/opalj/fpcf/fixtures/taint_xlang/TaintTest")
            .flatMap(_.methods)
            .filter(_.body.isDefined)
            .map(m => {
                val TACode(_, code, _, _, _) = tacai(m)
                code
            })
            .map(_.length)
            .sum

        // count llvm instructions
        val llvmInstructionsCount = project.get(LLVMProjectKey)
            .functions
            .flatMap(_.basicBlocks)
            .map(_.instructions.size)
            .sum

        println("-------------------------------------------------------------------------------------")
        println(s"Java bytecode instructions: $javaBcInstructionsCount, Java TAC instructions: $javaTACInstructionsCount, LLVM instructions: $llvmInstructionsCount")
        println("-------------------------------------------------------------------------------------")
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
    new NativeForwardTaintAnalysisScheduler(Map(
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

class CrossLanguageForwardTaintAnalysisMcSemaX8664GccO0Test extends AbstractCrossLanguageForwardTaintAnalysisTest(
    "./DEVELOPING_OPAL/validate/src/test/resources/llvm/cross_language/taint/x86_64/libtainttest_gcc_O0_mcsema.ll",
    XlangForwardFlowPathMcSemaX8664GccO0.PROPERTY_VALIDATOR_KEY,
    new NativeForwardTaintAnalysisScheduler(Map(
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

class CrossLanguageForwardTaintAnalysisMcSemaX8664GccO2Test extends AbstractCrossLanguageForwardTaintAnalysisTest(
    "./DEVELOPING_OPAL/validate/src/test/resources/llvm/cross_language/taint/x86_64/libtainttest_gcc_O2_mcsema.ll",
    XlangForwardFlowPathMcSemaX8664GccO2.PROPERTY_VALIDATOR_KEY,
    new NativeForwardTaintAnalysisScheduler(Map(
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

class CrossLanguageForwardTaintAnalysisMcSemaAarch64ClangO0Test extends AbstractCrossLanguageForwardTaintAnalysisTest(
    "./DEVELOPING_OPAL/validate/src/test/resources/llvm/cross_language/taint/aarch64/libtainttest_clang_O0_mcsema.ll",
    XlangForwardFlowPathMcSemaAarch64ClangO0.PROPERTY_VALIDATOR_KEY,
    new NativeForwardTaintAnalysisScheduler(Map(
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

class CrossLanguageForwardTaintAnalysisMcSemaAarch64ClangO2Test extends AbstractCrossLanguageForwardTaintAnalysisTest(
    "./DEVELOPING_OPAL/validate/src/test/resources/llvm/cross_language/taint/aarch64/libtainttest_clang_O2_mcsema.ll",
    XlangForwardFlowPathMcSemaAarch64ClangO2.PROPERTY_VALIDATOR_KEY,
    new NativeForwardTaintAnalysisScheduler(Map(
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

class CrossLanguageForwardTaintAnalysisMcSemaAarch64GccO0Test extends AbstractCrossLanguageForwardTaintAnalysisTest(
    "./DEVELOPING_OPAL/validate/src/test/resources/llvm/cross_language/taint/aarch64/libtainttest_gcc_O0_mcsema.ll",
    XlangForwardFlowPathMcSemaAarch64GccO0.PROPERTY_VALIDATOR_KEY,
    new NativeForwardTaintAnalysisScheduler(Map(
        "sub_1ff00e9c_Java_org_opalj_fpcf_fixtures_taint_1xlang_TaintTest_propagate_1identity_1to_1sink" ->
            List(Set("%X0_ptr", "%W0_ptr")),
        "sub_1ff00e5c_Java_org_opalj_fpcf_fixtures_taint_1xlang_TaintTest_sanitize_1only_1a_1into_1sink" ->
            List(Set("%2", "%10", "%20")),
        "sub_1ff00f04_Java_org_opalj_fpcf_fixtures_taint_1xlang_TaintTest_native_1array_1tainted" ->
            List(Set("%X0_ptr", "%W0_ptr")),
        "sub_1ff00dec_Java_org_opalj_fpcf_fixtures_taint_1xlang_TaintTest_propagate_1source" ->
            List(Set("%X0_ptr", "%W0_ptr"))
    ))
)

class CrossLanguageForwardTaintAnalysisMcSemaAarch64GccO2Test extends AbstractCrossLanguageForwardTaintAnalysisTest(
    "./DEVELOPING_OPAL/validate/src/test/resources/llvm/cross_language/taint/aarch64/libtainttest_gcc_O2_mcsema.ll",
    XlangForwardFlowPathMcSemaAarch64GccO2.PROPERTY_VALIDATOR_KEY,
    new NativeForwardTaintAnalysisScheduler(Map(
        "sub_1ff00e80_Java_org_opalj_fpcf_fixtures_taint_1xlang_TaintTest_propagate_1to_1java_1sink" ->
            List(Set("%X21_ptr", "%W21_ptr")),
        "sub_1ff00ef4_Java_org_opalj_fpcf_fixtures_taint_1xlang_TaintTest_propagate_1to_1java_1static_1sink" ->
            List(Set("%X21_ptr", "%W21_ptr")),
        "sub_1ff01130_Java_org_opalj_fpcf_fixtures_taint_1xlang_TaintTest_sanitize_1only_1a_1into_1sink" ->
            List(Set("%X19_ptr", "%W19_ptr")),
        "sub_1ff01060_Java_org_opalj_fpcf_fixtures_taint_1xlang_TaintTest_propagate_1source" ->
            List(Set("%X0_ptr", "%W0_ptr"))
    ))
)
