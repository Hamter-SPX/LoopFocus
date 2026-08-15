# Assumption Stress Testing

## What
เปลี่ยน assumption ทีละตัวแล้วดูว่า conclusion ยังเหมือนเดิมไหม — ทดสอบว่าข้อสรุปยืนบน assumption ไหน

## Why
ทุกข้อสรุปยืนบน assumption หลายตัว การพลิกทีละตัวคือการวัดว่า assumption ไหนเป็นเสาเข็ม (พลิกแล้ว conclusion พัง) และตัวไหนเป็นของตกแต่ง

## When
ก่อนรายงาน conclusion สำคัญ และเมื่อ assumption ใหม่ถูกเพิ่มเข้ามา

## Protocol
1. ระบุ assumption ที่ conclusion พึ่ง (Assumption Mining)
2. พลิกทีละตัว: ถ้ามันผิด conclusion เปลี่ยนไหม
3. assumption ที่พลิกแล้ว conclusion พัง = critical — ต้องตรวจ/ยืนยันก่อนสรุป
4. assumption ที่พลิกแล้วไม่กระทบ = สรุปได้แม้ยังไม่ยืนยัน (แต่ยังควรบันทึก)

## Evidence
- ผลการพลิกแต่ละ assumption ถูกบันทึก (sensitivity map)
- critical assumption ถูกตรวจก่อนสรุป

## Anti-patterns
- ไม่รู้ว่าข้อสรุปพึ่ง assumption อะไร
- สรุปบน assumption ที่ยังไม่ตรวจทั้งที่มันคือเสาเข็ม
