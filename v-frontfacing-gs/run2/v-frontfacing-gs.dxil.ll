;
; Input signature:
;
; Name                 Index   Mask Register SysValue  Format   Used
; -------------------- ----- ------ -------- -------- ------- ------
; TEXCOORD                 0   xy          0     NONE   float   xy  
; COLOR                    0   xyzw        1     NONE   float   xyzw
; SV_Position              0   xyzw        2      POS   float   xyzw
;
;
; Output signature:
;
; Name                 Index   Mask Register SysValue  Format   Used
; -------------------- ----- ------ -------- -------- ------- ------
; TEXCOORD                 0   xy          0     NONE   float   xy  
; COLOR                    0   xyzw        1     NONE   float   xyzw
; SV_Position              0   xyzw        2      POS   float   xyzw
; SV_IsFrontFace           0   x           3    FFACE    uint   x   
;
; shader hash: 622ac23bf034a255278c6b3e72f58f80
;
; Pipeline Runtime Information: 
;
;PSVRuntimeInfo:
; Geometry Shader
; InputPrimitive=point
; OutputTopology=point
; OutputStreamMask=1
; OutputPositionPresent=1
; MinimumExpectedWaveLaneCount: 0
; MaximumExpectedWaveLaneCount: 4294967295
; UsesViewID: false
; SigInputElements: 3
; SigOutputElements: 4
; SigPatchConstOrPrimElements: 0
; SigInputVectors: 3
; SigOutputVectors[0]: 4
; SigOutputVectors[1]: 0
; SigOutputVectors[2]: 0
; SigOutputVectors[3]: 0
; EntryFunctionName: main
;
;
; Input signature:
;
; Name                 Index             InterpMode DynIdx
; -------------------- ----- ---------------------- ------
; TEXCOORD                 0                 linear       
; COLOR                    0                 linear       
; SV_Position              0          noperspective       
;
; Output signature:
;
; Name                 Index             InterpMode DynIdx
; -------------------- ----- ---------------------- ------
; TEXCOORD                 0                 linear       
; COLOR                    0                 linear       
; SV_Position              0          noperspective       
; SV_IsFrontFace           0        nointerpolation       
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
; Number of inputs: 12, outputs per stream: { 13, 0, 0, 0 }
; Outputs for Stream 0 dependent on ViewId: {  }
; Inputs contributing to computation of Outputs for Stream 0:
;   output 0 depends on inputs: { 0 }
;   output 1 depends on inputs: { 1 }
;   output 4 depends on inputs: { 4 }
;   output 5 depends on inputs: { 5 }
;   output 6 depends on inputs: { 6 }
;   output 7 depends on inputs: { 7 }
;   output 8 depends on inputs: { 8 }
;   output 9 depends on inputs: { 9 }
;   output 10 depends on inputs: { 10 }
;   output 11 depends on inputs: { 11 }
;
target datalayout = "e-m:e-p:32:32-i1:32-i8:32-i16:32-i32:32-i64:64-f16:32-f32:32-f64:64-n8:16:32:64"
target triple = "dxil-ms-dx"

