source_filename = "test"
target datalayout = "e-p:32:32:32-f80:32:32"

@global_var_b6c = local_unnamed_addr constant i32 -1463714819
@global_var_b70 = local_unnamed_addr constant i32 -698416192
@global_var_b80 = local_unnamed_addr constant i32 -1447068688
@global_var_b84 = local_unnamed_addr constant i32 -1342177136
@global_var_b88 = local_unnamed_addr constant i32 -112722415
@global_var_b8c = local_unnamed_addr constant i32 -1858084336
@global_var_b90 = local_unnamed_addr constant i32 -702610912
@global_var_b94 = local_unnamed_addr constant i32 -721215457
@global_var_b98 = local_unnamed_addr constant i32 -721215457
@global_var_b9c = local_unnamed_addr constant i32 -721215457
@global_var_cac = local_unnamed_addr constant i32 -721215457
@global_var_d90 = local_unnamed_addr constant i32 -1862253569
@global_var_ddc = local_unnamed_addr constant i32 -1342177280
@global_var_dd8 = local_unnamed_addr constant i32 -1201683551
@global_var_dd4 = local_unnamed_addr constant i32 -1205877856
@global_var_dd0 = local_unnamed_addr constant i32 -1862253571
@global_var_dcc = local_unnamed_addr constant i32 -1459520515
@global_var_de0 = local_unnamed_addr constant i32 -1861961728
@global_var_e78 = local_unnamed_addr constant i32 -1191178272
@global_var_e6c = local_unnamed_addr constant i32 -1862220801
@global_var_e70 = local_unnamed_addr constant i32 -698416192
@global_var_3a3 = local_unnamed_addr global i32 0
@global_var_e9c = local_unnamed_addr constant i32 -1191178270
@global_var_c0f = local_unnamed_addr constant i32 37078
@global_var_7d2 = local_unnamed_addr constant [47 x i8] c"int_1xlang_TaintTest_propagate_1zero_1to_1sink\00"
@global_var_852 = local_unnamed_addr constant [76 x i8] c"ava_org_opalj_fpcf_fixtures_taint_1xlang_TaintTest_native_1array_1untainted\00"
@global_var_ef8 = local_unnamed_addr constant i32 -1744830666
@global_var_82b = local_unnamed_addr constant [38 x i8] c"lang_TaintTest_native_1array_1tainted\00"
@global_var_f24 = local_unnamed_addr constant i32 -1191179296
@global_var_457 = local_unnamed_addr global i32 947200
@global_var_fac = local_unnamed_addr constant i32 -127990879
@global_var_d1f = local_unnamed_addr constant i32 151060665
@global_var_10d0 = local_unnamed_addr constant i32 -1862204417
@global_var_10ec = local_unnamed_addr constant i32 -698416192
@global_var_10f0 = local_unnamed_addr constant [14 x i8] c"indirect_sink\00"
@global_var_10f4 = local_unnamed_addr constant [10 x i8] c"rect_sink\00"
@global_var_10f8 = local_unnamed_addr constant [6 x i8] c"_sink\00"
@global_var_10fc = local_unnamed_addr constant i32 1227358315
@global_var_1100 = local_unnamed_addr constant [3 x i8] c")V\00"
@global_var_1104 = local_unnamed_addr constant [15 x i8] c"ndirect_source\00"
@global_var_1108 = local_unnamed_addr constant [11 x i8] c"ect_source\00"
@global_var_110c = local_unnamed_addr constant [7 x i8] c"source\00"
@global_var_1110 = local_unnamed_addr constant [3 x i8] c"ce\00"
@global_var_1114 = local_unnamed_addr constant [3 x i8] c")I\00"
@global_var_1118 = local_unnamed_addr constant [17 x i8] c"ndirect_sanitize\00"
@global_var_111c = local_unnamed_addr constant [13 x i8] c"ect_sanitize\00"
@global_var_c38 = local_unnamed_addr constant i8 31
@global_var_cb0 = local_unnamed_addr constant i8 -3
@global_var_d30 = local_unnamed_addr constant i8 -3
@global_var_d84 = local_unnamed_addr constant i8 -32
@global_var_df8 = local_unnamed_addr constant i8 -3
@global_var_e40 = local_unnamed_addr constant i8 -3
@global_var_e8c = local_unnamed_addr constant i8 -3
@global_var_ec4 = local_unnamed_addr constant i8 -32
@global_var_ed8 = local_unnamed_addr constant i8 -3
@global_var_f40 = local_unnamed_addr constant i8 -3
@global_var_10e4 = local_unnamed_addr constant i8 -3

declare i32 @unknown_e0() local_unnamed_addr

define i32 @function_4a2(i32 %arg1, i32 %arg2, i32 %arg3, i32 %arg4) local_unnamed_addr {
dec_label_pc_4a2:
  %0 = udiv i32 %arg4, 8
  %1 = urem i32 %0, 2, !insn.addr !0
  ret i32 %1, !insn.addr !1
}

define i32 @_init(i32 %arg1, i32 %arg2, i32 %arg3, i32 %arg4) local_unnamed_addr {
dec_label_pc_b60:
  %0 = alloca i32
  %1 = alloca i1
  %r0.1.reg2mem = alloca i32, !insn.addr !2
  %2 = load i1, i1* %1
  %3 = load i1, i1* %1
  %4 = load i1, i1* %1
  %5 = load i1, i1* %1
  %6 = load i32, i32* %0
  %7 = icmp eq i1 %5, %2, !insn.addr !2
  br i1 %7, label %dec_label_pc_b9c, label %dec_label_pc_b64, !insn.addr !2

dec_label_pc_b9c:                                 ; preds = %dec_label_pc_b60
  br i1 %4, label %21, label %25, !insn.addr !3

dec_label_pc_b64:                                 ; preds = %dec_label_pc_b60
  %8 = icmp ne i1 %3, true, !insn.addr !4
  %9 = or i1 %4, %8, !insn.addr !4
  br i1 %9, label %10, label %17, !insn.addr !4

; <label>:10:                                     ; preds = %dec_label_pc_b64
  %11 = mul i32 %6, -1, !insn.addr !4
  %12 = add i32 %11, %arg1
  %13 = inttoptr i32 %12 to i32*, !insn.addr !4
  store i32 %arg1, i32* %13, align 4, !insn.addr !4
  %14 = add i32 %12, 4, !insn.addr !4
  %15 = inttoptr i32 %14 to i32*, !insn.addr !4
  store i32 %arg2, i32* %15, align 4, !insn.addr !4
  %16 = inttoptr i32 %arg1 to i32*, !insn.addr !5
  store i32 %arg1, i32* %16, align 4, !insn.addr !5
  br label %17, !insn.addr !5

; <label>:17:                                     ; preds = %dec_label_pc_b64, %10
  %18 = load i8, i8* inttoptr (i32 2936 to i8*), align 8, !insn.addr !6
  %19 = zext i8 %18 to i32, !insn.addr !6
  store i32 %19, i32* %r0.1.reg2mem, !insn.addr !6
  br label %20, !insn.addr !6

; <label>:20:                                     ; preds = %25, %17
  %r0.1.reload = load i32, i32* %r0.1.reg2mem
  ret i32 %r0.1.reload, !insn.addr !6

; <label>:21:                                     ; preds = %dec_label_pc_b9c
  %22 = load i32, i32* inttoptr (i32 2932 to i32*), align 4, !insn.addr !2
  %23 = add i32 %22, -31, !insn.addr !3
  %24 = inttoptr i32 %23 to i32*, !insn.addr !3
  store i32 -698416192, i32* %24, align 4, !insn.addr !3
  br label %25, !insn.addr !3

; <label>:25:                                     ; preds = %dec_label_pc_b9c, %21
  %spec.select = select i1 %4, i32 1065818121, i32 -1463714819
  store i32 %spec.select, i32* %r0.1.reg2mem
  br label %20

; uselistorder directives
  uselistorder i1 %4, { 2, 0, 1 }
  uselistorder i32* %r0.1.reg2mem, { 1, 0, 2 }
  uselistorder i1* %1, { 3, 2, 1, 0 }
  uselistorder i32 %arg1, { 1, 2, 3, 0 }
  uselistorder label %25, { 1, 0 }
  uselistorder label %17, { 1, 0 }
}

define i32 @call_weak_fn(i32 %arg1) local_unnamed_addr {
dec_label_pc_c20:
  %0 = alloca i1
  %1 = load i1, i1* %0
  %2 = load i1, i1* %0
  %3 = icmp eq i1 %2, %1, !insn.addr !7
  %4 = mul i32 %arg1, 2
  %5 = select i1 %3, i32 -1, i32 %4
  %r0.0 = and i32 %5, %arg1
  ret i32 %r0.0, !insn.addr !7

; uselistorder directives
  uselistorder i1* %0, { 1, 0 }
  uselistorder i32 %arg1, { 1, 0 }
}

define i32 @function_c26() local_unnamed_addr {
dec_label_pc_c26:
  %0 = alloca i32
  %1 = load i32, i32* %0
  ret i32 %1, !insn.addr !8
}

define i32 @function_c2c(i32 %arg1, i32 %arg2, i32 %arg3, i32 %arg4) local_unnamed_addr {
dec_label_pc_c2c:
  %0 = alloca i1
  %merge.reg2mem = alloca i32, !insn.addr !9
  %1 = load i1, i1* %0
  store i32 %arg1, i32* %merge.reg2mem, !insn.addr !9
  br i1 %1, label %3, label %2, !insn.addr !9

; <label>:2:                                      ; preds = %3, %dec_label_pc_c2c
  %merge.reload = load i32, i32* %merge.reg2mem
  ret i32 %merge.reload, !insn.addr !9

; <label>:3:                                      ; preds = %dec_label_pc_c2c
  %4 = add i32 %arg4, -31, !insn.addr !10
  %5 = inttoptr i32 %4 to i32*, !insn.addr !10
  store i32 %arg3, i32* %5, align 4, !insn.addr !10
  store i32 31, i32* %merge.reg2mem, !insn.addr !10
  br label %2, !insn.addr !10

; uselistorder directives
  uselistorder i32* %merge.reg2mem, { 1, 0, 2 }
}

define i32 @function_c3a() local_unnamed_addr {
dec_label_pc_c3a:
  ret i32 31, !insn.addr !11
}

define i32 @deregister_tm_clones(i32 %arg1, i32 %arg2) local_unnamed_addr {
dec_label_pc_c40:
  %0 = alloca i32
  %1 = alloca i1
  %r0.0.reg2mem = alloca i32, !insn.addr !12
  %cpsr_c.0.reg2mem = alloca i1, !insn.addr !12
  %2 = load i1, i1* %1
  %3 = load i1, i1* %1
  %4 = load i1, i1* %1
  %5 = load i32, i32* %0
  %6 = icmp ne i1 %4, %2, !insn.addr !12
  %7 = or i1 %3, %6, !insn.addr !12
  store i32 %arg1, i32* %r0.0.reg2mem, !insn.addr !12
  br i1 %7, label %8, label %12, !insn.addr !12

; <label>:8:                                      ; preds = %dec_label_pc_c40
  %9 = icmp slt i32 %arg1, 0, !insn.addr !12
  %10 = mul i32 %arg1, 2, !insn.addr !12
  %11 = and i32 %10, %arg1, !insn.addr !12
  store i1 %9, i1* %cpsr_c.0.reg2mem, !insn.addr !12
  store i32 %11, i32* %r0.0.reg2mem, !insn.addr !12
  br label %12, !insn.addr !12

; <label>:12:                                     ; preds = %dec_label_pc_c40, %8
  %r0.0.reload = load i32, i32* %r0.0.reg2mem
  %cpsr_c.0.reload = load i1, i1* %cpsr_c.0.reg2mem
  %13 = icmp ne i1 %cpsr_c.0.reload, true, !insn.addr !13
  %14 = or i1 %3, %13, !insn.addr !13
  br i1 %14, label %15, label %17, !insn.addr !13

; <label>:15:                                     ; preds = %12
  %16 = call i32 @__asm_mrsls(i32 %5), !insn.addr !13
  br label %17, !insn.addr !13

; <label>:17:                                     ; preds = %12, %15
  %18 = mul i32 %arg2, 2
  %19 = select i1 %7, i32 %18, i32 -1
  %r0.1 = and i32 %r0.0.reload, %19
  ret i32 %r0.1, !insn.addr !14

; uselistorder directives
  uselistorder i1 %3, { 1, 0 }
  uselistorder i32* %r0.0.reg2mem, { 0, 2, 1 }
  uselistorder i1* %1, { 2, 1, 0 }
  uselistorder i32 %arg1, { 2, 1, 3, 0 }
  uselistorder label %17, { 1, 0 }
  uselistorder label %12, { 1, 0 }
}

define i32 @function_c4c(i32 %arg1, i32 %arg2) local_unnamed_addr {
dec_label_pc_c4c:
  %0 = alloca i32
  %1 = load i32, i32* %0
  %2 = load i32, i32* %0
  store i8 41, i8* inttoptr (i32 594 to i8*), align 2, !insn.addr !15
  %3 = call i32 @function_4a2(i32 297, i32 1188, i32 %2, i32 %1), !insn.addr !16
  ret i32 %3, !insn.addr !16

; uselistorder directives
  uselistorder i32* %0, { 1, 0 }
}

define i32 @function_c5e(i32 %arg1) local_unnamed_addr {
dec_label_pc_c5e:
  ret i32 %arg1, !insn.addr !17
}

define i32 @function_c6e() local_unnamed_addr {
dec_label_pc_c6e:
  %0 = alloca i32
  %1 = load i32, i32* %0
  ret i32 %1, !insn.addr !18
}

define i32 @register_tm_clones(i32 %arg1, i32 %arg2) local_unnamed_addr {
dec_label_pc_c70:
  %0 = alloca i32
  %1 = alloca i1
  %r0.0.reg2mem = alloca i32, !insn.addr !19
  %cpsr_c.0.reg2mem = alloca i1, !insn.addr !19
  %2 = load i1, i1* %1
  %3 = load i1, i1* %1
  %4 = load i1, i1* %1
  %5 = load i32, i32* %0
  %6 = icmp ne i1 %4, %2, !insn.addr !19
  %7 = or i1 %3, %6, !insn.addr !19
  store i32 %arg1, i32* %r0.0.reg2mem, !insn.addr !19
  br i1 %7, label %8, label %12, !insn.addr !19

; <label>:8:                                      ; preds = %dec_label_pc_c70
  %9 = icmp slt i32 %arg1, 0, !insn.addr !19
  %10 = mul i32 %arg1, 2, !insn.addr !19
  %11 = and i32 %10, %arg1, !insn.addr !19
  store i1 %9, i1* %cpsr_c.0.reg2mem, !insn.addr !19
  store i32 %11, i32* %r0.0.reg2mem, !insn.addr !19
  br label %12, !insn.addr !19

; <label>:12:                                     ; preds = %dec_label_pc_c70, %8
  %r0.0.reload = load i32, i32* %r0.0.reg2mem
  %cpsr_c.0.reload = load i1, i1* %cpsr_c.0.reg2mem
  %13 = icmp ne i1 %cpsr_c.0.reload, true, !insn.addr !20
  %14 = or i1 %3, %13, !insn.addr !20
  br i1 %14, label %15, label %17, !insn.addr !20

; <label>:15:                                     ; preds = %12
  %16 = call i32 @__asm_mrsls(i32 %5), !insn.addr !20
  br label %17, !insn.addr !20

; <label>:17:                                     ; preds = %12, %15
  %18 = mul i32 %arg2, 2
  %19 = select i1 %7, i32 %18, i32 -1
  %r0.1 = and i32 %r0.0.reload, %19
  ret i32 %r0.1, !insn.addr !21

; uselistorder directives
  uselistorder i1 %3, { 1, 0 }
  uselistorder i32* %r0.0.reg2mem, { 0, 2, 1 }
  uselistorder i1* %1, { 2, 1, 0 }
  uselistorder i32 %arg1, { 2, 1, 3, 0 }
  uselistorder label %17, { 1, 0 }
  uselistorder label %12, { 1, 0 }
}

define i32 @function_c80(i32 %arg1, i32 %arg2, i32 %arg3) local_unnamed_addr {
dec_label_pc_c80:
  %0 = alloca i1
  %1 = load i1, i1* %0
  %2 = load i1, i1* %0
  %3 = load i1, i1* %0
  %4 = load i1, i1* %0
  %5 = icmp ne i1 %4, %1, !insn.addr !22
  %6 = or i1 %3, %5, !insn.addr !22
  br i1 %6, label %dec_label_pc_c8c.thread13, label %dec_label_pc_c84, !insn.addr !22

dec_label_pc_c84:                                 ; preds = %dec_label_pc_c80
  %7 = call i32 @function_d0c(), !insn.addr !22
  br i1 %2, label %9, label %dec_label_pc_c8c.thread13, !insn.addr !23

dec_label_pc_c8c.thread13:                        ; preds = %dec_label_pc_c80, %dec_label_pc_c84
  %8 = call i32 @function_1c210c94(), !insn.addr !24
  ret i32 %8, !insn.addr !24

; <label>:9:                                      ; preds = %dec_label_pc_c84
  %10 = call i32 @function_fe043d94(), !insn.addr !23
  ret i32 %10, !insn.addr !25

; uselistorder directives
  uselistorder i1* %0, { 3, 2, 1, 0 }
  uselistorder label %dec_label_pc_c8c.thread13, { 1, 0 }
}

define i32 @function_c98() local_unnamed_addr {
dec_label_pc_c98:
  %0 = call i32 @unknown_42f2a(), !insn.addr !26
  ret i32 %0, !insn.addr !27
}

define i32 @function_ca0(i32 %arg1, i32 %arg2, i32 %arg3, i32 %arg4) local_unnamed_addr {
dec_label_pc_ca0:
  %0 = alloca i1
  %r0.0.reg2mem = alloca i32, !insn.addr !28
  %1 = load i1, i1* %0
  %2 = load i1, i1* %0
  %3 = load i1, i1* %0
  %4 = icmp eq i1 %3, %1, !insn.addr !28
  store i32 %arg1, i32* %r0.0.reg2mem, !insn.addr !28
  br i1 %4, label %5, label %7, !insn.addr !28

; <label>:5:                                      ; preds = %dec_label_pc_ca0
  %6 = call i32 @function_81c68(), !insn.addr !28
  store i32 %6, i32* %r0.0.reg2mem, !insn.addr !28
  br label %7, !insn.addr !28

; <label>:7:                                      ; preds = %5, %dec_label_pc_ca0
  %r0.0.reload = load i32, i32* %r0.0.reg2mem
  %8 = icmp ne i1 %3, %1, !insn.addr !29
  %9 = or i1 %2, %8, !insn.addr !29
  %.mux = select i1 %9, i32 -721215457, i32 %r0.0.reload
  ret i32 %.mux, !insn.addr !29

; uselistorder directives
  uselistorder i1 %3, { 1, 0 }
  uselistorder i1 %1, { 1, 0 }
  uselistorder i32* %r0.0.reg2mem, { 0, 2, 1 }
  uselistorder i1* %0, { 2, 1, 0 }
}

define i32 @__do_global_dtors_aux(i32 %arg1, i32 %arg2) local_unnamed_addr {
dec_label_pc_cb0:
  %0 = alloca i32
  %1 = alloca i1
  %sp.0.reg2mem = alloca i32, !insn.addr !30
  %r0.0.reg2mem = alloca i32, !insn.addr !30
  %2 = load i1, i1* %1
  %3 = load i1, i1* %1
  %4 = load i1, i1* %1
  %5 = load i1, i1* %1
  %6 = load i32, i32* %0
  %7 = icmp eq i1 %5, %2, !insn.addr !30
  store i32 %arg1, i32* %r0.0.reg2mem, !insn.addr !30
  br i1 %7, label %8, label %15, !insn.addr !30

; <label>:8:                                      ; preds = %dec_label_pc_cb0
  %9 = add i32 %6, 4, !insn.addr !30
  %10 = inttoptr i32 %9 to i32*, !insn.addr !30
  %11 = load i32, i32* %10, align 4, !insn.addr !30
  %12 = add i32 %6, 48, !insn.addr !30
  %13 = inttoptr i32 %12 to i32*, !insn.addr !30
  %14 = load i32, i32* %13, align 4, !insn.addr !30
  store i32 %11, i32* %r0.0.reg2mem, !insn.addr !30
  store i32 %14, i32* %sp.0.reg2mem, !insn.addr !30
  br label %15, !insn.addr !30

; <label>:15:                                     ; preds = %dec_label_pc_cb0, %8
  %r0.0.reload = load i32, i32* %r0.0.reg2mem
  %16 = icmp ne i1 %3, true, !insn.addr !31
  %17 = or i1 %4, %16, !insn.addr !31
  br i1 %17, label %18, label %24, !insn.addr !31

; <label>:18:                                     ; preds = %15
  %sp.0.reload = load i32, i32* %sp.0.reg2mem
  %19 = mul i32 %sp.0.reload, -1, !insn.addr !31
  %20 = add i32 %19, %r0.0.reload
  %21 = inttoptr i32 %20 to i32*, !insn.addr !31
  store i32 %r0.0.reload, i32* %21, align 4, !insn.addr !31
  %22 = add i32 %20, 4, !insn.addr !31
  %23 = inttoptr i32 %22 to i32*, !insn.addr !31
  store i32 %arg2, i32* %23, align 4, !insn.addr !31
  br label %24, !insn.addr !31

; <label>:24:                                     ; preds = %15, %18
  ret i32 %r0.0.reload, !insn.addr !31

; uselistorder directives
  uselistorder i32 %r0.0.reload, { 1, 0, 2 }
  uselistorder i32* %r0.0.reg2mem, { 0, 2, 1 }
  uselistorder i1* %1, { 3, 2, 1, 0 }
  uselistorder label %24, { 1, 0 }
  uselistorder label %15, { 1, 0 }
}

define i32 @function_cb8(i32 %arg1, i32 %arg2) local_unnamed_addr {
dec_label_pc_cb8:
  %0 = alloca i32
  %1 = alloca double
  %2 = load i32, i32* %0
  %3 = load double, double* %1
  %4 = load double, double* %1
  %5 = load double, double* %1
  %6 = load double, double* %1
  %7 = udiv i32 %2, 32768, !insn.addr !32
  %8 = add i32 %arg1, 64, !insn.addr !33
  %9 = inttoptr i32 %8 to i32*, !insn.addr !33
  %10 = load i32, i32* %9, align 4, !insn.addr !33
  call void @__asm_vst4.32(double %6, double %5, double %4, double %3, i32 %10, i32 %7), !insn.addr !33
  %11 = mul i32 %arg1, 128, !insn.addr !34
  ret i32 %11, !insn.addr !35

; uselistorder directives
  uselistorder double* %1, { 3, 2, 1, 0 }
}

define i32 @function_cce(i32 %arg1) local_unnamed_addr {
dec_label_pc_cce:
  ret i32 %arg1, !insn.addr !36
}

