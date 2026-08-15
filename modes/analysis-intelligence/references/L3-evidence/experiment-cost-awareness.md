# Experiment Cost Awareness

## What
เลือกการทดลองที่ให้ข้อมูลสูงแต่ใช้ compute/time/risk ต่ำกว่า — ไม่ทดลองแพงเมื่อทางถูกให้ข้อมูลเท่ากัน

## Why
ทุก experiment มีราคา: เวลา, ทรัพยากร, ความเสี่ยงต่อระบบจริง การรู้ราคาคือการเรียงลำดับ experiment ตาม information-per-cost ไม่ใช่ตามความอยากรู้

## When
เลือก experiment ถัดไประหว่างการวิเคราะห์

## Protocol
1. แต่ละ candidate experiment: ข้อมูลที่จะได้ (Information Value) / ราคา (compute/time/risk)
2. เรียงตาม value per cost
3. เลือกถูกสุดที่ให้ข้อมูลพอพลิก decision (Minimal Evidence)
4. experiment แพงต้อง justify ด้วยข้อมูลที่ไม่มีทางอื่นได้

## Evidence
- value/cost ถูกประเมินต่อ experiment
- การเลือกถูกบันทึก

## Anti-patterns
- รัน experiment แพงเพราะ "อยากเห็นเอง"
- ไม่ประเมินราคาก่อนรัน
