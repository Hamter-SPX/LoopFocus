# Consensus Without Groupthink

## What
รวมหลายมุมมองโดยไม่ให้คำตอบเสียงข้างมากกลืน minority hypothesis ที่อาจถูก — ความเห็นพ้องที่เกิดจากการชั่งจริง ไม่ใช่การคล้อยตาม

## Why
groupthink ผลิต consensus ปลอม: ทุกคนเห็นด้วยเพราะเห็นคนอื่นเห็นด้วย ไม่ใช่เพราะหลักฐาน การสร้าง consensus ที่ minority ยังมีเสียงคือการกันการตัดสินใจหมู่ที่พลาดพร้อมกัน

## When
รวม verdict จากหลาย analyst/judge (Analysis Mesh, Multi-Judge)

## Protocol
1. เก็บ verdict แยกก่อนรวม (blind round — กัน anchoring)
2. รวมโดยดูทั้งความเห็นและเหตุผล ไม่ใช่แค่นับคะแนน
3. minority ที่มีเหตุผลดีถูกบันทึก/เก็บ (Minority Hypothesis Preservation)
4. consensus สุดท้ายระบุ dissent ที่ยังอยู่ + ทำไมไม่ชนะ

## Evidence
- verdict แยกถูกบันทึกก่อนรวม
- dissent ถูกระบุในผล

## Anti-patterns
- นับคะแนนแล้วจบ (dissent หาย)
- รวมความเห็นหลังเห็นของคนอื่น (anchoring)
