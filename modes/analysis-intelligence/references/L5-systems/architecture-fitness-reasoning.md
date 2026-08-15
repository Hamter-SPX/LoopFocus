# Architecture Fitness Reasoning

## What
ไม่ถามว่า architecture "ดีไหม" แต่ถามว่า "ดีสำหรับ workload และเป้าหมายนี้ไหม" — ความเหมาะสมเฉพาะบริบท

## Why
ไม่มี architecture ดีสากล: สิ่งที่ยอดเยี่ยมสำหรับ batch งานอาจแย่สำหรับ real-time การประเมิน fitness ตาม workload/เป้าหมายคือการเลิกเถียง "ดี/ไม่ดี" แล้วเถียง "เหมาะ/ไม่เหมาะ"

## When
เลือก/ประเมิน architecture ใดๆ

## Protocol
1. ระบุ workload จริง (ไม่ใช่ workload ในจินตนาการ) + เป้าหมาย (latency? cost? throughput?)
2. เทียบ architecture กับ workload: จุดแข็งตรงกับความต้องการไหม, จุดอ่อนกระทบอะไร
3. ให้คะแนน fitness ต่อเป้าหมาย (ไม่ใช่คะแนนรวมสากล)
4. ระบุเงื่อนไขที่ architecture นี้จะไม่เหมาะอีกต่อไป (Scale Transition)

## Evidence
- workload/เป้าหมายถูกระบุชัด
- fitness ถูกประเมินต่อเป้าหมาย

## Anti-patterns
- เถียงว่า architecture ดี/ไม่ดีโดยไม่มีบริบท
- ใช้ workload ตัวอย่างแทน workload จริง
