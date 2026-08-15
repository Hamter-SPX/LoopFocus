# Causal Intervention Design

## What
ออกแบบ intervention ที่แยก causal hypotheses ได้ดีที่สุด — การทดลองที่ผลของมันตัดสินได้ว่า A→B จริงหรือไม่

## Why
observation อย่างเดียวแยกสาเหตุไม่ได้เสมอ (confounder) intervention คือมีดผ่าตัด: เปลี่ยน A โดยไม่แตะอย่างอื่น แล้วดู B

## When
เมื่อต้องยืนยันสาเหตุก่อนการแก้จริง หรือเมื่อหลายสมมติฐานแยกกันไม่ออก

## Protocol
1. ระบุ hypotheses ที่แย่งกันอธิบาย
2. ออกแบบ intervention ที่เปลี่ยนตัวแปรเดียว (หรือน้อยสุด) ต่อ hypothesis
3. ทำนายผลของแต่ละ hypothesis ก่อนทำ (Prediction Before Observation)
4. ทำ intervention (ใน twin/sandbox ก่อนถ้าทำได้) แล้วเทียบ prediction

## Evidence
- prediction ก่อนทำถูกบันทึก
- intervention เปลี่ยนตัวแปรน้อยที่สุด

## Anti-patterns
- เปลี่ยนหลายตัวแปรพร้อมกัน (สรุปไม่ได้ว่าใครทำให้เกิด)
- ทำ intervention โดยไม่ทำนายก่อน