define i32 @function_ce0(i32 %arg1, i32 %arg2) local_unnamed_addr {
dec_label_pc_ce0:
  %0 = alloca i1
  %1 = load i1, i1* %0
  %2 = load i1, i1* %0
  %3 = load i1, i1* %0
  %4 = icmp ne i1 %1, true, !insn.addr !37
  %5 = or i1 %2, %4, !insn.addr !37
  %6 = add i32 %arg1, 32
  %7 = or i1 %5, %3
  %merge = select i1 %7, i32 %arg1, i32 %6
  ret i32 %merge, !insn.addr !37

; uselistorder directives
  uselistorder i1* %0, { 2, 1, 0 }
}

define i32 @function_cee() local_unnamed_addr {
dec_label_pc_cee:
  %0 = alloca i1
  %1 = load i1, i1* %0
  br i1 %1, label %dec_label_pc_cf2, label %2, !insn.addr !38

; <label>:2:                                      ; preds = %dec_label_pc_cee
  %3 = call i32 @function_fff7f1f6(), !insn.addr !38
  br label %dec_label_pc_cf2, !insn.addr !38

dec_label_pc_cf2:                                 ; preds = %dec_label_pc_cee, %2
  ret i32 31, !insn.addr !39

; uselistorder directives
  uselistorder label %dec_label_pc_cf2, { 1, 0 }
}

define i32 @frame_dummy(i32 %arg1) local_unnamed_addr {
dec_label_pc_d00:
  %0 = alloca i1
  %1 = load i1, i1* %0
  br i1 %1, label %3, label %2, !insn.addr !40

; <label>:2:                                      ; preds = %3, %dec_label_pc_d00
  ret i32 %arg1, !insn.addr !40

; <label>:3:                                      ; preds = %dec_label_pc_d00
  %4 = add i32 %arg1, -3340, !insn.addr !41
  %5 = inttoptr i32 %4 to i32*, !insn.addr !41
  %6 = add i32 %arg1, -3336, !insn.addr !41
  %7 = inttoptr i32 %6 to i32*, !insn.addr !41
  br label %2, !insn.addr !41

; uselistorder directives
  uselistorder i32 %arg1, { 0, 2, 1 }
}

define i32 @function_d08() local_unnamed_addr {
dec_label_pc_d08:
  %0 = alloca i32
  %1 = load i32, i32* %0
  ret i32 %1
}

define i32 @function_d0c() local_unnamed_addr {
dec_label_pc_d0c:
  %0 = alloca i32
  %1 = load i32, i32* %0
  ret i32 %1
}

define i32 @function_d0e() local_unnamed_addr {
dec_label_pc_d0e:
  %0 = alloca i1
  %r0.1.reg2mem = alloca i32, !insn.addr !42
  %1 = load i1, i1* %0
  br i1 %1, label %2, label %dec_label_pc_d1e, !insn.addr !42

; <label>:2:                                      ; preds = %dec_label_pc_d0e
  call void @__asm_svceq(i32 14874880), !insn.addr !42
  %3 = call i32 @function_ff8ef11a(), !insn.addr !43
  call void @__asm_svceq(i32 15251712), !insn.addr !44
  %4 = call i32 @function_ffa6f222(), !insn.addr !45
  store i32 %4, i32* %r0.1.reg2mem, !insn.addr !45
  br label %dec_label_pc_d1e, !insn.addr !45

dec_label_pc_d1e:                                 ; preds = %dec_label_pc_d0e, %2
  %r0.1.reload = load i32, i32* %r0.1.reg2mem
  ret i32 %r0.1.reload, !insn.addr !45

; uselistorder directives
  uselistorder label %dec_label_pc_d1e, { 1, 0 }
}

define i32 @function_d20(i32 %arg1) local_unnamed_addr {
dec_label_pc_d20:
  %0 = alloca i1
  %r0.02.reg2mem = alloca i32, !insn.addr !46
  %r0.01.reg2mem = alloca i32, !insn.addr !46
  %1 = load i1, i1* %0
  %2 = load i1, i1* %0
  %3 = load i1, i1* %0
  %4 = load i1, i1* %0
  br i1 %3, label %dec_label_pc_d24.thread, label %dec_label_pc_d24, !insn.addr !46

dec_label_pc_d24.thread:                          ; preds = %dec_label_pc_d20
  %5 = call i32 @function_241128(), !insn.addr !46
  store i32 %5, i32* %r0.01.reg2mem
  br label %6

dec_label_pc_d24:                                 ; preds = %dec_label_pc_d20
  store i32 %arg1, i32* %r0.01.reg2mem, !insn.addr !47
  store i32 %arg1, i32* %r0.02.reg2mem, !insn.addr !47
  br i1 %2, label %11, label %6, !insn.addr !47

; <label>:6:                                      ; preds = %dec_label_pc_d24, %dec_label_pc_d24.thread
  %r0.01.reload = load i32, i32* %r0.01.reg2mem
  %7 = add i32 %r0.01.reload, -3372, !insn.addr !47
  %8 = inttoptr i32 %7 to i32*, !insn.addr !47
  %9 = add i32 %r0.01.reload, -3368, !insn.addr !47
  %10 = inttoptr i32 %9 to i32*, !insn.addr !47
  store i32 %r0.01.reload, i32* %r0.02.reg2mem, !insn.addr !47
  br label %11, !insn.addr !47

; <label>:11:                                     ; preds = %dec_label_pc_d24, %6
  %r0.02.reload = load i32, i32* %r0.02.reg2mem
  %12 = icmp ne i1 %4, %1, !insn.addr !48
  %13 = or i1 %3, %12, !insn.addr !48
  %spec.select = select i1 %13, i32 253, i32 %r0.02.reload
  ret i32 %spec.select, !insn.addr !48

; uselistorder directives
  uselistorder i32 %r0.01.reload, { 0, 2, 1 }
  uselistorder i1 %3, { 1, 0 }
  uselistorder i1* %0, { 3, 2, 1, 0 }
  uselistorder label %11, { 1, 0 }
}

define i32 @Java_org_opalj_fpcf_fixtures_taint_1xlang_TaintTest_sum() local_unnamed_addr {
dec_label_pc_d04:
  %0 = alloca i32
  %1 = load i32, i32* %0
  ret i32 %1
}

define i32 @Java_org_opalj_fpcf_fixtures_taint_1xlang_TaintTest_propagate_1source(i32 %arg1, i32 %arg2, i32 %arg3, i32 %arg4) local_unnamed_addr {
dec_label_pc_d2c:
  %0 = alloca i32
  %1 = alloca i1
  %2 = load i1, i1* %1
  %3 = load i1, i1* %1
  %4 = load i1, i1* %1
  %5 = load i1, i1* %1
  %6 = load i32, i32* %0
  %stack_var_0 = alloca i32, align 4
  %7 = icmp ne i1 %5, %2, !insn.addr !49
  %8 = or i1 %4, %7, !insn.addr !49
  br i1 %8, label %9, label %14, !insn.addr !49

; <label>:9:                                      ; preds = %dec_label_pc_d2c
  %10 = add i32 %arg1, -3380, !insn.addr !49
  %11 = inttoptr i32 %10 to i32*, !insn.addr !49
  %12 = add i32 %arg1, -3376, !insn.addr !49
  %13 = inttoptr i32 %12 to i32*, !insn.addr !49
  br label %14, !insn.addr !49

; <label>:14:                                     ; preds = %dec_label_pc_d2c, %9
  %15 = icmp eq i1 %5, %2, !insn.addr !50
  br i1 %15, label %16, label %44, !insn.addr !50

; <label>:16:                                     ; preds = %14
  %17 = add i32 %arg2, -52, !insn.addr !50
  %18 = inttoptr i32 %17 to i32*, !insn.addr !50
  store i32 %arg1, i32* %18, align 4, !insn.addr !50
  %19 = add i32 %arg2, -48, !insn.addr !50
  %20 = inttoptr i32 %19 to i32*, !insn.addr !50
  store i32 %arg3, i32* %20, align 4, !insn.addr !50
  %21 = add i32 %arg2, -44, !insn.addr !50
  %22 = inttoptr i32 %21 to i32*, !insn.addr !50
  store i32 %arg4, i32* %22, align 4, !insn.addr !50
  %23 = add i32 %arg2, -40, !insn.addr !50
  %24 = inttoptr i32 %23 to i32*, !insn.addr !50
  %25 = add i32 %arg2, -36, !insn.addr !50
  %26 = inttoptr i32 %25 to i32*, !insn.addr !50
  %27 = add i32 %arg2, -32, !insn.addr !50
  %28 = inttoptr i32 %27 to i32*, !insn.addr !50
  %29 = add i32 %arg2, -28, !insn.addr !50
  %30 = inttoptr i32 %29 to i32*, !insn.addr !50
  %31 = add i32 %arg2, -24, !insn.addr !50
  %32 = inttoptr i32 %31 to i32*, !insn.addr !50
  %33 = add i32 %arg2, -20, !insn.addr !50
  %34 = inttoptr i32 %33 to i32*, !insn.addr !50
  %35 = add i32 %arg2, -16, !insn.addr !50
  %36 = inttoptr i32 %35 to i32*, !insn.addr !50
  %37 = add i32 %arg2, -12, !insn.addr !50
  %38 = inttoptr i32 %37 to i32*, !insn.addr !50
  %39 = add i32 %arg2, -8, !insn.addr !50
  %40 = inttoptr i32 %39 to i32*, !insn.addr !50
  %41 = ptrtoint i32* %stack_var_0 to i32, !insn.addr !50
  store i32 %41, i32* %40, align 4, !insn.addr !50
  %42 = add i32 %arg2, -4, !insn.addr !50
  %43 = inttoptr i32 %42 to i32*, !insn.addr !50
  br label %44, !insn.addr !50

; <label>:44:                                     ; preds = %14, %16
  %45 = icmp ne i1 %3, true, !insn.addr !51
  %46 = or i1 %4, %45, !insn.addr !51
  br i1 %46, label %47, label %53, !insn.addr !51

; <label>:47:                                     ; preds = %44
  %48 = mul i32 %6, -1, !insn.addr !51
  %49 = add i32 %48, %arg1
  %50 = inttoptr i32 %49 to i32*, !insn.addr !51
  %51 = add i32 %49, 4, !insn.addr !51
  %52 = inttoptr i32 %51 to i32*, !insn.addr !51
  br label %53, !insn.addr !51

; <label>:53:                                     ; preds = %44, %47
  ret i32 %arg1, !insn.addr !51

; uselistorder directives
  uselistorder i1 %5, { 1, 0 }
  uselistorder i1 %4, { 1, 0 }
  uselistorder i1 %2, { 1, 0 }
  uselistorder i1* %1, { 3, 2, 1, 0 }
  uselistorder i32 %arg2, { 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0 }
  uselistorder i32 %arg1, { 1, 0, 2, 3, 4 }
  uselistorder label %53, { 1, 0 }
  uselistorder label %44, { 1, 0 }
  uselistorder label %14, { 1, 0 }
}

define i32 @function_d42(i32 %arg1) local_unnamed_addr {
dec_label_pc_d42:
  %0 = alloca i32
  %1 = load i32, i32* %0
  %2 = mul i32 %arg1, 2, !insn.addr !52
  %3 = inttoptr i32 %2 to i8*, !insn.addr !52
  %4 = load i8, i8* %3, align 2, !insn.addr !52
  %5 = udiv i8 %4, 16
  %6 = zext i8 %5 to i32
  %7 = trunc i32 %1 to i16, !insn.addr !53
  %8 = add i32 %1, 30, !insn.addr !53
  %9 = inttoptr i32 %8 to i16*, !insn.addr !53
  store i16 %7, i16* %9, align 2, !insn.addr !53
  %10 = mul i32 %6, 32768, !insn.addr !54
  ret i32 %10, !insn.addr !55

; uselistorder directives
  uselistorder i32 %1, { 1, 0 }
}

define i32 @Java_org_opalj_fpcf_fixtures_taint_1xlang_TaintTest_propagate_1sanitize(i32 %arg1, i32 %arg2, i32 %arg3, i32 %arg4) local_unnamed_addr {
dec_label_pc_d54:
  %0 = alloca i32
  %1 = alloca i1
  %2 = load i1, i1* %1
  %3 = load i1, i1* %1
  %4 = load i1, i1* %1
  %5 = load i1, i1* %1
  %6 = load i32, i32* %0
  %stack_var_0 = alloca i32, align 4
  %7 = icmp ne i1 %5, %2, !insn.addr !56
  %8 = or i1 %4, %7, !insn.addr !56
  br i1 %8, label %9, label %15, !insn.addr !56

; <label>:9:                                      ; preds = %dec_label_pc_d54
  %10 = add i32 %arg1, -3420, !insn.addr !56
  %11 = inttoptr i32 %10 to i32*, !insn.addr !56
  %12 = add i32 %arg1, -3416, !insn.addr !56
  %13 = inttoptr i32 %12 to i32*, !insn.addr !56
  %14 = ptrtoint i32* %stack_var_0 to i32, !insn.addr !56
  store i32 %14, i32* %13, align 4, !insn.addr !56
  br label %15, !insn.addr !56

; <label>:15:                                     ; preds = %dec_label_pc_d54, %9
  %16 = icmp eq i1 %5, %2, !insn.addr !57
  br i1 %16, label %17, label %45, !insn.addr !57

; <label>:17:                                     ; preds = %15
  %18 = add i32 %arg3, -52, !insn.addr !57
  %19 = inttoptr i32 %18 to i32*, !insn.addr !57
  store i32 %arg1, i32* %19, align 4, !insn.addr !57
  %20 = add i32 %arg3, -48, !insn.addr !57
  %21 = inttoptr i32 %20 to i32*, !insn.addr !57
  store i32 %arg3, i32* %21, align 4, !insn.addr !57
  %22 = add i32 %arg3, -44, !insn.addr !57
  %23 = inttoptr i32 %22 to i32*, !insn.addr !57
  store i32 %arg4, i32* %23, align 4, !insn.addr !57
  %24 = add i32 %arg3, -40, !insn.addr !57
  %25 = inttoptr i32 %24 to i32*, !insn.addr !57
  %26 = add i32 %arg3, -36, !insn.addr !57
  %27 = inttoptr i32 %26 to i32*, !insn.addr !57
  %28 = add i32 %arg3, -32, !insn.addr !57
  %29 = inttoptr i32 %28 to i32*, !insn.addr !57
  %30 = add i32 %arg3, -28, !insn.addr !57
  %31 = inttoptr i32 %30 to i32*, !insn.addr !57
  %32 = add i32 %arg3, -24, !insn.addr !57
  %33 = inttoptr i32 %32 to i32*, !insn.addr !57
  %34 = add i32 %arg3, -20, !insn.addr !57
  %35 = inttoptr i32 %34 to i32*, !insn.addr !57
  %36 = add i32 %arg3, -16, !insn.addr !57
  %37 = inttoptr i32 %36 to i32*, !insn.addr !57
  %38 = add i32 %arg3, -12, !insn.addr !57
  %39 = inttoptr i32 %38 to i32*, !insn.addr !57
  %40 = add i32 %arg3, -8, !insn.addr !57
  %41 = inttoptr i32 %40 to i32*, !insn.addr !57
  %42 = ptrtoint i32* %stack_var_0 to i32, !insn.addr !57
  store i32 %42, i32* %41, align 4, !insn.addr !57
  %43 = add i32 %arg3, -4, !insn.addr !57
  %44 = inttoptr i32 %43 to i32*, !insn.addr !57
  br label %45, !insn.addr !57

; <label>:45:                                     ; preds = %15, %17
  %46 = icmp ne i1 %3, true, !insn.addr !58
  %47 = or i1 %4, %46, !insn.addr !58
  br i1 %47, label %48, label %54, !insn.addr !58

; <label>:48:                                     ; preds = %45
  %49 = mul i32 %6, -1, !insn.addr !58
  %50 = add i32 %49, %arg1
  %51 = inttoptr i32 %50 to i32*, !insn.addr !58
  %52 = add i32 %50, 4, !insn.addr !58
  %53 = inttoptr i32 %52 to i32*, !insn.addr !58
  br label %54, !insn.addr !58

; <label>:54:                                     ; preds = %45, %48
  ret i32 %arg1, !insn.addr !58

; uselistorder directives
  uselistorder i1 %5, { 1, 0 }
  uselistorder i1 %4, { 1, 0 }
  uselistorder i1 %2, { 1, 0 }
  uselistorder i1* %1, { 3, 2, 1, 0 }
  uselistorder i32 %arg3, { 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 0, 2, 1 }
  uselistorder i32 %arg1, { 1, 0, 2, 3, 4 }
  uselistorder label %54, { 1, 0 }
  uselistorder label %45, { 1, 0 }
  uselistorder label %15, { 1, 0 }
}

define i32 @function_d62() local_unnamed_addr {
dec_label_pc_d62:
  %0 = alloca i1
  %r0.0.reg2mem = alloca i32, !insn.addr !59
  %1 = load i1, i1* %0
  br i1 %1, label %2, label %dec_label_pc_d66, !insn.addr !59

; <label>:2:                                      ; preds = %dec_label_pc_d62
  %3 = call i32 @function_ff87ede6(), !insn.addr !59
  store i32 %3, i32* %r0.0.reg2mem, !insn.addr !59
  br label %dec_label_pc_d66, !insn.addr !59

dec_label_pc_d66:                                 ; preds = %2, %dec_label_pc_d62
  %r0.0.reload = load i32, i32* %r0.0.reg2mem
  ret i32 %r0.0.reload, !insn.addr !59
}

define i32 @function_d68(i32 %arg1, i32 %arg2, i32 %arg3, i32 %arg4) local_unnamed_addr {
dec_label_pc_d68:
  %0 = alloca i1
  %merge.reg2mem = alloca i32, !insn.addr !60
  %1 = load i1, i1* %0
  %2 = load i1, i1* %0
  %3 = load i1, i1* %0
  %4 = load i1, i1* %0
  %stack_var_0 = alloca i32, align 4
  %5 = icmp eq i1 %4, %1, !insn.addr !60
  br i1 %5, label %.thread, label %6, !insn.addr !60

; <label>:6:                                      ; preds = %dec_label_pc_d68
  %7 = add i32 %arg1, -32, !insn.addr !60
  %8 = inttoptr i32 %7 to i32*, !insn.addr !60
  store i32 %arg2, i32* %8, align 4, !insn.addr !60
  %9 = add i32 %arg1, -28
  %10 = inttoptr i32 %9 to i32*
  %11 = add i32 %arg1, -24
  %12 = inttoptr i32 %11 to i32*
  %13 = add i32 %arg1, -20
  %14 = inttoptr i32 %13 to i32*
  %15 = add i32 %arg1, -16
  %16 = inttoptr i32 %15 to i32*
  %17 = add i32 %arg1, -12
  %18 = inttoptr i32 %17 to i32*
  %19 = add i32 %arg1, -8
  %20 = inttoptr i32 %19 to i32*
  %21 = add i32 %arg1, -4
  %22 = inttoptr i32 %21 to i32*
  br label %.thread, !insn.addr !61

.thread:                                          ; preds = %dec_label_pc_d68, %6
  %23 = icmp ne i1 %2, true, !insn.addr !62
  %24 = or i1 %3, %23, !insn.addr !62
  store i32 %arg1, i32* %merge.reg2mem, !insn.addr !62
  br i1 %24, label %25, label %dec_label_pc_d74, !insn.addr !62

; <label>:25:                                     ; preds = %54, %.thread
  %merge.reload = load i32, i32* %merge.reg2mem
  ret i32 %merge.reload, !insn.addr !62

dec_label_pc_d74:                                 ; preds = %.thread
  br i1 %5, label %26, label %54, !insn.addr !63

; <label>:26:                                     ; preds = %dec_label_pc_d74
  %27 = add i32 %arg3, -52, !insn.addr !63
  %28 = inttoptr i32 %27 to i32*, !insn.addr !63
  store i32 %arg1, i32* %28, align 4, !insn.addr !63
  %29 = add i32 %arg3, -48, !insn.addr !63
  %30 = inttoptr i32 %29 to i32*, !insn.addr !63
  store i32 %arg3, i32* %30, align 4, !insn.addr !63
  %31 = add i32 %arg3, -44, !insn.addr !63
  %32 = inttoptr i32 %31 to i32*, !insn.addr !63
  store i32 %arg4, i32* %32, align 4, !insn.addr !63
  %33 = add i32 %arg3, -40, !insn.addr !63
  %34 = inttoptr i32 %33 to i32*, !insn.addr !63
  %35 = add i32 %arg3, -36, !insn.addr !63
  %36 = inttoptr i32 %35 to i32*, !insn.addr !63
  %37 = add i32 %arg3, -32, !insn.addr !63
  %38 = inttoptr i32 %37 to i32*, !insn.addr !63
  %39 = add i32 %arg3, -28, !insn.addr !63
  %40 = inttoptr i32 %39 to i32*, !insn.addr !63
  %41 = add i32 %arg3, -24, !insn.addr !63
  %42 = inttoptr i32 %41 to i32*, !insn.addr !63
  %43 = add i32 %arg3, -20, !insn.addr !63
  %44 = inttoptr i32 %43 to i32*, !insn.addr !63
  %45 = add i32 %arg3, -16, !insn.addr !63
  %46 = inttoptr i32 %45 to i32*, !insn.addr !63
  %47 = add i32 %arg3, -12, !insn.addr !63
  %48 = inttoptr i32 %47 to i32*, !insn.addr !63
  %49 = add i32 %arg3, -8, !insn.addr !63
  %50 = inttoptr i32 %49 to i32*, !insn.addr !63
  %51 = ptrtoint i32* %stack_var_0 to i32, !insn.addr !63
  store i32 %51, i32* %50, align 4, !insn.addr !63
  %52 = add i32 %arg3, -4, !insn.addr !63
  %53 = inttoptr i32 %52 to i32*, !insn.addr !63
  br label %54, !insn.addr !63

; <label>:54:                                     ; preds = %26, %dec_label_pc_d74
  %spec.select = select i1 %5, i32 %arg1, i32 224
  store i32 %spec.select, i32* %merge.reg2mem
  br label %25

; uselistorder directives
  uselistorder i32* %merge.reg2mem, { 1, 0, 2 }
  uselistorder i1* %0, { 3, 2, 1, 0 }
  uselistorder i32 %arg3, { 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 0, 2, 1 }
  uselistorder i32 %arg1, { 1, 10, 0, 9, 8, 7, 6, 5, 4, 3, 2 }
  uselistorder label %.thread, { 1, 0 }
}

