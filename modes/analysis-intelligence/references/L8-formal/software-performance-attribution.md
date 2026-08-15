# Software Performance Attribution

## What
แยก algorithmic complexity, lock contention, GC, allocation, serialization, network ฯลฯ — รู้ว่าซอฟต์แวร์ช้าเพราะอะไรกันแน่

## Why
"โค้ดช้า" มีสาเหตุเป็นสิบ — และแต่ละตัวแก้คนละทาง (GC ≠ lock ≠ algorithm) การ attribution ถูกคือการแก้ถูกจุด แทนการเดาสุ่ม optimize

## When
optimize/debug performance ฝั่งซอฟต์แวร์

## Protocol
1. เก็บ profiling ครบมิติ (CPU time, allocation, lock wait, GC, network, serialization)
2. หาตัวที่กินเวลามากสุด (ไม่ใช่ตัวที่ "น่าจะ" ช้า)
3. แยก algorithmic (ช้าโดยโครงสร้าง) จาก implementation (ช้าโดยวิธีเขียน)
4. แก้ตัวที่กินจริง + วัดก่อน/หลัง

## Evidence
- profiling ถูกเก็บ
- ตัวกินเวลาถูกระบุด้วยข้อมูล

## Anti-patterns
- Optimize ตามความรู้สึก (จุดที่ "น่าจะช้า")
- แก้ algorithmic ปัญหาด้วย micro-optimization (หรือกลับกัน)
