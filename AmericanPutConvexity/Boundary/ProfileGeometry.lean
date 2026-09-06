import AmericanPutConvexity.Boundary.Profiles

/-!
# Exact initial-profile sign geometry

The derivative of `(L q₀)/q₀'` admits an exact negative expression. This replaces
the asymptotic sign calculation in the appendix of CCJZ. These are initial-data
lemmas, not assertions about the subsequent Stefan evolution.
-/

namespace AmericanPutConvexity.Boundary

noncomputable def slopePolynomial (b y : ℝ) : ℝ := b + (1 - b) * y - y ^ 2 / 2
noncomputable def curvaturePolynomial (b y : ℝ) : ℝ :=
  1 - 2 * b - (2 - b) * y + y ^ 2 / 2

theorem deriv2_scaled (b c : ℝ) : deriv (deriv (scaledProfile b c)) =
    fun x => c ^ 3 * (curvaturePolynomial b (c * x) * Real.exp (-(c * x))) := by
  rw [deriv_scaled]
  funext x
  convert! (((shape_second_derivative b (c * x)).comp x
    ((hasDerivAt_id x).const_mul c)).const_mul (c ^ 2)).deriv using 1
  dsimp [curvaturePolynomial]
  ring

/-- The positive zero of the profile's derivative in the rescaled variable. -/
noncomputable def profilePeak (b : ℝ) : ℝ := 1 - b + Real.sqrt (1 + b ^ 2)

theorem profilePeak_pos {b : ℝ} (hb : 0 < b) : 0 < profilePeak b := by
  have hs := Real.sq_sqrt (show 0 ≤ 1 + b ^ 2 by positivity)
  have hn := Real.sqrt_nonneg (1 + b ^ 2)
  dsimp [profilePeak]
  nlinarith

theorem slopePolynomial_factor (b y : ℝ) :
    slopePolynomial b y =
      (profilePeak b - y) * (y - (1 - b - Real.sqrt (1 + b ^ 2))) / 2 := by
  have hs := Real.sq_sqrt (show 0 ≤ 1 + b ^ 2 by positivity)
  dsimp [slopePolynomial, profilePeak]
  nlinarith

theorem slopePolynomial_pos {b y : ℝ} (hb : 0 < b) (hy : 0 ≤ y)
    (hpeak : y < profilePeak b) : 0 < slopePolynomial b y := by
  have hs := Real.sq_sqrt (show 0 ≤ 1 + b ^ 2 by positivity)
  have hn := Real.sqrt_nonneg (1 + b ^ 2)
  have hneg : 1 - b - Real.sqrt (1 + b ^ 2) < 0 := by nlinarith
  rw [slopePolynomial_factor]
  exact div_pos (mul_pos (sub_pos.mpr hpeak) (by linarith)) (by norm_num)

theorem slopePolynomial_neg {b y : ℝ} (hb : 0 < b)
    (hpeak : profilePeak b < y) : slopePolynomial b y < 0 := by
  have hy := (profilePeak_pos hb).trans hpeak
  have hs := Real.sq_sqrt (show 0 ≤ 1 + b ^ 2 by positivity)
  have hn := Real.sqrt_nonneg (1 + b ^ 2)
  have hneg : 1 - b - Real.sqrt (1 + b ^ 2) < 0 := by nlinarith
  rw [slopePolynomial_factor]
  exact div_neg_of_neg_of_pos (mul_neg_of_neg_of_pos (by linarith) (by linarith))
    (by norm_num)

theorem slopePolynomial_peak (b : ℝ) : slopePolynomial b (profilePeak b) = 0 := by
  rw [slopePolynomial_factor]
  simp

theorem curvaturePolynomial_peak_neg {b : ℝ} (hb : 0 < b) :
    curvaturePolynomial b (profilePeak b) < 0 := by
  have hz := slopePolynomial_peak b
  have hsq : 0 < Real.sqrt (1 + b ^ 2) := Real.sqrt_pos.mpr (by positivity)
  dsimp [curvaturePolynomial, slopePolynomial, profilePeak] at *
  nlinarith

/-- The unique positive peak, with the signs and strict curvature in (3.1). -/
theorem scaledProfile_peak_geometry {b c : ℝ} (hb : 0 < b) (hc : 0 < c) :
    let x₁ := profilePeak b / c
    0 < x₁ ∧ deriv (scaledProfile b c) x₁ = 0 ∧
    (∀ x, 0 ≤ x → x < x₁ → 0 < deriv (scaledProfile b c) x) ∧
    (∀ x, x₁ < x → deriv (scaledProfile b c) x < 0) ∧
    deriv (deriv (scaledProfile b c)) x₁ < 0 := by
  have hcancel : c * (profilePeak b / c) = profilePeak b := by field_simp
  refine ⟨div_pos (profilePeak_pos hb) hc, ?_, ?_, ?_, ?_⟩
  · rw [deriv_scaled]
    change c ^ 2 * (slopePolynomial b (c * (profilePeak b / c)) *
      Real.exp (-(c * (profilePeak b / c)))) = 0
    rw [hcancel, slopePolynomial_peak]
    ring
  · intro x hx hxp
    rw [deriv_scaled]
    change 0 < c ^ 2 * (slopePolynomial b (c * x) * Real.exp (-(c * x)))
    apply mul_pos (sq_pos_of_pos hc)
    apply mul_pos _ (Real.exp_pos _)
    exact slopePolynomial_pos hb (mul_nonneg hc.le hx)
      (by nlinarith [(lt_div_iff₀ hc).mp hxp])
  · intro x hxp
    rw [deriv_scaled]
    change c ^ 2 * (slopePolynomial b (c * x) * Real.exp (-(c * x))) < 0
    apply mul_neg_of_pos_of_neg (sq_pos_of_pos hc)
    apply mul_neg_of_neg_of_pos _ (Real.exp_pos _)
    exact slopePolynomial_neg hb (by nlinarith [(div_lt_iff₀ hc).mp hxp])
  · rw [deriv2_scaled]
    dsimp only
    rw [hcancel]
    exact mul_neg_of_pos_of_neg (pow_pos hc 3)
      (mul_neg_of_neg_of_pos (curvaturePolynomial_peak_neg hb) (Real.exp_pos _))

