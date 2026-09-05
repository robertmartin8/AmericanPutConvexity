import AmericanConvexity.Boundary.Profiles

/-!
# Initial profiles concentrate at zero

Exact tail integrals and the two mass limits (2.6) in CCJZ. The integrals here
are of the explicit initial profiles; no claim of convergence of PDE solutions
or exercise boundaries is made.
-/

namespace AmericanConvexity.Boundary

open Filter MeasureTheory
open scoped Topology

noncomputable def profileTail (b y : ℝ) : ℝ :=
  (y ^ 2 / 2 + (b + 1) * y + b + 1) * Real.exp (-y)

theorem profileTail_hasDerivAt (b y : ℝ) :
    HasDerivAt (profileTail b) (-profileShape b y) y := by
  convert! ((((((hasDerivAt_id y).pow 2).div_const 2).add
    ((hasDerivAt_id y).const_mul (b + 1))).add_const b).add_const 1).mul
      (hasDerivAt_id y).neg.exp using 1
  dsimp [profileShape, profileTail]
  ring

private theorem tail_decomposition (b y : ℝ) : profileTail b y =
    (1 / 2) * (y ^ 2 * Real.exp (-y)) +
    (b + 1) * (y * Real.exp (-y)) + (b + 1) * Real.exp (-y) := by
  dsimp [profileTail]
  ring

theorem profileTail_decay (b : ℝ) : Tendsto (profileTail b) atTop (nhds 0) := by
  have h₂ := (Real.tendsto_pow_mul_exp_neg_atTop_nhds_zero 2).const_mul (1 / 2)
  have h₁ := (Real.tendsto_pow_mul_exp_neg_atTop_nhds_zero 1).const_mul (b + 1)
  have h₀ := (Real.tendsto_pow_mul_exp_neg_atTop_nhds_zero 0).const_mul (b + 1)
  simpa only [pow_one, pow_zero, one_mul, mul_zero, add_zero, ← tail_decomposition] using
    (h₂.add h₁).add h₀

private theorem scaled_tail_antiderivative (b c x : ℝ) :
    HasDerivAt (fun y => -profileTail b (c * y)) (scaledProfile b c x) x := by
  convert! ((profileTail_hasDerivAt b (c * x)).comp x
    ((hasDerivAt_id x).const_mul c)).neg using 1
  dsimp [scaledProfile]
  ring

/-- Exact integral to the right of a nonnegative threshold. -/
theorem scaledProfile_tail_integral (b : ℝ) {c z : ℝ} (hc : 0 < c) (hz : 0 ≤ z) :
    (∫ x in Set.Ioi z, scaledProfile b c x) = profileTail b (c * z) := by
  have hi := (scaledProfile_integrable b hc).mono_set (Set.Ioi_subset_Ioi hz)
  have ht := ((profileTail_decay b).comp (tendsto_id.const_mul_atTop hc)).neg
  have h := integral_Ioi_of_hasDerivAt_of_tendsto'
    (fun x _ => scaled_tail_antiderivative b c x) hi ht
  simpa only [neg_zero, zero_sub, neg_neg] using h

theorem scaledProfile_mass (b : ℝ) {c : ℝ} (hc : 0 < c) :
    (∫ x in Set.Ioi 0, scaledProfile b c x) = 1 + b := by
  rw [scaledProfile_tail_integral b hc le_rfl]
  simp [profileTail, add_comm]

theorem scaledProfile_partial_mass (b c z : ℝ) :
    (∫ x in (0 : ℝ)..z, scaledProfile b c x) = 1 + b - profileTail b (c * z) := by
  have h := intervalIntegral.integral_eq_sub_of_hasDerivAt
    (fun x _ => scaled_tail_antiderivative b c x)
    ((scaledProfile_smooth b c).continuous.intervalIntegrable 0 z)
  simpa [profileTail, add_comm, sub_eq_add_neg, add_left_comm, add_assoc] using h

theorem appendixCoefficient_continuous (k : ℝ) : Continuous (appendixCoefficient k) := by
  unfold appendixCoefficient
  fun_prop

