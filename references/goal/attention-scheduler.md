# Attention Scheduler

## What

Focus allocation by impact: high-impact blockers before low-impact polish, every loop. The scheduler re-ranks the work queue whenever a new blocker appears.

## Why

Agents' natural priority is recency and visibility: the pretty problem that is currently on screen beats the ugly blocker that is not. The scheduler inverts it mechanically — impact first — so a beautiful button never gets polished while the login flow is broken.

## When

- Every loop boundary (MEASURE re-ranks the queue)
- When a new blocker appears (it jumps the queue)
- When choosing the next slice in M4 (DoD order, not interest order)

## The ranking rule

Rank by: impact on goal completion (blockers first), then by what unblocks downstream (Critical Path), then by risk of staleness. Polish and cleanup rank last UNLESS they block review (an unreadable diff blocks the reviewer).

## Protocol

1. Keep a live queue in state.md (NEXT section may name only the top item; the queue lives in the ledger).
2. Re-rank at each MEASURE: new evidence changes impact, so the order changes.
3. The top item gets the next loop. Everything else waits — including yesterday's top item.
4. Scheduler decisions are recorded ("chose X over Y because X blocks completion").

## Evidence gates

- queue visible and re-ranked (ledger entries at loop boundaries)
- the chosen next action matches the queue's top

## Anti-patterns

- Doing the most interesting item while a blocker waits (interest is not impact)
- A queue that never changes order (a static queue is a wish list, not a scheduler)
- Polishing the report while a failing gate blocks completion

## Example

Mid-session: bug fixed, but the regression gate shows one old test broken, and the agent notices the error messages are inconsistently worded. Scheduler: the regression is a blocker (completion gate will fail) → fixed first; wording polish ranked last and reported as Optional. The session closed on time with the polish honestly deferred.
