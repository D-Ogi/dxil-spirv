"""Compile and check SER value semantics. Uses mock shader services, not a GPU.

Unknown executable SPIR-V instructions fail the model instead of being ignored.
Pass --converter to the C shared library built from the revision under test.
"""
import argparse
import ctypes as C
import hashlib
import json
import os
from pathlib import Path
import subprocess
import sys
from spirv_model import check, Machine

p=argparse.ArgumentParser(description=__doc__)
p.add_argument('--dxc',type=Path,required=True)
p.add_argument('--converter',type=Path,required=True)
p.add_argument('--spirv-tools',type=Path,required=True)
p.add_argument('--assembler',type=Path,required=True)
p.add_argument('--output',type=Path,required=True)
a=p.parse_args()
a.output=a.output.resolve(); a.output.mkdir(parents=True,exist_ok=True)
if any(a.output.iterdir()):
    p.error('--output must be empty, so stale compiler output cannot pass a test')
os.environ['TEMP']=os.environ['TMP']=str(a.output)
here=Path(__file__).resolve().parent
records=[]

def command(cmd,name):
    cmd=[str(x) for x in cmd]
    r=subprocess.run(cmd,capture_output=True)
    (a.output/(name+'.log')).write_bytes(r.stdout+r.stderr)
    records.append(dict(command=cmd,exit=r.returncode))
    return r.returncode==0

dll=C.CDLL(str(a.converter.resolve())); P=C.c_void_p
class Spirv(C.Structure): _fields_=[('data',P),('size',C.c_size_t)]
class PhysicalOption(C.Structure): _fields_=[('type',C.c_int),('enable',C.c_ubyte)]
def api(name,args,ret=C.c_int):
    f=getattr(dll,'dxil_spv_'+name); f.argtypes=args; f.restype=ret; return f
parse=api('parse_dxil_blob',[P,C.c_size_t,C.POINTER(P)])
create=api('create_converter',[P,C.POINTER(P)])
entry=api('converter_set_entry_point',[P,C.c_char_p],None)
run=api('converter_run',[P])
get=api('converter_get_compiled_spirv',[P,C.POINTER(Spirv)])
free=api('converter_free',[P],None)
freeblob=api('parsed_blob_free',[P],None)
add_option=api('converter_add_option',[P,P])
CALLBACK=C.CFUNCTYPE(None,P,C.c_int,C.c_char_p)
logs=[]
@CALLBACK
def log_cb(user,level,msg): logs.append(msg.decode(errors='replace'))
api('set_thread_log_callback',[CALLBACK,P],None)(log_cb,None)
compiled=True
for src in sorted(here.glob('*.hlsl'))+list(here.glob('*.ll')):
    name=src.stem; dxil=a.output/(name+'.dxil')
    if src.suffix=='.hlsl':
        ok=command([a.dxc,'-T','lib_6_9','-HV','2021',src,'-Fo',dxil,'-Fc',a.output/(name+'.ll')],name+'-dxc')
    else:
        ok=command([a.assembler,a.dxc.parent,src,dxil],name+'-assemble')
        if ok: ok=command([a.dxc.parent/'dxv.exe',dxil],name+'-dxv')
    if not ok: compiled=False; continue
    logs.clear(); data=dxil.read_bytes(); buf=C.create_string_buffer(data); blob=P(); conv=P(); spv=Spirv()
    row=dict(case=name,dxil_sha256=hashlib.sha256(data).hexdigest())
    row['parse']=parse(buf,len(data),C.byref(blob))
    if row['parse']==0:
        row['create']=create(blob,C.byref(conv))
        if row['create']==0:
            option=PhysicalOption(7,1); row['physical']=add_option(conv,C.byref(option))
            entry(conv,name.encode()); row['convert']=run(conv)
            if row['convert']==0:
                row['get']=get(conv,C.byref(spv))
                if row['get']==0:
                    binary=a.output/(name+'.spv'); binary.write_bytes(C.string_at(spv.data,spv.size))
                    ok=command([a.spirv_tools/'spirv-dis.exe',binary,'-o',a.output/(name+'.spvasm')],name+'-dis')
                    ok=command([a.spirv_tools/'spirv-val.exe','--target-env','vulkan1.3',binary],name+'-val') and ok
                    compiled=compiled and ok
            else: compiled=False
            free(conv)
        else: compiled=False
        freeblob(blob)
    else: compiled=False
    row['log']=''.join(logs); records.append(row)
results=check(a.output,'')
reference=here/'CopyReference.spvasm'
binary=a.output/'CopyReference.spv'
ok=command([a.spirv_tools/'spirv-as.exe','--target-env','vulkan1.3',reference,'-o',binary],'reference-as')
if ok: ok=command([a.spirv_tools/'spirv-val.exe','--target-env','vulkan1.3',binary],'reference-val')
actual=Machine(reference.read_text()).run() if ok else None
results.append(dict(case='independent-SPIRV-copy-reference',actual=actual,
                    expected=[111,123,0,1],passed=ok and actual==[111,123,0,1]))
report=dict(converter_sha256=hashlib.sha256(a.converter.read_bytes()).hexdigest(),records=records,results=results)
(a.output/'results.json').write_text(json.dumps(report,indent=2))
passed=sum(r['passed'] for r in results)
print(f'{passed}/{len(results)} SER value cases; compiler/validation success: {compiled}')
sys.exit(not compiled or passed!=len(results))
