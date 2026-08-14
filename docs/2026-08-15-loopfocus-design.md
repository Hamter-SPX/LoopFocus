# LoopFocus — Design Spec v1

วันที่: 2026-08-15
สถานะ: Draft v1 (ยังมีระบบเพิ่มเติมจากเจ้าของโปรเจกต์ในภายหลัง)
รูปแบบ: Agent Skill มาตรฐาน (agentskills.io) ใช้ข้าม runtime ได้ (CLI / IDE / Chat)

---

## 1. วิสัยทัศน์ (Vision)

### Identity

> **LoopFocus = ระบบควบคุม execution ของ Agent ที่ทำให้ทุก loop มีเหตุผล มีสถานะ มี feedback และต้อง converge เข้าหาเป้าหมาย — ไม่ใช่แค่วนจน token หมด**

- ทุก loop ต้องมี **เหตุผล** (ทำไมทำสิ่งนี้ — Hypothesis Ledger, Decision Ledger)
- ทุก loop ต้องมี **สถานะ** (อยู่ตรงไหนของ State Machine — Checkpoint Brain, Recovery Capsule)
- ทุก loop ต้องมี **feedback** (ผลเป็นยังไง วัดได้แค่ไหน — Signal Normalizer, Progress Delta)
- ทุก loop ต้อง **converge** (เข้าใกล้ Goal จริง — Convergence Engine, Oscillation Detector)

LoopFocus คือสกิลวินัย (discipline skill) ที่ทำให้ agent:

- **โฟกัสงานอย่างเดียว** — อยู่กับ repo + Goal จนจบ ไม่หลุดประเด็น ไม่มโน
- **วนลูปขุด root cause** — ไม่หยุดที่อาการ ไม่ retry ซ้ำแบบไร้เหตุผล
- **ช่างสังเกตแบบวิศวกร (SkillFocus)** — เห็นทุกจุดไม่โอเค (ทุก severity รวมจุดเสี่ยงต่ำ) แล้วรายงาน + เสนอวิธีปรับ
- **มีหลักฐานทุกคำตอบ** — ไม่มั่นใจ = self-reject จนกว่าจะตรงประเด็น
- **ทำนายบัคอนาคต** — วิเคราะห์ล่วงหน้าว่าฟีเจอร์ใหม่จะพังจุดไหน แบบมีหลักฐาน ไม่เดา
- **มีหน่วยความจำข้าม context** — resume ได้หลัง crash/reset ไม่เริ่มจากศูนย์

กลุ่มเป้าหมายปัญหา: agent ราคาแพงเก่งแต่ไม่โฟกัส / agent ราคาถูกทำตามคำสั่งทื่อๆ ไม่เจาะโครงสร้าง / agent แก้ตามที่สั่งโดยไม่ตรวจ repo / agent มโนคำตอบ / agent ติด loop retry

---

## 2. โครงสร้างไฟล์

```
LoopFocus/
├── SKILL.md                        # Router กระชับ — Core Laws, layers, modes, red flags, completion contract
├── references/                     # ระบบเชิงลึก 14 ไฟล์ (61 ระบบ จัดตามชั้นวินัย)
│   ├── state-machine.md            #   states, transitions, side-quest, focus depth
│   ├── gate-engine.md              #   26 gates, profiles, DAG, schemas
│   ├── loop-control.md             #   strategy ladder, no-progress tax, oscillation, entropy
│   ├── reasoning-discipline.md     #   hypothesis, confidence, counterfactual, pre-mortem, commitment levels
│   ├── goal-discipline.md          #   goal lock, intent, scope firewall, invariants, minimum intervention
│   ├── progress-discipline.md      #   progress proof/delta, DoD graph, regression sentinel, state integrity
│   ├── state-and-memory.md         #   checkpoints, recovery capsule, branch-and-recover, handoff, genome
│   ├── knowledge-discipline.md     #   half-life, conflict resolver, distillation, objective compression
│   ├── toolbus.md                  #   9 tools + signal normalizer + adaptive CI
│   ├── security-mode.md            #   M3: 7-category checklist, severity taxonomy
│   ├── build-mode.md               #   M4: intent anchor, DoD, slices
│   ├── canvas.md                   #   architecture drawing rules
│   ├── predictive-analysis.md      #   touch map, risk factors, confidence levels
│   └── verification-and-claim-governance.md
├── flow/                           # 6 flows: Why→When→Steps→Evidence gates→Anti-patterns
│   ├── README.md                   #   การเลือก flow
│   ├── bug-fix-flow.md
│   ├── feature-build-flow.md
│   ├── security-audit-flow.md
│   ├── review-flow.md
│   └── recovery-flow.md
├── schemas/                        # JSON schemas: signal, gate-result, genome
├── templates/                      # state.md / ledger.md / dod.md templates
├── prompts/                        # m3-security-mode.md, m4-build-mode.md
├── scripts/                        # 8 tools + 4 test suites + CI templates
│   ├── tool-discovery.sh, fast-gate.sh, gate-runner.sh, loopfocus-verify.sh
│   ├── normalize-signal.js, loop-genome.js, git-state.js, ci-controller.js
│   └── ci/github-actions.yml, gitlab-ci.yml
└── docs/                           # สเปค + plans + baseline results
```

ติดตั้งที่:
- `~/.config/opencode/skills/LoopFocus/` (opencode)
- `~/.agents/skills/LoopFocus/` (cross-runtime alias: Claude Code, Codex, Copilot, Gemini)

---

## 3. สถาปัตยกรรมแกนหลัก

### 3.0 สถาปัตยกรรมระดับบน (4 เสาควบคุม)

