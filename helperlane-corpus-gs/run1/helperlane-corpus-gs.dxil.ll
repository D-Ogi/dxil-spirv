;
; Input signature:
;
; Name                 Index   Mask Register SysValue  Format   Used
; -------------------- ----- ------ -------- -------- ------- ------
; SV_Position              0   xyzw        0      POS   float       
;
;
; Output signature:
;
; Name                 Index   Mask Register SysValue  Format   Used
; -------------------- ----- ------ -------- -------- ------- ------
; SV_Position              0   xyzw        0      POS   float   xyzw
;
; shader hash: 75d03def963868224dc4b05d42dfb1b8
;
; Pipeline Runtime Information: 
;
;PSVRuntimeInfo:
; Geometry Shader
; InputPrimitive=triangle
; OutputTopology=point
; OutputStreamMask=1
; OutputPositionPresent=1
; MinimumExpectedWaveLaneCount: 0
; MaximumExpectedWaveLaneCount: 4294967295
; UsesViewID: false
; SigInputElements: 1
; SigOutputElements: 1
; SigPatchConstOrPrimElements: 0
; SigInputVectors: 1
; SigOutputVectors[0]: 1
; SigOutputVectors[1]: 0
; SigOutputVectors[2]: 0
; SigOutputVectors[3]: 0
; EntryFunctionName: gs
;
;
; Input signature:
;
; Name                 Index             InterpMode DynIdx
; -------------------- ----- ---------------------- ------
; SV_Position              0          noperspective       
;
; Output signature:
;
; Name                 Index             InterpMode DynIdx
; -------------------- ----- ---------------------- ------
; SV_Position              0          noperspective       
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
;
; Resource Bindings:
;
; Name                                 Type  Format         Dim      ID      HLSL Bind  Count
; ------------------------------ ---------- ------- ----------- ------- -------------- ------
; $Globals                          cbuffer      NA          NA     CB0            cb0     1
;
;
; ViewId state:
;
; Number of inputs: 4, outputs per stream: { 4, 0, 0, 0 }
; Outputs for Stream 0 dependent on ViewId: {  }
; Inputs contributing to computation of Outputs for Stream 0:
;
target datalayout = "e-m:e-p:32:32-i1:32-i8:32-i16:32-i32:32-i64:64-f16:32-f32:32-f64:64-n8:16:32:64"
target triple = "dxil-ms-dx"

%dx.types.Handle = type { i8* }
%dx.types.ResBind = type { i32, i32, i32, i8 }
%dx.types.ResourceProperties = type { i32, i32 }
%dx.types.CBufRet.f32 = type { float, float, float, float }
%"$Globals" = type { <4 x float> }

@dx.nothing.a = internal constant [1 x i32] zeroinitializer