define i32 @sanitize(i32 %arg1, i32 %arg2, i32 %arg3, i32 %arg4) local_unnamed_addr {
dec_label_pc_d80:
  %0 = alloca i1
  %1 = load i1, i1* %0
  %2 = load i1, i1* %0
  %3 = load i1, i1* %0
  %4 = icmp ne i1 %3, %1, !insn.addr !64
  %5 = or i1 %2, %4, !insn.addr !64
  br i1 %5, label %6, label %11, !insn.addr !64

; <label>:6:                                      ; preds = %dec_label_pc_d80
  %7 = add i32 %arg1, -3464, !insn.addr !64
  %8 = inttoptr i32 %7 to i32*, !insn.addr !64
  %9 = add i32 %arg1, -3460, !insn.addr !64
  %10 = inttoptr i32 %9 to i32*, !insn.addr !64
  br label %11, !insn.addr !64

; <label>:11:                                     ; preds = %dec_label_pc_d80, %6
  %12 = icmp eq i1 %3, %1, !insn.addr !65
  br i1 %12, label %.thread, label %13, !insn.addr !65

; <label>:13:                                     ; preds = %11
  %14 = add i32 %arg1, -28
  %15 = inttoptr i32 %14 to i32*
  %16 = add i32 %arg1, -24
  %17 = inttoptr i32 %16 to i32*
  %18 = add i32 %arg1, -20
  %19 = inttoptr i32 %18 to i32*
  %20 = add i32 %arg1, -16
  %21 = inttoptr i32 %20 to i32*
  %22 = add i32 %arg1, -12
  %23 = inttoptr i32 %22 to i32*
  %24 = add i32 %arg1, -8
  %25 = inttoptr i32 %24 to i32*
  %26 = add i32 %arg1, -4
  %27 = inttoptr i32 %26 to i32*
  %28 = add i32 %arg1, -32, !insn.addr !66
  %29 = inttoptr i32 %28 to i32*, !insn.addr !66
  store i32 %arg4, i32* %29, align 4, !insn.addr !66
  br label %.thread, !insn.addr !66

.thread:                                          ; preds = %11, %13
  ret i32 %arg1, !insn.addr !66

; uselistorder directives
  uselistorder i1 %3, { 1, 0 }
  uselistorder i1 %1, { 1, 0 }
  uselistorder i1* %0, { 2, 1, 0 }
  uselistorder i32 %arg1, { 8, 7, 6, 5, 4, 3, 2, 1, 0, 9, 10 }
  uselistorder label %.thread, { 1, 0 }
  uselistorder label %11, { 1, 0 }
}

define i32 @function_d8c(i32 %arg1) local_unnamed_addr {
dec_label_pc_d8c:
  %0 = trunc i32 %arg1 to i8, !insn.addr !67
  %1 = add i32 %arg1, 4, !insn.addr !67
  %2 = inttoptr i32 %1 to i8*, !insn.addr !67
  store i8 %0, i8* %2, align 1, !insn.addr !67
  ret i32 %arg1, !insn.addr !67

; uselistorder directives
  uselistorder i32 %arg1, { 2, 1, 0 }
}

define i32 @function_d94(i32 %arg1) local_unnamed_addr {
dec_label_pc_d94:
  %0 = mul i32 %arg1, 32768, !insn.addr !68
  ret i32 %0, !insn.addr !69
}

define i32 @Java_org_opalj_fpcf_fixtures_taint_1xlang_TaintTest_propagate_1sink(i32 %arg1, i32 %arg2, i32 %arg3, i32 %arg4) local_unnamed_addr {
dec_label_pc_d98:
  %0 = alloca i32
  %1 = alloca i1
  %2 = load i1, i1* %1
  %3 = load i1, i1* %1
  %4 = load i1, i1* %1
  %5 = load i1, i1* %1
  %6 = load i32, i32* %0
  %stack_var_0 = alloca i32, align 4
  %7 = icmp ne i1 %5, %2, !insn.addr !70
  %8 = or i1 %4, %7, !insn.addr !70
  br i1 %8, label %9, label %15, !insn.addr !70

; <label>:9:                                      ; preds = %dec_label_pc_d98
  %10 = add i32 %arg1, -3488, !insn.addr !70
  %11 = inttoptr i32 %10 to i32*, !insn.addr !70
  %12 = add i32 %arg1, -3484, !insn.addr !70
  %13 = inttoptr i32 %12 to i32*, !insn.addr !70
  %14 = ptrtoint i32* %stack_var_0 to i32, !insn.addr !70
  store i32 %14, i32* %13, align 4, !insn.addr !70
  br label %15, !insn.addr !70

; <label>:15:                                     ; preds = %dec_label_pc_d98, %9
  %16 = icmp eq i1 %5, %2, !insn.addr !71
  br i1 %16, label %17, label %45, !insn.addr !71

; <label>:17:                                     ; preds = %15
  %18 = add i32 %arg3, -52, !insn.addr !71
  %19 = inttoptr i32 %18 to i32*, !insn.addr !71
  store i32 %arg1, i32* %19, align 4, !insn.addr !71
  %20 = add i32 %arg3, -48, !insn.addr !71
  %21 = inttoptr i32 %20 to i32*, !insn.addr !71
  store i32 %arg3, i32* %21, align 4, !insn.addr !71
  %22 = add i32 %arg3, -44, !insn.addr !71
  %23 = inttoptr i32 %22 to i32*, !insn.addr !71
  store i32 %arg4, i32* %23, align 4, !insn.addr !71
  %24 = add i32 %arg3, -40, !insn.addr !71
  %25 = inttoptr i32 %24 to i32*, !insn.addr !71
  %26 = add i32 %arg3, -36, !insn.addr !71
  %27 = inttoptr i32 %26 to i32*, !insn.addr !71
  %28 = add i32 %arg3, -32, !insn.addr !71
  %29 = inttoptr i32 %28 to i32*, !insn.addr !71
  %30 = add i32 %arg3, -28, !insn.addr !71
  %31 = inttoptr i32 %30 to i32*, !insn.addr !71
  %32 = add i32 %arg3, -24, !insn.addr !71
  %33 = inttoptr i32 %32 to i32*, !insn.addr !71
  %34 = add i32 %arg3, -20, !insn.addr !71
  %35 = inttoptr i32 %34 to i32*, !insn.addr !71
  %36 = add i32 %arg3, -16, !insn.addr !71
  %37 = inttoptr i32 %36 to i32*, !insn.addr !71
  %38 = add i32 %arg3, -12, !insn.addr !71
  %39 = inttoptr i32 %38 to i32*, !insn.addr !71
  %40 = add i32 %arg3, -8, !insn.addr !71
  %41 = inttoptr i32 %40 to i32*, !insn.addr !71
  %42 = ptrtoint i32* %stack_var_0 to i32, !insn.addr !71
  store i32 %42, i32* %41, align 4, !insn.addr !71
  %43 = add i32 %arg3, -4, !insn.addr !71
  %44 = inttoptr i32 %43 to i32*, !insn.addr !71
  br label %45, !insn.addr !71

; <label>:45:                                     ; preds = %15, %17
  %46 = icmp ne i1 %3, true, !insn.addr !72
  %47 = or i1 %4, %46, !insn.addr !72
  br i1 %47, label %48, label %54, !insn.addr !72

; <label>:48:                                     ; preds = %45
  %49 = mul i32 %6, -1, !insn.addr !72
  %50 = add i32 %49, %arg1
  %51 = inttoptr i32 %50 to i32*, !insn.addr !72
  %52 = add i32 %50, 4, !insn.addr !72
  %53 = inttoptr i32 %52 to i32*, !insn.addr !72
  br label %54, !insn.addr !72

; <label>:54:                                     ; preds = %45, %48
  ret i32 %arg1, !insn.addr !72

; uselistorder directives
  uselistorder i1 %5, { 1, 0 }
  uselistorder i1 %4, { 1, 0 }
  uselistorder i1 %2, { 1, 0 }
  uselistorder i1* %1, { 3, 2, 1, 0 }
  uselistorder i32 %arg3, { 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 0, 2, 1 }
  uselistorder i32 %arg1, { 1, 0, 2, 3, 4 }
  uselistorder label %54, { 1, 0 }
  uselistorder label %45, { 1, 0 }
  uselistorder label %15, { 1, 0 }
}

define i32 @function_da6() local_unnamed_addr {
dec_label_pc_da6:
  %0 = alloca i1
  %r0.0.reg2mem = alloca i32, !insn.addr !73
  %1 = load i1, i1* %0
  br i1 %1, label %2, label %dec_label_pc_daa, !insn.addr !73

; <label>:2:                                      ; preds = %dec_label_pc_da6
  %3 = call i32 @function_ff87ee2a(), !insn.addr !73
  store i32 %3, i32* %r0.0.reg2mem, !insn.addr !73
  br label %dec_label_pc_daa, !insn.addr !73

dec_label_pc_daa:                                 ; preds = %2, %dec_label_pc_da6
  %r0.0.reload = load i32, i32* %r0.0.reg2mem
  ret i32 %r0.0.reload, !insn.addr !73
}

define i32 @function_dac(i32 %arg1, i32 %arg2, i32 %arg3, i32 %arg4) local_unnamed_addr {
dec_label_pc_dac:
  %0 = alloca i32
  %1 = alloca i1
  %2 = load i1, i1* %1
  %3 = load i1, i1* %1
  %4 = load i1, i1* %1
  %5 = load i1, i1* %1
  %6 = load i32, i32* %0
  %7 = load i32, i32* %0
  %stack_var_264 = alloca i32, align 4
  %8 = icmp eq i1 %5, %2, !insn.addr !74
  br i1 %8, label %.thread, label %9, !insn.addr !74

; <label>:9:                                      ; preds = %dec_label_pc_dac
  %10 = add i32 %arg1, -32, !insn.addr !74
  %11 = inttoptr i32 %10 to i32*, !insn.addr !74
  store i32 %arg2, i32* %11, align 4, !insn.addr !74
  %12 = add i32 %arg1, -28
  %13 = inttoptr i32 %12 to i32*
  %14 = add i32 %arg1, -24
  %15 = inttoptr i32 %14 to i32*
  %16 = add i32 %arg1, -20
  %17 = inttoptr i32 %16 to i32*
  %18 = add i32 %arg1, -16
  %19 = inttoptr i32 %18 to i32*
  %20 = add i32 %arg1, -12
  %21 = inttoptr i32 %20 to i32*
  %22 = add i32 %arg1, -8
  %23 = inttoptr i32 %22 to i32*
  %24 = add i32 %arg1, -4
  %25 = inttoptr i32 %24 to i32*
  br label %.thread, !insn.addr !75

.thread:                                          ; preds = %dec_label_pc_dac, %9
  %26 = icmp ne i1 %3, true, !insn.addr !76
  %27 = or i1 %4, %26, !insn.addr !76
  br i1 %27, label %28, label %dec_label_pc_db8, !insn.addr !76

; <label>:28:                                     ; preds = %.thread
  ret i32 %arg1, !insn.addr !76

dec_label_pc_db8:                                 ; preds = %.thread
  %29 = mul i32 %7, 2048, !insn.addr !77
  %30 = trunc i32 %29 to i16, !insn.addr !78
  %31 = add i32 %29, %arg3, !insn.addr !78
  %32 = inttoptr i32 %31 to i16*, !insn.addr !78
  store i16 %30, i16* %32, align 2, !insn.addr !78
  %33 = add i32 %6, 15, !insn.addr !79
  %34 = inttoptr i32 %33 to i8*, !insn.addr !79
  %35 = load i8, i8* %34, align 1, !insn.addr !79
  %36 = zext i8 %35 to i32, !insn.addr !79
  %37 = inttoptr i32 %arg4 to i32*, !insn.addr !80
  store i32 %29, i32* %37, align 4, !insn.addr !80
  %38 = add i32 %arg4, 4, !insn.addr !80
  %39 = inttoptr i32 %38 to i32*, !insn.addr !80
  %40 = ptrtoint i32* %stack_var_264 to i32, !insn.addr !80
  store i32 %40, i32* %39, align 4, !insn.addr !80
  %41 = add i32 %arg4, 8, !insn.addr !80
  %42 = inttoptr i32 %41 to i32*, !insn.addr !80
  store i32 %arg3, i32* %42, align 4, !insn.addr !80
  %43 = add i32 %arg4, 12, !insn.addr !80
  %44 = inttoptr i32 %43 to i32*, !insn.addr !80
  store i32 %arg4, i32* %44, align 4, !insn.addr !80
  %45 = add i32 %arg4, 16, !insn.addr !80
  %46 = inttoptr i32 %45 to i32*, !insn.addr !80
  %47 = add i32 %arg4, 20, !insn.addr !80
  %48 = inttoptr i32 %47 to i32*, !insn.addr !80
  store i32 %36, i32* %48, align 4, !insn.addr !80
  %49 = add i32 %arg4, 24, !insn.addr !80
  %50 = inttoptr i32 %49 to i32*, !insn.addr !80
  %51 = add i32 %arg4, 28, !insn.addr !80
  %52 = inttoptr i32 %51 to i32*, !insn.addr !80
  %53 = mul i32 %7, 67108864, !insn.addr !81
  ret i32 %53, !insn.addr !82

; uselistorder directives
  uselistorder i32 %29, { 0, 2, 1 }
  uselistorder i32 %7, { 1, 0 }
  uselistorder i1* %1, { 3, 2, 1, 0 }
  uselistorder i32* %0, { 1, 0 }
  uselistorder i32 %arg4, { 8, 7, 6, 5, 0, 4, 3, 2, 1 }
  uselistorder i32 %arg3, { 1, 0 }
  uselistorder i32 %arg1, { 8, 7, 6, 5, 4, 3, 2, 1, 0 }
  uselistorder label %.thread, { 1, 0 }
}

define i32 @sink(i32 %arg1, i32 %arg2, i32 %arg3, i32 %arg4) local_unnamed_addr {
dec_label_pc_dc8:
  %0 = alloca i32
  %1 = alloca i1
  %2 = load i1, i1* %1
  %3 = load i1, i1* %1
  %4 = load i1, i1* %1
  %5 = load i1, i1* %1
  %6 = load i32, i32* %0
  %stack_var_0 = alloca i32, align 4
  %7 = icmp ne i1 %5, %2, !insn.addr !83
  %8 = or i1 %4, %7, !insn.addr !83
  br i1 %8, label %9, label %14, !insn.addr !83

; <label>:9:                                      ; preds = %dec_label_pc_dc8
  %10 = add i32 %arg1, -3536, !insn.addr !83
  %11 = inttoptr i32 %10 to i32*, !insn.addr !83
  %12 = add i32 %arg1, -3532, !insn.addr !83
  %13 = inttoptr i32 %12 to i32*, !insn.addr !83
  br label %14, !insn.addr !83

; <label>:14:                                     ; preds = %dec_label_pc_dc8, %9
  %15 = icmp eq i1 %5, %2, !insn.addr !84
  br i1 %15, label %16, label %44, !insn.addr !84

; <label>:16:                                     ; preds = %14
  %17 = add i32 %arg2, -52, !insn.addr !84
  %18 = inttoptr i32 %17 to i32*, !insn.addr !84
  store i32 %arg1, i32* %18, align 4, !insn.addr !84
  %19 = add i32 %arg2, -48, !insn.addr !84
  %20 = inttoptr i32 %19 to i32*, !insn.addr !84
  store i32 %arg3, i32* %20, align 4, !insn.addr !84
  %21 = add i32 %arg2, -44, !insn.addr !84
  %22 = inttoptr i32 %21 to i32*, !insn.addr !84
  store i32 %arg4, i32* %22, align 4, !insn.addr !84
  %23 = add i32 %arg2, -40, !insn.addr !84
  %24 = inttoptr i32 %23 to i32*, !insn.addr !84
  %25 = add i32 %arg2, -36, !insn.addr !84
  %26 = inttoptr i32 %25 to i32*, !insn.addr !84
  %27 = add i32 %arg2, -32, !insn.addr !84
  %28 = inttoptr i32 %27 to i32*, !insn.addr !84
  %29 = add i32 %arg2, -28, !insn.addr !84
  %30 = inttoptr i32 %29 to i32*, !insn.addr !84
  %31 = add i32 %arg2, -24, !insn.addr !84
  %32 = inttoptr i32 %31 to i32*, !insn.addr !84
  %33 = add i32 %arg2, -20, !insn.addr !84
  %34 = inttoptr i32 %33 to i32*, !insn.addr !84
  %35 = add i32 %arg2, -16, !insn.addr !84
  %36 = inttoptr i32 %35 to i32*, !insn.addr !84
  %37 = add i32 %arg2, -12, !insn.addr !84
  %38 = inttoptr i32 %37 to i32*, !insn.addr !84
  %39 = add i32 %arg2, -8, !insn.addr !84
  %40 = inttoptr i32 %39 to i32*, !insn.addr !84
  %41 = ptrtoint i32* %stack_var_0 to i32, !insn.addr !84
  store i32 %41, i32* %40, align 4, !insn.addr !84
  %42 = add i32 %arg2, -4, !insn.addr !84
  %43 = inttoptr i32 %42 to i32*, !insn.addr !84
  br label %44, !insn.addr !84

; <label>:44:                                     ; preds = %14, %16
  %45 = icmp ne i1 %3, true, !insn.addr !85
  %46 = or i1 %4, %45, !insn.addr !85
  br i1 %46, label %47, label %53, !insn.addr !85

; <label>:47:                                     ; preds = %44
  %48 = mul i32 %6, -1, !insn.addr !85
  %49 = add i32 %48, %arg1
  %50 = inttoptr i32 %49 to i32*, !insn.addr !85
  %51 = add i32 %49, 4, !insn.addr !85
  %52 = inttoptr i32 %51 to i32*, !insn.addr !85
  br label %53, !insn.addr !85

; <label>:53:                                     ; preds = %44, %47
  br i1 %15, label %dec_label_pc_ddc, label %54, !insn.addr !86

; <label>:54:                                     ; preds = %53
  %55 = call i32 @function_d10083ff(), !insn.addr !86
  ret i32 %55, !insn.addr !86

dec_label_pc_ddc:                                 ; preds = %53
  ret i32 %arg1, !insn.addr !87

; uselistorder directives
  uselistorder i1 %5, { 1, 0 }
  uselistorder i1 %4, { 1, 0 }
  uselistorder i1 %2, { 1, 0 }
  uselistorder i1* %1, { 3, 2, 1, 0 }
  uselistorder i32 %arg2, { 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0 }
  uselistorder i32 %arg1, { 1, 0, 2, 3, 4 }
  uselistorder label %53, { 1, 0 }
  uselistorder label %44, { 1, 0 }
  uselistorder label %14, { 1, 0 }
}

define i32 @function_de4(i32 %arg1, i32 %arg2, i32 %arg3, i32 %arg4) local_unnamed_addr {
dec_label_pc_de4:
  %0 = alloca i1
  %merge.reg2mem = alloca i32, !insn.addr !88
  %1 = load i1, i1* %0
  %2 = load i1, i1* %0
  %3 = load i1, i1* %0
  %4 = load i1, i1* %0
  %stack_var_0 = alloca i32, align 4
  %5 = icmp ne i1 %2, true, !insn.addr !88
  %6 = or i1 %3, %5, !insn.addr !88
  store i32 %arg1, i32* %merge.reg2mem, !insn.addr !88
  br i1 %6, label %7, label %dec_label_pc_de8, !insn.addr !88

; <label>:7:                                      ; preds = %37, %dec_label_pc_de4
  %merge.reload = load i32, i32* %merge.reg2mem
  ret i32 %merge.reload, !insn.addr !88

dec_label_pc_de8:                                 ; preds = %dec_label_pc_de4
  %8 = icmp eq i1 %4, %1, !insn.addr !89
  br i1 %8, label %9, label %37, !insn.addr !89

; <label>:9:                                      ; preds = %dec_label_pc_de8
  %10 = add i32 %arg2, -52, !insn.addr !89
  %11 = inttoptr i32 %10 to i32*, !insn.addr !89
  store i32 %arg1, i32* %11, align 4, !insn.addr !89
  %12 = add i32 %arg2, -48, !insn.addr !89
  %13 = inttoptr i32 %12 to i32*, !insn.addr !89
  store i32 %arg3, i32* %13, align 4, !insn.addr !89
  %14 = add i32 %arg2, -44, !insn.addr !89
  %15 = inttoptr i32 %14 to i32*, !insn.addr !89
  store i32 %arg4, i32* %15, align 4, !insn.addr !89
  %16 = add i32 %arg2, -40, !insn.addr !89
  %17 = inttoptr i32 %16 to i32*, !insn.addr !89
  %18 = add i32 %arg2, -36, !insn.addr !89
  %19 = inttoptr i32 %18 to i32*, !insn.addr !89
  %20 = add i32 %arg2, -32, !insn.addr !89
  %21 = inttoptr i32 %20 to i32*, !insn.addr !89
  %22 = add i32 %arg2, -28, !insn.addr !89
  %23 = inttoptr i32 %22 to i32*, !insn.addr !89
  %24 = add i32 %arg2, -24, !insn.addr !89
  %25 = inttoptr i32 %24 to i32*, !insn.addr !89
  %26 = add i32 %arg2, -20, !insn.addr !89
  %27 = inttoptr i32 %26 to i32*, !insn.addr !89
  %28 = add i32 %arg2, -16, !insn.addr !89
  %29 = inttoptr i32 %28 to i32*, !insn.addr !89
  %30 = add i32 %arg2, -12, !insn.addr !89
  %31 = inttoptr i32 %30 to i32*, !insn.addr !89
  %32 = add i32 %arg2, -8, !insn.addr !89
  %33 = inttoptr i32 %32 to i32*, !insn.addr !89
  %34 = ptrtoint i32* %stack_var_0 to i32, !insn.addr !89
  store i32 %34, i32* %33, align 4, !insn.addr !89
  %35 = add i32 %arg2, -4, !insn.addr !89
  %36 = inttoptr i32 %35 to i32*, !insn.addr !89
  br label %37, !insn.addr !89

; <label>:37:                                     ; preds = %9, %dec_label_pc_de8
  %spec.select = select i1 %8, i32 %arg1, i32 253
  store i32 %spec.select, i32* %merge.reg2mem
  br label %7

; uselistorder directives
  uselistorder i32* %merge.reg2mem, { 1, 0, 2 }
  uselistorder i1* %0, { 3, 2, 1, 0 }
  uselistorder i32 %arg2, { 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0 }
  uselistorder i32 %arg1, { 1, 2, 0 }
}

