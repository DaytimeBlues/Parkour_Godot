"""Run the bounded Godot 4.7.2 import, boot, and source smoke checks."""

import argparse
import json
import re
import subprocess
import sys
import time
from pathlib import Path


READY = "GODOT_PROTOTYPE_READY"
ERROR = re.compile(r"(?:SCRIPT )?ERROR:")
ANSI_STYLE = re.compile(r"\x1b\[[0-9;]*m")
PHASES = {
    "import": ("--headless", "--path", ".", "--editor", "--import"),
    "boot": ("--headless", "--path", ".", "--quit-after", "120"),
    "smoke": ("--headless", "--fixed-fps", "60", "--path", ".", "--script", "tests/smoke.gd"),
}


def validate(phase, returncode, output, report=None):
    """Return concrete reasons an engine check cannot be accepted."""
    output = ANSI_STYLE.sub("", output)
    failures = []
    if returncode != 0:
        failures.append(f"{phase}: exit {returncode}")
    if ERROR.search(output):
        failures.append(f"{phase}: engine ERROR marker")
    if phase == "import" and "[ DONE ] loading_editor_layout" not in output:
        failures.append("import: completion marker missing")
    if phase in ("boot", "smoke") and READY not in output:
        failures.append(f"{phase}: ready marker missing")
    if phase == "smoke":
        if report is None:
            failures.append("smoke: report missing")
        elif not isinstance(report, dict) or report.get("pass") is not True or report.get("failures") != []:
            failures.append("smoke: report failed")
        elif not isinstance(report.get("samples"), dict) or not report["samples"]:
            failures.append("smoke: physics samples missing")
        printed = []
        for line in output.splitlines():
            if line.startswith("{"):
                try:
                    printed.append(json.loads(line))
                except json.JSONDecodeError:
                    continue
        if not printed or not any(item == report for item in printed):
            failures.append("smoke: matching JSON completion missing from output")
    return failures


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--godot", type=Path, required=True)
    parser.add_argument("--project", type=Path, default=Path("."))
    parser.add_argument("--evidence-dir", type=Path, required=True)
    parser.add_argument("--timeout", type=int, default=90)
    args = parser.parse_args()
    project = args.project.resolve()
    evidence = args.evidence_dir.resolve()
    evidence.mkdir(parents=True, exist_ok=True)
    report_path = project / "evidence" / "headless-smoke.json"
    if not args.godot.is_file() or not (project / "project.godot").is_file():
        print("FAIL: Godot executable or project.godot missing", file=sys.stderr)
        return 1

    for phase, flags in PHASES.items():
        command = [str(args.godot.resolve()), *flags]
        print(f"COMMAND {phase}: {subprocess.list2cmdline(command)}", flush=True)
        started_ns = time.time_ns()
        try:
            result = subprocess.run(command, cwd=project, stdout=subprocess.PIPE,
                                    stderr=subprocess.STDOUT, text=True,
                                    errors="replace", timeout=args.timeout, check=False)
            output = result.stdout
            code = result.returncode
        except subprocess.TimeoutExpired as exc:
            output = exc.stdout or b""
            if isinstance(output, bytes):
                output = output.decode(errors="replace")
            output += f"\nTIMEOUT after {args.timeout}s\n"
            code = -1
        except OSError as exc:
            output = f"LAUNCH ERROR: {exc}\n"
            code = -1
        (evidence / f"ui-repair-{phase}-4.7.2.log").write_text(output, encoding="utf-8")
        report = None
        if phase == "smoke" and report_path.is_file() and report_path.stat().st_mtime_ns >= started_ns:
            try:
                report = json.loads(report_path.read_text(encoding="utf-8"))
                (evidence / "ui-repair-smoke-4.7.2.json").write_text(
                    json.dumps(report, indent=2) + "\n", encoding="utf-8")
            except (OSError, json.JSONDecodeError):
                pass
        failures = validate(phase, code, output, report)
        if code == -1 and "TIMEOUT" in output:
            failures.append(f"{phase}: timeout")
        if failures:
            for failure in failures:
                print(f"FAIL: {failure}", file=sys.stderr)
            return 1
        print(f"PASS: {phase} (log: {evidence / f'ui-repair-{phase}-4.7.2.log'})", flush=True)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
