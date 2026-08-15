# Change Radius Control

## What

Before executing a plan, count the blast radius: files touched, callers affected, behaviors at risk. A small goal with a huge radius is held and reassessed — the goal or the plan is wrong.

## Why

Radius is the honest measure of risk: a 30-file diff is not five times riskier than a 6-file one, it is differently risky — it changes the system's shape. The control exists to catch the mismatch between what the user asked for and what the diff is about to become, while it is still a plan.

## When

- Plan time (before execute, part of the plan gate)
- At the mutation gate for every edit ("does this expand the radius?")
- After replans (new plan, new radius count)

## The check

1. Count: files, callers (search usages), risky behaviors (state, concurrency, contracts).
2. Compare against the goal's size. Rule of thumb: a bug fix touching >3x the files its cause explains, or a feature whose radius reaches modules the feature never names — hold.
3. Hold outcome: re-hypothesize (the diagnosis is probably wrong) OR re-lock with the user (the goal is actually bigger — say so, get the bigger goal authorized).
4. Radius is measured on the plan, not the retroactive diff — a radius discovered after execution is a missed gate.

## Evidence gates

- radius count recorded in the plan (ledger: `radius: N files, M callers`)
- holds followed by re-hypothesis or user re-lock, not by pushing through

## Machine check

```bash
node scripts/git-state.js        # staged+unstaged files before commit
git diff --stat
```

## Anti-patterns

- Approving the big radius because each file's change is small (radius is about blast surface, not line count)
- Counting only files, not callers (the callers are where the breaks land)
- Discovering the radius after the diff and calling it "as expected"

## Example

M3 audit session: proposed fix touched auth service + router + session layer + 17 components for a redirect bug → radius mismatch → held. Re-hypothesis found the redirect logic lived in one middleware. Final radius: 2 files. The 17 components were collateral damage waiting to happen — the control cancelled it at plan time.
