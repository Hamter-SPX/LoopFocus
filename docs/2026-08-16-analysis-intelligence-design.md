# Analysis Intelligence — Design Spec v1

วันที่: 2026-08-16
สถานะ: Draft v1.1 (รวบรวมจากเจ้าของโปรเจกต์ — ~262 ระบบ ครบทุกตัวที่ให้มา รอรีวิว)
ตำแหน่ง: โหมด analysis-intelligence ของ LoopFocus — หน่วยสมบูรณ์ในตัว (Docs + Identity ของตัวเอง)

---

## 1. Identity

> **Adaptive Cross-Domain Recursive Analysis Intelligence**

นิยามสั้น (จากเจ้าของโปรเจกต์):

> **"สร้างแบบจำลองความจริงของปัญหาให้ถูกที่สุด ค้นพบสิ่งที่ยังไม่รู้ ทดสอบสิ่งที่คิดว่ารู้ และเปลี่ยนความเข้าใจนั้นให้เป็น Action ที่ LoopFocus สามารถลงมือและเรียนรู้จากผลจริงต่อได้"**

สิ่งที่โหมดนี้เป็น (ไม่ใช่แค่ "อ่านแล้วสรุป"):
- สร้างแบบจำลองของปัญหาและหาเหตุ-ผลจริง
- ไม่รีบตอบ — แยกได้เสมอว่า: FACT / INFERENCE / ASSUMPTION / HYPOTHESIS / UNKNOWN / CONTRADICTION
- มีอำนาจ "วิเคราะห์" และส่ง Action Plan ให้ LoopFocus ต่อได้ (พร้อม success/failure criteria)
- วน Recursive Analysis Loop จน information gain ต่ำลง — ไม่วนไม่รู้จบ

## 2. Signature Pipeline

```
Input / Problem
      ↓
Context Reconstruction
      ↓
World Model
      ↓
Facts / Assumptions / Unknowns
      ↓
Dependency + Causal Graph
      ↓
Hypothesis Generation
      ↓
Evidence Search
      ↓
Counterfactual Challenge
      ↓
Contradiction Resolution
      ↓
Impact Simulation
      ↓
Independent Judge
      ↓
Conclusion + Confidence
```

## 3. 6 Epistemic Classes (แยกได้ตลอด pipeline)

| Class | ความหมาย |
|---|---|
| FACT | มีหลักฐานยืนยัน |
| INFERENCE | อนุมานจากข้อเท็จจริง (ระบุเส้นทางอนุมาน) |
| ASSUMPTION | เชื่ออยู่โดยยังไม่พิสูจน์ (ระบุ + เจ้าของ + อายุ) |
| HYPOTHESIS | ตั้งไว้รอหลักฐานหักล้าง |
| UNKNOWN | ยอมรับว่าไม่รู้ (ระบุว่าต้องหาอะไร) |
| CONTRADICTION | หลักฐานชนกัน — ห้ามเลือกมั่ว |

## 4. Recursive Analysis Loop

```
Understand → Model → Analyze → Challenge
→ Find missing information → Update model → Re-analyze → Converge
```

หยุดเมื่อ information gain ต่ำลง (ไม่ใช่เมื่อวนจนหมดเวลา) — เข้ากับ LoopFocus ตรงที่ loop มีเงื่อนไขจบ

## 5. Router (Analysis Intent Router)

### 5.1 Intent Detection
Domain · Problem type · Complexity · Evidence quality · Uncertainty · Required depth · Time horizon · Cross-domain dependencies

### 5.2 Dynamic Composition
ไม่เลือกโหมดเดียว — รวม engine หลายตัว เช่น:
- "ทำไม AI server ช้าลงหลังเปลี่ยน model?" → Software + Hardware + Performance + Temporal + Causal
- "ควรเปลี่ยน architecture บริษัทไหม?" → System + Financial + Risk + Strategy + Scenario + Decision

### 5.3 Adaptive Analysis Routing (Meta-Routing)
เริ่มด้วย Software Analysis → evidence ชี้ว่า GPU memory pressure → Router อัปเดตเป็น Software + Hardware + Performance + Resource Analysis

### 5.4 Escalation Levels
| Level | ความลึก |
|---|---|
| L0 | Quick Analysis |
| L1 | Structured Analysis |
| L2 | Deep Analysis |
| L3 | Multi-Hypothesis Analysis |
| L4 | Cross-Domain Analysis |
| L5 | Adversarial Analysis |
| L6 | Recursive Intelligence |
| L7 | Research-Grade / Proof-Oriented |

งานง่ายไม่เผา reasoning — งานยาก Router escalate เอง

## 6. Analysis Mesh (Signature)

```
                Master Analysis
                      │
       ┌──────────────┼──────────────┐
       ↓              ↓              ↓
 Software Analyst Hardware Analyst Data Analyst
       │              │              │
       └──────────────┼──────────────┘
                      ↓
              Causal Synthesizer
                      ↓
              Adversarial Judge
                      ↓
                  Conclusion
```

Sub-analysis แต่ละตัว **ไม่เห็น conclusion ของอีกตัวในรอบแรก** (กัน anchoring) แล้วค่อยรวมผลภายหลัง

## 7. Internal Analysis Modes (14)

| Mode | วิเคราะห์อะไร |
|---|---|
| Software Intelligence | codebase, architecture, runtime, APIs, dependencies, state, performance, bugs, tech debt |
| Hardware Intelligence | CPU/GPU/NPU, memory hierarchy, storage, bus/interconnect, thermals/power, FPGA/SoC, HW-SW interaction |
| Data Intelligence | dataset structure, patterns, outliers, missing data, bias, distribution shifts, statistical relationships |
| Research Intelligence | source comparison, evidence grading, claim extraction, contradiction resolution, literature synthesis, knowledge gaps |
| Document Intelligence | requirements, contracts/specs, design docs, logs, reports, long-context relationships |
| Decision Intelligence | alternatives, constraints, trade-offs, expected outcomes, regret analysis, reversibility |
| Strategy Intelligence | objectives, resources, competitive dynamics, dependencies, bottlenecks, strategic sequencing |
| System Intelligence | whole-system modeling, interactions, feedback loops, emergent behavior, failure propagation |
| Causal Intelligence | root cause, causal graphs, confounders, counterfactuals |
| Temporal Intelligence | timeline, state changes, regression, trends, leading/lagging signals |
| Predictive Intelligence | scenario generation, forecast ranges, confidence, conditional predictions |
| Comparative Intelligence | A vs B vs C, controlled comparison, normalize evidence, decisive differences |
| Diagnostic Intelligence | symptoms, hypotheses, tests, evidence, root cause |
| Optimization Intelligence | objective function, constraints, search space, Pareto frontier, best compromise |

