# Parkour Godot

A fox, wings and a small woodland course, built in Godot. This repository is the dedicated Godot port; the original [Three.js Parkour](https://github.com/DaytimeBlues/Parkour) remains separate.

**Status: development prototype, not a finished multiplayer or classroom release.** The runnable project here is the verified woodland beta lineage `67a6c2491ce2c1c0a46a2d266ee2deadbfaaebeb`. Later HTTP and animation experiments are documented separately, not silently presented as integrated features.

## Run locally

1. Use **Godot 4.8 beta 2**, official revision `cafc17a19`. The project uses Compatibility rendering. Preserve the original project if trying another engine version.
2. Import `project.godot` and run the main scene.
3. Select **Start exploring**. Move with WASD or arrow keys, turn with Q/E or mouse drag, press Space to jump and hold it to climb, then release to glide. X requests dive, V changes camera, R resets, and Escape toggles the menu.

The controls above describe implementation, not a claim that every ordinary-input journey has passed. Dive and complete-course acceptance remain open.

## Test and export

Python 3.11+ is used for checks. The optional local visual-peer relay requires `websockets==15.0.1`, pinned in `requirements.txt`. Install dependencies in an environment you control.

```sh
python -m pip install -r requirements.txt
python -m unittest discover -s tests -v
python tools/strict_godot_check.py --godot /absolute/path/to/godot --project . --evidence-dir ../parkour-checks
```

The strict check runs import, bounded boot and physics/source smoke, rejecting engine errors and missing completion evidence. Historical log filenames contain `4.7.2`; they do not select the engine. The supplied executable controls the actual version.

Install the matching official Godot Web export templates, create the `web` directory if needed, then:

```sh
godot --headless --path . --export-release Web web/index.html
python tools/serve.py --http-port 49236 --relay-port 49237
```

Open `http://127.0.0.1:49236/index.html`. The server and relay are loopback-only development tools. Stop them after use. No hosting or automatic deployment is configured here.

## What is included

- Original project-owned fox, Angel wing and woodland GLBs, with SHA-256 provenance.
- Woodland collision geometry: 86 named parts, 5,336 triangles; foliage stays non-colliding.
- A Godot CharacterBody3D prototype with camera, jump/climb/glide and reset behavior.
- An experimental visual-only WebSocket relay and 19 Python regression tests.
- Current [status and source map](docs/STATUS.md), [validation](docs/VALIDATION.md), [roadmap](docs/ROADMAP.md), [asset provenance](assets/PROVENANCE.json) and [publication scope](docs/PUBLICATION.md).

**The visual relay is not the authoritative game backend.** The retained original uses an authoritative HTTP protocol, teacher/seat permissions and sequence/epoch fencing. Its Godot integration remains unfinished. Do not expose this development relay publicly.

## Rights and provenance

No new open-source licence is granted by this import. Project-owned files retain their existing rights. Third-party libraries retain their own licences. Separate fox animation research assets with unresolved release clearance are not included. See [asset and publication notes](docs/PUBLICATION.md).

## Great Woodland map proposal

See the [eight-zone map plan and 72-item asset register](docs/woodland/README.md). This is a planning proposal for a larger connected woodland, not an implemented expansion or a runtime release. Existing game files are unchanged.
