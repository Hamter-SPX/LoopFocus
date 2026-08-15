# Deep Uncertainty Reasoning

## What
จัดการโจทย์ที่แม้ probability ก็ไม่สามารถประเมินได้ดี — ไม่รู้ทั้งผลลัพธ์ที่เป็นไปได้และโอกาสของมัน

## Why
บางโจทย์เกินกว่า probability: เหตุการณ์ที่ไม่เคยเกิด, โลกที่เปลี่ยนเชิงโครงสร้าง การแสร้งว่าประเมิน probability ได้คือการสร้างตัวเลขปลอม การ reasoning ภายใต้ deep uncertainty ต้องใช้วิธีอื่น (robustness, minimax, scenarios)

## When
โจทย์ที่ไม่มีข้อมูลประวัติเพียงพอหรือโลกกำลังเปลี่ยนเชิงโครงสร้าง

## Protocol
1. ยอมรับว่า probability ประเมินไม่ได้ (ไม่ฝืนสร้างตัวเลข)
2. ใช้วิธีสำหรับ deep uncertainty: scenario analysis, minimax regret, robust decision
3. หาทางที่ยังดีในหลายโลกที่ "นึกออก" + เผื่อโลกที่นึกไม่ออก (Unknown-Unknown)
4. ระบุว่านี่คือ deep uncertainty — ไม่ใช่ risk ที่วัดได้

## Evidence
- การไม่ประเมิน probability ถูกระบุอย่างมีเหตุผล
- วิธีทางเลือกถูกใช้

## Anti-patterns
- สร้าง probability ปลอมในโจทย์ deep uncertainty
- ใช้เครื่องมือ risk ธรรมดากับปัญหาที่ไม่ใช่ risk ธรรมดา
