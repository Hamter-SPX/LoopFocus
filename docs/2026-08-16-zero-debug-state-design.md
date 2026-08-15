# Zero Debug State — Design Spec v1

วันที่: 2026-08-16
สถานะ: Draft v1 (รวบรวมจากเจ้าของโปรเจกต์ — ~560 ระบบ รอรีวิว)
ตำแหน่ง: โหมด zero-debug-state ของ LoopFocus — หน่วยสมบูรณ์ในตัว

---

## 1. Identity

> **Zero Debug State — Engineering toward systems where correctness is enforced by construction, invalid states are eliminated at the source, and debugging becomes an exception rather than the development model.**

ไม่ใช่ Debug Mode ที่เก่งขึ้น — แต่เป็นคนละปรัชญา:
- ไม่รอให้ bug เกิดแล้วค่อยหา แต่ทำให้ความผิดพลาดบางประเภท "เกิดไม่ได้ตั้งแต่แรก"
- หรือถ้าเกิด ต้องถูกจับได้ก่อนกลายเป็น behavior จริง

**แก่น 6 คำ**: Understand → Model → Constrain → Construct → Prove → Preserve

**กฎสูงสุด**: *If you cannot explain the structure you are modifying, you are not yet allowed to modify it.*

**ปรัชญาที่ต่างจาก systematic-debugging ชัดเจน:**
| Systematic Debugging | Zero Debug State |
|---|---|
| Bug exists → investigate → root cause → fix | Design → constrain invalid states → prove → execute → continuously verify → debugging rarely necessary |

## 2. Doctrine (4 ข้อ)

1. **Understand before change.**
2. **Constrain before execute.**
3. **Prove before trust.**
4. **Convert every defect into a permanent guarantee.**

เป้าหมายระยะสุดท้าย: ไม่ใช่แค่ "ไม่มี known bugs" แต่ **ลดจำนวนสิ่งที่ระบบต้องหวังว่าจะทำถูก เปลี่ยนให้กลายเป็นสิ่งที่ระบบถูกบังคับให้ทำถูก**

## 3. เป้าหมายระดับสูงสุด (5 ตัว)

| เป้าหมาย | ความหมาย |
|---|---|
| **Correctness Gradient** | ไม่ใช่ "ถูก/ผิด" อย่างเดียว — รู้ว่าแต่ละ subsystem มี guarantee ระดับไหน: Unverified → Tested → Property Verified → Model Checked → Formally Constrained → Proven/Construction-Enforced แล้วพยายามเลื่อนส่วน critical ไปทางขวา |
| **Defect Entropy Reduction** | มอง bug เป็น "จำนวนสถานะผิดที่ระบบอนุญาตให้เกิดขึ้นได้" — ทุกการปรับ architecture ต้องทำให้ invalid states ที่ representable ลดลง |
| **Correctness Closure** | Instance Fixed → Root Cause → Bug Class → Constraint Added → Verification Added → Architecture Rechecked → Same Class Cannot Recur — งานยังไม่ปิดจน loop นี้ครบ |
| **Proof Before Trust** | ไม่เชื่อเพราะผ่านครั้งเดียว — เชื่อเพราะระบบอธิบายได้ว่าทำไมมันต้องถูกต่อไป Test ผ่านเป็น evidence แต่ไม่ใช่เหตุผลสูงสุด |
| **Debugging Becomes a Failure Signal** | ถ้าต้องเปิด debugger บ่อย = architecture/spec/observability/invariant ออกแบบไม่ดี — ต้องถามว่า "ทำไม bug นี้ถึงต้องใช้ debugging ถึงจะค้นพบได้?" แล้วปรับระบบ |

## 4. Signatures (3 ตัว)

1. **Understandability as a Correctness Property** — ระบบที่ตรวจสอบความถูกต้องไม่ได้ง่ายพอ = ยังไม่ถึง Zero Debug State
2. **Repair Must Reduce Future Debugging** — ทุกการแก้ต้องตอบได้ว่า "หลังแก้ครั้งนี้ ปัญหาประเภทใดจะไม่ต้องใช้ debugger อีก?" ถ้าตอบได้แค่ "bug นี้หาย" = ยังไม่สุด
3. **Zero-Debug Exit Criterion** — นิยามชัดว่าเมื่อไรถึง "เข้าสู่ state นี้" (ดู section 5)

## 5. Zero-Debug Exit Criterion

```
Known structural defects        = 0
Known invariant violations      = 0
Unexplained critical behavior   = 0
Unresolved root causes          = 0

Critical contracts             = verified
Critical state transitions     = verified
Relevant architecture          = understood
Blast radius                   = understood
Repair invariants              = verified
Regression protections         = encoded
Runtime behavior               = conforms
Outstanding assumptions        = explicit
Critical unknowns              = 0
```

"Zero" ไม่ได้แปลว่า "รับประกันว่าไม่มี bug ตลอดกาล" — แปลว่า **ไม่มี known defect หรือ unexplained correctness gap ที่ปล่อยให้มนุษย์ต้องมานั่ง debug แบบเดาสุ่ม และ defect ที่ค้นพบถูกเปลี่ยนเป็น knowledge → constraint → guarantee เพื่อให้ bug class นั้นหายไปจากพื้นที่ที่เป็นไปได้**

## 6. Correctness Gradient (6 ระดับ)

Unverified → Tested → Property Verified → Model Checked → Formally Constrained → Proven/Construction-Enforced

## 7. Repair Permission Gradient (อำนาจเพิ่มตามความเข้าใจ)

| ระดับความเข้าใจ | สิทธิ์ |
|---|---|
| Low understanding | Observe only |
| Moderate understanding | Reversible experiments |
| High understanding | Local repair |
| Verified structural understanding | Architecture changes |
| Proof-level understanding | Critical irreversible changes |

## 8. Proof of Comprehension (ก่อนได้สิทธิ์แก้ subsystem สำคัญ)

ต้องทำได้ครบ: Predict behavior · Explain ownership · Trace data · Trace state · Trace control · Identify contracts · Identify invariants · Identify unknowns · Predict blast radius · Explain why alternative repair locations are wrong
ทำไม่ได้ครบ = ยังอยู่ใน Understand State ไม่ใช่ Repair State

## 9. Pipeline (แทน Write → Run → Break → Debug → Patch)

```
Observe → Reconstruct System → Understand Intent
→ Map Dependencies → Map State + Data + Control Flow
→ Discover Contracts / Invariants / Assumptions
→ Locate Structural Root Cause → Predict Impact
→ Design Repair → Prove Repair Fits Architecture
→ Implement → Verify
```

และสำหรับงานใหม่: **Prevent → Prove → Construct → Execute → Verify**

## 10. ระบบทั้งหมด (จัดเป็น 6 ชั้นตามแก่น 6 คำ)

### L1 — Understand (Comprehension Precedes Intervention) — ~120 ระบบ

