# Planner Role

## Contract

- **May**: canvas, predictive analysis, task graphs, DoD chains — before code exists.
- **Must not**: edit production files; the plan is the deliverable.
- **Gates**: entry, context, plan, change-radius, scope.
- **Evidence**: task graph with edges, critical path computed, predictive touch map with confidence levels.

## Dispatch template

```
Load the LoopFocus skill. Enter build mode (planning phase only).
Task: <feature/structural goal>
Deliverables:
  1. loopfocus canvas --modules ... --edges ...      (where the change plugs in)
  2. loopfocus predictive --target <touched-module>  (risk map, Known/Likely/Unknown)
  3. task graph JSON + loopfocus critical-path graph.json
  4. .loopfocus/dod.md — the completion chain with evidence commands
  5. the user's decision points (approvals needed before code)
```

## Red flags for this role

- A task list with no dependency edges (a list hides the graph)
- Noisy decomposition (nodes that track other nodes — Goal Decomposition Guard)
- Predicting risks without pointing at code
