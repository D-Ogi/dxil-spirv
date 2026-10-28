; shader hash: c561d0397685e91b2c7b7cd9a1657698
;
; Buffer Definitions:
;
; cbuffer CB
; {
;
;   struct CB
;   {
;
;       struct struct.MyPayload
;       {
;
;           struct struct.BasePayload
;           {
;
;               struct struct.SuperBasePayload
;               {
;
;                   float g;                          ; Offset:   32
;               
;               } SuperBasePayload;                   ; Offset:   32
;
;               float f;                              ; Offset:   36
;           
;           } BasePayload;                            ; Offset:   32
;
;           int i;                                    ; Offset:   40
;           float4 color;                             ; Offset:   48
;           uint2 pos;                                ; Offset:   64
;       
;       } cb_pld;                                     ; Offset:   32
;
;       float f;                                      ; Offset:    4
;   
;   } CB;                                             ; Offset:    0 Size:    72
;
; }
;
;
; Resource Bindings:
;
; Name                                 Type  Format         Dim      ID      HLSL Bind  Count
; ------------------------------ ---------- ------- ----------- ------- -------------- ------
; CB                                cbuffer      NA          NA     CB0            cb0     1
; RTAS                              texture     i32         ras      T0             t5     1
; BAB                                   UAV    byte         r/w      U0             u0     1
;
target datalayout = "e-m:e-p:32:32-i1:32-i8:32-i16:32-i32:32-i64:64-f16:32-f32:32-f64:64-n8:16:32:64"
target triple = "dxil-ms-dx"

%struct.RaytracingAccelerationStructure = type { i32 }
%struct.RWByteAddressBuffer = type { i32 }
%CB = type { %struct.MyPayload, float }
%struct.MyPayload = type { %struct.BasePayload, i32, <4 x float>, <2 x i32> }
%struct.BasePayload = type { %struct.SuperBasePayload, float }
%struct.SuperBasePayload = type { float }
%dx.types.Handle = type { i8* }
%dx.types.CBufRet.f32 = type { float, float, float, float }
%dx.types.CBufRet.i32 = type { i32, i32, i32, i32 }

@"\01?RTAS@@3URaytracingAccelerationStructure@@A" = external constant %struct.RaytracingAccelerationStructure, align 4
@"\01?BAB@@3URWByteAddressBuffer@@A" = external constant %struct.RWByteAddressBuffer, align 4
@CB = external constant %CB
@dx.nothing.a = internal constant [1 x i32] zeroinitializer