| ระบบ | หน้าที่ |
|---|---|
| Structural Comprehension Gate | ก่อนแก้ต้องผ่าน gate ว่าเข้าใจ architecture/boundaries/dependencies/state/data flow พอหรือยัง |
| System Topology Reconstruction | ภาพจริงว่า component/process/service/db/queue/cache/device/runtime เชื่อมกันอย่างไร ไม่เชื่อ folder structure |
| Semantic Architecture Reconstruction | "โครงสร้างตามความหมาย" — ไฟล์คนละ module แต่ responsibility เดียวกัน |
| Runtime Architecture Discovery | architecture ตอนรันจริง: call path, runtime binding, dynamic dependency, configuration |
| Static-vs-Runtime Reconciliation | เทียบ architecture ที่ source บอก กับที่ execution สร้างจริง |
| Architecture Reconstruction | ไม่มี doc ก็ย้อนสร้างภาพระบบจาก code/configs/interfaces/tests/runtime |
| Intent Reconstruction | code "ทำอะไรอยู่" vs "เดิมตั้งใจให้ทำอะไร" — สองอย่างไม่ตรงกันได้ |
| Intent Drift Detection | implementation ถูกแก้จนห่างจากเจตนาเดิม แม้ test ยังผ่าน |
| Responsibility Mapping | component ไหนเป็นเจ้าของ responsibility อะไร — ไม่เอา fix ไปวางผิด layer |
| Responsibility Integrity | logic ที่จะแก้ควรอยู่ layer นี้จริงหรือไม่ |
| Ownership Reconstruction | ใคร owner จริง ใครแค่ถือ reference ใครมีสิทธิ์ mutate |
| Authority Mapping | component ไหน "ทำอะไรได้" ไม่ใช่แค่ใคร import ใคร |
| Invariant Ownership | layer/component ไหนควรเป็นผู้รับผิดชอบบังคับ invariant |
| Contract Ownership | contract พัง — ฝั่ง producer หรือ consumer ละเมิด ไม่ fix ผิดฝั่ง |
| Dependency Graph Reconstruction | ก่อนแตะ A ต้องรู้ว่าใครใช้ A และ A พึ่งอะไร |
| Hidden Coupling Detection | dependency ผ่าน global state/events/cache/shared DB/environment/timing ที่ import graph ไม่เห็น |
| Ghost Dependency Detection | dependency ที่ไม่อยู่ใน package/import graph: DB schema, event name, env var, path, timing |
| Temporal Dependency Mapping | "สิ่งนี้ต้องเกิดก่อนสิ่งนั้น" — dependency ที่ไม่อยู่ใน import |
| Data-Flow Reconstruction | ตามข้อมูล input → transformation → storage → output ก่อนแก้ |
| Control-Flow Understanding | เส้นทาง execution สำคัญ ไม่ดู function ที่ error แยกโดดๆ |
| State-Flow Understanding | state ถูกสร้าง/เปลี่ยน/consume/ทำลายตรงไหน |
| State Authority Graph | state หนึ่งถูกอ่าน/เขียนจากใคร การเขียนไหน canonical |
| Mutation Provenance | ค่าผิด — ถูก mutate ครั้งแรกที่ไหน ไม่ใช่จุดที่พบ |
| Value Lineage | ค่า final มาจาก input ไหน ผ่าน transformation ใด |
| Control-Decision Lineage | branch สำคัญเกิดจาก condition ใด อิงข้อมูลอะไร |
| Configuration Lineage | config runtime มาจาก default/env/file/remote/override ไหน |
| Behavior Lineage | behavior เกิดจาก code+config+state+dependency+environment ชุดไหน |
| Lifecycle Mapping | component/object/resource: เกิด → active → transition → shutdown |
| Initialization Order Understanding | ไล่ lifecycle/boot order ก่อนแก้ปัญหา null/state missing |
| Shutdown Semantics Understanding | พังตอน stop/restart เพราะ cleanup/order — map ก่อนแก้ |
| Boundary Discovery | API/process/service/hardware-software/ownership boundaries |
| Semantic Boundary Recovery | boundary จริงแม้ codebase แบ่งไฟล์ผิดตั้งแต่แรก |
| Natural Module Discovery | module ที่ควรเป็นธรรมชาติจาก coupling/cohesion |
| Contract Reconstruction | interface รับประกันอะไรให้ caller แม้ไม่มี contract เขียน |
| Implicit Assumption Discovery | "ฟังก์ชันนี้ถูกเรียกหลัง init เสมอ", "ข้อมูลนี้ไม่มีวัน null" — ตรวจว่าจริงไหม |
| Invariant Discovery Before Repair | ก่อนแก้ต้องรู้ property ไหนที่ห้ามพัง |
| Invariant Ownership | layer ไหนควรบังคับ invariant นี้ |
| Critical Path Identification | เส้นทางที่ระบบพึ่งมากที่สุดก่อนตัดสินใจแก้ |
| Blast-Radius Prediction | เปลี่ยนตรงนี้ component อื่นได้ผลอะไร |
| Semantic Impact Analysis | ไม่ใช่แค่ไฟล์ไหนได้ผล — behavior ไหนจะเปลี่ยน |
| Transitive Impact Analysis | A→B→C→D ตามหลาย hop |
| Change Surface Mapping | พื้นที่ขั้นต่ำที่ต้องเปลี่ยนเพื่อแก้ root cause |
| Minimal Intervention Principle | เปลี่ยนน้อยสุด แต่แก้ต้นเหตุจริง |
| Correct-Layer Repair | ปัญหาที่ architecture ห้าม patch UI; ปัญหาที่ protocol ห้ามแก้แค่ consumer |
| Abstraction-Level Diagnosis | แก้ระดับ function/module/service/runtime/kernel/hardware/architecture |
| Symptom-vs-Structure Separation | error อยู่จุดหนึ่ง structural defect อาจอยู่คนละจุด |
| Root-Cause Ownership | component ที่ "ควรรับผิดชอบการป้องกัน" ไม่ใช่ตัวที่ crash |
| Existing-Mechanism Discovery | มี abstraction/helper/protocol ที่ควรใช้อยู่แล้วไหม |
| Pattern Conformance | เข้าใจ design pattern ของ codebase ก่อนสร้างแนวทางใหม่ |
| Architecture Style Preservation | fix ต้องไม่สร้างสองแนวทางปนกัน |
| Constraint Preservation | รู้ข้อจำกัด performance/memory/compatibility/security/hardware/product |
| Historical Context Reconstruction | ทำไม architecture ถึงเป็นแบบนี้ ก่อนลบสิ่งที่ดู "แปลก" |
| Change Intent Analysis | การเปลี่ยนก่อนหน้ามี guarantee อะไรที่ fix ใหม่ห้ามทำหาย |
| Behavioral Baseline | ภาพ behavior ปัจจุบันก่อนแก้ — แยก intentional จาก defect |
| Preservation Set | สิ่งที่ต้อง "เหมือนเดิมแน่นอน" หลังแก้ |
| Allowed Change Set | สิ่งที่อนุญาตให้ behavior เปลี่ยน |
| Forbidden Change Set | สิ่งที่ fix ห้ามกระทบ |
| Concurrency Topology | thread/task/actor/process ใครคุยกับใคร ใครแชร์ state |
| Synchronization Ownership | lock/queue/channel ใครเป็นเจ้าของ ปกป้อง invariant ไหน |
| Message-Causality Graph | message ไหนทำให้ state ไหนเกิด |
| Event Provenance | event ถูก emit เพราะอะไร downstream ทำอะไรต่อ |
| Hidden Event Coupling Discovery | ไม่ import กันแต่เชื่อมผ่าน event bus |
| Cache Coherence Understanding | source-of-truth, invalidation, propagation model |
| Replica Semantics Understanding | อ่านจาก leader/replica มี guarantee อะไร |
| Persistence Semantics Reconstruction | state ไหน durable/transient/derived/recoverable |
| Derived-State Detection | ค่า derive ใหม่ได้ ไม่ควร fix ด้วย second source of truth |
| Canonical State Selection | ก่อนแก้ consistency bug ต้องเลือกว่าความจริงหลักอยู่ไหน |
| Cross-Layer Contract Mapping | app assume อะไรจาก runtime/OS/driver/hardware — จริงไหม |
| ABI/API/Protocol Alignment | contract ระหว่าง compiler/runtime/library ก่อนแก้ native boundary |
| Hardware Constraint Awareness | fix ที่ดูถูกอาจขัด cache/alignment/atomicity/memory ordering |
| Performance Structure Understanding | cost center จริง ไม่แก้จุดที่ profile ดังเพราะเป็น downstream |
| Resource Flow Mapping | CPU/memory/FD/sockets/GPU memory/queue depth เกิด-ใช้-คืนที่ไหน |
| Resource Ownership Proof | leak ต้องรู้ lifecycle owner ไม่ใช่ cleanup กระจาย |
| Error Propagation Graph | error เริ่มจากไหน ถูก wrap/translate/suppress ที่ไหน |
| Failure Boundary Mapping | ใครควร absorb ใครควร propagate |
| Recovery Dependency Mapping | recovery path พึ่ง service อะไรบ้าง |
| Blast Radius Before Edit | maximum plausible blast radius ของทุก change |
| Change Radius vs Root-Cause Radius | การแก้กว้างกว่าต้นเหตุเกินไปไหม |
| Structural Fix Detection | รู้เมื่อไร local patch ไม่พอ ต้องแก้ architecture |
| Over-Repair Detection | กัน bug เล็ก → refactor ครึ่งระบบ |
| Under-Repair Detection | กัน patch จุดเดียวทั้งที่ต้นเหตุเป็น shared abstraction |
| Repair Placement Intelligence | จุดวาง fix ที่ invariant ถูก enforce ครั้งเดียวแล้วทั้งระบบได้ประโยชน์ |
| Fix Centrality Optimization | เลือกจุด semantic center ของปัญหา |
| Repair Layer Selection | เลือก type/schema/function/module/service/runtime/infra/hardware ได้เอง |
| Cross-Repository Structural Understanding | reconstruct architecture ข้าม repo |
| System-of-Systems Correctness | A/B/C ต่างทีมต่าง lifecycle — reason เป็นระบบใหญ่เดียว |
| Cross-Team Contract Drift | provider/consumer เข้าใจ API คนละความหมาย |
| Organizational Dependency as Engineering Risk | "ทีม A ต้องบอกทีม B ทุกครั้ง" = hidden system dependency |
| Understanding Confidence | ประเมินว่าเข้าใจ subsystem นี้แค่ไหน ไม่ใช่แค่ confidence กับ fix |
| Unknown Boundary Detection | ส่วนไหนของ blast radius ที่ยังมองไม่เห็น |
| Stop-before-Edit Rule | unknown อยู่บน critical path → ห้าม commit structural change |
| Evidence-Before-Interpretation | แยกสิ่งที่อ่านจากระบบจริง กับสิ่งที่ "คิดว่าน่าจะเป็น" |
| Model Contradiction Trigger | execution จริงขัดกับ model → ทิ้ง repair hypothesis เดิมทันที |
| Structural Counterexample Search | "มี path ไหนที่ทำให้ความเข้าใจโครงสร้างของฉันผิด?" |
| Alternative Architecture Interpretation | เก็บ interpretation หลายแบบเมื่อ evidence ไม่พอ |
| Understanding Regression Detection | ข้อมูลใหม่ขัด model เดิม → หยุด plan เดิม สร้างความเข้าใจใหม่ |
| Architecture Memory | เข้าใจแล้วรอบหน้าไม่เริ่มจากศูนย์ — ตรวจเฉพาะส่วนที่เปลี่ยน |
| Structural Drift Detection | architecture drift จาก model — รู้ก่อน bug เกิด |
| Architecture Baseline Validation | ก่อนแก้ใหญ่ ตรวจว่า model ที่จำไว้ยังตรงกับ code ปัจจุบัน |
| Proof-of-Understanding | ตอบ counterfactual เกี่ยวกับ subsystem เพื่อยืนยัน model ถูก |
| Predict-before-Edit Rule | ทำนายผลของ modification ก่อนทำ — ต่างมาก = understanding ผิด |
| Prediction Accuracy Tracking | วัดว่าเข้าใจ codebase จริงไหมจากความแม่นของ predictions |
| Understanding Calibration | confidence เรื่อง architecture ปรับจากประวัติ prediction |

