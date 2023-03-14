/* BSD 2-Clause License - see OPAL/LICENSE for details. */
package org.opalj.fpcf.fixtures.taint_xlang;

import org.opalj.fpcf.properties.taint_xlang.*;

/**
 * Add VM argument to run main: -Djava.library.path=DEVELOPING_OPAL/validate/src/test/resources/llvm/cross_language/taint/x86_64
 */
public class TaintTest {
        private static native int sum (int a, int b);
        private native int propagate_source ();
        private native int propagate_sanitize (int a);
        private native int propagate_sink (int a);
        private native int sanitize_only_a_into_sink (int a, int b);
        private native void propagate_identity_to_sink(int a);
        private native void propagate_zero_to_sink(int a);
        private native void native_array_tainted();
        private native void native_array_untainted();
        private native void propagate_to_java_sink(int a);
        private static native void propagate_to_java_static_sink(int a);
        private native int propagate_from_java_source();
        private native int propagate_from_java_source(int a);
        private native int propagate_from_java_source(String s);
        private native int propagate_java_sanitize(int a);
        static
        {
            System.loadLibrary ("tainttest_clang_O0");
        }
        public static void main (String[] args)
        {
            TaintTest demo = new TaintTest();
            // force call graph analysis of indirect methods
            // otherwise their callees are not analyzed,
            // as they are only reachable through native code
            // TODO: trigger cga from within other analysis
            demo.indirect_sink(demo.indirect_sanitize(demo.indirect_source()));

            demo.test_java_flow();
            demo.test_java_sanitize_no_flow();
            demo.test_java_untainted_no_flow();
            demo.test_native_sum_flow();
            demo.test_native_to_java_to_native_flow();
            demo.test_native_to_java_to_native_sanitized_no_flow();
            demo.test_native_indirect_sanitized_no_flow();
            demo.test_native_indirect_flow();
            demo.test_native_identity_flow();
            demo.test_native_zero_no_flow();
            demo.test_native_array_tainted_flow();
            demo.test_native_array_untainted_no_flow();
            demo.test_native_call_java_sink_flow();
            demo.test_native_call_java_static_sink_flow();
            demo.test_native_call_java_overloaded_source_flow();
            demo.test_native_call_java_overloaded_source_no_flow_1();
            demo.test_native_call_java_overloaded_source_no_flow_2();
            demo.test_native_call_java_sanitize_no_flow();
            System.out.println("done");
        }

        @XlangForwardFlowPath({"test_java_flow", "sink"})
        @XlangForwardFlowPathMcSemaX8664ClangO0({"test_java_flow", "sink"})
        @XlangForwardFlowPathMcSemaX8664ClangO2({"test_java_flow", "sink"})
        @XlangForwardFlowPathMcSemaAarch64ClangO0({"test_java_flow", "sink"})
        @XlangBackwardFlowPath({"test_java_flow", "sink"})
        @XlangBackwardFlowPathMcSemaX8664ClangO0({"test_java_flow", "sink"})
        @XlangBackwardFlowPathMcSemaX8664ClangO2({"test_java_flow", "sink"})
        @XlangBackwardFlowPathMcSemaAarch64ClangO0({"test_java_flow", "sink"})
        public void test_java_flow() {
            System.out.println("java");
            int tainted = source();
            sink(tainted);
        }

        @XlangForwardFlowPath({})
        @XlangForwardFlowPathMcSemaX8664ClangO0({})
        @XlangForwardFlowPathMcSemaX8664ClangO2({})
        @XlangForwardFlowPathMcSemaAarch64ClangO0({})
        @XlangBackwardFlowPath({})
        @XlangBackwardFlowPathMcSemaX8664ClangO0({})
        @XlangBackwardFlowPathMcSemaX8664ClangO2({})
        @XlangBackwardFlowPathMcSemaAarch64ClangO0({})
        public void test_java_sanitize_no_flow() {
            System.out.println("java sanitize");
            int tainted = source();
            sink(sanitize(tainted));
        }

