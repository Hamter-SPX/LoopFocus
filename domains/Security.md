# Security Domain Pack

The M3-mode reference condensed to stack-agnostic actions. Load with `references/security-arch.md` during any audit.

## The 7-category walk (never skip)

```bash
# per category, one ledger line: "checked — n findings" or "checked — none"
1. Injection        SQL/NoSQL/command/template/path/header
2. AuthN/AuthZ      hardcoded secrets, weak comparison, IDOR, mass assignment
3. Secret leakage   hardcoded keys, committed .env, tokens in logs
4. Dependency risk  run the REAL audit tool — output is evidence
5. Transport/config TLS, headers, CORS, permissions, rate limiting
6. Data exposure    PII, unauthenticated endpoints, verbose errors
7. Business logic   privilege escalations, replay, flows that skip checks
```

## Audit commands per stack

```bash
npm audit --audit-level=high            # JS-TS
pip-audit                                # Python
govulncheck ./...                        # Go
cargo audit                              # Rust
```

## Evidence bar

Every finding = `file:line` + reproduction OR tool output. Unverified = UNKNOWN in state.md, not a finding. Exploitability (remote? unauth?) verified before severity is assigned.

## Severity by exploitability

Critical = remotely exploitable, unauthenticated, or full compromise. Severity never comes from how scary the name sounds.

## The oscillation trap in security fixes

Fixing a vuln that breaks a feature, then fixing the feature that reopens the vuln — the swap pattern. The shared root cause is usually the missing security boundary both sides needed. Draw the boundary on the Canvas before the third edit.

## Fix policy

Severity-ordered proposal → ask the user which to apply → each fix is its own goal-locked task with DoD chain and regression test that pins the exploit.

## Post-fix verification

The regression test must reproduce the exploit RED before the fix and stay GREEN after: `loopfocus signal` + `loopfocus genome record --class security-<area>`.
