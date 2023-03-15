; ModuleID = '../TaintTest.c'
source_filename = "../TaintTest.c"
target datalayout = "e-m:e-i8:8:32-i16:16:32-i64:64-i128:128-n32:64-S128"
target triple = "aarch64-unknown-linux"

%struct.JNINativeInterface_ = type { ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr }

@.str = private unnamed_addr constant [14 x i8] c"indirect_sink\00", align 1
@.str.1 = private unnamed_addr constant [5 x i8] c"(I)V\00", align 1
@.str.2 = private unnamed_addr constant [5 x i8] c"sink\00", align 1
@.str.3 = private unnamed_addr constant [16 x i8] c"indirect_source\00", align 1
@.str.4 = private unnamed_addr constant [4 x i8] c"()I\00", align 1
@.str.5 = private unnamed_addr constant [46 x i8] c"org/opalj/fpcf/fixtures/taint_xlang/TaintTest\00", align 1
@.str.6 = private unnamed_addr constant [18 x i8] c"indirect_sanitize\00", align 1
@.str.7 = private unnamed_addr constant [5 x i8] c"(I)I\00", align 1
@.str.8 = private unnamed_addr constant [11 x i8] c"native %d\0A\00", align 1

; Function Attrs: mustprogress nofree norecurse nosync nounwind readnone willreturn uwtable
define dso_local i32 @Java_org_opalj_fpcf_fixtures_taint_1xlang_TaintTest_sum(ptr nocapture noundef readnone %0, ptr nocapture noundef readnone %1, i32 noundef %2, i32 noundef %3) local_unnamed_addr #0 {
  %5 = add nsw i32 %3, %2
  ret i32 %5
}

; Function Attrs: nounwind uwtable
define dso_local i32 @Java_org_opalj_fpcf_fixtures_taint_1xlang_TaintTest_propagate_1source(ptr nocapture noundef readnone %0, ptr nocapture noundef readnone %1) local_unnamed_addr #1 {
  %3 = tail call i32 @source(i32 noundef 42)
  %4 = add nsw i32 %3, 23
  ret i32 %4
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @source(i32 noundef %0) local_unnamed_addr #2 {
  %2 = alloca i32, align 4
  store i32 %0, ptr %2, align 4, !tbaa !6
  %3 = load i32, ptr %2, align 4, !tbaa !6
  %4 = mul nsw i32 %3, 7
  ret i32 %4
}

; Function Attrs: nounwind uwtable
define dso_local i32 @Java_org_opalj_fpcf_fixtures_taint_1xlang_TaintTest_propagate_1sanitize(ptr nocapture noundef readnone %0, ptr nocapture noundef readnone %1, i32 noundef %2) local_unnamed_addr #1 {
  %4 = tail call i32 @sanitize(i32 noundef %2)
  ret i32 %4
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @sanitize(i32 noundef %0) local_unnamed_addr #2 {
  %2 = alloca i32, align 4
  store i32 %0, ptr %2, align 4, !tbaa !6
  %3 = load i32, ptr %2, align 4, !tbaa !6
  %4 = sub nsw i32 %3, 19
  ret i32 %4
}

; Function Attrs: nounwind uwtable
define dso_local i32 @Java_org_opalj_fpcf_fixtures_taint_1xlang_TaintTest_propagate_1sink(ptr nocapture noundef readnone %0, ptr nocapture noundef readnone %1, i32 noundef %2) local_unnamed_addr #1 {
  tail call void @sink(i32 noundef %2)
  ret i32 23
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @sink(i32 noundef %0) local_unnamed_addr #2 {
  %2 = alloca i32, align 4
  store i32 %0, ptr %2, align 4, !tbaa !6
  %3 = load i32, ptr %2, align 4, !tbaa !6
  %4 = call i32 (ptr, ...) @printf(ptr noundef @.str.8, i32 noundef %3)
  ret void
}