### L2 — Model (Contract / Invariant / State Model) — ~60 ระบบ

| ระบบ | หน้าที่ |
|---|---|
| Negative-Space Analysis | วิเคราะห์สิ่งที่ระบบ "ไม่ได้กำหนด" — bug เกิดตรงที่ spec เงียบ |
| Undefined Semantic Zone Detection | input/state/transition ที่ไม่มีใครบอกว่าควรเกิดอะไร — บังคับ define |
| Ambiguity-to-Constraint Conversion | requirement ตีความได้หลายแบบ → ลดเหลือ semantics เดียว |
| Semantic Completeness Goal | valid state ทุกประเภทมี behavior ที่นิยามไว้ ไม่มี "คงไม่เกิด" |
| Impossible-State Census | รายการ state ที่ไม่ควรเกิด → ทำให้ represent ไม่ได้ทีละตัว |
| State-Space Accounting | ต้นทุน state-space ก่อนเพิ่ม state (boolean 1 ตัว = combinations ×2) |
| State-Space Budget | แต่ละ subsystem มีงบ complexity |
| Branch Entropy Reduction | if exceptional เต็มไปหมด = เพิ่มโอกาส defect |
| Special-Case Extinction | redesign ให้กรณีพิเศษกลับมาใช้กฎทั่วไป |
| Semantic Normalization | input หลาย representation → canonical form ก่อนเข้า core |
| Boundary Purification | ความยุ่งยากจากโลกภายนอก absorb ที่ boundary ไม่เข้า domain core |
| Pure Core / Impure Shell Reasoning | core deterministic สุด แยก I/O/clocks/network/randomness ออก |
| Determinism Envelope | ส่วนไหน deterministic ได้ → ล็อกไม่ให้ nondeterminism รั่ว |
| Randomness Ownership | ใคร owner, seed จากไหน, replay อย่างไร |
| Time Dependency Ownership | logic พึ่งเวลา → รับ clock explicit ไม่แอบอ่าน global time |
| External Reality Adapter | network/fs/sensor/APIs → explicit observations ก่อนเข้า core |
| Partial-Observability Awareness | "ไม่รู้ state จริง" เป็นเรื่องปกติ — UNKNOWN เป็น state ที่ถูกต้อง |
| Unknown-as-First-Class-State | timeout ≠ failure; ไม่มี response ≠ operation ไม่เกิด |
| Uncertainty Containment | uncertainty ไม่ลามเข้า deterministic ส่วนโดยไม่มี policy |
| Whole-System State-Space Reasoning | state combinations หลาย subsystem พร้อมกัน — ลดพื้นที่ contradiction |
| State-Machine Integrity | transition ที่ผิดต้องเป็นไปไม่ได้ |
| Type/Schema Integrity | data ผิดรูปไม่ผ่านเข้า core logic |
| Refinement-Type Correctness | type บอก constraint ได้: 0 < port < 65536, balance >= 0 |
| Effect-Aware Correctness | function ประกาศ side effect (I/O/network/db/mutation) |
| Capability-Safe Design | component ทำได้เฉพาะที่ได้รับ capability — ลด hidden authority |
| Total-Function Target | core logic ไม่มี undefined input/implicit panic |
| Exhaustiveness Guarantees | enum/protocol ใหม่ → handle ไม่ครบ fail ตั้งแต่ build |
| Single Source of Truth Enforcement | state สำคัญไม่ควรมีหลาย representation drift กัน |
| Canonical Representation | ข้อมูลเดียวกันรูปแบบมาตรฐานเดียว |
| Semantic Immutability | สิ่งที่ไม่ต้องเปลี่ยนต้องเปลี่ยนไม่ได้ |
| Mutation Budget | รู้จุดที่มีสิทธิ์ mutate state — ทำให้ต่ำที่สุด |
| State Duplication Detection | ความจริงเดียวกันถูกเก็บซ้ำกี่แห่ง |
| Derived-State Proof | derive ได้ต้องพิสูจน์ว่ามาจาก canonical ไม่ใช่ drift ได้ |
| Shadow-State Detection | state ที่ใช้จริงแต่ไม่มีใครประกาศ (flag, cache, implicit ordering, singleton) |
| Contract-First Engineering | interface ทุกชั้นมี precondition/postcondition/guarantees |
| Specification Completeness Detection | requirement ยังมีช่องที่ behavior ไม่ถูกนิยามไหม |
| Ambiguity Elimination | "เร็ว" "ปลอดภัย" "ไม่ซ้ำ" → property ที่วัด/ตรวจได้ |
| Contradiction-Free Specification | requirement ที่จริงพร้อมกันไม่ได้ → จับก่อน implementation |
| Spec-to-Code Traceability | code สำคัญรู้ว่ากำลัง fulfill requirement/invariant ไหน |
| Code-to-Spec Reverse Traceability | code ไม่มีเหตุผลรองรับ → flag เป็น accidental complexity |
| Dead-Behavior Elimination | path ไม่มี requirement ไม่มี caller → ลบหรือพิสูจน์ว่าจำเป็น |
| Machine-Checkable Requirements | requirement critical → เครื่องตรวจซ้ำได้ |
| Intent-to-Invariant Compilation | requirement ภาษาคน → invariant/contract/property ที่ตรวจได้ก่อนเขียนระบบ |
| Requirement Executability Check | requirement ตรวจไม่ได้/พิสูจน์ไม่ได้ → ทำให้ชัดก่อน implementation |
| Requirement Provenance | requirement มาจากไหน ใครต้องการ constraint ไหนเป็นต้นกำเนิด |
| Semantic Requirement Feasibility | requirement ขัด physics/compute/cost/time → รู้ตั้งแต่ต้น |
| Impossible Requirement Detection | ขัดกับ physics/distributed limitation → บอกตั้งแต่ design |
| Invariant Conflict Detection | invariant สองข้อรักษาพร้อมกันไม่ได้ภายใต้บาง state |
| Correctness vs Availability Explicitness | partition/failure — ระบบเลือก guarantee ไหน อย่าซ่อน trade-off |
| Property-Based Correctness | ตรวจ property ของระบบ ไม่ยึดเฉพาะ test cases |
| Model-Based Validation | behavior จริงต้องสอดคล้องกับ model |
| Fault Model Definition | "correct" ภายใต้ failure แบบไหน — ระบุก่อนอ้าง |
| Assumption Boundary Proof | guarantee ใช้ได้ถึง boundary ไหน ไม่ใช้คำว่า "รับประกัน" ลอยๆ |
| Cross-Language Contract Verification | Rust/C/Swift/Kotlin/Go — contract ข้าม ABI/FFI/serialization |
| Timing Contract | interface มี guarantee ด้านเวลา ไม่ใช่เฉพาะ input/output |
| Temporal Invariant Verification | "A ต้องเกิดภายใน N หลัง B", "ห้าม C ก่อน D" |
| Formal Temporal Correctness | "ต้องเกิดภายหลัง" "ห้ามพร้อมกัน" "สุดท้ายต้อง converge" |
| Liveness Proof | ไม่เพียงไม่เข้าสถานะผิด — พิสูจน์ว่า eventually สำเร็จ |
| Progress Invariant | workflow สำคัญมีตัวบ่งชี้ว่าเดินหน้า ไม่ติด intermediate เงียบๆ |
| Compiler-Assumption Verification | software ต้องไม่อิง behavior ที่ compiler ไม่ guarantee |
| Kernel-Assumption Registry | app/runtime พึ่ง syscall/scheduling/memory/fs — ประกาศ assumption |
| Foundational Assumption Audit | ไล่ถึง OS/runtime/compiler/hardware ว่าพึ่งอะไรที่ไม่รับประกัน |

