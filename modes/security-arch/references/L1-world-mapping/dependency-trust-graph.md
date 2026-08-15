# Dependency Trust Graph

## What

Every dependency — package, SDK, service, CI action, container image, build artifact — is a NODE in a trust graph, with edges for "pulled by", "runs with", "builds into". Supply-chain risk becomes graph reachability.

## Why

A vulnerable package is a point risk; a compromised build action that injects into every artifact is a systemic one. The graph distinguishes them: reachability from an untrusted node to a Crown Jewel artifact is the actual supply-chain risk. Flat dependency lists cannot express this.

## When

L1, from the dependency-gate's enumeration. Consumed by supply-chain-provenance-engine and hardware-supply-chain-trust.

## The node classes

| Node | Examples | Trust question |
|---|---|---|
| package/SDK | npm, pip, cargo crates | who publishes, what does it run |
| service dependency | internal services, SaaS | what data does it receive |
| CI action | GitHub Actions, runners | what can it modify |
| container image | base images, layers | built by whom, from what |
| build artifact | binaries, bundles, FPGA bitstreams | reproducible from source? |

## Protocol

1. Enumerate every node with its origin (registry, git URL, vendor).
2. Draw edges: build-time (package → artifact), run-time (service → service), pipeline (CI action → artifact).
3. Reachability pass: from each node, what can it reach? A CI action that can push to production reaches EVERYTHING.
4. Risk = reachability × trustworthiness of the node's origin. Untrusted node + short path to Crown Jewel = finding, whatever the advisory database says.
5. Record the graph in the World Model; the provenance engine fills origin evidence.

## Evidence gates

- every node has an origin record
- reachability paths computed for pipeline-critical nodes
- risk verdicts cite the path, not the node alone

## Anti-patterns

- A list of dependencies with versions and no edges
- Treating all nodes as equally risky (a pinned SDK and a scripted CI action are different animals)
- Forgetting the build pipeline as a dependency surface (pipelines ARE dependencies)

## Example

The CI action with repo-write permission reached every artifact; the graph drew the edge action → artifacts → production and flagged the action's third-party origin as the system's highest supply-chain risk — higher than any vulnerable package, because the action could modify the packages.