; Function Attrs: nounwind uwtable
define dso_local i32 @Java_org_opalj_fpcf_fixtures_taint_1xlang_TaintTest_sanitize_1only_1a_1into_1sink(ptr nocapture noundef readnone %0, ptr nocapture noundef readnone %1, i32 noundef %2, i32 noundef returned %3) local_unnamed_addr #1 {
  %5 = tail call i32 @sanitize(i32 noundef %2)
  %6 = add nsw i32 %5, %3
  tail call void @sink(i32 noundef %6)
  ret i32 %3
}

; Function Attrs: nounwind uwtable
define dso_local void @Java_org_opalj_fpcf_fixtures_taint_1xlang_TaintTest_propagate_1identity_1to_1sink(ptr nocapture noundef readnone %0, ptr nocapture noundef readnone %1, i32 noundef %2) local_unnamed_addr #1 {
  %4 = tail call i32 @identity(i32 noundef %2)
  tail call void @sink(i32 noundef %4)
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @identity(i32 noundef %0) local_unnamed_addr #2 {
  %2 = alloca i32, align 4
  store i32 %0, ptr %2, align 4, !tbaa !6
  %3 = load i32, ptr %2, align 4, !tbaa !6
  ret i32 %3
}

; Function Attrs: nounwind uwtable
define dso_local void @Java_org_opalj_fpcf_fixtures_taint_1xlang_TaintTest_propagate_1zero_1to_1sink(ptr nocapture noundef readnone %0, ptr nocapture noundef readnone %1, i32 noundef %2) local_unnamed_addr #1 {
  %4 = tail call i32 @zero(i32 noundef %2)
  tail call void @sink(i32 noundef 0)
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @zero(i32 noundef %0) local_unnamed_addr #2 {
  %2 = alloca i32, align 4
  store i32 %0, ptr %2, align 4, !tbaa !6
  ret i32 0
}

; Function Attrs: nounwind uwtable
define dso_local void @Java_org_opalj_fpcf_fixtures_taint_1xlang_TaintTest_native_1array_1tainted(ptr nocapture noundef readnone %0, ptr nocapture noundef readnone %1) local_unnamed_addr #1 {
  %3 = tail call i32 @source(i32 noundef 42)
  tail call void @sink(i32 noundef %3)
  ret void
}

; Function Attrs: nounwind uwtable
define dso_local void @Java_org_opalj_fpcf_fixtures_taint_1xlang_TaintTest_native_1array_1untainted(ptr nocapture noundef readnone %0, ptr nocapture noundef readnone %1) local_unnamed_addr #1 {
  %3 = tail call i32 @source(i32 noundef 42)
  tail call void @sink(i32 noundef 0)
  ret void
}

; Function Attrs: nounwind uwtable
define dso_local void @Java_org_opalj_fpcf_fixtures_taint_1xlang_TaintTest_propagate_1to_1java_1sink(ptr noundef %0, ptr noundef %1, i32 noundef %2) local_unnamed_addr #1 {
  %4 = load ptr, ptr %0, align 8, !tbaa !10
  %5 = getelementptr inbounds %struct.JNINativeInterface_, ptr %4, i64 0, i32 31
  %6 = load ptr, ptr %5, align 8, !tbaa !12
  %7 = tail call ptr %6(ptr noundef nonnull %0, ptr noundef %1) #4
  %8 = load ptr, ptr %0, align 8, !tbaa !10
  %9 = getelementptr inbounds %struct.JNINativeInterface_, ptr %8, i64 0, i32 33
  %10 = load ptr, ptr %9, align 8, !tbaa !14
  %11 = tail call ptr %10(ptr noundef nonnull %0, ptr noundef %7, ptr noundef nonnull @.str, ptr noundef nonnull @.str.1) #4
  %12 = load ptr, ptr %0, align 8, !tbaa !10
  %13 = getelementptr inbounds %struct.JNINativeInterface_, ptr %12, i64 0, i32 61
  %14 = load ptr, ptr %13, align 8, !tbaa !15
  tail call void (ptr, ptr, ptr, ...) %14(ptr noundef nonnull %0, ptr noundef %1, ptr noundef %11, i32 noundef %2) #4
  ret void
}

