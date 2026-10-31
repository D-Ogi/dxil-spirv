#version 460
#extension GL_EXT_samplerless_texture_functions : require

layout(set = 0, binding = 0) uniform usamplerBuffer _8;

layout(location = 0) out vec4 SV_Target;

void main()
{
    uvec4 _16 = texelFetch(_8, int(0u));
    SV_Target.x = uintBitsToFloat(_16.x);
    SV_Target.y = uintBitsToFloat(_16.y);
    SV_Target.z = uintBitsToFloat(_16.z);
    SV_Target.w = uintBitsToFloat(_16.w);
}


#if 0
// SPIR-V disassembly
; SPIR-V
; Version: 1.3
; Generator: Unknown(30017); 21022
; Bound: 35
; Schema: 0
OpCapability Shader
OpCapability SampledBuffer
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %3 "main" %12
OpExecutionMode %3 OriginUpperLeft
OpName %3 "main"
OpName %12 "SV_Target"
OpDecorate %8 DescriptorSet 0
OpDecorate %8 Binding 0
OpDecorate %12 Location 0
%1 = OpTypeVoid
%2 = OpTypeFunction %1
%5 = OpTypeInt 32 0
%6 = OpTypeImage %5 Buffer 0 0 0 1 Unknown
%7 = OpTypePointer UniformConstant %6
%8 = OpVariable %7 UniformConstant
%9 = OpTypeFloat 32
%10 = OpTypeVector %9 4
%11 = OpTypePointer Output %10
%12 = OpVariable %11 Output
%14 = OpConstant %5 0
%15 = OpTypeVector %5 4
%25 = OpTypePointer Output %9
%28 = OpConstant %5 1
%30 = OpConstant %5 2
%32 = OpConstant %5 3
%3 = OpFunction %1 None %2
%4 = OpLabel
OpBranch %33
%33 = OpLabel
%13 = OpLoad %6 %8
%16 = OpImageFetch %15 %13 %14
%17 = OpCompositeExtract %5 %16 0
%18 = OpBitcast %9 %17
%19 = OpCompositeExtract %5 %16 1
%20 = OpBitcast %9 %19
%21 = OpCompositeExtract %5 %16 2
%22 = OpBitcast %9 %21
%23 = OpCompositeExtract %5 %16 3
%24 = OpBitcast %9 %23
%26 = OpAccessChain %25 %12 %14
OpStore %26 %18
%27 = OpAccessChain %25 %12 %28
OpStore %27 %20
%29 = OpAccessChain %25 %12 %30
OpStore %29 %22
%31 = OpAccessChain %25 %12 %32
OpStore %31 %24
OpReturn
OpFunctionEnd
#endif
