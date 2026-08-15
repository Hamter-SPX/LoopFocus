# Information-Theoretic Reasoning

## What
ใช้แนวคิด entropy/information gain เพื่อวิเคราะห์ bottleneck หรือ uncertainty — เห็นขีดจำกัดของข้อมูล ไม่ใช่แค่ของเครื่อง

## Why
บาง bottleneck ไม่ใช่ compute แต่เป็นข้อมูล: ไม่ว่าประมวลผลเก่งแค่ไหน ข้อมูลที่มีไม่พอให้ตอบ การใช้ information theory คือการรู้ว่า uncertainty ลดได้แค่ไหนด้วยข้อมูลที่มี — และอะไรคือข้อมูลขั้นต่ำที่ต้องมี

## When
วิเคราะห์ uncertainty/bottleneck ที่เกี่ยวกับข้อมูล

## Protocol
1. ระบุคำถาม + ข้อมูลที่มี (quantify information content)
2. ประเมิน: ข้อมูลที่มีเพียงพอไหม (entropy ของคำตอบเทียบกับข้อมูล)
3. หาข้อมูลขั้นต่ำที่จำเป็น (Information Value)
4. bottleneck ที่ข้อมูลไม่พอ = เพิ่มข้อมูล ไม่ใช่เพิ่ม compute

## Evidence
- information content ถูกประเมิน
- ขั้นต่ำถูกระบุ

## Anti-patterns
- แก้ bottleneck ข้อมูลด้วยการเพิ่ม compute
- ไม่รู้ว่าข้อมูลที่มีตอบคำถามได้แค่ไหน
