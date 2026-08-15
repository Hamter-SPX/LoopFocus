# Model Fragility Analysis

## What
วิเคราะห์ไม่ใช่แค่ระบบเปราะหรือไม่ แต่ conclusion ของ AI เองเปราะต่อ assumption ไหน — หาจุดที่ความเข้าใจจะพัง

## Why
model ที่เราใช้วิเคราะห์ก็เป็นสิ่งก่อสร้าง — ยืนบน assumption เหมือนกัน การรู้ว่า model เปราะตรงไหนคือการรู้ว่าข้อสรุปไหนเชื่อถือได้แค่ไหนก่อนที่จะพังจริง

## When
ประเมินคุณภาพของ world model / causal model ที่สร้างขึ้น

## Protocol
1. ระบุ assumption ที่ model ยืน (Assumption Registry)
2. แต่ละตัว: ถ้าผิด model ส่วนไหนพัง และ conclusion ไหนตามพัง
3. assumption ที่มีผลกว้าง = จุดเปราะ — ตรวจก่อนหรือลดการพึ่งพา
4. ระบุ fragility ในข้อสรุป (Conclusion Sensitivity Map)

## Evidence
- จุดเปราะของ model ถูกระบุ
- ข้อสรุปที่เปราะถูกทำเครื่องหมาย

## Anti-patterns
- เชื่อ model ที่ไม่รู้ว่ายืนบนอะไร
- ใช้ model ที่เปราะกับ decision ที่แพง
