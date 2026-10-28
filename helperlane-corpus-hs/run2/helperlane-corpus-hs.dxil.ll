;
; Input signature:
;
; Name                 Index   Mask Register SysValue  Format   Used
; -------------------- ----- ------ -------- -------- ------- ------
; SV_Position              0   xyzw        0      POS   float   xyzw
;
;
; Output signature:
;
; Name                 Index   Mask Register SysValue  Format   Used
; -------------------- ----- ------ -------- -------- ------- ------
; SV_Position              0   xyzw        0      POS   float   xyzw
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
; TEST                     0   xyzw        4     NONE   float   xyzw
;
; shader hash: 022ebf4de987a1dc69bcd3bdf20c28fa
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
; SigInputElements: 1
; SigOutputElements: 1
; SigPatchConstOrPrimElements: 3
; SigInputVectors: 1
; SigOutputVectors[0]: 1
; SigOutputVectors[1]: 0
; SigOutputVectors[2]: 0
; SigOutputVectors[3]: 0
; EntryFunctionName: hs
;
;
; Input signature:
;
; Name                 Index             InterpMode DynIdx
; -------------------- ----- ---------------------- ------
; SV_Position              0          noperspective       
;
; Output signature:
;
; Name                 Index             InterpMode DynIdx
; -------------------- ----- ---------------------- ------
; SV_Position              0          noperspective       
;
; Patch Constant signature:
;
; Name                 Index             InterpMode DynIdx
; -------------------- ----- ---------------------- ------
; SV_TessFactor            0                              
; SV_InsideTessFactor      0                              
; TEST                     0                              
;
; Buffer Definitions:
;
; cbuffer $Globals
; {
;
;   struct $Globals
;   {
;
;       float4 a;                                     ; Offset:    0
;   
;   } $Globals;                                       ; Offset:    0 Size:    16
;
; }
;
;
; Resource Bindings:
;
; Name                                 Type  Format         Dim      ID      HLSL Bind  Count
; ------------------------------ ---------- ------- ----------- ------- -------------- ------
; $Globals                          cbuffer      NA          NA     CB0            cb0     1
;
;
; ViewId state:
;
; Number of inputs: 4, outputs: 4, patchconst: 20
; Outputs dependent on ViewId: {  }
; PCOutputs dependent on ViewId: {  }
; Inputs contributing to computation of Outputs:
;   output 0 depends on inputs: { 0 }
;   output 1 depends on inputs: { 1 }
;   output 2 depends on inputs: { 2 }
;   output 3 depends on inputs: { 3 }
; Inputs contributing to computation of PCOutputs:
;   output 3 depends on inputs: { 3 }
;   output 7 depends on inputs: { 3 }
;   output 11 depends on inputs: { 3 }
;   output 12 depends on inputs: { 3 }
;
target datalayout = "e-m:e-p:32:32-i1:32-i8:32-i16:32-i32:32-i64:64-f16:32-f32:32-f64:64-n8:16:32:64"
target triple = "dxil-ms-dx"

%dx.types.Handle = type { i8* }
%dx.types.ResBind = type { i32, i32, i32, i8 }
%dx.types.ResourceProperties = type { i32, i32 }
%dx.types.CBufRet.f32 = type { float, float, float, float }
%"$Globals" = type { <4 x float> }

@dx.nothing.a = internal constant [1 x i32] zeroinitializer

