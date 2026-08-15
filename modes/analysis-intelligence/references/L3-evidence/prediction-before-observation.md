# Prediction Before Observation

## What
ก่อน test/ทดลอง ต้องเขียนว่าแต่ละ hypothesis คาดว่าจะเห็นอะไร — ป้องกันการปรับเรื่องย้อนหลัง

## Why
พอเห็นผลแล้ว สมองปรับคำอธิบายให้เข้ากับผลทันที (postdiction) — แล้วทุกอย่าง "ตรงตามคาด" เสมอ การเขียน prediction ก่อนคือการล็อกคำอธิบายไว้ก่อนที่ผลจะมา

## When
ก่อนทุก experiment, test, observation ที่ตั้งใจทำ

## Protocol
1. เขียน prediction ของแต่ละ hypothesis ก่อนลงมือ
2. ระบุด้วยว่าผลแบบไหนจะหักล้าง hypothesis (ไม่ใช่แค่ยืนยัน)
3. ลงมือ → เทียบผลกับ prediction ที่เขียนไว้
4. prediction ที่พลาดคือข้อมูลสำคัญที่สุด (Surprise) — วิเคราะห์ ไม่ใช่แก้เรื่อง

## Evidence
- prediction ถูกบันทึกก่อนผล
- การเทียบหลังผลถูกบันทึก

## Anti-patterns
- ทำเสร็จแล้วค่อยเขียน "ตามที่คาดไว้"
- prediction ที่ vague จนผลอะไรก็เข้าได้
