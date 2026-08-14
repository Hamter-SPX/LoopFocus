# Bug Fix Flow

**Why:** most wasted loops come from fixing before understanding. This flow forces evidence before edits.

**When:** any defect, failing test, "it broke", regression report.

## Steps

1. **LOCK** — goal: the bug, not "make it work somehow". Invariants: behavior that must stay. Profile: LIGHT, escalate on difficulty.
2. **EXPLORE** — read the failing path (caller → dependency chain). Reproduce first: a test or command that shows the failure. Evidence before hypothesis.
3. **HYPOTHESIZE** — ledger entry: cause, test plan, expected result. One hypothesis at a time.
4. **EXECUTE** — ladder rung S1: smallest direct fix. Commit (rollback point).
5. **OBSERVE / MEASURE** — run the repro + suite. Normalize the signal. Delta?
6. **Decide** — progress → CONTINUE; flat/fail → next ladder rung (S2 root-cause trace, S3 minimal case, S4 dependencies, S5 alternative, S6 escalate). Two fails in one family → family banned by the genome.
7. **Regression check** — previously passing things still pass (sentinel).
8. **SkillFocus sweep** — other off-points seen along the way? Report + ask, do not fix silently.
9. **Verify** — `loopfocus-verify.sh` → record genome → report with the evidence chain.

## Evidence gates

- reproduction exists before the first edit
- every attempt has a ledger entry with an actual result
- the signal shows delta or the ladder advanced
- regression gate run against current code
- verify PASS before "fixed"

## Anti-patterns

- Editing the symptom because the failing line "looks wrong"
- Two edits per attempt (nothing attributable)
- Declaring fixed from one test while the suite is unrun
- Re-running the same fix reworded (the ladder exists for this)
