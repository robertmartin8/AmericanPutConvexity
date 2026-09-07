# PR draft: American put option boundary log-convexity

Local draft only: no upstream branch or pull request has been created. The
proof exists in the downstream repository; its integration into MathFin is
not yet implemented. The checklist below deliberately records that distinction.

**Suggested title:** `feat: log-convexity of the American put option exercise boundary`

---

## Summary

This contribution proposes upstreaming a continuous-time proof of the
American put option boundary-convexity result requested in #175. The proof
and Lean formalization are available in
[AmericanPutConvexity](https://github.com/robertmartin8/AmericanPutConvexity).
I would welcome review of the mathematical statement and agreement on module
placement and staging before the integration is finalized.

In the Black–Scholes model with constant strike $K>0$, risk-free interest
rate $r>0$, volatility $\sigma>0$, and dividend yield $0\le q\le r$, the
result is

$$
\tau\longmapsto\log(B(\tau)/K)\quad\text{is convex on }(0,\infty),
$$

where $\tau$ is time-to-expiry and $B$ is the exercise boundary defined from
the continuous-time optimal-stopping value. The stock-price boundary $B$
is also strictly decreasing and strictly convex. Convexity here is with
respect to time-to-expiry, for fixed model parameters, not with respect to
the dividend yield or the initial stock price.

This covers the issue's full $0<q<r$ range and includes $q=0$ and $q=r$.
It does not assert strictly positive logarithmic curvature. The route is a
straight-line comparison argument, not the discrete-tree convexity invariant
suggested in the issue.

## Proposed scope

The initial contribution would contain the stopping-value construction and
the geometric boundary theorem, without the additional machinery needed
for classical second derivatives. The downstream project also proves
$C^2$ regularity and $B''(\tau)>0$; I propose contributing that layer
separately so that it does not enlarge the first review unnecessarily.

The geometric result is not a theorem about a postulated smooth solution.
The value is defined over all bounded stopping times of the completed usual
Brownian filtration. A separate equivalence permits almost-sure horizon
bounds. The project derives the pricing equation, smooth fit, exercise-region
geometry, and normalization from the stopping construction.

The relevant current project import closure contains 172 modules and about
17,800 lines. This is a whole-module count, not a minimal proof-term count.
I am happy to split the integration into dependency-ordered PRs, with reusable
analytic results first and the final boundary theorem last.

## Proof outline

1. Normalize time and log-price so the continuation equation is
   $p_t=p_{xx}+(k-h-1)p_x-kp$, with $k>0$ and $0\le h\le k$.
2. For a decreasing line $\ell(t)=d-ct$, construct an exact solution
   $\widehat p(x,t)=f(x-\ell(t))-e^xg(x-\ell(t))$. The two exponential
   profiles solve constant-coefficient ODEs and impose both payoff matching
   and smooth fit on the line.
3. Prove payoff domination below the strike. The decisive forcing term is
   $k-he^x+ce^x(g-1)\ge0$, using $h\le k$ and $g\ge1$.
4. Divide $p-\widehat p$ by the positive profile $f$. The quotient satisfies
   a parabolic equation without a zero-order term. An ODE slope identity
   gives interval-shaped initial superlevel sets; a direct three-point
   maximum argument preserves them. No Sturm zero-number theorem is assumed.
5. An explicit backward-rectangle barrier excludes a contact with the line
   followed by a later return below it. Smooth fit contradicts the positive
   spatial derivative forced by the barrier.
6. Combine the resulting time-interval property with the near-expiry estimate
   and chord geometry to prove convexity without differentiating the boundary.
   A separate no-flat-tail argument gives strict decrease, and strict
   convexity of the exponential gives strict convexity of $B$.

The manuscript and Lean share this structure. The manuscript uses a European
put asymptotic for the expiry estimate, while Lean proves the needed estimate
with an explicit square-root subsolution.

## Existing declarations and review artifacts

Current source snapshot:
[`9b2b208520341a63b64eef43c1ecb3c5708a8e63`](https://github.com/robertmartin8/AmericanPutConvexity/tree/9b2b208520341a63b64eef43c1ecb3c5708a8e63).
The declarations below are in `AmericanPutConvexity.Stopping`; final upstream
names and module locations remain to be agreed.

| Result | Declaration |
| --- | --- |
| Normalized log-convexity | `canonicalLogBoundary_convexOn` |
| Log-convexity in physical units | `brownianUsualLogBoundary_convexOn` |
| Strict convexity of the stock-price boundary | `brownianUsualStockBoundary_strictConvexOn` |
| Strict decrease | `brownianUsualStockBoundary_strictAntiOn` |
| Normalization of the actual stopping boundary | `brownianUsualExerciseBoundary_eq_scaled_canonical` |
| Optional subsequent classical-curvature layer | `brownianUsualBoundary_classical_curvature` |

- [Geometric theorem source](https://github.com/robertmartin8/AmericanPutConvexity/blob/9b2b208520341a63b64eef43c1ecb3c5708a8e63/AmericanPutConvexity/Stopping/PhysicalBoundaryConvexity.lean)
- [Proof correspondence audit](https://github.com/robertmartin8/AmericanPutConvexity/blob/9b2b208520341a63b64eef43c1ecb3c5708a8e63/docs/straight-line-audit.md)
- [Manuscript at that snapshot](https://github.com/robertmartin8/AmericanPutConvexity/blob/9b2b208520341a63b64eef43c1ecb3c5708a8e63/paper/log-convexity.pdf)

The original recorded fresh-kernel audit is preserved at
[`61e3cf5483353229962626c9a94ad5a0d4dd8bb3`](https://github.com/robertmartin8/AmericanPutConvexity/tree/61e3cf5483353229962626c9a94ad5a0d4dd8bb3).
That snapshot uses the earlier `AmericanConvexity` namespace. Its
[audit instructions](https://github.com/robertmartin8/AmericanPutConvexity/blob/61e3cf5483353229962626c9a94ad5a0d4dd8bb3/docs/dependency-audit.md)
and [JSON report](https://github.com/robertmartin8/AmericanPutConvexity/blob/61e3cf5483353229962626c9a94ad5a0d4dd8bb3/docs/audits/final-proof-dependencies.json)
record replay of 74,785 declarations, with only `propext`, `Classical.choice`,
and `Quot.sound`. The replay traverses declaration types and bodies and checks
the collected dependency closure in an initially empty Lean kernel environment.

These are downstream results and audit records, not claims that the proposed
MathFin integration has passed CI. The port will need its own build and audit.
Kernel checking also remains distinct from reviewing whether the formal
definitions and statements express the intended financial theorem.

## Integration approach

The downstream project already depends on MathFin, so adding it as a MathFin
dependency would create a cycle. I propose porting the required source modules
into MathFin instead, preserving attribution and reusing existing infrastructure.
Both projects currently use Lean 4.32.0; import/API compatibility still needs
to be checked against the selected MathFin commit.

The downstream proof uses MathFin's stochastic-calculus, GBM, heat-kernel, and
filtration infrastructure, together with Mathlib and BrownianMotion. It does
not obtain boundary convexity from an upstream American-pricing theorem.

## Provenance

The proof and formalization were developed by Robert Martin, Dianoa Labs,
with substantial AI assistance. The manuscript's AI appendix describes the
workflow and model attribution. The mathematical proof and formal definitions
remain open to independent review; model agreement is not offered as a
substitute for that review. The downstream code is Apache-2.0 licensed.

## Checklist — pending upstream integration

- [ ] Agree module placement and a reviewable staging plan.
- [ ] Port the required proofs into real `MathFin/` Lean modules.
- [ ] Add the required `@[expose] public section` declarations and file headers.
- [ ] Check final theorem statements and dependency axioms in the port.
- [ ] Run `lake build` and the applicable per-file checks in MathFin.
- [ ] Add benchmark re-export shims and accurate faithfulness metadata.
- [ ] Update `docs/coverage.md` and regenerate the axiom audit.
- [ ] Refresh and check the verification ledger.
- [ ] Run MathFin's Python regression tests.
- [ ] Record the upstream integration's exact revision and verification results.

## Related issues

Addresses #175. This draft proposes the full $0<q<r$ geometric result, but
does not request closure before the implementation is integrated and reviewed.
