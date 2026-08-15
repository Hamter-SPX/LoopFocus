# Knowledge Half-Life

## What

Every piece of context has a freshness class and an expiration behavior. The agent tags each belief with its half-life and refreshes only what expired — never everything.

## Why

Context is treated as uniformly true until it silently goes stale: the README that predates the refactor, the test run that predates the edit. Half-life makes staleness a property of the data type, so refresh effort goes exactly where decay actually happens.

## When

- At LOCK (tag the beliefs about the repo)
- After any code change (the code-change classes expire immediately)
- When acting on any stored value that has a fast half-life (runtime state especially)

## The classes

| Data | Half-life | Refresh trigger |
|---|---|---|
| repository structure (files, modules) | slow | new files/dirs appear |
| test results | expires on code change | any edit to covered code |
| runtime process state (logs, metrics, memory) | very fast | each observation |
| API docs / README | may drift from code | conflict detected (Context Conflict Resolver) |
| dependency versions | stable between upgrades | lockfile changes |

## Rules

1. Tag beliefs in the ledger with their class (part of the Assumption Registry's fields).
2. Refresh only the expired classes — a code edit expires test results, not the directory map.
3. Fast-half-life data is never stored for later use; it is read at the moment of decision (runtime state is a snapshot, not a record).
4. Evidence Freshness is the machine arm: any code file newer than the recorded state invalidates the state's claims.

## Evidence gates

- freshness classes visible on load-bearing beliefs
- expired classes refreshed before their values are used

## Machine check

```bash
bash scripts/gate-runner.sh   # evidence-freshness gate (code vs state mtimes)
```

## Anti-patterns

- Re-running the whole suite because one file changed (refresh the expired class, not everything)
- Trusting a README over the running code without a conflict check
- Storing a runtime metric and quoting it three loops later
