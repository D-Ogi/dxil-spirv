;
; Note: shader requires additional functionality:
;       64-Bit integer
;       64-bit Atomics on Typed Resources
;
;
; Input signature:
;
; Name                 Index   Mask Register SysValue  Format   Used
; -------------------- ----- ------ -------- -------- ------- ------
; A                        0   x           0     NONE    uint   x   
; B                        0    y          0     NONE    uint    y  
; C                        0     z         0     NONE    uint     z 
;
;
; Output signature:
;
; Name                 Index   Mask Register SysValue  Format   Used
; -------------------- ----- ------ -------- -------- ------- ------
; SV_Target                0   xyzw        0   TARGET   float   xyzw
;
; shader hash: a264432c3d07994ddac97a3fa81bfeb8
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
; SigInputElements: 3
; SigOutputElements: 1
; SigPatchConstOrPrimElements: 0
; SigInputVectors: 1
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
; C                        0        nointerpolation       
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
; resF                                  UAV     f32         buf      U0             u0     1
; resI                                  UAV     i32         buf      U1             u1     1
; resI64                                UAV     u32         buf      U2             u2     1
;
;
; ViewId state:
;
; Number of inputs: 3, outputs: 4
; Outputs dependent on ViewId: {  }
; Inputs contributing to computation of Outputs:
;   output 0 depends on inputs: { 0, 1, 2 }
;   output 1 depends on inputs: { 0, 1, 2 }
;   output 2 depends on inputs: { 0, 1, 2 }
;   output 3 depends on inputs: { 0, 1, 2 }
;
target datalayout = "e-m:e-p:32:32-i1:32-i8:32-i16:32-i32:32-i64:64-f16:32-f32:32-f64:64-n8:16:32:64"
target triple = "dxil-ms-dx"

%dx.types.Handle = type { i8* }
%dx.types.ResBind = type { i32, i32, i32, i8 }
%dx.types.ResourceProperties = type { i32, i32 }
%"class.RWBuffer<float>" = type { float }
%"class.RWBuffer<int>" = type { i32 }
%"class.RWBuffer<unsigned long long>" = type { i64 }

