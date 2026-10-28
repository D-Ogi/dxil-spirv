;
; Note: shader requires additional functionality:
;       Tiled resources
;       Typed UAV Load Additional Formats
;
;
; Input signature:
;
; Name                 Index   Mask Register SysValue  Format   Used
; -------------------- ----- ------ -------- -------- ------- ------
; A                        0   xy          0     NONE    uint   xy  
; B                        0     zw        0     NONE    uint     zw
;
;
; Output signature:
;
; Name                 Index   Mask Register SysValue  Format   Used
; -------------------- ----- ------ -------- -------- ------- ------
; SV_Target                0   xyzw        0   TARGET   float   xyzw
;
; shader hash: f52a3a33470e66ec6fc58c7a745b4498
;
; Pipeline Runtime Information: 
;
;PSVRuntimeInfo:
; Pixel Shader
; DepthOutput=0
; SampleFrequency=0
; MinimumExpectedWaveLaneCount: 0
; MaximumExpectedWaveLaneCount: 4294967295
; UsesViewID: false
; SigInputElements: 2
; SigOutputElements: 1
; SigPatchConstOrPrimElements: 0
; SigInputVectors: 1
; SigOutputVectors[0]: 1
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
; A                        0        nointerpolation       
; B                        0        nointerpolation       
;
; Output signature:
;
; Name                 Index             InterpMode DynIdx
; -------------------- ----- ---------------------- ------
; SV_Target                0                              
;
; Buffer Definitions:
;
;
; Resource Bindings:
;
; Name                                 Type  Format         Dim      ID      HLSL Bind  Count
; ------------------------------ ---------- ------- ----------- ------- -------------- ------
; uav1                                  UAV     f32          2d      U0             u3     1
;
;
; ViewId state:
;
; Number of inputs: 4, outputs: 4
; Outputs dependent on ViewId: {  }
; Inputs contributing to computation of Outputs:
;   output 0 depends on inputs: { 0, 1, 2, 3 }
;   output 1 depends on inputs: { 0, 1, 2, 3 }
;   output 2 depends on inputs: { 0, 1, 2, 3 }
;   output 3 depends on inputs: { 0, 1, 2, 3 }
;
target datalayout = "e-m:e-p:32:32-i1:32-i8:32-i16:32-i32:32-i64:64-f16:32-f32:32-f64:64-n8:16:32:64"
target triple = "dxil-ms-dx"

%dx.types.Handle = type { i8* }
%dx.types.ResRet.f32 = type { float, float, float, float, i32 }
%"class.RWTexture2D<vector<float, 4> >" = type { <4 x float> }

define void @main() {
  %1 = call %dx.types.Handle @dx.op.createHandle(i32 57, i8 1, i32 0, i32 3, i1 false)  ; CreateHandle(resourceClass,rangeId,index,nonUniformIndex)
  %2 = call i32 @dx.op.loadInput.i32(i32 4, i32 1, i32 0, i8 0, i32 undef)  ; LoadInput(inputSigId,rowIndex,colIndex,gsVertexAxis)
  %3 = call i32 @dx.op.loadInput.i32(i32 4, i32 1, i32 0, i8 1, i32 undef)  ; LoadInput(inputSigId,rowIndex,colIndex,gsVertexAxis)
  %4 = call i32 @dx.op.loadInput.i32(i32 4, i32 0, i32 0, i8 0, i32 undef)  ; LoadInput(inputSigId,rowIndex,colIndex,gsVertexAxis)
  %5 = call i32 @dx.op.loadInput.i32(i32 4, i32 0, i32 0, i8 1, i32 undef)  ; LoadInput(inputSigId,rowIndex,colIndex,gsVertexAxis)
  %6 = call %dx.types.ResRet.f32 @dx.op.textureLoad.f32(i32 66, %dx.types.Handle %1, i32 undef, i32 %2, i32 %3, i32 undef, i32 undef, i32 undef, i32 undef)  ; TextureLoad(srv,mipLevelOrSampleCount,coord0,coord1,coord2,offset0,offset1,offset2)
  %7 = extractvalue %dx.types.ResRet.f32 %6, 0
  %8 = extractvalue %dx.types.ResRet.f32 %6, 1
  %9 = extractvalue %dx.types.ResRet.f32 %6, 2
  %10 = extractvalue %dx.types.ResRet.f32 %6, 3
  call void @dx.op.barrier(i32 80, i32 2)  ; Barrier(barrierMode)
  %11 = call %dx.types.ResRet.f32 @dx.op.textureLoad.f32(i32 66, %dx.types.Handle %1, i32 undef, i32 %4, i32 %5, i32 undef, i32 undef, i32 undef, i32 undef)  ; TextureLoad(srv,mipLevelOrSampleCount,coord0,coord1,coord2,offset0,offset1,offset2)
  %12 = extractvalue %dx.types.ResRet.f32 %11, 0
  %13 = extractvalue %dx.types.ResRet.f32 %11, 1
  %14 = extractvalue %dx.types.ResRet.f32 %11, 2
  %15 = extractvalue %dx.types.ResRet.f32 %11, 3
  %16 = extractvalue %dx.types.ResRet.f32 %11, 4
  %17 = call i1 @dx.op.checkAccessFullyMapped.i32(i32 71, i32 %16)  ; CheckAccessFullyMapped(status)
  %18 = uitofp i1 %17 to float
  %19 = fmul fast float %18, 2.000000e+00
  %20 = fadd fast float %12, %7
  %21 = fadd fast float %20, %19
  %22 = fadd fast float %13, %8
  %23 = fadd fast float %22, %19
  %24 = fadd fast float %14, %9
  %25 = fadd fast float %24, %19
  %26 = fadd fast float %15, %10
  %27 = fadd fast float %26, %19
  call void @dx.op.barrier(i32 80, i32 2)  ; Barrier(barrierMode)
  call void @dx.op.textureStore.f32(i32 67, %dx.types.Handle %1, i32 %2, i32 %3, i32 undef, float %21, float %23, float %25, float %27, i8 15)  ; TextureStore(srv,coord0,coord1,coord2,value0,value1,value2,value3,mask)
  call void @dx.op.storeOutput.f32(i32 5, i32 0, i32 0, i8 0, float %21)  ; StoreOutput(outputSigId,rowIndex,colIndex,value)
  call void @dx.op.storeOutput.f32(i32 5, i32 0, i32 0, i8 1, float %23)  ; StoreOutput(outputSigId,rowIndex,colIndex,value)
  call void @dx.op.storeOutput.f32(i32 5, i32 0, i32 0, i8 2, float %25)  ; StoreOutput(outputSigId,rowIndex,colIndex,value)
  call void @dx.op.storeOutput.f32(i32 5, i32 0, i32 0, i8 3, float %27)  ; StoreOutput(outputSigId,rowIndex,colIndex,value)
  ret void
}

