# Strategic Adversarial Reasoning

## What
ถ้ามีคู่แข่งหรือ actor อื่นปรับตัวตาม decision ของเรา — ต้องคิด response ของเขาด้วย ไม่ใช่คิดแค่ตาเรา

## Why
ในเกมที่มีคู่แข่ง การตัดสินใจไม่ใช่โจทย์คำนวณเดี่ยว — คู่แข่งจะตอบโต้ และการตอบโต้นั้นเปลี่ยนผลของ decision เรา การคิด response ของอีกฝ่ายคือการเห็นเกมจริง ไม่ใช่ครึ่งเกม

## When
decision ที่มีผลต่อตลาด/คู่แข่ง/ฝ่ายตรงข้าม

## Protocol
1. ระบุ actors ที่จะตอบสนองต่อ decision เรา
2. แต่ละ actor: เขาได้/เสียอะไร → เขาจะตอบแบบไหน (Incentive ของฝั่งเขา)
3. คิด response ของเราต่อ response ของเขา (Recursive Strategy)
4. เลือกทางที่ยังดีหลัง response chain (ไม่ใช่ดีเฉพาะก่อนเขาตอบ)

## Evidence
- actors และ incentive ของเขา ถูกระบุ
- response chain ถูกเขียน

## Anti-patterns
- คิดว่าโลกหยุดนิ่งหลังเราตัดสินใจ
- มองคู่แข่งว่าโง่/ไม่ตอบสนอง (steelman ฝั่งเขาด้วย)
