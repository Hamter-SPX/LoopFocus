# LoopFocus

> LoopFocus is the execution control discipline for agents. Every loop must have a reason, a state, and feedback — and must converge toward the goal. Looping until tokens run out is failure. Looping until the goal is reached is success.

**LoopFocus makes any agent (cheap or expensive) stay locked on the work**: it traces root causes instead of patching symptoms, finds all issues including low-severity and security risks, refuses to hallucinate, records every attempt in a machine-readable genome, and verifies completion with measurable evidence — across context resets, crashes, and handoffs.

## What's inside

| Layer | Contents |
|---|---|
| **Discipline** (SKILL.md + 62 references) | Focus State Machine, 5 Hard Rules, Gate Engine (26 gates), 61 systems as deep references, 6 flows |
| **Modes** (8) | analysis-intelligence · zero-debug-state · build · security · review · recover · ship · author-skill — with machine-checkable contracts |
| **Tools** (30) | Unified CLI + mode engine, gates, loop intelligence (convergence/fingerprint/entropy), Loop Genome, Signal Normalizer, planning (DoD/predictive/critical-path), ToolBus (CI/Docker/Playwright/OTel), lifecycle (init/handoff/distill), self-audit |
| **Templates + Schemas** | state / ledger / DoD templates, signal / gate / genome schemas |
| **CI** | Real GitHub Actions workflow (conformance + 9 test suites + secret scan) + CI templates for user projects |

## Install

```bash
# opencode / cross-runtime
mkdir -p ~/.config/opencode/skills/LoopFocus ~/.agents/skills/LoopFocus
cp -R SKILL.md references flow schemas templates prompts scripts ~/.config/opencode/skills/LoopFocus/
cp -R SKILL.md references flow schemas templates prompts scripts ~/.agents/skills/LoopFocus/
```

Or clone anywhere and point your runtime at the directory.

## Quick start — 60 seconds

```bash
cd your-project
loopfocus init            # scaffolds .loopfocus/ (state, ledger, profile) + discovers your tools
loopfocus mode resolve "fix the login bug"    # picks the operating mode
# edit .loopfocus/state.md — lock the goal + invariants
loopfocus fast            # build → static → test, stops at first failure
loopfocus converge --sequence 18,11,6,4,3     # is the loop actually converging?
loopfocus genome record --class login-hang --strategy dep-inspect --result success --delta 1 --reason "found the loop"
loopfocus verify          # completion gate — only this can say done
loopfocus handoff "continue the migration"    # or hand the work to someone else
```

The agent follows the same path from inside the skill: LOCK → EXPLORE → HYPOTHESIZE → EXECUTE → OBSERVE → MEASURE, with every transition gated and every attempt recorded.

## Core laws

1. Never repeat a failed approach without new evidence.
2. Never expand scope without linking it to the main goal.
3. Never discard a passing state without a rollback point.
4. Never claim progress without measurable delta.
5. Never declare completion while known blockers remain.

## Documentation

- `PLAYBOOKS.md` — shortest correct path per common request
- `GOLDEN_PATH.md` — one honest end-to-end task through every gate
- `ARCHITECTURE.md` — how the layers compose
- `flow/README.md` — pick a flow: bug fix, feature build, security audit, review, recovery
- `references/` — one deep file per system (What/Why/When/Protocol/Evidence gates/Machine check/Anti-patterns/Example)
- `SUPERPOWERS_ADAPTATION_MATRIX.md` — how LoopFocus maps onto existing agentic disciplines
- `VALIDATION_REPORT.json` — the test evidence backing this skill

## License

MIT — see `LICENSE`.
