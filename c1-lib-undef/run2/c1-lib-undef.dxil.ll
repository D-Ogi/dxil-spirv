; shader hash: 6b529c57f6b3d51bb140c935501bba11
;
; Buffer Definitions:
;
;
; Resource Bindings:
;
; Name                                 Type  Format         Dim      ID      HLSL Bind  Count
; ------------------------------ ---------- ------- ----------- ------- -------------- ------
;
target datalayout = "e-m:e-p:32:32-i1:32-i8:32-i16:32-i32:32-i64:64-f16:32-f32:32-f64:64-n8:16:32:64"
target triple = "dxil-ms-dx"

%class.matrix.float.4.4 = type { [4 x <4 x float>] }

declare void @"\01?GetMat@@YAXAIAV?$matrix@M$03$03@@@Z"(%class.matrix.float.4.4* dereferenceable(64))

define void @test() {
  %1 = call i32 @dx.op.loadInput.i32(i32 4, i32 0, i32 0, i8 0, i32 undef)  ; LoadInput(inputSigId,rowIndex,colIndex,gsVertexAxis)
  %2 = alloca [16 x float], align 4
  %3 = alloca <16 x float>, align 4
  %4 = bitcast <16 x float>* %3 to %class.matrix.float.4.4*
  call void @"\01?GetMat@@YAXAIAV?$matrix@M$03$03@@@Z"(%class.matrix.float.4.4* dereferenceable(64) %4) #1
  %5 = shl i32 %1, 2
  %6 = or i32 %5, 1
  %7 = or i32 %5, 2
  %8 = or i32 %5, 3
  %9 = load <16 x float>, <16 x float>* %3, align 4
  %10 = extractelement <16 x float> %9, i64 0
  %11 = getelementptr [16 x float], [16 x float]* %2, i32 0, i32 0
  store float %10, float* %11, align 4
  %12 = extractelement <16 x float> %9, i64 1
  %13 = getelementptr [16 x float], [16 x float]* %2, i32 0, i32 1
  store float %12, float* %13, align 4
  %14 = extractelement <16 x float> %9, i64 2
  %15 = getelementptr [16 x float], [16 x float]* %2, i32 0, i32 2
  store float %14, float* %15, align 4
  %16 = extractelement <16 x float> %9, i64 3
  %17 = getelementptr [16 x float], [16 x float]* %2, i32 0, i32 3
  store float %16, float* %17, align 4
  %18 = extractelement <16 x float> %9, i64 4
  %19 = getelementptr [16 x float], [16 x float]* %2, i32 0, i32 4
  store float %18, float* %19, align 4
  %20 = extractelement <16 x float> %9, i64 5
  %21 = getelementptr [16 x float], [16 x float]* %2, i32 0, i32 5
  store float %20, float* %21, align 4
  %22 = extractelement <16 x float> %9, i64 6
  %23 = getelementptr [16 x float], [16 x float]* %2, i32 0, i32 6
  store float %22, float* %23, align 4
  %24 = extractelement <16 x float> %9, i64 7
  %25 = getelementptr [16 x float], [16 x float]* %2, i32 0, i32 7
  store float %24, float* %25, align 4
  %26 = extractelement <16 x float> %9, i64 8
  %27 = getelementptr [16 x float], [16 x float]* %2, i32 0, i32 8
  store float %26, float* %27, align 4
  %28 = extractelement <16 x float> %9, i64 9
  %29 = getelementptr [16 x float], [16 x float]* %2, i32 0, i32 9
  store float %28, float* %29, align 4
  %30 = extractelement <16 x float> %9, i64 10
  %31 = getelementptr [16 x float], [16 x float]* %2, i32 0, i32 10
  store float %30, float* %31, align 4
  %32 = extractelement <16 x float> %9, i64 11
  %33 = getelementptr [16 x float], [16 x float]* %2, i32 0, i32 11
  store float %32, float* %33, align 4
  %34 = extractelement <16 x float> %9, i64 12
  %35 = getelementptr [16 x float], [16 x float]* %2, i32 0, i32 12
  store float %34, float* %35, align 4
  %36 = extractelement <16 x float> %9, i64 13
  %37 = getelementptr [16 x float], [16 x float]* %2, i32 0, i32 13
  store float %36, float* %37, align 4
  %38 = extractelement <16 x float> %9, i64 14
  %39 = getelementptr [16 x float], [16 x float]* %2, i32 0, i32 14
  store float %38, float* %39, align 4
  %40 = extractelement <16 x float> %9, i64 15
  %41 = getelementptr [16 x float], [16 x float]* %2, i32 0, i32 15
  store float %40, float* %41, align 4
  %42 = getelementptr [16 x float], [16 x float]* %2, i32 0, i32 %5
  %43 = load float, float* %42, align 4
  %44 = getelementptr [16 x float], [16 x float]* %2, i32 0, i32 %6
  %45 = load float, float* %44, align 4
  %46 = getelementptr [16 x float], [16 x float]* %2, i32 0, i32 %7
  %47 = load float, float* %46, align 4
  %48 = getelementptr [16 x float], [16 x float]* %2, i32 0, i32 %8
  %49 = load float, float* %48, align 4
  call void @dx.op.storeOutput.f32(i32 5, i32 0, i32 0, i8 0, float %43)  ; StoreOutput(outputSigId,rowIndex,colIndex,value)
  call void @dx.op.storeOutput.f32(i32 5, i32 0, i32 0, i8 1, float %45)  ; StoreOutput(outputSigId,rowIndex,colIndex,value)
  call void @dx.op.storeOutput.f32(i32 5, i32 0, i32 0, i8 2, float %47)  ; StoreOutput(outputSigId,rowIndex,colIndex,value)
  call void @dx.op.storeOutput.f32(i32 5, i32 0, i32 0, i8 3, float %49)  ; StoreOutput(outputSigId,rowIndex,colIndex,value)
  ret void
}

