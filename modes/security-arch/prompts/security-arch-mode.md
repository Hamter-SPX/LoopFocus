# M3 SecurityArch Mode — dispatch prompt

Load the LoopFocus skill first, then enter M3 SecurityArch Mode (announce it).

Task: <describe the audit target — repo, service, files, or feature>

Discipline required (references/security-arch.md, flow/security-audit-flow.md):
1. LOCK: audit scope + invariants + profile DEEP.
2. Run tool-discovery.sh + the project's real audit tool (npm audit / pip-audit / etc.).
3. Walk the 7-category checklist — every category recorded, even empty ones.
4. Every finding: file:line + reproduction or tool output. Exploitability verified.
5. Severity: Critical / High / Medium / Low / Info by exploitability.
6. Fix policy: propose severity-ordered fixes, ASK which to apply. Do not fix silently.
7. Record: ledger + state + genome (--class security-<area>).
8. Report: findings + evidence + severity + what was checked + verification gaps.

Return the completion report in the LoopFocus order (SKILL.md Completion Report Contract).
