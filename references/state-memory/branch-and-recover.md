# Branch-and-Recover

## What

Competing approaches run as parallel branches — git worktrees — each with its own evidence. The winner returns; the losers are removed with their failure recorded. A broken branch is discarded by returning to its checkpoint; no other branch's progress is touched.

## Why

When multiple hypotheses are equally alive, serial testing is slow and in-place testing is destructive. Branches give each hypothesis a sandbox with shared evidence standards — the comparison becomes fair, and a dead branch costs a worktree, not the workspace.

## When

- Two or more live hypotheses with comparable evidence (L5 depth, L8 extreme)
- S5 Alternative Implementations (test the replacement in a branch, not in place)
- Any "try both and see" situation (Reversible First's structural form)

## Protocol

```bash
node scripts/git-state.js worktree-new attempt-b    # branch per hypothesis
node scripts/git-state.js worktree-list
node scripts/git-state.js worktree-remove attempt-b # loser cleanup
```

1. Each branch declares its hypothesis + success criteria (the same evidence bar for all — fairness is the point).
2. Branches run their experiments independently; results record into the genome (same problem class).
3. Comparison on the shared bar → winner returns to the main workspace; losers removed, failures recorded (Failure Memory).
4. A branch that breaks its own checkpoint discards cleanly — nothing else is touched.

## Evidence gates

- shared success criteria written before branching
- loser failures recorded before removal
- winner's merge preserves the evidence trail (tests + signals)

## Machine check

```bash
node scripts/git-state.js worktree-list   # active branches
node scripts/loop-genome.js query --class <problem-class>   # per-branch attempts
```

## Anti-patterns

- Branching without shared criteria (the comparison becomes vibes)
- Keeping all branches alive "in case" (unmerged branches are open loops)
- Deleting a loser without recording why it lost (the next agent re-walks the dead path)
