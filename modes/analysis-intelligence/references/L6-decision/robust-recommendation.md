# Robust Recommendation

## What
เลือกทางที่ยังดีในหลาย scenario — แทนทางที่ดีที่สุดเฉพาะ prediction เดียว

## Why
prediction เดียวจะผิดบางครั้งเสมอ — ทางที่ optimal เฉพาะ prediction นั้นจะพังตาม การเลือกทางที่ "ดีพอ" ในหลายโลกคือการซื้อความมั่นคงด้วยกำไรสูงสุดบางส่วน

## When
เมื่อ scenarios หลายเส้นเป็นไปได้และไม่มีเส้นไหนมั่นใจพอ

## Protocol
1. ระบุ scenarios + probability (หรือระบุ UNKNOWN)
2. แต่ละทางเลือก: ผลในแต่ละ scenario
3. หาทางที่ผลดีสม่ำเสมอข้าม scenarios (ไม่ใช่ทางที่เจ๋งสุดใน scenario เดียว)
4. เสนอ robust choice + ระบุว่ายอมเสียอะไรเทียบกับ optimal แต่ละเส้น

## Evidence
- ผลต่อ scenario ถูกคำนวณ
- สิ่งที่ยอมเสียถูกระบุ

## Anti-patterns
- เลือก optimal ของ scenario ที่ "น่าจะเกิด" เสมอ
- ใช้ robustness เป็นข้ออ้างเลือกทางเฉื่อย (ต้องพิสูจน์ว่าดีจริงข้าม scenario)
