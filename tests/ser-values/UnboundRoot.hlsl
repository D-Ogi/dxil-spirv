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
void UnboundRoot() {
    RayQuery<RAY_FLAG_FORCE_OPAQUE> query;
    query.TraceRayInline(Scene, 0, 255, ray());
    while (query.Proceed()) {}
    dx::HitObject h = dx::HitObject::FromRayQuery(query);
    Out[0] = h.LoadLocalRootTableConstant(0);
    Out[1] = h.IsHit();
}

