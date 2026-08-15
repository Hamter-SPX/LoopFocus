# Model Mismatch Detection

## What
รู้ว่าเมื่อไร model ที่ใช้วิเคราะห์ไม่สามารถอธิบายโลกจริงอีกแล้ว — prediction เริ่มพลาดเป็นระบบ

## Why
model ทุกตัวมีวันหมดอายุ — โลกเปลี่ยนแต่ model ไม่เปลี่ยน การ detect mismatch เร็วคือการไม่ตัดสินใจบน model ที่ตายแล้ว

## When
เฝ้า model ที่ถูกใช้ต่อเนื่อง (ทุก prediction ที่เทียบกับจริงได้)

## Protocol
1. วัด prediction error ต่อเนื่อง (ไม่ใช่ดูครั้งเดียว)
2. error เกินเกณฑ์/มี pattern (เบ้ไปทางเดียว) = mismatch signal
3. แยกสาเหตุ: model ผิดตั้งแต่แรก vs โลกเปลี่ยน (Regime Change)
4. อัปเดต/เปลี่ยน model ตามสาเหตุ

## Evidence
- error ถูกวัดต่อเนื่อง
- การตัดสินใจถูกระงับเมื่อ mismatch

## Anti-patterns
- ใช้ model ต่อทั้งที่ error สะสม
- โทษ "ข้อมูลแปลก" แทนการตรวจ model
