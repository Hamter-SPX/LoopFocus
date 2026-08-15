# LoopFocus Playbooks

Shortest correct path per common request. Each playbook lists: mode, flow, minimal commands, and the trap that playbook exists to prevent.

## "Fix this bug" / "แก้บัคนี้"

Mode: **debug** · Flow: `flow/bug-fix-flow.md`

```bash
loopfocus mode resolve "fix the login hang"     # → zero-debug-state
loopfocus init && loopfocus discover             # state + tool map (first time only)
loopfocus genome query --class login-hang        # has this class been won before?
# LOCK: write goal + invariants into .loopfocus/state.md
# EXPLORE: read the failing path, reproduce first
# HYPOTHESIZE: ledger entry before the edit
# EXECUTE: ladder S1 → S2 → S3 → S4 → S5 → S6, never retry a rung
loopfocus fingerprint --class login-hang --approach caller-patch   # blocked = repeat
loopfocus fast && loopfocus converge --class login-hang
loopfocus verify                                  # only this says done
loopfocus genome record --class login-hang --strategy <s> --result success --delta 1 --reason "..."
```

Trap: reworded retries of the same fix. The ladder + genome ban make them structurally impossible.

## "Add a feature" / "ทำฟีเจอร์ใหม่"

Mode: **build (M4)** · Flow: `flow/feature-build-flow.md`

```bash
loopfocus mode resolve "add a reset-password feature"   # → build
loopfocus canvas --modules server db auth mailer --edges "server->db" "server->auth"
loopfocus predictive --target src/server.js             # who touches what will break?
# write .loopfocus/dod.md BEFORE the first edit
loopfocus dod                                          # walk the chain at the end
loopfocus verify
```

Trap: coding before design. Canvas + predictive + DoD graph exist to be done FIRST.

## "Security review" / "สแกนช่องโหว่"

Mode: **security (M3)** · Flow: `flow/security-audit-flow.md`

```bash
loopfocus mode resolve "security audit"   # → security
loopfocus discover                        # run the project's real audit tool too (npm audit etc.)
# walk ALL 7 categories, evidence per finding, severity by exploitability
# ASK the user which fixes to apply — never fix silently
loopfocus genome record --class security-injection --strategy checklist --result success --delta 1 --reason "..."
```

Trap: hollow audits (unverified suspicions, unchecked categories). Evidence or it is not a finding.

## "Review this code" / "รีวิวโค้ดนี้"

Mode: **review** · Flow: `flow/review-flow.md`

```bash
loopfocus mode resolve "review the PR"    # → review
loopfocus state                           # what actually changed
# findings = hypothesis + code path; dual verdicts (spec + quality); both required
```

Trap: one-line "LGTM" with no evidence walked.

## "Continue my work" / "ทำงานต่อจากเมื่อวาน"

Mode: **recover** · Flow: `flow/recovery-flow.md`

```bash
loopfocus mode resolve "continue the checkout fix"   # → recover
cat .loopfocus/state.md                              # READ FIRST — never start from the prompt
loopfocus state-check                                # is the recorded state valid?
loopfocus genome query --class checkout-submit       # what failed, what's banned
# cross-check state against reality, then resume at NEXT
```

Trap: redoing PROVEN work "to be sure". The capsule exists so you never have to.

## "Is this ready to ship?" / "พร้อมส่งหรือยัง"

Mode: **ship**

```bash
loopfocus dod && loopfocus gates && loopfocus verify
loopfocus self-audit --claims claims.txt    # adversarial pass on your own claims
# present integration options — merge/push/discard are the USER's decisions
```

Trap: claiming done while a known blocker remains. Hard Rule 5 exists for exactly this.

## "Write/improve a skill" / "เขียนสกิล"

Mode: **author-skill**

Iron Law: no skill content before baseline pressure tests (RED). Baseline first, skill second, GREEN third, loophole-closing last. The conformance gate audits the result: `loopfocus conformance`.
