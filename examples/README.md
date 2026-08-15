# Examples

Worked examples — real files, not narratives. Each shows what a LoopFocus-completed task leaves behind.

| Example | What you get |
|---|---|
| `golden-path/` | A complete simulated repo AFTER a LoopFocus bug fix: source, test, and the full `.loopfocus/` capsule (state, ledger with 3 hypotheses, genome with a banned family + winner, gates.conf, profile, metrics, DoD graph). Read `../GOLDEN_PATH.md` for the walkthrough that produced it. |
| `handoff-example.md` | A real handoff package — what a receiver gets when work is passed on. |
| `security-example.md` | A condensed M3 audit result — findings, severity, evidence, and the ask. |

## How to use them

1. **Read the capsule** — a new agent learning LoopFocus should read `.loopfocus/state.md` first, exactly as the recovery flow demands. That one file shows the whole discipline compressed.
2. **Run the repo** — `cd golden-path && npm test` passes; the test was the contract, the fix was in the dependency.
3. **Steal the formats** — the ledger's H1/H2/H3, the genome's ban/winner, and the DoD chain are the exact shapes the machine tools parse.

## Regenerate a fresh golden path

```bash
loopfocus init && loopfocus discover     # scaffold a new capsule
# then walk the flow in ../flow/bug-fix-flow.md and record everything
```
