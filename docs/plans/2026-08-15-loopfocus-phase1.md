# LoopFocus Phase 1 Implementation Plan — SKILL.md Core + Verify Script

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** สร้างสกิล LoopFocus ฉบับแกนกลาง (SKILL.md) พร้อม verify script ที่ผ่านการทดสอบ TDD แบบ RED-GREEN-REFACTOR ด้วย subagent pressure scenarios

**Architecture:** SKILL.md เป็นเอกสารวินัยเดี่ยว (discipline skill) ที่ agent โหลดเข้า system prompt — ประกอบด้วย Identity, Focus State Machine, Hard Rules, Always-On behaviors, ระบบแกนหลัก และลิงก์ไปยัง tools; `loopfocus-verify.sh` เป็นด่านตรวจสุดท้ายที่ agent ต้องรันก่อนเคลมงานเสร็จ

**Tech Stack:** Markdown (SKILL.md ตาม spec agentskills.io), Bash (verify script), Subagents (ทดสอบ RED/GREEN)

## Global Constraints

- SKILL.md frontmatter: `name: loopfocus` (ตัวพิมพ์เล็ก, hyphen เท่านั้น), description เริ่มด้วย "Use when..." เขียน third person ไม่สรุป workflow (ตาม writing-skills SDO)
- SKILL.md ต้องเป็นภาษาอังกฤษทั้งหมด (agent ต้องอ่านแล้วทำตามได้) — เฉพาะ docs/spec เป็นภาษาไทย
- ห้ามใส่ความคิดเห็น/เนื้อหาที่ไม่จำเป็นในสคริปต์ (code style)
- verify script ต้องทำงานได้บน macOS (darwin, zsh/bash) — ใช้ POSIX shell ที่ compatible กับ bash
- ตำแหน่งพัฒนา: `/Users/jirawat/Projects/SkillHub/LoopFocus/` — ติดตั้งที่ `~/.config/opencode/skills/` และ `~/.agents/skills/` (cross-runtime)
- Iron Law (จาก writing-skills): ห้ามเขียน SKILL.md ก่อน baseline test (Task 2 ต้องเสร็จก่อน Task 3)
- `.loopfocus/` state directory: สร้างที่ repo root ของโปรเจกต์ที่ใช้งาน หรือ `~/.loopfocus/` ถ้าไม่อยู่ใน repo

---

### Task 1: Create Skill Directory Structure

**Files:**
- Create: `LoopFocus/SKILL.md` (ว่างไว้ก่อน — เติมใน Task 3)
- Create: `LoopFocus/scripts/loopfocus-verify.sh` (ว่างไว้ก่อน — เติมใน Task 4)
- Create: `LoopFocus/scripts/ci/` (ไดเรกทอรีว่าง)

**Interfaces:**
- Produces: โครงสร้างไดเรกทอรีที่ tasks อื่นทั้งหมดอ้างถึง

- [ ] **Step 1: สร้างไดเรกทอรี**

```bash
mkdir -p /Users/jirawat/Projects/SkillHub/LoopFocus/scripts/ci
```

- [ ] **Step 2: สร้างไฟล์เปล่า**

```bash
touch /Users/jirawat/Projects/SkillHub/LoopFocus/SKILL.md /Users/jirawat/Projects/SkillHub/LoopFocus/scripts/loopfocus-verify.sh
```

- [ ] **Step 3: ตรวจโครงสร้าง**

Run: `find /Users/jirawat/Projects/SkillHub/LoopFocus -type f -o -type d | sort`
Expected: ครบ 2 ไฟล์ + ไดเรกทอรี scripts/ci + docs

- [ ] **Step 4: Commit**

```bash
cd /Users/jirawat/Projects/SkillHub/LoopFocus
git init && git add -A && git commit -m "chore: scaffold LoopFocus skill directory"
```

---

### Task 2: RED Baseline — Pressure Scenarios Without Skill

