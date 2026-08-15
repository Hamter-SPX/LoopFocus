# Failure Interaction Analysis

## What
failure A และ B แยกกันรับมือได้ แต่เกิดพร้อมกันแล้วระบบพัง — วิเคราะห์ combination แบบนี้

## Why
ระบบถูกออกแบบรับมือ failure ทีละตัว ความพังครั้งใหญ่เกือบทุกครั้งคือ failure หลายตัวชนกัน การวิเคราะห์ combination คือการหาจุดที่ "ทีละตัว OK" กลายเป็น "พร้อมกันพัง"

## When
ประเมิน resilience และหลัง incident ที่เกิดจากหลายสาเหตุร่วม

## Protocol
1. ระบุ failure modes ที่รู้จัก
2. จับคู่/รวมกลุ่ม: อะไรจะเกิดถ้า A+B พร้อมกัน? A ระหว่าง B กำลัง recover?
3. หา shared dependency ที่ทำให้เกิดพร้อมกันได้ (Correlated Failure)
4. combination ที่พัง → เสนอ independent recovery path

## Evidence
- combination ที่พังถูกทดสอบ/จำลอง
- shared cause ถูกระบุ

## Anti-patterns
- ประเมิน resilience ทีละ failure
- มองข้ามว่า failure มักเกิดพร้อมกันเมื่อ share สาเหตุ
