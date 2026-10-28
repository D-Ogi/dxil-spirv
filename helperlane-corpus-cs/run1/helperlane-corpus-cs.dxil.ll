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
; shader hash: d690fa13804740a7c03e5fc6e3b3291c
;
; Pipeline Runtime Information: 
;
;PSVRuntimeInfo:
; Compute Shader
; NumThreads=(14,12,3)
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
; EntryFunctionName: cs
;
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
; Resource bind info for SB
; {
;
;   float4 $Element;                                  ; Offset:    0 Size:    16
;
; }
;
;
; Resource Bindings:
;
; Name                                 Type  Format         Dim      ID      HLSL Bind  Count
; ------------------------------ ---------- ------- ----------- ------- -------------- ------
; $Globals                          cbuffer      NA          NA     CB0            cb0     1
; SB                                    UAV  struct         r/w      U0             u0     1
;
target datalayout = "e-m:e-p:32:32-i1:32-i8:32-i16:32-i32:32-i64:64-f16:32-f32:32-f64:64-n8:16:32:64"
target triple = "dxil-ms-dx"

%dx.types.Handle = type { i8* }
%dx.types.ResBind = type { i32, i32, i32, i8 }
%dx.types.ResourceProperties = type { i32, i32 }
%dx.types.CBufRet.f32 = type { float, float, float, float }
%"class.RWStructuredBuffer<vector<float, 4> >" = type { <4 x float> }
%"$Globals" = type { <4 x float> }

@dx.nothing.a = internal constant [1 x i32] zeroinitializer

define void @cs() {
  %1 = call %dx.types.Handle @dx.op.createHandleFromBinding(i32 217, %dx.types.ResBind { i32 0, i32 0, i32 0, i8 1 }, i32 0, i1 false)  ; CreateHandleFromBinding(bind,index,nonUniformIndex)
  %2 = call %dx.types.Handle @dx.op.createHandleFromBinding(i32 217, %dx.types.ResBind { i32 0, i32 0, i32 0, i8 2 }, i32 0, i1 false)  ; CreateHandleFromBinding(bind,index,nonUniformIndex)
  %3 = call %dx.types.Handle @dx.op.annotateHandle(i32 216, %dx.types.Handle %2, %dx.types.ResourceProperties { i32 13, i32 16 })  ; AnnotateHandle(res,props)  resource: CBuffer
  %4 = call i32 @dx.op.flattenedThreadIdInGroup.i32(i32 96)  ; FlattenedThreadIdInGroup()
  %5 = call %dx.types.CBufRet.f32 @dx.op.cbufferLoadLegacy.f32(i32 59, %dx.types.Handle %3, i32 0)  ; CBufferLoadLegacy(handle,regIndex)
  %6 = extractvalue %dx.types.CBufRet.f32 %5, 0
  %7 = extractvalue %dx.types.CBufRet.f32 %5, 1
  %8 = extractvalue %dx.types.CBufRet.f32 %5, 2
  %9 = extractvalue %dx.types.CBufRet.f32 %5, 3
  %10 = call i1 @dx.op.isHelperLane.i1(i32 221)  ; IsHelperLane()
  %11 = uitofp i1 %10 to float
  %12 = fadd fast float %6, %11
  %13 = fadd fast float %7, %11
  %14 = fadd fast float %8, %11
  %15 = fadd fast float %9, %11
  %16 = load i32, i32* getelementptr inbounds ([1 x i32], [1 x i32]* @dx.nothing.a, i32 0, i32 0)
  %17 = call %dx.types.Handle @dx.op.annotateHandle(i32 216, %dx.types.Handle %1, %dx.types.ResourceProperties { i32 4108, i32 16 })  ; AnnotateHandle(res,props)  resource: RWStructuredBuffer<stride=16>
  call void @dx.op.rawBufferStore.f32(i32 140, %dx.types.Handle %17, i32 %4, i32 0, float %12, float %13, float %14, float %15, i8 15, i32 4)  ; RawBufferStore(uav,index,elementOffset,value0,value1,value2,value3,mask,alignment)
  %18 = load i32, i32* getelementptr inbounds ([1 x i32], [1 x i32]* @dx.nothing.a, i32 0, i32 0)
  ret void
}

; Function Attrs: nounwind readnone
declare i32 @dx.op.flattenedThreadIdInGroup.i32(i32) #0

; Function Attrs: nounwind readonly
declare i1 @dx.op.isHelperLane.i1(i32) #1

; Function Attrs: nounwind
declare void @dx.op.rawBufferStore.f32(i32, %dx.types.Handle, i32, i32, float, float, float, float, i8, i32) #2

; Function Attrs: nounwind readonly
declare %dx.types.CBufRet.f32 @dx.op.cbufferLoadLegacy.f32(i32, %dx.types.Handle, i32) #1

; Function Attrs: nounwind readnone
declare %dx.types.Handle @dx.op.annotateHandle(i32, %dx.types.Handle, %dx.types.ResourceProperties) #0

; Function Attrs: nounwind readnone
declare %dx.types.Handle @dx.op.createHandleFromBinding(i32, %dx.types.ResBind, i32, i1) #0

attributes #0 = { nounwind readnone }
attributes #1 = { nounwind readonly }
attributes #2 = { nounwind }

!llvm.ident = !{!0}
!dx.version = !{!1}
!dx.valver = !{!2}
!dx.shaderModel = !{!3}
!dx.resources = !{!4}
!dx.entryPoints = !{!10}

!0 = !{!"dxcoob 1.9.2609.5 (01b62ad47)"}
!1 = !{i32 1, i32 6}
!2 = !{i32 1, i32 9}
!3 = !{!"cs", i32 6, i32 6}
!4 = !{null, !5, !8, null}
!5 = !{!6}
!6 = !{i32 0, %"class.RWStructuredBuffer<vector<float, 4> >"* undef, !"", i32 0, i32 0, i32 1, i32 12, i1 false, i1 false, i1 false, !7}
!7 = !{i32 1, i32 16}
!8 = !{!9}
!9 = !{i32 0, %"$Globals"* undef, !"", i32 0, i32 0, i32 1, i32 16, null}
!10 = !{void ()* @cs, !"cs", null, !4, !11}
!11 = !{i32 0, i64 17, i32 4, !12}
!12 = !{i32 14, i32 12, i32 3}

