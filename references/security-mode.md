# M3 — Security Mode

Trigger words: security, audit, scan, vulnerab, CVE, secure, pentest. Announced on entry.

## Mode contract

- May: inspect everything, run audit tools, write findings, propose fixes.
- Must not: apply fixes without the user's selection (Fix Policy).
- Gates that produce evidence: entry, context, assumption (exploitability claims), test (after any fix), artifact (reports), completion.
- Closes when: all 7 checklist categories walked, every finding carries evidence, the user has been asked about fixes, ledger + genome recorded.

## The 7-Category Coverage Checklist (walk ALL, even expecting nothing)

1. **Injection** — SQL, NoSQL, command, template, path traversal, header injection
2. **AuthN/AuthZ** — hardcoded secrets, weak comparison/type juggling, missing auth, IDOR, mass assignment
3. **Secret leakage** — hardcoded keys, .env committed, tokens in logs, secrets in client bundles
4. **Dependency risk** — run the project's audit tool (npm audit / pip-audit / cargo audit / govulncheck) and read the reachable advisories
5. **Transport/config** — TLS, security headers, CORS, file permissions, rate limiting
6. **Data exposure** — PII, sensitive unauthenticated endpoints, error messages leaking internals
7. **Business logic flaws** — privilege escalation paths, flows that skip checks, replay-able actions

Recording: one ledger line per category, "checked — n findings" or "checked — none". An unlisted category is a gap, not a zero.

## Evidence bar

Every finding = `file:line` + a reproduction OR the audit tool's output. An unverified suspicion is an UNKNOWN in state.md, never a finding. Exploitability claims (remote? unauth?) are verified before being written — a finding without exploitability is a severity guess.

## Severity taxonomy

| Severity | Decides |
|---|---|
| Critical | remotely exploitable, unauthenticated, or full compromise |
| High | serious impact with a weaker pre-condition |
| Medium | real flaw, limited impact or strong pre-conditions |
| Low | defense-in-depth, hygiene |
| Info | observation with no exploit path yet |

Severity comes from exploitability, not from how scary the name sounds.

## Fix policy inside M3

Findings → severity-ordered list → ask the user which to fix. Fixes follow the normal state machine (hypothesis → minimal change → test → regression check). Security fixes are never "improvements" — each is its own goal-locked task with its own DoD chain.

## Anti-patterns

- Calling a static source scan a certification (say what was and was not checked)
- Reporting a finding from "common patterns" without file:line
- Upgrading dependencies as one giant diff (one fix, one verification, per finding)
- Fixing a vuln without a regression test that pins the exploit
- Claiming "secure" — say what was verified, with what tool, on what version
