# MUNO

MUNO is planned as a custom Blender-based desktop application with integrated AI-assisted 3D creation workflows.

The project will follow the same maintainable structure used by Mixar:

- `upstream/` - Blender source as a Git submodule.
- `src/` - MUNO overlay changes applied on top of Blender.
- `source/` - generated local working tree created from `upstream/` plus `src/`.
- `build/` - generated build output.
- `docs/` - project planning, architecture notes, and implementation decisions.

The `source/` and `build/` directories should not be committed.

