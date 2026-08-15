# Resilience Reasoning

## What
ไม่ถามแค่ว่าป้องกัน failure ได้ไหม — แต่ถามว่าฟื้นตัวได้เร็วแค่ไหนหลังพัง

## Why
failure เกิดแน่ — ระบบที่กันได้ 99% แต่พังแล้วจม 3 วัน แพ้ระบบที่พังบ่อยกว่าแต่ฟื้นใน 5 นาที การคิด resilience คือการยอมรับว่าพังแล้ว optimize การฟื้นแทนการฝันว่าจะไม่พัง

## When
ประเมิน/ออกแบบระบบที่ downtime แพง

## Protocol
1. ระบุ failure modes + สิ่งที่ระบบทำหลังพัง (detect → contain → recover)
2. วัด MTTR (เวลาเฉลี่ยในการฟื้น) ต่อ failure mode — ไม่ใช่แค่ MTBF
3. หาจุดที่ฟื้นช้า (depend กับคน, ไม่มี automation, state เสียหาย)
4. ปรับให้ฟื้นได้เอง/เร็ว (Recovery Path Intelligence)

## Evidence
- MTTR ถูกวัดต่อ failure mode
- จุดฟื้นช้าถูกระบุ

## Anti-patterns
- ลงทุนแต่ prevention ไม่ลง recovery
- วัดแค่ "พังบ่อยแค่ไหน" ไม่วัด "ฟื้นช้าแค่ไหน"
