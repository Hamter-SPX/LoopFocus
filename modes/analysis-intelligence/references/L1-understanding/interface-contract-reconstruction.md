# Interface Contract Reconstruction

## What
จากหลาย component ที่ทำงานร่วมกัน อนุมาน contract ที่พวกมันคาดหวังซึ่งกันและกัน — format, ordering, timing, ownership — แม้ไม่มี spec

## Why
Contract ที่ไม่ได้เขียนคือข้อตกลงที่ถูกทำลายได้โดยไม่มีใครรู้ การ reconstruct มันขึ้นมาทำให้เห็นว่าใครพึ่งอะไรแบบไหน

## When
ระบบ multi-component ที่ไม่มี interface docs หรือ docs drift

## Protocol
1. ดูทุกจุดที่ component สื่อสารกัน (call, message, shared state)
2. อนุมาน contract จากสิ่งที่แต่ละฝั่ง assume (Assumption Mining ที่ boundary)
3. เทียบ contract ที่แต่ละฝั่งถือ — ไม่ตรงกัน = finding
4. เขียน contract ที่ reconstruct เป็นเอกสาร/ทดสอบ

## Evidence
- contract มาจากการอ่านทั้งสองฝั่ง
- จุดที่ contract ไม่ตรงกันถูกบันทึก

## Anti-patterns
- อ่านฝั่งเดียวแล้วสรุป contract
- ไม่เทียบ contract ของทั้งสองฝั่ง