define i32 @Java_org_opalj_fpcf_fixtures_taint_1xlang_TaintTest_sanitize_1only_1a_1into_1sink(i32 %arg1, i32 %arg2, i32 %arg3, i32 %arg4) local_unnamed_addr {
dec_label_pc_df4:
  %0 = alloca i32
  %1 = alloca i1
  %2 = load i1, i1* %1
  %3 = load i1, i1* %1
  %4 = load i1, i1* %1
  %5 = load i1, i1* %1
  %6 = load i32, i32* %0
  %stack_var_0 = alloca i32, align 4
  %7 = icmp ne i1 %5, %2, !insn.addr !90
  %8 = or i1 %4, %7, !insn.addr !90
  br i1 %8, label %9, label %15, !insn.addr !90

; <label>:9:                                      ; preds = %dec_label_pc_df4
  %10 = add i32 %arg1, -3580, !insn.addr !90
  %11 = inttoptr i32 %10 to i32*, !insn.addr !90
  %12 = add i32 %arg1, -3576, !insn.addr !90
  %13 = inttoptr i32 %12 to i32*, !insn.addr !90
  %14 = ptrtoint i32* %stack_var_0 to i32, !insn.addr !90
  store i32 %14, i32* %13, align 4, !insn.addr !90
  br label %15, !insn.addr !90

; <label>:15:                                     ; preds = %dec_label_pc_df4, %9
  %16 = icmp eq i1 %5, %2, !insn.addr !91
  br i1 %16, label %17, label %45, !insn.addr !91

; <label>:17:                                     ; preds = %15
  %18 = add i32 %arg3, -52, !insn.addr !91
  %19 = inttoptr i32 %18 to i32*, !insn.addr !91
  store i32 %arg1, i32* %19, align 4, !insn.addr !91
  %20 = add i32 %arg3, -48, !insn.addr !91
  %21 = inttoptr i32 %20 to i32*, !insn.addr !91
  store i32 %arg3, i32* %21, align 4, !insn.addr !91
  %22 = add i32 %arg3, -44, !insn.addr !91
  %23 = inttoptr i32 %22 to i32*, !insn.addr !91
  store i32 %arg4, i32* %23, align 4, !insn.addr !91
  %24 = add i32 %arg3, -40, !insn.addr !91
  %25 = inttoptr i32 %24 to i32*, !insn.addr !91
  %26 = add i32 %arg3, -36, !insn.addr !91
  %27 = inttoptr i32 %26 to i32*, !insn.addr !91
  %28 = add i32 %arg3, -32, !insn.addr !91
  %29 = inttoptr i32 %28 to i32*, !insn.addr !91
  %30 = add i32 %arg3, -28, !insn.addr !91
  %31 = inttoptr i32 %30 to i32*, !insn.addr !91
  %32 = add i32 %arg3, -24, !insn.addr !91
  %33 = inttoptr i32 %32 to i32*, !insn.addr !91
  %34 = add i32 %arg3, -20, !insn.addr !91
  %35 = inttoptr i32 %34 to i32*, !insn.addr !91
  %36 = add i32 %arg3, -16, !insn.addr !91
  %37 = inttoptr i32 %36 to i32*, !insn.addr !91
  %38 = add i32 %arg3, -12, !insn.addr !91
  %39 = inttoptr i32 %38 to i32*, !insn.addr !91
  %40 = add i32 %arg3, -8, !insn.addr !91
  %41 = inttoptr i32 %40 to i32*, !insn.addr !91
  %42 = ptrtoint i32* %stack_var_0 to i32, !insn.addr !91
  store i32 %42, i32* %41, align 4, !insn.addr !91
  %43 = add i32 %arg3, -4, !insn.addr !91
  %44 = inttoptr i32 %43 to i32*, !insn.addr !91
  br label %45, !insn.addr !91

; <label>:45:                                     ; preds = %15, %17
  %46 = icmp ne i1 %3, true, !insn.addr !92
  %47 = or i1 %4, %46, !insn.addr !92
  br i1 %47, label %48, label %54, !insn.addr !92

; <label>:48:                                     ; preds = %45
  %49 = mul i32 %6, -1, !insn.addr !92
  %50 = add i32 %49, %arg1
  %51 = inttoptr i32 %50 to i32*, !insn.addr !92
  %52 = add i32 %50, 4, !insn.addr !92
  %53 = inttoptr i32 %52 to i32*, !insn.addr !92
  br label %54, !insn.addr !92

; <label>:54:                                     ; preds = %45, %48
  ret i32 %arg1, !insn.addr !92

; uselistorder directives
  uselistorder i1 %5, { 1, 0 }
  uselistorder i1 %4, { 1, 0 }
  uselistorder i1 %2, { 1, 0 }
  uselistorder i1* %1, { 3, 2, 1, 0 }
  uselistorder i32 %arg3, { 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 0, 2, 1 }
  uselistorder i32 %arg1, { 1, 0, 2, 3, 4 }
  uselistorder label %54, { 1, 0 }
  uselistorder label %45, { 1, 0 }
  uselistorder label %15, { 1, 0 }
}

define i32 @function_e02(i32 %arg1) local_unnamed_addr {
dec_label_pc_e02:
  %0 = alloca i32
  %1 = alloca i1
  %r0.1.reg2mem = alloca i32, !insn.addr !93
  %2 = load i1, i1* %1
  %3 = load i32, i32* %0
  store i32 %arg1, i32* %r0.1.reg2mem, !insn.addr !93
  br i1 %2, label %4, label %dec_label_pc_e0e, !insn.addr !93

; <label>:4:                                      ; preds = %dec_label_pc_e02
  %5 = call i32 @function_ff87ee86(), !insn.addr !93
  call void @__asm_svceq(i32 14874880), !insn.addr !94
  %6 = call i32 @function_ff8ef212(), !insn.addr !95
  store i32 %6, i32* %r0.1.reg2mem, !insn.addr !95
  br label %dec_label_pc_e0e, !insn.addr !95

dec_label_pc_e0e:                                 ; preds = %dec_label_pc_e02, %4
  %r0.1.reload = load i32, i32* %r0.1.reg2mem
  %7 = icmp eq i32 %r0.1.reload, 0, !insn.addr !96
  %8 = icmp slt i32 %3, 0
  %9 = zext i1 %8 to i32
  %spec.select = select i1 %7, i32 %9, i32 %r0.1.reload
  ret i32 %spec.select, !insn.addr !97

; uselistorder directives
  uselistorder i32 %r0.1.reload, { 1, 0 }
  uselistorder i32* %r0.1.reg2mem, { 0, 2, 1 }
  uselistorder label %dec_label_pc_e0e, { 1, 0 }
}

define i32 @function_e16() local_unnamed_addr {
dec_label_pc_e16:
  %0 = alloca i1
  %r0.0.reg2mem = alloca i32, !insn.addr !98
  %1 = load i1, i1* %0
  br i1 %1, label %.critedge, label %dec_label_pc_e22, !insn.addr !98

.critedge:                                        ; preds = %dec_label_pc_e16
  call void @__asm_svceq(i32 14718975), !insn.addr !98
  call void @__asm_svceq(i32 15251712), !insn.addr !99
  %2 = call i32 @function_ffa6f326(), !insn.addr !100
  store i32 %2, i32* %r0.0.reg2mem, !insn.addr !100
  br label %dec_label_pc_e22, !insn.addr !100

dec_label_pc_e22:                                 ; preds = %dec_label_pc_e16, %.critedge
  %r0.0.reload = load i32, i32* %r0.0.reg2mem
  ret i32 %r0.0.reload, !insn.addr !100

; uselistorder directives
  uselistorder label %dec_label_pc_e22, { 1, 0 }
}

define i32 @function_e24(i32 %arg1) local_unnamed_addr {
dec_label_pc_e24:
  %0 = mul i32 %arg1, 16, !insn.addr !101
  ret i32 %0, !insn.addr !101
}

define i32 @function_e28(i32 %arg1, i32 %arg2, i32 %arg3, i32 %arg4) local_unnamed_addr {
dec_label_pc_e28:
  %0 = alloca i1
  %merge.reg2mem = alloca i32, !insn.addr !102
  %1 = load i1, i1* %0
  %2 = load i1, i1* %0
  %3 = load i1, i1* %0
  %4 = load i1, i1* %0
  %stack_var_0 = alloca i32, align 4
  %5 = icmp ne i1 %2, true, !insn.addr !102
  %6 = or i1 %3, %5, !insn.addr !102
  store i32 %arg1, i32* %merge.reg2mem, !insn.addr !102
  br i1 %6, label %7, label %dec_label_pc_e2c, !insn.addr !102

; <label>:7:                                      ; preds = %50, %dec_label_pc_e28
  %merge.reload = load i32, i32* %merge.reg2mem
  ret i32 %merge.reload, !insn.addr !102

dec_label_pc_e2c:                                 ; preds = %dec_label_pc_e28
  %8 = icmp eq i1 %4, %1, !insn.addr !103
  br i1 %8, label %22, label %9, !insn.addr !103

; <label>:9:                                      ; preds = %dec_label_pc_e2c
  %10 = add i32 %arg1, -24, !insn.addr !103
  %11 = inttoptr i32 %10 to i32*, !insn.addr !103
  %12 = add i32 %arg1, -20, !insn.addr !103
  %13 = inttoptr i32 %12 to i32*, !insn.addr !103
  %14 = add i32 %arg1, -16, !insn.addr !103
  %15 = inttoptr i32 %14 to i32*, !insn.addr !103
  %16 = add i32 %arg1, -12, !insn.addr !103
  %17 = inttoptr i32 %16 to i32*, !insn.addr !103
  %18 = add i32 %arg1, -8, !insn.addr !103
  %19 = inttoptr i32 %18 to i32*, !insn.addr !103
  %20 = add i32 %arg1, -4, !insn.addr !103
  %21 = inttoptr i32 %20 to i32*, !insn.addr !103
  br label %50

; <label>:22:                                     ; preds = %dec_label_pc_e2c
  %23 = add i32 %arg3, -52, !insn.addr !104
  %24 = inttoptr i32 %23 to i32*, !insn.addr !104
  store i32 %arg1, i32* %24, align 4, !insn.addr !104
  %25 = add i32 %arg3, -48, !insn.addr !104
  %26 = inttoptr i32 %25 to i32*, !insn.addr !104
  store i32 %arg3, i32* %26, align 4, !insn.addr !104
  %27 = add i32 %arg3, -44, !insn.addr !104
  %28 = inttoptr i32 %27 to i32*, !insn.addr !104
  store i32 %arg4, i32* %28, align 4, !insn.addr !104
  %29 = add i32 %arg3, -40, !insn.addr !104
  %30 = inttoptr i32 %29 to i32*, !insn.addr !104
  %31 = add i32 %arg3, -36, !insn.addr !104
  %32 = inttoptr i32 %31 to i32*, !insn.addr !104
  %33 = add i32 %arg3, -32, !insn.addr !104
  %34 = inttoptr i32 %33 to i32*, !insn.addr !104
  %35 = add i32 %arg3, -28, !insn.addr !104
  %36 = inttoptr i32 %35 to i32*, !insn.addr !104
  %37 = add i32 %arg3, -24, !insn.addr !104
  %38 = inttoptr i32 %37 to i32*, !insn.addr !104
  %39 = add i32 %arg3, -20, !insn.addr !104
  %40 = inttoptr i32 %39 to i32*, !insn.addr !104
  %41 = add i32 %arg3, -16, !insn.addr !104
  %42 = inttoptr i32 %41 to i32*, !insn.addr !104
  %43 = add i32 %arg3, -12, !insn.addr !104
  %44 = inttoptr i32 %43 to i32*, !insn.addr !104
  %45 = add i32 %arg3, -8, !insn.addr !104
  %46 = inttoptr i32 %45 to i32*, !insn.addr !104
  %47 = ptrtoint i32* %stack_var_0 to i32, !insn.addr !104
  store i32 %47, i32* %46, align 4, !insn.addr !104
  %48 = add i32 %arg3, -4, !insn.addr !104
  %49 = inttoptr i32 %48 to i32*, !insn.addr !104
  br label %50, !insn.addr !104

; <label>:50:                                     ; preds = %22, %9
  %spec.select = select i1 %8, i32 %arg1, i32 253
  store i32 %spec.select, i32* %merge.reg2mem
  br label %7

; uselistorder directives
  uselistorder i32* %merge.reg2mem, { 1, 0, 2 }
  uselistorder i1* %0, { 3, 2, 1, 0 }
  uselistorder i32 %arg3, { 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 0, 2, 1 }
  uselistorder i32 %arg1, { 1, 8, 7, 6, 5, 4, 3, 2, 0 }
}

define i32 @Java_org_opalj_fpcf_fixtures_taint_1xlang_TaintTest_propagate_1identity_1to_1sink(i32 %arg1, i32 %arg2, i32 %arg3, i32 %arg4) local_unnamed_addr {
dec_label_pc_e3c:
  %0 = alloca i32
  %1 = alloca i1
  %2 = load i1, i1* %1
  %3 = load i1, i1* %1
  %4 = load i1, i1* %1
  %5 = load i1, i1* %1
  %6 = load i32, i32* %0
  %stack_var_0 = alloca i32, align 4
  %7 = icmp ne i1 %5, %2, !insn.addr !105
  %8 = or i1 %4, %7, !insn.addr !105
  br i1 %8, label %9, label %15, !insn.addr !105

; <label>:9:                                      ; preds = %dec_label_pc_e3c
  %10 = add i32 %arg1, -3652, !insn.addr !105
  %11 = inttoptr i32 %10 to i32*, !insn.addr !105
  %12 = add i32 %arg1, -3648, !insn.addr !105
  %13 = inttoptr i32 %12 to i32*, !insn.addr !105
  %14 = ptrtoint i32* %stack_var_0 to i32, !insn.addr !105
  store i32 %14, i32* %13, align 4, !insn.addr !105
  br label %15, !insn.addr !105

; <label>:15:                                     ; preds = %dec_label_pc_e3c, %9
  %16 = icmp eq i1 %5, %2, !insn.addr !106
  br i1 %16, label %17, label %45, !insn.addr !106

; <label>:17:                                     ; preds = %15
  %18 = add i32 %arg3, -52, !insn.addr !106
  %19 = inttoptr i32 %18 to i32*, !insn.addr !106
  store i32 %arg1, i32* %19, align 4, !insn.addr !106
  %20 = add i32 %arg3, -48, !insn.addr !106
  %21 = inttoptr i32 %20 to i32*, !insn.addr !106
  store i32 %arg3, i32* %21, align 4, !insn.addr !106
  %22 = add i32 %arg3, -44, !insn.addr !106
  %23 = inttoptr i32 %22 to i32*, !insn.addr !106
  store i32 %arg4, i32* %23, align 4, !insn.addr !106
  %24 = add i32 %arg3, -40, !insn.addr !106
  %25 = inttoptr i32 %24 to i32*, !insn.addr !106
  %26 = add i32 %arg3, -36, !insn.addr !106
  %27 = inttoptr i32 %26 to i32*, !insn.addr !106
  %28 = add i32 %arg3, -32, !insn.addr !106
  %29 = inttoptr i32 %28 to i32*, !insn.addr !106
  %30 = add i32 %arg3, -28, !insn.addr !106
  %31 = inttoptr i32 %30 to i32*, !insn.addr !106
  %32 = add i32 %arg3, -24, !insn.addr !106
  %33 = inttoptr i32 %32 to i32*, !insn.addr !106
  %34 = add i32 %arg3, -20, !insn.addr !106
  %35 = inttoptr i32 %34 to i32*, !insn.addr !106
  %36 = add i32 %arg3, -16, !insn.addr !106
  %37 = inttoptr i32 %36 to i32*, !insn.addr !106
  %38 = add i32 %arg3, -12, !insn.addr !106
  %39 = inttoptr i32 %38 to i32*, !insn.addr !106
  %40 = add i32 %arg3, -8, !insn.addr !106
  %41 = inttoptr i32 %40 to i32*, !insn.addr !106
  %42 = ptrtoint i32* %stack_var_0 to i32, !insn.addr !106
  store i32 %42, i32* %41, align 4, !insn.addr !106
  %43 = add i32 %arg3, -4, !insn.addr !106
  %44 = inttoptr i32 %43 to i32*, !insn.addr !106
  br label %45, !insn.addr !106

; <label>:45:                                     ; preds = %15, %17
  %46 = icmp ne i1 %3, true, !insn.addr !107
  %47 = or i1 %4, %46, !insn.addr !107
  br i1 %47, label %48, label %54, !insn.addr !107

; <label>:48:                                     ; preds = %45
  %49 = mul i32 %6, -1, !insn.addr !107
  %50 = add i32 %49, %arg1
  %51 = inttoptr i32 %50 to i32*, !insn.addr !107
  %52 = add i32 %50, 4, !insn.addr !107
  %53 = inttoptr i32 %52 to i32*, !insn.addr !107
  br label %54, !insn.addr !107

; <label>:54:                                     ; preds = %45, %48
  ret i32 %arg1, !insn.addr !107

; uselistorder directives
  uselistorder i1 %5, { 1, 0 }
  uselistorder i1 %4, { 1, 0 }
  uselistorder i1 %2, { 1, 0 }
  uselistorder i1* %1, { 3, 2, 1, 0 }
  uselistorder i32 %arg3, { 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 0, 2, 1 }
  uselistorder i32 %arg1, { 1, 0, 2, 3, 4 }
  uselistorder label %54, { 1, 0 }
  uselistorder label %45, { 1, 0 }
  uselistorder label %15, { 1, 0 }
}

define i32 @function_e4a() local_unnamed_addr {
dec_label_pc_e4a:
  %0 = alloca i1
  %r0.0.reg2mem = alloca i32, !insn.addr !108
  %1 = load i1, i1* %0
  br i1 %1, label %2, label %dec_label_pc_e4e, !insn.addr !108

; <label>:2:                                      ; preds = %dec_label_pc_e4a
  %3 = call i32 @function_ff87eece(), !insn.addr !108
  store i32 %3, i32* %r0.0.reg2mem, !insn.addr !108
  br label %dec_label_pc_e4e, !insn.addr !108

dec_label_pc_e4e:                                 ; preds = %2, %dec_label_pc_e4a
  %r0.0.reload = load i32, i32* %r0.0.reg2mem
  ret i32 %r0.0.reload, !insn.addr !108
}

define i32 @function_e50(i32 %arg1, i32 %arg2) local_unnamed_addr {
dec_label_pc_e50:
  %0 = alloca i1
  %1 = load i1, i1* %0
  %2 = load i1, i1* %0
  %3 = icmp eq i1 %2, %1, !insn.addr !109
  br i1 %3, label %.thread, label %4, !insn.addr !109

; <label>:4:                                      ; preds = %dec_label_pc_e50
  %5 = add i32 %arg1, -32, !insn.addr !109
  %6 = inttoptr i32 %5 to i32*, !insn.addr !109
  store i32 %arg2, i32* %6, align 4, !insn.addr !109
  %7 = add i32 %arg1, -28
  %8 = inttoptr i32 %7 to i32*
  %9 = add i32 %arg1, -24
  %10 = inttoptr i32 %9 to i32*
  %11 = add i32 %arg1, -20
  %12 = inttoptr i32 %11 to i32*
  %13 = add i32 %arg1, -16
  %14 = inttoptr i32 %13 to i32*
  %15 = add i32 %arg1, -12
  %16 = inttoptr i32 %15 to i32*
  %17 = add i32 %arg1, -8
  %18 = inttoptr i32 %17 to i32*
  %19 = add i32 %arg1, -4
  %20 = inttoptr i32 %19 to i32*
  br label %.thread, !insn.addr !110

.thread:                                          ; preds = %dec_label_pc_e50, %4
  ret i32 %arg1, !insn.addr !110

; uselistorder directives
  uselistorder i1* %0, { 1, 0 }
  uselistorder i32 %arg1, { 0, 8, 7, 6, 5, 4, 3, 2, 1 }
  uselistorder label %.thread, { 1, 0 }
}

define i32 @identity(i32 %arg1) local_unnamed_addr {
dec_label_pc_e74:
  %0 = alloca i1
  %1 = load i1, i1* %0
  %2 = load i1, i1* %0
  %3 = load i1, i1* %0
  %4 = load i1, i1* %0
  %5 = icmp ne i1 %4, %1, !insn.addr !111
  %6 = or i1 %3, %5, !insn.addr !111
  br i1 %6, label %7, label %12, !insn.addr !111

; <label>:7:                                      ; preds = %dec_label_pc_e74
  %8 = add i32 %arg1, -3708, !insn.addr !111
  %9 = inttoptr i32 %8 to i32*, !insn.addr !111
  %10 = add i32 %arg1, -3704, !insn.addr !111
  %11 = inttoptr i32 %10 to i32*, !insn.addr !111
  br label %12, !insn.addr !111

; <label>:12:                                     ; preds = %dec_label_pc_e74, %7
  %13 = icmp eq i1 %4, %1, !insn.addr !112
  br i1 %13, label %.thread, label %14, !insn.addr !112

; <label>:14:                                     ; preds = %12
  %15 = add i32 %arg1, -28
  %16 = inttoptr i32 %15 to i32*
  %17 = add i32 %arg1, -24
  %18 = inttoptr i32 %17 to i32*
  %19 = add i32 %arg1, -20
  %20 = inttoptr i32 %19 to i32*
  %21 = add i32 %arg1, -16
  %22 = inttoptr i32 %21 to i32*
  %23 = add i32 %arg1, -12
  %24 = inttoptr i32 %23 to i32*
  %25 = add i32 %arg1, -8
  %26 = inttoptr i32 %25 to i32*
  %27 = add i32 %arg1, -4
  %28 = inttoptr i32 %27 to i32*
  br label %.thread, !insn.addr !113

.thread:                                          ; preds = %12, %14
  %29 = icmp ne i1 %2, true, !insn.addr !114
  %30 = or i1 %3, %29, !insn.addr !114
  br i1 %30, label %31, label %36, !insn.addr !114

; <label>:31:                                     ; preds = %.thread
  %32 = add i32 %arg1, -3720, !insn.addr !114
  %33 = inttoptr i32 %32 to i32*, !insn.addr !114
  %34 = add i32 %arg1, -3716, !insn.addr !114
  %35 = inttoptr i32 %34 to i32*, !insn.addr !114
  br label %36, !insn.addr !114

; <label>:36:                                     ; preds = %.thread, %31
  %spec.select = select i1 %6, i32 253, i32 %arg1
  ret i32 %spec.select, !insn.addr !115

; uselistorder directives
  uselistorder i1 %4, { 1, 0 }
  uselistorder i1 %3, { 1, 0 }
  uselistorder i1 %1, { 1, 0 }
  uselistorder i1* %0, { 3, 2, 1, 0 }
  uselistorder i32 %arg1, { 0, 8, 9, 7, 6, 5, 4, 3, 2, 1, 10, 11 }
  uselistorder label %36, { 1, 0 }
  uselistorder label %.thread, { 1, 0 }
  uselistorder label %12, { 1, 0 }
}

define i32 @Java_org_opalj_fpcf_fixtures_taint_1xlang_TaintTest_propagate_1zero_1to_1sink(i32 %arg1) local_unnamed_addr {
dec_label_pc_e88:
  %0 = alloca i1
  %1 = load i1, i1* %0
  %2 = load i1, i1* %0
  %3 = load i1, i1* %0
  %stack_var_0 = alloca i32, align 4
  %4 = icmp ne i1 %3, %1, !insn.addr !116
  %5 = or i1 %2, %4, !insn.addr !116
  br i1 %5, label %6, label %12, !insn.addr !116

; <label>:6:                                      ; preds = %dec_label_pc_e88
  %7 = add i32 %arg1, -3728, !insn.addr !116
  %8 = inttoptr i32 %7 to i32*, !insn.addr !116
  %9 = add i32 %arg1, -3724, !insn.addr !116
  %10 = inttoptr i32 %9 to i32*, !insn.addr !116
  %11 = ptrtoint i32* %stack_var_0 to i32, !insn.addr !116
  store i32 %11, i32* %10, align 4, !insn.addr !116
  br label %12, !insn.addr !116

; <label>:12:                                     ; preds = %dec_label_pc_e88, %6
  ret i32 %arg1, !insn.addr !116

; uselistorder directives
  uselistorder i1* %0, { 2, 1, 0 }
  uselistorder label %12, { 1, 0 }
}

