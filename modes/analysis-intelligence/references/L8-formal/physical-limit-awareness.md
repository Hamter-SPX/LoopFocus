# Physical Limit Awareness

## What
ไม่เสนอ solution ที่ละเมิดข้อจำกัดพื้นฐานด้าน bandwidth, latency, thermodynamics หรือ computation — รู้ขอบเขตที่ physics กำหนด

## Why
ข้อจำกัดทางกายภาพไม่ negotiable: แสงเดินทางไม่เร็วขึ้น, คำนวณไม่ฟรี, ความร้อนไม่หายไป การเสนอ solution ที่ละเมิดมันคือการเสียเวลาทั้งระบบ การรู้ limits คือการรู้ว่าพื้นที่คำตอบจริงคืออะไร

## When
ประเมิน feasibility ของ requirement/architecture ใดๆ

## Protocol
1. ระบุ physical limits ที่เกี่ยวข้อง (latency floor, bandwidth cap, energy floor)
2. เทียบ requirement กับ limits — เกินคือเป็นไปไม่ได้ (Semantic Requirement Feasibility)
3. ระบุว่า "เป็นไปไม่ได้" แบบไหน: physics จริง vs แค่ยาก (อย่าสับสน)
4. requirement ที่เกิน limits → ต้องเปลี่ยน requirement ไม่ใช่พยายามต่อไป

## Evidence
- limits ถูกระบุเป็นตัวเลข
- การเทียบ requirement/limit ถูกทำ

## Anti-patterns
- เสนอ solution ที่ละเมิด physics
- สับสน "ยากมาก" กับ "เป็นไปไม่ได้" (หรือกลับกัน)
