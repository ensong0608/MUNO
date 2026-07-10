# MUNO

MUNO is an independent Blender-based desktop application for AI-assisted 3D creation. It aims for functional and layout fidelity with Mixar while using new MUNO branding, a local Codex agent, and provider-neutral generation integrations.

## Current State

This checkout is a scaffold, not a runnable application yet:

- `src/` contains only a placeholder;
- the Blender submodule at `upstream/` is initialized at the documented
  Blender 5.0.1 RC compatibility commit, but its platform dependency bundle
  has not been downloaded in this clone;
- generated `source/` and `build/` trees are absent;
- no Mixar UI/runtime overlay has been imported;
- no Codex or 3D-generation provider integration is implemented.

Earlier work produced a successful experimental Blender 5.3-alpha baseline build in another local checkout. That result is historical and does not validate this clone's Blender 5.0 dependency bundle or build. MUNO is now targeting Blender 5.0 for initial Mixar compatibility.

## Architecture

```text
MUNO desktop (Blender 5.0 base)
  |-- MUNO UI and Blender tools
  |-- local Codex app-server client
  |     |-- ChatGPT sign-in
  |     `-- OPENAI_API_KEY
  `-- provider-neutral generation layer
        |-- Hunyuan (deferred)
        `-- future 3D providers
```

Repository layout:

- `upstream/` - Blender source submodule, pinned to a compatible Blender 5.0 revision.
- `src/` - committed MUNO overlay changes.
- `source/` - generated Blender plus MUNO working tree; never committed.
- `build/` - generated build output; never committed.
- `docs/` - status, architecture, decisions, and historical project log.

## Agreed Direction

- Reproduce Mixar's useful functionality and layout, with entirely new MUNO branding.
- Start from Blender 5.0 for compatibility, then evaluate upgrades separately.
- Replace Mixie with a local `codex app-server` integration.
- Support both ChatGPT authentication and `OPENAI_API_KEY`.
- Keep generation behind provider-neutral interfaces; direct Hunyuan work comes after the core agent workflow.
- Do not depend on Mixar's private hosted backend.

## Documentation

- [`docs/ARCHITECTURE_AND_ROADMAP.md`](docs/ARCHITECTURE_AND_ROADMAP.md) - target architecture and phased delivery plan.
- [`docs/PROJECT_STATUS.md`](docs/PROJECT_STATUS.md) - what works in this checkout today.
- [`docs/ENGINEERING_DECISIONS.md`](docs/ENGINEERING_DECISIONS.md) - durable product and engineering decisions.
- [`docs/MIXAR_OVERLAY_IMPORT_PLAN.md`](docs/MIXAR_OVERLAY_IMPORT_PLAN.md) - public overlay inventory and import sequence.
- [`docs/SOURCE_WORKFLOW.md`](docs/SOURCE_WORKFLOW.md) - generated-source rules.
- [`docs/PROJECT_LOG.md`](docs/PROJECT_LOG.md) - chronological history, including work performed in older local paths.

## Licensing And Identity

MUNO must preserve applicable GPL and third-party notices for reused code while replacing Mixar/Mixie names, trademarks, logos, icons, URLs, and other product identity. Public Mixar source can inform and supply appropriately licensed code; its unpublished backend and missing native sources must be independently reconstructed.
