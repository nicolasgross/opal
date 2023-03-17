/* BSD 2-Clause License - see OPAL/LICENSE for details. */
package org.opalj.ll.fpcf.analyses.cg

import org.opalj.br.Method
import org.opalj.br.analyses.{DeclaredMethods, DeclaredMethodsKey, SomeProject}
import org.opalj.ll.fpcf.analyses.ifds.{JNICallUtil, LLVMFunction}
import org.opalj.ll.llvm.value.constant.{ConstantDataArray, ConstantIntValue, ConstantStruct, GetElementPtrConst, PtrToIntConst}
import org.opalj.ll.llvm.value.{Argument, BinaryOperation, Call, GetElementPtr, GlobalAlias, GlobalVariable, IntToPtr, Load, Store, Value}
import org.opalj.log.{GlobalLogContext, LogContext, OPALLogger}

/**
 * Analysis that detects JNI calls and resolves the Java callee.
 *
 * @author Marc Clement
 * @author Nicolas Gross
 */
object JNICallDetectionAnalysis {
    private implicit val LogContext: LogContext = GlobalLogContext
    private val LogCategory = "JNI Call Detection"

    /**
     * Detects whether a call is a JNI call. If yes, the analysis tries to resolve the Java callee.
     *
     * @param call the call that should be analyzed.
     * @param project the corresponding project.
     * @return None if no JNI call could be resolved. Otherwise, a set of all possible Java callees is returned.
     *         If only the method could be resolved but not the class, the set might contain more than one callee if
     *         method name and signature are not unique.
     */
    def analyze(call: Call, project: SomeProject): Option[Set[Method]] = {
        implicit val declaredMethods: DeclaredMethods = project.get(DeclaredMethodsKey)

        resolveJNIFunction(call) match {
            case Some(Symbol("CallTypeMethod")) =>
                resolveMethodId(call.operand(2), false) match { // methodID is the third parameter
                    case None =>
                        OPALLogger.warn(LogCategory, s"native call might be JNI call but method could not be resolved: $call in ${call.function}")
                        None
                    case methods => methods
                }
            case Some(Symbol("CallStaticTypeMethod")) =>
                resolveMethodId(call.operand(2), true) match { // methodID is the third parameter
                    case None =>
                        OPALLogger.warn(LogCategory, s"native call might be JNI call but method could not be resolved: $call in ${call.function}")
                        None
                    case methods => methods
                }
            case _ => None
        }
    }

    private def resolveJNIFunction(call: Call): Option[Symbol] = {
        val loadFuncPtr: Load = call.calledValue match {
            case load: Load => load
            case itp: IntToPtr => itp.convVal match {
                case load: Load => load
                case _          => return None
            }
            case _ => return None
        }

        def matchJNIEnvIndex(index: Long): Option[Symbol] = index match {
            // https://docs.oracle.com/en/java/javase/19/docs/specs/jni/functions.html has the indices
            case 6                                     => Some(Symbol("FindClass"))
            case 31                                    => Some(Symbol("GetObjectClass"))
            case 33                                    => Some(Symbol("GetMethodId"))
            case index if index >= 34 && index <= 63   => Some(Symbol("CallTypeMethod")) // CallObjectMethod to CallVoidMethodA
            case 113                                   => Some(Symbol("GetStaticMethodId"))
            case index if index >= 114 && index <= 143 => Some(Symbol("CallStaticTypeMethod")) // CallStaticObjectMethod to CallStaticVoidMethodA
            case _                                     => None // unknown JNI function index or simply no JNI call
        }

        def matchBinOpOperand(operand: Value): Option[Symbol] = {
            operand match {
                case value: ConstantIntValue =>
                    val divisor = if (call.function.module.is64Bit) 8 else 4
                    matchJNIEnvIndex(value.signExtendedValue / divisor)
                case _ => None
            }
        }

        loadFuncPtr.src match {
            case gep: GetElementPtr if gep.isConstant => matchJNIEnvIndex(gep.constants.last)
            case itp: IntToPtr =>
                itp.convVal match {
                    case binOp: BinaryOperation => matchBinOpOperand(binOp.op2) match {
                        case None  => matchBinOpOperand(binOp.op1)
                        case index => index
                    }
                    case _ => None
                }
            case _ => None
        }
    }

    private def closestStoreToLoad(load: Load): Option[Store] = {
        val stores = load.src.users.filter(_.isInstanceOf[Store])
            .map(_.asInstanceOf[Store])
            .filter(load.allPrevious.contains(_))
        if (stores.nonEmpty) {
            Some(stores.reduce((s1, s2) => {
                if ((load.address - s1.address) < (load.address - s2.address)) s1
                else s2
            }))
        } else None
    }

    private def getOriginCall(value: Value): Option[Call] = value match {
        case call: Call => Some(call)
        case load: Load => closestStoreToLoad(load) match {
            case Some(store) => store.src match {
                case call: Call => Some(call)
                case _          => None
            }
            case None => None
        }
        case _ => None
    }

