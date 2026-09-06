# Building on formal-mathfin

## Current final-theorem audit

The [declaration-level dependency audit](dependency-audit.md) and its
[machine-readable report](audits/final-proof-dependencies.json) now identify
the actual proof dependencies of the final curvature results and the spatial
interval invariant. A fresh empty-kernel replay passed for 74,785 declarations,
including 498 declared in MathFin modules and 750 in BrownianMotion modules.
The three standard axioms are the only axioms; negative controls reject a
missing declaration, `sorryAx`, and a false proof term. This is more specific
than the historical import descriptions below. It is not an independent
kernel implementation or a review of every theorem in either repository.

## Use a downstream Lake package

Our project depends on MathFin via Git; our source stays in `AmericanPutConvexity/`.
Lake fetches upstream sources into `.lake/packages/MathFin/` and builds the imported
modules. We reuse upstream definitions directly, so our theorems are about the
same mathematical objects rather than look-alike definitions in a copied library.

```lean
import MathFin.Binomial.American

namespace AmericanPutConvexity

example {u d r : ℝ} (h : MathFin.BinomialNoArb u d r)
    (g : ℝ → ℝ) (n : ℕ) (S : ℝ) :
    MathFin.binomialPrice u d r g n S ≤ MathFin.americanPrice u d r g n S := by
  exact MathFin.binomialPrice_le_americanPrice h g n S

end AmericanPutConvexity
```

`AmericanPutConvexity/Finance.lean` contains build-checked applications, not claims of
new mathematical contributions. Add new theorems in our namespace, importing them
from `AmericanPutConvexity.lean` so `lake build` checks them.

No Docker, Python pipeline, Git submodule, or upstream contributor tooling is
required for this downstream workflow. If we later need to change upstream code,
we can make a separate fork/checkout and contribute a PR; never edit the disposable
copy in `.lake/packages/` as our source of record.

## Exact compatibility pins

| Component | Pin |
| --- | --- |
| MathFin | `784a8311f75a1519a23717856df9982bd6a9a370` |
| Lean | `leanprover/lean4:v4.32.0` |
| Mathlib | `81a5d257c8e410db227a6665ed08f64fea08e997` |
| BrownianMotion (transitive) | `4d52fa776130a29d4ad7d6eda2035a919c0b4696` |

MathFin is pinned to the inspected upstream HEAD, not a moving branch. All 14
transitive package revisions were compared with its committed `lake-manifest.json`
and match. Our explicit Mathlib requirement is last, following upstream's
resolution convention. Lean 4.33.1 remains installed, but this directory uses
4.32.0 automatically; do not force the newer toolchain for this project.

`lake exe cache get` restores Mathlib artifacts. `lake build` builds our library
and the MathFin modules it actually imports. This is **not** a claim that we have
locally built or audited every theorem in the entire upstream repository.

## Useful entry points and their scope

Links below are pinned to the version we consume.

