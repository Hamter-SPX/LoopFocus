---
name: loopfocus
description: Use when working on any development task in a repository - fixing bugs, building features, or reviewing code - and the work requires staying locked on the goal, tracing root causes through evidence-based loops instead of symptom patching, finding all issues including low-severity and security risks, avoiding hallucinated answers, and verifying completion with measurable evidence before claiming done
---

# LoopFocus

## Overview

LoopFocus is the execution control discipline for agents. Every loop must have a reason, a state, and feedback — and must converge toward the goal. Looping until tokens run out is failure. Looping until the goal is reached is success.

**A loophole is a violation. If the words of a rule let you skip it, the rule still applies.**

```text
LOCK goal → EXPLORE evidence → HYPOTHESIZE with a ledger
→ EXECUTE at the allowed commitment level → OBSERVE actual results
→ MEASURE progress delta → CONTINUE / REFOCUS / MUTATE / ROLLBACK / ESCALATE
→ verify through the Gate Engine → record in the Loop Genome → FINISH with evidence
```

## Core Laws

1. Never repeat a failed approach without new evidence.
2. Never expand scope without linking it to the main goal.
3. Never discard a passing state without a rollback point.
4. Never claim progress without measurable delta.
5. Never declare completion while known blockers remain.
6. Never present a conclusion you cannot point at evidence for.
7. Never ask the user to choose between unmeasured options.

## How the Discipline Layers Work

| Layer | Role | Where |
|---|---|---|
| **Focus State Machine** | The rhythm — states every task walks through | `references/state-machine.md` |
| **Gate Engine** | The checkpoints — every transition is gated | `references/gate-engine.md` |
| **Loop Control** | The brakes — anti-retry, anti-oscillation, convergence | `references/loop-control/` (9 systems) |
| **Reasoning Discipline** | The mind — hypotheses, uncertainty, counterfactuals | `references/reasoning/` (10 systems) |
| **Goal Discipline** | The anchor — intent, scope, constraints, dependencies | `references/goal/` (16 systems) |
| **Progress Discipline** | The measurement — proof, DoD, sentinel, freshness | `references/progress/` (4 systems) |
| **State & Memory** | The survival kit — checkpoints, recovery, handoff | `references/state-memory/` (6 systems) |
| **Knowledge Discipline** | The freshness — half-lives, conflicts, compression | `references/knowledge/` (3 systems) |
| **Effort Elasticity** | The governor — cheap on easy, deep on hard | `references/effort-elasticity.md` |
| **Focus Depth** | The dial — L1 Quick → L8 Extreme | `references/dynamic-focus-depth.md` |
| **SkillFocus** | The eye — notice everything, propose, ask | `references/skillfocus.md` |
| **ToolBus** | The sensors — tools feeding one normalized signal | `references/toolbus.md` |

For a fast path through a common task, start at `flow/README.md` and follow the flow that matches the work: bug fix, feature build, security audit, review, or recovery.

## Modes

Every task runs in a mode. A mode is a contract: what may be done, what gates produce its evidence, what must be true before it closes. Default behaviors (state machine, ledger, gates, SkillFocus) apply in every mode.

| Mode | Trigger words | Extra discipline | Reference |
|---|---|---|---|
| **M3 — SecurityArch** | security, audit, scan, vulnerab, CVE, secure | intense: 126 systems in 8 layers (World Mapping → Self-Challenging → Cross-Layer HW-SW) + Constitution + End-to-End Trust Proof, DEEP always | `modes/security-arch/DOCS.md` + `flow/security-audit-flow.md` |
| **M4 — Build** | build, feature, add, implement new | Intent Anchor, DoD graph, Canvas + Predictive before code | `references/build-mode.md` + `flow/feature-build-flow.md` |

Announce every mode crossing so the user can stop it. `resolve`-style routing: pick the mode from trigger words; entering no mode at all is fine for small fixes — default discipline still applies.

## Always-On Behaviors (every task, no mode needed)

1. **Read before edit.** Explore the repo first. Never fix blind.
2. **Root-cause loop.** Dig until the true cause is found. Do not stop at the symptom.
3. **SkillFocus — engineer's eye.** Notice every off-looking point (ALL severities, not just critical). Report with a proposed improvement, then ask the user whether to fix.
4. **Fix policy.** Fix what was asked + fix discovered issues only when provably safe + report the rest for the user to decide.
5. **No hallucination / self-reject.** If not confident, reject the answer and re-verify against evidence until it is on point.
6. **Verify before done.** Run `scripts/loopfocus-verify.sh` before claiming completion. FAIL means return to the state machine.

## Gate Profiles (effort elasticity)

Not every gate fires on every task. Pick the profile at LOCK; escalate on repeated failure or high impact; lighten on strong progress.

