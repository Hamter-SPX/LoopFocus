# SkillFocus (Engineer's Eye)

## What

The always-on observant mindset: notice every point that looks off — ALL severities, not just critical — and for each: report it, propose an improvement, and let the user decide.

## Why

The user's definition: "คนช่างสังเกตเห็นจุดนึงดูไม่โอเค จะบอกกับตัวเองว่า จุดนี้ไม่สวย ควรปรับปรุงยังไง — เหมือนวิศวกรคุยกับสถาปนิก". Agents default to two failure modes: tunnel vision (only the asked bug exists) or critical-hunting (only the loud problems matter). SkillFocus fixes both: the eye stays open at every severity, and every observation becomes a proposal, not a silent edit.

## When

Always-on. Actively practiced during EXPLORE (the sweep is part of reading) and during any pass through code.

## What the eye looks for

| Class | Examples |
|---|---|
| correctness smells | untested branches, silent catches, unchecked nulls |
| risky structures | shared mutable state, order dependencies, long functions |
| inconsistency | one module's pattern contradicting its neighbors |
| dead weight | dead code, unreachable branches, obsolete flags |
| security smells | string-built SQL, loose equality, hardcoded secrets |
| craft | naming drift, misleading comments, broken symmetry |

Severity is recorded, not filtered — a low-severity observation is still an observation. The engineer's eye does not discard the small stuff; it files it where the small stuff belongs.

## Protocol

1. During EXPLORE and every pass: collect observations (file:line + what looks off + why).
2. Classify each (Scope Firewall): Required / Supporting / Optional / Unrelated.
3. Optional-and-below → the report: each finding with a proposed improvement ("proposal: extract the duplicated validator into shared util").
4. Ask: "found N points — want me to fix any?" (Fix Policy). The user decides; the proposals make the decision cheap.
5. Record the report in the ledger — it is part of the completion report (item 7) and the handoff package.

## Evidence gates

- observations carry file:line (an observation without a location is a vibe)
- every Optional+ finding reached the user (reported), none slipped into the diff silently

## Anti-patterns

- Reporting only criticals (the eye's value is the non-obvious small stuff)
- Silently fixing an observation "because it was obviously right" (obvious-to-you is a proposal, not permission)
- Turning every observation into a fix request and flooding the user (proposals are ranked; the top ones asked first)
