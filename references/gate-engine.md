# Gate Engine

Gates are the checkpoints between state-machine transitions. A transition is not complete while a relevant gate is failing.

## Profiles (Effort Elasticity)

| Profile | Machine gates | Judgment gates | When |
|---|---|---|---|
| LIGHT | entry, build, test, completion | goal lock only | simple task |
| NORMAL | + static, regression, evidence-freshness, checkpoint | context, mutation, scope, progress, repeat | many files / architecture |
| DEEP | + artifact | all of the below, strict | repeated failure / high impact |
| Near completion | completion expands scope | — | close to done |

Escalate on repeated failure or high impact; lighten on sustained progress. The profile is recorded in `.loopfocus/profile` and announced.

## The 26 Gates

### Entry (before starting)

| Gate | Blocks when |
|---|---|
| entry | no `.loopfocus/state.md` with a `goal:` line |
| context | acting without reading the files involved |
| assumption | high-impact assumption without evidence or test |
| plan | large change radius with no written approach |
| scope | action classified Unrelated to the goal |

### Execution (before/at every edit)

| Gate | Blocks when |
|---|---|
| mutation | edit does not serve the goal / expands scope / irreversible |
| change-radius | small goal touching a large surface (hold + reassess) |
| dependency | dependency added/removed/upgraded without goal-linked reason |
| build | build command fails |
| static | lint/typecheck fails |
| test | test command fails |

### Regression (after every change)

| Gate | Blocks when |
|---|---|
| regression | passing-test count drops vs `.loopfocus/metrics` |
| runtime | program no longer starts/runs, new crash/error |
| browser | key interaction no longer works (open → click → type → navigate) |
| performance | hot-path latency/memory abnormally worse |

### Progress (every loop)

| Gate | Blocks when |
|---|---|
| progress | no measurable delta AND no information gain (NO_PROGRESS) |
| repeat | retrying an approach that failed, without new evidence |
| stuck | same failure class over threshold (no plain retry) |
| oscillation | A passes/B fails → A fails/B passes cycles (find shared root cause) |
| evidence-freshness | code changed after the state was last recorded |

### Recovery

| Gate | Blocks when |
|---|---|
| checkpoint | structural/risky change without stable state + rollback point |
| recovery | continuing after rollback/reset/crash without restoring goal + known truth + attempts + failures |

### CI

| Gate | Blocks when |
|---|---|
| ci | local fast gate not passed before relevant CI; near completion without broad/full CI |
| ci-reliability | treating runner/network/flaky failure as code failure |
| artifact | stage complete without output (report, log, screenshot, metric) |

### Completion

| Gate | Blocks when |
|---|---|
| completion | known blockers > 0, DoD chain incomplete, required checks unrun, known regression unfixed |

`blocking:false` gates record warnings; `blocking:true` gates stop progression until `next_action` is handled.

## Machine gates

`bash scripts/gate-runner.sh` runs the profile's machine gates and prints one JSON line each:

```json
{"gate":"regression","status":"FAIL","attempt":17,"reason":"3 previously passing tests now fail","blocking":true,"next_action":"fix_regression"}
```

Exit code 1 = at least one blocking FAIL. SKIP means not configured — never silently assumed.

## Judgment gates

Self-check before acting; write the decision into the ledger:

```text
gate: <name> | decision: allow/block | why: <reason linked to goal>
```

A blocked gate is an edit you did not make. Record it so a later loop can re-evaluate with new evidence.

## Gate DAG (per project)

```
entry → context → mutation → (build / runtime / browser) → test → regression → progress → ci → completion
```

The DAG follows the project's tool map (`scripts/tool-discovery.sh`): backend has no browser gate; docs-only changes may have no build gate. A gate without a configured command is SKIP.

## Anti-patterns

- Skipping a gate because "this is a trivial case" (profile LIGHT already encodes triviality)
- Re-running the whole CI matrix when one shard failed
- Counting a flaky failure as a code defect without a second run
- Writing `## UNKNOWN` headings to evade the blocker regex (the runner catches both forms)
- Silently widening scope after the mutation gate blocked — re-route through the user instead
