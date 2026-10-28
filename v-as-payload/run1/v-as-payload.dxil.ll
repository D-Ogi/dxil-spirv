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
; shader hash: 9107ed8d09da4c95da2b8a5663a374ab
;
; Pipeline Runtime Information: 
;
;PSVRuntimeInfo:
; Amplification Shader
; NumThreads=(4,1,1)
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
; cbuffer $Globals
; {
;
;   struct hostlayout.$Globals
;   {
;
;       row_major bool2x2 row_mat_array[2];           ; Offset:    0
;       int i;                                        ; Offset:   56
;       int j;                                        ; Offset:   60
;   
;   } $Globals;                                       ; Offset:    0 Size:    64
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
target datalayout = "e-m:e-p:32:32-i1:32-i8:32-i16:32-i32:32-i64:64-f16:32-f32:32-f64:64-n8:16:32:64"
target triple = "dxil-ms-dx"

%struct.MeshPayload.0 = type { [4 x i32], [4 x i32] }
%dx.types.Handle = type { i8* }
%dx.types.CBufRet.i32 = type { i32, i32, i32, i32 }
%"hostlayout.$Globals" = type { [2 x [2 x <2 x i32>]], i32, i32 }

@.hca = internal unnamed_addr constant [2 x i32] [i32 1, i32 3]
@.hca.2 = internal unnamed_addr constant [2 x i32] [i32 0, i32 2]
@"\01?gs@@3PAUGSStruct@@A.2.1.1dim" = addrspace(3) global [4 x %struct.MeshPayload.0] undef
@"\01?gs@@3PAUGSStruct@@A.1.v.1dim" = addrspace(3) global [8 x i32] undef, align 4
@"\01?gs@@3PAUGSStruct@@A.0.v.v.1dim" = addrspace(3) global [8 x i32] zeroinitializer, align 16

define void @main() {
  %1 = call %dx.types.Handle @dx.op.createHandle(i32 57, i8 2, i32 0, i32 0, i1 false)  ; CreateHandle(resourceClass,rangeId,index,nonUniformIndex)
  %2 = call i32 @dx.op.flattenedThreadIdInGroup.i32(i32 96)  ; FlattenedThreadIdInGroup()
  %3 = alloca [4 x i32], align 4
  %4 = alloca [4 x i32], align 4
  %5 = alloca [4 x i32], align 4
  %6 = alloca [4 x i32], align 4
  %7 = alloca [2 x i32], align 4
  %8 = alloca [3 x i32], align 4
  %9 = icmp ne i32 %2, 0
  %10 = call %dx.types.CBufRet.i32 @dx.op.cbufferLoadLegacy.i32(i32 59, %dx.types.Handle %1, i32 3)  ; CBufferLoadLegacy(handle,regIndex)
  %11 = extractvalue %dx.types.CBufRet.i32 %10, 2
  %12 = extractvalue %dx.types.CBufRet.i32 %10, 3
  %13 = lshr i32 %2, 1
  %14 = add nuw i32 %13, 2
  %15 = and i32 %2, 1
  %16 = zext i1 %9 to i32
  %17 = getelementptr [2 x i32], [2 x i32]* %7, i32 0, i32 0
  store i32 %13, i32* %17, align 4
  %18 = getelementptr [2 x i32], [2 x i32]* %7, i32 0, i32 1
  store i32 %14, i32* %18, align 4
  %19 = getelementptr [2 x i32], [2 x i32]* %7, i32 0, i32 %15
  %20 = load i32, i32* %19, align 4
  %21 = mul i32 %12, 2
  %22 = add i32 %11, %21
  %23 = getelementptr [4 x %struct.MeshPayload.0], [4 x %struct.MeshPayload.0] addrspace(3)* @"\01?gs@@3PAUGSStruct@@A.2.1.1dim", i32 0, i32 %22, i32 1, i32 %20
  store i32 %16, i32 addrspace(3)* %23, align 4, !tbaa !11
  %24 = call %dx.types.CBufRet.i32 @dx.op.cbufferLoadLegacy.i32(i32 59, %dx.types.Handle %1, i32 3)  ; CBufferLoadLegacy(handle,regIndex)
  %25 = extractvalue %dx.types.CBufRet.i32 %24, 3
  %26 = mul i32 %25, 4
  %27 = add i32 %2, %26
  %28 = getelementptr [8 x i32], [8 x i32] addrspace(3)* @"\01?gs@@3PAUGSStruct@@A.1.v.1dim", i32 0, i32 %27
  store i32 %2, i32 addrspace(3)* %28, align 4, !tbaa !15
  %29 = call %dx.types.CBufRet.i32 @dx.op.cbufferLoadLegacy.i32(i32 59, %dx.types.Handle %1, i32 3)  ; CBufferLoadLegacy(handle,regIndex)
  %30 = extractvalue %dx.types.CBufRet.i32 %29, 2
  %31 = extractvalue %dx.types.CBufRet.i32 %29, 3
  %32 = mul i32 %31, 2
  %33 = add i32 %30, %32
  %34 = getelementptr [4 x %struct.MeshPayload.0], [4 x %struct.MeshPayload.0] addrspace(3)* @"\01?gs@@3PAUGSStruct@@A.2.1.1dim", i32 0, i32 %33, i32 1, i32 0
  %35 = load i32, i32 addrspace(3)* %34, align 16
  %36 = mul i32 %31, 2
  %37 = add i32 %30, %36
  %38 = getelementptr [4 x %struct.MeshPayload.0], [4 x %struct.MeshPayload.0] addrspace(3)* @"\01?gs@@3PAUGSStruct@@A.2.1.1dim", i32 0, i32 %37, i32 1, i32 1
  %39 = load i32, i32 addrspace(3)* %38, align 4
  %40 = mul i32 %31, 2
  %41 = add i32 %30, %40
  %42 = getelementptr [4 x %struct.MeshPayload.0], [4 x %struct.MeshPayload.0] addrspace(3)* @"\01?gs@@3PAUGSStruct@@A.2.1.1dim", i32 0, i32 %41, i32 1, i32 3
  %43 = load i32, i32 addrspace(3)* %42, align 4
  %44 = icmp ne i32 %35, 0
  %45 = icmp ne i32 %39, 0
  %46 = icmp ne i32 %43, 0
  %47 = zext i1 %44 to i32
  %48 = zext i1 %45 to i32
  %49 = zext i1 %46 to i32
  %50 = call %dx.types.CBufRet.i32 @dx.op.cbufferLoadLegacy.i32(i32 59, %dx.types.Handle %1, i32 3)  ; CBufferLoadLegacy(handle,regIndex)
  %51 = extractvalue %dx.types.CBufRet.i32 %50, 2
  %52 = extractvalue %dx.types.CBufRet.i32 %50, 3
  %53 = mul i32 %52, 4
  %54 = add i32 0, %53
  %55 = getelementptr [8 x i32], [8 x i32] addrspace(3)* @"\01?gs@@3PAUGSStruct@@A.1.v.1dim", i32 0, i32 %54
  %56 = load i32, i32 addrspace(3)* %55, align 4
  %57 = mul i32 %52, 4
  %58 = add i32 1, %57
  %59 = getelementptr [8 x i32], [8 x i32] addrspace(3)* @"\01?gs@@3PAUGSStruct@@A.1.v.1dim", i32 0, i32 %58
  %60 = load i32, i32 addrspace(3)* %59, align 4
  %61 = mul i32 %52, 4
  %62 = add i32 2, %61
  %63 = getelementptr [8 x i32], [8 x i32] addrspace(3)* @"\01?gs@@3PAUGSStruct@@A.1.v.1dim", i32 0, i32 %62
  %64 = load i32, i32 addrspace(3)* %63, align 4
  %65 = mul i32 %52, 4
  %66 = add i32 3, %65
  %67 = getelementptr [8 x i32], [8 x i32] addrspace(3)* @"\01?gs@@3PAUGSStruct@@A.1.v.1dim", i32 0, i32 %66
  %68 = load i32, i32 addrspace(3)* %67, align 4
  %69 = icmp ne i32 %56, 0
  %70 = icmp ne i32 %60, 0
  %71 = icmp ne i32 %64, 0
  %72 = icmp ne i32 %68, 0
  %73 = zext i1 %69 to i32
  %74 = zext i1 %71 to i32
  %75 = zext i1 %70 to i32
  %76 = zext i1 %72 to i32
  %77 = mul i32 %52, 2
  %78 = add i32 %51, %77
  %79 = getelementptr [4 x %struct.MeshPayload.0], [4 x %struct.MeshPayload.0] addrspace(3)* @"\01?gs@@3PAUGSStruct@@A.2.1.1dim", i32 0, i32 %78, i32 1, i32 0
  store i32 %73, i32 addrspace(3)* %79, align 16
  %80 = mul i32 %52, 2
  %81 = add i32 %51, %80
  %82 = getelementptr [4 x %struct.MeshPayload.0], [4 x %struct.MeshPayload.0] addrspace(3)* @"\01?gs@@3PAUGSStruct@@A.2.1.1dim", i32 0, i32 %81, i32 1, i32 1
  store i32 %74, i32 addrspace(3)* %82, align 4
  %83 = mul i32 %52, 2
  %84 = add i32 %51, %83
  %85 = getelementptr [4 x %struct.MeshPayload.0], [4 x %struct.MeshPayload.0] addrspace(3)* @"\01?gs@@3PAUGSStruct@@A.2.1.1dim", i32 0, i32 %84, i32 1, i32 2
  store i32 %75, i32 addrspace(3)* %85, align 8
  %86 = mul i32 %52, 2
  %87 = add i32 %51, %86
  %88 = getelementptr [4 x %struct.MeshPayload.0], [4 x %struct.MeshPayload.0] addrspace(3)* @"\01?gs@@3PAUGSStruct@@A.2.1.1dim", i32 0, i32 %87, i32 1, i32 3
  store i32 %76, i32 addrspace(3)* %88, align 4
  %89 = call %dx.types.CBufRet.i32 @dx.op.cbufferLoadLegacy.i32(i32 59, %dx.types.Handle %1, i32 3)  ; CBufferLoadLegacy(handle,regIndex)
  %90 = extractvalue %dx.types.CBufRet.i32 %89, 2
  %91 = extractvalue %dx.types.CBufRet.i32 %89, 3
  %92 = mul i32 %91, 2
  %93 = add i32 %90, %92
  %94 = getelementptr [4 x %struct.MeshPayload.0], [4 x %struct.MeshPayload.0] addrspace(3)* @"\01?gs@@3PAUGSStruct@@A.2.1.1dim", i32 0, i32 %93, i32 1, i32 1
  store i32 %49, i32 addrspace(3)* %94, align 4
  %95 = call %dx.types.CBufRet.i32 @dx.op.cbufferLoadLegacy.i32(i32 59, %dx.types.Handle %1, i32 3)  ; CBufferLoadLegacy(handle,regIndex)
  %96 = extractvalue %dx.types.CBufRet.i32 %95, 2
  %97 = extractvalue %dx.types.CBufRet.i32 %95, 3
  %98 = mul i32 %97, 2
  %99 = add i32 %96, %98
  %100 = getelementptr [4 x %struct.MeshPayload.0], [4 x %struct.MeshPayload.0] addrspace(3)* @"\01?gs@@3PAUGSStruct@@A.2.1.1dim", i32 0, i32 %99, i32 1, i32 0
  %101 = load i32, i32 addrspace(3)* %100, align 16
  %102 = icmp ne i32 %101, 0
  %103 = zext i1 %102 to i32
  %104 = or i32 %15, 2
  %105 = getelementptr [4 x i32], [4 x i32]* %6, i32 0, i32 0
  store i32 %47, i32* %105, align 4
  %106 = getelementptr [4 x i32], [4 x i32]* %6, i32 0, i32 1
  store i32 %48, i32* %106, align 4
  %107 = getelementptr [4 x i32], [4 x i32]* %6, i32 0, i32 2
  store i32 %103, i32* %107, align 4
  %108 = getelementptr [4 x i32], [4 x i32]* %6, i32 0, i32 3
  store i32 %49, i32* %108, align 4
  %109 = getelementptr [4 x i32], [4 x i32]* %6, i32 0, i32 %104
  %110 = load i32, i32* %109, align 4
  %111 = icmp ne i32 %110, 0
  %112 = call %dx.types.CBufRet.i32 @dx.op.cbufferLoadLegacy.i32(i32 59, %dx.types.Handle %1, i32 3)  ; CBufferLoadLegacy(handle,regIndex)
  %113 = extractvalue %dx.types.CBufRet.i32 %112, 2
  %114 = extractvalue %dx.types.CBufRet.i32 %112, 3
  %115 = zext i1 %111 to i32
  %116 = mul i32 %114, 2
  %117 = add i32 %113, %116
  %118 = getelementptr [4 x %struct.MeshPayload.0], [4 x %struct.MeshPayload.0] addrspace(3)* @"\01?gs@@3PAUGSStruct@@A.2.1.1dim", i32 0, i32 %117, i32 1, i32 %15
  store i32 %115, i32 addrspace(3)* %118, align 4
  %119 = call %dx.types.CBufRet.i32 @dx.op.cbufferLoadLegacy.i32(i32 59, %dx.types.Handle %1, i32 3)  ; CBufferLoadLegacy(handle,regIndex)
  %120 = extractvalue %dx.types.CBufRet.i32 %119, 2
  %121 = extractvalue %dx.types.CBufRet.i32 %119, 3
  %122 = mul i32 %121, 2
  %123 = add i32 %120, %122
  %124 = getelementptr [4 x %struct.MeshPayload.0], [4 x %struct.MeshPayload.0] addrspace(3)* @"\01?gs@@3PAUGSStruct@@A.2.1.1dim", i32 0, i32 %123, i32 1, i32 %15
  %125 = load i32, i32 addrspace(3)* %124, align 4
  %126 = icmp ne i32 %125, 0
  %127 = zext i1 %126 to i32
  %128 = getelementptr [4 x i32], [4 x i32]* %5, i32 0, i32 0
  %129 = getelementptr [4 x i32], [4 x i32]* %5, i32 0, i32 1
  %130 = getelementptr [4 x i32], [4 x i32]* %5, i32 0, i32 2
  %131 = getelementptr [4 x i32], [4 x i32]* %5, i32 0, i32 3
  store i32 %47, i32* %128, align 4
  store i32 %48, i32* %129, align 4
  store i32 %103, i32* %130, align 4
  store i32 %49, i32* %131, align 4
  %132 = getelementptr [4 x i32], [4 x i32]* %5, i32 0, i32 %104
  store i32 %127, i32* %132, align 4
  %133 = load i32, i32* %128, align 4
  %134 = load i32, i32* %129, align 4
  %135 = load i32, i32* %130, align 4
  %136 = load i32, i32* %131, align 4
  %137 = getelementptr [4 x i32], [4 x i32]* %4, i32 0, i32 0
  store i32 %133, i32* %137, align 4
  %138 = getelementptr [4 x i32], [4 x i32]* %4, i32 0, i32 1
  store i32 %134, i32* %138, align 4
  %139 = getelementptr [4 x i32], [4 x i32]* %4, i32 0, i32 2
  store i32 %135, i32* %139, align 4
  %140 = getelementptr [4 x i32], [4 x i32]* %4, i32 0, i32 3
  store i32 %136, i32* %140, align 4
  %141 = getelementptr [4 x i32], [4 x i32]* %4, i32 0, i32 %104
  %142 = load i32, i32* %141, align 4
  %143 = icmp ne i32 %142, 0
  %144 = call %dx.types.CBufRet.i32 @dx.op.cbufferLoadLegacy.i32(i32 59, %dx.types.Handle %1, i32 3)  ; CBufferLoadLegacy(handle,regIndex)
  %145 = extractvalue %dx.types.CBufRet.i32 %144, 2
  %146 = extractvalue %dx.types.CBufRet.i32 %144, 3
  %147 = zext i1 %143 to i32
  %148 = mul i32 %146, 2
  %149 = add i32 %145, %148
  %150 = getelementptr [4 x %struct.MeshPayload.0], [4 x %struct.MeshPayload.0] addrspace(3)* @"\01?gs@@3PAUGSStruct@@A.2.1.1dim", i32 0, i32 %149, i32 1, i32 %15
  store i32 %147, i32 addrspace(3)* %150, align 4
  %151 = mul i32 %146, 2
  %152 = add i32 %145, %151
  %153 = getelementptr [4 x %struct.MeshPayload.0], [4 x %struct.MeshPayload.0] addrspace(3)* @"\01?gs@@3PAUGSStruct@@A.2.1.1dim", i32 0, i32 %152, i32 1, i32 %104
  store i32 %147, i32 addrspace(3)* %153, align 4
  %154 = call %dx.types.CBufRet.i32 @dx.op.cbufferLoadLegacy.i32(i32 59, %dx.types.Handle %1, i32 3)  ; CBufferLoadLegacy(handle,regIndex)
  %155 = extractvalue %dx.types.CBufRet.i32 %154, 2
  %156 = extractvalue %dx.types.CBufRet.i32 %154, 3
  %157 = mul i32 %156, 2
  %158 = add i32 %155, %157
  %159 = getelementptr [4 x %struct.MeshPayload.0], [4 x %struct.MeshPayload.0] addrspace(3)* @"\01?gs@@3PAUGSStruct@@A.2.1.1dim", i32 0, i32 %158, i32 1, i32 %15
  %160 = load i32, i32 addrspace(3)* %159, align 4
  %161 = icmp ne i32 %160, 0
  %162 = zext i1 %161 to i32
  %163 = getelementptr [4 x i32], [4 x i32]* %3, i32 0, i32 0
  %164 = getelementptr [4 x i32], [4 x i32]* %3, i32 0, i32 1
  %165 = getelementptr [4 x i32], [4 x i32]* %3, i32 0, i32 2
  %166 = getelementptr [4 x i32], [4 x i32]* %3, i32 0, i32 3
  store i32 %133, i32* %163, align 4
  store i32 %134, i32* %164, align 4
  store i32 %135, i32* %165, align 4
  store i32 %136, i32* %166, align 4
  %167 = getelementptr [4 x i32], [4 x i32]* %3, i32 0, i32 %104
  store i32 %162, i32* %167, align 4
  %168 = load i32, i32* %164, align 4
  %169 = load i32, i32* %166, align 4
  %170 = icmp ne i32 %168, 0
  %171 = icmp ne i32 %169, 0
  %172 = call %dx.types.CBufRet.i32 @dx.op.cbufferLoadLegacy.i32(i32 59, %dx.types.Handle %1, i32 3)  ; CBufferLoadLegacy(handle,regIndex)
  %173 = extractvalue %dx.types.CBufRet.i32 %172, 2
  %174 = extractvalue %dx.types.CBufRet.i32 %172, 3
  %175 = zext i1 %170 to i32
  %176 = zext i1 %171 to i32
  %177 = mul i32 %174, 2
  %178 = add i32 %173, %177
  %179 = getelementptr [4 x %struct.MeshPayload.0], [4 x %struct.MeshPayload.0] addrspace(3)* @"\01?gs@@3PAUGSStruct@@A.2.1.1dim", i32 0, i32 %178, i32 1, i32 2
  store i32 %175, i32 addrspace(3)* %179, align 8
  %180 = mul i32 %174, 2
  %181 = add i32 %173, %180
  %182 = getelementptr [4 x %struct.MeshPayload.0], [4 x %struct.MeshPayload.0] addrspace(3)* @"\01?gs@@3PAUGSStruct@@A.2.1.1dim", i32 0, i32 %181, i32 1, i32 1
  store i32 %176, i32 addrspace(3)* %182, align 4
  %183 = call %dx.types.CBufRet.i32 @dx.op.cbufferLoadLegacy.i32(i32 59, %dx.types.Handle %1, i32 3)  ; CBufferLoadLegacy(handle,regIndex)
  %184 = extractvalue %dx.types.CBufRet.i32 %183, 2
  %185 = extractvalue %dx.types.CBufRet.i32 %183, 3
  %186 = mul i32 %185, 2
  %187 = add i32 %184, %186
  %188 = getelementptr [4 x %struct.MeshPayload.0], [4 x %struct.MeshPayload.0] addrspace(3)* @"\01?gs@@3PAUGSStruct@@A.2.1.1dim", i32 0, i32 %187, i32 1, i32 0
  %189 = load i32, i32 addrspace(3)* %188, align 16
  %190 = mul i32 %185, 2
  %191 = add i32 %184, %190
  %192 = getelementptr [4 x %struct.MeshPayload.0], [4 x %struct.MeshPayload.0] addrspace(3)* @"\01?gs@@3PAUGSStruct@@A.2.1.1dim", i32 0, i32 %191, i32 1, i32 3
  %193 = load i32, i32 addrspace(3)* %192, align 4
  %194 = mul i32 %185, 2
  %195 = add i32 %184, %194
  %196 = getelementptr [4 x %struct.MeshPayload.0], [4 x %struct.MeshPayload.0] addrspace(3)* @"\01?gs@@3PAUGSStruct@@A.2.1.1dim", i32 0, i32 %195, i32 1, i32 1
  %197 = load i32, i32 addrspace(3)* %196, align 4
  %198 = getelementptr inbounds [3 x i32], [3 x i32]* %8, i32 0, i32 0
  store i32 %189, i32* %198, align 4
  %199 = getelementptr inbounds [3 x i32], [3 x i32]* %8, i32 0, i32 1
  store i32 %193, i32* %199, align 4
  %200 = getelementptr inbounds [3 x i32], [3 x i32]* %8, i32 0, i32 2
  store i32 %197, i32* %200, align 4
  %201 = getelementptr [3 x i32], [3 x i32]* %8, i32 0, i32 %15
  %202 = load i32, i32* %201, align 4, !tbaa !11, !range !17
  %203 = call %dx.types.CBufRet.i32 @dx.op.cbufferLoadLegacy.i32(i32 59, %dx.types.Handle %1, i32 3)  ; CBufferLoadLegacy(handle,regIndex)
  %204 = extractvalue %dx.types.CBufRet.i32 %203, 3
  %205 = mul i32 %204, 4
  %206 = add i32 0, %205
  %207 = getelementptr [8 x i32], [8 x i32] addrspace(3)* @"\01?gs@@3PAUGSStruct@@A.1.v.1dim", i32 0, i32 %206
  %208 = load i32, i32 addrspace(3)* %207, align 4
  %209 = call %dx.types.CBufRet.i32 @dx.op.cbufferLoadLegacy.i32(i32 59, %dx.types.Handle %1, i32 3)  ; CBufferLoadLegacy(handle,regIndex)
  %210 = extractvalue %dx.types.CBufRet.i32 %209, 2
  %211 = extractvalue %dx.types.CBufRet.i32 %209, 3
  %212 = getelementptr [2 x i32], [2 x i32]* @.hca, i32 0, i32 %208
  %213 = load i32, i32* %212, align 4
  %214 = mul i32 %211, 2
  %215 = add i32 %210, %214
  %216 = getelementptr [4 x %struct.MeshPayload.0], [4 x %struct.MeshPayload.0] addrspace(3)* @"\01?gs@@3PAUGSStruct@@A.2.1.1dim", i32 0, i32 %215, i32 1, i32 %213
  store i32 %176, i32 addrspace(3)* %216, align 4, !tbaa !11
  %217 = call %dx.types.CBufRet.i32 @dx.op.cbufferLoadLegacy.i32(i32 59, %dx.types.Handle %1, i32 3)  ; CBufferLoadLegacy(handle,regIndex)
  %218 = extractvalue %dx.types.CBufRet.i32 %217, 2
  %219 = extractvalue %dx.types.CBufRet.i32 %217, 3
  %220 = getelementptr [2 x i32], [2 x i32]* @.hca.2, i32 0, i32 %208
  %221 = load i32, i32* %220, align 4
  %222 = mul i32 %219, 2
  %223 = add i32 %218, %222
  %224 = getelementptr [4 x %struct.MeshPayload.0], [4 x %struct.MeshPayload.0] addrspace(3)* @"\01?gs@@3PAUGSStruct@@A.2.1.1dim", i32 0, i32 %223, i32 1, i32 %221
  %225 = load i32, i32 addrspace(3)* %224, align 4, !tbaa !11, !range !17
  %226 = call %dx.types.CBufRet.i32 @dx.op.cbufferLoadLegacy.i32(i32 59, %dx.types.Handle %1, i32 3)  ; CBufferLoadLegacy(handle,regIndex)
  %227 = extractvalue %dx.types.CBufRet.i32 %226, 3
  %228 = mul i32 %227, 4
  %229 = add i32 0, %228
  %230 = getelementptr [8 x i32], [8 x i32] addrspace(3)* @"\01?gs@@3PAUGSStruct@@A.0.v.v.1dim", i32 0, i32 %229
  %231 = load i32, i32 addrspace(3)* %230, align 16
  %232 = mul i32 %227, 4
  %233 = add i32 1, %232
  %234 = getelementptr [8 x i32], [8 x i32] addrspace(3)* @"\01?gs@@3PAUGSStruct@@A.0.v.v.1dim", i32 0, i32 %233
  %235 = load i32, i32 addrspace(3)* %234, align 4
  %236 = icmp ne i32 %231, 0
  %237 = icmp ne i32 %235, 0
  %238 = zext i1 %236 to i32
  %239 = zext i1 %237 to i32
  %240 = sub nsw i32 0, %202
  %241 = and i32 %238, %240
  %242 = call i32 @dx.op.tertiary.i32(i32 48, i32 %225, i32 %239, i32 %241)  ; IMad(a,b,c)
  %243 = select i1 %236, i32 %168, i32 0
  %244 = call i32 @dx.op.tertiary.i32(i32 48, i32 %169, i32 %239, i32 %243)  ; IMad(a,b,c)
  %245 = call %dx.types.CBufRet.i32 @dx.op.cbufferLoadLegacy.i32(i32 59, %dx.types.Handle %1, i32 3)  ; CBufferLoadLegacy(handle,regIndex)
  %246 = extractvalue %dx.types.CBufRet.i32 %245, 2
  %247 = extractvalue %dx.types.CBufRet.i32 %245, 3
  %248 = mul i32 %247, 2
  %249 = add i32 %246, %248
  %250 = getelementptr [4 x %struct.MeshPayload.0], [4 x %struct.MeshPayload.0] addrspace(3)* @"\01?gs@@3PAUGSStruct@@A.2.1.1dim", i32 0, i32 %249, i32 0, i32 0
  store i32 %242, i32 addrspace(3)* %250, align 16
  %251 = mul i32 %247, 2
  %252 = add i32 %246, %251
  %253 = getelementptr [4 x %struct.MeshPayload.0], [4 x %struct.MeshPayload.0] addrspace(3)* @"\01?gs@@3PAUGSStruct@@A.2.1.1dim", i32 0, i32 %252, i32 0, i32 1
  store i32 %244, i32 addrspace(3)* %253, align 4
  %254 = mul i32 %247, 2
  %255 = add i32 %246, %254
  %256 = getelementptr [4 x %struct.MeshPayload.0], [4 x %struct.MeshPayload.0] addrspace(3)* @"\01?gs@@3PAUGSStruct@@A.2.1.1dim", i32 0, i32 %255, i32 0, i32 2
  store i32 %242, i32 addrspace(3)* %256, align 8
  %257 = mul i32 %247, 2
  %258 = add i32 %246, %257
  %259 = getelementptr [4 x %struct.MeshPayload.0], [4 x %struct.MeshPayload.0] addrspace(3)* @"\01?gs@@3PAUGSStruct@@A.2.1.1dim", i32 0, i32 %258, i32 0, i32 3
  store i32 %244, i32 addrspace(3)* %259, align 4
  %260 = call %dx.types.CBufRet.i32 @dx.op.cbufferLoadLegacy.i32(i32 59, %dx.types.Handle %1, i32 3)  ; CBufferLoadLegacy(handle,regIndex)
  %261 = extractvalue %dx.types.CBufRet.i32 %260, 2
  %262 = extractvalue %dx.types.CBufRet.i32 %260, 3
  %263 = mul i32 %262, 2
  %264 = add i32 %261, %263
  %265 = getelementptr [4 x %struct.MeshPayload.0], [4 x %struct.MeshPayload.0] addrspace(3)* @"\01?gs@@3PAUGSStruct@@A.2.1.1dim", i32 0, i32 %264
  call void @dx.op.dispatchMesh.struct.MeshPayload.0(i32 173, i32 1, i32 1, i32 1, %struct.MeshPayload.0 addrspace(3)* %265)  ; DispatchMesh(threadGroupCountX,threadGroupCountY,threadGroupCountZ,payload)
  ret void
}

; Function Attrs: nounwind readnone
declare i32 @dx.op.flattenedThreadIdInGroup.i32(i32) #0

; Function Attrs: nounwind readonly
declare %dx.types.CBufRet.i32 @dx.op.cbufferLoadLegacy.i32(i32, %dx.types.Handle, i32) #1

; Function Attrs: nounwind
declare void @dx.op.dispatchMesh.struct.MeshPayload.0(i32, i32, i32, i32, %struct.MeshPayload.0 addrspace(3)*) #2

; Function Attrs: nounwind readnone
declare i32 @dx.op.tertiary.i32(i32, i32, i32, i32) #0

; Function Attrs: nounwind readonly
declare %dx.types.Handle @dx.op.createHandle(i32, i8, i32, i32, i1) #1

attributes #0 = { nounwind readnone }
attributes #1 = { nounwind readonly }
attributes #2 = { nounwind }

!llvm.ident = !{!0}
!dx.version = !{!1}
!dx.valver = !{!2}
!dx.shaderModel = !{!3}
!dx.resources = !{!4}
!dx.entryPoints = !{!7}

!0 = !{!"dxcoob 1.9.2609.5 (01b62ad47)"}
!1 = !{i32 1, i32 5}
!2 = !{i32 1, i32 9}
!3 = !{!"as", i32 6, i32 5}
!4 = !{null, null, !5, null}
!5 = !{!6}
!6 = !{i32 0, %"hostlayout.$Globals"* undef, !"", i32 0, i32 0, i32 1, i32 64, null}
!7 = !{void ()* @main, !"main", null, !4, !8}
!8 = !{i32 10, !9}
!9 = !{!10, i32 32}
!10 = !{i32 4, i32 1, i32 1}
!11 = !{!12, !12, i64 0}
!12 = !{!"bool", !13, i64 0}
!13 = !{!"omnipotent char", !14, i64 0}
!14 = !{!"Simple C/C++ TBAA"}
!15 = !{!16, !16, i64 0}
!16 = !{!"int", !13, i64 0}
!17 = !{i32 0, i32 2}

