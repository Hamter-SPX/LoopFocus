# Complexity Awareness

## What
รู้ว่าปัญหาบางแบบโตแบบ polynomial/exponential — และ architecture ที่ดูดีตอนเล็กอาจใช้ไม่ได้ตอน scale เพราะ complexity ไม่ใช่ linear

## Why
algorithm ที่เร็วกับ n=100 อาจตายกับ n=1M (O(n^2) vs O(n log n)) การรู้ complexity คือการรู้ว่าระบบจะไปตายที่ scale ไหน — ก่อนที่จะไปถึง

## When
เลือก algorithm/design และประเมิน scale ในอนาคต

## Protocol
1. ระบุ complexity ของส่วนสำคัญ (big-O, จริง ไม่ใช่ทฤษฎีสวย)
2. เทียบกับ scale ที่จะถึง (n เป้าหมาย × การเติบโต)
3. หาจุดที่ complexity จะฆ่า performance (Scale Transition)
4. เลือก design ที่รอดที่ scale เป้าหมาย (หรือระบุว่าต้องเปลี่ยนเมื่อไร)

## Evidence
- complexity ถูกวิเคราะห์จากโค้ดจริง
- จุดตายถูกคำนวณ

## Anti-patterns
- เลือก algorithm จาก performance ที่ n เล็ก
- ไม่รู้ complexity ของโค้ดตัวเอง
