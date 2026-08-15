# Loop Strategy Ladder

## What

A fixed escalation ladder of six strategy rungs. When a fix attempt fails, you move DOWN one rung. You never re-word and retry the same rung.

```
S1 Direct Fix
    ↓ fail
S2 Root-cause Trace
    ↓ fail
S3 Reproduce Minimal Case
    ↓ fail
S4 Search/Inspect Dependencies
    ↓ fail
S5 Alternative Implementation
    ↓ fail
S6 Escalate
```

## Why

Baseline testing (RED phase, 2026-08-15) showed the dominant failure mode: an agent performing 3 reworded retries of the same boundary-math approach before inspecting the dependency where the real cause lived. The ladder converts "try again" into "try differently" structurally: each rung is a different *class* of action, so repeating requires deliberately stepping back up — which the Repeat Gate blocks.

## When

- After every FAIL signal (flat or negative delta) on a fix attempt.
- NOT while converging (failures dropping loop-over-loop) — convergence keeps the current rung.
- NOT after an environment/flaky failure — CI Reliability resolves those first.

## Protocol

1. Record the failing rung + fingerprint in the ledger before moving.
2. Write the next rung's hypothesis (new hypothesis — not the old one rephrased).
3. Execute the new rung. One rung per loop.
4. Two failures in the same strategy family → family banned (genome auto-ban); the ladder is the only path forward.
5. S6 is a correct outcome: escalate with goal + attempts + failures + evidence paths + what is needed. Escalation is not defeat — the ladder's last rung exists precisely so escalation happens early, with a complete evidence package.

## Rung details

| Rung | What it does | When it wins |
|---|---|---|
| S1 Direct Fix | smallest edit at the failure site | the cause is local and visible |
| S2 Root-cause Trace | follow the fault path backward: input → transform → output | the symptom is downstream of the cause |
| S3 Reproduce Minimal Case | shrink the failing scenario until only the fault remains | the failure has confounders |
| S4 Inspect Dependencies | read every module in the failing path (caller AND callees) | the caller edit changed nothing (signal: delta +0) |
| S5 Alternative Implementation | replace the failing mechanism, not patch it | the mechanism itself is wrong |
| S6 Escalate | package the evidence, hand to the user | all five rungs failed with records |

## Evidence gates

- each rung change has a ledger entry (hypothesis + test plan + expected)
- the signal shows delta or the rung advanced — both is better
- banned families are never re-entered without new evidence

## Machine check

```bash
node scripts/loop-genome.js query --class <problem-class>
# banned: <families> → the ladder may not re-enter these
```

## Anti-patterns

- "The third time is the charm" — no. New rung or stop.
- Jumping S1 → S5 because the big rewrite "feels decisive"
- Re-entering a banned family because the failure message changed wording
- Escalating without the evidence package (that's not escalation, it's quitting)

## Example

Attempt 1 (S1): widened the refund window constant → fail, delta +0.
Attempt 2 (S1 reworded): added a grace day → fail, delta +0 → family banned by genome.
Attempt 3 (S4): read `dateUtils.js`, found the timezone sign flip → success.
The ladder forced the dependency inspection that found the real cause in one rung instead of five reworded retries.
