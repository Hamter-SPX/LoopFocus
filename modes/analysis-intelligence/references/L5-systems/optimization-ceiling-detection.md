# Optimization Ceiling Detection

## What
รู้ว่า architecture ปัจจุบันใกล้เพดานแล้ว — และการจูนต่อไม่คุ้ม

## Why
จุดที่ optimization ยังคุ้มมีขอบเขต: ใกล้เพดานแล้ว effort เพิ่มขึ้นแต่ผลน้อยลงเรื่อยๆ (diminishing returns) การรู้ว่าเมื่อไรหยุดจูน = การไม่เผา effort กับกำไรที่ไม่มี

## When
ระหว่าง optimize ต่อเนื่อง และเมื่อผลตอบแทนเริ่มลด

## Protocol
1. วัด gain ต่อ effort ในรอบล่าสุด (ไม่ใช่แค่ gain)
2. เทียบกับ ceiling เชิงทฤษฎีของ architecture (ขีดจำกัดพื้นฐาน)
3. gain/effort ต่ำ + ใกล้ ceiling = หยุดจูน
4. เปลี่ยนไป: architecture change (ถ้าต้องการเกิน ceiling) หรือยอมรับจุดนี้

## Evidence
- gain/effort ถูกวัด
- ceiling ถูกประเมินจากพื้นฐาน

## Anti-patterns
- จูนต่อไปเพราะ "น่าจะได้อีกนิด"
- ไม่รู้ว่า ceiling อยู่ไหนแล้วจูนไม่หยุด