define void @"\01?pc@@YA?AUPCStruct@@V?$InputPatch@UPosStruct@@$02@@V?$OutputPatch@UPosStruct@@$02@@I@Z"() {
  %1 = call %dx.types.Handle @dx.op.createHandleFromBinding(i32 217, %dx.types.ResBind { i32 0, i32 0, i32 0, i8 2 }, i32 0, i1 false)  ; CreateHandleFromBinding(bind,index,nonUniformIndex)
  %2 = call %dx.types.Handle @dx.op.annotateHandle(i32 216, %dx.types.Handle %1, %dx.types.ResourceProperties { i32 13, i32 16 })  ; AnnotateHandle(res,props)  resource: CBuffer
  %3 = call %dx.types.CBufRet.f32 @dx.op.cbufferLoadLegacy.f32(i32 59, %dx.types.Handle %2, i32 0)  ; CBufferLoadLegacy(handle,regIndex)
  %4 = extractvalue %dx.types.CBufRet.f32 %3, 0
  %5 = extractvalue %dx.types.CBufRet.f32 %3, 1
  %6 = extractvalue %dx.types.CBufRet.f32 %3, 2
  %7 = extractvalue %dx.types.CBufRet.f32 %3, 3
  %8 = call i1 @dx.op.isHelperLane.i1(i32 221)  ; IsHelperLane()
  %9 = uitofp i1 %8 to float
  %10 = fadd fast float %4, %9
  %11 = fadd fast float %5, %9
  %12 = fadd fast float %6, %9
  %13 = fadd fast float %7, %9
  %14 = load i32, i32* getelementptr inbounds ([1 x i32], [1 x i32]* @dx.nothing.a, i32 0, i32 0)
  %15 = call float @dx.op.loadInput.f32(i32 4, i32 0, i32 0, i8 3, i32 0)  ; LoadInput(inputSigId,rowIndex,colIndex,gsVertexAxis)
  %16 = fmul fast float %15, %10
  %17 = load i32, i32* getelementptr inbounds ([1 x i32], [1 x i32]* @dx.nothing.a, i32 0, i32 0)
  %18 = call float @dx.op.loadInput.f32(i32 4, i32 0, i32 0, i8 3, i32 0)  ; LoadInput(inputSigId,rowIndex,colIndex,gsVertexAxis)
  %19 = fmul fast float %18, %11
  %20 = load i32, i32* getelementptr inbounds ([1 x i32], [1 x i32]* @dx.nothing.a, i32 0, i32 0)
  %21 = call float @dx.op.loadInput.f32(i32 4, i32 0, i32 0, i8 3, i32 0)  ; LoadInput(inputSigId,rowIndex,colIndex,gsVertexAxis)
  %22 = fmul fast float %21, %12
  %23 = load i32, i32* getelementptr inbounds ([1 x i32], [1 x i32]* @dx.nothing.a, i32 0, i32 0)
  %24 = call float @dx.op.loadInput.f32(i32 4, i32 0, i32 0, i8 3, i32 0)  ; LoadInput(inputSigId,rowIndex,colIndex,gsVertexAxis)
  %25 = fmul fast float %24, %13
  %26 = load i32, i32* getelementptr inbounds ([1 x i32], [1 x i32]* @dx.nothing.a, i32 0, i32 0)
  %27 = load i32, i32* getelementptr inbounds ([1 x i32], [1 x i32]* @dx.nothing.a, i32 0, i32 0)
  call void @dx.op.storePatchConstant.f32(i32 106, i32 0, i32 0, i8 0, float %16)  ; StorePatchConstant(outputSigID,row,col,value)
  call void @dx.op.storePatchConstant.f32(i32 106, i32 0, i32 1, i8 0, float %19)  ; StorePatchConstant(outputSigID,row,col,value)
  call void @dx.op.storePatchConstant.f32(i32 106, i32 0, i32 2, i8 0, float %22)  ; StorePatchConstant(outputSigID,row,col,value)
  call void @dx.op.storePatchConstant.f32(i32 106, i32 1, i32 0, i8 0, float %25)  ; StorePatchConstant(outputSigID,row,col,value)
  call void @dx.op.storePatchConstant.f32(i32 106, i32 2, i32 0, i8 0, float undef)  ; StorePatchConstant(outputSigID,row,col,value)
  call void @dx.op.storePatchConstant.f32(i32 106, i32 2, i32 0, i8 1, float undef)  ; StorePatchConstant(outputSigID,row,col,value)
  call void @dx.op.storePatchConstant.f32(i32 106, i32 2, i32 0, i8 2, float undef)  ; StorePatchConstant(outputSigID,row,col,value)
  call void @dx.op.storePatchConstant.f32(i32 106, i32 2, i32 0, i8 3, float undef)  ; StorePatchConstant(outputSigID,row,col,value)
  %28 = load i32, i32* getelementptr inbounds ([1 x i32], [1 x i32]* @dx.nothing.a, i32 0, i32 0)
  ret void
}

