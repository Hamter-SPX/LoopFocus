# Causal Discovery Without Labels

## What
จาก observation ล้วนๆ อนุมาน causal structure โดยไม่ต้องมีคนกำหนดตัวแปรสาเหตุให้ก่อน

## Why
หลายโจทย์ไม่มีป้ายบอกว่าอะไรเป็นเหตุอะไรเป็นผล — มีแต่ข้อมูล การค้นโครงสร้างสาเหตุจากข้อมูลคือการสร้างแผนที่เหตุ-ผลจากศูนย์

## When
domain ใหม่ ระบบ black box หรือข้อมูล observational จำนวนมาก

## Protocol
1. ระบุตัวแปรที่สังเกตได้จากข้อมูล
2. ใช้เงื่อนไขเชิงสถิติ/เวลา/โครงสร้าง (independence, temporal order, intervention opportunity) เสนอโครงสร้างสาเหตุ
3. ทุกโครงสร้างที่เสนอเป็น HYPOTHESIS — มีคู่แข่ง (Competing World Models)
4. โครงสร้างที่ทำนายข้อมูลใหม่ได้แม่นสุด = INFERENCE พร้อม confidence

## Evidence
- โครงสร้างถูกทดสอบด้วยการทำนาย
- คู่แข่งถูกเก็บไว้จนมีหลักฐานตัด

## Anti-patterns
- อนุมานสาเหตุจาก correlation ตรงๆ
- ยึดโครงสร้างแรกที่ดูเข้ากันได้
