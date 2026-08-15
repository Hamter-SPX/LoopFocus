# SecurityArch — Design Spec v2

วันที่: 2026-08-16
สถานะ: Draft v2 (67 ระบบ + 3 Signature Features + 5 ชั้น — รอรีวิวจากเจ้าของโปรเจกต์)
ตำแหน่ง: โหมด M3 ของ LoopFocus — หน่วยสมบูรณ์ในตัว (มี Docs + Identity ของตัวเอง)

---

## 1. Identity

> **SecurityArch คือสถาปนิกความมั่นคงของ LoopFocus — ไม่ได้สแกนบั๊ก แต่สร้างแผนที่ทางสถาปัตยกรรม หาเส้นทางโจมตีจากต้นสู่ผล พิสูจน์ invariants ด้วยการพยายามทำลายมันเอง และตัดสินด้วยหลักฐานเท่านั้น ไม่ตัดสินด้วยความกลัว**

- โหมดนี้บังคับ DEEP เสมอ — ไม่มีวิ่งแบบเบา
- วิเคราะห์ threat ต่อ architecture ไม่ใช่ scan bug pattern
- ห้ามเคลม "secure" — บอกได้แค่ว่าตรวจด้วยอะไร บนเวอร์ชันไหน
- ออกโหมดได้ผ่าน Security Exit Gate เท่านั้น

## 2. 5 ชั้นของ SecurityArch

| ชั้น | ชื่อ | เนื้อหา |
|---|---|---|
| **L1** | Mapping | Architecture / Data / Identity / Trust |
| **L2** | Analysis | Threat / Risk / Attack-path / Blast-radius |
| **L3** | Adversarial Reasoning | Counterfactual / Unknown-unknown / Mutation |
| **L4** | Verification | Evidence / Proof / Independent Judge |
| **L5** | Autonomous Security Architecture | Synthesis / Optimization / Immune System / Continuous reasoning |

## 3. Pipeline หลัก (ลำดับบังคับ)

```
LoopFocus
   ↓
SECURITY_ARCH MODE
   ↓
Repository / System Recon
   ↓
Security World Model (representation ของทั้งระบบ)
   ↓
Architecture Graph → Data Flow Graph → Identity Graph
→ Trust Boundary Graph → Dependency Graph → Attack Surface
   ↓
Security Invariants + Assumption Registry
   ↓
Threat Hypothesis Generation (Unknown-Unknown Hunter)
   ↓
Attack-Path Reasoning (Causal Attack Graph + Multi-Hop)
   ↓
Counterfactual Simulation (Blast Radius + Digital Twin)
   ↓
Adversarial Architect + Architecture Mutation Testing
   ↓
Evidence Collection (Evidence Ledger + Contradiction Engine)
   ↓
Risk + Exploitability Judge (Independent Judge + Multi-Judge Quorum)
   ↓
Policy Synthesis + Least-Privilege Optimization
   ↓
Architecture Fix Planner (Proof-Carrying + Proof of Remediation)
   ↓
Implementation / Fix
   ↓
Re-map Architecture (Security Semantic Diff + Runtime Drift)
   ↓
Recursive Architecture Challenge (วนจนทุกเงื่อนไขผ่าน)
   ↓
SECURITY EXIT GATE
```

## 4. ระบบทั้งหมด 67 ตัว

### L1 — Mapping (แผนที่) — 15 ระบบ

