# Completion audit of the requested formalization

## Requested scope

The request was to formalize the proposed extension and obtain high confidence
that the statement and proof are correct, while formalizing weaker cases as
checkpoints. A cleaner Lean proof path was explicitly permitted. The supplied
background attachment was read; its historical/novelty discussion is not itself
proof evidence.

The requested mathematical result is the actual Black--Scholes American-put
exercise boundary under constant parameters `K>0`, `r>0`, `sigma>0`,
`0<=q<=r`: weak logarithmic curvature and strictly positive stock curvature
at every positive remaining maturity. C2 regularity is needed for the literal
everywhere second-derivative formulation. No assumption of convexity, a
single-interval invariant, a classical solution's existence, or boundary
smoothness may stand in place of a proof for the actual stopping problem.

## Requirement-by-requirement evidence

All source paths below are relative to `AmericanConvexity/`.

| Requirement | Authoritative evidence | Result |
| --- | --- | --- |
| Actual financial value rather than an arbitrary PDE solution | `Stopping/AmericanValue.lean`, `Reward.lean`, `UsualBrownianValue.lean` | Supremum of expected discounted put payoffs over bounded Brownian stopping times |
| Correct dividend drift, discounting and maturity convention | `Reward.lean`, `ActualNormalization.lean`, `ActualBoundaryNormalization.lean` | Drift `r-q`, discount rate r, variance `sigma^2*t`, and exact `t=sigma^2*tau/2` rescaling |
| Actual exercise threshold | `ExerciseRegion.lean`, `PositiveExerciseBoundary.lean` | Payoff-contact supremum; positivity, value matching and continuation identification proved |
| No accidental restriction to pointwise horizon bounds | `AEHorizonValue.lean`, `AEHorizonCurvature.lean` | Almost-sure and pointwise conventions have identical reward sets, values and boundaries |
| Constructed ODE profiles and exact straight-line pricing solution | `Boundary/Comparison.lean` | Profile existence, positivity, PDE, value matching and smooth fit checked |
| Identity (8) and domination on both sides below strike | `Boundary/Comparison.lean`, `ODEComparison.lean` | Exact excess identity and integrating-factor proof, including negative displacement |
| Identity (16) and initial single-interval shape | `Boundary/Comparison.lean`, `SingleCrossing.lean`, `ComparisonShape.lean` | Genuine derivative identity `J'=c` at zeros and interval-shaped strict superlevels |
| Positive interval propagation, including expiry | `Boundary/ParabolicValley.lean`, `ComparisonUnimodality.lean`; `Stopping/ActualComparisonIntervals.lean` | Direct three-point maximum proof; no Sturm or small-time derivative-trace hypothesis |
| Terminal boundary-point argument | `Boundary/ParabolicHopf.lean`, `ComparisonHopf.lean`, `Tangency.lean` | Explicit backward-rectangle barrier and contradiction with right smooth fit |
| Reduction to global convexity and expiry behavior | `Stopping/ActualNearExpiry.lean`, `ActualLogConvexity.lean`; `Boundary/LineIntervalConvexity.lean` | Proved expiry bound and derivative-free line/chord argument |
| Strictly negative boundary speed | `Stopping/ActualStefanVelocity.lean` | Actual derivative exists and is strictly negative at every positive time |
| Genuine classical second derivatives | `Stopping/ActualDensityC1.lean`, `ActualHeatFluxC1.lean`, `ActualBoundaryC2.lean` | Actual boundary is C2; no assumed second derivative or all-order classical contract |
| Full proposed curvature conclusion in physical units | `Stopping/PhysicalBoundaryCurvature.lean`, `brownianUsualBoundary_classical_curvature` | C2 for both profiles, `(log(B/K))''>=0`, `B''>0`, under only the requested parameters |
| Zero-dividend and Liu checkpoints | `Stopping/ActualBoundaryCurvature.lean`, `PhysicalBoundaryCurvature.lean` | Explicit weak log-curvature and strict stock-curvature specializations |
| Equal-rate endpoint and a parameter point outside Liu's range | `Stopping/AEHorizonCurvature.lean` | Exact theorem instances, not numerical tests |
| Complete proof terms under standard logical foundations | `AxiomAudit.lean`; `docs/audits/final-proof-dependencies.json` | Full build and fresh replay of 74,785 declarations; only the three standard axioms |
| Meaningful statement/proof inspection | `docs/solution-contract.md`, `straight-line-audit.md`, `dependency-audit.md` | Financial definitions and critical analytic steps inspected; substitutions and trust boundaries recorded |

The aggregate theorem's hypotheses and its underlying value/boundary definitions
were read directly. The source-level proof audit is not inferred from theorem
names or from the number of successful jobs. The dependency audit inspects
actual declaration types and bodies; its negative controls reject missing
declarations, `sorryAx`, and an invalid proof of `False`.

## Scope of completion and remaining distinctions

The requested formalization is complete in the ordinary sense of a Lean proof:
the actual theorem and weaker-case checkpoints are proved, the proof terms are
kernel-checked, and the statement/critical proof path have an author-side audit.
This is not a guarantee beyond Lean's trusted foundations or an assertion that
independent mathematical review has already occurred.

The following are not claimed as completed by this result:

- A line-by-line formalization of CCJZ's separate published proof, or its
  stronger strictly positive logarithmic-curvature conclusion. The authorized
  alternative proof supplies the requested weaker-case checkpoints.
- All-order boundary smoothness. C2 suffices for the requested result and is
  explicitly proved; the stronger existing classical contract remains a
  separate development track.
- Formal verification or reproduction of the supplied numerical reports,
  fifth-order expansion, or claims in the `q>r` regime. None is a premise of
  this proof.
- A present-day priority determination, publication, or independent referee
  report. Those require separate work and, for external coordination, authority.

No merge into main, push, publication or external review submission is part of
this handoff. The proved result and its audit are retained on the feature branch.
