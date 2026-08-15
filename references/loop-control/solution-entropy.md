# Solution Entropy

## What

Watches solution complexity across loops. When files touched, concepts introduced, and dependencies added keep growing while the problem persists, the solution is exploding — entropy warning.

## Why

An agent under pressure broadens instead of deepens: each failed loop adds a file, a fallback, a config flag. Complexity ↑ + progress flat = the agent is buying activity at the cost of coherence. Entropy detects this before the diff becomes unreviewable and unrevertible.

## When

Every MEASURE, computed from State Integrity (`git-state.js` diff stat) and the genome's attempt history.

## The signal

| Complexity | Progress | Entropy verdict |
|---|---|---|
| flat or shrinking | any | fine |
| growing | rising | acceptable (real work adds surface) |
| growing | flat | **entropy warning** |

Complexity metric = cumulative files/concepts/dependencies touched by the current attempt family, not the final diff.

## Protocol

1. Entropy warning → stop adding surface. No new files, no new deps, no new mechanisms.
2. Simplify: return to the last stable checkpoint (Branch-and-Recover), discard the accreted patches.
3. Re-hypothesize at L5 depth: the cause is deeper than the patches reached. Pre-mortem the next attempt.
4. Record the entropy episode in the ledger: what grew, what it cost, what was discarded.

## Evidence gates

- diff stat tracked across loops (State Integrity)
- entropy episode ends with a checkpoint return, not another patch

## Machine check

```bash
node scripts/git-state.js
# watch diff_stat / untracked_files grow across loops
```

## Anti-patterns

- "One more fallback and it will work" — that's the entropy voice
- Declaring the growing diff "thoroughness" (thoroughness adds evidence, not surface)
- Keeping the accreted patches "in case" after the checkpoint return

## Example

Refund bug: loop 1 touched 1 file, loop 2 touched 3, loop 3 touched 7 — with flat deltas. Entropy warning fired; checkpoint return discarded 9 files of fallbacks; the L5 re-hypothesis found the timezone sign flip in one dependency. Final diff: 1 file, 1 line.
