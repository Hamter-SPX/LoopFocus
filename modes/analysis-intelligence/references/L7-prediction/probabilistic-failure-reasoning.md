# Probabilistic Failure Reasoning

## What
ปัญหาที่ไม่ได้เกิด 100% — race, intermittent hardware fault, distributed timing — วิเคราะห์แบบ probability ไม่ใช่แบบ deterministic

## Why
failure แบบ intermittent หลอกทุกเครื่องมือ deterministic: รันซ้ำแล้วไม่เจอ, แก้แล้ว "เหมือนหาย" ทั้งที่ยังอยู่ การวิเคราะห์แบบ probability คือการยอมรับธรรมชาติของมันแล้วหาเงื่อนไขที่เพิ่มโอกาสเกิด

## When
failure ที่เกิดๆ หายๆ หรือพึ่ง timing

## Protocol
1. ระบุว่า failure นี้เป็น probabilistic (ไม่ reproduce ทุกครั้ง)
2. หาเงื่อนไขที่เพิ่มโอกาสเกิด (load, timing, order, environment)
3. วัด/ประเมินความถี่ตามเงื่อนไข (เกิดบ่อยแค่ไหนในเงื่อนไขไหน)
4. หา race/timing window ที่เป็นกลไก (Temporal Attack Reasoning ฝั่งวิเคราะห์)

## Evidence
- เงื่อนไขที่เพิ่มโอกาสถูกระบุ
- กลไก window ถูกหา

## Anti-patterns
- แก้ probabilistic failure ด้วย "รันใหม่แล้วผ่าน" (ยังอยู่)
- ใช้เครื่องมือ deterministic กับปัญหา probabilistic
