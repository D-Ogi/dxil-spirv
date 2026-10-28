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
; SV_Position              0   xyzw        0      POS   float   xyzw
;
; shader hash: 1911bb08edee96df19e5567459264eae
;
; Pipeline Runtime Information: 
;
;PSVRuntimeInfo:
; Mesh Shader
; MeshOutputTopology=triangle
; NumThreads=(3,1,1)
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
; EntryFunctionName: ms
;
;
; Vertex Output signature:
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
; Number of inputs: 0, outputs: 4, primitive outputs: 0
; Outputs dependent on ViewId: {  }
; Primitive Outputs dependent on ViewId: {  }
; Inputs contributing to computation of Outputs:
; Inputs contributing to computation of Primitive Outputs:
;
target datalayout = "e-m:e-p:32:32-i1:32-i8:32-i16:32-i32:32-i64:64-f16:32-f32:32-f64:64-n8:16:32:64"
target triple = "dxil-ms-dx"

%dx.types.Handle = type { i8* }
%dx.types.ResBind = type { i32, i32, i32, i8 }
%dx.types.ResourceProperties = type { i32, i32 }
%dx.types.CBufRet.f32 = type { float, float, float, float }
%"$Globals" = type { <4 x float> }

@dx.nothing.a = internal constant [1 x i32] zeroinitializer

define void @ms() {
  %1 = call %dx.types.Handle @dx.op.createHandleFromBinding(i32 217, %dx.types.ResBind { i32 0, i32 0, i32 0, i8 2 }, i32 0, i1 false)  ; CreateHandleFromBinding(bind,index,nonUniformIndex)
  %2 = call %dx.types.Handle @dx.op.annotateHandle(i32 216, %dx.types.Handle %1, %dx.types.ResourceProperties { i32 13, i32 16 })  ; AnnotateHandle(res,props)  resource: CBuffer
  %3 = call i32 @dx.op.flattenedThreadIdInGroup.i32(i32 96)  ; FlattenedThreadIdInGroup()
  %4 = call %dx.types.CBufRet.f32 @dx.op.cbufferLoadLegacy.f32(i32 59, %dx.types.Handle %2, i32 0)  ; CBufferLoadLegacy(handle,regIndex)
  %5 = extractvalue %dx.types.CBufRet.f32 %4, 0
  %6 = extractvalue %dx.types.CBufRet.f32 %4, 1
  %7 = extractvalue %dx.types.CBufRet.f32 %4, 2
  %8 = extractvalue %dx.types.CBufRet.f32 %4, 3
  %9 = call i1 @dx.op.isHelperLane.i1(i32 221)  ; IsHelperLane()
  %10 = uitofp i1 %9 to float
  %11 = fadd fast float %5, %10
  %12 = fadd fast float %6, %10
  %13 = fadd fast float %7, %10
  %14 = fadd fast float %8, %10
  %15 = load i32, i32* getelementptr inbounds ([1 x i32], [1 x i32]* @dx.nothing.a, i32 0, i32 0)
  call void @dx.op.setMeshOutputCounts(i32 168, i32 3, i32 1)  ; SetMeshOutputCounts(numVertices,numPrimitives)
  %16 = icmp eq i32 %3, 0
  %17 = icmp ne i1 %16, false
  %18 = icmp ne i1 %17, false
  br i1 %18, label %19, label %21

; <label>:19                                      ; preds = %0
  %20 = load i32, i32* getelementptr inbounds ([1 x i32], [1 x i32]* @dx.nothing.a, i32 0, i32 0)
  call void @dx.op.emitIndices(i32 169, i32 0, i32 0, i32 1, i32 2)  ; EmitIndices(PrimitiveIndex,VertexIndex0,VertexIndex1,VertexIndex2)
  br label %21

; <label>:21                                      ; preds = %19, %0
  %22 = load i32, i32* getelementptr inbounds ([1 x i32], [1 x i32]* @dx.nothing.a, i32 0, i32 0)
  call void @dx.op.storeVertexOutput.f32(i32 171, i32 0, i32 0, i8 0, float %11, i32 %3)  ; StoreVertexOutput(outputSigId,rowIndex,colIndex,value,vertexIndex)
  call void @dx.op.storeVertexOutput.f32(i32 171, i32 0, i32 0, i8 1, float %12, i32 %3)  ; StoreVertexOutput(outputSigId,rowIndex,colIndex,value,vertexIndex)
  call void @dx.op.storeVertexOutput.f32(i32 171, i32 0, i32 0, i8 2, float %13, i32 %3)  ; StoreVertexOutput(outputSigId,rowIndex,colIndex,value,vertexIndex)
  call void @dx.op.storeVertexOutput.f32(i32 171, i32 0, i32 0, i8 3, float %14, i32 %3)  ; StoreVertexOutput(outputSigId,rowIndex,colIndex,value,vertexIndex)
  %23 = load i32, i32* getelementptr inbounds ([1 x i32], [1 x i32]* @dx.nothing.a, i32 0, i32 0)
  ret void
}

; Function Attrs: nounwind
declare void @dx.op.emitIndices(i32, i32, i32, i32, i32) #0

; Function Attrs: nounwind readnone
declare i32 @dx.op.flattenedThreadIdInGroup.i32(i32) #1

; Function Attrs: nounwind
declare void @dx.op.storeVertexOutput.f32(i32, i32, i32, i8, float, i32) #0

; Function Attrs: nounwind readonly
declare i1 @dx.op.isHelperLane.i1(i32) #2

; Function Attrs: nounwind
declare void @dx.op.setMeshOutputCounts(i32, i32, i32) #0

; Function Attrs: nounwind readonly
declare %dx.types.CBufRet.f32 @dx.op.cbufferLoadLegacy.f32(i32, %dx.types.Handle, i32) #2

; Function Attrs: nounwind readnone
declare %dx.types.Handle @dx.op.annotateHandle(i32, %dx.types.Handle, %dx.types.ResourceProperties) #1

; Function Attrs: nounwind readnone
declare %dx.types.Handle @dx.op.createHandleFromBinding(i32, %dx.types.ResBind, i32, i1) #1

attributes #0 = { nounwind }
attributes #1 = { nounwind readnone }
attributes #2 = { nounwind readonly }

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
!3 = !{!"ms", i32 6, i32 6}
!4 = !{null, null, !5, null}
!5 = !{!6}
!6 = !{i32 0, %"$Globals"* undef, !"", i32 0, i32 0, i32 1, i32 16, null}
!7 = !{[3 x i32] [i32 0, i32 4, i32 0]}
!8 = !{void ()* @ms, !"ms", !9, !4, !14}
!9 = !{null, !10, null}
!10 = !{!11}
!11 = !{i32 0, !"SV_Position", i8 9, i8 3, !12, i8 4, i32 1, i8 4, i32 0, i8 0, !13}
!12 = !{i32 0}
!13 = !{i32 3, i32 15}
!14 = !{i32 0, i64 1, i32 9, !15}
!15 = !{!16, i32 3, i32 1, i32 2, i32 0}
!16 = !{i32 3, i32 1, i32 1}

