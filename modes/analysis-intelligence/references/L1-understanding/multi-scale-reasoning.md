# Multi-Scale Reasoning

## What
วิเคราะห์ phenomenon เดียวกันหลาย scale พร้อมกัน — micro (คำสั่ง/เส้น), meso (service), macro (cluster/องค์กร)

## Why
กฎที่ต่าง scale มักต่างกัน: สิ่งที่จริงใน micro อาจไม่จริงใน macro (และกลับกัน — Simpson's paradox) การเห็นหลาย scale ป้องกันข้อสรุปที่จริงแค่ระดับเดียว

## When
ข้อสรุปต้องใช้ข้ามระดับ หรือข้อมูลหลายระดับดูขัดกัน

## Protocol
1. วิเคราะห์ phenomenon ในแต่ละ scale แยกกัน
2. เทียบข้อสรุประหว่าง scale — ต่างกันคือ signal สำคัญ
3. หาเหตุผลว่าทำไม scale เปลี่ยนข้อสรุป
4. ข้อสรุปสุดท้ายระบุว่า valid ใน scale ไหน

## Evidence
- แต่ละ scale วิเคราะห์ด้วยข้อมูลของ scale นั้น
- จุดที่ข้อสรุปขัดข้าม scale ถูกบันทึก

## Anti-patterns
- ใช้กฎ micro อธิบาย macro ตรงๆ
- เฉลี่ยข้อสรุปข้าม scale ที่ขัดกัน
