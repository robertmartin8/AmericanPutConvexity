#!/usr/bin/env python3
"""Local structural checks using a supplied checkout of PalomarSubmission.

This is deliberately not called a Palomar verification: it does not perform
remote source authentication, licence detection, sandboxing or kernel replay.
"""

import argparse
import json
from pathlib import Path
import subprocess
import sys


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("policy_checkout", type=Path)
    args = parser.parse_args()
    policy = args.policy_checkout.resolve()
    sys.path.insert(0, str(policy))
    from scripts.submission_contract import load_formalization_metadata
    from scripts.verify_submission import (
        MAX_CHALLENGE_BYTES, MAX_CHALLENGE_LINES, load_comparator_config,
        manifest_packages, manifest_packages_directory,
        recorded_project_dependencies, repository_license_file,
    )

    project = Path(__file__).resolve().parent
    checkout = project.parent
    metadata = load_formalization_metadata(project / "formalization.yaml")
    config = load_comparator_config(project / "comparator.json")
    packages = manifest_packages(project)
    dependencies = recorded_project_dependencies(project, checkout, packages)
    manifest_packages_directory(project, checkout=checkout)
    licence = repository_license_file(checkout)
    challenge = (project / "Challenge.lean").read_bytes()
    if len(challenge) > MAX_CHALLENGE_BYTES or len(challenge.splitlines()) > MAX_CHALLENGE_LINES:
        raise ValueError("Challenge exceeds Palomar's size limit")
    policy_commit = subprocess.check_output(
        ["git", "rev-parse", "HEAD"], cwd=policy, text=True).strip()
    print(json.dumps({
        "check": "local structural preflight subset",
        "palomar_submission_revision": policy_commit,
        "metadata": "passed official parser",
        "comparator_configuration": "passed official parser",
        "theorems": len(config["theorem_names"]),
        "supplied_definitions": config.get("definition_names", []),
        "challenge_bytes": len(challenge),
        "challenge_lines": len(challenge.splitlines()),
        "dependencies": dependencies,
        "root_licence_file": str(licence.relative_to(checkout)),
        "limitations": "No secure runner, source authentication, licence detection or proof replay in this command",
    }, indent=2))


if __name__ == "__main__":
    main()