; Function Attrs: nounwind uwtable
define dso_local void @Java_org_opalj_fpcf_fixtures_taint_1xlang_TaintTest_propagate_1to_1java_1static_1sink(ptr noundef %0, ptr noundef %1, i32 noundef %2) local_unnamed_addr #1 {
  %4 = load ptr, ptr %0, align 8, !tbaa !10
  %5 = getelementptr inbounds %struct.JNINativeInterface_, ptr %4, i64 0, i32 113
  %6 = load ptr, ptr %5, align 8, !tbaa !16
  %7 = tail call ptr %6(ptr noundef nonnull %0, ptr noundef %1, ptr noundef nonnull @.str.2, ptr noundef nonnull @.str.1) #4
  %8 = load ptr, ptr %0, align 8, !tbaa !10
  %9 = getelementptr inbounds %struct.JNINativeInterface_, ptr %8, i64 0, i32 141
  %10 = load ptr, ptr %9, align 8, !tbaa !17
  tail call void (ptr, ptr, ptr, ...) %10(ptr noundef nonnull %0, ptr noundef %1, ptr noundef %7, i32 noundef %2) #4
  ret void
}

; Function Attrs: nounwind uwtable
define dso_local i32 @Java_org_opalj_fpcf_fixtures_taint_1xlang_TaintTest_propagate_1from_1java_1source__(ptr noundef %0, ptr noundef %1) local_unnamed_addr #1 {
  %3 = load ptr, ptr %0, align 8, !tbaa !10
  %4 = getelementptr inbounds %struct.JNINativeInterface_, ptr %3, i64 0, i32 31
  %5 = load ptr, ptr %4, align 8, !tbaa !12
  %6 = tail call ptr %5(ptr noundef nonnull %0, ptr noundef %1) #4
  %7 = load ptr, ptr %0, align 8, !tbaa !10
  %8 = getelementptr inbounds %struct.JNINativeInterface_, ptr %7, i64 0, i32 33
  %9 = load ptr, ptr %8, align 8, !tbaa !14
  %10 = tail call ptr %9(ptr noundef nonnull %0, ptr noundef %6, ptr noundef nonnull @.str.3, ptr noundef nonnull @.str.4) #4
  %11 = load ptr, ptr %0, align 8, !tbaa !10
  %12 = getelementptr inbounds %struct.JNINativeInterface_, ptr %11, i64 0, i32 49
  %13 = load ptr, ptr %12, align 8, !tbaa !18
  %14 = tail call i32 (ptr, ptr, ptr, ...) %13(ptr noundef nonnull %0, ptr noundef %1, ptr noundef %10) #4
  ret i32 %14
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind readnone willreturn uwtable
define dso_local i32 @Java_org_opalj_fpcf_fixtures_taint_1xlang_TaintTest_propagate_1from_1java_1source__I(ptr nocapture noundef readnone %0, ptr nocapture noundef readnone %1, i32 noundef %2) local_unnamed_addr #0 {
  ret i32 24
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind readnone willreturn uwtable
define dso_local i32 @Java_org_opalj_fpcf_fixtures_taint_1xlang_TaintTest_propagate_1from_1java_1source__Ljava_lang_String_2(ptr nocapture noundef readnone %0, ptr nocapture noundef readnone %1, ptr nocapture noundef readnone %2) local_unnamed_addr #0 {
  ret i32 42
}

