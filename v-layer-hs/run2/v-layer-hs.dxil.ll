;
; Note: shader requires additional functionality:
;       SV_RenderTargetArrayIndex or SV_ViewportArrayIndex from any shader feeding rasterizer
;
;
; Input signature:
;
; Name                 Index   Mask Register SysValue  Format   Used
; -------------------- ----- ------ -------- -------- ------- ------
; SV_Position              0   xyzw        0      POS   float    yzw
; TEXCOORD                 0   xy          1     NONE   float   xy  
; NORMAL                   0   xyz         2     NONE   float   xyz 
; SV_RenderTargetArrayIndex     0   x           3  RTINDEX    uint   x   
;
;
; Output signature:
;
; Name                 Index   Mask Register SysValue  Format   Used
; -------------------- ----- ------ -------- -------- ------- ------
; SV_Position              0   xyzw        0      POS   float   xyzw
; TEXCOORD                 0   xy          1     NONE   float   xy  
; NORMAL                   0   xyz         2     NONE   float   xyz 
; SV_RenderTargetArrayIndex     0   x           3  RTINDEX    uint   x   
;
;
; Patch Constant signature:
;
; Name                 Index   Mask Register SysValue  Format   Used
; -------------------- ----- ------ -------- -------- ------- ------
; SV_TessFactor            0      w        0  TRIEDGE   float      w
; SV_TessFactor            1      w        1  TRIEDGE   float      w
; SV_TessFactor            2      w        2  TRIEDGE   float      w
; SV_InsideTessFactor      0   x           3   TRIINT   float   x   
;
; shader hash: 0a8b01667e60cbac72f7426f182ca26a
;
; Pipeline Runtime Information: 
;
;PSVRuntimeInfo:
; Hull Shader
; InputControlPointCount=3
; OutputControlPointCount=3
; Domain=tri
; OutputPrimitive=triangle_cw
; MinimumExpectedWaveLaneCount: 0
; MaximumExpectedWaveLaneCount: 4294967295
; UsesViewID: false
; SigInputElements: 4
; SigOutputElements: 4
; SigPatchConstOrPrimElements: 2
; SigInputVectors: 4
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
; SV_Position              0          noperspective       
; TEXCOORD                 0                 linear       
; NORMAL                   0                 linear       
; SV_RenderTargetArrayIndex     0        nointerpolation       
;
; Output signature:
;
; Name                 Index             InterpMode DynIdx
; -------------------- ----- ---------------------- ------
; SV_Position              0          noperspective       
; TEXCOORD                 0                 linear       
; NORMAL                   0                 linear       
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
; cbuffer cb
; {
;
;   struct cb
;   {
;
;       float foo;                                    ; Offset:    0
;   
;   } cb;                                             ; Offset:    0 Size:     4
;
; }
;
;
; Resource Bindings:
;
; Name                                 Type  Format         Dim      ID      HLSL Bind  Count
; ------------------------------ ---------- ------- ----------- ------- -------------- ------
; cb                                cbuffer      NA          NA     CB0            cb0     1
;
;
; ViewId state:
;
; Number of inputs: 13, outputs: 13, patchconst: 13
; Outputs dependent on ViewId: {  }
; PCOutputs dependent on ViewId: {  }
; Inputs contributing to computation of Outputs:
;   output 1 depends on inputs: { 1 }
;   output 2 depends on inputs: { 2 }
;   output 3 depends on inputs: { 3 }
;   output 4 depends on inputs: { 4 }
;   output 5 depends on inputs: { 5 }
;   output 8 depends on inputs: { 8 }
;   output 9 depends on inputs: { 9 }
;   output 10 depends on inputs: { 10 }
;   output 12 depends on inputs: { 12 }
; Inputs contributing to computation of PCOutputs:
;
target datalayout = "e-m:e-p:32:32-i1:32-i8:32-i16:32-i32:32-i64:64-f16:32-f32:32-f64:64-n8:16:32:64"
target triple = "dxil-ms-dx"

