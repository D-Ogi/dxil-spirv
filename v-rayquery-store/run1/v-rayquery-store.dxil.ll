;
; Note: shader requires additional functionality:
;       Raytracing tier 1.1 features
;
;
; Input signature:
;
; Name                 Index   Mask Register SysValue  Format   Used
; -------------------- ----- ------ -------- -------- ------- ------
; IDX                      0   x           0     NONE    uint   x   
; RAYDESC                  0   xyz         1     NONE   float   xyz 
; RAYDESC                  1   x           2     NONE   float   x   
; RAYDESC                  2   xyz         3     NONE   float   xyz 
; RAYDESC                  3   x           4     NONE   float   x   
;
;
; Output signature:
;
; Name                 Index   Mask Register SysValue  Format   Used
; -------------------- ----- ------ -------- -------- ------- ------
; no parameters
; shader hash: fe9761c3628546d83ed33beed768d8d9
;
; Pipeline Runtime Information: 
;
;PSVRuntimeInfo:
; Vertex Shader
; OutputPositionPresent=0
; MinimumExpectedWaveLaneCount: 0
; MaximumExpectedWaveLaneCount: 4294967295
; UsesViewID: false
; SigInputElements: 5
; SigOutputElements: 0
; SigPatchConstOrPrimElements: 0
; SigInputVectors: 5
; SigOutputVectors[0]: 0
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
; IDX                      0                              
; RAYDESC                  0                              
; RAYDESC                  1                              
; RAYDESC                  2                              
; RAYDESC                  3                              
;
; Buffer Definitions:
;
;
; Resource Bindings:
;
; Name                                 Type  Format         Dim      ID      HLSL Bind  Count
; ------------------------------ ---------- ------- ----------- ------- -------------- ------
; RTAS                              texture     i32         ras      T0             t0     1
;
;
; ViewId state:
;
; Number of inputs: 17, outputs: 0
; Outputs dependent on ViewId: {  }
; Inputs contributing to computation of Outputs:
;
target datalayout = "e-m:e-p:32:32-i1:32-i8:32-i16:32-i32:32-i64:64-f16:32-f32:32-f64:64-n8:16:32:64"
target triple = "dxil-ms-dx"

%dx.types.Handle = type { i8* }
%struct.RaytracingAccelerationStructure = type { i32 }

@g_rayQueryArray.0 = internal unnamed_addr global [4 x i32] undef, align 4

