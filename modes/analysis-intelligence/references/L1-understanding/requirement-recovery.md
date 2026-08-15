# Requirement Recovery

## What
ระบบเก่าที่ spec หาย — reconstruct requirement จาก code, tests, docs และพฤติกรรม

## Why
จะแก้/ย้าย/เขียนระบบเก่าใหม่โดยไม่รู้ requirement = ทำลายพฤติกรรมที่ผู้ใช้พึ่งพาโดยไม่รู้ตัว

## When
ก่อน refactor/migrate ระบบที่ไม่มี spec

## Protocol
1. สกัด requirement จาก 4 แหล่ง: tests (สิ่งที่ถูกตรวจ), code paths (สิ่งที่ถูกสร้าง), docs (สิ่งที่เคยสัญญา), behavior (สิ่งที่เกิดขึ้นจริง)
2. requirement ที่ขัดกันระหว่างแหล่ง → Contradiction case
3. เรียบเรียงเป็นรายการพร้อมแหล่งอ้างอิง
4. requirement ที่สำคัญ → กลายเป็น invariant กัน regression

## Evidence
- แต่ละ requirement มีแหล่งอ้างอิง
- ความขัดแย้งถูกระบุไม่ถูกเลือกข้างมั่ว

## Anti-patterns
- Reconstruct จาก code อย่างเดียว (code แสดงสิ่งที่ทำ ไม่ใช่สิ่งที่ควรทำ)
- เก็บ requirement ที่ขัดกันไว้ทั้งคู่โดยไม่ตัดสิน
