# Critical Parameter Discovery

## What
หา parameter จริงๆ ที่ควบคุม outcome — แทนการเสียเวลาจูนทุกอย่าง

## Why
ระบบซับซ้อนดูเหมือนมีปุ่มเป็นร้อย แต่จริงๆ มี 2-3 ตัวที่คุมผลลัพธ์ การค้นพบ parameter หลักคือการโฟกัส effort ถูกจุด (จูน 3 ตัว แทน 30)

## When
optimize, ปรับจูน, หรืออยากเปลี่ยนพฤติกรรมระบบ

## Protocol
1. รวบรวม parameters ทั้งหมดที่เกี่ยวข้อง
2. วัด sensitivity ของแต่ละตัว (Sensitivity Analysis)
3. ตัวที่คุม outcome มากสุด = critical parameters (มักน้อยตัว)
4. โฟกัส effort ที่ตัวเหล่านั้น — ที่เหลือใช้ค่า default ที่สมเหตุสมผล

## Evidence
- sensitivity ถูกวัด
- critical parameters ถูกระบุพร้อมเหตุผล

## Anti-patterns
- จูนทุกอย่าง (ไม่มีโฟกัส)
- คิดว่า parameter ที่เห็นบ่อย = parameter ที่สำคัญ
