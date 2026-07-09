# Project Status

Last updated: 2026-07-08

## Current State

MUNO is in project setup and architecture planning.

The local repository exists at:

```text
H:\TOOLS\Muno
```

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
- Source generation script completed successfully and created `source/` as a clean Blender copy.
- Mixar reference map documented in `docs/MIXAR_REFERENCE_MAP.md`.

## Not Working Or Unresolved

- GitHub connector still returns `404` for `ensong0608/MUNO`, even though local `git push` succeeds.
- Blender submodule added at `upstream/`, pointing to `https://projects.blender.org/blender/blender.git`.
- Mixar repo cloned locally for analysis at `H:\TOOLS\Muno-reference\mixar-app`.
- Full Blender build has not been validated yet.
- `make.bat update` is blocked because Visual Studio Build Tools is installed without Blender-required C++ workload components.
- No MUNO backend exists yet.
- No AI provider has been selected yet.
- No MUNO branding assets exist yet.

## Next Engineering Steps

1. Add Blender as the `upstream/` submodule.
2. Add scripts for source generation.
3. Clone or add Mixar as a local reference.
4. Map Mixar overlay files, backend calls, and branding assets.
5. Create a first MUNO overlay skeleton in `src/`.
6. Document Windows build prerequisites.

## Notes

The Blender submodule will be a large local download. This is expected and matches Mixar's approach. The MUNO Git repo itself should remain small because it tracks the Blender source as a submodule pointer rather than committing Blender's full source tree.