### L3 — Constrain (Correct-by-Construction) — ~90 ระบบ

| ระบบ | หน้าที่ |
|---|---|
| Correct-by-Construction | correctness ถูกบังคับด้วยโครงสร้าง |
| Illegal State = Unrepresentable | state ที่ผิดไม่ควรถูกสร้างได้ |
| Correctness-by-Synthesis | สร้าง implementation จาก constraints/invariants — พื้นที่ที่ผิดถูกตัดตั้งแต่สร้าง |
| Architecture-before-Code Requirement | งานเชิงโครงสร้างต้องเข้าใจ architecture ก่อน — ยังไม่รู้ topology/ownership/contracts ไม่มีสิทธิ์เสนอ patch |
| Executable Architecture | architecture ตรวจด้วยเครื่องได้ว่า implementation ตรงกับที่ประกาศ |
| Architecture Conformance Proof | source/runtime/deployment รักษา layering/dependency direction/ownership |
| Forbidden Dependency Enforcement | layer ที่ไม่ควรรู้จักกัน — build fail ถ้ามี dependency ผิดทิศ |
| Dependency Direction Correctness | แก้ bug ไม่สร้าง dependency ย้อนชั้น |
| Semantic Coupling Budget | วัดว่า component รู้รายละเอียดของกันมากแค่ไหน |
| Change Locality Guarantee | change ประเภทหนึ่งควรแก้ในพื้นที่จำกัด — แตะ 20 module = responsibility ผิด |
| Reason-for-Change Integrity | module ควรมีเหตุผลหลักในการเปลี่ยนที่ชัด |
| Structural Predictability | ก่อนเปิดไฟล์ควรคาดได้ว่าความรับผิดชอบอยู่ layer ไหน |
| Semantic Navigation | ค้น code ตาม concept ("ownership ของ session") ไม่ใช่ filename |
| Concept-to-Code Traceability | concept สำคัญตามได้ว่าอยู่ตรงไหนตลอด stack |
| Structural Entropy Measurement | exception/bypass/one-off dependency เพิ่ม = correctness ลด |
| Entropy-Reducing Repair | เลือก fix ที่ลด structural entropy โดยไม่ over-refactor |
| Invariant Density Mapping | module ที่แบก invariant มากผิดปกติ = correctness hotspot |
| Abstraction Leak Detection | layer บนต้องไม่รู้ implementation detail ของ layer ล่าง |
| Semantic Leak Detection | concept รั่วผ่าน duplicated logic |
| Policy Centralization Analysis | rule เดียว implement ซ้ำหลายแห่งไหม |
| Policy Divergence Prevention | rule เดิมหลาย component ต้องไม่กลายเป็น semantics ต่างกัน |
| Compile-Time Elimination | จับได้ก่อน runtime → จับก่อน |
| Static Proof Before Execution | property ที่พิสูจน์ได้ → พิสูจน์ก่อนรัน |
| Runtime Assertions as Last Guard | runtime check เป็นแนวสุดท้าย ไม่ใช่เครื่องมือหลัก |
| Refinement-Type Correctness | type บังคับ constraint (0 < port < 65536) |
| Effect-Aware Correctness | function ประกาศ side effect |
| Capability-Safe Design | ทำได้เฉพาะที่ได้รับ capability |
| Total-Function Target | ไม่มี undefined input/implicit panic |
| Exhaustiveness Guarantees | handle ไม่ครบ fail build |
| Single Source of Truth Enforcement | ไม่มีหลาย representation drift |
| Canonical Representation | รูปแบบมาตรฐานเดียว |
| Semantic Immutability | ไม่ต้องเปลี่ยน = เปลี่ยนไม่ได้ |
| Mutation Budget | จุด mutate state ต่ำที่สุด |
| Local Reasoning Guarantee | อ่าน component เดียวเข้าใจได้ ไม่ตาม global side effects |
| Referential-Transparency Preference | logic pure ได้ → บังคับให้ pure |
| Order-Independence Goal | เรียกสลับลำดับแล้วผลยังถูก |
| Replayable Execution | replay ด้วย input/state เดิม → ผลเดิม |
| Deterministic Reproduction | สร้าง environment เดิมกลับมาได้อัตโนมัติ |
| Hermetic Build Correctness | build เดียวกัน + inputs เดียวกัน = artifact เดียวกัน |
| Reproducible Deployment | production state สร้างกลับจาก declared configuration |
| Configuration-as-Proof | config เป็น typed/validated model — ผิด deploy ไม่ได้ |
| Configuration Correctness | config invalid ไม่ boot ผ่าน |
| Environment-Parity Guarantee | dev/test/prod ต่างเฉพาะส่วนที่ประกาศ |
| Dependency Determinism | version/build inputs pinned/verified |
| Semantic Upgrade Checking | dependency upgrade ตรวจ behavior contract ไม่ใช่แค่ compile ผ่าน |
| API Contract Compatibility Proof | เปลี่ยน interface → ผู้เรียกเดิมยัง valid |
| Schema Evolution Proof | old/new readers+writers ทำงานร่วมกันตามช่วง migration |
| Migration Reversibility | rollback semantics หรือพิสูจน์ว่า irreversible |
| Invariant-Preserving Migration | ระหว่าง migration invariant ต้องไม่แตก |
| Data Migration Correctness | migration ข้อมูลถูกต้อง |
| Backward/Forward Compatibility Reasoning | version compatibility proof |
| Protocol Correctness | message sequence ไหนถูก/ผิด |
| Protocol-State Proof | ไม่ปล่อย arbitrary ordering ผ่าน |
| Serialization Round-Trip Guarantees | serialize→deserialize กลับมาเท่าเดิม |
| Exactly-Once Illusion Detection | ไม่ใช้คำว่า exactly-once โดยไม่มี semantics พิสูจน์ |
| Retry-Safe Design | retry แล้ว duplicate เกิดอะไร — รู้ก่อนใส่ |
| Semantic Retry Proof | ผลซ้ำคืออะไร พิสูจน์ ไม่ใช่ใส่ retry เพราะ error |
| Idempotency Guarantees | retry ซ้ำไม่สร้างผลซ้ำ |
| Cancellation Correctness | cancel กลางทาง state ยังถูก |
| Timeout Semantics | timeout ≠ "งานไม่เกิด" อัตโนมัติ |
| Partial-Failure Correctness | ครึ่งหนึ่งล่ม state ที่เหลือยังมีความหมาย |
| Distributed Invariant Preservation | invariant รอดแม้ replica delay/retry/partition/failover |
| Clock-Free Correctness Preference | ไม่พึ่งเวลา ถ้าไม่จำเป็น |
| Monotonic-State Design | state เดินหน้าอย่างเดียว ลด rollback/conflict |
| Event-Ordering Guarantees | ถูกต้องขึ้นกับลำดับ → encode ordering ชัด |
| Crash-Point Enumeration | crash ได้ทุกจุด → state หลัง restart ยัง valid |
| Crash Consistency | crash แล้ว state ถูก |
| Crash-Only Recovery Target | restart จาก failure โดยไม่ "ซ่อมมือ" |
| Recovery Correctness | recovery path ถูกต้อง |
| Self-Healing State Validation | corruption ที่แก้ได้ → ตรวจพบและ recover โดย rule ที่พิสูจน์ |
| Corruption Containment | state เสียจุดหนึ่งไม่แพร่ทั้งระบบ |
| Error Containment Domains | failure boundary เล็กที่สุด |
| Typed Error Semantics | error เป็น state ที่ออกแบบ ไม่ใช่ string กระจัดกระจาย |
| No Catch-All Failure Masking | ห้ามกลืน error จน invariant เสียแต่ดูปกติ |
| No Silent Failure | failure ต้องเป็น explicit state |
| No Undefined Recovery Path | ทุก failure class มี recovery semantics |
| Failure Transparency | caller รู้: สำเร็จ/ล้มเหลว/partial/unknown |
| Boundary Validation | input normalize/validate ก่อนข้าม boundary |
| Semantic Validation | syntax ถูกไม่พอ ความหมายต้องถูก |
| Dependency Contract Verification | contract ของ dependency ถูกตรวจ |
| Environment Assumption Verification | environment ที่ assume ถูกตรวจ |
| Resource Lifetime Guarantees | lifetime ถูกต้อง |
| Memory Safety | memory ปลอดภัย |
| Numerical Correctness | ตัวเลขถูก |
| Precision/Overflow Boundaries | ขอบเขต precision/overflow |
| Overflow-Safe Arithmetic | arithmetic ไม่ overflow |
| Unit-Safe Computation | meter/second/byte/currency สลับกันไม่ได้ |
| Dimensional Correctness | ตรวจหน่วยตั้งแต่ต้น |
| Precision Contract | ค่าคลาดเคลื่อนยอมรับได้เท่าไร — ระบุ |
| Numerical Invariant Preservation | invariant เชิงตัวเลขรักษา |
| Ownership & Lifetime Correctness | ลด dangling state/invalid ownership/lifecycle mismatch |
| Concurrency-by-Design | race/deadlock classes ลดตั้งแต่ architecture |
| Unsafe Boundary Minimization | unsafe/FFI ล้อมด้วย verified boundary เล็ก |
| Undefined-Behavior Budget = Zero (Critical Core) | ไม่พึ่ง behavior ที่ไม่รับประกัน |
| Memory Model Awareness | concurrency อิง memory ordering จริง ไม่ใช่ intuition |
| Race-Freedom Target | shared mutable state ลด/encode synchronization ตรวจได้ |
| Deadlock-Freedom Target | lock ordering/protocol มี property ตรวจได้ |
| Livelock/Starvation Awareness | "ไม่ crash" ไม่พอ — ต้อง progress |
| Progress Guarantees | งานสำคัญ guarantee ว่าไปต่อหรือจบชัด |
| Resource-Bound Correctness | RAM/disk/thread/FD ใกล้หมด correctness ยังอยู่ |
| Backpressure-by-Construction | โหลดเกิน → degrade อย่างมีแบบแผน |
| Database Constraint Maximization | invariant ที่ DB enforce ได้ → ย้ายลง DB |
| Application/Database Contract Proof | ORM/model/schema ไม่ให้ความหมายต่างกัน |
| Transaction Boundary Intelligence | transaction ครอบ semantic operation จริง |
| Transactional Integrity | transaction ถูกต้อง |
| Failure Atomicity | สำเร็จทั้งก้อนหรือ rollback ชัด |
| Isolation-Level Awareness | correctness สอดคล้องกับ isolation จริงของ DB |

