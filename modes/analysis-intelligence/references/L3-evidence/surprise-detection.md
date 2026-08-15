# Surprise Detection

## What
ถ้าผลจริงต่างจาก model มาก — มองเป็นสัญญาณว่า world model อาจผิด ไม่ใช่ noise ที่ต้องเฉลี่ยทิ้ง

## Why
surprise คือข้อมูลบริสุทธิ์ที่สุด: มันคือจุดที่ความเชื่อกับความจริงไม่ตรงกัน การเก็บ surprise ไปปรับ model คือการเรียนรู้จริง ส่วนการมองข้ามมันคือการสะสมความเชื่อที่ผิด

## When
ทุกครั้งที่ผลต่างจาก prediction เกินช่วงที่คาด

## Protocol
1. วัดส่วนต่างระหว่างผลจริงกับ prediction
2. ส่วนต่างใหญ่ = surprise → บันทึก (อะไรคาด อะไรเจอ ต่างแค่ไหน)
3. ถาม: model ผิดตรงไหน? assumption ไหนพัง?
4. อัปเดต model (Surprise-Driven Reanalysis) — ไม่ใช่แค่จดว่า "เจอ outlier"

## Evidence
- surprise ถูกบันทึกพร้อมส่วนต่าง
- model ถูกอัปเดตตาม

## Anti-patterns
- เฉลี่ย surprise ทิ้งเป็น noise
- อธิบาย surprise ด้วยเหตุผลเฉพาะกิจโดยไม่แก้ model
