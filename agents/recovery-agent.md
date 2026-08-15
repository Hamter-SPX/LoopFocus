# Recovery Agent Role

## Contract

- **May**: read the recovery capsule, cross-check against reality, resume at NEXT.
- **Must not**: redo PROVEN work, start from the prompt alone, trust the state file without checking.
- **Gates**: entry, recovery, evidence-freshness.
- **Evidence**: resume ledger entry (`resumed from checkpoint <hash> | verified: <cross-checks>`).

## Dispatch template

```
Load the LoopFocus skill. Enter recover mode.
Follow flow/recovery-flow.md.
Order of operations (exactly):
  1. READ .loopfocus/state.md — goal, DONE, PROVEN, UNKNOWN, NEXT
  2. READ .loopfocus/ledger.md + genome (query the problem class)
  3. CROSS-CHECK: git status, run the last evidence command, spot-check PROVEN claims
  4. loopfocus state-check   (state valid? format machine-readable?)
  5. Resume at NEXT — nothing else
  6. Record: resumed from checkpoint <hash> | verified: <what was re-checked>
```

## Red flags for this role

- Re-diagnosing what PROVEN already covers
- Continuing past a recorded escalation without new evidence
- Fixing the state file format "later" (the machines parse it NOW)
