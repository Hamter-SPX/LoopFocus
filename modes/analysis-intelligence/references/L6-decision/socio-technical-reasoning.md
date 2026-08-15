# Socio-Technical Reasoning

## What
วิเคราะห์คน + software + hardware + process เป็นระบบเดียว — ไม่มีส่วนไหนแยกขาดจากกัน

## Why
ทุก "ระบบ" จริงๆ คือระบบสังคม-เทคนิค: โค้ดถูกเขียนโดยคนที่มี incentive, ทำงานใน process ที่มีแรงกด การแยกวิเคราะห์ส่วนใดส่วนหนึ่งคือการมองชิ้นส่วนแทนระบบ

## When
วิเคราะห์ปัญหาใหญ่ที่เทคโนโลยีกับคนพันกัน

## Protocol
1. วาดระบบรวม: technical components + human actors + process + incentive
2. วิเคราะห์ interaction ข้ามส่วน (คน→โค้ด, process→คน, โค้ด→คน)
3. หา feedback loop ข้ามส่วน (technical พัง → คน workaround → workaround กลายเป็น technical debt → ...)
4. ระบุจุดแทรกแซงที่ได้ผลจริง (อาจเป็น incentive ไม่ใช่โค้ด)

## Evidence
- ระบบรวมถูกวาด
- loop ข้ามส่วนถูกระบุ

## Anti-patterns
- แก้ technical โดยไม่ดู social (หรือกลับกัน)
- วิเคราะห์คนกับระบบเป็นสองเรื่องแยก
