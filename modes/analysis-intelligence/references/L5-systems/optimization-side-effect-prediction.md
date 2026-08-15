# Optimization Side-Effect Prediction

## What
ปรับ performance จุดหนึ่งแล้วรู้ว่า cost/latency/memory/reliability จุดอื่นจะเสียอะไร — ก่อนที่จะปรับ

## Why
ทุก optimization มีราคา: เร็วขึ้นด้วย cache = memory เพิ่ม, เร็วขึ้นด้วย parallel = reliability ลด การรู้ราคาล่วงหน้าคือการ optimize อย่างมีสติ ไม่ใช่ชนะจุดเดียวแล้วแพ้ทั้งระบบ

## When
ก่อนทุกการ optimize ที่ไม่ใช่ trivial

## Protocol
1. ระบุสิ่งที่ optimize จะได้ (metric เป้า)
2. ไล่ผลข้างเคียงผ่าน dependency/resource: อะไรจะแพงขึ้น (memory, complexity, failure modes)
3. quantify ผลข้างเคียงถ้าทำได้ (เท่าไร)
4. ชั่ง: กำไรที่เป้า vs ราคาข้างเคียง — บันทึก trade-off

## Evidence
- ผลข้างเคียงถูกระบุเป็นรายการ
- การชั่งถูกบันทึก

## Anti-patterns
- optimize metric เดียวแล้วภูมิใจ (Goodhart)
- ไม่ไล่ผลข้างเคียงก่อนปรับ
