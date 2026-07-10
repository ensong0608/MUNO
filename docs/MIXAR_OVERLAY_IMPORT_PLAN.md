# Mixar Overlay Import Plan

Last updated: 2026-07-09

This document records what was found in the local Mixar reference checkout and how MUNO should import it safely.

Reference checkout:

```text
H:\TOOLS\Muno-reference\mixar-app
```

Reference commit:

```text
47557b7 Merge pull request #914 from Mixar-AI/develop
```

## Overlay Inventory

Mixar's public `src/` overlay is about 18 MB and is not the full Blender source tree.

Top-level size summary:

| Path | Files | Approx. Size |
| --- | ---: | ---: |
| `src/release` | 70 | 9.32 MB |
| `src/scripts` | 1115 | 8.44 MB |
| `src/intern` | 9 | 0.42 MB |
| `src/tests` | 1 | 0.04 MB |
| `src/tools` | 1 | 0.01 MB |

Important finding: this Mixar checkout does not contain `src/source/blender` or `src/source/creator`. Native overlay changes in this public checkout are mainly:

- `src/CMakeLists.txt`
- `src/GNUmakefile`
- `src/intern/ghost/intern/*`
- release/package assets under `src/release`
- Python runtime/add-on code under `src/scripts/mixar`

## Python Module Inventory

Mixar's main runtime code is under:

```text
src/scripts/mixar
```

Module summary:

| Module | Files | Approx. Size |
| --- | ---: | ---: |
| `paint` | 609 | 4840.7 KB |
| `moodboard` | 92 | 880.0 KB |
| `space_mixie_chat` | 60 | 592.8 KB |
| `common` | 90 | 452.4 KB |
| `uv_editor` | 46 | 273.4 KB |
| `testing` | 36 | 250.9 KB |
| `onboarding` | 27 | 199.5 KB |
| `texel_density` | 13 | 113.4 KB |
| `agent_bubble` | 19 | 73.2 KB |
| `hunyuan` | 12 | 71.3 KB |
| `asset_search` | 6 | 56.3 KB |
| `space_mixie` | 12 | 54.2 KB |
| `operation_history` | 10 | 47.0 KB |
| `byok` | 7 | 40.2 KB |
| `auth` | 6 | 35.0 KB |
| `mesh_segment` | 5 | 28.7 KB |
| `scene_graph` | 11 | 25.7 KB |
| `workflow` | 6 | 23.9 KB |
| `agent_viewport_lock` | 4 | 14.1 KB |
| `space_texture_sets` | 2 | 10.0 KB |
| `agent_scene_strip` | 1 | 3.8 KB |

## Relevant AI/Prompt-To-Scene Areas

For MUNO's first target, prompt-to-scene, the most relevant Mixar areas are:

- `src/scripts/mixar/modules/space_mixie_chat`
- `src/scripts/mixar/modules/common/api`
- `src/scripts/mixar/modules/common/websocket`
- `src/scripts/mixar/modules/moodboard`
- `src/scripts/mixar/modules/scene_graph`
- `src/scripts/mixar/modules/workflow`
- `src/scripts/mixar/modules/auth`
- `src/scripts/mixar/modules/byok`

For model generation and provider flows later:

- `src/scripts/mixar/modules/hunyuan`
- `src/scripts/mixar/modules/moodboard/core/*generation*`
- `src/scripts/mixar/modules/moodboard/core/*scene*`
- `src/scripts/mixar/modules/common/job_queue`

For broader product polish:

- `src/scripts/mixar/modules/paint`
- `src/scripts/mixar/modules/uv_editor`
- `src/scripts/mixar/modules/texel_density`
- `src/scripts/mixar/modules/onboarding`

## Recommended Import Order

Do not blindly copy the entire Mixar `src/` overlay in one step. The baseline MUNO build now works, and we should preserve that.

Recommended sequence:

1. Import Python package skeleton as `src/scripts/muno`, rebranded from `mixar`.
2. Import only the chat/API/config/common modules needed to load a MUNO panel and connect to a local backend placeholder.
3. Add compatibility shims where the Mixar code expects custom editor spaces that MUNO has not imported yet.
4. Run incremental build and headless smoke test after each import slice.
5. Import moodboard/prompt-to-scene UI after the chat/API layer loads.
6. Import generation/job queue pieces only after MUNO has a local backend contract.
7. Defer paint/UV/texel-density modules until prompt-to-scene is stable.
8. Defer release icons, splash, and installer branding until runtime behavior is working.

## Rebrand Rules

When importing:

- package path `mixar` becomes `muno`;
- env vars `MIXAR_*` become `MUNO_*`;
- config file `mixar.json` becomes `muno.json`;
- user-facing `Mixar` becomes `MUNO`;
- avoid copying Mixar trademark assets directly;
- preserve SPDX/license headers and document GPL inheritance.

## Current State

MUNO currently has a validated baseline native build:

```text
C:\DIG REPO\tools\Muno\build\Prod\bin\muno.exe
```

Current caveat: `muno.exe` is a copy of the built `blender.exe` baseline. The Mixar AI overlay is not imported yet.
