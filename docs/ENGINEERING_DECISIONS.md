# Engineering Decisions

This document records project decisions that should stay stable unless we explicitly revisit them.

## D001: Repository Shape

MUNO will use an overlay repository model:

- Blender source is tracked as a Git submodule at `upstream/`.
- MUNO-specific changes live in `src/`.
- A generated `source/` tree is created locally from `upstream/` plus `src/`.
- Build output lives in `build/`.
- Generated trees are ignored and not committed.

Rationale: Blender is too large to vendor directly into the application repo. The overlay model keeps MUNO maintainable and makes our changes easier to review.

## D002: Product Identity

MUNO will be treated as an independent product, not a Mixar-branded derivative.

Required implications:

- remove Mixar and Mixie product naming from visible UI;
- replace icons, splash screens, app metadata, installer metadata, and domain references;
- keep required upstream license and attribution notices;
- avoid implying Blender or Mixar endorsement.

## D003: AI Backend Ownership

MUNO will not depend on Mixar's hosted backend.

The desktop app should communicate with a MUNO-owned or MUNO-configured API through a provider-neutral client layer.

Initial backend capabilities:

- chat;
- scene inspection;
- structured tool calls;
- asset generation;
- asset import;
- authentication or API-key access;
- development stubs for offline builds.

## D004: First Platform

Windows is the first supported development platform.

Rationale: the requested local project path is on Windows and the immediate goal is to establish a working local development build.

Linux/macOS support can be added after the Windows build is understood.

## D005: Local Repo Root

The intended local repository root is:

```text
C:\DIG REPO\tools\Muno
```

An accidental empty nested Git repo was created by GitHub Desktop at:

```text
H:\TOOLS\Muno\MUNO
```

The owner confirmed it should be removed. It contained only its own `.git` folder and was deleted.

GitHub Desktop should use `C:\DIG REPO\tools\Muno` as the active repository root going forward. The old `H:\TOOLS\Muno` copy remains as a fallback.

## D006: Product Form

MUNO will be a full Blender fork, following the same broad approach as Mixar.

We are not starting as a lightweight Blender add-on.

Rationale: the goal is to create a custom AI-enabled Blender-based application, not merely install a panel into stock Blender.

## D007: Target User

The first target audience is general AI 3D users.

This means the first version should prioritize clear end-to-end creation workflows over niche professional tooling.

## D008: AI Workflow Order

MUNO will build AI workflows one at a time.

Initial priority order:

1. prompt-to-scene;
2. prompt-to-model;
3. image-to-3D;
4. edit selected object with natural language;
5. materials and textures;
6. animation.

## D009: Blender Submodule Meaning

Adding Blender as the `upstream/` submodule means the MUNO repo will store a pointer to Blender's official source repository instead of storing the full Blender source directly.

This is how Mixar structured its repo:

- `upstream/` points to Blender's official Git repository;
- `src/` contains app-specific overlay changes;
- scripts create a generated `source/` folder by copying Blender and applying the overlay;
- builds happen from the generated `source/` folder.

The submodule itself can be large when initialized locally, but the MUNO Git repo stays small because it commits only the submodule pointer and MUNO-specific files.
