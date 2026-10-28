StructuredBuffer<uint> A : register(t0);
RWStructuredBuffer<uint> O : register(u0);

[numthreads(64, 1, 1)]
void main(uint i : SV_DispatchThreadID)
{
	O[2 * i + 0] = A[i ^ 32];
	O[2 * i + 1] = A[i | 2];
}
