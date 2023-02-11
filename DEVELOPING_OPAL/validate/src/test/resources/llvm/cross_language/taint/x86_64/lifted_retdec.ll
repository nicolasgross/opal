source_filename = "test"
target datalayout = "e-m:e-p:64:64-i64:64-f80:128-n8:16:32:64-S128"

@global_var_4008 = local_unnamed_addr global i64 0
@global_var_4058 = global i64 0
@global_var_3ff8 = local_unnamed_addr global i64 0
@global_var_203e = constant [11 x i8] c"native %d\0A\00"
@global_var_2000 = local_unnamed_addr constant [14 x i8] c"indirect_sink\00"
@global_var_200e = local_unnamed_addr constant [5 x i8] c"(I)V\00"
@global_var_2013 = local_unnamed_addr constant [16 x i8] c"indirect_source\00"
@global_var_2023 = local_unnamed_addr constant [4 x i8] c"()I\00"
@global_var_2027 = local_unnamed_addr constant [18 x i8] c"indirect_sanitize\00"
@global_var_2039 = local_unnamed_addr constant [5 x i8] c"(I)I\00"
@0 = external global i32

define i64 @_init() local_unnamed_addr {
dec_label_pc_1000:
  %rax.0.reg2mem = alloca i64, !insn.addr !0
  %0 = load i64, i64* inttoptr (i64 16360 to i64*), align 8, !insn.addr !1
  %1 = icmp eq i64 %0, 0, !insn.addr !2
  store i64 0, i64* %rax.0.reg2mem, !insn.addr !3
  br i1 %1, label %dec_label_pc_1016, label %dec_label_pc_1014, !insn.addr !3

dec_label_pc_1014:                                ; preds = %dec_label_pc_1000
  call void @__gmon_start__(), !insn.addr !4
  store i64 ptrtoint (i32* @0 to i64), i64* %rax.0.reg2mem, !insn.addr !4
  br label %dec_label_pc_1016, !insn.addr !4

dec_label_pc_1016:                                ; preds = %dec_label_pc_1014, %dec_label_pc_1000
  %rax.0.reload = load i64, i64* %rax.0.reg2mem
  ret i64 %rax.0.reload, !insn.addr !5
}

define i64 @function_1020() local_unnamed_addr {
dec_label_pc_1020:
  %0 = alloca i64
  %1 = load i64, i64* %0
  ret i64 %1, !insn.addr !6
}

define i32 @function_1030(i8* %format, ...) local_unnamed_addr {
dec_label_pc_1030:
  %0 = call i32 (i8*, ...) @printf(i8* %format), !insn.addr !7
  ret i32 %0, !insn.addr !7
}

define i64* @function_1040(i64* %s, i32 %c, i32 %n) local_unnamed_addr {
dec_label_pc_1040:
  %0 = call i64* @memset(i64* %s, i32 %c, i32 %n), !insn.addr !8
  ret i64* %0, !insn.addr !8
}

define i64 @function_1050() local_unnamed_addr {
dec_label_pc_1050:
  %0 = call i64 @function_1020(), !insn.addr !9
  ret i64 %0, !insn.addr !9
}

define i64 @function_1060() local_unnamed_addr {
dec_label_pc_1060:
  %0 = call i64 @function_1020(), !insn.addr !10
  ret i64 %0, !insn.addr !10
}

define i64 @function_1070() local_unnamed_addr {
dec_label_pc_1070:
  %0 = call i64 @function_1020(), !insn.addr !11
  ret i64 %0, !insn.addr !11
}

define i64 @function_1080() local_unnamed_addr {
dec_label_pc_1080:
  %0 = call i64 @function_1020(), !insn.addr !12
  ret i64 %0, !insn.addr !12
}

define i64 @function_1090(i64 %arg1) local_unnamed_addr {
dec_label_pc_1090:
  %0 = call i64 @__cxa_finalize.1(i64 %arg1), !insn.addr !13
  ret i64 %0, !insn.addr !13
}