```
                    LOOPFOCUS
                        │
 ┌──────────────────────┼───────────────────────┐
 │                      │                       │
 ▼                      ▼                       ▼
Goal Control      Reasoning Control       Execution Control
 │                      │                       │
Intent Anchor     Hypothesis Ledger       Checkpoint Brain
Constraint        Uncertainty Map         Branch-and-Recover
Hierarchy         Assumption Registry     Rollback
Critical Path     Counterfactual          Recovery Capsule
Engine            Check                   Handoff Protocol
Scope Firewall    Decision Ledger
Dependency        Pre-Mortem
Awareness         Dead-End Prediction
 │                      │                       │
 └──────────────────────┼───────────────────────┘
                        ▼
                 Progress Control
                        │
            ┌───────────┼────────────┐
            ▼           ▼            ▼
      Convergence    Stuck      Oscillation
      Engine       Detector     Detector
            │           │            │
            └───────────┼────────────┘
                        ▼
               Strategy Mutation
                        │
        Continue / Refocus / Replan /
        Rollback / Escalate / Finish
```

**คำอธิบายเสา:**

| เสา | คำถามที่ตอบ | ระบบหลัก |
|---|---|---|
| **Goal Control** | "เรากำลังทำอะไร และขอบเขตแค่ไหน" | Intent Anchor, Constraint Hierarchy, Critical Path, Scope Firewall, Dependency Awareness |
| **Reasoning Control** | "ทำไมเราคิดว่าอย่างนั้น มีหลักฐานแค่ไหน" | Hypothesis Ledger, Uncertainty Map, Assumption Registry, Counterfactual, Pre-Mortem, Dead-End Prediction, Decision Ledger |
| **Execution Control** | "ทำแล้วจะปลอดภัยไหม ย้อนกลับได้ไหม" | Checkpoint Brain, Branch-and-Recover, Rollback, Recovery Capsule, Handoff Protocol |
| **Progress Control** | "เราเข้าใกล้ Goal จริงหรือเปล่า" | Convergence Engine, Stuck Detector, Oscillation Detector → Strategy Mutation → คำตัดสิน 6 ทาง |

Progress Control คือ "ผู้ชี้ชะตา" — วัดผลทุก loop แล้วสั่ง Continue / Refocus / Replan / Rollback / Escalate / Finish ผ่าน Strategy Mutation

### 3.1 Focus State Machine (หัวใจของสกิล)

```
        ┌─────────────────────────────────────────┐
        │                LOCK                      │  ล็อก Goal + Constraints + Invariants
        └──────────────────┬──────────────────────┘
                           ↓
        ┌─────────────────────────────────────────┐
        │               EXPLORE                    │  สำรวจ repo/หลักฐาน (อ่านก่อนแก้เสมอ)
        └──────────────────┬──────────────────────┘
                           ↓
        ┌─────────────────────────────────────────┐
        │             HYPOTHESIZE                  │  ตั้ง hypothesis + ลง Hypothesis Ledger
        └──────────────────┬──────────────────────┘
                           ↓
        ┌─────────────────────────────────────────┐
        │               EXECUTE                    │  ลงมือตาม Commitment Level ที่ได้รับอนุญาต
        └──────────────────┬──────────────────────┘
                           ↓
        ┌─────────────────────────────────────────┐
        │               OBSERVE                    │  เก็บผล: error, diff, test, metric
        └──────────────────┬──────────────────────┘
                           ↓
        ┌─────────────────────────────────────────┐
        │               MEASURE                    │  Progress Delta = ?  (ต้องเป็นตัวเลข/หลักฐาน)
        └──────────────────┬──────────────────────┘
                           ↓
              ┌────────────┼───────────────┬──────────────┬─────────────┐
              ↓            ↓               ↓              ↓             ↓
        Progress →    Drift →         Stuck →       Regress →     Blocked →
         CONTINUE     REFOCUS          MUTATE        ROLLBACK      ESCALATE
        (รอบต่อไป)   (ดึงกลับ Goal)  (Loop Mutation) (ย้อน checkpoint) (แจ้ง user)
```

### 3.2 Hard Rules (ละเมิดไม่ได้)

1. Never repeat a failed approach without new evidence.
2. Never expand scope without linking it to the main goal.
3. Never discard a passing state without a rollback point.
4. Never claim progress without measurable delta.
5. Never declare completion while known blockers remain.

### 3.3 Loop Strategy Switching (บันไดกลยุทธ์)

พลาดขั้นไหน = เลื่อนขั้นถัดไป ห้าม retry ขั้นเดิมด้วยถ้อยคำใหม่:

```
S1 Direct Fix
    ↓ fail
S2 Root-cause Trace
    ↓ fail
S3 Reproduce Minimal Case
    ↓ fail
S4 Search/Inspect Dependencies
    ↓ fail
S5 Alternative Implementation
    ↓ fail
S6 Escalate
```

### 3.4 Commitment Levels (ระดับความมุ่งมั่นต่อโค้ด)

ห้ามกระโดดข้ามโดยไม่มีข้อมูลรองรับ:

```
L0 Observe           → ดูเฉยๆ เก็บหลักฐาน
L1 Hypothesis        → ตั้งสมมติฐาน (ยังไม่แตะโค้ด)
L2 Experiment        → ทดลองใน sandbox/branch แยก
L3 Temporary Patch   → แพตช์ชั่วคราว ย้อนได้
L4 Confirmed Change  → แก้จริง มีหลักฐานรองรับ
L5 Structural Change → เปลี่ยนโครงสร้าง (ต้องผ่าน L4 + pre-mortem + reversible plan)
```

### 3.5 Effort Elasticity (Core — กันสกิลหนักเกินจำเป็น)

ไม่ตั้ง reasoning depth ตายตัว แต่ยืดหยุ่นตามสถานการณ์:

| สถานการณ์ | Overhead |
|---|---|
| Simple task | ต่ำ (ข้ามขั้นตอนที่ไม่จำเป็น) |
| Complicated | เพิ่มการวางแผน |
| Repeated failure | เพิ่ม depth อัตโนมัติ |
| Strong progress | คงเดิม |
| Near completion | narrow focus |

เหตุผลที่ต้องเป็น core: ทำให้สกิล "เบา" ในงานง่าย และ "ลึก" เฉพาะเมื่อจำเป็น — ไม่เป็นภาระทุก prompt

