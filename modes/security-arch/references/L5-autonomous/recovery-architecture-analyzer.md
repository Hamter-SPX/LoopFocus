# Recovery Architecture Analyzer

## What

Security does not end at prevention: the analyzer verifies that after a compromise, the system can ISOLATE the compromised component, REVOKE its credentials, RESTORE from clean state, and RECOVER service — with each step tested, not assumed.

## Why

Every system gets compromised eventually; the difference between an incident and a catastrophe is the recovery architecture. Teams that never planned recovery discover it is missing at the worst moment — revocation paths that do not exist, backups that were never tested, isolation boundaries that were only diagrammed. The analyzer makes recovery a designed property instead of a hoped-for one.

## When

L5, after the blast radius and defense map exist (it uses both: the radius names what must recover, the map's recovery column is its input).

## Protocol

1. Per crown-jewel and per high-blast-radius component: walk the four recovery verbs —
   - **Isolate**: can the component be cut off without collapsing dependents? (fan-in from the blast radius)
   - **Revoke**: can its credentials be invalidated, and how long until revocation propagates? (Revocation Propagation Analyzer)
   - **Restore**: is there a clean backup/state, and when was it last TESTED? (an untested backup is a rumor)
   - **Recover**: is there a runbook, and has it been drilled?
2. Classify per verb: verified (tested/drilled), designed-only (exists on paper), absent.
3. Designed-only and absent are findings — severity by the component's blast radius.
4. The analyzer's output feeds the exit gate (a system with no tested recovery cannot claim a complete security posture).

## Evidence gates

- four verbs walked per critical component
- "tested" means evidence of the test/drill, not the existence of the plan
- absent/designed-only verbs recorded as findings

## Anti-patterns

- Counting the existence of backups as recovery (restore-from-backup is the verb, and it needs its drill)
- Skipping revocation ("we'd rotate keys if needed" — rotation during an incident is the hard time to do it first)
- Isolation plans that assume the network is healthy (isolation must work while things are on fire)

## Example

Crown jewel = the payments ledger. Isolate: network rules existed (designed-only, never tested under load). Revoke: the shared admin token could NOT be revoked — it was baked into three services (absent → the finding that forced the key-split fix). Restore: backups existed; the last restore drill was 14 months old. Recover: no runbook for the ledger specifically. Four verbs, three findings — and the key-split became the audit's top fix because recovery analysis proved the token's unrevocability, which no prevention check would have surfaced.
