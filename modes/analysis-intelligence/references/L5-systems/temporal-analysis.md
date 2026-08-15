# Temporal Analysis

## What
วิเคราะห์เหตุการณ์ก่อน/หลัง, trend, regression, state evolution — มิติเวลาของระบบ

## Why
ระบบส่วนใหญ่ถูกเข้าใจผิดเพราะมอง snapshot เดียว: trend บอกทิศทาง, ก่อน/หลังบอกผลของการเปลี่ยน, state evolution บอกกลไก การวิเคราะห์เวลาเปิดมิติที่ snapshot ปิด

## When
ทุกครั้งที่มีข้อมูลข้ามช่วงเวลา

## Protocol
1. วางข้อมูลบน timeline (ไม่ใช่ aggregate ทิ้งมิติเวลา)
2. วิเคราะห์: trend (ทิศทางระยะยาว), seasonality, จุดเปลี่ยน (ก่อน/หลังเหตุการณ์)
3. เชื่อมจุดเปลี่ยนกับเหตุการณ์ (Intervention Effect)
4. สรุปพร้อมช่วงเวลาที่ valid (Temporal Validity)

## Evidence
- ข้อมูลถูกวางบน timeline
- จุดเปลี่ยนถูกเชื่อมกับเหตุการณ์

## Anti-patterns
- รวมข้อมูลข้ามช่วงที่ regime ต่างกัน (เฉลี่ยคนละโลก)
- วิเคราะห์ snapshot เดียวแล้วสรุป trend
