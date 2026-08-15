# Information Contamination Detection

## What
รู้ว่าหลักฐานหลายแหล่งอาจมาจากต้นทางเดียวกัน — ผ่านการ copy, quote, หรือการใช้ข้อมูลร่วมกันแบบไม่รู้ตัว

## Why
contamination ทำให้หลักฐานดูอิสระทั้งที่ไม่ใช่ — ข้อสรุปที่ "หลายแหล่งยืนยัน" จริงๆ แล้วคือเสียงเดียวสะท้อน การ detect คือการป้องกัน confidence ปลอม

## When
รวมหลักฐานจากหลายแหล่ง (คู่กับ Evidence Independence Detection)

## Protocol
1. ไล่ที่มาของแต่ละแหล่ง (Provenance)
2. หา overlap: แหล่งไหน quote/copy/derive จากแหล่งไหน
3. ทำเครื่องหมาย contaminated cluster = 1 หลักฐานจริง
4. ข้อสรุปใช้จำนวน cluster ไม่ใช่จำนวนเอกสาร

## Evidence
- cluster ของแหล่งที่ปนกันถูกระบุ
- การนับหลักฐานใช้ cluster

## Anti-patterns
- นับเอกสารเป็นหลักฐานอิสระ
- ไม่ไล่ที่มาของแหล่งที่ "ดูอิสระ"
