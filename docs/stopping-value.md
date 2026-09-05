# Continuous-time stopping value and checked classical identification

The curvature proof is complete for `DividendPutSolution`. This development
defines the financial value and now proves that any pair satisfying that
classical contract equals the Brownian American stopping value on both the raw
and completed usual filtrations. Classical-pair existence remains open.

**New main result:** `ActualLogConvexity.lean` proves convexity of the actual
normalized logarithmic boundary on all positive maturities from only `k>0`
and `0<=h<=k`. This uses a continuous-boundary comparison and chord argument,
not a classical-pair existence premise. The classical second-derivative and
strict stock-curvature statements are still distinguished from this
convex-function conclusion. `PhysicalBoundaryConvexity.lean` now proves log
convexity, strict stock convexity, strict decrease, and local Lipschitz continuity
for the actual physical-unit threshold, using exact stopping-value normalization.
No classical contract is assumed. See the final sections below.

**Current frontier:** `ActualInteriorRegularity.lean` proves joint
all-order smoothness and the pricing PDE for the actual stopping price on its
continuation region, without a classical-solution premise. The sections below
record successive checkpoints; older references to an open interior-PDE step
are superseded by the later construction. `PositiveExerciseBoundary.lean` now
proves a uniform positive lower bound on the threshold and constructs the actual
logarithmic boundary. `ActualBoundaryContinuity.lean` proves full stock/log
boundary continuity, including expiry. `ActualSmoothFit.lean` proves the
one-sided smooth-fit derivative. `ActualGradientTrace.lean` proves the distinct
continuation-side derivative trace. `ActualClassicalContract.lean` assembles all
contract fields conditional only on positive-time boundary smoothness, which
remains open.

The final sections prove almost-sure convergence of actual optimal contact times
to zero at exercise, bounded convergence of the resulting payoff quotients, and
smooth fit by comparison with the actual price quotient, and the gradient trace
using convexity in stock price.
They also prove spatial differentiability and joint gradient continuity across
the actual boundary, then a locally uniform positive lower bound for the
intrinsic premium's second spatial derivative near that boundary. Boundary
smoothness itself remains open.
The latest quantitative step integrates this bound and controls boundary
displacement by price and gradient increments at the earlier exercise spot.
Actual temporal comparison now bounds all price increments by the at-strike
short-maturity price and transfers that scalar modulus to the boundary.
An explicit expiry supersolution now gives a square-root temporal price bound
and a local quarter-power continuity bound for the actual log boundary.

## Exact financial definition

For an explicit filtration `F` on a probability space `(Omega,P)`, a
`BoundedRule F T` is a function `theta : Omega -> nonnegative reals` such that
its `WithTop` embedding is a Mathlib stopping time and `theta(omega)<=T` for
every outcome. `T` is remaining physical time, not calendar time or normalized
PDE time. Stopping-time measurability is derived. Conversely every ordinary
`WithTop`-valued stopping time bounded by the finite horizon has exactly this
representation; the finite codomain does not exclude bounded stopping rules.

`Reward.lean` uses MathFin's existing explicit `gbmValue` definition:

```text
S_theta = S * exp((r-q-sigma^2/2)*theta + sigma*W_theta),
reward_theta = exp(-r*theta) * max(K-S_theta,0).
```

The stock drift is `r-q`, while the discount rate is `r`. The expectation is
under the supplied probability measure. Joint measurability of `W` and the
derived measurability of `theta` give a measurable stopped reward. For
`r>=0`, `K>=0`, and `S>=0`, the reward lies in `[0,K]` pointwise and is
integrable. No moment or optional-stopping assumption is hidden in this bound.

`AmericanValue.lean` defines

```text
exerciseValues = { integral reward_theta dP | theta : BoundedRule F T },
americanPutValue = sSup exerciseValues.
```

The set is nonempty (immediate exercise is admissible) and bounded above by
`K`. Thus Lean's conditional real supremum is used on a proved nonempty,
bounded set, not via its default value on an invalid input.

## Constructed Brownian instance

`BrownianModel.lean` uses the pinned BrownianMotion package's `brownian` on
`gaussianLimit`, a constructed probability measure on `nonnegative reals -> R`.
The package proves continuous Brownian paths, joint measurability, the Brownian
law, and almost-sure zero initial value. Its natural filtration is explicit,
and `brownian_filtered` proves adaptation and independence of future increments
from that filtration. No bare Brownian-existence premise is left in the
definitions `brownianAmericanPut` and `brownianExerciseBoundary`.

This is the raw natural filtration. `UsualBrownianValue.lean` proves equality
with the completed/right-continuous usual augmentation from the classical
contract. The later `UsualGridMarkov.lean` removes that premise at positive spot:
both values are limits of the same Gaussian grid-price recursion. No representation
invariance across arbitrary Brownian probability spaces is claimed.

The financial modules reuse MathFin's GBM value **definition** and, in the local
stochastic bridge, its general Ito/local-martingale theorem. They do not import
a continuous-time American pricing or American PDE-verification theorem. Their
selected conclusions, the filtered Brownian result, and the new local Ito chain
have build-enforced transitive axiom guards. This is not an independent audit of
every upstream theorem.

## Checked value and contact-set results

The following are proved from the stopping definition, without the classical
pricing contract:

- `max(K-S,0) <= V(S,T) <= K`, and hence nonnegativity.
- `V(S,0)=max(K-S,0)`.
- The European payoff expectation is no greater than `V(S,T)`.
- `V` is nondecreasing in remaining maturity.
- `V` is nonincreasing, convex, and continuous in nonnegative initial spot.
- `V(0,T)=K`.

At a fixed maturity, define the **in-the-money contact set**

```text
E(T) = { S | 0<=S, S<=K, V(S,T)=K-S }.
```

`ExerciseRegion.lean` proves that this set is closed and convex and contains
zero. Its supremum `B(T)` is attained, lies in `[0,K]`, and
`E(T)=[0,B(T)]`. Contact sets shrink with remaining maturity, so `B` is
nonincreasing. At expiry, `B(0)=K`.

The restriction `S<=K` is intentional: at expiry the unrestricted value/payoff
coincidence set contains **every** nonnegative stock price. Taking its supremum
would not recover the desired terminal threshold. The present result proves
the endpoint convention, not continuity of the boundary as maturity tends to
zero. Attainment of the contact-set supremum also does **not** mean that an
optimal stopping time attaining the value supremum has been constructed.

## Checked optional stopping and verification principle

`GridSampling.lean` derives bounded continuous-path optional stopping from
Mathlib's discrete-time theorem. The grid index is `ceil(theta/delta)` and is
a stopping time for the filtration sampled at `i*delta`. Its deterministic
bound is `ceil(T/delta)`. With `delta=1/(n+1)`, the sampled times converge to
`theta`; path continuity and a uniform deterministic bound allow dominated
convergence of expectations. The results are an expectation inequality for
supermartingales and equality for martingales. They hold on finite measures
and require neither right-continuity nor completion of the filtration.

The stated process bound is global in time and outcome. Grid points may lie
slightly beyond maturity; this is safe for the candidate below because it is
frozen at maturity. No claim for arbitrary unbounded or discontinuous processes
is made.

`Verification.lean` applies these results to the actual American supremum:
a bounded continuous-path supermartingale dominating the discounted reward
bounds the value by its initial expectation. Equality follows if an admissible
contact rule makes the stopped candidate a martingale. Neither optimality of
the rule nor equality with the stopping value is assumed.

`ClassicalCandidate.lean` defines the exact process, with `s=min(t,T)`:

```text
X_s = log(S/K) + (r-q-sigma^2/2)*s + sigma*W_s,
U_t = exp(-r*s) * K*p(X_s, sigma^2/2*(T-s)).
```

For positive strike/spot and nonnegative discount rate, the classical contract
proves `0<=U_t<=K`, continuity along continuous paths, reward domination through
maturity, and payoff equality at maturity. Almost-sure `W_0=0` identifies its
initial value. The checked conditional theorem now reduces price identification
to supermartingality of this exact candidate, an admissible contact rule, and
the stopped-candidate martingale property. The later `ContactMartingale.lean`
development constructs the rule and proves the latter property from the PDE.
`ClassicalSupermartingale.lean` proves the global supermartingale property and
discharges the remaining stochastic premise.
In particular, no global C2 regularity across the exercise boundary is assumed
to justify an unqualified application of Ito's formula.

## Constructed first-contact stopping rule

`FirstContact.lean` constructs the first zero of a nonnegative continuous adapted
process `Z` that vanishes at a fixed horizon. Its zero-time set is closed and
nonempty, so its infimum is an attained zero, bounded by the horizon. For every
deterministic `t`, the event of contact by `t` is measurable in `F(t)`: it is the
event that the running minimum on `[0,min(t,T)]` is zero. Measurability follows
from measurable infima of continuous paths on a separable compact interval;
compactness proves that a zero minimum is attained. No completion or
right-continuity of the filtration is assumed.

`ClassicalContact.lean` applies this to

```text
Z_t = U_t - exp(-r*s)*max(K-S_s,0),   s=min(t,T).
```

The classical contract and adapted continuous stock driver prove adaptation,
continuity, nonnegativity, and zero gap at maturity. The resulting
`classicalContactRule` has exact payoff contact. With positive volatility,
every time strictly before it has positive remaining maturity and log spot
strictly above the classical boundary. This locates the stopped trajectory
inside the continuation region where the PDE and smoothness are available.

`BrownianVerification.lean` instantiates this rule on the constructed Brownian
space. `brownian_price_identification_of_martingales` no longer asks for a rule
or contact hypothesis: it asks only for supermartingality of the exact candidate
and martingality of that candidate stopped at its constructed first contact.
The final `brownian_boundary_curvature_of_martingales` transfers curvature when
these properties hold for every positive initial spot and finite horizon.

The contact martingale property is discharged by `ContactMartingale.lean`, and
global supermartingality by `ClassicalSupermartingale.lean`. The rule realizes
the classical price as its expected payoff; the supermartingale upper bound
on all other rules proves its optimality. Existence of a classical pair remains
open.

## Checked local PDE-to-Ito connection

`CandidatePDE.lean` writes the precise discounted price as a function of physical
elapsed time `t` and Brownian coordinate `w`:

```text
F(t,w) = exp(-r*t)*K*p(x0+(r-q-sigma^2/2)*t+sigma*w, sigma^2/2*(T-t)).
```

At continuation points, the normalized pricing PDE proves
`F_t+(1/2)*F_ww=0`. The time reversal, factor `sigma^2/2`, risk-neutral log drift,
and discount term are all checked by derivative identities, not by renaming the
PDE. The stochastic candidate evaluated before maturity agrees exactly with
`F(t,W_t)`.

`SmoothLocalization.lean` constructs a compactly supported globally C3 function
`G` agreeing with `F` near any continuation point. A bump is supported strictly
inside a neighborhood where the price is C3; outside that support its product
with the price is locally zero. This does not require global smoothness of the
price. `LocalPriceIto.lean` proves that `G_t+(1/2)*G_ww=0` on a neighborhood of
the chosen point, not globally on the support transition region.

`PlaneIto.lean` derives MathFin's six jointly continuous partial derivatives from
joint C3 regularity and invokes `MathFin.ito_formula_unrestricted`. Consequently
each local extension has an actual compensated local-martingale decomposition:

```text
G(t,W_t)-G(0,W_0) = M_t + integral_0^t (G_t+(1/2)*G_ww)(s,W_s) ds.
```

The local-martingale filtration here is explicitly MathFin's **null-augmented**
Brownian filtration. The local statement alone does not assert martingality of
the original candidate. The compact-region assembly, bounded promotion and
raw-filtration transfer described below now prove martingality up to first
contact. The global supermartingale property is proved separately by Gaussian
comparison, without differentiating the price twice across exercise.

The new import traverses upstream files containing unfinished declarations;
the guarded axiom checks on `plane_ito_localMartingale` and `local_price_ito`
verify their actual proof chains contain only `propext`, `Classical.choice`,
and `Quot.sound`, not `sorryAx`. This is a dependency-specific check, not a
claim that all imported declarations are complete.

## Checked bounded promotion and raw-filtration transfer

`BoundedLocalMartingale.lean` proves that an explicitly adapted local martingale
with a deterministic uniform bound on each finite time interval is a true
martingale. It uses the stopped-and-indicated martingales supplied by the
localizing sequence. At each fixed time they eventually agree with the process
almost surely. Dominated convergence preserves their integrals over every
event measurable at an earlier time, giving the required conditional expectation
identity. This proof does not invoke the unfinished upstream submartingale
uniform-integrability or stopping-stability declarations. The bounds must be
deterministic and uniform in outcomes, not merely pathwise random bounds.

The same module proves transfer of a true martingale to any smaller filtration
to which it is explicitly strongly adapted. `BrownianLocalVerification.lean`
checks that our raw natural Brownian filtration is contained in MathFin's exact
null augmentation. It also proves raw adaptation of the continuous classical
candidate stopped at any admissible bounded rule.

The classical price bound gives `|U_(t min theta)|<=K`. Thus
`brownian_stoppedCandidate_martingale_of_local` promotes an augmented local
martingale for that precise process to a true martingale on the raw filtration.
The reductions in this module require the global candidate supermartingale
property and augmented local martingality up to first contact. The later
`ContactMartingale.lean` assembly supplies the needed raw true-martingale property
directly, removing that stochastic premise from the final reductions. The
subsequent Gaussian comparison removes the global supermartingale premise too.

This local transfer concerns the particular adapted candidate process, not
all admissible stopping rules or the value supremum. The separate development
below now proves equality of the raw and usual-filtration American values.

## Checked interior approximation and contact-time limit

`LocalizationTimes.lean` constructs actual bounded stopping rules by taking the
first zero of the continuous adapted nonnegative margin

```text
max(0, min(Z_t - eps_n, n+1 - |W_t|, T-t-eps_n)),
eps_n = 1/(n+1),   Z = discounted classical price - discounted payoff.
```

Before this rule all three margins are strictly positive. At a positive exit
time their weak inequalities hold by continuity, still giving a strictly
positive price/payoff gap and remaining maturity. This last statement explicitly
excludes immediate stopping: an initially violated margin need not satisfy the
closed inequalities.

Every rule precedes first contact. On each compact interval strictly before
contact, the gap has a positive minimum and the continuous driver is bounded.
Consequently the rules eventually exceed every pre-contact time and converge
pathwise to first contact. No monotonicity of the sequence is needed here.

`MartingaleLimits.lean` proves that deterministically bounded martingales with
almost-sure limits at every fixed time yield an adapted martingale limit, by
dominated convergence of integrals over earlier measurable events. Continuity
and the classical price bound apply this to converging stopped candidates.

`BrownianInteriorLocalization.lean` combines these facts with bounded promotion
and raw-filtration transfer. Its theorem
`brownian_contact_martingale_of_interior_localMartingales` requires local
martingality of each exact interior-stopped candidate on the null augmentation,
and proves true martingality at first contact on the raw filtration.
The interior martingale properties are now proved from Ito as described next.
This interior-localization theorem alone is not stochastic identification;
the global comparison developed below now completes that identification.
Classical-solution existence remains open.

## Checked contact martingality from the PDE

`CompactLocalization.lean` constructs one globally C3 compactly supported
extension around a whole compact subset of continuation, with zero generator
on that set. `InteriorRegion.lean` proves that each trajectory up to a positive
interior exit stays in an explicit compact time/driver region. One extension
therefore works simultaneously for all such paths.

`InteriorIto.lean` resolves the random-time quantifier issue: a fixed-time
almost-sure Ito identity cannot simply be evaluated at a random time. A
countable dense set, zero pre-exit drift and path continuity give one identity
valid almost surely at every time through a positive exit. Immediate stopping
has zero increment. The stopped price increment is thus indistinguishable from
a stopped, indicated local martingale.

`ContactMartingale.lean` combines stopping stability, transfer under pathwise
almost-sure equality with explicitly adapted continuous targets, bounded
promotion and raw-filtration transfer. The stopping-rule limit gives
`brownianClassicalContactRule_martingale`, with no additional stochastic premise.
The proved expected payoff of this contact rule equals the scaled classical
price, yielding `classicalPrice_le_brownianAmericanPut` against the actual
stopping supremum. The opposite inequality, proved below, establishes optimality.

`brownian_price_identification_of_supermartingale` and
`brownian_boundary_curvature_of_supermartingales` isolate the global
supermartingale premise. `ClassicalSupermartingale.lean` now discharges it.
Existence of a pair satisfying the classical contract remains a separate obligation.

Stopping stability uses the proved upstream **martingale** optional-sampling
and uniform-integrability chain, not its unfinished submartingale counterparts.
The final contact and conditional curvature axiom guards check this distinction.

## Checked Gaussian comparison toward the global upper bound

`WindowComparison.lean` extends the obstacle comparison to a rectangle beginning
at any nonnegative time, not only expiry. The same exercise-boundary test handles
contact; no price second derivative across the boundary is assumed. Subtracting
a small quadratic supersolution, comparing on a sufficiently large rectangle,
and removing the penalty proves comparison on the entire spatial line for
bounded-above tests.

`CompactHeatFlow.lean` proves joint C2 regularity of the Gaussian heat evolution
for C2 compactly supported data. Compact support permits a parameter-dependent
convolution argument. Scaling the data to an exponential bound lets MathFin's
kernel differentiation theorems supply the genuine heat equation. These are
derivatives of comparison functions, not of the American price across exercise.

`BrownianHeatFlow.lean` identifies this heat flow with an actual expectation on
our constructed Brownian space. Dominated convergence proves joint continuity
including time zero, and the Brownian initial value supplies the exact initial
payoff. `LinearPriceComparison.lean` checks drift and discount factors and proves:

```text
0 <= a <= t,  f is C2 with compact support,  f(y) <= p(y,a) for every y
  => exp(-k*(t-a)) * E[f(x+(k-h-1)*(t-a)+W_(2*(t-a)))] <= p(x,t).
```

The time variable here is normalized time remaining; `W` is standard Brownian
motion, so the variance is exactly `2*(t-a)`.

