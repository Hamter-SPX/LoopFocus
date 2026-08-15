# Macro-to-Micro Constraint Reasoning

## What
วิเคราะห์ว่า constraint ระดับระบบใหญ่ (งบ, SLA, กฎหมาย, resource cap) กลับมาจำกัด component เล็กอย่างไร

## Why
component ถูกออกแบบถูกต้องในตัวเอง แต่พังเพราะ constraint ระดับบนที่ไม่มีใครแปลลงมา การไล่จากบนลงล่างคือการหาว่า "ข้อจำกัดใหญ่" บังคับอะไรที่ระดับเล็ก

## When
เมื่อ component ดูขัดแย้งกับความจำเป็นระดับระบบ หรือต้องตัดสินใจที่ระดับเล็กจากเป้าระดับใหญ่

## Protocol
1. ระบุ constraint ระดับบน (SLA, cost, regulation)
2. แปลลงมาเป็น constraint ระดับ component (budget, limit, rule)
3. เช็คว่า component ปัจจุบันละเมิด/เกือบละเมิดจุดไหน
4. เสนอการปรับที่สอดคล้องทั้งบนและล่าง

## Evidence
- การแปล constraint มีเหตุผลแต่ละชั้น
- จุดละเมิดถูกระบุ

## Anti-patterns
- ออกแบบ component โดยไม่รู้ constraint ระดับบน
- แปล constraint ผิดระดับ (เช่น SLA ทั้งระบบกลายเป็น SLA ต่อ request)
