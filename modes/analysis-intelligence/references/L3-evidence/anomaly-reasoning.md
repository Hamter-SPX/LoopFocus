# Anomaly Reasoning

## What
เจอสิ่งผิดปกติแล้วหา "ผิดเพราะอะไร" — ไม่ใช่แค่ flag ว่าผิด

## Why
การ flag anomaly ได้ค่าแค่ครึ่งเดียว: รู้ว่าผิดแต่ไม่รู้ทำไม = ยังแก้อะไรไม่ได้ การไล่เหตุของ anomaly คือการเปลี่ยนสัญญาณเป็นความรู้

## When
ทุก anomaly ที่ flag ขึ้น (monitoring, data, behavior)

## Protocol
1. ระบุ anomaly: ผิดจาก baseline แค่ไหน, ช่วงไหน, บริบทอะไร
2. ตั้งสมมติฐานสาเหตุหลายตัว (Hypothesis Engine)
3. หาหลักฐานแยก (อะไรเริ่มก่อน, อะไรเกิดพร้อม, ใครเกี่ยวข้อง)
4. ยืนยันสาเหตุด้วย intervention/prediction แล้วจึงเสนอแก้

## Evidence
- anomaly ถูก quantify (ไม่ใช่ "ดูแปลก")
- สาเหตุมีหลักฐาน

## Anti-patterns
- flag แล้วจบ
- โทษสาเหตุที่คุ้นเคยโดยไม่ไล่หลักฐาน