`SmoothMinorants.lean` constructs C2 compactly supported minorants of any
continuous function valued in [0,1]. An expanding inner bump truncates the data;
support-preserving smooth approximation and subtraction of a small outer bump
keep the result below the original function everywhere. The minorants have
absolute value at most 2 and converge pointwise. They need not be nonnegative
or monotone in their sequence index.

`ClassicalHeatComparison.lean` uses this bound for dominated convergence and
proves the inequality for the actual price slice:

```text
0 <= a <= t
  => exp(-k*(t-a)) * E[p(x+(k-h-1)*(t-a)+W_(2*(t-a)),a)] <= p(x,t).
```

This is an unconditional expectation comparison. The next development promotes
it to the conditional inequality for the actual price process.

## Checked global supermartingality and actual-boundary curvature

`IndependentKernel.lean` proves conditional averaging of `H(X,Y)` when `X` is
measurable with respect to the past and `Y` is independent of the past. It uses
the independent product law and Fubini to check integrals on every past-measurable
set, then invokes uniqueness of conditional expectation. The integrand is
bounded and measurable; no Markov axiom is added.

`BrownianTransition.lean` applies this to the constructed Brownian motion. It
checks that `sigma*(W_j-W_i)` has variance `sigma^2*(j-i)` and proves the raw
natural-filtration conditional transition formula. `ClassicalTransition.lean`
checks the normalized-to-physical time, drift and discount identities, giving
`E[U_j | F_i] <= U_i` for `i<=j<=T`.

`ClassicalSupermartingale.lean` handles times beyond maturity using the exact
frozen-process definition. Adaptation and the uniform price bound supply
integrability, completing `brownianClassicalCandidate_supermartingale`.
Together with contact martingality this proves `brownian_price_identification`
without any additional stochastic premise. The boundary is identified with
`K*exp(b(sigma^2*tau/2))` at positive maturities.

`brownian_boundary_conclusions` states weak log curvature and strictly positive
stock-boundary curvature for the actual stopping-value threshold. Named
zero-dividend and Liu-range versions specialize this theorem; they do not
independently formalize the published proofs. All remain conditional on a pair
satisfying the classical contract. Existence/regularity of that pair remains
unproved. The following development proves raw/usual-filtration value equality.

## Checked completion and the usual Brownian filtration

`FiltrationExtension.lean` proves that a uniformly bounded continuous-path
supermartingale remains a supermartingale on the right-continuation of its
filtration. For a past event in `F_(i+)`, compare at times decreasing to `i`
from above and pass the set-integral inequality through dominated convergence.
Adjoining ambient-measurable null sets separately preserves conditional
expectations. `AugmentedValue.lean` first proves value equality for this
right-continuous ambient-null extension.

`CompletedSpace.lean` then genuinely completes the ambient measure space using
Mathlib's completion, rather than treating ambient-null augmentation as full
completion. Original measurable functions have unchanged integrals. Their
bounded supermartingale property transfers by the set-integral criterion.

`brownianUsualFiltration` adjoins all null events in this completed space and
takes the right-continuation. Its `IsComplete` and `IsRightContinuous` instances
are proved. The classical candidate is a supermartingale on this filtration.
All usual-filtration stopping rewards are bounded above by its initial value;
the original contact rule remains admissible and has the same expected reward
after completion. Therefore `brownianUsualAmericanPut_eq_raw` proves equality
of the two financial values for positive initial spot under the classical
contract. The usual contact threshold is identified with the classical boundary,
and `brownianUsual_boundary_conclusions` proves weak log curvature and strict
stock curvature for it. No extra filtration or stochastic premise remains.

The Gaussian grid argument below now also proves raw/usual value equality
without that classical contract. Boundary curvature still requires the contract;
value equality alone does not supply boundary smoothness or a PDE solution.

## Price identification suffices for boundary identification

`DividendContact.lean` proves, for a classical dividend solution,

```text
K*p(log(S/K),t) = max(K-S,0)  iff  S<=K*exp(b(t)),  for S>0,t>0.
```

`ClassicalBridge.lean` then proves that equality between the stopping value and
the scaled classical price identifies the contact threshold automatically.
No separate boundary-identification premise is introduced.

Its final conditional theorem uses

```text
hp : DividendPutSolution (2*r/sigma^2) (2*q/sigma^2) p b,
hprice : for every tau>0,S>0,
  brownianAmericanPut(K,r,q,sigma,S,tau)
    = K*p(log(S/K),sigma^2/2*tau).
```

Together with positive strike/volatility and nonnegative discount rate, these
imply `B''(tau)>0` for the actual Brownian contact threshold. Eventual equality
at positive time transfers derivatives, so no smoothness of the financially
defined threshold is separately assumed in this transfer.

`ClassicalSupermartingale.lean` now proves `hprice` from `hp`, and its final
curvature theorems therefore have no separate price-identification premise.
**Existence of such a classical pair remains unproved.**

## Remaining verification obligations

Joint price continuity is now proved independently of a classical solution.
`MaturityTruncation.lean` caps any admissible rule at a new deterministic
horizon. Pathwise continuity and the bounded put reward give convergence of
expected rewards by dominated convergence, even for a varying sequence of
rules. `MaturityContinuity.lean` uses nearly optimal rules on both sides of
the supremum to prove maturity continuity, including at zero. No optimal rule
is assumed. `JointPriceContinuity.lean` combines this with convexity and the
strike bound: on a neighborhood of any positive spot, all maturity slices
share one Lipschitz constant. This proves joint continuity at positive spot.

`CanonicalPrice.lean` defines `canonicalPrice k h x t` as the completed
usual-filtration value with strike one, rate `k`, dividend `h`, volatility
`sqrt(2)`, spot `exp(x)` and horizon `t.toNNReal`. For nonnegative time these
are exactly normalized coordinates. For `k>=0` its joint continuity, expiry
payoff and bounds `putPayoff x <= p(x,t) <= 1` are checked with no PDE premise.
Clamping negative time only makes the definition total; the classical contract
uses nonnegative times.

The tail condition is also now proved directly, in `SpotDecay.lean`. Each
continuous path has a strictly positive minimum GBM multiplier on `[0,T]`.
For any sequence of spots tending to infinity and any sequence of rules bounded
by `T`, the pathwise put payoff is eventually zero. The strike bound permits
dominated convergence of expected rewards. Applying this to nearly optimal
rules proves decay of the supremum itself; spot monotonicity extends the
sequence argument to the real large-spot limit. Maturity monotonicity makes
the bound uniform over `[0,T]`. `canonicalPrice_decay` and
`canonicalPrice_decay_uniform` transfer these results to log spot and normalized
time, with no classical-solution premise or optimal-rule assumption.

The substantive missing step is to construct a classical solution pair, or to
derive the full classical contract directly from the stopping value. Verification
of any such pair against both raw and usual stopping values is now proved. The remaining
construction still requires positive-time boundary smoothness.
Interior PDE regularity, positivity of the threshold, boundary continuity and
smooth fit and gradient trace are now proved below; none follows merely from the supremum
definition or the spot-convexity proof above.

The identification and resulting boundary properties remain conditional on
existence of that pair; they are not unconditional existence results for the
financial free boundary. This gap remains visible and is not replaced with
an axiom or added as a field of the financial value.

## Strict positivity and full continuation geometry

`PricePositivity.lean` uses the actual Gaussian terminal law to show that the
deterministic maturity rule has strictly positive expected put payoff when
`K,S,sigma,T>0` and `r>=0`. The Gaussian measure gives positive mass to every
nonempty open set; the continuous nonnegative terminal payoff is positive on
one such set and is integrable by the strike bound. The law-transfer identity
gives positivity of its Brownian expectation. Measure completion preserves this
deterministic-rule integral, so positivity of both raw and usual stopping values
follows without a classical solution or raw/usual value-equality premise.

`StrictExerciseGeometry.lean` combines positivity with the attained contact
threshold. The value at the strike is positive, so the threshold is strictly
below strike. Positive price rules out all out-of-the-money payoff contact.
Consequently the complete nonnegative-spot contact set is exactly `[0,B(T)]`,
and strict continuation is equivalent to `B(T)<S`.

For normalized parameters, `canonicalStockBoundary` is the usual-filtration
threshold at strike one and volatility `sqrt(2)`. It starts at one and lies in
`[0,1)` at positive time. `canonicalPrice_contact_iff` and
`canonicalPrice_strict_continuation_iff` characterize its regions in log-spot
coordinates using `exp(x)`. Joint price continuity proves the actual
`canonicalContinuationRegion` is open. This price-positivity checkpoint alone
does not assert `B(T)>0`. The positive threshold and finite logarithmic boundary
are now established in the final section; boundary regularity remains open.

## One-sided boundary continuity and actual first contact

`BoundarySemicontinuity.lean` proves upper semicontinuity of the actual threshold
from maturity continuity of the stopping value. If a test spot is strictly above
the threshold and at most the strike, its strictly positive continuation premium
persists at nearby maturities. If the test spot exceeds strike, the uniform
threshold bound suffices. Thus all nearby thresholds remain below any fixed
strict upper bound for the threshold at the base time. Maturity monotonicity
then proves continuity from shorter maturities. This argument alone does not
prove continuity from longer maturities or the right limit at expiry; those are
now proved for the normalized candidate in the final section. The one-sided
results apply to the raw and usual models, and to `canonicalStockBoundary` with
its real-time clamp.

`ActualContact.lean` no longer needs a classical pair to construct a candidate
exercise rule. Along the frozen normalized log path
`x+(k-h-1)*min(t,T)+sqrt(2)*W(min(t,T))`, the actual canonical price minus payoff
is continuous, adapted, nonnegative and zero at maturity. Its first zero defines
`canonicalContactRule`; `brownianUsualActualContactRule` instantiates it on the
completed usual Brownian space. `canonicalLogPath_exp` verifies the exact GBM
normalization. Contact is attained, all prior points belong to the actual open
continuation region, and contact before expiry lies at or below the stock
threshold. These conclusions use neither boundary smoothness nor the PDE.

Admissibility alone does not establish optimality. The later `ActualOptimality.lean`
now identifies this rule's expected payoff with the stopping supremum, without
a classical pair. Its stopped-martingale characterization is now also proved
below. The full dynamic programming principle and the continuation PDE remain open.

## Finite-grid approximation of the American supremum

`FiniteExerciseGrid.lean` defines the finite exercise set
`{min(i*delta,T) : i=0,...,ceil(T/delta)}`. It contains zero and, for positive
mesh, maturity. Rounding a bounded stopping rule upward to the next mesh point
and capping at `T` produces a stopping rule for the same filtration, valued in
this set and no earlier than the original rule. The stopping-event proof uses
the original rule at `floor(t/delta)*delta`; it needs no usual-filtration
assumption. For `delta_n=1/(n+1)`, rounded times converge pathwise to the original
time, and continuous bounded put rewards converge in expectation.

`BermudanConvergence.lean` defines `GridRule` as all admissible bounded rules
whose times lie in this finite set, not merely one rounded candidate.
`gridAmericanPutValue` is the supremum of their expected payoffs in the original
model. It is bounded above by the American value and below by immediate payoff
and the European maturity expectation. Rounding a nearly optimal American rule
proves `gridValue_tendsto_americanValue`; the American value also equals the
supremum of these grid values. The meshes are not nested, so monotone convergence
is not asserted. The normalized usual-filtration specialization is
`canonicalGridPrice_tendsto`.

This gives an approximation route toward dynamic programming and actual-rule
optimality. Bellman identification and grid-supremum attainment are now proved
below. A quantitative convergence rate is not supplied.
The stock dynamics remain continuous-time Brownian dynamics; no binomial tree
or change of model is introduced.

## General finite-horizon Bellman optimality

`FiniteBellman.lean` defines backward recursion on an arbitrary filtered
probability space with adapted integrable real rewards:
`V_N=Z_N`, `V_i=max(Z_i,E[V_(i+1)|F_i])`. The process is frozen after `N`.
Adaptedness, integrability, pointwise payoff dominance and the supermartingale
property are proved. It is minimal, up to almost-sure comparison before the
horizon, among integrable supermartingales dominating the reward process.

`DiscreteContactMartingale.lean` proves that stopping a discrete process whose
conditional drift vanishes before stopping yields a martingale. Its proof writes
the stopped increment as the unstopped increment times the past-measurable
indicator of not having stopped; conditional-expectation indicator and subtraction
identities give zero drift.

`FiniteBellmanOptimality.lean` constructs the first payoff-contact index using a
bounded discrete hitting time. Contact exists because the terminal Bellman
value equals the reward. Strict pre-contact separation forces the continuation
branch of the recursion, so the stopped Bellman process is a martingale.
Its expected terminal payoff equals the expected initial Bellman value.
Discrete optional stopping and payoff dominance bound every competing bounded
rule by this value. `DiscreteStoppingValue.lean` packages all such natural-index
rules into a supremum and proves both `discreteStoppingValue_eq_bellman` and
`finiteBellmanRule_attains_value`.

This general finite discrete-time stopping-supremum theorem is not a binomial
specialization. Its physical-grid application is now proved by the explicit
reindexing below. The finite-grid Brownian Markov recursion is also proved below;
continuous-time first-contact optimality is proved separately below.

## Attained Bellman optimality on physical exercise grids

`GridReindexing.lean` samples the original filtration at `min(i*delta,T)`.
Every `GridRule` maps to a bounded natural-index rule using its upward-rounded
index. Conversely, every bounded rule in this capped sampled filtration maps
to an admissible physical-time grid rule. Both directions preserve the payoff;
`gridValue_eq_discreteValue` proves equality of their full expected-payoff
suprema. This handles a non-grid-aligned maturity and maturity zero, with
`delta>0`. No underlying process or probability measure is replaced.

`GridBellman.lean` checks adaptedness and integrability of the actual discounted
put reward on this sampled filtration. `gridValue_eq_bellman` identifies the
physical-grid value with the expected initial conditional-expectation Bellman
value. `optimalGridRule` transfers the discrete first-contact rule back to an
actual physical stopping rule; `optimalGridRule_attains_value` proves attainment.
The expected payoffs of these optimal rules converge to the American supremum
by the checked finite-grid convergence theorem.

`canonicalOptimalGridRule` and `canonicalOptimalGridRule_payoffs_tendsto`
instantiate the construction on the completed usual Brownian space and give
convergence to the actual `canonicalPrice`, without a classical-solution premise.
This is convergence of expected payoffs, not convergence of stopping times,
and alone does not prove that the continuous-time first-contact rule is optimal.
The separate vanishing-gap argument below now establishes that optimality.
Identification with a Brownian Markov pricing recursion is now proved below.
The deterministic waiting inequality and actual-price supermartingality are now
proved below. Full continuous-time dynamic programming and PDE regularity remain open.

## Gaussian Markov grid prices and unconditional filtration comparison

`BrownianBellman.lean` defines deterministic functions by backward Gaussian
integration. Writing `s_i=min(i*delta,T)` and `beta=r-q-sigma^2/2`, the recurrence
is

```text
M_0(i,x) = exp(-r*s_i) * max(K-exp(x),0)
M_(n+1)(i,x) = max(M_0(i,x),
  E[M_n(i+1, x + beta*(s_(i+1)-s_i) + sigma*W_(s_(i+1)-s_i))])
```

Discounting is included in the absolute-time reward `M_0`; it must not be
applied a second time to the expectation. The actual definition implements
the Gaussian expectation by `brownianHeatFlow` at variance
`sigma^2*(s_(i+1)-s_i)`. `brownianGridMarkovAux_bound` and
`brownianGridMarkovAux_continuous` prove boundedness and continuity inductively.
`bellmanAux_eq_brownianGridMarkovAux` proves the full conditional-value
identification at each index. At index zero, Brownian motion starts at zero
almost surely, so `brownianGridPrice_eq_gridValue` identifies the deterministic
initial recursion with the complete raw-grid stopping supremum.

`BrownianUsualTransition.lean` constructs the conditional value of a bounded
continuous terminal log-state payoff as an explicit continuous martingale,
frozen after maturity. Completion, null augmentation, and right continuation
preserve this martingale by the previously checked bounded supermartingale
extension, applied to both signs. This proves the exact usual-filtration
Gaussian transition without a classical solution or a new independence premise.

`UsualGridMarkov.lean` uses that transition to prove that the same deterministic
recursion equals the usual-grid value. It converges to `canonicalPrice` in the
normalized model. Uniqueness of the limit gives
`brownianUsualAmericanPut_eq_raw_of_pos` for `K>=0`, `r>=0`, and `S>0`, with
arbitrary real `q` and `sigma`, including maturity zero. This removes the
classical-solution premise from positive-spot raw/usual value equality.

These exact finite-grid dynamic-programming results and value convergence now
also give the waiting inequality and supermartingality below. Full continuous-time
dynamic programming and classical PDE/boundary regularity remain open. Actual
first-contact optimality is now proved below.

## Waiting inequality and actual-price supermartingality

`SampledRules.lean` sends bounded discrete stopping rules to physical stopping
rules for any increasing deterministic schedule. The schedule need not start
at zero; admissibility follows by a countable union of discrete stopping events.
`DelayedGrid.lean` applies this to `u+min(i*delta,T)`. Its conditional Bellman
value at the first index is the discounted Gaussian grid price at the random
log spot reached at time `u`. An optimal rule on this schedule is an admissible
rule for the original American problem with maturity `u+T`.

`AmericanWaiting.lean` passes its expected payoff to the limit by dominated
convergence, using the common strike bound. The result is the actual-price
inequality

```text
exp(-r*u) * E[V(exp(x + (r-q-sigma^2/2)*u + sigma*W_u), T)]
  <= V(exp(x), u+T).
```

`brownianAmericanPut_wait` gives the exact Gaussian heat-flow version for
`K>=0`, `r>=0`, positive spot, and arbitrary real `q,sigma`. The normalized
usual-filtration counterpart is `canonicalPrice_wait`, derived using the
unconditional raw/usual value equality. Waiting durations and remaining
maturities may both be zero. This is an inequality, not the complete dynamic
programming equality for stopping before or after an intermediate time.

