# L7 Pipeline — Autonomous Architecture Approval

## What

The complete L7 flow: from raw intent to an APPROVED architecture — with every step producing evidence and every authority independent.

```
Intent
  ↓
Business Requirements
  ↓
Architecture Candidate A/B/C      (Synthesizer)
  ↓
SecurityArch World Model          (L1 maps rebuilt per candidate)
  ↓
Formal Constraints                (Constitution + compiled invariants)
  ↓
Threat / Trust / Identity / Data Analysis   (L2)
  ↓
Counterexamples                   (Counterexample Generator)
  ↓
Adversarial Review                (Adversarial Architect)
  ↓
Architecture Optimization         (Policy Synthesis + Least-Privilege)
  ↓
Proof / Evidence                  (Evidence Ledger + Proof-Carrying)
  ↓
Independent Judge                 (Independent Judge + Quorum for Criticals)
  ↓
Approved Architecture
```

## When

When SecurityArch is asked to PRODUCE an architecture (new system, major redesign), not just audit one. This is the mode's highest-level function.

## Protocol

1. **Intent → Requirements**: the user's intent becomes checkable business requirements (what must the system do — written so candidates can be scored against it).
2. **Candidates**: the Synthesizer generates A/B/C under the hard constraints.
3. **Per candidate**: a World Model is built, then the full L2-L4 stack runs (analysis, counterexamples, adversarial review).
4. **Optimization**: surviving candidates are optimized (policy synthesis, least-privilege, minimum-trust).
5. **Proof**: the optimized candidate's claims are evidenced (Proof-Carrying blocks attached to every trust edge).
6. **Judgment**: the Independent Judge (and quorum for Critical-adjacent claims) rules on each candidate.
7. **Approval**: the surviving candidate(s) go to the USER — SecurityArch approves technically; the user approves ownership. "Approved Architecture" means both.

## Evidence gates

- requirements are checkable (candidates scored against them)
- every candidate ran the full stack (no shortcuts per candidate)
- the user's approval is the final step (SecurityArch proposes, never commits the organization)

## Anti-patterns

- Candidates that skip the counterexample round (unfalsified candidates are unapproved candidates)
- SecurityArch selecting the winner for the user (the report presents scored options; the user chooses)
- Approving an architecture whose trust edges lack proof blocks ("it was designed well" is not a proof block)

## Example

"Build the billing service" → requirements compiled (idempotency, audit trail, CONST-003 applicability) → three candidates → candidate B eliminated by counterexample (its retry semantics broke idempotency under partial failure) → C optimized (least-privilege scopes) → proof blocks attached → judge PASS → user chose C with the recorded tradeoff. The pipeline produced a security-approved architecture from an intent — the L7 promise, delivered end to end.