define i32 @function_e92() local_unnamed_addr {
dec_label_pc_e92:
  %0 = alloca i1
  %r0.0.reg2mem = alloca i32, !insn.addr !117
  %1 = load i1, i1* %0
  %2 = load i1, i1* %0
  %3 = icmp ne i1 %2, true, !insn.addr !117
  %4 = icmp eq i1 %1, %3, !insn.addr !117
  br i1 %4, label %5, label %7, !insn.addr !117

; <label>:5:                                      ; preds = %dec_label_pc_e92
  %6 = call i32 @__asm_movhi(i32 0, i32 2), !insn.addr !117
  br label %7, !insn.addr !117

; <label>:7:                                      ; preds = %dec_label_pc_e92, %5
  br i1 %2, label %8, label %dec_label_pc_e9a, !insn.addr !118

; <label>:8:                                      ; preds = %7
  %9 = call i32 @function_ff87ef1a(), !insn.addr !118
  store i32 %9, i32* %r0.0.reg2mem, !insn.addr !118
  br label %dec_label_pc_e9a, !insn.addr !118

dec_label_pc_e9a:                                 ; preds = %8, %7
  %r0.0.reload = load i32, i32* %r0.0.reg2mem
  ret i32 %r0.0.reload, !insn.addr !118

; uselistorder directives
  uselistorder i1 %2, { 1, 0 }
  uselistorder i1* %0, { 1, 0 }
  uselistorder label %7, { 1, 0 }
}

define i32 @function_e9c(i32 %arg1, i32 %arg2, i32 %arg3, i32 %arg4) local_unnamed_addr {
dec_label_pc_e9c:
  %0 = alloca i1
  %1 = load i1, i1* %0
  %2 = load i1, i1* %0
  %3 = load i1, i1* %0
  %4 = load i1, i1* %0
  %stack_var_0 = alloca i32, align 4
  %5 = icmp eq i1 %4, %1, !insn.addr !119
  br i1 %5, label %.thread, label %6, !insn.addr !119

; <label>:6:                                      ; preds = %dec_label_pc_e9c
  %7 = add i32 %arg1, -32, !insn.addr !119
  %8 = inttoptr i32 %7 to i32*, !insn.addr !119
  store i32 %arg2, i32* %8, align 4, !insn.addr !119
  %9 = add i32 %arg1, -28
  %10 = inttoptr i32 %9 to i32*
  %11 = add i32 %arg1, -24
  %12 = inttoptr i32 %11 to i32*
  %13 = add i32 %arg1, -20
  %14 = inttoptr i32 %13 to i32*
  %15 = add i32 %arg1, -16
  %16 = inttoptr i32 %15 to i32*
  %17 = add i32 %arg1, -12
  %18 = inttoptr i32 %17 to i32*
  %19 = add i32 %arg1, -8
  %20 = inttoptr i32 %19 to i32*
  %21 = add i32 %arg1, -4
  %22 = inttoptr i32 %21 to i32*
  br label %.thread, !insn.addr !120

.thread:                                          ; preds = %dec_label_pc_e9c, %6
  %23 = icmp ne i1 %2, true, !insn.addr !121
  %24 = or i1 %3, %23, !insn.addr !121
  br i1 %24, label %25, label %dec_label_pc_ea8, !insn.addr !121

; <label>:25:                                     ; preds = %.thread
  %26 = call i32 @unknown_e0(), !insn.addr !121
  ret i32 %26, !insn.addr !121

dec_label_pc_ea8:                                 ; preds = %.thread
  br i1 %5, label %40, label %dec_label_pc_eb4, !insn.addr !122

; <label>:27:                                     ; preds = %dec_label_pc_eb4, %40
  %spec.select = select i1 %5, i32 %arg1, i32 224
  ret i32 %spec.select, !insn.addr !123

dec_label_pc_eb4:                                 ; preds = %dec_label_pc_ea8
  %28 = add i32 %arg1, -24
  %29 = inttoptr i32 %28 to i32*
  %30 = add i32 %arg1, -20
  %31 = inttoptr i32 %30 to i32*
  %32 = add i32 %arg1, -16
  %33 = inttoptr i32 %32 to i32*
  %34 = add i32 %arg1, -12
  %35 = inttoptr i32 %34 to i32*
  %36 = add i32 %arg1, -8
  %37 = inttoptr i32 %36 to i32*
  %38 = add i32 %arg1, -4
  %39 = inttoptr i32 %38 to i32*
  br label %27

; <label>:40:                                     ; preds = %dec_label_pc_ea8
  %41 = add i32 %arg3, -52, !insn.addr !124
  %42 = inttoptr i32 %41 to i32*, !insn.addr !124
  store i32 %arg1, i32* %42, align 4, !insn.addr !124
  %43 = add i32 %arg3, -48, !insn.addr !124
  %44 = inttoptr i32 %43 to i32*, !insn.addr !124
  store i32 %arg3, i32* %44, align 4, !insn.addr !124
  %45 = add i32 %arg3, -44, !insn.addr !124
  %46 = inttoptr i32 %45 to i32*, !insn.addr !124
  store i32 %arg4, i32* %46, align 4, !insn.addr !124
  %47 = add i32 %arg3, -40, !insn.addr !124
  %48 = inttoptr i32 %47 to i32*, !insn.addr !124
  %49 = add i32 %arg3, -36, !insn.addr !124
  %50 = inttoptr i32 %49 to i32*, !insn.addr !124
  %51 = add i32 %arg3, -32, !insn.addr !124
  %52 = inttoptr i32 %51 to i32*, !insn.addr !124
  %53 = add i32 %arg3, -28, !insn.addr !124
  %54 = inttoptr i32 %53 to i32*, !insn.addr !124
  %55 = add i32 %arg3, -24, !insn.addr !124
  %56 = inttoptr i32 %55 to i32*, !insn.addr !124
  %57 = add i32 %arg3, -20, !insn.addr !124
  %58 = inttoptr i32 %57 to i32*, !insn.addr !124
  %59 = add i32 %arg3, -16, !insn.addr !124
  %60 = inttoptr i32 %59 to i32*, !insn.addr !124
  %61 = add i32 %arg3, -12, !insn.addr !124
  %62 = inttoptr i32 %61 to i32*, !insn.addr !124
  %63 = add i32 %arg3, -8, !insn.addr !124
  %64 = inttoptr i32 %63 to i32*, !insn.addr !124
  %65 = ptrtoint i32* %stack_var_0 to i32, !insn.addr !124
  store i32 %65, i32* %64, align 4, !insn.addr !124
  %66 = add i32 %arg3, -4, !insn.addr !124
  %67 = inttoptr i32 %66 to i32*, !insn.addr !124
  br label %27, !insn.addr !124

; uselistorder directives
  uselistorder i1* %0, { 3, 2, 1, 0 }
  uselistorder i32 %arg3, { 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 0, 2, 1 }
  uselistorder i32 %arg1, { 15, 14, 13, 12, 11, 10, 9, 0, 8, 7, 6, 5, 4, 3, 2, 1 }
  uselistorder label %27, { 1, 0 }
  uselistorder label %.thread, { 1, 0 }
}

define i32 @zero(i32 %arg1) local_unnamed_addr {
dec_label_pc_ec0:
  %0 = alloca i1
  %r0.02.reg2mem = alloca i32, !insn.addr !125
  %r0.01.reg2mem = alloca i32, !insn.addr !125
  %1 = load i1, i1* %0
  %2 = load i1, i1* %0
  %3 = load i1, i1* %0
  %4 = load i1, i1* %0
  %5 = icmp ne i1 %4, %1, !insn.addr !125
  %6 = or i1 %3, %5, !insn.addr !125
  br i1 %6, label %7, label %12, !insn.addr !125

; <label>:7:                                      ; preds = %dec_label_pc_ec0
  %8 = add i32 %arg1, -3784, !insn.addr !125
  %9 = inttoptr i32 %8 to i32*, !insn.addr !125
  %10 = add i32 %arg1, -3780, !insn.addr !125
  %11 = inttoptr i32 %10 to i32*, !insn.addr !125
  br label %12, !insn.addr !125

; <label>:12:                                     ; preds = %dec_label_pc_ec0, %7
  %13 = icmp eq i1 %4, %1, !insn.addr !126
  br i1 %13, label %29, label %14, !insn.addr !126

; <label>:14:                                     ; preds = %12
  %15 = add i32 %arg1, -28, !insn.addr !126
  %16 = inttoptr i32 %15 to i32*, !insn.addr !126
  %17 = add i32 %arg1, -24, !insn.addr !126
  %18 = inttoptr i32 %17 to i32*, !insn.addr !126
  %19 = add i32 %arg1, -20, !insn.addr !126
  %20 = inttoptr i32 %19 to i32*, !insn.addr !126
  %21 = add i32 %arg1, -16, !insn.addr !126
  %22 = inttoptr i32 %21 to i32*, !insn.addr !126
  %23 = add i32 %arg1, -12, !insn.addr !126
  %24 = inttoptr i32 %23 to i32*, !insn.addr !126
  %25 = add i32 %arg1, -8, !insn.addr !126
  %26 = inttoptr i32 %25 to i32*, !insn.addr !126
  %27 = add i32 %arg1, -4, !insn.addr !126
  %28 = inttoptr i32 %27 to i32*, !insn.addr !126
  br label %29, !insn.addr !126

; <label>:29:                                     ; preds = %12, %14
  store i32 %arg1, i32* %r0.01.reg2mem, !insn.addr !127
  br i1 %2, label %dec_label_pc_ecc, label %dec_label_pc_ecc.thread, !insn.addr !127

dec_label_pc_ecc:                                 ; preds = %29
  %30 = call i32 @function_7c1e50(), !insn.addr !127
  store i32 %30, i32* %r0.01.reg2mem, !insn.addr !128
  store i32 %30, i32* %r0.02.reg2mem, !insn.addr !128
  br i1 %3, label %dec_label_pc_ecc.thread, label %35, !insn.addr !128

dec_label_pc_ecc.thread:                          ; preds = %29, %dec_label_pc_ecc
  %r0.01.reload = load i32, i32* %r0.01.reg2mem
  %31 = add i32 %r0.01.reload, -3796, !insn.addr !128
  %32 = inttoptr i32 %31 to i32*, !insn.addr !128
  %33 = add i32 %r0.01.reload, -3792, !insn.addr !128
  %34 = inttoptr i32 %33 to i32*, !insn.addr !128
  store i32 %r0.01.reload, i32* %r0.02.reg2mem, !insn.addr !128
  br label %35, !insn.addr !128

; <label>:35:                                     ; preds = %dec_label_pc_ecc, %dec_label_pc_ecc.thread
  %r0.02.reload = load i32, i32* %r0.02.reg2mem
  %spec.select = select i1 %6, i32 253, i32 %r0.02.reload
  ret i32 %spec.select, !insn.addr !129

; uselistorder directives
  uselistorder i32 %r0.01.reload, { 0, 2, 1 }
  uselistorder i1 %4, { 1, 0 }
  uselistorder i1 %3, { 1, 0 }
  uselistorder i1 %1, { 1, 0 }
  uselistorder i32* %r0.01.reg2mem, { 0, 2, 1 }
  uselistorder i1* %0, { 3, 2, 1, 0 }
  uselistorder i32 %arg1, { 0, 7, 6, 5, 4, 3, 2, 1, 8, 9 }
  uselistorder label %35, { 1, 0 }
  uselistorder label %dec_label_pc_ecc.thread, { 1, 0 }
  uselistorder label %29, { 1, 0 }
  uselistorder label %12, { 1, 0 }
}

define i32 @Java_org_opalj_fpcf_fixtures_taint_1xlang_TaintTest_native_1array_1tainted(i32 %arg1) local_unnamed_addr {
dec_label_pc_ed4:
  %0 = alloca i1
  %1 = load i1, i1* %0
  %2 = load i1, i1* %0
  %3 = load i1, i1* %0
  %stack_var_0 = alloca i32, align 4
  %4 = icmp ne i1 %3, %1, !insn.addr !130
  %5 = or i1 %2, %4, !insn.addr !130
  br i1 %5, label %6, label %12, !insn.addr !130

; <label>:6:                                      ; preds = %dec_label_pc_ed4
  %7 = add i32 %arg1, -3804, !insn.addr !130
  %8 = inttoptr i32 %7 to i32*, !insn.addr !130
  %9 = add i32 %arg1, -3800, !insn.addr !130
  %10 = inttoptr i32 %9 to i32*, !insn.addr !130
  %11 = ptrtoint i32* %stack_var_0 to i32, !insn.addr !130
  store i32 %11, i32* %10, align 4, !insn.addr !130
  br label %12, !insn.addr !130

; <label>:12:                                     ; preds = %dec_label_pc_ed4, %6
  ret i32 %arg1, !insn.addr !130

; uselistorder directives
  uselistorder i1* %0, { 2, 1, 0 }
  uselistorder label %12, { 1, 0 }
}

define i32 @function_ede(i32 %arg1) local_unnamed_addr {
dec_label_pc_ede:
  %0 = alloca i1
  %r0.0.reg2mem = alloca i32, !insn.addr !131
  %1 = load i1, i1* %0
  %2 = load i1, i1* %0
  %3 = icmp ne i1 %2, true, !insn.addr !131
  %4 = icmp eq i1 %1, %3, !insn.addr !131
  br i1 %4, label %5, label %7, !insn.addr !131

; <label>:5:                                      ; preds = %dec_label_pc_ede
  %6 = call i32 @__asm_movhi(i32 0, i32 2), !insn.addr !131
  br label %7, !insn.addr !131

; <label>:7:                                      ; preds = %dec_label_pc_ede, %5
  store i32 %arg1, i32* %r0.0.reg2mem, !insn.addr !132
  br i1 %2, label %8, label %dec_label_pc_ee6, !insn.addr !132

; <label>:8:                                      ; preds = %7
  %9 = call i32 @function_ff87ef66(), !insn.addr !132
  store i32 %9, i32* %r0.0.reg2mem, !insn.addr !132
  br label %dec_label_pc_ee6, !insn.addr !132

dec_label_pc_ee6:                                 ; preds = %8, %7
  %r0.0.reload = load i32, i32* %r0.0.reg2mem
  ret i32 %r0.0.reload, !insn.addr !133

; uselistorder directives
  uselistorder i1 %2, { 1, 0 }
  uselistorder i32* %r0.0.reg2mem, { 0, 2, 1 }
  uselistorder i1* %0, { 1, 0 }
  uselistorder i32 2, { 7, 8, 0, 1, 2, 3, 4, 5, 6 }
  uselistorder label %7, { 1, 0 }
}

define i32 @function_eec(i32 %arg1) local_unnamed_addr {
dec_label_pc_eec:
  %0 = alloca i1
  %1 = load i1, i1* %0
  %2 = load i1, i1* %0
  %3 = load i1, i1* %0
  %4 = load i1, i1* %0
  %5 = icmp ne i1 %2, true, !insn.addr !134
  %6 = or i1 %3, %5, !insn.addr !134
  %7 = icmp eq i1 %4, %1, !insn.addr !135
  %or.cond = or i1 %6, %7
  br i1 %or.cond, label %.thread, label %8, !insn.addr !134

.thread:                                          ; preds = %8, %dec_label_pc_eec
  ret i32 %arg1, !insn.addr !134

; <label>:8:                                      ; preds = %dec_label_pc_eec
  %9 = add i32 %arg1, -28
  %10 = inttoptr i32 %9 to i32*
  %11 = add i32 %arg1, -24
  %12 = inttoptr i32 %11 to i32*
  %13 = add i32 %arg1, -20
  %14 = inttoptr i32 %13 to i32*
  %15 = add i32 %arg1, -16
  %16 = inttoptr i32 %15 to i32*
  %17 = add i32 %arg1, -12
  %18 = inttoptr i32 %17 to i32*
  %19 = add i32 %arg1, -8
  %20 = inttoptr i32 %19 to i32*
  %21 = add i32 %arg1, -4
  %22 = inttoptr i32 %21 to i32*
  br label %.thread, !insn.addr !136

; uselistorder directives
  uselistorder i1* %0, { 3, 2, 1, 0 }
  uselistorder i32 %arg1, { 6, 5, 4, 3, 2, 1, 0, 7 }
}

define i32 @function_efa() local_unnamed_addr {
dec_label_pc_efa:
  %0 = alloca i1
  %r0.0.reg2mem = alloca i32, !insn.addr !137
  %1 = load i1, i1* %0
  br i1 %1, label %dec_label_pc_efe, label %2, !insn.addr !137

; <label>:2:                                      ; preds = %dec_label_pc_efa
  %3 = call i32 @function_fff66efe(), !insn.addr !137
  store i32 %3, i32* %r0.0.reg2mem, !insn.addr !137
  br label %dec_label_pc_efe, !insn.addr !137

dec_label_pc_efe:                                 ; preds = %dec_label_pc_efa, %2
  %r0.0.reload = load i32, i32* %r0.0.reg2mem
  ret i32 %r0.0.reload, !insn.addr !137

; uselistorder directives
  uselistorder label %dec_label_pc_efe, { 1, 0 }
}

define i32 @function_f00(i32 %arg1, i32 %arg2, i32 %arg3, i32 %arg4) local_unnamed_addr {
dec_label_pc_f00:
  %0 = inttoptr i32 %arg4 to i32*, !insn.addr !138
  store i32 %arg1, i32* %0, align 4, !insn.addr !138
  %1 = add i32 %arg4, 4, !insn.addr !138
  %2 = inttoptr i32 %1 to i32*, !insn.addr !138
  store i32 %arg2, i32* %2, align 4, !insn.addr !138
  %3 = add i32 %arg4, 8, !insn.addr !138
  %4 = inttoptr i32 %3 to i32*, !insn.addr !138
  store i32 %arg3, i32* %4, align 4, !insn.addr !138
  %5 = add i32 %arg4, 12, !insn.addr !138
  %6 = inttoptr i32 %5 to i32*, !insn.addr !138
  store i32 %arg4, i32* %6, align 4, !insn.addr !138
  %7 = add i32 %arg4, 16, !insn.addr !138
  %8 = inttoptr i32 %7 to i32*, !insn.addr !138
  %9 = add i32 %arg4, 20, !insn.addr !138
  %10 = inttoptr i32 %9 to i32*, !insn.addr !138
  %11 = add i32 %arg4, 24, !insn.addr !138
  %12 = inttoptr i32 %11 to i32*, !insn.addr !138
  %13 = add i32 %arg4, 28, !insn.addr !138
  %14 = inttoptr i32 %13 to i32*, !insn.addr !138
  %15 = mul i32 %arg1, 32768, !insn.addr !139
  ret i32 %15, !insn.addr !140

; uselistorder directives
  uselistorder i32 %arg4, { 7, 6, 5, 4, 8, 3, 2, 1, 0 }
}

define i32 @Java_org_opalj_fpcf_fixtures_taint_1xlang_TaintTest_native_1array_1untainted(i32 %arg1, i32 %arg2, i32 %arg3, i32 %arg4) local_unnamed_addr {
dec_label_pc_f08:
  %0 = alloca i32
  %1 = alloca i1
  %2 = load i1, i1* %1
  %3 = load i1, i1* %1
  %4 = load i1, i1* %1
  %5 = load i1, i1* %1
  %6 = load i32, i32* %0
  %stack_var_0 = alloca i32, align 4
  %7 = icmp ne i1 %5, %2, !insn.addr !141
  %8 = or i1 %4, %7, !insn.addr !141
  br i1 %8, label %9, label %15, !insn.addr !141

; <label>:9:                                      ; preds = %dec_label_pc_f08
  %10 = add i32 %arg1, -3856, !insn.addr !141
  %11 = inttoptr i32 %10 to i32*, !insn.addr !141
  %12 = add i32 %arg1, -3852, !insn.addr !141
  %13 = inttoptr i32 %12 to i32*, !insn.addr !141
  %14 = ptrtoint i32* %stack_var_0 to i32, !insn.addr !141
  store i32 %14, i32* %13, align 4, !insn.addr !141
  br label %15, !insn.addr !141

; <label>:15:                                     ; preds = %dec_label_pc_f08, %9
  %16 = icmp eq i1 %5, %2, !insn.addr !142
  br i1 %16, label %17, label %45, !insn.addr !142

; <label>:17:                                     ; preds = %15
  %18 = add i32 %arg3, -52, !insn.addr !142
  %19 = inttoptr i32 %18 to i32*, !insn.addr !142
  store i32 %arg1, i32* %19, align 4, !insn.addr !142
  %20 = add i32 %arg3, -48, !insn.addr !142
  %21 = inttoptr i32 %20 to i32*, !insn.addr !142
  store i32 %arg3, i32* %21, align 4, !insn.addr !142
  %22 = add i32 %arg3, -44, !insn.addr !142
  %23 = inttoptr i32 %22 to i32*, !insn.addr !142
  store i32 %arg4, i32* %23, align 4, !insn.addr !142
  %24 = add i32 %arg3, -40, !insn.addr !142
  %25 = inttoptr i32 %24 to i32*, !insn.addr !142
  %26 = add i32 %arg3, -36, !insn.addr !142
  %27 = inttoptr i32 %26 to i32*, !insn.addr !142
  %28 = add i32 %arg3, -32, !insn.addr !142
  %29 = inttoptr i32 %28 to i32*, !insn.addr !142
  %30 = add i32 %arg3, -28, !insn.addr !142
  %31 = inttoptr i32 %30 to i32*, !insn.addr !142
  %32 = add i32 %arg3, -24, !insn.addr !142
  %33 = inttoptr i32 %32 to i32*, !insn.addr !142
  %34 = add i32 %arg3, -20, !insn.addr !142
  %35 = inttoptr i32 %34 to i32*, !insn.addr !142
  %36 = add i32 %arg3, -16, !insn.addr !142
  %37 = inttoptr i32 %36 to i32*, !insn.addr !142
  %38 = add i32 %arg3, -12, !insn.addr !142
  %39 = inttoptr i32 %38 to i32*, !insn.addr !142
  %40 = add i32 %arg3, -8, !insn.addr !142
  %41 = inttoptr i32 %40 to i32*, !insn.addr !142
  %42 = ptrtoint i32* %stack_var_0 to i32, !insn.addr !142
  store i32 %42, i32* %41, align 4, !insn.addr !142
  %43 = add i32 %arg3, -4, !insn.addr !142
  %44 = inttoptr i32 %43 to i32*, !insn.addr !142
  br label %45, !insn.addr !142

; <label>:45:                                     ; preds = %15, %17
  %46 = icmp ne i1 %3, true, !insn.addr !143
  %47 = or i1 %4, %46, !insn.addr !143
  br i1 %47, label %48, label %54, !insn.addr !143

; <label>:48:                                     ; preds = %45
  %49 = mul i32 %6, -1, !insn.addr !143
  %50 = add i32 %49, %arg1
  %51 = inttoptr i32 %50 to i32*, !insn.addr !143
  %52 = add i32 %50, 4, !insn.addr !143
  %53 = inttoptr i32 %52 to i32*, !insn.addr !143
  br label %54, !insn.addr !143

; <label>:54:                                     ; preds = %45, %48
  ret i32 %arg1, !insn.addr !143

; uselistorder directives
  uselistorder i1 %5, { 1, 0 }
  uselistorder i1 %4, { 1, 0 }
  uselistorder i1 %2, { 1, 0 }
  uselistorder i1* %1, { 3, 2, 1, 0 }
  uselistorder i32 %arg3, { 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 0, 2, 1 }
  uselistorder i32 %arg1, { 1, 0, 2, 3, 4 }
  uselistorder label %54, { 1, 0 }
  uselistorder label %45, { 1, 0 }
  uselistorder label %15, { 1, 0 }
}

