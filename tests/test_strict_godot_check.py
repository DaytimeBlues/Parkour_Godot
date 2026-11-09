"""False-green regression cases for the bounded Godot check."""

import unittest

from tools.strict_godot_check import validate


GOOD_REPORT = {"pass": True, "failures": [], "samples": {"spawn": {"grounded": True}}}
GOOD_SMOKE_OUTPUT = 'GODOT_PROTOTYPE_READY parts=86 triangles=5336\n{"pass": true, "failures": [], "samples": {"spawn": {"grounded": true}}}\n'


class StrictGodotCheckTests(unittest.TestCase):
    def test_exit_zero_with_engine_error_is_rejected(self):
        self.assertIn("boot: engine ERROR marker", validate(
            "boot", 0, "SCRIPT ERROR: Cannot call method\nGODOT_PROTOTYPE_READY"))

    def test_import_without_completion_is_rejected(self):
        for output in ("", "Godot Engine\n"):
            with self.subTest(output=output):
                self.assertIn("import: completion marker missing", validate("import", 0, output))

    def test_completed_import_can_pass(self):
        self.assertEqual([], validate("import", 0, "Godot Engine\n[ DONE ] loading_editor_layout\n"))

    def test_coloured_godot_import_completion_can_pass(self):
        output = "\x1b[92m[ DONE ]\x1b[39m \x1b[1mloading_editor_layout\x1b[22m\n"
        self.assertEqual([], validate("import", 0, output))

    def test_missing_ready_marker_is_rejected(self):
        self.assertIn("boot: ready marker missing", validate("boot", 0, "Godot Engine\n"))

    def test_nonzero_exit_is_rejected(self):
        self.assertIn("import: exit 2", validate("import", 2, "Godot Engine\n"))

    def test_missing_smoke_report_is_rejected(self):
        self.assertIn("smoke: report missing", validate("smoke", 0, GOOD_SMOKE_OUTPUT))

    def test_failed_smoke_report_is_rejected(self):
        failed = {**GOOD_REPORT, "pass": False, "failures": ["UI root missing"]}
        self.assertIn("smoke: report failed", validate("smoke", 0, GOOD_SMOKE_OUTPUT, failed))

    def test_malformed_smoke_report_is_rejected(self):
        self.assertIn("smoke: report failed", validate("smoke", 0, GOOD_SMOKE_OUTPUT, []))

    def test_missing_printed_completion_is_rejected(self):
        self.assertIn("smoke: matching JSON completion missing from output",
                      validate("smoke", 0, "GODOT_PROTOTYPE_READY\n", GOOD_REPORT))

    def test_valid_smoke_can_pass(self):
        self.assertEqual([], validate("smoke", 0, GOOD_SMOKE_OUTPUT, GOOD_REPORT))


if __name__ == "__main__":
    unittest.main()
