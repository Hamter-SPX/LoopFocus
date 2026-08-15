# SecurityArch (M3) — the intense security mode

Trigger words: security, audit, scan, vulnerab, CVE, secure, pentest, ช่องโหว่. Announced on entry. Profile: DEEP, always — SecurityArch does not run light.

## The 21-system core (references/security-arch/)

| Phase | Systems |
|---|---|
| **Map** | architecture-mapper · trust-boundary-mapper · attack-surface-mapper · data-flow-security · privilege-graph |
| **Model** | threat-model-engine · security-invariant-engine |
| **Gate** | boundary-gate · auth-authz-gate · secrets-gate · input-output-gate · dependency-gate · network-exposure-gate · storage-encryption-gate · failure-safe-gate |
| **Decide** | security-decision-log · risk-scoring · exploitability-judge · fix-architecture-planner |
| **Loop & Exit** | re-verify-loop · security-exit-gate |

Each system is a deep reference file with What/Why/When/Protocol/Evidence gates/Anti-patterns/Example. The mode runs them in order: Map → Model → Gate → Decide → Loop → Exit. The Security Exit Gate is the only door out — nine conditions, all demonstrably true.

## Mode contract

- May: inspect everything, run every audit tool, write findings, build threat models, run adversarial passes against the code's defenses.
- Must not: apply fixes without the user's selection (Fix Policy); report unverified suspicions as findings; declare anything "secure" — only "checked, with these tools, on this version".
- Gates that produce evidence: entry, context, assumption (exploitability claims), coverage, mutation, sast, artifact, completion.
- Closes when: the Security Exit Gate passes — mappers complete, 7 categories walked, machine scans run, every finding dispositioned, threat model + invariants recorded, re-verify clean, decision log present, user asked, completion gates pass.

## The 7-Category Coverage Checklist (walk ALL, even expecting nothing)

1. **Injection** — SQL, NoSQL, command, template, path traversal, header injection
2. **AuthN/AuthZ** — hardcoded secrets, weak comparison/type juggling, missing auth, IDOR, mass assignment
3. **Secret leakage** — hardcoded keys, .env committed, tokens in logs, secrets in client bundles, git history scan
4. **Dependency risk** — run the project's audit tool (npm audit / pip-audit / cargo audit / govulncheck) and read the reachable advisories
5. **Transport/config** — TLS, security headers, CORS, file permissions, rate limiting
6. **Data exposure** — PII, sensitive unauthenticated endpoints, error messages leaking internals
7. **Business logic flaws** — privilege escalation paths, flows that skip checks, replay-able actions

Recording: one ledger line per category, "checked — n findings" or "checked — none". An unlisted category is a gap, not a zero.

## Layer 2 — machine scans (mandatory in SecurityArch, output = evidence)

```bash
loopfocus sast          # curated static rules: SQL concat, eval/exec, unsafe HTML,
                        # hardcoded secrets, weak crypto, insecure transport
                        # every finding: file:line + rule + severity; Critical = blocking
loopfocus fuzz-check    # go: go test -fuzz=. -fuzztime=10s | python: hypothesis
                        # a crashing input = FAIL (evidence for injection/parsing findings)
loopfocus discover      # then run the project's real audit tool (npm audit etc.)
```

The scans are evidence generators, not certifications — findings still need file:line + reproduction before they enter the report. A clean scan says exactly what rules were run; it never says "secure".

## Layer 3 — threat model + adversarial pass (the "โหด" layer)

1. **Threat model canvas** (mandatory for any surface that handles input/credentials): draw the entry points, the trust boundaries, what an attacker controls, and what damage a compromise at each boundary causes. `references/canvas.md` applies — no boxes for code you have not read.
2. **Adversarial pass**: for every defense you find, attempt to defeat it (reproduce, not speculate): the loose `==` token → try the array coercion; the parameterized query → try to break out; the rate limit → try to bypass. A defense that survives your best attempt earns its finding's confidence level.
3. **Mutation check on security tests**: if the project has tests pinning a vuln fix, run `loopfocus mutation-test` — a security regression test that a mutant survives is decoration, not protection.

## Evidence bar

Every finding = `file:line` + a reproduction OR the audit tool's output. An unverified suspicion is an UNKNOWN in state.md, never a finding. Exploitability claims (remote? unauth?) are verified before being written.

## Severity taxonomy

| Severity | Decides |
|---|---|
| Critical | remotely exploitable, unauthenticated, or full compromise |
| High | serious impact with a weaker pre-condition |
| Medium | real flaw, limited impact or strong pre-conditions |
| Low | defense-in-depth, hygiene |
| Info | observation with no exploit path yet |

Severity comes from exploitability, not from how scary the name sounds.

## Fix policy inside SecurityArch

Findings → severity-ordered list → ask the user which to fix. Fixes follow the normal state machine (hypothesis → minimal change → test → regression check) and each fix is its own goal-locked task with a DoD chain whose regression test reproduces the exploit RED before the fix and stays GREEN after.

## Anti-patterns

- Calling a static source scan a certification (say what was and was not checked)
- Reporting a finding from "common patterns" without file:line
- Upgrading dependencies as one giant diff (one fix, one verification, per finding)
- Fixing a vuln without a regression test that pins the exploit
- Claiming "secure" — say what was verified, with what tool, on what version
- Skipping the threat model because "it is a small app" — small apps ship the same bugs
