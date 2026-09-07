# Palomar submission preparation

**Local compatibility checks passed**, including Comparator, NanoDa and a fresh
Lean-kernel replay. Nothing has been submitted. Palomar's secure hosted run and
editorial review remain separate steps; see [the verification record](VERIFICATION.md).

The intended registered result is the same geometric theorem as the main
development: log-convexity of the actual American put option exercise boundary,
and strict convexity of the stock-price boundary, for positive strike, risk-free
interest rate and volatility and `0 ≤ q ≤ r`, on positive time-to-expiry.
This package does not replace that result with an assumed PDE solution or an
assumed convexity/interval property.

## Compatibility boundary

Palomar permits named definitions whose implementations are supplied by the
Solution, with compared theorems constraining their mathematical meaning.
The Challenge uses this feature only for a probability measure and its
constructed Brownian process. Their probability, Gaussian-increment,
independence, measurability and continuity properties are proved and included
in the comparison. The completed usual natural filtration, discounted GBM
payoff, full stopping-time supremum and exercise boundary are explicit
Mathlib-only definitions in the Challenge.

This preserves the concrete-model scope of the existing theorem. It does not
claim a new theorem quantified over arbitrary Brownian probability spaces.
The Solution identifies these definitions with the existing development
and invokes the existing proof. No parent proof files were changed.

## What changed, and what did not

`law` and `W` are the only named definition holes in the Challenge. In the
Solution they are transparent aliases for Degenne's `gaussianLimit` and
`brownian`. The ordinary Brownian laws above prevent interpreting these as
a zero process, a non-probability measure, or an arbitrary financial boundary.
The final theorems have exactly the existing admissibility inequalities.

The adapter uses the existing theorem equating almost-surely bounded stopping
times with pointwise-bounded representatives. It does not restrict the stopping
family or change the discount rate, stock drift, payoff or filtration.
`value_eq` and `boundary_eq` are the explicit links back to the existing proof.
Classical boundary regularity and second derivatives are not in this geometric
submission target; those results remain in the parent development.

The 135-line Challenge includes the probability-model certificates, value
bounds, strict boundary bounds, the payoff-contact characterization, and both
geometric conclusions. Its deliberate `sorry`s are filled in the separate
Solution and are checked by Comparator; the Solution contains none.

Two further statements explicitly identify Brownian adaptedness to the stopping
filtration and the boundary as the supremum over all positive payoff-contact
spots. The `[0,K]` definition therefore does not conceal a different exercise set.

## Verification scope

- Challenge imports only Mathlib and is within Palomar's size limits.
- Every supplied definition is named in the Comparator configuration and is
  constrained by included, proved model certificates.
- All stopping times of the displayed filtration, bounded by the horizon
  almost surely, are included; the measure and discounting are explicit.
- Boundary positivity and payoff-contact characterization exclude degeneracy.
- Both geometric conclusions have the original parameter hypotheses.
- The Solution has no proof holes or nonstandard axioms.
- Challenge/Solution comparison and independent checking pass locally.
- Metadata accurately describes proof provenance, AI use and review limits.

Policy references (consulted 2026-09-07):
[submission guide](https://palomar-registry.org/how-to-submit),
[detailed requirements](https://github.com/PalomarRegistry/PalomarPolicy/blob/main/CONTRIBUTING.md).

Use `palomar/` as the selected project directory. The parent project is a
same-checkout path dependency; the repository-root licence and Lean toolchain
apply. A public immutable commit is required for any eventual submission.

Build with `lake build` from this directory. For the full native rehearsal use
`bash check.sh --native-development` with the pinned tools described in
[VERIFICATION.md](VERIFICATION.md). This rehearsal does not establish Linux
sandbox security or claim a Palomar-hosted verification result.
