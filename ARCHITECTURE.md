# LoopFocus Architecture

```
                        ┌──────────────────────────────────────────────┐
                        │                  LOOPFOCUS                   │
                        │  "every loop has a reason, a state,          │
                        │   and feedback — and converges"              │
                        └──────────────────────┬───────────────────────┘
                                               │
   ┌───────────────────┬───────────────────────┼───────────────────────┐
   │                   │                       │                       │
   ▼                   ▼                       ▼                       ▼
┌────────────┐   ┌────────────┐         ┌────────────┐         ┌────────────┐
│ GOAL       │   │ REASONING  │         │ EXECUTION  │         │ PROGRESS   │
│ ENGINE     │   │ ENGINE     │         │ CONTROL    │         │ CONTROL    │
│            │   │            │         │            │         │            │
│ goal lock  │   │ hypothesis │         │ checkpoints│         │ convergence│
│ intent     │   │ ledger     │         │ rollback   │         │ stuck      │
│ scope      │   │ uncertainty│         │ branching  │         │ oscillation│
│ firewall   │   │ counter-   │         │ handoff    │         │ entropy    │
│ invariants │   │ factual    │         │            │         │            │
└────────────┘   └────────────┘         └────────────┘         └────────────┘
                                               │
                                               ▼
                                    ┌─────────────────────┐
                                    │   STRATEGY MUTATION │
                                    │ continue/refocus/   │
                                    │ replan/rollback/    │
                                    │ escalate/finish     │
                                    └─────────────────────┘
                                               │
                              ┌────────────────┴────────────────┐
                              ▼                                 ▼
                    ┌─────────────────┐               ┌─────────────────┐
                    │   GATE ENGINE   │               │    STATE MACHINE│
                    │  26 gates, 3    │               │  LOCK→EXPLORE→  │
                    │  profiles, DAG  │               │  HYPOTHESIZE→   │
                    └────────┬────────┘               │  EXECUTE→OBSERVE│
                             │                       │  →MEASURE       │
                             └───────────┬───────────┴─────────────────┘
                                         ▼
                              ┌─────────────────────┐
                              │      TOOLBUS        │
                              │  git · build · test │
                              │  ci · browser ·     │
                              │  runtime · sandbox  │
                              └──────────┬──────────┘
                                         ▼
                              ┌─────────────────────┐
                              │  SIGNAL NORMALIZER  │
                              │  one JSON shape     │
                              └──────────┬──────────┘
                                         ▼
                              ┌─────────────────────┐
                              │   LOOP GENOME       │
                              │  attempts · bans ·  │
                              │  winners · memory   │
                              └─────────────────────┘
```

## Layer composition

| Layer | Files | Machine arms |
|---|---|---|
| Goal Engine | `references/goal/` (16 systems) | scope/mutation gates, goal-lock in state.md |
| Reasoning Engine | `references/reasoning/` (10) | hypothesis ledger format, self-audit.js |
| Execution Control | `references/state-memory/` (7) | git-state.js worktrees, checkpoint gate |
| Progress Control | `references/loop-control/` (9) + `references/progress/` (5) | convergence.js, loop-fingerprint.js, entropy.js, normalize-signal.js |
| Gate Engine | `references/gate-engine.md` (26 gates) | gate-runner.sh (9 machine gates), profiles |
| State Machine | `references/state-machine.md` | state.md + verify script parse |
| ToolBus | `references/toolbus.md` (9 tools) | 30 scripts, adaptive CI |
| Knowledge | `references/knowledge/` (3) | distill.sh, evidence-freshness gate |
| Governance | Effort Elasticity + Focus Depth | profile escalation, no-progress tax |

## Data flow (one loop)

1. **LOCK** → state.md (goal, invariants, profile) — `state-init.sh`, `mode.js`
2. **EXPLORE** → evidence → ledger — `tool-discovery.sh`, `predictive.js`
3. **HYPOTHESIZE** → ledger H<n> — template
4. **EXECUTE** → diff + commit — `loop-fingerprint.js` blocks repeats first
5. **OBSERVE** → raw output → artifact — `artifact.sh`, `e2e.sh`
6. **MEASURE** → normalized signal → `normalize-signal.js`
7. **Decide** → `convergence.js` / `entropy.js` → continue/mutate/rollback
8. **Record** → `loop-genome.js` (attempt, delta, ban, winner)
9. **Gate** → `gate-runner.sh` (profile's machine gates)
10. **Verify** → `loopfocus-verify.sh` (completion) + `self-audit.js` (claims)

## Escalation paths

| Situation | Path |
|---|---|
| repeated failure | tax streak → depth+1 → pre-mortem → branch-and-recover |
| oscillation | detector → canvas the A↔B edge → shared root cause |
| entropy | warning → checkpoint return → re-hypothesize at L5 |
| dead end | signature → escalate with evidence package |
| context loss | recovery capsule → cross-check → resume at NEXT |

## Integrity

`loopfocus-conformance.sh` audits the skill itself: metadata rules, reference integrity, schema validity, script syntax, and all test suites. The GitHub Actions workflow runs it on every push — a PR that breaks a reference or a suite does not merge.
