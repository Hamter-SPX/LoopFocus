# Regime Change Detection

## What
จับได้ว่า "กฎเดิมของระบบใช้ไม่ได้แล้ว" — workload, environment หรือเงื่อนไขเปลี่ยนจนระบบเข้าสู่ regime ใหม่

## Why
ทุก model ถูกสร้างใน regime หนึ่ง — เมื่อ regime เปลี่ยน model เก่าก็กลายเป็นอันตราย (ทำนายผิดอย่างมั่นใจ) การจับ regime change ได้เร็วคือการรู้ว่าเมื่อไรต้องสร้าง model ใหม่

## When
เฝ้าดูระบบที่ทำงานต่อเนื่อง และเมื่อผลเริ่มเบี่ยงจาก model เดิมเป็นระบบ

## Protocol
1. เฝ้าเบี่ยง: prediction error สะสมเกินปกติ, anomaly ถี่ขึ้น, พฤติกรรมพื้นฐานเลื่อน
2. ทดสอบว่าคือ regime change หรือแค่ fluctuation (สถิติ)
3. ยืนยัน change → ประกาศ: model เก่าหมดอายุ (Temporal Validity)
4. สร้าง model ใหม่บน regime ใหม่ (ไม่ใช่แปะ exception กับของเก่า)

## Evidence
- การเบี่ยงถูกวัดเป็นตัวเลข
- การประกาศ change มีหลักฐานสถิติ

## Anti-patterns
- แปะ exception กับ model เก่าเมื่อโลกเปลี่ยนแล้ว
- ตกใจกับ fluctuation แล้วเปลี่ยน model มั่ว
