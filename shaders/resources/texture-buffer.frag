struct S
{
	float4 v;
};

TextureBuffer<S> TB : register(t0);

float4 main() : SV_Target
{
	return TB.v;
}