        @XlangForwardFlowPath({})
        @XlangForwardFlowPathMcSemaX8664ClangO0({})
        @XlangForwardFlowPathMcSemaX8664ClangO2({})
        @XlangForwardFlowPathMcSemaAarch64ClangO0({})
        @XlangBackwardFlowPath({})
        @XlangBackwardFlowPathMcSemaX8664ClangO0({})
        @XlangBackwardFlowPathMcSemaX8664ClangO2({})
        @XlangBackwardFlowPathMcSemaAarch64ClangO0({})
        public void test_java_untainted_no_flow() {
            System.out.println("java untainted");
            int untainted = 23;
            sink(untainted);
        }

        @XlangForwardFlowPath({"test_native_sum_flow", "sink"})
        @XlangForwardFlowPathMcSemaX8664ClangO0({"test_native_sum_flow", "sink"})
        @XlangForwardFlowPathMcSemaX8664ClangO2({"test_native_sum_flow", "sink"})
        @XlangForwardFlowPathMcSemaAarch64ClangO0({"test_native_sum_flow", "sink"})
        @XlangBackwardFlowPath({"test_native_sum_flow", "sink"})
        @XlangBackwardFlowPathMcSemaX8664ClangO0({"test_native_sum_flow", "sink"})
        @XlangBackwardFlowPathMcSemaX8664ClangO2({"test_native_sum_flow", "sink"})
        @XlangBackwardFlowPathMcSemaAarch64ClangO0({"test_native_sum_flow", "sink"})
        public void test_native_sum_flow() {
            System.out.println("native sum");
            int tainted = source();
            int untainted = 23;
            int native_tainted = sum(tainted, untainted);
            sink(native_tainted);
        }

        @XlangForwardFlowPath({"test_native_to_java_to_native_flow", "Java_org_opalj_fpcf_fixtures_taint_1xlang_TaintTest_propagate_1sink", "sink"})
        @XlangForwardFlowPathMcSemaX8664ClangO0({"test_native_to_java_to_native_flow", "Java_org_opalj_fpcf_fixtures_taint_1xlang_TaintTest_propagate_1sink", "sub_1ff01210_Java_org_opalj_fpcf_fixtures_taint_1xlang_TaintTest_propagate_1sink", "sub_1ff01060__sink"})
        @XlangForwardFlowPathMcSemaX8664ClangO2({"test_native_to_java_to_native_flow", "Java_org_opalj_fpcf_fixtures_taint_1xlang_TaintTest_propagate_1sink", "sub_1ff011b0_Java_org_opalj_fpcf_fixtures_taint_1xlang_TaintTest_propagate_1sink", "sub_1ff01050__sink"})
        @XlangForwardFlowPathMcSemaAarch64ClangO0({"test_native_to_java_to_native_flow", "Java_org_opalj_fpcf_fixtures_taint_1xlang_TaintTest_propagate_1sink", "sub_1ff00d98_Java_org_opalj_fpcf_fixtures_taint_1xlang_TaintTest_propagate_1sink", "sub_1ff00bd0__sink"})
        @XlangBackwardFlowPath({"test_native_to_java_to_native_flow", "Java_org_opalj_fpcf_fixtures_taint_1xlang_TaintTest_propagate_1sink", "sink"})
        @XlangBackwardFlowPathMcSemaX8664ClangO0({"test_native_to_java_to_native_flow", "Java_org_opalj_fpcf_fixtures_taint_1xlang_TaintTest_propagate_1sink", "sub_1ff01210_Java_org_opalj_fpcf_fixtures_taint_1xlang_TaintTest_propagate_1sink", "sub_1ff01060__sink"})
        @XlangBackwardFlowPathMcSemaX8664ClangO2({"test_native_to_java_to_native_flow", "Java_org_opalj_fpcf_fixtures_taint_1xlang_TaintTest_propagate_1sink", "sub_1ff011b0_Java_org_opalj_fpcf_fixtures_taint_1xlang_TaintTest_propagate_1sink", "sub_1ff01050__sink"})
        @XlangBackwardFlowPathMcSemaAarch64ClangO0({"test_native_to_java_to_native_flow", "Java_org_opalj_fpcf_fixtures_taint_1xlang_TaintTest_propagate_1sink", "sub_1ff00d98_Java_org_opalj_fpcf_fixtures_taint_1xlang_TaintTest_propagate_1sink", "sub_1ff00bd0__sink"})
        public void test_native_to_java_to_native_flow() {
            System.out.println("native to java to native");
            int taint = propagate_source();
            propagate_sink(taint);
        }

