# Conclusion Stability Score

## What
บอกว่าคำตอบนี้แข็งแรงต่อข้อมูล/assumption ที่เปลี่ยนเล็กน้อยแค่ไหน — เป็นตัวเลข ไม่ใช่ความรู้สึก

## Why
สอง conclusion ที่ confidence เท่ากันอาจต่างกันสุดขั้ว: ตัวหนึ่งยืนนิ่งเมื่อหลักฐานขยับ อีกตัวพลิกทันที stability score แยกสองตัวนี้ออกจากกัน

## When
ประกอบกับ confidence ทุกครั้ง — confidence บอก "มั่นใจตอนนี้" stability บอก "จะอยู่ไหมเมื่อโลกขยับ"

## Protocol
1. เปลี่ยนหลักฐาน/assumption ทีละเล็กน้อย (perturb)
2. วัดว่า conclusion เปลี่ยนแค่ไหน (ทิศทาง/ขนาด)
3. stability = 1 - (ความไวต่อการเปลี่ยนแปลง)
4. สรุปพร้อมทั้งสองค่า: confidence + stability

## Evidence
- การ perturb ถูกทำอย่างเป็นระบบ
- ทั้งสองค่าถูกระบุ

## Anti-patterns
- รายงาน confidence โดยไม่รู้ stability
- ใช้ conclusion ที่ stability ต่ำกับ decision ระยะยาว