## 8. ระบบทั้งหมด (จัดเป็น 9 ชั้น)

### L1 — Understanding & Structure (35 ระบบ)

| ระบบ | หน้าที่ |
|---|---|
| System Understanding Engine | เข้าใจทั้งก้อนก่อนวิเคราะห์รายละเอียด |
| Context Reconstruction | ประกอบบริบทของปัญหาจากหลักฐานกระจัดกระจาย |
| Infer Hidden Structure | จากข้อมูลดิบ อนุมานกฎ/hierarchy/dependency/state machine ที่ไม่มีใครเขียน |
| Discover Latent Variables | จับตัวแปรที่ไม่ได้อยู่ในข้อมูลตรงๆ แต่เป็นสาเหตุร่วมของหลายอาการ |
| Mechanistic Understanding | เข้าใจกลไกว่า A ทำให้เกิด B ผ่านอะไร ไม่ใช่แค่ "A เกี่ยวกับ B" |
| Model Reconstruction | จาก logs/behavior/output ย้อนสร้างภาพระบบภายใน |
| Intent Reconstruction | เดาว่าผู้สร้างตั้งใจให้ระบบทำอะไร เทียบกับสิ่งที่มันทำจริง |
| Requirement Recovery | reconstruct requirement จาก code/tests/docs/พฤติกรรม (spec หาย) |
| Missing-Constraint Discovery | หา constraint ที่ควรมีแต่ไม่มีใครระบุ |
| Constraint Discovery | หา constraint ที่ไม่ได้เขียนไว้ตรงๆ |
| Boundary Discovery | หา natural boundaries ของระบบเอง ไม่เชื่อ module/file layout ปัจจุบัน |
| Emergence Analysis | อธิบายพฤติกรรมที่เกิดจาก interaction ของหลายส่วน ไม่ใช่ component เดียว |
| Interface Contract Reconstruction | จากหลาย component อนุมาน contract ที่คาดหวังซึ่งกันและกัน |
| Specification Mining | ไม่มี spec → สกัด behavioral spec จาก execution/history/tests |
| Behavioral Specification Mining | สร้าง behavioral spec จาก tests/traces/logs/execution |
| Specification Repair Intelligence | spec vs ระบบจริงขัดกัน → ตัดสินว่าฝ่ายไหนผิดจาก evidence |
| Implicit Contract Discovery | หา contract ที่ไม่มีใน spec แต่ระบบถือเป็นจริง (ordering/timing/ownership) |
| Latent Dependency Mining | ค้น dependency ที่ไม่ได้ประกาศ (พึ่ง timing/cache/state ของ B แบบไม่รู้ตัว) |
| Dependency Graph Intelligence | อะไรพึ่งอะไร เปลี่ยน A แล้ว B/C/D โดนอะไร |
| Fault Provenance | จาก failure ย้อนกลับว่าเริ่มจากเหตุการณ์ไหน ผ่าน component ใดบ้าง |
| Hidden-State Reconstruction | จาก log/output บางส่วน ประมาณ state ภายในที่มองไม่เห็น |
| Unobservable Variable Reasoning | จัดการตัวแปรที่วัดตรงๆ ไม่ได้แต่มีผลต่อระบบ |
| Multi-Resolution Analysis | มอง instruction→function→process→service→machine→cluster→org สลับระดับเอง |
| Multi-Scale Reasoning | วิเคราะห์ phenomenon เดียวกันหลาย scale พร้อมกัน |
| Micro-to-Macro Reasoning | พฤติกรรมเล็กๆ รวมกันสร้าง behavior ใหญ่ได้อย่างไร |
| Macro-to-Micro Constraint Reasoning | constraint ระดับระบบใหญ่จำกัด component เล็กอย่างไร |
| Abstraction-Level Selection | โจทย์นี้ควรมองระดับ transistor/function/service/company/ecosystem |
| Ontology Discovery | domain ใหม่ → สร้างหมวดหมู่/ความสัมพันธ์ของ concept เอง |
| Ontology Repair | concept เดิมอธิบายข้อมูลไม่ได้ → จัด ontology ใหม่ |
| Semantic Drift Detection | คำ/metric เดียวกันเปลี่ยนความหมายตามเวลา |
| World-Model Reconciliation | code/docs/runtime/telemetry/พฤติกรรมบอกคนละเรื่อง → "โลกจริง" คืออันไหน |
| Causal Digital Twin | แบบจำลองเชิงเหตุผลของระบบจริง ทดลองเปลี่ยนตัวแปรก่อนแตะของจริง |
| Reality Alignment ⭐ | สิ่งที่ Agent เชื่อ → ใกล้ระบบจริงที่สุดตลอดเวลา ไม่ยึด docs/code/benchmark/คำพูดเป็น truth ตายตัว |
| Cross-Session Continuity | งานใหญ่รักษา model ของปัญหาไว้ ปรับเมื่อระบบเปลี่ยน ไม่เริ่มจากศูนย์ |
| World Model | representation ของปัญหา (Facts/Assumptions/Unknowns/Edges) |

### L2 — Causal Intelligence (20 ระบบ)

