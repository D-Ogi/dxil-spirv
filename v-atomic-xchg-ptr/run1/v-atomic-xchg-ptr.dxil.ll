;
; Note: shader requires additional functionality:
;       64-Bit integer
;       64-bit Atomics on Group Shared
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
; shader hash: 649f955591212d059a0036f7a5c99028
;
; Pipeline Runtime Information: 
;
;PSVRuntimeInfo:
; Compute Shader
; NumThreads=(1,1,1)
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
; EntryFunctionName: CSMain
;
;
; Buffer Definitions:
;
; Resource bind info for output
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
; output                                UAV  struct         r/w      U0             u0     1
;
target datalayout = "e-m:e-p:32:32-i1:32-i8:32-i16:32-i32:32-i64:64-f16:32-f32:32-f64:64-n8:16:32:64"
target triple = "dxil-ms-dx"

%dx.types.Handle = type { i8* }
%dx.types.ResBind = type { i32, i32, i32, i8 }
%dx.types.ResourceProperties = type { i32, i32 }
%"class.RWStructuredBuffer<vector<float, 4> >" = type { <4 x float> }

@"\01?resF@@3PAMA" = external addrspace(3) global [256 x float], align 4
@"\01?resI@@3PAHA" = external addrspace(3) global [256 x i32], align 4
@"\01?resI64@@3PA_JA" = external addrspace(3) global [256 x i64], align 8

