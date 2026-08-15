# Scale Transition Intelligence

## What
architecture ที่ดีสำหรับ 1K users อาจพังตอน 10M — ทำนายจุดที่ design ต้องเปลี่ยน (ไม่ใช่แค่เพิ่มเครื่อง)

## Why
การ scale ไม่ใช่เส้นตรง: แต่ละช่วงขนาดมี architecture ที่เหมาะของมัน และการฝืน architecture เดิมเกินจุด = พังแบบไม่เป็นสัดส่วน การรู้จุดเปลี่ยนคือการเตรียมตัวก่อนถึง

## When
วางแผน growth และประเมินว่า architecture ปัจจุบันไปได้ไกลแค่ไหน

## Protocol
1. ระบุตัวแปรที่ scale (users, data, requests, nodes)
2. วิเคราะห์ว่าแต่ละ component พังที่ scale ไหน (ผ่าน complexity, contention, consistency)
3. หาจุดเปลี่ยน architecture (จุดที่ design ปัจจุบันไม่ยั่งยืน)
4. เตรียม transition plan ก่อนถึงจุด (ไม่ใช่หลังพัง)

## Evidence
- จุดพังของแต่ละ component ถูกประเมิน
- transition point ถูกระบุพร้อมเหตุผล

## Anti-patterns
- คิดว่าเพิ่มเครื่องแก้ทุกอย่าง
- รู้ตัวว่าต้องเปลี่ยน architecture ตอนพังแล้ว
