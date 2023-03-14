/* BSD 2-Clause License - see OPAL/LICENSE for details. */
package org.opalj.fpcf.properties.taint_xlang;

import org.opalj.fpcf.properties.PropertyValidator;

import java.lang.annotation.*;

@PropertyValidator(key = XlangForwardFlowPathMcSemaAarch64ClangO2.PROPERTY_VALIDATOR_KEY, validator = XlangForwardFlowPathMatcher.class)
@Target(ElementType.METHOD)
@Documented
@Retention(RetentionPolicy.CLASS)
public @interface XlangForwardFlowPathMcSemaAarch64ClangO2 {

    String PROPERTY_VALIDATOR_KEY = "XlangForwardFlowPathMcSemaAarch64ClangO2";

    String[] value();
}
