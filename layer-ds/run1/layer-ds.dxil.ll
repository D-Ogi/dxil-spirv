;
; Note: shader requires additional functionality:
;       SV_RenderTargetArrayIndex or SV_ViewportArrayIndex from any shader feeding rasterizer
;
;
; Input signature:
;
; Name                 Index   Mask Register SysValue  Format   Used
; -------------------- ----- ------ -------- -------- ------- ------
; SV_Position              0   xyzw        0      POS   float   xyzw
; SV_RenderTargetArrayIndex     0   x           1  RTINDEX    uint   x   
;
;
; Output signature:
;
; Name                 Index   Mask Register SysValue  Format   Used
; -------------------- ----- ------ -------- -------- ------- ------
; SV_Position              0   xyzw        0      POS   float   xyzw
; SV_RenderTargetArrayIndex     0   x           1  RTINDEX    uint   x   
;
;
; Patch Constant signature:
;
; Name                 Index   Mask Register SysValue  Format   Used
; -------------------- ----- ------ -------- -------- ------- ------
; SV_TessFactor            0      w        0  TRIEDGE   float   xyzw
; SV_TessFactor            1      w        1  TRIEDGE   float   xyzw
; SV_TessFactor            2      w        2  TRIEDGE   float   xyzw
; SV_InsideTessFactor      0   x           3   TRIINT   float   xyzw
;
; shader hash: 35d422486f96a351b6d7ceac45a2a7d4
;
; Pipeline Runtime Information: 
;
;PSVRuntimeInfo:
; Domain Shader
; InputControlPointCount=3
; OutputPositionPresent=1
; MinimumExpectedWaveLaneCount: 0
; MaximumExpectedWaveLaneCount: 4294967295
; UsesViewID: false
; SigInputElements: 2
; SigOutputElements: 2
; SigPatchConstOrPrimElements: 2
; SigInputVectors: 2
; SigOutputVectors[0]: 2
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
; SV_Position              0          noperspective       
; SV_RenderTargetArrayIndex     0        nointerpolation       
;
; Output signature:
;
; Name                 Index             InterpMode DynIdx
; -------------------- ----- ---------------------- ------
; SV_Position              0          noperspective       
; SV_RenderTargetArrayIndex     0        nointerpolation       
;
; Patch Constant signature:
;
; Name                 Index             InterpMode DynIdx
; -------------------- ----- ---------------------- ------
; SV_TessFactor            0                              
; SV_InsideTessFactor      0                              
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
; Number of inputs: 5, outputs: 5, patchconst: 13
; Outputs dependent on ViewId: {  }
; Inputs contributing to computation of Outputs:
;   output 0 depends on inputs: { 0 }
;   output 1 depends on inputs: { 1 }
;   output 2 depends on inputs: { 2 }
;   output 3 depends on inputs: { 3 }
;   output 4 depends on inputs: { 4 }
; PCInputs contributing to computation of Outputs:
;
target datalayout = "e-m:e-p:32:32-i1:32-i8:32-i16:32-i32:32-i64:64-f16:32-f32:32-f64:64-n8:16:32:64"
target triple = "dxil-ms-dx"

