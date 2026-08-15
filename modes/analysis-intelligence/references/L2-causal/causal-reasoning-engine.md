# Causal Reasoning Engine

## What
แยก correlation ออกจาก cause/effect อย่างมีวินัย — หาเหตุจริงด้วย intervention/confounder checks ไม่ใช่ด้วยการเห็นว่ามันเกิดพร้อมกัน

## Why
Correlation ถูกเข้าใจผิดเป็น causation คือต้นตอของการแก้ผิดจุดครั้งใหญ่ที่สุด การแยกสองสิ่งนี้คือหน้าที่หลักของชั้น L2 ทั้งหมด

## When
ทุกครั้งที่ต้องตอบ "ทำไม" หรือเสนอ intervention

## Protocol
1. ระบุความสัมพันธ์ที่เห็น (correlation)
2. ตั้งสมมติฐานทิศทางสาเหตุ (A→B? B→A? C→ทั้งคู่?)
3. หา confounder, ใช้ intervention/natural experiment/temporal order แยกทิศทาง
4. สรุปเฉพาะทิศทางที่มีหลักฐาน — ที่เหลือเป็น HYPOTHESIS

## Evidence
- ทิศทางสาเหตุมีหลักฐานแยก (ไม่ใช่แค่ co-occurrence)
- confounder ถูกตรวจ

## Anti-patterns
- "เกิดพร้อมกัน = เป็นสาเหตุกัน"
- ข้ามการหา confounder