`ActualSupermartingale.lean` applies the Brownian conditional transition to
the actual remaining-maturity price and this waiting inequality. It proves
`canonicalDiscountedPrice_supermartingale` on the raw filtration and
`canonicalDiscountedPrice_usual_supermartingale` on the completed usual
filtration. The process is discounted until maturity and then frozen. Its
continuity, uniform unit bound, initial value, and exact difference from the
discounted payoff are proved. That difference is the positive discount factor
times the existing `canonicalGap`, linking it to the actual first-contact rule.

These proofs assume no classical solution, boundary, PDE, or continuous-time
optimal rule. Supermartingality alone does not prove martingality up to first
contact. First-contact optimality is now proved below without first establishing
that full martingale characterization. The characterization is now proved in
`ActualContactMartingale.lean`; classical PDE/boundary regularity remains open.

## Actual first-contact optimality without a classical solution

`OrderedSampling.lean` proves the optional-sampling inequality for any two
ordered bounded stopping rules, by upward grid approximation and bounded
dominated convergence. It also constructs the pointwise minimum of two rules.

`FirstContactOptimality.lean` proves a general theorem for a bounded continuous
supermartingale `U` dominating a bounded continuous reward process `Z` up to
the horizon. Assume admissible rules `theta_n` have expected rewards tending to
`E[U_0]`. Optional sampling then gives

```text
0 <= E[U(theta_n)-Z(theta_n)] <= E[U_0]-E[Z(theta_n)] -> 0.
```

`VanishingGap.lean` converts this to an almost-sure vanishing-gap subsequence
using Mathlib's L1 convergence-in-measure and subsequence theorem. If the gap
is strictly positive before `tau`, continuity and compactness imply
`min(theta_(ns n),tau) -> tau` pathwise on that subsequence. Ordered optional
sampling and dominated convergence give `E[U_tau]=E[U_0]`; payoff contact then
gives `E[Z_tau]=E[U_0]`. This does not assert convergence of the untruncated
stopping rules themselves. A further event-pasting argument below now identifies
the stopped process as a martingale.

`ActualOptimality.lean` discharges every premise on the completed usual Brownian
space. It uses the actual `canonicalDiscountedPrice`, the original discounted
put payoff frozen at maturity, `brownianUsualActualContactRule`, and the already
proved optimal-grid expected-payoff convergence. The final result is
`brownianUsualActualContactRule_optimal`: the contact rule's expected monetary
payoff equals `canonicalPrice k h x T` for `k>=0`, arbitrary real `h,x`, and
nonnegative maturity. Strike is one and volatility is `sqrt(2)`, as in the
canonical definition. This is actual continuous-time optimality, not merely
optimality conditional on a PDE solution or on an assumed optimal rule.

The stopped-martingale characterization is now proved below. The full dynamic
programming principle and classical PDE, smooth-fit and boundary-regularity
obligations remain open.

## Actual stopped martingale and mean-value identity

`OptimalStoppedMartingale.lean` proves a general result over a finite measure:
if a bounded continuous supermartingale has the same expected value at a bounded
rule `tau` as initially, its process stopped at `tau` is a martingale. Ordered
optional sampling first gives expected-value preservation at every earlier rule.
For any event `A` measurable at time `i<=j`, the rule choosing `i` on `A` and
`j` otherwise is admissible; capping it at `tau` preserves the expected value.
Splitting the resulting integral over `A` and its complement gives equality of
the stopped process's set integrals at `i` and `j`. Adaptedness and the conditional
expectation uniqueness criterion then prove the full martingale property.

`ActualContactMartingale.lean` applies that theorem to the actual discounted
canonical price and the already proved optimal first-contact rule. The payoff-gap
identity converts optimal expected payoff to expected-price preservation.
`brownianUsualActualContactRule_martingale` proves the resulting usual-filtration
martingale without any PDE, smooth-fit or boundary-regularity hypothesis.

`canonicalPrice_contact_meanValue` applies bounded optional sampling to it:
at every admissible bounded observation rule `eta`, the expected discounted
remaining-maturity price at `min(eta,tau)` equals the initial canonical price.
This includes observation at deterministic times and bounded interior-exit rules
once those rules have been constructed. The parameters are `k>=0`, arbitrary
real `h,x`, and nonnegative maturity in the normalized strike-one, volatility
`sqrt(2)` model. No independent increments at arbitrary stopping times or general
restart identity is silently inferred from this fixed-start stopped mean-value
statement. The continuation PDE and boundary regularity remain to be derived.

## Local rectangular exit representation

`ContinuationRectangles.lean` uses openness of the actual continuation region:
for every continuation point `(x,T)`, it constructs `R>0` and `0<delta<T` such
that all `(y,T-s)` with `|y-x|<=R` and `0<=s<=delta` remain in continuation.
No exercise-boundary continuity or positive threshold is assumed.

`RectangleExit.lean` constructs the exit as first contact of the nonnegative
continuous adapted margin `max(0,min(R-|X_s-x|,delta-s))`. Before exit, both
inequalities are strict. For paths starting strictly inside and `delta>0`, exit
is positive and attained either on a spatial side or at elapsed time `delta`;
the spatial displacement at exit is at most `R`.

`ActualLocalMeanValue.lean` applies this rule to the normalized Brownian log-price.
The exit geometry holds almost surely, using Brownian motion's initial value.
For a rectangle contained in continuation, exit precedes actual exercise contact
pathwise: earlier exercise contact would have a strictly positive payoff gap.
`canonicalPrice_rectangle_meanValue` therefore removes the contact cap from the
stopped mean-value identity. The canonical price at `(x,T)` equals the expected
discounted canonical price on this rectangle's parabolic boundary.

The representation assumes only `k>=0`, rectangle containment and `delta<=T`;
the existence theorem supplies positive interior rectangles. It does **not** yet
prove differentiability, the continuation PDE, smooth fit or boundary regularity.
No general random-time restart or strong Markov theorem is assumed or inferred.

## Smooth test functions without smoothness of the price

`PlaneDynkin.lean` constructs the explicit residual
`G(t,W_t)-G(0,W_0)-integral_0^t (G_t+G_ww/2)(s,W_s) ds` for a jointly `C3`
plane test `G`. The MathFin Itô identity and continuous paths give simultaneous
almost-sure equality with a local martingale before random-time evaluation.
Raw adaptation is checked. Bounds on `G` and its generator on a finite time slab
then bound the residual stopped at any bounded raw Brownian rule; the checked
bounded-local-martingale promotion proves true stopped martingality. Its expected
residual is zero. Separate integrability proofs yield Dynkin's identity:
the expected stopped test equals its value at `(0,0)` plus the expected stopped
generator integral. Compactly supported `C3` tests automatically satisfy the
bounds, including the generator bound via compact support of derivatives.

`ActualTestFunctions.lean` constructs the same rectangle exit in the raw
filtration and proves its time equals the usual-filtration exit time. Original
measurable integrals are unchanged by completion, so the actual-price rectangle
mean-value identity transfers to the raw space used by Itô. The stopped path
stays in the closed driver-coordinate rectangle almost surely and its exit is
strictly positive for positive radius and duration.

In driver coordinates the discounted price is
`U(s,w)=exp(-k*s)*canonicalPrice(k,h,x+(k-h-1)*s+sqrt(2)*w,T-s)`.
If a compact `C3` test `G` matches `U(0,0)` and bounds `U` above throughout an
interior rectangle, its expected stopped generator integral is nonnegative.
For a lower bound it is nonpositive. Both statements also have versions assuming
the bound only at exit almost surely. These are genuine consequences for the
actual stopping price, not hypotheses about an unknown classical solution.

The price is still used only as a continuous function. The integrated inequalities
are strengthened to pointwise smooth-test conditions below; classical PDE,
interior differentiability, smooth fit and boundary regularity remain open.

## Pointwise pricing tests

`StrictDrift.lean` proves that a strictly positive/negative generator throughout
a closed driver rectangle has a strictly positive/negative expected integral
up to its exit. This is not just monotonicity of the integral: the duration is
strictly positive almost surely, each time integral is integrable, and the
resulting random drift integral is integrable as well. Strict positivity of an
integrable function almost everywhere on a nonzero measure space implies a
strictly positive integral.

`PointwiseTests.lean` constructs continuation rectangles contained in any
prescribed neighborhood of driver origin. If a test touching from above had a
negative generator there, continuity would keep that sign throughout one of
these rectangles. Strict drift contradicts the nonnegative expected integral
proved previously. A lower test is analogous. Multiplication by a smooth bump
preserves the test locally, including its first and second derivatives; this
removes compact support as a hypothesis on the final tests.

`PricingTests.lean` checks the exact coordinate and discounting transformation.
For every actual continuation point `(x,T)`, `k>=0`, arbitrary real `h`, and every
globally jointly `C3` real-plane test `phi` that agrees with the actual canonical
price there and bounds it above on a neighborhood, it proves

```text
phi_t(x,T) <= phi_xx(x,T) + (k-h-1)*phi_x(x,T) - k*phi(x,T).
```

For a lower test the inequality is reversed. The proof checks that the
Brownian-driver generator of the discounted test at origin is exactly
`phi_xx+(k-h-1)*phi_x-phi_t-k*phi`; all derivatives are of the test function.
No boundary, smooth-fit or classical-price premise occurs in these results.

This is a smooth-test formulation of the continuation equation. Equivalence to
a viscosity formulation allowing all `C1,2` local tests is not proved here.
Pointwise tests alone do not assert that the actual price has the displayed
derivatives. Interior classical regularity is now deduced through local
comparison and constructed Dirichlet solutions below. The free-boundary and
smooth-fit obligations still separate this from the full classical contract.

## Local smooth comparison from the test formulation

`SmoothPricingComparison.lean` defines the normalized operator
`P(F)=F_t-F_xx-(k-h-1)*F_x+k*F` and a smooth-test subsolution predicate. It proves
comparison on a closed cylinder `[L,R] x [a,T]` for `k>=0` and `a<T`: a continuous
test-subsolution `u` is below a comparator `F` if `F` is continuous on the closed
cylinder, jointly `C3` in its open interior, satisfies `P(F)>=0` there, and bounds
`u` on the initial and two lateral sides. No terminal boundary bound is assumed.

The proof maximizes `(T-t)*(u-F)` on the compact cylinder. A positive maximum
must lie strictly inside in both space and time: the weight vanishes at `T`,
and the other three sides have nonpositive difference. If its value is `M>0`,
then `F+M/(T-t)` touches `u` from above locally. A compact smooth extension around
that point supplies an admissible global test, without requiring the comparator
to be smooth at the cylinder boundary. The operator gains
`M/(T-t)^2+k*M/(T-t)>0`, contradicting the subsolution test. Continuity and closure
then extend comparison from `t<T` to the terminal slice. This explicitly avoids
using a two-sided local touching test at a merely one-sided terminal maximum.

`ActualSmoothComparison.lean` proves that the actual price and its negative satisfy
the required smooth-test predicates on continuation. Operator linearity gives
both upper and lower comparison. The resulting
`canonicalPrice_eq_smooth_on_cylinder` identifies the actual price with a supplied
continuous, interior-C3 solution of `P(F)=0` matching its initial/lateral values.
Only the open interior of the cylinder needs to lie in continuation.

This is a checked local identification theorem, **not by itself** a construction
or existence theorem for `F`. The construction and its application to actual
continuous parabolic boundary data are now completed below. No price
differentiability, smooth fit, or exercise-boundary regularity was added as an
assumption on the actual price in the comparison proof.

## Constructed initial-data contribution

`ContinuousHeatSmoothing.lean` strengthens the existing heat evolution: continuous
compactly supported data, with no differentiability hypothesis, produces a jointly
smooth heat solution at positive times. The proof puts a smooth cutoff on the
**kernel** factor of Mathlib's parameter-dependent convolution theorem. The cutoff
equals one on the support of the datum, which remains only locally integrable in
that theorem. Thus all derivatives are taken on the kernel side. The generalized
`LinearPriceComparison.lean` chain-rule/PDE lemmas now require only continuous
compact data; the prior classical comparison clients still compile.

`ContinuousPriceEvolution.lean` uses the explicit discounted, drifted Gaussian
evolution already defined as `linearPriceEvolution`. For any continuous compact
datum `f`, any `k,h,a`, it constructs `U` with all of the following checked:

- joint continuity, including the initial time;
- exact initial value `U(x,a)=f(x)`;
- joint smoothness of every order for `t>a`;
- `pricingOperator(k,h,U)=0` for `t>a`.

A continuous compact cutoff extension then matches the actual canonical price's
time-`a` trace on any prescribed finite spatial interval `[L,R]`. The resulting
`exists_canonicalPrice_initial_solution` supplies a constructed smooth PDE
solution with exactly that initial trace, rather than assuming its existence.

This is only the initial-data contribution to the cylinder Dirichlet problem.
Its lateral values at `L` and `R` are generally not the actual price's values.
The corresponding two-sided heat correction, pricing-coordinate transformation
and assembly are constructed below. The initial contribution alone does not
satisfy the local-identification theorem's full hypotheses. Smooth fit and
free-boundary regularity remain open after the full interior construction.

## Half-line boundary kernel and continuous boundary trace

`HeatBoundaryKernel.lean` defines, for the diffusivity-`1/2` Gaussian kernel,
`H(t,x)=x*K(t,x)/t`. For positive elapsed time it proves joint smoothness and
the exact derivative identities

```
H_x  = (t-x^2)/t^2 * K(t,x)
H_xx = x*(x^2-3*t)/t^3 * K(t,x)
H_t  = x*(x^2-3*t)/(2*t^3) * K(t,x) = H_xx/2.
```

For `x>0`, `H` is positive on positive elapsed times and its time integral is
exactly one. The proof uses the inverse-square substitution `t=y^(-2)` and
the half-Gaussian integral; integrability is proved, not assumed. The scaling
identity `x^2*H(x^2*s,x)=H(s,1)` then gives a fixed integrable density.

`HeatBoundaryExtension.lean` defines

```
V_g(x,t) = integral over s>0 of H(s,1)*g(t-x^2*s).
```

For bounded continuous `g`, dominated convergence proves joint continuity,
including `x=0`, where `V_g(0,t)=g(t)`. Consequently the boundary trace holds
under joint space/time approach. It preserves the bound `|V_g|<=C` whenever
`|g|<=C`, and if `g` vanishes for `t<=a`, so does `V_g`. For `x>0` the scaling
substitution identifies this formula with the usual boundary integral
`integral over s>0 of H(s,x)*g(t-s)`.

The extension's interior smoothness and PDE are now proved for continuous
compact boundary data, as described next. The two-sided interval heat correction
is now constructed in the subsequent section. Neither interior regularity of the
actual price nor the full classical pricing contract follows from this
half-line checkpoint alone.

## Constructed half-line heat solution

`FlatHeatKernel.lean` proves that `t^p*expNegInvGlue(t)` is smooth for every real
power `p`, including negative fractional powers. For each finite derivative
order, the proof factors this expression into a sufficiently high real power
and a polynomial in `1/t` times the smooth flat exponential. This handles the
singularity at elapsed time zero explicitly.

The resulting `causalHeatBoundaryKernel` agrees with `H(t,x)` for `t,x>0`, is
zero for `t<=0`, and is jointly smooth whenever `x` is nonzero. Its heat equation
holds for every elapsed time at `x>0`, including zero. At nonpositive elapsed
times its spatial slice is identically zero; nonnegativity supplies a temporal
minimum and hence a zero time derivative.

For continuous compact `g`, `HeatBoundarySmoothing.lean` proves all-order
interior smoothing of

```
integral over y in R of causalHeatBoundaryKernel(t-y,x)*g(y).
```

The proof again places a compact cutoff on the kernel rather than
differentiating `g`. A checked reflection/translation change of variables
identifies this integral with the existing `heatBoundaryExtension` for `x>0`.

`CompactKernelDerivative.lean` supplies a derivative-under-the-integral theorem:
jointly continuous kernel derivatives on an open parameter set have a uniform
bound on a small closed parameter ball times the compact support of `g`.
That bound times `|g|` is integrable. `HeatBoundaryEquation.lean` applies this
theorem to the temporal and first/second spatial derivatives, then integrates
the causal kernel's PDE. Thus the boundary extension satisfies `V_t=V_xx/2`
at every interior point `x>0`.

`exists_halfLine_heat_boundary_solution` now constructs `V` from continuous
compact `g` vanishing for `t<=a`, with all of these conclusions:

- joint continuity, including at the initial/boundary corner;
- exact boundary values `V(0,t)=g(t)`;
- zero values for `t<=a`;
- all-order interior smoothness for `x>0`;
- the heat equation `V_t=V_xx/2` for `x>0`.

This half-line result is used in the two-sided construction below, followed by
pricing-coordinate assembly and actual interior regularity. Smooth fit and
free-boundary regularity remain open.

## Constructed two-sided interval heat correction

`HeatBoundaryContraction.lean` proves that for every positive interval width `L`
and finite nonnegative duration `D`,

```
0 <= c(L,D) = integral over 0<s<=D of H(s,L) < 1.
```

The strict inequality follows from the strictly positive kernel mass after `D`
and the proved total mass of one. For a datum vanishing before `a`, propagation
to the opposite boundary before `a+D` therefore has norm at most `c(L,D)` times
the datum's uniform norm.

The causal bounded continuous functions form a checked closed, complete metric
space. With a compact time cutoff `chi`, bounded by one and zero after `a+D`,
`CoupledHeatBoundary.lean` applies the contraction theorem to the coupled map

```
(f0,f1) -> (g0 - chi*V_f1(L,.), g1 - chi*V_f0(L,.)).
```

The fixed point is constructed, not assumed. Its inputs satisfy both boundary
equations exactly; they are compactly supported when the supplied data and
cutoff are compact. This permits reuse of the proved half-line smoothness/PDE
without differentiating a convergent series.

