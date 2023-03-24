/* BSD 2-Clause License - see OPAL/LICENSE for details. */
package org.opalj.ll.fpcf.analyses.cg

import org.opalj.br.analyses.{ProjectInformationKey, SomeProject}
import org.opalj.ll.LLVMProjectKey
import org.opalj.ll.fpcf.analyses.ifds.{JNIMethod, LLVMFunction, NativeFunction}
import org.opalj.ll.llvm.value.Call

/**
 * Simple native call graph implementation. Computes local callees for each function and merges all local information
 * into one global callgraph.
 */
object SimpleNativeCallGraphKey extends ProjectInformationKey[Map[NativeFunction, Set[Call]], Nothing] {

    /**
     * The computation of the call graph requires a LLVM project.
     *
     * @return the dependencies.
     */
    override def requirements(project: SomeProject): Seq[ProjectInformationKey[_ <: AnyRef, _ <: AnyRef]] = Seq(LLVMProjectKey)

    /**
     * Computes the call graph.
     *
     * @return the call graph.
     */
    override def compute(project: SomeProject): Map[NativeFunction, Set[Call]] = {
        val cg = scala.collection.mutable.Map.empty[NativeFunction, Set[Call]]
        project.get(LLVMProjectKey).functions
            .map(f => project.get(NativeCalleesKey)(f))
            .foreach(_.foreach(tuple => tuple._1 match {
                case LLVMFunction(f) => // normal native function call
                    val newCalls = cg.getOrElse(LLVMFunction(f), Set.empty) ++ Set(tuple._2)
                    cg.update(LLVMFunction(f), newCalls)
                case jniCallee: JNIMethod =>
                    val newCalls = cg.getOrElse(jniCallee, Set.empty) ++ Set(tuple._2)
                    cg.update(jniCallee, newCalls)
            }))
        cg.toMap
    }
}