%dx.types.Handle = type { i8* }
%dx.types.CBufRet.f32 = type { float, float, float, float }
%cb = type { float }

@dx.nothing.a = internal constant [1 x i32] zeroinitializer

define void @"\01?HSPerPatchFunc@@YA?AUHSPerPatchData@@V?$InputPatch@UPSSceneIn@@$02@@V?$OutputPatch@UHSPerVertexData@@$02@@@Z"() {
  %1 = load i32, i32* getelementptr inbounds ([1 x i32], [1 x i32]* @dx.nothing.a, i32 0, i32 0)
  %2 = load i32, i32* getelementptr inbounds ([1 x i32], [1 x i32]* @dx.nothing.a, i32 0, i32 0)
  %3 = load i32, i32* getelementptr inbounds ([1 x i32], [1 x i32]* @dx.nothing.a, i32 0, i32 0)
  %4 = load i32, i32* getelementptr inbounds ([1 x i32], [1 x i32]* @dx.nothing.a, i32 0, i32 0)
  %5 = load i32, i32* getelementptr inbounds ([1 x i32], [1 x i32]* @dx.nothing.a, i32 0, i32 0)
  call void @dx.op.storePatchConstant.f32(i32 106, i32 0, i32 0, i8 0, float 1.000000e+00)  ; StorePatchConstant(outputSigID,row,col,value)
  call void @dx.op.storePatchConstant.f32(i32 106, i32 0, i32 1, i8 0, float 1.000000e+00)  ; StorePatchConstant(outputSigID,row,col,value)
  call void @dx.op.storePatchConstant.f32(i32 106, i32 0, i32 2, i8 0, float 1.000000e+00)  ; StorePatchConstant(outputSigID,row,col,value)
  call void @dx.op.storePatchConstant.f32(i32 106, i32 1, i32 0, i8 0, float 1.000000e+00)  ; StorePatchConstant(outputSigID,row,col,value)
  %6 = load i32, i32* getelementptr inbounds ([1 x i32], [1 x i32]* @dx.nothing.a, i32 0, i32 0)
  ret void
}

