# Agent Role Definitions

Dispatch-ready role contracts. Each role: what it may do, what it must not do, its gates, its evidence, its output shape. A role dispatched without these is a bare prompt.

| Role | Dispatch when | File |
|---|---|---|
| implementer | executing a task in a loop | `implementer.md` |
| reviewer | independent dual-verdict review | `reviewer.md` |
| security-auditor | M3 mode work | `security-auditor.md` |
| recovery-agent | resuming after context loss | `recovery-agent.md` |
| planner | large/structural tasks | `planner.md` |
| skill-author | author-skill mode | `skill-author.md` |

All roles share the base discipline (state machine, ledger, gates). A role adds its own contract on top.