| ระบบ | หน้าที่ |
|---|---|
| Causal Reasoning Engine | แยก correlation ออกจาก cause/effect |
| Root-Cause Intelligence | ไล่เหตุหลายชั้น ไม่หยุดที่ symptom แรก |
| Second/Third-order Effects | วิเคราะห์ผลกระทบต่อเนื่องจาก decision |
| Cascade Prediction | ความผิดปกติเล็กๆ จะลุกลามถึงไหน |
| Failure Interaction Analysis | failure A+B แยกกันรับมือได้ แต่พร้อมกันพัง — จับ combination |
| Correlated Failure Detection | redundancy หลายชุดแต่พึ่ง power/network/provider เดียวกันไหม |
| Common-Cause Reasoning | error หลายตัวอาจมี root cause เดียวซ่อนอยู่ |
| Cross-System Causal Trace | firmware→driver→kernel→runtime→application→user behavior ไล่กลับได้ |
| Causal Discovery Without Labels | จาก observation อนุมาน causal structure โดยไม่มีคนกำหนดตัวแปรก่อน |
| Hierarchical Causal Reasoning | causal model หลายระดับ ไม่ใช่ graph แบน |
| Causal Intervention Design | เลือก intervention ที่แยก causal hypotheses ได้ดีที่สุด |
| Natural Experiment Detection | มองเห็นสถานการณ์ในข้อมูลจริงที่ใช้เป็น experiment ได้ |
| Confounder Discovery | หา third variable ที่ทำให้คิดว่า A→B ทั้งที่จริงไม่ใช่ |
| Collider / Selection Bias Awareness | ป้องกัน causal conclusion ผิดจากการเลือกข้อมูลผิด |
| Simpson's-Paradox Awareness | trend รวม vs แยกกลุ่มตรงข้ามกันได้ |
| Base-Rate Intelligence | ไม่ถูกกรณีเด่นหลอกจนลืมอัตราพื้นฐาน |
| Counterfactual Reasoning | "ถ้าไม่ทำ X จะเกิดอะไร", "ถ้า X ผิดสมมติฐานล่ะ" |
| Counterfactual Execution Reasoning | "ถ้าบรรทัด/parameter นี้ต่างออกไป ระบบควรตอบสนองอย่างไร" |
| Abductive Reasoning ระดับสูง | จากผลลัพธ์ที่เห็น ย้อนหา "คำอธิบายที่ดีที่สุด" พร้อมคู่แข่งหลายสมมติฐาน |
| Cross-Domain Analogy | หลักคิดจาก distributed systems ไปวิเคราะห์องค์กร — แต่ตรวจว่า analogy ใช้ได้จริง |
| Transfer Reasoning | นำความรู้จากระบบหนึ่งไปอีกระบบ รู้ว่าส่วนไหน transferable |

### L3 — Evidence & Epistemics (40 ระบบ)

| ระบบ | หน้าที่ |
|---|---|
| Hypothesis Engine | ตั้งหลายสมมติฐานแล้วหาหลักฐานหักล้าง |
| Evidence Weighting | หลักฐานแต่ละชิ้นไม่ได้น้ำหนักเท่ากัน |
| Evidence Independence Detection | 10 แหล่งอาจ copy มาจากต้นทางเดียวกัน ไม่ใช่หลักฐานอิสระ 10 ชิ้น |
| Source Reliability Modeling | ความน่าเชื่อถือขึ้นกับ domain/timing/ประวัติความแม่นยำ |
| Claim Decomposition | ประโยคเดียวหลายข้ออ้าง → แตกเป็น atomic claims ตรวจทีละข้อ |
| Evidence-to-Claim Matching | ไม่ให้ citation ดูดีแต่ไม่ได้พิสูจน์ claim |
| Negative Evidence Reasoning | "หาไม่เจอ" ≠ "ไม่มี" เสมอไป |
| Absence-of-Evidence Calibration | กรณีไหนการไม่มีหลักฐานมีน้ำหนักจริง |
| Bayesian Updating | หลักฐานใหม่ → อัปเดตความเชื่อ ไม่ reset ใหม่ทั้งหมด |
| Competing World Models | เก็บโลกจำลองหลายแบบจนหลักฐานพอตัดทิ้ง |
| Model Selection Intelligence | คำอธิบายง่ายพอแต่ยังอธิบายข้อมูลได้ดีที่สุด |
| Overfitting Detection (reasoning) | กันคำอธิบายซับซ้อนเพื่อเข้ากับข้อมูลไม่กี่จุด |
| Prediction Before Observation | ก่อน test บอกว่าแต่ละ hypothesis คาดว่าจะเห็นอะไร |
| Postdiction Audit | จับกรณีหาเหตุผลมารองรับผลที่รู้อยู่แล้ว |
| Surprise Detection | ผลจริงต่างจาก model มาก = สัญญาณ world model อาจผิด |
| Anomaly Reasoning | สิ่งผิดปกติ → "ผิดเพราะอะไร" ไม่ใช่แค่ flag |
| Anomaly Importance Ranking | anomaly ไหนเปลี่ยน model ของระบบ |
| Contradiction Detection | เจอข้อมูล/requirement ที่ชนกันเอง |
| Contradiction Resolution | ทำงานกับข้อมูลขัดแย้งโดยไม่เลือกฝั่งมั่ว |
| Cross-Layer Contradiction Detection | requirement ระดับ product ขัดกับ hardware/software constraints |
| Information Contamination Detection | หลักฐานหลายแหล่งมาจากต้นทางเดียวกัน |
| Provenance-Aware Analysis | น้ำหนัก evidence ขึ้นกับที่มา + chain ที่ถูกแปลงก่อนมาถึง |
| Telemetry Truth Assessment | log/metric/trace ไม่ใช่ truth อัตโนมัติ — ประเมิน coverage + bias |
| Missing Telemetry Discovery | ระบบ "มองไม่เห็นอะไรอยู่" และข้อมูลที่ขาดบัง root cause อยู่ไหม |
| Measurement Error Reasoning | ไม่ถือ sensor/log/benchmark เป็น truth โดยอัตโนมัติ |
| Observer Effect Awareness | การวัด/experiment อาจเปลี่ยนพฤติกรรมสิ่งที่วัด |
| Instrumentation Bias Detection | ภาพระบบบิดเพราะเก็บ telemetry ไม่ครบ |
| Simulation-vs-Reality Gap Analysis | simulation/test ต่างจากโลกจริงตรงไหน |
| Benchmark Validity Analysis | benchmark วัดสิ่งที่เราสนใจจริงหรือไม่ |
| Benchmark Forensics | คะแนนดีขึ้นเพราะระบบดีขึ้นจริง หรือ test conditions/caching/leakage |
| Adversarial Dataset Analysis | ข้อมูลผิด/stale/duplicate/cherry-picked หรือไม่ |
| Sampling Bias Detection | — |
| Survivorship Bias Detection | — |
| Publication/Reporting Bias Detection | — |
| Incentive-Induced Data Distortion | คนผลิตข้อมูลมีแรงจูงใจให้ข้อมูลออกมาแบบไหน |
| Strategic Data Interpretation | ข้อมูลจาก actor มีผลประโยชน์ → วิเคราะห์แรงจูงใจควบคู่ |
| Adversarial Evidence Robustness | conclusion ทนเมื่อข้อมูลบางชิ้นผิด/บิดเบือน |
| Minimal Evidence Reasoning | หลักฐานขั้นต่ำที่พอตัดสิน แทนเก็บไม่จบ |
| Information Value Estimation | ข้อมูลไหนจะเปลี่ยน conclusion มากที่สุด |
| Critical Evidence Identification | หลักฐานไม่กี่ชิ้นที่ถ้าเปลี่ยน → conclusion เปลี่ยนทั้งหมด |
| Knowledge Gap Prioritization | "อะไรที่ไม่รู้มีผลต่อคำตอบมากที่สุด" |
| Question Supremacy ⭐ | เลือกคำถามที่เมื่อได้คำตอบแล้ว เปลี่ยนความเข้าใจระบบมากที่สุด |
| Optimal Question Generation | ถามคำถามที่ลด uncertainty มากสุด |
| Active Learning | เลือกข้อมูล/experiment ใหม่เพื่อความเข้าใจสูงสุด |
| Identifiability Awareness | รู้ว่าโจทย์ไหนข้อมูลที่มี "แยกคำตอบ A กับ B ไม่ได้จริง" แทนที่จะฝืนตอบ |
| Assumption Mining | ตรวจสมมติฐานที่คน/Agent กำลังถืออยู่ |
| Belief Revision | ข้อสรุประดับฐานผิด → แก้ conclusion ที่พึ่งมันทั้งหมดต่อเนื่อง |
| Dependency-aware Belief Update | เปลี่ยนความเชื่อ → propagate ผ่าน dependency graph ไม่ใช่ update claim เดียว |
| Optimal Instrumentation Planning | เพิ่ม logging/metrics/tracing เลือกจุด information gain สูงสุด ไม่ใช่เปิดทุกอย่าง |
| Experiment Cost Awareness | เลือกทดลองที่ให้ข้อมูลสูงแต่ใช้ compute/time/risk ต่ำ |

