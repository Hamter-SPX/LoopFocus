# Boundary Discovery

## What
หา natural boundaries ของระบบเอง — จุดที่ responsibility/state/trust เปลี่ยน — แทนที่จะเชื่อ module/file layout ปัจจุบัน

## Why
ขอบเขตที่แท้จริงของระบบมักไม่ตรงกับโฟลเดอร์: บางไฟล์ควรแยกแต่รวมอยู่, บางส่วนควรเป็นหน่วยเดียวแต่กระจัดกระจาย ขอบเขตจริงคือหน่วยของเหตุผลและการแก้

## When
ก่อน refactor, ก่อนวิเคราะห์ impact, ก่อนตัดสินว่าเปลี่ยนจุดนี้จะกระทบอะไร

## Protocol
1. ดูการไหลของ data/state/ownership — ขอบเขตจริงอยู่ตรงที่สิ่งเหล่านี้เปลี่ยนมือ
2. เทียบกับ layout ปัจจุบัน — จุดต่างคือ "โครงสร้างหลอก"
3. วาด boundary จริงลง canvas
4. ใช้ boundary จริงในการวิเคราะห์ impact ไม่ใช่ layout

## Evidence
- boundary จริงมีเหตุผล (ownership/data-flow)
- จุดต่างจาก layout ถูกบันทึก

## Anti-patterns
- เชื่อว่าไฟล์ = boundary
- ใช้ layout ปัจจุบันวิเคราะห์ impact ทั้งที่พบว่ามันหลอก
