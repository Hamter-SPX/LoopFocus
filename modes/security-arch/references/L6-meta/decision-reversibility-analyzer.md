# Decision Reversibility Analyzer

## What

Classifies every security decision by its reversibility: which roll back in minutes (a config flag), which cost weeks (a key migration), and which are one-way architectural commitments (a data model change, a public API contract).

## Why

Irreversible decisions deserve proportionally more scrutiny than reversible ones — a bad reversible choice is a lesson; a bad irreversible choice is a building. The analyzer forces the classification BEFORE commitment, so the review intensity matches the irreversibility, and the Decision Log records which class each choice belongs to.

## When

L6 — every significant security decision, at proposal time. The Fix Architecture Planner and the Synthesizer both run it on their outputs.

## The classes

| Class | Example | Review requirement |
|---|---|---|
| Reversible | config change, IAM scope tweak, WAF rule | standard review |
| Costly-reversible | key migration, dependency replacement | standard review + rollback plan |
| One-way | data model change, public contract, trust model replacement | pre-mortem + counterexamples + multi-judge (if Critical-adjacent) |

## Protocol

1. At proposal time, classify the decision's reversibility (what would undoing it cost?).
2. Apply the matching review intensity — one-way decisions cannot skip the pre-mortem and the counterexample pass.
3. Record the class in the Decision Log alongside the decision.
4. Track the classification over time: a decision that drifts from reversible to one-way (its surface grew dependents) gets re-reviewed at its new class.

## Evidence gates

- classification recorded at proposal time
- one-way decisions show their pre-mortem + counterexample evidence
- drift between classes re-triggers review

## Anti-patterns

- Reviewing a one-way commitment with reversible-decision speed ("it felt right in the meeting")
- Assuming reversibility because git exists (git reverts code, not data migrations or user-exposed contracts)
- Re-classifying downward (one-way → reversible) to lighten the review — the class is about undo cost, not convenience

## Example

The session-model change (static token → signed sessions) was classified one-way: the old token was embedded in two clients; retiring it meant a forced client update. The pre-mortem + counterexample pass caught the client-compatibility risk, and the migration shipped with a dual-acceptance window — the reversibility classification had forced the planning that made the one-way step safe.
