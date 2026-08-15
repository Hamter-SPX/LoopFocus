# Minimum Intervention

## What

The change should be as small as the problem. Fixing a 2-line problem by touching 20 files needs a written justification — and usually means the diagnosis is wrong.

## Why

Every touched file is a side-effect lottery ticket. The 20-file refactor that "fixes" the bug usually fixes it by accident and breaks three things by design. Minimum Intervention is not aesthetics — it is the mathematical best bet: smallest surface, fewest surprises, fastest review, cleanest rollback.

## When

- At plan time (change radius is part of the plan, not its aftermath)
- At the mutation gate (every edit asks: is this the smallest change that serves the goal?)
- After Solution Entropy warnings (the return to checkpoint is an intervention reset)

## Protocol

1. The fix's necessary surface comes from the root cause, not the symptom: a root cause in a shared util needs the util — nothing else.
2. If the planned surface exceeds the problem's size: hold (change-radius gate). Either the diagnosis is wrong (re-hypothesize) or the goal is bigger than stated (re-lock with the user).
3. Supporting changes (tests for the fix, one-line cleanup on the exact edited lines) stay inside the surface. Everything else is Optional → report, don't do.
4. The justification for a large surface is a ledger entry, not a vibe: "20 files because the cause spans the layer" with evidence, or the surface shrinks.

## Evidence gates

- diff size audited against the problem size (the change-radius gate's machine input: `git diff --stat`)
- large-surface justifications recorded

## Machine check

```bash
node scripts/git-state.js        # diff_stat — compare against the problem's size
```

## Anti-patterns

- "While I was in there" as a surface-expansion argument
- Calling a symptom patch minimal (small diff, wrong place — minimal AND root-caused, both)
- Fixing by rewriting the module "so it never happens again" (that's a separate Optional project)

## Example

Float rounding fix: root cause = one sign flip in one shared util. Final diff: 1 file, 1 line, plus its regression test. The nine accreted fallback files from the entropy episode were discarded at the checkpoint — the intervention reset them, and the one-line fix outlived them all.
