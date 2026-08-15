# Semantic Regression Detection

## What
code test ผ่านทั้งหมดแต่ behavior สำคัญเปลี่ยนไปก็จับได้ — การถดถอยทางความหมาย ไม่ใช่ทาง test

## Why
tests ปกป้องสิ่งที่ถูกเขียน ไม่ใช่ทุกสิ่งที่สำคัญ: behavior ที่ไม่มี test เปลี่ยนได้เงียบๆ การตรวจ semantic regression คือการเทียบ "ระบบเคยทำอะไร" กับ "ตอนนี้ทำอะไร" เหนือกว่า test suite

## When
หลังการ refactor/optimize ที่ "test ผ่านหมด"

## Protocol
1. ระบุ behavior สำคัญก่อนเปลี่ยน (จาก Behavioral Spec / ข้อมูลจริง)
2. หลังเปลี่ยน: เทียบ behavior จริง (ไม่ใช่แค่ test) — อะไรเปลี่ยนทั้งที่ไม่ตั้งใจ
3. จุดเปลี่ยน = semantic regression → แก้ หรือตั้งใจเปลี่ยน (บันทึกว่าเป็นการตัดสินใจ)
4. behavior สำคัญที่เปลี่ยน → กลายเป็น test ใหม่กันซ้ำ

## Evidence
- behavior ก่อน/หลังถูกเทียบ
- regression ที่เจอถูกแยกเป็น "ตั้งใจ/ไม่ตั้งใจ"

## Anti-patterns
- "test ผ่านหมด" = สรุปว่าไม่มีการถดถอย
- ไม่บันทึก behavior สำคัญก่อนเปลี่ยน
