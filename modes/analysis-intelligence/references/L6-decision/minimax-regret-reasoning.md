# Minimax Regret Reasoning

## What
สำหรับ uncertainty สูง — เลือกทางที่ลดความเสียใจสูงสุดในกรณีที่คาดผิด (ไม่ใช่ทางที่หวังผลดีสุด)

## Why
เมื่อไม่รู้ว่าอนาคตไหนจะเกิด การ maximize กำไรที่คาดไว้คือการเดิมพัน การ minimize regret สูงสุดคือการกันหายนะ — เหมาะกับ decision ที่พลาดแล้วแพง

## When
decision ภายใต้ deep uncertainty (probability ประเมินไม่ได้ดี)

## Protocol
1. ระบุ scenarios ที่เป็นไปได้ทั้งหมด (รวมตัวร้าย)
2. แต่ละทางเลือก: ถ้า scenario นั้นเกิด เราจะเสียใจแค่ไหน (ผลต่างจากทางที่ดีที่สุดใน scenario นั้น)
3. หาทางที่ regret สูงสุดต่ำที่สุด (minimax regret)
4. เลือกทางนั้น — มันคือทางที่ "ไม่มี scenario ไหนหายนะเกินรับ"

## Evidence
- scenarios ถูกระบุครบ
- regret ถูกคำนวณต่อ scenario

## Anti-patterns
- ใช้ minimax กับ decision ที่พลาดแล้วไม่แพง (ควร maximize expected value แทน)
- มองข้าม scenario ร้ายเพราะ "ไม่น่าเกิด"
