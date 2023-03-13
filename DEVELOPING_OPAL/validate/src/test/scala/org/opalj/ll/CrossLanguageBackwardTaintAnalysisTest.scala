/* BSD 2-Clause License - see OPAL/LICENSE for details. */
package org.opalj.ll;

import org.opalj.br.analyses.Project
import org.opalj.fpcf.PropertiesTest
import org.opalj.fpcf.properties.taint_xlang.{XlangMcSemaAarch64BackwardFlowPath, XlangBackwardFlowPath, XlangMcSemaX8664BackwardFlowPath}
import org.opalj.ifds.IFDSFact
import org.opalj.ll.fpcf.analyses.cg.SimpleNativeCallGraphKey
import org.opalj.ll.fpcf.analyses.ifds.NativeIFDSAnalysisScheduler
import org.opalj.ll.fpcf.analyses.ifds.taint.{JavaBackwardTaintAnalysisScheduler, NativeMcSemaAarch64BackwardTaintAnalysisScheduler, NativeBackwardTaintAnalysisScheduler, NativeTaintFact, NativeMcSemaX8664BackwardTaintAnalysisScheduler}
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
    NativeBackwardTaintAnalysisScheduler
)

class CrossLanguageO2BackwardTaintAnalysisTest extends AbstractCrossLanguageBackwardTaintAnalysisTest(
    "./DEVELOPING_OPAL/validate/src/test/resources/llvm/cross_language/taint/x86_64/TaintTest_O2.ll",
    XlangBackwardFlowPath.PROPERTY_VALIDATOR_KEY,
    NativeBackwardTaintAnalysisScheduler
)

class CrossLanguageMcSemaX8664BackwardTaintAnalysisTest extends AbstractCrossLanguageBackwardTaintAnalysisTest(
    "./DEVELOPING_OPAL/validate/src/test/resources/llvm/cross_language/taint/x86_64/libtainttest_clang_O0_mcsema.ll",
    XlangMcSemaX8664BackwardFlowPath.PROPERTY_VALIDATOR_KEY,
    NativeMcSemaX8664BackwardTaintAnalysisScheduler
)

class CrossLanguageMcSemaAarch64BackwardTaintAnalysisTest extends AbstractCrossLanguageBackwardTaintAnalysisTest(
    "./DEVELOPING_OPAL/validate/src/test/resources/llvm/cross_language/taint/aarch64/lifted_mcsema.ll",
    XlangMcSemaAarch64BackwardFlowPath.PROPERTY_VALIDATOR_KEY,
    NativeMcSemaAarch64BackwardTaintAnalysisScheduler
)

class CrossLanguageRetdecX8664BackwardTaintAnalysisTest extends AbstractCrossLanguageBackwardTaintAnalysisTest(
    "./DEVELOPING_OPAL/validate/src/test/resources/llvm/cross_language/taint/x86_64/lifted_retdec.ll",
    XlangBackwardFlowPath.PROPERTY_VALIDATOR_KEY,
    NativeBackwardTaintAnalysisScheduler
)
