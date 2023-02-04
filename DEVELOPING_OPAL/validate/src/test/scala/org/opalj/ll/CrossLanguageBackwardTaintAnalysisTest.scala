/* BSD 2-Clause License - see OPAL/LICENSE for details. */
package org.opalj.ll;

import org.opalj.br.analyses.Project
import org.opalj.fpcf.PropertiesTest
import org.opalj.fpcf.properties.taint_xlang.{XlangBackwardFlowPath, XlangMcSemaBackwardFlowPath}
import org.opalj.ifds.IFDSFact
import org.opalj.ll.fpcf.analyses.cg.SimpleNativeCallGraphKey
import org.opalj.ll.fpcf.analyses.ifds.taint.{JavaBackwardTaintAnalysisScheduler, NativeBackwardTaintAnalysisScheduler}
import org.opalj.tac.cg.RTACallGraphKey
import org.opalj.tac.fpcf.analyses.ifds.taint.TaintNullFact

import java.net.URL

abstract class AbstractCrossLanguageBackwardTaintAnalysisTest(llvmModule: String, validator: String) extends PropertiesTest {
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
        val testContext = executeAnalyses(JavaBackwardTaintAnalysisScheduler, NativeBackwardTaintAnalysisScheduler)
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

class CrossLanguageBackwardTaintAnalysisTest extends AbstractCrossLanguageBackwardTaintAnalysisTest(
    "./DEVELOPING_OPAL/validate/src/test/resources/llvm/cross_language/taint/TaintTest.ll",
    XlangBackwardFlowPath.PROPERTY_VALIDATOR_KEY
)

class CrossLanguageMcSemaBackwardTaintAnalysisTest extends AbstractCrossLanguageBackwardTaintAnalysisTest(
    "./DEVELOPING_OPAL/validate/src/test/resources/llvm/cross_language/taint/lifted_mcsema.ll",
    XlangMcSemaBackwardFlowPath.PROPERTY_VALIDATOR_KEY
)

class CrossLanguageRetdecBackwardTaintAnalysisTest extends AbstractCrossLanguageBackwardTaintAnalysisTest(
    "./DEVELOPING_OPAL/validate/src/test/resources/llvm/cross_language/taint/lifted_retdec.ll",
    XlangBackwardFlowPath.PROPERTY_VALIDATOR_KEY
)