### 3.6 Dynamic Focus Depth (ระดับความลึกของ loop)

งานง่ายใช้ loop ตื้น งานยากเพิ่ม depth อัตโนมัติ:

- L1 Quick (งานเล็กชัดเจน)
- L3 Persistent (เจออุปสรรคครั้งแรก)
- L5 Deep (ล้มซ้ำ / ซับซ้อน / security)
- L8 Extreme (รันไม่สำเร็จหลายรอบ, ระบบใหญ่, ต้อง branch-and-recover)

### 3.7 Gate Engine (แกนกลาง — ด่านตรวจทุกการกระทำ)

#### 3.7.1 สถาปัตยกรรมสมบูรณ์ของ LoopFocus

```
LoopFocus
│
├── Goal Engine
├── Focus / Anti-Drift
├── Hypothesis Engine
├── Progress / Convergence
├── Strategy Mutation
├── Checkpoint / Recovery
│
├── Gate Engine
│   ├── Entry Gates
│   ├── Execution Gates
│   ├── Progress Gates
│   ├── Regression Gates
│   ├── CI Gates
│   └── Completion Gate
│
└── ToolBus
    ├── Git
    ├── Build
    ├── Test
    ├── CI
    ├── Browser
    ├── Runtime
    └── Sandbox
```

#### 3.7.2 ครบ 26 Gates

| # | Gate | หน้าที่ | หมวด |
|---|---|---|---|
| 1 | **Entry Gate** | ก่อนเริ่มงานต้องรู้ Goal, constraints, repo state, DoD, environment ขั้นต่ำ ไม่ครบห้ามเริ่มแก้มั่ว | Entry |
| 2 | **Context Gate** | เช็คว่ามี context พอสำหรับ action ถัดไปไหม (ยังไม่อ่านไฟล์ที่เกี่ยวข้องแต่จะแก้ architecture → block) | Entry |
| 3 | **Assumption Gate** | assumption ที่มีผลสูงต้องมีหลักฐานหรือถูกทดสอบก่อน ("API นี้คืน null ไม่ได้" แต่ยังไม่เคยตรวจ contract → block) | Entry |
| 4 | **Plan Gate** | งาน change radius ใหญ่ต้องมีแนวทางก่อน execute; task เล็กผ่านแบบ light gate ได้ | Entry |
| 5 | **Mutation Gate** | ก่อนแก้ไฟล์ เช็ค: สัมพันธ์กับ Goal จริงไหม / ขยาย scope ไหม / reversible แค่ไหน | Execution |
| 6 | **Change-Radius Gate** | Goal เล็กแต่กำลังแก้ 30 ไฟล์ → hold + reassess | Execution |
| 7 | **Dependency Gate** | เพิ่ม/ลบ/upgrade dependency ต้องมีเหตุผลโยง Goal ไม่ให้ลง library เพราะสะดวกเฉยๆ | Execution |
| 8 | **Build Gate** | syntax/compiler/build ต้องผ่านตามระดับที่เกี่ยวข้องก่อนไป stage สูงกว่า | Execution |
| 9 | **Static Gate** | typecheck/lint/static analysis ที่โปรเจกต์มีอยู่ต้องไม่แย่ลง | Execution |
| 10 | **Test Gate** | แยก Affected → Integration → Broad/Full ไม่ต้อง Full Test ทุก loop | Execution |
| 11 | **Regression Gate** | สิ่งที่เคยผ่านแล้วต้องไม่กลับมาพัง ถ้า regression → หยุด progression | Regression |
| 12 | **Runtime Gate** | โปรแกรมต้อง start/run ได้จริง ไม่มี crash/error ใหม่ที่เกี่ยวข้องกับ change | Regression |
| 13 | **Browser Gate** | web app: interaction สำคัญต้องทำงานจริง (open → click → type → navigate → expected state) | Regression |
| 14 | **Performance Gate** | ไม่ benchmark ทุกงาน แต่ change แตะ hot path แล้ว latency/memory แย่ผิดปกติ → block | Regression |
| 15 | **Progress Gate** | แต่ละรอบต้องมี measurable delta หรือ information gain ถ้าไม่มีทั้งคู่ = NO_PROGRESS | Progress |
| 16 | **Repeat Gate** | approach เดิมที่ fail แล้วทำซ้ำไม่ได้ เว้นแต่มี new evidence ที่ทำให้สมมติฐานเปลี่ยน | Progress |
| 17 | **Stuck Gate** | failure class เดิมเกิดเกิน threshold → ห้าม retry ธรรมดา ต้อง mutate strategy | Progress |
| 18 | **Oscillation Gate** | ตรวจ A ผ่าน/B พัง → A พัง/B ผ่าน → ... → block การแก้ปลายเหตุ | Progress |
| 19 | **Checkpoint Gate** | ก่อนทำ structural/risky change ต้องมี stable state หรือ rollback point ก่อน | Recovery |
| 20 | **Recovery Gate** | หลัง rollback/context reset/crash ต้อง restore Goal + known truth + attempts + failures ก่อนทำงานต่อ | Recovery |
| 21 | **Evidence Freshness Gate** | test/build ที่ผ่านก่อน code เปลี่ยนล่าสุด = stale ใช้รับรอง current state ไม่ได้ | Progress |
| 22 | **CI Gate** | local fast gate ผ่านก่อน → relevant CI → ใกล้จบจึง broad/full CI | CI |
| 23 | **CI Reliability Gate** | แยก code failure จาก runner/network/flaky/environment failure ก่อนสั่งแก้โค้ด | CI |
| 24 | **Artifact Gate** | stage สำคัญต้องมี output (test result, log, diff, screenshot, metric) ไม่ใช้ข้อความจาก Agent ลอยๆ | CI |
| 25 | **Scope Gate** | สิ่งที่อยากทำจำแนก Required / Supporting / Optional / Unrelated → Unrelated = block | Entry |
| 26 | **Completion Gate** ⭐ | known blockers = 0, DoD ครบ, required checks ผ่าน, ไม่มี regression ที่รู้จัก → อนุญาต READY_TO_FINISH | Completion |

