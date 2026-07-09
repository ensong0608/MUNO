# MUNO Implementation Plan

## 1. Project Goal

Create MUNO as an independent Blender-based desktop application that keeps Blender's proven modeling foundation, replaces Mixar-specific branding and services, and adds our own AI-driven 3D creation workflow.

The intended result is not just a visual rebrand. MUNO should become its own product with:

- custom branding and distribution identity;
- a maintainable Blender overlay architecture;
- our own AI service layer;
- clear replacement points for third-party 3D generation models;
- reproducible local and CI builds;
- GPL-compliant source distribution.

## 2. What We Learned From Mixar

Mixar does not store the full Blender source directly in the GitHub repo. Instead, the repo uses Blender as a Git submodule:

- `upstream/` points to `https://projects.blender.org/blender/blender.git`;
- `src/` contains Mixar's modified files;
- build scripts generate `source/` by copying Blender from `upstream/` and overlaying `src/`;
- the final app is built from the generated `source/` directory.

This is the right pattern for MUNO because Blender is large and expensive to vendor directly. We should keep our repo small and intentional by committing only MUNO-specific changes.

## 3. Repository Layout

Planned local layout:

```text
H:\TOOLS\Muno\
  .git\
  README.md
  docs\
    MUNO_PLAN.md
  upstream\      # Blender submodule
  src\           # MUNO overlay files
  source\        # generated, ignored
  build\         # generated, ignored
  scripts\
    windows\
    unix\
```

Planned remote:

```text
https://github.com/ensong0608/MUNO
```

At the time this plan was created, the remote repository was not visible through the GitHub connector. We can still configure the local remote URL, but the online repo must exist before the first push succeeds.

## 4. Licensing And Branding Rules

Blender is GPL licensed, and Mixar's app source is open source. MUNO must respect the upstream license chain.

Required rules:

- keep license notices intact;
- publish source for distributed GPL binaries;
- document modifications clearly;
- remove Mixar trademarks, logos, names, icons, and product identity;
- replace Mixar/Mixie naming with MUNO-specific names;
- avoid implying endorsement by Blender or Mixar.

Branding work is a first-class requirement, not a cosmetic afterthought.

## 5. Architecture Direction

MUNO should keep three layers separate:

1. Blender base
   - Upstream Blender source, tracked as a submodule.
   - We should avoid editing this directly unless necessary.

2. MUNO desktop overlay
   - UI panels, operators, scripts, icons, app branding, bundled Python modules, and configuration.
   - These live in `src/`.

3. MUNO AI backend
   - Own hosted APIs for chat, tool execution, model routing, asset generation, user auth, billing if needed, and telemetry if needed.
   - The desktop app should treat this as a configurable service endpoint.

## 6. AI Feature Plan

Initial AI capabilities should be staged:

### Phase A: Local App Build

- clone/fork Mixar structure;
- initialize Blender submodule;
- reproduce a working local build;
- confirm app launches without relying on Mixar services;
- identify all Mixar backend calls.

### Phase B: Branding And Independence

- rename app identity to MUNO;
- replace icons, splash, app metadata, installer metadata, and package names;
- replace Mixar/Mixie UI strings;
- update license and attribution files;
- remove hard-coded Mixar backend URLs.

### Phase C: Backend Abstraction

- create a provider-neutral AI client layer;
- define API contracts for:
  - chat;
  - scene inspection;
  - Blender command/tool execution;
  - asset search;
  - text-to-3D;
  - image-to-3D;
  - authentication;
  - usage limits;
- add local development fallback/stub responses.

### Phase D: First MUNO AI Backend

- create a minimal backend service;
- support chat-to-Blender commands;
- support structured tool calls;
- log request/response traces for debugging;
- protect against unsafe arbitrary code execution;
- add API keys or auth tokens.

### Phase E: 3D Generation Integrations

Evaluate providers for:

- text-to-3D;
- image-to-3D;
- texture/material generation;
- mesh cleanup or retopology;
- rigging/animation assistance.

Integrate behind provider interfaces so we can swap models without rewriting the Blender UI.

### Phase F: Product Workflow

Build MUNO-specific workflows:

- prompt-to-scene;
- selected-object editing;
- material and texture generation;
- asset import and cleanup;
- procedural scene creation;
- animation helpers;
- versioned prompt history;
- user asset library.

## 7. Build Strategy

Start with Windows because the requested local path is on Windows.

Steps:

1. Install required build dependencies.
2. Add Blender as `upstream` submodule.
3. Import Mixar's overlay/build script pattern.
4. Generate `source/` from `upstream/` plus `src/`.
5. Build a debug/dev version first.
6. Build a release package later.

We should not attempt full release automation until a local developer build launches reliably.

## 8. Risk Areas

- Blender builds are large and slow.
- Blender's build dependencies can be brittle on Windows.
- Mixar's AI backend is not included, so AI features will fail until replaced.
- Some Mixar changes may be deeply coupled to their backend contracts.
- Trademark cleanup must be thorough before public distribution.
- GPL compliance must be tracked from the beginning.
- 3D generation providers may have licensing, cost, and quality differences.

## 9. Immediate Next Steps

1. Create the local repo at `H:\TOOLS\Muno`.
2. Add `.gitignore`, README, and this plan.
3. Configure remote as `https://github.com/ensong0608/MUNO.git`.
4. Add Blender upstream as a submodule.
5. Pull Mixar source into a separate inspection area or add it as a temporary reference remote.
6. Compare Mixar overlay files against Blender upstream.
7. Decide whether to:
   - fork Mixar directly and rebrand; or
   - recreate the overlay structure cleanly from Blender plus selected Mixar ideas.

Recommendation: start from Mixar's repo as a reference, but keep MUNO's committed history clean and intentional. Do not blindly preserve Mixar branding or backend assumptions.

## 10. Definition Of Done For Milestone 1

Milestone 1 is complete when:

- `H:\TOOLS\Muno` is a local Git repo;
- the remote URL is configured;
- Blender is added as a submodule;
- generated directories are ignored;
- project plan is committed locally;
- we have a reproducible command sequence for initializing the source tree;
- we know exactly where Mixar-specific backend calls and branding live.

