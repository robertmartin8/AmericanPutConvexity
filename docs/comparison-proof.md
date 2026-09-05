# Straight-line comparison proof: target and verification frontier

## Target, conventions, and milestones

The current goal is to verify the user's proposed proof for the Black--Scholes
American put with constant continuous dividend yield:

```text
K > 0, sigma > 0, r > 0, 0 <= q <= r,
a = sigma^2 / 2, t = a tau,
b(t) = log(B(t/a) / K),
k = r/a, h = q/a, alpha = k-h-1.

Target: b''(t) >= 0 for every t > 0.
Consequence, once b'(t)<0 is established: B''(tau) > 0.
```

Time is time REMAINING, and arguments of prices are `(x,t)`. This is not
convexity of a price in stock price. No smoothness at expiry is asserted.

The user also requests the weaker parameter regimes as instructive milestones.
We retain the published-proof development; a specialization of the new proof
will not be described as an independent verification of a published proof.

| Milestone | Required conclusion | Current status |
| --- | --- | --- |
| New proof at zero dividends | `b'' >= 0`, with `h=0` | Open; explicit comparison construction and its payoff bound checked |
| Published CCJZ theorem | `b'' > 0` at `h=0`, hence stock-boundary positive curvature | Open; previous initial-data construction retained and checked |
| Liu parameter range | New proof's `b'' >= 0` when `h+1 <= k` | Open; comparison payoff bound specialized and physical condition checked |
| Full proposed extension | `b'' >= 0` for `0 <= h <= k`, `k>0` | Open; exact comparison construction and payoff domination checked |

CCJZ Theorem 1.1 explicitly proves positive logarithmic curvature at zero
dividends. The proposed weak logarithmic conclusion is not new at `q=0`.
Liu's introduction identifies the then-open range `0<q<r<q+sigma^2/2`.
Neither observation is a present-day priority determination.

