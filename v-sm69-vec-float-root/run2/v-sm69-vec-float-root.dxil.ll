;
; Note: shader requires additional functionality:
;       UAVs at every shader stage
;       Tiled resources
;
;
; Input signature:
;
; Name                 Index   Mask Register SysValue  Format   Used
; -------------------- ----- ------ -------- -------- ------- ------
; IX                       0   x           0     NONE    uint   x   
; IX                       1   x           1     NONE    uint   x   
; IX                       2   x           2     NONE    uint   x   
;
;
; Output signature:
;
; Name                 Index   Mask Register SysValue  Format   Used
; -------------------- ----- ------ -------- -------- ------- ------
; no parameters
; shader hash: 29ec5b7c3abee98287413a9a2ef99055
;
; Pipeline Runtime Information: 
;
;PSVRuntimeInfo:
; Vertex Shader
; OutputPositionPresent=0
; MinimumExpectedWaveLaneCount: 0
; MaximumExpectedWaveLaneCount: 4294967295
; UsesViewID: false
; SigInputElements: 1
; SigOutputElements: 0
; SigPatchConstOrPrimElements: 0
; SigInputVectors: 3
; SigOutputVectors[0]: 0
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
; IX                       0                              
;
; Buffer Definitions:
;
; Resource bind info for RoStBuf
; {
;
;   float4 $Element;                                  ; Offset:    0 Size:    16
;
; }
;
; Resource bind info for RwStBuf
; {
;
;   float4 $Element;                                  ; Offset:    0 Size:    16
;
; }
;
; Resource bind info for CnStBuf
; {
;
;   float4 $Element;                                  ; Offset:    0 Size:    16
;
; }
;
; Resource bind info for ApStBuf
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
; RoByBuf                           texture    byte         r/o      T0             t1     1
; RoStBuf                           texture  struct         r/o      T1             t2     1
; RwByBuf                               UAV    byte         r/w      U0             u1     1
; RwStBuf                               UAV  struct         r/w      U1             u2     1
; CnStBuf                               UAV  struct     r/w+cnt      U2             u4     1
; ApStBuf                               UAV  struct     r/w+cnt      U3             u5     1
;
;
; ViewId state:
;
; Number of inputs: 9, outputs: 0
; Outputs dependent on ViewId: {  }
; Inputs contributing to computation of Outputs:
;
target datalayout = "e-m:e-p:32:32-i1:32-i8:32-i16:32-i32:32-i64:64-f16:32-f32:32-f64:64-n8:16:32:64"
target triple = "dxil-ms-dx"

%dx.types.Handle = type { i8* }
%dx.types.ResBind = type { i32, i32, i32, i8 }
%dx.types.ResourceProperties = type { i32, i32 }
%dx.types.ResRet.v4f32 = type { <4 x float>, i32 }
%struct.ByteAddressBuffer = type { i32 }
%"class.StructuredBuffer<vector<float, 4> >" = type { <4 x float> }
%struct.RWByteAddressBuffer = type { i32 }
%"class.RWStructuredBuffer<vector<float, 4> >" = type { <4 x float> }
%"class.ConsumeStructuredBuffer<vector<float, 4> >" = type { <4 x float> }
%"class.AppendStructuredBuffer<vector<float, 4> >" = type { <4 x float> }

