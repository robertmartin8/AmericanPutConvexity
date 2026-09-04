import Mathlib.Analysis.Convex.Basic
import Mathlib.Data.Real.Basic
import Mathlib.Tactic

/-!
# Starter proofs

Small, fully checked examples for developing real analysis and convexity theorems.
Place the cursor inside a proof to see its current goal in the Lean InfoView.
-/

namespace AmericanConvexity

/-- Every closed interval in the real line is convex. -/
theorem closedInterval_convex (a b : ℝ) : Convex ℝ (Set.Icc a b) := by
  exact convex_Icc a b

/-- A convex combination of two points in a closed interval stays in that interval. -/
theorem convexCombination_mem_interval {a b x y t : ℝ}
    (hx : x ∈ Set.Icc a b) (hy : y ∈ Set.Icc a b)
    (ht₀ : 0 ≤ t) (ht₁ : t ≤ 1) :
    (1 - t) * x + t * y ∈ Set.Icc a b := by
  simpa only [smul_eq_mul] using
    (closedInterval_convex a b) hx hy (sub_nonneg.mpr ht₁) ht₀ (sub_add_cancel 1 t)

/-- A basic quadratic inequality, proved using nonlinear arithmetic. -/
theorem two_mul_le_sum_squares (x y : ℝ) : 2 * x * y ≤ x ^ 2 + y ^ 2 := by
  nlinarith [sq_nonneg (x - y)]

-- Smoke tests for commonly useful proof automation.
example (x y : ℝ) : (x + y) ^ 2 = x ^ 2 + 2 * x * y + y ^ 2 := by
  ring

example : (1 / 2 : ℝ) + 1 / 3 = 5 / 6 := by
  norm_num

example (P Q : Prop) (h : P ∧ Q) : Q ∧ P := by
  aesop

example (m n : ℕ) (h : m + 1 ≤ n) : m < n := by
  omega

end AmericanConvexity
