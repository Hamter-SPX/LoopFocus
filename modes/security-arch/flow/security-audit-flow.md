# Security Audit Flow

**Why:** security findings live or die on evidence and coverage; unchecked categories and unverified exploits are the two classic hollow audits.

**When:** "security review", "audit", M3 territory.

## Steps

1. **LOCK** — scope of the audit (files/services/boundaries), profile DEEP. `references/security-arch.md`.
2. **Tool discovery + audit tools** — run the project's real audit command (npm audit etc.) early; results are evidence, not the audit.
3. **Walk the 7-category checklist** — all of them, recording one ledger line per category even when empty.
4. **Verify every finding** — file:line + repro or tool output. Exploitability verified before severity is assigned.
5. **Severity taxonomy** — Critical/High/Medium/Low/Info by exploitability.
6. **Fix policy** — propose severity-ordered fixes; ASK the user which to apply. Fixes are separate goal-locked tasks.
7. **Record** — ledger + state + genome (`--class security-<area>`); predictions for "what would break if we add feature X" in the predictive section.
8. **Report** — findings, evidence, severity, what was checked, and explicitly what was NOT checked.

## Evidence gates

- all 7 categories walked with records
- zero findings without file:line or tool output
- user asked before any fix
- verification gaps named in the report

## Anti-patterns

- "Static scan = certified" — say what the scan covers
- Reporting an unverified suspicion as a finding
- Fixing everything in one giant diff
- Severity assigned by fear, not exploitability
