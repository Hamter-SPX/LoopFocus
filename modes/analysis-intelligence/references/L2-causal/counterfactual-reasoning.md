# Counterfactual Reasoning

## What
ตอบคำถาม "ถ้าไม่ทำ X จะเกิดอะไร", "ถ้า X ผิดสมมติฐานล่ะ" — โดยใช้ model ไม่ใช่จินตนาการ

## Why
เราตัดสินใจจากสิ่งที่ทำได้ครั้งเดียว การรู้ว่าเส้นทางอื่นจะให้อะไร (และเส้นทางที่เลือกให้อะไรจริงเทียบกับไม่เลือก) คือการประเมิน decision อย่างตรงไปตรงมา

## When
ประเมินผลของ decision ที่ทำไปแล้ว และก่อนตัดสินใจครั้งสำคัญ

## Protocol
1. ระบุ intervention ที่เกิดขึ้นจริง (หรือจะทำ)
2. สร้างโลกคู่ขนานจาก causal model: ไม่ทำ intervention แล้วผลเป็นอย่างไร
3. เทียบผลจริง vs counterfactual — ส่วนต่างคือผลของ intervention จริง
4. confidence ขึ้นกับความแม่นของ model — ระบุด้วย

## Evidence
- counterfactual มาจาก model ไม่ใช่เดา
- confidence ถูกระบุ

## Anti-patterns
- ใช้ counterfactual สะดวกๆ เพื่อยืนยันสิ่งที่อยากเชื่อ (postdiction)
- ทำนาย counterfactual ด้วยความมั่นใจเกิน model