; Function Attrs: nounwind uwtable
define dso_local i32 @Java_org_opalj_fpcf_fixtures_taint_1xlang_TaintTest_propagate_1java_1sanitize(ptr noundef %0, ptr noundef %1, i32 noundef %2) local_unnamed_addr #1 {
  %4 = load ptr, ptr %0, align 8, !tbaa !10
  %5 = getelementptr inbounds %struct.JNINativeInterface_, ptr %4, i64 0, i32 6
  %6 = load ptr, ptr %5, align 8, !tbaa !19
  %7 = tail call ptr %6(ptr noundef nonnull %0, ptr noundef nonnull @.str.5) #4
  %8 = load ptr, ptr %0, align 8, !tbaa !10
  %9 = getelementptr inbounds %struct.JNINativeInterface_, ptr %8, i64 0, i32 33
  %10 = load ptr, ptr %9, align 8, !tbaa !14
  %11 = tail call ptr %10(ptr noundef nonnull %0, ptr noundef %7, ptr noundef nonnull @.str.6, ptr noundef nonnull @.str.7) #4
  %12 = load ptr, ptr %0, align 8, !tbaa !10
  %13 = getelementptr inbounds %struct.JNINativeInterface_, ptr %12, i64 0, i32 49
  %14 = load ptr, ptr %13, align 8, !tbaa !18
  %15 = tail call i32 (ptr, ptr, ptr, ...) %14(ptr noundef nonnull %0, ptr noundef %1, ptr noundef %11, i32 noundef %2) #4
  ret i32 %15
}

; Function Attrs: nofree nounwind
declare noundef i32 @printf(ptr nocapture noundef readonly, ...) local_unnamed_addr #3

attributes #0 = { mustprogress nofree norecurse nosync nounwind readnone willreturn uwtable "frame-pointer"="non-leaf" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic" "target-features"="+neon,+outline-atomics,+v8a" }
attributes #1 = { nounwind uwtable "frame-pointer"="non-leaf" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic" "target-features"="+neon,+outline-atomics,+v8a" }
attributes #2 = { noinline nounwind optnone uwtable "frame-pointer"="non-leaf" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic" "target-features"="+neon,+outline-atomics,+v8a" }
attributes #3 = { nofree nounwind "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic" "target-features"="+neon,+outline-atomics,+v8a" }
attributes #4 = { nounwind }

