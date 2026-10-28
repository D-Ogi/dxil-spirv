; shader hash: 41ad88f3e6395c75d3a5a609f2056a7a
;
; Buffer Definitions:
;
;
; Resource Bindings:
;
; Name                                 Type  Format         Dim      ID      HLSL Bind  Count
; ------------------------------ ---------- ------- ----------- ------- -------------- ------
;
target datalayout = "e-m:e-p:32:32-i1:32-i8:32-i16:32-i32:32-i64:64-f16:32-f32:32-f64:64-n8:16:32:64"
target triple = "dxil-ms-dx"

declare <4 x float> @"\01?GetColor@@YA?AV?$vector@M$03@@I@Z"(i32)

define void @main() {
  %1 = call i32 @dx.op.loadInput.i32(i32 4, i32 0, i32 0, i8 0, i32 undef)  ; LoadInput(inputSigId,rowIndex,colIndex,gsVertexAxis)
  %2 = call <4 x float> @"\01?GetColor@@YA?AV?$vector@M$03@@I@Z"(i32 %1) #1
  %3 = extractelement <4 x float> %2, i64 0
  call void @dx.op.storeOutput.f32(i32 5, i32 0, i32 0, i8 0, float %3)  ; StoreOutput(outputSigId,rowIndex,colIndex,value)
  %4 = extractelement <4 x float> %2, i64 1
  call void @dx.op.storeOutput.f32(i32 5, i32 0, i32 0, i8 1, float %4)  ; StoreOutput(outputSigId,rowIndex,colIndex,value)
  %5 = extractelement <4 x float> %2, i64 2
  call void @dx.op.storeOutput.f32(i32 5, i32 0, i32 0, i8 2, float %5)  ; StoreOutput(outputSigId,rowIndex,colIndex,value)
  %6 = extractelement <4 x float> %2, i64 3
  call void @dx.op.storeOutput.f32(i32 5, i32 0, i32 0, i8 3, float %6)  ; StoreOutput(outputSigId,rowIndex,colIndex,value)
  ret void
}

; Function Attrs: nounwind readnone
declare i32 @dx.op.loadInput.i32(i32, i32, i32, i8, i32) #0

; Function Attrs: nounwind
declare void @dx.op.storeOutput.f32(i32, i32, i32, i8, float) #1

attributes #0 = { nounwind readnone }
attributes #1 = { nounwind }

!llvm.ident = !{!0}
!dx.version = !{!1}
!dx.valver = !{!2}
!dx.shaderModel = !{!3}
!dx.typeAnnotations = !{!4}
!dx.entryPoints = !{!13, !14}

!0 = !{!"dxcoob 1.9.2609.5 (01b62ad47)"}
!1 = !{i32 1, i32 3}
!2 = !{i32 1, i32 9}
!3 = !{!"lib", i32 6, i32 3}
!4 = !{i32 1, <4 x float> (i32)* @"\01?GetColor@@YA?AV?$vector@M$03@@I@Z", !5, void ()* @main, !11}
!5 = !{!6, !9}
!6 = !{i32 1, !7, !8}
!7 = !{i32 7, i32 9}
!8 = !{}
!9 = !{i32 0, !10, !8}
!10 = !{i32 7, i32 5}
!11 = !{!12}
!12 = !{i32 0, !8, !8}
!13 = !{null, !"", null, null, null}
!14 = !{void ()* @main, !"main", !15, null, !21}
!15 = !{!16, !19, null}
!16 = !{!17}
!17 = !{i32 0, !"I", i8 5, i8 0, !18, i8 1, i32 1, i8 1, i32 0, i8 0, null}
!18 = !{i32 0}
!19 = !{!20}
!20 = !{i32 0, !"SV_Target", i8 9, i8 16, !18, i8 0, i32 1, i8 4, i32 0, i8 0, null}
!21 = !{i32 8, i32 0, i32 5, !18}

