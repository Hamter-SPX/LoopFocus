# Memory Hierarchy Intelligence

## What
เข้าใจว่า bottleneck ไม่ได้มีแค่ RAM — รวม cache locality, NUMA, accelerator memory และ movement cost

## Why
performance จริงถูกกำหนดโดย memory hierarchy: ข้อมูลอยู่ไกลจาก compute แค่ไหน หลาย "CPU-bound" จริงๆ คือ cache-miss-bound การเห็น hierarchy คือการ optimize ถูกชั้น

## When
optimize performance ของ workload ที่แตะข้อมูลมาก

## Protocol
1. ระบุว่า data อยู่ชั้นไหน (register/cache/RAM/NUMA-remote/accelerator/disk)
2. วัด movement cost (แต่ละ hop ราคาเท่าไร)
3. หาจุดที่ data ต้องเดินไกล (bottleneck จริง)
4. แก้ที่ locality/reuse (จัด layout, blocking, เก็บใกล้ compute)

## Evidence
- movement cost ถูกวัด/ประเมิน
- จุดเดินไกลถูกระบุ

## Anti-patterns
- Optimize compute ทั้งที่ bottleneck คือ memory
- ไม่รู้ว่า data อยู่ชั้นไหน
