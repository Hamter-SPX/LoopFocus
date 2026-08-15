# Plan Assumption Audit

## What
Action Plan ทุกแผนต้องรู้ว่ากำลังเดิมพันกับ assumption อะไร — เขียนออกมาให้ครบก่อนลงมือ

## Why
แผนยืนบน assumption (คนจะว่าง, API จะพร้อม, งบจะมา) — assumption ที่ไม่ถูกเขียนคือการเดิมพันที่ไม่รู้ตัว การ audit assumption คือการเห็นหมากที่วางทั้งหมดก่อนเดิน

## When
ก่อนอนุมัติ/ลงมือทุกแผน

## Protocol
1. ไล่แผนทีละขั้น: ขั้นนี้ถือว่าอะไรเป็นจริงโดยไม่พิสูจน์
2. เขียน assumption ทุกตัว + โอกาสที่จริง + ผลถ้าผิด
3. assumption ที่เสี่ยง × ผลสูง = ต้อง verify ก่อน หรือมี fallback
4. แนบ assumption list กับแผน (ผู้ลงมือต้องเห็น)

## Evidence
- assumption ถูกเขียนครบ
- ตัวเสี่ยงถูก verify/มี fallback

## Anti-patterns
- แผนที่ไม่มี assumption list (มีแต่ซ่อนอยู่)
- ตรวจ assumption ตอนพังแล้วเท่านั้น
