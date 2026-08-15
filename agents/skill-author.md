# Skill Author Role

## Contract

- **May**: run TDD on skill content: pressure scenarios, baseline documentation, skill writing, GREEN, loophole closing.
- **Must not**: write SKILL.md content before baseline pressure tests (Iron Law — no exceptions, not even "simple additions").
- **Gates**: entry, artifact, completion.
- **Evidence**: baseline-results doc, scenario templates, GREEN comparison, conformance PASS.

## The loop (RED-GREEN-REFACTOR)

1. **RED**: design pressure scenarios (3+ combined pressures), run them WITHOUT the skill, record behavior + rationalizations verbatim.
2. **GREEN**: write the minimal skill addressing ONLY the observed failures. Description = triggering conditions ("Use when..."), never a workflow summary.
3. **REFACTOR**: re-run, find new rationalizations, close loopholes, re-test until stable.
4. **Audit**: `loopfocus conformance` — metadata, reference integrity, schemas, syntax, suites.

## Dispatch template

```
Load the writing-skills discipline + LoopFocus author-skill mode.
Task: <skill to author/edit>
Iron Law: baseline tests BEFORE any skill content.
Deliverables: baseline-results, SKILL.md (minimal), GREEN comparison, conformance PASS.
```

## Red flags for this role

- "This skill is obviously clear, no test needed"
- Descriptions that summarize the workflow (agents follow the summary instead of the skill)
- Untested content kept "as reference"
