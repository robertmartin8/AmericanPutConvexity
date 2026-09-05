# Continuous-time stopping value and the remaining classical identification

The curvature proof is complete for `DividendPutSolution`. This development
defines the financial value to which that contract must be connected. It does
not assert that the connection is already proved.

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

This is the raw natural filtration. Equality with a formulation using the usual
completed/right-continuous augmentation is not yet proved. No representation
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
the stopped-candidate martingale property. Those stochastic properties are still
unproved; the optional-stopping and verification results do not supply them.
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

Those two stochastic properties and existence of a classical pair remain open.
An admissible contact rule is now constructed, but its optimality is still
conditional on the unproved martingale properties. It is not an independently
verified optimal stopping rule yet.

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
Brownian filtration. This is not yet a martingale statement for the original
candidate on the raw filtration. We still need to assemble the local statements
along the path up to first contact, promote the bounded stopped process to a
true martingale, and transfer to the raw filtration. The global candidate's
supermartingale property across the exercise boundary is also still missing.

The new import traverses upstream files containing unfinished declarations;
the guarded axiom checks on `plane_ito_localMartingale` and `local_price_ito`
verify their actual proof chains contain only `propext`, `Classical.choice`,
and `Quot.sound`, not `sorryAx`. This is a dependency-specific check, not a
claim that all imported declarations are complete.

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

**`hprice` and existence of such a classical pair remain unproved.** The
conditional transfer is not a theorem asserting actual-boundary curvature
without those premises.

## Remaining verification obligations

The substantive missing step is to connect optimal stopping to the classical
free-boundary problem, either by verifying a constructed classical solution
against the stopping value or by deriving the contract from the value. This
includes the needed existence, continuation PDE, strict continuation,
positive-time boundary regularity, smooth fit and gradient trace, joint price
continuity, and tail behavior. No such facts follow merely from the supremum
definition or the spot-convexity proof above.

In particular, strict positivity of the financial threshold, separation from
the strike at positive maturity, continuity of that threshold, and legitimacy
of its logarithm as the classical boundary are not established here. The
augmented-filtration comparison is also outstanding. These gaps remain visible;
none is replaced with an axiom or added as a field of the financial value.
