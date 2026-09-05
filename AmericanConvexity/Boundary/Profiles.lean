import AmericanConvexity.Boundary.Stefan

/-!
# Explicit compatible smooth profiles

The polynomial-times-exponential profiles in CCJZ's appendix (Lemma 3.4).
The coefficient is constructed explicitly, rather than assumed to exist.
This file verifies the initial-data conditions (2.3) and positive initial slope.
It does not claim the Dirac limit (2.6), sign geometry (3.1)--(3.2), or quotient
estimate (3.8), which are separate approximation obligations.
-/

namespace AmericanConvexity.Boundary

open Filter MeasureTheory
open scoped Topology ContDiff

/-- The unscaled appendix profile, with `b = a ε`. -/
noncomputable def profileShape (b y : ℝ) : ℝ :=
  (b * y + y ^ 2 / 2) * Real.exp (-y)

private theorem shape_derivative (b y : ℝ) :
    HasDerivAt (profileShape b) ((b + (1 - b) * y - y ^ 2 / 2) * Real.exp (-y)) y := by
  convert! (((hasDerivAt_id y).const_mul b).add
    (((hasDerivAt_id y).pow 2).div_const 2)).mul (hasDerivAt_id y).neg.exp using 1
  simp only [id_eq, Pi.pow_apply, Pi.neg_apply, Pi.add_apply]
  ring

private theorem shape_second_derivative (b y : ℝ) :
    HasDerivAt (fun z => (b + (1 - b) * z - z ^ 2 / 2) * Real.exp (-z))
      ((1 - 2 * b - (2 - b) * y + y ^ 2 / 2) * Real.exp (-y)) y := by
  convert! ((((hasDerivAt_id y).const_mul (1 - b)).const_add b).sub
    (((hasDerivAt_id y).pow 2).div_const 2)).mul (hasDerivAt_id y).neg.exp using 1
  simp only [id_eq, Pi.pow_apply, Pi.neg_apply, Pi.sub_apply]
  ring

/-- Scaling by `c = ε⁻²` preserves the mass of the shape. -/
noncomputable def scaledProfile (b c x : ℝ) : ℝ := c * profileShape b (c * x)

theorem scaledProfile_smooth (b c : ℝ) : ContDiff ℝ ∞ (scaledProfile b c) := by
  unfold scaledProfile profileShape
  fun_prop

private theorem scaled_derivative (b c x : ℝ) :
    HasDerivAt (scaledProfile b c)
      (c ^ 2 * ((b + (1 - b) * (c * x) - (c * x) ^ 2 / 2) * Real.exp (-(c * x)))) x := by
  convert! ((shape_derivative b (c * x)).comp x ((hasDerivAt_id x).const_mul c)).const_mul c using 1
  ring

private theorem deriv_scaled (b c : ℝ) : deriv (scaledProfile b c) =
    fun x => c ^ 2 * ((b + (1 - b) * (c * x) - (c * x) ^ 2 / 2) * Real.exp (-(c * x))) := by
  funext x
  exact (scaled_derivative b c x).deriv

theorem scaledProfile_at_zero (b c : ℝ) : scaledProfile b c 0 = 0 := by
  simp [scaledProfile, profileShape]

theorem scaledProfile_slope (b c : ℝ) : deriv (scaledProfile b c) 0 = c ^ 2 * b := by
  simp [deriv_scaled]

theorem scaledProfile_second (b c : ℝ) :
    deriv (deriv (scaledProfile b c)) 0 = c ^ 3 * (1 - 2 * b) := by
  rw [deriv_scaled]
  convert! (((shape_second_derivative b (c * 0)).comp 0
    ((hasDerivAt_id (0 : ℝ)).const_mul c)).const_mul (c ^ 2)).deriv using 1
  simp
  ring

theorem scaledProfile_positive {b c x : ℝ} (hb : 0 < b) (hc : 0 < c) (hx : 0 < x) :
    0 < scaledProfile b c x := by
  unfold scaledProfile profileShape
  positivity

private theorem shape_integrable (b : ℝ) : IntegrableOn (profileShape b) (Set.Ioi 0) := by
  have h₁ := Real.GammaIntegral_convergent (s := 2) (by norm_num)
  have h₂ := Real.GammaIntegral_convergent (s := 3) (by norm_num)
  norm_num only [show (2 : ℝ) - 1 = 1 by norm_num, Real.rpow_one] at h₁
  norm_num only [show (3 : ℝ) - 1 = 2 by norm_num, Real.rpow_ofNat] at h₂
  apply ((h₁.const_mul b).add (h₂.const_mul (1 / 2))).congr
  exact Filter.Eventually.of_forall fun x => by dsimp [profileShape]; ring

