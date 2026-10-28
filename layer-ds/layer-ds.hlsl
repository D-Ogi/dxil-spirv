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

[domain("tri")]
ControlPoint main(PatchConstants pc, float3 uvw : SV_DomainLocation, const OutputPatch<ControlPoint, 3> patch)
{
	ControlPoint o;
	o.pos = patch[0].pos * uvw.x + patch[1].pos * uvw.y + patch[2].pos * uvw.z;
	o.layer = patch[0].layer;
	return o;
}
