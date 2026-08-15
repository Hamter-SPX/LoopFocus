# Resilience Envelope

## What

Computes how much failure and compromise the system can absorb while still holding its security invariants: one service down, one credential leaked, one zone hostile — which invariants survive, which fall, at what threshold.

## Why

Every architecture has an envelope: below it, the invariants hold; above it, they collapse. Knowing the envelope is knowing the system's real margin — teams inside the envelope can sleep; teams that have never measured it are guessing. The envelope turns "how secure are we" into "what would it take to break us, exactly".

## When

L6 — computed after the invariants and blast radii exist, and re-computed after every architectural change (the envelope moves with every edge).

## Protocol

1. Take the invariant set and the failure/compromise scenarios (from the Counterfactual Engine).
2. Per scenario: which invariants hold? (The counterfactual verdicts are the raw data.)
3. Find the threshold: the scenario where the FIRST security-relevant invariant falls is the envelope's edge.
4. Report the envelope: what the system survives (with evidence), what breaks it (the threshold scenario), and the margin to the threshold.
5. The threshold scenario becomes the priority-hardening target — raising the envelope = hardening against the first thing that breaks it.

## Evidence gates

- per-scenario invariant survival recorded
- threshold scenario named with evidence
- envelope re-computed after architecture changes

## Anti-patterns

- "We're fine" without knowing the threshold (the envelope IS the answer to "how fine")
- Computing the envelope once and quoting it forever (edges move it)
- Only counting service-down scenarios (compromise scenarios matter more — a hostile insider is a scenario too)

## Example

Envelope results: the system held all invariants with one service down; held most with two down; COLLAPSED when "the admin token leaks" — at which point three invariants fell together (the single-point-of-failure signature). The envelope named the threshold scenario precisely, which promoted the key-split fix from "good idea" to "the thing between us and total invariant loss".