    private def resolveMethodId(methodId: Value, isStatic: Boolean)(implicit declaredMethods: DeclaredMethods): Option[Set[Method]] = {
        val getMethodIDCall = getOriginCall(methodId) match {
            case Some(call) => call
            case None       => return None
        }
        val jniFunction = resolveJNIFunction(getMethodIDCall)
        if (jniFunction.isEmpty || (!isStatic && jniFunction.get != Symbol("GetMethodId"))
            || (isStatic && jniFunction.get != Symbol("GetStaticMethodId"))) return None
        val clazz = resolveClass(getMethodIDCall.operand(1), LLVMFunction(getMethodIDCall.function), isStatic) match { // class is the second parameter
            case Some(clazz) if clazz.isEmpty => None // class name could not be recovered
            case Some(clazz)                  => Some(clazz) // class name was recovered
            case None                         => return None // seems not to be a JNI call
        }

        val name = resolveString(getMethodIDCall.operand(2)) // name is the third parameter
        val signature = resolveString(getMethodIDCall.operand(3)) // signature is the third parameter
        if (name.isEmpty || signature.isEmpty) return None // name or signature could not be recovered
        findJavaMethod(clazz, name.get, signature.get)
    }

    private def resolveString(name: Value): Option[String] = name match {
        case global: GlobalVariable => global.initializer match {
            case stringData: ConstantDataArray => Some(stringData.asString)
        }
        case pti: PtrToIntConst => pti.operand(0) match { // recover string from McSema chaos
            case alias: GlobalAlias => alias.aliasee match {
                case gep: GetElementPtrConst if gep.isConstant => gep.base match {
                    // gep constants:
                    // 0: mcSemaAllSegs index (always 0)
                    // 1: index of segment within mcSemaAllSegs
                    // 2: index of data array within segment
                    // 3: index of actual string within data array
                    case gv: GlobalVariable => gv.initializer match {
                        case mcsemaAllSegments: ConstantStruct => mcsemaAllSegments.getIndex(gep.constants(1).toInt) match {
                            case struct: ConstantStruct => struct.getIndex(gep.constants(2).toInt) match {
                                case data: ConstantDataArray => data.subSeqAsString(gep.constants(3).toInt)
                                case _                       => None
                            }
                            case _ => None
                        }
                        case _ => None
                    }
                    case _ => None
                }
                case _ => None
            }
            case _ => None
        }
        case _ => None
    }

    private def resolveClass(clazz: Value, function: LLVMFunction, isStatic: Boolean): Option[String] = getOriginCall(clazz) match {
        case Some(call) => resolveJNIFunction(call) match {
            case Some(Symbol("GetObjectClass")) =>
                JNICallUtil.resolveNativeMethodName(function) match {
                    // caller is JNI function (detect by function name) and class is taken from callers second arg (this reference):
                    case Some(ident) if resolveValueIsSecondArg(call.operand(1)) => Some(ident._1)
                    // caller is no JNI function or class cannot be resolved to callers second arg:
                    case _ => Some("")
                }
            case Some(Symbol("FindClass")) => resolveString(call.operand(1))
            case _                         => None // seems to be no JNI call
        }
        case None if isStatic => JNICallUtil.resolveNativeMethodName(function) match {
            // caller is JNI function (detect by function name) and class is taken from callers second arg (class reference in static call):
            case Some(ident) if resolveValueIsSecondArg(clazz) => Some(ident._1)
            // caller is no JNI function or class cannot be resolved to callers second arg:
            case _                                             => Some("")
        }
        case None => Some("") // could still be a JNI call, class object might have other origin, e.g. function parameter
    }

    private def resolveValueIsSecondArg(obj: Value): Boolean = obj match {
        // in compiled LLVM IR, obj could be tracked to the function's args
        // not trivially possible in McSema lifted code, where args are passed via state struct
        case arg: Argument if arg.index == 1 => true
        case load: Load => closestStoreToLoad(load) match {
            case Some(store) => store.src match {
                case arg: Argument if arg.index == 1 => true
                case _                               => false
            }
            case None => false
        }
        case _ => false
    }

    private def findJavaMethod(classFqn: Option[String], methodName: String, signature: String)(implicit declaredMethods: DeclaredMethods): Option[Set[Method]] = {
        val foundMethods = declaredMethods.declaredMethods.filter(declaredMethod => {
            val classType = declaredMethod.declaringClassType
            ((classFqn.isDefined && classType.fqn == classFqn.get) || classFqn.isEmpty) &&
                declaredMethod.name == methodName &&
                declaredMethod.descriptor.toJVMDescriptor == signature
        }).map(_.definedMethod).toSet
        if (foundMethods.isEmpty) None
        else Some(foundMethods) // multiple methods might be found if class fqn could not be recovered and name + signature are not unique
    }
}