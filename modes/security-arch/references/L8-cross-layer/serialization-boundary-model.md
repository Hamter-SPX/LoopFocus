# Serialization Boundary Model

## What

Models every point where data representation changes format — struct → JSON → bytes → protobuf → SQL → HTML — as a security boundary, because each transformation is a place where invariants silently break.

## Why

Serialization boundaries are the busiest security edges in modern systems and the least reviewed: the field that validates in the struct arrives as a string in JSON, survives as bytes in the queue, and reappears in HTML where the encoder forgot it. Each format change re-opens the validation question — and the model makes each hop an explicit checkpoint instead of an assumption.

## When

L8 — anywhere data crosses formats (APIs, queues, storage, UI, RPC) — which is everywhere.

## Protocol

1. Trace each data class's format journey: what format at each hop, what transformation happens.
2. Per transformation: check the three serialization invariants — type preserved (or explicitly converted), length bounded, semantics preserved (a number stays a number; a date stays a date).
3. Flag hops where invariants drop: the field that loses its type, the length that grows, the semantic drift (a string that becomes executable HTML).
4. The boundary contracts join the World Model — serialization hops are edges with contracts.

## Evidence gates

- format journeys traced per data class
- per-hop type/length/semantics verdicts
- invariant-drop hops flagged

## Anti-patterns

- "JSON is JSON" (the JSON at the API and the JSON at the DB are different edges)
- Checking the entry format only (the middle formats are where the drift happens)
- Assuming the framework serializes safely (frameworks serialize conveniently — verify the invariants)

## Example

The user profile's journey: struct (name: String) → JSON (fine) → queue (fine) → re-parsed into a template (the name landed in HTML unencoded — semantics drifted from "text" to "markup"). The model's hop 4 flag (semantics-preserved: NO) caught the stored-XSS at the serialization boundary — where no single format's review would have seen the journey's end.
