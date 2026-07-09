# Project Log

This log records what happened, what worked, and what did not work so we do not repeat the same investigations.

## 2026-07-08

### Created local repo

Created the local MUNO repo at:

```text
H:\TOOLS\Muno
```

Initialized Git and made the first commit:

```text
c0b752a Initialize MUNO planning repo
```

### Added planning docs

Added:

- `README.md`
- `.gitignore`
- `docs/MUNO_PLAN.md`
- `docs/ENGINEERING_DECISIONS.md`
- `docs/MILESTONES.md`
- `docs/QUESTIONS.md`

Committed as:

```text
3c964f2 Document MUNO engineering roadmap
```

### Remote setup

Configured remote:

```text
origin https://github.com/ensong0608/MUNO.git
```

`git ls-remote origin HEAD` succeeded but returned no refs, which indicated the remote was reachable and likely empty.

Pushed local `main` successfully:

```text
git push -u origin main
```

### GitHub connector issue

The GitHub connector returned `404` for:

```text
ensong0608/MUNO
```

Local Git commands can push successfully, so this appears to be a connector visibility/permission issue rather than a normal Git remote issue.

Status: unresolved, but not blocking local Git work.

### Removed accidental nested repo

GitHub Desktop created an empty nested Git repo at:

```text
H:\TOOLS\Muno\MUNO
```

It contained only its own `.git` directory. The owner confirmed removal, and it was deleted.

### Confirmed product direction

Confirmed decisions:

- MUNO should be a full Blender fork like Mixar.
- The first target audience is general AI 3D users.
- The first AI workflow should be prompt-to-scene.
- Additional workflows will be added one by one after that.

### Blender submodule explanation

Clarified that adding Blender as a submodule means:

- MUNO stores a pointer to Blender's official repository;
- local setup downloads Blender into `upstream/`;
- MUNO changes live separately in `src/`;
- generated working source lives in `source/`;
- build output lives in `build/`.

This is the same general method Mixar uses.
### Added Blender upstream submodule

Started adding Blender as the `upstream/` submodule:

```text
git submodule add https://projects.blender.org/blender/blender.git upstream
```

The first attempt timed out after about two minutes and left a partial `upstream/` folder with only a Git pointer file.

The second long attempt timed out from the command wrapper after about fifteen minutes, but child Git processes continued running and completed the checkout. This is expected risk with a large repository on this machine/path: the wrapper timeout can fire while Git is still doing real checkout work.

Final result:

- root `.gitmodules` was created;
- `upstream/` was registered as a Git submodule;
- Blender was checked out at commit `8704773557367b9955894409616bb13b9d5c064a`;
- no stale Git clone processes remained after completion.

Status: working.

Next related work:

- commit the submodule pointer;
- add scripts for generating MUNO's working `source/` tree from `upstream/` plus `src/`;
- check whether Blender LFS/build dependency setup needs a separate step.