### L4 — Adversarial & Self-Challenge (20 ระบบ)

| ระบบ | หน้าที่ |
|---|---|
| Adversarial Interpretation | ตีความข้อมูลอีกแบบที่ทำให้ conclusion เดิมผิด |
| Steelman Competing Conclusions | สร้างเหตุผลแข็งสุดของ conclusion ฝั่งตรงข้าม |
| Disconfirmation Priority | ให้ความสำคัญกับ evidence ที่ทำลาย hypothesis มากกว่าแค่สนับสนุน |
| Counterexample Search | conclusion แบบ universal → หาตัวอย่างเดียวที่ทำให้มันผิด |
| Counterexample Prioritization | หาเคสที่ทำให้พังมากที่สุดก่อน |
| Assumption Stress Testing | เปลี่ยน assumption ทีละตัว ดู conclusion ยังเหมือนเดิมไหม |
| Model Fragility Analysis | conclusion เปราะต่อ assumption ไหน |
| Conclusion Stability Score | คำตอบแข็งแรงต่อข้อมูล/assumption ที่เปลี่ยนเล็กน้อยแค่ไหน |
| Conclusion Sensitivity Map | assumption A เปลี่ยน → conclusion เปลี่ยนมากแค่ไหน |
| Assumption-Free Restart | ติดกรอบ → ทิ้ง model เดิม เริ่มจาก evidence ใหม่ |
| First-Principles Decomposition | ความรู้เดิมไม่น่าเชื่อถือ → วิเคราะห์จากข้อจำกัดพื้นฐาน |
| Paradigm Competition | เก็บกรอบคิดสองแบบที่อธิบายโลกต่างกัน ให้ evidence เลือก |
| Paradigm Replacement | evidence สะสมจน model เก่าใช้ไม่ได้ → กล้าทิ้ง framework เดิมทั้งชุด |
| Minority Hypothesis Preservation | hypothesis probability ต่ำแต่ impact สูง เก็บไว้จนมีหลักฐานตัดออก |
| Consensus Without Groupthink | รวมหลายมุมมองโดยไม่ให้เสียงข้างมากกลืน minority ที่อาจถูก |
| Disagreement Mining | disagreement = information ไม่ใช่ noise — หา assumption ที่ทำให้คำตอบต่างกัน |
| Model Ensemble Reasoning | หลาย model วิเคราะห์ปัญหาเดียวกัน หาจุด disagreement |
| Independent Judge | ตัวหา conclusion กับตัวตัดสินแยกกัน |
| Self-Critique ที่มีหลักฐาน | บอกจุดอ่อนของ conclusion ว่าอยู่ตรงไหน ไม่ใช่แค่ "อาจผิด" |
| Self-Diagnostic Intelligence | วิเคราะห์ว่า "ฉันกำลังใช้วิธีวิเคราะห์ผิดประเภทหรือไม่" |
| Method Failure Recognition | รู้เมื่อ approach ปัจจุบันเดินต่อแล้ว information gain ต่ำ |
| Reasoning Mode Switching | Bayesian ไม่เหมาะ → เปลี่ยน causal/formal/simulation/first-principles |
| Method Selection Intelligence | รู้ว่าจะใช้วิธีไหนกับโจทย์ไหน |
| Method Composition | statistics + causal + simulation + formal verification ร่วมกัน |
| Novel Analytical Method Synthesis | เครื่องมือ reasoning ที่มีไม่เหมาะ → สร้างกระบวนการใหม่ |
| Meta-Scientific Reasoning | วิเคราะห์ความน่าเชื่อถือของวิธีที่ใช้ศึกษา phenomenon |
| Analysis of Analysis | ตรวจว่าการวิเคราะห์รอบนี้เสียเวลาตรงไหน evidence อ่อนตรงไหน |
| Independent Rediscovery | งานสำคัญ: เริ่มรอบสองจากศูนย์ไม่เห็น conclusion เดิม แล้วเทียบผล |

### L5 — Systems & Dynamics (20 ระบบ)

