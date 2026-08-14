# Knowledge Discipline

Information ages, conflicts, and floods. These disciplines keep the context true.

## Knowledge Half-Life

Every piece of context has a half-life:

| Data | Freshness | Refresh when |
|---|---|---|
| repository structure | slow-changing | new files/dirs appear |
| test results | stale after code change | any code edit |
| runtime process state | very fast | each observation |
| API docs / README | may drift from code | conflict detected |
| dependency versions | stable between upgrades | lockfile changes |

Tag each belief with its freshness class (in the ledger's assumptions). Refresh only what expired — not everything. The evidence-freshness gate is the machine check for the code-vs-state staleness.

## Context Conflict Resolver

Two sources disagree — README says API v2, code says v3, tests expect v3, user says "latest implementation". Resolution:

1. detect the conflict explicitly (contradictory uncertainty class),
2. prioritize actual current evidence: running code > tests > docs > memory,
3. mark the stale source (README: stale) and record it,
4. never let the agent grab a random source and proceed.

Conflicts are findings, not annoyances — they are usually where the real bug lives.

## Context Distillation

Long tasks bloat context until the goal is forgotten. Periodically distill into "Current Truth" in state.md:

```text
MISSION:        <one line>
MUST PRESERVE:  <invariants, short>
CURRENT BLOCKER: <the one thing in the way>
NEXT PROOF:     <the next discriminating test>
```

The distillation replaces re-reading history. When context grows large, distill rather than summarize. A summary that keeps everything distills nothing.

## Objective Compression

For huge tasks (dozens of requirements), compress the objective into the four-line Current Truth above and pin it. Every loop starts by re-reading the pinned block. This is the anti-forgetting device for long work — the goal survives any amount of intermediate churn.

## Anti-patterns

- Trusting a README over the running code ("it says so")
- Re-running everything because one file changed (refresh only the expired class)
- Distilling by writing longer summaries
- Letting a conflict sit unresolved while work proceeds on both versions
- Updating state.md in prose instead of the pinned Current Truth shape
