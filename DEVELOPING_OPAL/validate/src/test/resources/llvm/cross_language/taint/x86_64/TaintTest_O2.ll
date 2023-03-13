; ModuleID = '../TaintTest.c'
source_filename = "../TaintTest.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux"

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
  store i32 %0, ptr %2, align 4, !tbaa !3
  %3 = load i32, ptr %2, align 4, !tbaa !3
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
  store i32 %0, ptr %2, align 4, !tbaa !3
  %3 = load i32, ptr %2, align 4, !tbaa !3
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
  store i32 %0, ptr %2, align 4, !tbaa !3
  %3 = load i32, ptr %2, align 4, !tbaa !3
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
  store i32 %0, ptr %2, align 4, !tbaa !3
  %3 = load i32, ptr %2, align 4, !tbaa !3
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
  store i32 %0, ptr %2, align 4, !tbaa !3
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
  %4 = load ptr, ptr %0, align 8, !tbaa !7
  %5 = getelementptr inbounds %struct.JNINativeInterface_, ptr %4, i64 0, i32 31
  %6 = load ptr, ptr %5, align 8, !tbaa !9
  %7 = tail call ptr %6(ptr noundef nonnull %0, ptr noundef %1) #4
  %8 = load ptr, ptr %0, align 8, !tbaa !7
  %9 = getelementptr inbounds %struct.JNINativeInterface_, ptr %8, i64 0, i32 33
  %10 = load ptr, ptr %9, align 8, !tbaa !11
  %11 = tail call ptr %10(ptr noundef nonnull %0, ptr noundef %7, ptr noundef nonnull @.str, ptr noundef nonnull @.str.1) #4
  %12 = load ptr, ptr %0, align 8, !tbaa !7
  %13 = getelementptr inbounds %struct.JNINativeInterface_, ptr %12, i64 0, i32 61
  %14 = load ptr, ptr %13, align 8, !tbaa !12
  tail call void (ptr, ptr, ptr, ...) %14(ptr noundef nonnull %0, ptr noundef %1, ptr noundef %11, i32 noundef %2) #4
  ret void
}

; Function Attrs: nounwind uwtable
define dso_local void @Java_org_opalj_fpcf_fixtures_taint_1xlang_TaintTest_propagate_1to_1java_1static_1sink(ptr noundef %0, ptr noundef %1, i32 noundef %2) local_unnamed_addr #1 {
  %4 = load ptr, ptr %0, align 8, !tbaa !7
  %5 = getelementptr inbounds %struct.JNINativeInterface_, ptr %4, i64 0, i32 113
  %6 = load ptr, ptr %5, align 8, !tbaa !13
  %7 = tail call ptr %6(ptr noundef nonnull %0, ptr noundef %1, ptr noundef nonnull @.str.2, ptr noundef nonnull @.str.1) #4
  %8 = load ptr, ptr %0, align 8, !tbaa !7
  %9 = getelementptr inbounds %struct.JNINativeInterface_, ptr %8, i64 0, i32 141
  %10 = load ptr, ptr %9, align 8, !tbaa !14
  tail call void (ptr, ptr, ptr, ...) %10(ptr noundef nonnull %0, ptr noundef %1, ptr noundef %7, i32 noundef %2) #4
  ret void
}

; Function Attrs: nounwind uwtable
define dso_local i32 @Java_org_opalj_fpcf_fixtures_taint_1xlang_TaintTest_propagate_1from_1java_1source(ptr noundef %0, ptr noundef %1) local_unnamed_addr #1 {
  %3 = load ptr, ptr %0, align 8, !tbaa !7
  %4 = getelementptr inbounds %struct.JNINativeInterface_, ptr %3, i64 0, i32 31
  %5 = load ptr, ptr %4, align 8, !tbaa !9
  %6 = tail call ptr %5(ptr noundef nonnull %0, ptr noundef %1) #4
  %7 = load ptr, ptr %0, align 8, !tbaa !7
  %8 = getelementptr inbounds %struct.JNINativeInterface_, ptr %7, i64 0, i32 33
  %9 = load ptr, ptr %8, align 8, !tbaa !11
  %10 = tail call ptr %9(ptr noundef nonnull %0, ptr noundef %6, ptr noundef nonnull @.str.3, ptr noundef nonnull @.str.4) #4
  %11 = load ptr, ptr %0, align 8, !tbaa !7
  %12 = getelementptr inbounds %struct.JNINativeInterface_, ptr %11, i64 0, i32 49
  %13 = load ptr, ptr %12, align 8, !tbaa !15
  %14 = tail call i32 (ptr, ptr, ptr, ...) %13(ptr noundef nonnull %0, ptr noundef %1, ptr noundef %10) #4
  ret i32 %14
}