define i32 @function_f16(i32 %arg1) local_unnamed_addr {
dec_label_pc_f16:
  %0 = alloca i1
  %r0.0.reg2mem = alloca i32, !insn.addr !144
  %1 = load i1, i1* %0
  store i32 %arg1, i32* %r0.0.reg2mem, !insn.addr !144
  br i1 %1, label %2, label %dec_label_pc_f1a, !insn.addr !144

; <label>:2:                                      ; preds = %dec_label_pc_f16
  %3 = call i32 @function_ff87ef9a(), !insn.addr !144
  store i32 %3, i32* %r0.0.reg2mem, !insn.addr !144
  br label %dec_label_pc_f1a, !insn.addr !144

dec_label_pc_f1a:                                 ; preds = %2, %dec_label_pc_f16
  %r0.0.reload = load i32, i32* %r0.0.reg2mem
  ret i32 %r0.0.reload, !insn.addr !145

; uselistorder directives
  uselistorder i32* %r0.0.reg2mem, { 0, 2, 1 }
}

define i32 @function_f22(i32 %arg1, i32 %arg2, i32 %arg3, i32 %arg4) local_unnamed_addr {
dec_label_pc_f22:
  %0 = alloca i32
  %1 = alloca i1
  %merge.reg2mem = alloca i32, !insn.addr !146
  %cpsr_c.0.reg2mem = alloca i1, !insn.addr !146
  %cpsr_z.0.reg2mem = alloca i1, !insn.addr !146
  %cpsr_n.0.reg2mem = alloca i1, !insn.addr !146
  %r0.1.reg2mem = alloca i32, !insn.addr !146
  %r0.0.reg2mem = alloca i32, !insn.addr !146
  %2 = load i1, i1* %1
  %3 = load i1, i1* %1
  %4 = load i32, i32* %0
  %stack_var_0 = alloca i32, align 4
  store i32 %arg1, i32* %r0.0.reg2mem, !insn.addr !146
  br i1 %3, label %5, label %dec_label_pc_f26, !insn.addr !146

; <label>:5:                                      ; preds = %dec_label_pc_f22
  %6 = call i32 @function_ff826f26(), !insn.addr !146
  store i32 %6, i32* %r0.0.reg2mem, !insn.addr !146
  br label %dec_label_pc_f26, !insn.addr !146

dec_label_pc_f26:                                 ; preds = %5, %dec_label_pc_f22
  %r0.0.reload = load i32, i32* %r0.0.reg2mem
  %7 = icmp eq i32 %r0.0.reload, 0, !insn.addr !147
  store i32 %r0.0.reload, i32* %r0.1.reg2mem, !insn.addr !147
  br i1 %7, label %dec_label_pc_f28, label %dec_label_pc_f2c, !insn.addr !147

dec_label_pc_f28:                                 ; preds = %dec_label_pc_f26
  %8 = and i32 %4, 1073741824, !insn.addr !148
  %9 = icmp ne i32 %8, 0, !insn.addr !148
  %10 = icmp slt i32 %4, 0
  %11 = zext i1 %10 to i32, !insn.addr !148
  %12 = icmp eq i1 %10, false, !insn.addr !148
  store i32 %11, i32* %r0.1.reg2mem, !insn.addr !148
  store i1 false, i1* %cpsr_n.0.reg2mem, !insn.addr !148
  store i1 %12, i1* %cpsr_z.0.reg2mem, !insn.addr !148
  store i1 %9, i1* %cpsr_c.0.reg2mem, !insn.addr !148
  br label %dec_label_pc_f2c, !insn.addr !148

dec_label_pc_f2c:                                 ; preds = %dec_label_pc_f28, %dec_label_pc_f26
  %cpsr_c.0.reload = load i1, i1* %cpsr_c.0.reg2mem
  %cpsr_z.0.reload = load i1, i1* %cpsr_z.0.reg2mem
  %r0.1.reload = load i32, i32* %r0.1.reg2mem
  %13 = icmp ne i1 %cpsr_c.0.reload, true, !insn.addr !149
  %14 = or i1 %cpsr_z.0.reload, %13, !insn.addr !149
  store i32 %r0.1.reload, i32* %merge.reg2mem, !insn.addr !149
  br i1 %14, label %15, label %dec_label_pc_f30, !insn.addr !149

; <label>:15:                                     ; preds = %45, %dec_label_pc_f2c
  %merge.reload = load i32, i32* %merge.reg2mem
  ret i32 %merge.reload, !insn.addr !149

dec_label_pc_f30:                                 ; preds = %dec_label_pc_f2c
  %cpsr_n.0.reload = load i1, i1* %cpsr_n.0.reg2mem
  %16 = icmp eq i1 %cpsr_n.0.reload, %2, !insn.addr !150
  br i1 %16, label %17, label %45, !insn.addr !150

; <label>:17:                                     ; preds = %dec_label_pc_f30
  %18 = add i32 %arg3, -52, !insn.addr !150
  %19 = inttoptr i32 %18 to i32*, !insn.addr !150
  store i32 %r0.1.reload, i32* %19, align 4, !insn.addr !150
  %20 = add i32 %arg3, -48, !insn.addr !150
  %21 = inttoptr i32 %20 to i32*, !insn.addr !150
  store i32 %arg3, i32* %21, align 4, !insn.addr !150
  %22 = add i32 %arg3, -44, !insn.addr !150
  %23 = inttoptr i32 %22 to i32*, !insn.addr !150
  store i32 %arg4, i32* %23, align 4, !insn.addr !150
  %24 = add i32 %arg3, -40, !insn.addr !150
  %25 = inttoptr i32 %24 to i32*, !insn.addr !150
  %26 = add i32 %arg3, -36, !insn.addr !150
  %27 = inttoptr i32 %26 to i32*, !insn.addr !150
  %28 = add i32 %arg3, -32, !insn.addr !150
  %29 = inttoptr i32 %28 to i32*, !insn.addr !150
  %30 = add i32 %arg3, -28, !insn.addr !150
  %31 = inttoptr i32 %30 to i32*, !insn.addr !150
  %32 = add i32 %arg3, -24, !insn.addr !150
  %33 = inttoptr i32 %32 to i32*, !insn.addr !150
  %34 = add i32 %arg3, -20, !insn.addr !150
  %35 = inttoptr i32 %34 to i32*, !insn.addr !150
  %36 = add i32 %arg3, -16, !insn.addr !150
  %37 = inttoptr i32 %36 to i32*, !insn.addr !150
  %38 = add i32 %arg3, -12, !insn.addr !150
  %39 = inttoptr i32 %38 to i32*, !insn.addr !150
  %40 = add i32 %arg3, -8, !insn.addr !150
  %41 = inttoptr i32 %40 to i32*, !insn.addr !150
  %42 = ptrtoint i32* %stack_var_0 to i32, !insn.addr !150
  store i32 %42, i32* %41, align 4, !insn.addr !150
  %43 = add i32 %arg3, -4, !insn.addr !150
  %44 = inttoptr i32 %43 to i32*, !insn.addr !150
  store i32 3878, i32* %44, align 4, !insn.addr !150
  br label %45, !insn.addr !150

; <label>:45:                                     ; preds = %17, %dec_label_pc_f30
  %spec.select = select i1 %16, i32 %r0.1.reload, i32 253
  store i32 %spec.select, i32* %merge.reg2mem
  br label %15

; uselistorder directives
  uselistorder i32 %r0.1.reload, { 2, 1, 0 }
  uselistorder i32 %4, { 1, 0 }
  uselistorder i32* %r0.0.reg2mem, { 0, 2, 1 }
  uselistorder i32* %r0.1.reg2mem, { 0, 2, 1 }
  uselistorder i32* %merge.reg2mem, { 1, 0, 2 }
  uselistorder i1* %1, { 1, 0 }
  uselistorder i32 %arg3, { 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 0, 2, 1 }
}

define i32 @Java_org_opalj_fpcf_fixtures_taint_1xlang_TaintTest_propagate_1to_1java_1sink(i32 %arg1, i32 %arg2, i32 %arg3, i32 %arg4) local_unnamed_addr {
dec_label_pc_f3c:
  %0 = alloca i32
  %1 = alloca i1
  %2 = load i1, i1* %1
  %3 = load i1, i1* %1
  %4 = load i1, i1* %1
  %5 = load i1, i1* %1
  %6 = load i32, i32* %0
  %stack_var_0 = alloca i32, align 4
  %7 = icmp ne i1 %5, %2, !insn.addr !151
  %8 = or i1 %4, %7, !insn.addr !151
  br i1 %8, label %9, label %14, !insn.addr !151

; <label>:9:                                      ; preds = %dec_label_pc_f3c
  %10 = add i32 %arg2, -3908, !insn.addr !151
  %11 = inttoptr i32 %10 to i32*, !insn.addr !151
  store i32 %arg1, i32* %11, align 4, !insn.addr !151
  %12 = add i32 %arg2, -3904, !insn.addr !151
  %13 = inttoptr i32 %12 to i32*, !insn.addr !151
  store i32 %arg2, i32* %13, align 4, !insn.addr !151
  br label %14, !insn.addr !151

; <label>:14:                                     ; preds = %dec_label_pc_f3c, %9
  %15 = icmp eq i1 %5, %2, !insn.addr !152
  br i1 %15, label %16, label %44, !insn.addr !152

; <label>:16:                                     ; preds = %14
  %17 = add i32 %arg4, -52, !insn.addr !152
  %18 = inttoptr i32 %17 to i32*, !insn.addr !152
  store i32 %arg1, i32* %18, align 4, !insn.addr !152
  %19 = add i32 %arg4, -48, !insn.addr !152
  %20 = inttoptr i32 %19 to i32*, !insn.addr !152
  store i32 %arg3, i32* %20, align 4, !insn.addr !152
  %21 = add i32 %arg4, -44, !insn.addr !152
  %22 = inttoptr i32 %21 to i32*, !insn.addr !152
  store i32 %arg4, i32* %22, align 4, !insn.addr !152
  %23 = add i32 %arg4, -40, !insn.addr !152
  %24 = inttoptr i32 %23 to i32*, !insn.addr !152
  %25 = add i32 %arg4, -36, !insn.addr !152
  %26 = inttoptr i32 %25 to i32*, !insn.addr !152
  %27 = add i32 %arg4, -32, !insn.addr !152
  %28 = inttoptr i32 %27 to i32*, !insn.addr !152
  %29 = add i32 %arg4, -28, !insn.addr !152
  %30 = inttoptr i32 %29 to i32*, !insn.addr !152
  %31 = add i32 %arg4, -24, !insn.addr !152
  %32 = inttoptr i32 %31 to i32*, !insn.addr !152
  %33 = add i32 %arg4, -20, !insn.addr !152
  %34 = inttoptr i32 %33 to i32*, !insn.addr !152
  %35 = add i32 %arg4, -16, !insn.addr !152
  %36 = inttoptr i32 %35 to i32*, !insn.addr !152
  %37 = add i32 %arg4, -12, !insn.addr !152
  %38 = inttoptr i32 %37 to i32*, !insn.addr !152
  %39 = add i32 %arg4, -8, !insn.addr !152
  %40 = inttoptr i32 %39 to i32*, !insn.addr !152
  %41 = ptrtoint i32* %stack_var_0 to i32, !insn.addr !152
  store i32 %41, i32* %40, align 4, !insn.addr !152
  %42 = add i32 %arg4, -4, !insn.addr !152
  %43 = inttoptr i32 %42 to i32*, !insn.addr !152
  br label %44, !insn.addr !152

; <label>:44:                                     ; preds = %14, %16
  %45 = icmp ne i1 %3, true, !insn.addr !153
  %46 = or i1 %4, %45, !insn.addr !153
  br i1 %46, label %47, label %54, !insn.addr !153

; <label>:47:                                     ; preds = %44
  %48 = mul i32 %6, -1, !insn.addr !153
  %49 = add i32 %48, %arg1
  %50 = inttoptr i32 %49 to i32*, !insn.addr !153
  %51 = add i32 %49, 4, !insn.addr !153
  %52 = inttoptr i32 %51 to i32*, !insn.addr !153
  %53 = ptrtoint i32* %stack_var_0 to i32, !insn.addr !153
  store i32 %53, i32* %52, align 4, !insn.addr !153
  br label %54, !insn.addr !153

; <label>:54:                                     ; preds = %44, %47
  ret i32 %arg1, !insn.addr !153

; uselistorder directives
  uselistorder i1 %5, { 1, 0 }
  uselistorder i1 %4, { 1, 0 }
  uselistorder i1 %2, { 1, 0 }
  uselistorder i1* %1, { 3, 2, 1, 0 }
  uselistorder i32 %arg4, { 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 0, 3, 2, 1 }
  uselistorder i32 %arg2, { 1, 0, 2 }
  uselistorder i32 %arg1, { 1, 0, 2, 3 }
  uselistorder label %54, { 1, 0 }
  uselistorder label %44, { 1, 0 }
  uselistorder label %14, { 1, 0 }
}

define i32 @function_f50() local_unnamed_addr {
dec_label_pc_f50:
  %0 = alloca i32
  %1 = load i32, i32* %0
  ret i32 %1, !insn.addr !154
}

define i32 @function_f56() local_unnamed_addr {
dec_label_pc_f56:
  %0 = alloca i32
  %1 = alloca i1
  %2 = alloca float
  %3 = load i1, i1* %1
  %4 = load i1, i1* %1
  %5 = load float, float* %2
  %6 = load i32, i32* %0
  %7 = load i32, i32* %0
  %brmerge = or i1 %3, %4
  br i1 %brmerge, label %8, label %9, !insn.addr !155

; <label>:8:                                      ; preds = %dec_label_pc_f56, %9
  ret i32 %7, !insn.addr !155

; <label>:9:                                      ; preds = %dec_label_pc_f56
  %10 = add i32 %6, -128, !insn.addr !156
  %11 = inttoptr i32 %10 to i32*, !insn.addr !156
  %12 = load i32, i32* %11, align 4, !insn.addr !156
  call void @__asm_vstrvc.16(float %5, i32 %12), !insn.addr !156
  br label %8, !insn.addr !156

; uselistorder directives
  uselistorder i1* %1, { 1, 0 }
  uselistorder i32* %0, { 1, 0 }
  uselistorder label %8, { 1, 0 }
}

define i32 @function_f64(i32 %arg1, i32 %arg2, i32 %arg3) local_unnamed_addr {
dec_label_pc_f64:
  %0 = alloca i32
  %1 = alloca double
  %2 = load i32, i32* %0
  %3 = load i32, i32* %0
  %4 = load double, double* %1
  %5 = load double, double* %1
  %6 = load double, double* %1
  %7 = load double, double* %1
  %8 = load double, double* %1
  %9 = load double, double* %1
  %10 = load double, double* %1
  %11 = load double, double* %1
  %12 = load double, double* %1
  %13 = load double, double* %1
  %14 = load double, double* %1
  %15 = load double, double* %1
  %16 = load double, double* %1
  %17 = mul i32 %3, 16384, !insn.addr !157
  %18 = udiv i32 %3, 32768, !insn.addr !158
  %19 = add nuw nsw i32 %18, 128, !insn.addr !159
  %20 = inttoptr i32 %19 to i32*, !insn.addr !159
  %21 = load i32, i32* %20, align 4, !insn.addr !159
  call void @__asm_vst2.32(double %16, double %15, double %14, double %13, i32 %21, i32 %2), !insn.addr !159
  %22 = load i32, i32* inttoptr (i32 -698416192 to i32*), align 64, !insn.addr !160
  call void @__asm_vst3.8(double %8, double %6, double %4, i32 %22, i32 %2), !insn.addr !160
  %23 = load i32, i32* inttoptr (i32 -698416064 to i32*), align 64, !insn.addr !161
  call void @__asm_vst2.32(double %8, double %7, double %6, double %5, i32 %23, i32 -698416192), !insn.addr !161
  %24 = load i32, i32* @global_var_3a3, align 4, !insn.addr !162
  %25 = inttoptr i32 %24 to i32*, !insn.addr !163
  %26 = load i32, i32* %25, align 4, !insn.addr !163
  call void @__asm_vst4.8(double %12, double %11, double %10, double %9, i32 %26, i32 %arg3), !insn.addr !163
  store i32 %17, i32* %25, align 4, !insn.addr !164
  %27 = add i32 %24, 4, !insn.addr !164
  %28 = inttoptr i32 %27 to i32*, !insn.addr !164
  %29 = add i32 %24, 8, !insn.addr !164
  ret i32 %29, !insn.addr !165

; uselistorder directives
  uselistorder i32 %24, { 2, 1, 0 }
  uselistorder double* %1, { 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0 }
  uselistorder i32* %0, { 1, 0 }
  uselistorder i32 -698416192, { 2, 1, 0, 3, 4, 5 }
}

define i32 @function_f92(i32 %arg1, i32 %arg2, i32 %arg3, i32 %arg4) local_unnamed_addr {
dec_label_pc_f92:
  %0 = alloca i32
  %1 = alloca double
  %2 = load i32, i32* %0
  %3 = load i32, i32* %0
  %4 = load double, double* %1
  %5 = load double, double* %1
  %6 = load double, double* %1
  %7 = load double, double* %1
  %8 = load double, double* %1
  %9 = load double, double* %1
  %10 = load double, double* %1
  %11 = load double, double* %1
  %12 = load double, double* %1
  %13 = load double, double* %1
  %14 = load double, double* %1
  %15 = load double, double* %1
  %16 = load double, double* %1
  %17 = load double, double* %1
  %18 = shl i32 %3, 31, !insn.addr !166
  %19 = or i32 %18, 128, !insn.addr !167
  %20 = inttoptr i32 %19 to i32*, !insn.addr !167
  %21 = load i32, i32* %20, align 128, !insn.addr !167
  call void @__asm_vst2.32(double %15, double %14, double %13, double %12, i32 %21, i32 %2), !insn.addr !167
  %22 = load i32, i32* inttoptr (i32 -1191178270 to i32*), align 4, !insn.addr !168
  call void @__asm_vst3.8(double %4, double %17, double %16, i32 %22, i32 %2), !insn.addr !168
  %23 = load i32, i32* inttoptr (i32 -1191178142 to i32*), align 4, !insn.addr !169
  call void @__asm_vst2.32(double %11, double %10, double %9, double %8, i32 %23, i32 -1191178270), !insn.addr !169
  call void @__asm_vst2.32(double %7, double %6, double %5, double %4, i32 1600222817, i32 %arg4), !insn.addr !170
  ret i32 1601465961, !insn.addr !170

; uselistorder directives
  uselistorder double %4, { 1, 0 }
  uselistorder double* %1, { 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0 }
  uselistorder i32* %0, { 1, 0 }
  uselistorder i32 -1191178270, { 1, 0, 2 }
}

define i32 @function_fb6(i32 %arg1) local_unnamed_addr {
dec_label_pc_fb6:
  %0 = alloca i32
  %1 = alloca i1
  %r0.0.reg2mem = alloca i32, !insn.addr !171
  %2 = load i1, i1* %1
  %3 = load i1, i1* %1
  %4 = load i32, i32* %0
  br i1 %3, label %5, label %7, !insn.addr !171

; <label>:5:                                      ; preds = %dec_label_pc_fb6
  %6 = call i32 @__asm_qaddeq(i32 %4, i32 %arg1), !insn.addr !171
  br label %7, !insn.addr !171

; <label>:7:                                      ; preds = %dec_label_pc_fb6, %5
  store i32 %arg1, i32* %r0.0.reg2mem, !insn.addr !172
  br i1 %2, label %dec_label_pc_fbe, label %8, !insn.addr !172

; <label>:8:                                      ; preds = %7
  %9 = call i32 @function_fff768be(), !insn.addr !172
  store i32 %9, i32* %r0.0.reg2mem, !insn.addr !172
  br label %dec_label_pc_fbe, !insn.addr !172

dec_label_pc_fbe:                                 ; preds = %7, %8
  %r0.0.reload = load i32, i32* %r0.0.reg2mem
  ret i32 %r0.0.reload, !insn.addr !172

; uselistorder directives
  uselistorder i1* %1, { 1, 0 }
  uselistorder label %dec_label_pc_fbe, { 1, 0 }
  uselistorder label %7, { 1, 0 }
}

define i32 @function_fc0(i32 %arg1, i32 %arg2) local_unnamed_addr {
dec_label_pc_fc0:
  %0 = mul i32 %arg1, 32768, !insn.addr !173
  ret i32 %0, !insn.addr !174
}

define i32 @Java_org_opalj_fpcf_fixtures_taint_1xlang_TaintTest_propagate_1from_1java_1source(i32 %arg1, i32 %arg2, i32 %arg3, i32 %arg4) local_unnamed_addr {
dec_label_pc_fc8:
  %0 = alloca i32
  %1 = alloca i1
  %2 = load i1, i1* %1
  %3 = load i1, i1* %1
  %4 = load i1, i1* %1
  %5 = load i1, i1* %1
  %6 = load i32, i32* %0
  %stack_var_0 = alloca i32, align 4
  %7 = icmp ne i1 %5, %2, !insn.addr !175
  %8 = or i1 %4, %7, !insn.addr !175
  br i1 %8, label %9, label %15, !insn.addr !175

; <label>:9:                                      ; preds = %dec_label_pc_fc8
  %10 = add i32 %arg1, -4048, !insn.addr !175
  %11 = inttoptr i32 %10 to i32*, !insn.addr !175
  %12 = add i32 %arg1, -4044, !insn.addr !175
  %13 = inttoptr i32 %12 to i32*, !insn.addr !175
  %14 = ptrtoint i32* %stack_var_0 to i32, !insn.addr !175
  store i32 %14, i32* %13, align 4, !insn.addr !175
  br label %15, !insn.addr !175

; <label>:15:                                     ; preds = %dec_label_pc_fc8, %9
  %16 = icmp eq i1 %5, %2, !insn.addr !176
  br i1 %16, label %17, label %45, !insn.addr !176

; <label>:17:                                     ; preds = %15
  %18 = add i32 %arg3, -52, !insn.addr !176
  %19 = inttoptr i32 %18 to i32*, !insn.addr !176
  store i32 %arg1, i32* %19, align 4, !insn.addr !176
  %20 = add i32 %arg3, -48, !insn.addr !176
  %21 = inttoptr i32 %20 to i32*, !insn.addr !176
  store i32 %arg3, i32* %21, align 4, !insn.addr !176
  %22 = add i32 %arg3, -44, !insn.addr !176
  %23 = inttoptr i32 %22 to i32*, !insn.addr !176
  store i32 %arg4, i32* %23, align 4, !insn.addr !176
  %24 = add i32 %arg3, -40, !insn.addr !176
  %25 = inttoptr i32 %24 to i32*, !insn.addr !176
  %26 = add i32 %arg3, -36, !insn.addr !176
  %27 = inttoptr i32 %26 to i32*, !insn.addr !176
  %28 = add i32 %arg3, -32, !insn.addr !176
  %29 = inttoptr i32 %28 to i32*, !insn.addr !176
  %30 = add i32 %arg3, -28, !insn.addr !176
  %31 = inttoptr i32 %30 to i32*, !insn.addr !176
  %32 = add i32 %arg3, -24, !insn.addr !176
  %33 = inttoptr i32 %32 to i32*, !insn.addr !176
  %34 = add i32 %arg3, -20, !insn.addr !176
  %35 = inttoptr i32 %34 to i32*, !insn.addr !176
  %36 = add i32 %arg3, -16, !insn.addr !176
  %37 = inttoptr i32 %36 to i32*, !insn.addr !176
  %38 = add i32 %arg3, -12, !insn.addr !176
  %39 = inttoptr i32 %38 to i32*, !insn.addr !176
  %40 = add i32 %arg3, -8, !insn.addr !176
  %41 = inttoptr i32 %40 to i32*, !insn.addr !176
  %42 = ptrtoint i32* %stack_var_0 to i32, !insn.addr !176
  store i32 %42, i32* %41, align 4, !insn.addr !176
  %43 = add i32 %arg3, -4, !insn.addr !176
  %44 = inttoptr i32 %43 to i32*, !insn.addr !176
  br label %45, !insn.addr !176

; <label>:45:                                     ; preds = %15, %17
  %46 = icmp ne i1 %3, true, !insn.addr !177
  %47 = or i1 %4, %46, !insn.addr !177
  br i1 %47, label %48, label %54, !insn.addr !177

; <label>:48:                                     ; preds = %45
  %49 = mul i32 %6, -1, !insn.addr !177
  %50 = add i32 %49, %arg1
  %51 = inttoptr i32 %50 to i32*, !insn.addr !177
  %52 = add i32 %50, 4, !insn.addr !177
  %53 = inttoptr i32 %52 to i32*, !insn.addr !177
  br label %54, !insn.addr !177

; <label>:54:                                     ; preds = %45, %48
  ret i32 %arg1, !insn.addr !177

; uselistorder directives
  uselistorder i1 %5, { 1, 0 }
  uselistorder i1 %4, { 1, 0 }
  uselistorder i1 %2, { 1, 0 }
  uselistorder i1* %1, { 3, 2, 1, 0 }
  uselistorder i32 %arg3, { 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 0, 2, 1 }
  uselistorder i32 %arg1, { 1, 0, 2, 3, 4 }
  uselistorder label %54, { 1, 0 }
  uselistorder label %45, { 1, 0 }
  uselistorder label %15, { 1, 0 }
}

