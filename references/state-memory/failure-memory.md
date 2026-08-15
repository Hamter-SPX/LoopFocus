# Failure Memory

## What

Failures are knowledge, stored with their reasons in the genome. Before starting any task, the memory is queried: what failed, why, which families are banned. The memory prevents both re-invention and repetition.

## Why

A failure nobody reads will happen again — with a different agent, in a different context, with the same shape. The memory is the cross-context immune system: the loop that costs today saves the identical loop tomorrow.

## When

- At LOCK (query the problem class before planning)
- After every failed attempt (record it — the record IS the memory)
- At handoffs (the failures ship in the package, not just the wins)

## What gets stored (per attempt, in the genome)

```text
strategy family + result + delta + reason + hypothesis
```

The `reason` is the memory's payload — "why did this fail" is what the next agent needs, not just "it failed". Auto-ban (2 fails / 0 successes) is the memory's enforcement arm.

## Protocol

1. Query first: `loop-genome.js query --class <similar-class>` — if a family won before, start there; if families are banned, respect the bans.
2. Record every attempt, including successes (winners are memory too — they are the starting point next time).
3. Read the memory before re-attempting anything — including after context loss (the genome survives in the recovery capsule).

## Evidence gates

- a pre-start query recorded in the ledger
- every attempt in the genome with a reason (no empty reasons — a failure without a reason is stored noise)

## Machine check

```bash
node scripts/loop-genome.js query --class <problem-class>
```

## Anti-patterns

- Querying after the first failure ("now I remember to check")
- Recording "fail: it didn't work" (no reason, no memory)
- Treating bans as suggestions (a ban is a structural fact, not advice)
