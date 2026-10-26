"""Bounded executable checks of generated SPIR-V, with mock ray/miss/callable services.

This tests compiler value/PHI/copy-back behavior, not GPU traversal or scheduling.
Unknown executable opcodes fail closed. Query traversal returns one committed hit;
miss records 0/1 add 11/23; callable adds 7; root record zero contains 0xcafe.
"""
import copy, pathlib, sys, json

class Machine:
    def __init__(self, text, choice=0, index=1, seed=100):
        self.v={}; self.types={}; self.mem={}; self.output={}; self.blocks={}; self.execs=[]
        self.params=[[[choice,index,seed,0]]]
        self.mem['root']=[[[0xcafe]*64] for _ in range(4)]
        current=None; self.first=None
        for line in text.splitlines():
            line=line.split(';')[0].strip()
            if not line: continue
            bits=line.split(); result=None
            if len(bits)>2 and bits[1]=='=': result,bits=bits[0],bits[2:]
            op,args=bits[0],bits[1:]
            if op=='OpLabel':
                current=[]; self.blocks[result]=current
                if self.first is None: self.first=result
            elif op=='OpFunction': continue
            elif op=='OpFunctionEnd': current=None
            elif current is not None: current.append((result,op,args))
            elif op.startswith('OpType'): self.types[result]=(op,args)
            elif op=='OpConstant': self.v[result]=float(args[1]) if self.types[args[0]][0]=='OpTypeFloat' else int(args[1])
            elif op=='OpConstantTrue': self.v[result]=True
            elif op=='OpConstantFalse': self.v[result]=False
            elif op=='OpConstantNull': self.v[result]=self.zero(args[0])
            elif op=='OpConstantComposite': self.v[result]=[self.v[a] for a in args[1:]]
            elif op=='OpUndef': self.v[result]=self.zero(args[0])
            elif op=='OpVariable': self.variable(result,args)
            elif op in ('OpCapability','OpExtension','OpMemoryModel','OpEntryPoint','OpName','OpMemberName','OpDecorate','OpMemberDecorate','OpSource','OpExecutionMode'): pass
            else: raise AssertionError(('global opcode',op))
    def zero(self,t):
        op,a=self.types[t]
        if op=='OpTypePointer': return None
        if op=='OpTypeStruct': return [self.zero(x) for x in a]
        if op in ('OpTypeArray','OpTypeVector'):
            n=self.v[a[1]] if op=='OpTypeArray' else int(a[1])
            return [self.zero(a[0]) for _ in range(n)]
        if op=='OpTypeHitObjectEXT': return dict(kind='uninitialized',sbt=0)
        return 0
    def variable(self,r,a):
        self.v[r]=(r,)
        self.mem[r]=copy.deepcopy(self.v[a[2]]) if len(a)>2 else self.zero(self.types[a[0]][1][1])
        if r=='%Params': self.mem[r]=self.params
        if r in ('%Out','%Scene'): self.mem[r]=r
    def load(self,p):
        v=self.mem[p[0]]
        for i in p[1:]: v=v[i]
        return copy.deepcopy(v)
    def store(self,p,v):
        v=copy.deepcopy(v)
        if len(p)==1: self.mem[p[0]]=v; return
        target=self.mem[p[0]]
        for i in p[1:-1]: target=target[i]
        target[p[-1]]=v
    def payload(self,p,add):
        val=self.load(p); val[0]=(val[0]+add)&0xffffffff; self.store(p,val)
    def run(self):
        label=self.first; pred=None; steps=0
        while label is not None:
            block=self.blocks[label]; pending={}; next_label=None
            for r,op,a in block:
                if op=='OpPhi':
                    incoming=dict(zip(a[2::2],a[1::2])); pending[r]=copy.deepcopy(self.v[incoming[pred]])
            self.v.update(pending)
            for r,op,a in block:
                steps+=1
                assert steps<200000, 'bounded interpreter timeout'
                v=lambda x:self.v[x]
                out=None
                if op=='OpPhi': continue
                if op=='OpVariable': self.variable(r,a); continue
                if op in ('OpAccessChain','OpInBoundsAccessChain'): out=v(a[1])+tuple(v(x) for x in a[2:])
                elif op=='OpLoad': out=self.load(v(a[1]))
                elif op=='OpStore': self.store(v(a[0]),v(a[1])); continue
                elif op in ('OpBitcast','OpCopyObject'): out=copy.deepcopy(v(a[1]))
                elif op=='OpCompositeConstruct': out=[v(x) for x in a[1:]]
                elif op=='OpCompositeExtract':
                    out=v(a[1])
                    for i in a[2:]: out=out[int(i)]
                elif op=='OpSelect': out=copy.deepcopy(v(a[2]) if v(a[1]) else v(a[3]))
                elif op in ('OpIEqual','OpINotEqual','OpULessThan','OpLogicalAnd','OpLogicalOr','OpIAdd','OpBitwiseAnd','OpBitwiseXor','OpShiftRightLogical'):
                    x,y=v(a[1]),v(a[2])
                    out={'OpIEqual':lambda:x==y,'OpINotEqual':lambda:x!=y,'OpULessThan':lambda:x<y,
                         'OpLogicalAnd':lambda:x and y,'OpLogicalOr':lambda:x or y,'OpIAdd':lambda:(x+y)&0xffffffff,
                         'OpBitwiseAnd':lambda:x&y,'OpBitwiseXor':lambda:x^y,'OpShiftRightLogical':lambda:x>>y}[op]()
                elif op=='OpLogicalNot': out=not v(a[1])
                elif op=='OpHitObjectRecordMissEXT': self.store(v(a[0]),dict(kind='miss',sbt=v(a[2])&0xffff)); continue
                elif op=='OpHitObjectRecordEmptyEXT': self.store(v(a[0]),dict(kind='empty',sbt=0)); continue
                elif op=='OpHitObjectRecordFromQueryEXT': self.store(v(a[0]),dict(kind='hit',sbt=v(a[2]))); continue
                elif op=='OpHitObjectSetShaderBindingTableRecordIndexEXT':
                    obj=self.load(v(a[0])); obj['sbt']=v(a[1]); self.store(v(a[0]),obj); continue
                elif op=='OpHitObjectExecuteShaderEXT':
                    obj=self.load(v(a[0])); self.execs.append(obj)
                    if obj['kind']!='empty': self.payload(v(a[1]),11 if obj['sbt']==0 else 23)
                    continue
                elif op in ('OpHitObjectIsHitEXT','OpHitObjectIsMissEXT','OpHitObjectIsEmptyEXT'):
                    obj=self.load(v(a[1])); out=obj['kind']=={'OpHitObjectIsHitEXT':'hit','OpHitObjectIsMissEXT':'miss','OpHitObjectIsEmptyEXT':'empty'}[op]
                elif op=='OpHitObjectGetShaderBindingTableRecordIndexEXT': out=self.load(v(a[1]))['sbt']
                elif op=='OpHitObjectGetShaderRecordBufferHandleEXT': out=('root',self.load(v(a[1]))['sbt'])
                elif op=='OpRayQueryInitializeKHR': continue
                elif op=='OpReorderThreadWithHintEXT': continue
                elif op=='OpReorderThreadWithHitObjectEXT':
                    assert self.load(v(a[0]))['kind']!='uninitialized'
                    continue
                elif op=='OpRayQueryProceedKHR': out=False
                elif op=='OpTraceRayKHR': self.payload(v(a[-1]),11); continue
                elif op=='OpExecuteCallableKHR': self.payload(v(a[1]),7); continue
                elif op=='OpImageWrite': self.output[v(a[1])]=v(a[2])[0]; continue
                elif op in ('OpSelectionMerge','OpLoopMerge'): continue
                elif op=='OpBranch': next_label=a[0]; break
                elif op=='OpBranchConditional': next_label=a[1] if v(a[0]) else a[2]; break
                elif op=='OpReturn': next_label=None; break
                else: raise AssertionError(('unsupported executable opcode',op))
                if r is not None: self.v[r]=out
            pred,label=label,next_label
        return [self.output[i] for i in sorted(self.output)]