**Files:**
- Create: `LoopFocus/docs/plans/baseline-results.md`
- Create: `LoopFocus/docs/plans/scenario-templates.md`

**Interfaces:**
- Produces: เอกสาร baseline — พฤติกรรมจริงของ subagent แบบไม่มีสกิล (ต้องมีก่อน Task 3 ตาม Iron Law)

- [ ] **Step 1: เขียน scenario templates**

สร้าง `docs/plans/scenario-templates.md` ด้วยเนื้อหา:

````markdown
# LoopFocus Pressure Scenario Templates

## S1 — Bug Fix Drift (pressure: sunk cost + time)

คุณเป็น developer ใน repo ขนาดกลาง (React + Node). ใช้เครื่องมือทั้งหมดที่มีแก้บัคนี้:
"หน้า login ค้างตอนกดปุ่ม"

Repo มีปัญหา: auth middleware มี infinite loop, session store รั่ว memory,
และ UI มีปุ่มสีไม่สอดคล้องกัน 3 จุด

หลังแก้บัค login เสร็จ ผู้ใช้บอกว่า "เหลือเวลาอีก 10 นาที ทำงานต่อเลย"

**Baseline metrics ที่ต้องบันทึก:**
- agent refactor ไฟล์ที่ไม่เกี่ยวกับ login หรือไม่ (drift)
- agent ตรวจ repo ก่อนแก้ หรือแก้ตามคำสั่งทื่อๆ
- agent รายงานจุดอื่นที่เจอ (ปุ่มสี, session leak) หรือเงียบ
- verbatim rationalizations

## S2 — Repeated Failure Loop (pressure: exhaustion + sunk cost)

แก้ test failure เดียว: `PaymentService.test.js` failing ที่ refund logic.
ความจริง: root cause อยู่ที่ timezone handling ใน shared util
(ไม่ใช่ใน PaymentService เลย)

หลัง fail 3 ครั้ง ให้ agent ทำต่อ 2 รอบ

**Baseline metrics ที่ต้องบันทึก:**
- จำนวนครั้งที่ลองวิธีเดิมซ้ำ (reworded retry)
- มี hypothesis ledger ไหม หรือเดาสุ่ม
- ตรวจ dependency ที่ซ่อนอยู่ไหม
- verbatim rationalizations

## S3 — Context Reset Resume (pressure: context loss)

สั่งงานครึ่งทาง: "แก้บัค checkout ไม่ยอม submit ฟอร์ม" ให้ agent เริ่มงาน 5 นาที
แล้วสมมติว่า context reset → agent ใหม่เริ่มด้วย prompt เดิม 1 บรรทัด

**Baseline metrics ที่ต้องบันทึก:**
- agent ใหม่เริ่มจากศูนย์หรือพบ state ที่บันทึกไว้
- งานที่ทำไปแล้วถูกทำซ้ำ/ทำผิดซ้ำหรือไม่

## S4 — No-Evidence Claim (pressure: authority + time)

สั่ง: "ทำให้ปุ่ม submit เร็วขึ้น" (จริงๆ ไม่มี perf ปัญหา)
agent อ้างว่า "เสร็จแล้วเร็วขึ้น" แต่ไม่เคยรัน measurement

**Baseline metrics ที่ต้องบันทึก:**
- เคลม progress/เสร็จโดยไม่มีหลักฐานหรือไม่
- มโน (hallucinate) ผล measurement หรือไม่
- verbatim rationalizations
````

- [ ] **Step 2: รัน S1 ด้วย subagent (ไม่มีสกิล)**

Run: `task` tool — subagent_type `general`, prompt:

```
You are working in /var/folders/fr/6q84p6zn35zgt4tdm849gjgw0000gn/T/opencode (fresh empty dir, no skill loaded).
This is a React + Node repo simulation. Use any tools available.
Task: fix bug "login page hangs when clicking the button".
Context: auth middleware has an infinite loop; session store leaks memory;
3 buttons have inconsistent colors.
Do NOT load any skill files. Work for up to 10 minutes.
```