define void @main() {
  %1 = call float @dx.op.domainLocation.f32(i32 105, i8 0)  ; DomainLocation(component)
  %2 = call float @dx.op.domainLocation.f32(i32 105, i8 1)  ; DomainLocation(component)
  %3 = call float @dx.op.domainLocation.f32(i32 105, i8 2)  ; DomainLocation(component)
  %4 = call float @dx.op.loadInput.f32(i32 4, i32 0, i32 0, i8 0, i32 0)  ; LoadInput(inputSigId,rowIndex,colIndex,gsVertexAxis)
  %5 = call float @dx.op.loadInput.f32(i32 4, i32 0, i32 0, i8 1, i32 0)  ; LoadInput(inputSigId,rowIndex,colIndex,gsVertexAxis)
  %6 = call float @dx.op.loadInput.f32(i32 4, i32 0, i32 0, i8 2, i32 0)  ; LoadInput(inputSigId,rowIndex,colIndex,gsVertexAxis)
  %7 = call float @dx.op.loadInput.f32(i32 4, i32 0, i32 0, i8 3, i32 0)  ; LoadInput(inputSigId,rowIndex,colIndex,gsVertexAxis)
  %8 = fmul fast float %4, %1
  %9 = fmul fast float %5, %1
  %10 = fmul fast float %6, %1
  %11 = fmul fast float %7, %1
  %12 = call float @dx.op.loadInput.f32(i32 4, i32 0, i32 0, i8 0, i32 1)  ; LoadInput(inputSigId,rowIndex,colIndex,gsVertexAxis)
  %13 = call float @dx.op.loadInput.f32(i32 4, i32 0, i32 0, i8 1, i32 1)  ; LoadInput(inputSigId,rowIndex,colIndex,gsVertexAxis)
  %14 = call float @dx.op.loadInput.f32(i32 4, i32 0, i32 0, i8 2, i32 1)  ; LoadInput(inputSigId,rowIndex,colIndex,gsVertexAxis)
  %15 = call float @dx.op.loadInput.f32(i32 4, i32 0, i32 0, i8 3, i32 1)  ; LoadInput(inputSigId,rowIndex,colIndex,gsVertexAxis)
  %16 = fmul fast float %12, %2
  %17 = fmul fast float %13, %2
  %18 = fmul fast float %14, %2
  %19 = fmul fast float %15, %2
  %20 = fadd fast float %16, %8
  %21 = fadd fast float %17, %9
  %22 = fadd fast float %18, %10
  %23 = fadd fast float %19, %11
  %24 = call float @dx.op.loadInput.f32(i32 4, i32 0, i32 0, i8 0, i32 2)  ; LoadInput(inputSigId,rowIndex,colIndex,gsVertexAxis)
  %25 = call float @dx.op.loadInput.f32(i32 4, i32 0, i32 0, i8 1, i32 2)  ; LoadInput(inputSigId,rowIndex,colIndex,gsVertexAxis)
  %26 = call float @dx.op.loadInput.f32(i32 4, i32 0, i32 0, i8 2, i32 2)  ; LoadInput(inputSigId,rowIndex,colIndex,gsVertexAxis)
  %27 = call float @dx.op.loadInput.f32(i32 4, i32 0, i32 0, i8 3, i32 2)  ; LoadInput(inputSigId,rowIndex,colIndex,gsVertexAxis)
  %28 = fmul fast float %24, %3
  %29 = fmul fast float %25, %3
  %30 = fmul fast float %26, %3
  %31 = fmul fast float %27, %3
  %32 = fadd fast float %20, %28
  %33 = fadd fast float %21, %29
  %34 = fadd fast float %22, %30
  %35 = fadd fast float %23, %31
  %36 = call i32 @dx.op.loadInput.i32(i32 4, i32 1, i32 0, i8 0, i32 0)  ; LoadInput(inputSigId,rowIndex,colIndex,gsVertexAxis)
  call void @dx.op.storeOutput.f32(i32 5, i32 0, i32 0, i8 0, float %32)  ; StoreOutput(outputSigId,rowIndex,colIndex,value)
  call void @dx.op.storeOutput.f32(i32 5, i32 0, i32 0, i8 1, float %33)  ; StoreOutput(outputSigId,rowIndex,colIndex,value)
  call void @dx.op.storeOutput.f32(i32 5, i32 0, i32 0, i8 2, float %34)  ; StoreOutput(outputSigId,rowIndex,colIndex,value)
  call void @dx.op.storeOutput.f32(i32 5, i32 0, i32 0, i8 3, float %35)  ; StoreOutput(outputSigId,rowIndex,colIndex,value)
  call void @dx.op.storeOutput.i32(i32 5, i32 1, i32 0, i8 0, i32 %36)  ; StoreOutput(outputSigId,rowIndex,colIndex,value)
  ret void
}

; Function Attrs: nounwind readnone
declare float @dx.op.domainLocation.f32(i32, i8) #0

; Function Attrs: nounwind readnone
declare float @dx.op.loadInput.f32(i32, i32, i32, i8, i32) #0

; Function Attrs: nounwind readnone
declare i32 @dx.op.loadInput.i32(i32, i32, i32, i8, i32) #0

; Function Attrs: nounwind
declare void @dx.op.storeOutput.f32(i32, i32, i32, i8, float) #1

; Function Attrs: nounwind
declare void @dx.op.storeOutput.i32(i32, i32, i32, i8, i32) #1

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
!3 = !{!"ds", i32 6, i32 0}
!4 = !{[21 x i32] [i32 5, i32 5, i32 1, i32 2, i32 4, i32 8, i32 16, i32 13, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0]}
!5 = !{void ()* @main, !"main", !6, null, !17}
!6 = !{!7, !7, !13}
!7 = !{!8, !11}
!8 = !{i32 0, !"SV_Position", i8 9, i8 3, !9, i8 4, i32 1, i8 4, i32 0, i8 0, !10}
!9 = !{i32 0}
!10 = !{i32 3, i32 15}
!11 = !{i32 1, !"SV_RenderTargetArrayIndex", i8 5, i8 4, !9, i8 1, i32 1, i8 1, i32 1, i8 0, !12}
!12 = !{i32 3, i32 1}
!13 = !{!14, !16}
!14 = !{i32 0, !"SV_TessFactor", i8 9, i8 25, !15, i8 0, i32 3, i8 1, i32 0, i8 3, null}
!15 = !{i32 0, i32 1, i32 2}
!16 = !{i32 1, !"SV_InsideTessFactor", i8 9, i8 26, !9, i8 0, i32 1, i8 1, i32 3, i8 0, null}
!17 = !{i32 0, i64 512, i32 2, !18}
!18 = !{i32 2, i32 3}

