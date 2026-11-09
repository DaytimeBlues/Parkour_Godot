# Current status and source map

Updated 9 November 2026. A source publication is not a new game release or a deployment.

## Selected runnable source

This repository begins with a publication-safe snapshot of the woodland beta project, source commit `67a6c2491ce2c1c0a46a2d266ee2deadbfaaebeb`. The initial publication copied its runtime scripts, three GLBs, collision data and tests unchanged. The current solo finish-loop changes are described below. Documentation, asset provenance and ignore rules are adapted for a public checkout. Private historical logs and original local Git history remain preserved separately.

The original checkpoint passed 19 Python tests, strict Godot import/boot/smoke, Web export, exact source/Git recovery and repeated tests on restored source. Bounded Chrome checks observed Start, forward movement, held-Space climb, glide/landing, camera change, reset and menu toggling. A brief two-tab visual-peer test showed movement and explicit disconnect. These are historical bounded observations, not fresh acceptance of this repository checkout.

Still open: dive-specific input proof, full course completion, long-lived reconnect, animation quality, school-device performance and production backend integration. Earlier visual-relay close 1008 is undiagnosed. Do not conflate that relay issue with the separate HTTP experiments.

Fresh publication validation is recorded in [VALIDATION.md](VALIDATION.md).

## Preserved development lines

| Line | Source identity | Evidence boundary |
| --- | --- | --- |
| Stable fallback | `5f1251ad8c3f2e3b4d818df3085bd850e56e68b1` | Godot 4.7.2 source recovery and bounded Web proof; retained separately |
| Woodland beta | `67a6c2491ce2c1c0a46a2d266ee2deadbfaaebeb` | Runnable source selected for this repository |
| Fox animation lab | `d6c6685ce50df60a32d398b9f4491390abde843f` | Two actual 51-bone clips imported/rendered; not integrated or release-cleared here |
| Native HTTP lab | `94faa73586ba94b1d540912c79e6f09d4da0384a` | Native protocol/recovery checks; not browser gameplay |
| Web HTTP lab | `5c13b78ad09b284ac4ae8a55b1dc8719d73d8be1` | Recoverable Web transport proof; exact six-request gate not passed |
| Student-input candidate | `e0e3fdb290f7cd52f6765534b6b190f10d14ca20` | Provider bytes/Git verified; executable restore remains incomplete; browser lifecycle failed |
| HTTP completion diagnostic | `57da5f0e493cb2d01c88c3eb7ff5ba770447b4cd` | Synthetic request/frame evidence; not a confirmed fix |

The failed student-input episode retained 63 API calls, 42 reconnects, 20 empty syncs, one idle rejection and zero moving frames. Its restored suite passed 10/11 tests; an OS socket-ownership permission check blocked the remaining contract child. This repository does not claim to repair or supersede that gate.

Read-only timeline review found about one second between Godot dispatch and Fetch start, followed by headers in a few milliseconds. The failed request never read its body before timeout; the successful request completed as frame pacing improved. Content-Length is not a proven cause. A separate deterministic scheduling probe found a 249 ms/250 ms quantization discontinuity. Neither finding is an integrated repair.

## Solo finish-loop candidate, 9 November 2026

A grounded arrival at the existing arch now freezes time and movement, shows elapsed seconds and falls, and offers Run again. Restart clears completion and returns to the start menu; pause does not advance the timer. The unstarted HUD says READY instead of DIVING. No geometry, speed, flight, camera, asset or network-protocol changes are included.

The expanded source/physics smoke physically traverses the existing approach, stairs and bridge twice without teleports. It checks finish, frozen timer/input, pause, repeat and restart. This is a synthetic-input test, not ordinary-browser course acceptance. The new assertions fail on the initial publication and pass on this candidate.

The current beta browser assessment still shows severe background-tab pacing limits. Do not claim a full playable browser journey until a verified foreground episode succeeds. No hosted or classroom release is established.
