# Review Mode — dispatch prompt

Load the LoopFocus skill first, then enter review mode (announce it).

Review target: <PR / diff / code>
Requirements: <locked goal + invariants>

Discipline (flow/review-flow.md):
1. Read the diff in context (callers + callees, not the diff alone)
2. Run the covering tests — a review without the suite is a skim
3. Findings = hypothesis + evidence (file:line or run output)
4. SkillFocus sweep: all severities, reported not buried
5. Dual verdicts: spec (implements the requirement?) AND quality (correct/maintainable/secure/tested?)
6. Name what was NOT reviewed

Return: findings + both verdicts.
