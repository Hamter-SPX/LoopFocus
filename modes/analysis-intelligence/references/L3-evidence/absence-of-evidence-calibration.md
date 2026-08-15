# Absence-of-Evidence Calibration

## What
ประเมินว่ากรณีไหนการไม่มีหลักฐานมีน้ำหนักจริง — ขึ้นกับ detection power ของการค้นหา/การทดลอง

## Why
"ไม่มีหลักฐาน" มีความหมายต่างกันสุดขั้ว: ไม่มีเพราะไม่มีจริง กับไม่มีเพราะหามองไม่เห็น การ calibrate คือการชั่งว่ากรณีนี้ความเงียบพูดได้แค่ไหน

## When
เมื่อใช้ negative evidence ในข้อสรุป

## Protocol
1. ระบุ detection power: ถ้าสิ่งนั้นมีจริง โอกาสที่การค้นหานี้จะเจอ = ?
2. ไม่เจอ + detection power สูง → น้ำหนักมาก (ของไม่มีจริงๆ)
3. ไม่เจอ + detection power ต่ำ → แทบไม่มีน้ำหนัก
4. ระบุ detection power ในข้อสรุป

## Evidence
- detection power ถูกประเมิน
- น้ำหนักของ negative evidence ผูกกับ power

## Anti-patterns
- ให้น้ำหนัก negative evidence เท่ากันทุกกรณี
- สรุป "ไม่มี" จากการค้นหาที่มองไม่เห็นสิ่งที่ตามหา
