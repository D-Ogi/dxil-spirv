#version 460
layout(vertices = 3) out;

layout(location = 1) in uint SV_RenderTargetArrayIndex[];
layout(location = 0) out vec4 SV_Position[3];
layout(location = 1) out uint SV_RenderTargetArrayIndex_1[3];

void hull_main()
{
    SV_Position[gl_InvocationID].x = gl_in[gl_InvocationID].gl_Position.x;
    SV_Position[gl_InvocationID].y = gl_in[gl_InvocationID].gl_Position.y;
    SV_Position[gl_InvocationID].z = gl_in[gl_InvocationID].gl_Position.z;
    SV_Position[gl_InvocationID].w = gl_in[gl_InvocationID].gl_Position.w;
    SV_RenderTargetArrayIndex_1[gl_InvocationID] = SV_RenderTargetArrayIndex[gl_InvocationID];
}

void patch_main()
{
    gl_TessLevelOuter[0u] = 1.0;
    gl_TessLevelOuter[1u] = 1.0;
    gl_TessLevelOuter[2u] = 1.0;
    gl_TessLevelInner[0u] = 1.0;
}

void main()
{
    hull_main();
    barrier();
    if (gl_InvocationID == 0u)
    {
        patch_main();
    }
}


#if 0
// SPIR-V disassembly
; SPIR-V
; Version: 1.3
; Generator: Unknown(30017); 21022
; Bound: 80
; Schema: 0
OpCapability Shader
OpCapability Tessellation
OpMemoryModel Logical GLSL450
OpEntryPoint TessellationControl %3 "main" %11 %14 %18 %21 %25 %29 %35
OpExecutionMode %3 Triangles
OpExecutionMode %3 SpacingEqual
OpExecutionMode %3 VertexOrderCw
OpExecutionMode %3 OutputVertices 3
OpName %3 "main"
OpName %11 "SV_Position"
OpName %14 "SV_RenderTargetArrayIndex"
OpName %18 "SV_Position"
OpName %21 "SV_RenderTargetArrayIndex"
OpName %25 "SV_TessFactor"
OpName %29 "SV_InsideTessFactor"
OpName %30 "hull_main"
OpName %32 "patch_main"
OpDecorate %11 BuiltIn Position
OpDecorate %14 Location 1
OpDecorate %18 Location 0
OpDecorate %21 Location 1
OpDecorate %25 BuiltIn TessLevelOuter
OpDecorate %25 Patch
OpDecorate %29 BuiltIn TessLevelInner
OpDecorate %29 Patch
OpDecorate %35 BuiltIn InvocationId
%1 = OpTypeVoid
%2 = OpTypeFunction %1
%5 = OpTypeFloat 32
%6 = OpTypeVector %5 4
%7 = OpTypeInt 32 0
%8 = OpConstant %7 32
%9 = OpTypeArray %6 %8
%10 = OpTypePointer Input %9
%11 = OpVariable %10 Input
%12 = OpTypeArray %7 %8
%13 = OpTypePointer Input %12
%14 = OpVariable %13 Input
%15 = OpConstant %7 3
%16 = OpTypeArray %6 %15
%17 = OpTypePointer Output %16
%18 = OpVariable %17 Output
%19 = OpTypeArray %7 %15
%20 = OpTypePointer Output %19
%21 = OpVariable %20 Output
%22 = OpConstant %7 4
%23 = OpTypeArray %5 %22
%24 = OpTypePointer Output %23
%25 = OpVariable %24 Output
%26 = OpConstant %7 2
%27 = OpTypeArray %5 %26
%28 = OpTypePointer Output %27
%29 = OpVariable %28 Output
%34 = OpTypePointer Input %7
%35 = OpVariable %34 Input
%37 = OpTypePointer Input %5
%39 = OpConstant %7 0
%42 = OpConstant %7 1
%48 = OpTypePointer Output %5
%59 = OpTypePointer Output %7
%63 = OpConstant %5 1
%69 = OpTypeBool
%3 = OpFunction %1 None %2
%4 = OpLabel
OpBranch %72
%72 = OpLabel
%67 = OpFunctionCall %1 %30
%68 = OpLoad %7 %35
%70 = OpIEqual %69 %68 %39
OpControlBarrier %26 %22 %39
OpSelectionMerge %74 None
OpBranchConditional %70 %73 %74
%73 = OpLabel
%71 = OpFunctionCall %1 %32
OpBranch %74
%74 = OpLabel
OpReturn
OpFunctionEnd
%30 = OpFunction %1 None %2
%31 = OpLabel
OpBranch %76
%76 = OpLabel
%36 = OpLoad %7 %35
%38 = OpAccessChain %37 %11 %36 %39
%40 = OpLoad %5 %38
%41 = OpAccessChain %37 %11 %36 %42
%43 = OpLoad %5 %41
%44 = OpAccessChain %37 %11 %36 %26
%45 = OpLoad %5 %44
%46 = OpAccessChain %37 %11 %36 %15
%47 = OpLoad %5 %46
%50 = OpLoad %7 %35
%49 = OpAccessChain %48 %18 %50 %39
OpStore %49 %40
%52 = OpLoad %7 %35
%51 = OpAccessChain %48 %18 %52 %42
OpStore %51 %43
%54 = OpLoad %7 %35
%53 = OpAccessChain %48 %18 %54 %26
OpStore %53 %45
%56 = OpLoad %7 %35
%55 = OpAccessChain %48 %18 %56 %15
OpStore %55 %47
%57 = OpAccessChain %34 %14 %36
%58 = OpLoad %7 %57
%61 = OpLoad %7 %35
%60 = OpAccessChain %59 %21 %61
OpStore %60 %58
OpReturn
OpFunctionEnd
%32 = OpFunction %1 None %2
%33 = OpLabel
OpBranch %78
%78 = OpLabel
%62 = OpAccessChain %48 %25 %39
OpStore %62 %63
%64 = OpAccessChain %48 %25 %42
OpStore %64 %63
%65 = OpAccessChain %48 %25 %26
OpStore %65 %63
%66 = OpAccessChain %48 %29 %39
OpStore %66 %63
OpReturn
OpFunctionEnd
#endif
