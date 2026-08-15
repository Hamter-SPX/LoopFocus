# Sequential Experiment Intelligence

## What
ไม่กำหนด test ทั้งหมดล่วงหน้า — test รอบใหม่ขึ้นกับผลรอบก่อน (ผลแรกกำหนดว่าจะทดสอบอะไรต่อ)

## Why
การกำหนดทุก test ล่วงหน้า = ใช้ข้อมูลเก่าในการออกแบบสิ่งที่ข้อมูลใหม่จะบอก การทดลองแบบ sequential ปรับตามผลที่เพิ่งได้ — converge เร็วขึ้นมาก

## When
การวิเคราะห์แบบ multi-round ที่ผลแต่ละรอบชี้ทางต่อไป

## Protocol
1. ออกแบบเฉพาะ test ถัดไป (ตัวที่ discriminating สูงสุดตอนนี้)
2. รัน → อัปเดต uncertainty space (Bayesian)
3. test ต่อไปออกแบบจาก space ใหม่
4. หยุดเมื่อ space แคบพอ (Stopping Intelligence)

## Evidence
- แต่ละ round ออกแบบจากผลรอบก่อน
- การอัปเดต space ถูกบันทึก

## Anti-patterns
- ออกแบบ test ทั้งหมดตั้งแต่แรกแล้วรันตาม script
- รัน test ต่อแม้ information gain ต่ำแล้ว
