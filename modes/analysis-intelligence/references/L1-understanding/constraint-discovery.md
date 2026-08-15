# Constraint Discovery

## What
หา constraint ที่มีอยู่จริงแต่ไม่ได้เขียนไว้ตรงๆ — ใน code, config, timing, resource

## Why
ระบบเต็มไปด้วย constraint โดยนัย: "งานนี้ต้องเสร็จก่อนงานนั้น", "หน่วยความจำนี้ใช้ได้แค่ตอนนี้" การรู้ constraint ที่แท้จริงคือข้อจำกัดของทุก solution ที่เสนอได้

## When
ก่อนเสนอ solution ใดๆ — constraint คือขอบเขตของพื้นที่คำตอบ

## Protocol
1. สกัด constraint จาก code paths, configs, timing, resource limits
2. แยก constraint จริงจาก convention (Constraint-Breaking Discovery)
3. บันทึก constraint + แหล่ง + ผลถ้าละเมิด
4. ทุก solution ที่เสนอต้องผ่าน constraint list

## Evidence
- constraint มีแหล่งอ้างอิง
- solution ถูกตรวจกับ constraint list

## Anti-patterns
- รับ convention เป็น constraint ตายตัว
- เสนอ solution โดยไม่เช็ค constraint
