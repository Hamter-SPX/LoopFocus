# Simulation-vs-Reality Gap Analysis

## What
รู้ว่า simulation/test environment ต่างจากโลกจริงตรงไหน — และข้อสรุปจาก sim ใช้กับจริงได้แค่ไหน

## Why
sim ต่างจากจริงเสมอ: load ที่สังเคราะห์, network ที่สมบูรณ์แบบ, data ที่สะอาด ข้อสรุปจาก sim ที่ไม่ระบุ gap คือการย้ายความมั่นใจผิดโลก

## When
ใช้ผลจาก simulation/test env กับข้อสรุปที่เกี่ยวกับ production

## Protocol
1. ระบุความต่าง: workload, latency, failure modes, data, scale
2. แต่ละความต่าง: เปลี่ยนข้อสรุปได้แค่ไหน (Sensitivity)
3. จุดที่ sim เชื่อถือได้ vs เชื่อไม่ได้ถูกแยก
4. ข้อสรุประบุว่า valid ใน env ไหน — และอะไรต้องยืนยันกับของจริง

## Evidence
- ความต่างถูกระบุเป็นรายการ
- ข้อสรุปแยกตาม env

## Anti-patterns
- ย้ายผล sim ไปจริงตรงๆ
- เชื่อ sim ที่ "ผ่านหมด" โดยไม่ถามว่าวัดอะไร
