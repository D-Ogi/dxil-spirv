# HitObject value regressions

These tests compile small SM 6.9 shaders and interpret the generated SPIR-V with
mock ray, miss and callable services. They check copies, two independent PHIs,
loop-carried values, local arrays, inlined helpers, unbound query objects, local
root constants, miss-index masking and temporary payload copy-back. This is a
compiler test, not evidence of GPU traversal, scheduling or performance.

`CopyReference.spvasm` is a separate handwritten reference for the copy/SBT-index
case. It uses two opaque objects directly, not the translator's pool. The runner
assembles and validates it, then checks the same expected result as the generated
shader. This provides an independent representation oracle, still without GPU
execution.

Build the C shared translator and `assemble-dxil.cpp` with a Windows C++ compiler
and the DXC include directory. The helper loads the selected DXC DLL at runtime;
it needs no DXC import library. Then run:

```text
python run.py --dxc PATH/dxc.exe --converter PATH/dxil-spirv-c-shared.dll --spirv-tools PATH --assembler PATH/assemble-dxil.exe --output OUTPUT
```

Use a new output directory for each revision. It receives DXIL, SPIR-V, logs and
`results.json`. The runner limits temporary files to that directory. It requires
DXC 1.9 with SM 6.9 and SPIR-V Tools with `SPV_EXT_shader_invocation_reorder`.

`TempAlias.ll` is assembled and validated with DXC. It has one payload allocation
shared by CallShader and HitObject.Invoke. Ordinary HLSL optimization splits this
allocation and misses the temporary-storage path. The model's services add 11 for
miss record 0, 23 for miss record 1, and 7 for the callable. A query commits one hit
with local-root record 0 set to 0xcafe. Expected outputs come from the HLSL value
contract. The interpreter rejects executable operations it does not implement.

The allocator retains each scalar HitObject reference in SSA and local memory.
With N retained references there are N+1 candidate storage slots, so a constructor
always has a free destination. A separate empty slot handles unbound invocation.
This permits any number of values subject to normal shader resource limits. It
does not copy opaque SPIR-V objects. The conservative allocation scan costs O(N^2)
scalar operations per constructor; GPU cost and backend compatibility need runtime
measurement before promotion.
