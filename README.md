# AmericanConvexity

A Lean 4 project verifying a proposed straight-line comparison proof that the
logarithmic American-put exercise boundary is convex for `0 <= q <= r`, `r>0`.
The zero-dividend and Liu parameter regimes are explicit milestones, and the
independent published CCJZ proof development is retained. The project integrates
[MathFin](https://github.com/formal-applied-math/formal-mathfin); the boundary
proof modules currently use Mathlib and local results, not MathFin pricing results.

> **Status: actual log-boundary convexity and strict stock-boundary convexity
> are proved in physical units.** `PhysicalBoundaryConvexity.lean` gives these
> function-level results for the completed usual-filtration exercise threshold
> under only `K>0`, `r>0`, `sigma>0`, and `0<=q<=r`. Zero-dividend and Liu-range
> checkpoints are explicit. Exact price normalization follows from finite-grid
> Bellman rescaling and convergence, without a classical-solution premise.
>
> `canonicalLogBoundary_convexOn` proves `ConvexOn ℝ (Ioi 0)` for the boundary
> constructed from the completed usual-filtration stopping value, assuming
> only `k>0` and `0<=h<=k`. It assumes neither a classical solution nor boundary
> smoothness. Zero-dividend and Liu-range specializations are explicit.
> The actual normalized log and stock boundaries are also strictly decreasing,
> the stock boundary is strictly convex, and both boundaries are locally
> Lipschitz at positive times (`ActualStockConvexity.lean`). These function-level
> conclusions still do not assert existence of classical second derivatives.
>
> Separately, weak log-curvature and strict stock curvature are proved for the
> classical pricing contract. `DividendPutSolution k h p b` implies `b''(t)>=0`,
> `b'(t)<0`, and the reconstructed stock boundary satisfies `B''(tau)>0`.
> No extra interval, speed, expiry, zero-count or derivative-trace premise remains.
> Identification with the actual Brownian American stopping value is now proved
> from this contract, on both the raw and completed usual filtrations, with no
> extra stochastic premise. Classical-solution
> existence and the independent strict-log-curvature CCJZ proof remain open.
> The actual stopping price is now proved smooth and satisfies the pricing PDE
> inside continuation, without a classical-solution premise.
> Its exercise threshold also has a proved positive lower bound, uniform over
> maturities, so the actual logarithmic boundary is now constructed.
> Both actual boundaries are continuous, including at expiry. Actual-price
> smooth fit and the continuation-side gradient trace are now proved.
> Positive-time boundary smoothness is the sole remaining field needed to
> construct the classical pricing contract for this actual pair.
> Toward that step, the actual spatial gradient is jointly continuous across
> the boundary, and the intrinsic premium has a locally uniform positive
> second-spatial-derivative lower bound on the continuation side.
> Quantitative linear-gradient and quadratic-premium separation now follow,
> yielding local bounds on boundary displacement by price/gradient increments.
> A new actual-price temporal comparison bounds every price increment by the
> at-strike short-maturity price, which also controls squared boundary displacement.
> An explicit expiry cap now gives a square-root temporal price bound and a
> local quarter-power continuity bound for the actual logarithmic boundary.
> Parabolic dilation now strengthens this away from expiry: the actual price
> is locally Lipschitz in time, and the actual log boundary has a local
> half-power continuity bound; the new convexity proof strengthens boundary
> regularity to local Lipschitz continuity. Boundary smoothness remains open.
> A further contact argument now proves that the actual price is jointly
> differentiable in space and time at every positive maturity, including the
> exercise boundary. Its time derivative at contact is zero. Joint continuity
> of that time derivative at contact is now proved. The boundary's finite one-sided
> speeds are proved negative and ordered; their equality remains open.
> Quadratic upper growth of the actual premium is now proved uniformly near
> contact. Together with Lipschitz boundary motion this bounds contact-time
> increments by `A*(delta t)^2`, and their difference quotients by `A*delta t`.
> A stationary exponential comparison now propagates that small boundary data
> to `0<=p_t(x,s)<=N*(x-b(s))`, uniformly at nearby maturities below the strike.
> This proves the joint contact trace `p_t->0`. The PDE then gives the exact
> continuation-side premium-curvature trace `u_xx->k-h*exp(b(t))>0`.
> Boundary smoothness remains open; this is not a second derivative across exercise.
> `ActualPriceC1.lean` now assembles genuine joint `ContDiffOn` regularity of
> order one for the actual price at all positive maturities. A continuous PDE
> extension of the premium curvature agrees with `u_xx` in continuation and
> has value `k-h*exp(b(t))` at contact. The gradient has this value as a proved
> right-sided derivative there (`ActualCurvatureExtension.lean`). The mixed
> derivative/flux at contact and boundary differentiability remain separate.
> `ActualTheta.lean` now proves that `theta=p_t` is smooth in continuation
> and satisfies the same pricing equation, with its proved continuous zero
> exercise values. `ActualThetaPositivity.lean` proves `theta>0` throughout
> continuation by a mean-value source and explicit parabolic propagation.
> This supplies the positive Dirichlet solution for the remaining contact-flux
> argument; the existence/continuity of `theta_x` at contact is not yet proved.
> A derivative-free quantitative Hopf barrier now gives two-sided positive
> bounds for `theta(x,t)/(x-b(t))` just to the right of exercise. Convergence
> of that ratio is not yet proved. Theta has no two-sided spatial derivative
> across contact; the remaining flux target is explicitly continuation-sided.
> A heat normal-kernel jump formula is now proved for locally Lipschitz moving
> graphs and specialized to the actual boundary, with heat/pricing time scaling
> explicit. It uses an integrably dominated moving-boundary correction to the
> flat kernel. Identification of theta with a suitable layer potential and
> regularity of its density are still needed before this gives the actual flux.
> `HeatLayerPotential.lean` now justifies differentiation under the singular
> layer integral. It proves the potential's interior derivative trace, its
> genuine one-sided derivative at contact, and flux continuity for continuously
> parameterized data with uniform bounds. The actual boundary supplies the
> required graph hypotheses, with zero-dividend and Liu checkpoints. These are
> flux results for layer potentials, not yet a representation of actual theta.
> `HeatDensityEquation.lean` now constructs the unique bounded continuous
> causal density solving the short-window heat boundary integral equation.
> Its contraction bound is proved directly from the kernel. A Lipschitz
> extension transfers the construction to the actual graph on a time window
> surrounding any positive target maturity, with zero-dividend/Liu checkpoints.
> Identifying the forcing and the represented solution with localized actual
> theta remains open; this is not yet the actual Stefan flux identity.
> Both one-sided layer derivatives are now checked. The density equation makes
> `F-V/2` have zero exterior flux and interior flux equal to the density,
> provided its forcing is twice the free term's derivative. A new bounded
> Neumann uniqueness theorem works on either side of a continuous moving graph,
> with no boundary velocity or decay assumption. Checking the candidate's PDE
> and identifying it with actual theta still remain.
> The actual theta has now been transformed to the diffusivity-1/2 heat
> equation, with heat time twice normalized pricing time. Around every positive
> contact, a compact smooth cutoff equal to one nearby is constructed with
> spatial transitions away from the graph and support after any prescribed
> earlier nonnegative heat time. The resulting source is proved continuous,
> bounded, compactly supported, causal, and zero on the exercise side. Its
> exact localized PDE is checked in continuation. The source's free heat
> potential is now constructed, with a continuous spatial derivative, uniform
> bounds, and zero initial data. Gaussian rescaling supplies the integrable
> inverse-square-root derivative bound. The forcing twice this derivative on
> the actual graph is a constructed bounded continuous causal function, and
> its density equation is solved on a window around every positive contact.
> Zero-dividend and Liu-range checkpoints are explicit. The single heat layer
> now has a proved PDE, spatial C2 regularity, and time differentiability off a
> merely continuous graph. Its original-source-time integral is identified
> with the elapsed-time layer, joining the PDE to the checked normal traces.
> Joint continuity across the graph, uniform bounds, and zero initial values
> are proved for continuous bounded causal densities. The free source
> potential's inhomogeneous heat PDE and the candidate's identification remain
> open; actual boundary flux and smoothness are not yet established.

The new actual-value proof uses the same straight-line comparator, interval
invariant, and terminal Hopf argument. It replaces the second-derivative tangent
selection with continuous first-contact and chord geometry. See
[`ActualLogConvexity.lean`](AmericanConvexity/Stopping/ActualLogConvexity.lean)
and [the derivative-free proof summary](docs/comparison-proof.md#actual-value-convexity-without-boundary-smoothness).
The subsequent [strict stock-convexity proof](AmericanConvexity/Stopping/ActualStockConvexity.lean)
excludes flat boundary tails using actual-price time increments and the terminal
Hopf barrier, then applies convex-function geometry and strict convexity of `exp`.
The [physical-unit assembly](AmericanConvexity/Stopping/PhysicalBoundaryConvexity.lean)
identifies the actual price and contact threshold after rescaling strike and time,
then transfers log convexity, strict stock convexity, strict decrease and local
Lipschitz continuity. The literal classical second-derivative statements are
not claimed complete by these convex-function theorems.

## Proposed extension and published checkpoints

The active target is `b''(t)>=0` for `t>0`, where
`b(t)=log(B(t/a)/K)`, `a=sigma^2/2`, and `0<=q<=r`, `r>0`, `sigma>0`, `K>0`.
The proposed proof and its exact verification frontier are tracked in
[`docs/comparison-proof.md`](docs/comparison-proof.md).

The actual continuous-time stopping value is now defined on a constructed
Brownian probability space. Payoff bounds, expiry payoff, maturity monotonicity,
spot convexity, joint spot/maturity continuity at positive spot (including expiry),
and the in-the-money contact threshold are checked
directly from that definition. Price identification now identifies the boundary
and transfers weak log curvature and strict stock curvature to that threshold,
conditional only on the classical solution contract and parameter assumptions.
The new normalized actual-value convexity theorem bypasses that contract;
the older differential and physical-unit transfers remain conditional on it.
See [`docs/stopping-value.md`](docs/stopping-value.md) for the exact filtration,
terminal-boundary convention, and remaining obligations.

Bounded continuous-path optional stopping is now proved by grid approximation
from the discrete theorem, and a verification principle connects dominating
supermartingales and contact martingales to the actual American supremum.
The exact discounted classical-price candidate has checked continuity,
adaptation, boundedness, and payoff domination. Its first-contact stopping rule
is now constructed, with proved contact and pre-contact continuation. Its
contact-martingale property is now derived from the PDE. The global
supermartingale property is also proved, completing identification from the contract.

The stochastic bridge now proves the exact Brownian-coordinate heat equation
inside continuation and constructs compact C3 localizations with zero drift
near each interior point. MathFin's Ito theorem supplies their compensated
local martingales on the explicitly null-augmented filtration. Assembly up to
first contact, promotion to a true martingale, and transfer to the raw
filtration are now proved. A separate Gaussian-comparison argument proves global
supermartingality without applying Ito across the exercise boundary.

Explicit interior stopping rules now converge pathwise to first contact. Before
each rule, the price/payoff gap and remaining maturity are bounded away from
zero, and the Brownian coordinate is bounded. A checked bounded-martingale limit
then transfers interior martingality to first contact. Compact-region smooth
extensions and a countable-dense-time argument make the Ito representation valid
simultaneously at random stopped times. Stopping stability and bounded promotion
complete `brownianClassicalContactRule_martingale`, without an additional
martingale premise. This also proves that the classical price is the expected
payoff of this admissible rule, hence is no greater than the actual American value.

For the opposite bound, arbitrary-start obstacle comparison is now
proved on the whole spatial line. The Brownian heat evolution of every smooth,
compactly supported test payoff below an initial price slice stays below the
classical price. Uniformly bounded smooth compact minorants and dominated
convergence now extend this inequality to the actual continuous price slice.
The independent-increment conditional-expectation argument and physical-time
normalization now give global supermartingality, including the process frozen
at maturity. `ClassicalSupermartingale.lean` identifies the classical price with
the stopping supremum and proves both curvature conclusions for the actual
boundary. Zero-dividend and Liu-range financial specializations are explicit.
`UsualBrownianValue.lean` now proves equality with the completed usual-filtration
American value and transfers both boundary-curvature conclusions to it. Its
filtration has checked completeness and right-continuity. Existence of the
classical pair is still not asserted.

`CanonicalPrice.lean` now defines a concrete normalized candidate directly from
the usual-filtration stopping supremum, using strike one and volatility `sqrt(2)`.
Its joint continuity, initial payoff, payoff/strike bounds and large-spot decay are proved without
a classical-solution premise. Maturity continuity uses truncation of nearly
optimal rules; joint continuity follows from a spot Lipschitz bound uniform in
maturity. Decay is uniform on every bounded maturity interval: continuous paths
have a positive minimum stock multiplier, so varying nearly optimal rules have
vanishing rewards at large spot; dominated convergence passes to expectations.
Continuation PDE regularity is now established for this candidate in
`ActualInteriorRegularity.lean`. Smooth fit is proved in `ActualSmoothFit.lean`
and the gradient trace in `ActualGradientTrace.lean`. Positive-time boundary
smoothness remains open.

`PricePositivity.lean` proves that the deterministic maturity payoff has positive
expectation for positive strike, spot, volatility and maturity, with nonnegative
rate. Hence both raw and usual American prices are strictly positive, without a
classical-solution premise. `StrictExerciseGeometry.lean` proves that the
normalized stock threshold is in `[0,1)` at positive maturity, and that contact
and strict continuation occur exactly below/at and above this threshold. The
continuation region is open. `PositiveExerciseBoundary.lean` now proves a
strictly positive lower bound for the threshold, uniform over nonnegative
maturities when `0<=h<=k` and `k>0`. It constructs `canonicalLogBoundary`, proves
value matching, and identifies continuation exactly as `x>canonicalLogBoundary(t)`.
This uses the actual interior PDE and a constructed stationary upper barrier,
not smooth fit or a classical pricing contract.

`BoundarySemicontinuity.lean` proves upper semicontinuity of the financial
threshold and continuity from shorter maturities. `ActualBoundaryContinuity.lean`
now excludes downward jumps using the interior PDE and maturity monotonicity,
proving full continuity of the normalized stock and log boundaries on nonnegative
maturities, including expiry. No smooth fit or boundary differentiability is
assumed. `ActualContact.lean` constructs an admissible first-contact
rule directly from the actual price/payoff gap on the completed usual Brownian
space. Contact and pre-contact continuation are proved without a classical pair;
optimality of this rule is now proved in `ActualOptimality.lean` below. The full
dynamic programming principle remains open.

`BrownianGerm.lean` now derives arbitrarily early downward excursions, for any
fixed drift and positive volatility, from the proved Brownian zero-one law and
Gaussian marginals. `ContactTimeBoundary.lean` uses these excursions and boundary
monotonicity to prove that the actual optimal contact times tend almost surely
to zero as initial log price approaches the exercise boundary. This closes the
probabilistic boundary-regularity step toward smooth fit, not the payoff
difference-quotient or gradient-trace steps themselves. `PayoffSlope.lean` and
`StoppedSlopeExpectation.lean` now supply bounded difference quotients and their
expectation limit. Optimality and payoff domination squeeze the actual price
quotient between two functions with limit `-exp(b(t))`. `ActualSmoothFit.lean`
proves the exact right-sided derivative required by the classical contract,
including a named zero-dividend result. `ConvexDerivativeTrace.lean` proves a
general secant squeeze for the interior derivatives of a convex function.
`ActualGradientTrace.lean` applies it in stock coordinates and then changes to
log coordinates, proving the separate continuation-side derivative trace.
Zero-dividend and Liu-range checkpoints are explicit. `ActualClassicalContract.lean`
assembles the full actual-price contract with positive-time boundary smoothness
as its sole remaining analytic hypothesis. That hypothesis is not yet proved.
`ContinuousBoundaryProblem.lean` leaves the original contract unchanged and
removes only that field in a separate weaker predicate. All fields of this
weaker predicate are proved for the actual value in `ActualContinuousContract.lean`.
The comparison, interval and Hopf lemmas are generalized to it; adding boundary
smoothness recovers exactly the original classical contract.

`ActualSpatialRegularity.lean` joins the exercise-side derivative to smooth fit,
proving spatial differentiability at every positive maturity, including boundary
points. `ConvexSliceGradient.lean` uses fixed-endpoint secants to prove joint
gradient continuity for differentiable convex spatial slices. Applied in stock
coordinates and transformed back, this gives joint continuity of the actual
log-price gradient across the exercise boundary, stronger than the fixed-time
trace. `ActualBoundaryNondegeneracy.lean` combines that continuity with the
interior PDE and maturity monotonicity: near each positive-time boundary point,
the intrinsic premium `u=p-(1-exp(x))` satisfies
`u_xx >= (k-h*exp(b(t)))/2 > 0` in continuation. Zero-dividend and Liu-range
checkpoints are explicit. These are ingredients toward boundary regularity,
not a proof of boundary smoothness or time-convexity of the boundary.

`QuadraticSeparation.lean` integrates the second-derivative bound without
requiring a second derivative at contact. `ActualQuadraticSeparation.lean`
gives linear growth of the intrinsic premium's gradient and quadratic growth
of its value above the actual boundary, uniformly over nearby maturities.
`ActualBoundaryIncrement.lean` then bounds the displacement between two nearby
exercise boundaries using price and gradient increments at the earlier exercise
spot. Both restricted parameter checkpoints are explicit.

`ActualStrictSpatialSlope.lean` proves that the continuation slope is strictly
greater than the exercise slope. `ActualTimeIncrement.lean` uses that fact to
exclude a positive spatial maximum of a time increment at earlier exercise,
then applies the interior PDE. `ActualTemporalComparison.lean` propagates any
uniform expiry-increment bound to all maturities. `ActualTemporalModulus.lean`
identifies the maximum expiry gap at strike, giving
`abs(p(x,t)-p(x,s)) <= p(0,abs(t-s))` for nonnegative maturities. The right-hand
side tends to zero. `ActualBoundaryTemporalModulus.lean` inserts this bound into
the boundary-increment inequality. `ExpiryUpperCap.lean` constructs the smooth
positive-time supersolution `(sqrt(x^2+4*t)-x)/2+abs(k-h-1)*t`.
`ActualExpiryUpperBound.lean` compares the actual price to this cap and proves
`p(0,t) <= sqrt(t)+abs(k-h-1)*t`, hence the same bound for every temporal
price increment with `t` replaced by the maturity difference.
`ActualBoundaryQuarterBound.lean` combines it with quadratic separation to
prove a local quarter-power continuity bound for the actual log boundary.
Zero-dividend and Liu-range checkpoints are explicit. Stronger regularity
sufficient for boundary smoothness is still needed.

`ActualPremiumDilation.lean` and `ActualDilationComparison.lean` compare the
intrinsic premium at `(rho*x,rho^2*t)` and `(x,t)`, with an explicit error
linear in `rho-1` for `1<=rho<=2`. `DilationWeight.lean` supplies a growing
exponential barrier. A positive corrected maximum cannot involve exercise,
so the proof uses only the already-proved interior PDE and spatial smooth fit.
`ActualTemporalDerivativeBound.lean` differentiates this inequality at scale
one; `ActualTemporalLipschitz.lean` proves Lipschitz temporal increments on
every compact positive-time interval, including increments crossing the
exercise/continuation interface. `ActualBoundaryHalfBound.lean` combines that
estimate with quadratic separation to prove local half-power boundary
continuity. All three restricted-parameter checkpoints (dilation, temporal
Lipschitz, and boundary half-power bounds) are explicit and axiom-audited.
These results do not establish boundary differentiability or smoothness.

`BermudanConvergence.lean` now proves that restricting exercise to finite grids
converges to the actual American stopping value, without changing the underlying
process or filtration. Upward rounding capped at maturity is admissible and its
expected payoff converges for every fixed rule. This yields convergence of the
grid-value suprema, including `canonicalGridPrice_tendsto` on the usual Brownian
space. Its physical-time grid supremum is now identified with the discrete
Bellman value below. This is not a binomial-model identification or quantitative
numerical error estimate.

`DiscreteStoppingValue.lean` now proves the general finite-horizon Bellman
identification on an arbitrary filtered probability space. The backward
conditional-expectation value is a dominating supermartingale; first payoff
contact gives a stopped martingale and attains the supremum over all bounded
discrete stopping rules. `GridReindexing.lean` proves the payoff-preserving
two-way conversion to capped physical-time grid rules. `GridBellman.lean` proves
grid-value identification and attainment, and constructs optimal grid rules whose
expected payoffs converge to the actual American price, including the normalized
usual-filtration price. Convergence of the stopping times themselves and
continuous-time first-contact optimality do not follow from grid convergence
alone. The latter is now proved by the separate vanishing-gap argument below.

`BrownianBellman.lean` identifies these conditional Bellman values with an
explicit deterministic Gaussian recursion in log spot, including the capped last
grid interval. `BrownianUsualTransition.lean` proves the same transition law on
the completed usual filtration by lifting a bounded continuous terminal-value
martingale. `UsualGridMarkov.lean` identifies both filtrations' grid values with
this one recursion, whose prices converge to `canonicalPrice`. Consequently,
raw and usual American values agree at positive spot for `K>=0` and `r>=0`,
without a classical-solution premise or any restriction on dividend or volatility.
The deterministic waiting inequality is now proved in `AmericanWaiting.lean`:
waiting for any fixed duration and then valuing the remaining American right
cannot increase the initial value. `DelayedGrid.lean` derives it from optimal
exercise on grids starting after the wait, followed by dominated convergence.
`ActualSupermartingale.lean` consequently proves that the actual discounted
normalized price, frozen at maturity, is a bounded continuous supermartingale
on both raw and usual filtrations. Its initial value and exact payoff-gap
identity are checked, without a classical solution.

`ActualOptimality.lean` now proves that the actual first-contact rule attains
the canonical American stopping value, with no PDE, smooth-fit or classical-pair
premise. `FirstContactOptimality.lean` proves a general bounded-supermartingale
argument: nearly optimal rules have vanishing expected price/payoff gaps; an
almost-sure subsequence, pathwise continuity and ordered optional sampling give
equality of expected values at first contact. The already constructed optimal
grid rules discharge the approximation hypothesis in the Brownian application.
`ActualContactMartingale.lean` now also proves the stopped-martingale
characterization and the mean-value identity at any bounded observation rule
capped at actual first contact. The general argument in
`OptimalStoppedMartingale.lean` uses ordered optional sampling and rules choosing
between two times on a past-measurable event. `ActualLocalMeanValue.lean` now
constructs exits from backward space-time rectangles contained in continuation,
proves they precede contact, and obtains the exact discounted exit representation.
Such rectangles exist around every continuation point. This uses no PDE or
smooth-fit premise. `PlaneDynkin.lean` now proves the expected generator-integral
identity for smooth tests at bounded stopping rules. `ActualTestFunctions.lean`
combines it with the actual-price representation: tests matching the initial
price and bounding it above/below on a continuation rectangle have nonnegative/
nonpositive expected generator integral. Smoothness is required only of the test,
not of the price. `PointwiseTests.lean` now turns these integrated inequalities
into pointwise generator conditions using strict drift and shrinking rectangles,
and removes compact support of the tests by a smooth cutoff. `PricingTests.lean`
translates them to the normalized pricing operator: a jointly `C3` upper test
satisfies `phi_t <= phi_xx+(k-h-1)*phi_x-k*phi`, and a lower test satisfies the
reverse inequality, at any actual continuation point. `SmoothPricingComparison.lean`
now derives parabolic comparison from these tests, with only continuity of the
subsolution and interior smoothness of the comparator. `ActualSmoothComparison.lean`
identifies the actual price with any continuous, interior-C3 PDE solution having
its initial/lateral data on a continuation cylinder, including terminal time.
`ContinuousHeatSmoothing.lean` now proves all-order positive-time smoothing from
merely continuous compact data. `ContinuousPriceEvolution.lean` constructs a
smooth pricing-equation solution matching the actual price's initial trace on
any finite spatial interval. The two-sided heat-equation boundary correction is
now transformed into pricing coordinates and assembled with the initial
contribution in `PricingDirichlet.lean`. Local identification then proves actual
interior smoothness and the pricing PDE in `ActualInteriorRegularity.lean`.
Full continuous-time dynamic programming and positive-time boundary smoothness
remain unproved. The gradient trace is now proved as described above.

The lateral-data construction now has a checked half-line boundary kernel:
`H(t,x)=x*K(t,x)/t` satisfies the diffusivity-`1/2` heat equation, is positive
for `t,x>0`, and has unit integral over positive elapsed time. Its integral
extension of bounded continuous boundary data is jointly continuous, has the
exact boundary trace, preserves the uniform bound, and is zero before the data
starts. For continuous compact boundary data, the integral's interior smoothness
and heat equation are now proved, including a constructed half-line solution
with zero initial data and the exact lateral trace. A strict finite-time
cross-boundary contraction now constructs the correction matching both ends of
a finite interval for continuous causal data. Its pricing-coordinate assembly
now closes actual-price interior regularity. The final theorems assume only
`k>=0` and membership in the actual continuation region, not price derivatives
or a classical solution contract.

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
| [`Stopping/ClassicalBridge.lean`](AmericanConvexity/Stopping/ClassicalBridge.lean) | Price identification implies boundary identification and transfers strict curvature; its explicit price premise is discharged in ClassicalSupermartingale |
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
| [`Boundary/WindowComparison.lean`](AmericanConvexity/Boundary/WindowComparison.lean) | Obstacle comparison from any nonnegative initial time, on a finite rectangle and then the full spatial line by removing a quadratic penalty |
| [`Stopping/CompactHeatFlow.lean`](AmericanConvexity/Stopping/CompactHeatFlow.lean) | Joint smoothness and the heat equation for compactly supported smooth test data; extends MathFin's kernel differentiation by scaling |
| [`Stopping/BrownianHeatFlow.lean`](AmericanConvexity/Stopping/BrownianHeatFlow.lean) | Heat flow as an actual Brownian expectation, with continuity at time zero, initial payoff and uniform bounds; discounted drifted pricing evolution |
| [`Stopping/LinearPriceComparison.lean`](AmericanConvexity/Stopping/LinearPriceComparison.lean) | The test-payoff Gaussian pricing evolution satisfies the normalized PDE and stays below the classical price from any nonnegative initial time |
| [`Stopping/SmoothMinorants.lean`](AmericanConvexity/Stopping/SmoothMinorants.lean) | Uniformly bounded C2 compact minorants converge pointwise to any continuous function valued in [0,1] |
| [`Stopping/ClassicalHeatComparison.lean`](AmericanConvexity/Stopping/ClassicalHeatComparison.lean) | Dominated convergence extends the Gaussian pricing inequality to the actual continuous classical price slice |
| [`Stopping/IndependentKernel.lean`](AmericanConvexity/Stopping/IndependentKernel.lean) | Conditional averaging with a past-measurable state and an independent increment, proved by product laws and Fubini |
| [`Stopping/BrownianTransition.lean`](AmericanConvexity/Stopping/BrownianTransition.lean) | The raw-filtration conditional Brownian transition, with exact scaled-increment variance |
| [`Stopping/ClassicalTransition.lean`](AmericanConvexity/Stopping/ClassicalTransition.lean) | Physical-time discount/drift normalization and the conditional price inequality before maturity |
| [`Stopping/ClassicalSupermartingale.lean`](AmericanConvexity/Stopping/ClassicalSupermartingale.lean) | Global supermartingality, price and boundary identification, and actual-boundary curvature from the classical contract; includes zero-dividend and Liu-range milestones |
| [`Stopping/FiltrationExtension.lean`](AmericanConvexity/Stopping/FiltrationExtension.lean) | Bounded continuous supermartingales survive right continuation and ambient-null augmentation |
| [`Stopping/AugmentedValue.lean`](AmericanConvexity/Stopping/AugmentedValue.lean) | Equality of raw and right-continuous ambient-null-augmented stopping values from the classical contract |
| [`Stopping/CompletedSpace.lean`](AmericanConvexity/Stopping/CompletedSpace.lean) | Full ambient completion preserves original measurable integrals and bounded supermartingales |
| [`Stopping/UsualBrownianValue.lean`](AmericanConvexity/Stopping/UsualBrownianValue.lean) | Complete right-continuous Brownian filtration, equality with the raw stopping value, and usual-filtration boundary curvature from the classical contract |
| [`Stopping/MaturityTruncation.lean`](AmericanConvexity/Stopping/MaturityTruncation.lean) | Admissible rule truncation and convergence of expected rewards under changing maturities |
| [`Stopping/MaturityContinuity.lean`](AmericanConvexity/Stopping/MaturityContinuity.lean) | Maturity continuity of the stopping supremum without an optimal-rule or classical-solution premise |
| [`Stopping/JointPriceContinuity.lean`](AmericanConvexity/Stopping/JointPriceContinuity.lean) | Uniform local spot Lipschitz bound and joint spot/maturity continuity at positive spot |
| [`Stopping/CanonicalPrice.lean`](AmericanConvexity/Stopping/CanonicalPrice.lean) | Concrete normalized usual-filtration stopping price, joint continuity, initial payoff, bounds and uniform finite-maturity tail decay |
| [`Stopping/SpotDecay.lean`](AmericanConvexity/Stopping/SpotDecay.lean) | Large-spot decay of the stopping supremum from pathwise compactness and nearly optimal rules, uniform over bounded maturities |
| [`Stopping/PricePositivity.lean`](AmericanConvexity/Stopping/PricePositivity.lean) | Positive Gaussian maturity-payoff expectation and strict positivity of raw, usual and normalized American prices |
| [`Stopping/StrictExerciseGeometry.lean`](AmericanConvexity/Stopping/StrictExerciseGeometry.lean) | Threshold strictly below strike, full contact/continuation characterization, and an open continuation domain, without a PDE premise |
| [`Stopping/BoundarySemicontinuity.lean`](AmericanConvexity/Stopping/BoundarySemicontinuity.lean) | Upper semicontinuity and shorter-maturity-side continuity of the financial threshold, without a PDE premise |
| [`Stopping/ActualContact.lean`](AmericanConvexity/Stopping/ActualContact.lean) | Actual-price first-contact rule, GBM normalization, attained contact and pre-contact continuation; optimality is proved later in ActualOptimality |
| [`Stopping/FiniteExerciseGrid.lean`](AmericanConvexity/Stopping/FiniteExerciseGrid.lean) | Finite exercise grids, admissible upward rounding capped at maturity, and expected-payoff convergence |
| [`Stopping/BermudanConvergence.lean`](AmericanConvexity/Stopping/BermudanConvergence.lean) | Genuine finite-grid stopping suprema converge to the American value in the same model; payoff and European bounds |
| [`Stopping/FiniteBellman.lean`](AmericanConvexity/Stopping/FiniteBellman.lean) | General conditional-expectation Bellman recursion, adaptedness, integrability, payoff dominance, supermartingality and minimality |
| [`Stopping/DiscreteContactMartingale.lean`](AmericanConvexity/Stopping/DiscreteContactMartingale.lean) | Discrete processes with zero conditional drift before stopping become stopped martingales |
| [`Stopping/FiniteBellmanOptimality.lean`](AmericanConvexity/Stopping/FiniteBellmanOptimality.lean) | Bellman first-contact stopping time, attained payoff, martingale property and finite-horizon optimality |
| [`Stopping/DiscreteStoppingValue.lean`](AmericanConvexity/Stopping/DiscreteStoppingValue.lean) | Bellman identification with the full bounded discrete stopping supremum and an explicit attaining rule |
| [`Stopping/GridReindexing.lean`](AmericanConvexity/Stopping/GridReindexing.lean) | Two-way payoff-preserving conversion between physical-time grid rules and bounded discrete rules in the capped sampled filtration |
| [`Stopping/GridBellman.lean`](AmericanConvexity/Stopping/GridBellman.lean) | Actual grid-value Bellman identification and attainment; optimal-grid expected payoffs converge to the American value |
| [`Stopping/BrownianBellman.lean`](AmericanConvexity/Stopping/BrownianBellman.lean) | Continuous bounded Gaussian Markov recursion, raw-grid price identification, and convergence to the raw American value |
| [`Stopping/BrownianUsualTransition.lean`](AmericanConvexity/Stopping/BrownianUsualTransition.lean) | Bounded continuous terminal-value martingale and exact Gaussian log-state transition on the completed usual filtration |
| [`Stopping/UsualGridMarkov.lean`](AmericanConvexity/Stopping/UsualGridMarkov.lean) | Usual-grid Gaussian price identification, convergence to canonical price, and raw/usual value equality without a classical solution |
| [`Stopping/SampledRules.lean`](AmericanConvexity/Stopping/SampledRules.lean) | Admissible physical-time rules from arbitrary increasing sampled schedules; Bellman homogeneity |
| [`Stopping/DelayedGrid.lean`](AmericanConvexity/Stopping/DelayedGrid.lean) | Bellman identification on grids starting after a fixed wait, and domination by the American value |
| [`Stopping/AmericanWaiting.lean`](AmericanConvexity/Stopping/AmericanWaiting.lean) | Deterministic waiting inequality for the actual raw and normalized usual prices via delayed-grid convergence |
| [`Stopping/ActualSupermartingale.lean`](AmericanConvexity/Stopping/ActualSupermartingale.lean) | Bounded continuous actual discounted price is a raw/usual supermartingale; initial price and exact payoff-gap identity |
| [`Stopping/OrderedSampling.lean`](AmericanConvexity/Stopping/OrderedSampling.lean) | Optional-sampling inequality for two ordered bounded continuous-time stopping rules |
| [`Stopping/VanishingGap.lean`](AmericanConvexity/Stopping/VanishingGap.lean) | Almost-sure vanishing-gap subsequence and pathwise convergence of times capped at first contact |
| [`Stopping/FirstContactOptimality.lean`](AmericanConvexity/Stopping/FirstContactOptimality.lean) | Expected-value preservation and first-contact optimality from a bounded supermartingale and nearly optimal rules |
| [`Stopping/ActualOptimality.lean`](AmericanConvexity/Stopping/ActualOptimality.lean) | Actual usual-filtration first-contact rule attains the canonical American value without a classical solution |
| [`Stopping/OptimalStoppedMartingale.lean`](AmericanConvexity/Stopping/OptimalStoppedMartingale.lean) | A bounded continuous supermartingale stopped at a value-preserving rule is a martingale, proved by event-pasted stopping rules |
| [`Stopping/ActualContactMartingale.lean`](AmericanConvexity/Stopping/ActualContactMartingale.lean) | Actual-price martingale up to first contact and mean-value identity at every bounded observation rule capped at contact |
| [`Stopping/RectangleExit.lean`](AmericanConvexity/Stopping/RectangleExit.lean) | Constructed bounded rectangle exit, pre-exit inequalities and attained parabolic boundary |
| [`Stopping/ContinuationRectangles.lean`](AmericanConvexity/Stopping/ContinuationRectangles.lean) | Closed backward rectangles inside the actual continuation region around every continuation point |
| [`Stopping/ActualLocalMeanValue.lean`](AmericanConvexity/Stopping/ActualLocalMeanValue.lean) | Actual rectangle exit precedes exercise contact; exact discounted local exit representation without a PDE premise |
| [`Stopping/PlaneDynkin.lean`](AmericanConvexity/Stopping/PlaneDynkin.lean) | Compensated smooth plane process, bounded stopped martingality and Dynkin identity; compact tests discharge bounds |
| [`Stopping/ActualTestFunctions.lean`](AmericanConvexity/Stopping/ActualTestFunctions.lean) | Raw rectangle mean value and upper/lower smooth-test expected generator inequalities for the actual price |
| [`Stopping/StrictDrift.lean`](AmericanConvexity/Stopping/StrictDrift.lean) | Strict generator sign gives strict sign of the expected integral up to positive rectangle exit |
| [`Stopping/PointwiseTests.lean`](AmericanConvexity/Stopping/PointwiseTests.lean) | Arbitrarily small continuation rectangles and pointwise generator inequalities for upper/lower C3 tests, without a compact-support requirement |
| [`Stopping/PricingTests.lean`](AmericanConvexity/Stopping/PricingTests.lean) | Exact transformation to upper/lower test inequalities for the normalized pricing equation |
| [`Stopping/SmoothPricingComparison.lean`](AmericanConvexity/Stopping/SmoothPricingComparison.lean) | Parabolic comparison from smooth tests for continuous functions, with terminal-time recovery and only interior-C3 comparator regularity |
| [`Stopping/ActualSmoothComparison.lean`](AmericanConvexity/Stopping/ActualSmoothComparison.lean) | Actual-price upper/lower local comparison and identification with a supplied smooth Dirichlet solution; existence remains separate |
| [`Stopping/ContinuousHeatSmoothing.lean`](AmericanConvexity/Stopping/ContinuousHeatSmoothing.lean) | All-order joint heat smoothing for continuous compact data; no derivatives of the datum |
| [`Stopping/ContinuousPriceEvolution.lean`](AmericanConvexity/Stopping/ContinuousPriceEvolution.lean) | Constructed continuous initial-data pricing evolution, exact initial trace, positive-time smoothness and PDE; actual-price interval traces included |
| [`Stopping/HeatBoundaryKernel.lean`](AmericanConvexity/Stopping/HeatBoundaryKernel.lean) | Positive-time half-line heat boundary kernel, exact derivatives/PDE, temporal unit mass, integrability and parabolic scaling |
| [`Stopping/HeatBoundaryExtension.lean`](AmericanConvexity/Stopping/HeatBoundaryExtension.lean) | Bounded continuous boundary-data integral: joint continuity, exact trace, causality, uniform bound and elapsed-time representation |
| [`Stopping/FlatHeatKernel.lean`](AmericanConvexity/Stopping/FlatHeatKernel.lean) | Smooth zero extension of the boundary kernel across elapsed time zero, with the PDE valid away from the spatial boundary |
| [`Stopping/HeatBoundarySmoothing.lean`](AmericanConvexity/Stopping/HeatBoundarySmoothing.lean) | All-order interior smoothing for continuous compact boundary data, via the causal kernel; no derivatives of the datum |
| [`Stopping/CompactKernelDerivative.lean`](AmericanConvexity/Stopping/CompactKernelDerivative.lean) | Derivative-under-the-integral theorem with explicit local compact domination of kernel derivatives |
| [`Stopping/HeatBoundaryEquation.lean`](AmericanConvexity/Stopping/HeatBoundaryEquation.lean) | Boundary integral heat equation and constructed half-line solution with continuous compact boundary data and zero initial data |
| [`Stopping/HeatBoundaryContraction.lean`](AmericanConvexity/Stopping/HeatBoundaryContraction.lean) | Strict finite-time kernel mass bound, complete space of causal boundary data and cross-boundary Lipschitz estimate |
| [`Stopping/CoupledHeatBoundary.lean`](AmericanConvexity/Stopping/CoupledHeatBoundary.lean) | Fixed-point construction of the two coupled boundary inputs; compactness follows from compact cutoff and data |
| [`Stopping/IntervalHeatBoundary.lean`](AmericanConvexity/Stopping/IntervalHeatBoundary.lean) | Constructed two-sided interval heat correction for continuous causal data, exact endpoint traces, zero initial data, interior smoothness and PDE |
| [`Stopping/HeatPricingTransform.lean`](AmericanConvexity/Stopping/HeatPricingTransform.lean) | Fixed-endpoint exponential gauge and time scaling from heat to pricing PDE |
| [`Stopping/PricingBoundaryCorrection.lean`](AmericanConvexity/Stopping/PricingBoundaryCorrection.lean) | Constructed pricing correction matching continuous causal lateral data and zero initial trace |
| [`Stopping/PricingDirichlet.lean`](AmericanConvexity/Stopping/PricingDirichlet.lean) | Constructed smooth pricing solution matching all three parabolic sides supplied by a continuous function |
| [`Stopping/ActualInteriorRegularity.lean`](AmericanConvexity/Stopping/ActualInteriorRegularity.lean) | Actual stopping price is jointly smooth and satisfies the pricing PDE throughout continuation; no classical-solution premise |
| [`Stopping/UpperSupportComparison.lean`](AmericanConvexity/Stopping/UpperSupportComparison.lean) | Actual-price comparison with smooth upper supports, allowing a comparator's second derivative to jump at its join |
| [`Stopping/StationaryPutCap.lean`](AmericanConvexity/Stopping/StationaryPutCap.lean) | Constructed payoff-matching stationary supersolution, explicit exponential branch and checked supports |
| [`Stopping/PositiveExerciseBoundary.lean`](AmericanConvexity/Stopping/PositiveExerciseBoundary.lean) | Uniformly positive actual exercise threshold, finite logarithmic boundary, value matching and exact continuation geometry; named zero-dividend checkpoint |
| [`Stopping/ContinuationSlice.lean`](AmericanConvexity/Stopping/ContinuationSlice.lean) | Actual maturity derivative is nonnegative; elliptic forcing and a quadratic maximum argument exclude an instant continuation interval |
| [`Stopping/ActualBoundaryContinuity.lean`](AmericanConvexity/Stopping/ActualBoundaryContinuity.lean) | No downward threshold jumps; actual stock/log boundary continuity including expiry and log-boundary monotonicity; named zero-dividend checkpoint |
| [`Stopping/BrownianGerm.lean`](AmericanConvexity/Stopping/BrownianGerm.lean) | Brownian negative germ event has probability one; arbitrarily early downward excursions survive every fixed drift and positive volatility |
| [`Stopping/ContactTimeBoundary.lean`](AmericanConvexity/Stopping/ContactTimeBoundary.lean) | Almost-sure convergence of actual optimal first-contact times to zero as initial log price approaches the exercise boundary |
| [`Stopping/PayoffSlope.lean`](AmericanConvexity/Stopping/PayoffSlope.lean) | Global 1-Lipschitz log payoff; uniformly bounded discounted slopes and their short-time boundary limit |
| [`Stopping/StoppedSlopeExpectation.lean`](AmericanConvexity/Stopping/StoppedSlopeExpectation.lean) | Checked reward normalization, measurability, domination and expected-slope limit along actual optimal rules |
| [`Stopping/ActualSmoothFit.lean`](AmericanConvexity/Stopping/ActualSmoothFit.lean) | Actual-price smooth fit from optimality, payoff domination and the expected-slope limit; named zero-dividend checkpoint |
| [`Stopping/ConvexDerivativeTrace.lean`](AmericanConvexity/Stopping/ConvexDerivativeTrace.lean) | General right derivative trace from convexity, boundary smooth fit and interior differentiability |
| [`Stopping/ActualGradientTrace.lean`](AmericanConvexity/Stopping/ActualGradientTrace.lean) | Actual stock/log gradient traces; explicit zero-dividend and Liu-range checkpoints |
| [`Stopping/ActualClassicalContract.lean`](AmericanConvexity/Stopping/ActualClassicalContract.lean) | Full actual-price contract conditional only on positive-time boundary smoothness |
| [`Stopping/ConvexSliceGradient.lean`](AmericanConvexity/Stopping/ConvexSliceGradient.lean) | Joint gradient continuity from continuous values and differentiable convex slices |
| [`Stopping/ActualSpatialRegularity.lean`](AmericanConvexity/Stopping/ActualSpatialRegularity.lean) | Actual spatial differentiability and joint gradient continuity across the exercise boundary |
| [`Stopping/ActualBoundaryNondegeneracy.lean`](AmericanConvexity/Stopping/ActualBoundaryNondegeneracy.lean) | Locally uniform positive lower bound for the intrinsic premium's second spatial derivative near the boundary |
| [`Stopping/QuadraticSeparation.lean`](AmericanConvexity/Stopping/QuadraticSeparation.lean) | Linear gradient and quadratic value separation from a flat contact point |
| [`Stopping/ActualQuadraticSeparation.lean`](AmericanConvexity/Stopping/ActualQuadraticSeparation.lean) | Actual-premium separation, uniformly over nearby maturities |
| [`Stopping/ActualBoundaryIncrement.lean`](AmericanConvexity/Stopping/ActualBoundaryIncrement.lean) | Actual boundary displacement controlled by price/gradient time increments; zero-dividend and Liu-range checkpoints |
| [`Stopping/ActualStrictSpatialSlope.lean`](AmericanConvexity/Stopping/ActualStrictSpatialSlope.lean) | Continuation slope strictly above the exercise slope, directly from stock convexity |
| [`Stopping/ActualTimeIncrement.lean`](AmericanConvexity/Stopping/ActualTimeIncrement.lean) | Actual time-increment PDE and exclusion of positive space-time maxima, including earlier exercise |
| [`Stopping/ActualTemporalComparison.lean`](AmericanConvexity/Stopping/ActualTemporalComparison.lean) | Uniform expiry-increment bounds propagate to every later maturity |
| [`Stopping/ActualTemporalModulus.lean`](AmericanConvexity/Stopping/ActualTemporalModulus.lean) | At-strike short-maturity price controls all temporal price increments and tends to zero |
| [`Stopping/ActualBoundaryTemporalModulus.lean`](AmericanConvexity/Stopping/ActualBoundaryTemporalModulus.lean) | Local squared boundary displacement bounded by the at-strike short-maturity price |
| [`Stopping/ExpiryUpperCap.lean`](AmericanConvexity/Stopping/ExpiryUpperCap.lean) | Explicit square-root payoff majorant and pricing supersolution |
| [`Stopping/ActualExpiryUpperBound.lean`](AmericanConvexity/Stopping/ActualExpiryUpperBound.lean) | Actual expiry and uniform temporal square-root bounds |
| [`Stopping/ActualBoundaryQuarterBound.lean`](AmericanConvexity/Stopping/ActualBoundaryQuarterBound.lean) | Genuine local quarter-power continuity of the actual log boundary, with restricted parameter checkpoints |
| [`Stopping/ActualPremiumDilation.lean`](AmericanConvexity/Stopping/ActualPremiumDilation.lean) | Exact actual-premium dilation PDE and exclusion of exercise at positive corrected maxima |
| [`Stopping/DilationWeight.lean`](AmericanConvexity/Stopping/DilationWeight.lean) | Explicit exponential weight and supersolution for dilation errors and spatial truncation |
| [`Stopping/ActualDilationComparison.lean`](AmericanConvexity/Stopping/ActualDilationComparison.lean) | Actual-premium dilation bound linear in scale increment, including expiry and restricted checkpoints |
| [`Stopping/ActualTemporalDerivativeBound.lean`](AmericanConvexity/Stopping/ActualTemporalDerivativeBound.lean) | Dilation differentiated at scale one and uniform continuation time-derivative bounds away from expiry |
| [`Stopping/ActualTemporalLipschitz.lean`](AmericanConvexity/Stopping/ActualTemporalLipschitz.lean) | Actual-price temporal Lipschitz bounds across exercise/continuation, with restricted checkpoints |
| [`Stopping/ActualBoundaryHalfBound.lean`](AmericanConvexity/Stopping/ActualBoundaryHalfBound.lean) | Local square-root continuity of the actual log boundary, with restricted checkpoints |
| [`Boundary/ContinuousBoundaryProblem.lean`](AmericanConvexity/Boundary/ContinuousBoundaryProblem.lean) | Pricing data without boundary smoothness; exact relation to the unchanged classical contract |
| [`Boundary/ContinuousContact.lean`](AmericanConvexity/Boundary/ContinuousContact.lean) | First contact of a continuous scalar profile, with strict negativity beforehand |
| [`Boundary/LineIntervalConvexity.lean`](AmericanConvexity/Boundary/LineIntervalConvexity.lean) | Derivative-free convexity from negative-intercept line intervals and the expiry condition |
| [`Stopping/ActualContinuousContract.lean`](AmericanConvexity/Stopping/ActualContinuousContract.lean) | All continuous-boundary pricing fields proved for the actual stopping value |
| [`Stopping/ActualComparisonIntervals.lean`](AmericanConvexity/Stopping/ActualComparisonIntervals.lean) | Actual spatial comparison invariant and time-interval geometry below admissible lines |
| [`Stopping/ActualConvexLowerComparison.lean`](AmericanConvexity/Stopping/ActualConvexLowerComparison.lean) | Moving-strip comparison for spatially convex smooth subsolutions, without boundary derivatives |
| [`Stopping/ActualNearExpiry.lean`](AmericanConvexity/Stopping/ActualNearExpiry.lean) | Actual square-root expiry lower barrier and the boundary ratio tending to minus infinity |
| [`Stopping/ActualLogConvexity.lean`](AmericanConvexity/Stopping/ActualLogConvexity.lean) | Convexity of the actual normalized logarithmic boundary, with zero-dividend and Liu-range checkpoints |
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
**assumes** positive log-boundary curvature; that stronger hypothesis remains open.
The new proof instead uses weak log curvature and strictly negative speed.
These generic coordinate lemmas do
not identify an arbitrary input function with the financial exercise boundary.

The limit lemma proves only **ordinary convexity**. Strict convexity or strictly
positive second derivatives do not follow just by taking limits.

The solution definitions now specify the PDE, payoff, continuation/exercise regions,
regularity and one-sided smooth fit without assuming convexity. Lean verifies that
their contact condition translates to the usual monetary put payoff and stock-price
threshold. Identification with the raw Brownian stopping value and its threshold
is now proved from the contract. Existence of such a classical solution remains
open. [Statement review and current proof
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
Actual stopping-value identification is now proved from the classical contract;
the usual-filtration comparison is also proved. Classical existence remains
open. The weaker parameter cases are tracked
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
