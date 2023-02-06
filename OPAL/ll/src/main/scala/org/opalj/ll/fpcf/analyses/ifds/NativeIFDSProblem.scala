/* BSD 2-Clause License - see OPAL/LICENSE for details. */
package org.opalj.ll.fpcf.analyses.ifds

import org.opalj.br.Method
import org.opalj.br.analyses.SomeProject
import org.opalj.br.fpcf.PropertyStoreKey
import org.opalj.fpcf.{EOptionP, FinalEP, InterimEUBP, Property, PropertyKey, PropertyStore}
import org.opalj.ifds.Dependees.Getter
import org.opalj.ifds.{AbstractIFDSFact, Callable, IFDSFact, IFDSProblem, IFDSProperty}
import org.opalj.ll.LLVMProjectKey
import org.opalj.ll.fpcf.analyses.ifds.taint.NativeArrayElement
import org.opalj.ll.llvm.value.{GetElementPtr, Instruction, Value}
import org.opalj.tac.fpcf.analyses.ifds.{JavaICFG, JavaStatement}

abstract class NativeForwardIFDSProblem[Fact <: AbstractIFDSFact, JavaFact <: AbstractIFDSFact](project: SomeProject)
    extends NativeIFDSProblem[Fact, JavaFact](project, new NativeForwardICFG(project))

abstract class NativeBackwardIFDSProblem[Fact <: AbstractIFDSFact, JavaFact <: AbstractIFDSFact](project: SomeProject)
    extends NativeIFDSProblem[Fact, JavaFact](project, new NativeBackwardICFG(project))

abstract class NativeIFDSProblem[Fact <: AbstractIFDSFact, JavaFact <: AbstractIFDSFact](project: SomeProject, override val icfg: NativeICFG)
    extends IFDSProblem[Fact, NativeFunction, LLVMStatement](icfg) {
    final implicit val propertyStore: PropertyStore = project.get(PropertyStoreKey)
    val javaPropertyKey: PropertyKey[Property]
    val javaICFG: JavaICFG

    override def createCallable(callable: NativeFunction): Callable = callable

    override def outsideAnalysisContextCall(callee: NativeFunction): Option[(LLVMStatement, Option[LLVMStatement], Fact, Seq[Callable], Getter) => Set[Fact]] = callee match {
        case LLVMFunction(function) =>
            function.basicBlockCount match {
                case 0 => Some((_: LLVMStatement, _: Option[LLVMStatement], in: Fact, _: Seq[Callable], _: Getter) => Set(in))
                case _ => None
            }
        case JNIMethod(method) => Some(handleJavaMethod(method))
    }

    private def handleJavaMethod(callee: Method)(call: LLVMStatement, successor: Option[LLVMStatement], in: Fact,
                                                 unbCallChain: Seq[Callable], dependeesGetter: Getter): Set[Fact] = {
        var result = Set.empty[Fact]
        val entryFacts = javaICFG.startStatements(callee).flatMap(javaCallFlow(_, call, callee, in)).map(new IFDSFact(_))
        for (entryFact <- entryFacts) { // ifds line 14
            val e = (callee, entryFact)
            val exitFacts: Map[JavaStatement, Set[JavaFact]] =
                dependeesGetter(e, javaPropertyKey).asInstanceOf[EOptionP[(JavaStatement, JavaFact), IFDSProperty[JavaStatement, JavaFact]]] match {
                    case ep: FinalEP[_, IFDSProperty[JavaStatement, JavaFact]] =>
                        ep.p.flows
                    case ep: InterimEUBP[_, IFDSProperty[JavaStatement, JavaFact]] =>
                        ep.ub.flows
                    case _ =>
                        Map.empty
                }
            for {
                (exitStatement, exitStatementFacts) <- exitFacts // ifds line 15.2
                exitStatementFact <- exitStatementFacts // ifds line 15.3
            } {
                result ++= javaReturnFlow(exitStatement, exitStatementFact, call, in, unbCallChain, successor)
            }
        }
        result
    }

    /**
     * Computes the data flow for a call to start edge.
     *
     * @param call The analyzed call statement.
     * @param callee The called method, for which the data flow shall be computed.
     * @param in The fact which holds before the execution of the `call`.
     * @param source The entity, which is analyzed.
     * @return The facts, which hold after the execution of `statement` under the assumption that
     *         the facts in `in` held before `statement` and `statement` calls `callee`.
     */
    protected def javaCallFlow(
        start:  JavaStatement,
        call:   LLVMStatement,
        callee: Method,
        in:     Fact
    ): Set[JavaFact]

    protected def javaReturnFlow(
        exit:         JavaStatement,
        in:           JavaFact,
        call:         LLVMStatement,
        callFact:     Fact,
        unbCallChain: Seq[Callable],
        successor:    Option[LLVMStatement]
    ): Set[Fact]

    /**
     * TODO Hardcoded aliases, must be replaced by an alias analysis.
     *
     * Aliases are stored in following format: foo => List((%12, %14), (%18, %26)),
     * Function foo has following aliases: %12 and %14 as well as %18 and %26.
     */
    val ptrAliasDefinitions: Map[String, List[Set[String]]] = Map()

    private lazy val ptrAliasesParsed: Map[LLVMFunction, List[Set[Value]]] = {
        def getInstrStartingWith(start: String, function: LLVMFunction): Option[Instruction] = {
            for (bb <- function.function.basicBlocks) {
                for (instr <- bb.instructions) {
                    if (instr.repr.trim.startsWith(start)) return Some(instr)
                }
            }
            None
        }
        val llvmProject = project.get(LLVMProjectKey)
        ptrAliasDefinitions.map {
            case (fname, list) =>
                val func = LLVMFunction(llvmProject.function(fname).get)
                (func, list.map(aliases => aliases.map(getInstrStartingWith(_, func).get)))
        }
    }

    /**
     * Get pointer aliases for a NativeArrayElement taint fact. Necessary for following case:
     * Callee returns a tainted array element with the base being a variable in the caller that was passed to the callee.
     * All variables in the caller must be tainted that are a GetElementPtr with same base and indices.
     */
    protected def getPtrAliasesForArrElem(fact: NativeArrayElement, function: LLVMFunction): Set[Value] = {
        val gep = function.function.basicBlocks.flatMap(_.instructions).find {
            case gep: GetElementPtr if gep.base == fact.base && gep.isConstant && gep.constants == fact.indices => true
            case _ => false
        }
        if (gep.isDefined) getPtrAliases(gep.get, function) + gep.get
        else Set.empty
    }

    /**
     * Get pointer aliases for a value.
     */
    protected def getPtrAliases(ptr: Value, function: LLVMFunction): Set[Value] =
        ptrAliasesParsed.get(function) match {
            case Some(list) =>
                list.foreach(aliases => if (aliases.contains(ptr)) return aliases - ptr)
                Set.empty
            case None => Set.empty
        }
}