| # | ระบบ | หน้าที่ |
|---|---|---|
| 1 | Security World Model | representation ภายในทั้งระบบ: Users/Agents/Services/APIs/Data/Secrets/Roles/Networks/Dependencies/Devices/Trust/Privileges/Policies/Invariants — reasoning บนโลกทั้งใบ ไม่ใช่อ่านทีละไฟล์ |
| 2 | Architecture Mapper | แผนที่ component/service/API/DB/auth/network/dependency จากโค้ดจริง |
| 3 | Trust Boundary Mapper | แบ่ง trusted/semi-trusted/untrusted zones + ทุก edge ข้าม zone |
| 4 | Attack Surface Mapper | entry points, exposed APIs, file inputs, IPC, sockets, webhooks |
| 5 | Data Flow Security | ตามข้อมูลสำคัญ source→processing→storage→output ทุก hop |
| 6 | Privilege Graph | ใคร/อะไรมีสิทธิ์ทำอะไร + escalation paths |
| 7 | Identity & Privilege Graph | แยก human/service/agent/token/API key/role + ความสัมพันธ์ทั้งระบบ |
| 8 | Data Classification Engine | Public/Internal/Sensitive/Secret/Crown Jewel — ตัดสิน severity ตาม context |
| 9 | Data Lineage Tracker | input→process→cache→DB→log→analytics→output หา leakage ข้ามระบบ |
| 10 | Dependency Trust Graph | package/SDK/service/CI action/container/artifact = node ใน trust graph |
| 11 | Configuration Security Reasoner | อ่าน Docker/K8s/IAM/proxy/cloud config/CI-CD/env/permissions ไม่ใช่โค้ดอย่างเดียว |
| 12 | Assumption Registry | ทุก assumption = object ที่มี owner/confidence/expiration/evidence — หมดอายุ → re-review อัตโนมัติ |
| 13 | Cross-Layer Reasoning | reasoning ข้าม Application→OS→Container→Cloud IAM→Network→CI/CD→Secrets พร้อมกัน |
| 14 | Trust Entropy Score | วัดว่าระบบ "เชื่อกันมั่วแค่ไหน" — implicit trust เยอะ = คะแนนแย่ |
| 15 | Security Time Machine | เปรียบเทียบ architecture รุ่นก่อน vs ปัจจุบัน — risk ไหนเกิดตั้งแต่ commit ไหน |

### L2 — Analysis (วิเคราะห์) — 8 ระบบ

| # | ระบบ | หน้าที่ |
|---|---|---|
| 16 | Threat Model Engine | วิเคราะห์ threat ต่อ architecture (STRIDE per actor) |
| 17 | Causal Attack Graph Engine | Entry→Identity→Permission→Service→Data→Impact + หา chain เสี่ยงสุด |
| 18 | Multi-Hop Reasoning | รวม 3-4 จุดที่ไม่ Critical → Critical ได้ ข้าม component ได้ |
| 19 | Blast-Radius Engine | impact ของ compromise แต่ละ component — ระบุ crown jewel |
| 20 | Counterfactual Security Engine | "ถ้า Auth ถูกยึด?" "ถ้า API key leak?" "ถ้า DB read-only?" → คำนวณ blast radius |
| 21 | Security Debt Graph | security debt เป็น graph — หนี้ตัวไหนเป็นรากของ risk อีกกี่จุด |
| 22 | Defense Dependency Graph | MFA พึ่ง IdP — ถ้า IdP พัง defense อื่นยังเหลืออะไร |
| 23 | Single-Point-of-Security-Failure Detector | หา component ที่หลุดตัวเดียว security model ทั้งระบบพัง |

### L3 — Adversarial Reasoning (เหตุผลเชิงต่อต้าน) — 7 ระบบ

| # | ระบบ | หน้าที่ |
|---|---|---|
| 24 | Adversarial Architect | persona ที่ 2 โจมตีสมมติฐานทางสถาปัตยกรรมอย่างหนัก → loop repair |
| 25 | Unknown-Unknown Hunter | ไม่เริ่มจาก CWE/checklist — ถาม "สมมติฐานไหนที่ไม่มีใครนึกว่ามันผิดได้?" สร้าง hypothesis ใหม่เอง |
| 26 | Architecture Mutation Testing | จงใจสร้าง "แบบจำลองการพัง" (ปิด auth check, เปลี่ยน trust assumption, dependency compromised) แล้วดูว่า SecurityArch ตรวจจับได้ไหม |
| 27 | Digital Twin Security Simulator | แบบจำลอง architecture อีกชุด ทดลอง failure/compromise โดยไม่แตะ production |
| 28 | Compositional Security Proof | A ปลอดภัย + B ปลอดภัย ≠ A+B ปลอดภัย — พิสูจน์ตอน component ต่อกัน |
| 29 | Hypothesis Engine | Observation→Hypothesis→Evidence→Confirm/Reject→Confidence update (ลด false positive) |
| 30 | Temporal Trust Engine | permission ที่ถูก "ตอนนี้" อาจผิดใน 30 วัน — temporary role, stale token, old key, forgotten service |