define i64 @function_10a0() local_unnamed_addr {
dec_label_pc_10a0:
  %0 = call i64 @function_1020(), !insn.addr !14
  ret i64 %0, !insn.addr !14

; uselistorder directives
  uselistorder i64 ()* @function_1020, { 0, 1, 4, 2, 3 }
}

define i64 @deregister_tm_clones() local_unnamed_addr {
dec_label_pc_10b0:
  ret i64 ptrtoint (i64* @global_var_4058 to i64), !insn.addr !15
}

define i64 @register_tm_clones() local_unnamed_addr {
dec_label_pc_10e0:
  ret i64 0, !insn.addr !16
}

define i64 @__do_global_dtors_aux() local_unnamed_addr {
dec_label_pc_1120:
  %0 = alloca i64
  %1 = load i64, i64* %0
  %2 = load i8, i8* bitcast (i64* @global_var_4058 to i8*), align 8, !insn.addr !17
  %3 = icmp eq i8 %2, 0, !insn.addr !17
  %4 = icmp eq i1 %3, false, !insn.addr !18
  br i1 %4, label %dec_label_pc_1158, label %dec_label_pc_112d, !insn.addr !18

dec_label_pc_112d:                                ; preds = %dec_label_pc_1120
  %5 = load i64, i64* @global_var_3ff8, align 8, !insn.addr !19
  %6 = icmp eq i64 %5, 0, !insn.addr !19
  br i1 %6, label %dec_label_pc_1147, label %dec_label_pc_113b, !insn.addr !20

dec_label_pc_113b:                                ; preds = %dec_label_pc_112d
  %7 = call i64 @__cxa_finalize.1(i64 15896), !insn.addr !21
  br label %dec_label_pc_1147, !insn.addr !21

dec_label_pc_1147:                                ; preds = %dec_label_pc_113b, %dec_label_pc_112d
  %8 = call i64 @deregister_tm_clones(), !insn.addr !22
  store i8 1, i8* bitcast (i64* @global_var_4058 to i8*), align 8, !insn.addr !23
  ret i64 %8, !insn.addr !24

dec_label_pc_1158:                                ; preds = %dec_label_pc_1120
  ret i64 %1, !insn.addr !25
}

define i64 @frame_dummy() local_unnamed_addr {
dec_label_pc_1160:
  %0 = call i64 @register_tm_clones(), !insn.addr !26
  ret i64 %0, !insn.addr !26
}

define i64 @Java_org_opalj_fpcf_fixtures_taint_1xlang_TaintTest_sum(i64 %arg1, i64 %arg2, i64 %arg3, i64 %arg4) local_unnamed_addr {
dec_label_pc_1170:
  %0 = add i64 %arg4, %arg3, !insn.addr !27
  %1 = and i64 %0, 4294967295, !insn.addr !27
  ret i64 %1, !insn.addr !28
}

define i64 @Java_org_opalj_fpcf_fixtures_taint_1xlang_TaintTest_propagate_1source(i64 %arg1, i64 %arg2) local_unnamed_addr {
dec_label_pc_1190:
  %0 = call i64 @function_10a0(), !insn.addr !29
  %1 = add i64 %0, 23, !insn.addr !30
  %2 = and i64 %1, 4294967295, !insn.addr !30
  ret i64 %2, !insn.addr !31
}

define i64 @Java_org_opalj_fpcf_fixtures_taint_1xlang_TaintTest_propagate_1sanitize(i64 %arg1, i64 %arg2, i64 %arg3) local_unnamed_addr {
dec_label_pc_11b0:
  %0 = call i64 @function_1080(), !insn.addr !32
  ret i64 %0, !insn.addr !33
}

define i64 @sanitize(i64 %arg1) local_unnamed_addr {
dec_label_pc_11e0:
  %0 = add i64 %arg1, 4294967277, !insn.addr !34
  %1 = and i64 %0, 4294967295, !insn.addr !34
  ret i64 %1, !insn.addr !35
}

define i64 @Java_org_opalj_fpcf_fixtures_taint_1xlang_TaintTest_propagate_1sink(i64 %arg1, i64 %arg2, i64 %arg3) local_unnamed_addr {
dec_label_pc_11f0:
  %0 = call i64 @function_1060(), !insn.addr !36
  ret i64 23, !insn.addr !37
}

