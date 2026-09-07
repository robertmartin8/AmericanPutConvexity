# Verification record

This file distinguishes local compatibility checks from a Palomar-hosted,
sandboxed verification. Nothing has been submitted or registered.

## Pinned tools used for the local rehearsal

| Component | Revision/version |
|---|---|
| Proof project | Lean `v4.32.0`; dependency revisions in `lake-manifest.json` |
| PalomarSubmission validator | `c605f23466450a52999fcfb3c6d68ed8febc56bf` |
| Comparator | `575674928e239f5bc452aab72d1dd7b0f1326494` |
| Comparator build toolchain | Lean `v4.34.0-rc1`, as required by its own pinned source |
| Proof exporter | lean4export `4e7915201d3f9f04470d9eae002fa695f7cdc589` (`v4.32.0`) |
| Independent kernel | NanoDa `68d5ca9db226849b41a6fff59d796ff19d0a8840` |

Comparator and NanoDa pins were read from the official PalomarSubmission
workflow. The proof project was not upgraded to Comparator's build toolchain.
All tools were built natively; no Docker was used.

## Completed checks

- `lake build Challenge` and `lake build Solution` succeeded in the nested
  project, with the parent's pinned proof development as a same-checkout path
  dependency. Challenge's deliberate holes are the Comparator contract, not
  proof holes in the Solution.
- The official Palomar metadata and Comparator-configuration parsers accepted
  the package. The official manifest parser and contained-path checks accepted
  the pinned dependency graph and the parent-directory path dependency.
- The Challenge is 125 lines and imports only `Mathlib`.
- The Solution proves equality of the explicit all-stopping-times value and
  exercise boundary with the existing objects before reusing the existing
  geometric theorems. No mathematical proof in the parent project was changed.
- The first Comparator run detected different Lean regular-definition heights
  despite identical financial expressions. Declaring the two supplied Brownian
  objects as transparent `abbrev`s removed that incidental difference. No
  financial definition was added to `definition_names` or exempted from checking.
- The subsequent run passed declaration comparison and started NanoDa.
  **Kernel replay completion is not yet recorded here.**

## Reproduction

For the local structural subset, use a checkout of the pinned
`PalomarRegistry/PalomarSubmission` repository and a Python environment with
PyYAML 6.0.3:

```sh
python preflight.py /path/to/PalomarSubmission
```

The official lockfile did not list the CPython 3.14 ARM64 Mac wheel. The local
environment used the same release with its hash verified against PyPI:
`34d5fcd24b8445fadc33f9cf348c1047101756fd760b4dacb5c3e99755703310`.
This changes a platform artifact, not the validator source or validation rules.

Build the pinned checkers, set `COMPARATOR_BIN`, `COMPARATOR_LEAN4EXPORT`,
`COMPARATOR_NANODA`, and `COMPARATOR_LANDRUN`, then run:

```sh
bash check.sh --native-development
```

On this Mac the Landrun path is Comparator's officially provided
`scripts/fake-landrun.sh`. It does **not** provide sandbox confinement. The
real Comparator and real NanoDa are still used, with the unchanged configuration
and three-axiom restriction. Logs go to the ignored `build/` directory.

## Still outside these local checks

Palomar's secure Linux runner must independently fetch an immutable public
commit, authenticate dependency provenance, compile its protected Challenge,
perform licence detection and sandboxed verification, and run editorial review.
Passing a local rehearsal is not Palomar acceptance, registration, peer review,
or a certificate of novelty. A final package must be committed and pushed by
the author before submitting the full commit SHA with project path `palomar`.
