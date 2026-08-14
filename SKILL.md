---
name: loopfocus
description: Use when working on any development task in a repository - fixing bugs, building features, or reviewing code - and the work requires staying locked on the goal, tracing root causes through evidence-based loops instead of symptom patching, finding all issues including low-severity and security risks, avoiding hallucinated answers, and verifying completion with measurable evidence before claiming done
---

# LoopFocus

## Overview

LoopFocus is the execution control discipline for agents. Every loop must have a reason, a state, and feedback — and must converge toward the goal. Looping until tokens run out is failure. Looping until the goal is reached is success.

**Violating the letter of the rules is violating the spirit of the rules.**

## When to Use

Use on EVERY development task: bug fix, feature build, code review, refactor, security audit. No exceptions.

## The Focus State Machine

Every task runs through these states. Move to the next state only when the current one is complete:

```
LOCK        Lock Goal + constraints + invariants (write them down)
  ↓
EXPLORE     Read the repo before touching anything. Evidence first.
  ↓
HYPOTHESIZE Write hypothesis + test plan into the ledger before acting
  ↓
EXECUTE     Act only at the allowed Commitment Level
  ↓
OBSERVE     Collect actual results: errors, diffs, test output, metrics
  ↓
MEASURE     Progress Delta? (numbers, not feelings)
  ↓
 ┌─ Progress → CONTINUE (next loop)
 ├─ Drift    → REFOCUS (back to Goal)
 ├─ Stuck    → MUTATE (change strategy, never retry same approach)
 ├─ Regress  → ROLLBACK (restore last passing checkpoint)
 └─ Blocked  → ESCALATE (report to user with evidence)
```

## Hard Rules — Never Violate

1. Never repeat a failed approach without new evidence.
2. Never expand scope without linking it to the main goal.
3. Never discard a passing state without a rollback point.
4. Never claim progress without measurable delta.
5. Never declare completion while known blockers remain.

## Always-On Behaviors (apply to every task, no mode needed)

1. **Read before edit.** Explore the repo first. Never fix blind.
2. **Root-cause loop.** Dig until the true cause is found. Do not stop at the symptom.
3. **SkillFocus — engineer's eye.** Actively notice every off-looking point (ALL severities, not just critical): inconsistent patterns, risky structures, dead code, smells. Report them with a proposed improvement, then ask the user whether to fix.
4. **Fix policy.** Fix what was asked + fix discovered issues only when provably safe (tests pass, minimal change, reversible, no invariant violation) + report the rest for the user to decide.
5. **No hallucination / self-reject.** If not confident in an answer, reject it and re-verify against evidence until it is on point. Never invent test results, metrics, or file contents.
6. **Verify before done.** Run `scripts/loopfocus-verify.sh` before claiming completion. FAIL means return to the state machine.

## Core Systems

### Goal Lock
Lock the objective at LOCK time. Every action must answer: "How does this finish the goal?" No answer = drift. Stop and return.

### Anti-Drift Engine
Watch for scope creep (fixing login turning into rewriting the whole UI). When detected: stop, state the drift, return to the locked goal.

### Hypothesis Ledger
Before each fix attempt, record in `.loopfocus/ledger.md`:
- What I think the cause is
- How I will test it
- What result I expect
After the attempt, record the actual result. Guessing without a ledger is forbidden.

### Loop Mutation
If the same approach fails 2-3 times, it is banned. Change hypothesis, tool, or approach automatically. Reworded retries of the same approach are the most common failure mode and are never allowed. When boundary-math edits keep failing, stop editing the caller and inspect the dependencies.

### Progress Proof
"Making progress" claims are worthless. Only evidence counts: test failures 14→3, compile passes up, affected files reduced. Loop with no metric improvement = stuck.

### Checkpoint Brain
At every milestone, record in `.loopfocus/state.md`:
- DONE: what is finished
- PROVEN: what is verified
- UNKNOWN: what is still open
- NEXT: the next action
A new agent or fresh context must read this file before doing anything. Commit small and often so git history is also a checkpoint.

### Self-Reject Rule
Before presenting any conclusion, ask: "Can I point to the evidence?" If no — reject the conclusion and go find evidence. If the answer does not directly address the question, reject it and rework it.

## Common Mistakes

| Mistake | Fix |
|---|---|
| Retrying the same fix with new wording | Loop Mutation: after 2-3 identical failures, change hypothesis/tool/approach |
| "I already tested it manually" | Evidence or it did not happen — artifact gate |
| Fixing 20 files for a 2-line problem | Minimum Intervention: change only what the goal needs |
| "Done" while a known blocker remains | Completion gate: blockers = 0 before READY_TO_FINISH |
| Fixing extra issues without asking | Fix policy: ask the user first, report + propose instead of silently expanding |

## Red Flags — STOP and return to the state machine

- Editing files before reading them
- Repeating an approach that already failed
- Claiming progress without a number
- Expanding scope without naming the goal link
- Answering with confidence while evidence is missing
- Declaring done while blockers are known

**All of these mean: pause, record what happened in `.loopfocus/`, and resume at the correct state.**
