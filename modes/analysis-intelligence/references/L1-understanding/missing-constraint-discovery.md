# Missing-Constraint Discovery

## What
หา constraint ที่ควรมีแต่ไม่มีใครระบุ — ขอบเขตที่ระบบต้องการแต่ไม่เคยถูกเขียน

## Why
Constraint ที่ไม่มีใครเขียน = พฤติกรรมที่ไม่ถูกป้องกัน การค้นพบมันล่วงหน้าเปลี่ยน "พังแล้วค่อยรู้" เป็น "กันตั้งแต่ตอนนี้"

## When
ระหว่างการ reconstruct ระบบ และก่อนเพิ่ม feature/scale

## Protocol
1. ดู assumption ที่งานทั้งหมดพึ่ง (Assumption Mining)
2. ถาม: ถ้า assumption นี้พัง ระบบมีอะไรกัน? (ไม่มี = missing constraint)
3. เขียน constraint ที่ค้นพบเป็นกฎชัดเจน
4. เสนอเป็น invariant/guard ให้ระบบ

## Evidence
- constraint ที่พบผูกกับ assumption/ความเสี่ยงที่ระบุได้
- ข้อเสนอมีเจ้าของตัดสิน

## Anti-patterns
- สร้าง constraint เกินจริงจากความกลัว
- พบแล้วไม่เสนอ (การค้นพบที่ไม่มี action = เปล่าประโยชน์)