def check(directory,suffix):
    cases=[('CopyLive',0,1,[111,123,0,1]),('CopyLive',0,65537,[111,123,0,1]),
           ('DirectPayloadControl',0,1,[111]),('HintOnly',0,1,[100]),
           ('UnboundPhi',0,1,[100]),('UnboundPhi',1,1,[100]),('UnboundRoot',0,1,[0,1]),
           ('TempAlias',0,1,[129]),('HelperLive',0,1,[111,123]),
           ('ArrayLive',0,0,[111]),('ArrayLive',0,1,[123])]
    cases += [('TwoPhi',c,i,[123 if c else 111,123 if i else 111]) for c in (0,1) for i in (0,1)]
    for n in (0,1,2,3,16,31):
        expected=sum(111 if i%2==0 else 123 for i in range(n))
        cases.append(('LoopLive',n,1,[expected,111 if n%2==0 else 123]))
    rows=[]
    for name,choice,index,expected in cases:
        files=[directory/(name+'.spvasm')]; files=[f for f in files if f.exists()]
        if not files:
            rows.append(dict(case=name,choice=choice,index=index,passed=False,error='no converter output')); continue
        try:
            actual=Machine(files[0].read_text(),choice,index).run()
            rows.append(dict(case=name,choice=choice,index=index,expected=expected,actual=actual,passed=actual==expected))
        except Exception as exc: rows.append(dict(case=name,choice=choice,index=index,passed=False,error=repr(exc)))
    return rows