        @XlangForwardFlowPath({})
        @XlangForwardFlowPathMcSemaX8664ClangO0({})
        @XlangForwardFlowPathMcSemaX8664ClangO2({})
        @XlangForwardFlowPathMcSemaAarch64ClangO0({})
        @XlangBackwardFlowPath({})
        @XlangBackwardFlowPathMcSemaX8664ClangO0({})
        @XlangBackwardFlowPathMcSemaX8664ClangO2({})
        @XlangBackwardFlowPathMcSemaAarch64ClangO0({})
        public void test_native_to_java_to_native_sanitized_no_flow() {
            System.out.println("native to java to native sanitized");
            propagate_sink(propagate_sanitize(propagate_source()));
        }

        @XlangForwardFlowPath({})
        @XlangForwardFlowPathMcSemaX8664ClangO0({})
        @XlangForwardFlowPathMcSemaX8664ClangO2({})
        @XlangForwardFlowPathMcSemaAarch64ClangO0({})
        @XlangBackwardFlowPath({})
        @XlangBackwardFlowPathMcSemaX8664ClangO0({})
        @XlangBackwardFlowPathMcSemaX8664ClangO2({})
        @XlangBackwardFlowPathMcSemaAarch64ClangO0({})
        public void test_native_indirect_sanitized_no_flow() {
            System.out.println("native indirect sanitized");
            int tainted = source();
            int untainted = 23;
            sink(sanitize_only_a_into_sink(tainted, untainted));
        }

        @XlangForwardFlowPath({"test_native_indirect_flow", "sink"})
        @XlangForwardFlowPathMcSemaX8664ClangO0({"test_native_indirect_flow", "sink"})
        @XlangForwardFlowPathMcSemaX8664ClangO2({"test_native_indirect_flow", "sink"})
        @XlangForwardFlowPathMcSemaAarch64ClangO0({"test_native_indirect_flow", "sink"})
        @XlangBackwardFlowPath({"test_native_indirect_flow", "sink"})
        @XlangBackwardFlowPathMcSemaX8664ClangO0({"test_native_indirect_flow", "sink"})
        @XlangBackwardFlowPathMcSemaX8664ClangO2({"test_native_indirect_flow", "sink"})
        @XlangBackwardFlowPathMcSemaAarch64ClangO0({"test_native_indirect_flow", "sink"})
        public void test_native_indirect_flow() {
            System.out.println("native indirect");
            int tainted = source();
            int untainted = 23;
            sink(sanitize_only_a_into_sink(untainted, tainted));
        }