theorem appendixCoefficient_zero {k : ℝ} (hk : 0 < k) :
    appendixCoefficient k 0 = Real.sqrt k := by
  have he := appendixCoefficient_equation hk 0
  have hp := appendixCoefficient_pos hk 0
  have hs := Real.sq_sqrt hk.le
  have hn := Real.sqrt_nonneg k
  simp only [mul_zero, sub_zero, zero_pow (by decide : 3 ≠ 0), add_zero, mul_one] at he
  nlinarith

theorem appendixCoefficient_limit {k : ℝ} (hk : 0 < k) :
    Tendsto (appendixCoefficient k) (nhdsWithin 0 (Set.Ioi 0)) (nhds (Real.sqrt k)) := by
  simpa only [appendixCoefficient_zero hk] using
    ((appendixCoefficient_continuous k).continuousAt.tendsto.mono_left
      nhdsWithin_le_nhds : Tendsto (appendixCoefficient k)
        (nhdsWithin 0 (Set.Ioi 0)) (nhds (appendixCoefficient k 0)))

private theorem appendix_shape_parameter_limit {k : ℝ} (hk : 0 < k) :
    Tendsto (fun ε => appendixCoefficient k ε * ε)
      (nhdsWithin 0 (Set.Ioi 0)) (nhds 0) := by
  simpa using (appendixCoefficient_limit hk).mul
    (show Tendsto (fun ε : ℝ => ε) (nhdsWithin 0 (Set.Ioi 0)) (nhds 0) from
      nhdsWithin_le_nhds)

private theorem rescaled_threshold_limit {z : ℝ} (hz : 0 < z) :
    Tendsto (fun ε : ℝ => (1 / ε ^ 2) * z) (nhdsWithin 0 (Set.Ioi 0)) atTop := by
  have h := ((tendsto_pow_atTop (by decide : 2 ≠ 0)).comp
    (tendsto_inv_nhdsGT_zero : Tendsto (fun ε : ℝ => ε⁻¹) (nhdsWithin 0 (Set.Ioi 0)) atTop)).atTop_mul_const hz
  simpa only [one_div, inv_pow, Function.comp_apply] using h

/-- Every fixed positive threshold eventually captures all the profile mass. -/
theorem appendixProfile_tail_limit {k z : ℝ} (hk : 0 < k) (hz : 0 < z) :
    Tendsto (fun ε => profileTail (appendixCoefficient k ε * ε) ((1 / ε ^ 2) * z))
      (nhdsWithin 0 (Set.Ioi 0)) (nhds 0) := by
  have hy := rescaled_threshold_limit hz
  have hb := (appendix_shape_parameter_limit hk).add_const 1
  have h₂ := ((Real.tendsto_pow_mul_exp_neg_atTop_nhds_zero 2).comp hy).const_mul (1 / 2)
  have h₁ := hb.mul ((Real.tendsto_pow_mul_exp_neg_atTop_nhds_zero 1).comp hy)
  have h₀ := hb.mul ((Real.tendsto_pow_mul_exp_neg_atTop_nhds_zero 0).comp hy)
  simpa only [Function.comp_apply, pow_one, pow_zero, one_mul, mul_zero, add_zero,
    ← tail_decomposition] using (h₂.add h₁).add h₀

/-- Both initial-data concentration limits in equation (2.6). -/
theorem appendixProfile_concentration {k : ℝ} (hk : 0 < k) :
    Tendsto (fun ε => ∫ x in Set.Ioi 0, appendixProfile k ε x)
      (nhdsWithin 0 (Set.Ioi 0)) (nhds 1) ∧
    (∀ z : ℝ, 0 < z → Tendsto (fun ε => ∫ x in (0 : ℝ)..z, appendixProfile k ε x)
      (nhdsWithin 0 (Set.Ioi 0)) (nhds 1)) := by
  have hb := (appendix_shape_parameter_limit hk).const_add 1
  constructor
  · apply Tendsto.congr' _ (by simpa using hb)
    filter_upwards [self_mem_nhdsWithin] with ε hε
    have hεpos : 0 < ε := hε
    exact (scaledProfile_mass (appendixCoefficient k ε * ε)
      (show 0 < 1 / ε ^ 2 by positivity)).symm
  · intro z hz
    have h := hb.sub (appendixProfile_tail_limit hk hz)
    convert! h using 1
    · funext ε
      exact scaledProfile_partial_mass (appendixCoefficient k ε * ε) (1 / ε ^ 2) z
    · norm_num

end AmericanConvexity.Boundary
