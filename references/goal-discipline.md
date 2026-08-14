# Goal Discipline

The anchor. Everything else exists to serve the locked goal.

## Goal Lock

At LOCK, write into `.loopfocus/state.md`:

```text
goal: <one sentence>
invariants:
  - <things that must not break>
profile: LIGHT|NORMAL|DEEP
```

Every subsequent action must answer: "How does this finish the goal?" No answer = drift. Record the answer in the ledger for anything non-trivial.

## Intent Anchor

The user's true intent is stored separately from the prompt's wording. A prompt says "make the button faster"; the intent may be "the page feels unresponsive" — different fixes. Before acting, restate the intent in your own words and confirm it against the evidence of what the user actually wants. Literal compliance with the wrong intent is the expensive kind of bug.

## Anti-Drift Engine

Drift signature: the current edit serves a goal that was never locked and is not the side quest. Classic case: fixing login → rewriting the whole UI. When detected: stop, state the drift in the ledger, return to the locked goal. Drift is not bad intent — it is usually a side quest that forgot to declare itself. Declare it properly or return.

## Scope Firewall

Classify every action you want to take:

| Class | Meaning | Fate |
|---|---|---|
| Required | goal cannot complete without it | do |
| Supporting | helps the goal tangibly | do if small and reversible |
| Optional | nice, unrelated to goal | report (SkillFocus), do not do |
| Unrelated | different goal entirely | blocked |

The classification is written in the ledger for every non-trivial action. Unrelated is blocked by the scope gate.

## Constraint Hierarchy

Constraints conflict. Resolution order:

1. **Hard** — user requirements, safety, API contracts, invariants (never bend; escalate if impossible)
2. **Soft** — stated preferences, style, deadlines (bend only with a recorded reason)
3. **Preference** — user taste (ask)
4. **Assumption** — our own guesses (weakest; testable)

When two constraints collide, the higher tier wins, and the loser is recorded in the decision ledger.

## Invariant Guard

Invariants locked at LOCK are re-checked EVERY loop: API contracts, existing behavior, user requirements, compatibility. A loop that breaks an invariant has regressed even if its tests pass. `scripts/loopfocus-verify.sh` and the regression gate are the machine arms of this guard.

## Contradiction Watch

Watch for actions that contradict earlier requirements — "never change the API contract" while round 8 is about to change the API. Block immediately; re-check the ledger before every execution if the task is long. The watch compares current action against locked constraints, not against memory.

## Minimum Intervention

If the problem is solvable by changing 2 spots, changing 20 files needs a written justification. The smaller the change radius, the smaller the side-effect surface. Minimum Intervention is enforced by the change-radius gate and the mutation gate.

## Change Radius Control

Before executing a plan, count the blast radius: files touched, callers affected, behaviors at risk. Small goal + huge radius = hold and reassess. Either the goal is bigger than stated (Intent Anchor problem) or the plan is wrong.

## Reversible First

With two viable approaches and insufficient data, prefer the reversible one: an experiment over an architecture change, a temporary patch over a migration, a worktree branch over an in-place rewrite. Irreversibility raises the commitment level required, not the confidence — L5 changes need pre-mortem + checkpoint even when confident.

## Dependency Awareness

When goal A is blocked by B, write the dependency edge down (`A blocked-by B` in state.md) and work on B explicitly — as a declared side quest with a budget — instead of looping A and wondering. Looping the blocked node wastes the exact loops this discipline exists to save.

## Critical Path Engine

Tasks form a graph, not a list. Find the edges that actually block completion and work those first. The completion-blocking path is the critical path; polishing a non-blocking node while a blocker sits unhandled violates the attention scheduler.

## Attention Scheduler

Allocate focus by impact: high-impact blockers before low-impact polish. A beautiful button on a broken login flow is drift. The scheduler re-ranks whenever a new blocker appears.

## Auto-Replan

When reality contradicts the plan, do not force the plan and do not abandon the goal. Replan only the affected portion: new dependencies, new evidence, changed constraints → update the plan section, keep the locked goal, record why in the decision ledger. The goal stays locked while the route changes.

## Goal Decomposition Guard

Decompose the goal into Necessary / Helpful / Optional / Noise — then delete Noise. Agents love managing task trees more than doing tasks; a decomposition with more management than work is itself drift. YAGNI at agent level: if deleting a node changes nothing about goal completion, delete it.

## Anti-patterns

- Locking the goal, then "discovering" a better goal mid-task and switching silently
- Escalating every constraint collision instead of resolving by the hierarchy
- Keeping a side quest alive after its budget died because it is interesting
- Replanning the whole task because one edge changed
- Calling scope expansion "thoroughness"