        @XlangForwardFlowPath({"test_native_identity_flow", "Java_org_opalj_fpcf_fixtures_taint_1xlang_TaintTest_propagate_1identity_1to_1sink", "sink"})
        @XlangForwardFlowPathMcSemaX8664ClangO0({"test_native_identity_flow", "Java_org_opalj_fpcf_fixtures_taint_1xlang_TaintTest_propagate_1identity_1to_1sink", "sub_1ff012b0_Java_org_opalj_fpcf_fixtures_taint_1xlang_TaintTest_propagate_1identity_1to_1sink", "sub_1ff01060__sink"})
        @XlangForwardFlowPathMcSemaX8664ClangO2({"test_native_identity_flow", "Java_org_opalj_fpcf_fixtures_taint_1xlang_TaintTest_propagate_1identity_1to_1sink", "sub_1ff01200_Java_org_opalj_fpcf_fixtures_taint_1xlang_TaintTest_propagate_1identity_1to_1sink", "sub_1ff01050__sink"})
        @XlangForwardFlowPathMcSemaAarch64ClangO0({"test_native_identity_flow", "Java_org_opalj_fpcf_fixtures_taint_1xlang_TaintTest_propagate_1identity_1to_1sink", "sub_1ff00e3c_Java_org_opalj_fpcf_fixtures_taint_1xlang_TaintTest_propagate_1identity_1to_1sink", "sub_1ff00bd0__sink"})
        @XlangBackwardFlowPath({"test_native_identity_flow", "Java_org_opalj_fpcf_fixtures_taint_1xlang_TaintTest_propagate_1identity_1to_1sink", "sink"})
        @XlangBackwardFlowPathMcSemaX8664ClangO0({"test_native_identity_flow", "Java_org_opalj_fpcf_fixtures_taint_1xlang_TaintTest_propagate_1identity_1to_1sink", "sub_1ff012b0_Java_org_opalj_fpcf_fixtures_taint_1xlang_TaintTest_propagate_1identity_1to_1sink", "sub_1ff01060__sink"})
        @XlangBackwardFlowPathMcSemaX8664ClangO2({"test_native_identity_flow", "Java_org_opalj_fpcf_fixtures_taint_1xlang_TaintTest_propagate_1identity_1to_1sink", "sub_1ff01200_Java_org_opalj_fpcf_fixtures_taint_1xlang_TaintTest_propagate_1identity_1to_1sink", "sub_1ff01050__sink"})
        @XlangBackwardFlowPathMcSemaAarch64ClangO0({"test_native_identity_flow", "Java_org_opalj_fpcf_fixtures_taint_1xlang_TaintTest_propagate_1identity_1to_1sink", "sub_1ff00e3c_Java_org_opalj_fpcf_fixtures_taint_1xlang_TaintTest_propagate_1identity_1to_1sink", "sub_1ff00bd0__sink"})
        public void test_native_identity_flow() {
            System.out.println("native identity");
            propagate_identity_to_sink(source());
        }

        @XlangForwardFlowPath({})
        @XlangForwardFlowPathMcSemaX8664ClangO0({})
        @XlangForwardFlowPathMcSemaX8664ClangO2({})
        @XlangForwardFlowPathMcSemaAarch64ClangO0({})
        @XlangBackwardFlowPath({})
        @XlangBackwardFlowPathMcSemaX8664ClangO0({})
        @XlangBackwardFlowPathMcSemaX8664ClangO2({})
        @XlangBackwardFlowPathMcSemaAarch64ClangO0({})
        public void test_native_zero_no_flow() {
            System.out.println("native zero");
            propagate_zero_to_sink(source());
        }

