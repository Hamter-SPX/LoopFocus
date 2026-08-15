# Cross-Layer Contradiction Detection

## What
requirement ระดับ product บอกอย่างหนึ่ง แต่ hardware/software constraints ทำไม่ได้จริง — จับความขัดแย้งข้ามชั้น

## Why
ความขัดแย้งที่แพงที่สุดอยู่ระหว่างชั้น: product สัญญา latency ที่ physics ไม่ให้, marketing สัญญา SLA ที่ infra ทำไม่ได้ การ detect ข้ามชั้นคือการจับก่อนที่ใครจะเซ็นสัญญา

## When
ประเมิน feasibility ของ requirement/plan ใหม่ และเมื่อระบบไม่ถึงเป้า

## Protocol
1. ระบุ requirement แต่ละชั้น (product, software, hardware, network)
2. เทียบข้ามชั้น: requirement ชั้นบนขัดกับขีดจำกัดชั้นล่างไหม (Semantic Requirement Feasibility)
3. จุดขัดถูกระบุ + quantify (ชั้นบนต้องการ X ชั้นล่างให้ได้ Y)
4. เสนอทางออก: ปรับ requirement, เปลี่ยน architecture หรือยอมรับ trade-off อย่างเป็นทางการ

## Evidence
- ขีดจำกัดชั้นล่างมีหลักฐาน (ไม่ใช่ความรู้สึก)
- จุดขัดถูก quantify

## Anti-patterns
- ตรวจ feasibility เฉพาะชั้นของตัวเอง
- ปล่อยให้ requirement ที่เป็นไปไม่ได้เดินหน้าต่อ