`IntervalHeatBoundary.lean` constructs the cutoff equal to one on `[a,T]` and
sets `V(x,t)=V_f0(x,t)+V_f1(L-x,t)`. Reflection preserves the second spatial
derivative, and the two fixed-point equations give the exact endpoint traces.
The final `exists_interval_heat_boundary_solution_continuous` theorem assumes
only globally continuous data `g0,g1` vanishing for `t<=a` and `L>0`; compact
support is supplied by a cutoff preserving both data on `[a,T]`. It constructs:

- a jointly continuous `V`;
- `V(x,t)=0` for `t<=a`;
- `V(0,t)=g0(t)` and `V(L,t)=g1(t)` for `a<=t<=T`;
- all-order interior smoothness for `0<x<L`;
- `V_t=V_xx/2` throughout that spatial interior.

This closes the zero-initial-data **heat** boundary correction. The next section
performs the pricing-coordinate assembly and local identification. Actual-price
interior regularity is not a conclusion of the heat checkpoint alone.

## Constructed pricing Dirichlet solution and actual interior regularity

`HeatPricingTransform.lean` uses a fixed-endpoint transformation. With
`alpha=k-h-1`, set

```text
G(x,t) = exp(-alpha*(x-L)/2 - (k+alpha^2/4)*(t-a)),
C(x,t) = G(x,t) * V(x-L, 2*(t-a)).
```

The checked identity is `P(C)=G*(2*V_t-V_xx)` at the transformed point.
It converts the diffusivity-`1/2` heat solution to the pricing equation while
keeping the two spatial endpoints fixed. `PricingBoundaryCorrection.lean`
rescales each continuous lateral datum and divides it by the nonzero gauge,
constructs the heat correction, and transforms back. The result has exact
lateral traces on `[a,T]`, vanishes for `t<=a`, and is smooth and solves the
pricing PDE in the spatial interior. No sign assumption on `k,h` is needed for
this analytic construction.

`PricingDirichlet.lean` starts with any globally continuous function `u(x,t)`.
The compactly extended initial trace gives the previously constructed evolution
`U`. Its left residual is extended as
`g0(t)=u(L,max(a,t))-U(L,max(a,t))`, and similarly on the right. These data are
continuous and zero for `t<=a` because `U` already matches the initial endpoints.
The boundary correction `C` therefore applies. The sum `F=U+C` is continuous,
matches `u` on the initial and two lateral sides, is jointly smooth inside the
cylinder, and satisfies `P(F)=0` there. Existence is constructed rather than
assumed, and no derivatives of `u` are required.

`ActualInteriorRegularity.lean` places a small cylinder around each point of the
open actual continuation region, applies this construction to `canonicalPrice`,
and invokes the checked comparison theorem. Thus the actual price agrees with
`F` on a neighborhood. Smoothness and derivatives transfer through this local
equality. The final statements, for `k>=0`, are:

- `canonicalPrice_contDiffOn`: joint all-order smoothness on actual continuation;
- `canonicalPrice_continuation_pde`: at every actual continuation point,
  `p_t=p_xx+(k-h-1)*p_x-k*p`.

Neither assumes a classical pricing pair, smooth fit, price differentiability,
or boundary regularity. Guarded transitive axiom audits cover the transformation,
both constructed existence results, local identification, smoothness and PDE.
They allow only `propext`, `Classical.choice` and `Quot.sound`.

This closes **interior** regularity, not classical-pair existence. Positivity of
the stock threshold, full boundary continuity and smooth fit are proved below.
The gradient trace is proved below; positive-time boundary smoothness remains open.
The independent published CCJZ strict-log-curvature proof also remains separate.

## Positive exercise threshold and actual logarithmic boundary

For `k>0` and `0<=h<=k`, `StationaryPutCap.lean` constructs `m>0` and `d<0` with

```text
exp(d)=m/(1+m),
k+(k-h-1)*m-m^2 >= 0.
```

The stationary comparator is `1-exp(x)` for `x<=d` and
`(1-exp(d))*exp(-m*(x-d))` for `x>d`. The two branches match in value and slope.
The exponential branch dominates the intrinsic value everywhere: the two
inequalities `exp(-m*s)>=1-m*s` and `m*exp(s)>=m+m*s` prove the required bound.
Both branches have nonnegative pricing operator on their respective sides.

The second derivative may jump at `d`. `UpperSupportComparison.lean` therefore
does not assume a globally smooth comparator. At a hypothetical positive
maximum of actual price minus comparator, payoff domination puts the price in
continuation, where it has the proved interior derivatives. A smooth function
touching the comparator from above gives the spatial maximum and one-sided
terminal-time derivative inequalities. The strictly positive rate contradicts
the PDE. At the join, the exponential branch supplies this upper support.

`PositiveExerciseBoundary.lean` adds `epsilon>0`, truncates spatially, and applies
this checked comparison. On the left, `p<=1` and `exp(L)<=epsilon` suffice; on
the right, the proved uniform price decay suffices. Letting epsilon decrease to
zero proves the global stationary price bound for all nonnegative maturities.
Since the bound equals the payoff below `d`, those points must be in exercise.
Consequently `exp(d)<=canonicalStockBoundary(k,h,t)` uniformly in `t>=0`.

The final checked conclusions include:

- `canonicalStockBoundary_uniform_pos`, with a constructed positive lower bound;
- a named zero-dividend positivity specialization;
- `canonicalLogBoundary=log(canonicalStockBoundary)` with a proved positive argument;
- its zero initial value, negative positive-time values, and exact exponential recovery;
- actual-price value matching and continuation exactly above this log boundary.

No classical pricing contract, smooth fit, boundary continuity, or optimal
perpetual-option formula is assumed. This comparator is only a proved upper
bound; it is not asserted to be the perpetual option value. Guarded audits allow
only the three standard axioms. Boundary continuity and smooth fit are proved
below, as is the gradient trace; positive-time boundary smoothness remains open.

## Full actual-boundary continuity, including expiry

`ContinuationSlice.lean` derives maturity monotonicity directly from the stopping
supremum and hence `p_t>=0`. For the intrinsic premium
`f(x,t)=p(x,t)-(1-exp(x))`, the proved continuation PDE gives

```text
f_xx + (k-h-1)*f_x - k*f >= k-h*exp(x).
```

On any closed spatial interval strictly below strike, the right side is bounded
below by a positive constant when `k>0` and `0<=h<=k`. A generic scalar maximum
lemma shows that a nonnegative profile with this forcing cannot have arbitrarily
small values at both endpoints: maximize `f(x)-eta*(x-c)^2` on `[c-rho,c+rho]`,
choosing `2*eta*(1+abs(k-h-1)*rho)` smaller than the forcing. Small endpoint
values force an interior maximum; its first- and second-derivative inequalities
contradict the forcing. The maximum and all constants are constructed.

Consequently an interval below strike cannot become continuation at every time
immediately after a time when its endpoints were in payoff contact. Joint price
continuity supplies the small endpoint premiums. No derivative convergence,
initial-time PDE, smooth-fit assertion, or parabolic boundary regularity is used.

`ActualBoundaryContinuity.lean` applies this to rule out a downward threshold
jump. If every later threshold were at most `u<B(a)`, positivity gives `u>0` and
one can choose a compact log-price interval strictly between `log(u)` and
`log(B(a))`, below strike. The interval's endpoints were in contact at `a`
(using the exact initial payoff if `a=0`) but every interior point would be in
continuation at every later time, contradicting the slice lemma.

Thus for each `u<B(a)` there is a later `t` with `u<B(t)`. Threshold monotonicity
turns this into lower semicontinuity; the previously proved upper semicontinuity
completes continuity. Positivity permits composition with the logarithm. Checked
results include:

- `canonicalStockBoundary_continuousAt` at every nonnegative maturity;
- `canonicalLogBoundary_continuousOn` on `[0,infinity)`, including expiry;
- `canonicalLogBoundary_antitoneOn` and a named zero-dividend continuity result.

The time clamp supplies the two-sided statement at zero; the substantive part
is the right-hand limit. Guarded transitive audits allow only the three standard
axioms. Smooth fit and the continuation-side gradient trace are proved below;
positive-time boundary smoothness remains missing from the classical contract.

## Optimal contact times shrink to zero at exercise

`BrownianGerm.lean` samples the constructed Brownian motion at
`t_n=(n+1)^(-2)` and sets `Z_n=(n+1)*W(t_n)`. It proves that every `Z_n` has
standard Gaussian law. These overlapping evaluations are **not** asserted to
be independent. The event `Z_n<-1` infinitely often is measurable in every
positive-time natural filtration, hence in the Brownian germ sigma algebra.
The pinned BrownianMotion package's proved `IsBrownianReal.indep_zero` makes its
probability zero or one.

Probability zero is excluded by bounded convergence. The continuous test
`F(z)=max(0,min(1,-z-1))` lies in `[0,1]`, vanishes for `z>=-1`, and has strictly
positive standard-Gaussian expectation. If there were only finitely many negative
probes almost surely, `F(Z_n)` would tend to zero almost surely. Bounded convergence
would force their expectations to tend to zero, contradicting their common
positive Gaussian expectation. Thus the negative germ event has probability one.

On this single event, for every real drift `mu`, every `sigma>0`, and every
`delta>0`, there is a time `0<s<delta` with `mu*s+sigma*W(s)<0`. This follows from
the checked sampling scale and `mu/(n+1)->0`; no law of the iterated logarithm,
reflection principle or independent-samples premise is needed.

`ContactTimeBoundary.lean` then proves

```text
for almost every Brownian path,
  firstContactTime(x,T) -> 0 as x -> canonicalLogBoundary(k,h,T),
```

for `k>0`, `0<=h<=k`, and `T>0`, under the completed Brownian measure. Choose an
early downward excursion shorter than both the requested tolerance and `T`.
All sufficiently nearby starting prices then lie below the time-`T` boundary
at that excursion. Since the boundary increases as remaining maturity decreases,
they have reached exercise by then. The previously proved pre-contact
continuation property gives the contact-time bound and hence the limit.

These are the actual first-contact rules whose optimality was already proved;
no assumed convergence or replacement family of stopping rules is used. The
limit allows approaches from either side of the boundary. Guarded audits include
the upstream zero-one theorem, Gaussian scaling, germ measurability, probability
one, drifted excursions and the final contact-time limit. All use only the three
standard axioms.

This probabilistic regularity result alone is **not smooth fit**. The next
section combines it with optimality and bounded logarithmic-payoff difference
quotients to prove the boundary derivative. Its continuation-side trace and
positive-time boundary smoothness remain open.

## Smooth fit of the actual stopping price

`PayoffSlope.lean` proves that `max(1-exp(x),0)` is globally 1-Lipschitz. On
the negative half-line the exponential derivative is at most one; the checked
proof uses the elementary exponential tangent inequality and handles crossing
the payoff kink separately. Consequently, for any fixed stopped time `s>=0`
and log-return `D`, the quotient

```text
exp(-k*s) * (payoff(x+D)-payoff(b+D)) / (x-b)
```

has absolute value at most one for `k>=0`. This remains valid for an unbounded
stock multiplier and at `x=b`, where Lean's total division gives zero.
Only the punctured right-hand limit is used for differentiation.

As `x->b<0`, with `s(x)->0` and `D(x)->0`, both payoff arguments eventually lie
below strike. The quotient then equals
`-exp(-k*s(x)+D(x))*slope(exp,b,x)` and tends to `-exp(b)`.
`StoppedSlopeExpectation.lean` identifies this expression with the normalized
GBM stopped-reward difference quotient for the actual optimal rule chosen at
`x`. The previously proved contact-time limit and Brownian path continuity at
zero give the required almost-sure limit. Checked measurability, the constant
bound one and filter-form dominated convergence pass it through expectation.

`ActualSmoothFit.lean` compares the actual price quotient to these quantities.
For `x>b`, the rule optimal at `x` is also admissible at `b`, so

```text
(payoff(x)-payoff(b))/(x-b)
  <= (p(x,t)-p(b,t))/(x-b)
  <= E[(reward(x,tau_x)-reward(b,tau_x))/(x-b)].
```

The left bound uses payoff domination and the already proved value matching;
the right uses proved optimality at `x` and the stopping supremum at `b`.
Both outside terms tend to `-exp(b)`, proving the middle limit. Thus, for
`k>0`, `0<=h<=k` and `t>0`, `canonicalPrice_smooth_fit` proves exactly

```text
HasDerivWithinAt (fun x => canonicalPrice k h x t)
  (-exp(canonicalLogBoundary k h t))
  (Ici (canonicalLogBoundary k h t)) (canonicalLogBoundary k h t).
```

This is the `smooth_fit` field of the classical pricing contract, now proved
for the actual candidate without assuming a classical solution or boundary
differentiability. A named zero-dividend specialization is checked. Guarded
transitive audits of the payoff bound, expectation limit, optimality comparison
and final smooth-fit theorem allow only the three standard axioms.

The distinct `gradient_trace` field asserts convergence of the **interior
derivatives**, not of difference quotients at the boundary. It is proved next.

## Actual continuation-side gradient trace and the remaining contract field

`ConvexDerivativeTrace.lean` proves the following general real-variable fact.
Suppose `f` is convex on `[B,infinity)`, differentiable on `(B,infinity)`, and
has right derivative `d` at `B`. For `S>B`, convexity gives

```text
slope(f,B,S) <= f'(S) <= slope(f,S,2*S-B)
  = 2*slope(f,B,2*S-B) - slope(f,B,S).
```

Both bounds tend to `d`, so `f'(S)` tends to `d` from the right. The proof needs
no second derivative and makes no assertion of convexity in log coordinates.

`ActualGradientTrace.lean` defines `canonicalStockPrice` as the same actual
stopping value at stock spot `S`. Its convexity comes from `SpotShape.lean`.
The logarithmic chain rule converts the proved smooth fit to stock derivative
`-1` at the positive stock boundary. Actual interior smoothness gives stock
differentiability above that boundary. The secant lemma therefore proves the
stock gradient trace. The exponential chain rule then gives exactly

```text
Tendsto (fun x => deriv (fun y => canonicalPrice k h y t) x)
  (nhdsWithin (canonicalLogBoundary k h t) (Ioi (canonicalLogBoundary k h t)))
  (nhds (-exp(canonicalLogBoundary k h t))).
```

This holds for `k>0`, `0<=h<=k` and `t>0`, without a classical solution or
boundary-differentiability premise. Named zero-dividend and Liu-range results
are checked, with guarded transitive audits allowing only the three standard
axioms.

`ActualClassicalContract.lean` now proves
`canonicalPrice_dividendPutSolution_of_boundary_smooth`: the actual price and
constructed log boundary satisfy `DividendPutSolution` provided that
`ContDiffOn R infinity (canonicalLogBoundary k h) (Ioi 0)` holds. Every other
contract field is discharged by proved actual-price results, including the
gradient trace. Zero-dividend and Liu-range assemblies retain precisely this
same explicit remaining hypothesis; they are not independent published proofs.

Positive-time boundary smoothness is **not yet proved**. Consequently the full
unconditional classical contract and unconditional curvature theorem are still
unfinished. The separate full dynamic programming and independent CCJZ proof
tracks also remain open.

## Joint spatial-gradient continuity across the actual boundary

`ActualSpatialRegularity.lean` first joins the left exercise derivative to the
proved right smooth fit. Hence `canonicalPrice` is differentiable in log spot
at every positive maturity, including exercise and boundary points, without any
boundary differentiability premise. The logarithmic change of coordinates
gives the same fact for `canonicalStockPrice` at all positive stock spots.

`ConvexSliceGradient.lean` proves a general parameter-dependent convexity
lemma. For a jointly continuous family with differentiable convex spatial
slices, the spatial derivatives are jointly continuous. At a reference point
`(S,t)`, choose `L<S<R` whose secants approximate the derivative there.
Convexity bounds the derivative at nearby `(S',t')` between the secants with
fixed endpoints `L` and `R`. Both secants are continuous in `(S',t')`, so the
bounds prove joint continuity by the order characterization of limits.

Applying this lemma in stock coordinates, then using the exponential chain
rule, proves `canonicalPrice_gradient_continuousAt` at every `(x,t)` with
`t>0`. Unlike the preceding fixed-time trace, both spot and maturity may vary
and the approximating points may cross the exercise boundary. The theorem does
not assert joint differentiability of the price in time and space. Named
zero-dividend and Liu-range specializations are checked.

## Locally uniform nondegeneracy on the continuation side

Let `u(x,t)=p(x,t)-(1-exp(x))`, the intrinsic premium (used here below strike).
`ActualBoundaryNondegeneracy.lean` proves that its spatial gradient is jointly
continuous and that `u=u_x=0` at the actual boundary. The previously proved
interior PDE and time monotonicity give

```text
u_xx >= F(x,s),
F(x,s) = k-h*exp(x) - (k-h-1)*u_x(x,s) + k*u(x,s).
```

The new gradient result makes `F` jointly continuous near every positive-time
boundary point `(b(t),t)`. At that point,
`F(b(t),t)=k-h*exp(b(t))>0`, since `k>0`, `h<=k` and `b(t)<0`.
Consequently, throughout some neighborhood of that point, all continuation
points satisfy

```text
u_xx(x,s) >= (k-h*exp(b(t)))/2 > 0.
```

`canonicalIntrinsicPremium_deriv2_lower_near_boundary` proves this exact
locally uniform statement. Its zero-dividend specialization has lower bound
`k/2`; a Liu-range checkpoint is also explicit. Guarded transitive axiom audits
cover the convex-slice lemma, actual cross-boundary differentiability, joint
gradients and the nondegeneracy results, allowing only `propext`,
`Classical.choice` and `Quot.sound`.

This does not prove a second-derivative trace, differentiability of the boundary,
or boundary curvature in time. It supplies quantitative spatial nondegeneracy
for the remaining boundary-regularity problem; the unconditional classical
contract is still unfinished.

## Uniform quadratic separation and quantitative boundary increments

`QuadraticSeparation.lean` proves an elementary integration lemma. Suppose
`f(b)=f'(b)=0`, both `f` and `f'` are continuous on `[b,R]`, and `f''>=C`
in its interior. The mean value theorem first gives `f'(x)>=C*(x-b)`.
Applying derivative monotonicity to `f(x)-C/2*(x-b)^2` gives
`f(x)>=C/2*(x-b)^2`. A second derivative at the endpoints is not assumed.

