# Model Failure Attribution

## What
แยก hallucination/ความผิดพลาดของ AI ว่ามาจาก model limitation, context, retrieval, tool result, prompt หรือ orchestration — ไม่เหมารวมว่า "model โง่"

## Why
AI ผิดมีหลายสาเหตุ และแก้คนละทาง: context ไม่พอ ≠ model อ่อน, retrieval ผิด ≠ prompt แย่ การ attribution ถูกคือการแก้ถูกจุด (และไม่โทษ model กับสิ่งที่ model ไม่ผิด)

## When
ทุกครั้งที่ AI ให้ผลผิด/หลอน

## Protocol
1. ระบุขั้นที่ผลผิดเกิด (รับ input → retrieve → compose → generate → tool → สรุป)
2. ทดสอบแยกขั้น: เปลี่ยน context/retrieval/tool result แล้วผลเปลี่ยนไหม
3. ระบุตัวการจริง (อาจหลายขั้นร่วม)
4. แก้ที่ขั้นนั้น (เพิ่ม context? แก้ retrieval? ปรับ prompt?)

## Evidence
- การทดสอบแยกขั้นถูกทำ
- ตัวการถูกระบุด้วยการทดลอง

## Anti-patterns
- โทษ "model หลอน" โดยไม่แยกสาเหตุ
- แก้ prompt กับปัญหาที่ retrieval เป็นตัวการ