### L4 — Construct (Build/Deploy/State ระดับระบบ) — ~60 ระบบ

| ระบบ | หน้าที่ |
|---|---|
| Correctness-by-Synthesis | สร้าง implementation จาก constraints |
| Toolchain Correctness Chain | Source→compiler→linker→package→artifact→deploy trace ได้ |
| Compiler Trust Verification | critical artifact ไม่พึ่ง compiler แบบมองไม่เห็น |
| Optimization-Safe Correctness | เปลี่ยน optimization/JIT/backend แล้วถูก |
| Compiler Miscompilation Suspicion Model | source semantics vs binary behavior ขัดกัน → toolchain เป็น hypothesis ได้ |
| IR-Level Invariant Checking | ตรวจ property หลัง lowering/optimization |
| Binary Semantic Verification | มั่นใจว่า binary สะท้อน semantics ของ source |
| Build-to-Binary Equivalence Confidence | artifact ที่ deploy คือสิ่งที่ source/config ตั้งใจ |
| Loader/Runtime Contract Correctness | shared libs/dynamic linking/runtime resolution/init |
| Generated-Code Verification | code จาก generator/AI/compiler อยู่ใต้ invariant เดียวกัน |
| Configuration-as-Proof | config เป็น typed/validated model |
| Reproducible Deployment | production state สร้างกลับจาก config |
| Deployment-State Correctness | ถูกระหว่าง rolling update |
| Transition Correctness | ถูกทั้งก่อน/หลัง/ระหว่างเปลี่ยนเวอร์ชัน |
| Rollback Correctness | rollback แล้ว schema/state/protocol มีความหมายถูกต้อง |
| Forward-Recovery Reasoning | ย้อนไม่ได้ → พิสูจน์ว่าเดินหน้าแก้ปลอดภัยกว่า |
| Partial-Deployment Reasoning | 30% v1 + 70% v2 ยังรักษา invariant |
| Protocol Evolution Correctness | producer/consumer คนละเวอร์ชัน combination ไหนรองรับ |
| Version-Skew Proof | app/backend/firmware/schema/agents คนละ version — guarantee ยังถูก |
| Multi-Version Reality Awareness | production มีหลายเวอร์ชันอยู่พร้อมกัน — reason แบบนี้ได้ |
| Mid-Flight Operation Compatibility | request เริ่มใน version A จบใน version B |
| Hot-Update Correctness | update ขณะทำงาน — state/contracts รักษา |
| Live-Migration Correctness | workload/state ย้ายเครื่อง — guarantee ตามไป |
| Hot-Patch Safety | patch ไม่ restart — code/state เก่าใหม่ coexist ถูก |
| Fleet Correctness | device/server หลายพันเครื่อง — ถูกทั้ง fleet |
| Heterogeneous Hardware Correctness | CPU/GPU/arch ต่างกัน semantics ไม่ drift |
| Cross-Platform Semantic Equivalence | Android/iOS/macOS/Linux — business invariant ตรงกัน |
| Concurrent Schedule Reasoning | ลด/ตรวจพื้นที่ schedule ที่เป็นไปได้ |
| Deterministic Replay of Concurrency | race ครั้งเดียว replay scheduling/state เดิมได้ |
| Interleaving State-Space Reduction | ลด possible interleavings แทน test ทุก combination |
| Scheduler-Independent Correctness | ไม่พึ่ง "ปกติ scheduler รันอันนี้ก่อน" |
| Lock Semantic Verification | lock ปกป้อง invariant อะไร — ไม่ใช่ใส่เพื่อให้อาการหาย |
| Lock Removal Intelligence | ปรับ ownership แล้วลด lock ได้ — ลด |
| Actor/Ownership Conversion Reasoning | shared mutable → ownership/message-based |
| Real-Time Correctness | ถูกแต่ช้าเกิน deadline = ผิด |
| Worst-Case Execution Reasoning | ไม่ดูแค่ average — worst-case สำหรับ critical |
| Timing Contract | interface มี guarantee ด้านเวลา |
| Embedded Correctness | register/interrupt/power state/peripheral lifecycle เป็น state machine เดียว |
| Interrupt-Safe State Design | interrupt กลางทางไม่เข้าสู่ impossible combination |
| DMA Ownership Correctness | CPU/device ใครเป็นเจ้าของ buffer ช่วงไหน |
| Cache-Coherency Contract Reasoning | HW/SW assumptions เรื่อง memory visibility ตรงกัน |
| Reset-Domain Correctness | reset บางส่วน — state ที่เหลือไม่ assume ว่า device ยังเหมือนเดิม |
| Power-State Correctness | sleep/wake/suspend/resume = lifecycle transition จริง |
| Boot-State Determinism | cold/warm/recovery boot ให้ invariants เริ่มต้นเหมือนที่คาด |
| Boot-Time Correctness Validation | ตรวจความถูกต้องตอน boot |
| Firmware-Version Compatibility Matrix | revision หลายชุด combination ไหน valid |
| Firmware/Software State Compatibility | firmware/software state เข้ากัน |
| FPGA/Hardware Contract Checking | RTL/bitstream/driver/software มี machine-checkable contract |
| Hardware State-Machine Verification | protocol/register/handshake critical → model-check ก่อนใช้ |
| Clock-Domain Correctness Awareness | crossing clock domains = correctness boundary |
| Hardware Contract Enforcement | alignment/ordering/DMA/cache-coherency/atomicity ตรง assumption |
| Device Capability Contracts | device ทำได้ตามที่ประกาศ |
| Power-Failure Correctness | ไฟหายระหว่าง write/update — semantics ชัด |
| Persistent-State Atomicity | persistent state atomic |
| ECC/Hardware Fault Awareness | แยก software defect จาก hardware corruption |
| Fault-Tolerant Computation | ตรวจว่า result ผิดจาก transient hardware fault ไหม |
| End-to-End Data Integrity | source→memory→network→storage→compute→output ตรวจ integrity |
| Fault-Injection-as-Design Tool | จำลอง failure ตั้งแต่ design พิสูจน์ recovery |
| Snapshot Semantic Validity | consistent ในระดับ storage ≠ consistent ในระดับ business |
| Restore-Time Invariant Reconstruction | restore แล้วตรวจ invariant ใหม่ |
| State Repair Proof | repair แล้ว state หลัง repair เป็น valid จริง |
| Data Provenance Correctness | ค่าใน DB ย้อนกลับได้ว่ามาจาก process ไหน |
| Derived-Data Invalidity Detection | canonical เปลี่ยน → derived stale ถูก invalidate |
| Semantic Cache Proof | cache correctness ตาม business semantics ไม่ใช่แค่ TTL |