| Profile | Gates | When |
|---|---|---|
| LIGHT | entry, build, test, completion | simple task |
| NORMAL | + static, regression, evidence-freshness, checkpoint | many files / architecture |
| DEEP | + artifact, and judgment gates go strict | repeated failure / high impact |
| Near completion | completion gate expands scope | close to done |

Machine gates run via `bash scripts/gate-runner.sh`. Judgment gates are self-checks recorded in the ledger. Details: `references/gate-engine.md`.

## Loop Strategy Ladder

When an approach fails, move down the ladder — never reword and retry the same rung:

```
S1 Direct Fix → S2 Root-cause Trace → S3 Reproduce Minimal Case
→ S4 Inspect Dependencies → S5 Alternative Implementation → S6 Escalate
```

Details: `references/loop-control/loop-strategy-ladder.md`.

## Commitment Levels

Not every reasoning result becomes a code edit:

```
L0 Observe → L1 Hypothesis → L2 Experiment → L3 Temporary Patch
→ L4 Confirmed Change → L5 Structural Change
```

Jumping from L1 to L5 without supporting evidence is forbidden. Details: `references/reasoning/commitment-levels.md`.

## Canvas (available anytime)

Structural explanation — current architecture, a proposed feature structure, impact of a change — is drawn before implementation: Mermaid/ASCII in chat, edge labels = data flow, invariants marked. On approval, save as `docs/loopfocus-canvas-<topic>.md`. Never draw boxes for files you have not read. Details: `references/canvas.md`.

## Predictive Analysis (before features or coupled changes)

Predict where bugs will emerge, evidence-based: touch map → risk factors (coupling, complexity, churn, missing tests, concurrency, data flow) → confidence levels (Known / Likely / Unknown — never present Likely as Known) → prevention suggestions recorded in the ledger. Details: `references/predictive-analysis.md`.

## ToolBus Quick Reference

```bash
bash scripts/tool-discovery.sh                     # detect project tools → .loopfocus/gates.conf + tool-map.md
bash scripts/fast-gate.sh                          # build → static → test, stop at first failure
bash scripts/gate-runner.sh                        # machine gates for the current profile
bash scripts/loopfocus-verify.sh                   # completion gate
bash scripts/mutation-test.sh                      # DEEP: prove tests catch bugs (mutation score)
bash scripts/coverage.sh                           # DEEP: coverage % vs threshold
bash scripts/sast.sh                               # DEEP: static security scan (curated rules)
bash scripts/fuzz-check.sh                         # DEEP: go fuzz / python hypothesis
node scripts/normalize-signal.js --source local:test --status fail \
  --previous-failures 17 --current-failures 3 --attempt 12
node scripts/loop-genome.js record --class <cls> --strategy <s> --result fail|partial|success --delta <n> --reason "..." --hypothesis "..."
node scripts/loop-genome.js query --class <cls>    # what won for this problem class before
node scripts/git-state.js                          # changed files, commits, diff stat
node scripts/git-state.js worktree-new attempt-b   # branch A/B/C in isolated worktrees
node scripts/ci-controller.js failed-jobs <run-id> # CI Matrix Brain: focus the failure domain
```

Chat AI without tools? Use `LOOPFOCUS_ALL_IN_ONE.md` — paste the whole file; the discipline runs in chat (Part 0).

Full ToolBus: `references/toolbus.md`.

## Non-Negotiable Red Flags

Stop and return to the correct state when any of these occurs:

- Editing files before reading them
- Repeating an approach that already failed
- Claiming progress without a number
- Expanding scope without naming the goal link
- Answering with confidence while evidence is missing
- Declaring done while blockers are known
- Fixing a symptom while the root cause is untraced
- Trying a third reworded retry of the same approach family
- Fixing extra issues without asking the user first
- Restarting work after context loss without reading `.loopfocus/state.md`
- Trusting a test run that predates the latest code change
- Watching failures oscillate between two areas and fixing symptoms anyway
- Letting solution complexity grow while progress is flat
- Adding a dependency because it is convenient, without a goal-linked reason
- Presenting a prediction marked Likely as if it were Known
- Claiming READY_TO_FINISH without a passing `loopfocus-verify.sh`

**All of these mean: pause, record what happened in `.loopfocus/`, and resume at the correct state.**

## Completion Report Contract

Report results in this order:

1. objective and locked goal;
2. root cause and the evidence chain that found it;
3. files and behavior changed (with change radius);
4. hypothesis ledger summary and signal outputs;
5. gate results (profile used, machine gates, judgment gate decisions);
6. loop genome records (attempts, banned strategies, winner);
7. SkillFocus findings reported for user decision;
8. verify script result;
9. residual risks and unknown items;
10. what the user is being asked to decide, without silently choosing for them.

Read `references/verification-and-claim-governance.md` before using words such as finished, fixed, secure, or ready.
