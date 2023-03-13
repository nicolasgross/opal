/* BSD 2-Clause License - see OPAL/LICENSE for details. */
package org.opalj.ll

import org.opalj.br.analyses.Project
import org.opalj.fpcf.PropertiesTest
import org.opalj.fpcf.properties.taint_xlang.{XlangForwardFlowPath, XlangMcSemaAarch64ForwardFlowPath, XlangMcSemaX8664ForwardFlowPath}
import org.opalj.ifds.IFDSFact
import org.opalj.ll.fpcf.analyses.ifds.NativeIFDSAnalysisScheduler
import org.opalj.ll.fpcf.analyses.ifds.taint.{JavaForwardTaintAnalysisScheduler, NativeForwardTaintAnalysisScheduler, NativeMcSemaAarch64ForwardTaintAnalysisScheduler, NativeMcSemaX8664ForwardTaintAnalysisScheduler, NativeTaintFact}
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

class CrossLanguageO0ForwardTaintAnalysisTest extends AbstractCrossLanguageForwardTaintAnalysisTest(
    "./DEVELOPING_OPAL/validate/src/test/resources/llvm/cross_language/taint/x86_64/TaintTest_O0.ll",
    XlangForwardFlowPath.PROPERTY_VALIDATOR_KEY,
    NativeForwardTaintAnalysisScheduler
)

class CrossLanguageO2ForwardTaintAnalysisTest extends AbstractCrossLanguageForwardTaintAnalysisTest(
    "./DEVELOPING_OPAL/validate/src/test/resources/llvm/cross_language/taint/x86_64/TaintTest_O2.ll",
    XlangForwardFlowPath.PROPERTY_VALIDATOR_KEY,
    NativeForwardTaintAnalysisScheduler
)

class CrossLanguageMcSemaX8664ForwardTaintAnalysisTest extends AbstractCrossLanguageForwardTaintAnalysisTest(
    "./DEVELOPING_OPAL/validate/src/test/resources/llvm/cross_language/taint/x86_64/libtainttest_clang_O0_mcsema.ll",
    XlangMcSemaX8664ForwardFlowPath.PROPERTY_VALIDATOR_KEY,
    NativeMcSemaX8664ForwardTaintAnalysisScheduler
)

class CrossLanguageMcSemaAarch64ForwardTaintAnalysisTest extends AbstractCrossLanguageForwardTaintAnalysisTest(
    "./DEVELOPING_OPAL/validate/src/test/resources/llvm/cross_language/taint/aarch64/lifted_mcsema.ll",
    XlangMcSemaAarch64ForwardFlowPath.PROPERTY_VALIDATOR_KEY,
    NativeMcSemaAarch64ForwardTaintAnalysisScheduler
)

class CrossLanguageRetdecX8664ForwardTaintAnalysisTest extends AbstractCrossLanguageForwardTaintAnalysisTest(
    "./DEVELOPING_OPAL/validate/src/test/resources/llvm/cross_language/taint/x86_64/lifted_retdec.ll",
    XlangForwardFlowPath.PROPERTY_VALIDATOR_KEY,
    NativeForwardTaintAnalysisScheduler
)