| ระบบ | หน้าที่ |
|---|---|
| Feedback-Loop Intelligence | positive/negative feedback loops + ผลสะสมระยะยาว |
| Threshold Detection | tipping point ที่ระบบเปลี่ยนพฤติกรรมฉับพลัน |
| Phase-Transition Reasoning | ระบบที่พฤติกรรมเปลี่ยนฉับพลันเมื่อผ่าน threshold |
| Chaotic-System Awareness | สถานการณ์บางประเภททำนายไกลไม่ได้แม้ model ดี |
| Regime Change Detection | "กฎเดิมของระบบใช้ไม่ได้แล้ว" (workload/environment เปลี่ยน) |
| Nonlinear Reasoning | input 2 เท่า ≠ ผล 2 เท่า |
| Fragility Detection | ระบบดูปกติแต่พึ่ง assumption บางอย่างมากจนเปราะ |
| Robustness Analysis | input/environment/workload เปลี่ยน ระบบยังดีแค่ไหน |
| Sensitivity Analysis | ตัวแปรไหนเปลี่ยนนิดเดียวแล้วส่งผลทั้งระบบ |
| Critical Parameter Discovery | parameter ที่ควบคุม outcome จริง |
| Bottleneck Migration Prediction | แก้ bottleneck A → bottleneck ถัดไปจะไปเกิดที่ไหน |
| Optimization Side-Effect Prediction | ปรับ performance จุดหนึ่ง → จุดอื่นเสียอะไร |
| Scale Transition Intelligence | ดีสำหรับ 1K users อาจพังที่ 10M — ทำนายจุดที่ design ต้องเปลี่ยน |
| Architecture Fitness Reasoning | ไม่ถามว่า "ดีไหม" แต่ "ดีสำหรับ workload/เป้าหมายนี้ไหม" |
| Architecture Breakpoint Prediction | scale/workload ระดับไหน architecture ต้องเปลี่ยน paradigm |
| Optimization Ceiling Detection | ใกล้เพดานแล้ว จูนต่อไม่คุ้ม |
| Emergent Requirement Discovery | จากการใช้งานจริงพบ requirement ที่ไม่มีใครเขียน |
| Semantic Regression Detection | test ผ่านหมดแต่ behavior สำคัญเปลี่ยน |
| Cross-Layer Bottleneck Localization | อาการที่ application แต่สาเหตุอาจอยู่ compiler/kernel/RAM/PCIe/GPU/network/scheduling — ไล่ทะลุ layer |
| Behavioral Equivalence Analysis | implementation สองตัว code ต่างกันแต่ทำงานเท่ากันจริงไหม |
| Invariant Discovery | จากระบบจริง ค้นหากฎที่ "ควรจริงเสมอ" เอง |
| Invariant Mining from Reality | สังเกตระบบแล้วค้น property ที่ดูเหมือนต้องจริงเสมอ |
| Invariant Evolution | invariant บางข้อใช้กับรุ่นเก่า แต่ไม่ควรบังคับรุ่นใหม่ |
| Invariant Violation Attribution | invariant พังเพราะอะไร ไม่ใช่รู้แค่ว่าพัง |
| Temporal Analysis | เหตุการณ์ก่อน/หลัง, trend, regression, state evolution |
| Semantic Diff | "ความหมายของระบบเปลี่ยนอะไร" ไม่ใช่ diff บรรทัด |

### L6 — Decision Intelligence (30 ระบบ)

| ระบบ | หน้าที่ |
|---|---|
| Decision Intelligence | recommendation พร้อม evidence + uncertainty |
| Trade-off Intelligence | Performance/Cost/Reliability/UX/Complexity/Security |
| Multi-Objective Intelligence | optimize หลายเป้าหมายโดยไม่ซ่อน trade-off |
| Pareto Reasoning | บางครั้งไม่มี "ดีที่สุด" — มีแต่ชุด Pareto-optimal |
| Constraint Negotiation | requirement ทั้งหมดเป็นไปไม่ได้ → บอก constraint ไหนควรคลาย |
| Goal Conflict Detection | จับเป้าหมายขัดกันตั้งแต่ต้น |
| Goal Integrity Checking | Action Plan ยังตอบเป้าหมายเดิม ไม่หลุดระหว่างทาง |
| Metric Gaming Detection | optimize metric ทำให้เป้าหมายจริงแย่ลงไหม |
| Goodhart Awareness | metric กลายเป็นเป้าหมาย → สงสัย reliability ของ metric |
| Metric Causality | metric X ลด มีผลต่อ objective จริงหรือไม่ |
| Metric Replacement Intelligence | metric ไม่สะท้อนเป้าหมาย → เสนอ metric ใหม่ |
| Decision Robustness | เลือก decision ที่ยังดีแม้สมมติฐานบางอย่างผิด |
| Minimax Regret Reasoning | uncertainty สูง → ลดความเสียใจสูงสุดเมื่อคาดผิด |
| Option Value Intelligence | ให้ค่าทางเลือกที่ยังเปิดโอกาสเปลี่ยนใจภายหลัง |
| Irreversibility Awareness | action ย้อนยาก → ต้องการหลักฐานมากขึ้นเอง |
| Timing Intelligence | decision ถูกแต่ผิดเวลา = decision แย่ |
| Wait-vs-Act Reasoning | คำนวณว่ารอข้อมูลเพิ่มหรือลงมือทันที |
| Path Dependency Analysis | decision วันนี้ล็อกทางเลือกอนาคต — เห็นผลก่อนตัดสิน |
| Long-Horizon Reasoning | ผลหลายเดือน/ปี แยกสิ่งที่มั่นใจ vs speculative |
| Scenario Branching | ไม่ทำนายเส้นเดียว — สร้างหลาย trajectory |
| Scenario Tree | แตกหลายอนาคต + probability/confidence |
| Leading Indicator Discovery | signal ที่บอกอนาคตก่อน metric หลักเปลี่ยน |
| Failure Pre-mortem | ก่อน action — ถ้าล้ม สาเหตุที่เป็นไปได้คืออะไร |
| Success Post-mortem | สำเร็จเพราะแผนจริงหรือโชค — ไม่เรียนรู้ผิด |
| Outcome Attribution | แยกผลสำเร็จมาจาก action ไหน |
| Intervention Effect Estimation | "ระบบดีขึ้นเอง" vs "ดีขึ้นเพราะเราแก้" |
| Learning From Near-Misses | เกือบพังแต่ไม่พัง — ยังต้องเรียนรู้ |
| Counterfactual Evaluation หลัง Action | ถ้าไม่ทำ action นี้ ผลน่าจะเป็นอย่างไร |
| Execution Feedback Attribution | ผลดี/แย่เกิดจาก analysis/plan/execution/environment |
| Surprise-Driven Reanalysis | ผลจริงผิดจาก prediction มาก → ทบทวน world model |
| Action Failure Prediction | ทำนายได้ว่าแผนนี้มีแนวโน้มล้มตรงไหน |
| Plan Assumption Audit | Action Plan เดิมพันกับ assumption อะไร |
| Robust Recommendation | ทางที่ดีในหลาย scenario แทนที่ดีสุดเฉพาะ prediction เดียว |
| Decision Boundary Discovery | เงื่อนไขที่ recommendation พลิกจาก A → B |
| Decision Boundary Mapping | — |
| Decision Traceability | ตอบย้อนหลังได้ว่า "ทำไมตอนนั้นถึงเลือก X" |
| Stakeholder Perspective Modeling | decision เดียวกันส่งผลต่อ engineer/user/company ต่างกัน |
| Incentive Analysis | กฎ/ระบบใหม่ผลักคนเปลี่ยนพฤติกรรมอย่างไร |
| Strategic Adversarial Reasoning | คู่แข่งปรับตัวตาม decision ของเรา — คิด response เขาด้วย |
| Recursive Strategy | "ถ้าเราทำ X เขาทำ Y เราควรทำ Z" |
| Human-System Analysis | ปัญหาจาก process/incentives/human behavior ไม่ใช่ technology อย่างเดียว |
| Organizational Bottleneck Detection | ระบบดีแต่ช้าเพราะ approval/ownership/communication |
| Socio-Technical Reasoning | คน + software + hardware + process เป็นระบบเดียว |
| Novel Solution Synthesis | ทางเลือกเดิมไม่ดีทั้งหมด → สร้างทางเลือกใหม่ |
| Constraint-Breaking Discovery | แยก constraint จริงจาก convention |
| Paradigm Shift Detection | optimize เดิมไม่คุ้ม → เปลี่ยนแนวคิดทั้งชุด |
| Systemic Risk Analysis | ปัญหาเล็กๆ หลายจุดรวมกันสร้าง risk ใหญ่ |
| Concentration Risk Analysis | resource/knowledge/dependency กระจุกตัวเกินไป |
| Resilience Reasoning | ไม่ถามแค่ว่าป้องกัน failure ได้ไหม แต่ฟื้นตัวได้เร็วแค่ไหน |
| Graceful Degradation Analysis | ระบบเสียบางส่วน → ลดความสามารถอย่างไรแทนพังทั้งระบบ |
| Recovery Path Intelligence | วิเคราะห์เส้นทางกลับสู่สถานะปกติก่อนเกิดเหตุจริง |

