# Out-of-Distribution Awareness

## What
เจอ input/สถานการณ์ที่ไม่เหมือนสิ่งที่เคยวิเคราะห์ — ต้องลด confidence เอง ไม่ใช่ทำนายด้วยความมั่นใจเดิม

## Why
model ทุกตัวรู้จักแค่สิ่งที่เคยเห็น — OOD คือดินแดนที่ model ไม่มีสิทธิ์มั่นใจ การรู้ตัวเมื่ออยู่นอก distribution คือการไม่ทำนายสุ่มด้วยความมั่นใจ

## When
เมื่อ input/เงื่อนไขต่างจากช่วงที่ model ถูกสร้าง/ทดสอบ

## Protocol
1. ตรวจว่า input อยู่ใน range ที่ model เคยเห็นไหม (distribution check)
2. นอก range → ลด confidence อย่างชัดเจน + ระบุว่านอกขอบเขต
3. ระบุว่าต้องเก็บข้อมูล/ทดสอบอะไรเพื่อขยายขอบเขต
4. ห้ามใช้ model นอกขอบเขตโดยไม่ flag

## Evidence
- การตรวจ in/out distribution ถูกทำ
- confidence ถูกลดเมื่อ OOD

## Anti-patterns
- ใช้ model กับทุก input ด้วย confidence เดิม
- ไม่รู้ว่า model ตัวเอง valid ตรงไหน