define i64 @sink(i64 %arg1) local_unnamed_addr {
dec_label_pc_1220:
  %0 = and i64 %arg1, 4294967295, !insn.addr !38
  %1 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([11 x i8], [11 x i8]* @global_var_203e, i64 0, i64 0), i64 %0), !insn.addr !39
  %2 = sext i32 %1 to i64, !insn.addr !39
  ret i64 %2, !insn.addr !40
}

define i64 @Java_org_opalj_fpcf_fixtures_taint_1xlang_TaintTest_sanitize_1only_1a_1into_1sink(i64 %arg1, i64 %arg2, i64 %arg3, i64 %arg4) local_unnamed_addr {
dec_label_pc_1250:
  %0 = call i64 @function_1080(), !insn.addr !41
  %1 = call i64 @function_1060(), !insn.addr !42
  %2 = and i64 %arg4, 4294967295, !insn.addr !43
  ret i64 %2, !insn.addr !44

; uselistorder directives
  uselistorder i64 ()* @function_1080, { 1, 0 }
}

define i64 @Java_org_opalj_fpcf_fixtures_taint_1xlang_TaintTest_propagate_1identity_1to_1sink(i64 %arg1, i64 %arg2, i64 %arg3) local_unnamed_addr {
dec_label_pc_1290:
  %0 = call i64 @function_1050(), !insn.addr !45
  %1 = call i64 @function_1060(), !insn.addr !46
  ret i64 %1, !insn.addr !47
}

define i64 @identity(i64 %arg1) local_unnamed_addr {
dec_label_pc_12c0:
  %0 = and i64 %arg1, 4294967295, !insn.addr !48
  ret i64 %0, !insn.addr !49
}

define i64 @Java_org_opalj_fpcf_fixtures_taint_1xlang_TaintTest_propagate_1zero_1to_1sink(i64 %arg1, i64 %arg2, i64 %arg3) local_unnamed_addr {
dec_label_pc_12d0:
  %0 = call i64 @function_1070(), !insn.addr !50
  %1 = call i64 @function_1060(), !insn.addr !51
  ret i64 %1, !insn.addr !52
}

define i64 @zero(i64 %arg1) local_unnamed_addr {
dec_label_pc_1300:
  ret i64 0, !insn.addr !53

; uselistorder directives
  uselistorder i64 0, { 1, 3, 4, 8, 2, 0, 9, 5, 6, 7 }
}

define i64 @Java_org_opalj_fpcf_fixtures_taint_1xlang_TaintTest_native_1array_1tainted(i64 %arg1, i64 %arg2) local_unnamed_addr {
dec_label_pc_1310:
  %stack_var_-32 = alloca i64, align 8
  %0 = call i64* @memset(i64* nonnull %stack_var_-32, i32 0, i32 8), !insn.addr !54
  %1 = call i64 @function_10a0(), !insn.addr !55
  %2 = call i64 @function_1060(), !insn.addr !56
  ret i64 %2, !insn.addr !57
}

define i64 @Java_org_opalj_fpcf_fixtures_taint_1xlang_TaintTest_native_1array_1untainted(i64 %arg1, i64 %arg2) local_unnamed_addr {
dec_label_pc_1350:
  %stack_var_-32 = alloca i64, align 8
  %0 = call i64* @memset(i64* nonnull %stack_var_-32, i32 0, i32 8), !insn.addr !58
  %1 = call i64 @function_10a0(), !insn.addr !59
  %sext = mul i64 %1, 4294967296
  %2 = ashr exact i64 %sext, 32, !insn.addr !60
  store i64 %2, i64* %stack_var_-32, align 8, !insn.addr !60
  %3 = call i64 @function_1060(), !insn.addr !61
  ret i64 %3, !insn.addr !62

; uselistorder directives
  uselistorder i64* %stack_var_-32, { 1, 0 }
  uselistorder i64 ()* @function_1060, { 5, 4, 3, 2, 1, 0 }
  uselistorder i64 ()* @function_10a0, { 2, 1, 0 }
  uselistorder i64* (i64*, i32, i32)* @memset, { 1, 0, 2 }
}

