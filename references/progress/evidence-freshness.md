# Evidence Freshness

## What

Evidence expires when the code changes. A test run that predates the latest edit certifies nothing — re-run before claiming, or label the claim stale.

## Why

The cheapest hallucination in software work is the stale green: the tests passed, then someone changed the code, and the green is still quoted. Freshness makes the temporal condition explicit: evidence is a claim about a specific artifact state, and it dies with that state.

## When

- Before every completion claim (does the evidence postdate the last change?)
- At the evidence-freshness gate (mtime comparison against state.md)
- After any dependency upgrade or config change (they invalidate like code edits)

## Protocol

1. Bind each evidence artifact to its artifact state: commit hash or file mtimes (`evidence: .loopfocus/evidence/attempt-4-test.log @ commit abc123`).
2. Before quoting evidence: is the artifact state still current? No → the evidence is stale: re-run or label it explicitly as historical.
3. The evidence-freshness gate automates the code-side check: any tracked file newer than state.md means the recorded state is stale.
4. Stale evidence in a report is a finding, not a footnote — it means the verification chain broke.

## Evidence gates

- evidence artifacts carry their commit/timestamp
- freshness gate passes before completion claims

## Machine check

```bash
bash scripts/gate-runner.sh   # evidence-freshness gate
```

## Anti-patterns

- "It passed earlier" as a current claim
- Re-running one test and calling the whole suite's old green fresh
- Recording state.md from memory after the edits (state records the actual workspace, not the intention)
