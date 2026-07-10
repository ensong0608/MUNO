# Project Status

Last updated: 2026-07-09

## Current State

MUNO is in project setup and architecture planning.

The active local repository now exists at:

```text
C:\DIG REPO\tools\Muno
```

The previous `H:\TOOLS\Muno` copy is retained as a fallback/network-share copy.

The GitHub remote is configured as:

```text
https://github.com/ensong0608/MUNO.git
```

The local `main` branch tracks `origin/main`.

## Working

- Local repo initialized.
- Remote configured.
- Initial planning docs created.
- Initial planning commits pushed to GitHub.
- Accidental nested repo at `H:\TOOLS\Muno\MUNO` removed.
- Product direction confirmed as a full Blender fork.
- Target audience confirmed as general AI 3D users.
- First AI workflow confirmed as prompt-to-scene.
- Blender upstream checkout completed at commit `8704773557367b9955894409616bb13b9d5c064a`.
- Blender upstream was later advanced by Blender's update command to commit `fc4e62d47f3d5c2e395ca2d7ab47e4c723ad7761`.
- Source generation script completed successfully and created `source/` as a clean Blender copy.
- Mixar reference map documented in `docs/MIXAR_REFERENCE_MAP.md`.
- Mixar-style MUNO build scripts added and lightly validated.
- MUNO build flow documented in `docs/MUNO_BUILD_FLOW.md`.
- Visual Studio Build Tools C++ workload is installed and detected from `C:\BuildTools`.
- Blender's Windows dependency bundle was downloaded into `upstream\lib\windows_x64` and copied into generated `source\lib\windows_x64`.
- Current measured size: `upstream\lib\windows_x64` is about 6.51 GB; generated `source\lib\windows_x64` is also about 6.51 GB.
- Workspace copied from `H:\TOOLS\Muno` to local storage at `C:\DIG REPO\tools\Muno` to avoid network-share build slowness.
- First native Windows Ninja build completed successfully from the `C:` workspace.
- Build output exists at `C:\DIG REPO\tools\Muno\build\Prod\bin`.
- `muno.exe` exists as a copy of the current built `blender.exe` baseline.
- Headless smoke test passed: built executable reported `MUNO_SMOKE_OK 5.3.0 Alpha`.

## Not Working Or Unresolved

- GitHub connector still returns `404` for `ensong0608/MUNO`, even though local `git push` succeeds.
- Blender submodule added at `upstream/`, pointing to `https://projects.blender.org/blender/blender.git`.
- Mixar repo cloned locally for analysis at `H:\TOOLS\Muno-reference\mixar-app`.
- No MUNO backend exists yet; scripts default to local placeholder URLs.
- No AI provider has been selected yet.
- No MUNO branding assets exist yet.
- Deep binary/app branding is not complete yet; the current `muno.exe` is a wrapper-level executable copy of the baseline Blender build.
- Mixar's AI overlay has not been imported yet; `src/` still contains only the placeholder file.

## Next Engineering Steps

1. Import/adapt Mixar `src/` overlay into MUNO `src/`.
2. Rebrand overlay identity/assets from Mixar to MUNO.
3. Stub or redirect Mixar backend calls to local MUNO placeholders.
4. Import/adapt Mixar's AI overlay into MUNO `src/`.
5. Validate that the imported overlay still builds incrementally.
6. Begin prompt-to-scene backend/API design.

## Notes

The Blender submodule will be a large local download. This is expected and matches Mixar's approach. The MUNO Git repo itself should remain small because it tracks the Blender source as a submodule pointer rather than committing Blender's full source tree.
