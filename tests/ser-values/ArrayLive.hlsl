// Compiler-only SER contract probes. No GPU launch is performed by this source.
// Dynamic indices are inputs so the relevant objects stay live through DXC optimization.
struct [raypayload] Payload { uint value : read(miss, closesthit, caller) : write(miss, closesthit, caller); };
RWStructuredBuffer<uint> Out : register(u0);
RaytracingAccelerationStructure Scene : register(t0);
cbuffer Params : register(b0) { uint Choice; uint Index; uint Seed; uint Padding; };

RayDesc ray() {
    RayDesc r;
    r.Origin = float3(0, 0, -1);
    r.Direction = float3(0, 0, 1);
    r.TMin = 0;
    r.TMax = 100;
    return r;
}

[shader("raygeneration")] void ArrayLive() {
  dx::HitObject h[2];
  [loop] for (uint i=0; i<2; ++i) h[i] = dx::HitObject::MakeMiss(0,i,ray());
  Payload p = {Seed}; dx::HitObject::Invoke(h[Index & 1],p); Out[0]=p.value;
}