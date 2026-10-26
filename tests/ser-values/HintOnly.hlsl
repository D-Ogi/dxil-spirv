RWStructuredBuffer<uint> Out : register(u0);
cbuffer Params : register(b0) { uint Choice; uint Index; uint Seed; uint Padding; };
[shader("raygeneration")]
void HintOnly()
{
    dx::MaybeReorderThread(Index, 4);
    Out[0] = Seed;
}
