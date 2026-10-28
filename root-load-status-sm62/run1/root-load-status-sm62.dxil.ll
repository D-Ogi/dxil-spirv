;
; Note: shader requires additional functionality:
;       Tiled resources
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
; shader hash: 73973e335512b4b234c90439839f7ced
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
;
; Resource Bindings:
;
; Name                                 Type  Format         Dim      ID      HLSL Bind  Count
; ------------------------------ ---------- ------- ----------- ------- -------------- ------
; B                                     UAV    byte         r/w      U0             u1     1
;
target datalayout = "e-m:e-p:32:32-i1:32-i8:32-i16:32-i32:32-i64:64-f16:32-f32:32-f64:64-n8:16:32:64"
target triple = "dxil-ms-dx"

%dx.types.Handle = type { i8* }
%dx.types.ResRet.f32 = type { float, float, float, float, i32 }
%struct.RWByteAddressBuffer = type { i32 }

define void @main() {
  %1 = call %dx.types.Handle @dx.op.createHandle(i32 57, i8 1, i32 0, i32 1, i1 false)  ; CreateHandle(resourceClass,rangeId,index,nonUniformIndex)
  %2 = call i32 @dx.op.threadId.i32(i32 93, i32 0)  ; ThreadId(component)
  %3 = shl i32 %2, 4
  %4 = call %dx.types.ResRet.f32 @dx.op.rawBufferLoad.f32(i32 139, %dx.types.Handle %1, i32 %3, i32 undef, i8 15, i32 4)  ; RawBufferLoad(srv,index,elementOffset,mask,alignment)
  %5 = extractvalue %dx.types.ResRet.f32 %4, 0
  %6 = extractvalue %dx.types.ResRet.f32 %4, 1
  %7 = extractvalue %dx.types.ResRet.f32 %4, 2
  %8 = extractvalue %dx.types.ResRet.f32 %4, 3
  %9 = extractvalue %dx.types.ResRet.f32 %4, 4
  %10 = call i1 @dx.op.checkAccessFullyMapped.i32(i32 71, i32 %9)  ; CheckAccessFullyMapped(status)
  %11 = select i1 %10, float %5, float 0.000000e+00
  %12 = select i1 %10, float %6, float 0.000000e+00
  %13 = select i1 %10, float %7, float 0.000000e+00
  %14 = select i1 %10, float %8, float 0.000000e+00
  %15 = add i32 %3, 1024
  call void @dx.op.rawBufferStore.f32(i32 140, %dx.types.Handle %1, i32 %15, i32 undef, float %11, float %12, float %13, float %14, i8 15, i32 4)  ; RawBufferStore(uav,index,elementOffset,value0,value1,value2,value3,mask,alignment)
  ret void
}

; Function Attrs: nounwind readnone
declare i32 @dx.op.threadId.i32(i32, i32) #0

; Function Attrs: nounwind readonly
declare %dx.types.ResRet.f32 @dx.op.rawBufferLoad.f32(i32, %dx.types.Handle, i32, i32, i8, i32) #1

; Function Attrs: nounwind readonly
declare i1 @dx.op.checkAccessFullyMapped.i32(i32, i32) #1

; Function Attrs: nounwind
declare void @dx.op.rawBufferStore.f32(i32, %dx.types.Handle, i32, i32, float, float, float, float, i8, i32) #2

; Function Attrs: nounwind readonly
declare %dx.types.Handle @dx.op.createHandle(i32, i8, i32, i32, i1) #1

attributes #0 = { nounwind readnone }
attributes #1 = { nounwind readonly }
attributes #2 = { nounwind }

!llvm.ident = !{!0}
!dx.version = !{!1}
!dx.valver = !{!2}
!dx.shaderModel = !{!3}
!dx.resources = !{!4}
!dx.entryPoints = !{!7}

!0 = !{!"dxcoob 1.9.2609.5 (01b62ad47)"}
!1 = !{i32 1, i32 2}
!2 = !{i32 1, i32 9}
!3 = !{!"cs", i32 6, i32 2}
!4 = !{null, !5, null, null}
!5 = !{!6}
!6 = !{i32 0, %struct.RWByteAddressBuffer* undef, !"", i32 0, i32 1, i32 1, i32 11, i1 false, i1 false, i1 false, null}
!7 = !{void ()* @main, !"main", null, !4, !8}
!8 = !{i32 0, i64 4112, i32 4, !9}
!9 = !{i32 64, i32 1, i32 1}

