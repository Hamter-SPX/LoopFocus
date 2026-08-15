# Causal Digital Twin

## What
สร้างแบบจำลองเชิงเหตุผลของระบบจริง แล้วลองเปลี่ยนตัวแปรในแบบจำลองเพื่อคาดการณ์ผลก่อนแตะของจริง

## Why
การทดลองกับระบบจริงแพง/เสี่ยง/ทำไม่ได้ — twin ให้ที่ทดลอง: เปลี่ยน input, ปิด component, โยน load แล้วดูว่า causal graph ทำนายอะไร

## When
ก่อนการเปลี่ยนแปลงที่สำคัญ, ก่อน intervention, เมื่อต้องตอบ "ถ้า...จะเกิดอะไร"

## Protocol
1. สร้าง twin จาก world model + causal graph (Causal Digital Twin = model ที่รันได้)
2. ทดลองใน twin: เปลี่ยนทีละตัวแปร (Counterfactual)
3. เทียบ prediction กับของจริงเมื่อมีโอกาส (Prediction Before Observation)
4. twin ที่ทำนายพลาด → แก้ model ไม่ใช่แค่แก้ผล (Surprise-Driven Reanalysis)

## Evidence
- prediction ถูกบันทึกก่อนเทียบจริง
- twin อัปเดตตามผลจริง

## Anti-patterns
- ใช้ twin โดยไม่เคยเทียบกับจริง
- แก้ prediction โดยไม่แก้ model