        @XlangForwardFlowPath({"test_native_array_tainted_flow", "Java_org_opalj_fpcf_fixtures_taint_1xlang_TaintTest_native_1array_1tainted", "sink"})
        @XlangForwardFlowPathMcSemaX8664ClangO0({"test_native_array_tainted_flow", "Java_org_opalj_fpcf_fixtures_taint_1xlang_TaintTest_native_1array_1tainted", "sub_1ff01330_Java_org_opalj_fpcf_fixtures_taint_1xlang_TaintTest_native_1array_1tainted", "sub_1ff01060__sink"})
        @XlangForwardFlowPathMcSemaX8664ClangO2({"test_native_array_tainted_flow", "Java_org_opalj_fpcf_fixtures_taint_1xlang_TaintTest_native_1array_1tainted", "sub_1ff01240_Java_org_opalj_fpcf_fixtures_taint_1xlang_TaintTest_native_1array_1tainted", "sub_1ff01050__sink"})
        @XlangForwardFlowPathMcSemaAarch64ClangO0({"test_native_array_tainted_flow", "Java_org_opalj_fpcf_fixtures_taint_1xlang_TaintTest_native_1array_1tainted", "sub_1ff00ed4_Java_org_opalj_fpcf_fixtures_taint_1xlang_TaintTest_native_1array_1tainted", "sub_1ff00bd0__sink"})
        @XlangBackwardFlowPath({"test_native_array_tainted_flow", "Java_org_opalj_fpcf_fixtures_taint_1xlang_TaintTest_native_1array_1tainted", "sink"})
        @XlangBackwardFlowPathMcSemaX8664ClangO0({"test_native_array_tainted_flow", "Java_org_opalj_fpcf_fixtures_taint_1xlang_TaintTest_native_1array_1tainted", "sub_1ff01330_Java_org_opalj_fpcf_fixtures_taint_1xlang_TaintTest_native_1array_1tainted", "sub_1ff01060__sink"})
        @XlangBackwardFlowPathMcSemaX8664ClangO2({"test_native_array_tainted_flow", "Java_org_opalj_fpcf_fixtures_taint_1xlang_TaintTest_native_1array_1tainted", "sub_1ff01240_Java_org_opalj_fpcf_fixtures_taint_1xlang_TaintTest_native_1array_1tainted", "sub_1ff01050__sink"})
        @XlangBackwardFlowPathMcSemaAarch64ClangO0({"test_native_array_tainted_flow", "Java_org_opalj_fpcf_fixtures_taint_1xlang_TaintTest_native_1array_1tainted", "sub_1ff00ed4_Java_org_opalj_fpcf_fixtures_taint_1xlang_TaintTest_native_1array_1tainted", "sub_1ff00bd0__sink"})
        public void test_native_array_tainted_flow() {
            System.out.println("native array tainted");
            native_array_tainted();
        }

        @XlangForwardFlowPath({})
        @XlangForwardFlowPathMcSemaX8664ClangO0({})
        @XlangForwardFlowPathMcSemaX8664ClangO2({})
        @XlangForwardFlowPathMcSemaAarch64ClangO0({})
        @XlangBackwardFlowPath({})
        @XlangBackwardFlowPathMcSemaX8664ClangO0({})
        @XlangBackwardFlowPathMcSemaX8664ClangO2({})
        @XlangBackwardFlowPathMcSemaAarch64ClangO0({})
        public void test_native_array_untainted_no_flow() {
            System.out.println("native array untainted");
            native_array_untainted();
        }

        @XlangForwardFlowPath({"test_native_call_java_sink_flow", "Java_org_opalj_fpcf_fixtures_taint_1xlang_TaintTest_propagate_1to_1java_1sink", "indirect_sink", "sink"})
        @XlangForwardFlowPathMcSemaX8664ClangO0({"test_native_call_java_sink_flow", "Java_org_opalj_fpcf_fixtures_taint_1xlang_TaintTest_propagate_1to_1java_1sink", "sub_1ff013b0_Java_org_opalj_fpcf_fixtures_taint_1xlang_TaintTest_propagate_1to_1java_1sink", "indirect_sink", "sink"})
        @XlangForwardFlowPathMcSemaX8664ClangO2({"test_native_call_java_sink_flow", "Java_org_opalj_fpcf_fixtures_taint_1xlang_TaintTest_propagate_1to_1java_1sink", "sub_1ff01280_Java_org_opalj_fpcf_fixtures_taint_1xlang_TaintTest_propagate_1to_1java_1sink", "indirect_sink", "sink"})
        @XlangForwardFlowPathMcSemaAarch64ClangO0({"test_native_call_java_sink_flow", "Java_org_opalj_fpcf_fixtures_taint_1xlang_TaintTest_propagate_1to_1java_1sink", "sub_1ff00f3c_Java_org_opalj_fpcf_fixtures_taint_1xlang_TaintTest_propagate_1to_1java_1sink", "indirect_sink", "sink"})
        @XlangBackwardFlowPath({"test_native_call_java_sink_flow", "Java_org_opalj_fpcf_fixtures_taint_1xlang_TaintTest_propagate_1to_1java_1sink", "indirect_sink", "sink"})
        @XlangBackwardFlowPathMcSemaX8664ClangO0({"test_native_call_java_sink_flow", "Java_org_opalj_fpcf_fixtures_taint_1xlang_TaintTest_propagate_1to_1java_1sink", "sub_1ff013b0_Java_org_opalj_fpcf_fixtures_taint_1xlang_TaintTest_propagate_1to_1java_1sink", "indirect_sink", "sink"})
        @XlangBackwardFlowPathMcSemaX8664ClangO2({"test_native_call_java_sink_flow", "Java_org_opalj_fpcf_fixtures_taint_1xlang_TaintTest_propagate_1to_1java_1sink", "sub_1ff01280_Java_org_opalj_fpcf_fixtures_taint_1xlang_TaintTest_propagate_1to_1java_1sink", "indirect_sink", "sink"})
        @XlangBackwardFlowPathMcSemaAarch64ClangO0({"test_native_call_java_sink_flow", "Java_org_opalj_fpcf_fixtures_taint_1xlang_TaintTest_propagate_1to_1java_1sink", "sub_1ff00f3c_Java_org_opalj_fpcf_fixtures_taint_1xlang_TaintTest_propagate_1to_1java_1sink", "indirect_sink", "sink"})
        public void test_native_call_java_sink_flow() {
            System.out.println("native call java sink");
            propagate_to_java_sink(source());
        }

