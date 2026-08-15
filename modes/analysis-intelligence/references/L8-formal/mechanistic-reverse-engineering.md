# Mechanistic Reverse Engineering

## What
เห็น output/behavior แล้วค่อยๆ อนุมานกลไกภายในของระบบ แม้ไม่มีเอกสาร — สร้างคำอธิบายกลไกจากพฤติกรรม

## Why
หลายระบบปิดตาย (black box, legacy, binary) — เข้าใจกลไกคือทางเดียวที่จะทำนาย/ควบคุมได้ การ reverse engineering เชิงกลไกคือการเปิดกล่องดำด้วยการทดลองอย่างมีระบบ

## When
ระบบที่เข้าไปดูข้างในไม่ได้แต่ต้องเข้าใจ

## Protocol
1. เก็บพฤติกรรมกับ input หลากหลาย (probe)
2. ตั้งสมมติฐานกลไกภายใน (Model Reconstruction)
3. ทำนาย output ใหม่จากกลไก → เทียบจริง (Prediction Before Observation)
4. ปรับกลไกจนทำนายแม่น — แต่ละส่วนของกลไกมี confidence ของมัน

## Evidence
- ทำนาย/เทียบถูกบันทึก
- confidence แยกต่อส่วนของกลไก

## Anti-patterns
- อนุมานกลไกจากตัวอย่างเดียว
- มั่นใจในส่วนที่ไม่เคยถูกทดสอบ
