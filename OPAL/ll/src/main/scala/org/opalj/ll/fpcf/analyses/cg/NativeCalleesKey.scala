/* BSD 2-Clause License - see OPAL/LICENSE for details. */
package org.opalj.ll.fpcf.analyses.cg

import org.opalj.br.analyses.{ProjectInformationKey, SomeProject}
import org.opalj.ll.LLVMProjectKey
import org.opalj.ll.fpcf.analyses.ifds.{JNIMethod, LLVMFunction, NativeFunction}
import org.opalj.ll.llvm.value.{Call, Function}

import java.util.concurrent.atomic.AtomicInteger
import scala.collection.concurrent.TrieMap

object NativeCalleesKey extends ProjectInformationKey[Function => Set[(NativeFunction, Call)], Nothing] {

    /**
     * Requires a LLVM project.
     *
     * @return the dependencies.
     */
    override def requirements(project: SomeProject): Seq[ProjectInformationKey[_ <: AnyRef, _ <: AnyRef]] = Seq(LLVMProjectKey)

    /**
     * Returns an factory which detects and caches the callees + callsites in a function.
     */
    override def compute(project: SomeProject): Function => Set[(NativeFunction, Call)] = {
        val calleesStore = TrieMap.empty[Function, Set[(NativeFunction, Call)]]

        def detectAndCache(function: Function): Set[(NativeFunction, Call)] = {
            val callees = scala.collection.mutable.Set.empty[(NativeFunction, Call)]
            val jniCallDetection = project.get(LazyJNICallDetectionKey)

            // process calls in this function
            function.basicBlocks.flatMap(_.instructions).foreach {
                case c: Call => c.calledValue match {
                    case f: Function => // normal native function call
                        callees.add((LLVMFunction(f), c))
                    case _ => jniCallDetection(c) match {
                        case Some(methods) =>
                            callees.addAll(methods.map(m => (JNIMethod(m), c)))
                        case _ =>
                    }
                }
                case _ =>
            }
            calleesStore.put(function, callees.toSet)
            callees.toSet
        }

        (function: Function) =>
            calleesStore.get(function) match {
                case Some(callees) => callees
                case None => function.synchronized {
                    calleesStore.get(function) match {
                        case Some(callees) => callees
                        case None          => detectAndCache(function)
                    }
                }
            }
    }
}
