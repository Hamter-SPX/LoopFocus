# Hypothesis Engine

## What

Structured reasoning instead of scanning: Observation → Security Hypothesis → Evidence Search → Confirm/Reject → Confidence Update. Every candidate risk is a hypothesis that must earn evidence before it becomes a finding.

## Why

Scanning produces noise: patterns everywhere, verified facts few. The hypothesis loop inverts the flow — the observation first, the falsifiable claim second, the targeted evidence search third. It is the single biggest false-positive reducer in SecurityArch: a hypothesis that cannot find its evidence is REJECTED, not downgraded.

## When

All of L2-L4 — every candidate finding routes through this engine before the Evidence Ledger accepts it.

## The loop

```text
Observation:        the login endpoint returns a token to every user
Security Hypothesis: "any authenticated user can escalate to admin"
Evidence Search:    trace the token's use: which routes accept it? admin checks?
Verdict:            CONFIRMED / REJECTED / INCONCLUSIVE
Confidence Update:  Known (reproduced) / Likely / Unknown — recorded
```

## Protocol

1. Write the observation with its anchor (file:line / behavior).
2. State the hypothesis as a falsifiable claim ("X can reach Y without Z").
3. Search for the discriminating evidence — what would prove OR refute it? (Counterfactual check applies.)
4. Verdict: CONFIRMED (evidence found + preferably reproduced), REJECTED (evidence refutes), INCONCLUSIVE (cannot decide — stays a candidate with the missing evidence named).
5. Update confidence; route: CONFIRMED → Evidence Ledger; REJECTED → Decision Log (negative result); INCONCLUSIVE → Unknown-Unknown pool or exit as UNKNOWN.

## Evidence gates

- hypothesis stated before evidence search (not reverse-engineered after)
- discriminating evidence named (what would refute it)
- verdicts recorded with the evidence that produced them

## Anti-patterns

- Searching evidence that only confirms (confirmation is a ritual, not a test)
- Skipping the loop for "obvious" findings (obvious is a hypothesis too — cheap to verify)
- REPORTING inconclusive hypotheses as findings (they are candidates, labeled as such)

## Example

Observation: ownership is never checked in the cart query. Hypothesis: "user A can read user B's orders by changing the name parameter". Evidence search: the query has no owner filter; reproduction with two users confirmed cross-user reads. CONFIRMED → Known. The same loop on "the rate limiter can be bypassed" found the proxy config applied limits per-IP — REJECTED with the reason recorded. Two candidates, one finding, one negative result — the engine's value in one pass.