; Function Attrs: nounwind
define void @"\01?raygen1@@YAXXZ"() #0 {
  %1 = load %struct.RaytracingAccelerationStructure, %struct.RaytracingAccelerationStructure* @"\01?RTAS@@3URaytracingAccelerationStructure@@A"
  %2 = load %struct.RWByteAddressBuffer, %struct.RWByteAddressBuffer* @"\01?BAB@@3URWByteAddressBuffer@@A"
  %3 = load %CB, %CB* @CB
  %4 = alloca %struct.MyPayload
  %5 = call %dx.types.Handle @dx.op.createHandleForLib.CB(i32 160, %CB %3)  ; CreateHandleForLib(Resource)
  %6 = load i32, i32* getelementptr inbounds ([1 x i32], [1 x i32]* @dx.nothing.a, i32 0, i32 0)
  %7 = call %dx.types.CBufRet.f32 @dx.op.cbufferLoadLegacy.f32(i32 59, %dx.types.Handle %5, i32 2)  ; CBufferLoadLegacy(handle,regIndex)
  %8 = extractvalue %dx.types.CBufRet.f32 %7, 0
  %9 = call %dx.types.CBufRet.f32 @dx.op.cbufferLoadLegacy.f32(i32 59, %dx.types.Handle %5, i32 2)  ; CBufferLoadLegacy(handle,regIndex)
  %10 = extractvalue %dx.types.CBufRet.f32 %9, 1
  %11 = call %dx.types.CBufRet.i32 @dx.op.cbufferLoadLegacy.i32(i32 59, %dx.types.Handle %5, i32 2)  ; CBufferLoadLegacy(handle,regIndex)
  %12 = extractvalue %dx.types.CBufRet.i32 %11, 2
  %13 = call %dx.types.CBufRet.f32 @dx.op.cbufferLoadLegacy.f32(i32 59, %dx.types.Handle %5, i32 3)  ; CBufferLoadLegacy(handle,regIndex)
  %14 = extractvalue %dx.types.CBufRet.f32 %13, 0
  %15 = insertelement <4 x float> undef, float %14, i64 0
  %16 = extractvalue %dx.types.CBufRet.f32 %13, 1
  %17 = insertelement <4 x float> %15, float %16, i64 1
  %18 = extractvalue %dx.types.CBufRet.f32 %13, 2
  %19 = insertelement <4 x float> %17, float %18, i64 2
  %20 = extractvalue %dx.types.CBufRet.f32 %13, 3
  %21 = insertelement <4 x float> %19, float %20, i64 3
  %22 = call i32 @dx.op.dispatchRaysIndex.i32(i32 145, i8 0)  ; DispatchRaysIndex(col)
  %23 = call i32 @dx.op.dispatchRaysIndex.i32(i32 145, i8 1)  ; DispatchRaysIndex(col)
  %24 = insertelement <2 x i32> undef, i32 %22, i32 0
  %25 = insertelement <2 x i32> %24, i32 %23, i32 1
  %26 = load i32, i32* getelementptr inbounds ([1 x i32], [1 x i32]* @dx.nothing.a, i32 0, i32 0)
  %27 = load i32, i32* getelementptr inbounds ([1 x i32], [1 x i32]* @dx.nothing.a, i32 0, i32 0)
  %28 = uitofp i32 %22 to float
  %29 = uitofp i32 %23 to float
  %30 = call i32 @dx.op.dispatchRaysDimensions.i32(i32 146, i8 0)  ; DispatchRaysDimensions(col)
  %31 = uitofp i32 %30 to float
  %32 = fdiv fast float %28, %31
  %33 = fdiv fast float %29, %31
  %34 = call float @dx.op.dot3.f32(i32 55, float %32, float %33, float 1.000000e+00, float %32, float %33, float 1.000000e+00)  ; Dot3(ax,ay,az,bx,by,bz)
  %35 = call float @dx.op.unary.f32(i32 25, float %34)  ; Rsqrt(value)
  %36 = fmul fast float %32, %35
  %37 = fmul fast float %33, %35
  %38 = fmul fast float 1.000000e+00, %35
  %39 = load i32, i32* getelementptr inbounds ([1 x i32], [1 x i32]* @dx.nothing.a, i32 0, i32 0)
  %40 = load i32, i32* getelementptr inbounds ([1 x i32], [1 x i32]* @dx.nothing.a, i32 0, i32 0)
  %41 = load i32, i32* getelementptr inbounds ([1 x i32], [1 x i32]* @dx.nothing.a, i32 0, i32 0)
  %42 = load i32, i32* getelementptr inbounds ([1 x i32], [1 x i32]* @dx.nothing.a, i32 0, i32 0)
  %43 = load i32, i32* getelementptr inbounds ([1 x i32], [1 x i32]* @dx.nothing.a, i32 0, i32 0)
  %44 = call %dx.types.Handle @dx.op.createHandleForLib.struct.RaytracingAccelerationStructure(i32 160, %struct.RaytracingAccelerationStructure %1)  ; CreateHandleForLib(Resource)
  %45 = getelementptr inbounds %struct.MyPayload, %struct.MyPayload* %4, i32 0, i32 0
  %46 = getelementptr inbounds %struct.BasePayload, %struct.BasePayload* %45, i32 0, i32 0, i32 0
  store float %8, float* %46
  %47 = getelementptr inbounds %struct.BasePayload, %struct.BasePayload* %45, i32 0, i32 1
  store float %10, float* %47
  %48 = getelementptr inbounds %struct.MyPayload, %struct.MyPayload* %4, i32 0, i32 1
  store i32 %12, i32* %48
  %49 = getelementptr inbounds %struct.MyPayload, %struct.MyPayload* %4, i32 0, i32 2
  store <4 x float> %21, <4 x float>* %49
  %50 = getelementptr inbounds %struct.MyPayload, %struct.MyPayload* %4, i32 0, i32 3
  store <2 x i32> %25, <2 x i32>* %50
  call void @dx.op.traceRay.struct.MyPayload(i32 157, %dx.types.Handle %44, i32 0, i32 0, i32 0, i32 1, i32 0, float 0.000000e+00, float 0.000000e+00, float 0.000000e+00, float 1.250000e-01, float %36, float %37, float %38, float 1.280000e+02, %struct.MyPayload* %4)  ; TraceRay(AccelerationStructure,RayFlags,InstanceInclusionMask,RayContributionToHitGroupIndex,MultiplierForGeometryContributionToShaderIndex,MissShaderIndex,Origin_X,Origin_Y,Origin_Z,TMin,Direction_X,Direction_Y,Direction_Z,TMax,payload)
  %51 = getelementptr inbounds %struct.MyPayload, %struct.MyPayload* %4, i32 0, i32 0
  %52 = getelementptr inbounds %struct.BasePayload, %struct.BasePayload* %51, i32 0, i32 0, i32 0
  %53 = load float, float* %52
  %54 = getelementptr inbounds %struct.BasePayload, %struct.BasePayload* %51, i32 0, i32 1
  %55 = load float, float* %54
  %56 = getelementptr inbounds %struct.MyPayload, %struct.MyPayload* %4, i32 0, i32 3
  %57 = load <2 x i32>, <2 x i32>* %56
  %58 = load i32, i32* getelementptr inbounds ([1 x i32], [1 x i32]* @dx.nothing.a, i32 0, i32 0)
  %59 = fcmp fast olt float %55, 0.000000e+00
  br i1 %59, label %60, label %64

