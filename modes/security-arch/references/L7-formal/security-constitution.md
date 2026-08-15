# Security Constitution ⭐

## What

The per-project security constitution — CONST-001..CONST-00N — the highest authority in SecurityArch. It binds EVERYTHING: the analysis, the fixes, the synthesized architectures, and SecurityArch itself. The mode has no right to override it; a proposal that violates a CONST is BLOCKED.

## Why

The most dangerous property an AI security system can have is the ability to edit its own rules. The Constitution removes that: the rules live OUTSIDE the mode's authority, written by the project's humans. SecurityArch's power stops exactly at the Constitution's edge — and the system is designed to make that edge explicit and enforced, not honored-in-spirit.

## Where it lives

`.loopfocus/constitution.md` (per repo) or the repo's `SECURITY_CONSTITUTION.md`. Loaded at mode entry; versioned with the repo; amendable only by the project owner.

## The standard seed

```text
CONST-001 Private user data must never cross tenant boundaries.
CONST-002 No internet-facing component receives direct database credentials.
CONST-003 Human administrator credentials cannot be used by autonomous agents.
CONST-004 Critical actions require independently verifiable authorization.
CONST-005 Compromise of one service must not imply compromise of the whole system.
```

## Protocol

1. At mode entry: load the Constitution (missing Constitution = a finding about the project, and the audit proceeds on the seed set with that gap recorded).
2. Every proposal — fix, synthesized architecture, policy, scope change — runs `loopfocus constitution-check` before it proceeds. The check requires every CONST to be ADDRESSED (comply with evidence, or violate → BLOCK).
3. A BLOCKED proposal returns to its author with the violated CONST named. SecurityArch does not suggest workarounds for the Constitution.
4. Amendments are the owner's alone: SecurityArch may PROPOSE an amendment with reasoning (the world changed, the rule is stale) but may not apply it.

## Evidence gates

- Constitution loaded and versioned
- constitution-check run per proposal (machine-enforced)
- violations BLOCKED with the CONST named
- amendment proposals recorded as owner-owned

## Anti-patterns

- Treating the Constitution as "guidelines" when the schedule tightens (it is the one thing that must not bend)
- SecurityArch silently editing the Constitution "for this special case" (that is the one forbidden act)
- A Constitution so vague it can never be violated (a rule that cannot fire cannot protect)

## Example

The proposed "quick fix": put the DB password directly in the web service's env for the release. constitution-check: CONST-002 → BLOCKED. The alternative (secret manager lookup) cost a day. The team later said the block was the moment they understood the Constitution was real — and the mode's credibility came from that very refusal.
