import AmericanPutConvexity.Boundary.ProfileGeometry
import AmericanPutConvexity.Boundary.QuadraticCrossing

/-! The single downward zero of `L q₀` required in CCJZ (3.2). -/

namespace AmericanPutConvexity.Boundary

open scoped ContDiff

noncomputable def operatorQuadraticA (k c : ℝ) : ℝ := (c ^ 2 - (k - 1) * c - k) / 2
noncomputable def operatorQuadraticB (k b c : ℝ) : ℝ :=
  -(2 - b) * c ^ 2 + (k - 1) * c * (1 - b) - k * b
noncomputable def operatorQuadraticC (k b c : ℝ) : ℝ :=
  (1 - 2 * b) * c ^ 2 + (k - 1) * c * b

theorem operator_as_quadratic (k b c : ℝ) : spatialOperator k (scaledProfile b c) =
    fun x => c * (operatorQuadraticA k c * (c * x) ^ 2 +
      operatorQuadraticB k b c * (c * x) + operatorQuadraticC k b c) * Real.exp (-(c * x)) := by
  funext x
  rw [spatialOperator, deriv2_scaled, deriv_scaled]
  dsimp [operatorQuadraticA, operatorQuadraticB, operatorQuadraticC,
    curvaturePolynomial, scaledProfile, profileShape]
  ring

private theorem quadratic_exp_derivative (a b d c x : ℝ) :
    HasDerivAt (fun x => c * (a * (c * x) ^ 2 + b * (c * x) + d) * Real.exp (-(c * x)))
      (c ^ 2 * ((2 * a * (c * x) + b) - (a * (c * x) ^ 2 + b * (c * x) + d)) *
        Real.exp (-(c * x))) x := by
  have hy := (hasDerivAt_id x).const_mul c
  convert! (((((hy.pow 2).const_mul a).add (hy.const_mul b)).add_const d).const_mul c).mul
    hy.neg.exp using 1
  dsimp
  ring

