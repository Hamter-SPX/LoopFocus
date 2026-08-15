# Review Flow

**Why:** reviewing is a loop task too — coverage, evidence, and no silent decisions apply to reading code as much as to writing it.

**When:** reviewing code, PRs, someone else's change, or re-reviewing your own work (the self-audit pass).

## Steps

1. **LOCK** — what is being reviewed against what: the requirements, the invariants, the style the codebase already uses.
2. **EXPLORE** — read the diff in context: what changed, what calls it, what it calls. Never review a diff without its consumers.
3. **HYPOTHESIZE** — findings are hypotheses with evidence: "this fails when X because (line, path)". An impression without a path is not a finding.
4. **SkillFocus sweep** — all severities: correctness, security, maintainability, inconsistency with neighboring code, dead code, risky structure. Low-severity findings are reported, not buried.
5. **Contradiction watch** — does the change violate a locked requirement or the codebase's own conventions? Block, don't shrug.
6. **Verdict with evidence** — spec verdict (implements the requirement?) and quality verdict (correct, maintainable, secure, tested?). Both required — never just one.
7. **Report** — findings ordered by severity, each with evidence; praise where deserved (the engineer's eye sees what's right too); what was NOT reviewed (gaps).

## Evidence gates

- every finding has a code path, not a vibe
- both verdicts present
- scope of the review stated (what was and was not read)

## Anti-patterns

- Approving because the diff is small
- Flagging preferences as defects
- Reviewing the diff without running the tests that cover it
- One-line "LGTM" — a review with no findings and no evidence walked is a skim, not a review