!llvm.module.flags = !{!0, !1, !2, !3, !4}
!llvm.ident = !{!5}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 7, !"PIC Level", i32 2}
!2 = !{i32 7, !"PIE Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 2}
!4 = !{i32 7, !"frame-pointer", i32 1}
!5 = !{!"Debian clang version 15.0.7"}
!6 = !{!7, !7, i64 0}
!7 = !{!"int", !8, i64 0}
!8 = !{!"omnipotent char", !9, i64 0}
!9 = !{!"Simple C/C++ TBAA"}
!10 = !{!11, !11, i64 0}
!11 = !{!"any pointer", !8, i64 0}
!12 = !{!13, !11, i64 248}
!13 = !{!"JNINativeInterface_", !11, i64 0, !11, i64 8, !11, i64 16, !11, i64 24, !11, i64 32, !11, i64 40, !11, i64 48, !11, i64 56, !11, i64 64, !11, i64 72, !11, i64 80, !11, i64 88, !11, i64 96, !11, i64 104, !11, i64 112, !11, i64 120, !11, i64 128, !11, i64 136, !11, i64 144, !11, i64 152, !11, i64 160, !11, i64 168, !11, i64 176, !11, i64 184, !11, i64 192, !11, i64 200, !11, i64 208, !11, i64 216, !11, i64 224, !11, i64 232, !11, i64 240, !11, i64 248, !11, i64 256, !11, i64 264, !11, i64 272, !11, i64 280, !11, i64 288, !11, i64 296, !11, i64 304, !11, i64 312, !11, i64 320, !11, i64 328, !11, i64 336, !11, i64 344, !11, i64 352, !11, i64 360, !11, i64 368, !11, i64 376, !11, i64 384, !11, i64 392, !11, i64 400, !11, i64 408, !11, i64 416, !11, i64 424, !11, i64 432, !11, i64 440, !11, i64 448, !11, i64 456, !11, i64 464, !11, i64 472, !11, i64 480, !11, i64 488, !11, i64 496, !11, i64 504, !11, i64 512, !11, i64 520, !11, i64 528, !11, i64 536, !11, i64 544, !11, i64 552, !11, i64 560, !11, i64 568, !11, i64 576, !11, i64 584, !11, i64 592, !11, i64 600, !11, i64 608, !11, i64 616, !11, i64 624, !11, i64 632, !11, i64 640, !11, i64 648, !11, i64 656, !11, i64 664, !11, i64 672, !11, i64 680, !11, i64 688, !11, i64 696, !11, i64 704, !11, i64 712, !11, i64 720, !11, i64 728, !11, i64 736, !11, i64 744, !11, i64 752, !11, i64 760, !11, i64 768, !11, i64 776, !11, i64 784, !11, i64 792, !11, i64 800, !11, i64 808, !11, i64 816, !11, i64 824, !11, i64 832, !11, i64 840, !11, i64 848, !11, i64 856, !11, i64 864, !11, i64 872, !11, i64 880, !11, i64 888, !11, i64 896, !11, i64 904, !11, i64 912, !11, i64 920, !11, i64 928, !11, i64 936, !11, i64 944, !11, i64 952, !11, i64 960, !11, i64 968, !11, i64 976, !11, i64 984, !11, i64 992, !11, i64 1000, !11, i64 1008, !11, i64 1016, !11, i64 1024, !11, i64 1032, !11, i64 1040, !11, i64 1048, !11, i64 1056, !11, i64 1064, !11, i64 1072, !11, i64 1080, !11, i64 1088, !11, i64 1096, !11, i64 1104, !11, i64 1112, !11, i64 1120, !11, i64 1128, !11, i64 1136, !11, i64 1144, !11, i64 1152, !11, i64 1160, !11, i64 1168, !11, i64 1176, !11, i64 1184, !11, i64 1192, !11, i64 1200, !11, i64 1208, !11, i64 1216, !11, i64 1224, !11, i64 1232, !11, i64 1240, !11, i64 1248, !11, i64 1256, !11, i64 1264, !11, i64 1272, !11, i64 1280, !11, i64 1288, !11, i64 1296, !11, i64 1304, !11, i64 1312, !11, i64 1320, !11, i64 1328, !11, i64 1336, !11, i64 1344, !11, i64 1352, !11, i64 1360, !11, i64 1368, !11, i64 1376, !11, i64 1384, !11, i64 1392, !11, i64 1400, !11, i64 1408, !11, i64 1416, !11, i64 1424, !11, i64 1432, !11, i64 1440, !11, i64 1448, !11, i64 1456, !11, i64 1464, !11, i64 1472, !11, i64 1480, !11, i64 1488, !11, i64 1496, !11, i64 1504, !11, i64 1512, !11, i64 1520, !11, i64 1528, !11, i64 1536, !11, i64 1544, !11, i64 1552, !11, i64 1560, !11, i64 1568, !11, i64 1576, !11, i64 1584, !11, i64 1592, !11, i64 1600, !11, i64 1608, !11, i64 1616, !11, i64 1624, !11, i64 1632, !11, i64 1640, !11, i64 1648, !11, i64 1656, !11, i64 1664, !11, i64 1672, !11, i64 1680, !11, i64 1688, !11, i64 1696, !11, i64 1704, !11, i64 1712, !11, i64 1720, !11, i64 1728, !11, i64 1736, !11, i64 1744, !11, i64 1752, !11, i64 1760, !11, i64 1768, !11, i64 1776, !11, i64 1784, !11, i64 1792, !11, i64 1800, !11, i64 1808, !11, i64 1816, !11, i64 1824, !11, i64 1832, !11, i64 1840, !11, i64 1848, !11, i64 1856, !11, i64 1864}
!14 = !{!13, !11, i64 264}
!15 = !{!13, !11, i64 488}
!16 = !{!13, !11, i64 904}
!17 = !{!13, !11, i64 1128}
!18 = !{!13, !11, i64 392}
!19 = !{!13, !11, i64 48}
