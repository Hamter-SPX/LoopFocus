# Input/Output Gate

## What

Checks every input the system accepts and every output it produces: inputs are validated at the boundary (type, length, charset, structure), outputs are encoded and bounded (no injection, no data leakage, no unbounded responses).

## Why

Injection lives at the input; data exposure lives at the output. Both are per-endpoint properties — a system with nine safe endpoints and one unsafe one is an unsafe system. The gate walks endpoints, not averages.

## When

Every entry point in the Attack Surface inventory, inputs and outputs separately.

## Protocol

1. **Input side**: for each entry point — what is accepted (type, size, structure), where is it validated (at the boundary, not deep inside), and where does validated data become trusted (the dangerous transition: SQL, shell, HTML, file paths, deserialization).
2. **Output side**: what is emitted — encoded for its context (HTML-encoded for browser, escaped for shell/logs), bounded in size, and free of data the caller should not receive (internal errors, stack traces, other users' records).
3. Verify the dangerous transitions by attempt: quote payloads for SQL, HTML tags for reflection, `../` for paths.
4. Per-endpoint verdicts recorded; a fail on either side is a finding.

## Evidence gates

- per-endpoint input and output verdicts
- dangerous transitions verified by payload attempts
- internal data (errors, traces) checked for in responses

## Anti-patterns

- Validating input "somewhere" in the flow instead of at the boundary (late validation still runs on attacker-shaped data)
- Output encoding skipped because "the data is internal" (internal data becomes output somewhere)
- Checking only string inputs (files, headers, and objects are inputs too)

## Example

/api/user?name=: input side — no validation at the boundary, string reaches SQL concat (F1 Critical, reproduced with `' OR '1'='1`). Output side — /debug returned process.env + db.config unauth (F5). One endpoint, both gates failing, two findings with different remediations — the separation made each fix precise.
