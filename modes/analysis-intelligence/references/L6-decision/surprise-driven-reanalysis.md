# Surprise-Driven Reanalysis

## What
ผลจริงที่ผิดจาก prediction มากต้อง trigger การทบทวน world model — ไม่ใช่แค่แก้ตัวเลขแล้วทำต่อ

## Why
surprise = model ผิด (ไม่ใช่ข้อมูลผิดเสมอไป) การแก้แค่ตัวเลขแล้วเดินต่อคือการเก็บ model ที่ผิดไว้ใช้ต่อ การ reanalysis คือการหา assumption ที่พังแล้วซ่อม model — ป้องกันความผิดซ้ำ

## When
ทุกครั้งที่ผลจริงเบี่ยงจาก prediction เกินช่วงที่คาด

## Protocol
1. ระบุ surprise: คาดอะไร เจออะไร ต่างแค่ไหน
2. ไล่ assumption ที่ model ใช้ — ตัวไหนพังทำให้เห็นผลแบบนี้ (Assumption Stress)
3. ซ่อม model ที่จุดพัง (Belief Revision)
4. ทดสอบ model ใหม่กับ prediction ต่อไป

## Evidence
- surprise ถูก quantify
- assumption ที่พังถูกระบุ + model ถูกซ่อม

## Anti-patterns
- อธิบาย surprise ด้วยเหตุผลเฉพาะกิจแล้วจบ
- เก็บ model เดิมทั้งที่ surprise ซ้ำ
