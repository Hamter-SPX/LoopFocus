# Architecture Breakpoint Prediction

## What
คาดการณ์ว่าที่ scale/workload ระดับไหน architecture ต้องเปลี่ยน paradigm — จุดที่ปรับแต่งไม่พอแล้ว

## Why
ทุก architecture มีเพดาน: เกินจุดหนึ่ง การจูนก็แค่ยืดเวลา การรู้ breakpoint ล่วงหน้าคือการรู้ว่าเมื่อไรต้องคิดใหม่ทั้งชุด ไม่ใช่เสียเวลายืดของเก่า

## When
วางแผนระยะยาวของระบบที่กำลังโต

## Protocol
1. ระบุขีดจำกัดเชิงโครงสร้างของ architecture (ผ่าน complexity, consistency, coupling)
2. ประเมินว่า workload จะถึงขีดจำกัดเมื่อไร (แนวโน้มจริง)
3. ทำนาย breakpoint: จุดที่ต้องเปลี่ยน paradigm (ไม่ใช่แค่เพิ่ม node)
4. วางแผน transition ก่อนถึง (Parallel run, migration path)

## Evidence
- ขีดจำกัดเชิงโครงสร้างถูกระบุ
- breakpoint มีการคำนวณแนวโน้ม

## Anti-patterns
- รอให้พังแล้วค่อยเปลี่ยน paradigm
- จูนไปเรื่อยๆ ทั้งที่โครงสร้างถึงเพดานแล้ว
