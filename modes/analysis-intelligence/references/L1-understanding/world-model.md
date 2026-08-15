# World Model

## What
representation ของปัญหาทั้งหมด: entities, edges (dependency/causal/trust), assumptions, unknowns, invariants — ที่ทุกชั้นของ Analysis Intelligence ใช้ reasoning ร่วมกัน

## Why
การวิเคราะห์ที่ไม่มี model กลาง = ข้อสรุปกระจัดกระจายที่ตีกันเอง model คือหน่วยความจำของเหตุผล — สิ่งที่ทำให้การวิเคราะห์หลายชั้นต่อกันได้

## When
สร้างตั้งแต่ Context Reconstruction แล้วอัปเดตทุก loop จนจบ (และข้าม session)

## Protocol
1. entities + edges + assumptions + unknowns ถูกบันทึก (ไฟล์ .loopfocus/analysis-model.md หรือ world-model.json)
2. ทุก edge มีเหตุผล/ชนิด/verified
3. ทุก assumption มี owner/age/expiry
4. ทุกการอัปเดตถูกบันทึกว่าหลักฐานอะไรทำให้เปลี่ยน

## Evidence
- model เป็น artifact ที่ตรวจได้
- การเปลี่ยน model อ้างอิงหลักฐาน

## Anti-patterns
- model ในหัว (หายเมื่อ context หมด)
- model ที่ไม่เคยอัปเดตหลังหลักฐานใหม่
