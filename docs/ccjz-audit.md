# CCJZ American-put boundary convexity: source audit and formalization plan

## Status — main theorem NOT formalized

Target: X. Chen, J. Chadam, L. Jiang, W. Zheng, **Convexity of the Exercise Boundary
of the American Put Option on a Zero Dividend Asset**, *Mathematical Finance*
18(1), 2008, pp. 185–197, Theorem 1.1.
[User-supplied paper](https://sites.pitt.edu/~chadam/papers/3CCJW9-28-05.pdf).
Page numbers below are the printed journal pages, not PDF page indices.

The full 13-page paper was read. Equations and several apparent transcription
errors in the extracted text were checked against rendered original pages. This
is a dependency/scope audit and initial proof work, **not a certification of every
analytic argument in the paper**, and not a formalization of its near-expiry
asymptotics (Theorem 1.2).

## 1. Is this already in MathFin?

**No matching formalization was found** at
`784a8311f75a1519a23717856df9982bd6a9a370`, which also matched the remote HEAD during
this audit. Search covered all 284 `MathFin/**/*.lean` modules, the umbrella,
and coverage/roadmap documents, using boundary/free-boundary, American/convexity,
optimal-stopping, author names, and actual `ConvexOn`/`StrictConvexOn` occurrences.
The nearest candidate modules were inspected at the statement/definition level;
the American and Snell modules were read in full.

| Candidate | Actual content | Why it is not Theorem 1.1 |
| --- | --- | --- |
| `Binomial/American.lean` | `americanPrice : ... → ℕ → ℝ → ℝ`, Bellman maximum; payoff and European-price lower bounds | Finite-step recursion, no continuous exercise boundary |
| `Binomial/SnellEnvelope.lean` | Scalar and coin-flip-path domination, adaptedness and minimality; discounted identification | Still discrete; explicitly leaves supremum-over-stopping-times identification as downstream work (lines 53–54) |
| `BlackScholes/SpotConvexity.lean` | `bsV_spot_convexOn`, convexity of the **European call price in spot** | Different object and independent variable |
| `BlackScholes/StrikeConvexity.lean` | `bsV_strike_convexOn`, `bsP_strike_convexOn` | European call/put **price in strike**, not American boundary in time |
| `BlackScholes/PutStrikeConvexity.lean` | Second strike derivative of the European put formula | Again a price Greek, not boundary curvature |
| `Binomial/MertonAmericanCallTree.lean` | No early exercise of a non-dividend American **call** | Different option and theorem |

Upstream `docs/open-problems.md`, lines 330–341, explicitly acknowledges the
continuous-boundary gap. Its earlier table saying the zero-dividend case is
“proved” refers to mathematical literature, not a Lean declaration. A European
CRR pricing limit does not establish convergence of American stopping regions.

Thus there is no existing proof of our target to audit step by step. Our successful
build and axiom guards for the imported discrete results are not evidence that
this continuous-time theorem is already proved. We have not audited all of MathFin
or all of its unrelated stochastic-calculus proofs.

## 2. Exact mathematical target

Fix **positive** strike `E`, volatility `σ`, risk-free rate `r`, and maturity `T_F`,
with zero dividend yield. The paper's argument uses `k = 2r/σ² > 0`; do not silently
extend it to zero or negative rates.

The financial value to identify is the finite-horizon optimal stopping value under
risk-neutral GBM. With remaining physical time `τ`, this is

```text
U(S, τ) = sup over stopping times 0 ≤ θ ≤ τ
          E[exp(-r θ) · max(E - S exp((r - σ²/2)θ + σ W_θ), 0)].
```

This target now has an implemented dividend-capable counterpart in `Stopping/`.
The constructed Brownian probability space, natural filtration, admissible
bounded stopping times, reward measurability/integrability, and nonempty/bounded
value set are checked. The in-the-money contact threshold is also constructed.
The verification link to a classical obstacle solution, its existence and
regularity, and the usual-filtration comparison remain open. See
[the exact financial definition and verification frontier](stopping-value.md).

Before expiry, the exercise set must be proved to be an interval of stock prices,
with a genuine threshold `S_f(T)`, not defined to have the properties we want.
At expiry the value equals the payoff for **all** stock prices: the supremum of
that entire coincidence set is not `E`. Set the terminal boundary to `E` by the
in-the-money/left-limit convention and prove its continuity, rather than treating
the terminal coincidence set as the same finite-threshold characterization.

The paper sets

```text
t = (σ²/2)(T_F - T),    x = log(S/E),    k = 2r/σ²,
P(S,T) = E p(x,t),      S_f(T) = E exp(s(t)).
```

The normalized continuation equation is

```text
p_t - p_xx - (k-1)p_x + kp = 0             for t>0, x>s(t),
p(s(t),t) = 1-exp(s(t)),  p_x(s(t),t) = -exp(s(t)).
```

Include initial payoff, stopping-region equality, strict continuation-region
inequality, growth/boundedness and regularity conditions. The initial condition
on negative `x` is supplied by the paper's stopping-region extension; it must not
be discarded when reading equation (1.1).

**Theorem 1.1 is stronger than ordinary convexity:** it gives `s''(t) > 0` for
`t > 0`, and `S_f''(T) > 0` before expiry. The coordinate identity on p. 186 is

```text
S_f''(T) = (σ⁴/4) E exp(s(t)) [s''(t) + (s'(t))²].
```

Smoothness/positive second derivative at expiry is **not** part of the claim.
Convexity on a closed time interval requires a separate continuity-at-expiry step.
Stock-price boundary convexity is not generally equivalent to log-boundary
convexity; the implication above is the direction the paper uses.

## 3. Paper dependencies — what must be proved, not assumed away

Following the supplied paper, rather than detouring through a binomial limit:

| Stage | Paper location | Outstanding obligation |
| --- | --- | --- |
| Financial interpretation | Introduction, p. 186 | Identify the GBM optimal stopping value with the obstacle/free-boundary solution |
| Analytic solution | Equation (1.1), external references | Existence, uniqueness, boundary regularity, monotonicity, smooth fit; non-vacuity of solution hypotheses |
| Smooth approximate profiles | Lemma 3.4, appendix | Implemented: (2.3), (2.6), (3.1), (3.2), (3.8); exact sign identities avoid the informal `O(ε)` estimates |
| Stefan solutions | Lemma 2.1 | Existence, uniqueness and regularity on moving/unbounded domains; proof is cited, not supplied in the paper |
| Recover prices and boundaries | Lemma 2.2, Theorem 2.1 | ODE/integral reconstruction, obstacle comparison, convergence of **boundaries**, not just prices |
| Sign geometry | Lemmas 3.1–3.2 | Parabolic zero-number principle, Hopf lemma, unique smooth zero curves, behavior at spatial infinity |
| Approximate curvature | Equations (3.3)–(3.7), Lemma 3.3 | Nonzero denominator for `φ=q_t/q_x`, derivative identities, Robin boundary condition, maximum-principle argument giving `φ_x<0` |
| Weak convexity in the limit | Proof of Theorem 1, p. 193 | Apply convexity-under-limits once the actual boundary convergence is proved |
| Strict curvature in the limit | Final paragraph on p. 193 | Prove convergence of derivatives in flattened boundary coordinates, regularity and the strong-maximum-principle/nontriviality argument |
| Return to stock/calendar units | Theorem 1.1, p. 186 | Coordinate identity and positive prefactor — now implemented as generic lemmas |

The final paragraph's “together with all derivatives” convergence and “a strong
maximum principle then gives” are substantive obligations. Uniform convergence
of prices does not by itself imply convergence of contact sets, and a limit of
strictly convex functions need not be strictly convex (`x²/n → 0`).

Searches of pinned Mathlib/BrownianMotion did not locate the needed parabolic
Hopf, Stefan well-posedness or parabolic zero-number theorems. This is a missing
infrastructure finding, not a proof that no differently packaged general result
could ever be reused. Generic calculus, topology, integrability and convexity
infrastructure are available.

## 4. Source issues to resolve explicitly

### A. A substantive initial-endpoint issue in Lemma 2.1

On p. 189, (2.3) allows `q₀'(0)=0` but Lemma 2.1 asserts `s'(t)<0` on **[0,∞)**.
Take

```text
q₀(x) = x³ exp(-x),  x ≥ 0.
```

It is `C⁴` (indeed smooth), positive for `x>0`, integrable on `(0,∞)`, vanishes
at zero and infinity, and has `q₀'(0)=q₀''(0)=0`. Hence for every `k>0` it satisfies
all the printed (2.3), including `(q₀'(0))² = k Lq₀(0)`. But the Stefan condition
at the initial corner gives `0 = -k s'(0)`, so `s'(0)=0`, not `<0`.

`Boundary/InitialProfileCheck.lean` **machine-checks those profile conditions**
and the zero-speed implication. It does not formalize Stefan existence, nor is
it a counterexample to the main boundary-convexity theorem.

A faithful proof must either restrict this strict-speed conclusion to `t>0`, or
add `q₀'(0)>0` when claiming it at `t=0`. The later condition (3.1) does impose
positive initial slope, as do the appendix's chosen profiles, so this issue need
not invalidate the main theorem's intended argument.

### B. Apparent printed typos, checked on rendered pages

- **p. 191, Lemma 3.1 proof:** after negative initial/boundary second derivatives,
  the text prints `q_xx > 0` where the argument requires `<0`, then switches to
  `p_xx` when discussing the zero curve of `q_x`. These are not identities to copy
  into Lean. The lemma's actual stated conclusion is `q_xx < 0`.
- **p. 193, proof of Theorem 1:** it cites `s_ε' < 0` immediately before concluding
  `s'' ≥ 0` in the limit. Decreasing approximants are not enough; the needed input
  is the convexity/positive second derivative established in Lemma 3.3.

These observations motivate checking the mathematics rather than mechanically
transcribing the typeset text. They are not claims to have refuted Theorem 1.1.

## 5. What is now kernel-checked locally

- `Boundary/Coordinates.lean`: definitions of normalized time and reconstructed
  boundary; expiry convention; first derivative; **the exact second-derivative
  identity**; transfer of positive curvature; transfer of ordinary convexity.
- `Boundary/Limits.lean`: pointwise limits preserve ordinary convexity on a fixed
  convex domain. Uses a nontrivial filter so convergence is not vacuous.
- `Boundary/InitialProfileCheck.lean`: the auxiliary-lemma endpoint check above.

These files make **no claim that an arbitrary input function is the actual optimal
exercise boundary**. In particular, the hypothesis of positive log-boundary
curvature in the coordinate lemma remains to be proved for the PDE solution.
There is no placeholder theorem asserting the main result, no `sorry`, and no
new project axiom. `lake build` checks the code; selected results have axiom guards.

## 6. Solution-definition milestone and next work

The normalized obstacle and smooth-data Stefan predicates are now implemented,
with explicit regularity and one-sided boundary conditions. The contact/payoff
correspondence in stock units is checked. The analytic curvature and existence
goals are explicit proposition definitions, with no proof asserted. The appendix
coefficient and profiles now satisfy all of (2.3), (2.6), (3.1), (3.2), and (3.8),
completing the initial-data construction in Lemma 3.4. The
[appendix proof notes](appendix-proof.md) explain the exact replacements for the
source's asymptotic sign estimates.

See [solution definitions and statement review](solution-contract.md) for the exact
scope, source checks and the proof-route decision. We may use a different valid
proof of the known theorem; there is no requirement to reproduce CCJZ's argument.

The remaining work now concerns analytic existence/uniqueness, propagation of the
initial sign conditions through the Stefan evolution, higher corner regularity,
boundary convergence and the stochastic verification link. Never
package convexity, derivative convergence, or the desired maximum-principle
conclusion as an unexplained field and call the resulting projection a proof of
Theorem 1.1.
