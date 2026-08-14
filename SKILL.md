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

## Gate Engine

Gates are checkpoints every action must pass. The Focus State Machine is the rhythm; gates are the checkpoints on every transition. Never skip a state while a relevant gate is failing.

### Gate Profiles (change automatically)

| Profile | Gates | When |
|---|---|---|
| LIGHT | entry, build, test, completion | simple task |
| NORMAL | LIGHT + static, regression, evidence-freshness, checkpoint | many files / architecture |
| DEEP | NORMAL + artifact, and reasoning gates below get strict | repeated failure / high impact |
| Near completion | completion gate expands scope | close to done |

Choose the profile when locking the goal. Record it in `.loopfocus/profile`. Escalate the profile (LIGHT→NORMAL→DEEP) when failures repeat or impact is high. Never force a heavy profile on a trivial task (Effort Elasticity).

### Machine Gates (run `scripts/gate-runner.sh`)

- **entry** — state.md recorded with a goal (all profiles)
- **build** — build command passes (configured via `.loopfocus/gates.conf`)
- **static** — lint/typecheck passes
- **test** — test command passes
- **regression** — passing-test count did not drop vs `.loopfocus/metrics`
- **evidence-freshness** — no code file changed after state.md was last updated
- **checkpoint** — git repo exists (rollback point available)
- **artifact** — evidence file produced, non-empty
- **completion** — UNKNOWN: none + NEXT: none/done + ledger has actual result

Every gate prints one JSON line: `{"gate","status","attempt","reason","blocking","next_action"}`. FAIL with `blocking:true` means stop and handle `next_action` before continuing. Exit code 1 = at least one blocking FAIL.

### Judgment Gates (self-check before acting — record the decision in the ledger)

- **context gate** — do I have enough context for this action? If I have not read the files involved, block myself before editing architecture.
- **assumption gate** — high-impact assumptions need evidence or a test first. "This API never returns null" is not evidence unless the contract was checked.
- **plan gate** — large change radius needs a written approach before executing.
- **mutation gate** — does this edit serve the goal? Does it expand scope? How reversible is it?
- **change-radius gate** — a small goal touching 30 files → hold and reassess.
- **dependency gate** — adding/removing/upgrading a dependency needs a goal-linked reason, not convenience.
- **progress gate** — every loop needs measurable delta or information gain. Neither = NO_PROGRESS.
- **repeat gate** — a failed approach cannot be retried without new evidence changing the hypothesis.
- **stuck gate** — same failure class over threshold → no plain retry; mutate strategy.
- **oscillation gate** — A passes/B fails → A fails/B passes → … → stop fixing symptoms; find the shared root cause.
- **scope gate** — classify every action Required / Supporting / Optional / Unrelated. Unrelated is blocked.
- **runtime/browser/performance gates** — change must run, key interactions must work, hot-path changes must not regress latency/memory abnormally.
- **ci gates** — local fast gate before CI; separate code failure from flaky/environment failure before touching code; near completion, expand to full CI.
- **recovery gate** — after rollback/reset/crash: restore goal + known truth + attempts + failures before continuing.
- **checkpoint gate** — before structural/risky changes: stable state + rollback point first.

### Gate DAG (per project, not a fixed chain)

```
entry → context → mutation → (build / runtime / browser) → test → regression → progress → ci → completion
```

Backend has no browser gate. Docs-only changes may have no build gate. Discover the project's gates from its tools (Phase 5 Tool Auto-Discovery).

### Loop Genome + Failure Memory

Every task has an evolution history. Record each attempt with `scripts/loop-genome.js`:

```bash
node scripts/loop-genome.js record --class <problem-class> --strategy <name> \
  --result fail|partial|success --delta <n> --reason "..." --hypothesis "..."
```