define void @CSMain() {
  %1 = call %dx.types.Handle @dx.op.createHandleFromBinding(i32 217, %dx.types.ResBind { i32 0, i32 0, i32 0, i8 1 }, i32 0, i1 false)  ; CreateHandleFromBinding(bind,index,nonUniformIndex)
  %2 = call i32 @dx.op.threadIdInGroup.i32(i32 95, i32 0)  ; ThreadIdInGroup(component)
  %3 = call i32 @dx.op.threadIdInGroup.i32(i32 95, i32 1)  ; ThreadIdInGroup(component)
  %4 = call i32 @dx.op.threadIdInGroup.i32(i32 95, i32 2)  ; ThreadIdInGroup(component)
  %5 = call i32 @dx.op.flattenedThreadIdInGroup.i32(i32 96)  ; FlattenedThreadIdInGroup()
  %6 = sub i32 %3, %4
  %7 = uitofp i32 %6 to float
  %8 = udiv i32 %3, %4
  %9 = zext i32 %3 to i64
  %10 = zext i32 %4 to i64
  %11 = mul nuw i64 %10, %9
  %12 = getelementptr [256 x float], [256 x float] addrspace(3)* @"\01?resF@@3PAMA", i32 0, i32 %2
  %13 = bitcast float %7 to i32
  %14 = bitcast float addrspace(3)* %12 to i32 addrspace(3)*
  %15 = atomicrmw xchg i32 addrspace(3)* %14, i32 %13 seq_cst
  %16 = getelementptr [256 x i32], [256 x i32] addrspace(3)* @"\01?resI@@3PAHA", i32 0, i32 %2
  %17 = atomicrmw xchg i32 addrspace(3)* %16, i32 %8 seq_cst
  %18 = getelementptr [256 x i64], [256 x i64] addrspace(3)* @"\01?resI64@@3PA_JA", i32 0, i32 %2
  %19 = atomicrmw xchg i64 addrspace(3)* %18, i64 %11 seq_cst
  %20 = sitofp i32 %8 to float
  %21 = bitcast float %20 to i32
  %22 = atomicrmw xchg i32 addrspace(3)* %14, i32 %21 seq_cst
  %23 = atomicrmw xchg i32 addrspace(3)* %14, i32 %13 seq_cst
  %24 = bitcast i32 %23 to float
  %25 = fptosi float %24 to i32
  %26 = atomicrmw xchg i32 addrspace(3)* %14, i32 %21 seq_cst
  %27 = fptoui float %7 to i32
  %28 = atomicrmw xchg i32 addrspace(3)* %16, i32 %27 seq_cst
  %29 = fptosi float %7 to i64
  %30 = atomicrmw xchg i64 addrspace(3)* %18, i64 %29 seq_cst
  %31 = sitofp i64 %30 to float
  %32 = bitcast float %31 to i32
  %33 = cmpxchg i32 addrspace(3)* %14, i32 %13, i32 %32 seq_cst seq_cst
  %34 = sitofp i32 %25 to float
  %35 = bitcast float %34 to i32
  %36 = cmpxchg i32 addrspace(3)* %14, i32 %21, i32 %35 seq_cst seq_cst
  %37 = cmpxchg i32 addrspace(3)* %14, i32 %13, i32 %35 seq_cst seq_cst
  %38 = cmpxchg i32 addrspace(3)* %14, i32 %21, i32 %32 seq_cst seq_cst
  %39 = cmpxchg i32 addrspace(3)* %14, i32 %13, i32 %32 seq_cst seq_cst
  %40 = cmpxchg i32 addrspace(3)* %14, i32 %21, i32 %35 seq_cst seq_cst
  %41 = cmpxchg i32 addrspace(3)* %14, i32 %13, i32 %35 seq_cst seq_cst
  %42 = cmpxchg i32 addrspace(3)* %14, i32 %21, i32 %32 seq_cst seq_cst
  %43 = atomicrmw xchg i32 addrspace(3)* %14, i32 1065353216 seq_cst
  %44 = atomicrmw xchg i32 addrspace(3)* %14, i32 1073741824 seq_cst
  %45 = cmpxchg i32 addrspace(3)* %14, i32 1065353216, i32 1073741824 seq_cst seq_cst
  %46 = cmpxchg i32 addrspace(3)* %14, i32 %21, i32 1073741824 seq_cst seq_cst
  %47 = cmpxchg i32 addrspace(3)* %14, i32 1065353216, i32 %32 seq_cst seq_cst
  %48 = cmpxchg i32 addrspace(3)* %14, i32 1065353216, i32 1073741824 seq_cst seq_cst
  %49 = cmpxchg i32 addrspace(3)* %14, i32 1065353216, i32 %35 seq_cst seq_cst
  %50 = cmpxchg i32 addrspace(3)* %14, i32 %35, i32 1073741824 seq_cst seq_cst
  %51 = extractvalue { i32, i1 } %50, 0
  %52 = bitcast i32 %51 to float
  %53 = call %dx.types.Handle @dx.op.annotateHandle(i32 216, %dx.types.Handle %1, %dx.types.ResourceProperties { i32 4108, i32 16 })  ; AnnotateHandle(res,props)  resource: RWStructuredBuffer<stride=16>
  call void @dx.op.rawBufferStore.f32(i32 140, %dx.types.Handle %53, i32 %5, i32 0, float %52, float %52, float %52, float %52, i8 15, i32 4)  ; RawBufferStore(uav,index,elementOffset,value0,value1,value2,value3,mask,alignment)
  ret void
}

; Function Attrs: nounwind readnone
declare i32 @dx.op.threadIdInGroup.i32(i32, i32) #0

; Function Attrs: nounwind readnone
declare i32 @dx.op.flattenedThreadIdInGroup.i32(i32) #0

; Function Attrs: nounwind
declare void @dx.op.rawBufferStore.f32(i32, %dx.types.Handle, i32, i32, float, float, float, float, i8, i32) #1

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
!dx.entryPoints = !{!8}

!0 = !{!"dxcoob 1.9.2609.5 (01b62ad47)"}
!1 = !{i32 1, i32 6}
!2 = !{i32 1, i32 9}
!3 = !{!"cs", i32 6, i32 6}
!4 = !{null, !5, null, null}
!5 = !{!6}
!6 = !{i32 0, %"class.RWStructuredBuffer<vector<float, 4> >"* undef, !"", i32 0, i32 0, i32 1, i32 12, i1 false, i1 false, i1 false, !7}
!7 = !{i32 1, i32 16}
!8 = !{void ()* @CSMain, !"CSMain", null, !4, !9}
!9 = !{i32 0, i64 269484048, i32 4, !10}
!10 = !{i32 1, i32 1, i32 1}

