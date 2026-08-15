# Negative Result Intelligence

## What
experiment ที่ "ไม่เจออะไร" ก็ใช้ตัด hypothesis ได้ — ถ้า test มี detection power เพียงพอ

## Why
ผลลบถูกทิ้งเพราะดูไร้ค่า — แต่ผลลบจาก test ที่มี power สูงคือหลักฐานแข็ง: "ถ้ามี มันต้องเจอ และมันไม่เจอ" การรู้ power ของ test คือการเปลี่ยนความว่างเปล่าเป็นข้อมูล

## When
ตีความ experiment ที่ผลออกมา "ไม่มีอะไร"

## Protocol
1. ถาม: test นี้มี power แค่ไหน — ถ้าสิ่งนั้นมีจริง โอกาสเจอ = ?
2. power สูง + ไม่เจอ = negative evidence แข็ง (ตัด hypothesis ได้)
3. power ต่ำ + ไม่เจอ = ไม่ได้ข้อมูล (UNKNOWN)
4. ระบุ power ในข้อสรุป — "ไม่เจอ" ต้องบอกด้วยว่าเจอได้แค่ไหน

## Evidence
- power ถูกประเมิน
- ผลลบถูกตีความตาม power

## Anti-patterns
- ทิ้งผลลบทั้งหมดว่าไร้ค่า
- ใช้ผลลบจาก test ที่มองไม่เห็นสิ่งที่ตามหา
