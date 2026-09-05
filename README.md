# AmericanConvexity

A Lean 4 project verifying a proposed straight-line comparison proof that the
logarithmic American-put exercise boundary is convex for `0 <= q <= r`, `r>0`.
The zero-dividend and Liu parameter regimes are explicit milestones, and the
independent published CCJZ proof development is retained. The project integrates
[MathFin](https://github.com/formal-applied-math/formal-mathfin); the boundary
proof modules currently use Mathlib and local results, not MathFin pricing results.

> **Status: weak log-curvature and strict stock curvature are proved for the
> classical pricing contract.** `DividendPutSolution k h p b` implies `b''(t)>=0`,
> `b'(t)<0`, and the reconstructed stock boundary satisfies `B''(tau)>0`.
> No extra interval, speed, expiry, zero-count or derivative-trace premise remains.
> Identification with the actual American stopping value and the independent
> strict-log-curvature CCJZ proof remain open.

## Proposed extension and published checkpoints

The active target is `b''(t)>=0` for `t>0`, where
`b(t)=log(B(t/a)/K)`, `a=sigma^2/2`, and `0<=q<=r`, `r>0`, `sigma>0`, `K>0`.
The proposed proof and its exact verification frontier are tracked in
[`docs/comparison-proof.md`](docs/comparison-proof.md).

The actual continuous-time stopping value is now defined on a constructed
Brownian probability space. Payoff bounds, expiry payoff, maturity monotonicity,
spot convexity/continuity, and the in-the-money contact threshold are checked
directly from that definition. Price identification would identify the boundary
and transfer curvature, but that stochastic/PDE identification remains open.
See [`docs/stopping-value.md`](docs/stopping-value.md) for the exact filtration,
terminal-boundary convention, and remaining obligations.

Bounded continuous-path optional stopping is now proved by grid approximation
from the discrete theorem, and a verification principle connects dominating
supermartingales and contact martingales to the actual American supremum.
The exact discounted classical-price candidate has checked continuity,
adaptation, boundedness, and payoff domination. Its first-contact stopping rule
is now constructed, with proved contact and pre-contact continuation. Its
contact-martingale property is now derived from the PDE. The global
supermartingale property remains open, so identification is not yet complete.

The stochastic bridge now proves the exact Brownian-coordinate heat equation
inside continuation and constructs compact C3 localizations with zero drift
near each interior point. MathFin's Ito theorem supplies their compensated
local martingales on the explicitly null-augmented filtration. Assembly up to
first contact, promotion to a true martingale, and transfer to the raw
filtration are now proved. The global supermartingale property remains open.

Explicit interior stopping rules now converge pathwise to first contact. Before
each rule, the price/payoff gap and remaining maturity are bounded away from
zero, and the Brownian coordinate is bounded. A checked bounded-martingale limit
then transfers interior martingality to first contact. Compact-region smooth
extensions and a countable-dense-time argument make the Ito representation valid
simultaneously at random stopped times. Stopping stability and bounded promotion
complete `brownianClassicalContactRule_martingale`, without an additional
martingale premise. This also proves that the classical price is the expected
payoff of this admissible rule, hence is no greater than the actual American value.

**New checked progress:** the classical contract now also implies globally
strictly negative boundary speed. Weak log curvature reduces zero speed to a
flat tail. Explicit positive-patch barriers propagate positivity of actual
time increments; a slanted terminal Hopf rectangle excludes a flat tail.
`StockConclusion.lean` proves strict stock curvature in calendar time and time
remaining, including named zero-dividend and Liu-range specializations.

A direct three-point maximum principle proves the
positive-interval invariant. It uses continuous initial data and the normalized
PDE, bypassing the full Sturm theorem and the initial derivative-trace argument.
`ComparisonConclusion.lean` discharges the last premise of the log-curvature
assembly and proves `DividendCurvatureClaim`, `ZeroDividendWeakCurvatureClaim`,
and `LiuRangeCurvatureClaim` for their stated classical contracts.

The checked chain includes the explicit comparison/PDE/smooth fit, payoff
domination, initial shape, normalized PDE, tail/coefficient and boundary-sign
bounds, moving-boundary maximum principle, terminal Hopf barrier, geometric
rectangle construction, and negative-intercept reduction. The zero-dividend
specialization uses the original CCJZ contract. **The weak zero-dividend result
is a specialization of this proof, not an independent verification of the
published strict-log-curvature proof.**

The earlier zero-count route is retained: exact initial roots, confinement and
conditional initialization are checked. Its derivative-trace and Sturm inputs
remain unproved, but neither is used in the completed classical log-curvature
proof. The earlier strict-speed premise is now discharged by
`StrictBoundarySpeed.lean`, without adding any pricing-contract fields.

The pricing contract now also yields strict separation of the boundary from
the strike, and a proved comparison theorem for smooth subsolutions on strips
that cross the exercise region. The free-boundary contact case uses smooth fit
and a one-sided test-function calculation, not an assumed PDE or second price
derivative at the boundary. Applying this comparison now proves the non-sharp
bound `b(t)<-sqrt(t)/64` for sufficiently small positive times, and hence
`b(t)/t -> -infinity`. The zero-dividend ratio-limit specialization is checked.

The published zero-dividend checkpoint is:

X. Chen, J. Chadam, L. Jiang, and W. Zheng, **Convexity of the Exercise Boundary
of the American Put Option on a Zero Dividend Asset**, *Mathematical Finance*
18(1), 2008, pp. 185–197, **Theorem 1.1**.

[Read the paper](https://sites.pitt.edu/~chadam/papers/3CCJW9-28-05.pdf) ·
[Detailed source audit and proof plan](docs/ccjz-audit.md)

The setting is the Black–Scholes model with zero dividends, positive strike `E`,
volatility `σ`, risk-free rate `r`, and maturity `T_F`. In particular, the paper's
argument uses `k = 2r/σ² > 0`; we must not silently extend it to nonpositive rates.

Writing `T` for calendar time, the paper introduces

```text
t = (σ²/2)(T_F - T),       S_f(T) = E exp(s(t)).
```

It proves the stronger curvature statements

```text
s''(t) > 0       for t > 0,
S_f''(T) > 0     before expiry.
```

This is **convexity of the exercise boundary in time**, not convexity of an
option price in spot or strike. Smoothness at expiry is not asserted. The paper's
near-expiry asymptotics, Theorem 1.2, are not our current target.

## Work completed

### 1. Lean development environment

Installed elan, Lean, Lake, the Lean extension in the existing Cursor editor,
and TOML editing support. Downloaded Mathlib's precompiled artifacts and added
editor build/check/cache tasks and a GitHub Actions build workflow.

The initial setup used Lean 4.33.1. The project was subsequently aligned with
MathFin's **Lean 4.32.0** toolchain; elan selects it automatically in this folder.
The newer toolchain remains installed locally for other projects.

### 2. MathFin integration and coverage check

MathFin is a **pinned Lake Git dependency**, not a fork or copied source tree.
Our proofs live separately in `AmericanConvexity/` and can import upstream modules:

```lean
import MathFin.Binomial.American
import MathFin.Binomial.SnellEnvelope
```

All 14 transitive package revisions were compared with MathFin's manifest and
matched. [Integration details and scope](docs/upstream.md).

**No implementation of the target theorem was found.** The investigation searched
all 284 MathFin modules, its umbrella and documentation, and inspected the closest
candidate definitions and statements. The pinned revision also matched GitHub
HEAD at the time of that check.

- `Binomial/American.lean` defines finite-step American pricing by Bellman recursion.
- `Binomial/SnellEnvelope.lean` provides discrete scalar/path-space characterizations;
  it explicitly leaves supremum-over-stopping-times identification as downstream work.
- `BlackScholes/SpotConvexity.lean` concerns European call-price convexity in spot.
- `StrikeConvexity.lean` and `PutStrikeConvexity.lean` concern European prices in strike.

None supplies the continuous-time American exercise boundary or its time convexity.
The upstream documentation's statement that zero-dividend boundary convexity is
“proved” refers to the mathematical literature, not an existing Lean proof.

### 3. Supporting mathematical results

All files below are included in the project build.

| File | What is checked |
| --- | --- |
| [`Boundary/Coordinates.lean`](AmericanConvexity/Boundary/Coordinates.lean) | Normalized time, reconstruction of the stock-price boundary, expiry convention, first and second derivatives, and transfer of convexity/positive curvature |
| [`Boundary/Limits.lean`](AmericanConvexity/Boundary/Limits.lean) | Pointwise limits of convex real functions on a fixed convex domain are convex |
| [`Boundary/Problem.lean`](AmericanConvexity/Boundary/Problem.lean) | Classical normalized solution predicate; payoff/contact correspondence in stock units; uniqueness of the threshold for a fixed price; explicit open analytic goals |
| [`Boundary/DividendProblem.lean`](AmericanConvexity/Boundary/DividendProblem.lean) | Dividend solution contract; exact zero-dividend equivalence; physical parameter normalization; named weak curvature targets proved in ComparisonConclusion |
| [`Boundary/DividendContact.lean`](AmericanConvexity/Boundary/DividendContact.lean) | Classical dividend price/payoff contact characterizes the boundary in log and stock units |
| [`Stopping/Rules.lean`](AmericanConvexity/Stopping/Rules.lean) | Bounded finite-horizon stopping rules; derived measurability; equivalent representation of bounded WithTop stopping times |
| [`Stopping/Reward.lean`](AmericanConvexity/Stopping/Reward.lean) | Dividend GBM stopped reward, measurability, integrability, and pointwise bounds |
| [`Stopping/AmericanValue.lean`](AmericanConvexity/Stopping/AmericanValue.lean) | Nonempty bounded stopping-value supremum; payoff/European bounds; expiry and maturity monotonicity |
| [`Stopping/SpotShape.lean`](AmericanConvexity/Stopping/SpotShape.lean) | Actual stopping value is decreasing and convex in initial spot |
| [`Stopping/ExerciseRegion.lean`](AmericanConvexity/Stopping/ExerciseRegion.lean) | Spot continuity; closed interval contact set; attained threshold, expiry convention, and maturity monotonicity |
| [`Stopping/BrownianModel.lean`](AmericanConvexity/Stopping/BrownianModel.lean) | Constructed Brownian model, natural filtration, financial value, and contact threshold |
| [`Stopping/ClassicalBridge.lean`](AmericanConvexity/Stopping/ClassicalBridge.lean) | Price identification implies boundary identification and transfers strict curvature; price identification remains an explicit open premise |
| [`Stopping/GridSampling.lean`](AmericanConvexity/Stopping/GridSampling.lean) | Upward stopping-time grid approximation and bounded continuous-path optional stopping |
| [`Stopping/Verification.lean`](AmericanConvexity/Stopping/Verification.lean) | Dominating-supermartingale upper bound and contact-martingale verification for the actual stopping-value supremum |
| [`Stopping/ClassicalCandidate.lean`](AmericanConvexity/Stopping/ClassicalCandidate.lean) | Exact discounted classical-price process; continuity, bounds, reward domination, and conditional verification |
| [`Stopping/FirstContact.lean`](AmericanConvexity/Stopping/FirstContact.lean) | Continuous adapted first-zero stopping rule from compact minima, without usual-filtration assumptions |
| [`Stopping/ClassicalContact.lean`](AmericanConvexity/Stopping/ClassicalContact.lean) | Constructed classical first-contact rule, attained payoff contact, and strict continuation before contact |
| [`Stopping/BrownianVerification.lean`](AmericanConvexity/Stopping/BrownianVerification.lean) | Constructed Brownian contact rule; price identification and boundary curvature reduced to two explicit martingale obligations |
| [`Stopping/CandidatePDE.lean`](AmericanConvexity/Stopping/CandidatePDE.lean) | Exact physical-time/Brownian-coordinate derivatives and zero generator inside continuation |
| [`Stopping/SmoothLocalization.lean`](AmericanConvexity/Stopping/SmoothLocalization.lean) | Compact C3 functions agreeing with the actual price near continuation points |
| [`Stopping/PlaneIto.lean`](AmericanConvexity/Stopping/PlaneIto.lean) | Joint C3 regularity supplies the partials required by MathFin's local-martingale Ito theorem |
| [`Stopping/LocalPriceIto.lean`](AmericanConvexity/Stopping/LocalPriceIto.lean) | Zero-drift local price extensions with genuine compensated local martingales; assembled later in ContactMartingale |
| [`Stopping/BoundedLocalMartingale.lean`](AmericanConvexity/Stopping/BoundedLocalMartingale.lean) | Deterministically bounded local martingales are true martingales, by localized set-integral limits; transfer to smaller filtrations |
| [`Stopping/BrownianLocalVerification.lean`](AmericanConvexity/Stopping/BrownianLocalVerification.lean) | Stopped candidate is raw-adapted and bounded; augmented local martingality implies the raw true-martingale property needed for verification |
| [`Stopping/LocalizationTimes.lean`](AmericanConvexity/Stopping/LocalizationTimes.lean) | Explicit interior stopping rules, strict pre-exit and closed positive-exit margins, and pathwise convergence to first contact |
| [`Stopping/MartingaleLimits.lean`](AmericanConvexity/Stopping/MartingaleLimits.lean) | Bounded pointwise limits preserve martingality; continuous stopped candidates pass to limits of stopping rules |
| [`Stopping/BrownianInteriorLocalization.lean`](AmericanConvexity/Stopping/BrownianInteriorLocalization.lean) | Brownian interior approximation and reduction of contact martingality to interior local martingales |
| [`Stopping/CompactLocalization.lean`](AmericanConvexity/Stopping/CompactLocalization.lean) | One compactly supported C3 extension around a whole compact subset of continuation, with zero generator there |
| [`Stopping/InteriorRegion.lean`](AmericanConvexity/Stopping/InteriorRegion.lean) | Explicit compact regions containing trajectories up to positive interior exits; one smooth extension works for all such paths |
| [`Stopping/InteriorIto.lean`](AmericanConvexity/Stopping/InteriorIto.lean) | Simultaneous almost-sure stopped-time Ito representation, using dense times and continuity; includes immediate stopping |
| [`Stopping/ContactMartingale.lean`](AmericanConvexity/Stopping/ContactMartingale.lean) | Contact martingality and realized contact payoff from the classical PDE; identification now requires only the global supermartingale property in addition to the classical contract |
| [`Boundary/Comparison.lean`](AmericanConvexity/Boundary/Comparison.lean) | Explicit straight-line comparison, PDE and smooth fit, payoff domination, Riccati crossing identity, characteristic growth gap |
| [`Boundary/ODEComparison.lean`](AmericanConvexity/Boundary/ODEComparison.lean) | Two-sided nonnegative-forcing ODE comparison proved by integrating factors |
| [`Boundary/SingleCrossing.lean`](AmericanConvexity/Boundary/SingleCrossing.lean) | Upward-crossing uniqueness, single-valley geometry, and at-most-two roots per level |
| [`Boundary/ComparisonShape.lean`](AmericanConvexity/Boundary/ComparisonShape.lean) | Initial single-interval geometry, two-point level covers, simple noncritical roots, and identification with the initial pricing difference |
| [`Boundary/GaugeTransform.lean`](AmericanConvexity/Boundary/GaugeTransform.lean) | Local normalized-difference PDE, epsilon-shift invariance, and negative moving-boundary/initial-corner data |
| [`Boundary/ComparisonTail.lean`](AmericanConvexity/Boundary/ComparisonTail.lean) | Explicit exponential tail estimate, uniform-in-time convergence to minus one, and a fixed negative right endpoint; includes a named zero-dividend specialization |
| [`Boundary/ComparisonCoefficients.lean`](AmericanConvexity/Boundary/ComparisonCoefficients.lean) | Bounds on the logarithmic profile slope, normalized PDE drift, and its first spatial and temporal derivatives |
| [`Boundary/ParabolicMaximum.lean`](AmericanConvexity/Boundary/ParabolicMaximum.lean) | Proved weak maximum principle on continuous moving strips, including terminal time and moving-domain compactness |
| [`Boundary/ComparisonMaximum.lean`](AmericanConvexity/Boundary/ComparisonMaximum.lean) | No-positive-data branch and earlier-positive-point implication for the actual unbounded comparison; named zero-dividend specialization |
| [`Boundary/ParabolicHopf.lean`](AmericanConvexity/Boundary/ParabolicHopf.lean) | Terminal-time positive right derivative proved using an explicit exponential barrier and weak comparison |
| [`Boundary/MovingLine.lean`](AmericanConvexity/Boundary/MovingLine.lean) | Exact spatial translations and time chain rule; moving-line coordinates subtract the line speed from the drift |
| [`Boundary/ComparisonHopf.lean`](AmericanConvexity/Boundary/ComparisonHopf.lean) | Actual moving-coordinate PDE and one-sided contact fit; contradiction for a positive backward rectangle, including zero dividends |
| [`Boundary/TangentGeometry.lean`](AmericanConvexity/Boundary/TangentGeometry.lean) | Negative curvature puts a smooth function strictly below its tangent nearby |
| [`Boundary/TangentIntercept.lean`](AmericanConvexity/Boundary/TangentIntercept.lean) | Generic negative-intercept selection and global curvature reduction; its ratio-limit premise is now discharged for the pricing solution |
| [`Boundary/Tangency.lean`](AmericanConvexity/Boundary/Tangency.lean) | Positive rectangle construction and exclusion of concave tangency, conditional on the interval invariant |
| [`Boundary/ComparisonAssembly.lean`](AmericanConvexity/Boundary/ComparisonAssembly.lean) | Log-curvature implication conditional only on the interval invariant; strict stock curvature also requires strict speed; zero-dividend specialization |
| [`Boundary/SmoothValley.lean`](AmericanConvexity/Boundary/SmoothValley.lean) | Smooth approximations to the positive part and minimum; strict monotonicity, derivatives, and error bounds |
| [`Boundary/OrderedTriples.lean`](AmericanConvexity/Boundary/OrderedTriples.lean) | Compact ordered equal-time triples in a moving strip |
| [`Boundary/ParabolicValley.lean`](AmericanConvexity/Boundary/ParabolicValley.lean) | Direct three-point maximum principle, including terminal-time maxima |
| [`Boundary/ParabolicUnimodality.lean`](AmericanConvexity/Boundary/ParabolicUnimodality.lean) | Removal of smoothing and time perturbations; propagated three-point inequality |
| [`Boundary/ComparisonUnimodality.lean`](AmericanConvexity/Boundary/ComparisonUnimodality.lean) | Actual comparison superlevels are intervals; no Sturm or initial derivative-trace premise |
| [`Boundary/ComparisonConclusion.lean`](AmericanConvexity/Boundary/ComparisonConclusion.lean) | Weak normalized log curvature from the classical contract alone; zero-dividend and Liu-range milestones; strict stock curvature with strict speed |
| [`Boundary/PositiveBump.lean`](AmericanConvexity/Boundary/PositiveBump.lean) | Explicit polynomial-times-exponential subsolution for bounded drift |
| [`Boundary/PositivePropagation.lean`](AmericanConvexity/Boundary/PositivePropagation.lean) | Positive bottom patches stay positive inside a rectangle or moving straight tube |
| [`Boundary/StrongPositivity.lean`](AmericanConvexity/Boundary/StrongPositivity.lean) | One positive point propagates to every later interior point of a half-line |
| [`Boundary/FlatTail.lean`](AmericanConvexity/Boundary/FlatTail.lean) | Proved weak curvature and monotonicity turn zero speed into a flat tail |
| [`Boundary/TimeIncrement.lean`](AmericanConvexity/Boundary/TimeIncrement.lean) | Actual time-increment PDE, positive-profile normalization, bounded drift, and nonnegativity |
| [`Boundary/IncrementPositivity.lean`](AmericanConvexity/Boundary/IncrementPositivity.lean) | Strict increment positivity above strike and on hypothetical flat tails; shared-boundary smooth fit |
| [`Boundary/StrictBoundarySpeed.lean`](AmericanConvexity/Boundary/StrictBoundarySpeed.lean) | No flat tail by slanted Hopf rectangle; globally strictly negative boundary speed |
| [`Boundary/StockConclusion.lean`](AmericanConvexity/Boundary/StockConclusion.lean) | Strict stock curvature with no extra speed premise; both time conventions; zero-dividend and Liu-range specializations; combined derivative conclusions |
| [`Boundary/InitialRoots.lean`](AmericanConvexity/Boundary/InitialRoots.lean) | Exactly two simple initial roots below a higher positive initial value; identification of the actual spatial derivatives |
| [`Boundary/RootConfinement.lean`](AmericanConvexity/Boundary/RootConfinement.lean) | Every small-time positive-level root lies near the initial roots, using only continuity, initial data and tail bounds |
| [`Boundary/RootStability.lean`](AmericanConvexity/Boundary/RootStability.lean) | At-most-two-root initialization conditional on the still-open initial derivative traces; no-positive-data branch and zero-dividend specialization |
| [`Boundary/ZeroCountGeometry.lean`](AmericanConvexity/Boundary/ZeroCountGeometry.lean) | Spatial two-root bound plus negative endpoint data implies interval superlevels; positive-level to zero-level passage |
| [`Boundary/ComparisonIntervals.lean`](AmericanConvexity/Boundary/ComparisonIntervals.lean) | Actual comparison's interval consequence conditional on root counts, with boundary/truncation hypotheses discharged and a zero-dividend specialization |
| [`Boundary/ExerciseGeometry.lean`](AmericanConvexity/Boundary/ExerciseGeometry.lean) | Ordinary spatial derivative at contact, strictly negative boundary, positive boundary forcing, and classical supersolution property off the boundary |
| [`Boundary/OneSidedContact.lean`](AmericanConvexity/Boundary/OneSidedContact.lean) | One-sided stationary second-derivative test and spatial test-function bounds at exercise contact |
| [`Boundary/BoundaryTest.lean`](AmericanConvexity/Boundary/BoundaryTest.lean) | Differentiation along the moving boundary; cancellation by smooth fit; exclusion of subsolution contact maxima |
| [`Boundary/ObstacleComparison.lean`](AmericanConvexity/Boundary/ObstacleComparison.lean) | Proved obstacle comparison, requiring only local smoothness at potential positive contacts; includes zero dividends and strips collapsing at expiry |
| [`Boundary/ExpiryBarrier.lean`](AmericanConvexity/Boundary/ExpiryBarrier.lean) | Explicit quadratic shrinking-strip barrier: derivatives, pricing inequality, relative expiry continuity, lateral bounds and actual price comparison |
| [`Boundary/NearExpiry.lean`](AmericanConvexity/Boundary/NearExpiry.lean) | Non-sharp square-root boundary bound and `b(t)/t -> -infinity` from the pricing contract, including zero dividends |
| [`Boundary/DelayedPrice.lean`](AmericanConvexity/Boundary/DelayedPrice.lean) | Clamped time delay, continuation at points above payoff, and the delayed pricing equation |
| [`Boundary/LocalizationBarrier.lean`](AmericanConvexity/Boundary/LocalizationBarrier.lean) | Explicit quadratic supersolution for spatial localization without uniform tail assumptions |
| [`Boundary/TimeMonotonicity.lean`](AmericanConvexity/Boundary/TimeMonotonicity.lean) | Localized delayed-price comparison, removal of the penalty, and price time-monotonicity from the contract |
| [`Boundary/BoundaryMonotonicity.lean`](AmericanConvexity/Boundary/BoundaryMonotonicity.lean) | Nonincreasing boundary, nonpositive speed, and strictly negative speed at hypothetical concave points; zero-dividend checkpoints |
| [`Boundary/Stefan.lean`](AmericanConvexity/Boundary/Stefan.lean) | Smooth-data Stefan interface and intrinsic one-sided initial derivatives; no existence theorem yet |
| [`Boundary/Profiles.lean`](AmericanConvexity/Boundary/Profiles.lean) | Explicit appendix coefficient and smooth profiles satisfying (2.3), with positive initial slope |
| [`Boundary/ProfileConcentration.lean`](AmericanConvexity/Boundary/ProfileConcentration.lean) | Exact tail integrals and both concentration limits (2.6) |
| [`Boundary/ProfileGeometry.lean`](AmericanConvexity/Boundary/ProfileGeometry.lean) | Unique profile peak and an exact strictly negative operator/slope quotient derivative |
| [`Boundary/ProfileOperator.lean`](AmericanConvexity/Boundary/ProfileOperator.lean) | All initial sign conditions (3.1), (3.2), (3.8), using a quadratic crossing lemma |
| [`Boundary/InitialProfileCheck.lean`](AmericanConvexity/Boundary/InitialProfileCheck.lean) | A concrete initial-endpoint issue in the printed assumptions/conclusion of Lemma 2.1 |
| [`Finance.lean`](AmericanConvexity/Finance.lean) | Applications of MathFin's American-put payoff bound, European-price bound, and Snell minimality; integration examples, not new finance results |
| [`Basic.lean`](AmericanConvexity/Basic.lean) | Introductory interval-convexity, inequality, and tactic examples |
| [`AxiomAudit.lean`](AmericanConvexity/AxiomAudit.lean) | Build-enforced axiom checks for selected upstream and local results |

In particular, `deriv2_stockBoundary` proves the paper's coordinate identity:

```text
S_f''(T) = (σ⁴/4) E exp(s(t)) [s''(t) + (s'(t))²].
```

Its differentiability assumptions are explicit. The positive-curvature corollary
**assumes** positive log-boundary curvature; proving that hypothesis for the actual
exercise boundary is still the central task. These generic coordinate lemmas do
not identify an arbitrary input function with the financial exercise boundary.

The limit lemma proves only **ordinary convexity**. Strict convexity or strictly
positive second derivatives do not follow just by taking limits.

The solution definitions now specify the PDE, payoff, continuation/exercise regions,
regularity and one-sided smooth fit without assuming convexity. Lean verifies that
their contact condition translates to the usual monetary put payoff and stock-price
threshold. Existence and identification with the GBM stopping value remain open;
the threshold geometry is part of the analytic solution predicate and still needs
to be established for the financial value. [Statement review and current proof
obligations](docs/solution-contract.md).

The initial-data construction of **Lemma 3.4 is now verified**: the explicit family
satisfies (2.3), (2.6), (3.1), (3.2), and (3.8). Exact polynomial identities replace
the appendix's asymptotic sign calculations. This proves properties of the initial
profiles, not existence or curvature of their evolving boundaries.
[Detailed proof and remaining gaps](docs/appendix-proof.md).
The earlier flat-slope example also satisfies the initial-data predicate.

### 4. Source-paper audit findings

The full 13-page paper was read, with relevant equations and apparent typos checked
against rendered PDF pages. This was not a certification of every analytic step.

**Initial-endpoint issue, Lemma 2.1, p. 189.** Its printed conditions (2.3) allow

```text
q₀(x) = x³ exp(-x),  x ≥ 0.
```

Lean verifies that this profile is `C⁴`, positive for `x>0`, integrable, vanishes
at zero and infinity, and satisfies the stated compatibility condition. However,
`q₀'(0) = q₀''(0) = 0`. The Stefan relation `q₀'(0) = -k s'(0)`, for `k>0`, then
forces `s'(0)=0`, contrary to the printed strict-negativity claim on **[0,∞)**.

The auxiliary statement needs either a restriction to `t>0` or an additional
positive-initial-slope hypothesis. **This is not a counterexample to the main
convexity theorem:** condition (3.1) and the appendix's chosen profiles provide
positive initial slope. We have not formalized Stefan existence for this profile.

Other findings recorded in the audit include apparent sign/notation typos in the
proof of Lemma 3.1 and a reference to decreasing, rather than convex, approximants
in the final proof. These must be resolved mathematically, not copied into Lean.

## Verification and its limits

### MathFin's epistemic status: provisional, not fully verified

**Our confidence in MathFin is not 100%.** We have not independently verified its
full mathematical development. We treat it as a useful but provisionally trusted
dependency, not as an unquestioned foundation for our results.

**Every core MathFin result that our proofs rely on must be independently reviewed
and verified at the pinned revision**, including the underlying definitions,
assumptions, and relevant transitive proof dependencies. That review must:

- Check that the formal statement represents the intended mathematical/financial
  claim, rather than a weaker surrogate or a theorem about a different model.
- Check hypotheses for missing conditions, circularity, or vacuity, and establish
  that they actually hold in our application.
- Inspect the supporting arguments and dependency chain, reproduce the Lean build,
  and check for additional axioms or unfinished proofs.
- Record what was reviewed, the evidence, and any unresolved gaps in our audit notes;
  revisit affected results when dependency revisions change.

A successful Lean build and clean axiom audit validate the formal proof under its
stated assumptions. They do **not** establish that the definitions, assumptions,
or interpretation faithfully capture the finance problem. Our existing integration
examples and selected axiom checks are not a completed independent audit of MathFin.
Until that review is complete, claims resting on its core results remain provisional.

### Current mechanical checks

**Latest local verification: `lake build` succeeds.**

- The implemented project proofs contain no `sorry` or new project axioms.
- Axiom guards for selected results permit only Lean's standard `propext`,
  `Classical.choice`, and `Quot.sound`.
- Project warnings are errors; unfinished `sorry` proofs fail the build.
- Undeclared implicit variables are disabled with `autoImplicit = false`.
- The GitHub Actions workflow is configured, but local success is not a claim
  that hosted CI has run.

Building checks our modules and their imported dependencies, **not every theorem
in MathFin**. Axiom checks establish proof dependencies, not whether a statement
faithfully captures the intended financial question. There is no placeholder
assertion claiming the main theorem is complete.

## Remaining work

For the active straight-line proof, see the dependency list in
[`docs/comparison-proof.md`](docs/comparison-proof.md). Weak normalized log
curvature, the interval invariant, and the tangency contradiction are proved.
The direct three-point argument bypasses the unfinished zero-number route.
Strict stock curvature is also proved with no extra strictness premise.
Actual stopping-value identification remains open. The proved weaker parameter cases are tracked
separately from independent verification of the published proofs.
The financial value and its in-the-money contact threshold are now constructed;
their checked properties and precise remaining PDE/filtration gaps are in
[`docs/stopping-value.md`](docs/stopping-value.md).

The detailed dependency map is in [`docs/ccjz-audit.md`](docs/ccjz-audit.md).
Following the supplied paper requires:

1. **Existence and financial interpretation.** The normalized obstacle and
   smooth-data Stefan predicates are implemented. Prove existence/uniqueness,
   establish the additional corner regularity needed downstream, and identify the
   solution with the GBM optimal-stopping value so the assumptions are not vacuous.
2. **Approximation theory.** The initial-data construction is checked. Establish
   Stefan well-posedness, recover the obstacle prices, and prove
   convergence of the exercise boundaries—not merely convergence of prices.
3. **Curvature of approximating boundaries.** Develop the parabolic zero-number,
   maximum-principle and Hopf-lemma arguments supporting Lemmas 3.1–3.3, including
   the quotient `φ=q_t/q_x` and its boundary condition.
4. **Limit and strictness.** Apply the checked weak-convexity limit lemma, then
   justify derivative convergence and the strong-maximum-principle step yielding
   `s''>0`. Finish with the checked coordinate transformation.

Searches did not locate the necessary Stefan/parabolic theory in our pinned
dependencies. This is substantial remaining infrastructure, not a short missing
tactic proof. We must not hide it in assumptions equivalent to the desired result.

Expiry also needs care: the option value equals the payoff at **every** stock
price at maturity. The terminal threshold `S_f(T_F)=E` therefore needs the proper
in-the-money/left-limit convention, not the supremum of the entire terminal
coincidence set.

## Build and edit

On this machine, open the project folder in Cursor:

```sh
open -a Cursor .
```

For the theorem work, start with `AmericanConvexity/Boundary/Problem.lean`,
`AmericanConvexity/Boundary/Profiles.lean`, and `docs/solution-contract.md`.
`docs/ccjz-audit.md` maps the paper's dependencies. `Finance.lean` demonstrates upstream usage; `Basic.lean`
provides introductory tactic examples.

From the project root:

```sh
# Needed only if the current terminal predates the elan installation:
source "$HOME/.elan/env"

lake exe cache get   # Restore Mathlib's precompiled artifacts if needed
lake build          # Check the project and axiom guards

# Check one saved source file:
lake env lean -DwarningAsError=true AmericanConvexity/Boundary/Coordinates.lean
```

In Cursor, **Cmd+Shift+B** builds the project. **Tasks: Run Task** also provides
single-file checking and cache download. The Lean InfoView shows the proof state
at the cursor; use **Lean 4: InfoView: Toggle InfoView** if it is hidden. Reload
the window after a toolchain change if necessary.

Unicode input includes `\R` → `ℝ`, `\in` → `∈`, and `\le` → `≤` (Tab if needed).
Use `#check` to inspect theorem types, `#print` to inspect definitions, and
`#print axioms` to inspect proof dependencies.

When adding a module, keep project declarations in the `AmericanConvexity`
namespace (or a subnamespace), import the module in `AmericanConvexity.lean`,
and run `lake build`. Prefer specific MathFin imports over its entire umbrella.

## Reproducible dependencies

| Component | Pin |
| --- | --- |
| Lean | `leanprover/lean4:v4.32.0` |
| MathFin | `784a8311f75a1519a23717856df9982bd6a9a370` |
| Mathlib | `81a5d257c8e410db227a6665ed08f64fea08e997` |
| BrownianMotion, transitive | `4d52fa776130a29d4ad7d6eda2035a919c0b4696` |

`lean-toolchain` selects Lean, `lakefile.toml` declares dependencies, and
`lake-manifest.json` locks all dependency commits. Keep all three in version
control. Downloaded sources and build artifacts in `.lake/` are ignored; do not
edit that directory as the source of record.

On another machine, install [elan](https://github.com/leanprover/elan), clone this
project, then run `lake exe cache get` and `lake build`. Elan downloads the pinned
Lean version automatically. Install the recommended Lean editor extension.
No Docker or MathFin-specific Python authoring pipeline is required.

For upgrades, choose a MathFin commit, align our Lean and explicit Mathlib pins
with that commit, then run `lake update`, `lake exe cache get`, and `lake build`.
Check transitive revisions against its manifest. Do not upgrade Lean or Mathlib
independently of MathFin.

## Further reading

- [Detailed paper audit and formalization plan](docs/ccjz-audit.md)
- [MathFin integration notes](docs/upstream.md)
- [Mathematics in Lean](https://leanprover-community.github.io/mathematics_in_lean/)
- [Theorem Proving in Lean 4](https://lean-lang.org/theorem_proving_in_lean4/)
- [Mathlib API documentation](https://leanprover-community.github.io/mathlib4_docs/)
- [Lean community / Zulip](https://leanprover.zulipchat.com/)
