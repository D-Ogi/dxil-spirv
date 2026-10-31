struct ControlPoint
{
	float4 pos : SV_Position;
	uint layer : SV_RenderTargetArrayIndex;
};

struct PatchConstants
{
	float edges[3] : SV_TessFactor;
	float inside : SV_InsideTessFactor;
};

PatchConstants patch_main()
{
	PatchConstants o;
	o.edges[0] = 1.0;
	o.edges[1] = 1.0;
	o.edges[2] = 1.0;
	o.inside = 1.0;
	return o;
}

[domain("tri")]
[partitioning("integer")]
[outputtopology("triangle_cw")]
[outputcontrolpoints(3)]
[patchconstantfunc("patch_main")]
ControlPoint main(InputPatch<ControlPoint, 3> patch, uint i : SV_OutputControlPointID)
{
	return patch[i];
}
