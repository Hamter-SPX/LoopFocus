# Oscillation Detector

## What

Catches the two-face failure: fixing A breaks B, fixing B breaks A, in a cycle. The detector stops symptom-chasing and forces the hunt for the shared root cause.

## Why

Oscillation is the most expensive loop in practice — every loop looks like progress (something just turned green) while the total stays broken. It is also the clearest diagnostic signal available: two areas swapping failure means they share a cause, and that cause is usually a coupling the code does not admit.

## When

MEASURE, comparing failure sets across consecutive loops. Trigger pattern:

```
loop 1: A PASS / B FAIL
loop 2: A FAIL / B PASS
loop 3: A PASS / B FAIL     ← oscillation verdict
```

## Protocol

1. Track per-loop failure sets (which tests/areas fail), not just totals.
2. On the swap pattern (2 or more alternations): oscillation verdict. The Oscillation Gate blocks the next symptom edit.
3. Stop editing A and B. Draw the dependency edge between them on the Canvas — the shared root cause almost always sits on that edge (shared state, shared config, a contract both depend on, an order dependency).
4. Write ONE hypothesis about the shared cause. Test it against both failure sets.
5. The fix must change the shared cause, not pad either symptom.

## Evidence gates

- failure sets recorded per loop (test names, not counts)
- the shared-cause hypothesis written before the next edit
- the final fix touches the shared path, provable in the diff

## Machine check

```bash
node scripts/loop-genome.js query --class <problem-class>
# attempts alternate between two strategies with flat deltas = oscillation signature
```

## Anti-patterns

- "Fix A, then B will also be green" (it was, last loop)
- Treating the swap as two independent bugs (it is one cause, two masks)
- Adding a third patch that "keeps both green" without finding the shared cause — that's oscillation with a crutch

## Example

Session loop: auth token fix → session expiry test fails; expiry fix → auth test fails; auth fix again → expiry fails. Detector fired at the second swap. Canvas showed both consuming `config.SESSION_TTL` — the shared constant was being mutated by the expiry "fix". One change to the constant's handling fixed both, permanently.
