/* BSD 2-Clause License - see OPAL/LICENSE for details. */
package org.opalj.fpcf.properties.taint_xlang;

import org.opalj.fpcf.properties.PropertyValidator;

import java.lang.annotation.*;

@PropertyValidator(key = XlangForwardFlowPath.PROPERTY_VALIDATOR_KEY, validator = XlangForwardFlowPathMatcher.class)
@Target(ElementType.METHOD)
@Documented
@Retention(RetentionPolicy.CLASS)
public @interface XlangForwardFlowPath {

    String PROPERTY_VALIDATOR_KEY = "XlangForwardFlowPath";

    String[] value();
}