`ActualQuadraticSeparation.lean` applies this to the actual intrinsic premium
`u=p-(1-exp(x))`. Fix `t>0` and set `A=k-h*exp(b(t))>0`. Joint gradient
continuity, boundary continuity and the proved local second-derivative bound
give a radius `delta>0` such that, for every nearby maturity `s`,

```text
b(s) <= x <= b(s)+delta  implies
  u_x(x,s) >= A/2*(x-b(s)),
  u(x,s)   >= A/4*(x-b(s))^2.
```

The same radius works uniformly for `abs(s-t)<delta`, and these maturities
are positive. The proof explicitly confines every intermediate spatial point
to the neighborhood where the second-derivative bound holds.

`ActualBoundaryIncrement.lean` then shrinks the maturity neighborhood so that
both boundaries lie within the same separation interval. For nearby `s<=v`,
write `D=b(s)-b(v)>=0`. Evaluation at the earlier exercise spot `x=b(s)` gives

```text
A/2*D   <= p_x(b(s),v)-p_x(b(s),s),
A/4*D^2 <= p(b(s),v)-p(b(s),s).
```

Value matching and the proved two-sided spatial smooth fit identify the earlier
price and gradient; boundary monotonicity supplies the sign of `D`. These are
actual stopping-price results, without a classical-pair or boundary-smoothness
premise. Named zero-dividend results use constants `k/2` and `k/4`; Liu-range
results are also explicit. Guarded transitive audits allow only the three
standard axioms throughout.

These estimates transfer quantitative temporal control of the price or its
spatial gradient to control of boundary increments. They do not by themselves
prove a temporal Lipschitz/Hölder estimate, differentiability of the boundary,
or the outstanding positive-time boundary smoothness. Those steps remain open.

## Actual temporal comparison without a smooth-boundary premise

`ActualStrictSpatialSlope.lean` proves `p_x(x,t)>-exp(x)` in continuation.
In stock coordinates, convexity puts the derivative above the secant from the
exercise boundary, and strict value/payoff separation makes that secant greater
than `-1`. The exponential chain rule gives the log-coordinate inequality.

For `delta>=0`, define `W(x,t)=p(x,t+delta)-p(x,t)`.
`ActualTimeIncrement.lean` proves its continuity and its pricing PDE wherever
the earlier point is in continuation. At a positive spatial maximum, the
earlier point cannot be in exercise: the later price is strictly above payoff,
its derivative exceeds `-exp(x)`, and the earlier exercise derivative equals
`-exp(x)`, contradicting `W_x=0`. Both points are therefore in continuation.
The interior PDE, a nonpositive second spatial derivative, a nonnegative
left-time derivative and `k>0` exclude a positive space-time maximum.

`ActualTemporalComparison.lean` applies this argument on a finite rectangle,
including its terminal time. It then removes the spatial truncation: on the
left `W<=exp(x)`, and on the right the uniform price tail tends to zero.
Consequently, if `C>=0` and `p(x,delta)-payoff(x)<=C` for all `x`, then
`W(x,t)<=C` for every `x` and `t>=0`. No full dynamic-programming theorem or
free-boundary derivative is used.

## A single at-strike price controls temporal and boundary increments

`ActualTemporalModulus.lean` proves that `u=p-(1-exp(x))` is increasing in
space: its derivative is zero in exercise and strictly positive in continuation.
Thus, below strike, the price/payoff gap is bounded by its value at strike.
Above strike, price monotonicity gives the same bound. The largest expiry gap
is therefore bounded by `p(0,delta)`. The preceding temporal comparison and
time monotonicity yield

```text
abs(p(x,t)-p(x,s)) <= p(0,abs(t-s))     (s,t >= 0).
```

Joint price continuity and the zero expiry payoff at strike prove
`p(0,delta)->0` as `delta->0`. This modulus is uniform in log spot and in both
maturities. Named zero-dividend and Liu-range specializations are checked.
An explicit power-law rate is now proved in the following section.

`ActualBoundaryTemporalModulus.lean` combines this with the earlier quadratic
separation result. Fix `t0>0` and `A=k-h*exp(b(t0))>0`. For nearby `s<=v`,

```text
A/4*(b(s)-b(v))^2 <= p(0,v-s).
```

This is an actual stopping-price and boundary statement, without a classical
contract or boundary-smoothness premise. Zero-dividend and Liu-range results
are explicit. Guarded transitive audits cover the strict slope, time-increment
PDE, maximum principle, global comparison, scalar modulus and boundary
consequence, allowing only the three standard axioms.

The explicit short-maturity upper bound at strike is now proved below. It does
not itself prove the outstanding positive-time boundary smoothness; the full
unconditional classical contract remains open.

## An explicit expiry cap and quantitative temporal rates

`ExpiryUpperCap.lean` defines, with `alpha=k-h-1`,

```text
U(x,t) = (sqrt(x^2+4*t)-x)/2 + abs(alpha)*t.
```

For `t>=0`, it dominates both zero and `-x`, hence the put payoff. It is jointly
continuous, including at expiry, and smooth at positive times. Writing
`r=sqrt(x^2+4*t)`, its derivatives are

```text
U_x  = (x/r-1)/2,       abs(U_x) <= 1,
U_xx = 2*t/r^3,
U_t  = 1/r+abs(alpha).
```

Since `2*t/r^3<=1/r`, the diffusion residual is nonnegative. The drift correction
dominates `alpha*U_x`, and `k*U>=0`, proving the pricing supersolution inequality.
All derivatives and signs are checked, not postulated.

`ActualExpiryUpperBound.lean` applies actual-price upper-support comparison to
`U+epsilon` on a finite rectangle. On a sufficiently negative left edge,
`U>=1>=p`; on the right, price decay supplies the `epsilon` bound. Sending
`epsilon` to zero gives `p<=U`. At strike this yields, for every `t>=0`,

```text
p(0,t) <= sqrt(t)+abs(k-h-1)*t.
```

The earlier temporal comparison therefore proves, uniformly over all log spots
and all nonnegative maturities,

```text
abs(p(x,t)-p(x,s)) <= sqrt(abs(t-s))+abs(k-h-1)*abs(t-s).
```

This is a square-root temporal rate; it uses no European formula or
classical-solution premise. Zero-dividend and Liu-range specializations are
explicit.

## A local quarter-power modulus for the actual log boundary

Fix `t0>0` and `A=k-h*exp(b(t0))>0`. The preceding results give, for nearby
ordered maturities `s<=v`,

```text
A/4*(b(s)-b(v))^2 <= sqrt(v-s)+abs(k-h-1)*(v-s).
```

`ActualBoundaryQuarterBound.lean` shrinks the neighborhood so `v-s<=1`, bounds
the linear term by a multiple of the square root, and takes another square
root. It proves that there are `eta>0` and `C>0` such that **every pair** of
maturities in that neighborhood satisfies

```text
dist(b(s),b(v)) <= C*sqrt(sqrt(dist(s,v))).
```

The nested square root is the quarter-power modulus for nonnegative distance.
One checked choice of constant is
`C=1+4*(1+abs(k-h-1))/A`. The proof treats both maturity orderings explicitly.
Named zero-dividend and Liu-range boundary estimates are retained.

Guarded transitive audits cover the cap supersolution, actual comparison,
temporal rates and quarter-power boundary estimate, allowing only the three
standard axioms. This strengthens continuity to a quantitative local modulus;
it does **not** prove boundary differentiability, higher regularity, or the full
unconditional classical pricing contract. Positive-time boundary smoothness
remains the outstanding contract obligation.

## Parabolic dilation, temporal Lipschitz bounds, and half-power boundary continuity

The actual intrinsic premium is `u(x,t)=p(x,t)-(1-exp(x))`. Without boundary
derivatives, the development proves `0<=u<=exp(x)` and, at every positive
maturity, `0<=u_x<=exp(x)`. In exercise `u=u_x=0`; in continuation `u_x>0`.
Its exact continuation equation is

```text
u_t = u_xx + alpha*u_x - k*u - k + h*exp(x),  alpha=k-h-1.
```

`ActualPremiumDilation.lean` defines
`W_rho(x,t)=u(rho*x,rho^2*t)-u(x,t)`. When both evaluation points are in
continuation, its pricing-operator source is exactly

```text
alpha*rho*(rho-1)*u_x(rho*x,rho^2*t)
  - k*(rho^2-1)*u(rho*x,rho^2*t)
  + k*(1-rho^2) + h*(rho^2*exp(rho*x)-exp(x)).
```

For `1<=rho<=2`, `DilationWeight.lean` and `ActualDilationComparison.lean`
bound this source and the expiry error using

```text
w(x) = exp(3*x)+exp(-3*x)
D = (2*abs(alpha)+4*h+1)*(rho-1)
E(x,t) = D*exp((10+3*abs(alpha))*t)*w(x).
```

The barrier has nonpositive spatial derivative below strike and pricing
operator at least `D*w(x)` for nonnegative time. At a positive maximum of
`W_rho-E`, the scaled point cannot be in exercise because its premium would
be zero. The unscaled point cannot be in exercise either: the corrected
spatial derivative would then be strictly positive. Both points therefore
lie in continuation, where the PDE rules out the maximum. Explicit far-left
and far-right bounds justify the finite-rectangle truncation. This proves
`W_rho<=E` on the whole line for every nonnegative maturity.

`ActualTemporalDerivativeBound.lean` differentiates the proved inequality at
`rho=1`, giving

```text
x*u_x(x,t)+2*t*u_t(x,t)
  <= (2*abs(alpha)+4*h+1)*exp((10+3*abs(alpha))*t)*w(x).
```

For `0<a<=t<=T`, the continuation price time derivative is bounded above by

```text
M(x,a,T) = ((2*abs(alpha)+4*h+1)*exp((10+3*abs(alpha))*T)*w(x)
             + abs(x)*exp(x))/(2*a).
```

`ActualTemporalLipschitz.lean` proves that this bound controls **all** price
increments on `[a,T]`, not only those whose intermediate points are in
continuation:

```text
abs(p(x,t)-p(x,s)) <= M(x,a,T)*abs(t-s).
```

Its maximum argument differentiates only where the premium is strictly
positive. It assumes neither a boundary time derivative nor a price time
derivative at exercise/continuation contacts.

Finally `ActualBoundaryHalfBound.lean` uses continuity to make `M(b(s),a,T)`
uniformly bounded near a fixed positive maturity. Together with the proved
quadratic separation, this gives `A/4*(b(s)-b(v))^2<=H*(v-s)` for nearby ordered
maturities, where `A=k-h*exp(b(t0))>0` and `H>0`. Taking square roots proves

```text
dist(b(s),b(v)) <= C*sqrt(dist(s,v))
```

for every pair in a positive-time neighborhood. The dilation, temporal
Lipschitz, and half-power boundary estimates have named zero-dividend and
Liu-range checkpoints. Guarded transitive audits allow only `propext`,
`Classical.choice`, and `Quot.sound`. These are actual stopping-price results,
not consequences of an assumed classical pricing contract. They still do
**not** prove the remaining positive-time boundary smoothness field or the
full unconditional convexity theorem.

## Actual normalized log-boundary convexity

The previous regularity estimates are retained, but a derivative-free route
now establishes the convex-function conclusion without first proving smoothness.
`ContinuousBoundaryProblem.lean` removes only boundary smoothness in a separate
pricing predicate, and proves exact equivalence with the original classical
contract after restoring that field. `ActualContinuousContract.lean` proves
the weaker predicate for the actual usual-filtration price and log boundary.

Generalized comparison helpers now require only these weaker data. Their
application in `ActualComparisonIntervals.lean` proves the spatial
single-positive-interval invariant, the terminal contact obstruction, and
connectedness in time of the boundary's strict sublevel set below every line
`d-c*t` with `c>0` and `d<=0`. The terminal contact argument uses continuity
and a first-contact selection, not `b'` or `b''`.

`ActualConvexLowerComparison.lean` independently compares smooth spatially
convex subsolutions to the actual price. In exercise a local maximum would
force the test's second spatial derivative below `-exp(x)`, contradicting
convexity. In continuation the pricing PDE rules out a positive maximum.
`ActualNearExpiry.lean` applies the previously constructed shrinking expiry
barrier, obtaining `b(t)<-sqrt(t)/64` near expiry and the required ratio limit.

The scalar geometry in `LineIntervalConvexity.lean` first proves monotonicity
of `b(t)/t`, then controls every chord using the line sublevel intervals. The
assembled theorem is

```lean
theorem canonicalLogBoundary_convexOn {k h : ℝ}
    (hk : 0 < k) (hh : 0 ≤ h) (hhk : h ≤ k) :
    ConvexOn ℝ (Set.Ioi 0) (canonicalLogBoundary k h)
```

Zero-dividend and Liu-range theorems are explicit. The result uses the same
actual stopping supremum, GBM model and completed usual filtration defined
above; no alternative analytic price is substituted. Transitive audits cover
the actual contract, interval/contact arguments, expiry input, scalar geometry
and all three final convexity statements. No boundary smoothness, convexity,
Sturm theorem, or classical-solution existence axiom is a premise.

This proves the normalized convex-function statement. It does not by itself
construct classical boundary second derivatives or establish their strict
stock-boundary consequence in full physical units. Those remaining statements
and the independent strict-log CCJZ development must not be conflated with the
result above.

## Actual strict boundary decrease and strict stock convexity

`ActualIncrementPositivity.lean` proves continuity, the pricing gauge equation,
nonnegativity, and positive propagation for the actual time increment divided
by the positive stationary profile. Its input is the already constructed
stopping value, including proved time monotonicity and continuation regularity.
If the two time slices have the same boundary, actual spatial smooth fit gives
zero value and zero spatial derivative of their normalized difference there.

On a hypothetical flat boundary tail, the normalized increment is positive at
every continuation point at each strictly later time. `ActualNoFlatTail.lean`
constructs a backward strip with a slanted left edge ending at the fixed
exercise boundary. The terminal Hopf barrier contradicts the zero spatial
derivative, excluding every flat tail without boundary time derivatives.

A convex nonincreasing function that takes the same value at two distinct
positive times must be constant thereafter, by the adjacent-secant inequality.
`Boundary/ConvexStrictMonotonicity.lean` proves this implication and the strict
convexity of `exp` composed with an injective convex profile. Assembly in
`ActualStockConvexity.lean` gives, under only `k>0`, `0<=h<=k`:

- `canonicalLogBoundary_strictAntiOn` and `canonicalStockBoundary_strictAntiOn`;
- `canonicalStockBoundary_strictConvexOn`;
- `canonicalLogBoundary_locallyLipschitzOn` and
  `canonicalStockBoundary_locallyLipschitzOn` on positive times.

Strict decrease and strict stock convexity have named zero-dividend and
Liu-range checkpoints. Sixteen new guarded transitive axiom checks cover the
increment PDE/positivity/smooth-fit arguments, no-flat-tail contradiction,
scalar geometry, and assembled conclusions, allowing only `propext`,
`Classical.choice`, and `Quot.sound`.

The local Lipschitz result improves the preceding half-power boundary modulus.
It does not imply classical differentiability everywhere. Neither strict
convexity nor local Lipschitz continuity supplies the still-missing classical
boundary smoothness field. Literal `b''>=0`, strict classical stock curvature,
and full physical-unit identification remain separate from these unconditional
normalized function-level results.

## Exact normalization and physical-unit boundary convexity

The physical-unit identification left open in the preceding checkpoint is now
proved independently of boundary smoothness. The new chain is:

1. `ShrinkingGrids.lean`: any positive exercise mesh tending to zero converges
   to the actual American stopping value. Upward rounding has error at most the
   mesh; payoff path continuity and bounded convergence give the result. The
   stochastic model and filtration are not discretized or replaced.
2. `GridNormalization.lean`: exact Bellman recursion rescaling. With
   `a=sigma^2/2`, scaled times `a*T,a*delta`, rates `r/a,q/a`, volatility
   `sqrt(2)`, and shifted log spot `log(S/K)`, both drift and Gaussian variance
   increments agree. Discounted payoffs scale by `K`, multiplication by positive
   `K` commutes with each Bellman maximum, and the grid step count is unchanged.
3. `ActualNormalization.lean`: pass that identity to the finite-grid limits.
   For `K>0`, `r>=0`, `sigma>0`, `S>0`, and every nonnegative maturity `T`,
   both raw and usual values satisfy

   ```text
   V(K,r,q,sigma,S,T)
     = K * canonicalPrice (2*r/sigma^2) (2*q/sigma^2)
         (log(S/K)) (sigma^2/2*T).
   ```

   No restriction on `q` or classical-pair hypothesis is required for this
   price identity.
4. `ActualBoundaryNormalization.lean`: for `r>0`, `0<=q<=r`, recover the
   physical usual-filtration exercise threshold from price/payoff contact,
   obtaining `B(tau)=K*exp(b(a*tau))`. Its normalized logarithm therefore equals
   `b(a*tau)` exactly at every positive remaining maturity.
5. `PhysicalBoundaryConvexity.lean`: transfer the established shape results
   through this positive time/price rescaling.

The final theorem `brownianUsualLogBoundary_convexOn` states convexity of
`tau -> log(brownianUsualExerciseBoundary K r q sigma tau.toNNReal / K)` on
`tau>0`. `brownianUsualStockBoundary_strictConvexOn` states strict convexity of
that actual stock threshold. Strict decrease and local Lipschitz continuity
are also proved. Their hypotheses are only `K>0`, `r>0`, `sigma>0`, `0<=q<=r`.
Explicit zero-dividend and Liu-range versions use the same financial definition.

Twenty-six new guarded transitive audits cover mesh convergence, finite-grid
scaling, price and threshold identification, and the physical-unit conclusions.
They permit only `propext`, `Classical.choice`, and `Quot.sound`. These results
finish physical-unit transfer for the convex-function conclusions. They do not
prove classical boundary second-derivative existence or strict positivity of
the classical stock second derivative; boundary regularity remains the next
substantive obligation.

