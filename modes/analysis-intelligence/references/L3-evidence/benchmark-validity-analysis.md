# Benchmark Validity Analysis

## What
ไม่เชื่อคะแนน benchmark ตรงๆ แต่ถามว่า benchmark วัดสิ่งที่เราสนใจจริงหรือไม่

## Why
benchmark เป็น proxy ของเป้าหมาย — และ proxy มักเบี้ยว: วัด latency เฉลี่ยแต่จริงๆ สนใจ p99, วัด throughput แต่จริงๆ สนใจ cost การถาม validity คือการไม่ optimize ผิดเป้า

## When
ใช้ผล benchmark ใดๆ ในการตัดสินใจ

## Protocol
1. ระบุสิ่งที่อยากรู้จริง (objective)
2. ถาม: benchmark นี้วัด objective จริงไหม? ห่างแค่ไหน?
3. หา gap: สิ่งที่ benchmark ไม่ครอบคลุม (edge cases, real workload, real failure)
4. ข้อสรุประบุว่า benchmark พูดแทนอะไรได้ — ไม่ใช่พูดแทนทุกอย่าง

## Evidence
- objective ถูกระบุแยกจาก metric
- gap ถูกบันทึก

## Anti-patterns
- ใช้คะแนน benchmark แทน objective โดยตรง
- เชื่อ benchmark ที่ชนะใจโดยไม่ถามว่าวัดอะไร
