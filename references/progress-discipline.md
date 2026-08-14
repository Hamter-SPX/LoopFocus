# Progress Discipline

Claims are cheap; deltas are not. This discipline binds the word "progress" to evidence.

## Progress Proof

"Making progress" as a claim is worthless. Only evidence counts:

- test failures 14 → 3,
- compile errors 8 → 0,
- affected files shrinking,
- a hypothesis confirmed (information gain).

Every progress statement in a report cites its measurement. No measurement = no progress claim.

## Progress Delta

A loop's worth is its delta: how much the situation improved, in numbers. Activity (edits, commands, reads) is not delta. Delta ≈ 0 across multiple loops = NO_PROGRESS → No-Progress Tax applies. Delta is produced by the Signal Normalizer and recorded in the genome.

## Definition-of-Done Graph

Not a TODO list — a chain of conditions that must be true, in order:

```text
feature works → tests pass → no regression → verify → done
```

Written into `.loopfocus/dod.md` at LOCK (M4 requires it; bug fixes may inline it in state.md). Each node has its evidence command. Incomplete chain = not done, no matter how good the work feels.

## Regression Sentinel

Progress in one area must not hide collapse in another. Every loop re-checks previously passing things: 12 tests passing before, 9 after = net negative, whatever the new feature does. The regression gate compares against `.loopfocus/metrics`. The sentinel is why "it works on my machine" cannot close a loop.

## Evidence Freshness

Evidence expires when the code changes. A test run that predates the latest edit certifies nothing — re-run before claiming. The evidence-freshness gate compares file mtimes against state.md. Stale evidence is recorded, not reused.

## State Integrity

Know the workspace state between loops, not just at the end:

```text
before: tests 98/100, modified files 3, known issue X
after:  tests 91/100, modified files 14, known issue X
→ regression alarm → do not continue blindly
```

`node scripts/git-state.js` feeds this: changed files, commits, diff stat. State Integrity is navigation feedback during the loop — the final verification cannot be the first time the numbers are seen.

## Anti-patterns

- Reporting "significant progress" from vibes
- Re-running only the new test and calling the suite green
- Treating a stale CI pass as current
- Writing the DoD graph after the work is done (it exists to guide, not to justify)
- Ignoring a growing modified-file count while "the fix is almost done"
