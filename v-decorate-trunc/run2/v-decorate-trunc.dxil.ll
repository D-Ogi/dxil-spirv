; shader hash: 2964b68d20c2cc86cce3dd88b2b19544
;
; Buffer Definitions:
;
; cbuffer $Globals
; {
;
;   struct $Globals
;   {
;
;       int idx;                                      ; Offset:    0
;   
;   } $Globals;                                       ; Offset:    0 Size:     4
;
; }
;
;
; Resource Bindings:
;
; Name                                 Type  Format         Dim      ID      HLSL Bind  Count
; ------------------------------ ---------- ------- ----------- ------- -------------- ------
; $Globals                          cbuffer      NA          NA     CB0   cb4294967295     1
;
target datalayout = "e-m:e-p:32:32-i1:32-i8:32-i16:32-i32:32-i64:64-f16:32-f32:32-f64:64-n8:16:32:64"
target triple = "dxil-ms-dx"

%"$Globals" = type { i32 }
%dx.types.Handle = type { i8* }
%dx.types.CBufRet.i32 = type { i32, i32, i32, i32 }

@"$Globals" = external constant %"$Globals"
@dx.nothing.a = internal constant [1 x i32] zeroinitializer

define void @main() {
  %1 = load %"$Globals", %"$Globals"* @"$Globals"
  %2 = alloca [16 x float], align 4
  %3 = call %dx.types.Handle @"dx.op.createHandleForLib.$Globals"(i32 160, %"$Globals" %1)  ; CreateHandleForLib(Resource)
  %4 = load i32, i32* getelementptr inbounds ([1 x i32], [1 x i32]* @dx.nothing.a, i32 0, i32 0)
  br label %5

; <label>:5                                       ; preds = %0
  br label %6

; <label>:6                                       ; preds = %11, %5
  %7 = phi i32 [ 0, %5 ], [ %12, %11 ]
  %8 = sitofp i32 %7 to float
  %9 = getelementptr inbounds [16 x float], [16 x float]* %2, i32 0, i32 %7
  %10 = load i32, i32* getelementptr inbounds ([1 x i32], [1 x i32]* @dx.nothing.a, i32 0, i32 0)
  store float %8, float* %9, align 4
  br label %11

; <label>:11                                      ; preds = %6
  %12 = add nsw i32 %7, 1
  %13 = load i32, i32* getelementptr inbounds ([1 x i32], [1 x i32]* @dx.nothing.a, i32 0, i32 0)
  %14 = icmp slt i32 %12, 16
  %15 = icmp ne i1 %14, false
  %16 = icmp ne i1 %15, false
  br i1 %16, label %6, label %17

; <label>:17                                      ; preds = %11
  br label %18

; <label>:18                                      ; preds = %17
  %19 = call %dx.types.CBufRet.i32 @dx.op.cbufferLoadLegacy.i32(i32 59, %dx.types.Handle %3, i32 0)  ; CBufferLoadLegacy(handle,regIndex)
  %20 = extractvalue %dx.types.CBufRet.i32 %19, 0
  %21 = load i32, i32* getelementptr inbounds ([1 x i32], [1 x i32]* @dx.nothing.a, i32 0, i32 0)
  %22 = getelementptr inbounds [16 x float], [16 x float]* %2, i32 0, i32 %20
  %23 = load float, float* %22, align 4
  %24 = load i32, i32* getelementptr inbounds ([1 x i32], [1 x i32]* @dx.nothing.a, i32 0, i32 0)
  %25 = load i32, i32* getelementptr inbounds ([1 x i32], [1 x i32]* @dx.nothing.a, i32 0, i32 0)
  call void @dx.op.storeOutput.f32(i32 5, i32 0, i32 0, i8 0, float %23)  ; StoreOutput(outputSigId,rowIndex,colIndex,value)
  ret void
}

; Function Attrs: nounwind
declare void @dx.op.storeOutput.f32(i32, i32, i32, i8, float) #0

; Function Attrs: nounwind readonly
declare %dx.types.CBufRet.i32 @dx.op.cbufferLoadLegacy.i32(i32, %dx.types.Handle, i32) #1

; Function Attrs: nounwind readonly
declare %dx.types.Handle @"dx.op.createHandleForLib.$Globals"(i32, %"$Globals") #1

attributes #0 = { nounwind }
attributes #1 = { nounwind readonly }

!llvm.ident = !{!0}
!dx.version = !{!1}
!dx.valver = !{!2}
!dx.shaderModel = !{!3}
!dx.resources = !{!4}
!dx.typeAnnotations = !{!7}
!dx.entryPoints = !{!11, !13}

!0 = !{!"dxcoob 1.9.2609.5 (01b62ad47)"}
!1 = !{i32 1, i32 3}
!2 = !{i32 1, i32 9}
!3 = !{!"lib", i32 6, i32 3}
!4 = !{null, null, !5, null}
!5 = !{!6}
!6 = !{i32 0, %"$Globals"* @"$Globals", !"$Globals", i32 0, i32 -1, i32 1, i32 4, null}
!7 = !{i32 1, void ()* @main, !8}
!8 = !{!9}
!9 = !{i32 0, !10, !10}
!10 = !{}
!11 = !{null, !"", null, !4, !12}
!12 = !{i32 0, i64 1}
!13 = !{void ()* @main, !"main", !14, null, !18}
!14 = !{null, !15, null}
!15 = !{!16}
!16 = !{i32 0, !"OUT", i8 9, i8 0, !17, i8 2, i32 1, i8 1, i32 0, i8 0, null}
!17 = !{i32 0}
!18 = !{i32 8, i32 1, i32 5, !17}

