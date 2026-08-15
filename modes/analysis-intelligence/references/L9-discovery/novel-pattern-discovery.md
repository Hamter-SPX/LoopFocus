# Novel Pattern Discovery

## What
หา pattern ที่ไม่ได้อยู่ใน training checklist — รูปแบบใหม่ที่ไม่เคยถูกระบุในความรู้เดิม

## Why
checklist ครอบคลุมสิ่งที่รู้จัก — pattern ใหม่คือสิ่งที่ทุกเครื่องมือเดิมมองไม่เห็น การหา pattern ใหม่คือการค้นพบความรู้ ไม่ใช่การเรียกคืน

## When
เมื่อวิเคราะห์ข้อมูล/ระบบใหม่ หรือเมื่อ pattern เดิมอธิบายไม่พอ

## Protocol
1. สำรวจข้อมูลโดยไม่บังคับด้วย pattern เดิม (Open-World)
2. หาความสม่ำเสมอที่ไม่ตรงกับ pattern ที่รู้จัก (residual structure)
3. ตั้งเป็น candidate pattern + ทดสอบ (Novel Hypothesis)
4. pattern ที่รอดการทดสอบ = discovery (บันทึก + ขอบเขต)

## Evidence
- candidate ถูกทดสอบ
- ขอบเขตของ pattern ใหม่ถูกระบุ

## Anti-patterns
- เห็นความสม่ำเสมอแล้วประกาศ pattern ทันที (ต้องทดสอบ)
- บังคับข้อมูลเข้ากับ pattern เดิม
