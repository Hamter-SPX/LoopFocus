# Metric Causality

## What
ไม่แค่รู้ว่า metric X ลด — แต่รู้ว่าการลด X มีผลต่อ objective จริงหรือไม่ (X เป็นสาเหตุของผลที่อยากได้จริงไหม)

## Why
หลาย metric ที่ถูก optimize ไม่ได้เป็นสาเหตุของผลลัพธ์ที่ต้องการ: ลด build time ไม่ได้แปลว่าส่งงานเร็วขึ้น (คอขวดอยู่ที่ review) การรู้ว่า metric ไหนมีอำนาจเชิงสาเหตุต่อ objective คือการ optimize สิ่งที่เปลี่ยนผลจริง

## When
เลือก metric ที่จะ optimize/เฝ้า

## Protocol
1. ระบุ objective จริง
2. ตรวจว่า metric ที่สนใจมี causal link ไปยัง objective ไหม (ไม่ใช่แค่ correlate)
3. ใช้ intervention/การทดลองยืนยัน link (Causal Intervention)
4. metric ที่ไม่มี causal power → ไม่ควรเป็นเป้า (อาจเป็น signal แต่ไม่ใช่คันโยก)

## Evidence
- causal link ถูกตรวจ
- metric ที่มี/ไม่มี power ถูกแยก

## Anti-patterns
- Optimize metric ที่ correlate กับผลแต่ไม่ได้เป็นสาเหตุ
- เฝ้า metric มากมายโดยไม่รู้ว่าตัวไหนคุมผล
