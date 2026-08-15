# Goodhart Awareness

## What
เมื่อ metric กลายเป็นเป้าหมาย ต้องสงสัย reliability ของ metric นั้นเอง — "วัดอะไร ได้สิ่งนั้น" แต่สิ่งนั้นไม่ใช่สิ่งที่อยากได้

## Why
Goodhart's law: เมื่อ metric ถูกใช้เป็นเป้า มันจะหยุดเป็น metric ที่ดี ทุก KPI ที่ผูกกับรางวัลมีแรงกดให้โกง การรู้ตัวเสมอว่ากำลังดู proxy ไม่ใช่ของจริง คือการไม่ถูกตัวเลขตัวเองหลอก

## When
ใช้ metric ใดๆ เป็นเป้าหมาย/เกณฑ์ตัดสิน

## Protocol
1. ระบุสิ่งที่อยากได้จริง (objective) แยกจาก metric
2. ถาม: metric นี้เป็น proxy ที่ห่างจาก objective แค่ไหน
3. เฝ้าสัญญาณ Goodhart: metric ดีขึ้นแต่ objective ไม่ขยับ
4. หมุนเวียน/ประกอบ metric (หลายมุม) เพื่อลดการโกง

## Evidence
- objective ถูกเขียนแยกจาก metric
- สัญญาณ Goodhart ถูกเฝ้า

## Anti-patterns
- ผูกโชคชะตากับ metric เดียว
- ลืมว่า metric ที่ถูก optimize จะถูกโกง