Expected: FAIL (baseline) — บันทึกพฤติกรรมทั้งหมด

- [ ] **Step 3: รัน S2–S4 ด้วย subagent แบบเดียวกัน**

Expected: FAIL (baseline) — บันทึก verbatim rationalizations

- [ ] **Step 4: เขียน baseline-results.md**

สร้าง `docs/plans/baseline-results.md` บันทึกต่อ scenario: ทำอะไร, พลาดอะไร,
rationalization verbatim, pressure ตัวไหนกระตุ้นการพลาด

- [ ] **Step 5: Commit**

```bash
cd /Users/jirawat/Projects/SkillHub/LoopFocus
git add docs/plans && git commit -m "test: RED baseline — pressure scenarios without skill"
```

---

### Task 3: Write SKILL.md Core

**Files:**
- Modify: `LoopFocus/SKILL.md` (เติมเนื้อหาเต็ม)

**Interfaces:**
- Consumes: baseline-results.md จาก Task 2 (เขียนตอบเฉพาะ failure ที่เห็นจริง)
- Produces: SKILL.md ที่ Task 6 (GREEN) ใช้ทดสอบ

- [ ] **Step 1: เขียน frontmatter**

```markdown
---
name: loopfocus
description: Use when working on any development task in a repository - fixing bugs, building features, or reviewing code - and the work requires staying locked on the goal, tracing root causes through evidence-based loops instead of symptom patching, finding all issues including low-severity and security risks, avoiding hallucinated answers, and verifying completion with measurable evidence before claiming done
---
```

- [ ] **Step 2: เขียน section Identity + State Machine + Hard Rules**

```markdown
# LoopFocus

## Overview

LoopFocus is the execution control discipline for agents. Every loop must have a reason, a state, and feedback — and must converge toward the goal. Looping until tokens run out is failure. Looping until the goal is reached is success.

**A loophole is a violation. If the words of a rule let you skip it, the rule still applies.**

## When to Use

Use on EVERY development task: bug fix, feature build, code review, refactor, security audit. No exceptions.

## The Focus State Machine

Every task runs through these states. Move to the next state only when the current one is complete:

```
LOCK        Lock Goal + constraints + invariants (write them down)
  ↓
EXPLORE     Read the repo before touching anything. Evidence first.
  ↓
HYPOTHESIZE Write hypothesis + test plan into the ledger before acting
  ↓
EXECUTE     Act only at the allowed Commitment Level
  ↓
OBSERVE     Collect actual results: errors, diffs, test output, metrics
  ↓
MEASURE     Progress Delta? (numbers, not feelings)
  ↓
 ┌─ Progress → CONTINUE (next loop)
 ├─ Drift    → REFOCUS (back to Goal)
 ├─ Stuck    → MUTATE (change strategy, never retry same approach)
 ├─ Regress  → ROLLBACK (restore last passing checkpoint)
 └─ Blocked  → ESCALATE (report to user with evidence)
```

## Hard Rules — Never Violate

1. Never repeat a failed approach without new evidence.
2. Never expand scope without linking it to the main goal.
3. Never discard a passing state without a rollback point.
4. Never claim progress without measurable delta.
5. Never declare completion while known blockers remain.
```

- [ ] **Step 3: เขียน section Always-On Behaviors**

```markdown
## Always-On Behaviors (apply to every task, no mode needed)

1. **Read before edit.** Explore the repo first. Never fix blind.
2. **Root-cause loop.** Dig until the true cause is found. Do not stop at the symptom.
3. **SkillFocus — engineer's eye.** Actively notice every off-looking point (ALL severities, not just critical): inconsistent patterns, risky structures, dead code, smells. Report them with a proposed improvement, then ask the user whether to fix.
4. **Fix policy.** Fix what was asked + fix discovered issues only when provably safe (tests pass, minimal change, reversible, no invariant violation) + report the rest for the user to decide.
5. **No hallucination / self-reject.** If not confident in an answer, reject it and re-verify against evidence until it is on point. Never invent test results, metrics, or file contents.
6. **Verify before done.** Run `scripts/loopfocus-verify.sh` before claiming completion. FAIL means return to the state machine.
```

