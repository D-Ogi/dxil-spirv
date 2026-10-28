ByteAddressBuffer B : register(t0);
RWByteAddressBuffer O : register(u0);

[numthreads(64, 1, 1)]
void main(uint i : SV_DispatchThreadID)
{
	uint status;
	uint4 v = B.Load4(i * 16, status);
	O.Store4(i * 16, CheckAccessFullyMapped(status) ? v : 0);
}
