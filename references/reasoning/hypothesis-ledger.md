# Hypothesis Ledger

## What

The mandatory write-before-act record: every fix attempt declares its hypothesis, its test plan, and its expected result BEFORE the edit exists. The actual result is recorded after OBSERVE.

## Why

The ledger is the boundary between debugging and guessing. Guessing has no falsifiable statement, so nothing can end; the ledger forces a statement that the result can kill. Baseline testing (RED 2026-08-15) showed the difference directly: the S2 agent without the skill made 3 reworded guesses; the S2 agent with the skill made 2 ledgered hypotheses and found the root cause with zero wasted edits.

## When

Before every attempt that changes behavior (even an L2 experiment). Reading and observing do not need entries; anything that could be wrong does.

## Format (templates/ledger.md.template)

```text
## H<n>
- Hypothesis: <what I think the cause is>
- Test plan: <how I will prove or refute it>
- Expected result: <what I predict>
- Actual result: <what happened>      ← REQUIRED, starts with "actual result:"
- Verdict: confirmed | refuted
```

The `actual result:` line format is machine-read by `loopfocus-verify.sh` — a ledger without it fails the completion gate.

## Rules

1. One hypothesis per entry. Two causes tested in one edit = zero attribution.
2. The test plan must be discriminating: capable of refuting the hypothesis (see `counterfactual-check.md`). A plan that only confirms is a ritual.
3. Refuted is a successful loop — it shrank the cause space. Record it as proudly as a confirmation.
4. Never edit an old entry. Append a new one (the ledger is an audit trail, not a draft).

## Evidence gates

- entry exists before the edit (verifiable by commit order: ledger commit ≤ edit commit)
- every entry ends with an actual result (verify script checks the line exists)

## Anti-patterns

- Writing the entry after the edit ("documenting what I did")
- A hypothesis so vague it cannot fail ("something is wrong with the state")
- Reusing H2 as a copy of H1 with different words (the fingerprint catches this)

## Example

```
## H2
- Hypothesis: the dependency parses the charge date as UTC, inflating day 30 → 31
- Test plan: isolated probe: daysSince('2026-07-16', ...) with PaymentService removed
- Expected result: probe prints 31
- Actual result: probe printed 31 → dependency math confirmed as the cause
- Verdict: confirmed
```
