float4 GetColor(uint i);

[shader("pixel")]
float4 main(uint i : I) : SV_Target
{
	return GetColor(i);
}
