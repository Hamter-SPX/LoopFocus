# Correlated Failure Detection

## What
ตรวจว่า redundancy ที่ดูมีหลายชุดจริงๆ พึ่ง power/network/provider/compiler เดียวกันหรือไม่

## Why
redundancy ที่ correlate กันคือ redundancy ปลอม — พังพร้อมกันทั้งที่ดูเหมือนมีสำรอง การตรวจ correlation คือการวัดว่า "สำรอง" จริงแค่ไหน

## When
ประเมินความน่าเชื่อถือของทุกข้ออ้าง redundancy/high-availability

## Protocol
1. ระบุ redundancy ที่ประกาศ (2 nodes, 2 providers, 2 paths)
2. ไล่ dependency ร่วม: power source, network route, cloud region, codebase, human
3. shared dependency ที่พังแล้วพาทุกชุดล้ม = single point ที่ซ่อนอยู่
4. เสนอ independent redundancy ที่แท้จริง

## Evidence
- dependency ร่วมถูกระบุเป็นรายการ
- จุด single point ซ่อนถูกบันทึก

## Anti-patterns
- นับจำนวนชุดสำรอง = ความปลอดภัย
- มองข้าม dependency ที่ "ธรรมดาเกินไป" (ไฟ, เครือข่าย)
