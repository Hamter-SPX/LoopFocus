# Data Classification Engine

## What

Classifies every data class in the system: Public / Internal / Sensitive / Secret / Crown Jewel — so severity is judged against what the data actually IS, not against a generic checklist.

## Why

Severity without context is noise: the same SQL injection is Critical against Crown Jewel credentials and Medium against a public catalog. Classification is the context layer that makes Risk Scoring honest — and it exposes the assets worth building the threat model around (an attacker's real targets).

## When

L1, during the Data Flow pass. Every data class gets a label before any severity is assigned anywhere.

## The classes

| Class | Definition | Breach consequence |
|---|---|---|
| Public | safe to show anyone | none |
| Internal | company-internal, not for outsiders | minor embarrassment/competitive |
| Sensitive | PII, financial, tenant data | regulatory, monetary, trust |
| Secret | credentials, keys, tokens | access to everything they protect |
| Crown Jewel | the asset everything else exists to protect | business-ending |

## Protocol

1. Enumerate data classes from the Data Flow traces (not from a schema dump — from where data actually goes).
2. Label each with the class + the reason (why Sensitive? because PII, per regulation X).
3. Crown Jewel nomination: which ONE asset would hurt most if stolen? Nominate explicitly — the Blast-Radius Engine centers on it.
4. Record the classification in the World Model; every later severity decision cites the class.
5. Re-classify when the flow changes (a class is a property of the system's current shape).

## Evidence gates

- every traced data class labeled with a reason
- crown jewel nominated explicitly
- severity scores cite the data class they rest on

## Anti-patterns

- Classifying from field names ("user_email sounds sensitive") without tracing what it protects
- Everything is Sensitive (when everything is special, nothing is — and real Secrets get diluted)
- Classification never revisited after architecture changes

## Example

Checkout app classes: catalog data = Public; orders = Sensitive (PII + purchase history); session tokens = Secret; the payments ledger + signing keys = Crown Jewel. The SQL injection on /api/user scored Critical not because SQLi is always critical, but because it reached Sensitive data with a Secret credential in the same DB — the classification made the severity defensible.
