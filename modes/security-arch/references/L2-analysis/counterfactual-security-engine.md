# Counterfactual Security Engine

## What

Runs "what if" worlds against the architecture: What if Auth is compromised? What if an API key leaks? What if the DB becomes read-only? What if an attacker gets a normal account? — and computes which invariants survive and which fall in each world.

## Why

Security designs are tested by their counterfactuals, not their happy path. A system that looks secure while everything works may have zero survivability the moment one assumption breaks. The engine stress-tests the model itself — the cheapest form of red-teaming — and surfaces the single-assumption collapses before an attacker does.

## When

L2/L3 — after invariants exist, before and after every architectural change. The Recursive Challenge runs it on each repaired design.

## Protocol

1. Enumerate the counterfactual worlds: each key component compromised/unavailable/hostile + each key credential leaked + each isolation boundary failed.
2. Per world: walk the model — which trust edges still hold, which invariants survive, which data classes become reachable?
3. Classify: world survivable (invariants hold) / degraded (partial) / catastrophic (Crown Jewel reachable).
4. Catastrophic worlds are findings: "if X falls, everything falls" — the fix is architectural (blast-radius reduction, isolation, key separation), not patch-level.
5. Record worlds + verdicts in the ledger; the Recursive Challenge re-runs them after each repair.

## Evidence gates

- worlds enumerated per key component/credential/boundary
- per-world invariant survival recorded
- catastrophic worlds become findings with architectural fixes

## Anti-patterns

- Only asking "what if an attacker arrives" (the more useful question is "what if THIS breaks")
- Catastrophic verdicts left as observations instead of findings
- Re-running the same worlds after a fix that changed nothing about them

## Example

"What if the admin API key leaks?" — the key was ALSO the session signing key, so the world showed: token forgery + admin access + config read = catastrophic. The finding: key role separation — session signing and admin access must be different keys. The counterfactual found the single-assumption collapse that a code scan structurally cannot see.