define void @main() {
  %1 = call %dx.types.Handle @dx.op.createHandleFromBinding(i32 217, %dx.types.ResBind { i32 2, i32 2, i32 0, i8 1 }, i32 2, i1 false)  ; CreateHandleFromBinding(bind,index,nonUniformIndex)
  %2 = call %dx.types.Handle @dx.op.createHandleFromBinding(i32 217, %dx.types.ResBind { i32 1, i32 1, i32 0, i8 1 }, i32 1, i1 false)  ; CreateHandleFromBinding(bind,index,nonUniformIndex)
  %3 = call %dx.types.Handle @dx.op.createHandleFromBinding(i32 217, %dx.types.ResBind { i32 0, i32 0, i32 0, i8 1 }, i32 0, i1 false)  ; CreateHandleFromBinding(bind,index,nonUniformIndex)
  %4 = call i32 @dx.op.loadInput.i32(i32 4, i32 2, i32 0, i8 0, i32 undef)  ; LoadInput(inputSigId,rowIndex,colIndex,gsVertexAxis)
  %5 = call i32 @dx.op.loadInput.i32(i32 4, i32 1, i32 0, i8 0, i32 undef)  ; LoadInput(inputSigId,rowIndex,colIndex,gsVertexAxis)
  %6 = call i32 @dx.op.loadInput.i32(i32 4, i32 0, i32 0, i8 0, i32 undef)  ; LoadInput(inputSigId,rowIndex,colIndex,gsVertexAxis)
  %7 = sub i32 %5, %4
  %8 = uitofp i32 %7 to float
  %9 = udiv i32 %5, %4
  %10 = zext i32 %5 to i64
  %11 = zext i32 %4 to i64
  %12 = mul nuw i64 %10, %11
  %13 = call %dx.types.Handle @dx.op.annotateHandle(i32 216, %dx.types.Handle %3, %dx.types.ResourceProperties { i32 4106, i32 265 })  ; AnnotateHandle(res,props)  resource: RWTypedBuffer<F32>
  %14 = bitcast float %8 to i32
  %15 = call i32 @dx.op.atomicBinOp.i32(i32 78, %dx.types.Handle %13, i32 8, i32 %6, i32 undef, i32 undef, i32 %14)  ; AtomicBinOp(handle,atomicOp,offset0,offset1,offset2,newValue)
  %16 = call %dx.types.Handle @dx.op.annotateHandle(i32 216, %dx.types.Handle %2, %dx.types.ResourceProperties { i32 4106, i32 260 })  ; AnnotateHandle(res,props)  resource: RWTypedBuffer<I32>
  %17 = call i32 @dx.op.atomicBinOp.i32(i32 78, %dx.types.Handle %16, i32 8, i32 %6, i32 undef, i32 undef, i32 %9)  ; AtomicBinOp(handle,atomicOp,offset0,offset1,offset2,newValue)
  %18 = call %dx.types.Handle @dx.op.annotateHandle(i32 216, %dx.types.Handle %1, %dx.types.ResourceProperties { i32 4106, i32 261 })  ; AnnotateHandle(res,props)  resource: RWTypedBuffer<U32>
  %19 = call i64 @dx.op.atomicBinOp.i64(i32 78, %dx.types.Handle %18, i32 8, i32 %6, i32 undef, i32 undef, i64 %12)  ; AtomicBinOp(handle,atomicOp,offset0,offset1,offset2,newValue)
  %20 = sitofp i32 %9 to float
  %21 = call %dx.types.Handle @dx.op.annotateHandle(i32 216, %dx.types.Handle %3, %dx.types.ResourceProperties { i32 4106, i32 265 })  ; AnnotateHandle(res,props)  resource: RWTypedBuffer<F32>
  %22 = bitcast float %20 to i32
  %23 = call i32 @dx.op.atomicBinOp.i32(i32 78, %dx.types.Handle %21, i32 8, i32 %6, i32 undef, i32 undef, i32 %22)  ; AtomicBinOp(handle,atomicOp,offset0,offset1,offset2,newValue)
  %24 = call %dx.types.Handle @dx.op.annotateHandle(i32 216, %dx.types.Handle %3, %dx.types.ResourceProperties { i32 4106, i32 265 })  ; AnnotateHandle(res,props)  resource: RWTypedBuffer<F32>
  %25 = call i32 @dx.op.atomicBinOp.i32(i32 78, %dx.types.Handle %24, i32 8, i32 %6, i32 undef, i32 undef, i32 %14)  ; AtomicBinOp(handle,atomicOp,offset0,offset1,offset2,newValue)
  %26 = bitcast i32 %25 to float
  %27 = fptosi float %26 to i32
  %28 = call %dx.types.Handle @dx.op.annotateHandle(i32 216, %dx.types.Handle %3, %dx.types.ResourceProperties { i32 4106, i32 265 })  ; AnnotateHandle(res,props)  resource: RWTypedBuffer<F32>
  %29 = call i32 @dx.op.atomicBinOp.i32(i32 78, %dx.types.Handle %28, i32 8, i32 %6, i32 undef, i32 undef, i32 %22)  ; AtomicBinOp(handle,atomicOp,offset0,offset1,offset2,newValue)
  %30 = fptoui float %8 to i32
  %31 = call %dx.types.Handle @dx.op.annotateHandle(i32 216, %dx.types.Handle %2, %dx.types.ResourceProperties { i32 4106, i32 260 })  ; AnnotateHandle(res,props)  resource: RWTypedBuffer<I32>
  %32 = call i32 @dx.op.atomicBinOp.i32(i32 78, %dx.types.Handle %31, i32 8, i32 %6, i32 undef, i32 undef, i32 %30)  ; AtomicBinOp(handle,atomicOp,offset0,offset1,offset2,newValue)
  %33 = fptosi float %8 to i64
  %34 = call %dx.types.Handle @dx.op.annotateHandle(i32 216, %dx.types.Handle %1, %dx.types.ResourceProperties { i32 4106, i32 261 })  ; AnnotateHandle(res,props)  resource: RWTypedBuffer<U32>
  %35 = call i64 @dx.op.atomicBinOp.i64(i32 78, %dx.types.Handle %34, i32 8, i32 %6, i32 undef, i32 undef, i64 %33)  ; AtomicBinOp(handle,atomicOp,offset0,offset1,offset2,newValue)
  %36 = sitofp i64 %35 to float
  %37 = call %dx.types.Handle @dx.op.annotateHandle(i32 216, %dx.types.Handle %3, %dx.types.ResourceProperties { i32 4106, i32 265 })  ; AnnotateHandle(res,props)  resource: RWTypedBuffer<F32>
  %38 = bitcast float %36 to i32
  %39 = call i32 @dx.op.atomicCompareExchange.i32(i32 79, %dx.types.Handle %37, i32 %6, i32 undef, i32 undef, i32 %14, i32 %38)  ; AtomicCompareExchange(handle,offset0,offset1,offset2,compareValue,newValue)
  %40 = sitofp i32 %27 to float
  %41 = call %dx.types.Handle @dx.op.annotateHandle(i32 216, %dx.types.Handle %3, %dx.types.ResourceProperties { i32 4106, i32 265 })  ; AnnotateHandle(res,props)  resource: RWTypedBuffer<F32>
  %42 = bitcast float %40 to i32
  %43 = call i32 @dx.op.atomicCompareExchange.i32(i32 79, %dx.types.Handle %41, i32 %6, i32 undef, i32 undef, i32 %22, i32 %42)  ; AtomicCompareExchange(handle,offset0,offset1,offset2,compareValue,newValue)
  %44 = call %dx.types.Handle @dx.op.annotateHandle(i32 216, %dx.types.Handle %3, %dx.types.ResourceProperties { i32 4106, i32 265 })  ; AnnotateHandle(res,props)  resource: RWTypedBuffer<F32>
  %45 = call i32 @dx.op.atomicCompareExchange.i32(i32 79, %dx.types.Handle %44, i32 %6, i32 undef, i32 undef, i32 %14, i32 %42)  ; AtomicCompareExchange(handle,offset0,offset1,offset2,compareValue,newValue)
  %46 = call %dx.types.Handle @dx.op.annotateHandle(i32 216, %dx.types.Handle %3, %dx.types.ResourceProperties { i32 4106, i32 265 })  ; AnnotateHandle(res,props)  resource: RWTypedBuffer<F32>
  %47 = call i32 @dx.op.atomicCompareExchange.i32(i32 79, %dx.types.Handle %46, i32 %6, i32 undef, i32 undef, i32 %22, i32 %38)  ; AtomicCompareExchange(handle,offset0,offset1,offset2,compareValue,newValue)
  %48 = call %dx.types.Handle @dx.op.annotateHandle(i32 216, %dx.types.Handle %3, %dx.types.ResourceProperties { i32 4106, i32 265 })  ; AnnotateHandle(res,props)  resource: RWTypedBuffer<F32>
  %49 = call i32 @dx.op.atomicCompareExchange.i32(i32 79, %dx.types.Handle %48, i32 %6, i32 undef, i32 undef, i32 %14, i32 %38)  ; AtomicCompareExchange(handle,offset0,offset1,offset2,compareValue,newValue)
  %50 = call %dx.types.Handle @dx.op.annotateHandle(i32 216, %dx.types.Handle %3, %dx.types.ResourceProperties { i32 4106, i32 265 })  ; AnnotateHandle(res,props)  resource: RWTypedBuffer<F32>
  %51 = call i32 @dx.op.atomicCompareExchange.i32(i32 79, %dx.types.Handle %50, i32 %6, i32 undef, i32 undef, i32 %22, i32 %42)  ; AtomicCompareExchange(handle,offset0,offset1,offset2,compareValue,newValue)
  %52 = call %dx.types.Handle @dx.op.annotateHandle(i32 216, %dx.types.Handle %3, %dx.types.ResourceProperties { i32 4106, i32 265 })  ; AnnotateHandle(res,props)  resource: RWTypedBuffer<F32>
  %53 = call i32 @dx.op.atomicCompareExchange.i32(i32 79, %dx.types.Handle %52, i32 %6, i32 undef, i32 undef, i32 %14, i32 %42)  ; AtomicCompareExchange(handle,offset0,offset1,offset2,compareValue,newValue)
  %54 = call %dx.types.Handle @dx.op.annotateHandle(i32 216, %dx.types.Handle %3, %dx.types.ResourceProperties { i32 4106, i32 265 })  ; AnnotateHandle(res,props)  resource: RWTypedBuffer<F32>
  %55 = call i32 @dx.op.atomicCompareExchange.i32(i32 79, %dx.types.Handle %54, i32 %6, i32 undef, i32 undef, i32 %22, i32 %38)  ; AtomicCompareExchange(handle,offset0,offset1,offset2,compareValue,newValue)
  %56 = call %dx.types.Handle @dx.op.annotateHandle(i32 216, %dx.types.Handle %3, %dx.types.ResourceProperties { i32 4106, i32 265 })  ; AnnotateHandle(res,props)  resource: RWTypedBuffer<F32>
  %57 = call i32 @dx.op.atomicBinOp.i32(i32 78, %dx.types.Handle %56, i32 8, i32 %6, i32 undef, i32 undef, i32 1065353216)  ; AtomicBinOp(handle,atomicOp,offset0,offset1,offset2,newValue)
  %58 = call %dx.types.Handle @dx.op.annotateHandle(i32 216, %dx.types.Handle %3, %dx.types.ResourceProperties { i32 4106, i32 265 })  ; AnnotateHandle(res,props)  resource: RWTypedBuffer<F32>
  %59 = call i32 @dx.op.atomicBinOp.i32(i32 78, %dx.types.Handle %58, i32 8, i32 %6, i32 undef, i32 undef, i32 1073741824)  ; AtomicBinOp(handle,atomicOp,offset0,offset1,offset2,newValue)
  %60 = call %dx.types.Handle @dx.op.annotateHandle(i32 216, %dx.types.Handle %3, %dx.types.ResourceProperties { i32 4106, i32 265 })  ; AnnotateHandle(res,props)  resource: RWTypedBuffer<F32>
  %61 = call i32 @dx.op.atomicCompareExchange.i32(i32 79, %dx.types.Handle %60, i32 %6, i32 undef, i32 undef, i32 1065353216, i32 1073741824)  ; AtomicCompareExchange(handle,offset0,offset1,offset2,compareValue,newValue)
  %62 = call %dx.types.Handle @dx.op.annotateHandle(i32 216, %dx.types.Handle %3, %dx.types.ResourceProperties { i32 4106, i32 265 })  ; AnnotateHandle(res,props)  resource: RWTypedBuffer<F32>
  %63 = call i32 @dx.op.atomicCompareExchange.i32(i32 79, %dx.types.Handle %62, i32 %6, i32 undef, i32 undef, i32 %22, i32 1073741824)  ; AtomicCompareExchange(handle,offset0,offset1,offset2,compareValue,newValue)
  %64 = call %dx.types.Handle @dx.op.annotateHandle(i32 216, %dx.types.Handle %3, %dx.types.ResourceProperties { i32 4106, i32 265 })  ; AnnotateHandle(res,props)  resource: RWTypedBuffer<F32>
  %65 = call i32 @dx.op.atomicCompareExchange.i32(i32 79, %dx.types.Handle %64, i32 %6, i32 undef, i32 undef, i32 1065353216, i32 %38)  ; AtomicCompareExchange(handle,offset0,offset1,offset2,compareValue,newValue)
  %66 = call %dx.types.Handle @dx.op.annotateHandle(i32 216, %dx.types.Handle %3, %dx.types.ResourceProperties { i32 4106, i32 265 })  ; AnnotateHandle(res,props)  resource: RWTypedBuffer<F32>
  %67 = call i32 @dx.op.atomicCompareExchange.i32(i32 79, %dx.types.Handle %66, i32 %6, i32 undef, i32 undef, i32 1065353216, i32 1073741824)  ; AtomicCompareExchange(handle,offset0,offset1,offset2,compareValue,newValue)
  %68 = call %dx.types.Handle @dx.op.annotateHandle(i32 216, %dx.types.Handle %3, %dx.types.ResourceProperties { i32 4106, i32 265 })  ; AnnotateHandle(res,props)  resource: RWTypedBuffer<F32>
  %69 = call i32 @dx.op.atomicCompareExchange.i32(i32 79, %dx.types.Handle %68, i32 %6, i32 undef, i32 undef, i32 1065353216, i32 %42)  ; AtomicCompareExchange(handle,offset0,offset1,offset2,compareValue,newValue)
  %70 = call %dx.types.Handle @dx.op.annotateHandle(i32 216, %dx.types.Handle %3, %dx.types.ResourceProperties { i32 4106, i32 265 })  ; AnnotateHandle(res,props)  resource: RWTypedBuffer<F32>
  %71 = call i32 @dx.op.atomicCompareExchange.i32(i32 79, %dx.types.Handle %70, i32 %6, i32 undef, i32 undef, i32 %42, i32 1073741824)  ; AtomicCompareExchange(handle,offset0,offset1,offset2,compareValue,newValue)
  %72 = bitcast i32 %71 to float
  call void @dx.op.storeOutput.f32(i32 5, i32 0, i32 0, i8 0, float %72)  ; StoreOutput(outputSigId,rowIndex,colIndex,value)
  call void @dx.op.storeOutput.f32(i32 5, i32 0, i32 0, i8 1, float %72)  ; StoreOutput(outputSigId,rowIndex,colIndex,value)
  call void @dx.op.storeOutput.f32(i32 5, i32 0, i32 0, i8 2, float %72)  ; StoreOutput(outputSigId,rowIndex,colIndex,value)
  call void @dx.op.storeOutput.f32(i32 5, i32 0, i32 0, i8 3, float %72)  ; StoreOutput(outputSigId,rowIndex,colIndex,value)
  ret void
}

