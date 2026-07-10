# Project Questions

These are the questions that matter before we start shaping MUNO's product and architecture too deeply.

## Product Direction

1. Who is MUNO primarily for?
   - Answer: general AI 3D users.

2. What is the first workflow that must feel excellent?
   - Answer: prompt-to-scene first.
   - Later workflows: prompt-to-model, image-to-3D, edit selected object, materials/textures, animation.

3. Should MUNO be a full Blender fork or a lighter Blender add-on first?
   - Answer: full Blender fork, like Mixar.

## AI And Backend

4. Should the first backend be local-only, cloud-hosted, or hybrid?
   - Answer: local Codex app-server first; generation providers may be cloud or local behind a neutral interface.

5. Which AI providers do we want to evaluate first?
   - Answer: Codex for chat, planning, and Blender tool use.
   - Hunyuan remains desired for 3D workflows but is deferred.
   - Other local or hosted 3D models can be added behind the same provider contract.

6. Do we want user accounts and billing in the first version, or should the first version use local API keys only?
   - Answer: no MUNO accounts or billing initially. Support ChatGPT authentication and `OPENAI_API_KEY` for Codex.

7. Should generated assets be stored locally, in cloud storage, or both?

## Branding

8. What does MUNO stand for, if anything?

9. What tone should the app have?
   - professional production tool;
   - creator-friendly assistant;
   - experimental AI lab;
   - game/UGC-focused studio.

10. Do we have logo, color, and icon direction yet?

## Engineering

11. Which local checkout is active?
   - Current answer: the repository containing this file, presently `C:\Users\lawre\Desktop\PROJECTS\MUNO`.
   - `H:\TOOLS\Muno` and `C:\DIG REPO\tools\Muno` are historical workspaces; the accidental nested repo was removed.

12. Are we comfortable downloading and building Blender locally now?

13. Do we want to preserve Mixar history by forking, or keep MUNO history clean by rebuilding the overlay with Mixar as a reference?
   - Answer: keep intentional MUNO history and import/reconstruct reviewed slices from the public Mixar reference.

14. What license/notice files do we want at repo root for MUNO's own code and branding?
   - Answer: GPL license texts, NOTICE, REUSE metadata, source correspondence, and a trademark/identity policy are established on the foundation branch.

15. What compatibility and branding target should guide the first import?
   - Answer: functional/layout fidelity, entirely new MUNO branding, and a Blender 5.0 base.
