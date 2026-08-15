# Telemetry Truth Assessment

## What
log/metric/trace ไม่ถูกถือเป็น truth อัตโนมัติ — ประเมิน instrumentation coverage และ measurement bias ด้วย

## Why
telemetry คือภาพที่ระบบเลือกถ่ายตัวเอง: ไม่ได้เก็บทุกอย่าง, เก็บมุมที่ผู้สร้างสนใจ, บางทีเก็บผิด การเชื่อมันเป็นความจริงคือการวิเคราะห์เงาแทนตัวจริง

## When
ใช้ metric/log ใดๆ เป็นหลักฐานในข้อสรุป

## Protocol
1. ถาม: metric นี้เก็บอย่างไร, ครอบคลุมแค่ไหน, อะไรไม่ถูกเก็บ (Missing Telemetry)
2. หา bias: เก็บเฉพาะ path ที่ง่าย, sampling เบ้, การรวมที่ซ่อนความต่าง
3. ระบุระดับความเชื่อใน metric นี้ (ไม่ได้แปลว่าใช้ไม่ได้ — แต่ใช้ด้วยขอบเขต)
4. metric สำคัญที่ bias มาก → เสนอการเก็บเพิ่ม (Optimal Instrumentation)

## Evidence
- coverage/bias ของ metric ถูกบันทึก
- ข้อสรุประบุขอบเขตความเชื่อ

## Anti-patterns
- ใช้ metric เป็นความจริงโดยไม่ถามว่าเก็บมาอย่างไร
- เชื่อ "ไม่มีข้อมูลนี้" ว่าหมายถึงไม่มีเหตุการณ์ (Negative Evidence)
