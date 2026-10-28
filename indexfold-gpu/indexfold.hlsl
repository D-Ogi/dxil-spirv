// dxcdiff case indexfold: buffer indices of the forms "constant - x", "x | constant", "x ^ constant" and
// "(x * constant) | constant", which a translator may fold into "scale * x + bias" only when the fold is exact.
// t0: StructuredBuffer<uint> of 1024 elements; t1: ByteAddressBuffer of 4096 bytes.
// u0: 16 results per thread.
StructuredBuffer<uint> A : register(t0);
ByteAddressBuffer R : register(t1);
RWStructuredBuffer<uint> Out : register(u0);

[numthreads(64, 1, 1)]
void main(uint i : SV_DispatchThreadID)
{
    uint o = i * 16;
    Out[o + 0] = A[63 - i];
    Out[o + 1] = A[200 - (i << 1)];
    Out[o + 2] = A[i ^ 32];
    Out[o + 3] = A[i | 2];
    Out[o + 4] = A[(i * 12) | 16];
    Out[o + 5] = A[(i * 6) ^ 8];
    Out[o + 6] = A[(i << 2) | 3];
    Out[o + 7] = A[i + 5];
    Out[o + 8] = R.Load(4092 - 4 * i);
    Out[o + 9] = R.Load(1020 - (i << 2));
    Out[o + 10] = R.Load((i ^ 32) << 2);
    Out[o + 11] = R.Load((i << 4) | 8);
    Out[o + 12] = R.Load(((i * 3) << 2) | 16);
    Out[o + 13] = R.Load((i << 2) ^ 64);
    Out[o + 14] = R.Load2(2040 - 8 * i).y;
    Out[o + 15] = R.Load(4 * i + 12);
}
