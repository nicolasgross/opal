/* BSD 2-Clause License - see OPAL/LICENSE for details. */
package org.opalj.ll

import org.opalj.br.analyses.Project
import org.opalj.fpcf.PropertiesTest
import org.opalj.fpcf.properties.taint_xlang.XlangForwardFlowPath
import org.opalj.ifds.IFDSFact
import org.opalj.ll.fpcf.analyses.ifds.taint.{JavaForwardTaintAnalysisScheduler, NativeForwardTaintAnalysisScheduler}
import org.opalj.tac.cg.RTACallGraphKey
import org.opalj.tac.fpcf.analyses.ifds.taint.TaintNullFact

import java.net.URL

abstract class AbstractCrossLanguageForwardTaintAnalysisTest(llvmModule: String, validator: String) extends PropertiesTest {
    override def init(p: Project[URL]): Unit = {
        p.updateProjectInformationKeyInitializationData(LLVMProjectKey)(
            current => List(llvmModule)
        )
        p.get(LLVMProjectKey)
        p.get(RTACallGraphKey)
    }

    describe("CrossLanguageForwardTaintAnalysis") {
        val testContext = executeAnalyses(JavaForwardTaintAnalysisScheduler, NativeForwardTaintAnalysisScheduler)
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

class CrossLanguageForwardTaintAnalysisTest extends AbstractCrossLanguageForwardTaintAnalysisTest(
    "./DEVELOPING_OPAL/validate/src/test/resources/llvm/cross_language/taint/TaintTest.ll",
    XlangForwardFlowPath.PROPERTY_VALIDATOR_KEY
)

class CrossLanguageMcSemaForwardTaintAnalysisTest extends AbstractCrossLanguageForwardTaintAnalysisTest(
    "./DEVELOPING_OPAL/validate/src/test/resources/llvm/cross_language/taint/lifted_mcsema.ll",
    XlangForwardFlowPath.PROPERTY_VALIDATOR_KEY
)

class CrossLanguageRetdecForwardTaintAnalysisTest extends AbstractCrossLanguageForwardTaintAnalysisTest(
    "./DEVELOPING_OPAL/validate/src/test/resources/llvm/cross_language/taint/lifted_retdec.ll",
    XlangForwardFlowPath.PROPERTY_VALIDATOR_KEY
)
