/* BSD 2-Clause License - see OPAL/LICENSE for details. */
package org.opalj.ll.llvm.value.constant

import org.bytedeco.llvm.LLVM.LLVMValueRef
import org.bytedeco.llvm.global.LLVM.LLVMGetAggregateElement
import org.opalj.ll.llvm.value.{User, Value}

case class ConstantStruct(ref: LLVMValueRef) extends User(ref) {
    def getIndex(index: Int) = Value(LLVMGetAggregateElement(ref, index)).get
}