; Function Attrs: nounwind readnone
declare i32 @dx.op.loadInput.i32(i32, i32, i32, i8, i32) #0

; Function Attrs: nounwind
declare void @dx.op.storeOutput.f32(i32, i32, i32, i8, float) #1

; Function Attrs: nounwind
declare i32 @dx.op.atomicCompareExchange.i32(i32, %dx.types.Handle, i32, i32, i32, i32, i32) #1

; Function Attrs: nounwind
declare i32 @dx.op.atomicBinOp.i32(i32, %dx.types.Handle, i32, i32, i32, i32, i32) #1

; Function Attrs: nounwind
declare i64 @dx.op.atomicBinOp.i64(i32, %dx.types.Handle, i32, i32, i32, i32, i64) #1

; Function Attrs: nounwind readnone
declare %dx.types.Handle @dx.op.annotateHandle(i32, %dx.types.Handle, %dx.types.ResourceProperties) #0

; Function Attrs: nounwind readnone
declare %dx.types.Handle @dx.op.createHandleFromBinding(i32, %dx.types.ResBind, i32, i1) #0

attributes #0 = { nounwind readnone }
attributes #1 = { nounwind }

!llvm.ident = !{!0}
!dx.version = !{!1}
!dx.valver = !{!2}
!dx.shaderModel = !{!3}
!dx.resources = !{!4}
!dx.viewIdState = !{!12}
!dx.entryPoints = !{!13}

