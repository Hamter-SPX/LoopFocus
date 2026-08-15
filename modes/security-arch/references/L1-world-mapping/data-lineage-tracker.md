# Data Lineage Tracker

## What

Follows data through EVERY system it passes: input → process → cache → DB → log → analytics → output. Leakage is found at the hops, not at the endpoints.

## Why

Data leaks in the middle: written to a log, sent to analytics, cached without expiry, copied to a backup nobody classified. Endpoint checks (storage encrypted? output encoded?) miss exactly these hops — the lineage trace makes every hop a checkpoint where a control either exists or becomes a finding.

## When

L1, as the concrete execution of data-flow-security for each Sensitive/Secret/Crown Jewel class.

## Protocol

1. Pick a data class (start with Secret and Crown Jewel).
2. Trace hop by hop: entry point → every function/service that touches it → every store (cache, DB, file) → every emitter (log, response, analytics, third party).
3. Per hop: record the control verdict — validated? masked? encrypted? necessary at all? (a data class in a hop it does not need is a finding by itself: "why is the password in the analytics payload?")
4. Record the lineage in the World Model as a path — the trace is the deliverable, findings are its byproducts.
5. Cross-check by grep: search logs/code for the data's identifiers; an identifier appearing where the trace says it should not = a finding with a hop number.

## Evidence gates

- one lineage trace per Sensitive/Secret/Crown Jewel class
- per-hop control verdicts recorded
- greps run to cross-check emitted identifiers

## Anti-patterns

- Tracing endpoints only (the middle hops are where leakage lives)
- One trace standing in for all data classes (Secret and PII leak differently)
- Trusting the trace without the grep cross-check (the trace is a model; the grep is reality)

## Example

Credential lineage: env → config → db.config → /debug response → (should stop) — the trace showed the credential reaching an output hop with no masking control, which became finding F5 with the exact hop named ("emitted at /debug response"), instead of the vaguer "credentials exposed".
