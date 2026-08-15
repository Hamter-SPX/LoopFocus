# AI-System Analysis

## What
วิเคราะห์ model + tokenizer + inference engine + quantization + GPU + memory + serving stack เป็นระบบเดียว — ไม่ใช่แยกชิ้น

## Why
AI system เป็น stack: บั๊ก/คอขวดอยู่ตรงรอยต่อ (model ดีแต่ quantization พัง, serving ดีแต่ memory พอดีเกิน) การวิเคราะห์ทั้ง stack คือการเห็นจุดที่ชิ้นส่วนรวมกันแล้วพัง

## When
debug/optimize ระบบ AI inference/training จริง

## Protocol
1. ระบุทุกชั้นของ stack (model → quantization → engine → GPU/memory → serving → client)
2. วิเคราะห์แต่ละชั้น + รอยต่อระหว่างชั้น (ข้อมูลเปลี่ยนรูปตรงไหน)
3. หาจุดที่คุณภาพ/performance ตก (เทียบ baseline ต่อชั้น)
4. แก้ที่ชั้น/รอยต่อที่เป็นตัวการ (Model Failure Attribution)

## Evidence
- ทุกชั้นถูกวิเคราะห์
- จุดตกถูกระบุต่อชั้น

## Anti-patterns
- โทษ model อย่างเดียว (stack มีหลายผู้ต้องสงสัย)
- แยกชั้นวิเคราะห์โดยไม่ดูรอยต่อ
