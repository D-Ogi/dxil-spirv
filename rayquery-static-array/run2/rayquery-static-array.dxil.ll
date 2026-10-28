;
; Note: shader requires additional functionality:
;       Raytracing tier 1.1 features
;
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
; shader hash: 9d843141eba3b01900727e0fd6425117
;
; Pipeline Runtime Information: 
;
;PSVRuntimeInfo:
; Compute Shader
; NumThreads=(64,1,1)
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
; Resource bind info for O
; {
;
;   uint $Element;                                    ; Offset:    0 Size:     4
;
; }
;
;
; Resource Bindings:
;
; Name                                 Type  Format         Dim      ID      HLSL Bind  Count
; ------------------------------ ---------- ------- ----------- ------- -------------- ------
; RTAS                              texture     i32         ras      T0             t0     1
; O                                     UAV  struct         r/w      U0             u0     1
;
target datalayout = "e-m:e-p:32:32-i1:32-i8:32-i16:32-i32:32-i64:64-f16:32-f32:32-f64:64-n8:16:32:64"
target triple = "dxil-ms-dx"

%dx.types.Handle = type { i8* }
%struct.RaytracingAccelerationStructure = type { i32 }
%"class.RWStructuredBuffer<unsigned int>" = type { i32 }

@g_queries.0 = internal unnamed_addr global [2 x i32] undef, align 4

define void @main() {
  %1 = call %dx.types.Handle @dx.op.createHandle(i32 57, i8 1, i32 0, i32 0, i1 false)  ; CreateHandle(resourceClass,rangeId,index,nonUniformIndex)
  %2 = call %dx.types.Handle @dx.op.createHandle(i32 57, i8 0, i32 0, i32 0, i1 false)  ; CreateHandle(resourceClass,rangeId,index,nonUniformIndex)
  %3 = call i32 @dx.op.threadId.i32(i32 93, i32 0)  ; ThreadId(component)
  %4 = call i32 @dx.op.allocateRayQuery(i32 178, i32 0)  ; AllocateRayQuery(constRayFlags)
  store i32 %4, i32* getelementptr inbounds ([2 x i32], [2 x i32]* @g_queries.0, i32 0, i32 0), align 4
  %5 = call i32 @dx.op.allocateRayQuery(i32 178, i32 0)  ; AllocateRayQuery(constRayFlags)
  store i32 %5, i32* getelementptr inbounds ([2 x i32], [2 x i32]* @g_queries.0, i32 0, i32 1), align 4
  %6 = call i32 @dx.op.allocateRayQuery(i32 178, i32 0)  ; AllocateRayQuery(constRayFlags)
  %7 = and i32 %3, 1
  %8 = getelementptr inbounds [2 x i32], [2 x i32]* @g_queries.0, i32 0, i32 %7
  store i32 %6, i32* %8, align 4
  call void @dx.op.rayQuery_TraceRayInline(i32 179, i32 %6, %dx.types.Handle %2, i32 0, i32 255, float 0.000000e+00, float 0.000000e+00, float 0.000000e+00, float 0.000000e+00, float 0.000000e+00, float 0.000000e+00, float 1.000000e+00, float 1.000000e+00)  ; RayQuery_TraceRayInline(rayQueryHandle,accelerationStructure,rayFlags,instanceInclusionMask,origin_X,origin_Y,origin_Z,tMin,direction_X,direction_Y,direction_Z,tMax)
  %9 = call i32 @dx.op.rayQuery_StateScalar.i32(i32 204, i32 %6)  ; RayQuery_CandidatePrimitiveIndex(rayQueryHandle)
  call void @dx.op.rawBufferStore.i32(i32 140, %dx.types.Handle %1, i32 %3, i32 0, i32 %9, i32 undef, i32 undef, i32 undef, i8 1, i32 4)  ; RawBufferStore(uav,index,elementOffset,value0,value1,value2,value3,mask,alignment)
  ret void
}

; Function Attrs: nounwind readnone
declare i32 @dx.op.threadId.i32(i32, i32) #0

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
!dx.entryPoints = !{!11}

!0 = !{!"dxcoob 1.9.2609.5 (01b62ad47)"}
!1 = !{i32 1, i32 5}
!2 = !{i32 1, i32 9}
!3 = !{!"cs", i32 6, i32 5}
!4 = !{!5, !8, null, null}
!5 = !{!6}
!6 = !{i32 0, %struct.RaytracingAccelerationStructure* undef, !"", i32 0, i32 0, i32 1, i32 16, i32 0, !7}
!7 = !{i32 0, i32 4}
!8 = !{!9}
!9 = !{i32 0, %"class.RWStructuredBuffer<unsigned int>"* undef, !"", i32 0, i32 0, i32 1, i32 12, i1 false, i1 false, i1 false, !10}
!10 = !{i32 1, i32 4}
!11 = !{void ()* @main, !"main", null, !4, !12}
!12 = !{i32 0, i64 33554448, i32 4, !13}
!13 = !{i32 64, i32 1, i32 1}

