/* BSD 2-Clause License - see OPAL/LICENSE for details. */
package org.opalj.ll.fpcf.analyses.ifds

import org.opalj.br.analyses.{DeclaredMethodsKey, SomeProject}
import org.opalj.ifds.ICFG
import org.opalj.ll.fpcf.analyses.cg.{LazyJNICallDetectionKey, SimpleNativeCallGraphKey}
import org.opalj.ll.llvm.value.{Call, Function}

abstract class NativeICFG(project: SomeProject) extends ICFG[NativeFunction, LLVMStatement] {
    implicit val declaredMethods = project.get(DeclaredMethodsKey)

    /**
     * Gets the set of all methods possibly called at some statement.
     *
     * @param statement The statement.
     * @return All callables possibly called at the statement or None, if the statement does not
     *         contain a call.
     */
    override def getCalleesIfCallStatement(statement: LLVMStatement): Option[Set[_ <: NativeFunction]] = {
        statement.instruction match {
            case call: Call => resolveCallee(call) match {
                case Some(method) => Some(Set(method))
                case None => None
            }
            case _          => None
        }
    }

    def resolveCallee(call: Call): Option[_ <: NativeFunction] = {
        val jniCallDetection = project.get(LazyJNICallDetectionKey)
        call.calledValue match {
            case function: Function => Some(LLVMFunction(function))
            case _ => jniCallDetection(call) match {
                case Some(method) => Some(JNIMethod(method))
                case None => None
            }
        }
    }

    override def getCallers(callee: NativeFunction): Set[LLVMStatement] =
        project.get(SimpleNativeCallGraphKey)(callee).getOrElse(Set.empty).map(LLVMStatement)
}
