# LoopFocus

> LoopFocus คือวินัยควบคุม execution สำหรับ agent — ทุกรอบการทำงาน (loop) ต้องมีเหตุผล มีสถานะ มี feedback และต้อง converge เข้าเป้าหมาย วนจน token หมดคือความล้มเหลว วนจนถึงเป้าหมายคือความสำเร็จ

**LoopFocus ทำให้ agent ตัวไหนก็ได้ (แพงหรือถูก) โฟกัสงานจริง**: ขุด root cause แทนที่จะ patch อาการ, เจอทุกจุดที่ควรปรับปรุงรวมจุดเสี่ยงต่ำและ security, ไม่มโนคำตอบ, บันทึกทุกความพยายามลง genome ที่เครื่องอ่านได้, และยืนยันความเสร็จด้วยหลักฐานที่วัดได้ — ข้าม context reset, crash และการส่งต่อได้

## ข้างในมีอะไร

| ชั้น | เนื้อหา |
|---|---|
| **วินัย** (SKILL.md + 62 references) | Focus State Machine, 5 Hard Rules, Gate Engine (26 gates), 61 ระบบเป็นไฟล์ลึก, 6 flows |
| **โหมด** (8) | analysis-intelligence · debug · build · security · review · recover · ship · author-skill — พร้อมสัญญาที่ตรวจด้วยเครื่อง |
| **Tools** (30) | CLI รวมคำสั่ง + mode engine, gates, loop intelligence (convergence/fingerprint/entropy), Loop Genome, Signal Normalizer, planning (DoD/predictive/critical-path), ToolBus (CI/Docker/Playwright/OTel), lifecycle (init/handoff/distill), self-audit |
| **Templates + Schemas** | state / ledger / DoD templates, signal / gate / genome schemas |
| **CI** | GitHub Actions จริง (conformance + 9 test suites + secret scan) + CI templates ให้โปรเจกต์ผู้ใช้ |

## ติดตั้ง

```bash
mkdir -p ~/.config/opencode/skills/LoopFocus ~/.agents/skills/LoopFocus
cp -R SKILL.md references flow schemas templates prompts scripts ~/.config/opencode/skills/LoopFocus/
cp -R SKILL.md references flow schemas templates prompts scripts ~/.agents/skills/LoopFocus/
```

หรือ clone ไปไว้ที่ไหนก็ได้แล้วชี้ runtime ไปที่โฟลเดอร์

## เริ่มใช้ใน 60 วินาที

```bash
cd your-project
loopfocus init            # สร้าง .loopfocus/ + ตรวจเจอ tools ของโปรเจกต์
loopfocus mode resolve "แก้บัคหน้า login ค้าง"   # เลือกโหมดอัตโนมัติ
# แก้ .loopfocus/state.md — ล็อก goal + invariants
loopfocus fast            # build → static → test หยุดที่เจอ fail แรก
loopfocus converge --sequence 18,11,6,4,3     # loop กำลัง converge จริงไหม?
loopfocus genome record --class login-hang --strategy dep-inspect --result success --delta 1 --reason "เจอ loop"
loopfocus verify          # completion gate — ผ่านเท่านั้นถึงเคลมว่าเสร็จ
loopfocus handoff "ทำ migration ต่อ"          # หรือส่งต่องานให้คนอื่น
```

Agent ก็เดินทางเดียวกันจากในสกิล: LOCK → EXPLORE → HYPOTHESIZE → EXECUTE → OBSERVE → MEASURE — ทุก transition ผ่าน gate ทุก attempt ถูกบันทึก

## กฎเหล็ก 5 ข้อ

1. ห้ามทำวิธีที่ล้มแล้วซ้ำโดยไม่มีหลักฐานใหม่
2. ห้ามขยายขอบเขตงานโดยไม่โยงกับเป้าหมายหลัก
3. ห้ามทิ้งสถานะที่ผ่านแล้วโดยไม่มีจุดย้อนกลับ
4. ห้ามเคลมความคืบหน้าโดยไม่มีตัวเลขที่วัดได้
5. ห้ามประกาศเสร็จขณะที่ยังมี blocker ที่รู้อยู่

## เอกสาร

- `PLAYBOOKS.md` — ทางลัดที่สั้นที่สุดต่อคำขอทั่วไป
- `GOLDEN_PATH.md` — ตัวอย่างจบ 1 งานผ่านทุก gate
- `ARCHITECTURE.md` — การประกอบกันของชั้นวินัย
- `flow/README.md` — เลือก flow: แก้บัค, สร้างฟีเจอร์, สแกน security, รีวิว, กู้คืน
- `references/` — ระบบละไฟล์ลึก (What/Why/When/Protocol/Evidence gates/Machine check/Anti-patterns/Example)
- `SUPERPOWERS_ADAPTATION_MATRIX.md` — เทียบกับวินัย agentic ที่มีอยู่
- `VALIDATION_REPORT.json` — หลักฐานการทดสอบของสกิลนี้

## License

MIT — ดู `LICENSE`
