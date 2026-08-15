# Proof-Oriented Analysis

## What
สำหรับโจทย์ที่ต้องการความแน่นอนสูง — เปลี่ยนจาก probabilistic reasoning ไปสู่ formal reasoning: พิสูจน์แทนการประมาณ

## Why
บางโจทย์ "น่าจะ" ไม่พอ: ความปลอดภัย, เงิน, ระบบที่ผิดครั้งเดียวหายนะ การพิสูจน์อย่าง formal (invariant, type, model checking) ให้ความแน่นอนที่ probability ให้ไม่ได้

## When
ข้อสรุปที่ต้องเป็นจริงเสมอ (ไม่ใช่ส่วนใหญ่)

## Protocol
1. ระบุ property ที่ต้องพิสูจน์ (เขียน formal: ทุก X, ไม่มีทางที่ Y)
2. เลือกเครื่องมือพิสูจน์ (invariant + induction, model checking, type system, formal verification)
3. พิสูจน์ หรือหา counterexample (พิสูจน์ไม่ได้ → รู้ว่าทำไม)
4. ระบุขอบเขตของ proof (valid ภายใต้ assumption อะไร)

## Evidence
- property ถูกเขียน formal
- proof/counterexample ถูกบันทึก

## Anti-patterns
- ใช้ probabilistic reasoning กับ property ที่ต้อง "เสมอ"
- อ้าง "พิสูจน์แล้ว" ทั้งที่ทำแค่ทดสอบ
