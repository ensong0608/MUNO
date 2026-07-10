# SPDX-FileCopyrightText: 2026 MUNO contributors
# SPDX-License-Identifier: GPL-3.0-or-later

"""Fast repository-foundation checks that do not require a Blender build."""

from __future__ import annotations

import os
import re
import subprocess
import sys
import tempfile
import unittest
from pathlib import Path
from unittest import mock


ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / "scripts"))

import generate_config  # noqa: E402


EXPECTED_BLENDER_COMMIT = "f52ba4dcdf5f669c1bc57f39a0e056be30d3ab60"


class FoundationTests(unittest.TestCase):
    def test_required_license_files_exist(self) -> None:
        required = (
            "LICENSE",
            "NOTICE.md",
            "REUSE.toml",
            "SOURCE_CORRESPONDENCE.md",
            "TRADEMARKS.md",
            "LICENSES/GPL-2.0-or-later.txt",
            "LICENSES/GPL-3.0-or-later.txt",
            "LICENSES/LicenseRef-Mixar-Brand.txt",
        )
        for relative_path in required:
            with self.subTest(path=relative_path):
                self.assertTrue((ROOT / relative_path).is_file())

    def test_blender_gitlink_is_pinned_to_compatibility_commit(self) -> None:
        output = subprocess.check_output(
            ["git", "ls-files", "--stage", "upstream"],
            cwd=ROOT,
            text=True,
        )
        mode, commit, stage_and_path = output.strip().split(maxsplit=2)
        self.assertEqual(mode, "160000")
        self.assertEqual(commit, EXPECTED_BLENDER_COMMIT)
        self.assertEqual(stage_and_path, "0\tupstream")

    def test_runtime_config_defaults_are_local(self) -> None:
        with tempfile.TemporaryDirectory() as temporary_dir:
            version_file = Path(temporary_dir) / "VERSION"
            version_file.write_text("9.8.7\n", encoding="utf-8")
            with mock.patch.dict(os.environ, {}, clear=True):
                config = generate_config.generate_config(str(version_file))

        self.assertEqual(config["environment"], "Prod")
        self.assertEqual(config["backend_url"], "http://127.0.0.1:8765")
        self.assertEqual(config["frontend_url"], "http://127.0.0.1:3000")
        self.assertEqual(config["app_info"]["version"], "9.8.7")
        self.assertNotIn("dev_bypass", config)

    def test_dev_bypass_is_rejected_outside_dev(self) -> None:
        environment = {"MUNO_ENV": "Prod", "DEV_BYPASS_ENABLED": "true"}
        with mock.patch.dict(os.environ, environment, clear=True):
            with self.assertRaises(SystemExit):
                generate_config.generate_config(str(ROOT / "VERSION"))

    def test_build_defaults_match_blender_base_and_optional_gpu_policy(self) -> None:
        windows = (ROOT / "scripts/windows/settings.bat").read_text(encoding="utf-8")
        unix = (ROOT / "scripts/unix/settings.sh").read_text(encoding="utf-8")
        cmake = (ROOT / "cmake/muno_overrides.cmake").read_text(encoding="utf-8")

        self.assertIn("BLENDER_VERSION=5.0", windows)
        self.assertIn("BLENDER_VERSION:-5.0", unix)
        self.assertIn('if "%BUILD_WITH_NINJA%"=="1"', windows)
        self.assertIn("set(MUNO_ENABLE_CUDA OFF", cmake)
        self.assertIn("set(MUNO_ENABLE_OPTIX OFF", cmake)

    def test_local_markdown_links_resolve(self) -> None:
        link_pattern = re.compile(r"\[[^]]*]\(([^)]+)\)")
        failures: list[str] = []
        markdown_files = [ROOT / "README.md", *sorted((ROOT / "docs").glob("*.md"))]

        for markdown_file in markdown_files:
            for target in link_pattern.findall(markdown_file.read_text(encoding="utf-8")):
                target = target.strip().split("#", 1)[0]
                if not target or "://" in target or target.startswith("mailto:"):
                    continue
                resolved = (markdown_file.parent / target).resolve()
                if not resolved.exists():
                    failures.append(f"{markdown_file.relative_to(ROOT)} -> {target}")

        self.assertEqual(failures, [], "Broken local links:\n" + "\n".join(failures))


if __name__ == "__main__":
    unittest.main()
