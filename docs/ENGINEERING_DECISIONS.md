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

## D005: Current Local Repo Root

The intended local repository root is:

```text
H:\TOOLS\Muno
```

There is currently also an empty nested Git repo at:

```text
H:\TOOLS\Muno\MUNO
```

This appears to have been created by GitHub Desktop. Do not delete or move it until the owner confirms whether GitHub Desktop should point at `H:\TOOLS\Muno` or `H:\TOOLS\Muno\MUNO`.

