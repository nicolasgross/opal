/* BSD 2-Clause License - see OPAL/LICENSE for details. */
package org.opalj.apk

import com.typesafe.config.ConfigValueFactory
import org.opalj.apk.parser.{ApkParser, DexParser}
import org.opalj.br.Method
import org.opalj.br.analyses.cg.{AllEntryPointsFinder, InitialEntryPointsKey}
import org.opalj.br.analyses.{BasicReport, ProjectInformationKeys, SomeProject}
import org.opalj.br.fpcf.FPCFAnalysesManagerKey
import org.opalj.fpcf.{PropertyBounds, PropertyStore}
import org.opalj.ifds.{Callable, IFDSAnalysis, IFDSAnalysisScheduler, IFDSFact, IFDSPropertyMetaInformation}
import org.opalj.ll.LLVMProjectKey
import org.opalj.ll.fpcf.analyses.cg.SimpleNativeCallGraphKey
import org.opalj.ll.fpcf.analyses.ifds.{LLVMFunction, LLVMStatement, McSemaUtil, NativeFunction, NativeIFDSAnalysis, NativeIFDSAnalysisScheduler}
import org.opalj.ll.fpcf.analyses.ifds.taint.{NativeArrayElement, NativeTaintFact, NativeTaintNullFact, SimpleJavaBackwardTaintProblem, SimpleNativeBackwardTaintProblem}
import org.opalj.ll.fpcf.properties.NativeTaint
import org.opalj.tac.cg.RTACallGraphKey
import org.opalj.tac.fpcf.analyses.ifds.{JavaIFDSProblem, JavaStatement}
import org.opalj.tac.fpcf.analyses.ifds.taint.{FlowFact, TaintFact, Variable}
import org.opalj.tac.fpcf.properties.{TACAI, Taint}

import scala.annotation.unused

/**
 * Simple demo that loads an APK file and its lifted native libs to run a cross-language backward taint analysis.
 * Used to evluate runtime of the analysis on real-world apps.
 *
 * @author Nicolas Gross
 */
object ApkXlangBackwardTaintAnalysis {

    /**
     * Load APK and run cross-language backward taint analysis.
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
                ))
            .withValue(
                    AllEntryPointsFinder.ConfigKey, ConfigValueFactory.fromAnyRef(true)
                )
        val project = ApkParser.createProject(args.head, liftedLibs, project_config, DexParser.Enjarify)

        // run analysis
        project.get(RTACallGraphKey)
        val manager = project.get(FPCFAnalysesManagerKey)
        val (ps, analyses) = manager.runAll(MyJavaBackwardTaintAnalysisScheduler, MyNativeBackwardTaintAnalysisScheduler)

        // obtain analysis results
        for ((method, fact) <- analyses.head._2.asInstanceOf[MyJavaBackwardTaintAnalysis].ifdsProblem.entryPoints) {
            @unused // do something with taint facts
            val taintFacts = ps((method, fact), MyJavaBackwardTaintAnalysisScheduler.property.key)
        }

        BasicReport("Done.")
    }
}


// define entry points, sources, sinks, and sanitizers for Java code
class MyJavaBackwardTaintProblem(p: SomeProject) extends SimpleJavaBackwardTaintProblem(p) {

    override val entryPoints: Seq[(Method, IFDSFact[TaintFact, JavaStatement])] = p.allProjectClassFiles
        .flatMap(_.methods)
        .filter(_.body.isDefined)
        .filter(_.name == "query")
        .map(m => m -> new IFDSFact(
            Variable(JavaIFDSProblem.switchParamAndVariableIndex(0, isStaticMethod = false))))

    override protected def sanitizesReturnValue(callee: Method): Boolean = false

    override protected def createFlowFactAtCall(call: JavaStatement, in: TaintFact,
                                                unbCallChain: Seq[Callable]): Option[FlowFact] = None
}

// boilerplate code
class MyJavaBackwardTaintAnalysis(project: SomeProject)
    extends IFDSAnalysis()(project, new MyJavaBackwardTaintProblem(project), Taint)

// boilerplate code
object MyJavaBackwardTaintAnalysisScheduler extends IFDSAnalysisScheduler[TaintFact, Method, JavaStatement] {
    override def init(p: SomeProject, ps: PropertyStore) = new MyJavaBackwardTaintAnalysis(p)
    override def property: IFDSPropertyMetaInformation[JavaStatement, TaintFact] = Taint
    override def requiredProjectInformation: ProjectInformationKeys = Seq(LLVMProjectKey)
    override val uses: Set[PropertyBounds] = Set(PropertyBounds.finalP(TACAI), PropertyBounds.ub(NativeTaint))
}


// define entry points, sources, sinks, and sanitizers for native code
class MyNativeBackwardTaintProblem(p: SomeProject) extends SimpleNativeBackwardTaintProblem(Map.empty, p) {

    override val entryPoints: Seq[(NativeFunction, IFDSFact[NativeTaintFact, LLVMStatement])] = {
        p.get(LLVMProjectKey).functions
            .filter(f => McSemaUtil.matchesMcSemaFunctionName(f.name, "sqlite3_snprintf")
                || McSemaUtil.matchesMcSemaFunctionName(f.name, "BIO_printf"))
            .filter(f => McSemaUtil.isMcSemaStateType(f.argument(0).typ))
            .toSeq
            .map(f => (LLVMFunction(f), new IFDSFact(NativeTaintNullFact)))
    }

    override protected def sanitizesReturnValue(callee: NativeFunction): Boolean = false

    override protected def createFlowFactAtCall(call: LLVMStatement, in: NativeTaintFact,
                                                unbCallChain: Seq[Callable]): Option[NativeTaintFact] = None

    override def createFlowFactAtExit(callee: NativeFunction, in: NativeTaintFact,
                                      unbCallChain: Seq[Callable]): Option[NativeTaintFact] = callee match {
        case LLVMFunction(function) if (McSemaUtil.matchesMcSemaFunctionName(function.name, "sqlite3_snprintf")
            || McSemaUtil.matchesMcSemaFunctionName(function.name, "BIO_printf")) &&
            McSemaUtil.isMcSemaStateType(function.argument(0).typ) =>
            Some(NativeArrayElement(function.argument(0), McSemaUtil.getArgRegIndices(function.module.targetTriple, 1)))
        case _ => None
    }
}

// boilerplate code
class MyNativeBackwardTaintAnalysis(project: SomeProject)
    extends NativeIFDSAnalysis(project, new MyNativeBackwardTaintProblem(project), NativeTaint)

// boilerplate code
object MyNativeBackwardTaintAnalysisScheduler extends NativeIFDSAnalysisScheduler[NativeTaintFact] {
    override def init(p: SomeProject, ps: PropertyStore) = new MyNativeBackwardTaintAnalysis(p)
    override def property: IFDSPropertyMetaInformation[LLVMStatement, NativeTaintFact] = NativeTaint
    override val uses: Set[PropertyBounds] = Set()
    override def requiredProjectInformation: ProjectInformationKeys = SimpleNativeCallGraphKey +: super.requiredProjectInformation
}