### L7 — Prediction & Uncertainty (15 ระบบ)

| ระบบ | หน้าที่ |
|---|---|
| Confidence Calibration | Known/Likely/Uncertain/Unknown — 90% ต้องแปลว่าหลักฐานแข็ง |
| Confidence Decomposition | ความไม่มั่นใจมาจาก data/model/assumption/measurement/reasoning ไหน |
| Forecast Horizon Estimation | ควรเชื่อการทำนายได้ไกลแค่ไหน |
| Prediction Interval Intelligence | ให้ช่วงที่เป็นไปได้ ไม่ใช่เลขเดียว |
| Deep Uncertainty Reasoning | โจทย์ที่แม้ probability ก็ประเมินไม่ได้ดี |
| Unknown-Unknown Budgeting | ส่วนไหน coverage ต่ำจนควรเผื่อ margin |
| Unknown-Unknown Hunter | ไม่จำกัดที่ checklist — ค้นหาสิ่งที่ยังไม่รู้ว่ามี |
| Tail-Risk Intelligence | เหตุการณ์โอกาสต่ำแต่ผลกระทบสูง แยกจากความเสี่ยงปกติ |
| Black-Swan Sensitivity | ส่วนไหนของ conclusion พังง่ายสุดถ้ามีเหตุการณ์ที่ model ไม่เคยเห็น |
| Rare-Event Intelligence | ไม่มองข้าม failure 1 ในล้านครั้งถ้า impact สูง |
| Probabilistic Failure Reasoning | race/intermittent fault/distributed timing วิเคราะห์แบบ probability |
| Model Mismatch Detection | model ที่ใช้วิเคราะห์อธิบายโลกจริงไม่ได้แล้ว |
| Open-World Reasoning | เผื่อ possibility ที่ solution/root cause ยังไม่ถูกค้นพบ |
| Out-of-Distribution Awareness | input ไม่เหมือนที่เคยวิเคราะห์ → ลด confidence เอง |
| Generalization Boundary Detection | ความรู้จากสถานการณ์หนึ่งใช้ได้ถึงขอบเขตไหน |
| Temporal Validity | conclusion ใช้ได้กับ version/config/time period ไหน |
| Knowledge Drift Awareness | ความจริงที่เคยถูกอาจหมดอายุเมื่อระบบเปลี่ยน |
| Re-analysis Trigger Intelligence | change ประเภทไหนใหญ่พอให้ conclusion เก่าต้องตรวจใหม่ |
| Semantic Memory Compression | เก็บ "สิ่งที่เรียนรู้" เป็นกฎ/constraint/model กลับมาใช้ได้ |
| Explanation Fidelity | ย่อ reasoning ให้อ่านง่ายโดยไม่เปลี่ยนสาเหตุ |

### L8 — Formal & Scientific (25 ระบบ)

