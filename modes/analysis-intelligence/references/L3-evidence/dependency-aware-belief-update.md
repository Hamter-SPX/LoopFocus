# Dependency-aware Belief Update

## What
ไม่ update claim แค่ตัวเดียว — แต่ propagate การเปลี่ยนความเชื่อผ่าน dependency graph ให้ทุกสิ่งที่พึ่งมัน

## Why
ความเชื่อเชื่อมกันเป็น graph: เปลี่ยน A แล้ว B/C ที่ยืนบน A ต้องเปลี่ยนตาม การ propagate คือการรักษาความสอดคล้องของทั้งระบบความเชื่อ ไม่ให้ข้อสรุปเก่าแขวนค้างบนฐานใหม่

## When
ทุกครั้งที่ความเชื่อระดับฐานเปลี่ยน

## Protocol
1. ความเชื่อเปลี่ยน → หา dependents ใน belief graph
2. อัปเดตตามลำดับ dependency (ฐานก่อน ปลายหลัง)
3. dependent ที่อัปเดตแล้วเปลี่ยน conclusion = cascade ที่ต้องรายงาน
4. บันทึกว่าเปลี่ยนอะไรเพราะอะไร (Traceable)

## Evidence
- belief graph ถูกใช้ (ไม่ใช่ไล่จากความจำ)
- cascade ถูกบันทึก

## Anti-patterns
- อัปเดตจุดเดียวแล้วลืม dependents
- ไล่ dependents จากความจำ (ต้อง graph)
