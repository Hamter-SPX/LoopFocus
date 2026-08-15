# Emergent Requirement Discovery

## What
จากการใช้งานจริงพบ requirement ที่ไม่มีใครเขียนไว้ — ความต้องการที่เกิดขึ้นจากการใช้ ไม่ใช่จาก spec

## Why
ผู้ใช้สร้าง requirement ด้วยพฤติกรรม: ใช้ระบบในทางที่ออกแบบไม่ถึง, workaround ที่กลายเป็นมาตรฐาน การค้นพบ requirement เหล่านี้คือการเห็นสิ่งที่ระบบ "ต้องทำจริง" ไม่ใช่สิ่งที่เคยเขียน

## When
วิเคราะห์พฤติกรรมการใช้งาน, support tickets, workaround patterns

## Protocol
1. เก็บพฤติกรรมการใช้จริง (workaround, การใช้ผิดทางที่เป็นระบบ, คำขอซ้ำ)
2. อนุมาน requirement ที่ซ่อน: ผู้ใช้พยายามทำอะไร (Intent Reconstruction)
3. เทียบกับ spec — สิ่งที่พฤติกรรมบอกแต่ spec ไม่มี = emergent requirement
4. เสนอ: รับ requirement เข้า spec อย่างเป็นทางการ หรือออกแบบทางที่ถูกต้องให้

## Evidence
- requirement มาจากพฤติกรรมจริง (มีหลักฐาน)
- การตัดสินใจรับ/ไม่รับถูกบันทึก

## Anti-patterns
- มอง workaround เป็น "ผู้ใช้ใช้ผิด" โดยไม่ถามว่าทำไม
- รับ requirement จากพฤติกรรมเดียว
