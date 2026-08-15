# Security Example — condensed M3 audit result

From the M3 GREEN verification session (2026-08-15). Shows the shape of a complete audit, not the full report.

## Coverage (7 categories, all walked)

| Category | Findings |
|---|---|
| Injection | F1 Critical (SQL concat), F2 Critical (login SQLi) |
| AuthN/AuthZ | F3 High (hardcoded token), F7 Medium (`==` type juggling) |
| Secret leakage | F4 High (DB password in source) |
| Dependency risk | F6 High (express 4.16 — 7 advisories, qs proto-pollution reachable) |
| Transport/config | F10 Low (no rate limit), F12 Info (no security headers) |
| Data exposure | F5 High (/debug dumps process.env unauth) |
| Business logic | F9 Medium (every login gets the static admin token) |

## Evidence bar (every finding carries a path)

- F1: `server.js:10` — repro: `x' OR '1'='1` returns all rows (run live)
- F2: `server.js:20-21` — repro: `admin' -- ` logs in without password
- F7: `auth.js:5` — repro: `['admin123'] == 'admin123'` → `true` in node

## The ask (Fix Policy — nothing fixed silently)

> Found 12 issues: 2 Critical, 4 High, 3 Medium, 2 Low, 1 Info.
> Proposed order: parameterize SQL → replace token check → move DB creds to env → upgrade express → auth + rate-limit /debug removal.
> Which should I apply?

## Post-fix contract

Each fix = separate goal-locked task with a regression test that reproduces the exploit RED and pins it GREEN. Genome class: `security-<area>` (e.g. `security-injection`).

## What an audit report must also say

What was NOT checked: no runtime exploit of /debug (deps not installed), no browser-based CSRF test, secrets scan covered git history but not artifact archives.
