# Data Flow Security

## What

Traces sensitive data along its full journey — source → processing → storage → output — and checks the controls at EVERY hop, not just at the endpoints.

## Why

Data is most exposed in transit and in transformation, exactly where per-hop audits stop. A credential encrypted at rest but logged in a debug line mid-processing is compromised; the flow trace catches what endpoint checks miss.

## When

After the Attack Surface Mapper. Pick the sensitive data classes (credentials, tokens, PII, payment data) and trace each.

## Protocol

1. Classify the sensitive data: what types exist (credentials, PII, financial, session tokens).
2. For each type, trace the full path: where it enters, where it is processed (every handler/function that touches it), where it is stored, where it is emitted (logs, responses, files, caches, third parties).
3. At each hop check: is it validated? encrypted? masked in logs? present in error messages? cached unnecessarily? sent to a third party?
4. Cross-check outputs: grep logs/code for the data's identifiers — a data class that appears in an output it should not touch is a finding with a hop number.
5. Record the flow as a canvas path — the trace IS the deliverable, not just its findings.

## Evidence gates

- one trace per sensitive data class
- every hop has a control verdict (ok / weak / missing)
- findings cite the hop, not just "data exposure"

## Anti-patterns

- Checking storage encryption and declaring the flow secure (transit/processing hops remain)
- Tracing only credentials (PII and session tokens fund their own breaches)
- A trace with endpoints and no middle (the middle is where data actually leaks)

## Example

Reset-password feature prediction: SMTP credentials added to config → flow trace follows them: entered via env → loaded into db.config → **emitted by the unauth /debug dump** → the hop-level finding (F5) was already a Known risk in the Predictive Analysis before the feature existed.
