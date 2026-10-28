;
; Input signature:
;
; Name                 Index   Mask Register SysValue  Format   Used
; -------------------- ----- ------ -------- -------- ------- ------
; no parameters
;
; Output signature:
;
; Name                 Index   Mask Register SysValue  Format   Used
; -------------------- ----- ------ -------- -------- ------- ------
; no parameters
; shader hash: 1ffe6b54d2ea3c186389223a128daf96
;
; Pipeline Runtime Information: 
;
;PSVRuntimeInfo:
; Amplification Shader
; NumThreads=(2,1,1)
; MinimumExpectedWaveLaneCount: 0
; MaximumExpectedWaveLaneCount: 4294967295
; UsesViewID: false
; SigInputElements: 0
; SigOutputElements: 0
; SigPatchConstOrPrimElements: 0
; SigInputVectors: 0
; SigOutputVectors[0]: 0
; SigOutputVectors[1]: 0
; SigOutputVectors[2]: 0
; SigOutputVectors[3]: 0
; EntryFunctionName: main
;
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

%struct.Payload = type { i32 }

@"\01?g_payloads@@3PAUPayload@@A" = external addrspace(3) global [2 x %struct.Payload], align 4

define void @main() {
  %1 = call i32 @dx.op.flattenedThreadIdInGroup.i32(i32 96)  ; FlattenedThreadIdInGroup()
  %2 = getelementptr [2 x %struct.Payload], [2 x %struct.Payload] addrspace(3)* @"\01?g_payloads@@3PAUPayload@@A", i32 0, i32 %1, i32 0
  store i32 %1, i32 addrspace(3)* %2, align 4, !tbaa !8
  call void @dx.op.barrier(i32 80, i32 9)  ; Barrier(barrierMode)
  call void @dx.op.dispatchMesh.struct.Payload(i32 173, i32 1, i32 1, i32 1, %struct.Payload addrspace(3)* getelementptr inbounds ([2 x %struct.Payload], [2 x %struct.Payload] addrspace(3)* @"\01?g_payloads@@3PAUPayload@@A", i32 0, i32 1))  ; DispatchMesh(threadGroupCountX,threadGroupCountY,threadGroupCountZ,payload)
  ret void
}

; Function Attrs: nounwind readnone
declare i32 @dx.op.flattenedThreadIdInGroup.i32(i32) #0

; Function Attrs: noduplicate nounwind
declare void @dx.op.barrier(i32, i32) #1

; Function Attrs: nounwind
declare void @dx.op.dispatchMesh.struct.Payload(i32, i32, i32, i32, %struct.Payload addrspace(3)*) #2

attributes #0 = { nounwind readnone }
attributes #1 = { noduplicate nounwind }
attributes #2 = { nounwind }

!llvm.ident = !{!0}
!dx.version = !{!1}
!dx.valver = !{!2}
!dx.shaderModel = !{!3}
!dx.entryPoints = !{!4}

!0 = !{!"dxcoob 1.9.2609.5 (01b62ad47)"}
!1 = !{i32 1, i32 5}
!2 = !{i32 1, i32 9}
!3 = !{!"as", i32 6, i32 5}
!4 = !{void ()* @main, !"main", null, null, !5}
!5 = !{i32 10, !6}
!6 = !{!7, i32 4}
!7 = !{i32 2, i32 1, i32 1}
!8 = !{!9, !9, i64 0}
!9 = !{!"int", !10, i64 0}
!10 = !{!"omnipotent char", !11, i64 0}
!11 = !{!"Simple C/C++ TBAA"}

