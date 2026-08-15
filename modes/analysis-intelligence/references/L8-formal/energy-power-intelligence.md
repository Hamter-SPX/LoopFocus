# Energy/Power Intelligence

## What
วิเคราะห์ performance-per-watt และข้อจำกัดพลังงาน — สำหรับ hardware/AI systems ที่พลังงานคือ constraint จริง

## Why
พลังงานกลายเป็นคอขวดจริง: data center ถูกจำกัดด้วย power, device ถูกจำกัดด้วยแบต การ optimize โดยไม่ดูพลังงานคือการ optimize ครึ่งเดียว (เร็วแต่กินไฟจนใช้จริงไม่ได้)

## When
ประเมิน/optimize ระบบที่พลังงานเป็น constraint (AI inference, mobile, DC)

## Protocol
1. วัด/ประเมิน power ของ workload (ต่อ operation, ต่อ request)
2. คำนวณ performance-per-watt (งาน/วัตต์) — metric ที่สมดุล
3. หา trade-off: เร็วขึ้นเท่าไร แลกไฟเท่าไร (Energy–Latency–Throughput)
4. เลือกจุดบน Pareto ตาม constraint จริง (power budget)

## Evidence
- power ถูกวัด/ประเมิน
- trade-off ถูก quantify

## Anti-patterns
- Optimize latency อย่างเดียวโดยไม่ดู power
- ไม่รู้ power budget ของระบบตัวเอง
