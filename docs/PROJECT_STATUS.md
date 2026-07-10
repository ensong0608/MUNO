# Project Status

Last updated: 2026-07-10

## Active Checkout

The active checkout for current work is the repository containing this file. On the present machine it is:

```text
C:\Users\lawre\Desktop\PROJECTS\MUNO
```

Remote: `https://github.com/ensong0608/MUNO.git`

Commands and documentation should use paths relative to the repository root. Older absolute paths in `PROJECT_LOG.md` describe historical workspaces and are not current instructions.

## Current State Of This Clone

- Repository planning and build scaffolding exist.
- `src/` contains only `.gitkeep`; no application overlay is present.
- `upstream/` is initialized at Blender commit
  `f52ba4dcdf5f669c1bc57f39a0e056be30d3ab60` (Blender 5.0.1 RC).
- Blender's platform dependency bundle has not been downloaded in this clone.
- `source/` and `build/` do not exist here.
- The application cannot currently be run from this clone.
- Mixar's public repository has been audited separately and is not a complete buildable product snapshot: its Blender gitlink and required native Mixie Chat editor sources are absent.
- No Codex integration, MUNO runtime UI, or generation-provider adapter exists yet.

## Confirmed Decisions

- Functional and layout fidelity to Mixar, with independent MUNO branding.
- Blender 5.0 as the initial compatibility base.
- Local Codex app-server replaces Mixie as the agent runtime.
- Both ChatGPT login and API-key authentication are supported.
- Generation APIs use provider-neutral interfaces.
- Hunyuan/model generation is retained as a goal but deferred until the core application and Codex workflow are working.

## Historical Validation

On 2026-07-09, a different checkout at `C:\DIG REPO\tools\Muno` generated a Blender source tree and completed a Blender 5.3-alpha baseline build. A copied executable passed a headless smoke test there. This proves that the earlier build scaffolding could drive a native build on that machine; it does **not** validate the current Desktop clone, Mixar overlay compatibility, MUNO branding, or the new Blender 5.0 target.

The older `H:\TOOLS\Muno` and `C:\DIG REPO\tools\Muno` paths are historical only.

## Immediate Work

1. Repair repository/licensing foundations and pin an appropriate Blender 5.0 base.
2. Initialize a clean Blender 5.0 source/build workflow in this clone.
3. Import the usable public Mixar overlay in reviewable slices, preserving notices.
4. Replace product identity and remove dependencies on Mixar services.
5. Reconstruct the missing MUNO chat/editor surface where public Mixar sources are incomplete.
6. Integrate local Codex app-server and expose controlled Blender tools.
7. Add provider-neutral generation jobs; implement Hunyuan later.

See `ARCHITECTURE_AND_ROADMAP.md` for phase gates.
