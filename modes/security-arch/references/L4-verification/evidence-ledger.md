# Evidence Ledger

## What

The mandatory record for every finding: Evidence, Attack preconditions, Affected boundary, Impact, Confidence, Contradicting evidence, Verification status — seven fields, all present, or the finding does not exist.

## Why

"Critical because I think so" is the failure mode the ledger forbids. The seven fields force the finding to be a complete claim: what was observed, under what conditions, at which boundary, doing what damage, with how much certainty, against what counter-evidence, verified how. A finding that cannot fill the fields was never a finding — it was a feeling.

## When

Every finding, before it enters any report, any exit gate, any severity discussion.

## The seven fields (machine-validated via `loopfocus evidence-check`)

```json
{
  "title": "...",
  "evidence": "file:line + reproduction or tool output",
  "attack_preconditions": "what the attacker needs first",
  "affected_boundary": "which trust crossing is broken",
  "impact": "what data/asset is reached, with its data class",
  "confidence": "Known | Likely | Unknown",
  "contradicting_evidence": "anything that weakens the claim (empty list is a claim)",
  "verification_status": "reproduced | tool-verified | unverified"
}
```

## Protocol

1. A candidate finding is drafted with all seven fields.
2. `loopfocus evidence-check --file <finding>` validates presence — missing fields = reject, not report.
3. `loopfocus risk-score` then computes severity × confidence; Unknown confidence cannot report at full severity.
4. The completed finding is appended to the ledger file (`.loopfocus/findings.jsonl`) — the ledger is the audit's spine, and every exit condition reads from it.
5. Contradicting evidence is NEVER left empty for High/Critical — the judge must have hunted for it.

## Evidence gates

- seven fields present (machine-checked)
- confidence honest (Unknown stays Unknown until verified)
- the findings ledger is current (every report item traces to a ledger entry)

## Anti-patterns

- Reporting from memory without reconstructing the evidence path
- "Contradicting evidence: none found" without having looked (the look must be recorded)
- Patching the finding's wording until the fields fit (the fields must fit the truth)

## Example

The `==` token finding: evidence = `auth.js:5` + node reproduction of `['admin123'] == 'admin123'`; preconditions = unauthenticated request with crafted query; boundary = internet → admin API; impact = admin functions (Crown Jewel-adjacent); confidence = Known (reproduced); contradicting = none after testing strict equality fix; verification = reproduced. The ledger entry survived the multi-judge quorum unchanged — because it was complete.
