# Risk Concentration Engine

## What

Finds nodes where privilege, data, and trust accumulate beyond any functional need — before a vulnerability exists. Concentration is risk; the engine names it as such.

## Why

Vulnerabilities come and go; concentration stays. A node holding three Crown Jewel classes and five services' credentials is a disaster waiting for ANY bug — and concentrating first, then auditing, is how systems get their single points of failure. The engine flags the accumulation itself, which is fixable even when no bug is present.

## When

L6, on the World Model's privilege/data/trust edges. Re-run after architecture changes (concentration grows silently).

## Protocol

1. Compute per node: distinct data classes held, distinct privileges, distinct principals trusting it.
2. Flag concentrations: multiple Crown Jewel/Sensitive classes on one node; one node in the trust closure of many principals; one credential granting many unrelated capabilities.
3. The flag is a finding even with zero known vulnerabilities — "concentration with no compensating controls" is the finding; "concentration with verified compensating controls" is a logged risk.
4. Responses: split the node (separate stores, separate keys, separate services), or record the deliberate acceptance with its reopen-if (Decision Log).

## Evidence gates

- per-node concentration computed from the model
- concentrations flagged with or without vulnerabilities present
- acceptances recorded as decisions with reopen-if

## Anti-patterns

- Only flagging concentration when a bug exists (concentration is the finding; the bug is just its first symptom)
- "It's convenient to keep them together" as a response (convenience is what built the concentration)
- Flagging but never splitting or accepting (an unresolved flag is noise)

## Example

The db.config object: held the DB credential (Secret), the SMTP credential (Secret), the admin token (Secret), AND was reachable by every service (trust closure). Three secret classes, one node, all-services trust — concentration flagged before anyone found the /debug dump. The split (one secret store per purpose) reduced the node's blast radius structurally, so when /debug was later discovered, its damage was already a fraction of what it would have been.
