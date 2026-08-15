# Superpowers Adaptation Matrix

How LoopFocus maps onto existing agentic-discipline skills (superpowers family) — what it reuses, extends, and adds.

| Superpowers skill | LoopFocus counterpart | Relationship |
|---|---|---|
| systematic-debugging | Loop Strategy Ladder (S1-S6) + Stuck Detector | extends: the ladder adds escalation structure; the detector mechanizes "stuck vs hard" |
| test-driven-development | RED-GREEN-REFACTOR for skills (author-skill mode) + TDD evidence protocol | reuses: same cycle, same Iron Law; LoopFocus adds the conformance gate as the machine check |
| verification-before-completion | Completion Gate + loopfocus-verify.sh + self-audit.js | extends: adds machine-run gates with JSON verdicts instead of self-discipline alone |
| root-cause-tracing (superpowers) | S2 Root-cause Trace + Hypothesis Ledger + Counterfactual Check | extends: adds the ledger format (write before act), counterfactual discrimination, confidence decay |
| writing-skills | author-skill mode + baseline scenarios + conformance | reuses: pressure scenarios, SDO rules (description = triggers only), token efficiency; adds conformance audit |
| writing-plans / executing-plans | Plan Gate + DoD Graph + critical-path.js | extends: adds the completion-condition chain and the machine DoD walker |
| subagent-driven-development | Handoff Protocol + Recovery Capsule + Branch-and-Recover | extends: the six-part handoff package is the dispatch contract; worktrees are the branch mechanism |
| receiving-code-review | Self-audit pass + self-audit.js | extends: self-review as an adversarial audit with bound claims |
| using-git-worktrees | git-state.js worktree-new / branch-and-recover | reuses: same worktree machinery, wired into the branch attempt protocol |
| dispatching-parallel-agents | Branch-and-Recover (A/B/C attempts) | reuses: parallel isolation, adds evidence-bar comparison before choosing |
| brainstorming | Canvas + Predictive Analysis + Intent Anchor | extends: intent anchoring before requirements, canvas before implementation, prediction before coding |

## What LoopFocus adds that superpowers does not have

| Addition | Why it matters |
|---|---|
| **Loop Genome** (cross-context strategy memory) | problem classes recognize themselves; banned families stay banned across agents and resets |
| **Signal Normalizer** (one JSON shape for all tool output) | decisions consume signals, never raw output — "17→3 = converging" is computable |
| **Convergence Engine** (sequence, not snapshot) | an agent that sees 18→16→19→14→21 knows to mutate; red/green alone cannot tell |
| **Oscillation Detector** | the A↔B swap pattern is the cheapest root-cause locator in practice |
| **No-Progress Tax** (compounding cost of flat loops) | repetition becomes structurally expensive instead of personally resisted |
| **Gate Engine with profiles** (LIGHT/NORMAL/DEEP) | discipline that scales — cheap on easy tasks, deep on hard ones |
| **Mode contracts with machine check** | `mode check` refuses to close a mode with unrun gates, like a CI gate for behavior |

## Design positions where LoopFocus deliberately differs

1. **Converging ≠ green.** LoopFocus treats a still-red loop whose failures drop as progress — superpowers' verification-before-completion is the last gate, not the loop's only signal.
2. **Evidence freshness is a gate, not advice.** Stale greens are invalidated mechanically (mtime comparison), because the cheapest hallucination is quoting an old pass.
3. **Escalation is a rung, not a failure.** S6 packages the evidence and hands it up; "escalate early with a full package" beats "loop until tokens run out".
