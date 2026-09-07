# Palomar submission preparation

Work in progress: **not yet submission-ready**. Nothing has been submitted.

The intended registered result is the same geometric theorem as the main
development: log-convexity of the actual American put option exercise boundary,
and strict convexity of the stock-price boundary, for positive strike, risk-free
interest rate and volatility and `0 ≤ q ≤ r`, on positive time-to-expiry.
This package must not replace that result with an assumed PDE solution or an
assumed convexity/interval property.

## Proposed compatibility boundary

Palomar permits named definitions whose implementations are supplied by the
Solution, with compared theorems constraining their mathematical meaning.
The Challenge will use this feature only for a probability measure and its
constructed Brownian process. Their probability, Gaussian-increment,
independence, measurability and continuity properties must be proved, not
assumed. The completed usual natural filtration, discounted GBM payoff, full
stopping-time supremum and exercise boundary are to be explicit Mathlib-only
definitions in the Challenge.

This preserves the concrete-model scope of the existing theorem. It does not
claim a new theorem quantified over arbitrary Brownian probability spaces.
The Solution must identify these definitions with the existing development
and invoke the existing proof, rather than prove an easier substitute.

## Verification obligations

- Challenge imports only Mathlib and is within Palomar's size limits.
- Every supplied definition is named in the Comparator configuration and is
  constrained by included, proved model certificates.
- All stopping times of the displayed filtration, bounded by the horizon
  almost surely, are included; the measure and discounting are explicit.
- Boundary positivity and payoff-contact characterization exclude degeneracy.
- Both geometric conclusions have the original parameter hypotheses.
- The Solution has no proof holes or nonstandard axioms.
- Challenge/Solution comparison and independent checking actually pass.
- Metadata accurately describes proof provenance, AI use and review limits.

Policy references (consulted 2026-09-07):
[submission guide](https://palomar-registry.org/how-to-submit),
[detailed requirements](https://github.com/PalomarRegistry/PalomarPolicy/blob/main/CONTRIBUTING.md).

Use `palomar/` as the selected project directory. The parent project is a
same-checkout path dependency; the repository-root licence and Lean toolchain
apply. A public immutable commit is required for any eventual submission.

