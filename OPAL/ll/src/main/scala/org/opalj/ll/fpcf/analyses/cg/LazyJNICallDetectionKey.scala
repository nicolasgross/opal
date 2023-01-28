/* BSD 2-Clause License - see OPAL/LICENSE for details. */
package org.opalj.ll.fpcf.analyses.cg

import org.opalj.br.Method
import org.opalj.br.analyses.{ProjectInformationKey, SomeProject}
import org.opalj.ll.LLVMProjectKey
import org.opalj.ll.llvm.value.Call

import scala.collection.concurrent.TrieMap

object LazyJNICallDetectionKey extends ProjectInformationKey[Call => Option[Method], Nothing] {

    /**
     * The JNI call detection requires a LLVM project.
     *
     * @return the dependencies.
     */
    override def requirements(project: SomeProject): Seq[ProjectInformationKey[_ <: AnyRef, _ <: AnyRef]] = Seq(LLVMProjectKey)

    /**
     * Returns an factory which detects and caches whether a call is a JNI call.
     */
    override def compute(project: SomeProject): Call => Option[Method] = {
        val detections = TrieMap.empty[Call, Option[Method]]

        def detectAndCache(call: Call): Option[Method] = {
            val detection = JNICallDetectionAnalysis.analyze(call, project)
            detections.put(call, detection)
            detection
        }

        (call: Call) =>
            detections.get(call) match {
                case Some(method) => method
                case None => call.synchronized {
                    detections.get(call) match {
                        case Some(method) => method
                        case None => detectAndCache(call)
                    }
                }
            }
    }
}