- [CCJZ, Theorem 1.1](https://sites.pitt.edu/~chadam/papers/3CCJW9-28-05.pdf)
- [Liu, introduction](https://arxiv.org/pdf/1304.5337)

## What is kernel-checked

### Solution statement and parameter normalization

`DividendProblem.lean` specifies the classical dividend-paying PDE, payoff,
exercise/continuation conditions, regularity, boundedness, decay, and right-sided
smooth fit. It does NOT assume boundary monotonicity or convexity, any zero-count
invariant, or a maximum principle. The rate conditions are explicit.

`dividendPutSolution_zero_iff` proves exact equivalence with the preexisting
`NormalizedPutSolution` at `h=0`. `normalized_dividend_regime` checks the physical
parameter inequalities; `liu_condition_normalization` proves that `h+1<=k`
is equivalent to `q+sigma^2/2<=r`.

The curvature targets are named **proposition definitions**, not asserted
theorems. Their elementary specialization implications are proved, without
asserting any of the open premises. Existence and identification with the
continuous-time GBM stopping value are still separate, unproved obligations.

### Step 2: explicit comparison construction

`Comparison.lean` constructs the elementary ODE profiles explicitly. At positive
killing rate it uses the two real characteristic roots; at zero killing rate it
uses the constant function one, including the double-root case.

Checked results include global smoothness, the ODE, value one and slope zero
at zero, and `F(z)>=1` for ALL real `z`. The last fact uses the exponential's
tangent inequality, not an assumption about the unknown option price.

`straightPrice_equation` proves the actual partial-derivative pricing equation
for the explicit comparison. `straightPrice_fit` proves both value matching and
smooth fit along `x=d-ct`. These theorems do not leave existence of `f,g` as an
assumption. In particular the killing rate in the second ODE is `h`, not `k`.

### Step 3: domination below strike

`excess_equation` checks identity (8) with actual first and second derivatives:

```text
H'' + (alpha-c) H' - k H
  = k - h exp(ell+z) + c exp(ell+z)(g(z)-1).
```

`ODEComparison.lean` replaces the Cauchy-kernel integral by a proved two-sided
integrating-factor comparison. For real roots `u,v`, set

```text
W(x) = exp(-u*x) [H'(x)-v*H(x)],
U(x) = exp(-v*x) H(x).
W'(x) = exp(-u*x) [H''(x)-(u+v)H'(x)+u*v*H(x)].
```

Nonnegative forcing makes `W` nondecreasing. Its value at zero is zero, so
`U'` is nonpositive to the left and nonnegative to the right. Hence `U>=0`,
and thus `H>=0`, on both sides of zero. The lemma is proved from ordinary
derivative monotonicity and has no integral-representation or PDE assumptions.

`straightPrice_dominates` concludes the payoff bound for `x<=0`, `t>=0`,
`d<=0`, `c>=0`, `0<=h<=k`. Named zero-dividend and Liu-range specializations
are also checked. These are comparison lemmas, not curvature theorems.

### Step 4: elementary identities (not propagation)

The Riccati derivative of `F'/F`, the derivative of `R=exp(-z)f/g`, and
`J(0)=-1` are checked. `slope_gap_crosses_up` proves the actual derivative
identity `J'(z)=c` whenever `J(z)=0`. `positive_root_gap` proves
`lambda>mu+1` from the two characteristic equations when `c>0`; it also
allows `mu=0` for the constant zero-dividend profile.

The single-hump conclusion, far-field convergence, normalized difference PDE,
and its positive-time zero-count initialization are NOT yet formalized.

## Analytic dependencies still to prove

1. **Step 1.** Near-expiry `b(t)/t -> -infinity`, tangent-intercept selection,
   and the geometric consequences of a strictly negative second derivative.
2. **Step 4, initialization.** Derive the initial single-positive-interval shape,
   handle noncritical positive levels, prove uniform corner/tail signs and
   derivative convergence near the simple initial zeros.
3. **Step 4, propagation.** Prove the necessary parabolic maximum/zero-number
   results, check their hypotheses for the normalized difference, and pass from
   positive levels to the positivity set. Do not assume the desired invariant
   as a field of the pricing-solution contract.
4. **Step 5.** Formalize the existence of a positive point at tangency and the
   backward-strip comparison barrier giving the smooth-fit contradiction.
5. **Financial applicability.** Establish the properties needed for the
   actual American value, including boundary regularity and monotonicity,
   rather than only proving a conditional theorem for an uninhabited contract.
6. **Conclusions.** Prove the curvature claims and their parameter specializations;
   transfer to stock units. Preserve the distinction between weak and strict
   logarithmic curvature. Retain the separate CCJZ route and its stronger target.

For the informal audit, [Lou's Theorem 1.2 and Lemma 2.1](https://arxiv.org/pdf/1809.00309)
provide an appropriate moving-boundary zero-number statement: with nonzero
boundary values, continuous boundary curves suffice. This avoids introducing
`b'(0+)` through a coordinate change, but does not by itself initialize the
zero count. **A literature citation is not an imported Lean theorem.**

The suggested final barrier is in coordinates `y=x-ell(t)`:

```text
w_t = w_yy + beta(y) w_y,
beta(y) = alpha-c+2 f'(y)/f(y),
psi(y) = exp(lambda*y)-1,
psi''+beta psi' = lambda exp(lambda*y)(lambda+beta) > 0.
```

On a small backward rectangle, a small multiple of `psi` is bounded above by
`w` on its initial and lateral edges. Weak comparison would give a strictly
positive right derivative at the terminal tangency, contradicting smooth fit.
This is an audited informal route, not yet a checked lemma.

## Verification boundaries

All new proof modules use Mathlib, not MathFin's pricing theorems. No `sorry`,
new axiom, numerical output, or purported review is used as a proof premise.
Selected new declarations have build-enforced axiom guards.

The pasted numerical reports have not been reproduced. The named solver/test
scripts and figure were not supplied in this repository at the initial audit.
No novelty claim is certified by either these reports or the current Lean build.
