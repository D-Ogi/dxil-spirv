; shader hash: 03c854b3c1c416df48d20862973b6c3f
;
; Buffer Definitions:
;
; Resource bind info for O
; {
;
;   float $Element;                                   ; Offset:    0 Size:     4
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

%struct.RaytracingAccelerationStructure = type { i32 }
%"class.RWStructuredBuffer<float>" = type { float }
%struct.Payload = type { %struct.Middle, float }
%struct.Middle = type { %struct.Base, float }
%struct.Base = type { float }
%dx.types.Handle = type { i8* }

@"\01?RTAS@@3URaytracingAccelerationStructure@@A" = external constant %struct.RaytracingAccelerationStructure, align 4
@"\01?O@@3V?$RWStructuredBuffer@M@@A" = external constant %"class.RWStructuredBuffer<float>", align 4
@dx.nothing.a = internal constant [1 x i32] zeroinitializer

; Function Attrs: nounwind
define void @"\01?raygen@@YAXXZ"() #0 {
  %1 = load %struct.RaytracingAccelerationStructure, %struct.RaytracingAccelerationStructure* @"\01?RTAS@@3URaytracingAccelerationStructure@@A"
  %2 = load %"class.RWStructuredBuffer<float>", %"class.RWStructuredBuffer<float>"* @"\01?O@@3V?$RWStructuredBuffer@M@@A"
  %3 = alloca %struct.Payload
  %4 = load i32, i32* getelementptr inbounds ([1 x i32], [1 x i32]* @dx.nothing.a, i32 0, i32 0)
  %5 = load i32, i32* getelementptr inbounds ([1 x i32], [1 x i32]* @dx.nothing.a, i32 0, i32 0)
  %6 = load i32, i32* getelementptr inbounds ([1 x i32], [1 x i32]* @dx.nothing.a, i32 0, i32 0)
  %7 = load i32, i32* getelementptr inbounds ([1 x i32], [1 x i32]* @dx.nothing.a, i32 0, i32 0)
  %8 = load i32, i32* getelementptr inbounds ([1 x i32], [1 x i32]* @dx.nothing.a, i32 0, i32 0)
  %9 = load i32, i32* getelementptr inbounds ([1 x i32], [1 x i32]* @dx.nothing.a, i32 0, i32 0)
  %10 = load i32, i32* getelementptr inbounds ([1 x i32], [1 x i32]* @dx.nothing.a, i32 0, i32 0)
  %11 = call %dx.types.Handle @dx.op.createHandleForLib.struct.RaytracingAccelerationStructure(i32 160, %struct.RaytracingAccelerationStructure %1)  ; CreateHandleForLib(Resource)
  %12 = getelementptr inbounds %struct.Payload, %struct.Payload* %3, i32 0, i32 0
  %13 = getelementptr inbounds %struct.Middle, %struct.Middle* %12, i32 0, i32 0, i32 0
  store float 0.000000e+00, float* %13
  %14 = getelementptr inbounds %struct.Middle, %struct.Middle* %12, i32 0, i32 1
  store float 0.000000e+00, float* %14
  %15 = getelementptr inbounds %struct.Payload, %struct.Payload* %3, i32 0, i32 1
  store float 0.000000e+00, float* %15
  call void @dx.op.traceRay.struct.Payload(i32 157, %dx.types.Handle %11, i32 0, i32 255, i32 0, i32 1, i32 0, float 0.000000e+00, float 0.000000e+00, float 0.000000e+00, float 0.000000e+00, float 0.000000e+00, float 0.000000e+00, float 1.000000e+00, float 1.000000e+00, %struct.Payload* %3)  ; TraceRay(AccelerationStructure,RayFlags,InstanceInclusionMask,RayContributionToHitGroupIndex,MultiplierForGeometryContributionToShaderIndex,MissShaderIndex,Origin_X,Origin_Y,Origin_Z,TMin,Direction_X,Direction_Y,Direction_Z,TMax,payload)
  %16 = getelementptr inbounds %struct.Payload, %struct.Payload* %3, i32 0, i32 0
  %17 = getelementptr inbounds %struct.Middle, %struct.Middle* %16, i32 0, i32 0, i32 0
  %18 = load float, float* %17
  %19 = getelementptr inbounds %struct.Middle, %struct.Middle* %16, i32 0, i32 1
  %20 = load float, float* %19
  %21 = load i32, i32* getelementptr inbounds ([1 x i32], [1 x i32]* @dx.nothing.a, i32 0, i32 0)
  %22 = fadd fast float %18, %20
  %23 = load i32, i32* getelementptr inbounds ([1 x i32], [1 x i32]* @dx.nothing.a, i32 0, i32 0)
  %24 = call %dx.types.Handle @"dx.op.createHandleForLib.class.RWStructuredBuffer<float>"(i32 160, %"class.RWStructuredBuffer<float>" %2)  ; CreateHandleForLib(Resource)
  call void @dx.op.rawBufferStore.f32(i32 140, %dx.types.Handle %24, i32 0, i32 0, float %22, float undef, float undef, float undef, i8 1, i32 4)  ; RawBufferStore(uav,index,elementOffset,value0,value1,value2,value3,mask,alignment)
  %25 = load i32, i32* getelementptr inbounds ([1 x i32], [1 x i32]* @dx.nothing.a, i32 0, i32 0)
  ret void
}