; <label>:60                                      ; preds = %0
  %61 = load i32, i32* getelementptr inbounds ([1 x i32], [1 x i32]* @dx.nothing.a, i32 0, i32 0)
  %62 = fcmp fast olt float %53, 0.000000e+00
  %63 = load i32, i32* getelementptr inbounds ([1 x i32], [1 x i32]* @dx.nothing.a, i32 0, i32 0)
  br label %64

; <label>:64                                      ; preds = %60, %0
  %65 = phi i1 [ false, %0 ], [ %62, %60 ]
  %66 = load i32, i32* getelementptr inbounds ([1 x i32], [1 x i32]* @dx.nothing.a, i32 0, i32 0)
  %67 = extractelement <2 x i32> %57, i32 0
  %68 = extractelement <2 x i32> %57, i32 1
  %69 = call i32 @dx.op.dispatchRaysDimensions.i32(i32 146, i8 0)  ; DispatchRaysDimensions(col)
  %70 = load i32, i32* getelementptr inbounds ([1 x i32], [1 x i32]* @dx.nothing.a, i32 0, i32 0)
  %71 = mul i32 %68, %69
  %72 = add i32 %67, %71
  %73 = call %dx.types.Handle @dx.op.createHandleForLib.struct.RWByteAddressBuffer(i32 160, %struct.RWByteAddressBuffer %2)  ; CreateHandleForLib(Resource)
  %74 = zext i1 %65 to i32
  call void @dx.op.rawBufferStore.i32(i32 140, %dx.types.Handle %73, i32 %72, i32 undef, i32 %74, i32 undef, i32 undef, i32 undef, i8 1, i32 4)  ; RawBufferStore(uav,index,elementOffset,value0,value1,value2,value3,mask,alignment)
  %75 = load i32, i32* getelementptr inbounds ([1 x i32], [1 x i32]* @dx.nothing.a, i32 0, i32 0)
  ret void
}

