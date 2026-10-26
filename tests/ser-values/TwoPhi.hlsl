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
void TwoPhi() {
    dx::HitObject a = dx::HitObject::MakeMiss(0, 0, ray());
    dx::HitObject b = dx::HitObject::MakeMiss(0, 1, ray());
    dx::HitObject c = a;
    [branch] if (Choice) c = b;
    dx::HitObject d = a;
    [branch] if (Index) d = b;
    Payload p = {Seed};
    Payload q = {Seed};
    dx::HitObject::Invoke(c, p);
    dx::HitObject::Invoke(d, q);
    Out[0] = p.value;
    Out[1] = q.value;
}

