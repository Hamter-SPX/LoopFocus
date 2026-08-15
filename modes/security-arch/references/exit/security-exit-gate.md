# Security Exit Gate

## What

The only door out of SecurityArch mode. LoopFocus exits the mode when — and only when — every condition is demonstrably true: mappers complete, gates run, findings dispositioned, decisions logged, re-verify clean, user asked.

## Why

A security audit's natural ending is "enough" — a feeling, usually when the findings list stops growing. The exit gate replaces the feeling with conditions, so the mode cannot be left with unchecked categories, unverified findings, or silent decisions — the three ways hollow audits end.

## When

Any attempt to close SecurityArch. Machine-checkable via `security-exit.sh`.

## The conditions (ALL must hold)

1. **Mappers complete** — architecture, trust boundaries, attack surface, data flow, privilege graph all recorded with anchors.
2. **7 categories walked** — every coverage category recorded, including the "none" entries.
3. **Machine scans run** — sast output attached (and Criticals dispositioned), fuzz/audit run or SKIP with reason.
4. **Every finding dispositioned** — each finding is fixed-and-verified, accepted-with-log-entry, or deferred-with-log-entry. No orphan findings.
5. **Threat model + invariants recorded** — the model exists; invariants re-verified green.
6. **Re-verify loop clean** — the last full pass after the last fix produced no new findings.
7. **Decision log present** — every accept/reject/scope ruling has an entry with reopen-if.
8. **User asked** — the Fix Policy ask happened; the user's selections recorded.
9. **Completion gates pass** — the standard LoopFocus gates (verify script etc.) still apply on top.

## Machine check

```bash
loopfocus security-exit
# {"verdict":"PASS"}  or  {"verdict":"FAIL","missing":["mappers","decision_log",...]}
```

A FAIL names the missing conditions. The mode stays open until they are true — leaving early is a discipline violation, not a shortcut.

## Evidence gates

- all nine conditions verifiable (each maps to a ledger section or tool output)
- exit attempts recorded (a rejected exit is a finding about the audit itself)

## Anti-patterns

- Exiting because "the user is waiting" (schedule pressure does not close security conditions)
- Checking conditions from memory instead of the artifacts
- One clean exit gate run standing in for a clean re-verify (they are different conditions — both required)

## Example

First exit attempt: FAIL — missing: decision_log (two accepted risks unrecorded), re_verify (last fix not re-passed). The gate named exactly what was left. Twenty minutes later, both done, second attempt: PASS. The mode closed on evidence, not on fatigue.