; Function Attrs: nounwind readnone
declare i32 @dx.op.dispatchRaysDimensions.i32(i32, i8) #1

; Function Attrs: nounwind readnone
declare i32 @dx.op.dispatchRaysIndex.i32(i32, i8) #1

; Function Attrs: nounwind readnone
declare float @dx.op.dot3.f32(i32, float, float, float, float, float, float) #1

; Function Attrs: nounwind readnone
declare float @dx.op.unary.f32(i32, float) #1

; Function Attrs: nounwind
declare void @dx.op.rawBufferStore.i32(i32, %dx.types.Handle, i32, i32, i32, i32, i32, i32, i8, i32) #0

; Function Attrs: nounwind readonly
declare %dx.types.CBufRet.i32 @dx.op.cbufferLoadLegacy.i32(i32, %dx.types.Handle, i32) #2

; Function Attrs: nounwind readonly
declare %dx.types.CBufRet.f32 @dx.op.cbufferLoadLegacy.f32(i32, %dx.types.Handle, i32) #2

; Function Attrs: nounwind
declare void @dx.op.traceRay.struct.MyPayload(i32, %dx.types.Handle, i32, i32, i32, i32, i32, float, float, float, float, float, float, float, float, %struct.MyPayload*) #0

; Function Attrs: nounwind readonly
declare %dx.types.Handle @dx.op.createHandleForLib.CB(i32, %CB) #2

; Function Attrs: nounwind readonly
declare %dx.types.Handle @dx.op.createHandleForLib.struct.RaytracingAccelerationStructure(i32, %struct.RaytracingAccelerationStructure) #2

; Function Attrs: nounwind readonly
declare %dx.types.Handle @dx.op.createHandleForLib.struct.RWByteAddressBuffer(i32, %struct.RWByteAddressBuffer) #2

attributes #0 = { nounwind }
attributes #1 = { nounwind readnone }
attributes #2 = { nounwind readonly }

!llvm.ident = !{!0}
!dx.version = !{!1}
!dx.valver = !{!2}
!dx.shaderModel = !{!3}
!dx.resources = !{!4}
!dx.typeAnnotations = !{!12}
!dx.entryPoints = !{!16, !18}

!0 = !{!"dxcoob 1.9.2609.5 (01b62ad47)"}
!1 = !{i32 1, i32 3}
!2 = !{i32 1, i32 9}
!3 = !{!"lib", i32 6, i32 3}
!4 = !{!5, !8, !10, null}
!5 = !{!6}
!6 = !{i32 0, %struct.RaytracingAccelerationStructure* @"\01?RTAS@@3URaytracingAccelerationStructure@@A", !"RTAS", i32 0, i32 5, i32 1, i32 16, i32 0, !7}
!7 = !{i32 0, i32 4}
!8 = !{!9}
!9 = !{i32 0, %struct.RWByteAddressBuffer* @"\01?BAB@@3URWByteAddressBuffer@@A", !"BAB", i32 0, i32 0, i32 1, i32 11, i1 false, i1 false, i1 false, null}
!10 = !{!11}
!11 = !{i32 0, %CB* @CB, !"CB", i32 0, i32 0, i32 1, i32 72, null}
!12 = !{i32 1, void ()* @"\01?raygen1@@YAXXZ", !13}
!13 = !{!14}
!14 = !{i32 1, !15, !15}
!15 = !{}
!16 = !{null, !"", null, !4, !17}
!17 = !{i32 0, i64 17}
!18 = !{void ()* @"\01?raygen1@@YAXXZ", !"\01?raygen1@@YAXXZ", null, null, !19}
!19 = !{i32 8, i32 7, i32 5, !20}
!20 = !{i32 0}

