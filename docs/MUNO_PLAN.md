# MUNO Implementation Plan

This file summarizes the product plan. `ARCHITECTURE_AND_ROADMAP.md` defines phase gates; `PROJECT_STATUS.md` records the state of the current clone.

## Goal

Build MUNO as an independent Blender-based desktop application with the useful functionality and layout of Mixar, entirely new MUNO identity, Codex as its AI agent, and replaceable 3D generation providers.

## Repository Model

```text
upstream/   pinned Blender 5.0 submodule
src/        committed MUNO overlay
source/     generated upstream plus overlay (ignored)
build/      generated artifacts (ignored)
scripts/    setup, overlay, build, and validation helpers
docs/       current state, decisions, inventory, and history
```

Use paths relative to the repository root. The current Desktop clone is the active workspace; absolute paths in dated project-log entries are historical.

## Implementation Principles

- Begin on Blender 5.0 to minimize Mixar compatibility risk.
- Treat public Mixar code as a partial, licensed reference rather than a complete application snapshot.
- Import small, reviewable overlay slices and preserve applicable notices.
- Replace all product identity and hosted Mixar dependencies.
- Reconstruct unavailable native editor and agent behavior as MUNO code.
- Keep Blender tools typed, reviewable, and subject to approval boundaries.
- Keep model-generation contracts independent of any one provider.

## Agent Direction

MUNO will supervise local `codex app-server` and communicate through its structured standard-I/O protocol. It will support both ChatGPT-managed login and `OPENAI_API_KEY`.

The first useful AI path is prompt-to-scene:

1. Codex receives the user request and scene context.
2. Codex chooses explicit MUNO Blender tools.
3. MUNO applies approval and execution rules.
4. Tool results and scene changes stream back to the conversation.

Codex replaces Mixie's planning and tool-use role. External generation models remain separate jobs.

## Generation Direction

Define common contracts for request, credentials, progress, cancellation, results, errors, asset caching, and scene import. Direct Hunyuan integration for meshes/topology/UV/textures is desired but deferred until the application shell and Codex workflow are stable.

## Work Order

1. Licensing, attribution, Blender 5.0 pin, and reproducible clean-clone build.
2. Public overlay import and MUNO rebranding.
3. Missing UI/editor reconstruction.
4. Codex transport, authentication, sessions, events, and lifecycle.
5. Controlled Blender tools and prompt-to-scene.
6. Broader workflow fidelity.
7. Provider-neutral generation and direct Hunyuan support.
8. Packaging, compliance, and clean-machine validation.

## Main Risks

- The public Mixar repo omits its hosted agent/backend and required native editor sources.
- Overlay code may depend on exact Blender revisions or private protocols.
- Native builds are large and expensive; each slice needs a smoke gate.
- Provider licensing, availability, cost, and API shapes may change.
- GPL/source-distribution and third-party attribution must be tracked from import time.

## First Definition Of Done

The foundation phase is done when this clone, from documented repo-relative commands, initializes the pinned Blender 5.0 base, generates `source/`, builds, and passes a headless smoke test without Mixar services.
