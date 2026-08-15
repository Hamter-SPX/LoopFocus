# Resource Coupling Intelligence

## What
CPU, memory, bandwidth, storage, thermal และ power เชื่อมกันอย่างไร — ไม่ optimize แยกทีละตัว

## Why
ทรัพยากรไม่เป็นอิสระ: เพิ่ม CPU → ร้อนขึ้น → throttle → ช้าลง, ลด memory → disk swap → I/O พุ่ง การ optimize แยกตัวคือการชนะจุดเดียวแล้วแพ้ระบบ การเห็น coupling คือการ optimize ทั้งระบบ

## When
optimize/ออกแบบระบบที่ทรัพยากรพันกัน (เกือบทุกอย่าง)

## Protocol
1. วาด coupling ระหว่างทรัพยากร (ตัวไหนกระทบตัวไหน)
2. ประเมินผลข้างเคียงของการปรับแต่ละตัว (Optimization Side-Effect)
3. หาจุดที่ปรับแล้วทั้งระบบดีขึ้นจริง (ไม่ใช่แค่ metric เดียว)
4. ตรวจหลังปรับครบทุกมิติ (ไม่ใช่แค่มิติเป้า)

## Evidence
- coupling ถูกวาด
- การตรวจหลังปรับครบมิติถูกทำ

## Anti-patterns
- Optimize metric เดียวแล้วลืมส่วนที่เหลือ
- ไม่เห็นว่า resource แย่งกันเอง
