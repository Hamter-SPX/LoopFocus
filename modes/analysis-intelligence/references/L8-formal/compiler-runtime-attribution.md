# Compiler/Runtime Attribution

## What
ประสิทธิภาพหรือ behavior ที่ผิดอาจมาจาก optimizer, runtime, GC, JIT, linker หรือ ABI — ไม่ใช่ source code

## Why
โค้ดไม่ใช่สิ่งที่รัน — สิ่งที่รันคือผลของ compiler/runtime ที่ transform โค้ด การโทษ source code ทั้งที่ตัวการคือ optimizer flag หรือ GC คือการแก้ผิดที่

## When
behavior/performance แปลกที่อธิบายจาก source ไม่ได้

## Protocol
1. ระบุ layer ที่ transform โค้ด (compiler, JIT, GC, runtime, linker)
2. ทดสอบแยก layer: เปลี่ยน flag/version/GC mode → behavior เปลี่ยนไหม
3. ถ้าเปลี่ยน → ตัวการคือ layer นั้น (ไม่ใช่ source)
4. แก้ที่ layer (flag, version, config) หรือเขียน source ใหม่ให้ layer ทำงานถูก

## Evidence
- การทดสอบแยก layer ถูกทำ
- ตัวการถูกระบุด้วยการทดลอง

## Anti-patterns
- โทษ source code ทันทีที่ผลแปลก
- ไม่รู้ว่า compiler/runtime version ไหนที่รันอยู่
