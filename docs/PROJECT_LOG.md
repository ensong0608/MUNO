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
### Added source generation workflow

Created:

- `scripts/windows/generate-source.ps1`
- `scripts/unix/generate-source.sh`
- `docs/SOURCE_WORKFLOW.md`
- `docs/BUILD_PREREQUISITES.md`
- `src/.gitkeep`

Ran the Windows generator as a background process and monitored progress through logs under `tmp/`.

Final source generation result:

- `source/` was created successfully;
- about 1.05 GB copied;
- 20,277 files copied;
- no copy failures;
- no overlay files applied because `src/` currently contains only `.gitkeep`;
- `source/` and `tmp/` are ignored by Git.

Status: working.

Next related work:

- validate Blender's update/build prerequisites;
- run `make.bat update` from `source/` when approved;
- then run the first development build.
### Tried Blender update/build prerequisite validation

Checked available tools from a plain shell:

- Git found;
- Python launcher found;
- CMake not found on PATH;
- SVN not found on PATH;
- `python` not found on PATH;
- `cl` not found on PATH.

Ran:

```text
make.bat update
```

Result: failed quickly because Blender could not detect Visual Studio.

Found Visual Studio Build Tools 2022 installed at:

```text
C:\BuildTools
```

Tried `make.bat update` through Visual Studio environment setup. `LaunchDevCmd.bat` opened an interactive persistent shell and did not return to Blender's update command, so that wrapper was stopped.

Tried:

```text
make.bat update 2022b verbose
```

Result: failed because the existing Build Tools install does not include `Microsoft.VisualStudio.Component.VC.Tools.x86.x64` / Desktop C++ workload components required by Blender.

Attempted to start Visual Studio Installer modification using Blender's `vsconfig`, but the action was blocked because it is a system-wide modification requiring explicit owner approval.

Status: blocked pending approval to modify Visual Studio Build Tools or manual installation of the required C++ workload.
### Cloned and inspected Mixar reference

Cloned Mixar's public repo to:

```text
H:\TOOLS\Muno-reference\mixar-app
```

Inspected reference commit:

```text
47557b7 Merge pull request #914 from Mixar-AI/develop
```

Confirmed Mixar's actual structure:

- Blender is a submodule at `upstream/`;
- app changes are in `src/`;
- build scripts copy `upstream/` into `source/` and overlay `src/`;
- Windows build flow uses `scripts/windows/settings.bat`, `overlay.bat`, and `build.bat`;
- Mixar backend is not included, but desktop-side clients and config references are present.

Created `docs/MIXAR_REFERENCE_MAP.md` to record the copy/rebrand strategy.
### Added Mixar-style MUNO build scripts

Generated MUNO-adapted versions of Mixar's build/config scripts from the local Mixar reference repo.

Added:

- `.env.example`
- `VERSION`
- `Makefile`
- `cmake/muno_overrides.cmake`
- `scripts/generate_config.py`
- `scripts/python_requirements.txt`
- `scripts/windows/settings.bat`
- `scripts/windows/init.bat`
- `scripts/windows/overlay.bat`
- `scripts/windows/build.bat`
- `scripts/windows/build_clean.bat`
- `scripts/windows/build_ms.bat`
- `scripts/windows/build_ninja.bat`
- `scripts/windows/install.bat`
- `scripts/windows/check_overlay_conflicts.bat`
- `scripts/unix/settings.sh`
- `scripts/unix/init.sh`
- `scripts/unix/overlay.sh`
- `scripts/unix/build.sh`
- `scripts/unix/build_clean.sh`
- `scripts/unix/install.sh`
- `scripts/unix/run.sh`
- `scripts/unix/check_overlay_conflicts.sh`

Adapted names from Mixar to MUNO in those scripts, including environment variables, app names, executable name, `muno.json`, and local default backend URLs.

Validation performed:

- `py scripts\generate_config.py --output tmp\muno.test.json` succeeded.
- `cmd.exe /v:on /c "cd /d H:\TOOLS\Muno && call scripts\windows\settings.bat ..."` loaded expected MUNO variables.
- `scripts\windows\overlay.bat` completed successfully with no stderr.

