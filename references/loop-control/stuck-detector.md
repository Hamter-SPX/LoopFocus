# Stuck Detector

## What

Distinguishes "working on a hard problem" from "stuck in a loop". Hard work changes its fingerprint every loop; a stuck loop repeats the same one.

## Why

The two states demand opposite responses: hard work needs CONTINUE with deeper depth; stuck needs MUTATE. Treating stuck as hard wastes loops; treating hard as stuck abandons a converging approach. Baseline testing showed agents cannot tell the difference under pressure — they narrate stuck loops as "progress".

## When

Every MEASURE state. Especially when tempted to write "still working on it" for the third time.

## Detection — the fingerprint

A loop has a fingerprint: `files touched + error class + approach + result`. Stuck is any of:

- **same error** — identical message/class across consecutive loops
- **same diff** — same files, same edit shape
- **same test failure set** — the same N tests fail, no new information
- **same reasoning** — the next hypothesis is the previous one reworded ("maybe if I also…")

Two consecutive identical fingerprints = stuck, regardless of how much activity happened between them (commands run, files read, prose written).

Hard work, by contrast: the failure set shifts, the error class changes, the hypothesis genuinely differs, information is gained (even refutations count).

## Protocol

1. Record the fingerprint each loop (ledger line: `fingerprint: files=X error=Y approach=Z`).
2. Compare against the previous loop. Identical → stuck verdict.
3. Stuck verdict → MUTATE: strategy family banned, ladder advances one rung, depth +1 level.
4. Hard verdict → CONTINUE at current depth; optionally deepen if the problem warrants (effort elasticity).

## Evidence gates

- fingerprints recorded for consecutive loops
- stuck verdict followed by a genuinely different next attempt (verifiable in the diff)

## Machine check

```bash
node scripts/loop-genome.js query --class <problem-class>
# two identical attempts (same strategy, same failure reason) = the machine already banned the family
```

## Anti-patterns

- Calling activity progress ("I ran 14 commands")
- Declaring stuck after ONE failed loop (a single failure is information, not a loop)
- Changing two variables to "escape" the fingerprint (that's retry with confounders — blocked by the oscillation gate's cousin, unattributable change)

## Example

Loop 1: edit caller, `TypeError: utils.greet is not a function`. Loop 2: edit caller differently, same error, same test failure. Fingerprints identical → stuck. Verdict forced the S4 dependency inspection that found the export-key typo. The agent's own narration said "close, one more try" — the detector overrode it.