theorem scaledProfile_integrable (b : ℝ) {c : ℝ} (hc : 0 < c) :
    IntegrableOn (scaledProfile b c) (Set.Ioi 0) := by
  have h := (integrableOn_Ioi_comp_mul_left_iff (profileShape b) 0 hc).mpr
    (by simpa using shape_integrable b)
  exact h.const_mul c

private theorem shape_decay (b : ℝ) : Tendsto (profileShape b) atTop (nhds 0) := by
  have h₁ := (Real.tendsto_pow_mul_exp_neg_atTop_nhds_zero 1).const_mul b
  have h₂ := (Real.tendsto_pow_mul_exp_neg_atTop_nhds_zero 2).const_mul (1 / 2)
  convert! h₁.add h₂ using 1
  · funext x
    dsimp [profileShape]
    ring
  · simp

theorem scaledProfile_decay (b : ℝ) {c : ℝ} (hc : 0 < c) :
    Tendsto (scaledProfile b c) atTop (nhds 0) := by
  change Tendsto (fun x => c * profileShape b (c * x)) atTop (nhds 0)
  simpa only [mul_zero, Function.comp_apply, id_eq] using
    ((shape_decay b).comp (tendsto_id.const_mul_atTop hc)).const_mul c

/-- Exactly the algebraic condition needed for the corner compatibility. -/
theorem scaledProfile_initialData {k b c : ℝ} (hb : 0 < b) (hc : 0 < c)
    (hcompat : c ^ 2 * b ^ 2 = k * (c * (1 - 2 * b) + (k - 1) * b)) :
    StefanInitialData k (scaledProfile b c) := by
  have hf := scaledProfile_smooth b c
  have hd : Differentiable ℝ (scaledProfile b c) := hf.differentiable (by simp)
  have hdd : Differentiable ℝ (deriv (scaledProfile b c)) := by
    rw [deriv_scaled]
    fun_prop
  refine ⟨hf.of_le (by decide) |>.contDiffOn, scaledProfile_integrable b hc,
    fun x hx => scaledProfile_positive hb hc hx, scaledProfile_at_zero b c,
    scaledProfile_decay b hc, ?_⟩
  rw [initialRightDeriv_eq_deriv hd le_rfl, initialRightDeriv_twice_eq hd hdd,
    scaledProfile_slope, scaledProfile_second, scaledProfile_at_zero]
  linear_combination c ^ 2 * hcompat

/-- The positive root of the appendix coefficient equation. -/
noncomputable def appendixCoefficient (k ε : ℝ) : ℝ :=
  let d := k * (2 * ε - (k - 1) * ε ^ 3)
  (Real.sqrt (d ^ 2 + 4 * k) - d) / 2

theorem appendixCoefficient_pos {k : ℝ} (hk : 0 < k) (ε : ℝ) :
    0 < appendixCoefficient k ε := by
  unfold appendixCoefficient
  dsimp
  have hsq := Real.sq_sqrt (show 0 ≤ (k * (2 * ε - (k - 1) * ε ^ 3)) ^ 2 + 4 * k by positivity)
  have hnonneg := Real.sqrt_nonneg ((k * (2 * ε - (k - 1) * ε ^ 3)) ^ 2 + 4 * k)
  nlinarith

theorem appendixCoefficient_equation {k : ℝ} (hk : 0 < k) (ε : ℝ) :
    (appendixCoefficient k ε) ^ 2 =
      k * (1 - 2 * appendixCoefficient k ε * ε + (k - 1) * appendixCoefficient k ε * ε ^ 3) := by
  unfold appendixCoefficient
  dsimp
  have hsq := Real.sq_sqrt (show 0 ≤ (k * (2 * ε - (k - 1) * ε ^ 3)) ^ 2 + 4 * k by positivity)
  nlinarith

/-- The actual smooth approximation profile from the appendix. -/
noncomputable def appendixProfile (k ε : ℝ) : ℝ → ℝ :=
  scaledProfile (appendixCoefficient k ε * ε) (1 / ε ^ 2)

theorem appendixProfile_initialData {k ε : ℝ} (hk : 0 < k) (hε : 0 < ε) :
    StefanInitialData k (appendixProfile k ε) := by
  apply scaledProfile_initialData (mul_pos (appendixCoefficient_pos hk ε) hε) (by positivity)
  have h := appendixCoefficient_equation hk ε
  field_simp
  nlinarith [h]

theorem appendixProfile_slope_pos {k ε : ℝ} (hk : 0 < k) (hε : 0 < ε) :
    0 < deriv (appendixProfile k ε) 0 := by
  change 0 < deriv (scaledProfile (appendixCoefficient k ε * ε) (1 / ε ^ 2)) 0
  rw [scaledProfile_slope]
  exact mul_pos (sq_pos_of_pos (by positivity)) (mul_pos (appendixCoefficient_pos hk ε) hε)

end AmericanConvexity.Boundary
