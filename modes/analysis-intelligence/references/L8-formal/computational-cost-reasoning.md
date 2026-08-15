# Computational Cost Reasoning

## What
ประเมินว่าการตัดสินใจจะส่งผลต่อ compute/memory/network/storage อย่างไร — ราคาทางทรัพยากรของทุกทางเลือก

## Why
ทุก decision มีราคา compute ที่ซ่อนอยู่: feature ใหม่ = CPU, เก็บข้อมูล = storage, ส่งข้าม network = bandwidth การรู้ราคาคือการตัดสินใจที่มีข้อมูลครบ (ไม่ใช่แค่ "มันเวิร์ค")

## When
เลือก architecture/algorithm/feature ที่กระทบทรัพยากร

## Protocol
1. ประเมิน cost ต่อมิติ: compute (CPU/GPU), memory, network, storage
2. คำนวณที่ scale จริง (n ผู้ใช้ × usage) ไม่ใช่ prototype
3. เทียบ cost ระหว่างทางเลือก (รวม cost ต่อเนื่อง ไม่ใช่แค่ตั้งต้น)
4. ระบุ cost ใน decision record (Trade-off)

## Evidence
- cost ถูกประเมินต่อมิติ
- การคำนวณที่ scale จริงถูกทำ

## Anti-patterns
- ตัดสินใจจาก cost ที่ prototype (scale จริงต่างกันมาก)
- มองข้าม cost ต่อเนื่อง (storage โตทุกเดือน)
