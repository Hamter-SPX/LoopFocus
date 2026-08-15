# Commitment Levels

## What

A permission ladder for code changes. Not every reasoning result becomes an edit: the depth of commitment matches the strength of evidence, from observation (L0) to structural change (L5).

## Why

The most expensive accidents come from under-evidenced structural changes — an agent with a hypothesis that "feels right" rewrites the architecture. The levels make the jump explicit and gated: you cannot reach L5 without walking through the lower levels' evidence.

## When

Before every EXECUTE, the planned edit declares its level in the ledger. The mutation gate then checks the level against the evidence actually held.

## The levels

| Level | Name | Permits | Requires |
|---|---|---|---|
| L0 | Observe | read code, run existing tests, no changes | nothing |
| L1 | Hypothesis | write ledger entries | a stated cause |
| L2 | Experiment | isolated sandbox/worktree/branch, disposable | a falsifiable plan |
| L3 | Temporary Patch | reversible change with a stated removal plan | a rollback point |
| L4 | Confirmed Change | edit backed by evidence | hypothesis confirmed + alternatives refuted + tests |
| L5 | Structural Change | architecture-level edit | L4 evidence + pre-mortem + reversible plan + checkpoint |

## Rules

1. The declared level bounds the edit. A "quick experiment" that mutates production config is an L4 wearing an L2 mask — blocked by the mutation gate.
2. Level jumps skip only with new evidence, never with confidence: Hypothesis (L1) → Structural (L5) is the forbidden jump.
3. Downgrading is always allowed and is a virtue: "this evidence only supports an experiment" → run the experiment, not the rewrite.

## Evidence gates

- level declared in the ledger before each edit
- L5 edits show the L4 evidence chain (confirmed hypothesis + tests) in the ledger

## Machine check

```bash
grep -E '^level: L[0-5]' .loopfocus/ledger.md   # every edit declares its level
```

## Anti-patterns

- Declaring L2 and leaving the experiment in the production path
- "It's small" as justification for an L5 (smallness is Minimum Intervention, not evidence)
- Never declaring a level — undeclared edits default to the highest level the diff implies, which is the most expensive way to be caught

## Example

Auth fix: hypothesis "the middleware loop never exits" (L1) → the edit removing the loop is L4 only after the hang-guard test refutes the alternative ("the timeout is elsewhere") and confirms the loop is the cause. Rewriting the whole auth stack (L5) on the same evidence would be the forbidden jump.
