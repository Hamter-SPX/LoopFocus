# Feature Build Flow

**Why:** features fail from unexamined intent, absent design, and scope creep — not from code.

**When:** "add X", "build Y", M4 territory.

## Steps

1. **LOCK** — Intent Anchor: restate the requirement in your own words; separate intent from wording. Invariants + profile (usually NORMAL).
2. **Canvas** — draw where the feature plugs in, edges labeled, invariants marked. Get approval on non-trivial structures.
3. **Predictive pass** — touch map + risk factors + confidence levels; top risks become required tests.
4. **DoD graph** — `.loopfocus/dod.md`: works → tests pass → no regression → verify → done, each node with its command.
5. **First slice** — thinnest end-to-end path; verify; commit.
6. **Write → verify loop** — each slice: ledger entry → code → fast-gate → normalize → state.md → commit.
7. **Scope firewall** — new ideas → SkillFocus report, not code, until approved.
8. **Finish** — full gate chain, verify script, genome record, completion report with verification gaps.

## Evidence gates

- canvas + predictive exist before the first edit
- DoD chain written at start, checked at end
- each slice has a measurable delta
- no unapproved scope in the diff (mutation gate)

## Anti-patterns

- Building the cool part first (violates DoD ordering)
- "Small improvements" smuggled into the diff
- DoD written at the end to justify the work done
- Skipping predictive because the feature is small
