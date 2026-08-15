# Independent Judge

## What

The verdict authority that is NOT the discoverer. Findings flow: Discoverer → Evidence → Independent Security Judge → PASS / REJECT / NEED_MORE_EVIDENCE.

## Why

Self-judgment is the single biggest source of false confidence in security work: the architect who found the flaw also decides it is fixed. The separation is structural honesty — the judge has no stake in the finding being right, so it can demand the evidence actually holds. It is the same principle as code review, applied to security verdicts.

## When

Every High/Critical finding verdict, every "safe" declaration, every exit-gate condition that depends on a security claim. The judge reads the Evidence Ledger entry and nothing else first — the finding must stand on its record.

## Protocol

1. Discoverer completes the seven-field finding and submits it.
2. The judge (a separate persona/pass — NEVER the same reasoning stream) reviews ONLY the evidence: does the evidence support the claimed impact? does it reproduce? do the preconditions hold? is the boundary actually crossed?
3. Verdicts:
   - **PASS** — the finding stands as recorded.
   - **REJECT** — the evidence does not support it (recorded with the reason — a rejection is a finding about the finding).
   - **NEED_MORE_EVIDENCE** — plausible but unproven; the missing evidence is named.
4. Critical findings escalate to the Multi-Judge Quorum; the independent judge is always one vote.
5. Verdicts are ledger entries — who judged, what they said, when.

## Evidence gates

- judge identity recorded (which pass/persona, with what inputs)
- REJECT and NEED_MORE_EVIDENCE verdicts carry reasons
- no finding reaches the report without a judge verdict

## Anti-patterns

- The discoverer judging their own finding ("I verified it myself")
- A judge that rubber-stamps because the discoverer "usually finds real stuff"
- PASS verdicts without naming what was checked in the evidence

## Example

Finding: "the payment webhook can be forged". Judge review: the evidence showed the secret was in the client bundle (reproduced) — PASS. Second finding: "the DB backup is unencrypted" — judge found the evidence was a config comment, not a backup inspection → NEED_MORE_EVIDENCE (inspect an actual backup). The finding returned with real evidence or died — exactly the filter the judge exists to be.
