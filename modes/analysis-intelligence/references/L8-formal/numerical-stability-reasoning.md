# Numerical Stability Reasoning

## What
วิเคราะห์ว่า computation ไหนอาจถูก error เล็กๆ สะสมจนผลผิด — และปรับ algorithm ให้ทนต่อการปัดเศษ

## Why
การคำนวณเชิงตัวเลขมีกับดัก: ลบเลขใกล้กัน, บวกเลขเล็กกับใหญ่, ทำซ้ำล้านครั้ง — error เล็กสะสมเป็นผลผิด การวิเคราะห์ stability คือการกันไม่ให้ "logic ถูกแต่คำตอบผิด"

## When
code ที่คำนวณ float, summation ใหญ่, iteration มาก, matrix

## Protocol
1. ระบุจุดที่ error เข้า/ขยาย (การลบใกล้กัน, การสะสม, ill-conditioned)
2. ประเมินว่า error โตแค่ไหน (forward/backward error)
3. ใช้ algorithm ที่ stable กว่า (จัดลำดับใหม่, compensated sum, แก้ formulation)
4. ทดสอบกับ input ที่ไวต่อ error

## Evidence
- จุดขยาย error ถูกระบุ
- การทดสอบ input ไวถูกทำ

## Anti-patterns
- เชื่อผล float โดยไม่วิเคราะห์ stability
- "logic ถูก" = คิดว่าคำตอบถูก (ตัวเลขก็พังได้)