        @XlangForwardFlowPath({"test_native_call_java_static_sink_flow", "Java_org_opalj_fpcf_fixtures_taint_1xlang_TaintTest_propagate_1to_1java_1static_1sink", "sink"})
        @XlangForwardFlowPathMcSemaX8664ClangO0({"test_native_call_java_static_sink_flow", "Java_org_opalj_fpcf_fixtures_taint_1xlang_TaintTest_propagate_1to_1java_1static_1sink", "sub_1ff01440_Java_org_opalj_fpcf_fixtures_taint_1xlang_TaintTest_propagate_1to_1java_1static_1sink", "sink"})
        @XlangForwardFlowPathMcSemaX8664ClangO2({"test_native_call_java_static_sink_flow", "Java_org_opalj_fpcf_fixtures_taint_1xlang_TaintTest_propagate_1to_1java_1static_1sink", "sub_1ff012e0_Java_org_opalj_fpcf_fixtures_taint_1xlang_TaintTest_propagate_1to_1java_1static_1sink", "sink"})
        @XlangForwardFlowPathMcSemaAarch64ClangO0({"test_native_call_java_static_sink_flow", "Java_org_opalj_fpcf_fixtures_taint_1xlang_TaintTest_propagate_1to_1java_1static_1sink", "sub_1ff00f3c_Java_org_opalj_fpcf_fixtures_taint_1xlang_TaintTest_propagate_1to_1java_1static_1sink", "sink"})
        @XlangBackwardFlowPath({"test_native_call_java_static_sink_flow", "Java_org_opalj_fpcf_fixtures_taint_1xlang_TaintTest_propagate_1to_1java_1static_1sink", "sink"})
        @XlangBackwardFlowPathMcSemaX8664ClangO0({"test_native_call_java_static_sink_flow", "Java_org_opalj_fpcf_fixtures_taint_1xlang_TaintTest_propagate_1to_1java_1static_1sink", "sub_1ff01440_Java_org_opalj_fpcf_fixtures_taint_1xlang_TaintTest_propagate_1to_1java_1static_1sink", "sink"})
        @XlangBackwardFlowPathMcSemaX8664ClangO2({"test_native_call_java_static_sink_flow", "Java_org_opalj_fpcf_fixtures_taint_1xlang_TaintTest_propagate_1to_1java_1static_1sink", "sub_1ff012e0_Java_org_opalj_fpcf_fixtures_taint_1xlang_TaintTest_propagate_1to_1java_1static_1sink", "sink"})
        @XlangBackwardFlowPathMcSemaAarch64ClangO0({"test_native_call_java_static_sink_flow", "Java_org_opalj_fpcf_fixtures_taint_1xlang_TaintTest_propagate_1to_1java_1static_1sink", "sub_1ff00f3c_Java_org_opalj_fpcf_fixtures_taint_1xlang_TaintTest_propagate_1to_1java_1static_1sink", "sink"})
        public void test_native_call_java_static_sink_flow() {
            System.out.println("native call java static sink");
            propagate_to_java_static_sink(source());
        }