## Joint price differentiability at contact and one-sided boundary speeds

`Boundary/LipschitzContactDifferentiability.lean` proves a general contact
lemma without assuming the boundary graph is differentiable. Suppose
`U(b(s),s)=0` near `t`, the graph has a local Lipschitz displacement bound, and
the spatial derivative of `U` is continuous and zero at `(b(t),t)`. The spatial
mean-value inequality bounds `|U(x,s)|` by an arbitrarily small gradient bound
times `|x-b(s)|`. Lipschitz boundary motion controls the latter by a fixed
multiple of the space-time displacement. Thus `U` has zero full first derivative
at contact.

`ActualContactDifferentiability.lean` applies this to the actual intrinsic
premium `u(x,t)=p(x,t)-(1-exp(x))`, using already proved smooth fit, joint
spatial-gradient continuity, and local Lipschitz boundary motion. It proves:

- `canonicalIntrinsicPremium_hasFDerivAt_contact`: `Du=0` at contact;
- `canonicalPrice_hasFDerivAt_contact`: the price differential there is
  `(dx,dt) -> -exp(b(t))*dx`;
- `canonicalPrice_hasDerivAt_time_contact`: the actual time derivative exists
  at the contact point and is zero;
- `canonicalPrice_joint_differentiableAt`: joint first differentiability at
  every positive-time point, using the existing smooth formulas off contact;
- `canonicalPrice_differentiableAt_time`: time differentiability at every
  fixed log spot and positive maturity.

These statements assert genuine `HasFDerivAt`/`HasDerivAt`, not merely a value
of Lean's totalized derivative operator. They do **not** assert continuity of
the time derivative or second derivatives across contact.

`ActualBoundaryOneSided.lean` applies convex-function calculus to the actual
log boundary. The left and right derivatives exist finitely at every positive
time, are nondecreasing as functions of time, and satisfy
`b'_-(t)<=b'_+(t)<0`. The strict sign follows from strict boundary decrease and
the upper bound on a convex right derivative by any future secant slope.
Boundary differentiability is proved equivalent to equality of the one-sided
speeds. Their equality remains **unproved**. If differentiability is supplied
at a point, the full derivative is consequently strictly negative there.

The contact-price differential and one-sided boundary-speed statements have
explicit zero-dividend and Liu-range checkpoints. Seventeen new guarded
transitive audits allow only `propext`, `Classical.choice`, and `Quot.sound`.
The next regularity obligations include control of derivative traces and
elimination of possible corners in the boundary; neither first price
differentiability nor convexity alone completes the classical contract.

## Quadratic upper growth and uniform contact-time increments

`ActualSpatialSecondBound.lean` derives a locally uniform continuation-side
upper bound for `u_xx`, where `u=p-(1-exp(x))`. The PDE gives
`u_xx=u_t-(k-h-1)*u_x+k*u+k-h*exp(x)`. The existing upper bound on `p_t=u_t`,
the spatial bounds `0<=u_x<=exp(x)`, and `u<=exp(x)` control every term.
No second spatial derivative at contact is asserted.

`QuadraticUpper.lean` proves the elementary integration lemma from flat
contact. With the actual gradient trace, `ActualQuadraticUpper.lean` gives
uniform `u_x<=C*(x-b(s))` and `u<=C/2*(x-b(s))^2` on a short interval to the
right of the boundary at every nearby maturity.

`ActualContactIncrement.lean` retains pairwise local Lipschitz control of the
boundary and evaluates that upper estimate at the earlier boundary `b(s)`
at the later maturity `v`. Since `b(v)<=b(s)` and
`b(s)-b(v)<=L*(v-s)`, this proves

`0<=p(b(s),v)-p(b(s),s)<=A*(v-s)^2`.

The constants and neighborhood are uniform in both maturities. Shrinking
the neighborhood gives

`0<=(p(b(s),s+delta)-p(b(s),s))/delta<=A*delta`.

The zero-dividend and Liu-range quadratic contact estimates are explicit.
`Boundary/DiscountedMaximum.lean` proves a moving-strip comparison principle
for `w_t<=w_xx+D*w_x-k*w`, `k>0`, using a positive compact maximum and the
negative discount term. Boundary continuity suffices. Thirteen transitive
axiom guards cover these estimates and the comparison principle.

The uniform contact quotient bound supplies the left-boundary datum for the
comparison inside continuation proved in the following stage. Boundary
smoothness remains open. These regularity estimates do not change the already
unconditional function-level boundary convexity theorem.

## Joint time-derivative continuity and exact spatial-curvature trace

`Boundary/StationaryBarrier.lean` proves the calculus and supersolution
inequality for `phi(x)=1-exp(-rho*(x-beta))`, where `rho` is positive and at
least the drift `k-h-1`. It is nonnegative to the right of `beta`, and bounded
above there by `rho*(x-beta)`. Positive affine multiples remain stationary
pricing supersolutions when the constant offset is nonnegative.

`ActualIncrementComparison.lean` compares actual time increments with a
stationary supersolution on a continuous moving strip. Both price slices
solve the PDE in the earlier continuation region. The previously proved
discounted maximum principle handles their difference from the barrier.
The exponential specialization has explicit initial-gap, uniform increment,
and quadratic left-boundary hypotheses.

`ActualTemporalTraceBound.lean` discharges these hypotheses using actual-price
theorems alone. Around a reference maturity `t`, it chooses a fixed earlier
time `a` and restricts the variable terminal maturity `s` to a smaller
neighborhood. The stationary reference `beta=b(s)` lies below all earlier
boundaries by antitonicity. Strict decrease supplies a uniform positive gap
at the initial time. The right endpoint is the strike `x=0`. On the resulting
compact space-time rectangle, temporal Lipschitz continuity gives a uniform
`M*delta` increment bound. The earlier-contact estimate gives `A*delta^2`
on the moving left side.

The comparison gives `w_delta(x,s)<=A*delta^2+delta*C*phi(x)`. Dividing by
positive `delta` and taking the right limit, using the proved actual time
differentiability, yields

`0<=p_t(x,s)<=N*(x-b(s))` for `b(s)<=x<=0`, uniformly in nearby `s`.

`ActualTimeDerivativeContinuity.lean` first proves `p_t=0` throughout exercise,
including contact. The linear estimate is extended across exercise by the
continuous majorant `N*max(0,x-b(s))`. This majorant tends to zero jointly at
contact. Squeezing proves `ContinuousAt` of the actual time derivative at
every positive-time boundary point.

`ActualSpatialSecondTrace.lean` now passes to the contact limit in the premium
PDE, using `p_t->0`, `u_x->0`, and `u->0`. It proves the joint continuation-side
limit `u_xx->k-h*exp(b(t))>0`. No second spatial derivative at contact or across
exercise is asserted. The time-derivative continuity and curvature-trace
theorems have explicit zero-dividend and Liu-range checkpoints. Twenty guarded
transitive audits allow only `propext`, `Classical.choice`, and `Quot.sound`.

Boundary smoothness and equality of its one-sided speeds remain **unproved**.
The next regularity work must control the mixed derivative/flux or otherwise
eliminate boundary corners; the trace theorems alone do not do so.

## Joint C1 price and right-sided gradient derivative

`ActualPriceC1.lean` proves continuity of the actual time derivative throughout
positive-time space-time. The exercise interior is locally constant in time;
the continuation interior uses the smooth Fréchet directional derivative;
contact uses the proved joint trace. A general coordinate identity expresses
the full derivative of a differentiable plane function through its two slice
derivatives. Their continuity proves continuity of the actual price's full
derivative. `canonicalPrice_contDiffOn_one` then proves genuine joint C1
regularity on `{z : real * real | 0<z.2}`.

`ActualCurvatureExtension.lean` defines a continuous extension of the
continuation curvature by the PDE expression

`p_t+k-h*exp(x)-(k-h-1)*u_x+k*u`.

It equals `u_xx` in continuation and equals `k-h*exp(b(t))` at contact. It is
**not** asserted to equal the actual second derivative in exercise. The
gradient's continuity and continuation-side derivative limit give a genuine
`HasDerivWithinAt` for `u_x` on `Ici(b(t))` at `b(t)`, with derivative
`k-h*exp(b(t))`. Hence the right-sided ratio `u_x(x,t)/(x-b(t))` tends to that
strictly positive coefficient.

Both the C1 price theorem and the right-sided gradient derivative have explicit
zero-dividend and Liu-range checkpoints. Fifteen guarded transitive axiom
checks cover this addition. Boundary differentiability still requires control
of the contact mixed derivative/flux or another corner-exclusion argument.
These results alone do not establish that the gradient has a joint C1 extension
across contact, so the implicit-function theorem cannot yet be applied to it.

## Positive theta equation without boundary smoothness

`PlanePricingDerivative.lean` establishes the calculus needed to differentiate
the pricing equation. Smooth directional derivatives commute, including the
third-order interchange `D_t D_x D_x = D_x D_x D_t`. Differentiation respects
the constant-coefficient pricing combination. These identities are proved
from Mathlib's Fréchet derivative symmetry theorem.

`ActualTheta.lean` defines `canonicalTheta k h x t = deriv (canonicalPrice k h x) t`.
This is the derivative in time remaining, not calendar-time theta. On positive
times it is jointly continuous, nonnegative, and zero in exercise. Inside
continuation it is jointly smooth and solves

`theta_t = theta_xx+(k-h-1)*theta_x-k*theta`.

The PDE is obtained by differentiating the proved actual-price PDE on an open
continuation neighborhood. The same calculus proves the interior mixed
derivative identity `p_xt=theta_x`. No derivative at contact is used.

`ActualThetaPositivity.lean` strengthens nonnegativity to strict positivity in
continuation. The strict premium over initial payoff and the mean value theorem
give an earlier time `a` at the same spot with positive theta. Zero theta in
exercise puts this source strictly above `b(a)`. The stationary positive profile
removes discounting, leaving the previously bounded drift. The explicit
parabolic positivity barrier carries the source to the later target on the
half-line `x>b(a)`, which stays inside continuation by boundary antitonicity.

The theta PDE and positivity have zero-dividend and Liu-range checkpoints.
Twenty-two guarded transitive axiom checks cover this addition. The existence
and continuity of the contact limit of `theta_x` are still **unproved**; neither
interior smoothness nor the zero Dirichlet trace alone supplies that limit.

## Quantitative contact growth of theta

`Boundary/QuantitativeHopf.lean` proves a terminal linear lower bound without
assuming a boundary derivative exists. It retains the explicit exponential
barrier and weak comparison from the Hopf argument but stops before passing
to a derivative. Qualitative positivity on the compact bottom and right
edges supplies a positive barrier scale.

`ActualThetaContactGrowth.lean` uses a local Lipschitz constant `L` for the
actual log boundary and the line through contact with speed `L+1`. At earlier
nearby times the line is strictly above the boundary. Transforming the
normalized theta into line coordinates produces a nonnegative solution on a
fixed backward rectangle; its bottom and right edges are strictly positive.
The shifted drift remains bounded. Quantitative comparison therefore gives
`m*y<=theta(b(t)+y,t)` on `0<=y<=1` for a suitable `m>0`.

The previously proved upper bound then yields a shorter right neighborhood
with `0<m<=theta(x,t)/(x-b(t))<=M`. The constants are at a fixed reference
maturity; no uniform lower bound over nearby maturities is asserted here.
Zero-dividend and Liu-range checkpoints and seven guarded transitive audits
cover this stage.

The quotient's convergence and the existence/continuity of the normal flux
are still **unproved**. A separate checked conclusion excludes two-sided
spatial differentiability of theta at contact: exercise-side constancy would
force derivative zero, contradicting the right slope lower bound. Thus any
subsequent Stefan flux must use a right-sided derivative or continuation-side
limit, not Lean's ordinary totalized derivative at the contact point. The
price itself remains jointly C1, as previously proved.

## Moving-boundary heat normal-kernel jump

