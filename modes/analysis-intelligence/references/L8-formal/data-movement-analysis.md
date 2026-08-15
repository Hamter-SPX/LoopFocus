# Data-Movement Analysis

## What
สำหรับ AI/hardware — บางระบบ computation ไม่ใช่ตัวแพงที่สุด แต่เป็นการย้ายข้อมูล ต้องตรวจพบได้

## Why
การย้ายข้อมูลแพงกว่า compute ในหลาย workload (GPU ต้องรอข้อมูลจาก CPU/RAM) การ optimize compute ทั้งที่ย้ายข้อมูลคือคอขวด = ไม่ได้อะไร การวิเคราะห์ movement คือการเห็นคอขวดที่แท้จริง

## When
วิเคราะห์ performance ของ AI/hardware/ระบบข้อมูลหนัก

## Protocol
1. ระบุเส้นทางข้อมูลทั้งหมด (ใครส่งให้ใคร ที่ไหน)
2. วัด/ประเมิน cost ของการย้ายแต่ละเส้น (bandwidth, latency, การรอ)
3. เทียบ compute cost กับ movement cost (ตัวไหนใหญ่กว่า = bottleneck)
4. ลด movement (compute ใกล้ data, batch, compression, caching)

## Evidence
- เส้นทางข้อมูลถูกระบุ
- cost เทียบ compute/movement ถูกทำ

## Anti-patterns
- Optimize compute ในระบบที่ movement คือคอขวด
- ไม่วัดว่า data เดินทางเท่าไร
