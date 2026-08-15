# Specification Mining

## What
ไม่มี spec — สกัด behavioral specification จาก execution, history, tests

## Why
พฤติกรรมจริงคือ spec ที่แท้จริงของระบบเก่า สกัดออกมาได้ก็ตรวจย้อนหลังได้ว่าระบบ "ควร" ทำอะไร

## When
ก่อนแก้/ย้ายระบบที่ไม่มีเอกสาร

## Protocol
1. เก็บ traces/executions หลากหลาย scenario
2. สกัด invariants ที่ถือจริงในทุก trace (Invariant Discovery)
3. เขียนเป็น behavioral spec (states + transitions + rules)
4. ใช้ spec ตรวจการเปลี่ยนแปลง (Semantic Regression Detection)

## Evidence
- spec สกัดจาก traces จริง ไม่ใช่จินตนาการ
- ทุก invariant มี trace อ้างอิง

## Anti-patterns
- สกัด spec จากตัวอย่างเดียว
- เก็บ invariant ที่ขัดกับ trace บางตัวโดยไม่ระบุ