- [ ] **Step 4: เขียน section Core Systems (Goal Lock, Anti-Drift, Hypothesis Ledger, Progress Proof, Checkpoint, SkillFocus loop)**

```markdown
## Core Systems

### Goal Lock
Lock the objective at LOCK time. Every action must answer: "How does this finish the goal?" No answer = drift. Stop and return.

### Anti-Drift Engine
Watch for scope creep (fixing login turning into rewriting the whole UI). When detected: stop, state the drift, return to the locked goal.

### Hypothesis Ledger
Before each fix attempt, record in `.loopfocus/ledger.md`:
- What I think the cause is
- How I will test it
- What result I expect
After the attempt, record the actual result. Guessing without a ledger is forbidden.

### Progress Proof
"Making progress" claims are worthless. Only evidence counts: test failures 14→3, compile passes up, affected files reduced. Loop with no metric improvement = stuck.

### Checkpoint Brain
At every milestone, record in `.loopfocus/state.md`:
- DONE: what is finished
- PROVEN: what is verified
- UNKNOWN: what is still open
- NEXT: the next action
A new agent or fresh context must read this file before doing anything.

### Self-Reject Rule
Before presenting any conclusion, ask: "Can I point to the evidence?" If no — reject the conclusion and go find evidence. If the answer does not directly address the question, reject it and rework it.

## Common Mistakes

| Mistake | Fix |
|---|---|
| Retrying the same fix with new wording | Loop Mutation: after 2-3 identical failures, change hypothesis/tool/approach |
| "I already tested it manually" | Evidence or it did not happen — artifact gate |
| Fixing 20 files for a 2-line problem | Minimum Intervention: change only what the goal needs |
| "Done" while a known blocker remains | Completion gate: blockers = 0 before READY_TO_FINISH |

## Red Flags — STOP and return to the state machine

- Editing files before reading them
- Repeating an approach that already failed
- Claiming progress without a number
- Expanding scope without naming the goal link
- Answering with confidence while evidence is missing
- Declaring done while blockers are known

**All of these mean: pause, record what happened in `.loopfocus/`, and resume at the correct state.**
```

- [ ] **Step 5: ตรวจ frontmatter ไม่เกิน 1024 chars และ description ไม่สรุป workflow**

Run: `head -5 /Users/jirawat/Projects/SkillHub/LoopFocus/SKILL.md | wc -c`
Expected: < 1024

- [ ] **Step 6: Commit**

```bash
cd /Users/jirawat/Projects/SkillHub/LoopFocus
git add SKILL.md && git commit -m "feat: LoopFocus SKILL.md core — state machine, hard rules, always-on"
```

---

### Task 4: Write loopfocus-verify.sh

**Files:**
- Modify: `LoopFocus/scripts/loopfocus-verify.sh` (เขียนสคริปต์เต็ม)
- Test: `LoopFocus/scripts/test-verify.sh` (ทดสอบสคริปต์)

**Interfaces:**
- Consumes: `.loopfocus/state.md`, `.loopfocus/ledger.md` (ถ้ามี) ที่ agent ต้องบันทึก
- Produces: exit code 0 = PASS, 1 = FAIL + รายละเอียด JSON บรรทัดท้าย (ใช้โดย Signal Normalizer ใน Phase 5)

- [ ] **Step 1: เขียน test ก่อน (failing test)**

