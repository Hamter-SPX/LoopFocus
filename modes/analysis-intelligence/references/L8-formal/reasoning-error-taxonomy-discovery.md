# Reasoning Error Taxonomy Discovery

## What
สร้างหมวด reasoning mistakes จากพฤติกรรมจริงของ Agent เอง — จำแนกวิธีผิดซ้ำๆ เป็น taxonomy ของตัวเอง

## Why
Agent แต่ละตัวมี pattern ความผิดของมัน (ชอบยึดคำตอบแรก, กลัวสรุป, มองข้ามขอบเขต) การสร้าง taxonomy จากพฤติกรรมจริงคือการรู้จักความผิดของตัวเอง — แล้วกันได้ตรงจุด

## When
ทบทวนความผิดพลาดสะสม (Analysis of Analysis หลายรอบ)

## Protocol
1. รวบรวม reasoning errors ที่เกิด (จาก logs/บทเรียน/การทบทวน)
2. จัดกลุ่มตามชนิด (anchoring, overconfidence, scope miss, evidence อ่อน...)
3. ตั้งชื่อหมวด + สัญญาณเตือนของแต่ละหมวด
4. ใช้ taxonomy ตรวจตัวเองล่วงหน้า (Self-Diagnostic)

## Evidence
- errors ถูกจัดกลุ่มจากข้อมูลจริง
- taxonomy ถูกใช้จริงในการตรวจ

## Anti-patterns
- ทบทวน error ทีละตัวโดยไม่หา pattern
- มี taxonomy แล้วไม่ใช้ตรวจ
