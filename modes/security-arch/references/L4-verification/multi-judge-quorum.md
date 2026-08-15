# Multi-Judge Quorum

## What

Critical-level findings get THREE independent verdicts — Security Architect, Adversarial Reviewer, Independent Judge — before the finding is final. The quorum combines them into one verdict with dissent recorded.

## Why

A Critical finding triggers expensive remediation; a false Critical burns trust and budget, a missed Critical burns everything else. Three perspectives with different biases (the designer's optimism, the adversary's skepticism, the judge's neutrality) converge on verdicts that one perspective alone cannot produce. Dissent is recorded, not averaged away.

## When

Every Critical finding (and contested High findings). The quorum runs on the Evidence Ledger entry — all three read the same record.

## The three roles

| Role | Bias to counter | Asks |
|---|---|---|
| Security Architect | optimism | does the evidence support the severity I proposed? |
| Adversarial Reviewer | false-negative risk | what would an attacker need for this to NOT work? have I been too generous? |
| Independent Judge | neither | does the record, on its own, justify the claim? |

## Protocol

1. The finding enters quorum with its complete seven-field record.
2. Each role writes its verdict independently (no seeing the others' first — independence is the mechanism).
3. Combine: 3 PASS = confirmed; 2 PASS = confirmed with recorded dissent; 2+ REJECT = rejected (with reasons); any NEED_MORE_EVIDENCE = the finding returns for evidence, verdict suspended.
4. The quorum result is a ledger entry: who said what, the dissent, the final verdict.
5. A rejected Critical does not disappear — it is logged with the rejection reason (Decision Log), and its reopen-if condition names what would revive it.

## Evidence gates

- three independent verdicts recorded per Critical
- dissent recorded verbatim (not summarized into agreement)
- suspended findings carry the missing-evidence list

## Anti-patterns

- Running the quorum as three paragraphs from one reasoning stream (that's one judge with three hats)
- Averaging ("2.5 judges agree") — verdicts are votes, not scores
- Dropping a rejected Critical silently (the rejection is a decision; log it)

## Example

The SQLi finding went to quorum: Architect PASS (reproduced), Adversarial PASS but dissented on severity (wanted Critical; the judge's note on preconditions kept it Critical because unauth), Judge PASS. 3 PASS with dissent recorded. The dissent itself later mattered: when the auth layer hardened, the reopen-if condition in the log downgraded the finding honestly.
