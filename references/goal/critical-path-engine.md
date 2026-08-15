# Critical Path Engine

## What

Tasks form a graph, not a list. The engine finds the edges that actually block completion — the critical path — and work follows that path first.

## Why

Effort on non-blocking nodes is the classic schedule illusion: busy and blocked at the same time. The engine reorders work by the completion graph: the chain that must finish in sequence gets the attention; the parallel slack absorbs delays. It is the Attention Scheduler's structural input.

## When

- Plan time for multi-part work (features, migrations, audits with many findings)
- Re-plan time (Auto-Replan recomputes the path when edges change)
- Whenever a blocker appears mid-task (the path re-routes instantly)

## Protocol

1. List tasks with their edges: "X depends-on Y", "A blocks B".
2. Find the longest chain to completion — that's the critical path. Work it first.
3. Non-critical nodes wait. Their slack is not free time for polish — it is buffer for the critical path's surprises.
4. When an edge changes (new blocker, cleared block), recompute. The path is a living structure, not a list.

## Evidence gates

- task graph with edges written at plan time (in the ledger/plan)
- work order matches the path (visible in commit order)

## Anti-patterns

- A flat task list with no edges (a list hides the graph; the graph is the work)
- Polishing a non-blocking node while a blocker sits on the path (see the Scheduler)
- Computing the path once and never re-checking after a new blocker lands

## Example

Migration plan: tests can't pass until the schema lands; the schema can't land until the backfill proves lossless. Critical path: backfill → schema → tests. The engine's order put the backfill proof first; the tempting "easy UI updates" waited — and the waiting time absorbed the backfill's surprises without delaying the goal.
