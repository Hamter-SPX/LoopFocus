# Independent Judge

## What
ตัวหา conclusion กับตัวตัดสิน conclusion แยกกัน — คน/กระบวนการที่สรุปไม่มีสิทธิ์ approve งานตัวเอง

## Why
ผู้วิเคราะห์รักข้อสรุปตัวเอง (sunk cost, anchoring) — การให้อีกกระบวนการตัดสินจาก evidence ล้วนๆ คือการตรวจที่ไม่มีอคติแบบนั้น นี่คือหลักการเดียวกับ code review

## When
ทุก conclusion สำคัญก่อนรายงาน/ส่ง Action Plan

## Protocol
1. ผู้วิเคราะห์ส่ง: conclusion + evidence + assumption (ไม่ส่งความเห็นประกอบ)
2. Judge อ่านเฉพาะ evidence — ถาม: หลักฐานรองรับข้อสรุปจริงไหม, assumption สมเหตุสมผลไหม, มีทางตีความอื่นไหม
3. Verdict: PASS / REJECT / NEED_MORE_EVIDENCE (พร้อมเหตุผล)
4. REJECT → กลับไปหาหลักฐานเพิ่มหรือปรับ conclusion; PASS → ส่งต่อได้

## Evidence
- Judge แยกจากผู้วิเคราะห์ (บันทึกว่าใคร/รอบไหน)
- Verdict มีเหตุผล

## Anti-patterns
- อนุมัติข้อสรุปตัวเอง
- Judge ที่ rubber stamp เพราะผู้วิเคราะห์ "เก่ง"