define void @main() {
  %1 = call %dx.types.Handle @dx.op.createHandle(i32 57, i8 2, i32 0, i32 0, i1 false)  ; CreateHandle(resourceClass,rangeId,index,nonUniformIndex)
  %2 = call i32 @dx.op.outputControlPointID.i32(i32 107)  ; OutputControlPointID()
  %3 = load i32, i32* getelementptr inbounds ([1 x i32], [1 x i32]* @dx.nothing.a, i32 0, i32 0)
  %4 = call float @dx.op.loadInput.f32(i32 4, i32 0, i32 0, i8 1, i32 %2)  ; LoadInput(inputSigId,rowIndex,colIndex,gsVertexAxis)
  %5 = call float @dx.op.loadInput.f32(i32 4, i32 0, i32 0, i8 2, i32 %2)  ; LoadInput(inputSigId,rowIndex,colIndex,gsVertexAxis)
  %6 = call float @dx.op.loadInput.f32(i32 4, i32 0, i32 0, i8 3, i32 %2)  ; LoadInput(inputSigId,rowIndex,colIndex,gsVertexAxis)
  %7 = call float @dx.op.loadInput.f32(i32 4, i32 1, i32 0, i8 0, i32 %2)  ; LoadInput(inputSigId,rowIndex,colIndex,gsVertexAxis)
  %8 = call float @dx.op.loadInput.f32(i32 4, i32 1, i32 0, i8 1, i32 %2)  ; LoadInput(inputSigId,rowIndex,colIndex,gsVertexAxis)
  %9 = call float @dx.op.loadInput.f32(i32 4, i32 2, i32 0, i8 0, i32 %2)  ; LoadInput(inputSigId,rowIndex,colIndex,gsVertexAxis)
  %10 = call float @dx.op.loadInput.f32(i32 4, i32 2, i32 0, i8 1, i32 %2)  ; LoadInput(inputSigId,rowIndex,colIndex,gsVertexAxis)
  %11 = call float @dx.op.loadInput.f32(i32 4, i32 2, i32 0, i8 2, i32 %2)  ; LoadInput(inputSigId,rowIndex,colIndex,gsVertexAxis)
  %12 = call i32 @dx.op.loadInput.i32(i32 4, i32 3, i32 0, i8 0, i32 %2)  ; LoadInput(inputSigId,rowIndex,colIndex,gsVertexAxis)
  %13 = call %dx.types.CBufRet.f32 @dx.op.cbufferLoadLegacy.f32(i32 59, %dx.types.Handle %1, i32 0)  ; CBufferLoadLegacy(handle,regIndex)
  %14 = extractvalue %dx.types.CBufRet.f32 %13, 0
  %15 = load i32, i32* getelementptr inbounds ([1 x i32], [1 x i32]* @dx.nothing.a, i32 0, i32 0)
  %16 = fadd fast float %14, 1.000000e+00
  %17 = load i32, i32* getelementptr inbounds ([1 x i32], [1 x i32]* @dx.nothing.a, i32 0, i32 0)
  %18 = fadd fast float %16, 1.000000e+00
  %19 = load i32, i32* getelementptr inbounds ([1 x i32], [1 x i32]* @dx.nothing.a, i32 0, i32 0)
  %20 = fadd fast float %18, 1.000000e+00
  %21 = load i32, i32* getelementptr inbounds ([1 x i32], [1 x i32]* @dx.nothing.a, i32 0, i32 0)
  %22 = load i32, i32* getelementptr inbounds ([1 x i32], [1 x i32]* @dx.nothing.a, i32 0, i32 0)
  %23 = load i32, i32* getelementptr inbounds ([1 x i32], [1 x i32]* @dx.nothing.a, i32 0, i32 0)
  call void @dx.op.storeOutput.f32(i32 5, i32 0, i32 0, i8 0, float %20)  ; StoreOutput(outputSigId,rowIndex,colIndex,value)
  call void @dx.op.storeOutput.f32(i32 5, i32 0, i32 0, i8 1, float %4)  ; StoreOutput(outputSigId,rowIndex,colIndex,value)
  call void @dx.op.storeOutput.f32(i32 5, i32 0, i32 0, i8 2, float %5)  ; StoreOutput(outputSigId,rowIndex,colIndex,value)
  call void @dx.op.storeOutput.f32(i32 5, i32 0, i32 0, i8 3, float %6)  ; StoreOutput(outputSigId,rowIndex,colIndex,value)
  call void @dx.op.storeOutput.f32(i32 5, i32 1, i32 0, i8 0, float %7)  ; StoreOutput(outputSigId,rowIndex,colIndex,value)
  call void @dx.op.storeOutput.f32(i32 5, i32 1, i32 0, i8 1, float %8)  ; StoreOutput(outputSigId,rowIndex,colIndex,value)
  call void @dx.op.storeOutput.f32(i32 5, i32 2, i32 0, i8 0, float %9)  ; StoreOutput(outputSigId,rowIndex,colIndex,value)
  call void @dx.op.storeOutput.f32(i32 5, i32 2, i32 0, i8 1, float %10)  ; StoreOutput(outputSigId,rowIndex,colIndex,value)
  call void @dx.op.storeOutput.f32(i32 5, i32 2, i32 0, i8 2, float %11)  ; StoreOutput(outputSigId,rowIndex,colIndex,value)
  call void @dx.op.storeOutput.i32(i32 5, i32 3, i32 0, i8 0, i32 %12)  ; StoreOutput(outputSigId,rowIndex,colIndex,value)
  %24 = load i32, i32* getelementptr inbounds ([1 x i32], [1 x i32]* @dx.nothing.a, i32 0, i32 0)
  ret void
}

; Function Attrs: nounwind readnone
declare i32 @dx.op.outputControlPointID.i32(i32) #0

