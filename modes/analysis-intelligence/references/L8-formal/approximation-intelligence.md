# Approximation Intelligence

## What
รู้เมื่อไร solution ที่ approximate คุ้มกว่าการหาคำตอบ exact — และ approximate แบบไหนที่ "ดีพอ" สำหรับโจทย์นี้

## Why
exact แพง (เวลา/ทรัพยากร) และหลายโจทย์ไม่ต้องการ exact: ผลต่าง 1% ไม่มีผลต่อ decision การรู้ว่า approximate พอเมื่อไรคือการได้คำตอบเร็วพอที่จะใช้ — ไม่ใช่แม่นจนสาย

## When
เมื่อ exact แพงเกิน หรือ decision ไม่ไวต่อความต่างเล็กน้อย

## Protocol
1. ระบุความแม่นที่ decision ต้องการจริง (ไม่ใช่ "แม่นสุด")
2. หา approximation ที่อยู่ในขอบเขตนั้น (พร้อม error bound)
3. เทียบราคา: approximate เร็ว/ถูกกว่าเท่าไร แลกกับ error เท่าไร
4. เลือกตามความไวของ decision ต่อ error (Sensitivity)

## Evidence
- ความแม่นที่ต้องถูกระบุ
- error bound ของ approximation ถูกระบุ

## Anti-patterns
- หา exact ทั้งที่ decision ไม่ไวต่อ error
- approximate โดยไม่รู้ error bound (อาจผิดเกินรับ)
