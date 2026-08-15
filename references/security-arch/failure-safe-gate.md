# Failure-Safe Gate

## What

Verifies that failure modes close instead of open: when a check fails, a service dies, or an exception fires, the system must DENY — never grant access, never expose data, never bypass a control.

## Why

Fail-open is the quiet killer: the auth service is down so the middleware skips the check; the validation throws so the input passes through raw; the circuit breaker trips so the request is processed anyway. Every failure path is an attacker lever — cause the failure, inherit the access.

## When

Every control that can fail (auth checks, validation, rate limits, upstream calls), walked from the failure branch of the code.

## Protocol

1. For each control: read the FAILURE branch, not the happy path. What happens when the dependency it guards throws, times out, or returns garbage?
2. Classify: fail-closed (deny) / fail-open (allow) / fail-confused (unpredictable state).
3. Verify the interesting ones by attempt: kill the upstream, throw in the middleware, corrupt the config — observe what the system does.
4. Fail-open or fail-confused on a security-relevant control = finding, severity by what the failure grants.

## Evidence gates

- failure branches read for every security-relevant control
- fail-open paths verified by attempt where feasible
- per-control verdicts recorded

## Anti-patterns

- Reviewing only the happy path (the happy path is not where the bug lives)
- "It returns 500" assumed without checking what the 500 path did BEFORE returning
- Skipping the verification attempt on the grounds that "we can't easily break it in a review" (simulate the failure, it's the point)

## Example

Cart handler: `loadCart()` returned null on empty cart → `cart.items` threw → unhandled rejection → the submit silently did nothing. Not a security control — but the SAME pattern on the auth middleware (exception in the token check → next() skipped the check) would be fail-open Critical. The gate's walk flagged the pattern class, and the invariant engine added "auth failures must reject" as a checkable rule.
