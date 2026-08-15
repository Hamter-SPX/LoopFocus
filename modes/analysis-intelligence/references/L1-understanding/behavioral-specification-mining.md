# Behavioral Specification Mining

## What
สร้าง behavioral spec จาก tests, traces, logs และ execution history — เอกสารพฤติกรรมที่ระบบ "แสดงจริง" ไม่ใช่ที่ใคร "บอก"

## Why
สำหรับระบบที่ spec ทางการหายหรือลวง behavioral spec คือความจริงภาคสนาม — ใช้เป็นเกณฑ์ตรวจ regression และเป็นเอกสารให้ทีมใหม่

## When
ควบคู่ Specification Mining เมื่อมี execution data เพียงพอ

## Protocol
1. รวม tests + traces + logs เป็น dataset พฤติกรรม
2. สกัด pattern ที่คงที่ (Behavioral Equivalence ช่วยยืนยัน)
3. เขียน spec พร้อม confidence ต่อ rule (ถี่แค่ไหนที่เห็น)
4. rule ที่ไม่ค่อยเห็น → ระบุเป็น UNKNOWN ไม่ใช่ spec

## Evidence
- แต่ละ rule มีความถี่/หลักฐาน
- rule ที่ไม่แน่ใจถูกติดป้าย

## Anti-patterns
- เขียน spec จากความจำของคน
- rule ที่เห็นครั้งเดียวกลายเป็น spec ตายตัว
