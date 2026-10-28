; shader hash: b09cac16842a3e1217a42a152135ff7f
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

define void @main() {
  %1 = load %"$Globals", %"$Globals"* @"$Globals", align 4
  %2 = call %dx.types.Handle @"dx.op.createHandleForLib.$Globals"(i32 160, %"$Globals" %1)  ; CreateHandleForLib(Resource)
  %3 = call %dx.types.CBufRet.i32 @dx.op.cbufferLoadLegacy.i32(i32 59, %dx.types.Handle %2, i32 0)  ; CBufferLoadLegacy(handle,regIndex)
  %4 = extractvalue %dx.types.CBufRet.i32 %3, 0
  %5 = sitofp i32 %4 to float
  call void @dx.op.storeOutput.f32(i32 5, i32 0, i32 0, i8 0, float %5)  ; StoreOutput(outputSigId,rowIndex,colIndex,value)
  call void @dx.op.storeOutput.f32(i32 5, i32 0, i32 0, i8 1, float %5)  ; StoreOutput(outputSigId,rowIndex,colIndex,value)
  call void @dx.op.storeOutput.f32(i32 5, i32 0, i32 0, i8 2, float %5)  ; StoreOutput(outputSigId,rowIndex,colIndex,value)
  call void @dx.op.storeOutput.f32(i32 5, i32 0, i32 0, i8 3, float %5)  ; StoreOutput(outputSigId,rowIndex,colIndex,value)
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
!dx.entryPoints = !{!11, !12}

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
!11 = !{null, !"", null, !4, null}
!12 = !{void ()* @main, !"main", !13, null, !17}
!13 = !{null, !14, null}
!14 = !{!15}
!15 = !{i32 0, !"SV_Position", i8 9, i8 3, !16, i8 4, i32 1, i8 4, i32 0, i8 0, null}
!16 = !{i32 0}
!17 = !{i32 8, i32 1, i32 5, !16}