Status: build script structure is working at the config/overlay level. Full compile remains blocked by missing Visual Studio C++ workload and by the fact that Mixar's full `src/` overlay has not yet been imported/adapted.

### Installed Blender Windows build prerequisites

Visual Studio Build Tools at `C:\BuildTools` now includes the C++ workload needed by Blender.

Validated from the Visual Studio developer environment:

- CMake is available from `C:\BuildTools\Common7\IDE\CommonExtensions\Microsoft\CMake\CMake\bin\cmake.exe`.
- MSVC `cl.exe` is available from `C:\BuildTools\VC\Tools\MSVC\14.44.35207\bin\Hostx64\x64\cl.exe`.
- Ninja is available from `C:\BuildTools\Common7\IDE\CommonExtensions\Microsoft\CMake\Ninja\ninja.exe`.

Important detail: CMake is available through the Visual Studio developer environment, not necessarily from a plain terminal PATH.

### Downloaded Blender Windows platform libraries

The first attempt to run Blender's update command from generated `source/` failed:

```text
fatal: C:/Program Files/Git/mingw64/libexec/git-core\git-submodule cannot be used without a working tree.
```

Reason: `source/` is a generated copy and is not a Git working tree. Blender's dependency update must run from `upstream/`, which is the real Blender Git checkout.

The update was rerun from:

```text
H:\TOOLS\Muno\upstream
```

Result:

- Blender's `lib/windows_x64` dependency bundle was downloaded and hydrated through Git LFS.
- The update process advanced `upstream/` from `8704773557367b9955894409616bb13b9d5c064a` to `fc4e62d47f3d5c2e395ca2d7ab47e4c723ad7761`.
- The MUNO overlay step was rerun and copied the hydrated libraries into generated `source/`.

Measured sizes:

- `H:\TOOLS\Muno\upstream\lib\windows_x64`: 19,078 files, about 6.51 GB.
- `H:\TOOLS\Muno\source\lib\windows_x64`: 19,076 files, about 6.51 GB.
- `H:\TOOLS\Muno\upstream`: about 7.56 GB total.
- `H:\TOOLS\Muno\source`: about 7.56 GB total.

Why this is needed: Blender's Windows build expects a large precompiled dependency bundle containing libraries such as Python and other third-party components. Mixar does not commit those files either; its public repo only records the Blender submodule and overlay files.

Checked local Mixar reference folder:

- `H:\TOOLS\Muno-reference\mixar-app\upstream`: missing.
- `H:\TOOLS\Muno-reference\mixar-app\source`: missing.
- `H:\TOOLS\Muno-reference\mixar-app\src`: about 0.02 GB.

Conclusion: the local Mixar checkout cannot be used as the source for Blender or the Windows dependency bundle because those folders are not present there.

### Copied MUNO workspace to local storage

Copied the MUNO workspace from the network-backed `H:` drive to local storage:

```text
Source: H:\TOOLS\Muno
Target: C:\DIG REPO\tools\Muno
```

Reason: `H:` maps to `\\aswsmain\users$\LLee`, which is a network share. Blender builds read and write a large number of small files, so building directly on a network share is likely to be much slower than building on local storage.

Validation after copy:

- Git remote is still `https://github.com/ensong0608/MUNO.git`.
- Active working tree root is `C:/DIG REPO/tools/Muno`.
- Blender `upstream` submodule commit is `fc4e62d47f3d5c2e395ca2d7ab47e4c723ad7761`.
- `C:\DIG REPO\tools\Muno\upstream`: 39,359 files, about 7.56 GB.
- `C:\DIG REPO\tools\Muno\source`: 39,358 files, about 7.56 GB.
- `C:\DIG REPO\tools\Muno\upstream\lib\windows_x64`: 19,078 files, about 6.51 GB.
- `C:\DIG REPO\tools\Muno\source\lib\windows_x64`: 19,076 files, about 6.51 GB.

Status: use `C:\DIG REPO\tools\Muno` for build work going forward.
