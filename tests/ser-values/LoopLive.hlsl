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

[shader("raygeneration")]
void LoopLive() {
  dx::HitObject previous = dx::HitObject::MakeMiss(0, 0, ray());
  uint sum = 0;
  [loop] for (uint i = 0; i < Choice; ++i) {
    dx::HitObject next = dx::HitObject::MakeMiss(0, (i + 1) & 1, ray());
    Payload p = {Seed};
    dx::HitObject::Invoke(previous, p);
    sum += p.value;
    previous = next;
  }
  Payload q = {Seed};
  dx::HitObject::Invoke(previous, q);
  Out[0] = sum; Out[1] = q.value;
}
