;
; Note: shader requires additional functionality:
;       UAVs at every shader stage
;       Raytracing tier 1.1 features
;
;
; Input signature:
;
; Name                 Index   Mask Register SysValue  Format   Used
; -------------------- ----- ------ -------- -------- ------- ------
; RAYDESC                  0   xyz         0     NONE   float   xyz 
; RAYDESC                  1   x           1     NONE   float   x   
; RAYDESC                  2   xyz         2     NONE   float   xyz 
; RAYDESC                  3   x           3     NONE   float   x   
;
;
; Output signature:
;
; Name                 Index   Mask Register SysValue  Format   Used
; -------------------- ----- ------ -------- -------- ------- ------
; OUT                      0   x           0     NONE   float   x   
;
; shader hash: 318d3fb635e9457aff18d79f234e148a
;
; Pipeline Runtime Information: 
;
;PSVRuntimeInfo:
; Vertex Shader
; OutputPositionPresent=0
; MinimumExpectedWaveLaneCount: 0
; MaximumExpectedWaveLaneCount: 4294967295
; UsesViewID: false
; SigInputElements: 4
; SigOutputElements: 1
; SigPatchConstOrPrimElements: 0
; SigInputVectors: 4
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
; RAYDESC                  0                              
; RAYDESC                  1                              
; RAYDESC                  2                              
; RAYDESC                  3                              
;
; Output signature:
;
; Name                 Index             InterpMode DynIdx
; -------------------- ----- ---------------------- ------
; OUT                      0                 linear       
;
; Buffer Definitions:
;
; Resource bind info for UAV
; {
;
;   int $Element;                                     ; Offset:    0 Size:     4
;
; }
;
;
; Resource Bindings:
;
; Name                                 Type  Format         Dim      ID      HLSL Bind  Count
; ------------------------------ ---------- ------- ----------- ------- -------------- ------
; RTAS                              texture     i32         ras      T0             t0     1
; UAV                                   UAV  struct         r/w      U0             u0     1
;
;
; ViewId state:
;
; Number of inputs: 13, outputs: 1
; Outputs dependent on ViewId: {  }
; Inputs contributing to computation of Outputs:
;
target datalayout = "e-m:e-p:32:32-i1:32-i8:32-i16:32-i32:32-i64:64-f16:32-f32:32-f64:64-n8:16:32:64"
target triple = "dxil-ms-dx"

%dx.types.Handle = type { i8* }
%dx.types.ResRet.i32 = type { i32, i32, i32, i32, i32 }
%struct.RaytracingAccelerationStructure = type { i32 }
%"class.RWStructuredBuffer<int>" = type { i32 }

define void @main() {
  %1 = call %dx.types.Handle @dx.op.createHandle(i32 57, i8 1, i32 0, i32 0, i1 false)  ; CreateHandle(resourceClass,rangeId,index,nonUniformIndex)
  %2 = call %dx.types.Handle @dx.op.createHandle(i32 57, i8 0, i32 0, i32 0, i1 false)  ; CreateHandle(resourceClass,rangeId,index,nonUniformIndex)
  %3 = call float @dx.op.loadInput.f32(i32 4, i32 3, i32 0, i8 0, i32 undef)  ; LoadInput(inputSigId,rowIndex,colIndex,gsVertexAxis)
  %4 = call float @dx.op.loadInput.f32(i32 4, i32 2, i32 0, i8 0, i32 undef)  ; LoadInput(inputSigId,rowIndex,colIndex,gsVertexAxis)
  %5 = call float @dx.op.loadInput.f32(i32 4, i32 2, i32 0, i8 1, i32 undef)  ; LoadInput(inputSigId,rowIndex,colIndex,gsVertexAxis)
  %6 = call float @dx.op.loadInput.f32(i32 4, i32 2, i32 0, i8 2, i32 undef)  ; LoadInput(inputSigId,rowIndex,colIndex,gsVertexAxis)
  %7 = call float @dx.op.loadInput.f32(i32 4, i32 1, i32 0, i8 0, i32 undef)  ; LoadInput(inputSigId,rowIndex,colIndex,gsVertexAxis)
  %8 = call float @dx.op.loadInput.f32(i32 4, i32 0, i32 0, i8 0, i32 undef)  ; LoadInput(inputSigId,rowIndex,colIndex,gsVertexAxis)
  %9 = call float @dx.op.loadInput.f32(i32 4, i32 0, i32 0, i8 1, i32 undef)  ; LoadInput(inputSigId,rowIndex,colIndex,gsVertexAxis)
  %10 = call float @dx.op.loadInput.f32(i32 4, i32 0, i32 0, i8 2, i32 undef)  ; LoadInput(inputSigId,rowIndex,colIndex,gsVertexAxis)
  %11 = call i32 @dx.op.allocateRayQuery(i32 178, i32 513)  ; AllocateRayQuery(constRayFlags)
  %12 = call i32 @dx.op.allocateRayQuery(i32 178, i32 513)  ; AllocateRayQuery(constRayFlags)
  call void @dx.op.rayQuery_TraceRayInline(i32 179, i32 %11, %dx.types.Handle %2, i32 1, i32 2, float %8, float %9, float %10, float %7, float %4, float %5, float %6, float %3)  ; RayQuery_TraceRayInline(rayQueryHandle,accelerationStructure,rayFlags,instanceInclusionMask,origin_X,origin_Y,origin_Z,tMin,direction_X,direction_Y,direction_Z,tMax)
  call void @dx.op.rayQuery_TraceRayInline(i32 179, i32 %12, %dx.types.Handle %2, i32 1, i32 2, float %8, float %9, float %10, float %7, float %4, float %5, float %6, float %3)  ; RayQuery_TraceRayInline(rayQueryHandle,accelerationStructure,rayFlags,instanceInclusionMask,origin_X,origin_Y,origin_Z,tMin,direction_X,direction_Y,direction_Z,tMax)
  %13 = call %dx.types.ResRet.i32 @dx.op.rawBufferLoad.i32(i32 139, %dx.types.Handle %1, i32 0, i32 0, i8 1, i32 4)  ; RawBufferLoad(srv,index,elementOffset,mask,alignment)
  %14 = extractvalue %dx.types.ResRet.i32 %13, 0
  %15 = icmp eq i32 %14, 0
  %16 = select i1 %15, i32 %11, i32 %12
  %17 = call i32 @dx.op.rayQuery_StateScalar.i32(i32 204, i32 %16)  ; RayQuery_CandidatePrimitiveIndex(rayQueryHandle)
  call void @dx.op.rawBufferStore.i32(i32 140, %dx.types.Handle %1, i32 1, i32 0, i32 %17, i32 undef, i32 undef, i32 undef, i8 1, i32 4)  ; RawBufferStore(uav,index,elementOffset,value0,value1,value2,value3,mask,alignment)
  call void @dx.op.storeOutput.f32(i32 5, i32 0, i32 0, i8 0, float 0.000000e+00)  ; StoreOutput(outputSigId,rowIndex,colIndex,value)
  ret void
}

