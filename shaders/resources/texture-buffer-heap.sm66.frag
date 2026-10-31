struct S
{
	float4 v;
};

float4 main(uint i : I) : SV_Target
{
	TextureBuffer<S> tb = ResourceDescriptorHeap[i];
	return tb.v;
}