; Function Attrs: nounwind uwtable
define dso_local i32 @Java_org_opalj_fpcf_fixtures_taint_1xlang_TaintTest_propagate_1java_1sanitize(ptr noundef %0, ptr noundef %1, i32 noundef %2) local_unnamed_addr #1 {
  %4 = load ptr, ptr %0, align 8, !tbaa !7
  %5 = getelementptr inbounds %struct.JNINativeInterface_, ptr %4, i64 0, i32 6
  %6 = load ptr, ptr %5, align 8, !tbaa !16
  %7 = tail call ptr %6(ptr noundef nonnull %0, ptr noundef nonnull @.str.5) #4
  %8 = load ptr, ptr %0, align 8, !tbaa !7
  %9 = getelementptr inbounds %struct.JNINativeInterface_, ptr %8, i64 0, i32 33
  %10 = load ptr, ptr %9, align 8, !tbaa !11
  %11 = tail call ptr %10(ptr noundef nonnull %0, ptr noundef %7, ptr noundef nonnull @.str.6, ptr noundef nonnull @.str.7) #4
  %12 = load ptr, ptr %0, align 8, !tbaa !7
  %13 = getelementptr inbounds %struct.JNINativeInterface_, ptr %12, i64 0, i32 49
  %14 = load ptr, ptr %13, align 8, !tbaa !15
  %15 = tail call i32 (ptr, ptr, ptr, ...) %14(ptr noundef nonnull %0, ptr noundef %1, ptr noundef %11, i32 noundef %2) #4
  ret i32 %15
}

; Function Attrs: nofree nounwind
declare dso_local noundef i32 @printf(ptr nocapture noundef readonly, ...) local_unnamed_addr #3

attributes #0 = { mustprogress nofree norecurse nosync nounwind readnone willreturn uwtable "frame-pointer"="none" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nounwind uwtable "frame-pointer"="none" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #2 = { noinline nounwind optnone uwtable "frame-pointer"="none" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #3 = { nofree nounwind "frame-pointer"="none" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #4 = { nounwind }

