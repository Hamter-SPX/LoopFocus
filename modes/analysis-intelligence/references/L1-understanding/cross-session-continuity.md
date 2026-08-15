# Cross-Session Continuity

## What
งานวิเคราะห์ใหญ่รักษา model ของปัญหาไว้ข้าม session — ปรับเมื่อระบบเปลี่ยน ไม่เริ่มจากศูนย์ทุกครั้ง

## Why
การวิเคราะห์เชิงลึกสะสมความเข้าใจ การเริ่มใหม่ทุก session เผาความเข้าใจนั้นทิ้ง — และเสีย loop แรกๆ ไปกับสิ่งที่เคยรู้แล้ว

## When
งานที่ยาว/ย้อนกลับมาทำซ้ำ (audit รอบสอง, ปัญหาที่กลับมา, migration หลายรอบ)

## Protocol
1. model + findings + open questions ถูกบันทึกเป็น artifact (world-model, ledger, conclusions)
2. เริ่ม session ใหม่ด้วยการโหลด model แล้วเทียบกับ reality (World-Model Reconciliation)
3. ส่วนที่ระบบเปลี่ยน → ปรับเฉพาะส่วนนั้น (Knowledge Drift Awareness)
4. ส่วนที่ยังเหมือน → ไม่วิเคราะห์ซ้ำ

## Evidence
- model เป็น artifact ที่โหลดได้
- การปรับข้าม session ถูกบันทึก

## Anti-patterns
- เริ่มจากศูนย์ทั้งที่ model เก่ามี
- เชื่อ model เก่าโดยไม่เทียบกับปัจจุบัน
