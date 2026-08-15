# Implicit Contract Discovery

## What
หา contract ที่ไม่มีใน spec แต่ระบบถือเป็นจริง: ordering, timing, ownership, initialization assumptions

## Why
บั๊กระดับลึกส่วนใหญ่คือ implicit contract ที่ถูกทำลายโดยคนที่ไม่รู้ว่ามันมีอยู่ การทำให้มัน explicit คือการป้องกันชั้นแรก

## When
ระหว่าง interface/component analysis ทุกครั้ง

## Protocol
1. หา assumption ที่แต่ละฝั่งใช้กับอีกฝั่งโดยไม่เคยตกลงกัน (Latent Dependency Mining)
2. เขียน implicit contract ออกมาเป็นข้อความชัด
3. ระบุจุดที่ละเมิดได้/ละเมิดแล้ว
4. เสนอให้กลายเป็น explicit (test, doc, assertion)

## Evidence
- contract ที่พบมีร่องรอยในโค้ด/พฤติกรรม
- จุดเสี่ยงถูกระบุ

## Anti-patterns
- เก็บไว้ในหัวว่า "รู้อยู่แล้ว" (implicit ที่ไม่ถูกเขียนจะพังอีก)
- พบแล้วไม่เสนอให้ explicit
