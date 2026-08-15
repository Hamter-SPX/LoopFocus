# SecurityArch — Docs

The complete operating documentation for the SecurityArch mode of LoopFocus.

## Trigger

security, audit, scan, vulnerab, cve, secure, pentest, ช่องโหว่ — or explicitly: `loopfocus mode show security-arch`.

## Contract (from mode.js)

- **May**: inspect everything, run every audit tool, write findings, build threat models, adversarial passes, synthesize architectures.
- **Must not**: apply fixes without user selection; report unverified suspicions as findings; declare "secure"; override the Security Constitution; judge own findings.
- **Profile**: DEEP always.
- **Closes when**: Security Exit Gate passes (9 conditions).
- **Flow**: `flow/security-audit-flow.md`.

## The pipeline (mandatory order)

```
Repository/System Recon
→ Security World Model
→ Architecture/Data/Identity/Trust/Dependency Graphs + Attack Surface
→ Security Invariants + Assumption Registry + Security Constitution load
→ Threat Hypothesis Generation (Unknown-Unknown Hunter)
→ Attack-Path Reasoning (Causal Attack Graph + Multi-Hop)
→ Counterfactual Simulation (Blast Radius + Digital Twin)
→ Adversarial Architect + Architecture Mutation Testing
→ Evidence Collection (Evidence Ledger + Contradiction Engine)
→ Risk Scoring + Exploitability Judge (Independent Judge + Quorum for Critical)
→ Policy Synthesis + Least-Privilege Optimization
→ Fix Architecture Planner (Proof-Carrying + Proof of Remediation)
→ Implementation/Fix
→ Re-map (Security Semantic Diff + Runtime Drift)
→ Recursive Architecture Challenge (loop until convergence conditions)
→ Security Exit Gate
```

## Layer reference index

| Layer | Path | Systems |
|---|---|---|
| L1 World Mapping | `references/L1-world-mapping/` | 15 |
| L2 Analysis | `references/L2-analysis/` | 8 |
| L3 Adversarial | `references/L3-adversarial/` | 7 |
| L4 Verification | `references/L4-verification/` | 13 |
| L5 Autonomous | `references/L5-autonomous/` | 8 |
| L6 Meta | `references/L6-meta/` | 20 |
| L7 Formal | `references/L7-formal/` | 6 |
| L8 Cross-Layer | `references/L8-cross-layer/` | 33 |
| Gates | `references/gates/` | 14 |
| Exit | `references/exit/` | 2 |

Total: 126 systems. Load the file for the layer you are working in — never all of them.

## Machine tools

```bash
loopfocus sast                    # static scan, curated rules (Critical = blocking)
loopfocus fuzz-check              # go fuzz / python hypothesis
loopfocus mutation-test           # security tests must catch mutants
loopfocus security-exit           # the 9-condition exit gate
loopfocus constitution-check      # does the change violate the Security Constitution?
loopfocus risk-score <finding>    # two-axis severity × confidence
loopfocus evidence-check <file>   # every finding must carry the 7 evidence fields
```

## The Security Constitution

Lives at `.loopfocus/constitution.md` (or the repo's `SECURITY_CONSTITUTION.md`). Format:

```text
CONST-001 Private user data must never cross tenant boundaries.
CONST-002 No internet-facing component receives direct database credentials.
CONST-003 Human administrator credentials cannot be used by autonomous agents.
CONST-004 Critical actions require independently verifiable authorization.
CONST-005 Compromise of one service must not imply compromise of the whole system.
```

SecurityArch has NO authority to override the Constitution. A proposal that violates a CONST is BLOCKED — the user may amend the Constitution, the mode may not.

## The exit gate (9 conditions)

mappers complete · 7 categories walked · machine scans run · every finding dispositioned · threat model + invariants recorded · re-verify clean · decision log present · user asked · completion gates pass. Machine check: `loopfocus security-exit`.

## Completion report

The standard LoopFocus 10-item contract, plus SecurityArch-specific items:
- the World Model summary (what the system IS)
- attack chains found (paths, not points) with the highest-risk chain first
- the Constitution check result (proposals blocked/accepted)
- the Independent Judge verdicts (who judged, what they said)
- the Trust Proof for the most sensitive data path (End-to-End, per hop)