| ระบบ | หน้าที่ |
|---|---|
| Mechanistic Reverse Engineering | เห็น output/behavior → อนุมานกลไกภายในแม้ไม่มีเอกสาร |
| Theory Formation | ไม่แค่ hypothesis — สร้าง "ทฤษฎีของระบบ" อธิบายหลายปรากฏการณ์ด้วยกฎชุดเดียว |
| Theory Unification | คำอธิบายหลายชุด → รวมเป็นชุดเดียวด้วย assumption น้อยสุด |
| Theory Falsification | ทุกทฤษฎีต้องบอก "หลักฐานแบบไหนจะพิสูจน์ว่าฉันผิด" |
| Novel Law Discovery | จากข้อมูลจำนวนมาก หา relationship/กฎใหม่ |
| Novel Variable Discovery | ตัวแปรที่มนุษย์กำหนดไม่พอ → สร้างตัวแปรใหม่ |
| Novel Hypothesis Synthesis | ผสม evidence สร้างคำอธิบายใหม่ ไม่จำกัด pattern ที่รู้จัก |
| Novel Test Synthesis | ไม่มี benchmark เหมาะ → ออกแบบวิธีวัดใหม่ |
| Analysis Method Invention | สร้างกระบวนการวิเคราะห์เฉพาะโจทย์ |
| Formal Consistency Checking | ข้อสรุปหลายข้อเป็นจริงพร้อมกันได้หรือไม่ |
| Proof-Oriented Analysis | โจทย์ต้องการความแน่นอนสูง → probabilistic → formal |
| Proof Obligation Discovery | ข้ออ้างไหนต้องพิสูจน์จริง ข้อไหนใช้ statistical evidence พอ |
| Proof Gap Detection | ตรงไหน "เกือบพิสูจน์ได้" แต่ขาด assumption/evidence |
| Formal + Empirical Hybrid Reasoning | พิสูจน์ได้ก็พิสูจน์ ที่เหลือใช้ measurement ไม่ปนความมั่นใจสองแบบ |
| Physical-Limit Awareness | ไม่เสนอ solution ที่ละเมิด bandwidth/latency/thermodynamics |
| Semantic Requirement Feasibility | อ่าน requirement แล้วรู้ตั้งแต่ต้นว่าส่วนไหนขัด physics/compute/cost/time |
| Information-Theoretic Reasoning | entropy/information gain วิเคราะห์ bottleneck/uncertainty |
| Complexity Awareness | ปัญหาแบบ polynomial/exponential — ดีตอนเล็กอาจใช้ไม่ได้ตอน scale |
| Algorithmic Lower-Bound Awareness | performance บางอย่างลดต่อไม่ได้ |
| Approximation Intelligence | เมื่อไร approximate คุ้มกว่า exact |
| Precision Budgeting | แม่นยำสูงเฉพาะจุดที่ไวต่อ error |
| Numerical Stability Reasoning | error เล็กๆ สะสมจนผลผิด |
| Numerical Behavior Intelligence | precision loss/accumulation/quantization ที่ทำให้ผลต่างทั้ง logic ถูก |
| Computational Cost Reasoning | decision ส่งผล compute/memory/network/storage อย่างไร |
| Energy/Power Intelligence | performance-per-watt + ข้อจำกัดพลังงาน |
| Thermal-aware Analysis | performance degradation จาก thermal |
| Energy–Latency–Throughput Reasoning | trade-off 3 ด้านพร้อมกัน (AI/HPC) |
| Memory-Hierarchy Intelligence | cache locality/NUMA/accelerator memory/movement cost |
| Data-Movement Analysis | บางระบบย้ายข้อมูลแพงกว่า compute |
| Compute Placement Intelligence | CPU/GPU/NPU/edge/cloud ตรงไหน |
| Hardware–Software Co-Design Reasoning | เปลี่ยน algorithm ดีกว่าเพิ่ม GPU หรือกลับกัน |
| Hardware Performance Attribution | แยก compute/cache/memory BW/I-O/scheduling/thermal/software |
| Software Performance Attribution | algorithmic/lock/GC/allocation/serialization/network |
| Compiler/Runtime Attribution | optimizer/runtime/GC/JIT/linker/ABI ไม่ใช่ source |
| Workload Characterization | CPU-bound/memory-bound/I-O-bound/sync-bound/model-bound |
| Resource Coupling Intelligence | CPU/memory/BW/storage/thermal/power เชื่อมกัน — ไม่ optimize แยก |
| AI-System Analysis | model+tokenizer+inference+quantization+GPU+memory+serving เป็นระบบเดียว |
| Model Failure Attribution | hallucination จาก model/context/retrieval/tool/prompt/orchestration |
| Agent Failure Attribution | planning/reasoning/memory/tool selection/execution/verification |
| Reasoning Error Taxonomy Discovery | สร้างหมวด reasoning mistakes จากพฤติกรรมจริงของ Agent |

### L9 — Discovery & Meta (15 ระบบ)

| ระบบ | หน้าที่ |
|---|---|
| Discovery Intelligence ⭐ | ไม่รอให้มนุษย์ถาม — ค้นพบเองว่า "ปัญหาที่ควรสนใจจริงไม่ใช่ X แต่เป็น Y" |
| Discovery-before-Answer ⭐ | ก่อนตอบ: มีปัญหาที่สำคัญกว่าคำถามซ่อนอยู่หรือไม่ |
| Autonomous Discovery ⭐ | ตรวจข้อมูลแล้วค้นเองว่า phenomenon ไหนผิดปกติหรือมีค่า |
| Autonomous Theory Building ⭐ | สร้าง model อธิบาย behavior เอง → ทำนายสิ่งที่ยังไม่เห็น → ผิดก็แก้ทฤษฎี |
| Novel Pattern Discovery | หา pattern ที่ไม่ได้อยู่ใน checklist |
| Information Bottleneck Discovery | หาไม่ใช่ compute bottleneck แต่ "ข้อมูลที่จำเป็นขาดตรงไหน" |
| Stopping Intelligence | รู้ว่าเมื่อไรข้อมูลเพิ่มไม่คุ้มและควรตัดสิน |
| Reasoning Budget Allocation | reasoning หนักเฉพาะส่วนที่มีผลต่อ conclusion มากสุด |
| Depth-on-Demand | งานเล็กตอบเร็ว ปัญหาระดับ system ขุดหลายชั้นเอง |
| Analysis Compression | คิดลึกมาก → compress เป็นข้อสรุปที่มนุษย์เข้าใจง่าย ไม่เสียสาระ |
| Audience-Adaptive Explanation | engineer/executive/researcher ระดับรายละเอียดต่างกัน |
| Traceable Conclusion | conclusion ทุกข้อย้อนหา evidence/assumption ได้ |
| Reproducible Analysis | Agent อื่นได้ evidence เดียวกัน reproduce เส้นทางตัดสินหลักได้ |
| Analysis Reliability Score | คะแนนจาก evidence coverage/assumption count/disagreement/stability |
| Meta-Analysis Quality Control | ประเมินตัวเอง: เสียเวลาตรงไหน หลักฐานอ่อนตรงไหน reasoning shortcut ตรงไหน |
| Analysis Debt Detection | ข้อสรุปไหนถูกใช้ต่อทั้งที่ยังไม่ validate = "หนี้ทางความเข้าใจ" |

