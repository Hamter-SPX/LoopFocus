goal: make `npm test` pass by fixing the ROOT CAUSE
invariants:
  - test file must NOT be modified (it encodes the contract)
  - minimal intervention
profile: NORMAL
DONE: tool discovery, baseline repro, 3 attempts (2 banned caller-patch), root-cause fix in lib
PROVEN: npm test 1/1 pass after fixing export key greeting→greet (evidence: .loopfocus/evidence/attempt-3-test.log)
UNKNOWN: none
NEXT: done