### L5 — Prove (Proof Before Trust) — ~110 ระบบ

| ระบบ | หน้าที่ |
|---|---|
| Correctness Budget | critical ใช้ proof หนักกว่า low-risk อย่างมีเหตุผล |
| Risk-Weighted Formality | formal เฉพาะจุดที่ failure cost สูง |
| Correctness Economics | ระดับ proof ตามผลกระทบของ failure |
| Correctness Hotspot Discovery | code 5-10% ที่ถือ invariant สำคัญสุด → guarantee หนักสุดตรงนั้น |
| Correctness Concentration Reduction | ถูกทั้งระบบพึ่ง function/person/component เดียว → ลด |
| Proof-Carrying Change | change สำคัญพก evidence ว่า invariant ไหนยังผ่าน |
| Proof-Carrying Interface | component บอก guarantee ที่ผู้ใช้พึ่งได้ |
| Proof Dependency Graph ⭐ | guarantee A พึ่ง proof B/C — B เปลี่ยน → รู้ว่าอะไรต้อง verify ใหม่ |
| Correctness Knowledge Graph ⭐ | requirement→architecture→invariant→implementation→test→runtime→release เชื่อมหมด |
| Compositional Proof Reuse | component ที่พิสูจน์แล้ว → ประกอบระบบใหญ่ไม่เริ่มใหม่ |
| Incremental Re-Proving | code เปลี่ยน 2% ไม่ตรวจ 100% — ตรวจเฉพาะ proof surface |
| Proof Cache with Invalidation | cache correctness evidence + invalidation แม่นเหมือน build system |
| Semantic Change Calculus | change เปลี่ยน "ความหมายระบบ" แค่ไหน ไม่ผูกจำนวนบรรทัด |
| Correctness Delta | ทุก commit: guarantee เพิ่ม/ลด/ไม่เปลี่ยน |
| Guarantee Regression Detection | test ผ่านแต่ guarantee ลดจาก "impossible" เป็น "unlikely" = regression |
| Correctness Ratchet Enforcement | bug class ที่ eliminate แล้วห้ามกลับมาง่ายๆ |
| Proof Monotonicity Goal | เพิ่ม evidence โดยไม่ทำลายของเดิมโดยไม่มีเหตุผล |
| Proof-preserving Refactoring | refactor ไม่เปลี่ยน semantics → รักษา evidence เดิม |
| Behavioral Equivalence Proof for Refactors | old/new observable behavior เท่ากันในส่วนที่ตั้งใจไม่เปลี่ยน |
| Semantic Dead-Code Proof | path นี้ไม่มีความหมายต่อ valid system state |
| Composition Proof | สอง component ถูกเดี่ยวๆ → ต่อกันพิสูจน์ contract รอยต่ออีกครั้ง |
| Correctness Confidence Composition | A 99% + B 99% ≠ ระบบ 99% — คำนวณ dependency ของ guarantees |
| Emergent Defect Analysis | component ถูกหมดแต่ interaction รวมผิด — ตรวจระดับ composition |
| Feature Interaction Correctness | A ถูก, B ถูก แต่ A+B ผิด |
| Configuration Combination Explosion Control | flag/config มาก → หา combination สำคัญ ไม่ปล่อย state-space โต |
| Feature-Flag Correctness Lifecycle | flag ชั่วคราวมีวันหมดอายุ ถูกถอน |
| Proof Obligation Discovery | ข้ออ้างไหนต้องพิสูจน์จริง ข้อไหน statistical พอ |
| Proof Gap Detection | ตรงไหน "เกือบพิสูจน์ได้" แต่ขาด assumption |
| Formal Consistency Checking | ข้อสรุปหลายข้อจริงพร้อมกันได้ไหม |
| Proof-Oriented Analysis | โจทย์ต้องการความแน่นอนสูง → formal |
| Formal + Empirical Hybrid Reasoning | พิสูจน์ได้พิสูจน์ ที่เหลือวัด |
| Counterexample Search | universal claim → หาตัวอย่างเดียวที่ผิด |
| Counterexample Prioritization | หาเคสที่พังมากสุดก่อน |
| Correctness Oracle Validation | ตัวตัดสินความถูกต้องเองถูกไหม — test เขียนผิดพร้อม code ได้ |
| Specification Truth Resolution | Spec/Test/Code/Runtime ขัดกัน — หา intended truth ไม่สมมติว่า spec ถูก |
| Oracle Independence | test oracle ไม่สร้างจาก logic เดียวกับ implementation |
| Oracle Diversity | ใช้วิธีตรวจที่ failure mode ต่างกัน ไม่ใช้เครื่องมือชนิดเดียว |
| N-Version Cross-Check | computation critical สองวิธีอิสระตรวจกันเอง |
| Differential Verification | implementation สองแบบ/rุ่นเก่าใหม่ semantics สอดคล้อง |
| Metamorphic Correctness | ไม่มี expected output → รู้ relationship ที่ควรจริงเมื่อ input เปลี่ยน |
| Verification Portfolio | type system/model checking/fuzz/property/simulation/runtime monitor |
| Minimum Sufficient Guarantee | ไม่ overengineer — contract อ่อนพอต่อ invariant ก็พอ |
| Proof Cost Optimization | เลือก technique ตามมูลค่าของ guarantee |
| Property Completeness Pressure | bug ลอด test ได้ = property ยังไม่ครอบคลุมพอ |
| Mutation Resistance | เปลี่ยน logic ผิดๆ → verification ต้องจับได้ |
| Boundary Mutation Testing | ทดสอบที่ transition/contract มากกว่ากระจาย random |
| Invariant Mutation Testing | ทำลาย invariant → ระบบตรวจต้องร้อง |
| Property-Based Correctness | ตรวจ property ไม่ยึด test cases |
| Correctness Argument Generation | อธิบายเป็น argument ว่า "ทำไมสิ่งนี้ถึงถูก" |
| Correctness Argument Attack | ฝ่ายตรงข้ามพยายามเจาะ argument นั้น |
| Independent Semantics Reconstruction | verifier สร้างความเข้าใจใหม่จาก source/evidence ไม่รับ reasoning ของผู้แก้เป็นจริง |
| Independent Repair Verification | reasoning ที่สร้าง fix ≠ reasoning ที่รับรอง fix |
| Adversarial Repair Review | รอบที่พยายามทำให้ fix ล้ม |
| Self-Verification Separation | Agent สร้าง patch ไม่ใช่หลักฐานเดียวว่าถูก |
| Self-Deception Detection | หลักฐานยืนยัน repair สร้างจาก assumptions เดียวกับ repair ไหม |
| Circular Verification Detection | ห้าม implement → generate expected → test กับผลตัวเอง |
| Evidence Independence Score | หลักฐาน 5 อย่างจาก logic เดียว ≠ verification 5 ชั้น |
| Repair Falsification | ก่อน implement พิสูจน์ว่า fix "ยังมีเคสไหนไม่แก้ root cause" |
| Repair Causality Proof | Before fail/After pass ไม่พอ — เชื่อม modification→mechanism→invariant restored |
| Mechanism Confirmation | กลไกที่คาดว่าเปลี่ยน เป็นกลไกที่เปลี่ยนจริง |
| Alternative-Cause Elimination | ตัดคำอธิบายอื่นก่อนประกาศ root cause |
| Accidental-Fix Rejection | "ลองแล้วผ่าน" ไม่มี causal explanation → สงสัย |
| Coincidental-Test-Pass Detection | ผ่านจาก timing/cache/environment ไม่เกี่ยวกับ causal mechanism |
| No Unexplained Success | "ไม่รู้ทำไม แต่แก้แล้วหาย" = FAIL |
| No Unexplained Failure | failure สำคัญต้องมี causal account ก่อนปิด |
| Causal Closure | root cause→mechanism→symptom→repair→restored invariant เชื่อมครบ |
| Semantic Closure | behavior ที่เปลี่ยนเป็น intentional หรือ proven consequence |
| Structural Closure | ไม่มี workaround ทำให้ invariant กระจายหลายจุด |
| Operational Closure | deploy/restart/migrate/rollback หลัง repair ยังถูก |
| Knowledge Closure | ความรู้ถูกเก็บใน enforceable form ไม่หายกับ session |
| Second-Bug Prediction | defect หนึ่ง → หา bug อื่นจาก defect class เดียวกัน |
| Sibling Defect Discovery | pattern ผิดใน A → ตรวจ sibling locations |
| Bug-Family Extinction | sibling defects จาก cause เดียวกันยังเหลือ = fix ไม่สมบูรณ์ |
| Bug-Class Extinction | กำจัด class ไม่ใช่แก้ instance |
| Defect Immunization | bug ทุกครั้งทิ้งภูมิคุ้มกัน: type/invariant/contract/proof/test |
| Regression-to-Rule Compilation | regression ที่เกิด → rule ที่ CI/LoopFocus ตรวจตลอดไป |
| Known-Failure Closure | ไม่มี known failure จบด้วย "จำไว้ว่าอย่าทำ" — ต้อง encode |
| Human-Memory Independence | correctness ไม่พึ่ง senior ที่ "รู้ข้อห้ามในหัว" |
| Documentation Independence for Safety-Critical Rules | rule สำคัญ enforce ได้ ไม่อยู่แค่ docs |
| Review Independence | review เป็น defense เพิ่ม ไม่ใช่หลักของ correctness |
| Debugger Independence | debugger เป็นเครื่องมือฉุกเฉิน ไม่ใช่ workflow ปกติ |
| Human Procedure Elimination | "ต้องจำทำขั้นตอนนี้ทุกครั้ง" → encode ลงระบบ |
| Tribal Knowledge Compilation | ความรู้ในหัว senior → architecture/contract/check |
| Operational Correctness | startup/shutdown/backup/restore/scaling/migration/DR เป็นส่วนหนึ่งของ correctness |
| Restore Verification | backup มี ≠ restore ได้ — พิสูจน์ recovery state จริง |
| Correctness Across Disaster Recovery | restore/failover/rebuild แล้ว guarantees กลับครบ |
| Time-Travel State Reasoning | state ก่อน/หลัง event — วิเคราะห์ corruption/migration |
| Correctness Provenance | guarantee ย้อนได้ว่าเกิดจาก type/contract/proof/test/runtime/hardware ไหน |
| Observability as Verification | telemetry ยืนยันว่า runtime ยังรักษา invariant |
| Runtime Conformance Checking | production behavior เทียบ model/contract ต่อเนื่อง |
| Semantic Drift Alarm | behavior เริ่มต่างจาก spec แม้ยังไม่มี incident |
| Invariant Telemetry | metric บางตัวตอบตรงๆ ว่า property สำคัญยังจริงไหม |
| Proof Decay Detection | evidence หมดอายุเมื่อ dependency/config/compiler เปลี่ยน → re-verify |
| Correctness Lineage | guarantee ขึ้นกับ compiler/library/hardware assumption ใด |
| Assumption Expiry | assumption ไม่เป็นอมตะ — trigger ให้ตรวจใหม่ |
| Truth Maintenance System | assumption ถูกลบ → conclusion ที่พึ่งมันถูกถอนอัตโนมัติ |
| Contradiction-Free Knowledge Base | knowledge ที่สะสมตรวจ contradiction เอง |
| Traceability to Runtime Reality | guarantee ไปจบที่สิ่งที่ deploy จริง ไม่จบแค่ source |
| Release Artifact Identity Proof | binary/container/firmware ที่รัน คือ artifact ที่ผ่าน verification จริง |
| Correctness Release Gate | "feature complete" ≠ "correctness complete" — release critical ต้องผ่านอย่างหลัง |
| Correctness SLA/SLO | SLO ของ semantic correctness ไม่ใช่แค่ uptime |
| Correctness Fixed-Point Goal | re-analysis แล้วไม่มี repair ใหม่จำเป็นภายใต้ scope/evidence |
| Zero-Debug Confidence Envelope | ระบุว่า guarantee ไหนพิสูจน์ภายใต้ assumptions อะไร ไม่พูดว่า "ถูกแน่นอน" |

