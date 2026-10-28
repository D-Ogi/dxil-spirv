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
; shader hash: c4b8a6362e242ace486af3b8cf12fac2
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
;   uint2 $Element;                                   ; Offset:    0 Size:     8
;
; }
;
;
; Resource Bindings:
;
; Name                                 Type  Format         Dim      ID      HLSL Bind  Count
; ------------------------------ ---------- ------- ----------- ------- -------------- ------
; O                                     UAV  struct         r/w      U0             u0     1
;
target datalayout = "e-m:e-p:32:32-i1:32-i8:32-i16:32-i32:32-i64:64-f16:32-f32:32-f64:64-n8:16:32:64"
target triple = "dxil-ms-dx"

%dx.types.Handle = type { i8* }
%dx.types.ResRet.i32 = type { i32, i32, i32, i32, i32 }
%dx.types.i32c = type { i32, i1 }
%"class.RWStructuredBuffer<vector<unsigned int, 2> >" = type { <2 x i32> }

define void @main() {
  %1 = call %dx.types.Handle @dx.op.createHandle(i32 57, i8 1, i32 0, i32 0, i1 false)  ; CreateHandle(resourceClass,rangeId,index,nonUniformIndex)
  %2 = call i32 @dx.op.threadId.i32(i32 93, i32 0)  ; ThreadId(component)
  %3 = call %dx.types.ResRet.i32 @dx.op.bufferLoad.i32(i32 68, %dx.types.Handle %1, i32 %2, i32 0)  ; BufferLoad(srv,index,wot)
  %4 = extractvalue %dx.types.ResRet.i32 %3, 0
  %5 = extractvalue %dx.types.ResRet.i32 %3, 1
  %6 = call %dx.types.i32c @dx.op.binaryWithCarryOrBorrow.i32(i32 44, i32 %4, i32 -1)  ; UAddc(a,b)
  %7 = extractvalue %dx.types.i32c %6, 0
  %8 = extractvalue %dx.types.i32c %6, 1
  %9 = zext i1 %8 to i32
  %10 = add i32 %9, %5
  call void @dx.op.bufferStore.i32(i32 69, %dx.types.Handle %1, i32 %2, i32 0, i32 %7, i32 %10, i32 undef, i32 undef, i8 3)  ; BufferStore(uav,coord0,coord1,value0,value1,value2,value3,mask)
  ret void
}

; Function Attrs: nounwind readnone
declare i32 @dx.op.threadId.i32(i32, i32) #0

; Function Attrs: nounwind readnone
declare %dx.types.i32c @dx.op.binaryWithCarryOrBorrow.i32(i32, i32, i32) #0

; Function Attrs: nounwind readonly
declare %dx.types.Handle @dx.op.createHandle(i32, i8, i32, i32, i1) #1

; Function Attrs: nounwind readonly
declare %dx.types.ResRet.i32 @dx.op.bufferLoad.i32(i32, %dx.types.Handle, i32, i32) #1

; Function Attrs: nounwind
declare void @dx.op.bufferStore.i32(i32, %dx.types.Handle, i32, i32, i32, i32, i32, i32, i8) #2

attributes #0 = { nounwind readnone }
attributes #1 = { nounwind readonly }
attributes #2 = { nounwind }

!llvm.ident = !{!0}
!dx.version = !{!1}
!dx.valver = !{!2}
!dx.shaderModel = !{!3}
!dx.resources = !{!4}
!dx.entryPoints = !{!8}

!0 = !{!"dxcoob 1.9.2609.5 (01b62ad47)"}
!1 = !{i32 1, i32 0}
!2 = !{i32 1, i32 9}
!3 = !{!"cs", i32 6, i32 0}
!4 = !{null, !5, null, null}
!5 = !{!6}
!6 = !{i32 0, %"class.RWStructuredBuffer<vector<unsigned int, 2> >"* undef, !"", i32 0, i32 0, i32 1, i32 12, i1 false, i1 false, i1 false, !7}
!7 = !{i32 1, i32 8}
!8 = !{void ()* @main, !"main", null, !4, !9}
!9 = !{i32 0, i64 16, i32 4, !10}
!10 = !{i32 64, i32 1, i32 1}

