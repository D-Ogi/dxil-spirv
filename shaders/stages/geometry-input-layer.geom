struct VSOut
{
	float4 pos : SV_Position;
	uint layer : SV_RenderTargetArrayIndex;
};

struct GSOut
{
	float4 pos : SV_Position;
	uint layer : SV_RenderTargetArrayIndex;
};

[maxvertexcount(1)]
void main(point VSOut p[1], inout PointStream<GSOut> stream)
{
	GSOut o;
	o.pos = p[0].pos;
	o.layer = p[0].layer + 1;
	stream.Append(o);
}
