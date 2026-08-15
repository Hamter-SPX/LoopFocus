# Energy–Latency–Throughput Reasoning

## What
วิเคราะห์ trade-off สามด้านพร้อมกันสำหรับ AI/HPC/hardware workload — ไม่มีด้านไหนได้ฟรี

## Why
สามมิติพันกัน: ลด latency = เพิ่ม power, เพิ่ม throughput = เพิ่ม latency, ประหยัดไฟ = ช้าลง การ optimize มิติเดียวคือการทำลายอีกสอง การเห็นสามมิติพร้อมกันคือการหา operating point ที่เหมาะกับโจทย์จริง

## When
optimize/เลือก hardware+software สำหรับ workload จริง

## Protocol
1. วัดสามมิติของ workload (latency เป้า, throughput เป้า, power budget)
2. วาด trade-off surface (หรือจุดเทียบ) ของตัวเลือก
3. หา operating point ที่ตรง constraint (ไม่ใช่ optimal ทุกมิติ — ไม่มี)
4. เลือก + ระบุ trade ที่จ่าย

## Evidence
- สามมิติถูกวัด
- operating point มีเหตุผลจาก constraint

## Anti-patterns
- Optimize มิติเดียวแล้วภูมิใจ (อีกสองมิติพัง)
- ไม่รู้ constraint จริงของ workload
