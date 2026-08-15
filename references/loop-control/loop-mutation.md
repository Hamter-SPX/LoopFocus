# Loop Mutation

## What

The mechanical rule that bans a failed strategy family and forces a change of hypothesis, tool, or approach. It is the operational arm of Hard Rule 1 ("never repeat a failed approach without new evidence").

## Why

Mutation exists because willpower does not survive pressure. Sunk cost whispers "one more try"; exhaustion whispers "just tweak it". The rule does not ask the agent to resist — it removes the option, via the genome's auto-ban, which outlives the temptation.

## When

- 2-3 failures in the same strategy family (genome auto-bans at 2 fails / 0 successes).
- Stuck verdict from the Stuck Detector.
- No-Progress Tax streak ≥ 2.

## What mutation requires

The next attempt must differ in at least one of:

1. **hypothesis** — a genuinely new causal story, not the old one rephrased;
2. **tool** — a different instrument (static analysis instead of print debugging, Playwright instead of unit test, worktree instead of in-place edit);
3. **approach** — a different rung of the strategy ladder, or a different strategy family.

Changing the wording of the same idea is not mutation. Changing the variable names is not mutation. "Also add a fallback" is not mutation.

## Protocol

1. Ban triggers (auto-ban or tax streak) → write the ban in the ledger: `banned: <family> | reason: <failures with deltas>`.
2. Write the new hypothesis BEFORE choosing the new action (the mutation must be causal, not random).
3. Execute at the next ladder rung or a different family.
4. The ban persists in the genome — it outlives this context and applies to any future agent on this problem class.

## Evidence gates

- ban recorded with reasons
- the mutated attempt's diff proves the change (different files or different mechanism)
- bans visible in the genome (`banned: <families>`)

## Machine check

```bash
node scripts/loop-genome.js query --class <problem-class>
# banned: caller-patch   ← the ladder may not re-enter this
```

## Anti-patterns

- Mutating the prose while the diff is a reworded retry
- Banning a family, then re-entering it "because the error message changed"
- Mutating randomly (a new tool with the same wrong hypothesis is noise, not mutation)

## Example

E2E final scenario: `caller-patch` failed twice with delta +0 → genome auto-banned it → mutation forced `dependency-inspection` → export-key root cause found on the next attempt. The ban, not discipline, produced the correct move.
