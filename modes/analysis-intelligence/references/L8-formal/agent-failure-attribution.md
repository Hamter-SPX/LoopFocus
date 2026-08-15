# Agent Failure Attribution

## What
ถ้า Agent ทำงานผิด — จำแนกว่ามาจากเข้าใจเป้าหมายผิด, วิเคราะห์ผิด, เลือก tool ผิด, execute ผิด หรือ verify ผิด

## Why
Agent เป็น pipeline หลายขั้น: พลาดตรงไหนแก้ตรงนั้น การโทษ "agent โง่" รวมๆ ทำให้แก้ไม่ถูกจุด (วางแผนดีแต่ execute พัง → แก้ที่ execute ไม่ใช่ที่ planning)

## When
ทุกครั้งที่ agent (หรือทีม agent) ทำงานพลาด

## Protocol
1. ไล่ pipeline: goal → plan → tool → execute → verify
2. หาขั้นแรกที่ผลเบี่ยง (เทียบ output แต่ละขั้นกับที่ควร)
3. ระบุขั้นที่พลาด + ทำไม (ขาดข้อมูล? tool ไม่พอ? verify อ่อน?)
4. แก้ที่ขั้นนั้น (Execution Feedback Attribution แบบ agent)

## Evidence
- แต่ละขั้นถูกตรวจแยก
- ขั้นที่พลาดถูกระบุพร้อมเหตุผล

## Anti-patterns
- โทษขั้นสุดท้ายที่เห็นพัง (บ่อยครั้งพลาดตั้งแต่ขั้นแรก)
- แก้ทุกขั้นพร้อมกันโดยไม่รู้ว่าขั้นไหนคือตัวการ