define void @hs() {
  %1 = call %dx.types.Handle @dx.op.createHandleFromBinding(i32 217, %dx.types.ResBind { i32 0, i32 0, i32 0, i8 2 }, i32 0, i1 false)  ; CreateHandleFromBinding(bind,index,nonUniformIndex)
  %2 = call %dx.types.Handle @dx.op.annotateHandle(i32 216, %dx.types.Handle %1, %dx.types.ResourceProperties { i32 13, i32 16 })  ; AnnotateHandle(res,props)  resource: CBuffer
  %3 = call i32 @dx.op.outputControlPointID.i32(i32 107)  ; OutputControlPointID()
  %4 = call %dx.types.CBufRet.f32 @dx.op.cbufferLoadLegacy.f32(i32 59, %dx.types.Handle %2, i32 0)  ; CBufferLoadLegacy(handle,regIndex)
  %5 = extractvalue %dx.types.CBufRet.f32 %4, 0
  %6 = extractvalue %dx.types.CBufRet.f32 %4, 1
  %7 = extractvalue %dx.types.CBufRet.f32 %4, 2
  %8 = extractvalue %dx.types.CBufRet.f32 %4, 3
  %9 = call i1 @dx.op.isHelperLane.i1(i32 221)  ; IsHelperLane()
  %10 = uitofp i1 %9 to float
  %11 = fadd fast float %5, %10
  %12 = fadd fast float %6, %10
  %13 = fadd fast float %7, %10
  %14 = fadd fast float %8, %10
  %15 = load i32, i32* getelementptr inbounds ([1 x i32], [1 x i32]* @dx.nothing.a, i32 0, i32 0)
  %16 = call float @dx.op.loadInput.f32(i32 4, i32 0, i32 0, i8 0, i32 %3)  ; LoadInput(inputSigId,rowIndex,colIndex,gsVertexAxis)
  %17 = call float @dx.op.loadInput.f32(i32 4, i32 0, i32 0, i8 1, i32 %3)  ; LoadInput(inputSigId,rowIndex,colIndex,gsVertexAxis)
  %18 = call float @dx.op.loadInput.f32(i32 4, i32 0, i32 0, i8 2, i32 %3)  ; LoadInput(inputSigId,rowIndex,colIndex,gsVertexAxis)
  %19 = call float @dx.op.loadInput.f32(i32 4, i32 0, i32 0, i8 3, i32 %3)  ; LoadInput(inputSigId,rowIndex,colIndex,gsVertexAxis)
  %20 = fmul fast float %16, %11
  %21 = fmul fast float %17, %12
  %22 = fmul fast float %18, %13
  %23 = fmul fast float %19, %14
  %24 = load i32, i32* getelementptr inbounds ([1 x i32], [1 x i32]* @dx.nothing.a, i32 0, i32 0)
  %25 = load i32, i32* getelementptr inbounds ([1 x i32], [1 x i32]* @dx.nothing.a, i32 0, i32 0)
  call void @dx.op.storeOutput.f32(i32 5, i32 0, i32 0, i8 0, float %20)  ; StoreOutput(outputSigId,rowIndex,colIndex,value)
  call void @dx.op.storeOutput.f32(i32 5, i32 0, i32 0, i8 1, float %21)  ; StoreOutput(outputSigId,rowIndex,colIndex,value)
  call void @dx.op.storeOutput.f32(i32 5, i32 0, i32 0, i8 2, float %22)  ; StoreOutput(outputSigId,rowIndex,colIndex,value)
  call void @dx.op.storeOutput.f32(i32 5, i32 0, i32 0, i8 3, float %23)  ; StoreOutput(outputSigId,rowIndex,colIndex,value)
  %26 = load i32, i32* getelementptr inbounds ([1 x i32], [1 x i32]* @dx.nothing.a, i32 0, i32 0)
  ret void
}

; Function Attrs: nounwind readnone
declare i32 @dx.op.outputControlPointID.i32(i32) #0

; Function Attrs: nounwind readnone
declare float @dx.op.loadInput.f32(i32, i32, i32, i8, i32) #0

; Function Attrs: nounwind
declare void @dx.op.storeOutput.f32(i32, i32, i32, i8, float) #1

; Function Attrs: nounwind
declare void @dx.op.storePatchConstant.f32(i32, i32, i32, i8, float) #1

; Function Attrs: nounwind readonly
declare i1 @dx.op.isHelperLane.i1(i32) #2

; Function Attrs: nounwind readonly
declare %dx.types.CBufRet.f32 @dx.op.cbufferLoadLegacy.f32(i32, %dx.types.Handle, i32) #2

; Function Attrs: nounwind readnone
declare %dx.types.Handle @dx.op.annotateHandle(i32, %dx.types.Handle, %dx.types.ResourceProperties) #0

; Function Attrs: nounwind readnone
declare %dx.types.Handle @dx.op.createHandleFromBinding(i32, %dx.types.ResBind, i32, i1) #0

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
!1 = !{i32 1, i32 6}
!2 = !{i32 1, i32 9}
!3 = !{!"hs", i32 6, i32 6}
!4 = !{null, null, !5, null}
!5 = !{!6}
!6 = !{i32 0, %"$Globals"* undef, !"", i32 0, i32 0, i32 1, i32 16, null}
!7 = !{[11 x i32] [i32 4, i32 4, i32 1, i32 2, i32 4, i32 8, i32 20, i32 0, i32 0, i32 0, i32 6280]}
!8 = !{void ()* @hs, !"hs", !9, !4, !20}
!9 = !{!10, !10, !14}
!10 = !{!11}
!11 = !{i32 0, !"SV_Position", i8 9, i8 3, !12, i8 4, i32 1, i8 4, i32 0, i8 0, !13}
!12 = !{i32 0}
!13 = !{i32 3, i32 15}
!14 = !{!15, !18, !19}
!15 = !{i32 0, !"SV_TessFactor", i8 9, i8 25, !16, i8 0, i32 3, i8 1, i32 0, i8 3, !17}
!16 = !{i32 0, i32 1, i32 2}
!17 = !{i32 3, i32 1}
!18 = !{i32 1, !"SV_InsideTessFactor", i8 9, i8 26, !12, i8 0, i32 1, i8 1, i32 3, i8 0, !17}
!19 = !{i32 2, !"TEST", i8 9, i8 0, !12, i8 0, i32 1, i8 4, i32 4, i8 0, !13}
!20 = !{i32 0, i64 1, i32 3, !21}
!21 = !{void ()* @"\01?pc@@YA?AUPCStruct@@V?$InputPatch@UPosStruct@@$02@@V?$OutputPatch@UPosStruct@@$02@@I@Z", i32 3, i32 3, i32 2, i32 3, i32 3, float 6.400000e+01}

