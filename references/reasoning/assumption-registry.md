# Assumption Registry

## What

A dated list of every load-bearing assumption, with the work that depends on each. When new information refutes an assumption, the registry points at everything that must be re-checked.

## Why

Assumptions are invisible load-bearing walls. Work gets built on "the API never returns null" or "this list is already sorted"; the wall falls silently months later, and nobody remembers which parts were standing on it. The registry makes the walls visible and the damage path computable.

## When

- Every LOCK (assumptions the goal rests on)
- Whenever an edit's correctness depends on an unverified property
- After any OBSERVE that contradicts one (the trigger for the walk-back)

## Format (ledger section)

```text
## Assumptions
- A1: <assumption> | used-by: <decision/edit/commit> | status: unverified | added: <loop>
- A2: <assumption> | used-by: <...> | status: verified | evidence: <file:line / test>
```

## The walk-back protocol

When evidence refutes an assumption:

1. Mark it refuted with the evidence.
2. Walk the `used-by` links — every decision/edit built on it is now suspect.
3. Re-check each dependent: does it still hold on the new truth? Record per item: holds / needs rework / already broken.
4. Re-verify the dependents that hold (Evidence Freshness — their old verification predates the new truth).
5. The walk-back is a recorded task, not a mental note.

## Evidence gates

- load-bearing assumptions listed at LOCK
- each assumption has a status + used-by links
- refutations trigger a recorded walk-back

## Anti-patterns

- Keeping an assumption alive after refutation because the rework is annoying
- Assumptions with no used-by links (a wall nobody stands on was never load-bearing)
- Verifying an assumption by reading the comment that states it (comments assert; tests verify)

## Example

Refund bug: A1 "the service owns the refund-window math" (used-by: attempts 1-3) — refuted by the probe showing the util computes the diff. Walk-back: attempts 1-3's reasoning re-examined; the window-constant family re-classified as built on a false assumption; ladder advanced to S4. The registry made the re-classification a mechanical consequence instead of a slow realization.
