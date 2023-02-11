/* BSD 2-Clause License - see OPAL/LICENSE for details. */
package org.opalj.fpcf.properties.taint_xlang;

import org.opalj.fpcf.properties.PropertyValidator;

import java.lang.annotation.*;

@PropertyValidator(key = XlangMcSemaX8664ForwardFlowPath.PROPERTY_VALIDATOR_KEY, validator = XlangForwardFlowPathMatcher.class)
@Target(ElementType.METHOD)
@Documented
@Retention(RetentionPolicy.CLASS)
public @interface XlangMcSemaX8664ForwardFlowPath {

    String PROPERTY_VALIDATOR_KEY = "XlangMcSemaX8664ForwardFlowPath";

    String[] value();
}