### L4 — Verification (การพิสูจน์) — 13 ระบบ

| # | ระบบ | หน้าที่ |
|---|---|---|
| 31 | Evidence Ledger | ทุก finding: Evidence/Attack preconditions/Affected boundary/Impact/Confidence/Contradicting evidence/Verification status |
| 32 | Independent Judge | Discoverer ≠ Judge — PASS/REJECT/NEED_MORE_EVIDENCE |
| 33 | Multi-Judge Quorum | Critical finding: Architect / Adversarial Reviewer / Independent Judge แยกความเห็น แล้วรวม verdict |
| 34 | Contradiction Engine | หลักฐานขัดกัน → ไม่เลือกมั่ว สร้าง contradiction case บังคับหาหลักฐานเพิ่ม |
| 35 | Confidence Calibration | รู้ว่าเมื่อไร "ไม่รู้" แทนที่จะ hallucinate finding |
| 36 | Security Invariant Engine | กฎ "ห้ามถูกละเมิด" + ตรวจทุก loop |
| 37 | Security Invariant Proof Engine | พยายามหาทางที่ invariant อาจถูกละเมิดจาก architecture/code/config |
| 38 | Proof-Carrying Architecture | ทุก architecture decision สำคัญพก "เหตุผล + invariant + evidence" — service เข้าถึง DB เพราะอะไร มีหลักฐานอะไรว่าไม่ข้ามสิทธิ์ |
| 39 | Security Semantic Diff | code/config/infra เปลี่ยน → "security model เปลี่ยนอย่างไร" (trust boundary เพิ่ม 1 จุด? privilege กว้างขึ้น?) |
| 40 | Proof of Remediation | "แก้แล้ว" ต้องมี evidence ว่า attack path เดิมถูกตัดจริง + ไม่มี path ใหม่ |
| 41 | Incident Back-Propagation | หลัง incident — หาว่า assumption/gate ไหนควรจับได้แต่พลาด แล้วอัปเดต rule ของตัวเอง |
| 42 | Runtime Drift Detector | Expected Architecture ↔ Runtime Reality |
| 43 | Detection Gap Analyzer | ถ้าเหตุการณ์ X เกิด ระบบจะรู้ไหม? ไม่มี signal = Invisible Attack Surface |

### L5 — Autonomous Security Architecture (อัตโนมัติ) — 8 ระบบ

| # | ระบบ | หน้าที่ |
|---|---|---|
| 44 | Architecture Immune System | baseline "architecture ปกติ" → change arrives → semantic diff → new trust/privilege/exposure? → response เหมือนภูมิคุ้มกัน |
| 45 | Policy Synthesis Engine | สร้างข้อเสนอ policy: least-privilege, isolation, authz boundary, data-access rule ให้เหมาะกับ architecture |
| 46 | Least-Privilege Optimizer | คำนวณ permission ที่ไม่จำเป็นต่อ function จริง → เสนอ scope เล็กสุด |
| 47 | Defense Coverage Map | ทุก attack path จับคู่ prevention/detection/containment/recovery |
| 48 | Recovery Architecture Analyzer | compromised แล้ว isolate/revoke/restore/recover ได้ไหม |
| 49 | Supply-Chain Provenance Engine | artifact "มาจากไหน ผ่านอะไร build โดยใคร เชื่อได้แค่ไหน" |
| 50 | Security Decision Log | accept/reject + reopen-if ทุก ruling |
| 51 | Risk Scoring | severity × confidence สองแกน |

### Gates (ด่านตรวจเฉพาะด้าน) — 14 ระบบ

