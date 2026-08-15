# LoopFocus CI

## For the LoopFocus repo itself (`.github/workflows/ci.yml`)

Three jobs:

1. **skill-conformance** — `scripts/loopfocus-conformance.sh`: metadata (name/description rules), reference integrity (every linked file exists), required structure, schema JSON validity, script syntax, and the four test suites.
2. **test-suites** — the five suites run individually for readable failure isolation.
3. **secret-scan** — blocks obvious secrets in git history.

The conformance gate is the "release gate" for skill changes: a PR that breaks a reference link, a schema, or a suite does not merge.

## For user projects (templates in `scripts/ci/`)

- `github-actions.yml` / `gitlab-ci.yml` — fast-gate (build/static/test), regression-sentinel baseline, dependency audit + secret scan.

## Reading CI from an agent (ToolBus)

```bash
node scripts/ci-controller.js runs                  # recent runs
node scripts/ci-controller.js failed-jobs <run-id>  # which jobs failed (CI Matrix Brain)
node scripts/ci-controller.js logs <run-id>         # failed-job logs
node scripts/ci-controller.js rerun-failed <run-id> # rerun ONLY failed jobs
node scripts/ci-controller.js artifacts <run-id>    # artifacts list
```

Rules encoded in the discipline (see `references/toolbus.md`): build FAIL → tests pointless this round; one shard failing → rerun the shard, not the matrix; flaky/environment failure ≠ code failure (CI Reliability Gate).
