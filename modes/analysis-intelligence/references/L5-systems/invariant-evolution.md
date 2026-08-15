# Invariant Evolution

## What
รู้ว่า invariant บางข้อใช้กับ architecture รุ่นเก่า แต่ไม่ควรบังคับกับรุ่นใหม่ — กฎก็มีอายุ

## Why
invariant เกิดจาก design หนึ่ง — เมื่อ design เปลี่ยน invariant เก่าบางข้อกลายเป็นโซ่ตรวน (บังคับสิ่งที่ไม่มีเหตุผลแล้ว) การรู้ว่า invariant ไหนยังมีผล ไหนหมดอายุ คือการไม่ถูกอดีตจับเป็นตัวประกัน

## When
หลังการเปลี่ยน architecture/design สำคัญ

## Protocol
1. ระบุ invariant ที่มีอยู่ + design ที่มันเกิดจาก
2. เทียบกับ design ใหม่: invariant นี้ยังจำเป็น/สมเหตุสมผลไหม
3. ยังจำเป็น → คงไว้; หมดเหตุผล → ปลด (บันทึกว่าปลดเพราะอะไร)
4. invariant ใหม่ที่ design ใหม่ต้องการ → เพิ่ม

## Evidence
- การคง/ปลด/เพิ่มถูกบันทึกพร้อมเหตุผล
- invariant ที่เหลือมี design รองรับ

## Anti-patterns
- ยึด invariant เก่าทั้งที่ design เปลี่ยนแล้ว
- ปลด invariant เพราะ "ไม่สะดวก" โดยไม่มีเหตุผลเชิง design
