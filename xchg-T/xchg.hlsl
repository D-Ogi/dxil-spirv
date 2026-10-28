RWStructuredBuffer<float> S : register(u0);
RWBuffer<float> T : register(u1);
groupshared float G[64];

[numthreads(64, 1, 1)]
void main(uint i : SV_DispatchThreadID)
{
	float b, c;
#if USE_T
	InterlockedExchange(T[i], 2.0, b);
	T[i + 64] = b;
#endif
#if USE_G
	InterlockedExchange(G[i], 3.0, c);
	S[i + 128] = c;
#endif
}