#### 3.7.3 Gate Profiles (ไม่เปิดทุก Gate แรงเท่ากัน)

| Profile | Gates | ใช้เมื่อ |
|---|---|---|
| **LIGHT** | Entry → Mutation → Build/Test ที่จำเป็น → Completion | Task simple |
| **NORMAL** | LIGHT + Context, Regression, Progress, Checkpoint, Relevant CI | หลายไฟล์ / architecture |
| **DEEP** | NORMAL + Assumption, Change Radius, Runtime, Browser, Performance, Full CI, Evidence Freshness, Artifact | Fail ซ้ำ / high impact |
| **Near Completion** | Completion Gate ขยาย scope | ใกล้เสร็จ |

LoopFocus เปลี่ยน profile อัตโนมัติตามสถานการณ์

#### 3.7.4 Gate DAG (ไม่ใช่ chain ตายตัว — แต่ละโปรเจกต์ไม่เหมือนกัน)

```
                    Entry Gate
                        │
                   Context Gate
                        │
                   Mutation Gate
                  /      |       \
              Build    Runtime   Browser
                │         │         │
              Test        └────┬────┘
                │              │
             Regression ───────┘
                │
            Progress Gate
                │
                CI
                │
         Completion Gate
```

- backend ไม่มี Browser Gate → ไม่ต้องรัน
- docs-only change → อาจไม่มี Build Gate เลย
- Gate DAG สร้างจาก Tool Auto-Discovery (Tool Map ของ repo)

#### 3.7.5 Gate Output มาตรฐาน (ทุก Gate คืน JSON เดียวกัน)

```json
{
  "gate": "regression",
  "status": "FAIL",
  "attempt": 17,
  "reason": "3 previously passing tests now fail",
  "blocking": true,
  "evidence": ["test-report"],
  "next_action": "rollback_or_root_cause"
}
```

→ Gate Engine คุยกับ Progress Engine, ToolBus, Loop Engine, Strategy Mutation ได้หมดผ่าน schema เดียวนี้

### 3.8 State Machine + Gate Engine ทำงานร่วมกัน

State Machine = "จังหวะการทำงาน" (LOCK → EXPLORE → ... → MEASURE); Gate Engine = "ด่านตรวจ" ที่ประกบทุก transition — ข้าม state ไม่ได้ถ้า gate ที่เกี่ยวข้องไม่ผ่าน; Gate Profile กำหนดว่าด่านไหนเปิดใช้ในสถานการณ์ไหน; Gate DAG กำหนดเส้นทางตามธรรมชาติของโปรเจกต์

---

## 4. กลุ่มระบบ (Systems Registry)

### 4.1 Goal & Focus (ล็อกเป้าหมาย ไม่หลุด)

| ระบบ | หน้าที่ | Trigger |
|---|---|---|
| **Goal Lock** | ล็อก Objective หลักตั้งแต่ต้น ทุก action ต้องตอบได้ว่า "ช่วย Goal นี้เสร็จยังไง" ตอบไม่ได้ = drift | ทุกงาน |
| **Intent Anchor** | เก็บเจตนาจริงของผู้ใช้แยกจาก wording ของ prompt — ไม่ให้ทำถูกตัวอักษรแต่ผิดเป้าหมาย | ตอนรับงาน |
| **Anti-Drift Engine** | ตรวจจับออกนอกเรื่อง (แก้ login → refactor UI ทั้งระบบ) → ดึงกลับ objective เดิม | ระหว่างทำงาน |
| **Scope Firewall** | ทุกงานที่อยากทำ แบ่ง Required / Helpful / Unrelated → block Unrelated | ก่อนแต่ละ action |
| **Side-Quest Sandbox** | อนุญาตออกนอก Goal ชั่วคราวเพื่อหาสาเหตุ แต่มีขอบเขต+เวลาจำกัด แล้วต้องกลับ main objective | เมื่อต้องสืบสวนนอกเส้น |
| **Focus Budget** | side quest / investigation ทุกอันมี budget (รอบ/effort) เกินโดยไม่มี progress → terminate branch กลับ Main Goal | เริ่ม side quest |
| **Attention Scheduler** | ลงแรงจุด impact สูงก่อน ไม่ polish จุดเล็กขณะ blocker ใหญ่ยังอยู่ | จัดลำดับงาน |
| **Goal Decomposition Guard** | กันแตกงานยิบเกินจนมัวแต่จัดการ task tree — Main Goal → Necessary / Helpful / Optional / Noise (ตัด Noise) = YAGNI ระดับ agent | ตอนวางแผนงาน |

### 4.2 Reasoning & Hypothesis (คิดเป็นระบบ ไม่เดาสุ่ม)