/-- The quotient after cancellation of the nonzero exponential and scaling. -/
noncomputable def initialQuotient (k b c x : ℝ) : ℝ :=
  c * curvaturePolynomial b (c * x) / slopePolynomial b (c * x) + (k - 1) -
    (k / c) * (b * (c * x) + (c * x) ^ 2 / 2) / slopePolynomial b (c * x)

theorem operator_div_slope {k b c x : ℝ} (hc : c ≠ 0)
    (hA : slopePolynomial b (c * x) ≠ 0) :
    spatialOperator k (scaledProfile b c) x / deriv (scaledProfile b c) x =
      initialQuotient k b c x := by
  rw [spatialOperator, deriv2_scaled, deriv_scaled]
  dsimp only [initialQuotient, scaledProfile, profileShape, slopePolynomial] at *
  generalize b + (1 - b) * (c * x) - (c * x) ^ 2 / 2 = A at *
  field_simp [hc, Real.exp_ne_zero, hA]

/-- An exact derivative identity; the drift term cancels. -/
theorem initialQuotient_hasDerivAt {k b c x : ℝ} (hc : c ≠ 0)
    (hA : slopePolynomial b (c * x) ≠ 0) :
    HasDerivAt (initialQuotient k b c)
      ((-c ^ 2 * (slopePolynomial b (c * x) + (1 - b - c * x) ^ 2) -
        k * (b ^ 2 + b * (c * x) + (c * x) ^ 2 / 2)) /
        (slopePolynomial b (c * x)) ^ 2) x := by
  have hy := (hasDerivAt_id x).const_mul c
  have hA' : HasDerivAt (fun x => slopePolynomial b (c * x))
      (c * (1 - b - c * x)) x := by
    convert! (((hy.const_mul (1 - b)).const_add b).sub ((hy.pow 2).div_const 2)) using 1
    dsimp [slopePolynomial]
    ring
  have hB' : HasDerivAt (fun x => curvaturePolynomial b (c * x))
      (c * (-(2 - b) + c * x)) x := by
    convert! ((hy.const_mul (-(2 - b))).const_add (1 - 2 * b)).add
      ((hy.pow 2).div_const 2) using 1 <;>
      dsimp [curvaturePolynomial] <;> (try funext y) <;>
      (try simp only [Pi.add_apply]) <;> ring
  have hH' : HasDerivAt (fun x => b * (c * x) + (c * x) ^ 2 / 2)
      (c * (b + c * x)) x := by
    convert! (hy.const_mul b).add ((hy.pow 2).div_const 2) using 1
    simp only [id_eq]
    ring
  convert! ((((hB'.const_mul c).div hA' hA).add_const (k - 1)).sub
    ((hH'.const_mul (k / c)).div hA' hA)) using 1
  dsimp [slopePolynomial, curvaturePolynomial] at *
  field_simp
  ring

/-- Strict negativity on the entire increasing part of every positive profile.
No asymptotic `O(epsilon)` bound or sufficiently-small parameter is needed. -/
theorem initialQuotient_deriv_neg {k b c x : ℝ} (hk : 0 ≤ k) (hb : 0 < b)
    (hc : 0 < c) (hx : 0 ≤ x) (hp : c * x < profilePeak b) :
    deriv (initialQuotient k b c) x < 0 := by
  have hA := slopePolynomial_pos hb (mul_nonneg hc.le hx) hp
  rw [(initialQuotient_hasDerivAt hc.ne' hA.ne').deriv]
  apply div_neg_of_neg_of_pos _ (sq_pos_of_pos hA)
  have hp₁ : 0 < c ^ 2 * (slopePolynomial b (c * x) + (1 - b - c * x) ^ 2) :=
    mul_pos (sq_pos_of_pos hc) (add_pos_of_pos_of_nonneg hA (sq_nonneg _))
  have hp₂ : 0 ≤ k * (b ^ 2 + b * (c * x) + (c * x) ^ 2 / 2) := by positivity
  nlinarith

/-- The strict sign is for the actual differential-operator quotient. -/
theorem operator_quotient_deriv_neg {k b c x : ℝ} (hk : 0 ≤ k) (hb : 0 < b)
    (hc : 0 < c) (hx : 0 ≤ x) (hp : c * x < profilePeak b) :
    deriv (fun y => spatialOperator k (scaledProfile b c) y /
      deriv (scaledProfile b c) y) x < 0 := by
  have hA := slopePolynomial_pos hb (mul_nonneg hc.le hx) hp
  have hcont : Continuous (fun y => slopePolynomial b (c * y)) := by
    unfold slopePolynomial
    fun_prop
  have hne := hcont.continuousAt.eventually (eventually_ne_nhds hA.ne')
  have heq : (fun y => spatialOperator k (scaledProfile b c) y /
      deriv (scaledProfile b c) y) =ᶠ[nhds x] initialQuotient k b c :=
    hne.mono fun y hy => operator_div_slope hc.ne' hy
  rw [heq.deriv_eq]
  exact initialQuotient_deriv_neg hk hb hc hx hp

end AmericanPutConvexity.Boundary
