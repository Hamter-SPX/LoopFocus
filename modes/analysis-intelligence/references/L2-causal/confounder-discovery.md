# Confounder Discovery

## What
หา third variable ที่ทำให้คิดว่า A→B ทั้งที่จริงไม่ใช่ — ตัวแปรที่ผลักทั้ง A และ B พร้อมกัน

## Why
confounder คือกับดักอันดับหนึ่งของ causal reasoning: เห็น A กับ B ไปด้วยกันแล้วสรุปผิด การหา confounder อย่างจริงจังคือการป้องกันข้อสรุปผิดชนิดที่แพงที่สุด

## When
ทุกครั้งที่เสนอความสัมพันธ์เชิงสาเหตุจากข้อมูล observational

## Protocol
1. ตั้งคำถาม: มีตัวแปรไหนที่ผลักทั้ง A และ B ไหม? (เวลา, ขนาด, นโยบาย, สภาพแวดล้อม)
2. ตรวจข้อมูล: ควบคุม confounder แล้วความสัมพันธ์ยังอยู่ไหม?
3. หา confounder ที่ยังไม่วัด (latent) — ระบุเป็น UNKNOWN
4. สรุปเฉพาะหลัง confounder ที่รู้จักถูกตัดออก

## Evidence
- confounder ที่รู้จักถูกตรวจ/ควบคุม
- latent confounder ถูกระบุ

## Anti-patterns
- สรุป causal โดยไม่หาคู่แข่ง
- "ไม่มี confounder" โดยไม่ได้หา
