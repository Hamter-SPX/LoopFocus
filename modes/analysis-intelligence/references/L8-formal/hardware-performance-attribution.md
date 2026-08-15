# Hardware Performance Attribution

## What
แยก slowdown ว่ามาจาก compute, cache, memory bandwidth, I/O, scheduling, thermal หรือ software — ไม่เหมารวมว่า "เครื่องช้า"

## Why
"เครื่องช้า" ไม่ใช่สาเหตุ — คืออาการรวมของหลายกลไก การ attribution ถูกคือการรู้ว่าคอขวดจริงคือตัวไหน แล้วแก้ถูกจุด (เพิ่ม CPU ทั้งที่ตัน memory = ไม่ช่วย)

## When
performance ปัญหาในระบบที่ฮาร์ดแวร์เกี่ยวข้อง

## Protocol
1. เก็บ counters ครบมิติ (CPU util, cache miss, memory BW, I/O wait, throttle, scheduling)
2. หามิติที่อิ่มตัว (ตัวที่แตะ 100% หรือใกล้)
3. เทียบ: ตัวไหนคือคอขวดจริง (อิ่มก่อนตัวอื่น)
4. แยก thermal effect (Thermal-aware) และ software inefficiency ออก

## Evidence
- counters ถูกเก็บครบมิติ
- มิติอิ่มตัวถูกระบุ

## Anti-patterns
- เหมาว่า CPU = คอขวด (บ่อยครั้งคือ memory/I/O)
- แก้ hardware ทั้งที่ software คือตัวการ
