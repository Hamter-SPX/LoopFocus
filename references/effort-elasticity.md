# Effort Elasticity

## What

The core overhead governor: discipline strength scales with difficulty. Simple tasks run light; hard tasks run deep. The skill never weighs more than the task needs.

## Why

A discipline skill fails one of two ways: too light (drifts, retries, hallucinates) or too heavy (every trivial task burns a full ceremony, so agents skip the skill entirely). Elasticity is the fix for the second failure — the mechanism that makes LoopFocus cheap enough to always run, while staying deep where depth pays. The user spec names this explicitly as core: "ทำให้ Super Skill ไม่หนักทุก prompt".

## When

Continuously — the profile and depth re-evaluate at every loop boundary, not just at LOCK.

## The elastic response

| Situation | Response |
|---|---|
| simple task, clear cause | LIGHT profile, L1 depth, minimal ceremony |
| complicated / coupled | NORMAL profile, deeper planning |
| repeated failure | DEEP profile, depth +1, pre-mortem, branch allowed |
| strong progress | maintain current level — do NOT add ceremony to a working loop |
| near completion | narrow focus; completion gate expands its scope |

## Rules

1. Change levels on evidence: escalate when failures repeat or impact is high; lighten when progress resumes. Level changes are recorded in the ledger (a level change is a decision).
2. Never force a heavy profile on a trivial task — ceremony is a cost the user pays in time and tokens.
3. Never stay light while the same failure class repeats — elasticity cuts both ways, and the tax escalates automatically.
4. The minimum is never zero: even LIGHT keeps goal lock, ledger, and completion gate (the cheap core that prevents the expensive mistakes).

## Evidence gates

- level decisions recorded
- no LIGHT profile surviving a repeated failure class (the tax's escalation is visible)

## Anti-patterns

- Full DEEP ceremony on a one-line fix (the user's time is not free)
- Staying LIGHT through three identical failures (that's not elasticity, that's drift)
- Elasticity invoked to justify skipping the completion gate (the minimum never includes skipping it)
