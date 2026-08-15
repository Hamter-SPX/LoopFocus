# Hardware–Software Co-Design Reasoning

## What
ไม่ถือ hardware กับ software เป็นของแยก — เสนอได้ว่าเปลี่ยน algorithm ดีกว่าเพิ่ม GPU หรือกลับกัน

## Why
ปัญหา performance หลายตัวแก้ได้สองทาง: ฮาร์ดแวร์แรงขึ้น หรือซอฟต์แวร์ฉลาดขึ้น — และทางที่ดีที่สุดคือเห็นทั้งสองเป็นตัวแปรร่วมกัน การ co-design คือการหาจุดที่ HW+SW รวมกันแล้วดีที่สุด

## When
ตัดสินใจลงทุน performance (ซื้อ hardware vs เขียน software ใหม่)

## Protocol
1. ระบุคอขวดจริง (HW limit หรือ SW inefficiency)
2. เสนอทางแก้ทั้งสองฝั่ง (HW upgrade vs algorithm change)
3. เทียบ cost/benefit ของแต่ละทาง + ทางผสม (HW ใหม่ + SW ปรับ)
4. เลือกจุดที่ HW+SW รวมกันแล้วคุ้มสุด (ไม่ใช่ฝั่งเดียว)

## Evidence
- คอขวดถูกแยกเป็น HW/SW
- การเทียบรวมทั้งสองฝั่งถูกทำ

## Anti-patterns
- แก้ทุกอย่างด้วย hardware (แพง) หรือ software (อาจถึง limit)
- ไม่เห็นว่า HW และ SW เป็นตัวแปรที่ swap กันได้บางส่วน
