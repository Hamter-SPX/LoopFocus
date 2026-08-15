# Organizational Bottleneck Detection

## What
technical system ดีแค่ไหนก็ช้าได้เพราะ approval/ownership/communication — หาจุดคอขวดขององค์กร

## Why
คอขวดของงานจริงมักไม่ใช่โค้ด: รออนุมัติ, ownership ไม่ชัด, ข้อมูลไม่ไหลข้ามทีม การ detect จุดเหล่านี้คือการเห็นระบบจริงของงาน — ไม่ใช่แค่ระบบของซอฟต์แวร์

## When
เมื่อ throughput ของงานต่ำทั้งที่ technical ไม่ตัน

## Protocol
1. ไล่ flow ของงานจริง (ไอเดีย → ทำ → รีวิว → ปล่อย)
2. หาจุดรอ/จุดซ้ำ/จุดที่ไม่ชัดเจนใน flow (ค่าใช้จ่ายเวลาแต่ละจุด)
3. ระบุ bottleneck: จุดที่งานกอง (approval? handoff? unclear owner?)
4. เสนอแก้ที่ process (ไม่ใช่เพิ่มคน — บ่อยครั้งยิ่งแย่)

## Evidence
- flow ถูกไล่พร้อมเวลาจริง
- จุดกองถูกระบุ

## Anti-patterns
- แก้ organizational bottleneck ด้วย technical tool (เพิ่ม tool กับ process พัง = พังหนักกว่าเดิม)
- โทษคนแทนการดู flow