!llvm.module.flags = !{!0, !1}
!llvm.ident = !{!2}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 7, !"uwtable", i32 2}
!2 = !{!"clang version 15.0.7 (Fedora 15.0.7-1.fc37)"}
!3 = !{!4, !4, i64 0}
!4 = !{!"int", !5, i64 0}
!5 = !{!"omnipotent char", !6, i64 0}
!6 = !{!"Simple C/C++ TBAA"}
!7 = !{!8, !8, i64 0}
!8 = !{!"any pointer", !5, i64 0}
!9 = !{!10, !8, i64 248}
!10 = !{!"JNINativeInterface_", !8, i64 0, !8, i64 8, !8, i64 16, !8, i64 24, !8, i64 32, !8, i64 40, !8, i64 48, !8, i64 56, !8, i64 64, !8, i64 72, !8, i64 80, !8, i64 88, !8, i64 96, !8, i64 104, !8, i64 112, !8, i64 120, !8, i64 128, !8, i64 136, !8, i64 144, !8, i64 152, !8, i64 160, !8, i64 168, !8, i64 176, !8, i64 184, !8, i64 192, !8, i64 200, !8, i64 208, !8, i64 216, !8, i64 224, !8, i64 232, !8, i64 240, !8, i64 248, !8, i64 256, !8, i64 264, !8, i64 272, !8, i64 280, !8, i64 288, !8, i64 296, !8, i64 304, !8, i64 312, !8, i64 320, !8, i64 328, !8, i64 336, !8, i64 344, !8, i64 352, !8, i64 360, !8, i64 368, !8, i64 376, !8, i64 384, !8, i64 392, !8, i64 400, !8, i64 408, !8, i64 416, !8, i64 424, !8, i64 432, !8, i64 440, !8, i64 448, !8, i64 456, !8, i64 464, !8, i64 472, !8, i64 480, !8, i64 488, !8, i64 496, !8, i64 504, !8, i64 512, !8, i64 520, !8, i64 528, !8, i64 536, !8, i64 544, !8, i64 552, !8, i64 560, !8, i64 568, !8, i64 576, !8, i64 584, !8, i64 592, !8, i64 600, !8, i64 608, !8, i64 616, !8, i64 624, !8, i64 632, !8, i64 640, !8, i64 648, !8, i64 656, !8, i64 664, !8, i64 672, !8, i64 680, !8, i64 688, !8, i64 696, !8, i64 704, !8, i64 712, !8, i64 720, !8, i64 728, !8, i64 736, !8, i64 744, !8, i64 752, !8, i64 760, !8, i64 768, !8, i64 776, !8, i64 784, !8, i64 792, !8, i64 800, !8, i64 808, !8, i64 816, !8, i64 824, !8, i64 832, !8, i64 840, !8, i64 848, !8, i64 856, !8, i64 864, !8, i64 872, !8, i64 880, !8, i64 888, !8, i64 896, !8, i64 904, !8, i64 912, !8, i64 920, !8, i64 928, !8, i64 936, !8, i64 944, !8, i64 952, !8, i64 960, !8, i64 968, !8, i64 976, !8, i64 984, !8, i64 992, !8, i64 1000, !8, i64 1008, !8, i64 1016, !8, i64 1024, !8, i64 1032, !8, i64 1040, !8, i64 1048, !8, i64 1056, !8, i64 1064, !8, i64 1072, !8, i64 1080, !8, i64 1088, !8, i64 1096, !8, i64 1104, !8, i64 1112, !8, i64 1120, !8, i64 1128, !8, i64 1136, !8, i64 1144, !8, i64 1152, !8, i64 1160, !8, i64 1168, !8, i64 1176, !8, i64 1184, !8, i64 1192, !8, i64 1200, !8, i64 1208, !8, i64 1216, !8, i64 1224, !8, i64 1232, !8, i64 1240, !8, i64 1248, !8, i64 1256, !8, i64 1264, !8, i64 1272, !8, i64 1280, !8, i64 1288, !8, i64 1296, !8, i64 1304, !8, i64 1312, !8, i64 1320, !8, i64 1328, !8, i64 1336, !8, i64 1344, !8, i64 1352, !8, i64 1360, !8, i64 1368, !8, i64 1376, !8, i64 1384, !8, i64 1392, !8, i64 1400, !8, i64 1408, !8, i64 1416, !8, i64 1424, !8, i64 1432, !8, i64 1440, !8, i64 1448, !8, i64 1456, !8, i64 1464, !8, i64 1472, !8, i64 1480, !8, i64 1488, !8, i64 1496, !8, i64 1504, !8, i64 1512, !8, i64 1520, !8, i64 1528, !8, i64 1536, !8, i64 1544, !8, i64 1552, !8, i64 1560, !8, i64 1568, !8, i64 1576, !8, i64 1584, !8, i64 1592, !8, i64 1600, !8, i64 1608, !8, i64 1616, !8, i64 1624, !8, i64 1632, !8, i64 1640, !8, i64 1648, !8, i64 1656, !8, i64 1664, !8, i64 1672, !8, i64 1680, !8, i64 1688, !8, i64 1696, !8, i64 1704, !8, i64 1712, !8, i64 1720, !8, i64 1728, !8, i64 1736, !8, i64 1744, !8, i64 1752, !8, i64 1760, !8, i64 1768, !8, i64 1776, !8, i64 1784, !8, i64 1792, !8, i64 1800, !8, i64 1808, !8, i64 1816, !8, i64 1824, !8, i64 1832, !8, i64 1840, !8, i64 1848, !8, i64 1856, !8, i64 1864}
!11 = !{!10, !8, i64 264}
!12 = !{!10, !8, i64 488}
!13 = !{!10, !8, i64 904}
!14 = !{!10, !8, i64 1128}
!15 = !{!10, !8, i64 392}
!16 = !{!10, !8, i64 48}