define void @main() {
  %1 = call %dx.types.Handle @dx.op.createHandleFromBinding(i32 217, %dx.types.ResBind { i32 5, i32 5, i32 0, i8 1 }, i32 5, i1 false)  ; CreateHandleFromBinding(bind,index,nonUniformIndex)
  %2 = call %dx.types.Handle @dx.op.createHandleFromBinding(i32 217, %dx.types.ResBind { i32 4, i32 4, i32 0, i8 1 }, i32 4, i1 false)  ; CreateHandleFromBinding(bind,index,nonUniformIndex)
  %3 = call %dx.types.Handle @dx.op.createHandleFromBinding(i32 217, %dx.types.ResBind { i32 2, i32 2, i32 0, i8 1 }, i32 2, i1 false)  ; CreateHandleFromBinding(bind,index,nonUniformIndex)
  %4 = call %dx.types.Handle @dx.op.createHandleFromBinding(i32 217, %dx.types.ResBind { i32 1, i32 1, i32 0, i8 1 }, i32 1, i1 false)  ; CreateHandleFromBinding(bind,index,nonUniformIndex)
  %5 = call %dx.types.Handle @dx.op.createHandleFromBinding(i32 217, %dx.types.ResBind { i32 2, i32 2, i32 0, i8 0 }, i32 2, i1 false)  ; CreateHandleFromBinding(bind,index,nonUniformIndex)
  %6 = call %dx.types.Handle @dx.op.createHandleFromBinding(i32 217, %dx.types.ResBind { i32 1, i32 1, i32 0, i8 0 }, i32 1, i1 false)  ; CreateHandleFromBinding(bind,index,nonUniformIndex)
  %7 = call i32 @dx.op.loadInput.i32(i32 4, i32 0, i32 0, i8 0, i32 undef)  ; LoadInput(inputSigId,rowIndex,colIndex,gsVertexAxis)
  %8 = call %dx.types.Handle @dx.op.annotateHandle(i32 216, %dx.types.Handle %4, %dx.types.ResourceProperties { i32 4107, i32 0 })  ; AnnotateHandle(res,props)  resource: RWByteAddressBuffer
  %9 = call %dx.types.ResRet.v4f32 @dx.op.rawBufferVectorLoad.v4f32(i32 303, %dx.types.Handle %8, i32 %7, i32 undef, i32 4)  ; RawBufferVectorLoad(buf,index,elementOffset,alignment)
  %10 = extractvalue %dx.types.ResRet.v4f32 %9, 0
  %11 = call i32 @dx.op.loadInput.i32(i32 4, i32 0, i32 1, i8 0, i32 undef)  ; LoadInput(inputSigId,rowIndex,colIndex,gsVertexAxis)
  %12 = call %dx.types.ResRet.v4f32 @dx.op.rawBufferVectorLoad.v4f32(i32 303, %dx.types.Handle %8, i32 %11, i32 undef, i32 4)  ; RawBufferVectorLoad(buf,index,elementOffset,alignment)
  %13 = extractvalue %dx.types.ResRet.v4f32 %12, 0
  %14 = extractvalue %dx.types.ResRet.v4f32 %12, 1
  %15 = call i1 @dx.op.checkAccessFullyMapped.i32(i32 71, i32 %14)  ; CheckAccessFullyMapped(status)
  %16 = call %dx.types.Handle @dx.op.annotateHandle(i32 216, %dx.types.Handle %6, %dx.types.ResourceProperties { i32 11, i32 0 })  ; AnnotateHandle(res,props)  resource: ByteAddressBuffer
  %17 = call %dx.types.ResRet.v4f32 @dx.op.rawBufferVectorLoad.v4f32(i32 303, %dx.types.Handle %16, i32 %7, i32 undef, i32 4)  ; RawBufferVectorLoad(buf,index,elementOffset,alignment)
  %18 = extractvalue %dx.types.ResRet.v4f32 %17, 0
  %19 = call %dx.types.ResRet.v4f32 @dx.op.rawBufferVectorLoad.v4f32(i32 303, %dx.types.Handle %16, i32 %11, i32 undef, i32 4)  ; RawBufferVectorLoad(buf,index,elementOffset,alignment)
  %20 = extractvalue %dx.types.ResRet.v4f32 %19, 0
  %21 = extractvalue %dx.types.ResRet.v4f32 %19, 1
  %22 = call i1 @dx.op.checkAccessFullyMapped.i32(i32 71, i32 %21)  ; CheckAccessFullyMapped(status)
  %23 = fadd fast <4 x float> %13, %10
  %24 = fadd fast <4 x float> %23, %18
  %25 = fadd fast <4 x float> %24, %20
  call void @dx.op.rawBufferVectorStore.v4f32(i32 304, %dx.types.Handle %8, i32 %7, i32 undef, <4 x float> %25, i32 4)  ; RawBufferVectorStore(uav,index,elementOffset,value0,alignment)
  %26 = and i1 %15, %22
  %27 = zext i1 %26 to i32
  %28 = call %dx.types.Handle @dx.op.annotateHandle(i32 216, %dx.types.Handle %4, %dx.types.ResourceProperties { i32 4107, i32 0 })  ; AnnotateHandle(res,props)  resource: RWByteAddressBuffer
  call void @dx.op.rawBufferStore.i32(i32 140, %dx.types.Handle %28, i32 100, i32 undef, i32 %27, i32 undef, i32 undef, i32 undef, i8 1, i32 4)  ; RawBufferStore(uav,index,elementOffset,value0,value1,value2,value3,mask,alignment)
  %29 = call %dx.types.Handle @dx.op.annotateHandle(i32 216, %dx.types.Handle %3, %dx.types.ResourceProperties { i32 4108, i32 16 })  ; AnnotateHandle(res,props)  resource: RWStructuredBuffer<stride=16>
  %30 = call %dx.types.ResRet.v4f32 @dx.op.rawBufferVectorLoad.v4f32(i32 303, %dx.types.Handle %29, i32 %7, i32 0, i32 4)  ; RawBufferVectorLoad(buf,index,elementOffset,alignment)
  %31 = extractvalue %dx.types.ResRet.v4f32 %30, 0
  %32 = call %dx.types.ResRet.v4f32 @dx.op.rawBufferVectorLoad.v4f32(i32 303, %dx.types.Handle %29, i32 %11, i32 0, i32 4)  ; RawBufferVectorLoad(buf,index,elementOffset,alignment)
  %33 = extractvalue %dx.types.ResRet.v4f32 %32, 0
  %34 = call i32 @dx.op.loadInput.i32(i32 4, i32 0, i32 2, i8 0, i32 undef)  ; LoadInput(inputSigId,rowIndex,colIndex,gsVertexAxis)
  %35 = call %dx.types.ResRet.v4f32 @dx.op.rawBufferVectorLoad.v4f32(i32 303, %dx.types.Handle %29, i32 %34, i32 0, i32 4)  ; RawBufferVectorLoad(buf,index,elementOffset,alignment)
  %36 = extractvalue %dx.types.ResRet.v4f32 %35, 0
  %37 = extractvalue %dx.types.ResRet.v4f32 %35, 1
  %38 = call i1 @dx.op.checkAccessFullyMapped.i32(i32 71, i32 %37)  ; CheckAccessFullyMapped(status)
  %39 = call %dx.types.Handle @dx.op.annotateHandle(i32 216, %dx.types.Handle %5, %dx.types.ResourceProperties { i32 12, i32 16 })  ; AnnotateHandle(res,props)  resource: StructuredBuffer<stride=16>
  %40 = call %dx.types.ResRet.v4f32 @dx.op.rawBufferVectorLoad.v4f32(i32 303, %dx.types.Handle %39, i32 %7, i32 0, i32 4)  ; RawBufferVectorLoad(buf,index,elementOffset,alignment)
  %41 = extractvalue %dx.types.ResRet.v4f32 %40, 0
  %42 = call %dx.types.ResRet.v4f32 @dx.op.rawBufferVectorLoad.v4f32(i32 303, %dx.types.Handle %39, i32 %11, i32 0, i32 4)  ; RawBufferVectorLoad(buf,index,elementOffset,alignment)
  %43 = extractvalue %dx.types.ResRet.v4f32 %42, 0
  %44 = call %dx.types.ResRet.v4f32 @dx.op.rawBufferVectorLoad.v4f32(i32 303, %dx.types.Handle %39, i32 %34, i32 0, i32 4)  ; RawBufferVectorLoad(buf,index,elementOffset,alignment)
  %45 = extractvalue %dx.types.ResRet.v4f32 %44, 0
  %46 = extractvalue %dx.types.ResRet.v4f32 %44, 1
  %47 = call i1 @dx.op.checkAccessFullyMapped.i32(i32 71, i32 %46)  ; CheckAccessFullyMapped(status)
  %48 = fadd fast <4 x float> %33, %31
  %49 = fadd fast <4 x float> %48, %36
  %50 = fadd fast <4 x float> %49, %41
  %51 = fadd fast <4 x float> %50, %43
  %52 = fadd fast <4 x float> %51, %45
  call void @dx.op.rawBufferVectorStore.v4f32(i32 304, %dx.types.Handle %29, i32 %7, i32 0, <4 x float> %52, i32 4)  ; RawBufferVectorStore(uav,index,elementOffset,value0,alignment)
  %53 = and i1 %38, %47
  %54 = zext i1 %53 to i32
  %55 = call %dx.types.Handle @dx.op.annotateHandle(i32 216, %dx.types.Handle %4, %dx.types.ResourceProperties { i32 4107, i32 0 })  ; AnnotateHandle(res,props)  resource: RWByteAddressBuffer
  call void @dx.op.rawBufferStore.i32(i32 140, %dx.types.Handle %55, i32 200, i32 undef, i32 %54, i32 undef, i32 undef, i32 undef, i8 1, i32 4)  ; RawBufferStore(uav,index,elementOffset,value0,value1,value2,value3,mask,alignment)
  %56 = call %dx.types.Handle @dx.op.annotateHandle(i32 216, %dx.types.Handle %2, %dx.types.ResourceProperties { i32 36876, i32 16 })  ; AnnotateHandle(res,props)  resource: RWStructuredBuffer<stride=16, counter>
  %57 = call i32 @dx.op.bufferUpdateCounter(i32 70, %dx.types.Handle %56, i8 -1)  ; BufferUpdateCounter(uav,inc)
  %58 = call %dx.types.ResRet.v4f32 @dx.op.rawBufferVectorLoad.v4f32(i32 303, %dx.types.Handle %56, i32 %57, i32 0, i32 4)  ; RawBufferVectorLoad(buf,index,elementOffset,alignment)
  %59 = extractvalue %dx.types.ResRet.v4f32 %58, 0
  %60 = call %dx.types.Handle @dx.op.annotateHandle(i32 216, %dx.types.Handle %1, %dx.types.ResourceProperties { i32 36876, i32 16 })  ; AnnotateHandle(res,props)  resource: RWStructuredBuffer<stride=16, counter>
  %61 = call i32 @dx.op.bufferUpdateCounter(i32 70, %dx.types.Handle %60, i8 1)  ; BufferUpdateCounter(uav,inc)
  call void @dx.op.rawBufferVectorStore.v4f32(i32 304, %dx.types.Handle %60, i32 %61, i32 0, <4 x float> %59, i32 4)  ; RawBufferVectorStore(uav,index,elementOffset,value0,alignment)
  ret void
}

