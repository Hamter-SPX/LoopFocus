# Security Time Machine

## What

Compares the architecture of previous versions against the current one and answers: which risks appeared, since which commit/version, and whether any old risk silently returned.

## Why

Security regressions are usually introductions: a change adds a trust edge, opens a port, widens a role. The Time Machine pinpoints the introduction moment — turning "we have a risk" into "this commit introduced the risk", which is what makes fixes fast and reverts honest.

## When

After a re-map or a semantic diff, when a new risk appears. Also on demand: "when did we become exposed to X?".

## Protocol

1. Keep snapshots of the World Model at milestones (the model is committed; git history IS the time machine).
2. On a new risk: diff the current model against the last clean snapshot — which edges, zones, privileges, or invariants changed?
3. Trace the changed edge to its introducing commit/version.
4. Answer the three questions: what appeared? since when? what did it replace?
5. Record the answer in the Decision Log — the history of risk introductions is itself an audit artifact.

## Evidence gates

- model snapshots exist (committed World Model = the machine)
- new risks traced to introducing changes
- introduction history recorded

## Anti-patterns

- Re-auditing from scratch because nobody saved the old model (git commits are free — commit the model)
- "We've always been exposed" without checking (the Time Machine checks)
- Comparing versions by file count instead of model edges (security lives in edges, not files)

## Example

"Since when is /debug unauthenticated?" — model diff: the debug route was added 2026-07-11 in commit 9f3c2a1 "add diagnostics helper", which bypassed the auth middleware because it was registered before it. One question, one commit, one fix. Without the machine, the answer would have been "we don't know".