; Function Attrs: nounwind readnone
declare i32 @dx.op.loadInput.i32(i32, i32, i32, i8, i32) #0

; Function Attrs: nounwind
declare void @dx.op.storeOutput.f32(i32, i32, i32, i8, float) #1

; Function Attrs: nounwind readonly
declare %dx.types.ResRet.f32 @dx.op.textureLoad.f32(i32, %dx.types.Handle, i32, i32, i32, i32, i32, i32, i32) #2

; Function Attrs: nounwind
declare void @dx.op.textureStore.f32(i32, %dx.types.Handle, i32, i32, i32, float, float, float, float, i8) #1

; Function Attrs: noduplicate nounwind
declare void @dx.op.barrier(i32, i32) #3

; Function Attrs: nounwind readonly
declare i1 @dx.op.checkAccessFullyMapped.i32(i32, i32) #2

; Function Attrs: nounwind readonly
declare %dx.types.Handle @dx.op.createHandle(i32, i8, i32, i32, i1) #2

attributes #0 = { nounwind readnone }
attributes #1 = { nounwind }
attributes #2 = { nounwind readonly }
attributes #3 = { noduplicate nounwind }

!llvm.ident = !{!0}
!dx.version = !{!1}
!dx.valver = !{!2}
!dx.shaderModel = !{!3}
!dx.resources = !{!4}
!dx.viewIdState = !{!8}
!dx.entryPoints = !{!9}

!0 = !{!"dxcoob 1.9.2609.5 (01b62ad47)"}
!1 = !{i32 1, i32 0}
!2 = !{i32 1, i32 9}
!3 = !{!"ps", i32 6, i32 0}
!4 = !{null, !5, null, null}
!5 = !{!6}
!6 = !{i32 0, %"class.RWTexture2D<vector<float, 4> >"* undef, !"", i32 0, i32 3, i32 1, i32 2, i1 false, i1 false, i1 false, !7}
!7 = !{i32 0, i32 9}
!8 = !{[6 x i32] [i32 4, i32 4, i32 15, i32 15, i32 15, i32 15]}
!9 = !{void ()* @main, !"main", !10, !4, !19}
!10 = !{!11, !16, null}
!11 = !{!12, !15}
!12 = !{i32 0, !"A", i8 5, i8 0, !13, i8 1, i32 1, i8 2, i32 0, i8 0, !14}
!13 = !{i32 0}
!14 = !{i32 3, i32 3}
!15 = !{i32 1, !"B", i8 5, i8 0, !13, i8 1, i32 1, i8 2, i32 0, i8 2, !14}
!16 = !{!17}
!17 = !{i32 0, !"SV_Target", i8 9, i8 16, !13, i8 0, i32 1, i8 4, i32 0, i8 0, !18}
!18 = !{i32 3, i32 15}
!19 = !{i32 0, i64 12288}

