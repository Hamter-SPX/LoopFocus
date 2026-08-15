# Model Reconstruction

## What
จาก logs/behavior/output เท่านั้น ย้อนสร้างภาพระบบภายในคร่าวๆ — โครงสร้าง, state, flows — เมื่อไม่มีโค้ดหรือเอกสาร

## Why
หลายระบบ (legacy, third-party, black box) ไม่มีเอกสารให้อ่าน การ reconstruct จากพฤติกรรมคือทางเดียวที่จะเข้าใจก่อนแก้

## When
ระบบที่เข้าโค้ดไม่ได้: third-party, legacy ที่ spec หาย, runtime ที่ black box

## Protocol
1. เก็บพฤติกรรมหลากหลาย input (probe อย่างมีระบบ)
2. ตั้งสมมติฐานโครงสร้างภายใน (Infer Hidden Structure)
3. ทำนายผล input ใหม่จาก model → เทียบกับจริง (Prediction Before Observation)
4. ปรับ model จนทำนายได้คงที่ → บันทึก confidence ของแต่ละส่วน

## Evidence
- ทำนาย-เทียบผลถูกบันทึก
- ส่วนที่ทำนายไม่เคยถูกระบุเป็น UNKNOWN

## Anti-patterns
- Reconstruct จากตัวอย่างเดียว
- มั่นใจในส่วนที่ไม่เคยทดสอบ
