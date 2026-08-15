# Invariant Guard

## What

The invariants locked at LOCK are re-checked EVERY loop — before the edit (would this break one?), and after (did it?). A loop that breaks an invariant has regressed even if its own tests pass.

## Why

Invariants are the quiet contracts: API shapes, existing behavior, compatibility promises. A passing test suite can sit on top of a silently broken contract for weeks. The guard makes contract preservation a per-loop check instead of a release-day surprise.

## When

- At LOCK: list the invariants (state.md `invariants:`)
- Before every EXECUTE: the mutation gate asks "does this edit risk any invariant?"
- After every OBSERVE: the regression gate + explicit invariant checks

## Protocol

1. Each invariant gets a check: a test, a command, or an explicit verification step. An invariant with no check is a wish.
2. Before an edit that touches an invariant's surface: run its check first (the before-state must be clean — a broken invariant discovered mid-task is a finding, not part of the fix).
3. After the edit: re-run. Changed behavior on an invariant = regression → ROLLBACK, regardless of the new feature's tests.
4. Invariant checks live in the DoD graph for feature work (M4) — "no regression" node includes them explicitly.

## Evidence gates

- invariants listed with their checks at LOCK
- invariant checks re-run every loop that touches their surface (visible in gate outputs)

## Machine check

```bash
bash scripts/gate-runner.sh     # regression gate compares against .loopfocus/metrics
bash scripts/loopfocus-verify.sh
```

## Anti-patterns

- "That API has no consumers, changing it is fine" — an unverified claim about an invariant (check the callers)
- Checking invariants only at the end (the loop between break and check is where the damage compounds)
- Invariants so vague they can't fail ("keep it good")

## Example

Lock: "invariants: formatOrderTotal(2) === '2.00' | check: test/app.test.js sentinel". The epsilon fix changed rounding for 1.005 → 1.01 — the sentinel re-ran and proved 2 → 2.00 still held. Without the guard, the fix could have shipped a new rounding rule for whole numbers by accident, and no failing test would have noticed.
