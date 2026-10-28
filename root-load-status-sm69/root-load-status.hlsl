RWByteAddressBuffer B : register(u1);

[numthreads(64, 1, 1)]
void main(uint i : SV_DispatchThreadID)
{
	uint status;
	float4 v = B.Load<float4>(i * 16, status);
	B.Store<float4>(i * 16 + 1024, CheckAccessFullyMapped(status) ? v : 0.0);
}
