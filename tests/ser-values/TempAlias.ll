; shader hash: 98aaaa6bf38b43e78ef030598fcc54a9
;
; Buffer Definitions:
;
; cbuffer Params
; {
;
;   struct Params
;   {
;
;       uint Choice;                                  ; Offset:    0
;       uint Index;                                   ; Offset:    4
;       uint Seed;                                    ; Offset:    8
;       uint Padding;                                 ; Offset:   12
;   
;   } Params;                                         ; Offset:    0 Size:    16
;
; }
;
; Resource bind info for Out
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
; Params                            cbuffer      NA          NA     CB0            cb0     1
; Scene                             texture     i32         ras      T0             t0     1
; Out                                   UAV  struct         r/w      U0             u0     1
;
target datalayout = "e-m:e-p:32:32-i1:32-i8:32-i16:32-i32:32-i64:64-f16:32-f32:32-f64:64-n8:16:32:64"
target triple = "dxil-ms-dx"

%dx.types.Handle = type { i8* }
%struct.Payload = type { i32 }
%dx.types.ResourceProperties = type { i32, i32 }
%dx.types.CBufRet.i32 = type { i32, i32, i32, i32 }
%dx.types.HitObject = type { i8* }
%struct.RaytracingAccelerationStructure = type { i32 }
%"class.RWStructuredBuffer<unsigned int>" = type { i32 }
%Params = type { i32, i32, i32, i32 }

@"\01?Out@@3V?$RWStructuredBuffer@I@@A" = external constant %dx.types.Handle, align 4
@"\01?Scene@@3URaytracingAccelerationStructure@@A" = external constant %dx.types.Handle, align 4
@Params = external constant %dx.types.Handle

; Function Attrs: nounwind
define void @"\01?TempAlias@@YAXXZ"() #0 {
  %1 = load %dx.types.Handle, %dx.types.Handle* @"\01?Scene@@3URaytracingAccelerationStructure@@A", align 4
  %2 = load %dx.types.Handle, %dx.types.Handle* @"\01?Out@@3V?$RWStructuredBuffer@I@@A", align 4
  %3 = load %dx.types.Handle, %dx.types.Handle* @Params, align 4
  %4 = alloca %struct.Payload, align 8
  %5 = alloca %struct.Payload, align 8
  %6 = alloca %struct.Payload, align 8
  %7 = call %dx.types.Handle @dx.op.createHandleForLib.dx.types.Handle(i32 160, %dx.types.Handle %3)  ; CreateHandleForLib(Resource)
  %8 = call %dx.types.Handle @dx.op.annotateHandle(i32 216, %dx.types.Handle %7, %dx.types.ResourceProperties { i32 13, i32 16 })  ; AnnotateHandle(res,props)  resource: CBuffer
  %9 = call %dx.types.CBufRet.i32 @dx.op.cbufferLoadLegacy.i32(i32 59, %dx.types.Handle %8, i32 0)  ; CBufferLoadLegacy(handle,regIndex)
  %10 = extractvalue %dx.types.CBufRet.i32 %9, 2
  %11 = call %dx.types.Handle @dx.op.createHandleForLib.dx.types.Handle(i32 160, %dx.types.Handle %1)  ; CreateHandleForLib(Resource)
  %12 = call %dx.types.Handle @dx.op.annotateHandle(i32 216, %dx.types.Handle %11, %dx.types.ResourceProperties { i32 16, i32 0 })  ; AnnotateHandle(res,props)  resource: RTAccelerationStructure
  %13 = getelementptr inbounds %struct.Payload, %struct.Payload* %6, i32 0, i32 0
  store i32 %10, i32* %13, align 8
  call void @dx.op.traceRay.struct.Payload(i32 157, %dx.types.Handle %12, i32 0, i32 255, i32 0, i32 0, i32 0, float 0.000000e+00, float 0.000000e+00, float -1.000000e+00, float 0.000000e+00, float 0.000000e+00, float 0.000000e+00, float 1.000000e+00, float 1.000000e+02, %struct.Payload* nonnull %6)  ; TraceRay(AccelerationStructure,RayFlags,InstanceInclusionMask,RayContributionToHitGroupIndex,MultiplierForGeometryContributionToShaderIndex,MissShaderIndex,Origin_X,Origin_Y,Origin_Z,TMin,Direction_X,Direction_Y,Direction_Z,TMax,payload)
  %14 = load i32, i32* %13, align 8
  %15 = getelementptr inbounds %struct.Payload, %struct.Payload* %5, i32 0, i32 0
  store i32 %14, i32* %15, align 8
  call void @dx.op.callShader.struct.Payload(i32 159, i32 0, %struct.Payload* nonnull %5)  ; CallShader(ShaderIndex,Parameter)
  %16 = load i32, i32* %15, align 8
  %17 = call %dx.types.HitObject @dx.op.hitObject_MakeMiss(i32 265, i32 0, i32 0, float 0.000000e+00, float 0.000000e+00, float -1.000000e+00, float 0.000000e+00, float 0.000000e+00, float 0.000000e+00, float 1.000000e+00, float 1.000000e+02)  ; HitObject_MakeMiss(RayFlags,MissShaderIndex,Origin_X,Origin_Y,Origin_Z,TMin,Direction_X,Direction_Y,Direction_Z,TMax)
  %18 = getelementptr inbounds %struct.Payload, %struct.Payload* %5, i32 0, i32 0
  store i32 %16, i32* %18, align 8
  call void @dx.op.hitObject_Invoke.struct.Payload(i32 267, %dx.types.HitObject %17, %struct.Payload* nonnull %5)  ; HitObject_Invoke(hitObject,payload)
  %19 = load i32, i32* %18, align 8
  %20 = call %dx.types.Handle @dx.op.createHandleForLib.dx.types.Handle(i32 160, %dx.types.Handle %2)  ; CreateHandleForLib(Resource)
  %21 = call %dx.types.Handle @dx.op.annotateHandle(i32 216, %dx.types.Handle %20, %dx.types.ResourceProperties { i32 4108, i32 4 })  ; AnnotateHandle(res,props)  resource: RWStructuredBuffer<stride=4>
  call void @dx.op.rawBufferStore.i32(i32 140, %dx.types.Handle %21, i32 0, i32 0, i32 %19, i32 undef, i32 undef, i32 undef, i8 1, i32 4)  ; RawBufferStore(uav,index,elementOffset,value0,value1,value2,value3,mask,alignment)
  ret void
}

