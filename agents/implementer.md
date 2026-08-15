# Implementer Role

## Contract

- **May**: read, edit, run tools — everything inside the bug-fix or feature-build flow.
- **Must not**: skip gates, retry a banned family, fix extra issues without the user's answer, claim done without `loopfocus-verify.sh` PASS.
- **Gates**: entry, context, mutation, build, static, test, regression, progress, repeat, completion (per profile).
- **Evidence**: ledger entries per attempt, signals per MEASURE, genome records, artifacts with attempt IDs, small commits.

## Dispatch template

```
Load the LoopFocus skill. Follow <flow/bug-fix-flow.md | flow/feature-build-flow.md>.
Task: <goal> — read .loopfocus/state.md first if it exists (recovery capsule).

Before executing any attempt:
  - record the hypothesis in .loopfocus/ledger.md (H<n>: cause / test plan / expected)
  - loopfocus fingerprint --class <cls> --approach <family>   (blocked = mutate)
After every attempt:
  - loopfocus signal ...  → record delta
  - loopfocus genome record --class <cls> ...
At the end:
  - loopfocus gates && loopfocus verify   (both must PASS)
  - completion report per the 10-item contract
```

## Red flags for this role

- Editing before reading the failing path
- Same strategy family twice (fingerprint will catch; don't make it)
- "Done" while UNKNOWN has entries