theorem scaledProfile_operator_geometry {k b c : ℝ} (hk : 0 ≤ k) (hb : 0 < b)
    (hc : 0 < c) (hzero : 0 < spatialOperator k (scaledProfile b c) 0) :
    ∃ x₂ : ℝ, 0 < x₂ ∧ x₂ < profilePeak b / c ∧
      spatialOperator k (scaledProfile b c) x₂ = 0 ∧
      deriv (spatialOperator k (scaledProfile b c)) x₂ < 0 ∧
      (∀ x, 0 ≤ x → x < x₂ → 0 < spatialOperator k (scaledProfile b c) x) ∧
      (∀ x, x₂ < x → x ≤ profilePeak b / c → spatialOperator k (scaledProfile b c) x < 0) := by
  let a := operatorQuadraticA k c
  let d := operatorQuadraticB k b c
  let e := operatorQuadraticC k b c
  have hp := profilePeak_pos hb
  have hpeak := scaledProfile_peak_geometry hb hc
  have hpq := scaledProfile_positive hb hc (div_pos hp hc)
  have hLpeak : spatialOperator k (scaledProfile b c) (profilePeak b / c) < 0 := by
    unfold spatialOperator
    rw [hpeak.2.1]
    have := hpeak.2.2.2.2
    have hkp := mul_nonneg hk hpq.le
    nlinarith
  have hcancel : c * (profilePeak b / c) = profilePeak b := by field_simp
  have hepos : 0 < e := by
    rw [operator_as_quadratic] at hzero
    simp only [mul_zero, zero_pow (by decide : 2 ≠ 0), zero_add, add_zero,
      neg_zero, Real.exp_zero, mul_one] at hzero
    exact (mul_pos_iff_of_pos_left hc).mp hzero
  have hend : a * (profilePeak b) ^ 2 + d * profilePeak b + e < 0 := by
    rw [operator_as_quadratic] at hLpeak
    dsimp only at hLpeak
    rw [hcancel] at hLpeak
    by_contra hn
    have hn' : 0 ≤ a * (profilePeak b) ^ 2 + d * profilePeak b + e := le_of_not_gt hn
    have hnonneg := mul_nonneg (mul_nonneg hc.le hn') (Real.exp_pos (-profilePeak b)).le
    exact (not_le_of_gt hLpeak) hnonneg
  obtain ⟨z, hz, hzM, hroot, hder, hleft, hright⟩ := quadratic_downward_crossing hp hepos hend
  have hcz : c * (z / c) = z := by field_simp
  refine ⟨z / c, div_pos hz hc, (div_lt_div_iff_of_pos_right hc).mpr hzM, ?_, ?_, ?_, ?_⟩
  · rw [operator_as_quadratic]
    change c * (a * (c * (z / c)) ^ 2 + d * (c * (z / c)) + e) *
      Real.exp (-(c * (z / c))) = 0
    rw [hcz, hroot]
    ring
  · rw [operator_as_quadratic]
    change deriv (fun x => c * (a * (c * x) ^ 2 + d * (c * x) + e) *
      Real.exp (-(c * x))) (z / c) < 0
    rw [(quadratic_exp_derivative a d e c (z / c)).deriv, hcz, hroot, sub_zero]
    exact mul_neg_of_neg_of_pos (mul_neg_of_pos_of_neg (sq_pos_of_pos hc) hder) (Real.exp_pos _)
  · intro x hx hxz
    rw [operator_as_quadratic]
    apply mul_pos _ (Real.exp_pos _)
    apply mul_pos hc
    exact hleft (c * x) (mul_nonneg hc.le hx) (by nlinarith [(lt_div_iff₀ hc).mp hxz])
  · intro x hzx hxM
    rw [operator_as_quadratic]
    apply mul_neg_of_neg_of_pos _ (Real.exp_pos _)
    apply mul_neg_of_pos_of_neg hc
    exact hright (c * x) (by nlinarith [(div_lt_iff₀ hc).mp hzx])
      (by nlinarith [(le_div_iff₀ hc).mp hxM])

/-- The compatibility equation forces a positive initial operator value. -/
theorem appendixProfile_operator_zero_pos {k ε : ℝ} (hk : 0 < k) (hε : 0 < ε) :
    0 < spatialOperator k (appendixProfile k ε) 0 := by
  have hi := appendixProfile_initialData hk hε
  have hs : ContDiff ℝ ∞ (appendixProfile k ε) := scaledProfile_smooth _ _
  have hd := hs.differentiable (by simp)
  have hdd := (hs.of_le (show (2 : ℕ∞ω) ≤ ∞ by decide)).differentiable_deriv_two
  have hcompat := hi.compatibility
  rw [initialRightDeriv_eq_deriv hd le_rfl, initialRightDeriv_twice_eq hd hdd] at hcompat
  change (deriv (appendixProfile k ε) 0) ^ 2 =
    k * spatialOperator k (appendixProfile k ε) 0 at hcompat
  have hp := sq_pos_of_pos (appendixProfile_slope_pos hk hε)
  rw [hcompat] at hp
  exact (mul_pos_iff_of_pos_left hk).mp hp

/-- All sign conditions (3.1), (3.2) and (3.8) for the appendix family.
The concentration limits (2.6) are in `ProfileConcentration.lean`. -/
theorem appendixProfile_sign_conditions {k ε : ℝ} (hk : 0 < k) (hε : 0 < ε) :
    ∃ x₁ x₂ : ℝ, 0 < x₂ ∧ x₂ < x₁ ∧
      deriv (appendixProfile k ε) x₁ = 0 ∧
      deriv (deriv (appendixProfile k ε)) x₁ < 0 ∧
      (∀ x, 0 ≤ x → x < x₁ → 0 < deriv (appendixProfile k ε) x) ∧
      (∀ x, x₁ < x → deriv (appendixProfile k ε) x < 0) ∧
      spatialOperator k (appendixProfile k ε) x₂ = 0 ∧
      deriv (spatialOperator k (appendixProfile k ε)) x₂ < 0 ∧
      (∀ x, 0 ≤ x → x < x₂ → 0 < spatialOperator k (appendixProfile k ε) x) ∧
      (∀ x, x₂ < x → x ≤ x₁ → spatialOperator k (appendixProfile k ε) x < 0) ∧
      (∀ x, 0 ≤ x → x ≤ x₂ → deriv (fun y =>
        spatialOperator k (appendixProfile k ε) y / deriv (appendixProfile k ε) y) x < 0) := by
  let b := appendixCoefficient k ε * ε
  let c := 1 / ε ^ 2
  have hb : 0 < b := mul_pos (appendixCoefficient_pos hk ε) hε
  have hc : 0 < c := by dsimp [c]; positivity
  have hg := scaledProfile_peak_geometry hb hc
  obtain ⟨x₂, hx₂, h₂₁, hL, hdL, hleft, hright⟩ :=
    scaledProfile_operator_geometry hk.le hb hc (appendixProfile_operator_zero_pos hk hε)
  refine ⟨profilePeak b / c, x₂, hx₂, h₂₁, hg.2.1, hg.2.2.2.2,
    hg.2.2.1, hg.2.2.2.1, hL, hdL, hleft, hright, ?_⟩
  intro x hx hxx₂
  exact operator_quotient_deriv_neg hk.le hb hc hx
    (by nlinarith [(lt_div_iff₀ hc).mp (hxx₂.trans_lt h₂₁)])

end AmericanPutConvexity.Boundary
