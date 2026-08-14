# LoopFocus Phase 2 Implementation Plan — Gate Engine

**Goal:** สร้าง Gate Engine — 26 gates (documented ใน SKILL.md) + gate-runner.sh สำหรับ gate ที่ตรวจด้วยเครื่องได้ + Gate Profiles (LIGHT/NORMAL/DEEP) + Gate DAG + output JSON schema

**Tech Stack:** Markdown, Bash (POSIX), TDD

## Tasks

1. **T2.1 — gate-runner.sh tests ก่อน (RED)**: เขียน test-gate.sh ทดสอบ gate ที่ตรวจด้วยเครื่องได้ 8 ตัว + profile switching + JSON output
2. **T2.2 — gate-runner.sh (GREEN)**: implement 8 machine-checkable gates + profiles + regression metric store (`.loopfocus/metrics`)
3. **T2.3 — SKILL.md Gate Engine section**: document ครบ 26 gates + profiles + DAG + JSON schema (agent-discipline part)
4. **T2.4 — GREEN scenario**: รัน pressure scenario พิสูจน์ agent ทำตาม gate discipline (เช่น Repeat Gate กัน retry)
5. **T2.5 — Install + commit**

## Machine-checkable gates (8 จาก 26)

| Gate | ตรวจอะไร | ข้อมูลจาก |
|---|---|---|
| entry | state.md มี goal หรือไม่ | .loopfocus/state.md |
| build | build command exit 0 | .loopfocus/gates.conf |
| static | lint/typecheck exit 0 | .loopfocus/gates.conf |
| test | test command exit 0 | .loopfocus/gates.conf |
| regression | test count ไม่ลดจาก metrics เดิม | .loopfocus/metrics |
| evidence-freshness | state/ledger mtime ใหม่กว่าโค้ดที่แก้ล่าสุด | mtime |
| artifact | มีไฟล์ evidence (test report) | .loopfocus/gates.conf |
| completion | UNKNOWN: none + NEXT: none/done + ledger actual | state/ledger |

Gate ที่เหลือ (context, assumption, plan, mutation, change-radius, dependency, runtime, browser, performance, progress, repeat, stuck, oscillation, checkpoint, recovery, ci, ci-reliability, scope) = agent-judgment gates อยู่ใน SKILL.md

## Gate Profiles

- LIGHT: entry, build(ถ้ามี), test(ถ้ามี), completion
- NORMAL: LIGHT + static, regression, evidence-freshness, checkpoint(state มี rollback point)
- DEEP: NORMAL + artifact
- Profile เลือกจาก `.loopfocus/profile` (default NORMAL)

## Output Schema (ทุก gate)

```json
{"gate":"<name>","status":"PASS|FAIL","attempt":<n>,"reason":"...","blocking":true|false,"evidence":["..."],"next_action":"..."}
```

gate-runner.sh รันทุก gate ของ profile แล้วรวม: exit 0 = ผ่านทั้งหมด, exit 1 = มี blocking FAIL พร้อม JSON ทั้งหมด