; Function Attrs: nounwind
declare void @dx.op.callShader.struct.Payload(i32, i32, %struct.Payload*) #0

; Function Attrs: nounwind
declare void @dx.op.hitObject_Invoke.struct.Payload(i32, %dx.types.HitObject, %struct.Payload*) #0

; Function Attrs: nounwind
declare void @dx.op.rawBufferStore.i32(i32, %dx.types.Handle, i32, i32, i32, i32, i32, i32, i8, i32) #0

; Function Attrs: nounwind readonly
declare %dx.types.CBufRet.i32 @dx.op.cbufferLoadLegacy.i32(i32, %dx.types.Handle, i32) #1

; Function Attrs: nounwind readnone
declare %dx.types.HitObject @dx.op.hitObject_MakeMiss(i32, i32, i32, float, float, float, float, float, float, float, float) #2

; Function Attrs: nounwind
declare void @dx.op.traceRay.struct.Payload(i32, %dx.types.Handle, i32, i32, i32, i32, i32, float, float, float, float, float, float, float, float, %struct.Payload*) #0

; Function Attrs: nounwind readnone
declare %dx.types.Handle @dx.op.annotateHandle(i32, %dx.types.Handle, %dx.types.ResourceProperties) #2

; Function Attrs: nounwind readonly
declare %dx.types.Handle @dx.op.createHandleForLib.dx.types.Handle(i32, %dx.types.Handle) #1

attributes #0 = { nounwind }
attributes #1 = { nounwind readonly }
attributes #2 = { nounwind readnone }

!llvm.ident = !{!0}
!dx.version = !{!1}
!dx.valver = !{!1}
!dx.shaderModel = !{!2}
!dx.resources = !{!3}
!dx.typeAnnotations = !{!12}
!dx.dxrPayloadAnnotations = !{!16}
!dx.entryPoints = !{!19, !21}

!0 = !{!"dxcoob 1.9.2609.5 (01b62ad47)"}
!1 = !{i32 1, i32 9}
!2 = !{!"lib", i32 6, i32 9}
!3 = !{!4, !7, !10, null}
!4 = !{!5}
!5 = !{i32 0, %struct.RaytracingAccelerationStructure* bitcast (%dx.types.Handle* @"\01?Scene@@3URaytracingAccelerationStructure@@A" to %struct.RaytracingAccelerationStructure*), !"Scene", i32 0, i32 0, i32 1, i32 16, i32 0, !6}
!6 = !{i32 0, i32 4}
!7 = !{!8}
!8 = !{i32 0, %"class.RWStructuredBuffer<unsigned int>"* bitcast (%dx.types.Handle* @"\01?Out@@3V?$RWStructuredBuffer@I@@A" to %"class.RWStructuredBuffer<unsigned int>"*), !"Out", i32 0, i32 0, i32 1, i32 12, i1 false, i1 false, i1 false, !9}
!9 = !{i32 1, i32 4}
!10 = !{!11}
!11 = !{i32 0, %Params* bitcast (%dx.types.Handle* @Params to %Params*), !"Params", i32 0, i32 0, i32 1, i32 16, null}
!12 = !{i32 1, void ()* @"\01?TempAlias@@YAXXZ", !13}
!13 = !{!14}
!14 = !{i32 1, !15, !15}
!15 = !{}
!16 = !{i32 0, %struct.Payload undef, !17}
!17 = !{!18}
!18 = !{i32 0, i32 819}
!19 = !{null, !"", null, !3, !20}
!20 = !{i32 0, i64 8589934608}
!21 = !{void ()* @"\01?TempAlias@@YAXXZ", !"\01?TempAlias@@YAXXZ", null, null, !22}
!22 = !{i32 8, i32 7, i32 5, !23}
!23 = !{i32 0}
