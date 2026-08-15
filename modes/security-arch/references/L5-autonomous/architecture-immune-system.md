# Architecture Immune System

## What

SecurityArch's continuous mode: a baseline of what the "normal secure architecture" looks like; every change is compared against it semantically; deviations trigger a response. The system does not wait for the next audit — it reacts like an immune system to each change.

```
Known Secure Architecture (baseline model)
        ↓
   Change arrives (PR, config, infra)
        ↓
Semantic Security Diff
        ↓
New Trust / New Privilege / New Exposure?
        ↓
SecurityArch Response (flag → verify → accept/reject → update baseline)
```

## Why

Audits are periodic; changes are continuous. The gap between them is where breaches happen — a risky change can live for months before the next audit sees it. The immune system closes the gap: the semantic diff runs at change time, the baseline updates deliberately, and drift never accumulates silently.

## When

Always on during SecurityArch work and recommended as a standing discipline afterward (the Security Semantic Diff + Runtime Drift Detector are its instruments).

## Protocol

1. Baseline: the verified World Model after the audit (the "known secure" state).
2. On each change: run the semantic diff — classify deltas (NEW_TRUST / WIDER_PRIVILEGE / NEW_EXPOSURE / INVARIANT_RISK / NEUTRAL).
3. Response by class: NEUTRAL → accept silently; the rest → flag with the delta named.
4. Flagged deltas go through the standard loop (hypothesis → evidence → judge) — a delta that survives scrutiny is accepted AND the baseline is updated (the model evolves deliberately, never by accumulation).
5. Immune memory: accepted/rejected deltas feed the Security Learning Loop — the baseline gets smarter about what is normal for THIS system.

## Evidence gates

- baseline model exists and is versioned
- every change's delta classification recorded
- baseline updates are deliberate (accepted deltas), never silent absorption

## Anti-patterns

- Re-auditing from scratch each change instead of diffing (the immune system is incremental by design)
- Accepting deltas without the scrutiny loop "to keep moving" (that's how immunity fails)
- A baseline so stale every change looks abnormal (re-baseline after major approved changes)

## Example

After the audit, the baseline recorded: "no unauthenticated routes; DB unreachable externally". Two weeks later a PR adds a public status endpoint → semantic diff: NEW_EXPOSURE → flagged → scrutinized (does it leak? no — health string only) → accepted with the baseline updated to include it. Three days later another PR modifies that endpoint to include DB connection status → the delta (WIDER_PRIVILEGE: DB info to public) was flagged instantly — the immune system caught the regression the day it was written, not at the next audit.
