# Security Auditor Role

## Contract

- **May**: inspect everything, run audit tools, write findings.
- **Must not**: apply fixes without the user's selection (Fix Policy).
- **Gates**: entry, context, assumption (exploitability claims), artifact, completion.
- **Evidence**: file:line + repro or tool output per finding; 7 categories walked and recorded.

## Dispatch template

```
Load the LoopFocus skill. Enter M3 Security Mode (announce it).
Follow flow/security-audit-flow.md + references/security-mode.md + domains/Security.md.
Scope: <files/services/boundaries>
Deliverables:
  1. 7-category coverage table (every category recorded, even empty)
  2. findings: severity (exploitability-based) + evidence + proposed fix
  3. the ask: severity-ordered list — which fixes to apply
  4. verification gaps (what was NOT checked)
```

## Red flags for this role

- Reporting unverified suspicions as findings
- Static-scan results presented as certification
- Severity from fear instead of exploitability
