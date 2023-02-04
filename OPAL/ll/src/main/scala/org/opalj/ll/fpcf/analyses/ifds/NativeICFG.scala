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
            case call: Call => Some(resolveCallees(call))
            case _          => None
        }
    }

    private def resolveCallees(call: Call): Set[_ <: NativeFunction] = {
        val jniCallDetection = project.get(LazyJNICallDetectionKey)
        call.calledValue match {
            case function: Function => Set(LLVMFunction(function))
            case _ => jniCallDetection(call) match {
                case Some(methods) => methods.map(JNIMethod)
                case None => Set.empty
            }
        }
    }

    override def getCallers(callee: NativeFunction): Set[LLVMStatement] = {
        val cg = project.get(SimpleNativeCallGraphKey)
        cg(callee).getOrElse(Set.empty).map(LLVMStatement)
    }
}
