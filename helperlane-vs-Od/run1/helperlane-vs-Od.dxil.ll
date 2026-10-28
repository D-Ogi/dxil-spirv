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
; SV_Position              0   xyzw        0      POS   float   xyzw
;
; shader hash: 28a14376823e44c031f764106e0a0853
;
; Pipeline Runtime Information: 
;
;PSVRuntimeInfo:
; Vertex Shader
; OutputPositionPresent=1
; MinimumExpectedWaveLaneCount: 0
; MaximumExpectedWaveLaneCount: 4294967295
; UsesViewID: false
; SigInputElements: 0
; SigOutputElements: 1
; SigPatchConstOrPrimElements: 0
; SigInputVectors: 0
; SigOutputVectors[0]: 1
; SigOutputVectors[1]: 0
; SigOutputVectors[2]: 0
; SigOutputVectors[3]: 0
; EntryFunctionName: main
;
;
; Output signature:
;
; Name                 Index             InterpMode DynIdx
; -------------------- ----- ---------------------- ------
; SV_Position              0          noperspective       
;
; Buffer Definitions:
;
;
; Resource Bindings:
;
; Name                                 Type  Format         Dim      ID      HLSL Bind  Count
; ------------------------------ ---------- ------- ----------- ------- -------------- ------
;
;
; ViewId state:
;
; Number of inputs: 0, outputs: 4
; Outputs dependent on ViewId: {  }
; Inputs contributing to computation of Outputs:
;
target datalayout = "e-m:e-p:32:32-i1:32-i8:32-i16:32-i32:32-i64:64-f16:32-f32:32-f64:64-n8:16:32:64"
target triple = "dxil-ms-dx"

@dx.nothing.a = internal constant [1 x i32] zeroinitializer

define void @main() {
  %1 = call i1 @dx.op.isHelperLane.i1(i32 221)  ; IsHelperLane()
  %2 = select i1 %1, float 1.000000e+00, float 0.000000e+00
  %3 = load i32, i32* getelementptr inbounds ([1 x i32], [1 x i32]* @dx.nothing.a, i32 0, i32 0)
  call void @dx.op.storeOutput.f32(i32 5, i32 0, i32 0, i8 0, float %2)  ; StoreOutput(outputSigId,rowIndex,colIndex,value)
  call void @dx.op.storeOutput.f32(i32 5, i32 0, i32 0, i8 1, float %2)  ; StoreOutput(outputSigId,rowIndex,colIndex,value)
  call void @dx.op.storeOutput.f32(i32 5, i32 0, i32 0, i8 2, float %2)  ; StoreOutput(outputSigId,rowIndex,colIndex,value)
  call void @dx.op.storeOutput.f32(i32 5, i32 0, i32 0, i8 3, float %2)  ; StoreOutput(outputSigId,rowIndex,colIndex,value)
  ret void
}

; Function Attrs: nounwind
declare void @dx.op.storeOutput.f32(i32, i32, i32, i8, float) #0

; Function Attrs: nounwind readonly
declare i1 @dx.op.isHelperLane.i1(i32) #1

attributes #0 = { nounwind }
attributes #1 = { nounwind readonly }

!llvm.ident = !{!0}
!dx.version = !{!1}
!dx.valver = !{!2}
!dx.shaderModel = !{!3}
!dx.viewIdState = !{!4}
!dx.entryPoints = !{!5}

!0 = !{!"dxcoob 1.9.2609.5 (01b62ad47)"}
!1 = !{i32 1, i32 6}
!2 = !{i32 1, i32 9}
!3 = !{!"vs", i32 6, i32 6}
!4 = !{[2 x i32] [i32 0, i32 4]}
!5 = !{void ()* @main, !"main", !6, null, !11}
!6 = !{null, !7, null}
!7 = !{!8}
!8 = !{i32 0, !"SV_Position", i8 9, i8 3, !9, i8 4, i32 1, i8 4, i32 0, i8 0, !10}
!9 = !{i32 0}
!10 = !{i32 3, i32 15}
!11 = !{i32 0, i64 1}

