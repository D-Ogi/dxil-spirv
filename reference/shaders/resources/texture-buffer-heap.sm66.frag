#version 460
#extension GL_EXT_nonuniform_qualifier : require
#extension GL_EXT_samplerless_texture_functions : require

layout(set = 0, binding = 0) uniform usamplerBuffer _9[];

layout(location = 0) flat in uint I;
layout(location = 0) out vec4 SV_Target;

void main()
{
    uvec4 _22 = texelFetch(_9[I], int(0u));
    SV_Target.x = uintBitsToFloat(_22.x);
    SV_Target.y = uintBitsToFloat(_22.y);
    SV_Target.z = uintBitsToFloat(_22.z);
    SV_Target.w = uintBitsToFloat(_22.w);
}


#if 0
// SPIR-V disassembly
; SPIR-V
; Version: 1.3
; Generator: Unknown(30017); 21022
; Bound: 41
; Schema: 0
OpCapability Shader
OpCapability SampledBuffer
OpCapability RuntimeDescriptorArray
OpExtension "SPV_EXT_descriptor_indexing"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %3 "main" %11 %15
OpExecutionMode %3 OriginUpperLeft
OpName %3 "main"
OpName %11 "I"
OpName %15 "SV_Target"
OpDecorate %9 DescriptorSet 0
OpDecorate %9 Binding 0
OpDecorate %11 Flat
OpDecorate %11 Location 0
OpDecorate %15 Location 0
%1 = OpTypeVoid
%2 = OpTypeFunction %1
%5 = OpTypeInt 32 0
%6 = OpTypeImage %5 Buffer 0 0 0 1 Unknown
%7 = OpTypeRuntimeArray %6
%8 = OpTypePointer UniformConstant %7
%9 = OpVariable %8 UniformConstant
%10 = OpTypePointer Input %5
%11 = OpVariable %10 Input
%12 = OpTypeFloat 32
%13 = OpTypeVector %12 4
%14 = OpTypePointer Output %13
%15 = OpVariable %14 Output
%17 = OpTypePointer UniformConstant %6
%20 = OpConstant %5 0
%21 = OpTypeVector %5 4
%31 = OpTypePointer Output %12
%34 = OpConstant %5 1
%36 = OpConstant %5 2
%38 = OpConstant %5 3
%3 = OpFunction %1 None %2
%4 = OpLabel
OpBranch %39
%39 = OpLabel
%16 = OpLoad %5 %11
%18 = OpAccessChain %17 %9 %16
%19 = OpLoad %6 %18
%22 = OpImageFetch %21 %19 %20
%23 = OpCompositeExtract %5 %22 0
%24 = OpBitcast %12 %23
%25 = OpCompositeExtract %5 %22 1
%26 = OpBitcast %12 %25
%27 = OpCompositeExtract %5 %22 2
%28 = OpBitcast %12 %27
%29 = OpCompositeExtract %5 %22 3
%30 = OpBitcast %12 %29
%32 = OpAccessChain %31 %15 %20
OpStore %32 %24
%33 = OpAccessChain %31 %15 %34
OpStore %33 %26
%35 = OpAccessChain %31 %15 %36
OpStore %35 %28
%37 = OpAccessChain %31 %15 %38
OpStore %37 %30
OpReturn
OpFunctionEnd
#endif