define void @main() {
  %1 = call %dx.types.Handle @dx.op.createHandle(i32 57, i8 0, i32 0, i32 0, i1 false)  ; CreateHandle(resourceClass,rangeId,index,nonUniformIndex)
  %2 = call float @dx.op.loadInput.f32(i32 4, i32 4, i32 0, i8 0, i32 undef)  ; LoadInput(inputSigId,rowIndex,colIndex,gsVertexAxis)
  %3 = call float @dx.op.loadInput.f32(i32 4, i32 3, i32 0, i8 0, i32 undef)  ; LoadInput(inputSigId,rowIndex,colIndex,gsVertexAxis)
  %4 = call float @dx.op.loadInput.f32(i32 4, i32 3, i32 0, i8 1, i32 undef)  ; LoadInput(inputSigId,rowIndex,colIndex,gsVertexAxis)
  %5 = call float @dx.op.loadInput.f32(i32 4, i32 3, i32 0, i8 2, i32 undef)  ; LoadInput(inputSigId,rowIndex,colIndex,gsVertexAxis)
  %6 = call float @dx.op.loadInput.f32(i32 4, i32 2, i32 0, i8 0, i32 undef)  ; LoadInput(inputSigId,rowIndex,colIndex,gsVertexAxis)
  %7 = call float @dx.op.loadInput.f32(i32 4, i32 1, i32 0, i8 0, i32 undef)  ; LoadInput(inputSigId,rowIndex,colIndex,gsVertexAxis)
  %8 = call float @dx.op.loadInput.f32(i32 4, i32 1, i32 0, i8 1, i32 undef)  ; LoadInput(inputSigId,rowIndex,colIndex,gsVertexAxis)
  %9 = call float @dx.op.loadInput.f32(i32 4, i32 1, i32 0, i8 2, i32 undef)  ; LoadInput(inputSigId,rowIndex,colIndex,gsVertexAxis)
  %10 = call i32 @dx.op.loadInput.i32(i32 4, i32 0, i32 0, i8 0, i32 undef)  ; LoadInput(inputSigId,rowIndex,colIndex,gsVertexAxis)
  %11 = call i32 @dx.op.allocateRayQuery(i32 178, i32 0)  ; AllocateRayQuery(constRayFlags)
  store i32 %11, i32* getelementptr inbounds ([4 x i32], [4 x i32]* @g_rayQueryArray.0, i32 0, i32 0), align 4
  %12 = call i32 @dx.op.allocateRayQuery(i32 178, i32 0)  ; AllocateRayQuery(constRayFlags)
  store i32 %12, i32* getelementptr inbounds ([4 x i32], [4 x i32]* @g_rayQueryArray.0, i32 0, i32 1), align 4
  %13 = call i32 @dx.op.allocateRayQuery(i32 178, i32 0)  ; AllocateRayQuery(constRayFlags)
  store i32 %13, i32* getelementptr inbounds ([4 x i32], [4 x i32]* @g_rayQueryArray.0, i32 0, i32 2), align 4
  %14 = call i32 @dx.op.allocateRayQuery(i32 178, i32 0)  ; AllocateRayQuery(constRayFlags)
  store i32 %14, i32* getelementptr inbounds ([4 x i32], [4 x i32]* @g_rayQueryArray.0, i32 0, i32 3), align 4
  %15 = call i32 @dx.op.allocateRayQuery(i32 178, i32 0)  ; AllocateRayQuery(constRayFlags)
  %16 = getelementptr inbounds [4 x i32], [4 x i32]* @g_rayQueryArray.0, i32 0, i32 %10
  store i32 %15, i32* %16, align 4
  call void @dx.op.rayQuery_TraceRayInline(i32 179, i32 %15, %dx.types.Handle %1, i32 1, i32 2, float %7, float %8, float %9, float %6, float %3, float %4, float %5, float %2)  ; RayQuery_TraceRayInline(rayQueryHandle,accelerationStructure,rayFlags,instanceInclusionMask,origin_X,origin_Y,origin_Z,tMin,direction_X,direction_Y,direction_Z,tMax)
  %17 = call i32 @dx.op.allocateRayQuery(i32 178, i32 1)  ; AllocateRayQuery(constRayFlags)
  call void @dx.op.rayQuery_TraceRayInline(i32 179, i32 %17, %dx.types.Handle %1, i32 3, i32 4, float %7, float %8, float %9, float %6, float %3, float %4, float %5, float %2)  ; RayQuery_TraceRayInline(rayQueryHandle,accelerationStructure,rayFlags,instanceInclusionMask,origin_X,origin_Y,origin_Z,tMin,direction_X,direction_Y,direction_Z,tMax)
  ret void
}

; Function Attrs: nounwind readnone
declare i32 @dx.op.loadInput.i32(i32, i32, i32, i8, i32) #0

; Function Attrs: nounwind readnone
declare float @dx.op.loadInput.f32(i32, i32, i32, i8, i32) #0

; Function Attrs: nounwind
declare i32 @dx.op.allocateRayQuery(i32, i32) #1

; Function Attrs: nounwind
declare void @dx.op.rayQuery_TraceRayInline(i32, i32, %dx.types.Handle, i32, i32, float, float, float, float, float, float, float, float) #1

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
!dx.viewIdState = !{!8}
!dx.entryPoints = !{!9}

!0 = !{!"dxcoob 1.9.2609.5 (01b62ad47)"}
!1 = !{i32 1, i32 5}
!2 = !{i32 1, i32 9}
!3 = !{!"vs", i32 6, i32 5}
!4 = !{!5, null, null, null}
!5 = !{!6}
!6 = !{i32 0, %struct.RaytracingAccelerationStructure* undef, !"", i32 0, i32 0, i32 1, i32 16, i32 0, !7}
!7 = !{i32 0, i32 4}
!8 = !{[2 x i32] [i32 17, i32 0]}
!9 = !{void ()* @main, !"main", !10, !4, !23}
!10 = !{!11, null, null}
!11 = !{!12, !15, !17, !19, !21}
!12 = !{i32 0, !"IDX", i8 5, i8 0, !13, i8 0, i32 1, i8 1, i32 0, i8 0, !14}
!13 = !{i32 0}
!14 = !{i32 3, i32 1}
!15 = !{i32 1, !"RAYDESC", i8 9, i8 0, !13, i8 0, i32 1, i8 3, i32 1, i8 0, !16}
!16 = !{i32 3, i32 7}
!17 = !{i32 2, !"RAYDESC", i8 9, i8 0, !18, i8 0, i32 1, i8 1, i32 2, i8 0, !14}
!18 = !{i32 1}
!19 = !{i32 3, !"RAYDESC", i8 9, i8 0, !20, i8 0, i32 1, i8 3, i32 3, i8 0, !16}
!20 = !{i32 2}
!21 = !{i32 4, !"RAYDESC", i8 9, i8 0, !22, i8 0, i32 1, i8 1, i32 4, i8 0, !14}
!22 = !{i32 3}
!23 = !{i32 0, i64 33554432}

