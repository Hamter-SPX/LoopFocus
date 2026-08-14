# Verification & Claim Governance

The words finished / fixed / secure / ready are claims, and claims bind to evidence.

## Claim rules

1. Every completion claim cites its evidence: the verify run, the gate outputs, the test counts, the artifact paths.
2. Evidence is fresh (postdates the last code change) and scoped (covers the claimed surface — a passing unit test does not certify a feature).
3. `loopfocus-verify.sh` PASS is necessary for READY_TO_FINISH, not sufficient — judgment gates (the user's questions, the SkillFocus report) still stand.
4. Regression-free is claimed only with the regression gate run against current code.
5. "Secure" is never claimed — say what was checked, with which tool, on which version, and what remains unchecked (verification gaps).

## Before using completion words

- UNKNOWN: none in state.md — no known blockers
- NEXT: none|done
- ledger has actual results for every attempt
- verify script PASS
- profile-required gates all run (none skipped by laziness — SKIP means not configured)
- the user has been asked about the outstanding decisions

## Reporting the residual

Every completion report ends with what is NOT covered: untested platforms, unsimulated environments, out-of-scope surfaces, assumptions still unverified. A gap named is a gap managed; a gap hidden is a trap for the next agent.

## Integration decisions are the user's

Merge, push, cleanup, or discard — present the options with evidence, never select silently. Discarding work requires the user's explicit instruction; cleanup happens only for workspaces the process owns.

## Anti-patterns

- "All tests pass" where only the new test was run
- Claiming READY_TO_FINISH with a FAIL recorded earlier the same loop and not re-verified
- Omitting the verification-gaps section because it "looks weak" — it is the strongest part of the report
- Choosing the integration action for the user "to save them time"