| ระบบ | หน้าที่ | Trigger |
|---|---|---|
| **Hypothesis Ledger** | บันทึกก่อนแก้แต่ละรอบ: คิดว่าสาเหตุคืออะไร / ทดสอบยังไง / ผลเป็นยังไง | ก่อน HYPOTHESIZE |
| **Confidence Decay** | hypothesis ที่ทดสอบแล้วไม่สำเร็จ → ลด confidence อัตโนมัติ ห้ามยึดติดความคิดเดิม | หลัง hypothesis ล้ม |
| **Counterfactual Check** | จะเปลี่ยน X → ถาม "ถ้า X ไม่ใช่ต้นเหตุ เราควรเห็นอะไร" ลด confirmation bias | ก่อน EXECUTE ใหญ่ |
| **Pre-Mortem Loop** | ก่อนลงมือรอบใหญ่ ถาม "ถ้าวิธีนี้ล้ม จะล้มตรงไหน" แล้วป้องกันล่วงหน้า | ก่อน EXECUTE ใหญ่ |
| **Dead-End Prediction** | ก่อนใช้ approach แพง/ยาว ประเมินโอกาสไปถึง Goal หรือเดินเข้าทางตัน | ก่อนตัดสินใจทางยาว |
| **Information Gain Routing** | ยังไม่รู้สาเหตุ → เลือก action ที่ให้ข้อมูลใหม่มากสุด ไม่ใช่อันที่ดูทำงานเยอะสุด | สถานะ Unknown |
| **Uncertainty Map** | แยก Known / Likely / Unknown / Contradictory — ไม่เอาที่เดามาใช้เป็นข้อเท็จจริง | ตลอดเวลา |
| **Assumption Registry** | เก็บทุก assumption; มีข้อมูลใหม่หักล้าง → ย้อนหางานที่ affected ทันที | ตลอดเวลา |
| **Decision Ledger** | เก็บเหตุผลตัดสินใจสำคัญ ("ทำไมเลือก A ไม่ B") กันกลับคำแบบไม่มีเหตุผลใหม่ | ทุกการตัดสินใจสำคัญ |

### 4.3 Progress & Verification (หลักฐานก่อนคำเคลม)

| ระบบ | หน้าที่ | Trigger |
|---|---|---|
| **Progress Proof** | ไม่เชื่อคำพูดว่า "คืบหน้า" ดู evidence จริง (test fail 14→3, compile ผ่านขึ้น) | MEASURE ทุกรอบ |
| **Progress Delta** | วัดว่ารอบนั้นทำให้ดีขึ้นจริงกี่ % (delta ≈ 0 หลายรอบ = ติด) | MEASURE ทุกรอบ |
| **Regression Sentinel** | คืบหน้าด้านหนึ่ง ต้องเช็คของที่เคยผ่านไม่พัง (12 tests → 9 = ติดลบจริง) | หลังทุกการแก้ |
| **Evidence Freshness** | evidence เก่าหมดอายุหลังเปลี่ยนโค้ดล่าสุด → invalidate + รันใหม่ | หลังทุกการแก้ |
| **Definition-of-Done Graph** | ไม่ใช่ TODO list แต่เป็น DAG เงื่อนไข: feature works → tests pass → no regression → verify → done ยังไม่ครบ = ยังไม่เสร็จ | ตั้งแต่เริ่มงาน |
| **Verify ก่อนจบ** | รัน `loopfocus-verify.sh` ทุกงาน ห้ามเคลมเสร็จโดยไม่รัน | ก่อนตอบจบงาน |
| **State Integrity** | รู้สถานะ workspace ระหว่าง loop (tests 98/100 + modified 3 → 91/100 + 14 = regression alarm) → ไม่เดินต่อแบบหลับตา — เป็น navigation feedback ระหว่าง loop ไม่ใช่แค่ verification สุดท้าย | ระหว่าง loop |

### 4.4 Context & Knowledge (ข้อมูลมีอายุ ต้องจัดการ)

| ระบบ | หน้าที่ | Trigger |
|---|---|---|
| **Knowledge Half-Life** | ข้อมูลแต่ละประเภทมีอายุ: repo structure = stable / test result = stale หลัง code เปลี่ยน / runtime process state = stale เร็วมาก / API docs = อาจเปลี่ยน → ติดป้าย freshness ของ context แล้ว refresh เฉพาะสิ่งที่จำเป็น | ตลอดเวลา |
| **Context Conflict Resolver** | context หลายแหล่งขัดกัน (README: v2, Code: v3, Tests: v3) → ตรวจจับความขัดแย้ง → prioritize หลักฐานจริงล่าสุด → mark แหล่งที่ stale — ไม่ปล่อยให้ agent หยิบข้อมูลสุ่มชิ้นเดียวไปใช้ | ตอน EXPLORE |
| **Objective Compression** | งานใหญ่ requirements 100 ข้อ → สร้างตัวแทนสั้นๆ pin ไว้ตลอด context: `MISSION / MUST PRESERVE / CURRENT BLOCKER / NEXT PROOF` — กัน agent ลืม objective ในงานยาว | งานใหญ่/ยาว |

### 4.5 Loop Control (กัน retry ซ้ำ ติดหล่ม) — Killer Features

| ระบบ | หน้าที่ | Trigger |
|---|---|---|
| **Stuck Detector** | แยก "งานยากจริง" กับ "ติด loop" (error เดิม / diff เดิม / test failure เดิม / reasoning เดิม) → ติดจริง = escalate | MEASURE ทุกรอบ |
| **Loop Mutation** | ทำวิธีเดิมพลาด 2–3 รอบ → ห้ามทำแบบเดิม ต้องเปลี่ยน hypothesis / tool / approach อัตโนมัติ | หลังล้มซ้ำ |
| **No-Progress Tax** | ล้มซ้ำไม่เกิด progress → ต้นทุนทาง logic บังคับ: ห้ามใช้ strategy family เดิม + บังคับ reset hypothesis + เพิ่ม reasoning depth + ขุด dependency ที่ซ่อนอยู่ | หลังล้มซ้ำ |
| **Loop Fingerprint** | hash รูปแบบ attempt (files + error + approach + result) รอบใหม่คล้ายรอบเก่ามาก → เตือน "กำลังทำซ้ำ" | ทุก attempt |
| **Convergence Engine** ⭐ | ดูว่า converge เข้า Goal จริงไหม: unresolved issues 18→11→6→4→3 = ดี แต่ 18→16→19→14→21 = unstable loop → เปลี่ยน strategy อัตโนมัติ | MEASURE ทุกรอบ |
| **Oscillation Detector** ⭐ | ตรวจจับวงจร A PASS/B FAIL → A FAIL/B PASS → A PASS/B FAIL (แก้ A แล้ว B พัง สลับไปมา) → หยุดแก้ปลายเหตุ ค้นหา shared root cause | MEASURE ทุกรอบ |
| **Solution Entropy** | เปลี่ยนไฟล์/แนวคิด/dependency เพิ่มขึ้นเรื่อยๆ แต่ปัญหายังไม่จบ = solution complexity ระเบิด → entropy warning → simplify → กลับ last stable checkpoint | MEASURE ทุกรอบ |