; Function Attrs: nounwind
declare void @dx.op.rawBufferStore.f32(i32, %dx.types.Handle, i32, i32, float, float, float, float, i8, i32) #0

; Function Attrs: nounwind
declare void @dx.op.traceRay.struct.Payload(i32, %dx.types.Handle, i32, i32, i32, i32, i32, float, float, float, float, float, float, float, float, %struct.Payload*) #0

; Function Attrs: nounwind readonly
declare %dx.types.Handle @dx.op.createHandleForLib.struct.RaytracingAccelerationStructure(i32, %struct.RaytracingAccelerationStructure) #1

; Function Attrs: nounwind readonly
declare %dx.types.Handle @"dx.op.createHandleForLib.class.RWStructuredBuffer<float>"(i32, %"class.RWStructuredBuffer<float>") #1

attributes #0 = { nounwind }
attributes #1 = { nounwind readonly }

!llvm.ident = !{!0}
!dx.version = !{!1}
!dx.valver = !{!2}
!dx.shaderModel = !{!3}
!dx.resources = !{!4}
!dx.typeAnnotations = !{!11, !22}
!dx.entryPoints = !{!26, !28}

!0 = !{!"dxcoob 1.9.2609.5 (01b62ad47)"}
!1 = !{i32 1, i32 3}
!2 = !{i32 1, i32 9}
!3 = !{!"lib", i32 6, i32 3}
!4 = !{!5, !8, null, null}
!5 = !{!6}
!6 = !{i32 0, %struct.RaytracingAccelerationStructure* @"\01?RTAS@@3URaytracingAccelerationStructure@@A", !"RTAS", i32 0, i32 0, i32 1, i32 16, i32 0, !7}
!7 = !{i32 0, i32 4}
!8 = !{!9}
!9 = !{i32 0, %"class.RWStructuredBuffer<float>"* @"\01?O@@3V?$RWStructuredBuffer@M@@A", !"O", i32 0, i32 0, i32 1, i32 12, i1 false, i1 false, i1 false, !10}
!10 = !{i32 1, i32 4}
!11 = !{i32 0, %"class.RWStructuredBuffer<float>" undef, !12, %struct.Payload undef, !14, %struct.Middle undef, !17, %struct.Base undef, !20}
!12 = !{i32 4, !13}
!13 = !{i32 6, !"h", i32 3, i32 0, i32 7, i32 9}
!14 = !{i32 12, !15, !16}
!15 = !{i32 6, !"Middle", i32 3, i32 0}
!16 = !{i32 6, !"c", i32 3, i32 8, i32 7, i32 9}
!17 = !{i32 8, !18, !19}
!18 = !{i32 6, !"Base", i32 3, i32 0}
!19 = !{i32 6, !"b", i32 3, i32 4, i32 7, i32 9}
!20 = !{i32 4, !21}
!21 = !{i32 6, !"a", i32 3, i32 0, i32 7, i32 9}
!22 = !{i32 1, void ()* @"\01?raygen@@YAXXZ", !23}
!23 = !{!24}
!24 = !{i32 1, !25, !25}
!25 = !{}
!26 = !{null, !"", null, !4, !27}
!27 = !{i32 0, i64 17}
!28 = !{void ()* @"\01?raygen@@YAXXZ", !"\01?raygen@@YAXXZ", null, null, !29}
!29 = !{i32 8, i32 7, i32 5, !30}
!30 = !{i32 0}

