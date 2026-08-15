# Micro-to-Macro Reasoning

## What
เข้าใจว่าพฤติกรรมเล็กๆ ระดับ component รวมกันสร้าง behavior ใหญ่ของระบบได้อย่างไร

## Why
พฤติกรรมรวม (throughput, stability, cost) เป็นผลรวมของ micro-behavior การไล่จากเล็กไปใหญ่คือการหา "ทำไมรวมแล้วเป็นแบบนี้" — และหาจุดเล็กที่ควบคุมผลใหญ่ได้ (Critical Parameter)

## When
เมื่อต้องอธิบาย/ทำนาย behavior ระดับระบบจากส่วนประกอบ

## Protocol
1. ระบุ micro-behavior ที่เกี่ยวข้อง (ต่อ request, ต่อ task)
2. ระบุกลไกรวม (queue, contention, feedback)
3. จำลอง/คำนวณผลรวม เทียบกับจริง
4. หาจุด micro ที่ขยับแล้ว macro เปลี่ยนมากสุด

## Evidence
- ผลรวมที่คำนวณเทียบกับจริง
- จุดคุม macro ถูกระบุพร้อมเหตุผล

## Anti-patterns
- สรุป macro จาก micro ตัวอย่างเดียว (ต้องผ่านกลไกรวม)
- ละเลย feedback ที่เกิดตอนรวม
