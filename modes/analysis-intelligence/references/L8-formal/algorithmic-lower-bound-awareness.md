# Algorithmic Lower-Bound Awareness

## What
รู้ว่า performance บางอย่างลดต่อไม่ได้เพราะติดข้อจำกัดของปัญหาเอง — มีขอบล่างทางทฤษฎีที่ไม่มี algorithm ไหนฝ่าได้

## Why
การ optimize ที่พยายามฝ่า lower bound คือการไล่ตามสิ่งที่เป็นไปไม่ได้ — เสียแรงไม่รู้จบ การรู้ bound คือการรู้ว่าเมื่อไรหยุด optimize และต้องเปลี่ยนโจทย์/ยอมรับแทน

## When
optimize จนผลเริ่มนิ่ง และเมื่อประเมินว่า "เร็วขึ้นอีกได้ไหม"

## Protocol
1. ระบุ lower bound ของปัญหา (sorting = n log n, บางโจทย์มี bound ต่ำกว่า)
2. เทียบ performance ปัจจุบันกับ bound (ใกล้แค่ไหน)
3. ใกล้ bound แล้ว → optimize ต่อไม่คุ้ม (Optimization Ceiling)
4. ยังไกล → หาว่าทำไม (algorithm ผิด? implementation? measurement?)

## Evidence
- bound ถูกระบุจากทฤษฎี
- ระยะถึง bound ถูกคำนวณ

## Anti-patterns
- พยายามฝ่า lower bound (เป็นไปไม่ได้)
- อ้าง "ติด limit" ทั้งที่ยังห่าง bound มาก
