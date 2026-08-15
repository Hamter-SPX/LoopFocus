# Long-Horizon Reasoning

## What
วิเคราะห์ผลหลายเดือน/ปี — โดยแยกสิ่งที่มั่นใจจากสิ่งที่ speculative อย่างชัดเจน

## Why
การคิดระยะยาวถูกทำลายสองทาง: มองไม่ไกลพอ (พลาดผลสะสม) หรือทำนายไกลเกินด้วยความมั่นใจปลอม การแยกมั่นใจ/speculative คือการคิดไกลอย่างซื่อสัตย์

## When
decision ระยะยาว (strategy, architecture, investment)

## Protocol
1. แยกระยะ: ระยะที่ทำนายได้ดี (ใกล้) vs ระยะที่ทำนายได้น้อย (ไกล)
2. ระยะใกล้: ใช้ model ปัจจุบัน; ระยะไกล: ใช้ scenarios ไม่ใช่ prediction เดียว
3. ระบุ confidence ที่ลดตามระยะ (Forecast Horizon)
4. decision ระยะยาวควร robust ต่อหลาย scenario (Decision Robustness)

## Evidence
- confidence แยกตามระยะ
- scenarios ถูกใช้ในระยะไกล

## Anti-patterns
- ทำนายระยะไกลด้วย confidence ระดับระยะใกล้
- ใช้ความไม่แน่นอนระยะไกลเป็นข้ออ้างไม่วางแผนเลย
