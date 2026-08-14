# Reasoning Discipline

The mind of the loop. Every belief carries a confidence level and an expiration. Guesses are allowed — unlabeled guesses are not.

## Hypothesis Ledger (mandatory per attempt)

Before every fix attempt, write in `.loopfocus/ledger.md`:

```text
## H<n>
- Hypothesis: <what I think the cause is>
- Test plan: <how I will prove or refute it>
- Expected result: <what I predict>
- Actual result: <what happened>   ← filled after OBSERVE
- Verdict: confirmed | refuted
```

No entry = the attempt did not happen. The ledger is the difference between debugging and guessing.

## Confidence Decay

A hypothesis that fails a test loses confidence automatically. Confidence is not loyalty:

- refuted → 0 (move down the strategy ladder),
- untested → keep at Likely, never above,
- confirmed by one test → Likely-strong, not Known,
- confirmed by independent evidence (two different measurements) → Known.

Sticking to an idea because you thought of it first is the exact failure Confidence Decay exists to prevent.

## Commitment Levels

| Level | Name | What it permits |
|---|---|---|
| L0 | Observe | read, run existing tests, no changes |
| L1 | Hypothesis | write ledger entries only |
| L2 | Experiment | isolated sandbox/worktree/branch, disposable |
| L3 | Temporary Patch | reversible change with a stated removal plan |
| L4 | Confirmed Change | edit backed by refuted-alternatives + tests |
| L5 | Structural Change | architecture-level, requires pre-mortem + reversible plan + checkpoint |

Jumping L1 → L5 without supporting evidence is forbidden. Every edit states its level in the ledger.

## Counterfactual Check (before changing X)

Ask: "If X is NOT the cause, what would we observe instead?" If current evidence is equally compatible with X and not-X, changing X is premature — find the discriminating observation first. This kills confirmation bias cheaply.

## Pre-Mortem Loop (before big/expensive rounds)

Ask: "If this approach fails, where will it fail?" Write the top predicted failure points, then add one prevention per point (a test, a boundary check, a smaller first slice). A pre-mortem is mandatory before L5 changes and before S5 alternative implementations.

## Dead-End Prediction (before long/expensive paths)

Estimate: does this path have a credible route to the goal, or is it a well-formed dead end? Signals of dead ends: no discriminating test exists, the change cannot be verified, success requires rewriting an invariant the user locked. Flag the estimate in the ledger; if the path is a dead end, stop before spending the budget.

## Information Gain Routing

When the cause is unknown, choose the action that yields the most NEW information, not the action that looks like the most work. Rank candidate actions by: (a) does the result discriminate between my top hypotheses? (b) cost. Run the most discriminating cheap action first.

## Uncertainty Map

Classify every belief:

- **Known** — verified by evidence I have seen
- **Likely** — pattern match, partial evidence
- **Unknown** — no evidence yet (say so)
- **Contradictory** — two sources disagree (run the Conflict Resolver)

Never operate on a Likely as if it were Known, and never write code against an Unknown without first making it a hypothesis.

## Assumption Registry

Every load-bearing assumption goes into the registry section of the ledger:

```text
## Assumptions
- A1: <assumption> | used-by: <decision/edit> | status: unverified
```

When new information refutes an assumption, immediately walk the registry: find every decision built on it, re-check those, and record the affected work. Refuted assumptions do not linger.

## Decision Ledger

Important decisions (architecture choice, strategy family, scope call) get a dated entry: what was decided, the alternatives considered, why they lost, and what evidence would reopen the decision. A later loop may only reverse a decision with a new reason recorded — never by forgetting the old one.

## Anti-patterns

- Testing a hypothesis by trying to confirm it (choose discriminating tests instead)
- "It worked before" as evidence for current behavior
- Keeping an assumption alive after its refutation because the rework is annoying
- Recording conclusions without the measurement that produced them
- Calling a Likely prediction "will break" in the report
