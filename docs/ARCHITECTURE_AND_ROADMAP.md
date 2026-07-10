# Architecture And Roadmap

Last updated: 2026-07-10

## Product Boundary

MUNO is an independent Blender-based application. It should preserve the workflows and layout that make Mixar useful, but it must not ship Mixar/Mixie branding or depend on Mixar's unpublished agent backend.

Initial compatibility target: Blender 5.0.

The repository currently pins Blender commit
`f52ba4dcdf5f669c1bc57f39a0e056be30d3ab60`, which identifies itself as
Blender 5.0.1 RC. Platform libraries and a native build are still pending in
this checkout.

## Target Architecture

```text
MUNO Blender desktop
  |
  |-- Presentation: MUNO-branded chat, moodboard, scene, and workflow UI
  |-- Agent bridge: local codex app-server (JSON-RPC over stdio)
  |     |-- ChatGPT authentication
  |     `-- API-key authentication
  |-- Blender tool boundary
  |     |-- inspect scene and selection
  |     |-- invoke reviewed operators
  |     `-- approval and execution controls
  `-- Generation layer
        |-- provider-neutral job and asset contracts
        `-- Hunyuan and other providers (deferred)
```

Codex owns conversation, planning, tool invocation, approvals, and streamed agent events. Blender-specific operations remain explicit MUNO tools rather than unrestricted hidden backend behavior. Generation models are separate providers invoked through a stable job interface; Codex is not itself the mesh generator.

## Import Boundary

The public Mixar repository provides useful Python UI/runtime modules, assets, build patterns, and client-side generation flows, but not its hosted agent implementation. It also omits native Mixie Chat editor sources referenced by the overlay. Therefore MUNO can adapt public code where licensing permits, but exact behavior requires reconstruction rather than a mechanical repository copy.

## Delivery Phases

### Phase 0: Repository Foundation

- establish root licensing and attribution;
- pin and initialize a Blender 5.0-compatible submodule;
- make clean-clone setup and build instructions reproducible;
- add basic validation/CI for scripts and overlay hygiene.

Exit: a clean clone can produce and smoke-test an unbranded Blender 5.0 baseline.

### Phase 1: Public Overlay And MUNO Identity

- inventory and import public Mixar overlay slices;
- preserve source notices and third-party attribution;
- replace trademarks, assets, endpoints, and visible identity;
- reconstruct missing native UI pieces as MUNO code.

Exit: a MUNO-branded application launches without contacting Mixar services.

### Phase 2: Codex Agent

- supervise a local `codex app-server` process;
- support ChatGPT and API-key authentication;
- implement conversation/session/event handling;
- expose a minimal, typed Blender tool set;
- add approvals, cancellation, error recovery, and audit-friendly traces.

Exit: a user can ask Codex to inspect and make a controlled change to the open scene.

### Phase 3: Workflow Fidelity

- restore chat, moodboard, scene graph, operation history, and prompt-to-scene flows;
- map Mixie-specific concepts onto Codex tools/events;
- add regression checks for core UI and scene operations.

Exit: the primary prompt-to-scene workflow is useful without Mixar infrastructure.

### Phase 4: Generation Providers

- define provider-neutral request, progress, result, cancellation, and error contracts;
- implement local asset caching/import and credential handling;
- add direct Hunyuan support for relevant mesh/topology/UV/texture operations;
- add other providers without coupling them to the UI.

Exit: at least one direct 3D provider completes an end-to-end generation and import job.

### Phase 5: Distribution

- complete branding and installer metadata;
- produce license/source bundles and reproducible artifacts;
- test clean-machine install, update, and authentication flows.

Exit: a distributable MUNO build has complete identity, notices, and setup documentation.

## Review Strategy

Keep foundation, overlay import, rebranding, Codex transport, Blender tools, and provider integrations as separate reviewable changes or pull requests when practical. Every imported slice should still launch or pass its relevant smoke checks before the next slice lands.