### L6 — Preserve (Ratchet & Evolution) — ~90 ระบบ

| ระบบ | หน้าที่ |
|---|---|
| Correctness Ratchet | guarantee เดินทางเดียว — defect ที่ป้องกันแล้วไม่กลับมา uncontrolled |
| No-Regression-of-Guarantee Rule | change ใหม่ห้ามลด guarantee เดิมเงียบๆ |
| Root-Cause-to-Constraint Conversion | defect → เปลี่ยน root cause เป็น constraint ถาวร |
| Regression Impossibility Target | bug class ที่เกิดแล้ว → invariant/test/proof ไม่เกิดซ้ำ |
| Regression-to-Rule Compilation | regression → rule ที่ตรวจตลอดไป |
| Defect Immunization | bug ทิ้งภูมิคุ้มกันไว้ใน type/invariant/contract/proof/test |
| Structural Learning Permanence | สิ่งที่เรียนจาก defect กลับเข้า architecture rules |
| Knowledge-to-Constraint Compilation | สิ่งที่ "เรียนรู้จาก codebase" → rule ที่ระบบตรวจได้ |
| Architecture Memory | เข้าใจแล้วรอบหน้าไม่เริ่มจากศูนย์ |
| Structural Drift Detection | architecture drift — รู้ก่อน bug เกิด |
| Architecture Baseline Validation | ก่อนแก้ใหญ่ตรวจว่า model ยังตรงกับ code |
| Architectural Smell Recognition | abstraction leak/god object/temporal coupling/hidden global/circular dependency |
| Design Smell → Proof Requirement | smell ยังไม่ใช่ bug แต่ trigger verification เพิ่ม |
| Complexity-to-Evidence Ratio | ซับซ้อนมาก + evidence น้อย = correctness hotspot |
| Change Frequency × Criticality Analysis | critical + ถูกแก้บ่อย = ต้อง guarantee สูง |
| Defect Density Prediction from Structure | hidden state/coupling สูง = risk แม้ยังไม่พบ bug |
| Correctness Hotspot Forecasting | ทำนายบริเวณที่จะสร้าง defect รุ่นถัดไป |
| Pre-Bug Intervention | เสนอ redesign เพราะเห็น defect pressure สูง แม้ยังไม่พัง |
| Antifragile Correctness | failure/near-miss ทำให้ constraint เพิ่มและแข็งแรงขึ้น |
| Guarantee Evolution | architecture รุ่นใหม่บอก guarantee ไหนเพิ่ม/ลด/เปลี่ยน |
| Guarantee Negotiation | guarantee ชนกัน — บอกต้องเลือกอะไร ไม่สร้าง behavior คลุมเครือ |
| Incidental Change Detection | behavior ที่เปลี่ยนโดยไม่ตั้งใจ (Semantic Closure ฝั่งนี้) |
| Correctness Self-Description | subsystem บอก guarantee/assumption/failure semantics ของมัน |
| System Self-Consistency Check | components cross-check semantic assumptions กัน |
| Automatic Assumption Inventory | สำรวจ "สิ่งที่ระบบเชื่อโดยไม่ enforce" — ลดทีละรายการ |
| Assumption Elimination Rate | วัดความก้าวหน้าจากจำนวน critical assumptions ที่กลายเป็น guarantees |
| Unexplained Behavior Budget = Zero | critical behavior ไม่มี causal explanation = ไม่ปล่อยผ่าน |
| Manual Repair Budget → Near Zero | production ไม่ต้องใช้คำสั่งเฉพาะกิจที่มีแค่บางคนรู้ |
| Self-Stabilizing Architecture Goal | disturbance ชั่วคราว → ระบบพาตัวเองกลับ valid state |
| Convergence Proof | recovery/reconciliation ไม่ใช่ "น่าจะกลับมาปกติ" — พิสูจน์ว่า converge |
| Steady-State Correctness | หลังเหตุการณ์จบ ไม่เหลือ latent inconsistent state |
| Correctness Horizon | guarantee ยังอยู่หลัง restart/deploy/failover/migration/scale ไหม |
| Operational Ritual Elimination | "ก่อน deploy อย่าลืมทำ X" → เครื่องทำแทน |
| Runbook Compilation | ขั้นตอนแน่นอน → machine-checkable workflow |
| Incident Knowledge Compilation | postmortem → invariant/guard/constraint ใหม่ ไม่ใช่ PDF |
| Near-Miss Compilation | เกือบเกิด → เพิ่ม guarantee ได้ |
| Institutional Correctness | ย้าย procedure → automation → enforced invariant |
| Human-in-the-Loop Correctness | human action เป็น state transition จริง |
| Debugging Necessity Audit | ต้อง debug เรื่องเดิมซ้ำ = Zero Debug ล้มเหลวตรงไหน — หาต้นเหตุของ "ความจำเป็นในการ debug" |
| Debugger-to-Design Feedback | ข้อมูลจาก debugger → ปรับ architecture/invariant/telemetry/type |
| Zero-Debug Maturity Measurement | Reactive → Preventive → Constraint Driven → Proof Driven → Correct-by-Construction |
| Correctness Autonomy | Agent บอกเองได้ว่า "ยังไม่มีสิทธิ์แก้ เพราะเข้าใจ/พิสูจน์ไม่พอ" และรู้ว่าต้องหาอะไรต่อ |
| AI-Generated Change Distrust | ไม่เชื่อ patch ตัวเองเพียงเพราะเป็นคนสร้าง |
| AI Change Blast-Radius Gate | change ยิ่งกระทบมาก ยิ่งต้องเข้าใจ/พิสูจน์มากขึ้น |
| Action Provenance | ทุกการเปลี่ยนของ Agent ย้อนได้ว่ามาจาก requirement/evidence/reasoning ไหน |
| AI Agent State Correctness | context ในข้อความ ≠ canonical system state |
| Tool-Effect Verification | เรียก tool แล้วตรวจผลจริง ไม่ infer จาก intent |
| Plan-vs-Reality Reconciliation | step 1 แล้ว environment เปลี่ยน → revalidate ก่อน step 2 |
| Agent Action Idempotency | retry ของ Agent ไม่สร้าง duplicate effect |
| Agent Memory Correctness | memory เก่า/summary ไม่ override reality ปัจจุบัน |
| Agent Hallucination Containment | claim ไม่มี evidence ห้ามกลายเป็น irreversible action |
| Reasoning-to-Execution Contract | "คิดว่าจะทำ" กับ action จริง เทียบกันก่อน commit |
| Unknown-Unknown Escalation | behavior ที่ model อธิบายไม่ได้ → เพิ่มการสำรวจ ไม่ใช่เพิ่ม patch |
| No-Patch-on-Mystery Rule | ไม่รู้ว่าทำไม patch ทำให้หาย → ยังไม่ผ่าน Zero Debug |
| Repair Loop Convergence | fix→verify→fix ต้องเข้าใกล้ valid state ไม่วนแก้ |
| Oscillation Detection | fix A ทำ B พัง, fix B ทำ A พัง — ปัญหาอยู่ที่ model |
| Repair Debt Detection | fix ที่ผ่านแต่ทิ้ง workaround = ไม่ถึง Zero Debug |
| Complexity Non-Increase Target | repair ไม่เพิ่ม accidental complexity |
| Architecture Fitness After Repair | fix ถูก functionally แต่ coupling แย่ลง → reject ได้ |
| Post-Repair Structural Reproof | สร้าง dependency/state/contract model ใหม่ พิสูจน์ว่าไม่ทำ architecture เสีย |
| Pre-Repair Regression Model | รู้ว่าพฤติกรรมไหนต้องเหมือนเดิมก่อนเปลี่ยน |
| Architecture Reconciliation After Repair | สร้าง model ใหม่ตรวจว่า architecture จริงตรงกับที่เข้าใจ |
| Repair Proof Obligation | ระบุว่า fix ต้องพิสูจน์อะไรถึงจะถือว่าถูก |
| Multi-Option Repair Design | local/structural/redesign หลายแบบเทียบกัน |
| Repair Cost vs Correctness | การแก้ระดับไหนกำจัด bug class ได้คุ้มสุด |
| Future-Change Compatibility | fix วันนี้ไม่ล็อก architecture จน feature ถัดไปยาก |
| One-Way Door Detection | เปลี่ยนที่ย้อนยาก → ยกระดับ proof อัตโนมัติ |
| Correctness Debt Ledger | ส่วนที่ยังอาศัย assumption/test แต่ยังไม่ construction-safe มองเห็นชัด |
| Proof Coverage Map | guarantee ไหนมีหลักฐานระดับไหน (ไม่ใช่แค่ test coverage) |
| Comprehension Debt | แก้ได้แต่ยังอธิบายไม่ครบ = หนี้ความเข้าใจ |
| Understanding Coverage | เข้าใจพื้นที่ที่จะเปลี่ยนกี่ % unknown อยู่ตรงไหน |
| Structural Unknown Gate | unknown แตะ critical dependency → ห้ามเริ่ม repair |
| Evidence Freshness | model/call graph/runtime trace/assumption หมดอายุเมื่อ code เปลี่ยน |
| Physical-World Boundary Correctness | sensor/device ให้ค่าผิด/stale ได้ — โลกจริงไม่ deterministic |
| Sensor Plausibility Contracts | physical input มี range/rate/state สมเหตุสมผลก่อนใช้ตัดสินใจ |
| Actuation Confirmation | "ส่งคำสั่งแล้ว" ≠ "โลกจริงเปลี่ยนแล้ว" |
| Probabilistic Correctness | AI/ML — guarantee เป็น distribution/error bounds |
| Model Confidence vs System Confidence Separation | AI มั่นใจ 99% ≠ ระบบ correctness 99% |
| AI Output Constraint Envelope | ส่วน probabilistic ล้อมด้วย deterministic constraints |
| Model Upgrade Semantic Gate | เปลี่ยน AI model = dependency/API upgrade ไม่ใช่ drop-in |
| Nondeterministic Component Containment | ความสุ่มไม่ทำให้ deterministic core เสีย guarantee |
| Self-Modifying Code Correctness | Agent สร้าง code/config ใหม่ → re-establish guarantees ก่อน activate |
| Runtime Policy Synthesis Validation | policy ที่ Agent สร้างตรวจ consistency ก่อนใช้ |
| Self-Repair Safety | self-healing ต้องพิสูจน์ว่าไม่ทำให้ state แย่ลง |
| Commit-Point Discovery | จุดที่ action เปลี่ยนจาก reversible → committed |
| Point-of-No-Return Detection | ก่อน irreversible → ยกระดับ verification อัตโนมัติ |
| Compensation Validity Proof | "ย้อนกลับ" ทางธุรกิจ ≠ undo state — ตรวจ semantics จริง |
| Exactly-What-Happened State | ผลไม่แน่นอนหลัง timeout/crash → determine state แทนเดาแล้ว retry |
| Distributed Commit Skepticism | ลด cross-system atomicity ถ้า redesign ให้ local ขึ้นได้ |
| Saga Correctness Verification | compensation ไม่ใช่ undo อัตโนมัติ |
| Long-Running Workflow Correctness | workflow กินชั่วโมง/วัน ทน deploy/restart/version change |
| Distributed Authority Correctness | ไม่มีหลาย service คิดว่าตัวเองเป็น authoritative owner |
| Distributed Invariant Decomposition | invariant ใหญ่แบ่งเป็น local guarantees |
| Partition Correctness Definition | นิยาม behavior ขณะ network partition ก่อนเรียกว่าถูก |
| Duplicate Message Immunity | duplicate/reordered = สภาวะปกติที่ออกแบบรับ |
| Read-Model Correctness | eventual/derived/read replica — stale สูงสุดที่ยอมรับได้ |