## 9. สามเป้าหมายสุดขอบ

| เป้าหมาย | ความหมาย |
|---|---|
| **Autonomous Theory Building** | รับระบบไม่รู้จัก → สร้าง model อธิบาย behavior → ทำนายสิ่งที่ยังไม่เห็น → ทำนายผิดก็แก้ทฤษฎี ไม่ใช่แค่แก้คำตอบ |
| **Autonomous Discovery** | ไม่ต้องมีคนบอก "หา bug นี้" — ตรวจข้อมูลแล้วค้นพบเองว่า phenomenon ไหนผิดปกติหรือมีค่า |
| **Reality Alignment** | จุดสูงสุด: สิ่งที่ Agent เชื่อ → ใกล้ระบบจริงที่สุดตลอดเวลา ไม่ยึด docs/code/benchmark/คำพูดมนุษย์เป็น truth ตายตัว |

## 10. สิ่งที่โหมดนี้ต้องทำได้ (30 ความสามารถหลัก — สรุปจากเจ้าของโปรเจกต์)

1. เข้าใจปัญหาซับซ้อนมากได้เอง แม้ข้อมูลกระจัดกระจาย/ไม่ครบ/หลายโดเมนปนกัน
2. จับต้นเหตุจริง ไม่ติดอาการ แยก root cause จากผลข้างเคียง
3. วิเคราะห์ข้าม Hardware+Software+Data+Infra+Product+Strategy ในโจทย์เดียวกัน
4. แยก Fact/Inference/Assumption/Unknown — ไม่มั่วเติมช่องว่าง
5. ตั้งสมมติฐานหลายทาง ตัดทิ้งด้วย evidence แทนยึดคำตอบแรก
6. มองผลกระทบหลายชั้น (ทันที/second-order/third-order/ระยะยาว)
7. เข้าใจระบบทั้งก้อน ไม่ใช่ไฟล์/component เดียว
8. หา dependency ซ่อน + bottleneck/จุดที่ทั้งระบบพึ่งมากเกินไป
9. คาดการณ์ผลก่อนลงมือ + บอกได้ว่ามั่นใจแค่ไหน
10. สร้างหลายทางเลือก ตัดสินได้ว่าแบบไหนเหมาะสุดภายใต้ constraint จริง
11. เปลี่ยนใจได้เมื่อหลักฐานใหม่มา
12. รู้เมื่อไม่ควรตัดสิน + ข้อมูลอะไรให้ information gain สูงสุด
13. ทำงานกับข้อมูลขัดแย้งโดยไม่เลือกฝั่งมั่ว
14. ตรวจจับ assumption ที่ถูกถือเป็น "เรื่องปกติ"
15. causal reasoning จริง ไม่สับสน correlation กับ causation
16. วิเคราะห์ failure chain หลาย hop (hardware เริ่ม → application แสดงอาการ)
17. เห็น emergent behavior จากหลาย subsystem ที่ไม่มีใครผิดเดี่ยวๆ
18. เปรียบเทียบทางเลือกยุติธรรม (normalize constraint + evidence ก่อน)
19. เข้าใจหลาย objective ที่ขัดกัน ไม่หลง metric เดียว
20. บอกไม่รู้ได้แม่น + รู้ว่า uncertainty มาจากไหน
21. confidence แบบ calibrated — 90% = หลักฐานแข็งจริง
22. แยก reversible/irreversible decisions
23. recommendation ใช้ได้จริง ไม่ใช่บทวิเคราะห์สวยๆ
24. ส่ง Action Plan ให้ LoopFocus ลงมือได้ + success/failure criteria
25. ดูผลหลังลงมือ วิเคราะห์ใหม่ ถ้าผลไม่ตรง prediction หา assumption ที่ผิด
26. เรียนรู้จากการวิเคราะห์ที่พลาด
27. หักล้างคำตอบตัวเองก่อนเชื่อ conclusion
28. ค้นหา unknown-unknowns ไม่จำกัด checklist
29. Research-grade / Engineering-grade / Executive-grade
30. เชื่อม technical reality กับ cost/time/risk/โอกาสธุรกิจ

## 11. โครงสร้างไฟล์ (Docs + Identity ของตัวเอง)

```
modes/analysis-intelligence/
├── IDENTITY.md
├── DOCS.md
├── references/
│   ├── L1-understanding/
│   ├── L2-causal/
│   ├── L3-evidence/
│   ├── L4-adversarial/
│   ├── L5-systems/
│   ├── L6-decision/
│   ├── L7-prediction/
│   ├── L8-formal/
│   └── L9-discovery/
├── flow/
├── prompts/
└── tools/
```

## 12. Tools ที่วางแผน (เฟส implementation)

- analysis-router.js — intent detection + dynamic composition + escalation L0-L7
- epistemic-tagger.js — ติดป้าย FACT/INFERENCE/ASSUMPTION/HYPOTHESIS/UNKNOWN/CONTRADICTION ให้ทุกข้อความ
- conclusion-score.js — Analysis Reliability Score + confidence decomposition
- mesh-dispatcher.sh — Analysis Mesh (analysts แยกอิสระรอบแรก)
- question-engine.js — Question Supremacy / optimal question generation
- counterfactual-runner.js — assumption stress testing + conclusion stability
- (ต่อยอดจาก tools ที่มี: world-model, semantic-diff, counterexample, convergence...)

## 13. แผนการทดสอบ (TDD)

- RED: scenario "วิเคราะห์ปัญหาซับซ้อนข้ามโดเมน" แบบไม่มีสกิล — วัด: ตอบเร็วเกินไป, สับสน correlation/causation, ไม่แยก epistemic classes, ไม่หักล้างตัวเอง
- GREEN: scenario เดียวกัน — ต้องเห็น epistemic tags, หลาย hypothesis, counterfactual challenge, Independent Judge แยก, convergent loop
- Machine tests: ทุก tool ใหม่ (router/epistemic/mesh/question)
- REFACTOR: rationalization hunt

## 14. สิ่งที่ยังจะเพิ่ม (รอ input จากเจ้าของโปรเจกต์)

- (เปิดรับ — เติมใน v2)
