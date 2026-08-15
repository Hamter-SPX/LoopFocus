# Compute Placement Intelligence

## What
งานนี้ควรอยู่ CPU/GPU/NPU/edge/cloud ตรงไหน — ตัดสินจาก latency, memory, cost และ workload จริง ไม่ใช่แฟชั่น

## Why
"ยัดเข้า GPU" ไม่ใช่คำตอบเสมอ: งานเล็กกว่า GPU overhead, งาน latency-sensitive ไม่ควรข้าม network การเลือก placement จาก workload จริงคือการได้ performance/cost ที่ถูกต้อง

## When
เลือกว่าจะรัน workload ที่ไหน (hardware, edge/cloud)

## Protocol
1. ระบุความต้องการของ workload (compute, memory, latency, data location, cost)
2. เทียบตัวเลือก placement (CPU/GPU/NPU/edge/cloud) ตามความต้องการ
3. รวม cost ของการย้ายข้อมูล (Data-Movement) เข้าในการเทียบ
4. เลือก + ระบุเงื่อนไขที่จะเปลี่ยนคำตอบ (scale, workload เปลี่ยน)

## Evidence
- ความต้องการถูกระบุ
- การเทียบรวม data movement

## Anti-patterns
- เลือก placement ตามแฟชั่น (ทุกอย่างต้อง GPU)
- ไม่รวม cost การย้ายข้อมูล
