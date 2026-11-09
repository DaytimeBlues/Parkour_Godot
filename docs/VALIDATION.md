# Publication snapshot validation

9 November 2026, Windows; official Godot 4.8.beta2.official.cafc17a19 and Python 3.11.9.

- 19 Python unit/regression tests: PASS.
- Strict engine import, bounded boot and source/physics smoke: PASS.
- Matching no-thread Compatibility Web export: PASS.
- Runtime scripts, GLBs, collision data and test code: byte-identical to beta source 67a6c24.
- Automated checks for common credential patterns, private machine paths, provider links and email addresses across selected files: no findings. This is a bounded scan, not a guarantee against every secret.

The first publication smoke attempt exposed a missing output directory: private evidence had correctly been excluded, but the unchanged smoke runner requires an evidence directory. That attempt failed with a null file handle and timed out. An empty tracked evidence/.gitkeep now preserves the directory. The next strict run passed all three stages. No gameplay or test assertions were changed.

This run used source-level synthetic input. No new ordinary-browser, full-course, multiplayer stability, performance, hosted or classroom acceptance is claimed. Generated Web output and local logs remain outside Git. Original beta validation and later lab limitations are separated in STATUS.md.