define i64 @Java_org_opalj_fpcf_fixtures_taint_1xlang_TaintTest_propagate_1to_1java_1sink(i64 %arg1, i64 %arg2, i64 %arg3) local_unnamed_addr {
dec_label_pc_1390:
  %0 = and i64 %arg1, -256, !insn.addr !63
  ret i64 %0, !insn.addr !64
}

define i64 @Java_org_opalj_fpcf_fixtures_taint_1xlang_TaintTest_propagate_1from_1java_1source(i64 %arg1, i64 %arg2) local_unnamed_addr {
dec_label_pc_1420:
  %0 = and i64 %arg1, -256, !insn.addr !65
  ret i64 %0, !insn.addr !66
}

define i64 @Java_org_opalj_fpcf_fixtures_taint_1xlang_TaintTest_propagate_1java_1sanitize(i64 %arg1, i64 %arg2, i64 %arg3) local_unnamed_addr {
dec_label_pc_14a0:
  %0 = and i64 %arg1, -256, !insn.addr !67
  ret i64 %0, !insn.addr !68
}

define i64 @source() local_unnamed_addr {
dec_label_pc_1530:
  ret i64 42, !insn.addr !69
}

define i64 @_fini() local_unnamed_addr {
dec_label_pc_153c:
  %0 = alloca i64
  %1 = load i64, i64* %0
  ret i64 %1, !insn.addr !70

; uselistorder directives
  uselistorder i32 1, { 2, 4, 5, 1, 0, 3 }
}

declare void @__gmon_start__() local_unnamed_addr

declare i32 @printf(i8*, ...) local_unnamed_addr

declare i64* @memset(i64*, i32, i32) local_unnamed_addr

declare i64 @__cxa_finalize.1(i64) local_unnamed_addr

!0 = !{i64 4096}
!1 = !{i64 4104}
!2 = !{i64 4111}
!3 = !{i64 4114}
!4 = !{i64 4116}
!5 = !{i64 4122}
!6 = !{i64 4134}
!7 = !{i64 4144}
!8 = !{i64 4160}
!9 = !{i64 4187}
!10 = !{i64 4203}
!11 = !{i64 4219}
!12 = !{i64 4235}
!13 = !{i64 4240}
!14 = !{i64 4267}
!15 = !{i64 4312}
!16 = !{i64 4376}
!17 = !{i64 4388}
!18 = !{i64 4395}
!19 = !{i64 4398}
!20 = !{i64 4409}
!21 = !{i64 4418}
!22 = !{i64 4423}
!23 = !{i64 4428}
!24 = !{i64 4436}
!25 = !{i64 4440}
!26 = !{i64 4452}
!27 = !{i64 4485}
!28 = !{i64 4489}
!29 = !{i64 4512}
!30 = !{i64 4517}
!31 = !{i64 4525}
!32 = !{i64 4550}
!33 = !{i64 4560}
!34 = !{i64 4586}
!35 = !{i64 4590}
!36 = !{i64 4614}
!37 = !{i64 4629}
!38 = !{i64 4651}
!39 = !{i64 4663}
!40 = !{i64 4673}
!41 = !{i64 4713}
!42 = !{i64 4727}
!43 = !{i64 4732}
!44 = !{i64 4740}
!45 = !{i64 4774}
!46 = !{i64 4785}
!47 = !{i64 4795}
!48 = !{i64 4807}
!49 = !{i64 4811}
!50 = !{i64 4838}
!51 = !{i64 4849}
!52 = !{i64 4859}
!53 = !{i64 4874}
!54 = !{i64 4907}
!55 = !{i64 4912}
!56 = !{i64 4923}
!57 = !{i64 4933}
!58 = !{i64 4971}
!59 = !{i64 4976}
!60 = !{i64 4981}
!61 = !{i64 4987}
!62 = !{i64 4997}
!63 = !{i64 5126}
!64 = !{i64 5136}
!65 = !{i64 5264}
!66 = !{i64 5273}
!67 = !{i64 5398}
!68 = !{i64 5408}
!69 = !{i64 5434}
!70 = !{i64 5448}