define void @gs() {
  %1 = call %dx.types.Handle @dx.op.createHandleFromBinding(i32 217, %dx.types.ResBind { i32 0, i32 0, i32 0, i8 2 }, i32 0, i1 false)  ; CreateHandleFromBinding(bind,index,nonUniformIndex)
  %2 = call %dx.types.Handle @dx.op.annotateHandle(i32 216, %dx.types.Handle %1, %dx.types.ResourceProperties { i32 13, i32 16 })  ; AnnotateHandle(res,props)  resource: CBuffer
  %3 = call %dx.types.CBufRet.f32 @dx.op.cbufferLoadLegacy.f32(i32 59, %dx.types.Handle %2, i32 0)  ; CBufferLoadLegacy(handle,regIndex)
  %4 = extractvalue %dx.types.CBufRet.f32 %3, 0
  %5 = extractvalue %dx.types.CBufRet.f32 %3, 1
  %6 = extractvalue %dx.types.CBufRet.f32 %3, 2
  %7 = extractvalue %dx.types.CBufRet.f32 %3, 3
  %8 = call i1 @dx.op.isHelperLane.i1(i32 221)  ; IsHelperLane()
  %9 = uitofp i1 %8 to float
  %10 = fadd fast float %4, %9
  %11 = fadd fast float %5, %9
  %12 = fadd fast float %6, %9
  %13 = fadd fast float %7, %9
  %14 = load i32, i32* getelementptr inbounds ([1 x i32], [1 x i32]* @dx.nothing.a, i32 0, i32 0)
  %15 = load i32, i32* getelementptr inbounds ([1 x i32], [1 x i32]* @dx.nothing.a, i32 0, i32 0)
  call void @dx.op.storeOutput.f32(i32 5, i32 0, i32 0, i8 0, float %10)  ; StoreOutput(outputSigId,rowIndex,colIndex,value)
  call void @dx.op.storeOutput.f32(i32 5, i32 0, i32 0, i8 1, float %11)  ; StoreOutput(outputSigId,rowIndex,colIndex,value)
  call void @dx.op.storeOutput.f32(i32 5, i32 0, i32 0, i8 2, float %12)  ; StoreOutput(outputSigId,rowIndex,colIndex,value)
  call void @dx.op.storeOutput.f32(i32 5, i32 0, i32 0, i8 3, float %13)  ; StoreOutput(outputSigId,rowIndex,colIndex,value)
  call void @dx.op.emitStream(i32 97, i8 0)  ; EmitStream(streamId)
  call void @dx.op.cutStream(i32 98, i8 0)  ; CutStream(streamId)
  %16 = load i32, i32* getelementptr inbounds ([1 x i32], [1 x i32]* @dx.nothing.a, i32 0, i32 0)
  ret void
}

; Function Attrs: nounwind
declare void @dx.op.storeOutput.f32(i32, i32, i32, i8, float) #0

; Function Attrs: nounwind
declare void @dx.op.cutStream(i32, i8) #0

; Function Attrs: nounwind
declare void @dx.op.emitStream(i32, i8) #0

; Function Attrs: nounwind readonly
declare i1 @dx.op.isHelperLane.i1(i32) #1

; Function Attrs: nounwind readonly
declare %dx.types.CBufRet.f32 @dx.op.cbufferLoadLegacy.f32(i32, %dx.types.Handle, i32) #1

; Function Attrs: nounwind readnone
declare %dx.types.Handle @dx.op.annotateHandle(i32, %dx.types.Handle, %dx.types.ResourceProperties) #2

; Function Attrs: nounwind readnone
declare %dx.types.Handle @dx.op.createHandleFromBinding(i32, %dx.types.ResBind, i32, i1) #2

attributes #0 = { nounwind }
attributes #1 = { nounwind readonly }
attributes #2 = { nounwind readnone }

!llvm.ident = !{!0}
!dx.version = !{!1}
!dx.valver = !{!2}
!dx.shaderModel = !{!3}
!dx.resources = !{!4}
!dx.viewIdState = !{!7}
!dx.entryPoints = !{!8}

!0 = !{!"dxcoob 1.9.2609.5 (01b62ad47)"}
!1 = !{i32 1, i32 6}
!2 = !{i32 1, i32 9}
!3 = !{!"gs", i32 6, i32 6}
!4 = !{null, null, !5, null}
!5 = !{!6}
!6 = !{i32 0, %"$Globals"* undef, !"", i32 0, i32 0, i32 1, i32 16, null}
!7 = !{[9 x i32] [i32 4, i32 4, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0]}
!8 = !{void ()* @gs, !"gs", !9, !4, !16}
!9 = !{!10, !13, null}
!10 = !{!11}
!11 = !{i32 0, !"SV_Position", i8 9, i8 3, !12, i8 4, i32 1, i8 4, i32 0, i8 0, null}
!12 = !{i32 0}
!13 = !{!14}
!14 = !{i32 0, !"SV_Position", i8 9, i8 3, !12, i8 4, i32 1, i8 4, i32 0, i8 0, !15}
!15 = !{i32 3, i32 15}
!16 = !{i32 0, i64 1, i32 1, !17}
!17 = !{i32 3, i32 1, i32 1, i32 1, i32 1}

