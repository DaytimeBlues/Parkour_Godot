# Parkour Godot: The Great Woodland

10 November 2026. Planning only. No implementation, deployment or source checkpoint advancement.


This is the public-safe publication copy of the delivered planning document. Private source locators and personal computer paths are omitted; private evidence is described, not offered as a publicly reproducible check. Runtime baseline references the separate [solo-finish candidate](https://github.com/DaytimeBlues/Parkour_Godot/tree/ba8e8a6915dbcfbb103879e645b3f1a861cc9085), not a claim that these features are merged into main.

## 1. Direction and scope

Keep the approved woodland direction: warm yellow-lime and olive tree masses, pale cream stone, broad moss-edged landings, chunky roots and bright sky. Expand it into one connected landscape rather than several unrelated biomes. The proposal is a 1,024 x 1,024 m world, centered near the origin, with eight distinct woodland zones, three replayable circuits and a full expedition route.

The square is the terrain envelope, not one million square metres of detailed parkour. Detail follows approximately 2.9-3.4 km of connected route, with woodland masses, shallow valleys and non-traversable outer ridges filling the spaces. North is -Z. Reserve a roughly 64 m outer buffer (interior about +/-448 m). Zone footprints below are overlapping composition envelopes, not ownership tiles; their backdrop/dressing edges may enter that buffer, but route anchors and the main grounded path should not.

All new dimensions, population counts, route lengths, timings, budgets and asset variants are planning estimates. They become acceptance limits only after a representative controller/camera/wing and Web pilot. This document plans the work; it does not build, install, replace, upload source, deploy, spend credits or accept a release.

No new biome, combat, enemy AI, collectibles, currency, free-flight stamina system, historical castle, dynamic weather, procedural infinite world or new multiplayer mode is required. Other animals remain a separate existing asset-readiness queue, not a dependency for a playable fox map.


## 2. Verified baseline and important differences

Current owner-read source is clean ba8e8a6915dbcfbb103879e645b3f1a861cc9085, branch overnight/solo-finish-loop-20261109, in the existing Windows Godot publication checkout. The source owner reports three ordinary completed solo courses, including one-fall recovery, and bounded climb, glide, dive, camera and pause checks. Those results supersede the old open solo-finish statement. They do not prove the proposed map, school performance, human feel or authoritative multiplayer.

The current collider is compact: 86 named concave parts, 5,336 triangles, total collider extent x -12.052..17.991, y -5.593..10.159, z -9.800..10.992 m. The current course can be walked without jumping. There is no checkpoint system. Falling respawns at the original spawn, preserves time and adds a fall; reset clears them. Preserve that accessible low-route principle and original baseline as a separate scene.

Current controller uses speed 7.2 m/s; capsule radius 0.35 m and height 1.8 m; snap 0.18 m; step aid 0.25 m; maximum floor angle 45 degrees. Jump starts at vertical speed 8.2 m/s. Held Space tends to +1.8 m/s indefinitely, glide to -2.4 m/s and dive to -18 m/s. Current updraft sets +14 m/s and has one hard-coded location. These stateful targets are not ballistic jump distances.

Current center ceiling y=18, failure bounds x -23..27, z -23..23, y<-7 and visual-peer rejection for position length>100 make the proposed map impossible without explicit profile changes. No amount of larger tree/terrain meshes solves those rules. The new checkpoint, map profile, broader bounds, multiple updrafts and route progress are proposed engineering, not already working features.

Runtime remains Godot 4.8-beta2 cafc17a19, Compatibility/WebGL2, fixed 60 Hz physics, shadows off, Web threads off and PWA caching off. Godot 4.8 texture streaming is unavailable to this renderer. The current game has original fox, Angel wings and woodland GLBs; the more advanced fox/other-animal labs are separate, not silently integrated. The exact candidate recovery gate remains open; this documentation does not advance it.


## 3. Landform and navigation plan

Terrain ranges approximately 18-128 m; hero canopy tops may reach 155 m. Propose a world-profile ceiling around 180 m, fall plane below 0 m and horizontal envelope around +/-512 m, with actual safe bounds calculated from the final scene. These values are new map settings, not global controller edits. Keep all geometry close enough to the origin that double-precision builds are unnecessary for this proposal.

A river enters from the north-east ridge, drops through two small waterfalls in the eastern gorge, bends southwest through Brookbend and exits below the southern skyline. Sculpt high terrain at Windcrown and Canopy Ridge, a sheltered central basin at Heartwood, and low broad trails around Mosswood/Brookbend. Trails and rivers should curve to reveal landmarks every 60-100 m instead of exposing the entire world from every clearing.

Use Terrain3D for continuous ground, banks, hill shoulders and height blending. Heightfield terrain cannot supply multiple elevations at one x/z location, caves or overhangs. Build arches, walkable roots, bridges, terraces, ledges and cliffs that need overhangs as separate static meshes with simple collision. Avoid scaling the existing whole woodland GLB to kilometre size.

Each zone has one recognizable silhouette and at least two physical connections. Heartwood is the main interchange. The summit arch, Heartwood tree and waterfall form a navigation triangle, but no visible route information depends on color alone. Keep a broad ground recovery path beneath or around every high challenge. The full expedition uses the same world and assets, not a fourth separate map.


### Zone briefs

- **Z1 Sunlit Clearing**: center x/z (-330, 330), elevation 24-36 m, composition 220 x 190 m. Spawn, route choice, practice and shared finish. Preserve the existing woodland as a compact home-course exhibit, rather than stretching its mesh. Grounded start; small ramp, jump, climb and safe glide practice; finish plinth. Assets: A01, A10-A16, A29, A46-A49, A58-A65

- **Z2 Mosswood Hollow**: center x/z (-310, 85), elevation 28-50 m, composition 230 x 260 m. Wide forest-floor paths, readable roots and low stone shelves. Beginner route and primary reference match. Three short jump choices; root bridge; walkable recovery trail beneath. Assets: A10-A16, A20-A23, A29-A35, A39-A41

- **Z3 Brookbend**: center x/z (-45, 270), elevation 18-40 m, composition 300 x 200 m. Shallow river, stepping stones, broad banks and a low bridge. Connect river return to the hub. Bank-to-bank crossing; optional stepping stones; low water recovery. Assets: A05-A07, A13, A17-A19, A27, A36-A45

- **Z4 Rootbound Ruins**: center x/z (-170, -135), elevation 48-80 m, composition 250 x 250 m. Root-wrapped pale arches, terraces and a ruined stair court. Vertical progression without a full castle. Step and landing rhythm; two traversable arch openings; switchback fallback. Assets: A03, A11-A16, A20-A26, A29-A35, A42

- **Z5 Heartwood Crossing**: center x/z (80, 10), elevation 34-64 m, composition 250 x 240 m. Central giant tree landmark and route interchange. See three destinations without dense canopy hiding them. Broad tree-root ring; grounded route anchor; two local return links. Assets: A12, A14-A16, A20-A21, A28-A35, A46-A49

- **Z6 Canopy Ridge**: center x/z (260, -255), elevation 72-110 m, composition 300 x 250 m. High stone-and-root ridge with tree crowns beside the route, not a thin branch maze. Two shelf ascents; visible launch and landing pairs; canopy overlook. Assets: A03-A04, A10-A16, A20-A23, A28-A35, A47

- **Z7 River Cliffs**: center x/z (355, 100), elevation 22-96 m, composition 240 x 360 m. Eastern gorge with waterfall and wide long-glide landings. Highest speed and strongest recovery needs. Three staged glides; two bounded wind columns; lower riverbank return. Assets: A03-A07, A12-A19, A23, A27, A36-A38, A47-A50

- **Z8 Windcrown**: center x/z (5, -365), elevation 104-128 m, composition 280 x 180 m. Northern summit, single hero arch and long woodland vista. End of the high circuit, not a separate biome. Summit approach; broad rest terrace; controlled descent toward canopy. Assets: A03-A04, A12-A16, A24-A26, A30-A35, A47-A49


## 4. Route and checkpoint contract

Use four route-data resources on the shared map. The three circuits are selectable and replayable; the full expedition follows a longer ordered chain. Route length estimates include bends and vertical approaches; verify them on the greybox before judging play time. At 7.2 m/s, 2.9-3.4 km alone is roughly 6.7-7.9 minutes of straight travel, so the 14-22 minute first-run estimate includes stops, ascent and learning. It is not measured completion time. Diagram-center straight chains are about 1,378 / 1,176 / 1,411 / 2,684 m for R1-R4; the revised estimates allow bends. Final anchor locations and measured playable splines, not center chords, determine accepted distances.

Author 24 distinct checkpoint anchors and let each route reference a subset; the expedition uses 16 of them. An anchor stores stable ID, entry volume, allowed feet-height band, optional grounded condition, facing and safe respawn pose. The route resource stores ordered references to those anchors, with a distinct stage ID per visit; order does not belong to a shared physical anchor. The 24 physical locations include Sunlit and Heartwood start/finish areas. A loop can visit one location at start and finish as different stages without counting it twice as a new physical anchor. Grounded anchors appear at major landings/interchanges, so indefinite climb cannot skip all progress. Optional midair gates may be added only where a deliberate glide is the named skill.

Recovery returns to the last confirmed safe anchor, preserving elapsed time and adding one fall. A new run/reset clears route progress and time/falls. A finish requires every required anchor in order plus a grounded finish volume. Test duplicate/re-entered anchors, skipped anchors, wrong-height crossings, falling during activation, last-anchor unload, Run again, pause and lost focus. Never respawn into a loop, into water or above unloaded collision.

Free exploration can cross routes or fly above them without awarding course completion. Preserve current held-climb behavior for the initial map. If unrestricted climb makes the challenge too weak, review a separately named optional limited-flight mode with the project owner after playtesting; do not introduce hidden stamina or silently shorten the existing controls.

Stage challenge glides as short launch/landing modules before joining them into a panorama. Initial test distances might be 8-15 m, 20-35 m and 40-60 m with explicit vertical differences, but these are fixture ranges, not approved reachable gaps. Measure climb, glide steering, release timing, dive interruption and landing dispersion with ordinary input, then choose real spans from successful trials with margin.

- **R1 Forest Floor**: Z1 > Z2 > Z3 > Z5 > Z1; ~1,400-1,700 m; 7 anchors; 2 optional gaps; 1 optional wind lift; 7-11 min first pass; walkable primary route.

- **R2 Canopy Ridge**: Z5 > Z4 > Z8 > Z6 > Z5; ~1,300-1,600 m; 9 anchors; 6 leap/glide beats; 2 lifts; 7-11 min first pass; ascent and broad landings.

- **R3 River Cliffs**: Z5 > Z6 > Z7 > Z3 > Z5; ~1,500-1,800 m; 8 anchors; 3 signature glides; 3 lifts; 8-12 min first pass; high and low return routes.

- **R4 Great Woodland Expedition**: Z1 > Z2 > Z4 > Z8 > Z6 > Z7 > Z3 > Z5 > Z1; ~2,900-3,400 m; 16 ordered anchors chosen from the same 24; no new geometry; 14-22 min first exploration; practice time excluded.


## 5. Metric kit, camera and readability

Begin with a 160 x 160 m pilot around Sunlit Clearing and one part of Mosswood/Brookbend. Include one low trail, two jump choices, one arch, root bridge, cliff/landing pair, a recovery shelf and an updraft. This is the integration specimen for terrain, material, collision, trees, water, camera, flight and reset, not a second unrelated map.

Start main ground trails at 4-6 m wide, with wider 8-12 m rest/turn/landing areas. Ordinary ground routes should normally remain at or below 15 degrees, though current controller accepts 45 degrees. Use 0.10/0.15/0.20 m stair risers and a smooth collision ramp where useful, below the 0.25 m step aid. These dimensions are initial authoring targets and must pass actual input, not a guarantee derived from a capsule.

Landing candidates start at 3, 5, 8 and 12 m widths. Final usable width is the greater of capsule landing dispersion, actual wing sweep plus margin, and camera visibility needs. Keep 0.5-1 m of pale readable landing lip free from moss, flowers and loose geometry. Separate visual roughness from a continuous collision top. Avoid mandatory thin beams or surprise changes in slope.

The current camera uses a 5 m spring arm, 0.18 m margin and sphere radius, 72 degree FOV, near 0.08 m and pivot +0.55 m above capsule center. An 0.7 m capsule opening is not a safe passage specification. Test actual fox/wings, full chase arm, compressed camera, first-person, wide/portrait windows, ascent, dive and landing. Author opening width from the measured wing and camera fixture rather than a guessed socket span.

Clutter exclusion masks cover the collision-safe route, landing lips, launch sightlines and anchor volumes. Do not hide the next required landing behind foliage. Use matching route names, simple symbols and text: leaf/ground for Forest Floor, stepped arch for Canopy, wing/river for River Cliffs, ring for expedition and a return arrow for recovery. Provide static alternatives to moving wind/leaf cues and visual counterparts to audio.


## 6. Godot tools and reuse decisions

Preferred authoring: Terrain3D 1.1.0 for sculpting/painting the 16 regions of 256 x 256 m at 1 m vertex spacing; Godot scene resources for sectors, route anchors and updraft volumes; Path3D/Curve3D for editable trail/river guides; Blender or existing source tools for exact-fit roots, arches, cliffs and collision proxies. Use explicit GLB exports with editable authoring sources. GridMap is optional for repeated static ruins, not a container for scripted objectives.

Terrain3D 1.1.0 release assets and local terrain.gdextension include no-thread and threaded Web WASM libraries, and the release supports Godot 4.5-4.8. Official platform documentation nonetheless labels Web exports very experimental. Match engine, extension build, dynamic-link export template, extension support and thread settings in the isolated pilot. Do not assume a native import or Compatibility checkbox proves browser readiness.

The local 256 m Terrain3D trial verifies API/height data and detects two vertical GodotPhysics ray misses at exact sample positions; a headless Jolt comparison passes those samples. This is a diagnostic observation, not authority to change the game physics backend or proof of controller contact. Test the current backend with the actual capsule; consider a separate backend comparison only if a reproduced game defect warrants it.

Runtime choice is conditional: use Terrain3D in the game if the exact native + no-thread Web pilot passes visual, collision, load and device tests. Otherwise retain Terrain3D as the authoring tool and bake a conventional low-poly MeshInstance3D terrain with independently validated collision. The inspected API exposes bake_mesh, but materials/UV transfer, chunk splitting and the final Web pipeline remain untested. Bake is a bounded conversion task, not an already working fallback.

Reuse the actual Cosmo woodland ancient/split/sapling set first. Inspected self-contained GLBs have LOD0 triangle counts 1,038 / 1,348 / 614; final LOD1/2 counts are 518/418, 536/536 and 306/252. Each visible tree LOD has two opaque material surfaces. The split variant gains nothing from its last geometry level, so keep its simpler two-step policy if profiling confirms. Current 24/60 m transitions and 160 m cull are trial settings, not map acceptance.

Cosmo generation is seeded and repeatable with MIT notices retained; its trial uses generated solid-color foliage, not bundled bark/leaf textures. It was headless-tested under Godot 4.6.3, not this game Web export. For runtime use, adapt exported LOD meshes into Terrain3D instancer scene naming or an equivalent small-area MultiMesh layer; do not run the full generator during gameplay.

Use Kenney Nature Kit or Quaternius Ultimate Stylized Nature for selected generic shrubs, stones, deadwood and foliage after actual-file and licence inspection. Official pages state CC0; they are candidates, not yet obtained/import-tested here. Palette-match only needed items. Build the project-specific launch/landing/recovery/seam family custom because it must fit this controller, camera and wings. Reuse the better owned fox rather than a new crude model.

Optional tools are deliberately secondary. Terrain3D already provides foliage placement, so do not add a second scatter system first. ProtonScatter may later help dressing on mesh cliffs, but bundled demo textures have separate rights and must be excluded unless cleared. Road Generator is a candidate for trail authoring/baking, not a reason to add highway junction logic or an untested runtime dependency. Simple curves and hand-authored connectors remain the baseline.


## 7. Population, loading and performance plan

Distinguish three grids: 16 Terrain3D regions at 256 m, 64 human-authored prop/gameplay sectors at 128 m, and Terrain3D instancer batches at 32 m. Zones cross those grids. Sector boundaries are authoring/load boundaries, not visible walls. Keep route IDs, safe anchor state and landmark silhouettes independent of prop residency.

Terrain3D 1.1 documentation describes region streaming as future work for 1.2. All allocated region maps can still occupy RAM/VRAM. max_regions reduces uniform-buffer use, not texture memory. Do not promise automatic streaming or beta texture streaming in Compatibility. Start with all modest terrain data resident; segment the world into separate runtime levels only if the measured full terrain exceeds budget.

Detail residency is a proposed custom scene policy: retain current sector plus neighboring sectors needed by reachable paths, prefetch before a fast glide/respawn and keep destination collision until the player safely leaves. Hiding/culling a sector is different from unloading its mesh/texture resources. Initially keep all route-critical collision resident and use visibility cuts for dressing; unload only after preload and lifecycle tests prove it useful. No-thread Web can still hitch during synchronous instantiation and GPU upload, so stage small batches and measure each transition rather than assume background import. Distant terrain/ridge silhouettes remain visible while dense grass, debris and fine roots disappear. Do not despawn terrain below a player or assume distant peer collision exists merely because the camera generates dynamic terrain collision.

Use one foliage batching owner: Terrain3D instancer if the runtime plugin is selected, otherwise cell-sized Godot MultiMeshes. Both render whole batches rather than independently culling every instance, so never put all map trees in one MultiMesh. Use source LOD meshes and shared materials. Major colliding trunks/roots remain separate simple proxies; decorative trees, foliage, pebbles and distant silhouettes have no physics bodies.

Use hard visibility cutoffs with hysteresis as the Compatibility baseline; do not assume Forward+-only stock visibility crossfades. Test pop-in from both sides of each threshold. Use cliffs and large opaque rock masses for any occluder proxies, not leaf canopy; MultiMesh is not included in built-in occluder baking. Add occlusion only if a matched scene shows a net gain.

Initial whole-map populations are about 1,500 trees, 600 shrubs, 600 sapling/scrub clumps, 3,000 near-only grass clumps and the register quantities. These are layout caps, not counts to fill uniformly. Begin the pilot at one-quarter dressing density and add only what helps composition. Every distant glide must retain a clear destination and skyline, not a dense wall of foliage.

Provisional low-preset budget at 1280 x 720 on a named target school laptop: steady route at least 30 fps, p95 frame time <=33 ms and p99 <=50 ms after warm-up; no repeated >100 ms hitch at cell transitions. Candidate content limits: <=250 visible draw calls, <=350k visible triangles, <=64 MiB map texture memory and <=25 MiB compressed added map content, excluding the engine. These are proposed starting limits, not measured or user-accepted claims; use actual device evidence to keep or revise them.

Keep current shadows off for the first acceptance pass. Prefer opaque palette materials, few surfaces and 512 px textures only where useful; generate mipmaps and verify actual target compression. No volumetric fog, screen-space reflections, realtime GI, full water simulation or dense transparent grass is needed. Add optional shadows/effects only after matched before/after profiling. Browser startup/network loading is separate from GPU frame rate.

Measure the same camera path at the hub, dense hollow, ruins, summit panorama, three fast glides and river/waterfall, then five reset/retry cycles. Record p50/p95/p99 frame time, draw calls, triangles, object/material counts, terrain/texture allocations, browser memory where measurable, peak download/start time and console errors. Object counts must return to baseline and memory must stop rising. Headless tree population milliseconds are not FPS evidence.


## 8. Asset production and admission

The asset register is comprehensive by family rather than listing every placed pebble. It contains 72 stable-ID work items, separating editable source, runtime geometry/material, collision, route/gameplay data, animals, UI, audio, effects, build/test and recovery deliverables. Variant and placement counts are initial estimates; an existing item is not automatically approved for map integration.

For every asset retain author/source URL, exact licence text, date/version/hash, allowed modification/redistribution, original file, editable source, runtime export, units/axes/origin/pivots, bounds, triangle/material/texture counts, LOD, collision tags and any rig/clip/socket data. Code and bundled media can have different licences. Public availability, a screenshot or a free button is not sufficient reuse clearance.

Exact-fit route modules need independent visual and collision meshes, clear landing/launch markers and a scale/pivot manifest. Tree leaves and vines do not gain collision from appearing solid. All forms need a normal and low-preset gameplay-distance comparison, not only beauty renders. No purchases, paid APIs or outside model-service uploads are part of the plan.

Use one integration writer for the source checkout. Asset work stays in isolated, uniquely named candidate folders with immutable manifests and a known parent checkpoint. Do not edit the current woodland/fox/wings originals or erase dirty work. The asset register should advance through: proposed, source inspected, authored, imported, visually reviewed, ordinary-input tested, device profiled, restored and accepted. Passing a lab only advances the applicable state.


## 9. Phased implementation and validation

P0 - Preserve and pin. Resolve the pending exact private checkpoint/restore gate for ba8e8a6. Re-read existing route/locomotion plan, current README and later owner evidence. Capture branch, clean/dirty overlay, editor/templates, current physics, renderer and active writer. Planning continues now; code and map features do not cross the recovery gate.

P1 - Metric and renderer pilot. Build only the 160 m representative slice in an isolated development map. Prove map-profile bounds, camera/wing envelope, movement fixture, one updraft, broad landing/recovery, one terrain region edge, three Cosmo trees and water. Export exact no-thread Web plugin candidate and mesh fallback specimen. Choose one runtime path after ordinary input, rendering and target-device measurements. Do not populate the whole world before this decision.

P2 - Whole-world greybox. Author all eight landforms, river course, route graphs, 24 anchors and recovery links using simple collision. Implement local route/checkpoint/reset contracts and profile-driven limits, not visuals first. Walk every ground connection and complete each circuit/expedition with ordinary controls. Measure actual route lengths and first/competent runs; shorten empty travel or add meaningful beats rather than scale the whole world.

P3 - Cohesive production kit. Make the custom launch/landing/root/recovery family, palette and hero landmark, then adopt only the cleared stock foliage/debris. Finish one zone to reference quality before producing the rest. Independently check pale edges, readable silhouettes, motion/contact, camera, collisions and low preset. Keep the current fox until a replacement passes all its separate gates.

P4 - Populate and tune. Dress one sector at a time with exclusion masks and deterministic placement. Expand to all zones only while the agreed visible-set/download/memory budgets hold. Add restrained audio/cues and settings. Validate cell boundaries at maximum flight speed, forced recovery, pause, repeated reset and hidden/visible menus. Capture native and actual Web results separately.

P5 - Multiplayer admission, if this map is selected for multiplayer. Design a matching authoritative collision/map-profile/checkpoint contract before sharing the larger positions. Preserve server authority, idle/sequence/epoch fencing and privacy. The current >100 peer filter must become validated map-scoped bounds, not be deleted blindly. Test far-apart peers, map/version mismatch, grounded anchors, correction, fall recovery, disconnect/rejoin and capacity; visual relay success does not prove gameplay authority.

P6 - Acceptance and recovery. Independent source/behavior review and visual reference review; exact Web build ordinary controls, all routes, recovery/reset, settings and target school device/network checks; applicable regression tests; private exact-object source backup, download and executable restore. Keep current compact course and Three.js reference available for rollback. Deployment/hosting/cost approval is a separate step.


## 10. Decisions, risks and next bounded action

Recommended decisions: one connected woodland; 1,024 m square as a planning envelope; eight zones; three circuits plus one expedition; Terrain3D authoring with conditional runtime and baked fallback; reusable generic dressing; custom metric traversal pieces; current flight behavior preserved; broad ground/recovery connections; fox first. These are recommendations for the project owner to review, not silently approved implementation or final dimensions.

Highest-risk unknowns: exact Terrain3D no-thread Web/device compatibility; capsule/terrain contact across seams; current unlimited-climb effect on challenge; full-map scene/texture cost; authority/collision parity at larger scale; wing/camera clearance; checkpoint implementation and recovery correctness. Each has a named pilot or acceptance gate above, rather than an unsupported assurance.

The 1 km choice is deliberately reversible until P2. If greybox testing shows long empty travel or low-end devices cannot maintain the budget, keep all eight designed zones but compress footprints into a 768 m square or load circuits separately through the same hub. Do not use giant fog walls or remove recovery routes merely to preserve a nominal size.

Next authorized work now is planning only: review this map and register, reconcile the dated extension with the existing project route plan and keep the current source frozen. The first later build task, after the source recovery gate, is the representative 160 m pilot, not a million-square-metre art pass. No extra purchase or plugin installation is needed to review the plan.


## Complete asset register


### Terrain

- **A01 Editable terrain source** (16 variants): 16 x 256 m regions, 1,024 m square. Origin: New Terrain3D authoring. Status: PROPOSED / NOT PRODUCED. Deliver: Versioned region maps + sculpt/mask source. Gate: Native + Web pilot, region seams, no unsupported streaming claim.

- **A02 Baked terrain fallback** (16 variants): 16 region meshes, subdivided only as profiling requires. Origin: New derivation from A01. Status: PROPOSED / NOT PRODUCED. Deliver: Mesh resources/GLB, import settings, simplified colliders. Gate: Same height samples, seams, palette and routes as Terrain3D.

- **A03 Cliff/outcrop modules** (8 variants): 80-120 placed modules. Origin: Adapt CC0 rock donors; custom silhouette gaps. Status: PROPOSED / NOT PRODUCED. Deliver: Editable source + GLB + separate collision. Gate: No snagging ledges; no overhang inferred from heightmap.

- **A04 Distant ridge silhouettes** (4 variants): 8-12 non-traversable backdrops. Origin: New simple meshes or adapt cleared donors. Status: PROPOSED / NOT PRODUCED. Deliver: Low-detail opaque meshes. Gate: Beyond boundary, no collision/route promise, consistent skyline.

- **A05 River channel and banks** (6 variants): ~1.0-1.2 km visual watercourse, broken into 6 reaches. Origin: New terrain shaping + bank adapters. Status: PROPOSED / NOT PRODUCED. Deliver: Curves, bank meshes and river sections. Gate: Walkable banks, no water/terrain gaps, no fluid simulation claim.

- **A06 River surface** (3 variants): 6-10 sections. Origin: New simple opaque water mesh/material. Status: PROPOSED / NOT PRODUCED. Deliver: Material + three flow-rate variants. Gate: Compatibility WebGL2; no refraction, SSR or expensive simulation.

- **A07 Waterfall and foam receiver** (3 variants): 2 falls, 4 foam patches. Origin: New simple meshes; licensed texture only if needed. Status: PROPOSED / NOT PRODUCED. Deliver: Ribbon mesh, opaque/light alpha material, low preset. Gate: Read at distance, no flicker, low-motion mode.

- **A08 Terrain height/control/color data** (3 variants): One set per region. Origin: New authored map data. Status: PROPOSED / NOT PRODUCED. Deliver: Source maps, checksums and import recipe. Gate: No precision loss at landings; save/load equality.

- **A09 Boundary and recovery envelope** (1 variants): 1 map-wide definition. Origin: New map-profile data. Status: PROPOSED / NOT PRODUCED. Deliver: Versioned bounds, safe volumes, fall plane. Gate: Every accessible edge and high point inside profile.


### Traversal

- **A10 Trail and ramp adapters** (6 variants): 45-60 links. Origin: Custom fit; optional Road Generator bake after spike. Status: PROPOSED / NOT PRODUCED. Deliver: Visual GLB + clean ramp collision. Gate: Ground path normally <=15 deg; joins below step threshold.

- **A11 Short step/stair family** (4 variants): 18-26 runs. Origin: Custom metric module. Status: PROPOSED / NOT PRODUCED. Deliver: 0.10/0.15/0.20 m visual risers; smooth/ramp proxy. Gate: No riser > current 0.25 m step aid; ordinary input in both directions.

- **A12 Launch ledge family** (3 variants): 18 launches. Origin: Custom fit to controller/camera. Status: PROPOSED / NOT PRODUCED. Deliver: Broad slab/root forms + named launch marker. Gate: Takeoff view and ground anchor visible; no blind lip.

- **A13 Landing slab family** (4 variants): 28 primary landings. Origin: Custom fit to controller/wing envelope. Status: PROPOSED / NOT PRODUCED. Deliver: 3/5/8/12 m planning widths, separate flat collision. Gate: Use measured landing dispersion and wing span, not nominal width alone.

- **A14 Lower recovery shelves** (3 variants): 24 shelves. Origin: Custom fit. Status: PROPOSED / NOT PRODUCED. Deliver: Broad connected meshes and return route markers. Gate: Ordinary fall -> safe shelf or prompt respawn; no soft lock.

- **A15 Root/stone seam adapters** (6 variants): 50-70 joins. Origin: Custom fit around reusable kit. Status: PROPOSED / NOT PRODUCED. Deliver: Visual seam caps + collision seam checks. Gate: No small ledges, camera traps or hidden gaps.

- **A16 Bridge deck/rail modules** (4 variants): 6-8 bridges. Origin: Adapt existing root-bridge cue; custom exact spans. Status: PROPOSED / NOT PRODUCED. Deliver: Root and pale-stone decks; railing optional. Gate: 4 m main-deck starting width; tested camera and capsule clearance.

- **A17 Stepping stone family** (4 variants): 16-22 stones. Origin: Adapt stock forms with custom flat tops. Status: PROPOSED / NOT PRODUCED. Deliver: GLBs with independent colliders. Gate: Optional route; miss drops onto recovery bank.

- **A18 Grounded causeway alternative** (2 variants): 2 crossings. Origin: Custom ground route. Status: PROPOSED / NOT PRODUCED. Deliver: Simple mesh + collider. Gate: Accessible alternate to water and glide gaps.

- **A19 Switchback and bank connectors** (3 variants): 8-12 connectors. Origin: Custom fit. Status: PROPOSED / NOT PRODUCED. Deliver: Ramp/shelf mesh + path metadata. Gate: Grounded route remains continuous throughout map.


### Structures

- **A20 Large root arch family** (3 variants): 9 arches. Origin: Adapt existing look; custom metric openings. Status: PROPOSED / NOT PRODUCED. Deliver: GLB + simple collision. Gate: Opening >= measured wing/camera envelope + margin.

- **A21 Hero Heartwood tree** (1 variants): 1 landmark. Origin: Custom trunk/roots using Cosmo canopy or authored mesh. Status: PROPOSED / NOT PRODUCED. Deliver: Editable source; roots and platforms separate. Gate: Hero roots are collision, foliage is not; distinct from scatter trees.

- **A22 Fallen logs and hollow forms** (4 variants): 12-18 forms. Origin: Adapt CC0 donors or existing study. Status: PROPOSED / NOT PRODUCED. Deliver: GLBs; only tagged traversal logs collide. Gate: No mandatory cramped tunnels; chase camera remains usable.

- **A23 Retaining walls/terraces** (4 variants): 25-35 segments. Origin: Custom coherent pale stone kit. Status: PROPOSED / NOT PRODUCED. Deliver: GLB + collision proxies. Gate: Matches landing palette and slope support, no hidden collision.

- **A24 Ruined arch family** (3 variants): 10 arches. Origin: Adapt CC0 if exact suitable files pass; else custom. Status: PROPOSED / NOT PRODUCED. Deliver: Whole, broken and summit arch GLBs. Gate: Wide readable openings; no extra castle/temple scope.

- **A25 Pillars and capstones** (4 variants): 24-32 pieces. Origin: Adapt cleared kit, palette-match. Status: PROPOSED / NOT PRODUCED. Deliver: Shared-material meshes. Gate: Occlusion and camera checks, no accidental route blockers.

- **A26 Ruined floor/stair court** (4 variants): 12-18 patches. Origin: Custom/adapt modular kit. Status: PROPOSED / NOT PRODUCED. Deliver: Ground court tiles + trim. Gate: Collision edges align, grounded alternative through ruins.

- **A27 Low brook bridge/abutments** (3 variants): 2 bridges + bank ends. Origin: Custom fit; no dam-kit transplant. Status: PROPOSED / NOT PRODUCED. Deliver: Deck/abutment GLBs + proxy. Gate: Natural river crossing, clearance and bank alignment.


### Vegetation

- **A28 Woodland Cosmo tree set** (3 variants): ~1,200 trees across whole world. Origin: Existing Cosmo ancient/split/sapling, f0f06e4. Status: EXISTS / ADOPTION GATE OPEN. Deliver: Original seeds + three LOD meshes + MIT notices. Gate: Exact 4.8-beta2 Web render, batch adapter and silhouette review.

- **A29 Additional grove silhouettes** (3 variants): ~300 trees, optional after main set. Origin: Adapt CC0 only if existing three look repetitive. Status: PROPOSED / NOT PRODUCED. Deliver: Three approved tree variants with LOD. Gate: One palette/scale; no new pack imported wholesale.

- **A30 Sapling/scrub clumps** (4 variants): ~600 placements. Origin: Existing inputs: Cosmo sapling; new clump adaptations proposed, CC0 donors not inspected. Status: EXISTING INPUTS / ADAPTATION OR FIXTURE PROPOSED. Deliver: Instanced low-detail meshes. Gate: No corridor occlusion; no collision on dressing.

- **A31 Shrub family** (4 variants): ~600 placements. Origin: Kenney or Quaternius candidate. Status: PROPOSED / NOT PRODUCED. Deliver: Opaque mesh clumps + optional LOD. Gate: Rights/file/import review and batching.

- **A32 Grass clumps** (4 variants): ~3,000 clumps total; near-only. Origin: Kenney/Quaternius or custom tiny meshes. Status: PROPOSED / NOT PRODUCED. Deliver: Small opaque clump meshes. Gate: No individual blades, no alpha-heavy field, no landing-edge cover.

- **A33 Ferns and broadleaf clumps** (3 variants): ~350 placements. Origin: Cleared CC0 candidate. Status: PROPOSED / NOT PRODUCED. Deliver: Mesh clumps, no physics. Gate: Consistent scale; near-only density budget.

- **A34 Flowers/mushrooms** (6 variants): ~300 small grouped placements. Origin: Cleared CC0 or simple original. Status: PROPOSED / NOT PRODUCED. Deliver: Shared-palette groups. Gate: Optional dressing only; no collection mechanic implied.

- **A35 Moss/root trim and hanging vines** (5 variants): ~200 strips/groups. Origin: Custom mesh trim, texture-free first. Status: PROPOSED / NOT PRODUCED. Deliver: Mesh trim + non-colliding vines. Gate: Pale landing lip stays uncovered; no misleading grab surface.


### Dressing

- **A36 Boulder/rock family** (8 variants): ~450 placements. Origin: Kenney Nature/Quaternius candidate. Status: PROPOSED / NOT PRODUCED. Deliver: Palette-matched GLBs with LOD. Gate: Colliders only for route/support rocks, not every pebble.

- **A37 Small stone/pebble clusters** (4 variants): ~250 placements. Origin: Cleared CC0 candidate. Status: PROPOSED / NOT PRODUCED. Deliver: Combined cluster meshes. Gate: Batched, no tiny colliders or route clutter.

- **A38 River reeds/bank foliage** (3 variants): ~200 clumps. Origin: Cleared CC0 candidate. Status: PROPOSED / NOT PRODUCED. Deliver: Opaque low-cost meshes. Gate: No water/landing occlusion; culled before distant glides.

- **A39 Stumps, deadwood and root accents** (4 variants): ~100 placements. Origin: Cleared CC0 or reuse existing study. Status: PROPOSED / NOT PRODUCED. Deliver: Combined shared-material meshes. Gate: No obstruction of collision-safe corridor.

- **A40 Leaf-litter groups** (3 variants): ~150 placements. Origin: New flat low-poly groups or CC0. Status: PROPOSED / NOT PRODUCED. Deliver: Texture-free groups first. Gate: No z-fighting; optional low preset removal.

- **A41 Ground detail patches** (3 variants): ~100 patches. Origin: New palette/geometric variation. Status: PROPOSED / NOT PRODUCED. Deliver: Opaque patch meshes. Gate: No renderer-specific decals required.

- **A42 Ruins debris clusters** (4 variants): ~60 clusters. Origin: Adapt same A24-A26 kit. Status: PROPOSED / NOT PRODUCED. Deliver: Combined groups. Gate: No duplicate colliders, no confusing false landings.


### Materials

- **A43 Terrain palette/material set** (6 variants): Grass, soil, pale stone, rock, riverbed, moss. Origin: New solid palette; CC0 texture optional. Status: PROPOSED / NOT PRODUCED. Deliver: Material library + swatches. Gate: 512 px default if textured; mipmaps and actual import verified.

- **A44 Bark/leaf shared materials** (2 variants): 2 main surfaces/tree. Origin: Existing Cosmo solid colors; match woodland. Status: EXISTS / ADOPTION GATE OPEN. Deliver: Shared resources; no per-instance copies. Gate: Opaque, no source textures silently added.

- **A45 Water/foam material set** (2 variants): 2 shared resources. Origin: New simple material. Status: PROPOSED / NOT PRODUCED. Deliver: Compatibility variant + low-motion variant. Gate: Bounded transparency, no unsupported screen effects.


### Gameplay

- **A46 Spawn/finish plinth and markers** (2 variants): 3 route starts + 1 shared expedition start/finish. Origin: Adapt existing finish cue; new metric forms. Status: PROPOSED / NOT PRODUCED. Deliver: Scene markers + shapes/text. Gate: Grounded finish, clear feedback; preserve reset/falls semantics.

- **A47 Checkpoint anchor scenes** (3 variants): 24 distinct anchors, routes reference subsets. Origin: New system, not in current candidate. Status: PROPOSED / NOT PRODUCED. Deliver: ID, volume, grounded rule, respawn pose, map revision. Gate: Order, duplicates, wrong-height, respawn and reset tests.

- **A48 Route signs/arrows** (5 variants): ~55 signs and floor markers. Origin: New shape/text-based kit. Status: PROPOSED / NOT PRODUCED. Deliver: Floor/Canopy/River/Expedition/Recovery symbols. Gate: No color-only route identity; legible from actual camera.

- **A49 Practice interaction and control cues** (4 variants): 4 practice stations. Origin: New lightweight scenes. Status: PROPOSED / NOT PRODUCED. Deliver: Static geometry + clear instruction states. Gate: Keyboard readable; optional hints, not modal interruption.

- **A50 Bounded updraft volumes and cues** (2 variants): 6 updrafts; 2 optional challenge variants. Origin: New data-driven version of existing concept. Status: PROPOSED / NOT PRODUCED. Deliver: Area3D/data, start/end heights, vector, cue mesh/audio. Gate: Dive cancels lift; exits, ceiling and network parity; not cosmetic lift.

- **A51 Recovery/fall volumes** (2 variants): Per-sector safe bounds + fallback. Origin: New map-profile system. Status: PROPOSED / NOT PRODUCED. Deliver: Fall plane, exclusion volumes and safe pose validation. Gate: No full-map origin respawn after every miss; no respawn loop.

- **A52 Route/map data resources** (4 variants): Floor, Canopy, River, full expedition. Origin: New authored route data. Status: PROPOSED / NOT PRODUCED. Deliver: Stable IDs, ordered anchors, rules and revision hash. Gate: Ground bypass cannot finish skipped route; free roam still allowed.


### Avatar

- **A53 Current fox/Angel/woodland originals** (3 variants): Preserve exact original files. Origin: Existing game ba8e8a6. Status: EXISTS / ADOPTION GATE OPEN. Deliver: Read-only originals with provenance/hashes. Gate: No automatic replacement; reference and rollback.

- **A54 Fox locomotion integration candidate** (1 variants): 1 chosen fox, independent player clones. Origin: Existing lab/baseline inputs; selection and new game integration/manifest proposed. Status: EXISTING INPUTS / ADAPTATION OR FIXTURE PROPOSED. Deliver: Editable rig, GLB, socket/axis/scale/clip manifest. Gate: No sliding, loop pop, wing clipping or shared-skeleton state.

- **A55 Fox action clips** (7 variants): Idle, walk, run, launch/climb, glide, dive, land. Origin: Adapt owned clips; custom missing transitions. Status: PROPOSED / NOT PRODUCED. Deliver: AnimationTree/Player plus versioned clips. Gate: Current states drive visuals; animation cannot move authority collider.

- **A56 Wing/socket and clearance fixture** (1 variants): 1 tested active wing plus envelope data. Origin: Existing Angel input; new socket/clearance fixture proposed, no new wing selection. Status: EXISTING INPUTS / ADAPTATION OR FIXTURE PROPOSED. Deliver: Socket transform, clearance volume, test scene. Gate: All camera/pose/landing transitions with actual wing span.

- **A57 Other owned animal readiness** (4 variants): Rabbit, raccoon, squirrel, deer optional later. Origin: Existing 14-GLB roster inventory, mixed rigs. Status: EXISTS / ADOPTION GATE OPEN. Deliver: Per-species readiness/license/clip register. Gate: Not required for first map; no fox gait blindly retargeted; rights separately cleared.


### UI

- **A58 Route selection and progress** (4 variants): 3 circuits + expedition. Origin: New UI using existing menu style. Status: PROPOSED / NOT PRODUCED. Deliver: Route name, difficulty, progress, reset state. Gate: No invented multiplayer/leaderboard status; small screen tested.

- **A59 Checkpoint/recovery/finish feedback** (5 variants): 5 states. Origin: Adapt existing results; add honest route states. Status: PROPOSED / NOT PRODUCED. Deliver: Start, checkpoint, missed-order, fall/recover, finish. Gate: Time/falls preserved on recovery; Run again clears consistently.

- **A60 Map/orientation and landmark legend** (1 variants): 1 lightweight static map/overlay. Origin: New original map. Status: PROPOSED / NOT PRODUCED. Deliver: Simple labelled map + route symbols. Gate: Keyboard dismissal, no compulsory minimap or GPS scope.

- **A61 Settings and reduced-motion cues** (1 variants): 1 settings extension. Origin: Adapt current menu. Status: PROPOSED / NOT PRODUCED. Deliver: Density preset, camera sensitivity, cue motion/audio toggles. Gate: Preserve current controls; no color-only or motion-only information.


### Audio

- **A62 Forest/wind/river ambience** (3 variants): 3 loop families with zone blends. Origin: Reuse owned or specifically cleared CC0 recordings. Status: PROPOSED / NOT PRODUCED. Deliver: Seamless OGG + license/source record. Gate: Audition loops, no abrupt seam; mute works.

- **A63 Footstep/landing/wing cues** (4 variants): Stone, soil, leaf, wing/landing family. Origin: Reuse owned or cleared CC0. Status: PROPOSED / NOT PRODUCED. Deliver: Short mono positional cues. Gate: Mix under ambience; no sound required to navigate.

- **A64 Start/checkpoint/recovery/finish cues** (4 variants): 4 short UI events. Origin: New/owned or cleared CC0. Status: PROPOSED / NOT PRODUCED. Deliver: OGG + visual equivalent. Gate: No repeated retrigger spam; reset cleans playback.


### VFX

- **A65 Wind/leaf/checkpoint cues** (3 variants): Localised limited emitters only. Origin: New simple geometry/sprite cues. Status: PROPOSED / NOT PRODUCED. Deliver: Low-motion static alternative. Gate: Compatibility export + repeated pause/reset cleanup.


### Tools and validation

- **A66 Zone/foliage scene manifests** (1 variants): 64 x 128 m authoring sectors; 32 m instancer cells. Origin: New authored placement data. Status: PROPOSED / NOT PRODUCED. Deliver: Seed/version + spawn exclusion masks + bounds. Gate: Repeatable generation; no landing decoration drift.

- **A67 Collision and route fixtures** (1 variants): One metric test scene + per-zone seam cases. Origin: New tests reusing current controller. Status: PROPOSED / NOT PRODUCED. Deliver: Capsule/camera/wing fixture, route replay and sample checks. Gate: Both directions, max glide speed, cell boundary, recovery.

- **A68 Web/native build profiles** (2 variants): Terrain3D runtime candidate + mesh fallback. Origin: New configuration derived from current baseline. Status: PROPOSED / NOT PRODUCED. Deliver: Exact engine/templates/export settings + dependency manifest. Gate: No-thread/extension match, no missing WASM, no production host change.

- **A69 Performance fixture and evidence** (1 variants): 8 representative views + repeatable busiest route. Origin: New measurement harness. Status: PROPOSED / NOT PRODUCED. Deliver: Frame-time, draw/material/triangle/memory/startup records. Gate: Actual browser/device captures, not headless timings.

- **A70 Licence/source/import register** (1 variants): Every reused and authored asset. Origin: New register, retain existing provenance. Status: PROPOSED / NOT PRODUCED. Deliver: URLs, author, license text, hash, units, pivots, LOD, clips. Gate: Complete before import approval or sharing; no unclear-rights downloads.

- **A71 Map/network authority contract** (1 variants): Future multiplayer map revision. Origin: New design/test seam, not existing multiplayer acceptance. Status: PROPOSED / NOT PRODUCED. Deliver: Shared bounds, collision/map ID, checkpoint rules, peer tests. Gate: Do not fix by simply deleting position filter; validate server parity.

- **A72 Recovery and handoff package** (1 variants): Each accepted phase. Origin: New milestone packaging. Status: PROPOSED / NOT PRODUCED. Deliver: Source/assets/tests/licenses/manifests + independent restore evidence. Gate: Private provider gate respected; plan is not a source backup.


## Evidence and coverage

- **S1 Current source-owner read, 10 Nov 2026**: ba8e8a6915dbcfbb103879e645b3f1a861cc9085; controller, main, avatar, project.godot, collision.json, README and publication receipt. Owner supplied the exact metrics and latest ordinary-control outcomes. Planner did not rerun the game or access the desktop source.

- **S2 Existing project Page, read 10 Nov**: Private project Page (locator omitted from this public copy) ; sequence 18, last edited 9 Nov. Historical migration/assets/authority constraints read in full; superseded solo-finish status kept distinct.

- **S3 Six-project roadmap, read 10 Nov**: Private cross-project roadmap (locator omitted from this public copy) ; 9 Nov roadmap. Read Parkour tasks, ownership, map, tools and acceptance sections; not a current runtime test.

- **S4 Visual references, inspected 10 Nov**: Visual-target-review-135-concepts-20261105.pdf p3 rendered/visually read; environment-02-forest-floor primary, environment-04-material-kit supporting. Parkour-fox-motion-clearance-concept-20261109.png visually read. Concepts are not engine images or measured dimensions.

- **S5 Current woodland comparison**: Image worker visually inspected ordinary-finish-2.jpg from ba8e8a6: pale stone arch, very bright lime/olive low-poly foliage, cream surfaces, cyan sky. Planner received description, not local image pixels; this finish view does not establish whole-map extent.

- **S6 Local Cosmo source/actual assets**: cosmo-tree-trial-20261109/delivery/TRIAL_RECEIPT.md; THIRD_PARTY_NOTICES.md; upstream f0f06e40f05710f2de040cac751e03b86b721fe5; inspected local manifest/report and licences. Geometry/import/headless results are retained prior evidence, not rerun Web tests.

- **S7 Terrain3D 1.1 source/release evidence**: https://github.com/TokisanGames/Terrain3D/releases/tag/v1.1.0-stable ; local release.json, actual terrain.gdextension libraries, LICENSE.txt, reflected bake_mesh API and 256 m trial logs read. Release 30 Oct 2026; exact Web game integration untested.

- **S8 Terrain3D platform and export docs, read 10 Nov**: https://terrain3d.readthedocs.io/en/stable/docs/platforms.html ; https://github.com/TokisanGames/Terrain3D/issues/502 . Web very experimental; exact thread/template/export settings must match. Do not blindly apply historical threaded-server advice to current no-thread candidate.

- **S9 Terrain3D collision/performance/instancing, read 10 Nov**: https://terrain3d.readthedocs.io/en/1.1/docs/collision.html ; https://terrain3d.readthedocs.io/en/1.1/docs/performance.html ; https://terrain3d.readthedocs.io/en/1.1/docs/instancer.html . Streaming future 1.2; max_regions not VRAM reduction; instancing has no collision and uses 32 m cells.

- **S10 Godot MultiMesh documentation, read 10 Nov**: https://docs.godotengine.org/en/stable/tutorials/performance/using_multimesh.html . Whole-batch culling limits; divide batches spatially. Stable docs guide the experiment but do not certify beta2.

- **S11 Generic asset source pages, read 10 Nov**: https://kenney.nl/assets/nature-kit : 330 assets, CC0. https://quaternius.com/packs/ultimatestylizednature.html : 63 models, CC0, FBX/OBJ/Blend/glTF. Pages read; actual archives and this game import unverified.

- **S13 Existing route plan, full text supplied/read 10 Nov**: Project-owned planning record: ROUTE-AND-LOCOMOTION-PLAN-20261109.md ; 9,698 bytes, SHA256 60b3f770052be138287f5b5bc416bd40c38e04ad2c23ee538a8b55613e6ccddd. Owner supplied full verbatim text. This map extends its three-route, clearance, unlimited-climb and per-species constraints. Its old open ordinary-finish statements are superseded, not copied as current status.

- **S14 Godot visibility and occlusion docs, read 10 Nov**: https://docs.godotengine.org/en/stable/classes/class_geometryinstance3d.html ; https://docs.godotengine.org/en/stable/tutorials/3d/occlusion_culling.html . Compatibility stock fade limitation and MultiMesh occluder-baking boundary.

- **S12 Project-owned asset queue, read 10 Nov**: custom-asset-inventory-20261110/CUSTOM-ASSET-QUEUE.md . Existing reuse-first decision and custom launch/landing/recovery/seam family. Reconciled with fresh controller packet rather than treating older assumptions as current.


Plan authoring did not execute or change game source, install assets or deploy a build. This public documentation copy is a later repository publication of the plan. All fresh design dimensions are proposed, not accepted metrics.
