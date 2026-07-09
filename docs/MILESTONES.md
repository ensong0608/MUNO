# Milestones

## Milestone 0: Repo And Planning

Status: complete

Deliverables:

- local Git repository at `H:\TOOLS\Muno`;
- remote configured as `https://github.com/ensong0608/MUNO.git`;
- project plan committed;
- engineering decisions documented;
- open questions documented;
- project status documented;
- project log documented.

Exit criteria:

- final local repo root confirmed as `H:\TOOLS\Muno`;
- online Git push access confirmed.

Notes:

- GitHub connector visibility is unresolved, but local Git push access works.

## Milestone 1: Blender Base

Status: next

Deliverables:

- Blender added as `upstream/` submodule; done
- generated `source/` workflow scripted;
- build prerequisites documented;
- first local source generation succeeds.

Exit criteria:

- `upstream/` can be initialized from a clean clone;
- `source/` can be regenerated without manual copying;
- generated folders remain untracked.

## Milestone 2: Mixar Analysis

Status: not started

Deliverables:

- Mixar repo cloned or added as reference remote outside committed source;
- list of overlay files;
- list of backend endpoints and environment variables;
- list of branding assets and strings;
- decision on reuse versus clean reimplementation.

Exit criteria:

- MUNO has a precise map of what must be replaced before any public release.

## Milestone 3: MUNO Identity

Status: not started

Deliverables:

- app name changed to MUNO;
- visible Mixar/Mixie strings removed;
- placeholder MUNO icons and splash assets added;
- installer/app metadata updated;
- license and attribution files updated.

Exit criteria:

- local build no longer presents itself as Mixar.

## Milestone 4: AI Abstraction

Status: not started

Deliverables:

- provider-neutral desktop AI client;
- development stub backend;
- configurable backend URL;
- structured tool-call contract;
- safe command execution boundaries.

Exit criteria:

- app can run without Mixar services and show a working MUNO AI panel using stubs.

## Milestone 5: First Real AI Workflow

Status: not started

Deliverables:

- first provider integration selected;
- one end-to-end AI workflow implemented;
- result import into Blender scene;
- error, loading, and retry states.

Exit criteria:

- a user can create or modify a 3D scene through MUNO AI without Mixar infrastructure.
