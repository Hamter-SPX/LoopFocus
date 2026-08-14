# Focus State Machine

The rhythm of every task. Move to the next state only when the current one is complete. Every transition passes through the Gate Engine.

## States

| State | Question answered | Output artifact |
|---|---|---|
| LOCK | What exactly is the goal? | `goal:` line in `.loopfocus/state.md` + invariants |
| EXPLORE | What does the code actually say? | evidence list in ledger (file:line) |
| HYPOTHESIZE | What do I think the cause is, and how do I test it? | hypothesis entry in ledger (H1, H2, …) |
| EXECUTE | What is the smallest action at my commitment level? | diff + commit (rollback point) |
| OBSERVE | What actually happened? | test output, logs, metrics → evidence file |
| MEASURE | Did the world get better, by how much? | normalized signal (delta, progress) |

## Transitions (MEASURE decides)

| Signal | Transition | Action |
|---|---|---|
| Progress (delta > 0, no regressions) | CONTINUE | next loop, same strategy family |
| Drift (action no longer serves goal) | REFOCUS | restate the locked goal, return to EXPLORE |
| Stuck (flat/negative delta, same failure class) | MUTATE | banned strategy + next ladder rung |
| Regress (previously passing broke) | ROLLBACK | restore last passing checkpoint |
| Blocked (external dependency, no path) | ESCALATE | report with evidence, stop looping |

## Side-Quest Sandbox

Sometimes the root cause lives outside the goal's surface. That is allowed — but only as a bounded side quest:

1. Declare it: `side-quest: <question> | budget: <N loops or M minutes> | returns-to: <main goal>` in the ledger.
2. Every loop inside the side quest consumes budget. Over budget without progress → terminate the branch and return to the main goal (Focus Budget).
3. A side quest never becomes the new goal silently. Returning is mandatory, and the return is recorded.

## Dynamic Focus Depth

Loop depth scales with difficulty. Start shallow; deepen automatically.

| Level | Name | When |
|---|---|---|
| L1 | Quick | small, clear task — light profile, few loops |
| L3 | Persistent | first obstacles — normal profile, full ledger |
| L5 | Deep | repeated failure / coupled code / security — DEEP profile, branch-and-recover allowed |
| L8 | Extreme | repeated non-convergence, system-wide change — worktree branching + pre-mortem + independent re-check |

Escalate one level per sustained failure class, never jump L1→L8 without evidence. Descend when progress resumes.

## Anti-patterns

- Executing before EXPLORE ("I know this codebase")
- Two hypotheses tested in one edit (no attribution possible)
- Skipping MEASURE and narrating the outcome from memory
- Treating a side quest's results as the main goal's progress
- Staying at L1 depth while the same failure repeats

## Evidence gates

- LOCK: `goal:` recorded, invariants listed, profile chosen
- EXPLORE: at least one file:line evidence per claim about the code
- HYPOTHESIZE: hypothesis + test plan + expected result written before the edit
- EXECUTE: diff committed (rollback point exists)
- OBSERVE: raw output saved to an evidence file with attempt number
- MEASURE: normalized signal produced
