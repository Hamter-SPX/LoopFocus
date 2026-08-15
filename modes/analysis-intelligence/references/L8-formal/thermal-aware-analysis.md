# Thermal-Aware Analysis

## What
เข้าใจ performance degradation ที่เกิดจาก thermal behavior — ไม่ใช่แค่ software: ระบบร้อนแล้วช้าลงเอง

## Why
thermal throttling หลอกทุกการวิเคราะห์ performance: ระบบ "ช้า" ทั้งที่โค้ดไม่มีอะไรผิด — แค่ร้อน การแยก thermal effect คือการไม่แก้โค้ดผิดจุด

## When
performance แปลกที่แปรตามเวลา/โหลด และใน hardware-constrained systems

## Protocol
1. เก็บ thermal data ควบคู่ performance (อุณหภูมิ + clock + latency)
2. หา correlation: performance ตกตามอุณหภูมิไหม (throttling curve)
3. แยก: ปัญหาที่ thermal vs ที่ software (เทียบที่อุณหภูมิเท่ากัน)
4. ถ้า thermal: แก้ที่ระบายความร้อน/power budget ไม่ใช่ที่โค้ด

## Evidence
- thermal + performance ถูกเก็บคู่กัน
- การแยกสาเหตุถูกทำ

## Anti-patterns
- Debug performance โดยไม่ดูอุณหภูมิ
- แก้โค้ดกับปัญหาที่ thermal เป็นตัวการ
