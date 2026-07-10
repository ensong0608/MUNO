# Milestones

Status is scoped to the current clone, not historical workspaces.

## Milestone 0: Direction And Audit

Status: complete

- product is a full Blender-based MUNO application;
- target is Mixar functional/layout fidelity with independent branding;
- public Mixar source and missing components are inventoried;
- Blender 5.0, Codex app-server, dual authentication, and provider-neutral generation are agreed.

## Milestone 1: Reproducible Blender 5.0 Foundation

Status: in progress

- establish licensing and attribution; done on the foundation branch
- pin and initialize Blender 5.0 in `upstream/`; done at `f52ba4dc...`
- download Blender's platform dependency bundle;
- repair repo-relative setup/build scripts;
- generate `source/`, build, and smoke-test from a clean clone;
- add lightweight CI/validation.

Exit: this clone reproducibly launches a Blender 5.0 baseline.

## Milestone 2: MUNO Application Shell

Status: not started

- import reviewed public overlay slices;
- replace Mixar/Mixie identity and endpoints;
- reconstruct missing editor/UI components;
- launch without Mixar services.

Exit: a MUNO-branded application shell launches and its core panels load.

## Milestone 3: Codex Agent

Status: not started

- manage local Codex app-server lifecycle;
- support ChatGPT and API-key authentication;
- stream conversations and tool events into the UI;
- expose controlled Blender inspection and mutation tools;
- implement approvals, cancellation, and error recovery.

Exit: Codex can inspect and safely modify the current scene.

## Milestone 4: Workflow Fidelity

Status: not started

- restore prompt-to-scene, moodboard, scene graph, and history workflows;
- replace Mixie-specific protocols with Codex events/tools;
- add relevant regression and smoke tests.

Exit: prompt-to-scene is useful without Mixar infrastructure.

## Milestone 5: Generation Providers

Status: deferred

- provider-neutral job, progress, result, and credential contracts;
- asset cache/import workflow;
- direct Hunyuan integration and additional providers.

Exit: a direct 3D provider completes an end-to-end generation/import flow.

## Milestone 6: Distribution

Status: not started

- final branding and package metadata;
- complete source/license/notice bundles;
- clean-machine install and authentication validation.

Exit: MUNO can be distributed with reproducible artifacts and complete notices.
