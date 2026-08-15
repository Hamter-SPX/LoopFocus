# Hidden-State Reconstruction

## What
จาก log/output ที่เห็นเพียงบางส่วน ประมาณ state ภายในที่มองไม่เห็น — queue depth, cache content, scheduler state, connection pool

## Why
สิ่งที่มองไม่เห็นมักเป็นตัวการ: ระบบดูปกติใน log แต่ state ภายในกำลังสะสมจนพัง การ reconstruct state ที่ซ่อนคือการเห็นสิ่งที่ telemetry ไม่เก็บ

## When
เมื่ออาการบ่งว่า state ภายในมีบทบาทแต่ไม่มี signal ตรงๆ

## Protocol
1. ระบุ state ภายในที่เกี่ยวข้องกับอาการ
2. หา indirect signals (latency pattern, throughput curve, log gaps)
3. สร้าง estimate + confidence (UNKNOWN ถ้าประเมินไม่ได้)
4. ทดสอบ estimate ด้วยการทำนาย (Prediction Before Observation)

## Evidence
- estimate มี signal อ้างอิง
- ส่วนที่ประเมินไม่ได้ระบุเป็น UNKNOWN

## Anti-patterns
- สร้าง state ภายในที่ไม่สามารถตรวจได้เลย
- เชื่อ estimate เกิน confidence ของมัน
