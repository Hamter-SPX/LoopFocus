# Latent Dependency Mining

## What
ค้น dependency ที่ไม่ได้ประกาศ: A ดูเหมือนไม่พึ่ง B แต่พฤติกรรมจริงพึ่ง timing/cache/state ของ B

## Why
Dependency ที่ประกาศตรวจได้ แต่ latent dependency คือเส้นทางพังที่มองไม่เห็น — เปลี่ยน B แล้ว A พังโดยไม่มีใครคาดเดา

## When
ก่อนเปลี่ยนแปลง component ที่ดูเหมือนไม่มีใครใช้ และเมื่ออาการแปลกๆ โผล่หลังการเปลี่ยนที่ไม่ควรกระทบ

## Protocol
1. สังเกต coupling ทางอ้อม: shared cache, timing, global state, resource contention
2. ทดสอบ: เปลี่ยน B แล้วดู A (หรือ simulate)
3. latent dependency ที่เจอ → บันทึกลง dependency graph + เสนอให้ตัดหรือประกาศ

## Evidence
- dependency ที่พบมีพฤติกรรมยืนยัน
- ถูกเพิ่มเข้า graph ไม่ใช่เก็บในหัว

## Anti-patterns
- เชื่อ import graph = dependency ทั้งหมด
- มองข้าม coupling ผ่าน shared resource