### 4.6 State & Memory (resume ได้ ไม่เริ่มจากศูนย์)

| ระบบ | หน้าที่ | Trigger |
|---|---|---|
| **Checkpoint Brain** | ทุก milestone บันทึก: ทำแล้ว / พิสูจน์แล้ว / ยังไม่รู้ / next action | ทุก milestone |
| **Recovery Capsule** | state ขนาดเล็กที่ agent ใหม่ (หรือ context ใหม่) อ่านแล้วทำงานต่อได้ทันทีหลัง crash/reset | ต่อเนื่อง |
| **Branch-and-Recover** | หลายวิธีแก้ → ลองเป็น branch A/B/C เก็บผล; B พัง → ย้อน checkpoint ก่อน B ไม่ทำลายความคืบหน้า A | เมื่อมีหลายทางเลือก |
| **Context Distillation** | งานยาว → ย่อ context เป็น "Current Truth" กันลืมเป้าหมาย | เมื่อ context โตเกินเกณฑ์ |
| **Handoff Protocol** | ส่งงานต่อ (agent/skill/คนอื่น) = Goal + constraints + attempts + failures + current evidence ไม่ใช่ prompt สั้นๆ | ทุกการส่งต่อ |
| **Failure Memory** | บันทึก approach ที่เคยล้ม + เหตุผล — agent ตัวอื่น/รอบใหม่ต้องอ่านก่อนเริ่ม ไม่ทำผิดซ้ำ | ทุก failure |
| **Loop Genome** | ประวัติวิวัฒนาการของวิธีแก้ต่อ task: Hypothesis → Fail/Partial/Goal + %progress + family ban → คราวหน้าเจอ problem class คล้ายกัน รู้เลยว่า strategy family ไหนเคยสำเร็จ | ทุก task |
| **Checkpoint/Genome storage** | เก็บใน `.loopfocus/` ใน repo (หรือ `~/.loopfocus/` สำหรับ global) | อัตโนมัติ |

### 4.7 Constraints & Safety (ห้ามพังของเดิม)

| ระบบ | หน้าที่ | Trigger |
|---|---|---|
| **Invariant Guard** | ล็อกสิ่งที่ห้ามพัง: API contract, existing behavior, requirement, compatibility — เช็คทุก loop | ตลอดเวลา |
| **Contradiction Watch** | ตรวจจับทำผิด requirement เดิม (โดนสั่ง "ห้ามแก้ API contract" แต่รอบที่ 8 กำลังเปลี่ยน API) → block ทันที | ก่อน EXECUTE |
| **Constraint Hierarchy** | Hard / Soft / Preference / Assumption — ขัดกันให้รักษา Hard ก่อน | ตอน LOCK |
| **Minimum Intervention** | แก้ 2 จุดพอ ห้าม refactor 20 ไฟล์โดยไม่มีเหตุผล ลด side effects | ตอนวางแผนแก้ |
| **Change Radius Control** | ประเมิน change ที่เสนอใหญ่เกินตัวปัญหาหรือไม่ (แก้ auth redirect แต่จะแตะ 17 components = TOO LARGE → block) | ตอนวางแผนแก้ |
| **Reversible First** | ข้อมูลไม่พอ + มี 2 วิธี → เลือกวิธีทดลองเล็ก rollback ได้ก่อนเปลี่ยน architecture ใหญ่ | ตอนเลือกวิธี |

### 4.8 Planning & Dependencies

| ระบบ | หน้าที่ | Trigger |
|---|---|---|
| **Dependency Awareness** | Goal A ถูก block โดย B → สร้าง dependency ชัดๆ แทนวน A ซ้ำ | เมื่อติดขัด |
| **Critical Path Engine** | dependency graph ของงาน หาเส้นที่ขวาง completion จริงๆ | ตอนวางแผน |
| **Auto-Replan** | สภาพจริงไม่ตรงแผน → replan เฉพาะส่วนที่กระทบ แต่ Goal หลักยัง lock อยู่ | เมื่อแผนแตก |

---

## 5. พฤติกรรมติดตัวเสมอ (Always-On)

ไม่ต้องสั่งโหมด ทำอัตโนมัติทุกงาน:

1. **Focus** — อยู่กับงาน+repo ไม่หลุดประเด็น ไม่ทำนอกเหนือ
2. **Loop Root-Cause** — วนขุดหาต้นตอจนเจอ ไม่หยุดที่อาการ
3. **SkillFocus (ช่างสังเกต)** — เจอจุดไม่โอเคทุก severity (ไม่ใช่แค่ Critical) → รายงาน + เสนอวิธีปรับปรุง
4. **หลักการแก้** — แก้ที่สั่ง + แก้จุดที่เจอเองเฉพาะที่ "ชัวร์ปลอดภัย" (= ทดสอบผ่าน + Minimal Intervention + ย้อนได้ + ไม่ละเมิด Invariant) + ที่เหลือรายงานให้ user ตัดสินใจ (ถาม: "เจอจุดอื่นด้วย จะให้แก้มั้ย หรือจะทำอะไร")
5. **ไม่มโน / Self-reject** — ไม่มั่นใจในคำตอบ → reject คำตอบตัวเอง ตรวจหลักฐานซ้ำจนกว่าจะตรงประเด็น
6. **Verify ก่อนจบ** — รัน `loopfocus-verify.sh` ทุกงาน

## 6. โหมด (Modes)

เปิดเมื่อสั่งเท่านั้น:

- **M3 Security Mode**: สแกนช่องโหว่/จุดเสี่ยง security — injection, auth bypass, secret leakage, insecure dependency, permission misconfig, data exposure + ออกรายงาน severity + เสนอวิธีแก้ (ใช้ Loop Strategy + SkillFocus เต็มรูปแบบ)
- **M4 Build Mode**: สร้าง feature ใหม่ — ล็อก requirement (Goal Lock + Intent Anchor), ออกแบบก่อนเขียน (Predictive + Canvas), สร้าง DoD Graph, เขียนไป verify ไป ไม่มโน ไม่ลุกลาม scope

## 7. ความสามารถเสริม (เรียกใช้ได้ตลอด)

### 7.1 Predictive Analysis (ทำนายบัคอนาคต)

- วิเคราะห์ล่วงหน้าว่าโค้ดส่วนไหนจะพัง/เกิดบัคเมื่อมีฟีเจอร์ใหม่เข้ามา
- ปัจจัย: coupling, complexity, churn, test coverage, technical debt, concurrency, data flow
- ต้องอ้างอิงจากโค้ดจริง + ระบุระดับความเชื่อมั่น (Uncertainty Map) — ทำนายแบบมีหลักฐาน ไม่มโน
- Output: รายการจุดเสี่ยง + เหตุผล + severity + แนวป้องกัน

### 7.2 Canvas (ออกแบบสถาปัตยกรรม)

- วาด diagram (Mermaid/ASCII) ในแชท: โครงสร้างปัจจุบัน, จุดที่ควรแก้, เสนอโครงสร้างฟีเจอร์ใหม่
- ถ้า user อนุมัติ → เก็บเป็น design doc (`.md`) ใน repo
- ใช้กับ: วิเคราะห์โค้ดที่เป็นอยู่, ออกแบบ feature ใหม่, อธิบาย impact ของ change

## 8. Tools

### 8.1 loopfocus-verify.sh

Agent ต้องรันก่อนเคลมว่างานเสร็จ ตรวจสอบ:

1. DoD Graph ครบทุกเงื่อนไขหรือไม่
2. มีหลักฐาน progress ที่วัดได้หรือไม่ (test/compile/diff metric)
3. Regression Sentinel: ของที่เคยผ่านยังผ่านอยู่หรือไม่
4. Evidence Freshness: evidence ทั้งหมดมาจากโค้ดเวอร์ชันล่าสุดหรือไม่
5. Invariant Guard: invariant ที่ล็อกไว้ยัง intact หรือไม่
6. มี blocker ที่รู้อยู่แล้วค้างอยู่หรือไม่ (มี = ห้ามเคลมเสร็จ)
7. Loop Genome / Failure Memory ถูกบันทึกแล้วหรือไม่

Output: PASS/FAIL + รายละเอียด ถ้า FAIL ต้องกลับเข้า state machine

### 8.2 loop-genome.py

- บันทึก Loop Genome (attempt history) + Failure Memory + Decision Ledger ลง `.loopfocus/`
- ค้น problem class คล้ายกันในอดีต → เสนอ strategy family ที่เคยสำเร็จ
- เปิดอ่านได้จาก agent ตัวใหม่/context ใหม่

### 8.3 CI Templates

- `github-actions.yml` / `gitlab-ci.yml` — เทมเพลตให้ repo ใส่ CI: lint + typecheck + test + build + (optional) security scan พร้อมคำอธิบายวิธีติดตั้ง

### 8.4 ToolBus (เครื่องมือทั้งหมดต่อเข้าสมองเดียว)

```
                  LoopFocus
                      │
                Focus Engine
                      │
                ┌─ ToolBus ─┐
                │           │
        ┌───────┼───────────┼─────────┐
        ▼       ▼           ▼         ▼
       Git     Local        CI      Runtime
              Tools      Controller Observer
        │       │           │         │
     Worktree  │      GitHub Actions  OTel
        │      ├─ Build      │       traces
        │      ├─ Test       │       metrics
        │      ├─ Lint       │       logs
        │      └─ E2E        │
        │                    │
        └────────────┬───────┘
                     ▼
               Signal Normalizer
                     │
                     ▼
             Progress / Regression
                     │
       ┌─────────────┼──────────────┐
       ▼             ▼              ▼
   CONTINUE       MUTATE         ROLLBACK
                                     │
                         REPLAN / ESCALATE
```

**หลักการสำคัญ: output จากทุก tool ต้องถูก normalize ก่อนเข้า Focus Engine**

```json
{
  "attempt": 12,
  "source": "ci:e2e",
  "status": "fail",
  "previous_failures": 17,
  "current_failures": 3,
  "delta": "+14",
  "failure_class": "webkit-navigation",
  "new_regressions": 0,
  "evidence_fresh": true,
  "progress": true
}
```

→ ยัง FAIL แต่ 17→3 = กำลัง converge → ไม่เปลี่ยน strategy แบบสุ่ม (ฉลาดกว่า "run test → เห็นแดง → แก้ → run ใหม่")

#### ส่วนประกอบ ToolBus

