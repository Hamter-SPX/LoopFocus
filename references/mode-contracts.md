# Mode Contracts (8 modes)

Every task runs in one mode. A mode is a contract: what this phase may do, what it must not do yet, which gates produce its evidence, and what must be true before it can close. Default behaviors (state machine, ledger, gates, SkillFocus) apply in every mode. Announce every mode crossing.

## analysis-intelligence — Analysis Intelligence (safe unasked)

- Trigger: explain, what/why/how questions, "understand", อธิบาย
- May: read, explain, draw structure explanations
- Must not: edit, install, change state
- Gates: entry, context
- Closes when: the explanation is delivered with file:line evidence
- Flow: none (read-only)

## zero-debug-state — Zero Debug State

- Trigger: bug, fix, broken, failing, error, crash, แก้, พัง
- May: everything inside the bug-fix flow
- Must not: fix symptoms without root-cause evidence; retry a failed approach
- Gates: entry, context, mutation, build, test, regression, progress, repeat, completion
- Closes when: root cause fixed, regression-free, verify PASS
- Flow: bug-fix-flow

## build (M4)

- Trigger: build, feature, add, implement, create, ทำฟีเจอร์, เพิ่ม
- May: everything inside the feature-build flow
- Must not: code before canvas + predictive + DoD graph; expand scope unapproved
- Gates: entry, context, plan, mutation, change-radius, build, static, test, regression, artifact, completion
- Closes when: DoD chain complete, gates pass, verify PASS
- Flow: feature-build-flow

## security-arch (M3, SecurityArch)

- Trigger: security, audit, scan, vulnerab, cve, secure, pentest, ช่องโหว่
- May: inspect everything, run every audit tool, write findings, build threat models, adversarial passes
- Must not: apply fixes without user selection (Fix Policy); unverified findings; declare "secure"
- Gates: entry, context, assumption, artifact, coverage, mutation, sast, completion
- Closes when: 7 categories walked + Layer-2 scans (sast/fuzz/audit) + threat model + evidence per finding + user asked
- Flow: security-audit-flow
- Profile: DEEP always — SecurityArch does not run light

## review

- Trigger: review, pr, pull request, check my code, code review, รีวิว
- May: read, run tests, produce dual-verdict findings
- Must not: fix findings without being asked; approve without evidence
- Gates: entry, context, artifact
- Closes when: spec + quality verdicts delivered with evidenced findings
- Flow: review-flow

## recover — (safe unasked)

- Trigger: resume, continue, recover, ต่อจาก, ต่อ, pick up, restore
- May: read the recovery capsule, cross-check, resume at NEXT
- Must not: redo PROVEN work; start from the prompt alone
- Gates: entry, recovery, evidence-freshness
- Closes when: resumed at the recorded NEXT with a resume ledger entry
- Flow: recovery-flow

## ship

- Trigger: ready, merge, finish, deploy, release, ส่งมอบ, ปิดงาน
- May: run full gates, package the completion report
- Must not: merge/push/discard on the user's behalf; claim done with blockers
- Gates: completion, ci, artifact
- Closes when: integration options presented, user chose, no silent decisions
- Flow: completion contract

## author-skill

- Trigger: author skill, create skill, write skill, edit skill, สกิล
- May: run TDD RED/GREEN/REFACTOR on skill content
- Must not: write skill content before baseline pressure tests (Iron Law)
- Gates: entry, artifact, completion
- Closes when: baseline documented, skill written, GREEN passed, loopholes closed
- Flow: writing-skills discipline
