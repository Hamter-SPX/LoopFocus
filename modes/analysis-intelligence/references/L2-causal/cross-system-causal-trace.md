# Cross-System Causal Trace

## What
ปัญหาที่เริ่มจาก firmware → driver → kernel → runtime → application → user behavior ต้องไล่กลับได้ตลอดสาย

## Why
สาเหตุกับอาการอาจห่างกันหลายระบบและหลายองค์กร การไล่ข้ามระบบคือการเชื่อมจุดที่แต่ละทีมเห็นแค่ส่วนของตน

## When
ปัญหาที่ข้าม boundary: hardware-software, service-to-service, org-to-org

## Protocol
1. ระบุระบบทั้งหมดในสาย (firmware→...→user)
2. ที่แต่ละ boundary: state/ข้อมูลอะไรถูกส่งต่อและเปลี่ยนมือ
3. ไล่จากอาการกลับไปหาต้นทาง ข้าม boundary ทีละจุด
4. จุดที่หลักฐานขาด = UNKNOWN พร้อมวิธีเก็บหลักฐานเพิ่ม

## Evidence
- แต่ละ boundary มีหลักฐานการส่งต่อ
- จุดขาดหลักฐานถูกระบุ

## Anti-patterns
- หยุดไล่ที่ boundary ("ของทีมนั้น")
- กระโดดข้ามระบบโดยไม่มีหลักฐานเชื่อม
