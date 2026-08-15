# Context Conflict Resolver

## What

When context sources disagree — README says API v2, code says v3, tests expect v3 — the resolver detects the conflict, prioritizes actual current evidence, marks the stale source, and forbids proceeding on a random grab.

## Why

Conflicts are where real bugs live: the disagreement usually means one source was true once, and the code moved on. Proceeding on a randomly chosen source bakes the stale truth into new work. The resolver turns each conflict into a finding with a verdict instead of a coin flip.

## When

- EXPLORE, when sources disagree (it is a checklist item, not an accident)
- Whenever a stored value contradicts a just-observed one
- Before acting on any doc claim that the code could falsify

## Resolution order (who wins)

1. **running code / actual behavior** (the current truth — observe, don't assume)
2. tests (they encode intended current behavior)
3. docs / README / comments (statements about the code — sometimes true)
4. memory / prior context (a claim about a past state)

## Protocol

1. Detect explicitly: name both sources and the contradiction (uncertainty class: Contradictory).
2. Verify the winner by observation — run the code, run the test. The hierarchy predicts; observation decides.
3. Mark the loser stale (in the ledger): `README (API v2) → stale; code/tests say v3`.
4. Record the conflict as a finding — if it survives the task, it goes to the SkillFocus report ("docs drift: README still documents v2").
5. Never proceed while the conflict is unresolved: an unresolved contradiction is a blocker, not a nuisance.

## Evidence gates

- contradiction named with both sources
- winner verified by observation, loser marked stale
- unresolved conflicts treated as blockers

## Anti-patterns

- Picking the source that agrees with the current plan (that's not resolution, that's shopping)
- Resolving by authority ("the senior wrote the README")
- Proceeding with "probably the code" without actually reading the code
