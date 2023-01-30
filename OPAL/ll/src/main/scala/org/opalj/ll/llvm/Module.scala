/* BSD 2-Clause License - see OPAL/LICENSE for details. */
package org.opalj.ll.llvm

import org.bytedeco.llvm.LLVM.{LLVMModuleRef, LLVMValueRef}
import org.bytedeco.llvm.global.LLVM.{LLVMDisposeMessage, LLVMGetFirstFunction, LLVMGetNamedFunction, LLVMGetNextFunction, LLVMGetTarget, LLVMPrintModuleToString}
import org.opalj.ll.llvm.value.{Function, Value}

case class Module(ref: LLVMModuleRef, is64Bit: Boolean) {
    def functions: FunctionIterator = {
        new FunctionIterator(LLVMGetFirstFunction(ref))
    }

    def repr: String = {
        val bytePointer = LLVMPrintModuleToString(ref)
        val string = bytePointer.getString
        LLVMDisposeMessage(bytePointer)
        string
    }

    def targetTriple: String = {
        val bytePointer = LLVMGetTarget(ref)
        val string = bytePointer.getString
        string
    }

    def function(name: String): Function =
        Value(LLVMGetNamedFunction(ref, name)) match {
            case None =>
                throw new IllegalArgumentException("Unknown function '"+name+"'")
            case Some(function: Function) => function
            case Some(_)                  => throw new IllegalStateException("Expected LLVMGetNamedFunction to return a Function ref")
        }
}

class FunctionIterator(var ref: LLVMValueRef) extends Iterator[Function] {
    override def hasNext: Boolean = ref != null

    override def next(): Function = {
        val function = Function(ref)
        this.ref = LLVMGetNextFunction(ref)
        function
    }
}
