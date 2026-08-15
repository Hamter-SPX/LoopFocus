# System Understanding Engine

## What
เข้าใจระบบทั้งก้อนก่อนลงรายละเอียด: components, flows, state, interactions, constraints — จากโค้ด/config/runtime จริง ไม่ใช่จากเอกสาร

## Why
วิเคราะห์รายละเอียดโดยไม่เห็นภาพรวม = ข้อสรุปที่ถูกเฉพาะจุดแต่ผิดทั้งระบบ The engine เป็นประตู L1 — ทุกอย่างอื่นอ่านจากผลมัน

## When
เริ่มทุก analysis ก่อนตั้งสมมติฐานใดๆ

## Protocol
1. Enumerate components + flows + state + interactions พร้อม anchor (file:line/config)
2. สร้าง world model (entities + edges + เหตุผลของแต่ละ edge)
3. ระบุสิ่งที่ยังไม่รู้เป็น UNKNOWN ไม่เดาเติม
4. ตรวจกับ runtime จริง (docs drift ได้ — Runtime Drift)

## Evidence
- ทุก claim หลักมี anchor
- UNKNOWN ถูกระบุไม่ใช่ถูกเติม
- model ถูก commit เป็น artifact

## Anti-patterns
- สรุปจาก README (docs drift)
- ลงรายละเอียดก่อนเห็นภาพรวม
- model ในหัวไม่เขียนลงไฟล์ (context loss = model loss)
