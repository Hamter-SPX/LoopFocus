# Dependency Graph Intelligence

## What
รู้ว่าอะไรพึ่งอะไร — และเปลี่ยน A แล้ว B/C/D โดนอะไร — จาก graph จริงไม่ใช่จากความจำ

## Why
ทุกการวิเคราะห์ impact ที่ไม่มี graph คือการเดา graph ทำให้ "เปลี่ยนจุดนี้เสี่ยงอะไร" เป็นคำถามที่ตอบด้วยการเดินเส้น ไม่ใช่ความรู้สึก

## When
ก่อนทุกการเปลี่ยนแปลง และเป็นฐานของ L2-L6 ทุกชั้น

## Protocol
1. สร้าง dependency graph จากโค้ด + runtime (import, call, data flow, resource sharing)
2. รวม latent dependency (Latent Dependency Mining)
3. ทุก edge มีชนิด (compile/runtime/data/resource)
4. ใช้ graph ตอบ: fan-out ของ A, fan-in ของ B, เส้นทางที่กระทบ

## Evidence
- graph เป็น artifact ที่อัปเดตได้
- การวิเคราะห์ impact อ้าง graph

## Anti-patterns
- ใช้ความจำแทน graph
- graph ที่ไม่มี latent edges (ครึ่งเดียวของความจริง)
