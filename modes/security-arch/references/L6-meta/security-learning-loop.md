# Security Learning Loop

## What

Incidents, false positives, false negatives, and rejected findings all feed back into SecurityArch's reasoning policy — the system gets measurably better at judging after every round of reality.

## Why

An analyzer that never learns repeats its mistakes with new confidence. The loop closes the gap between SecurityArch's verdicts and what reality said: a false positive teaches over-severity, a false negative teaches a blind spot, an incident teaches a missed class. Without the loop, the 126 systems are static; with it, they improve.

## When

Continuously — after every incident, every re-audit comparison, every rejected/quashed finding, every calibration review.

## The feedback classes

| Signal | Policy update |
|---|---|
| false positive (finding rejected by judge) | the pattern that produced it gets a confidence discount |
| false negative (incident SecurityArch missed) | new invariant/gate/assumption (Incident Back-Propagation's output) |
| rejected finding later proven real | the rejection criteria get re-examined (what evidence was demanded too strictly?) |
| verdict held up in production | the pattern that produced it gains calibrated trust |
| repeated finding class across projects | the class graduates into a default check (checklist/canary/compile rule) |

## Protocol

1. Collect outcomes: judge verdicts vs re-audit results, incident records, held-up ratios.
2. Classify each outcome per the table.
3. Apply the policy update — as a recorded change (the policy is versioned; updates are dated and reasoned).
4. Re-run old verdicts against the new policy where cheap (a policy change can re-open closed findings — that is a feature, the reopen-if conditions activate).
5. The loop's own record (what changed, why, what it caught later) is the evidence that the loop is working.

## Evidence gates

- outcomes collected (not anecdotal — the loop runs on records)
- policy updates recorded with their triggers
- policy versioning maintained

## Anti-patterns

- Learning only from incidents (false positives teach as much, more cheaply)
- Updating policy after ONE outlier (patterns need repetition; the loop tracks streaks)
- A policy that never actually changes (an unresponsive loop is decoration)

## Example

Two projects in a row shipped the "route registered before middleware" bug — the first time it was found manually (incident-adjacent), the second time the loop's updated policy (default check: route order assertion in every audit's L1 pass) caught it in the first hour. The learning loop had converted one team's mistake into every future audit's automatic check.
