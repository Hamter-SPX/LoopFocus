# Numerical Behavior Intelligence

## What
จับ precision loss, accumulation error, quantization effect และ instability ที่ทำให้ผลต่างแม้ logic ถูก — เห็นชั้นตัวเลขของระบบ

## Why
หลายบั๊ก "อธิบายไม่ได้" จริงๆ คือ numerical: float ที่เทียบไม่เท่ากัน, quantization ที่เปลี่ยนผล, error ที่สะสมข้ามบริการ การเห็นชั้นตัวเลขคือการอธิบายสิ่งที่ logic มองไม่เห็น

## When
debug ผลที่ "แปลก" ในระบบที่เกี่ยวข้องกับตัวเลข (เงิน, ML, signal)

## Protocol
1. ตรวจ precision ตลอด path (float32/64, int, decimal — เปลี่ยนที่ไหน)
2. หาจุด quantization/rounding (ML model, serialization, storage)
3. ตรวจการเทียบ/สะสมที่ไวต่อ error (Numerical Stability)
4. ระบุจุดที่ตัวเลขเปลี่ยนความหมาย (Semantic Drift เชิงตัวเลข)

## Evidence
- precision path ถูกไล่
- จุด quantization ถูกระบุ

## Anti-patterns
- หาเหตุจาก logic อย่างเดียวเมื่อผลตัวเลขแปลก
- ใช้ float กับเงิน/สิ่งที่ต้อง exact
