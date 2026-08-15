# Decision Ledger

## What

A dated record of important decisions: what was decided, the alternatives considered, why they lost, and what evidence would reopen the decision. Reversals require a new recorded reason.

## Why

Context loss erases the WHY of decisions, and later loops quietly reverse them — or worse, keep them without knowing they were decisions. The ledger makes every important choice an audit trail entry, so future loops argue with the record instead of with their own memory.

## When

- Architecture choices ("why strategy A, not B")
- Strategy-family selections and bans
- Scope rulings (what was classified Optional and deferred)
- Constraint resolutions (which tier won a collision, and why)

## Format (ledger section)

```text
## Decisions
- <date> <decision> | alternatives: <what lost and why> | reopen-if: <evidence that would change it>
```

## Rules

1. The `reopen-if` clause is mandatory — a decision without a reopening condition is a belief wearing a decision's costume.
2. Reversals append a new entry citing the new evidence; they never edit the old one (the old entry explains the old world, which future agents may still need).
3. Reversing a decision that other work depends on triggers the assumption walk-back (see `assumption-registry.md`).

## Evidence gates

- important decisions present with alternatives + reopen-if
- reversals cite new evidence, never "I changed my mind" alone

## Anti-patterns

- Recording decisions after the fact without the alternatives ("we decided X" — why?)
- Reopening a decision with no new evidence (that's drift with a citation)
- A decision ledger nobody queries at LOCK (the record exists to be consulted first)

## Example

E2E session: "2026-08-15: strategy family boundary-constant banned | alternatives: dependency-inspection (chosen later) | reopen-if: a test shows the constant itself produces the wrong cutoff" — the ban survived context loss in the genome, and the reopening condition made the ban falsifiable instead of arbitrary.
