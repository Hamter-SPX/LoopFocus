# ToolBus

All tools feed one brain. Every output is normalized into one signal shape before any decision consumes it.

## Signal Normalizer

```bash
node scripts/normalize-signal.js --source local:test --status fail \
  --previous-failures 17 --current-failures 3 --failure-class webkit-nav \
  --new-regressions 0 --evidence-fresh true --attempt 12
```

```json
{"attempt":12,"source":"local:test","status":"fail","previous_failures":17,"current_failures":3,"delta":"+14","failure_class":"webkit-nav","new_regressions":0,"evidence_fresh":true,"progress":true,"next_action":"continue"}
```

Decision rules encoded:
- failures dropping + no new regressions + fresh evidence → `progress: true` → CONTINUE even while FAIL (do not mutate a converging strategy),
- flat/rising failures → `progress: false` → MUTATE,
- new regressions > 0 → ROLLBACK.

The signal is what the Progress Engine sees — never raw tool output.

## Tool Auto-Discovery

```bash
bash scripts/tool-discovery.sh
```

Scans package.json / pyproject.toml / Cargo.toml / go.mod / .github/workflows / .gitlab-ci.yml / Dockerfile / playwright config → writes `.loopfocus/gates.conf` (build_cmd, static_cmd, test_cmd, test_count_cmd, has_ci, has_playwright, …) and `.loopfocus/tool-map.md`. Run at LOCK. A gate without a configured command is SKIP — never silently assumed, never silently skipped.

## Local Fast Gate

```bash
bash scripts/fast-gate.sh
```

Runs build → static → test from gates.conf, stopping at the first failure. A failed build makes tests pointless this loop — do not wait for CI to discover what 2 seconds locally would show. The CI Controller applies the same ordering remotely.

## CI Controller (smart rerun)

```bash
node scripts/ci-controller.js runs
node scripts/ci-controller.js failed-jobs <run-id>     # CI Matrix Brain input
node scripts/ci-controller.js logs <run-id>            # failed-job logs
node scripts/ci-controller.js rerun-failed <run-id>    # rerun ONLY failed jobs
node scripts/ci-controller.js artifacts <run-id>
```

Rules: build FAIL → tests need not run this round; WebKit-only failure → rerun/fix the WebKit shard, not the matrix; a failure that reproduces only on a specific runner is environment, not code (CI Reliability — verify before touching code).

## Git State Engine

```bash
node scripts/git-state.js                         # branch, commits, staged/unstaged/untracked, diff stat
node scripts/git-state.js worktree-new attempt-b  # isolated branch for a competing approach
node scripts/git-state.js worktree-list
node scripts/git-state.js worktree-remove attempt-b
```

Worktrees are the Branch-and-Recover substrate: A/B/C attempts in parallel sandboxes, winner returns, losers removed with their failure recorded.

## Browser/E2E Driver (Playwright as sensor)

For UI work: `npx playwright test` after every visual change; `--project` per browser (Chromium/Firefox/WebKit) to match the CI matrix; `--screenshot` into artifacts so evidence is attached to the attempt. The UI loop is: render → interact → screenshot → compare → normalize. Browser state (console errors, network failures) is evidence like test output.

## Build Sandbox (Docker for risky changes)

Dangerous or experimental changes run in a container against the CI image first; only a passing sandbox result comes back into the workspace. Never test environment-destroying changes in the working tree. The sandbox is the L2 Experiment home when worktrees are not enough.

## Runtime Observer (OpenTelemetry)

When the project emits OTel traces/metrics/logs, read them as runtime evidence. Tests passing while latency jumps 120ms → 1.8s is a real regression the suite cannot see:

```bash
node scripts/normalize-signal.js --source runtime:otel --status fail --failure-class latency ...
```

"Technically pass, actually worse" is exactly what the runtime gate exists to catch.

## Artifact/Evidence Collector

Every tool result is saved with its attempt number before it counts as evidence: test report, screenshot, CI log, diff. Ledger entries reference the artifact path (`evidence: .loopfocus/evidence/attempt-4-test.log`). A claim without an artifact path is not evidence.

## Adaptive CI

```
Code Changed → Impact Detection → Fast Checks → Affected Tests
→ Relevant CI Matrix → PASS? → NO: loop (fix)   YES: Broader CI → Full Gate
```

Small work does not fire full CI every loop. Near completion, the radius expands to the full gate. Always end with full CI on the final change. Impact detection reuses the touch map from Predictive Analysis.

## Anti-patterns

- Rerunning the whole CI matrix for one flaky shard
- Reading raw tool output and "interpreting" it into a decision (normalize first)
- Sandboxing after the dangerous change is already in the workspace
- Collecting artifacts nobody can find (name them with attempt numbers)
- Treating a passing local gate as license to skip the CI gate on the final change