!0 = !{!"dxcoob 1.9.2609.5 (01b62ad47)"}
!1 = !{i32 1, i32 6}
!2 = !{i32 1, i32 9}
!3 = !{!"ps", i32 6, i32 6}
!4 = !{null, !5, null, null}
!5 = !{!6, !8, !10}
!6 = !{i32 0, %"class.RWBuffer<float>"* undef, !"", i32 0, i32 0, i32 1, i32 10, i1 false, i1 false, i1 false, !7}
!7 = !{i32 0, i32 9}
!8 = !{i32 1, %"class.RWBuffer<int>"* undef, !"", i32 0, i32 1, i32 1, i32 10, i1 false, i1 false, i1 false, !9}
!9 = !{i32 0, i32 4}
!10 = !{i32 2, %"class.RWBuffer<unsigned long long>"* undef, !"", i32 0, i32 2, i32 1, i32 10, i1 false, i1 false, i1 false, !11}
!11 = !{i32 0, i32 5, i32 3, i32 1}
!12 = !{[5 x i32] [i32 3, i32 4, i32 15, i32 15, i32 15]}
!13 = !{void ()* @main, !"main", !14, !4, !24}
!14 = !{!15, !21, null}
!15 = !{!16, !19, !20}
!16 = !{i32 0, !"A", i8 5, i8 0, !17, i8 1, i32 1, i8 1, i32 0, i8 0, !18}
!17 = !{i32 0}
!18 = !{i32 3, i32 1}
!19 = !{i32 1, !"B", i8 5, i8 0, !17, i8 1, i32 1, i8 1, i32 0, i8 1, !18}
!20 = !{i32 2, !"C", i8 5, i8 0, !17, i8 1, i32 1, i8 1, i32 0, i8 2, !18}
!21 = !{!22}
!22 = !{i32 0, !"SV_Target", i8 9, i8 16, !17, i8 0, i32 1, i8 4, i32 0, i8 0, !23}
!23 = !{i32 3, i32 15}
!24 = !{i32 0, i64 135266304}

