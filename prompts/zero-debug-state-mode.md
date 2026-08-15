# Debug Mode — dispatch prompt

Load the LoopFocus skill first, then enter Zero Debug State mode (announce it).

Task: <the bug, the failing test, the symptom>
Repository: <path>

Discipline (flow/bug-fix-flow.md):
1. LOCK: goal + invariants + profile in .loopfocus/state.md
2. EXPLORE: read the failing path; reproduce BEFORE the first edit
3. HYPOTHESIZE: ledger entry per attempt (cause / test plan / expected)
4. EXECUTE: strategy ladder S1→S6; fingerprint check before every attempt
5. OBSERVE/MEASURE: normalize signals; record genome per attempt
6. Regression sentinel: previously passing things still pass
7. SkillFocus: report found issues, ask before fixing extras
8. Verify: gates + loopfocus-verify.sh PASS before claiming done

Return the completion report per the 10-item contract.