- A strategy that failed twice with zero successes is auto-banned — never retry it.
- Before starting a new problem, check history: `node scripts/loop-genome.js query --class <similar-class>` — if a strategy family already won for this problem class, start there instead of thinking from zero.
- The genome lives in `.loopfocus/genome.json` (per repo, or `~/.loopfocus/` outside a repo). A new agent or fresh context must query it before re-attempting anything.

## Modes

Invoked on request. Default behaviors stay on; a mode adds its own discipline.

### M3 — Security Mode (trigger: "security review", "audit", "scan", "vulnerab", "CVE", "secure")

1. **Coverage checklist — never skip a category** (go through ALL, even if you expect nothing):
   - Injection (SQL, NoSQL, command, template, path traversal)
   - AuthN/AuthZ (hardcoded secrets, weak comparison/type juggling, missing auth, IDOR)
   - Secret leakage (hardcoded keys, .env committed, tokens in logs)
   - Dependency risk (npm audit / pip-audit / cargo audit / govulncheck — run the project's audit tool)
   - Transport/config (TLS, headers, CORS, permissions, rate limiting)
   - Data exposure (PII, sensitive endpoints unauthenticated, mass assignment)
   - Business logic flaws
2. **Evidence first.** Every finding = file:line + a reproduction or the audit tool's output. Unverified suspicion is recorded as UNKNOWN, not as a finding.
3. **Severity taxonomy:** Critical / High / Medium / Low / Info — with exploitability (remote? unauth?) as the deciding factor, not gut feel.
4. **Fix policy applies:** propose fixes, ask the user which to apply. Never silently fix security issues beyond the goal unless provably safe and reversible.
5. **Record everything** in `.loopfocus/ledger.md` + state.md + genome (`--class security-<area>`).

### M4 — Build Mode (trigger: "build", "feature", "add", "implement new")

1. **LOCK first:** restate the requirement in your own words (Intent Anchor) + list MUST/MUST-NOT invariants before writing anything.
2. **Design before code:** Canvas the architecture (below) + Predictive analysis on the touched area.
3. **DoD Graph:** write the completion conditions as a chain (feature works → tests pass → no regression → verify → done) into `.loopfocus/dod.md` at the start.
4. **Write → verify loop:** smallest working slice first, run gates every loop, update state.md each milestone.
5. **No scope creep:** new ideas go to the report list (SkillFocus), not into the code, until the user approves.

## Canvas (available anytime)

When the task needs structural explanation — current architecture, a proposed feature structure, or impact of a change — draw it before implementing:

1. Draw in chat: Mermaid or ASCII — modules/boxes + edges = data flow or dependency. Label every edge with what travels on it.
2. Mark on the diagram: where the change goes, what else touches it (Predictive), what must not break (invariants).
3. If the user approves, save the diagram + explanation as `docs/loopfocus-canvas-<topic>.md` in the repo (committed).
4. Never draw boxes for classes/files you have not actually read — a canvas is evidence-based like everything else.

## Predictive Analysis (ก่อน feature ใหม่/ก่อนแก้จุดที่เชื่อมเยอะ)

Predict where bugs will emerge when a new feature or change lands. Evidence-based — cite the actual code:

1. **Touch map:** which modules the change touches, and which depend on them (search callers).
2. **Risk factors, with evidence:** coupling (how many callers), complexity (long functions/branches), churn (recent git history of the file), missing tests (coverage of the touched paths), concurrency (shared mutable state), data flow (inputs that flow into the change).
3. **Confidence levels:** each prediction is Known (verified by reading) / Likely (pattern + partial evidence) / Unknown (insufficient evidence — say so). Never present Likely as Known.
4. **Output:** risk list per module + prevention suggestion (extra test, boundary check, contract pin). Record in the ledger so post-feature bugs can be compared against predictions.

## Red Flags — STOP and return to the state machine

- Editing files before reading them
- Repeating an approach that already failed
- Claiming progress without a number
- Expanding scope without naming the goal link
- Answering with confidence while evidence is missing
- Declaring done while blockers are known

**All of these mean: pause, record what happened in `.loopfocus/`, and resume at the correct state.**
