import Mathlib

/-! A quadratic changing from positive to negative on an interval has exactly
one zero there, crosses downwards, and has the corresponding strict signs. -/

namespace AmericanPutConvexity.Boundary

theorem quadratic_downward_crossing {a b c M : ℝ} (hM : 0 < M) (hc : 0 < c)
    (hend : a * M ^ 2 + b * M + c < 0) :
    ∃ z : ℝ, 0 < z ∧ z < M ∧ a * z ^ 2 + b * z + c = 0 ∧
      2 * a * z + b < 0 ∧
      (∀ x, 0 ≤ x → x < z → 0 < a * x ^ 2 + b * x + c) ∧
      (∀ x, z < x → x ≤ M → a * x ^ 2 + b * x + c < 0) := by
  have hcont : Continuous (fun x : ℝ => a * x ^ 2 + b * x + c) := by fun_prop
  obtain ⟨z, hz, hzero⟩ := intermediate_value_Icc' hM.le hcont.continuousOn
    (show (0 : ℝ) ∈ Set.Icc (a * M ^ 2 + b * M + c)
      (a * 0 ^ 2 + b * 0 + c) by constructor <;> nlinarith)
  have hzpos : 0 < z := by
    by_contra hn
    have : z = 0 := by linarith [hz.1]
    subst z
    norm_num at hzero
    linarith
  have hzM : z < M := by
    by_contra hn
    have : z = M := by linarith [hz.2]
    subst z
    linarith
  have hfactor (x : ℝ) :
      (a * x ^ 2 + b * x + c) * z = (z - x) * (c - a * z * x) := by
    linear_combination x * hzero
  have hrM : 0 < c - a * z * M := by
    have hn := mul_neg_of_neg_of_pos hend hzpos
    rw [hfactor] at hn
    nlinarith
  have hr (x : ℝ) (hx : 0 ≤ x) (hxM : x ≤ M) : 0 < c - a * z * x := by
    by_cases ha : 0 ≤ a * z
    · nlinarith [mul_nonneg ha (sub_nonneg.mpr hxM)]
    · nlinarith [mul_nonpos_of_nonpos_of_nonneg (le_of_not_ge ha) hx]
  refine ⟨z, hzpos, hzM, hzero, ?_, ?_, ?_⟩
  · have hrz := hr z hzpos.le hzM.le
    nlinarith
  · intro x hx hxz
    have hp := mul_pos (sub_pos.mpr hxz) (hr x hx (hxz.le.trans hzM.le))
    rw [← hfactor] at hp
    nlinarith
  · intro x hzx hxM
    have hn := mul_neg_of_neg_of_pos (sub_neg.mpr hzx) (hr x (hzpos.le.trans hzx.le) hxM)
    rw [← hfactor] at hn
    nlinarith

end AmericanPutConvexity.Boundary
