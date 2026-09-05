# AmericanConvexity

A Lean 4 project working toward a formal proof that the optimal exercise boundary
of an American put on a non-dividend-paying asset is convex. We build on
[MathFin](https://github.com/formal-applied-math/formal-mathfin) and Mathlib.

> **Status: the main theorem is not yet formalized.** The environment is working,
> the upstream library and source paper have been investigated, and several
> supporting results are kernel-checked. The substantial free-boundary PDE proof
> and its connection to the financial optimal-stopping problem remain outstanding.

## Target theorem

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
| [`Boundary/Stefan.lean`](AmericanConvexity/Boundary/Stefan.lean) | Smooth-data Stefan interface and intrinsic one-sided initial derivatives; no existence theorem yet |
| [`Boundary/Profiles.lean`](AmericanConvexity/Boundary/Profiles.lean) | Explicit appendix coefficient and smooth profiles satisfying (2.3), with positive initial slope |
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

The appendix profiles satisfy all of (2.3), including corner compatibility, and
have positive initial slope. Their concentration limits, sign geometry and quotient
estimate have not yet been proved; this is not a completed Lemma 3.4. The earlier
flat-slope example also satisfies the new initial-data predicate.

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

The detailed dependency map is in [`docs/ccjz-audit.md`](docs/ccjz-audit.md).
Following the supplied paper requires:

1. **Existence and financial interpretation.** The normalized obstacle and
   smooth-data Stefan predicates are implemented. Prove existence/uniqueness,
   establish the additional corner regularity needed downstream, and identify the
   solution with the GBM optimal-stopping value so the assumptions are not vacuous.
2. **Approximation theory.** Complete the appendix profiles' concentration and
   sign estimates beyond the checked (2.3) conditions, establish Stefan
   well-posedness, recover the obstacle prices, and prove
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
