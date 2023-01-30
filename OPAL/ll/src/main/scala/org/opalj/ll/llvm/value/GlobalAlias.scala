/* BSD 2-Clause License - see OPAL/LICENSE for details. */
package org.opalj.ll.llvm.value

import org.bytedeco.llvm.LLVM.LLVMValueRef
import org.bytedeco.llvm.global.LLVM.LLVMAliasGetAliasee

case class GlobalAlias(ref: LLVMValueRef) extends Value(ref: LLVMValueRef) {
    def aliasee: Value = Value(LLVMAliasGetAliasee(ref)).get
}
