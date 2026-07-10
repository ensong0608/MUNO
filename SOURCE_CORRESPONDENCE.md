<!-- SPDX-FileCopyrightText: 2026 MUNO contributors -->
<!-- SPDX-License-Identifier: GPL-3.0-or-later -->

# Source Correspondence

This document defines how MUNO release binaries correspond to their complete, preferred source form. It is a release requirement, not a claim that a public MUNO binary has already been released.

## Source inputs

MUNO combines three traceable source layers:

1. The MUNO repository, including its build, generation, overlay, and packaging scripts.
2. A pinned Blender source revision at `upstream/`. Blender's own notices and third-party license inventory remain authoritative for that tree.
3. The selected, independently branded portions of Mixar App, with original file notices and modification history preserved.

The Mixar checkout inspected for the initial MUNO reconstruction was commit `47557b7646b3c8999bb8a9e41179fe06ca7e1373` from <https://github.com/Mixar-AI/mixar-app>. Mixar's published source correspondence identifies Blender commit `f52ba4dcdf5f669c1bc57f39a0e056be30d3ab60` for its first public source candidate. MUNO must record its own final Blender gitlink and any imported Mixar baseline in each release tag; these references are provenance, not automatic updates.

## Release rule

Every distributed MUNO binary must be reproducible from the exact public source tag associated with that binary. Before publishing a release:

1. Pin and commit every source dependency, including the Blender gitlink.
2. Record the Mixar baseline and all MUNO modification commits.
3. Include the scripts and configuration needed to regenerate generated build inputs.
4. Tag the complete source used for the binary.
5. Build and package from that tag, then publish matching version identifiers and checksums.
6. Make the corresponding source available in a machine-readable form in compliance with the applicable GPL version.

Signing keys, service credentials, user secrets, and private deployment infrastructure are not Corresponding Source and must not be published. Build scripts, interface definitions, patches, and non-secret configuration required to produce the distributed executable are Corresponding Source and must be published.

## Derived-work tracking

Mixar-derived files retain Adeveda Enterprises Private Limited copyright notices. Blender-derived files retain Blender and contributor notices. Texture-painting files corresponding to Mixar's ucupaint-derived asset and layer/channel implementation must retain attribution to ucupumar as well as later modifiers. [NOTICE.md](NOTICE.md) contains the project-level acknowledgements; file-level SPDX identifiers are authoritative where present.

Mixar/Mixie brand assets are not part of MUNO's distributable source or binary identity. If an upstream asset is temporarily present during reconstruction, it must remain identified under its upstream brand-asset terms and must be removed or replaced before any MUNO distribution.
