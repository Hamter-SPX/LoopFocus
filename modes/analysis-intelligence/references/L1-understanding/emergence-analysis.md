# Emergence Analysis

## What
อธิบายพฤติกรรมที่ไม่ได้เกิดจาก component ตัวเดียว แต่เกิดจาก interaction ของหลายส่วนรวมกัน

## Why
Emergent behavior คือจุดที่ระบบ "หลอก": ทุก component ถูกหมดแต่ระบบรวมพัง — หรือกลับกัน การมองหา emergence คือการมองระดับระบบ ไม่ใช่ระดับชิ้นส่วน

## When
เมื่อพฤติกรรมรวมไม่ตรงผลรวมของชิ้นส่วน หรือพังโดยไม่มีใครผิดเดี่ยวๆ

## Protocol
1. ระบุพฤติกรรมรวมที่ไม่สามารถอธิบายจาก component เดียว
2. หา interaction ที่สร้างมัน (feedback, ordering, resource sharing)
3. จำลอง/ทดสอบว่า interaction นั้นอธิบายพฤติกรรมได้จริง
4. บันทึกกลไก emergence ลง model — มันคือส่วนของระบบที่มองไม่เห็นจากโค้ด

## Evidence
- interaction ที่ระบุทดสอบได้
- พฤติกรรมรวมอธิบายจาก interaction ไม่ใช่โทษ component

## Anti-patterns
- โทษ component เดียวกับพฤติกรรมรวม
- อธิบาย emergence โดยไม่ระบุ interaction ที่สร้างมัน
