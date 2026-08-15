## H1
- Hypothesis: caller-side destructuring is the problem
- Test plan: switch to property access, rerun
- Expected result: test passes
- Actual result: same TypeError — refuted
- Verdict: refuted

## H2
- Hypothesis: the lib exports nothing usable; fallback in caller
- Test plan: add typeof guard + fallback string
- Expected result: test passes
- Actual result: wrong greeting text — refuted (fingerprint: same family)
- Verdict: refuted

## H3
- Hypothesis: the dependency exports the function under the wrong key
- Test plan: read lib/greeting-utils.js exports, fix key, rerun
- Expected result: test passes
- Actual result: npm test 1/1 pass — confirmed
- Verdict: confirmed

## Gate decisions
- gate: repeat | decision: block | why: caller-patch family auto-banned (2 fails / 0 successes)
- gate: mutation | decision: mutate | why: ban forced strategy change to dependency-inspection

## Decisions
- 2026-08-15 banned family caller-patch | alternatives: dependency-inspection (chosen) | reopen-if: new evidence shows the caller is implicated