| Tool | หน้าที่ | เทคโนโลยี |
|---|---|---|
| **CI Controller** | อ่าน workflow/status/failed job/logs/artifacts รู้ว่า commit ไหนพัง CI; rerun อย่างฉลาด: Build FAIL → ไม่ต้องรอ Test, E2E fail เฉพาะ browser → rerun shard/browser นั้นก่อน | GitHub Actions (GitHub-hosted + self-hosted runners) |
| **Local Fast Gate** | ก่อนเสียเวลารอ CI รันของเร็วในเครื่อง: compiler/typecheck → lint → unit tests → affected tests → ค่อย Full CI | pytest (tests), Ruff (lint/format, ใช้ใน CI ได้ด้วย) |
| **Browser/E2E Driver** | เป็น sensor ของ LoopFocus: render/interact/screenshot/browser state + CI execution — ต่อยอด FVEP v6 ได้ (แก้ UI → render → interact → screenshot → loop) | Playwright (Chromium/Firefox/WebKit) |
| **Git State Engine** | อ่าน diff/commits/changed files; ใช้ **Git worktree** แยก sandbox: Attempt A/B/C คนละ worktree → เปรียบเทียบผลก่อนเลือกวิธีที่ดีที่สุด | Git worktrees |
| **Build Sandbox** | isolate + reproducible environment สำหรับทดลอง build/test; dangerous/experimental change → sandbox ก่อน → ผ่านค่อยนำกลับ workspace | Docker |
| **Runtime Observer** | รับ traces + metrics + logs เป็นข้อมูล runtime จริง เช่น tests ผ่านแต่ latency 120ms → 1.8s = "technically pass แต่ progress จริงติดลบ" | OpenTelemetry |
| **Artifact/Evidence Collector** | ทุก tool คืนมากกว่า PASS/FAIL: logs, trace, screenshot, test report, diff, build output, CI artifact + attempt ID → รู้ว่าหลักฐานมาจาก loop ไหน | — |
| **Tool Auto-Discovery** | เปิด repo → ตรวจ package.json / pyproject.toml / Cargo.toml / go.mod / .github/workflows / Dockerfile → สร้าง Tool Map อัตโนมัติว่า project นี้มี build/test/lint/e2e อะไรบ้าง | — |
| **CI Matrix Brain** | ไม่มอง CI = PASS ค่าเดียว เห็น matrix: Linux PASS / macOS PASS / Windows FAIL / Chromium PASS / WebKit FAIL → focus เฉพาะ failure domain ไม่แก้ทั้งโปรเจกต์ | Playwright multi-project (browsers/configs) |

#### 8.4b Adaptive CI (ขยาย radius การ verify ตามสถานการณ์)

```
Code Changed
    ↓
Impact Detection
    ↓
Fast Checks
    ↓
Affected Tests
    ↓
Relevant CI Matrix
    ↓
PASS?
 ┌──┴───┐
 NO    YES
 ↓      ↓
Loop   Broader CI
        ↓
     Full Gate
```

- งานเล็กไม่ต้องยิง Full CI ทุกรอบ (ประหยัดเวลา/ค่าใช้จ่าย)
- ใกล้จบงาน → ค่อยขยาย verification radius ไปจน Full Gate

---

## 9. กลไกการทำงานร่วมกัน (ตัวอย่าง flow)

**Scenario: ผู้ใช้สั่ง "ช่วยแก้บัคหน้า login ค้าง"**

1. **LOCK**: Goal = "login ไม่ค้าง" | Intent Anchor: ผู้ใช้ต้องการเข้าใช้งานได้ ไม่ใช่แค่หน้าไม่ค้าง | Constraint Hierarchy: Hard = ห้ามเปลี่ยน API contract
2. **EXPLORE**: อ่านโค้ด login, session, router — SkillFocus เห็นจุดไม่สวยอื่น 2 จุด (เก็บไว้รายงานทีหลัง)
3. **HYPOTHESIZE**: ลง ledger "คาดว่าปัญหาที่ infinite loop ใน middleware" (L1)
4. **EXECUTE**: S1 Direct Fix → ไม่หาย
5. **OBSERVE/MEASURE**: Progress Delta = 0 → S2 Root-cause Trace → เจอ race condition ใน session layer (L4 confirmed)
6. แก้จริง + test ผ่าน (Regression Sentinel: 12 tests เดิมยังผ่าน)
7. **รายงาน**: แก้แล้ว + รายงานจุดไม่โอเคอีก 2 จุดที่เจอ ถาม user จะให้แก้มั้ย
8. **VERIFY**: loopfocus-verify.sh PASS → done
9. **บันทึก**: Loop Genome เก็บ problem class "login hang" → strategy family ที่สำเร็จ = root-cause trace ที่ session race

---

## 10. แผนการทดสอบ (TDD ตามหลัก writing-skills)

1. **RED**: สร้าง pressure scenarios (3+ แรงกดดันรวม) รันด้วย subagent **โดยไม่มีสกิล** — เก็บพฤติกรรม baseline: หลุดโฟกัสยังไง, retry ยังไง, มโนยังไง, rationalization ที่ใช้ (verbatim)
2. **GREEN**: เขียน SKILL.md + tools แก้เฉพาะ failure ที่เห็นจริง
3. **REFACTOR**: รันซ้ำหาช่องโหว่ (rationalization ใหม่) → ปิด loophole → re-test จน bulletproof

Pressure types: time pressure, sunk cost, authority, exhaustion, context loss

Success criteria: agent ทำตาม Hard Rules + state machine ภายใต้แรงกดดันสูงสุด + resume ได้หลัง context reset

---

## 11. ขอบเขตการส่งมอบ (Phases)

- **Phase 1**: SKILL.md ฉบับแรก (state machine + hard rules + always-on + ระบบหลัก) + verify script
- **Phase 2**: Gate Engine (26 gates + profiles + DAG + output schema)
- **Phase 3**: Loop Genome + Failure Memory tools + `.loopfocus/` storage
- **Phase 4**: Modes (M3/M4) + Canvas + Predictive
- **Phase 5**: ToolBus (Signal Normalizer, Tool Auto-Discovery, Local Fast Gate, CI Controller, Git State Engine, Build Sandbox, Runtime Observer, E2E Driver, CI Matrix Brain, Adaptive CI)
- **Phase 6**: CI templates + ทดสอบครบวงจร + ติดตั้ง cross-runtime

## 12. สถานะการรวบรวมระบบ

- จำนวนระบบทั้งหมด: **61 ระบบ + 4 เสา + Gate Engine (26 gates + 4 profiles + DAG) + ToolBus (9 tools + Signal Normalizer + Adaptive CI) + Identity**
- สถานะ: **IMPLEMENTED** — โครงสร้างแบบ FVEP (SKILL.md router + references/ 14 ไฟล์ + flow/ 6 docs + schemas/ + templates/ + prompts/ + scripts/) ติดตั้งที่ `~/.config/opencode/skills/` และ `~/.agents/skills/` ผ่านการทดสอบ TDD (RED/GREEN/REFACTOR) + E2E scenarios ครบทุก phase
