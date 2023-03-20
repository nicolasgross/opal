/* BSD 2-Clause License - see OPAL/LICENSE for details. */
package org.opalj.ll.fpcf.analyses.ifds

import org.opalj.br.analyses.SomeProject
import org.opalj.ll.fpcf.analyses.ifds.taint.{NativeTaintFact, NativeVariable}
import org.opalj.ll.llvm.{PointerType, StructType, Type}
import org.opalj.ll.llvm.value.{BitCast, Call, GetElementPtr, Load, Store, Value}

/**
 * Helper functions to work on LLVM IR lifted by McSema.
 *
 * Created based on McSema commit 2636805.
 *
 * @author Nicolas Gross
 */
object McSemaUtil {

    /**
     * Gets indices of return register in McSema state for each architecture.
     *
     * @param targetTriple target triple of the IR for architecture detection.
     * @return the indices of the return register in McSema state.
     */
    def getReturnRegIndices(targetTriple: String): Seq[Long] = {
        if (targetTriple.startsWith("x86_64")) Seq(0, 6, 1, 0, 0) // indices of RAX in McSema state
        else if (targetTriple.startsWith("aarch64")) Seq(0, 3, 1, 0, 0) // indices of X0 in McSema state
        else Seq.empty
    }

    def getArgRegIndices(targetTriple: String, index: Int): Seq[Long] = {
        if (targetTriple.startsWith("x86_64")) index match {
            case 0 => Seq(0, 6, 11, 0, 0) // indices of RDI in McSema state
            case 1 => Seq(0, 6, 9, 0, 0)  // indices of RSI in McSema state
            case 2 => Seq(0, 6, 7, 0, 0)  // indices of RDX in McSema state
            case 3 => Seq(0, 6, 5, 0, 0)  // indices of RCX in McSema state
            case _ => Seq.empty
        }
        else if (targetTriple.startsWith("aarch64")) index match {
            case 0 => Seq(0, 3, 1, 0, 0) // indices of X0 in McSema state
            case 1 => Seq(0, 3, 3, 0, 0) // indices of X1 in McSema state
            case 2 => Seq(0, 3, 5, 0, 0) // indices of X2 in McSema state
            case 3 => Seq(0, 3, 7, 0, 0) // indices of X3 in McSema state
            case _ => Seq.empty
        }
        else Seq.empty
    }

    def isMcSemaStateType(typ: Type): Boolean = typ match {
        case ptr: PointerType if ptr.repr == "%struct.State*"    => true
        case struct: StructType if struct.name == "struct.State" => true
        case _                                                   => false
    }

    def isMcSemaStateCall(call: Call): Boolean = call.argument(0) match {
        case Some(arg) => isMcSemaStateType(arg.typ)
        case None      => false
    }

    private def noStoreOrCallInBetween(start: LLVMStatement, end: LLVMStatement, dst: Value, icfg: NativeICFG): Boolean = {
        icfg.nextStatements(start).map(_.instruction).map {
            case stmt if stmt == end.instruction       => true
            case store: Store if store.dst == dst      => false
            case call: Call if isMcSemaStateCall(call) => false
            case stmt                                  => noStoreOrCallInBetween(LLVMStatement(stmt), end, dst, icfg)
        }.forall(identity)
    }

    def mcSemaRetvalTainted(call: LLVMStatement, in: NativeTaintFact)(implicit project: SomeProject): Boolean = {
        val icfg = new NativeBackwardICFG(project)

        def gepMatchesReturnReg(gep: GetElementPtr): Boolean =
            if (gep.isConstant && isMcSemaStateType(gep.sourceElementType))
                gep.constants == getReturnRegIndices(call.function.function.module.targetTriple)
            else false

        in match {
            case NativeVariable(value) => value match {
                case load: Load if noStoreOrCallInBetween(LLVMStatement(load), call, load.src, icfg) => load.src match {
                    case bc: BitCast => bc.convVal match {
                        case gep: GetElementPtr => gepMatchesReturnReg(gep)
                        case _                  => false
                    }
                    case gep: GetElementPtr => gepMatchesReturnReg(gep)
                    case _                  => false
                }
                case _ => false
            }
            case _ => false
        }
    }

    def matchesMcSemaFunctionName(fnameToCheck: String, matchesWith: String): Boolean =
        fnameToCheck.startsWith("sub_") && fnameToCheck.endsWith(s"_$matchesWith")
}