| # | ระบบ | หน้าที่ |
|---|---|---|
| 52 | Boundary Gate | ตรวจทุก crossing ระหว่าง trust boundary |
| 53 | Auth/AuthZ Gate | auth จริงไหม authz จริงไหม แยกตรวจ |
| 54 | Authorization Path Analyzer | request→auth→policy→ownership→resource→response |
| 55 | Cross-Service Trust Analyzer | A เชื่อ B เพราะอะไร? B ถูกยึดแล้ว impersonate C ได้ไหม? |
| 56 | Secrets Gate | หา secret ทุกที่ + transit/storage |
| 57 | Secret Lifecycle Analyzer | creation→storage→access→rotation→revocation→logging |
| 58 | Input/Output Gate | input validated ที่ boundary, output encoded + bounded |
| 59 | Dependency/Supply-chain Gate | advisory + lockfile + pinning + lifecycle scripts |
| 60 | Network Exposure Gate | open ports, internal claims, egress |
| 61 | Storage/Encryption Gate | at rest/in transit/backups + key management |
| 62 | Failure-Safe Gate | พังแล้วต้อง fail-closed |
| 63 | State Machine Security | ตรวจ invalid transition (ข้าม verification, unsuspend ผิดทาง) |
| 64 | Temporal Attack Reasoning | ช่องโหว่จากลำดับเหตุการณ์ (race/state inconsistency) |
| 65 | Fix Architecture Planner | design bug → design fix ไม่ใช่ patch |

### Exit — 2 ระบบ

| # | ระบบ | หน้าที่ |
|---|---|---|
| 66 | Re-Verify Loop | หลังแก้ architecture วนตรวจใหม่ทั้งระบบ |
| 67 | Security Exit Gate | 9 เงื่อนไข — ออกโหมดได้เมื่อผ่านหมด |

## 5. Signature Features (3 ตัว)

### 5.1 Architecture Immune System
ไม่ใช่ scan เป็นครั้งๆ — baseline "architecture ปกติ" + change arrives → Semantic Security Diff → new trust/privilege/exposure? → response (เหมือนภูมิคุ้มกันของระบบ)

### 5.2 Security World Model
representation ภายใน: Users / Agents / Services / APIs / Data / Secrets / Roles / Networks / Dependencies / Devices / Trust / Privileges / Policies / Invariants — reasoning บนโลกทั้งใบของระบบ ไม่ใช่อ่านทีละไฟล์ (หัวใจของความ "เก่งจริง")

### 5.3 Recursive Architecture Challenge (โหดสุด)
```
Design → Secure it → Attack assumptions → Repair
→ Attack repaired design → Search secondary effects
→ Repair again → Independent proof
```
วนจนกว่า:
- Critical Paths = 0
- Unverified High Risks = 0
- Security Invariants = PASS
- Contradictions = resolved
- Evidence Confidence >= threshold
- Independent Judge = PASS

→ แล้วค่อยออกจาก SecurityArch Mode (LoopFocus คือตัว loop ให้)

## 6. Rules ที่ SecurityArch ยึดเหนือ LoopFocus มาตรฐาน

1. **ห้ามบอก Critical เพราะ "คิดว่าน่าจะ"** — Evidence Ledger บังคับทุก finding
2. **Discoverer ห้ามเป็น Judge** — ตัวค้นพบกับตัวตัดสินคนละ persona
3. **Patch ห้ามใช้กับ design bug** — Fix Architecture Planner บังคับ
4. **ห้ามเคลม secure** — บอกได้แค่วิธีตรวจ + เวอร์ชัน
5. **ออกโหมดผ่าน Exit Gate เท่านั้น** — 9 เงื่อนไขครบ

## 7. แผนการทดสอบ (TDD)

- RED: scenario "audit ระบบจริงจัง" แบบไม่มีสกิล — ดูว่า agent ธรรมดาพลาดอะไร (คาดว่า: ไม่ทำ threat model, ไม่เจอ multi-hop, ไม่ตรวจ config, ไม่แยก judge)
- GREEN: ระบบ 67 ตัวทำงาน — scenario เดียวกันต้องเจอ multi-hop chain + blast radius + evidence ledger ครบ + recursive challenge วนจนเงื่อนไขผ่าน
- Machine tests: security-exit.sh, risk-score.js (ใหม่), sast/fuzz/mutation suites
- REFACTOR: หา rationalization → ปิด loophole

## 8. สิ่งที่ยังจะเพิ่ม (รอ input เพิ่มจากเจ้าของโปรเจกต์)

- (เปิดรับ — จะเติมในสเปค v3)
