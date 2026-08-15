# Decision Boundary Discovery

## What
หาเงื่อนไขที่ recommendation จาก "เลือก A" จะพลิกเป็น "เลือก B" — เส้นแบ่งของการตัดสินใจ

## Why
recommendation ไม่ใช่คำตอบตายตัว — มันคือฟังก์ชันของเงื่อนไข การรู้ boundary (จุดที่คำตอบพลิก) คือการรู้ว่าคำแนะนำนี้เปราะแค่ไหน และต้องเฝ้าเงื่อนไขไหน

## When
ทุก recommendation สำคัญ

## Protocol
1. ระบุตัวแปรที่มีผลต่อ recommendation (Sensitivity)
2. หาจุดที่ recommendation พลิก (เปลี่ยนตัวแปรทีละตัว)
3. วาด boundary: เงื่อนไขแบบไหน → A, แบบไหน → B
4. ระบุว่าสถานการณ์ปัจจุบันอยู่ห่างจาก boundary แค่ไหน (margin)

## Evidence
- boundary ถูกคำนวณ
- margin ถูกระบุ

## Anti-patterns
- ให้ recommendation โดยไม่รู้ว่ามันพลิกเมื่อไร
- ซ่อนว่า recommendation เปราะต่อเงื่อนไขที่กำลังเปลี่ยน
