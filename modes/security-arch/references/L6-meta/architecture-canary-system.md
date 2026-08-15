# Architecture Canary System

## What

Places lightweight invariant checks at critical points like canaries in a coal mine: when system behavior starts drifting from the security model, the canary dies loudly and early — long before the drift becomes a finding.

## Why

Big breaches begin as small deviations: a route added without auth, a role widened "temporarily", a config override committed. Full audits run too slowly to catch these at birth. Canaries are the cheap, always-on checks that die at the first deviation — converting silent drift into an immediate signal.

## When

L6 — installed after the audit, as the immune system's tripwires. Each canary is a compiled check (Security Semantic Compiler output) at a sensitive point.

## The canary design

| Canary | Watchpoint | Dies when |
|---|---|---|
| route-auth canary | route table vs middleware | any route appears outside the middleware chain |
| role-drift canary | IAM baseline | any permission appears that is not in the baseline |
| secret-scan canary | commit stream | any credential-shaped string lands in the repo |
| config canary | deploy configs | a security-relevant config key changes value |
| invariant canary | compiled invariant checks | any invariant check fails |

## Protocol

1. Pick the watchpoints from the audit's findings (each fixed class gets a canary so it cannot silently return).
2. Install as CI jobs / scheduled checks / deployment hooks — canaries run continuously, not on demand.
3. A dead canary triggers the standard loop: the deviation is treated as a finding candidate with the semantic diff attached.
4. Record canary history: what died, when, what it caught — the canary log is the immune system's memory.

## Evidence gates

- canaries installed per fixed finding class
- canary deaths recorded with the deviation they caught
- canary checks themselves verified (a canary that cannot die is decoration — mutation-test the canaries)

## Anti-patterns

- Canaries only on the biggest issues (the small drifts are the early warnings)
- A dead canary ignored "because it's probably a false positive" (investigate first, suppress second)
- Never testing whether the canaries can fire (run the mutation: inject a deviation, watch it die)

## Example

The route-auth canary died 11 days after the audit: a new status endpoint had been registered outside the middleware chain. The team had 11 days of drift, not months; the fix was a one-line re-registration; and the canary log recorded the near-miss — proving the immune system worked, which justified installing canaries for the remaining finding classes.
