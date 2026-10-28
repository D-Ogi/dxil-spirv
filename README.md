# Evidence for the dxil-spirv issue reports

This branch holds only the reproduction files for the issue reports filed at
https://github.com/HansKristian-Work/dxil-spirv/issues. It shares no history with the source.

Setup for every case:

- dxil-spirv: upstream master a7676a1f (2026-10-27), CLI built RelWithDebInfo with clang-cl 23.1.4.
- DXC 1.9.2609.5 (release).
- spirv-val from SPIRV-Tools 2026.3, `--target-env vulkan1.3 --scalar-block-layout`.

Each directory has the HLSL input, `commands.txt` (the exact commands), `summary.txt`, and `run1` and `run2`
(two independent runs: the DXIL, its disassembly `.dxil.ll`, the SPIR-V `.spv` and `.spvasm`, the
dxil-spirv log and the spirv-val output). For a crash, `cdb.txt` has the symbolized stack. Paths are
shortened: `<build>` is the dxil-spirv build directory, `<dxil-spirv>` the source tree.
Directories that start with `v-` are spirv-val checks of a smaller case; `c1`-`c3` are cases from DXC's own
test corpus.

| Issue | Directories |
|---|---|
| Buffer index folding for `C - x`, `x \| C`, `x ^ C` | indexfold-sub, indexfold-sub-ssbo, indexfold-orxor-ssbo, indexfold-gpu |
| UAddc (AddUint64) | adduint64, v-iaddcarry |
| Ray query handle through a select or a static array | rayquery-select, rayquery-static-array, c2-rayquery-pix, v-rayquery-store |
| RawBufferLoad status on a root descriptor | root-load-status-sm62, root-load-status-sm69, root-load4-status, v-sm69-vec-float-root |
| DeviceMemoryBarrier scope in a pixel shader | membarrier-ps, v-callgraph |
| Float InterlockedExchange | xchg-T, xchg-G, v-atomic-xchg-ptr, v-atomic-xchg-val |
| GetDimensions on a root descriptor | rootdesc-getdims, rootdesc-getdims-ssbo, rootdesc-getdims-nobda |
| tbuffer / TextureBuffer Dim | tbuffer, texturebuffer, v-dimensionality |
| DispatchMesh payload array element | as-payload-element, v-as-payload |
| GEP of a GEP into a ray payload | derived-payload, c3-derived-payload, derived-payload-O3 |
| IsHelperLane outside pixel shaders | helperlane-vs-Od, helperlane-vs-O3, helperlane-corpus-*, v-helper |
| Hull shader Layer input | layer-hs, layer-ds, v-layer-hs |
| Geometry shader FrontFacing output | frontface-gs, v-frontfacing-gs |
| Library external function | lib-extern, c1-lib-undef |
| Library unbound resource | lib-unbound-cbv, v-decorate-trunc |
| Zero-size CBV array | cb-in-struct, v-array-len0 |

`indexfold-gpu` is the GPU differential test on an RTX 4090 (NVIDIA 595.97): `indexfold.hlsl` has the 16
index forms, run for 64 threads. Each log has three routes: the DXIL through dxil-spirv with the descriptor
heap (`dxil-heap`) and with plain descriptors (`dxil-legacy`), and the HLSL through DXC's `-spirv`
(`dxc-spirv`, the witness). Each route is compared with a CPU reference. `rtx4090-indexfold-base.log` is
a dxil-spirv build whose `extract_raw_buffer_access_split()` is the same as on master: both dxil-spirv routes
differ in 2169 of 4096 bytes and the DXC route matches. `rtx4090-indexfold-fix.log` is the same build with
the code change of branch `fix/raw-buffer-index-folding`: all routes match. The other cases in the logs
(int32, float32, bit16, ...) are the other cases of the same test kit and pass in both runs.