; Function Attrs: nounwind readnone
declare float @dx.op.loadInput.f32(i32, i32, i32, i8, i32) #0

; Function Attrs: nounwind readnone
declare i32 @dx.op.loadInput.i32(i32, i32, i32, i8, i32) #0

; Function Attrs: nounwind
declare void @dx.op.storeOutput.f32(i32, i32, i32, i8, float) #1

; Function Attrs: nounwind
declare void @dx.op.storeOutput.i32(i32, i32, i32, i8, i32) #1

; Function Attrs: nounwind
declare void @dx.op.storePatchConstant.f32(i32, i32, i32, i8, float) #1

; Function Attrs: nounwind readonly
declare %dx.types.CBufRet.f32 @dx.op.cbufferLoadLegacy.f32(i32, %dx.types.Handle, i32) #2

; Function Attrs: nounwind readonly
declare %dx.types.Handle @dx.op.createHandle(i32, i8, i32, i32, i1) #2

attributes #0 = { nounwind readnone }
attributes #1 = { nounwind }
attributes #2 = { nounwind readonly }

!llvm.ident = !{!0}
!dx.version = !{!1}
!dx.valver = !{!2}
!dx.shaderModel = !{!3}
!dx.resources = !{!4}
!dx.viewIdState = !{!7}
!dx.entryPoints = !{!8}

!0 = !{!"dxcoob 1.9.2609.5 (01b62ad47)"}
!1 = !{i32 1, i32 2}
!2 = !{i32 1, i32 9}
!3 = !{!"hs", i32 6, i32 2}
!4 = !{null, null, !5, null}
!5 = !{!6}
!6 = !{i32 0, %cb* undef, !"", i32 0, i32 0, i32 1, i32 4, null}
!7 = !{[29 x i32] [i32 13, i32 13, i32 0, i32 2, i32 4, i32 8, i32 16, i32 32, i32 0, i32 0, i32 256, i32 512, i32 1024, i32 0, i32 4096, i32 13, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0]}
!8 = !{void ()* @main, !"main", !9, !4, !27}
!9 = !{!10, !20, !23}
!10 = !{!11, !14, !16, !18}
!11 = !{i32 0, !"SV_Position", i8 9, i8 3, !12, i8 4, i32 1, i8 4, i32 0, i8 0, !13}
!12 = !{i32 0}
!13 = !{i32 3, i32 14}
!14 = !{i32 1, !"TEXCOORD", i8 9, i8 0, !12, i8 2, i32 1, i8 2, i32 1, i8 0, !15}
!15 = !{i32 3, i32 3}
!16 = !{i32 2, !"NORMAL", i8 9, i8 0, !12, i8 2, i32 1, i8 3, i32 2, i8 0, !17}
!17 = !{i32 3, i32 7}
!18 = !{i32 3, !"SV_RenderTargetArrayIndex", i8 5, i8 4, !12, i8 1, i32 1, i8 1, i32 3, i8 0, !19}
!19 = !{i32 3, i32 1}
!20 = !{!21, !14, !16, !18}
!21 = !{i32 0, !"SV_Position", i8 9, i8 3, !12, i8 4, i32 1, i8 4, i32 0, i8 0, !22}
!22 = !{i32 3, i32 15}
!23 = !{!24, !26}
!24 = !{i32 0, !"SV_TessFactor", i8 9, i8 25, !25, i8 0, i32 3, i8 1, i32 0, i8 3, !19}
!25 = !{i32 0, i32 1, i32 2}
!26 = !{i32 1, !"SV_InsideTessFactor", i8 9, i8 26, !12, i8 0, i32 1, i8 1, i32 3, i8 0, !19}
!27 = !{i32 0, i64 512, i32 3, !28}
!28 = !{void ()* @"\01?HSPerPatchFunc@@YA?AUHSPerPatchData@@V?$InputPatch@UPSSceneIn@@$02@@V?$OutputPatch@UHSPerVertexData@@$02@@@Z", i32 3, i32 3, i32 2, i32 3, i32 3, float 6.400000e+01}