        @XlangForwardFlowPath({"test_native_call_java_overloaded_source_flow", "sink"})
        @XlangForwardFlowPathMcSemaX8664ClangO0({"test_native_call_java_overloaded_source_flow", "sink"})
        @XlangForwardFlowPathMcSemaX8664ClangO2({"test_native_call_java_overloaded_source_flow", "sink"})
        @XlangForwardFlowPathMcSemaAarch64ClangO0({"test_native_call_java_overloaded_source_flow", "sink"})
        @XlangBackwardFlowPath({"test_native_call_java_overloaded_source_flow", "sink"})
        @XlangBackwardFlowPathMcSemaX8664ClangO0({"test_native_call_java_overloaded_source_flow", "sink"})
        @XlangBackwardFlowPathMcSemaX8664ClangO2({"test_native_call_java_overloaded_source_flow", "sink"})
        @XlangBackwardFlowPathMcSemaAarch64ClangO0({"test_native_call_java_overloaded_source_flow", "sink"})
        public void test_native_call_java_overloaded_source_flow() {
            System.out.println("native call overloaded java source no params");
            sink(propagate_from_java_source());
        }

        @XlangForwardFlowPath({})
        @XlangForwardFlowPathMcSemaX8664ClangO0({})
        @XlangForwardFlowPathMcSemaX8664ClangO2({})
        @XlangForwardFlowPathMcSemaAarch64ClangO0({})
        @XlangBackwardFlowPath({})
        @XlangBackwardFlowPathMcSemaX8664ClangO0({})
        @XlangBackwardFlowPathMcSemaX8664ClangO2({})
        @XlangBackwardFlowPathMcSemaAarch64ClangO0({})
        public void test_native_call_java_overloaded_source_no_flow_1() {
            System.out.println("native call overloaded java source int param");
            sink(propagate_from_java_source(42));
        }

        @XlangForwardFlowPath({})
        @XlangForwardFlowPathMcSemaX8664ClangO0({})
        @XlangForwardFlowPathMcSemaX8664ClangO2({})
        @XlangForwardFlowPathMcSemaAarch64ClangO0({})
        @XlangBackwardFlowPath({})
        @XlangBackwardFlowPathMcSemaX8664ClangO0({})
        @XlangBackwardFlowPathMcSemaX8664ClangO2({})
        @XlangBackwardFlowPathMcSemaAarch64ClangO0({})
        public void test_native_call_java_overloaded_source_no_flow_2() {
            System.out.println("native call overloaded java source string param");
            sink(propagate_from_java_source("test"));
        }

        @XlangForwardFlowPath({})
        @XlangForwardFlowPathMcSemaX8664ClangO0({})
        @XlangForwardFlowPathMcSemaX8664ClangO2({})
        @XlangForwardFlowPathMcSemaAarch64ClangO0({})
        @XlangBackwardFlowPath({})
        @XlangBackwardFlowPathMcSemaX8664ClangO0({})
        @XlangBackwardFlowPathMcSemaX8664ClangO2({})
        @XlangBackwardFlowPathMcSemaAarch64ClangO0({})
        public void test_native_call_java_sanitize_no_flow() {
            System.out.println("native call java sanitize");
            sink(propagate_java_sanitize(source()));
        }

        public int indirect_source() {
            return source();
        }

        public void indirect_sink(int a) {
            sink(a);
        }

        public int indirect_sanitize(int a) {
            return sanitize(a);
        }
        
        private static int source()
        {
            return 42;
        }
        
        private static void sink(int a) {
            System.out.println("java " + a);
        }
        
        private static int sanitize(int a)
        {
            return a - 19;
        }
}
