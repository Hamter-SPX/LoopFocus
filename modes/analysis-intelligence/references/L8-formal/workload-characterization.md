# Workload Characterization

## What
ดู workload แล้วบอกได้ว่ามัน CPU-bound, memory-bound, I/O-bound, synchronization-bound หรือ model-bound — ระบุธรรมชาติของงาน

## Why
optimize โดยไม่รู้ชนิดของ workload = ยิงมั่ว: memory-bound ไปเพิ่ม CPU ไม่ช่วยอะไร การ characterize ก่อนคือการรู้ว่า effort ควรไปทางไหน

## When
ก่อน optimize ใดๆ และเมื่อเลือก hardware/design

## Protocol
1. วัด workload หลายมิติ (CPU, memory, I/O, lock, model compute)
2. หามิติที่อิ่มตัว/ครองเวลา = ชนิดของ workload
3. ตรวจว่าชนิดเปลี่ยนตาม scale ไหม (เล็ก CPU-bound ใหญ่ memory-bound)
4. ใช้ชนิดกำหนดทิศทาง optimize (แต่ละชนิดมี playbook ของมัน)

## Evidence
- หลายมิติถูกวัด
- ชนิดถูกระบุจากข้อมูล

## Anti-patterns
- Optimize โดยไม่รู้ชนิด workload
- characterize ที่ scale เดียวแล้วใช้กับทุก scale
