#version 460
layout(points) in;
layout(max_vertices = 1, points) out;

layout(location = 1) in uint SV_RenderTargetArrayIndex[1];

void main()
{
    gl_Position.x = gl_in[0u].gl_Position.x;
    gl_Position.y = gl_in[0u].gl_Position.y;
    gl_Position.z = gl_in[0u].gl_Position.z;
    gl_Position.w = gl_in[0u].gl_Position.w;
    gl_Layer = int(SV_RenderTargetArrayIndex[0u] + 1u);
    EmitVertex();
}


#if 0
// SPIR-V disassembly
; SPIR-V
; Version: 1.3
; Generator: Unknown(30017); 21022
; Bound: 42
; Schema: 0
OpCapability Shader
OpCapability Geometry
OpMemoryModel Logical GLSL450
OpEntryPoint Geometry %3 "main" %11 %14 %16 %18
OpExecutionMode %3 Invocations 1
OpExecutionMode %3 OutputVertices 1
OpExecutionMode %3 InputPoints
OpExecutionMode %3 OutputPoints
OpName %3 "main"
OpName %11 "SV_Position"
OpName %14 "SV_RenderTargetArrayIndex"
OpName %16 "SV_Position"
OpName %18 "SV_RenderTargetArrayIndex"
OpDecorate %11 BuiltIn Position
OpDecorate %14 Location 1
OpDecorate %16 BuiltIn Position
OpDecorate %18 BuiltIn Layer
%1 = OpTypeVoid
%2 = OpTypeFunction %1
%5 = OpTypeFloat 32
%6 = OpTypeVector %5 4
%7 = OpTypeInt 32 0
%8 = OpConstant %7 1
%9 = OpTypeArray %6 %8
%10 = OpTypePointer Input %9
%11 = OpVariable %10 Input
%12 = OpTypeArray %7 %8
%13 = OpTypePointer Input %12
%14 = OpVariable %13 Input
%15 = OpTypePointer Output %6
%16 = OpVariable %15 Output
%17 = OpTypePointer Output %7
%18 = OpVariable %17 Output
%19 = OpTypePointer Input %5
%21 = OpConstant %7 0
%26 = OpConstant %7 2
%29 = OpConstant %7 3
%31 = OpTypePointer Input %7
%35 = OpTypePointer Output %5
%3 = OpFunction %1 None %2
%4 = OpLabel
OpBranch %40
%40 = OpLabel
%20 = OpAccessChain %19 %11 %21 %21
%22 = OpLoad %5 %20
%23 = OpAccessChain %19 %11 %21 %8
%24 = OpLoad %5 %23
%25 = OpAccessChain %19 %11 %21 %26
%27 = OpLoad %5 %25
%28 = OpAccessChain %19 %11 %21 %29
%30 = OpLoad %5 %28
%32 = OpAccessChain %31 %14 %21
%33 = OpLoad %7 %32
%34 = OpIAdd %7 %33 %8
%36 = OpAccessChain %35 %16 %21
OpStore %36 %22
%37 = OpAccessChain %35 %16 %8
OpStore %37 %24
%38 = OpAccessChain %35 %16 %26
OpStore %38 %27
%39 = OpAccessChain %35 %16 %29
OpStore %39 %30
OpStore %18 %34
OpEmitVertex
OpReturn
OpFunctionEnd
#endif
