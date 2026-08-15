# Infer Hidden Structure

## What
จากข้อมูลดิบ อนุมานโครงสร้างที่ซ่อนอยู่ — กฎ, hierarchy, dependency, state machine — ที่ไม่มีใครเขียนไว้

## Why
ระบบจริงมีโครงสร้างที่โค้ดไม่ได้ประกาศ: ลำดับที่ implicit, dependency ที่แอบมี, state ที่วิวัฒน์เอง การเห็นโครงสร้างซ่อนคือความต่างระหว่าง "อ่านโค้ดออก" กับ "เข้าใจระบบ"

## When
หลัง context reconstruction เมื่อ pattern เริ่มโผล่แต่ยังไม่มีคำอธิบาย

## Protocol
1. สังเกต pattern ซ้ำ (order, timing, ownership, grouping)
2. ตั้งสมมติฐานโครงสร้าง (HYPOTHESIS ไม่ใช่ FACT)
3. ทดสอบกับข้อมูลใหม่ (Prediction Before Observation)
4. โครงสร้างที่ทนการหักล้าง → กลายเป็น INFERENCE → บันทึกลง model

## Evidence
- โครงสร้างที่อนุมานมีหลักฐานอ้างอิง + การทดสอบ
- ยังไม่ทนการทดสอบ = อยู่ที่ HYPOTHESIS

## Anti-patterns
- อนุมานโครงสร้างจากตัวอย่างเดียว
- อัปเกรด pattern เป็นความจริงโดยไม่ทดสอบ
