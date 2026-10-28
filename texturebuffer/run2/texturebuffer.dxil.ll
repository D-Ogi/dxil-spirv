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
; SV_Target                0   xyzw        0   TARGET   float   xyzw
;
; shader hash: d16055c1fbeed0b8b7b3954256cf1616
;
; Pipeline Runtime Information: 
;
;PSVRuntimeInfo:
; Pixel Shader
; DepthOutput=0
; SampleFrequency=0
; MinimumExpectedWaveLaneCount: 0
; MaximumExpectedWaveLaneCount: 4294967295
; UsesViewID: false
; SigInputElements: 0
; SigOutputElements: 1
; SigPatchConstOrPrimElements: 0
; SigInputVectors: 0
; SigOutputVectors[0]: 1
; SigOutputVectors[1]: 0
; SigOutputVectors[2]: 0
; SigOutputVectors[3]: 0
; EntryFunctionName: main
;
;
; Output signature:
;
; Name                 Index             InterpMode DynIdx
; -------------------- ----- ---------------------- ------
; SV_Target                0                              
;
; Buffer Definitions:
;
; tbuffer TB
; {
;
;   struct TB
;   {
;
;       struct struct.S
;       {
;
;           float4 v;                                 ; Offset:    0
;       
;       } TB;                                         ; Offset:    0
;
;   
;   } TB;                                             ; Offset:    0 Size:    16
;
; }
;
;
; Resource Bindings:
;
; Name                                 Type  Format         Dim      ID      HLSL Bind  Count
; ------------------------------ ---------- ------- ----------- ------- -------------- ------
; TB                                texture     u32     tbuffer      T0             t0     1
;
;
; ViewId state:
;
; Number of inputs: 0, outputs: 4
; Outputs dependent on ViewId: {  }
; Inputs contributing to computation of Outputs:
;
target datalayout = "e-m:e-p:32:32-i1:32-i8:32-i16:32-i32:32-i64:64-f16:32-f32:32-f64:64-n8:16:32:64"
target triple = "dxil-ms-dx"

%dx.types.Handle = type { i8* }
%dx.types.ResRet.i32 = type { i32, i32, i32, i32, i32 }
%TB = type { %struct.S }
%struct.S = type { <4 x float> }

define void @main() {
  %1 = call %dx.types.Handle @dx.op.createHandle(i32 57, i8 0, i32 0, i32 0, i1 false)  ; CreateHandle(resourceClass,rangeId,index,nonUniformIndex)
  %2 = call %dx.types.ResRet.i32 @dx.op.bufferLoad.i32(i32 68, %dx.types.Handle %1, i32 0, i32 undef)  ; BufferLoad(srv,index,wot)
  %3 = extractvalue %dx.types.ResRet.i32 %2, 0
  %4 = bitcast i32 %3 to float
  %5 = extractvalue %dx.types.ResRet.i32 %2, 1
  %6 = bitcast i32 %5 to float
  %7 = extractvalue %dx.types.ResRet.i32 %2, 2
  %8 = bitcast i32 %7 to float
  %9 = extractvalue %dx.types.ResRet.i32 %2, 3
  %10 = bitcast i32 %9 to float
  call void @dx.op.storeOutput.f32(i32 5, i32 0, i32 0, i8 0, float %4)  ; StoreOutput(outputSigId,rowIndex,colIndex,value)
  call void @dx.op.storeOutput.f32(i32 5, i32 0, i32 0, i8 1, float %6)  ; StoreOutput(outputSigId,rowIndex,colIndex,value)
  call void @dx.op.storeOutput.f32(i32 5, i32 0, i32 0, i8 2, float %8)  ; StoreOutput(outputSigId,rowIndex,colIndex,value)
  call void @dx.op.storeOutput.f32(i32 5, i32 0, i32 0, i8 3, float %10)  ; StoreOutput(outputSigId,rowIndex,colIndex,value)
  ret void
}

; Function Attrs: nounwind
declare void @dx.op.storeOutput.f32(i32, i32, i32, i8, float) #0

; Function Attrs: nounwind readonly
declare %dx.types.ResRet.i32 @dx.op.bufferLoad.i32(i32, %dx.types.Handle, i32, i32) #1

; Function Attrs: nounwind readonly
declare %dx.types.Handle @dx.op.createHandle(i32, i8, i32, i32, i1) #1

attributes #0 = { nounwind }
attributes #1 = { nounwind readonly }

!llvm.ident = !{!0}
!dx.version = !{!1}
!dx.valver = !{!2}
!dx.shaderModel = !{!3}
!dx.resources = !{!4}
!dx.viewIdState = !{!8}
!dx.entryPoints = !{!9}

!0 = !{!"dxcoob 1.9.2609.5 (01b62ad47)"}
!1 = !{i32 1, i32 0}
!2 = !{i32 1, i32 9}
!3 = !{!"ps", i32 6, i32 0}
!4 = !{!5, null, null, null}
!5 = !{!6}
!6 = !{i32 0, %TB* undef, !"", i32 0, i32 0, i32 1, i32 15, i32 0, !7}
!7 = !{i32 0, i32 5}
!8 = !{[2 x i32] [i32 0, i32 4]}
!9 = !{void ()* @main, !"main", !10, !4, null}
!10 = !{null, !11, null}
!11 = !{!12}
!12 = !{i32 0, !"SV_Target", i8 9, i8 16, !13, i8 0, i32 1, i8 4, i32 0, i8 0, !14}
!13 = !{i32 0}
!14 = !{i32 3, i32 15}