define void @main() {
  %1 = call float @dx.op.loadInput.f32(i32 4, i32 0, i32 0, i8 0, i32 0)  ; LoadInput(inputSigId,rowIndex,colIndex,gsVertexAxis)
  %2 = call float @dx.op.loadInput.f32(i32 4, i32 0, i32 0, i8 1, i32 0)  ; LoadInput(inputSigId,rowIndex,colIndex,gsVertexAxis)
  %3 = call float @dx.op.loadInput.f32(i32 4, i32 1, i32 0, i8 0, i32 0)  ; LoadInput(inputSigId,rowIndex,colIndex,gsVertexAxis)
  %4 = call float @dx.op.loadInput.f32(i32 4, i32 1, i32 0, i8 1, i32 0)  ; LoadInput(inputSigId,rowIndex,colIndex,gsVertexAxis)
  %5 = call float @dx.op.loadInput.f32(i32 4, i32 1, i32 0, i8 2, i32 0)  ; LoadInput(inputSigId,rowIndex,colIndex,gsVertexAxis)
  %6 = call float @dx.op.loadInput.f32(i32 4, i32 1, i32 0, i8 3, i32 0)  ; LoadInput(inputSigId,rowIndex,colIndex,gsVertexAxis)
  %7 = call float @dx.op.loadInput.f32(i32 4, i32 2, i32 0, i8 0, i32 0)  ; LoadInput(inputSigId,rowIndex,colIndex,gsVertexAxis)
  %8 = call float @dx.op.loadInput.f32(i32 4, i32 2, i32 0, i8 1, i32 0)  ; LoadInput(inputSigId,rowIndex,colIndex,gsVertexAxis)
  %9 = call float @dx.op.loadInput.f32(i32 4, i32 2, i32 0, i8 2, i32 0)  ; LoadInput(inputSigId,rowIndex,colIndex,gsVertexAxis)
  %10 = call float @dx.op.loadInput.f32(i32 4, i32 2, i32 0, i8 3, i32 0)  ; LoadInput(inputSigId,rowIndex,colIndex,gsVertexAxis)
  call void @dx.op.storeOutput.f32(i32 5, i32 0, i32 0, i8 0, float %1)  ; StoreOutput(outputSigId,rowIndex,colIndex,value)
  call void @dx.op.storeOutput.f32(i32 5, i32 0, i32 0, i8 1, float %2)  ; StoreOutput(outputSigId,rowIndex,colIndex,value)
  call void @dx.op.storeOutput.f32(i32 5, i32 1, i32 0, i8 0, float %3)  ; StoreOutput(outputSigId,rowIndex,colIndex,value)
  call void @dx.op.storeOutput.f32(i32 5, i32 1, i32 0, i8 1, float %4)  ; StoreOutput(outputSigId,rowIndex,colIndex,value)
  call void @dx.op.storeOutput.f32(i32 5, i32 1, i32 0, i8 2, float %5)  ; StoreOutput(outputSigId,rowIndex,colIndex,value)
  call void @dx.op.storeOutput.f32(i32 5, i32 1, i32 0, i8 3, float %6)  ; StoreOutput(outputSigId,rowIndex,colIndex,value)
  call void @dx.op.storeOutput.f32(i32 5, i32 2, i32 0, i8 0, float %7)  ; StoreOutput(outputSigId,rowIndex,colIndex,value)
  call void @dx.op.storeOutput.f32(i32 5, i32 2, i32 0, i8 1, float %8)  ; StoreOutput(outputSigId,rowIndex,colIndex,value)
  call void @dx.op.storeOutput.f32(i32 5, i32 2, i32 0, i8 2, float %9)  ; StoreOutput(outputSigId,rowIndex,colIndex,value)
  call void @dx.op.storeOutput.f32(i32 5, i32 2, i32 0, i8 3, float %10)  ; StoreOutput(outputSigId,rowIndex,colIndex,value)
  call void @dx.op.storeOutput.i32(i32 5, i32 3, i32 0, i8 0, i32 0)  ; StoreOutput(outputSigId,rowIndex,colIndex,value)
  call void @dx.op.emitStream(i32 97, i8 0)  ; EmitStream(streamId)
  call void @dx.op.cutStream(i32 98, i8 0)  ; CutStream(streamId)
  ret void
}

; Function Attrs: nounwind readnone
declare float @dx.op.loadInput.f32(i32, i32, i32, i8, i32) #0

; Function Attrs: nounwind
declare void @dx.op.storeOutput.f32(i32, i32, i32, i8, float) #1

; Function Attrs: nounwind
declare void @dx.op.storeOutput.i32(i32, i32, i32, i8, i32) #1

; Function Attrs: nounwind
declare void @dx.op.cutStream(i32, i8) #1

; Function Attrs: nounwind
declare void @dx.op.emitStream(i32, i8) #1

attributes #0 = { nounwind readnone }
attributes #1 = { nounwind }

!llvm.ident = !{!0}
!dx.version = !{!1}
!dx.valver = !{!2}
!dx.shaderModel = !{!3}
!dx.viewIdState = !{!4}
!dx.entryPoints = !{!5}

!0 = !{!"dxcoob 1.9.2609.5 (01b62ad47)"}
!1 = !{i32 1, i32 0}
!2 = !{i32 1, i32 9}
!3 = !{!"gs", i32 6, i32 0}
!4 = !{[17 x i32] [i32 12, i32 13, i32 1, i32 2, i32 0, i32 0, i32 16, i32 32, i32 64, i32 128, i32 256, i32 512, i32 1024, i32 2048, i32 0, i32 0, i32 0]}
!5 = !{void ()* @main, !"main", !6, null, !17}
!6 = !{!7, !14, null}
!7 = !{!8, !11, !13}
!8 = !{i32 0, !"TEXCOORD", i8 9, i8 0, !9, i8 2, i32 1, i8 2, i32 0, i8 0, !10}
!9 = !{i32 0}
!10 = !{i32 3, i32 3}
!11 = !{i32 1, !"COLOR", i8 9, i8 0, !9, i8 2, i32 1, i8 4, i32 1, i8 0, !12}
!12 = !{i32 3, i32 15}
!13 = !{i32 2, !"SV_Position", i8 9, i8 3, !9, i8 4, i32 1, i8 4, i32 2, i8 0, !12}
!14 = !{!8, !11, !13, !15}
!15 = !{i32 3, !"SV_IsFrontFace", i8 5, i8 13, !9, i8 1, i32 1, i8 1, i32 3, i8 0, !16}
!16 = !{i32 3, i32 1}
!17 = !{i32 1, !18}
!18 = !{i32 1, i32 3, i32 1, i32 1, i32 24}