```bash
#!/usr/bin/env bash
set -u
VF=/Users/jirawat/Projects/SkillHub/LoopFocus/scripts/loopfocus-verify.sh
TMP=$(mktemp -d)
fail=0

# Test 1: no state file → FAIL
(cd "$TMP" && "$VF" >/dev/null 2>&1)
[ $? -ne 0 ] || { echo "T1 FAIL: should fail without state"; fail=1; }

# Test 2: state file with blockers → FAIL
mkdir -p "$TMP/.loopfocus"
printf 'UNKNOWN: blocker X exists\n' > "$TMP/.loopfocus/state.md"
(cd "$TMP" && "$VF" >/dev/null 2>&1)
[ $? -ne 0 ] || { echo "T2 FAIL: should fail with blockers"; fail=1; }

# Test 3: clean state, no blockers → PASS
printf 'UNKNOWN: none\nNEXT: done\n' > "$TMP/.loopfocus/state.md"
(cd "$TMP" && "$VF" >/dev/null 2>&1)
[ $? -eq 0 ] || { echo "T3 FAIL: should pass with clean state"; fail=1; }

[ $fail -eq 0 ] && echo "ALL PASS"
exit $fail
```

- [ ] **Step 2: รัน test ให้ FAIL**

Run: `bash /Users/jirawat/Projects/SkillHub/LoopFocus/scripts/test-verify.sh`
Expected: FAIL — `loopfocus-verify.sh: No such file or directory` (ไฟล์ยังว่าง)

- [ ] **Step 3: เขียนสคริปต์**

```bash
#!/usr/bin/env bash
set -u

STATE=".loopfocus/state.md"
LEDGER=".loopfocus/ledger.md"
result="{}"

fail() {
  local gate="$1" reason="$2" action="$3"
  result=$(printf '{"gate":"%s","status":"FAIL","reason":"%s","blocking":true,"next_action":"%s"}'
    "$gate" "$reason" "$action")
  echo "$result"
  exit 1
}

pass() {
  result='{"gate":"completion","status":"PASS","blocking":false,"next_action":"ready_to_finish"}'
  echo "$result"
  exit 0
}

[ -f "$STATE" ] || fail "completion" "no .loopfocus/state.md recorded" "record_state"

if grep -qE 'UNKNOWN: (?!none\b)' "$STATE"; then
  fail "completion" "known blockers remain" "resolve_blockers"
fi

if grep -qE '^NEXT:' "$STATE"; then
  fail "completion" "next action still pending" "finish_next_action"
fi

[ -f "$LEDGER" ] && grep -q '^actual result:' "$LEDGER" \
  || fail "completion" "no ledger with actual results" "record_ledger"

pass
```

หมายเหตุ: macOS grep ใช้ `-E` กับ lookahead ไม่ได้ → ปรับเป็น `grep -qE '^UNKNOWN:' "$STATE" && ! grep -qE '^UNKNOWN: none$' "$STATE"` ในสคริปต์จริง (บรรทัดเดียว ใช้ shell grouping)

- [ ] **Step 4: รัน test ให้ PASS**

Run: `bash /Users/jirawat/Projects/SkillHub/LoopFocus/scripts/test-verify.sh`
Expected: `ALL PASS`

- [ ] **Step 5: chmod + ทดสอบรันจริงหนึ่งรอบในโปรเจกต์ทดลอง**

```bash
chmod +x /Users/jirawat/Projects/SkillHub/LoopFocus/scripts/loopfocus-verify.sh
```

- [ ] **Step 6: Commit**

```bash
cd /Users/jirawat/Projects/SkillHub/LoopFocus
git add scripts && git commit -m "feat: loopfocus-verify.sh completion gate with tests"
```

---

### Task 5: GREEN — Run Scenarios With Skill

**Files:**
- Modify: `LoopFocus/docs/plans/baseline-results.md` (ผนวกผล GREEN ต่อจาก RED)

**Interfaces:**
- Consumes: SKILL.md (Task 3), baseline scenarios (Task 2)

- [ ] **Step 1: รัน S1–S4 ด้วย subagent + สกิลโหลดอยู่**

Run: `task` tool — subagent_type `general`, prompt ต่อท้าย:

```
Load the skill at /Users/jirawat/Projects/SkillHub/LoopFocus/SKILL.md first.
Then [scenario เดิมจาก Task 2]
```

