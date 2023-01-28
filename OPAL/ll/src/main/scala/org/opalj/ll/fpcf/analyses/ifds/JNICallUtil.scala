/* BSD 2-Clause License - see OPAL/LICENSE for details. */
package org.opalj.ll.fpcf.analyses.ifds

import org.opalj.br.Method

object JNICallUtil {

    /**
     * Converts a Java parameter index (param 0 == this if non-static) to the respective index
     * in a JNICall of this method.
     *
     * @param index the Java parameter index.
     * @param isStatic whether the Java method is static.
     * @return the respective native parameter index in the JNICall.
     */
    def javaParamIndexToNative(index: Int, isStatic: Boolean): Int = {
        // JNI call args if static: JNIEnv, class, method, arg 0, arg 1, ...
        // JNI call args if non-static: JNIEnv, this, method, arg 0, arg 1, ...
        if (isStatic) {
            // static call, tainted arg
            index + 3
        } else if (index == 0) {
            // non-static call, tainted this
            1
        } else {
            // non-static call, tainted arg
            index + 2
        }
    }

    /**
     * Converts a native JNI function parameter index to a Java parameter index (arg 0 == this if non-static).
     *
     * @param index the native JNICall parameter index.
     * @param isStatic whether the Java method is static.
     * @return the respective Java parameter index.
     */
    def nativeParamIndexToJava(index: Int, isStatic: Boolean): Int = {
        // JNI function args if static: JNIEnv, arg 0, arg 1, ...
        // JNI function args if non-static: JNIEnv, this, arg 0, arg 1, ...
        index - 1
    }

    /**
     * Resolves a Java native method name to the actual function name in the .so file.
     *
     * https://docs.oracle.com/en/java/javase/13/docs/specs/jni/design.html#resolving-native-method-names
     *
     * @param nativeMethod the 'native' tagged Java method.
     * @return the resolved function name.
     */
    def resolveNativeFunctionName(nativeMethod: Method): String = {
        val calleeName = nativeMethod.name.map {
            case c if isAlphaNumeric(c) => c
            case '_'                    => "_1"
            case ';'                    => "_2"
            case '['                    => "_3"
            case c                      => s"_${c.toInt.toHexString.reverse.padTo(4, '0').reverse}"
        }.mkString
        val classFile = nativeMethod.classFile.fqn
            .replace("_", "_1")
            .replace('/', '_')
        "Java_"+classFile+"_"+calleeName
    }

    /**
     * Resolves a native function to the class and method name of the corresponding Java companion method.
     *
     * @param nativeFunction the native function from the .so file.
     * @return A tuple (fqn, method name) if function has native Java companion, otherwise None.
     */
    def resolveNativeMethodName(nativeFunction: LLVMFunction): Option[(String, String)] = {
        if (!nativeFunction.name.startsWith("Java_")) return None
        val nameWithoutJava = nativeFunction.name.substring(5)

        // split class name and method name
        var lastCharWasDigit = true
        var methodNameIndex = -1
        val iterator = nameWithoutJava.zipWithIndex.reverseIterator
        while (methodNameIndex == -1 && iterator.hasNext) {
            val (c, i) = iterator.next()
            if (!lastCharWasDigit && c == '_') methodNameIndex = i
            if (c >= '0' && c <= '9') lastCharWasDigit = true
            else lastCharWasDigit = false
        }
        val parts = nameWithoutJava.splitAt(methodNameIndex)

        // decode class name
        val fqnDecoded = "_([^0-9])".r
            .replaceAllIn(parts._1, m => "/"+m.group(1))
            .replace("_1", "_")

        // decode method name
        val tmpMethodDecoded = parts._2.substring(1)
            .replace("_1", "_")
            .replace("_2", ";")
            .replace("_3", "[")
        val regexHexEnc = "_([0-9A-Fa-f]{4})".r
        val methodDecoded = regexHexEnc
            .replaceAllIn(tmpMethodDecoded, m => Integer.parseInt(m.group(1), 16).toChar.toString)

        Some((fqnDecoded, methodDecoded))
    }

    private def isAlphaNumeric(char: Char): Boolean = {
        char >= 'a' && char <= 'z' || char >= 'A' && char <= 'Z' || char >= '0' && char <= '9'
    }
}
