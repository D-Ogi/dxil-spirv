;
; Input signature:
;
; Name                 Index   Mask Register SysValue  Format   Used
; -------------------- ----- ------ -------- -------- ------- ------
; A                        0   xyzw        0     NONE    uint   xyzw
; B                        0   xyzw        1     NONE    uint   xyzw
;
;
; Output signature:
;
; Name                 Index   Mask Register SysValue  Format   Used
; -------------------- ----- ------ -------- -------- ------- ------
; SV_Target                0   xyzw        0   TARGET   float   xyzw
;
; shader hash: 54f7a935dad0fc7b349a79025d09df89
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
; SigInputElements: 2
; SigOutputElements: 1
; SigPatchConstOrPrimElements: 0
; SigInputVectors: 2
; SigOutputVectors[0]: 1
; SigOutputVectors[1]: 0
; SigOutputVectors[2]: 0
; SigOutputVectors[3]: 0
; EntryFunctionName: main
;
;
; Input signature:
;
; Name                 Index             InterpMode DynIdx
; -------------------- ----- ---------------------- ------
; A                        0        nointerpolation       
; B                        0        nointerpolation       
;
; Output signature:
;
; Name                 Index             InterpMode DynIdx
; -------------------- ----- ---------------------- ------
; SV_Target                0                              
;
; Buffer Definitions:
;
;
; Resource Bindings:
;
; Name                                 Type  Format         Dim      ID      HLSL Bind  Count
; ------------------------------ ---------- ------- ----------- ------- -------------- ------
;
;
; ViewId state:
;
; Number of inputs: 8, outputs: 4
; Outputs dependent on ViewId: {  }
; Inputs contributing to computation of Outputs:
;   output 0 depends on inputs: { 0, 4 }
;   output 1 depends on inputs: { 0, 1, 4, 5 }
;   output 2 depends on inputs: { 0, 1, 2, 4, 5, 6 }
;   output 3 depends on inputs: { 0, 1, 2, 3, 4, 5, 6, 7 }
;
target datalayout = "e-m:e-p:32:32-i1:32-i8:32-i16:32-i32:32-i64:64-f16:32-f32:32-f64:64-n8:16:32:64"
target triple = "dxil-ms-dx"

%dx.types.i32c = type { i32, i1 }

define void @main() {
  %1 = call i32 @dx.op.loadInput.i32(i32 4, i32 1, i32 0, i8 0, i32 undef)  ; LoadInput(inputSigId,rowIndex,colIndex,gsVertexAxis)
  %2 = call i32 @dx.op.loadInput.i32(i32 4, i32 1, i32 0, i8 1, i32 undef)  ; LoadInput(inputSigId,rowIndex,colIndex,gsVertexAxis)
  %3 = call i32 @dx.op.loadInput.i32(i32 4, i32 1, i32 0, i8 2, i32 undef)  ; LoadInput(inputSigId,rowIndex,colIndex,gsVertexAxis)
  %4 = call i32 @dx.op.loadInput.i32(i32 4, i32 1, i32 0, i8 3, i32 undef)  ; LoadInput(inputSigId,rowIndex,colIndex,gsVertexAxis)
  %5 = call i32 @dx.op.loadInput.i32(i32 4, i32 0, i32 0, i8 0, i32 undef)  ; LoadInput(inputSigId,rowIndex,colIndex,gsVertexAxis)
  %6 = call i32 @dx.op.loadInput.i32(i32 4, i32 0, i32 0, i8 1, i32 undef)  ; LoadInput(inputSigId,rowIndex,colIndex,gsVertexAxis)
  %7 = call i32 @dx.op.loadInput.i32(i32 4, i32 0, i32 0, i8 2, i32 undef)  ; LoadInput(inputSigId,rowIndex,colIndex,gsVertexAxis)
  %8 = call i32 @dx.op.loadInput.i32(i32 4, i32 0, i32 0, i8 3, i32 undef)  ; LoadInput(inputSigId,rowIndex,colIndex,gsVertexAxis)
  %9 = call %dx.types.i32c @dx.op.binaryWithCarryOrBorrow.i32(i32 44, i32 %5, i32 %1)  ; UAddc(a,b)
  %10 = extractvalue %dx.types.i32c %9, 0
  %11 = extractvalue %dx.types.i32c %9, 1
  %12 = zext i1 %11 to i32
  %13 = add i32 %6, %2
  %14 = add i32 %12, %13
  %15 = call %dx.types.i32c @dx.op.binaryWithCarryOrBorrow.i32(i32 44, i32 %7, i32 %3)  ; UAddc(a,b)
  %16 = extractvalue %dx.types.i32c %15, 0
  %17 = extractvalue %dx.types.i32c %15, 1
  %18 = zext i1 %17 to i32
  %19 = add i32 %8, %4
  %20 = shl i32 %10, 1
  %21 = add i32 %14, %10
  %22 = add i32 %14, %16
  %23 = add i32 %19, %14
  %24 = add i32 %23, %18
  %25 = uitofp i32 %20 to float
  %26 = uitofp i32 %21 to float
  %27 = uitofp i32 %22 to float
  %28 = uitofp i32 %24 to float
  call void @dx.op.storeOutput.f32(i32 5, i32 0, i32 0, i8 0, float %25)  ; StoreOutput(outputSigId,rowIndex,colIndex,value)
  call void @dx.op.storeOutput.f32(i32 5, i32 0, i32 0, i8 1, float %26)  ; StoreOutput(outputSigId,rowIndex,colIndex,value)
  call void @dx.op.storeOutput.f32(i32 5, i32 0, i32 0, i8 2, float %27)  ; StoreOutput(outputSigId,rowIndex,colIndex,value)
  call void @dx.op.storeOutput.f32(i32 5, i32 0, i32 0, i8 3, float %28)  ; StoreOutput(outputSigId,rowIndex,colIndex,value)
  ret void
}

; Function Attrs: nounwind readnone
declare i32 @dx.op.loadInput.i32(i32, i32, i32, i8, i32) #0

; Function Attrs: nounwind
declare void @dx.op.storeOutput.f32(i32, i32, i32, i8, float) #1

; Function Attrs: nounwind readnone
declare %dx.types.i32c @dx.op.binaryWithCarryOrBorrow.i32(i32, i32, i32) #0

attributes #0 = { nounwind readnone }
attributes #1 = { nounwind }

!llvm.ident = !{!0}
!dx.version = !{!1}
!dx.valver = !{!2}
!dx.shaderModel = !{!3}
!dx.viewIdState = !{!4}
!dx.entryPoints = !{!5}

!0 = !{!"dxcoob 1.9.2609.5 (01b62ad47)"}
!1 = !{i32 1, i32 0}
!2 = !{i32 1, i32 9}
!3 = !{!"ps", i32 6, i32 0}
!4 = !{[10 x i32] [i32 8, i32 4, i32 15, i32 14, i32 12, i32 8, i32 15, i32 14, i32 12, i32 8]}
!5 = !{void ()* @main, !"main", !6, null, null}
!6 = !{!7, !12, null}
!7 = !{!8, !11}
!8 = !{i32 0, !"A", i8 5, i8 0, !9, i8 1, i32 1, i8 4, i32 0, i8 0, !10}
!9 = !{i32 0}
!10 = !{i32 3, i32 15}
!11 = !{i32 1, !"B", i8 5, i8 0, !9, i8 1, i32 1, i8 4, i32 1, i8 0, !10}
!12 = !{!13}
!13 = !{i32 0, !"SV_Target", i8 9, i8 16, !9, i8 0, i32 1, i8 4, i32 0, i8 0, !10}

