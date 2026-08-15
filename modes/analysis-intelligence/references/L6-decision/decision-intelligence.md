# Decision Intelligence

## What
ให้ recommendation พร้อม evidence และ uncertainty — ไม่ใช่แค่ตัวเลือก แต่ตัวเลือก + ทำไม + มั่นใจแค่ไหน

## Why
decision ที่ไม่มี evidence คือการพนันแบบไม่รู้ตัว, ที่ไม่มี uncertainty คือการพนันแบบหลอกตัวเอง การส่งทั้งสามอย่างคือการให้ผู้ตัดสินใจมีข้อมูลครบ

## When
ทุกครั้งที่เสนอ recommendation

## Protocol
1. ระบุ decision + ตัวเลือก
2. รวบรวม evidence สนับสนุน/ค้านแต่ละตัวเลือก
3. ประเมิน uncertainty (อะไรที่ยังไม่รู้, ถ้ารู้แล้วจะพลิกไหม)
4. ส่ง: recommendation + evidence + confidence + sensitivity map + เงื่อนไขที่จะเปลี่ยนคำแนะนำ

## Evidence
- evidence ถูกแนบ
- เงื่อนไขเปลี่ยน recommendation ถูกระบุ

## Anti-patterns
- เสนอตัวเลือกเปล่าๆ ไม่มีเหตุผล
- ซ่อน uncertainty เพื่อให้ recommendation ดูแข็ง