; Function Attrs: nounwind readnone
declare i32 @dx.op.loadInput.i32(i32, i32, i32, i8, i32) #0

; Function Attrs: nounwind readonly
declare %dx.types.ResRet.v4f32 @dx.op.rawBufferVectorLoad.v4f32(i32, %dx.types.Handle, i32, i32, i32) #1

; Function Attrs: nounwind readonly
declare i1 @dx.op.checkAccessFullyMapped.i32(i32, i32) #1

; Function Attrs: nounwind
declare void @dx.op.rawBufferVectorStore.v4f32(i32, %dx.types.Handle, i32, i32, <4 x float>, i32) #2

; Function Attrs: nounwind
declare void @dx.op.rawBufferStore.i32(i32, %dx.types.Handle, i32, i32, i32, i32, i32, i32, i8, i32) #2

; Function Attrs: nounwind
declare i32 @dx.op.bufferUpdateCounter(i32, %dx.types.Handle, i8) #2

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
!dx.viewIdState = !{!13}
!dx.entryPoints = !{!14}

!0 = !{!"dxcoob 1.9.2609.5 (01b62ad47)"}
!1 = !{i32 1, i32 9}
!2 = !{!"vs", i32 6, i32 9}
!3 = !{!4, !8, null, null}
!4 = !{!5, !6}
!5 = !{i32 0, %struct.ByteAddressBuffer* undef, !"", i32 0, i32 1, i32 1, i32 11, i32 0, null}
!6 = !{i32 1, %"class.StructuredBuffer<vector<float, 4> >"* undef, !"", i32 0, i32 2, i32 1, i32 12, i32 0, !7}
!7 = !{i32 1, i32 16}
!8 = !{!9, !10, !11, !12}
!9 = !{i32 0, %struct.RWByteAddressBuffer* undef, !"", i32 0, i32 1, i32 1, i32 11, i1 false, i1 false, i1 false, null}
!10 = !{i32 1, %"class.RWStructuredBuffer<vector<float, 4> >"* undef, !"", i32 0, i32 2, i32 1, i32 12, i1 false, i1 false, i1 false, !7}
!11 = !{i32 2, %"class.ConsumeStructuredBuffer<vector<float, 4> >"* undef, !"", i32 0, i32 4, i32 1, i32 12, i1 false, i1 true, i1 false, !7}
!12 = !{i32 3, %"class.AppendStructuredBuffer<vector<float, 4> >"* undef, !"", i32 0, i32 5, i32 1, i32 12, i1 false, i1 true, i1 false, !7}
!13 = !{[2 x i32] [i32 9, i32 0]}
!14 = !{void ()* @main, !"main", !15, !3, !20}
!15 = !{!16, null, null}
!16 = !{!17}
!17 = !{i32 0, !"IX", i8 5, i8 0, !18, i8 0, i32 3, i8 1, i32 0, i8 0, !19}
!18 = !{i32 0, i32 1, i32 2}
!19 = !{i32 3, i32 1}
!20 = !{i32 0, i64 8590004240}

