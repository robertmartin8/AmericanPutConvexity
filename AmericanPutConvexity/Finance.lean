import MathFin.Binomial.American
import MathFin.Binomial.SnellEnvelope

/-!
# MathFin integration examples

These examples check that we can use upstream definitions and theorems directly.
They are applications of existing results, not new mathematical contributions.

Import specific MathFin modules rather than the entire `MathFin` umbrella.
Our new results belong in the `AmericanPutConvexity` namespace and should reuse
`MathFin.americanPrice`, `MathFin.BinomialNoArb`, etc. instead of copying them.

Scope: these prices and Snell envelopes are for finite-step binomial models,
not a continuous-time American option or its exercise boundary.
-/

namespace AmericanPutConvexity

-- An American put is worth at least its immediate exercise payoff.
example (u d r K S : ℝ) (n : ℕ) :
    max (K - S) 0 ≤ MathFin.americanPrice u d r (fun s => max (K - s) 0) n S := by
  exact MathFin.americanPrice_ge_intrinsic u d r (fun s => max (K - s) 0) n S

-- Under no arbitrage, its price also dominates the corresponding European put.
example {u d r : ℝ} (h : MathFin.BinomialNoArb u d r) (K S : ℝ) (n : ℕ) :
    MathFin.binomialPrice u d r (fun s => max (K - s) 0) n S ≤
      MathFin.americanPrice u d r (fun s => max (K - s) 0) n S := by
  exact MathFin.binomialPrice_le_americanPrice h (fun s => max (K - s) 0) n S

-- Any dominating supermartingale candidate gives an upper bound on the price.
example {u d r : ℝ} (h : MathFin.BinomialNoArb u d r)
    (g : ℝ → ℝ) (V : ℕ → ℝ → ℝ)
    (hV_g : ∀ n S, g S ≤ V n S)
    (hV_super : ∀ n S,
      MathFin.binomialOptionPriceOnePeriod u d r (V n (S * u)) (V n (S * d)) ≤
        V (n + 1) S) (n : ℕ) (S : ℝ) :
    MathFin.americanPrice u d r g n S ≤ V n S := by
  exact MathFin.americanPrice_le_of_supermartingale_dominating h g V hV_g hV_super n S

end AmericanPutConvexity
