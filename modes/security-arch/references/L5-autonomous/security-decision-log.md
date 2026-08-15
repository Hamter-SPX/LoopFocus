# Security Decision Log

## What

The audit's own Decision Ledger: every security-relevant architecture decision recorded — what was accepted, what was rejected, and why — with the evidence that reopens each one.

## Why

Security audits produce dozens of judgment calls ("this risk is accepted for now", "this finding is out of scope"). Without a log, the calls evaporate and the next audit re-litigates them, or worse, ships on assumptions the previous round already refuted. The log is the audit's memory.

## When

Throughout the audit — every accept/reject/scope ruling is a ledger entry, not a chat line.

## Format (ledger section)

```text
## Security Decisions
- <date> <decision> | risk: <what was weighed> | verdict: accepted|rejected|deferred
  | reason: <why> | reopen-if: <evidence that would change the verdict>
```

## Rules

1. Accepted risks are explicit — "we accept X because Y" written down, with Y being a reason, not fatigue.
2. Every rejection names the finding it rejected and why it lost.
3. The `reopen-if` clause is mandatory: a verdict without a reopening condition is a belief, not a decision.
4. The log ships in the handoff package and the completion report — later audits read it first.

## Evidence gates

- every accept/reject/scope ruling has an entry
- accepted risks carry reasons, rejected findings carry reasons
- reopen-if present on every verdict

## Anti-patterns

- Accepting risks verbally ("we'll fix that later") with no entry — later never reads the chat
- "Accepted because the user said so" without recording WHAT the user accepted
- A log with only rejections (acceptances are the riskiest entries and need the most justification)

## Example

Audit ruling: "2026-08-15: accepted — unauthenticated /api/health returns DB status string | risk: minor info leak (version string) | reason: monitoring dependency requires it; no credential exposure | reopen-if: the status string ever includes connection details". The next audit reads the reopen-if, checks the endpoint, and closes or reopens the verdict in one minute instead of re-auditing from scratch.