- [`MathFin.Binomial.Model`](https://github.com/formal-applied-math/formal-mathfin/blob/784a8311f75a1519a23717856df9982bd6a9a370/MathFin/Binomial/Model.lean):
  `BinomialNoArb`, risk-neutral up-probability, European backward pricing, replication.
- [`MathFin.Binomial.American`](https://github.com/formal-applied-math/formal-mathfin/blob/784a8311f75a1519a23717856df9982bd6a9a370/MathFin/Binomial/American.lean):
  `americanPrice`, its Bellman recursion, immediate-exercise bound, European-price bound.
- [`MathFin.Binomial.SnellEnvelope`](https://github.com/formal-applied-math/formal-mathfin/blob/784a8311f75a1519a23717856df9982bd6a9a370/MathFin/Binomial/SnellEnvelope.lean):
  minimal dominating supermartingale, scalar and coin-flip path-space versions.
- [`MathFin.BlackScholes.SpotConvexity`](https://github.com/formal-applied-math/formal-mathfin/blob/784a8311f75a1519a23717856df9982bd6a9a370/MathFin/BlackScholes/SpotConvexity.lean):
  European call payoff/price convexity in spot. Not imported or built by our current examples.

Important distinctions before choosing our first theorem:

1. **Convexity of price in spot is not convexity of the exercise boundary in time.**
   A proof of the former does not establish the latter.
2. The current American model is a **finite-step binomial recursion**. It is not
   already a continuous-time optimal-stopping/free-boundary formulation.
3. The Snell module explicitly lists identification with the supremum over stopping
   times as downstream work; its proved path-space characterization alone should
   not be described as having completed that identification.
4. `BinomialNoArb u d r` means `0 < d` and `d < exp r < u`; `r` is the per-step
   continuously compounded rate. `crrUpProb` is a probability, **not a dividend yield**.
   Adding dividends requires checking/modifying the model, not just renaming a parameter.

The exact theorem statements and assumptions are authoritative, not README labels.
`AmericanPutConvexity/AxiomAudit.lean` guards the three upstream facts used by our
examples against extra axioms or `sorryAx`; their allowed axioms are `propext`,
`Classical.choice`, and `Quot.sound`. This checks proof dependencies, not whether a
statement faithfully represents the finance question we intend to ask.

## Stochastic bridge: Ito dependency

The stopping/PDE bridge now also imports
`MathFin.Foundations.ItoFormulaUnrestrictedLocMart`. The local adapter
`Stopping/PlaneIto.lean` derives its partial-derivative hypotheses from joint C3
regularity. `Stopping/LocalPriceIto.lean` applies it to compact smooth extensions
of the classical discounted price inside continuation. This is substantive
reuse of MathFin stochastic calculus, not reuse of an American pricing theorem.
The completed classical boundary-convexity proof itself remains independent of
these new stochastic modules.

Fresh or replayed builds emit upstream `sorry` warnings for unrelated declarations
in `BrownianMotion.StochasticIntegral.UniformIntegrable` (line 311),
`OptionalSampling` (line 258), and `LocalMartingale` (line 94), at the pin above.
These files are in the import graph. The build-enforced axiom guards for our
final local Ito conclusions check the transitive **proof** graph and permit
only `propext`, `Classical.choice`, and `Quot.sound`; no imported unfinished
declaration is accepted as part of those conclusions. Importing a file and
depending on every theorem in it are different claims.

`Stopping/ContactMartingale.lean` now also uses the upstream proved martingale
stopping-stability chain (`isStable_martingale`, continuous-time martingale
optional sampling, and martingale uniform integrability). Its submartingale
counterparts are the unfinished declarations noted above and are not used.
The contact-martingale and final conditional curvature guards also permit only
the three standard axioms. Mathlib's smooth partition-of-unity construction is
used to extend the price around compact interior regions; no global smoothness
of the price across the free boundary is assumed.

The global-upper-bound development also uses
`MathFin.Foundations.FeynmanKacHeatEquation`: its kernel differentiation and
Gaussian-law integral transfer, not merely its algebraic kernel PDE identity.
`CompactHeatFlow.lean` proves the actual heat-flow derivative equation after
scaling arbitrary compact data to the upstream exponential-growth hypothesis.
Mathlib's parameter-dependent convolution supplies joint regularity.
`LinearPriceComparison.lean` then combines this with our obstacle comparison.
Mathlib's support-preserving smooth approximation supplies the approximants in
`SmoothMinorants.lean`; the local construction makes them compact minorants with
a uniform bound. Dominated convergence in `ClassicalHeatComparison.lean` then
extends the inequality to the continuous price slice. Both final guarded proof
chains use only the three standard axioms.

`IndependentKernel.lean` proves the conditional-expectation step from Mathlib's
independent product laws, Fubini, and uniqueness of conditional expectation.
`BrownianTransition.lean` uses the constructed Brownian increment law and its
independence from the raw past, with Mathlib's Gaussian scaling theorem.
`ClassicalTransition.lean` checks the physical normalization;
`ClassicalSupermartingale.lean` then proves global supermartingality, price
identification and the actual boundary curvature conclusions. These final
proof chains, including the zero-dividend and Liu-range specializations, have
guarded audits allowing only the three standard axioms. Classical-solution
existence remains unproved. The raw/usual-filtration comparison is now checked
in `UsualBrownianValue.lean`.

`FiltrationExtension.lean` uses MathFin's proved `condExp_sup_nulls` to transfer
supermartingality under ambient-null augmentation. Its right-continuation
argument uses bounded dominated convergence on past-measurable sets, not an
upstream unfinished submartingale optional-sampling result. `CompletedSpace.lean`
uses Mathlib's actual measure completion and integral-trimming theorem to move
to the complete ambient space. The completed filtration in `UsualBrownianValue.lean`
has proved `IsComplete` and `IsRightContinuous` instances. Its value equality
and final boundary conclusions are guarded against any nonstandard axiom.

`MaturityTruncation.lean` and `MaturityContinuity.lean` use Mathlib's dominated
convergence and order properties of the real supremum to prove maturity
continuity directly from admissible stopping rules. `JointPriceContinuity.lean`
uses `ConvexOn.lipschitzOnWith_of_abs_le` to obtain a spot bound uniform in
maturity. The resulting normalized `canonicalPrice` has checked joint continuity,
initial payoff and bounds without assuming a classical PDE solution. These new
proof chains also have guarded audits allowing only the three standard axioms.

`SpotDecay.lean` uses the compact minimum theorem for the positive stock
multiplier along each continuous path, then bounded dominated convergence for
varying stopping rules. Nearly optimal rules transfer the limit to the actual
supremum. No maximal inequality, optimal stopping existence theorem, or PDE
solution is assumed. The general decay result and its normalized fixed-time and
uniform finite-maturity versions have guarded three-standard-axiom audits.

`PricePositivity.lean` uses the constructed Brownian terminal Gaussian law,
Mathlib's theorem that Lebesgue measure is absolutely continuous with respect
to a nondegenerate Gaussian measure, and positivity of the integral of a continuous
nonnegative function nonzero somewhere. Measure-completion integral transfer
handles the usual filtration without using conditional classical verification.
`StrictExerciseGeometry.lean` combines this with the already proved contact-set
interval and price continuity. The price-positivity and final continuation-domain
proof chains have guarded audits allowing only the three standard axioms.

`BoundarySemicontinuity.lean` derives threshold semicontinuity directly from
the local contact-set and maturity-continuity results, using Mathlib's filter
definitions. `ActualContact.lean` reuses the proved local continuous-adapted
first-zero construction (`FirstContact.lean`), now instantiated with the actual
stopping price rather than a postulated classical pair. It checks the normalized
path against MathFin's `gbmValue` definition. Neither module imports an optimality
or dynamic-programming axiom; the new stopping-rule and geometry proof chains
have guarded three-standard-axiom audits.

`FiniteExerciseGrid.lean` extends the local grid-rounding work with capping at
maturity, using Mathlib's floor/ceiling order identities to prove stopping-time
admissibility. Dominated convergence handles payoff limits. `BermudanConvergence.lean`
uses real-supremum order properties and nearly optimal rules to prove convergence
of finite-grid values in the original process and filtration. MathFin's binomial
Snell/Bermudan modules are not used for this result: their tree dynamics and
recursions are not an identification with these Brownian stopping suprema.
The final grid-convergence chains have guarded three-standard-axiom audits.

`FiniteBellman.lean` and its optimality modules use Mathlib's actual conditional
expectation, discrete hitting times, and discrete optional stopping. They prove
the general finite-horizon Snell/Bellman theorem locally, including supremum
identification and attainment. No MathFin binomial Snell theorem is substituted
for an arbitrary-filtration theorem. `DiscreteContactMartingale.lean` explicitly
derives the stopped martingale from conditional-expectation indicator identities.
All final finite Bellman and optimality chains have guarded three-standard-axiom
audits. The physical-grid reindexing and a separate continuous-time first-contact
optimality argument are now proved below.

`GridReindexing.lean` proves stopping-time admissibility in both directions using
the actual capped sampled filtration and floor/ceiling identities, and proves
equality of payoff ranges. `GridBellman.lean` applies the local general Bellman
optimality theorem to the original discounted put reward. Its explicit physical
grid rules attain the grid supremum and their expected payoffs converge to the
American value, including on the completed usual Brownian model. The final
identification, attainment and convergence proofs have guarded audits allowing
only the three standard axioms; they do not assume a PDE solution or continuous
optimal-stopping theorem.

`BrownianBellman.lean` identifies conditional Bellman values with deterministic
Gaussian integration using the previously checked raw increment transition.
`BrownianUsualTransition.lean` lifts the explicit bounded continuous terminal-value
martingale through completion, null augmentation and right continuation, applying
the supermartingale extension to both signs. This proves the corresponding
usual-filtration Gaussian transition. `UsualGridMarkov.lean` identifies the raw
and usual grid prices with the same recursion, proves convergence to the
canonical price, and removes the classical-solution premise from positive-spot
raw/usual American-value equality. All final new chains have guarded audits
allowing only the three standard axioms. No continuous-time dynamic-programming
or PDE-existence theorem is imported or assumed by this development.

`SampledRules.lean` proves stopping-time admissibility on increasing deterministic
schedules directly from a countable union of stopping events. `DelayedGrid.lean`
uses local finite Bellman attainment for schedules starting after a fixed wait.
`AmericanWaiting.lean` uses bounded dominated convergence to derive the actual
American waiting inequality. The resulting `ActualSupermartingale.lean` proofs
combine this inequality with the proved Brownian conditional transition, then
lift through completion and usual augmentation. Guarded audits of the waiting
inequality and both final supermartingales allow only the three standard axioms.
No classical-price verification or continuous-time optimal-stopping theorem is
used to establish this actual-price supermartingale property.

`OrderedSampling.lean` derives two-rule bounded continuous optional sampling
from Mathlib's discrete result and dominated convergence. `VanishingGap.lean`
uses Mathlib's L1-to-convergence-in-measure theorem and its almost-sure
subsequence theorem, plus compact minimum attainment for the pathwise argument.
`FirstContactOptimality.lean` assembles these into a general expected-value
preservation/optimality theorem. `ActualOptimality.lean` applies it to the
actual usual-filtration price and the already verified optimal-grid rules,
with no classical or continuous-optimality premise. The final actual contact
optimality theorem and its key supporting chains have guarded three-standard-axiom
audits. No unfinished upstream continuous submartingale sampling theorem is used.

`OptimalStoppedMartingale.lean` derives stopped martingality from expected-value
preservation using only the checked ordered optional-sampling result, explicit
two-time event-pasted rules, continuous stopped adaptation, integral splitting,
and uniqueness of conditional expectation. `ActualContactMartingale.lean` checks
expected-price preservation from actual payoff optimality, obtains the actual
usual-filtration stopped martingale, and applies bounded optional sampling for
the stopped mean-value identity. Guarded audits of the generic and actual final
chains allow only the three standard axioms. No PDE solution, strong Markov
theorem at random times, or unfinished upstream optional-sampling result is used
for these identities.

`RectangleExit.lean` constructs bounded exits from continuous adapted paths using
the checked first-contact machinery. `ContinuationRectangles.lean` supplies
interior rectangles by openness. `ActualLocalMeanValue.lean` proves their exits
precede actual contact and specializes the stopped mean-value identity to an
exact local exit representation. Guarded audits of rectangle existence, actual
exit geometry, contact ordering and the final identity admit only the three
standard axioms. This adds no PDE regularity or random-time restart assumption.

`PlaneDynkin.lean` reuses MathFin's checked continuous drift primitive and raw
adapted residual, plus the existing plane Itô adapter. Continuous modifications
are proved indistinguishable before stopping. Our local-martingale transfer and
bounded promotion prove the stopped Dynkin identity, with separate integrability
checks and derived compact-test bounds. `ActualTestFunctions.lean` combines it
with actual-price rectangle mean value via the checked completion integral
transfer. Guarded audits cover the generic residual, stopped martingale, compact
Dynkin identity and both final deterministic-patch test inequalities; they admit
only `propext`, `Classical.choice` and `Quot.sound`. The imported unfinished
continuous submartingale sampling results are not used in these proof chains.

`StrictDrift.lean` uses nonzero-measure strict integral positivity, continuity
and the already checked stopped-drift integrability. `PointwiseTests.lean`
combines this with small-rectangle geometry and smooth bump localization.
`PricingTests.lean` reuses the checked time/space chain-rule calculations from
`CandidatePDE.lean`, but supplies smoothness of the test rather than a classical
option solution. Guarded audits of both final normalized pricing-test chains,
their coordinate identity and their key stochastic/geometry supports allow only
the three standard axioms. No interior-regularity theorem is assumed or imported
as a premise of the actual-price test conditions.

`SmoothPricingComparison.lean` derives comparison directly from the smooth-test
predicate using compact maximum attainment, a localized reciprocal-time barrier,
and continuity on the closure. It uses the checked compact smooth extension
around an interior singleton; no boundary smoothness or terminal test is presumed.
`ActualSmoothComparison.lean` discharges the actual and negative-price test
predicates from `PricingTests.lean`, then obtains both comparisons and local
identification. Guarded audits cover the barrier algebra, generic comparison,
actual predicates and final identification; they permit only the three standard
axioms. Local Dirichlet-solution existence is constructed in the later
`PricingDirichlet.lean` development, not imported or hidden in a hypothesis
asserting regularity of the actual price.

`ContinuousHeatSmoothing.lean` applies Mathlib's all-order parameter-convolution
regularity theorem with a smooth compact cutoff on the Gaussian kernel and only
continuous (hence locally integrable) reflected initial data. The kernel and
initial datum are not confused: no derivative of the datum is used. The existing
MathFin kernel-side PDE identity, checked Brownian initial trace, and drift/discount
chain rule then prove the explicit initial-data pricing solution. Guarded audits
cover the smoothing theorem, generalized PDE, smooth evolution and both constructed
existence results in `ContinuousPriceEvolution.lean`; only the three standard
axioms occur. No lateral-boundary solution or full Dirichlet existence theorem
has been imported or assumed by this construction.

`HeatBoundaryKernel.lean` derives its kernel derivatives from MathFin's public
total derivative of `heatKernel`. Mathlib's real-power change of variables and
half-Gaussian integral prove the temporal unit mass; the parabolic scaling
identity is checked algebraically. `HeatBoundaryExtension.lean` uses this fixed
integrable density and Mathlib's dominated-convergence continuity theorem for
bounded continuous data. Guarded audits cover the kernel PDE, normalization,
integrability, scaling, extension continuity, joint trace, causality, bound and
elapsed-time representation. Only the three standard axioms occur. No theorem
asserting regularity of the actual price is assumed.

`FlatHeatKernel.lean` now proves the causal kernel's all-order smoothness using
Mathlib's polynomial-times-flat-exponential and real-power smoothness results.
The extension by zero at elapsed time zero is checked explicitly.
`HeatBoundarySmoothing.lean` uses the parameter-convolution theorem with compact
kernel cutoff and continuous data. `CompactKernelDerivative.lean` supplies the
local domination hypotheses of Mathlib's differentiation-under-the-integral
theorem from compactness and joint continuity of kernel derivatives.
`HeatBoundaryEquation.lean` then proves the boundary integral's PDE and assembles
a constructed half-line heat solution. Guarded audits cover these steps and
the final existence theorem, with only the three standard axioms. Actual-price
regularity is not imported or assumed by this construction.

`HeatBoundaryContraction.lean` uses the proved unit-mass kernel and strictly
positive tail integral to obtain a strict finite-time propagation bound. It
proves completeness of the causal bounded-continuous function space via
closedness. `CoupledHeatBoundary.lean` applies Mathlib's contraction fixed-point
theorem on the product of that space; no boundary-input existence premise is
introduced. `IntervalHeatBoundary.lean` constructs the time cutoff, proves the
reflected PDE and assembles the interval correction. Guarded audits cover the
strict mass estimate, operator bound, fixed-point equations, compactness,
reflection, and both interval existence results. All selected chains use only
`propext`, `Classical.choice`, and `Quot.sound`. Pricing-coordinate assembly and
actual-price interior regularity are now proved in the following development.

`HeatPricingTransform.lean` proves the fixed-endpoint exponential gauge and
time-rescaling identity using checked derivative rules and the local product
second-derivative lemma. `PricingBoundaryCorrection.lean` rescales the continuous
boundary data, applies the constructed interval heat solution and transforms
back. `PricingDirichlet.lean` joins this correction to the existing initial-data
evolution; continuous residual data extended with `max(a,t)` ensure corner
compatibility without assuming boundary-data derivatives.
`ActualInteriorRegularity.lean` uses openness of actual continuation to choose
a local cylinder, constructs its Dirichlet solution, and applies the existing
actual-price comparison theorem. Local equality transfers all-order smoothness
and the pricing PDE to the actual stopping value. No external interior-regularity
or classical-existence theorem is used. Guarded audits of the transformation,
existence, identification, smoothness and final PDE chains allow only the three
standard axioms. Smooth fit and free-boundary regularity remain open.

`UpperSupportComparison.lean` uses the newly established actual interior PDE
and the checked spatial/one-sided temporal maximum lemmas. It permits comparators
with locally smooth upper supports, rather than importing a nonsmooth comparison
theorem. `StationaryPutCap.lean` constructs an elementary payoff-matching
exponential supersolution and checks its supports, including the join.
`PositiveExerciseBoundary.lean` combines this with the actual strike bound and
uniform large-spot decay to prove the global upper bound and uniformly positive
exercise threshold. It constructs the actual logarithmic boundary and proves
value matching and exact continuation geometry. Guarded audits of comparison,
barrier, parameter existence, positivity and logarithmic-boundary conclusions
permit only `propext`, `Classical.choice` and `Quot.sound`. No perpetual-price,
smooth-fit, or boundary-regularity theorem is imported or assumed.

`ContinuationSlice.lean` derives actual-price maturity monotonicity from the
stopping supremum and uses Mathlib's derivative sign lemma for monotone functions.
The already checked actual PDE then gives an elliptic forcing inequality for
the intrinsic premium. A local quadratic maximum argument uses compact maximum
attainment and the project's proved second-derivative maximum lemma; no
elliptic regularity theorem is imported. Continuity of only the two endpoint
price values excludes an instantaneous interval of continuation.
`ActualBoundaryContinuity.lean` combines this with positive threshold, exact
contact geometry and monotonicity to exclude downward jumps, then uses the
existing upper semicontinuity to prove full continuity, including expiry.
Composition with the logarithm uses its proved positive argument. Guarded audits
cover forcing, the maximum lemma, no-jump result and final stock/log continuity,
with only `propext`, `Classical.choice` and `Quot.sound`. Smooth fit and boundary
differentiability are neither assumed nor established in this chain.

`BrownianGerm.lean` explicitly uses the pinned BrownianMotion package's proved
`IsBrownianReal.indep_zero` (Blumenthal zero-one law), now covered by a guarded
transitive axiom audit. Mathlib's Gaussian scaling theorem gives the identical
standard-normal laws of normalized near-zero probes. Tail-event measurability
uses the definition of the natural filtration and the decreasing probe times.
Bounded convergence applied to a continuous negative-side test rules out a
zero-probability negative germ event. No independence of the probes is assumed.
Elementary scaling supplies arbitrarily early excursions for arbitrary drift
and positive volatility. `ContactTimeBoundary.lean` combines these with actual
boundary monotonicity and pre-contact continuation, proving almost-sure
convergence of optimal contact times to zero at exercise under the completed
measure. The zero-one theorem and all selected new chains audit to only
`propext`, `Classical.choice` and `Quot.sound`. Smooth fit is not imported or
asserted by this construction.

`PayoffSlope.lean` proves the global log-payoff Lipschitz bound and uses only
elementary derivative/limit rules to identify the short-time quotient limit.
`StoppedSlopeExpectation.lean` checks the GBM normalization against MathFin's
definition and applies Mathlib's filter-form dominated convergence with bound
one. Actual-rule measurability and the previously proved almost-sure contact-time
limit discharge its hypotheses. `ActualSmoothFit.lean` uses the proved
optimality theorem and the stopping supremum, then Mathlib's squeeze theorem
and derivative/slope equivalence. No smooth-fit theorem is imported or assumed.
Guarded audits of the bound, expectation limit, price comparison and final
one-sided smooth-fit theorem use only the three standard axioms. The interior
gradient trace and positive-time boundary smoothness remain separate obligations.
