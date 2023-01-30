/* BSD 2-Clause License - see OPAL/LICENSE for details. */

package org.opalj.ll.llvm
package value
package constant

import org.bytedeco.llvm.LLVM.LLVMValueRef
import org.bytedeco.llvm.global.LLVM.{LLVMGetAggregateElement, LLVMGetAsString}
import org.bytedeco.javacpp.SizeTPointer

import scala.collection.mutable.ListBuffer


abstract class ConstantDataSequential(ref: LLVMValueRef) extends User(ref) {
    def asString: String = LLVMGetAsString(ref, new SizeTPointer(1)).getString

    def subSeqAsString(startIndex: Int = 0): Option[String] = {
        val chars = ListBuffer.empty[Char]
        var index = startIndex
        while (true) {
            Value(LLVMGetAggregateElement(ref, index)) match {
                case None => return Some(chars.mkString) // reached end of data sequential
                case Some(value) => value match {
                    case constInt: ConstantIntValue if constInt.signExtendedValue == 0 => return Some(chars.mkString)
                    case constInt: ConstantIntValue => chars.append(constInt.signExtendedValue.toChar)
                    case _ => return None
                }
            }
            index += 1
        }
        None // should never be reached
    }
}

case class ConstantDataArray(ref: LLVMValueRef) extends ConstantDataSequential(ref)
case class ConstantDataVector(ref: LLVMValueRef) extends ConstantDataSequential(ref)
