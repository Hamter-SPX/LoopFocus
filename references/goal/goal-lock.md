# Goal Lock

## What

The first state of every task: write the objective in one sentence, list the invariants, choose the profile — then hold that lock for the entire task. Every action must be able to answer: "How does this finish the goal?"

## Why

Scope drift is not a decision — it is the absence of one. An unlocked goal silently becomes whatever the current edit serves. The lock makes drift detectable: an action that cannot cite its goal-link is drift by definition.

## When

Always, at LOCK — before the first read, no exceptions, no "this is too small". Small tasks have small locks, but never zero locks.

## What gets locked

```text
goal: <one sentence>
invariants:
  - <must not break>
profile: LIGHT|NORMAL|DEEP
```

- The goal is an outcome, not an activity. "Fix the login hang" — not "investigate the auth code".
- Invariants are the things that must stay true (API contracts, existing behavior, user requirements, compatibility).
- The profile sets the gate strength (see `gate-engine.md`).

## Rules

1. The lock is written in `.loopfocus/state.md` — a lock in memory is an intention.
2. Every non-trivial action records its goal-link in the ledger ("serves goal because: …").
3. A better goal discovered mid-task is a proposal to the user, never a silent re-lock. Goal changes are user decisions.
4. The lock survives context loss (recovery capsule) and handoffs (Handoff Protocol ships it).

## Evidence gates

- `goal:` line present before the first edit (entry gate checks this)
- goal-links recorded for non-trivial actions (mutation gate checks the link, not the vibes)

## Anti-patterns

- Locking a symptom as the goal ("stop the red test") — the red test is evidence, the goal is the behavior
- Re-locking quietly mid-task because the new goal is "obviously better"
- A lock so vague every action can cite it ("improve the code")

## Example

Lock: "goal: checkout form submits and confirms | invariants: existing cart API unchanged, no forced logout | profile: NORMAL". When the temptation arose to also redesign the cart UI, the goal-link test failed — the redesign became a SkillFocus report item instead of an unapproved edit.
