/* BSD 2-Clause License - see OPAL/LICENSE for details. */
package org.opalj.ll.fpcf.analyses.cg

import org.opalj.br.analyses.{DeclaredMethods, DeclaredMethodsKey, ProjectInformationKeys, SomeProject}
import org.opalj.br.fpcf.{BasicFPCFLazyAnalysisScheduler, FPCFAnalysis, FPCFAnalysisScheduler}
import org.opalj.fpcf._
import org.opalj.ll.fpcf.analyses.ifds.{JNIMethod, LLVMFunction, NativeFunction}
import org.opalj.ll.llvm.value.{Call, Function}

class NativeCGAEntity(val entryPoints: Set[Function], val callChain: Set[Function]) {
    // ignore call chain for hashing/equality such that property store returns same cg for entry points, ignoring the callchain
    override def equals(obj: Any): Boolean = entryPoints.equals(obj)
    override def hashCode(): Int = entryPoints.hashCode()
}

sealed trait SimpleCallGraphPropertyMetaInformation extends PropertyMetaInformation {
    final type Self = SimpleNativeCallGraph
}

case class SimpleNativeCallGraph(cg: Map[NativeFunction, Set[Call]]) extends SimpleCallGraphPropertyMetaInformation with Property {
    final override def key: PropertyKey[SimpleNativeCallGraph] = SimpleNativeCallGraph.key

    def apply(function: NativeFunction): Option[Set[Call]] = cg.get(function)
}

object SimpleNativeCallGraph extends SimpleCallGraphPropertyMetaInformation {
    final val key: PropertyKey[SimpleNativeCallGraph] = PropertyKey.create(
        "SimpleNativeCallGraph",
        new SimpleNativeCallGraph(Map.empty)
    )
}

class SimpleCallGraphAnalysis(val project: SomeProject) extends FPCFAnalysis {
    type CallGraph = Map[NativeFunction, Set[Call]]
    implicit val declaredMethods: DeclaredMethods = project.get(DeclaredMethodsKey)

    def lazilyAnalyze(entity: Entity): ProperPropertyComputationResult = {
        entity match {
            case nativeCGAEntity: NativeCGAEntity => analyze(nativeCGAEntity)
            case _                                => throw new IllegalArgumentException("Simple Call Graph Analysis can only process Sets of Functions!")
        }
    }

    private def analyze(entity: NativeCGAEntity): ProperPropertyComputationResult = {
        if (entity.entryPoints.isEmpty) Result(entity, SimpleNativeCallGraph(Map.empty))
        else if (entity.entryPoints.size == 1) Result(entity, SimpleNativeCallGraph(processFunction(entity.entryPoints.head, entity.callChain)))
        else Result(entity, SimpleNativeCallGraph(processMultipleEntries(entity.entryPoints, entity.callChain)))
    }

    private def processFunction(function: Function, callChain: Set[Function]): CallGraph = {
        val cg = scala.collection.mutable.Map.empty[NativeFunction, Set[Call]]
        val nextEntryPoints = scala.collection.mutable.Set.empty[Function]

        // process calls in this function
        project.get(NativeCalleesKey)(function).foreach(tuple => tuple._1 match {
            case LLVMFunction(f) => // normal native function call
                if (!callChain.contains(f)) nextEntryPoints.add(f)
                val newCalls = cg.getOrElse(LLVMFunction(f), Set.empty) ++ Set(tuple._2)
                cg.update(LLVMFunction(f), newCalls)
            case jniCallee: JNIMethod =>
                val newCalls = cg.getOrElse(jniCallee, Set.empty) ++ Set(tuple._2)
                cg.update(jniCallee, newCalls)
        })

        val subCg = processMultipleEntries(nextEntryPoints.toSet, callChain + function)
        mergeCallGraphs(cg.toMap, subCg)
    }

    private def processMultipleEntries(entryPoints: Set[Function], callChain: Set[Function]): CallGraph = {
        // if multiple entry points, get individual call graphs from property store and merge them
        val cgs = entryPoints
            .map(e => propertyStore(EPK(new NativeCGAEntity(Set(e), callChain), SimpleNativeCallGraph.key)))
            .map {
                case ep: FinalEP[NativeCGAEntity, SimpleNativeCallGraph] => ep.p.cg
                case _                                                   => Map.empty[NativeFunction, Set[Call]] // analysis already triggered
            }
        cgs.fold(Map.empty)(mergeCallGraphs)
    }

    private def mergeCallGraphs(cg1: CallGraph, cg2: CallGraph): CallGraph = {
        (cg1.toSeq ++ cg2.toSeq).groupBy(_._1).map {
            case (key, value) => (key, value.flatMap(_._2).toSet)
        }
    }
}

trait SimpleCallGraphAnalysisScheduler extends FPCFAnalysisScheduler {
    def derivedProperty: PropertyBounds = PropertyBounds.ub(SimpleNativeCallGraph)

    override def requiredProjectInformation: ProjectInformationKeys = Seq(DeclaredMethodsKey)

    override def uses: Set[PropertyBounds] = Set(PropertyBounds.ub(SimpleNativeCallGraph))
}

object LazySimpleCallGraphAnalysis extends SimpleCallGraphAnalysisScheduler with BasicFPCFLazyAnalysisScheduler {
    override def derivesLazily: Some[PropertyBounds] = Some(derivedProperty)

    override def register(project: SomeProject, propertyStore: PropertyStore, initData: InitializationData): FPCFAnalysis = {
        val analysis = new SimpleCallGraphAnalysis(project)
        propertyStore.registerLazyPropertyComputation(SimpleNativeCallGraph.key, analysis.lazilyAnalyze)
        analysis
    }
}