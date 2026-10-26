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

dx::HitObject make(uint i) { return dx::HitObject::MakeMiss(0,i,ray()); }
dx::HitObject bind(dx::HitObject h, uint i) { h.SetShaderTableIndex(i); return h; }
[shader("raygeneration")] void HelperLive() {
 dx::HitObject a=make(0); dx::HitObject b=bind(a,Index);
 Payload p={Seed}; Payload q={Seed}; dx::HitObject::Invoke(a,p); dx::HitObject::Invoke(b,q);
 Out[0]=p.value; Out[1]=q.value;
}