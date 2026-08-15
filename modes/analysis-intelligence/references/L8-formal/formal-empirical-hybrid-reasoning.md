# Formal + Empirical Hybrid Reasoning

## What
สิ่งที่พิสูจน์ formally ได้ก็พิสูจน์ — ส่วนที่พิสูจน์ไม่ได้ใช้ measurement/experiment โดยไม่ปนความมั่นใจของสองแบบ

## Why
ระบบจริงผสมสองส่วน: บาง property พิสูจน์ได้ (algorithm, invariant) บางส่วนต้องวัด (performance, behavior จริง) การปนกัน (อ้างความแน่นอนของ formal กับส่วน empirical) คือความมั่นใจปลอม การแยกสองแบบคือความซื่อสัตย์ต่อธรรมชาติของหลักฐาน

## When
วิเคราะห์ระบบที่มีทั้งส่วนพิสูจน์ได้และส่วนที่ต้องวัด

## Protocol
1. แยกระบบเป็นส่วนที่พิสูจน์ได้ (logic, algorithm) กับส่วนที่ต้องวัด (runtime, environment)
2. ส่วนแรก: พิสูจน์ formal (Proof-Oriented)
3. ส่วนหลัง: วัด/ทดลอง (Empirical) พร้อม confidence แบบสถิติ
4. รวมผลโดยรักษาความต่างของความมั่นใจ (ไม่รายงานเป็นระดับเดียวกัน)

## Evidence
- การแยกส่วนถูกทำ
- ความมั่นใจสองแบบถูกแยกในรายงาน

## Anti-patterns
- อ้าง formal certainty กับผลการวัด
- ใช้ empirical evidence แทน proof ในส่วนที่พิสูจน์ได้
