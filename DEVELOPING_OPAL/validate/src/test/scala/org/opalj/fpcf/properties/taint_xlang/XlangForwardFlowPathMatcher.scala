/* BSD 2-Clause License - see OPAL/LICENSE for details. */
package org.opalj.fpcf.properties.taint_xlang

import org.opalj.fpcf.properties.taint.AbstractForwardFlowPathMatcher
import org.opalj.ll.fpcf.analyses.ifds.taint.JavaForwardTaintAnalysisScheduler

class XlangForwardFlowPathMatcher extends AbstractForwardFlowPathMatcher(JavaForwardTaintAnalysisScheduler.property.key)