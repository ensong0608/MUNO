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

5. Which AI providers do we want to evaluate first?
   - OpenAI for chat/tool planning;
   - Tripo, Meshy, Luma, Stability, or other 3D providers;
   - local models where practical.

6. Do we want user accounts and billing in the first version, or should the first version use local API keys only?

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

11. Should GitHub Desktop use `H:\TOOLS\Muno` as the repo root, or should we switch to the nested `H:\TOOLS\Muno\MUNO` folder it appears to have created?
   - Answer at the time: use `H:\TOOLS\Muno`.
   - Current update: use `C:\DIG REPO\tools\Muno` as the active local repo because it is on local storage and should build faster.
   - The accidental nested repo was removed.

12. Are we comfortable downloading and building Blender locally now?

13. Do we want to preserve Mixar history by forking, or keep MUNO history clean by rebuilding the overlay with Mixar as a reference?

14. What license/notice files do we want at repo root for MUNO's own code and branding?
