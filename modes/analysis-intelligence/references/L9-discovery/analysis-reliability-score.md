# Analysis Reliability Score

## What
conclusion แต่ละอันมีคะแนนจาก evidence coverage, assumption count, disagreement และ stability — ไม่ใช้ confidence ตัวเลขลอยๆ

## Why
confidence ตัวเดียวซ่อนที่มา — reliability score แยกองค์ประกอบ: หลักฐานครบไหม, assumption หนักไหม, มีเสียงค้านไหม, ทนการเขย่าไหม การเห็นองค์ประกอบคือการรู้ว่าทำไมถึงเชื่อ และเชื่อได้เท่าไร

## When
ประกอบกับทุก conclusion สำคัญ

## Protocol
1. คำนวณ 4 องค์ประกอบ: evidence coverage, assumption count (ยิ่งน้อยยิ่งดี), disagreement (มีเสียงค้านไหม), stability (ทนการเขย่าแค่ไหน)
2. รวมเป็น score (ถ่วงตามความสำคัญของแต่ละองค์ประกอบ)
3. ส่ง score + breakdown (ไม่ใช่เลขเดียว)
4. score ต่ำ = ไม่ควรถูกใช้ตัดสินใจแพง

## Evidence
- 4 องค์ประกอบถูกคำนวณ
- breakdown ถูกส่ง

## Anti-patterns
- ใช้ confidence ตัวเดียวไม่มีที่มา
- score สูงจากการปิดตาไม่ดูองค์ประกอบอ่อน
