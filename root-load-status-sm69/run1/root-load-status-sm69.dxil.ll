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
; shader hash: 417f282f7951dd8b89c2bd06a0a7d6a9
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
%dx.types.ResBind = type { i32, i32, i32, i8 }
%dx.types.ResourceProperties = type { i32, i32 }
%dx.types.ResRet.v4f32 = type { <4 x float>, i32 }
%struct.RWByteAddressBuffer = type { i32 }

define void @main() {
  %1 = call %dx.types.Handle @dx.op.createHandleFromBinding(i32 217, %dx.types.ResBind { i32 1, i32 1, i32 0, i8 1 }, i32 1, i1 false)  ; CreateHandleFromBinding(bind,index,nonUniformIndex)
  %2 = call i32 @dx.op.threadId.i32(i32 93, i32 0)  ; ThreadId(component)
  %3 = shl i32 %2, 4
  %4 = call %dx.types.Handle @dx.op.annotateHandle(i32 216, %dx.types.Handle %1, %dx.types.ResourceProperties { i32 4107, i32 0 })  ; AnnotateHandle(res,props)  resource: RWByteAddressBuffer
  %5 = call %dx.types.ResRet.v4f32 @dx.op.rawBufferVectorLoad.v4f32(i32 303, %dx.types.Handle %4, i32 %3, i32 undef, i32 4)  ; RawBufferVectorLoad(buf,index,elementOffset,alignment)
  %6 = extractvalue %dx.types.ResRet.v4f32 %5, 0
  %7 = extractvalue %dx.types.ResRet.v4f32 %5, 1
  %8 = call i1 @dx.op.checkAccessFullyMapped.i32(i32 71, i32 %7)  ; CheckAccessFullyMapped(status)
  %9 = select i1 %8, <4 x float> %6, <4 x float> zeroinitializer
  %10 = add i32 %3, 1024
  call void @dx.op.rawBufferVectorStore.v4f32(i32 304, %dx.types.Handle %4, i32 %10, i32 undef, <4 x float> %9, i32 4)  ; RawBufferVectorStore(uav,index,elementOffset,value0,alignment)
  ret void
}

; Function Attrs: nounwind readnone
declare i32 @dx.op.threadId.i32(i32, i32) #0

; Function Attrs: nounwind readonly
declare %dx.types.ResRet.v4f32 @dx.op.rawBufferVectorLoad.v4f32(i32, %dx.types.Handle, i32, i32, i32) #1

; Function Attrs: nounwind readonly
declare i1 @dx.op.checkAccessFullyMapped.i32(i32, i32) #1

; Function Attrs: nounwind
declare void @dx.op.rawBufferVectorStore.v4f32(i32, %dx.types.Handle, i32, i32, <4 x float>, i32) #2

; Function Attrs: nounwind readnone
declare %dx.types.Handle @dx.op.annotateHandle(i32, %dx.types.Handle, %dx.types.ResourceProperties) #0

; Function Attrs: nounwind readnone
declare %dx.types.Handle @dx.op.createHandleFromBinding(i32, %dx.types.ResBind, i32, i1) #0

attributes #0 = { nounwind readnone }
attributes #1 = { nounwind readonly }
attributes #2 = { nounwind }

!llvm.ident = !{!0}
!dx.version = !{!1}
!dx.valver = !{!1}
!dx.shaderModel = !{!2}
!dx.resources = !{!3}
!dx.entryPoints = !{!6}

!0 = !{!"dxcoob 1.9.2609.5 (01b62ad47)"}
!1 = !{i32 1, i32 9}
!2 = !{!"cs", i32 6, i32 9}
!3 = !{null, !4, null, null}
!4 = !{!5}
!5 = !{i32 0, %struct.RWByteAddressBuffer* undef, !"", i32 0, i32 1, i32 1, i32 11, i1 false, i1 false, i1 false, null}
!6 = !{void ()* @main, !"main", null, !3, !7}
!7 = !{i32 0, i64 8589938704, i32 4, !8}
!8 = !{i32 64, i32 1, i32 1}