; Function Attrs: nounwind readnone
declare float @dx.op.loadInput.f32(i32, i32, i32, i8, i32) #0

; Function Attrs: nounwind
declare void @dx.op.storeOutput.f32(i32, i32, i32, i8, float) #1

; Function Attrs: nounwind readonly
declare %dx.types.ResRet.i32 @dx.op.rawBufferLoad.i32(i32, %dx.types.Handle, i32, i32, i8, i32) #2

; Function Attrs: nounwind
declare void @dx.op.rawBufferStore.i32(i32, %dx.types.Handle, i32, i32, i32, i32, i32, i32, i8, i32) #1

; Function Attrs: nounwind
declare i32 @dx.op.allocateRayQuery(i32, i32) #1

; Function Attrs: nounwind
declare void @dx.op.rayQuery_TraceRayInline(i32, i32, %dx.types.Handle, i32, i32, float, float, float, float, float, float, float, float) #1

; Function Attrs: nounwind readonly
declare i32 @dx.op.rayQuery_StateScalar.i32(i32, i32) #2

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
!dx.viewIdState = !{!11}
!dx.entryPoints = !{!12}

!0 = !{!"dxcoob 1.9.2609.5 (01b62ad47)"}
!1 = !{i32 1, i32 5}
!2 = !{i32 1, i32 9}
!3 = !{!"vs", i32 6, i32 5}
!4 = !{!5, !8, null, null}
!5 = !{!6}
!6 = !{i32 0, %struct.RaytracingAccelerationStructure* undef, !"", i32 0, i32 0, i32 1, i32 16, i32 0, !7}
!7 = !{i32 0, i32 4}
!8 = !{!9}
!9 = !{i32 0, %"class.RWStructuredBuffer<int>"* undef, !"", i32 0, i32 0, i32 1, i32 12, i1 false, i1 false, i1 false, !10}
!10 = !{i32 1, i32 4}
!11 = !{[15 x i32] [i32 13, i32 1, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0]}
!12 = !{void ()* @main, !"main", !13, !4, !27}
!13 = !{!14, !25, null}
!14 = !{!15, !18, !21, !23}
!15 = !{i32 0, !"RAYDESC", i8 9, i8 0, !16, i8 0, i32 1, i8 3, i32 0, i8 0, !17}
!16 = !{i32 0}
!17 = !{i32 3, i32 7}
!18 = !{i32 1, !"RAYDESC", i8 9, i8 0, !19, i8 0, i32 1, i8 1, i32 1, i8 0, !20}
!19 = !{i32 1}
!20 = !{i32 3, i32 1}
!21 = !{i32 2, !"RAYDESC", i8 9, i8 0, !22, i8 0, i32 1, i8 3, i32 2, i8 0, !17}
!22 = !{i32 2}
!23 = !{i32 3, !"RAYDESC", i8 9, i8 0, !24, i8 0, i32 1, i8 1, i32 3, i8 0, !20}
!24 = !{i32 3}
!25 = !{!26}
!26 = !{i32 0, !"OUT", i8 9, i8 0, !16, i8 2, i32 1, i8 1, i32 0, i8 0, !20}
!27 = !{i32 0, i64 33619984}