; Function Attrs: nounwind readnone
declare i32 @dx.op.loadInput.i32(i32, i32, i32, i8, i32) #0

; Function Attrs: nounwind
declare void @dx.op.storeOutput.f32(i32, i32, i32, i8, float) #1

attributes #0 = { nounwind readnone }
attributes #1 = { nounwind }

!llvm.ident = !{!0}
!dx.version = !{!1}
!dx.valver = !{!2}
!dx.shaderModel = !{!3}
!dx.typeAnnotations = !{!4}
!dx.entryPoints = !{!13, !16}

!0 = !{!"dxcoob 1.9.2609.5 (01b62ad47)"}
!1 = !{i32 1, i32 3}
!2 = !{i32 1, i32 9}
!3 = !{!"lib", i32 6, i32 3}
!4 = !{i32 1, void (%class.matrix.float.4.4*)* @"\01?GetMat@@YAXAIAV?$matrix@M$03$03@@@Z", !5, void ()* @test, !11}
!5 = !{!6, !8}
!6 = !{i32 1, !7, !7}
!7 = !{}
!8 = !{i32 1, !9, !7}
!9 = !{i32 2, !10, i32 7, i32 9}
!10 = !{i32 4, i32 4, i32 1}
!11 = !{!12}
!12 = !{i32 0, !7, !7}
!13 = !{null, !"", null, null, !14}
!14 = !{i32 5, !15}
!15 = !{i32 11}
!16 = !{void ()* @test, !"test", !17, null, !23}
!17 = !{!18, !21, null}
!18 = !{!19}
!19 = !{i32 0, !"I", i8 5, i8 0, !20, i8 1, i32 1, i8 1, i32 0, i8 0, null}
!20 = !{i32 0}
!21 = !{!22}
!22 = !{i32 0, !"SV_Target", i8 9, i8 16, !20, i8 0, i32 1, i8 4, i32 0, i8 0, null}
!23 = !{i32 8, i32 0, i32 5, !20}

