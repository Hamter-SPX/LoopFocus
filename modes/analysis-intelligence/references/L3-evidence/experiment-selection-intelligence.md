# Experiment Selection Intelligence

## What
เลือก experiment/test ที่แยกสมมติฐานออกจากกันได้ดีที่สุด — การทดลองที่ผลของมันตัดสินได้ว่าสมมติฐานไหนถูก

## Why
experiment หลายแบบให้ข้อมูลซ้ำหรือแยกไม่ออก การเลือกแบบที่ discriminating ที่สุดคือการได้คำตอบเร็วสุดด้วยการทดลองน้อยสุด

## When
เมื่อหลาย hypothesis แข่งกันและต้องทดลอง

## Protocol
1. ระบุ hypotheses + prediction ที่ต่างกัน
2. ออกแบบ/เลือก experiment ที่ผลแยก prediction ได้ชัดสุด (Causal Intervention Design)
3. ประเมิน power: ถ้า hypothesis ผิด experiment จะบอกได้จริงไหม (Negative Result Intelligence)
4. รัน experiment ที่ discriminating สูงสุดก่อน

## Evidence
- ความ discriminating ของแต่ละ experiment ถูกประเมิน
- prediction ถูกบันทึกก่อนรัน

## Anti-patterns
- รัน experiment ที่ทุก hypothesis ทำนายเหมือนกัน
- เลือก experiment ตามความง่ายไม่ใช่ตามอำนาจแยก