The regularity bootstrap in Section 3.2 of
[Chen, Cheng and Chadam's dividend-paying paper](https://sites.pitt.edu/~chadam/papers/LargeDNonConvex.pdf)
requires boundary gradient regularity and the weak Stefan identity before
deducing smoothness. Our proved local Lipschitz boundary motion meets its
starting regularity threshold, but does not by itself supply either ingredient.

`MovingHeatKernelBound.lean` proves a uniform spatial derivative bound for
the diffusivity-1/2 boundary kernel `H(s,x)=x*heatKernel(s,x)/s`. The mean
value theorem gives, for `|d(s)|<=L*s`,

`|H(s,x+d(s))-H(s,x)| <= 3*L/(sqrt(2*pi)*sqrt(s))`.

The right side is integrable on every finite positive-time window. In
`MovingHeatJump.lean`, this gives continuity across `x=0` of the integrated
correction for every bounded continuous density. The flat-kernel unit-mass
trace then yields the exact right-sided jump

`integral H(s,x+d(s))*g(s) -> g(0)+integral H(s,d(s))*g(s)`.

The density is cut off beyond the chosen time window. The spatial derivative
of the ordinary heat kernel is `-H`; a separate theorem checks the resulting
negative sign in its integrated normal-kernel jump. No graph derivative is
used, and the correction's integrability is proved rather than postulated.

`ActualBoundaryHeatJump.lean` supplies a local window and the required
displacement estimate for the actual boundary. Heat time is twice normalized
pricing time, so its displacement is `b(t)-b(t-s/2)`, not `b(t)-b(t-s)`.
The jump theorem applies to every bounded continuous density supported in that
window, with explicit zero-dividend and Liu-range checkpoints.

This is a **kernel jump theorem**, not yet a flux theorem for actual theta.
The next section justifies differentiating a layer potential in the interior.
Constructing/identifying the actual solution's layer representation with a
suitably regular density and establishing the Stefan velocity identity remain
substantive obligations.
Boundary differentiability and the literal everywhere second-derivative
conclusions are still unproved. The already checked actual-boundary convexity
theorems do not depend on those remaining obligations.

## Differentiated heat layer potentials and their flux

`HeatLayerPotential.lean` defines

`V(x)=integral_{0<s<T} heatKernel(s,x+d(s))*g(s)`.

The Gaussian bound `|heatKernel(s,y)|<=1/sqrt(2*pi*s)` proves absolute
integrability and continuity of the potential, including at `x=0`.
For spatial evaluation points bounded away from zero, a Gaussian moment
bound gives an integrable uniform bound for the flat normal kernel. Adding
the already proved motion correction gives an integrable envelope for
the derivative of the moving kernel. The parameterized-integral derivative
theorem therefore applies even at arbitrarily small positive elapsed times.
Neither the density nor the graph is differentiated.

The proved interior derivative is

`V'(x)=-integral_{0<s<T} H(s,x+d(s))*g(s)`, for `x>0`.

For bounded continuous density cut off beyond `T`, the kernel jump gives
the continuation-side limit

`V'(x) -> -(g(0)+integral_{0<s<T} H(s,d(s))*g(s))`.

Continuity of `V` and this derivative limit also prove a genuine
`HasDerivWithinAt` on `Ici 0` at zero, with the same flux value. This
does not assert a two-sided derivative of the layer at contact. The flux
formula is continuous under continuous parameter variation of the graph
displacements and densities, provided their Lipschitz and size bounds are
uniform; dominated convergence handles the singular time endpoint.

`ActualBoundaryHeatLayer.lean` supplies the actual graph hypotheses in a
local positive-time window and proves both the one-sided derivative and
interior derivative trace for every such density. The elapsed-time
displacement remains `b(t)-b(t-s/2)`. Explicit zero-dividend and Liu-range
specializations and twelve guarded transitive axiom checks cover this stage.

These are **actual-graph layer-potential theorems**, not a claim that theta
is that potential. Constructing or identifying the actual PDE solution's
layer representation and establishing the required density regularity remain
the next analytic tasks, followed by the Stefan velocity identity and
boundary bootstrap. The actual boundary's smoothness is still unproved.

## Constructing the causal heat-layer density

`HeatHistoryOperator.lean` defines the elapsed-time operator

`K_D f(t)=integral_{0<s<D} H(s,b(t)-b(t-s))*f(t-s)`.

For continuous graph motion satisfying `|b(t)-b(t-s)|<=L*s`, its
bounded-continuous-function norm is at most

`Q(L,D)=6*L*sqrt(D)/sqrt(2*pi)`.

This estimate includes the singular endpoint. The proof computes the exact
integral of `1/sqrt(s)` and uses the previously checked moving-kernel bound.
The operator is continuous in time, preserves causality, and has a proved
difference estimate with the same norm constant. A positive window with
`Q(L,D)<1` is constructed for every `L`.

`HeatDensityEquation.lean` solves `f=g+K_D f` by the Banach contraction
theorem on the complete space of bounded continuous functions that vanish
at and before a specified starting time. The solution is unique in that
space for the global truncated equation. On the first time window, its
truncated history is proved equal to the entire causal past, so the solution
satisfies the genuine local Volterra integral equation. Continuity and
boundedness of the density are conclusions of the construction.

`ActualHeatDensity.lean` applies this construction to the actual graph.
Mathlib's real-valued Lipschitz extension theorem supplies a global graph
agreeing with the actual boundary near a positive target maturity `a`.
A sufficiently small `0<D<a` gives the heat-time window
`[2*a-D/2,2*a+D/2]`, so the target is strictly inside it. The final equation
contains `b(t/2)-b((t-s)/2)`, not the auxiliary extension. For every bounded
continuous forcing that vanishes up to the initial heat time, a bounded
continuous causal density is constructed on this window. Zero-dividend and
Liu-range checkpoints and fifteen guarded transitive axiom checks cover it.

The forcing contract is important: this is **not** a solution of arbitrary
singular expiry data, nor an identification of the constructed density with
actual theta's flux. The actual equation's compact causal localization is
now constructed below. The remaining representation argument must construct
the appropriate boundary forcing from its free heat potential and show
that the resulting layer potential represents the actual solution. The
Stefan velocity identity and boundary regularity bootstrap remain open.

## Exterior uniqueness and exact two-sided flux matching

`Boundary/NeumannMaximum.lean` proves the strict parabolic maximum principle
with a strictly positive one-sided derivative into the moving spatial domain.
The boundary curve is only continuous. At a boundary maximum, right difference
quotients are nonpositive, contradicting that derivative; an interior maximum
is excluded by the differential inequality, including at terminal time.

`Boundary/NeumannHalfLine.lean` removes both the strictness and the finite
right endpoint for the heat equation. A growing quadratic barrier has a
strict heat inequality and strictly positive perturbed inward derivative.
Boundedness supplies a sufficiently distant truncation point; no decay at
infinity is assumed. Applying the maximum principle to both signs proves
that a bounded solution with zero initial values and zero one-sided Neumann
data is identically zero. `NeumannExterior.lean` checks the reflection to the
left exterior `x<=b(t)`. Neither theorem requires a boundary velocity.

`HeatLayerMatching.lean` checks reflection of the heat layer and obtains
its genuine left-sided contact derivative. With
`I=integral H(s,d(s))*f(t-s)`, the two derivatives of the layer V are

`V_x(0-) = f(t)-I`, and `V_x(0+) = -f(t)-I`.

Consequently the already solved density equation `f(t)=g(t)+I` makes
`U=F-V/2` satisfy `U_x(0-)=0` and `U_x(0+)=f(t)`, when
`F_x(0)=g(t)/2`. The sign and the factor 1/2 are both checked in Lean;
the diffusivity of this heat kernel is 1/2. Causality supplies the density's
elapsed-time cutoff on the first window. Eight guarded transitive axiom
checks cover these results.

This establishes the analytic boundary-condition mechanism for the candidate
representation. It does **not** yet assert that the candidate solves the
required PDE or equals actual theta. The remaining route is:

1. **Proved below:** localize and gauge the actual theta equation, obtaining
   a bounded causal source without presuming boundary derivatives.
2. **Proved below:** construct its free heat source potential F and the
   continuous causal forcing `g=2*F_x` on the local graph.
3. Verify the layer candidate's PDE, boundedness and initial values. The proved
   exterior Neumann uniqueness then supplies its zero exterior values.
4. Identify the candidate with localized theta by Dirichlet uniqueness, obtain
   the actual normal flux, and establish the Stefan identity and bootstrap.

These are remaining proof obligations, not hypotheses silently added to the
actual-boundary convexity theorem or claims of completed smoothness.

## Constructing the actual compact heat source

`ActualHeatTheta.lean` uses heat time `s=2*t` and the fixed-space transform

`W(x,s)=exp(alpha*x/2+(k+alpha^2/4)*s/2)*theta(x,s/2)`,

where `alpha=k-h-1`. The inverse gauge identity is exact. The actual W is
continuous at every positive heat time, zero in exercise, and smoothly solves
`W_s=W_xx/2` in continuation. Explicit zero-dividend and Liu-range heat
equations are included.

`HeatLocalizationSource.lean` checks the source for a smooth cutoff chi:

`Q=(chi_s-chi_xx/2)*W-chi_x*W_x`.

The localized heat residual equals Q in continuation. Spatial derivatives
of W are only used on the support of chi_x. If that support avoids the
contact graph, Q is continuous across contact; outside the positive-time
cutoff support it is identically zero. Its support is contained in that of
chi, so compact support gives a global bound. Q also vanishes on the entire
exercise side: W vanishes there, and at contact chi_x is locally zero.
The localized W itself is proved globally continuous and bounded.

`ActualHeatSource.lean` constructs the required cutoff, not just a
conditional source theorem. A spatial bump is one on a collar of the
target boundary value. Continuity of the graph gives a time window on
which every contact stays in that collar. A separate time bump localizes
to this window. The product is one near the target contact and its
spatial derivative has support disjoint from the graph.

For every actual positive pricing time t, and every prescribed heat start
`0<=a<2*t`, `exists_actualHeatTheta_source_after` constructs chi and
proves that Q is bounded, continuous, compactly supported, and zero at
and before a. Allowing a prescribed start lets this source fit the already
constructed short Volterra window. Fifteen guarded transitive axiom checks
cover the transform, localized equation, support/continuity estimates, and
actual source construction.

This completes the source-localization step. The free potential, its spatial
derivative, and the associated forcing are now constructed below. The
candidate's PDE and identification with localized W, the actual Stefan flux
identity, and the boundary smoothness bootstrap remain unproved.

## The source potential and actual boundary forcing

`HeatSourceMoments.lean` rescales the Gaussian spatial convolution to fixed
unit-time Gaussian moments. For any bounded continuous space-time source Q,
these moments depend continuously on elapsed time and the evaluation point,
without differentiating Q. The derivative moment has the uniform estimate

`|spatialAverage(Q,u,x,s)| <= C*M1/sqrt(u)`,

where `|Q|<=C` and `M1=integral |H(1,y)|` is a proved finite Gaussian first
moment. Exact change-of-variable identities relate both moments to their
ordinary heat-kernel convolution formulas.

`HeatSourceDerivative.lean` differentiates the spatial convolution by taking
derivatives of the kernel only. Compact support of Q supplies compact spatial
slices; Q needs continuity, not differentiability. This proves the rescaled
derivative formula as a genuine `HasDerivAt` statement.

`HeatSourcePotential.lean` integrates the Gaussian average over `0<u<D`.
Its continuous spatial derivative is the integral of the derivative average.
The singular endpoint is included: `integral_0^D 1/sqrt(u)=2*sqrt(D)` supplies
an integrable uniform majorant for differentiation and continuity. Both the
potential and its spatial derivative have uniform bounds and vanish at and
before the source's causal start a. On `s<=a+D`, the truncation includes the
entire causal past, and the potential is proved exactly equal to

`F(x,s)=integral_{0<u<s-a} integral_y G(u,y-x)*Q(y,s-u)`.

`ActualHeatForcing.lean` constructs the bounded continuous causal boundary
forcing `g(s)=2*F_x(b(s/2),s)`. To obtain a globally continuous representative,
it first evaluates on `b(max(a,s)/2)`. Since F_x vanishes for all x at and
before a, the representative is proved equal to the actual-graph formula
for every s. Thus neither expiry behavior nor a negative-time boundary
extension is an added assumption. The exact derivative `g(s)/2` of F at the
graph is proved as well.

`exists_actualHeatSource_density` chooses a short actual-graph Volterra window,
constructs the actual theta cutoff/source after its start, builds this specific
forcing, and solves the density equation. The density is no longer conditional
on an arbitrary supplied forcing. Explicit zero-dividend and Liu-range versions
are included, and nineteen guarded transitive axiom checks cover this stage.

The single-layer potential's PDE, regularity, bounds, and initial data are
now proved below. The free potential's inhomogeneous heat PDE off the graph
is still needed before applying the exterior Neumann and interior Dirichlet
uniqueness results to identify the candidate with localized W. The source is
continuous across contact but not asserted globally smooth; the PDE proof
must respect that distinction. Actual theta's normal flux, the Stefan
velocity identity, and smoothness of the actual exercise boundary remain
unproved.

## A classical heat layer without differentiating the moving graph

`CausalHeatKernel.lean` extends the Gaussian G by zero at nonpositive elapsed
time. The resulting space-time function is proved smooth away from (0,0),
including across time zero at nonzero spatial displacement, and satisfies
the diffusivity-1/2 heat equation there. The proof uses the already checked
flat exponential extension; no regularity at the singular origin is asserted.

`MovingHeatLayerEquation.lean` works in original source time:

`V(x,t)=integral_u G_causal(t-u,x-b(u))*f(u)`.

If x differs from b(t), every kernel evaluation avoids the singular origin.
For continuous b and continuous compactly supported f, the integrand and
its parameter derivatives are continuous jointly with source time. Compact
source support justifies differentiation under the integral. The graph is
never differentiated: b(u) is held fixed when differentiating x or t.
The layer has a proved heat PDE, spatial derivatives of every finite order,
and a time derivative off the graph.

`CausalLayerLocalization.lean` removes the compact-support restriction on
the density. A smooth cutoff preserves any continuous causal density on
its entire past up to a chosen time and changes only its future. The causal
kernel ignores that changed future. Consequently the PDE, spatial C2
regularity, and time differentiability hold for continuous causal densities,
including those already constructed by the boundary integral equation.

`MovingHeatLayerBridge.lean` proves exact equality, on the first causal
window, with the elapsed-time integral used by the jump theorem:

`V(x,t)=integral_{0<u<D} G(u,x-b(t-u))*f(t-u)`.

The Gaussian inverse-square-root bound gives joint continuity across the
graph and a uniform bound `2*C*sqrt(D)/sqrt(2*pi)` when `|f|<=C`.
The layer vanishes at and before the density's causal start.
Its left and right contact derivatives are exactly
`f(t)-K_D f(t)` and `-(f(t)+K_D f(t))`. The normal-trace theorem retains
the local Lipschitz-displacement hypothesis needed for those traces; the
PDE and continuity theorems only require graph continuity.

Nineteen guarded transitive axiom checks cover this connection. The layer
PDE and jump formulas are now about the same function, not disconnected
constructions. The remaining representation task is the free source
potential's inhomogeneous heat PDE and application of uniqueness to
`F-V/2`, followed by the actual flux/Stefan identity and boundary bootstrap.

## Identified actual representation and positive pricing-theta flux

The representation tasks in the preceding development history are now
discharged by `LocalSourceEquation.lean`, `HeatRepresentationCandidate.lean`,
`HeatRepresentationExterior.lean`, `HeatRepresentationIdentification.lean`,
and `ActualHeatRepresentation.lean`. The source potential has its actual
inhomogeneous PDE off the graph. Bounded exterior Neumann uniqueness and
interior Dirichlet uniqueness identify `F-V/2` with localized actual heat
theta. `ActualHeatFlux.lean` removes the cutoff near each contact and obtains
a genuine right-sided spatial derivative, locally continuous in heat time.

`ActualThetaFlux.lean` transfers this result back to pricing coordinates.
Writing `alpha=k-h-1` and `A=k+alpha^2/4`, the exact identity is

`theta(x,t)=exp(-alpha*x/2-A*t)*W(x,2*t)`.

The product-rule term differentiating the gauge vanishes at contact because
`W(b(t),2*t)=0`. Consequently the intrinsic right derivative

`canonicalThetaRightFlux k h t = derivWithin (theta(.,t)) [b(t),infinity) b(t)`

exists, is continuous for every positive pricing time, and is strictly
positive. Positivity follows from the already proved positive lower bound
for `theta(x,t)/(x-b(t))`, whose convergence to this derivative is now proved.
The results require only `k>0` and `0<=h<=k`; explicit zero-dividend and
Liu-range positive-flux checkpoints are retained. Eleven transitive axiom
guards cover this stage.

This is not the ordinary two-sided derivative of theta's zero exercise
extension. Nor does continuity of the boundary derivative alone establish
joint convergence of the interior spatial gradient to it. That stronger
trace, the actual Stefan velocity identity, and the boundary regularity
bootstrap remain unfinished.

## Joint interior-gradient convergence to the actual boundary flux

`HeatLayerGradientExtension.lean` fills in the right jump of the normal
kernel using the flat boundary extension and the moving-graph correction:

`N(x,t)=heatBoundaryExtension(f,x,t)`
`       + integral_{0<u<D} [H(u,x+b(t)-b(t-u))-H(u,x)]*f(t-u)`.

Here x is distance from the current graph. The correction is dominated by
`(3*L*C/sqrt(2*pi))/sqrt(u)` uniformly in x and t on the time window.
Dominated convergence therefore gives joint continuity, including x=0.
Causality identifies N with the normal-kernel integral for x>0, so -N is
the genuine interior spatial derivative of the heat layer. At contact its
value is `-(f(t)+heatHistory(b,D,f,t))`.

`HeatRepresentationGradient.lean` combines this extension with the source
potential's continuous spatial derivative. The density equation gives
boundary value f(t) for the represented candidate's gradient. Identification
on the closed continuation strip transfers its genuine interior derivative.

`ActualHeatGradientTrace.lean` supplies the actual clamped-graph displacement
bounds and constructed density, then removes the cutoff on a space-time
neighborhood. The resulting local gradient extension is continuous at the
actual contact, equals a genuine right-sided derivative there, and agrees
with the ordinary spatial derivative throughout nearby continuation.

`ActualThetaGradientTrace.lean` transfers this through the inverse heat gauge.
The interior derivative is

`theta_x = -(alpha/2)*theta + inverseThetaHeatGauge*W_x`.

The first term vanishes at contact. The limit of the second is the already
identified `canonicalThetaRightFlux`. Thus `canonicalTheta_gradient_tendsto_contact`
proves joint convergence through continuation as both space and pricing
time tend to any positive-time contact. No relation between their approach
rates is required. Zero-dividend and Liu-range checkpoints are explicit;
nineteen guarded transitive axiom checks cover this stage.

The joint-gradient trace is now complete. The actual Stefan velocity identity
and the boundary differentiability/smoothness bootstrap are still separate
unfinished obligations. In particular this result does not differentiate
smooth fit along a boundary already assumed differentiable.

## Actual C1 boundary and Stefan velocity identity

`ActualPremiumGradientDifferential.lean` defines `g=u_x`, the actual
intrinsic-premium gradient. In continuation it is smooth and its full
derivative has coefficients `(u_xx,theta_x)`. Commutation of the price's
mixed derivatives is used only inside the smooth continuation region.
The already proved joint traces give the limiting differential at contact:

`Dg(b(t),t) = (k-h*exp(b(t)))*dx + canonicalThetaRightFlux(t)*dt`.

`ActualStefanVelocity.lean` proves continuation is a convex epigraph using
the earlier derivative-free convexity theorem. Intersecting with times
greater than t/2 produces a convex open domain whose closure stays away
from expiry. The function g is continuous on this closure, so Mathlib's
derivative-extension theorem gives a genuine relative full derivative at
contact with precisely the coefficients above.

`Boundary/LipschitzImplicitBoundary.lean` supplies the implicit step without
assuming differentiability of b. Compose the relative first-order remainder
with the zero graph, use its local Lipschitz bound to control the space-time
increment by the time increment, and divide by the nonzero spatial
coefficient. Applied to `g(b(s),s)=0`, this proves

`b'(t)=-canonicalThetaRightFlux(t)/(k-h*exp(b(t)))`.

The denominator and flux are strictly positive. Both are continuous in
positive time. Thus the actual boundary has a continuous strictly negative
derivative and is genuinely `ContDiffOn` of order one. Its previously
constructed left and right speeds are now proved equal. The equivalent
Stefan identity is

`canonicalThetaRightFlux(t)=-(k-h*exp(b(t)))*b'(t)`.

Only `k>0` and `0<=h<=k` are assumed. Explicit zero-dividend and Liu-range
velocity checkpoints are included. Twenty-one transitive axiom guards
cover the implicit lemma, differential, geometry, and final results.

This use of convexity is not circular: the function-level actual convexity
theorem was proved without boundary differentiability. This stage does
not establish C2 or higher regularity, so it does not yet complete the
classical second-derivative formulation or the independent strict-log-curvature
CCJZ development.

## Observation-time regularization estimates for the history operator

`HeatHistoryTimeKernel.lean` uses original source time:

`K_b(t,s)=H(t-s,b(t)-b(s))`.

For fixed s, differentiation in observation time t differentiates b(t),
but not b(s) and not the density f(s). If the graph speed and its
displacement quotient are bounded by L, the checked estimates are

`|K_b(t,s)| <= 3L/sqrt(2*pi*(t-s))`,
`|partial_t K_b(t,s)| <= 8L/((t-s)*sqrt(2*pi*(t-s)))`.

The time derivative follows from the kernel's exact parabolic scaling
identity and its spatial derivative bound. The mean-value inequality
controls observation-time increments away from source time. No second
derivative of the graph or first derivative of the density is assumed.

`HeatHistoryTimeMajorant.lean` splits the common-past difference at
`u=delta=t2-t1`, where `u=t1-s`. It uses twice the size bound for `u<delta`
and the time-derivative bound times delta for `u>delta`. After taking out
`L/sqrt(2*pi)`, the nonnegative integrable majorant is

`6/sqrt(u)` on `(0,delta)`, and
`8*delta/(u*sqrt(u))` on `(delta,infinity)`.

Its integral is exactly `28*sqrt(delta)`. The splitting point is excluded
only as a null singleton. Consequently the common-past kernel difference
against density bounded by C has norm at most
`28*L*C/sqrt(2*pi)*sqrt(delta)`. This estimate is stated for Lean's total
Bochner integral; it does not itself supply integrability or continuity
of an arbitrary bounded density. The eventual application uses the
already constructed continuous density, and integral splitting must retain
its integrability obligations.

`ActualHistoryTimeBounds.lean` supplies the graph hypotheses without new
assumptions. The actual heat graph `s -> b(s/2)` is C1; its continuous
derivative is bounded on compact positive-time intervals. The mean-value
inequality gives a common displacement bound. Both pointwise kernel
estimates and the common-past integral estimate are specialized to this
actual graph for the full `k>0,0<=h<=k` regime. Twenty-two transitive axiom
guards cover this stage.

This is preparation for the higher-regularity bootstrap. The recent-source
contribution, source forcing regularity, and the assembly into a Holder
bound for the actual flux remain to be proved. No C2 boundary claim follows
from this stage alone.

## Full actual-graph history: one-half Holder time bound

`HeatHistorySourceTime.lean` closes the integrability and splitting
obligations identified above. The source-time kernel against a continuous
bounded density is genuinely integrable on each relevant source interval.
Reflection between source and elapsed time preserves integrability and
the integral. Splitting at the earlier observation time is justified via
adjacent interval integrals, before subtracting the common-past terms.
The recent-source integral has bound

`6*L*C/sqrt(2*pi)*sqrt(t2-t1)`.

`HeatHistoryHolder.lean` defines the history from a fixed positive start,

`heatHistoryFrom(b,f,a,t)=integral_{a<s<t} K_b(t,s)*f(s)`.

It identifies this exactly with `heatHistory b (t-a) f t`. The common-past
difference contributes 28 and the recent-source term contributes 6, giving

`|heatHistoryFrom(b,f,a,t2)-heatHistoryFrom(b,f,a,t1)|`
` <= 34*L*C/sqrt(2*pi)*sqrt(t2-t1)`.

Here `a<t1<t2`, the graph derivative and displacement quotients have bound
L on the window, and f is continuous with `|f|<=C`. No derivative or Holder
modulus of f is assumed. Unlike the preceding norm estimate alone, the
assembly explicitly proves integrability of all terms that are split or
subtracted; it does not rely on a default value for a divergent integral.

`ActualHistoryHolder.lean` applies this to the actual heat-coordinate
boundary. Its already-proved C1 regularity supplies uniform compact-window
bounds. Clamping the graph before a positive start produces a globally
continuous representative, and exact integral equalities remove that clamp
on the source window. Thus the full actual-graph history is one-half Holder
in observation time for any continuous bounded density. Explicit
zero-dividend and Liu-range results and twelve transitive axiom guards are
included.

The actual density satisfies `f=forcing+history`. This stage proves the
history part's regularity, not the forcing part's. Establishing regularity
of the localized source forcing is the next step before asserting a Holder
bound for the actual density/flux and then improving C1 boundary regularity.

## Actual forcing regularity and one-half Holder right heat flux

The next stage is now proved, without increasing the boundary regularity
assumptions. `SeparatedSourceCurve.lean` differentiates a source-time integral
along a C1 curve disjoint from the compact source support. The derivative is
the time-kernel integral plus the curve velocity times the spatial-kernel
integral. Both are continuous. Only the kernel is differentiated; the source
is merely continuous and compactly supported.

`SeparatedSourceForcing.lean` identifies the fixed-window potential's spatial
derivative with the differentiated source-time integral, using genuine
derivatives and the local potential equality before the causal window ends.
`HeatSourceSeparation.lean` proves that a cutoff constant near contact makes
its localization source zero nearby. This needs no differentiability of
theta across exercise.

`ActualForcingRegularity.lean` applies these facts to the actual C1 heat graph.
The forcing, twice the potential's first spatial derivative, is C1 and locally
Lipschitz near the target contact. `ActualDensityHolder.lean` combines this with the full history
estimate. On a sufficiently small time neighborhood, the Lipschitz term is
bounded by a constant times `sqrt(t2-t1)`. The continuous bounded density in
the constructed integral equation is therefore one-half Holder. Its derivative
or a prior Holder assumption is never used.

`ActualHeatFluxHolder.lean` removes the cutoff through the actual layer
representation and identifies the density with the intrinsic one-sided
derivative `canonicalHeatThetaRightFlux`. At every positive maturity, there
are a neighborhood U of its heat time and A>=0 such that, for s1<s2 in U,

`|canonicalHeatThetaRightFlux(s2)-canonicalHeatThetaRightFlux(s1)|`
` <= A*sqrt(s2-s1)`.

The intrinsic derivative is also proved to satisfy `HasDerivWithinAt` from
the continuation side; no total-derivative default is used. The full
`k>0,0<=h<=k` theorem has explicit zero-dividend and Liu specializations.
Sixteen new transitive axiom guards cover these steps. Transfer of this
modulus to pricing flux and boundary velocity, and the higher regularity
bootstrap toward C2, remain unfinished.

## Pricing flux, C1,1/2 velocity, and linear history remainder

`LocalHalfHolder.lean` records the precise local square-root modulus on all
ordered pairs in a neighborhood. It proves preservation under local equality,
positive time rescaling, and multiplication by a C1 factor, using continuity
to obtain local bounds for the factors.

`ActualVelocityHolder.lean` proves the exact intrinsic-flux identity

`canonicalThetaRightFlux(t)`
` = inverseThetaHeatGauge(b(t),t)*canonicalHeatThetaRightFlux(2*t)`.

Both sides are genuine continuation-sided derivatives. The inverse gauge is
C1 along the actual boundary. The heat-time change and this multiplier
therefore transfer the one-half Holder bound to the pricing flux. The
coefficient `-1/(k-h*exp(b(t)))` is C1 because its denominator is strictly
positive. Multiplication by this coefficient and the proved Stefan identity
give `LocalHalfHolderAt (deriv (canonicalLogBoundary k h)) t` at every t>0.
The actual normalized boundary is thus locally C1,1/2. The corresponding
heat-coordinate velocity has the same exponent. Zero-dividend and Liu-range
pricing-flux and velocity checkpoints are explicit.

`HalfHolderRemainder.lean` applies the mean-value inequality to the function
minus an anchored line. On a sufficiently small positive interval, for
s<=t and every anchor r in [s,t],

`|b(t)-b(s)-b'(r)*(t-s)| <= A*(t-s)*sqrt(t-s)`.

The derivative modulus and remainder are supplied for the actual heat graph
by `ActualGraphRemainder.lean`, including the two restricted regimes. No
second derivative is involved in this estimate.

`HeatHistoryLinearization.lean` multiplies this order-u^(3/2) graph error
by the checked order-u^(-3/2) spatial kernel bound. Hence

`|H(u,x)-H(u,v*u)| <= 3*A/sqrt(2*pi)`

whenever `|x-v*u|<=A*u*sqrt(u)`. With a one-half Holder density, subtracting
the frozen linear-kernel/density product likewise has a bounded remainder.
The unweighted kernel estimate is specialized to the actual graph, uniformly
in endpoints and anchors on its local interval.

Twenty-one new transitive axiom guards cover this stage. A bounded remainder
alone is not a bound for its time derivative or increments. The next analytic
step is to improve the history time modulus beyond exponent one-half; the
higher bootstrap and actual-boundary C2 result remain unfinished.

## Frozen-remainder time derivative and three-quarter common-past bound

`HeatKernelGradientMotion.lean` uses the heat equation to obtain the second
spatial kernel derivative bound from the existing time-derivative estimate.
The mean-value inequality then controls changes of the spatial kernel gradient
on the displacement interval `|x|<=L*u`.

`HeatHistoryRemainderDerivative.lean` writes the observation-time derivative as

`D(u,x,w)=-H(u,x)/u+(w-x/(2*u))*H_x(u,x)`.

For a fixed reference slope v, `|x-v*u|<=A*u*sqrt(u)` and
`|w-v|<=A*sqrt(u)`, with `|x|<=L*u`, `|v|<=L` and `0<u<=1`, it proves

`|D(u,x,w)-D(u,v*u,v)| <= (8+5*L^2)*A/(sqrt(2*pi)*u)`.

The reference slope is held fixed during differentiation, even when it was
chosen from an actual earlier boundary velocity. No b'' is used.

`HeatHistoryRemainderTime.lean` handles the weighted remainder

`R(t,s)=H(t-s,b(t)-b(s))*f(s)-H(t-s,v*(t-s))*c`.

Here s, v and c are all fixed while t varies. If `|f(s)|<=C` and
`|f(s)-c|<=D*sqrt(t-s)`, the derivative bound is

`|R_t(t,s)| <= ((8+5*L^2)*A*C+8*L*D)/(sqrt(2*pi)*(t-s))`.

The mean-value inequality gives a corresponding increment estimate with
denominator `t1-s`. Source-time continuity is proved from continuity of b and
f on the source interval. `ActualRemainderTime.lean` supplies every graph
hypothesis from the actual C1,1/2 boundary, choosing v=b'(t1). Zero-dividend
and Liu-range controls are explicit; only the indicated density-value bounds
remain inputs to this reusable estimate.

`HeatRemainderInterpolation.lean` proves the elementary near/far inequality
`min(1,delta/u)<=(delta/u)^(3/4)`. The majorant u^(-3/4) is integrable on
(0,T), with integral `4*T^(1/4)`. Measurability plus domination establishes
genuine integrability, not just a bound on Lean's total integral.

`HeatRemainderOverlap.lean` combines the bounded remainder and the new time
estimate. With source time s=t1-u and the same v,c at both observations, the
common-past remainder difference is integrable and its integral has bound

`4*max(B_near,C_far)*T^(1/4)*(t2-t1)^(3/4)`,

where `B_near=6*(A*C+L*D)/sqrt(2*pi)` and
`C_far=((8+5*L^2)*A*C+8*L*D)/sqrt(2*pi)`. The graph and density hypotheses
are explicit in the theorem. Eighteen new transitive axiom guards cover this
stage.

This is a three-quarter bound for the common-past frozen remainder, not yet
for the complete actual history or flux. The reference integral, recent-source
contribution, and older sources outside the local Holder window still need
assembly. In particular, the already-verified actual flux/velocity modulus
remains one-half at this checkpoint, and C2 remains unfinished.

## Complete local history: reference and recent-source terms assembled

`HeatHistoryReference.lean` proves integrability of
`linearHeatHistoryIntegral(v,c,T)=integral_(0,T) H(u,v*u)*c`.
For fixed v,c and 0<T1<=T2, its difference is bounded by

`3*L*C/(sqrt(2*pi)*sqrt(T1))*(T2-T1)`

when `|v|<=L` and `|c|<=C`. Only the upper elapsed-time limit changes. Both
integrals and their split are proved integrable.

For the new source interval, the frozen reference time precedes the source.
`HeatRemainderRecent.lean` handles this explicitly: a uniform velocity error
`A*sqrt(delta)` gives graph error `A*sqrt(delta)*u` by the mean-value
inequality. With density error `D*sqrt(delta)`, the remainder is dominated
by `3*(A*C+L*D)*sqrt(delta)/(sqrt(2*pi)*sqrt(u))`. Its integral over (0,delta)
is genuinely integrable and bounded by

`6*(A*C+L*D)/sqrt(2*pi)*delta`.

`HeatHistoryFrozenDecomposition.lean` proves the exact identity splitting
the full history difference into the common-past remainder, new-source
remainder, and reference difference. Each reference and history subtraction
has an integrability proof; the reference parameters are identical at both
observations.

`HeatHistoryThreeQuarter.lean` assembles these three bounds. For
`a<t1<t2`, `t2-a<=1`, and the stated square-root comparison bounds, the
complete history satisfies

`|heatHistoryFrom(b,f,a,t2)-heatHistoryFrom(b,f,a,t1)|`
` <= heatHistoryThreeQuarterConstant(A,L,C,D,t1-a)*(t2-t1)^(3/4)`.

The constant includes the common-past coefficient, recent-source coefficient,
and reference coefficient `3*L*C/(sqrt(2*pi)*sqrt(t1-a))`.
`HalfHolderHistory.lean` derives every comparison premise from C1 graph
regularity, a square-root modulus for its derivative, and a square-root
modulus for the continuous bounded density on the source window. There is
no density derivative or second graph derivative hypothesis.

`ActualHistoryThreeQuarter.lean` supplies the graph hypotheses from the actual
boundary. Around every positive heat time it constructs an interval and
constants that work for every smaller closed source window of length at most
one, and every bounded continuous density with a square-root modulus there.
The graph is clamped strictly before this interval, preserving all source
values and all derivatives used in the proof; exact integral equalities remove
the clamp. The complete-history estimate is explicit in zero-dividend and
Liu regimes as well. Sixteen new transitive axiom guards cover this stage.

At this checkpoint the estimate covered a local source window only. The
following step extends it to the original causal history.

## Full-history bootstrap to actual C1,3/4 boundary regularity

`ActualOlderHistory.lean` proves source-time integrability for the actual
graph and the exact split at a new local start a. The old portion over
(a0,a) is Lipschitz for observations t1<=t2 with a+e<=t1, e>0:

`|oldHistory(t2)-oldHistory(t1)|`
` <= 8*L*C*(a-a0)/(e*sqrt(2*pi*e))*(t2-t1)`.

Here L is a proved actual-graph bound on a compact positive-time window and
C bounds the continuous density. No regularity of the density at old source
times beyond continuity is needed. `ActualFullHistoryThreeQuarter.lean`
chooses a closed source window inside the local half-Holder neighborhood
and a smaller observation neighborhood. Its fixed gap from a bounds the
recent-history coefficient uniformly. Adding the old Lipschitz part gives
`LocalThreeQuarterHolderAt` for the full original history.

`ActualDensityThreeQuarter.lean` first obtains the existing half-Holder
density estimate, then uses the full-history improvement in the same
equation f=forcing+history. The forcing is C1. The density is consequently
three-quarter Holder without assuming any density derivative.

`ActualHeatFluxThreeQuarter.lean` transfers this bound via the actual layer
representation and uniqueness of the right derivative. Finally
`ActualVelocityThreeQuarter.lean` gives, for k>0 and 0<=h<=k, at every t>0:

- `LocalThreeQuarterHolderAt (canonicalThetaRightFlux k h) t`;
- `LocalThreeQuarterHolderAt (deriv (canonicalLogBoundary k h)) t`;
- the corresponding three-quarter bound for the heat-coordinate graph speed.

Zero-dividend and Liu checkpoints are explicit. Twenty-two new guarded
transitive axiom checks cover the analytic split, full-history estimate,
density, intrinsic flux identification, transfer rules and actual velocity.
No second derivative is assumed or concluded. C2 and the actual classical
curvature contract remain unfinished.

## Integrable frozen-history derivative at the actual boundary

The actual C1,3/4 graph gives the checked remainder

`|b(t)-b(s)-b'(r)*(t-s)| <= A*(t-s)*(t-s)^(3/4)`

for every anchor r between s and t in a positive-time window.
`ThreeQuarterRemainderDerivative.lean` uses the previous half-Holder
derivative estimate with effective constants `A*u^(1/4)` and `D*u^(1/4)`.
For a frozen reference slope v and density value c the result is

`|d/dr [K_b(r,s)*f(s)-H(r-s,v*(r-s))*c] at r=t|`
` <= (((8+5*L^2)*A*C+8*L*D)/sqrt(2*pi))*(t-s)^(-3/4)`.

Here the graph and velocity errors relative to v have orders 7/4 and 3/4,
the density error relative to c has order 3/4, and t-s<=1. Reference values
and source time are held fixed. Neither b'' nor f' is assumed.

`FrozenDerivativeIntegrability.lean` proves source continuity away from the
diagonal using the explicit smooth kernel derivative. The integrable
majorant gives both genuine integrability and a norm bound for the integral.
`ActualFrozenDerivative.lean` supplies the actual graph conditions and, for
the actual heat flux, chooses a local window T and M>=0 such that every
0<delta<=T has an integrable frozen derivative with integral norm at most
`M*delta^(1/4)`. Constants can depend on the fixed positive observation time.
The same conclusion holds for any continuous positive-time density with a
local three-quarter modulus there. Zero-dividend and Liu specializations
are included, with fifteen new guarded transitive axiom checks.

The full moving-endpoint differentiation and continuity of its derivative
are not yet proved. Consequently this checkpoint does not conclude C2.

## New-source quotient and common-past right derivative

`ThreeQuarterRecent.lean` upgrades the new-source remainder estimate:

`|integral_0^delta R(t+delta,t+delta-u) du|`
` <= (6*(A*C+L*D)/sqrt(2*pi))*delta^(5/4)`.

The reference slope and value are frozen at t. The graph error is bounded
by `A*delta^(3/4)*u` and the density error by `D*delta^(3/4)`. Genuine
integrability follows from an inverse-square-root majorant. Division by
delta leaves a quarter-power bound, proving the quotient tends to zero.
`ActualRecentRemainder.lean` supplies these conditions for the actual graph
and any positive-time continuous locally three-quarter density. The
intrinsic actual heat flux and both restricted parameter regimes are
explicit specializations.

`RightIntegralDerivative.lean` proves right differentiation under an
integral from an integrable slope majorant and pointwise derivatives.
The proof applies dominated convergence to the difference quotients and
uses genuine integrability for the difference-of-integrals identity.
`FrozenCommonPastDerivative.lean` obtains the slope majorant by bounding
the derivative at all intermediate observations to the right of t.
Elapsed time there exceeds its initial value u, so the `u^(-3/4)` bound
is uniform and integrable on the fixed source interval.

`ActualCommonPastDerivative.lean` proves existence of a short T>0, T<t,
for which the actual graph satisfies the right-derivative theorem. Its
density assumptions are global bounded continuity and the already proved
local three-quarter modulus. These are suitable for the constructed causal
density. Both reference values and the source endpoint are fixed during
this derivative. Twelve new axiom guards check the transitive dependencies.

The derivative of the full original history is not yet assembled. The
straight-line reference and older-source derivatives must be included,
and continuity/two-sided differentiability established before claiming C2.

## Right differentiation from the original causal start to the actual flux

The straight-line reference now has the ordinary derivative

`d/dT linearHeatHistoryIntegral(v,c,T) = H(T,v*T)*c`, for T>0.

`HistoryRightAssembly.lean` checks the exact increment decomposition in
elapsed time and combines the reference derivative with common-past right
differentiation and the vanishing new-source quotient. It produces a right
derivative for a complete local history integral, without differentiating
the reference slope, density value or source density.

`OlderHistoryDerivative.lean` separately differentiates the old-source
integral. Its interval ends strictly before the observation time; a positive
gap controls the kernel derivative uniformly on a two-sided observation
neighborhood. The actual graph is only required to be C1, and the density
continuous and bounded. Genuine integrability is supplied by the actual
history theorem and a constant derivative majorant on a finite interval.

`FullHistoryRightDerivative.lean` extends the result to any original positive
causal start. If that start lies before the constructed local one, the old
portion is added; if it lies after it, the intervening old portion is
subtracted. The exact split holds on a neighborhood of the observation.
Both original source-time and elapsed-time formulations have a right
derivative.

`ActualDensityRightDerivative.lean` applies this result to the constructed
density equation, after deriving its three-quarter modulus from C1 forcing.
`ActualHeatFluxRightDerivative.lean` removes the cutoff via the proved
local layer representation and uniqueness of the right spatial derivative.
The resulting intrinsic heat flux has a right time derivative at every
positive heat time. Zero-dividend and Liu cases are explicit. Fifteen new
transitive axiom guards verify the complete dependency chain.

Continuity of the time derivative and two-sided time differentiability are
not yet established. No C2 boundary or classical pointwise curvature claim
is made by this checkpoint.
