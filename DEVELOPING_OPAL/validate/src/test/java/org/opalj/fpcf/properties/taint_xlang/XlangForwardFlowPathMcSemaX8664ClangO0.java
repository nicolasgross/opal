/* BSD 2-Clause License - see OPAL/LICENSE for details. */
package org.opalj.fpcf.properties.taint_xlang;

import org.opalj.fpcf.properties.PropertyValidator;

import java.lang.annotation.*;

@PropertyValidator(key = XlangForwardFlowPathMcSemaX8664ClangO0.PROPERTY_VALIDATOR_KEY, validator = XlangForwardFlowPathMatcher.class)
@Target(ElementType.METHOD)
@Documented
@Retention(RetentionPolicy.CLASS)
public @interface XlangForwardFlowPathMcSemaX8664ClangO0 {

    String PROPERTY_VALIDATOR_KEY = "XlangForwardFlowPathMcSemaX8664ClangO0";

    String[] value();
}
