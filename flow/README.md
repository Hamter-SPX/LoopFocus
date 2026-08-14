# LoopFocus Flows

Readable end-to-end paths through the discipline. Each flow: Why → When → Steps → Evidence gates → Anti-patterns.

| Flow | Use when |
|---|---|
| `bug-fix-flow.md` | a defect, a failing test, "something broke" |
| `feature-build-flow.md` | new feature, M4 territory |
| `security-audit-flow.md` | M3 territory, audit request |
| `review-flow.md` | reviewing code, PRs, someone else's change |
| `recovery-flow.md` | context reset, crash, resuming someone's work |

All flows share the base discipline (state machine, gates, ledger, genome); each adds its own checkpoints. Pick ONE flow and follow it; crossing flows mid-task is how drift starts.