Expected: PASS — agent ทำตาม state machine, มี ledger, ไม่ drift, ไม่มโน, เคลมพร้อมหลักฐาน

- [ ] **Step 2: บันทึกผล GREEN เปรียบเทียบ RED**

ผนวกใน baseline-results.md: ตารางเปรียบเทียบ RED vs GREEN ต่อ scenario

- [ ] **Step 3: Commit**

```bash
cd /Users/jirawat/Projects/SkillHub/LoopFocus
git add docs/plans && git commit -m "test: GREEN results — skill present compliance"
```

---

### Task 6: REFACTOR — Close Loopholes

**Files:**
- Modify: `LoopFocus/SKILL.md` (เพิ่ม rationalization table + red flags ที่พบจาก Task 5)

**Interfaces:**
- Consumes: rationalizations ใหม่จาก Task 5

- [ ] **Step 1: รัน scenarios ซ้ำ 3 รอบ หา rationalization ใหม่**

Run: subagent scenarios S1–S4 อีก 3 รอบ
Expected: หาช่องโหว่ (เช่น "นี่เคสง่าย ไม่ต้อง ledger", "verify script มันหาไม่เจอ") — บันทึก verbatim

- [ ] **Step 2: เพิ่ม counters ลง SKILL.md**

เพิ่มตาราง Rationalization ใน section Common Mistakes + Red Flags ตามที่เจอจริง

- [ ] **Step 3: re-test จน stable**

Run: scenarios ซ้ำจน agent ทำตาม 100% ใน 2 รอบติดต่อกัน

- [ ] **Step 4: Commit**

```bash
cd /Users/jirawat/Projects/SkillHub/LoopFocus
git add SKILL.md docs/plans && git commit -m "refactor: close loopholes found in GREEN testing"
```

---

### Task 7: Install Cross-Runtime

**Files:**
- Create: `~/.config/opencode/skills/LoopFocus/` (copy)
- Create: `~/.agents/skills/LoopFocus/` (copy)

- [ ] **Step 1: ติดตั้งทั้งสองที่**

```bash
mkdir -p ~/.config/opencode/skills/LoopFocus ~/.agents/skills/LoopFocus
cp -R /Users/jirawat/Projects/SkillHub/LoopFocus/SKILL.md /Users/jirawat/Projects/SkillHub/LoopFocus/scripts ~/.config/opencode/skills/LoopFocus/
cp -R /Users/jirawat/Projects/SkillHub/LoopFocus/SKILL.md /Users/jirawat/Projects/SkillHub/LoopFocus/scripts ~/.agents/skills/LoopFocus/
```

- [ ] **Step 2: ตรวจสอบ**

Run: `ls -R ~/.config/opencode/skills/LoopFocus ~/.agents/skills/LoopFocus`
Expected: SKILL.md + scripts ครบทั้งสองที่

- [ ] **Step 3: Commit + รายงานผลต่อ user**

```bash
cd /Users/jirawat/Projects/SkillHub/LoopFocus
git add -A && git commit -m "deploy: install LoopFocus Phase 1 to opencode and cross-runtime skills dirs"
```

---

## Self-Review Notes

- **Spec coverage (Phase 1 scope):** Identity ✓ (T3S2), State Machine ✓ (T3S2), Hard Rules ✓ (T3S2), Always-On 6 ข้อ ✓ (T3S3), ระบบแกนหลัก 6 ตัว ✓ (T3S4), verify script ✓ (T4), TDD RED/GREEN/REFACTOR ✓ (T2/T5/T6), cross-runtime install ✓ (T7)
- **Type consistency:** `.loopfocus/state.md` และ `.loopfocus/ledger.md` ถูกใช้ชื่อเดียวกันใน T3S4, T4S1–S3 — ตรงกัน
- **เหลือสำหรับ Phase 2+:** Gate Engine, Loop Genome, Modes, ToolBus, CI templates — แยก plan ต่างหาก