define i32 @function_fd6() local_unnamed_addr {
dec_label_pc_fd6:
  %0 = alloca i1
  %r0.0.reg2mem = alloca i32, !insn.addr !178
  %1 = load i1, i1* %0
  br i1 %1, label %2, label %dec_label_pc_fda, !insn.addr !178

; <label>:2:                                      ; preds = %dec_label_pc_fd6
  %3 = call i32 @function_ff87f05a(), !insn.addr !178
  store i32 %3, i32* %r0.0.reg2mem, !insn.addr !178
  br label %dec_label_pc_fda, !insn.addr !178

dec_label_pc_fda:                                 ; preds = %2, %dec_label_pc_fd6
  %r0.0.reload = load i32, i32* %r0.0.reg2mem
  ret i32 %r0.0.reload, !insn.addr !178
}

define i32 @function_fde() local_unnamed_addr {
dec_label_pc_fde:
  %0 = alloca i32
  %1 = alloca i1
  %2 = alloca float
  %3 = load i1, i1* %1
  %4 = load i1, i1* %1
  %5 = load float, float* %2
  %6 = load i32, i32* %0
  %7 = load i32, i32* %0
  %brmerge = or i1 %3, %4
  br i1 %brmerge, label %8, label %9, !insn.addr !179

; <label>:8:                                      ; preds = %dec_label_pc_fde, %9
  ret i32 %7, !insn.addr !179

; <label>:9:                                      ; preds = %dec_label_pc_fde
  %10 = add i32 %6, -128, !insn.addr !180
  %11 = inttoptr i32 %10 to i32*, !insn.addr !180
  %12 = load i32, i32* %11, align 4, !insn.addr !180
  call void @__asm_vstrvc.16(float %5, i32 %12), !insn.addr !180
  br label %8, !insn.addr !180

; uselistorder directives
  uselistorder i1* %1, { 1, 0 }
  uselistorder i32* %0, { 1, 0 }
  uselistorder label %8, { 1, 0 }
}

define i32 @function_fee(i32 %arg1, i32 %arg2, i32 %arg3) local_unnamed_addr {
dec_label_pc_fee:
  %0 = alloca i32
  %1 = alloca double
  %2 = load i32, i32* %0
  %3 = load i32, i32* %0
  %4 = load double, double* %1
  %5 = load double, double* %1
  %6 = load double, double* %1
  %7 = load double, double* %1
  %8 = load double, double* %1
  %9 = load double, double* %1
  %10 = load double, double* %1
  %11 = load double, double* %1
  %12 = load double, double* %1
  %13 = load double, double* %1
  %14 = load double, double* %1
  %15 = load double, double* %1
  %16 = load double, double* %1
  %17 = load double, double* %1
  %18 = load double, double* %1
  call void @__asm_vst4.8(double %14, double %12, double %10, double %9, i32 %arg1, i32 %arg1), !insn.addr !181
  %19 = shl i32 %3, 31, !insn.addr !182
  %20 = or i32 %19, 128, !insn.addr !183
  %21 = inttoptr i32 %20 to i32*, !insn.addr !183
  %22 = load i32, i32* %21, align 128, !insn.addr !183
  call void @__asm_vst2.32(double %18, double %17, double %16, double %15, i32 %22, i32 %2), !insn.addr !183
  %23 = load i32, i32* inttoptr (i32 -1744830666 to i32*), align 4, !insn.addr !184
  call void @__asm_vst3.8(double %8, double %6, double %4, i32 %23, i32 %2), !insn.addr !184
  %24 = load i32, i32* inttoptr (i32 -1744830538 to i32*), align 4, !insn.addr !185
  call void @__asm_vst2.32(double %8, double %7, double %6, double %5, i32 %24, i32 -1744830666), !insn.addr !185
  call void @__asm_vst4.8(double %14, double %13, double %12, double %11, i32 1735287148, i32 %arg3), !insn.addr !186
  ret i32 1735287148, !insn.addr !187

; uselistorder directives
  uselistorder double %14, { 1, 0 }
  uselistorder double %12, { 1, 0 }
  uselistorder double* %1, { 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0 }
  uselistorder i32* %0, { 1, 0 }
  uselistorder i32 -1744830666, { 1, 0, 2 }
  uselistorder i32 %arg1, { 1, 0 }
}

define i32 @function_101a(i32 %arg1, i32 %arg2) local_unnamed_addr {
dec_label_pc_101a:
  %0 = alloca i32
  %1 = alloca double
  %2 = load i32, i32* %0
  %3 = load i32, i32* %0
  %4 = load double, double* %1
  %5 = load double, double* %1
  %6 = load double, double* %1
  %7 = load double, double* %1
  %8 = load double, double* %1
  %9 = load double, double* %1
  %10 = load double, double* %1
  %11 = load double, double* %1
  %12 = load double, double* %1
  %13 = load double, double* %1
  %14 = load double, double* %1
  %15 = mul i32 %3, 32768, !insn.addr !188
  %16 = or i32 %15, 128, !insn.addr !189
  %17 = inttoptr i32 %16 to i32*, !insn.addr !189
  %18 = load i32, i32* %17, align 128, !insn.addr !189
  call void @__asm_vst2.32(double %13, double %12, double %11, double %10, i32 %18, i32 %2), !insn.addr !189
  %19 = load i32, i32* inttoptr (i32 -1191179296 to i32*), align 32, !insn.addr !190
  call void @__asm_vst3.8(double %5, double %4, double %14, i32 %19, i32 %2), !insn.addr !190
  %20 = load i32, i32* inttoptr (i32 -1191179168 to i32*), align 32, !insn.addr !191
  call void @__asm_vst2.32(double %9, double %8, double %7, double %6, i32 %20, i32 -1191179296), !insn.addr !191
  %21 = load i32, i32* @global_var_457, align 4, !insn.addr !192
  ret i32 %21, !insn.addr !192

; uselistorder directives
  uselistorder double* %1, { 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0 }
  uselistorder i32* %0, { 1, 0 }
  uselistorder i32 -1191179296, { 1, 0, 2 }
}

define i32 @function_1038(i32 %arg1, i32 %arg2, i32 %arg3, i32 %arg4) local_unnamed_addr {
dec_label_pc_1038:
  %0 = alloca i32
  %1 = alloca double
  %2 = load i32, i32* %0
  %3 = load i32, i32* %0
  %4 = load double, double* %1
  %5 = load double, double* %1
  %6 = load double, double* %1
  %7 = load double, double* %1
  %stack_var_264 = alloca i32, align 4
  %8 = mul i32 %3, 32768, !insn.addr !193
  call void @__asm_vst4.8(double %7, double %6, double %5, double %4, i32 %arg1, i32 %arg1), !insn.addr !194
  %9 = add i32 %2, 15, !insn.addr !195
  %10 = inttoptr i32 %9 to i8*, !insn.addr !195
  %11 = load i8, i8* %10, align 1, !insn.addr !195
  %12 = zext i8 %11 to i32, !insn.addr !195
  %13 = inttoptr i32 %arg4 to i32*, !insn.addr !196
  store i32 %arg1, i32* %13, align 4, !insn.addr !196
  %14 = add i32 %arg4, 4, !insn.addr !196
  %15 = inttoptr i32 %14 to i32*, !insn.addr !196
  %16 = ptrtoint i32* %stack_var_264 to i32, !insn.addr !196
  store i32 %16, i32* %15, align 4, !insn.addr !196
  %17 = add i32 %arg4, 8, !insn.addr !196
  %18 = inttoptr i32 %17 to i32*, !insn.addr !196
  store i32 %8, i32* %18, align 4, !insn.addr !196
  %19 = add i32 %arg4, 12, !insn.addr !196
  %20 = inttoptr i32 %19 to i32*, !insn.addr !196
  store i32 %arg4, i32* %20, align 4, !insn.addr !196
  %21 = add i32 %arg4, 16, !insn.addr !196
  %22 = inttoptr i32 %21 to i32*, !insn.addr !196
  %23 = add i32 %arg4, 20, !insn.addr !196
  %24 = inttoptr i32 %23 to i32*, !insn.addr !196
  store i32 %12, i32* %24, align 4, !insn.addr !196
  %25 = add i32 %arg4, 24, !insn.addr !196
  %26 = inttoptr i32 %25 to i32*, !insn.addr !196
  %27 = add i32 %arg4, 28, !insn.addr !196
  %28 = inttoptr i32 %27 to i32*, !insn.addr !196
  %29 = mul i32 %arg1, 32768, !insn.addr !197
  ret i32 %29, !insn.addr !198

; uselistorder directives
  uselistorder double* %1, { 3, 2, 1, 0 }
  uselistorder i32* %0, { 1, 0 }
  uselistorder i32 16, { 1, 2, 0, 3 }
  uselistorder i32 8, { 1, 2, 3, 4, 0 }
  uselistorder i32 %arg4, { 7, 6, 5, 4, 8, 3, 2, 1, 0 }
  uselistorder i32 %arg1, { 0, 3, 2, 1 }
}

define i32 @Java_org_opalj_fpcf_fixtures_taint_1xlang_TaintTest_propagate_1java_1sanitize(i32 %arg1, i32 %arg2, i32 %arg3, i32 %arg4) local_unnamed_addr {
dec_label_pc_104c:
  %0 = alloca i32
  %1 = alloca i1
  %2 = load i1, i1* %1
  %3 = load i1, i1* %1
  %4 = load i1, i1* %1
  %5 = load i1, i1* %1
  %6 = load i32, i32* %0
  %stack_var_0 = alloca i32, align 4
  %7 = icmp ne i1 %5, %2, !insn.addr !199
  %8 = or i1 %4, %7, !insn.addr !199
  br i1 %8, label %9, label %14, !insn.addr !199

; <label>:9:                                      ; preds = %dec_label_pc_104c
  %10 = add i32 %arg2, -4180, !insn.addr !199
  %11 = inttoptr i32 %10 to i32*, !insn.addr !199
  store i32 %arg1, i32* %11, align 4, !insn.addr !199
  %12 = add i32 %arg2, -4176, !insn.addr !199
  %13 = inttoptr i32 %12 to i32*, !insn.addr !199
  store i32 %arg2, i32* %13, align 4, !insn.addr !199
  br label %14, !insn.addr !199

; <label>:14:                                     ; preds = %dec_label_pc_104c, %9
  %15 = icmp eq i1 %5, %2, !insn.addr !200
  br i1 %15, label %16, label %44, !insn.addr !200

; <label>:16:                                     ; preds = %14
  %17 = add i32 %arg4, -52, !insn.addr !200
  %18 = inttoptr i32 %17 to i32*, !insn.addr !200
  store i32 %arg1, i32* %18, align 4, !insn.addr !200
  %19 = add i32 %arg4, -48, !insn.addr !200
  %20 = inttoptr i32 %19 to i32*, !insn.addr !200
  store i32 %arg3, i32* %20, align 4, !insn.addr !200
  %21 = add i32 %arg4, -44, !insn.addr !200
  %22 = inttoptr i32 %21 to i32*, !insn.addr !200
  store i32 %arg4, i32* %22, align 4, !insn.addr !200
  %23 = add i32 %arg4, -40, !insn.addr !200
  %24 = inttoptr i32 %23 to i32*, !insn.addr !200
  %25 = add i32 %arg4, -36, !insn.addr !200
  %26 = inttoptr i32 %25 to i32*, !insn.addr !200
  %27 = add i32 %arg4, -32, !insn.addr !200
  %28 = inttoptr i32 %27 to i32*, !insn.addr !200
  %29 = add i32 %arg4, -28, !insn.addr !200
  %30 = inttoptr i32 %29 to i32*, !insn.addr !200
  %31 = add i32 %arg4, -24, !insn.addr !200
  %32 = inttoptr i32 %31 to i32*, !insn.addr !200
  %33 = add i32 %arg4, -20, !insn.addr !200
  %34 = inttoptr i32 %33 to i32*, !insn.addr !200
  %35 = add i32 %arg4, -16, !insn.addr !200
  %36 = inttoptr i32 %35 to i32*, !insn.addr !200
  %37 = add i32 %arg4, -12, !insn.addr !200
  %38 = inttoptr i32 %37 to i32*, !insn.addr !200
  %39 = add i32 %arg4, -8, !insn.addr !200
  %40 = inttoptr i32 %39 to i32*, !insn.addr !200
  %41 = ptrtoint i32* %stack_var_0 to i32, !insn.addr !200
  store i32 %41, i32* %40, align 4, !insn.addr !200
  %42 = add i32 %arg4, -4, !insn.addr !200
  %43 = inttoptr i32 %42 to i32*, !insn.addr !200
  br label %44, !insn.addr !200

; <label>:44:                                     ; preds = %14, %16
  %45 = icmp ne i1 %3, true, !insn.addr !201
  %46 = or i1 %4, %45, !insn.addr !201
  br i1 %46, label %47, label %54, !insn.addr !201

; <label>:47:                                     ; preds = %44
  %48 = mul i32 %6, -1, !insn.addr !201
  %49 = add i32 %48, %arg1
  %50 = inttoptr i32 %49 to i32*, !insn.addr !201
  %51 = add i32 %49, 4, !insn.addr !201
  %52 = inttoptr i32 %51 to i32*, !insn.addr !201
  %53 = ptrtoint i32* %stack_var_0 to i32, !insn.addr !201
  store i32 %53, i32* %52, align 4, !insn.addr !201
  br label %54, !insn.addr !201

; <label>:54:                                     ; preds = %44, %47
  ret i32 %arg1, !insn.addr !201

; uselistorder directives
  uselistorder i1 %5, { 1, 0 }
  uselistorder i1 %4, { 1, 0 }
  uselistorder i1 %2, { 1, 0 }
  uselistorder i1* %1, { 3, 2, 1, 0 }
  uselistorder i32 4, { 0, 12, 1, 13, 2, 3, 14, 4, 5, 6, 15, 7, 16, 8, 9, 10, 17, 11 }
  uselistorder i32 -1, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 12, 13, 14, 11 }
  uselistorder i32 %arg4, { 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 0, 3, 2, 1 }
  uselistorder i32 %arg2, { 1, 0, 2 }
  uselistorder i32 %arg1, { 1, 0, 2, 3 }
  uselistorder label %54, { 1, 0 }
  uselistorder label %44, { 1, 0 }
  uselistorder label %14, { 1, 0 }
}

define i32 @function_1060() local_unnamed_addr {
dec_label_pc_1060:
  %0 = alloca i32
  %1 = load i32, i32* %0
  ret i32 %1, !insn.addr !202
}

define i32 @function_1066() local_unnamed_addr {
dec_label_pc_1066:
  %0 = alloca i32
  %1 = alloca i1
  %2 = alloca float
  %3 = load i1, i1* %1
  %4 = load i1, i1* %1
  %5 = load float, float* %2
  %6 = load i32, i32* %0
  %7 = load i32, i32* %0
  %brmerge = or i1 %3, %4
  br i1 %brmerge, label %8, label %9, !insn.addr !203

; <label>:8:                                      ; preds = %dec_label_pc_1066, %9
  ret i32 %7, !insn.addr !203

; <label>:9:                                      ; preds = %dec_label_pc_1066
  %10 = add i32 %6, -128, !insn.addr !204
  %11 = inttoptr i32 %10 to i32*, !insn.addr !204
  %12 = load i32, i32* %11, align 4, !insn.addr !204
  call void @__asm_vstrvc.16(float %5, i32 %12), !insn.addr !204
  br label %8, !insn.addr !204

; uselistorder directives
  uselistorder i1* %1, { 1, 0 }
  uselistorder i32* %0, { 1, 0 }
  uselistorder label %8, { 1, 0 }
}

define i32 @function_1076() local_unnamed_addr {
dec_label_pc_1076:
  %0 = alloca i32
  %1 = load i32, i32* %0
  ret i32 %1, !insn.addr !205
}

define i32 @function_1082() local_unnamed_addr {
dec_label_pc_1082:
  %0 = alloca i32
  %1 = load i32, i32* %0
  ret i32 %1, !insn.addr !206
}

define i32 @function_108a(i32 %arg1, i32 %arg2, i32 %arg3, i32 %arg4) local_unnamed_addr {
dec_label_pc_108a:
  %0 = alloca i32
  %1 = alloca i1
  %merge.reg2mem = alloca i32, !insn.addr !207
  %2 = load i1, i1* %1
  %3 = load i1, i1* %1
  %4 = load i1, i1* %1
  %5 = load i32, i32* %0
  %6 = icmp ne i1 %3, true, !insn.addr !207
  %7 = icmp eq i1 %2, %6, !insn.addr !207
  store i32 %arg1, i32* %merge.reg2mem, !insn.addr !207
  br i1 %7, label %8, label %dec_label_pc_108e, !insn.addr !207

; <label>:8:                                      ; preds = %dec_label_pc_1092.thread, %dec_label_pc_1092, %10, %dec_label_pc_108a
  %merge.reload = load i32, i32* %merge.reg2mem
  ret i32 %merge.reload, !insn.addr !207

dec_label_pc_108e:                                ; preds = %dec_label_pc_108a
  br i1 %3, label %dec_label_pc_1092.thread, label %dec_label_pc_1092, !insn.addr !208

dec_label_pc_1092.thread:                         ; preds = %dec_label_pc_108e
  %9 = call i32 @function_ff87f212(), !insn.addr !208
  store i32 %9, i32* %merge.reg2mem
  br label %8

dec_label_pc_1092:                                ; preds = %dec_label_pc_108e
  store i32 %arg1, i32* %merge.reg2mem, !insn.addr !209
  br i1 %4, label %8, label %10, !insn.addr !209

; <label>:10:                                     ; preds = %dec_label_pc_1092
  call void @__asm_mcrrpl(i32 0, i32 0, i32 %5, i32 %arg3, i32 0), !insn.addr !210
  store i32 %arg1, i32* %merge.reg2mem, !insn.addr !210
  br label %8, !insn.addr !210

; uselistorder directives
  uselistorder i32* %merge.reg2mem, { 2, 3, 1, 0, 4 }
  uselistorder i1* %1, { 2, 1, 0 }
  uselistorder i32 0, { 5, 6, 7, 0, 8, 9, 10, 11, 1, 12, 2, 3, 4 }
  uselistorder label %8, { 2, 1, 0, 3 }
}

define i32 @function_109e(i32 %arg1) local_unnamed_addr {
dec_label_pc_109e:
  ret i32 %arg1, !insn.addr !211
}

define i32 @function_10a2(i32 %arg1, i32 %arg2) local_unnamed_addr {
dec_label_pc_10a2:
  %0 = alloca i32
  %1 = alloca i1
  %2 = alloca double
  %3 = load i1, i1* %1
  %4 = load i32, i32* %0
  %5 = load i32, i32* %0
  %6 = load double, double* %2
  %7 = load double, double* %2
  %8 = load double, double* %2
  %9 = load double, double* %2
  %10 = load double, double* %2
  %11 = load double, double* %2
  %12 = load double, double* %2
  %13 = load double, double* %2
  %14 = load double, double* %2
  %15 = load double, double* %2
  %16 = load double, double* %2
  br i1 %3, label %17, label %dec_label_pc_10a8, !insn.addr !212

; <label>:17:                                     ; preds = %dec_label_pc_10a2
  %18 = call i32 @function_1128(), !insn.addr !212
  br label %dec_label_pc_10a8, !insn.addr !212

dec_label_pc_10a8:                                ; preds = %17, %dec_label_pc_10a2
  %19 = shl i32 %5, 31, !insn.addr !213
  %20 = or i32 %19, 128, !insn.addr !214
  %21 = inttoptr i32 %20 to i32*, !insn.addr !214
  %22 = load i32, i32* %21, align 128, !insn.addr !214
  call void @__asm_vst2.32(double %15, double %14, double %13, double %12, i32 %22, i32 %4), !insn.addr !214
  %23 = load i32, i32* inttoptr (i32 -127990879 to i32*), align 4, !insn.addr !215
  call void @__asm_vst3.8(double %7, double %6, double %16, i32 %23, i32 %4), !insn.addr !215
  %24 = load i32, i32* inttoptr (i32 -127990751 to i32*), align 4, !insn.addr !216
  call void @__asm_vst2.32(double %11, double %10, double %9, double %8, i32 %24, i32 -127990879), !insn.addr !216
  ret i32 151060665, !insn.addr !217

; uselistorder directives
  uselistorder double* %2, { 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0 }
  uselistorder i32* %0, { 1, 0 }
  uselistorder i32 -127990879, { 1, 0, 2 }
  uselistorder i32 128, { 1, 2, 3, 4, 5, 0 }
  uselistorder i32 31, { 3, 4, 5, 1, 2, 0 }
}

