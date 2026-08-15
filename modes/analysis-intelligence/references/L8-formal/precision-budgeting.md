# Precision Budgeting

## What
ใช้ความแม่นยำสูงเฉพาะจุดที่ผลลัพธ์ไวต่อ error — ไม่ใช่แม่นทุกจุดเท่ากัน

## Why
ความแม่นมีราคา (compute, เวลา, ความซับซ้อน) การแม่นทุกจุดคือการจ่ายราคาเต็มกับจุดที่ error ไม่มีผล การจัดสรร precision ตาม sensitivity คือการได้คุณภาพที่ต้องการด้วยราคาต่ำสุด

## When
ออกแบบ computation/measurement ที่ความแม่นสำคัญบางจุด

## Protocol
1. ระบุจุดที่ผลลัพธ์ไวต่อ error (Sensitivity Analysis)
2. จุดไว → precision สูง; จุดไม่ไว → precision พอใช้
3. ระบุ error budget รวม (งบความคลาดเคลื่อนของทั้งระบบ)
4. จัดสรรงบตาม sensitivity (ไม่ใช่เฉลี่ยเท่ากัน)

## Evidence
- sensitivity ถูกใช้จัดสรร
- error budget ถูกระบุ

## Anti-patterns
- แม่นทุกจุด (แพง) หรือหยาบทุกจุด (พังที่จุดไว)
- ไม่รู้ว่าจุดไหนไวต่อ error
