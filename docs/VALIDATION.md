# Publication snapshot validation

9 November 2026, Windows; official Godot 4.8.beta2.official.cafc17a19 and Python 3.11.9.

- 19 Python unit/regression tests: PASS.
- Strict engine import, bounded boot and source/physics smoke: PASS.
- Matching no-thread Compatibility Web export: PASS.
- Runtime scripts, GLBs, collision data and test code: byte-identical to beta source 67a6c24.
- Automated checks for common credential patterns, private machine paths, provider links and email addresses across selected files: no findings. This is a bounded scan, not a guarantee against every secret.

The first publication smoke attempt exposed a missing output directory: private evidence had correctly been excluded, but the unchanged smoke runner requires an evidence directory. That attempt failed with a null file handle and timed out. An empty tracked evidence/.gitkeep now preserves the directory. The next strict run passed all three stages. No gameplay or test assertions were changed.

This run used source-level synthetic input. No new ordinary-browser, full-course, multiplayer stability, performance, hosted or classroom acceptance is claimed. Generated Web output and local logs remain outside Git. Original beta validation and later lab limitations are separated in STATUS.md.

## Solo finish-loop validation, 9 November 2026

The original publication checkpoint was subsequently downloaded from private backup: all 38 files and full Git verified, clean pinned dependencies restored in an isolated Python environment, 19 Python tests and strict import/boot/smoke/Web export passed.

For this new candidate, 19 Python checks plus strict import/boot and expanded physics smoke pass. Matching Web export passes. Expanded smoke traverses the real course twice using synthetic held input and tests finish stop, elapsed-time freeze, movement/jump inhibition, results action, pause, repeat and reset. Running these same new checks against the unchanged baseline produces eight expected finish-loop failures. Original failure evidence is retained separately.

A bounded ordinary-input check of the restored baseline rendered the fox/woodland, started, moved and paused. It repeatedly displayed 1 FPS while the visible Chrome window was on another page. Temporary focus emulation was reverted and did not establish a fix. This was not the modified candidate, and full ordinary-input course/finish acceptance remains open. No performance benchmark is claimed.
