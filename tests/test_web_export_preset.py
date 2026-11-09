"""Keep the Web export portable and independent of prior generated output."""
import configparser
from pathlib import Path
import unittest


class WebExportPresetTests(unittest.TestCase):
    def setUp(self):
        self.preset = configparser.RawConfigParser()
        self.preset.read(Path(__file__).resolve().parents[1] / "export_presets.cfg")

    def test_templates_resolve_from_matching_engine_install(self):
        options = self.preset["preset.0.options"]
        self.assertEqual(options["custom_template/debug"], '""')
        self.assertEqual(options["custom_template/release"], '""')

    def test_generated_web_folder_is_excluded(self):
        exclusions = self.preset["preset.0"]["exclude_filter"].strip('"').split(",")
        self.assertIn("web/*", exclusions)


if __name__ == "__main__":
    unittest.main()
