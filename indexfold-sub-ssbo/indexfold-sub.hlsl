StructuredBuffer<uint> A : register(t0);
RWStructuredBuffer<uint> O : register(u0);

[numthreads(64, 1, 1)]
void main(uint i : SV_DispatchThreadID)
{
	O[i] = A[63 - i];
}
