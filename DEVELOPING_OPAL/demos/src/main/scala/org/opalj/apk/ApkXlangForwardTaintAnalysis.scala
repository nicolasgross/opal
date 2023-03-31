/* BSD 2-Clause License - see OPAL/LICENSE for details. */
package org.opalj.apk

import com.typesafe.config.ConfigValueFactory
import org.opalj.apk.parser.{ApkParser, DexParser}
import org.opalj.br.Method
import org.opalj.br.analyses.cg.{AllEntryPointsFinder, InitialEntryPointsKey}
import org.opalj.br.analyses.{BasicReport, ProjectInformationKeys, SomeProject}
import org.opalj.br.fpcf.FPCFAnalysesManagerKey
import org.opalj.fpcf.{PropertyBounds, PropertyStore}
import org.opalj.ifds.{IFDSAnalysis, IFDSAnalysisScheduler, IFDSFact, IFDSPropertyMetaInformation}
import org.opalj.ll.LLVMProjectKey
import org.opalj.ll.fpcf.analyses.ifds.{LLVMFunction, LLVMStatement, NativeFunction, NativeIFDSAnalysis, NativeIFDSAnalysisScheduler}
import org.opalj.ll.fpcf.analyses.ifds.taint.{NativeFlowFact, NativeTaintFact, SimpleJavaForwardTaintProblem, SimpleNativeForwardTaintProblem}
import org.opalj.ll.fpcf.properties.NativeTaint
import org.opalj.tac.{LazyDetachedTACAIKey, TACode}
import org.opalj.tac.cg.RTACallGraphKey
import org.opalj.tac.fpcf.analyses.ifds.JavaStatement
import org.opalj.tac.fpcf.analyses.ifds.taint.{FlowFact, TaintFact, TaintNullFact, Variable}
import org.opalj.tac.fpcf.properties.{TACAI, Taint}

import scala.annotation.unused

/**
 * Simple demo that loads an APK file and its lifted native libs to run a cross-language forward taint analysis.
 * Used to evluate runtime of the analysis on real-world apps.
 *
 * @author Nicolas Gross
 */
object ApkXlangForwardTaintAnalysis {

    /**
     * Load APK and run cross-language forward taint analysis.
     *
     * @param args first arg is path to APK, all following args are paths to lifted native libs.
     */
    def main(args: Array[String]): Unit = {
        if (args.isEmpty) {
            println("Missing arguments")
            return
        }

        // create APK based project
        val liftedLibs = if (args.length == 1) List.empty else args.tail.toList
        val project_config = BaseConfig.withValue(
            InitialEntryPointsKey.ConfigKey, ConfigValueFactory.fromAnyRef(
                "org.opalj.br.analyses.cg.AllEntryPointsFinder"
            )
        )
            .withValue(
                AllEntryPointsFinder.ConfigKey, ConfigValueFactory.fromAnyRef(true)
            )
        val project = ApkParser.createProject(args.head, liftedLibs, project_config, DexParser.Enjarify)

        printTargetCodeMetrics(project)

        // run analysis
        project.get(RTACallGraphKey)
        val manager = project.get(FPCFAnalysesManagerKey)
        val (ps, analyses) = manager.runAll(MyJavaForwardTaintAnalysisScheduler, MyNativeForwardTaintAnalysisScheduler)

        // obtain analysis results
        for ((method, fact) <- analyses.head._2.asInstanceOf[MyJavaForwardTaintAnalysis].ifdsProblem.entryPoints) {
            @unused // do something with taint facts
            val taintFacts = ps((method, fact), MyJavaForwardTaintAnalysisScheduler.property.key)
        }

        BasicReport("Done.")
    }

    private def printTargetCodeMetrics(project: SomeProject): Unit = {
        // count java bytecode instructions
        val javaBcInstructionsCount = project.allProjectClassFiles
            .flatMap(_.methods)
            .filter(_.body.isDefined)
            .map(_.body.get.instructionsCount)
            .sum

        // count java TAC instructions
        val tacai = project.get(LazyDetachedTACAIKey)
        val javaTACInstructionsCount = project.allProjectClassFiles
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

        println("-----------------------------------------------------------------------------------------------------")
        println(s"Java bytecode instructions: $javaBcInstructionsCount, Java TAC instructions: $javaTACInstructionsCount, LLVM instructions: $llvmInstructionsCount")
        println("-----------------------------------------------------------------------------------------------------")
    }
}

// define entry points, sources, sinks, and sanitizers for Java code
class MyJavaForwardTaintProblem(p: SomeProject) extends SimpleJavaForwardTaintProblem(p) {

    override val entryPoints: Seq[(Method, IFDSFact[TaintFact, JavaStatement])] = for {
        m <- p.allProjectClassFiles
            .filter(classFile => classFile.thisType.fqn.startsWith("com/kunzisoft/keepass"))
            .flatMap(_.methods)
            .filter(_.body.isDefined)
    } yield m -> new IFDSFact(TaintNullFact)

    override protected def sanitizesReturnValue(callee: Method): Boolean = false

    override protected def createTaints(callee: Method, call: JavaStatement): Set[TaintFact] = {
        if (callee.name == "getPassword") Set(Variable(call.index))
        else Set.empty
    }

    override protected def createFlowFact(callee: Method, call: JavaStatement, in: TaintFact): Option[FlowFact] = None
}

// boilerplate code
class MyJavaForwardTaintAnalysis(project: SomeProject)
    extends IFDSAnalysis()(project, new MyJavaForwardTaintProblem(project), Taint)

// boilerplate code
object MyJavaForwardTaintAnalysisScheduler extends IFDSAnalysisScheduler[TaintFact, Method, JavaStatement] {
    override def init(p: SomeProject, ps: PropertyStore) = new MyJavaForwardTaintAnalysis(p)
    override def property: IFDSPropertyMetaInformation[JavaStatement, TaintFact] = Taint
    override def requiredProjectInformation: ProjectInformationKeys = Seq(LLVMProjectKey)
    override val uses: Set[PropertyBounds] = Set(PropertyBounds.finalP(TACAI), PropertyBounds.ub(NativeTaint))
}

// define entry points, sources, sinks, and sanitizers for native code
class MyNativeForwardTaintProblem(p: SomeProject) extends SimpleNativeForwardTaintProblem(Map.empty, p) {

    override val entryPoints: Seq[(NativeFunction, IFDSFact[NativeTaintFact, LLVMStatement])] = Seq.empty

    override protected def sanitizesReturnValue(callee: NativeFunction): Boolean = false

    override protected def createTaints(callee: LLVMFunction, call: LLVMStatement): Set[NativeTaintFact] = Set.empty

    override protected def createFlowFact(call: LLVMStatement, in: NativeTaintFact): Option[NativeFlowFact] = None
}

// boilerplate code
class MyNativeForwardTaintAnalysis(project: SomeProject)
    extends NativeIFDSAnalysis(project, new MyNativeForwardTaintProblem(project), NativeTaint)

// boilerplate code
object MyNativeForwardTaintAnalysisScheduler extends NativeIFDSAnalysisScheduler[NativeTaintFact] {
    override def init(p: SomeProject, ps: PropertyStore) = new MyNativeForwardTaintAnalysis(p)
    override def property: IFDSPropertyMetaInformation[LLVMStatement, NativeTaintFact] = NativeTaint
    override val uses: Set[PropertyBounds] = Set()
}
