# Changelog

All notable changes to LoopFocus.

## 2026-08-15 — v0.6.0 "FVEP-density"

- Added 11 tools: canvas, artifact, self-audit, distill, state-check, ci-matrix, flaky-check, sandbox, adaptive-ci, otel-observe, e2e (tool count 19 → 30)
- Added test suite 9 (test-tools2.sh) — all suites green
- Added root docs: README, README_TH, PLAYBOOKS, GOLDEN_PATH, ARCHITECTURE, CHANGELOG, LICENSE

## 2026-08-15 — v0.5.0 "Machine intelligence"

- Added mode engine: 8 modes with contracts + resolve/show/list/check (mode.js)
- Added unified CLI (`loopfocus`) dispatching all commands
- Added convergence.js (Convergence Engine as a machine), loop-fingerprint.js (repeat gate), entropy.js (Solution Entropy)
- Added dod.sh (DoD graph walker), predictive.js (touch map), critical-path.js
- Added state-init.sh, handoff.sh
- Extended loop-genome.js with `--current-failures`
- Tool count 9 → 19; test suites 5 → 8

## 2026-08-15 — v0.4.0 "Deep references"

- Split 14 reference files into 62: one deep file per system (What/Why/When/Protocol/Evidence gates/Machine check/Anti-patterns/Example)
- Added references for: loop-control (9), reasoning (10), goal (16), progress (5), state-memory (7), knowledge (3), effort-elasticity, dynamic-focus-depth, skillfocus

## 2026-08-15 — v0.3.0 "FVEP-style structure"

- Restructured into SKILL.md router + references/ + flow/ + schemas/ + templates/ + prompts/
- Added conformance audit + GitHub Actions CI + CI docs

## 2026-08-15 — v0.2.0 "ToolBus"

- Added tool-discovery.sh, normalize-signal.js, fast-gate.sh, git-state.js, ci-controller.js
- Added CI templates (GitHub Actions + GitLab)
- E2E verification passed: genome auto-ban forced root-cause discovery

## 2026-08-15 — v0.1.0 "Core"

- SKILL.md core: Identity, Focus State Machine, 5 Hard Rules, Always-On behaviors, 7 core systems
- loopfocus-verify.sh (completion gate) with TDD
- RED baseline (4 pressure scenarios) → GREEN → REFACTOR loop
- Gate Engine: gate-runner.sh (9 machine gates), 3 profiles
- Loop Genome + Failure Memory (loop-genome.js)
- M3 Security Mode, M4 Build Mode, Canvas, Predictive Analysis