define i32 @function_10c4(i32 %arg1, i32 %arg2, i32 %arg3, i32 %arg4) local_unnamed_addr {
dec_label_pc_10c4:
  %0 = alloca i1
  %merge.reg2mem = alloca i32, !insn.addr !218
  %1 = load i1, i1* %0
  %2 = load i1, i1* %0
  %3 = load i1, i1* %0
  %stack_var_0 = alloca i32, align 4
  %4 = icmp eq i1 %3, %1, !insn.addr !218
  br i1 %4, label %dec_label_pc_10c8, label %5, !insn.addr !218

; <label>:5:                                      ; preds = %dec_label_pc_10c8, %dec_label_pc_10c4
  %merge.reload = load i32, i32* %merge.reg2mem
  ret i32 %merge.reload, !insn.addr !218

dec_label_pc_10c8:                                ; preds = %dec_label_pc_10c4
  %spec.select = select i1 %2, i32 -1862204417, i32 %arg1
  %6 = add i32 %arg4, -52, !insn.addr !219
  %7 = inttoptr i32 %6 to i32*, !insn.addr !219
  store i32 %spec.select, i32* %7, align 4, !insn.addr !219
  %8 = add i32 %arg4, -48, !insn.addr !219
  %9 = inttoptr i32 %8 to i32*, !insn.addr !219
  store i32 %arg3, i32* %9, align 4, !insn.addr !219
  %10 = add i32 %arg4, -44, !insn.addr !219
  %11 = inttoptr i32 %10 to i32*, !insn.addr !219
  store i32 %arg4, i32* %11, align 4, !insn.addr !219
  %12 = add i32 %arg4, -40, !insn.addr !219
  %13 = inttoptr i32 %12 to i32*, !insn.addr !219
  %14 = add i32 %arg4, -36, !insn.addr !219
  %15 = inttoptr i32 %14 to i32*, !insn.addr !219
  %16 = add i32 %arg4, -32, !insn.addr !219
  %17 = inttoptr i32 %16 to i32*, !insn.addr !219
  %18 = add i32 %arg4, -28, !insn.addr !219
  %19 = inttoptr i32 %18 to i32*, !insn.addr !219
  %20 = add i32 %arg4, -24, !insn.addr !219
  %21 = inttoptr i32 %20 to i32*, !insn.addr !219
  %22 = add i32 %arg4, -20, !insn.addr !219
  %23 = inttoptr i32 %22 to i32*, !insn.addr !219
  %24 = add i32 %arg4, -16, !insn.addr !219
  %25 = inttoptr i32 %24 to i32*, !insn.addr !219
  %26 = add i32 %arg4, -12, !insn.addr !219
  %27 = inttoptr i32 %26 to i32*, !insn.addr !219
  %28 = add i32 %arg4, -8, !insn.addr !219
  %29 = inttoptr i32 %28 to i32*, !insn.addr !219
  %30 = ptrtoint i32* %stack_var_0 to i32, !insn.addr !219
  store i32 %30, i32* %29, align 4, !insn.addr !219
  %31 = add i32 %arg4, -4, !insn.addr !219
  %32 = inttoptr i32 %31 to i32*, !insn.addr !219
  store i32 %spec.select, i32* %merge.reg2mem, !insn.addr !219
  br label %5, !insn.addr !219

; uselistorder directives
  uselistorder i32* %merge.reg2mem, { 1, 0 }
  uselistorder i1* %0, { 2, 1, 0 }
  uselistorder i32 -4, { 0, 1, 2, 3, 4, 5, 6, 7, 10, 9, 8, 11, 12, 13, 15, 14, 16, 17, 18, 19, 20, 21, 23, 22, 24, 25 }
  uselistorder i32 -8, { 0, 1, 2, 3, 4, 5, 6, 7, 10, 9, 8, 11, 12, 13, 15, 14, 16, 17, 18, 19, 20, 21, 23, 22, 24, 25 }
  uselistorder i32 -12, { 0, 1, 2, 3, 4, 5, 6, 7, 10, 9, 8, 11, 12, 13, 15, 14, 16, 17, 18, 19, 20, 21, 23, 22, 24, 25 }
  uselistorder i32 -16, { 0, 1, 2, 3, 4, 5, 6, 7, 10, 9, 8, 11, 12, 13, 15, 14, 16, 17, 18, 19, 20, 21, 23, 22, 24, 25 }
  uselistorder i32 -20, { 0, 1, 2, 3, 4, 5, 6, 7, 10, 9, 8, 11, 12, 13, 15, 14, 16, 17, 18, 19, 20, 21, 23, 22, 24, 25 }
  uselistorder i32 -24, { 0, 1, 2, 3, 4, 5, 6, 7, 10, 9, 8, 11, 12, 13, 15, 14, 16, 17, 18, 19, 20, 21, 23, 22, 24, 25 }
  uselistorder i32 -28, { 0, 1, 2, 3, 4, 5, 6, 7, 9, 8, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 21, 20, 22, 23 }
  uselistorder i32 -32, { 0, 1, 2, 3, 4, 5, 7, 6, 8, 9, 10, 11, 12, 13, 14, 15, 16, 18, 17, 19, 20 }
  uselistorder i32 %arg4, { 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 0, 3, 2, 1 }
}

define i32 @function_10d4(i32 %arg1) local_unnamed_addr {
dec_label_pc_10d4:
  %0 = mul i32 %arg1, 32768, !insn.addr !220
  ret i32 %0, !insn.addr !221
}

define i32 @source(i32 %arg1) local_unnamed_addr {
dec_label_pc_10d8:
  %0 = alloca i1
  %1 = load i1, i1* %0
  %2 = load i1, i1* %0
  %3 = load i1, i1* %0
  %4 = add i32 %arg1, 64
  %spec.select = select i1 %3, i32 %arg1, i32 %4
  %5 = icmp ne i1 %3, %1, !insn.addr !222
  %6 = or i1 %2, %5, !insn.addr !222
  %r0.1 = select i1 %6, i32 253, i32 %spec.select
  ret i32 %r0.1, !insn.addr !222

; uselistorder directives
  uselistorder i1* %0, { 2, 1, 0 }
  uselistorder i32 253, { 3, 0, 4, 5, 1, 2, 6 }
  uselistorder i32 64, { 1, 0 }
}

define i32 @_fini() local_unnamed_addr {
dec_label_pc_10e0:
  %0 = alloca i32
  %1 = alloca i1
  %2 = load i1, i1* %1
  %3 = load i1, i1* %1
  %4 = load i32, i32* %0
  %5 = icmp eq i1 %3, %2, !insn.addr !223
  br i1 %5, label %6, label %dec_label_pc_10e4, !insn.addr !223

; <label>:6:                                      ; preds = %dec_label_pc_10e0
  %7 = call i32 @function_111c(), !insn.addr !223
  ret i32 %7, !insn.addr !223

dec_label_pc_10e4:                                ; preds = %dec_label_pc_10e0
  ret i32 %4, !insn.addr !223

; uselistorder directives
  uselistorder i1* %1, { 1, 0 }
}

define i32 @function_10e6() local_unnamed_addr {
dec_label_pc_10e6:
  %0 = alloca i1
  %r0.0.reg2mem = alloca i32, !insn.addr !224
  %1 = load i1, i1* %0
  %stack_var_772 = alloca i32, align 4
  br i1 %1, label %5, label %dec_label_pc_10ea, !insn.addr !224

dec_label_pc_10ea:                                ; preds = %dec_label_pc_10e6
  %2 = call i32 @function_fff654ee(), !insn.addr !224
  %3 = ptrtoint i32* %stack_var_772 to i32, !insn.addr !225
  %4 = mul i32 %3, 32768, !insn.addr !226
  store i32 %4, i32* %r0.0.reg2mem
  br label %dec_label_pc_10f0

; <label>:5:                                      ; preds = %dec_label_pc_10e6
  %6 = call i32 @function_11b0(), !insn.addr !227
  store i32 %6, i32* %r0.0.reg2mem, !insn.addr !227
  br label %dec_label_pc_10f0, !insn.addr !227

dec_label_pc_10f0:                                ; preds = %dec_label_pc_10ea, %5
  %r0.0.reload = load i32, i32* %r0.0.reg2mem
  ret i32 %r0.0.reload, !insn.addr !227

; uselistorder directives
  uselistorder i32* %r0.0.reg2mem, { 0, 2, 1 }
  uselistorder i32 32768, { 0, 1, 2, 3, 4, 5, 9, 6, 7, 8, 10 }
  uselistorder label %dec_label_pc_10f0, { 1, 0 }
}

define i32 @function_110c() local_unnamed_addr {
dec_label_pc_110c:
  %0 = alloca i32
  %1 = load i32, i32* %0
  ret i32 %1
}

define i32 @function_111c() local_unnamed_addr {
dec_label_pc_111c:
  %0 = alloca i32
  %1 = load i32, i32* %0
  ret i32 %1
}

define i32 @function_1128() local_unnamed_addr {
dec_label_pc_1128:
  %0 = alloca i32
  %1 = load i32, i32* %0
  ret i32 %1
}

define i32 @function_1198() local_unnamed_addr {
dec_label_pc_1198:
  %0 = alloca i32
  %1 = load i32, i32* %0
  ret i32 %1
}

define i32 @function_11b0() local_unnamed_addr {
dec_label_pc_11b0:
  %0 = alloca i32
  %1 = load i32, i32* %0
  ret i32 %1
}

define i32 @function_81c68() local_unnamed_addr {
dec_label_pc_81c68:
  %0 = alloca i32
  %1 = load i32, i32* %0
  ret i32 %1
}

define i32 @function_241128() local_unnamed_addr {
dec_label_pc_241128:
  %0 = alloca i32
  %1 = load i32, i32* %0
  ret i32 %1
}

declare i32 @unknown_42f2a() local_unnamed_addr

define i32 @function_7c1e50() local_unnamed_addr {
dec_label_pc_7c1e50:
  %0 = alloca i32
  %1 = load i32, i32* %0
  ret i32 %1
}

define i32 @function_1c210c94() local_unnamed_addr {
dec_label_pc_1c210c94:
  %0 = alloca i32
  %1 = load i32, i32* %0
  ret i32 %1
}

define i32 @function_d10083ff() local_unnamed_addr {
dec_label_pc_d10083ff:
  %0 = alloca i32
  %1 = load i32, i32* %0
  ret i32 %1
}

define i32 @function_fe043d94() local_unnamed_addr {
dec_label_pc_fe043d94:
  %0 = alloca i32
  %1 = load i32, i32* %0
  ret i32 %1
}

define i32 @function_ff826f26() local_unnamed_addr {
dec_label_pc_ff826f26:
  %0 = alloca i32
  %1 = load i32, i32* %0
  ret i32 %1
}

define i32 @function_ff83697e() local_unnamed_addr {
dec_label_pc_ff83697e:
  %0 = alloca i32
  %1 = load i32, i32* %0
  ret i32 %1
}

define i32 @function_ff87ede6() local_unnamed_addr {
dec_label_pc_ff87ede6:
  %0 = alloca i32
  %1 = load i32, i32* %0
  ret i32 %1
}

define i32 @function_ff87ee2a() local_unnamed_addr {
dec_label_pc_ff87ee2a:
  %0 = alloca i32
  %1 = load i32, i32* %0
  ret i32 %1
}

define i32 @function_ff87ee86() local_unnamed_addr {
dec_label_pc_ff87ee86:
  %0 = alloca i32
  %1 = load i32, i32* %0
  ret i32 %1
}

define i32 @function_ff87eece() local_unnamed_addr {
dec_label_pc_ff87eece:
  %0 = alloca i32
  %1 = load i32, i32* %0
  ret i32 %1
}

define i32 @function_ff87ef1a() local_unnamed_addr {
dec_label_pc_ff87ef1a:
  %0 = alloca i32
  %1 = load i32, i32* %0
  ret i32 %1
}

define i32 @function_ff87ef66() local_unnamed_addr {
dec_label_pc_ff87ef66:
  %0 = alloca i32
  %1 = load i32, i32* %0
  ret i32 %1
}

define i32 @function_ff87ef9a() local_unnamed_addr {
dec_label_pc_ff87ef9a:
  %0 = alloca i32
  %1 = load i32, i32* %0
  ret i32 %1
}

define i32 @function_ff87f05a() local_unnamed_addr {
dec_label_pc_ff87f05a:
  %0 = alloca i32
  %1 = load i32, i32* %0
  ret i32 %1
}

define i32 @function_ff87f212() local_unnamed_addr {
dec_label_pc_ff87f212:
  %0 = alloca i32
  %1 = load i32, i32* %0
  ret i32 %1
}

define i32 @function_ff8ef11a() local_unnamed_addr {
dec_label_pc_ff8ef11a:
  %0 = alloca i32
  %1 = load i32, i32* %0
  ret i32 %1
}

define i32 @function_ff8ef212() local_unnamed_addr {
dec_label_pc_ff8ef212:
  %0 = alloca i32
  %1 = load i32, i32* %0
  ret i32 %1
}

define i32 @function_ffa6f222() local_unnamed_addr {
dec_label_pc_ffa6f222:
  %0 = alloca i32
  %1 = load i32, i32* %0
  ret i32 %1
}

define i32 @function_ffa6f326() local_unnamed_addr {
dec_label_pc_ffa6f326:
  %0 = alloca i32
  %1 = load i32, i32* %0
  ret i32 %1
}

define i32 @function_fff654ee() local_unnamed_addr {
dec_label_pc_fff654ee:
  %0 = alloca i32
  %1 = load i32, i32* %0
  ret i32 %1
}

define i32 @function_fff66efe() local_unnamed_addr {
dec_label_pc_fff66efe:
  %0 = alloca i32
  %1 = load i32, i32* %0
  ret i32 %1
}

define i32 @function_fff768be() local_unnamed_addr {
dec_label_pc_fff768be:
  %0 = alloca i32
  %1 = load i32, i32* %0
  ret i32 %1
}

define i32 @function_fff7f1f6() local_unnamed_addr {
dec_label_pc_fff7f1f6:
  %0 = alloca i32
  %1 = load i32, i32* %0
  ret i32 %1

; uselistorder directives
  uselistorder i32 1, { 70, 69, 68, 67, 66, 65, 64, 63, 62, 61, 60, 59, 58, 57, 56, 55, 54, 53, 52, 51, 50, 49, 48, 47, 46, 45, 44, 43, 42, 41, 174, 137, 126, 125, 40, 124, 175, 138, 123, 133, 122, 39, 139, 121, 38, 37, 36, 136, 120, 35, 34, 176, 119, 33, 177, 132, 32, 131, 31, 130, 30, 135, 118, 29, 140, 117, 178, 116, 28, 141, 115, 27, 129, 26, 128, 25, 134, 114, 24, 23, 179, 113, 22, 180, 147, 146, 145, 144, 143, 142, 112, 21, 148, 111, 181, 110, 20, 149, 109, 108, 150, 107, 182, 106, 152, 151, 105, 183, 104, 153, 103, 184, 102, 101, 100, 154, 99, 185, 98, 19, 186, 155, 97, 156, 96, 157, 95, 18, 187, 94, 17, 188, 158, 93, 189, 92, 16, 190, 91, 15, 159, 90, 191, 89, 14, 88, 192, 160, 87, 161, 86, 193, 85, 13, 12, 194, 84, 11, 10, 163, 162, 83, 164, 82, 9, 8, 81, 80, 79, 127, 7, 166, 165, 78, 6, 167, 77, 76, 169, 168, 75, 5, 4, 3, 171, 170, 74, 2, 172, 73, 1, 72, 173, 71, 0 }
}

declare i32 @__asm_mrsls(i32) local_unnamed_addr

declare void @__asm_vst4.32(double, double, double, double, i32, i32) local_unnamed_addr

declare void @__asm_svceq(i32) local_unnamed_addr

declare i32 @__asm_movhi(i32, i32) local_unnamed_addr

declare i32 @__asm_qaddeq(i32, i32) local_unnamed_addr

declare void @__asm_vstrvc.16(float, i32) local_unnamed_addr

declare void @__asm_vst2.32(double, double, double, double, i32, i32) local_unnamed_addr

declare void @__asm_vst3.8(double, double, double, i32, i32) local_unnamed_addr

declare void @__asm_vst4.8(double, double, double, double, i32, i32) local_unnamed_addr

declare void @__asm_mcrrpl(i32, i32, i32, i32, i32) local_unnamed_addr

!0 = !{i64 1424}
!1 = !{i64 1438}
!2 = !{i64 2912}
!3 = !{i64 2972}
!4 = !{i64 2916}
!5 = !{i64 2920}
!6 = !{i64 2928}
!7 = !{i64 3104}
!8 = !{i64 3110}
!9 = !{i64 3116}
!10 = !{i64 3124}
!11 = !{i64 3134}
!12 = !{i64 3136}
!13 = !{i64 3140}
!14 = !{i64 3144}
!15 = !{i64 3158}
!16 = !{i64 3164}
!17 = !{i64 3166}
!18 = !{i64 3182}
!19 = !{i64 3184}
!20 = !{i64 3188}
!21 = !{i64 3192}
!22 = !{i64 3200}
!23 = !{i64 3208}
!24 = !{i64 3212}
!25 = !{i64 3220}
!26 = !{i64 3224}
!27 = !{i64 3228}
!28 = !{i64 3232}
!29 = !{i64 3236}
!30 = !{i64 3248}
!31 = !{i64 3252}
!32 = !{i64 3256}
!33 = !{i64 3258}
!34 = !{i64 3268}
!35 = !{i64 3274}
!36 = !{i64 3278}
!37 = !{i64 3296}
!38 = !{i64 3310}
!39 = !{i64 3326}
!40 = !{i64 3328}
!41 = !{i64 3332}
!42 = !{i64 3342}
!43 = !{i64 3346}
!44 = !{i64 3350}
!45 = !{i64 3354}
!46 = !{i64 3360}
!47 = !{i64 3364}
!48 = !{i64 3368}
!49 = !{i64 3372}
!50 = !{i64 3376}
!51 = !{i64 3380}
!52 = !{i64 3396}
!53 = !{i64 3404}
!54 = !{i64 3408}
!55 = !{i64 3410}
!56 = !{i64 3412}
!57 = !{i64 3416}
!58 = !{i64 3420}
!59 = !{i64 3426}
!60 = !{i64 3432}
!61 = !{i64 3436}
!62 = !{i64 3440}
!63 = !{i64 3444}
!64 = !{i64 3456}
!65 = !{i64 3460}
!66 = !{i64 3464}
!67 = !{i64 3470}
!68 = !{i64 3476}
!69 = !{i64 3478}
!70 = !{i64 3480}
!71 = !{i64 3484}
!72 = !{i64 3488}
!73 = !{i64 3494}
!74 = !{i64 3500}
!75 = !{i64 3504}
!76 = !{i64 3508}
!77 = !{i64 3512}
!78 = !{i64 3514}
!79 = !{i64 3516}
!80 = !{i64 3520}
!81 = !{i64 3524}
!82 = !{i64 3526}
!83 = !{i64 3528}
!84 = !{i64 3532}
!85 = !{i64 3536}
!86 = !{i64 3540}
!87 = !{i64 3548}
!88 = !{i64 3556}
!89 = !{i64 3560}
!90 = !{i64 3572}
!91 = !{i64 3576}
!92 = !{i64 3580}
!93 = !{i64 3586}
!94 = !{i64 3590}
!95 = !{i64 3594}
!96 = !{i64 3598}
!97 = !{i64 3602}
!98 = !{i64 3606}
!99 = !{i64 3610}
!100 = !{i64 3614}
!101 = !{i64 3620}
!102 = !{i64 3624}
!103 = !{i64 3628}
!104 = !{i64 3632}
!105 = !{i64 3644}
!106 = !{i64 3648}
!107 = !{i64 3652}
!108 = !{i64 3658}
!109 = !{i64 3664}
!110 = !{i64 3668}
!111 = !{i64 3700}
!112 = !{i64 3704}
!113 = !{i64 3708}
!114 = !{i64 3712}
!115 = !{i64 3716}
!116 = !{i64 3720}
!117 = !{i64 3730}
!118 = !{i64 3734}
!119 = !{i64 3740}
!120 = !{i64 3744}
!121 = !{i64 3748}
!122 = !{i64 3752}
!123 = !{i64 3760}
!124 = !{i64 3764}
!125 = !{i64 3776}
!126 = !{i64 3780}
!127 = !{i64 3784}
!128 = !{i64 3788}
!129 = !{i64 3792}
!130 = !{i64 3796}
!131 = !{i64 3806}
!132 = !{i64 3810}
!133 = !{i64 3814}
!134 = !{i64 3820}
!135 = !{i64 3824}
!136 = !{i64 3828}
!137 = !{i64 3834}
!138 = !{i64 3840}
!139 = !{i64 3844}
!140 = !{i64 3846}
!141 = !{i64 3848}
!142 = !{i64 3852}
!143 = !{i64 3856}
!144 = !{i64 3862}
!145 = !{i64 3866}
!146 = !{i64 3874}
!147 = !{i64 3878}
!148 = !{i64 3880}
!149 = !{i64 3884}
!150 = !{i64 3888}
!151 = !{i64 3900}
!152 = !{i64 3904}
!153 = !{i64 3908}
!154 = !{i64 3920}
!155 = !{i64 3926}
!156 = !{i64 3930}
!157 = !{i64 3940}
!158 = !{i64 3948}
!159 = !{i64 3950}
!160 = !{i64 3958}
!161 = !{i64 3962}
!162 = !{i64 3966}
!163 = !{i64 3970}
!164 = !{i64 3976}
!165 = !{i64 3982}
!166 = !{i64 3992}
!167 = !{i64 3994}
!168 = !{i64 4002}
!169 = !{i64 4006}
!170 = !{i64 4018}
!171 = !{i64 4022}
!172 = !{i64 4026}
!173 = !{i64 4036}
!174 = !{i64 4038}
!175 = !{i64 4040}
!176 = !{i64 4044}
!177 = !{i64 4048}
!178 = !{i64 4054}
!179 = !{i64 4062}
!180 = !{i64 4066}
!181 = !{i64 4078}
!182 = !{i64 4084}
!183 = !{i64 4086}
!184 = !{i64 4094}
!185 = !{i64 4098}
!186 = !{i64 4106}
!187 = !{i64 4118}
!188 = !{i64 4128}
!189 = !{i64 4130}
!190 = !{i64 4138}
!191 = !{i64 4142}
!192 = !{i64 4146}
!193 = !{i64 4152}
!194 = !{i64 4154}
!195 = !{i64 4160}
!196 = !{i64 4164}
!197 = !{i64 4168}
!198 = !{i64 4170}
!199 = !{i64 4172}
!200 = !{i64 4176}
!201 = !{i64 4180}
!202 = !{i64 4192}
!203 = !{i64 4198}
!204 = !{i64 4202}
!205 = !{i64 4214}
!206 = !{i64 4226}
!207 = !{i64 4234}
!208 = !{i64 4238}
!209 = !{i64 4242}
!210 = !{i64 4246}
!211 = !{i64 4254}
!212 = !{i64 4262}
!213 = !{i64 4264}
!214 = !{i64 4266}
!215 = !{i64 4274}
!216 = !{i64 4278}
!217 = !{i64 4282}
!218 = !{i64 4292}
!219 = !{i64 4300}
!220 = !{i64 4308}
!221 = !{i64 4310}
!222 = !{i64 4316}
!223 = !{i64 4320}
!224 = !{i64 4326}
!225 = !{i64 4330}
!226 = !{i64 4332}
!227 = !{i64 4334}
