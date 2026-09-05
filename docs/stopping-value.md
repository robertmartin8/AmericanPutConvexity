# Continuous-time stopping value and checked classical identification

The curvature proof is complete for `DividendPutSolution`. This development
defines the financial value and now proves that any pair satisfying that
classical contract equals the Brownian American stopping value on both the raw
and completed usual filtrations. Classical-pair existence remains open.

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
construction includes the needed existence, continuation PDE, positivity of the
stock threshold, boundary continuity and positive-time regularity, smooth fit
and gradient trace.
No such facts follow merely from the supremum
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
`canonicalContinuationRegion` is open. None of this asserts `B(T)>0`; a finite
logarithmic boundary and its regularity still need to be established.

## One-sided boundary continuity and actual first contact

`BoundarySemicontinuity.lean` proves upper semicontinuity of the actual threshold
from maturity continuity of the stopping value. If a test spot is strictly above
the threshold and at most the strike, its strictly positive continuation premium
persists at nearby maturities. If the test spot exceeds strike, the uniform
threshold bound suffices. Thus all nearby thresholds remain below any fixed
strict upper bound for the threshold at the base time. Maturity monotonicity
then proves continuity from shorter maturities. This is not a proof of continuity
from longer maturities or of the right limit at expiry. The results apply to the
raw and usual models, and to `canonicalStockBoundary` with its real-time clamp.

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
a classical pair. The full dynamic programming principle, the corresponding
stopped-martingale characterization, and the continuation PDE remain open.

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
that full martingale characterization. The characterization and classical
PDE/boundary regularity remain open.

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
stopping rules themselves, nor does it identify the stopped process as a
martingale without a further argument.

`ActualOptimality.lean` discharges every premise on the completed usual Brownian
space. It uses the actual `canonicalDiscountedPrice`, the original discounted
put payoff frozen at maturity, `brownianUsualActualContactRule`, and the already
proved optimal-grid expected-payoff convergence. The final result is
`brownianUsualActualContactRule_optimal`: the contact rule's expected monetary
payoff equals `canonicalPrice k h x T` for `k>=0`, arbitrary real `h,x`, and
nonnegative maturity. Strike is one and volatility is `sqrt(2)`, as in the
canonical definition. This is actual continuous-time optimality, not merely
optimality conditional on a PDE solution or on an assumed optimal rule.

The full dynamic programming principle, stopped-martingale characterization,
and classical PDE, smooth-fit and boundary-regularity obligations remain open.