## 11. กฎการไหลของงาน (Defect → Guarantee)

```
Defect discovered
→ Why was this state possible?
→ Find violated assumption/invariant
→ Fix defect
→ Encode constraint
→ Encode proof/test/check
→ Make same defect class impossible
```

## 12. Tools ที่วางแผน

- comprehension-gate.sh — ตรวจว่า agent ตอบคำถาม Proof of Comprehension ครบก่อนแก้
- repair-permission.js — คำนวณระดับสิทธิ์จากความเข้าใจ (Observe→...→Proof-level)
- correctness-gradient.js — วัดระดับ guarantee ของ subsystem
- state-space.js — คำนวณ/เฝ้า state-space budget
- proof-dependency-graph.js — guarantee → assumptions, invalidation propagation
- exit-criterion.sh — Zero-Debug Exit Criterion ตรวจ 13 เงื่อนไข
- assumption-inventory.sh — สำรวจ "สิ่งที่ระบบเชื่อโดยไม่ enforce"
- (ต่อยอด: mutation, invariant, convergence tools ที่มีแล้ว)

## 13. แผนการทดสอบ (TDD)

- RED: scenario "แก้บัคโดยไม่เข้าใจระบบ" แบบไม่มีสกิล — วัด: กระโดดแก้ทันที, patch symptom, ไม่ไล่ root cause, ไม่ encode constraint
- GREEN: scenario เดียวกัน — ต้องเห็น: Understanding Gate ผ่านก่อน, Repair Hypothesis ก่อน edit, defect → constraint → test, exit criterion ครบ
- Machine tests: ทุก tool ใหม่
- REFACTOR: rationalization hunt ("จุดนี้เล็กไม่ต้องเข้าใจทั้งระบบ")

## 14. สิ่งที่ยังจะเพิ่ม (รอ input จากเจ้าของโปรเจกต์)

- (เปิดรับ — เติมใน v2)
