import AmericanConvexity.Stopping.ActualDilationComparison

/-! # Positive-time derivative bounds from actual-price dilation

Differentiating the proved dilation inequality at scale one controls the
time derivative in continuation. The constants are uniform on every compact
positive-time interval; no boundary derivative is used.
-/

namespace AmericanConvexity.Stopping

open Set Filter Boundary
open scoped Topology ContDiff

theorem parabolicDilation_hasDeriv_scale_one {u : ℝ → ℝ → ℝ} {x t : ℝ}
    (hu : DifferentiableAt ℝ (fun z : ℝ × ℝ => u z.1 z.2) (x,t)) :
    HasDerivAt (fun ρ : ℝ => u (ρ*x) (ρ^2*t)-u x t)
      (x*deriv (fun y => u y t) x+2*t*deriv (u x) t) 1 := by
  let A := fderiv ℝ (fun z : ℝ × ℝ => u z.1 z.2) (x,t)
  have hA : HasFDerivAt (fun z : ℝ × ℝ => u z.1 z.2) A (x,t) := hu.hasFDerivAt
  have hx : HasDerivAt (fun y => u y t) (A (1,0)) x := by
    simpa only [Function.comp_def,id_eq] using
      hA.comp_hasDerivAt x ((hasDerivAt_id x).prodMk (hasDerivAt_const x t))
  have ht : HasDerivAt (u x) (A (0,1)) t := by
    simpa only [Function.comp_def,id_eq] using
      hA.comp_hasDerivAt t ((hasDerivAt_const t x).prodMk (hasDerivAt_id t))
  have hpath : HasDerivAt (fun ρ : ℝ => (ρ*x,ρ^2*t)) (x,2*t) 1 := by
    convert! ((hasDerivAt_id (1 : ℝ)).mul_const x).prodMk
      (((hasDerivAt_id (1 : ℝ)).pow 2).mul_const t) using 1
    simp
  have hAc : HasFDerivAt (fun z : ℝ × ℝ => u z.1 z.2) A ((1 : ℝ)*x,1^2*t) := by
    simpa only [one_mul,one_pow] using hA
  have hc := (hAc.comp_hasDerivAt 1 hpath).sub_const (u x t)
  rw [hx.deriv,ht.deriv]
  convert! hc using 1
  rw [show ((x,2*t) : ℝ × ℝ) = x • (1,0)+(2*t) • (0,1) by ext <;> simp]
  simp only [map_add,map_smul,smul_eq_mul]

theorem canonicalIntrinsicPremium_dilation_differential_bound {k h x t : ℝ}
    (hk : 0 < k) (hh : 0 ≤ h) (hhk : h ≤ k)
    (hz : (x,t) ∈ canonicalContinuationRegion k h) :
    x*deriv (fun y => canonicalIntrinsicPremium k h y t) x +
      2*t*deriv (canonicalIntrinsicPremium k h x) t ≤
        (2*|k-h-1|+4*h+1)*Real.exp ((10+3*|k-h-1|)*t)*dilationWeight x := by
  have ht : 0 < t := hz.1
  have hd := parabolicDilation_hasDeriv_scale_one
    ((canonicalIntrinsicPremium_joint_contDiffAt hk.le hz).differentiableAt (by norm_num))
  apply le_of_tendsto (hd.tendsto_slope.mono_left (nhdsGT_le_nhdsNE (1 : ℝ)))
  filter_upwards [nhdsWithin_le_nhds (Iio_mem_nhds (show (1 : ℝ) < 2 by norm_num)),
    self_mem_nhdsWithin] with ρ hρ2 (hρ : 1 < ρ)
  have he := canonicalPremiumDilation_le_barrier hk hh hhk hρ.le hρ2.le ht.le x
  have hδ : 0 < ρ-1 := sub_pos.mpr hρ
  have hs : (canonicalIntrinsicPremium k h (ρ*x) (ρ^2*t)-canonicalIntrinsicPremium k h x t)/(ρ-1) ≤
      (2*|k-h-1|+4*h+1)*Real.exp ((10+3*|k-h-1|)*t)*dilationWeight x := by
    apply (div_le_iff₀ hδ).mpr
    convert! he using 1
    unfold dilationBarrier dilationErrorCoefficient
    ring
  simpa only [slope,vsub_eq_sub,smul_eq_mul,one_mul,one_pow,sub_self,sub_zero,div_eq_inv_mul] using hs

noncomputable def actualTemporalDerivativeBound (k h x a T : ℝ) : ℝ :=
  ((2*|k-h-1|+4*h+1)*Real.exp ((10+3*|k-h-1|)*T)*dilationWeight x+
    |x| * Real.exp x)/(2*a)

theorem actualTemporalDerivativeBound_nonneg {k h x a T : ℝ} (hh : 0 ≤ h) (ha : 0 < a) :
    0 ≤ actualTemporalDerivativeBound k h x a T := by
  unfold actualTemporalDerivativeBound
  exact div_nonneg (add_nonneg (mul_nonneg (mul_nonneg (by positivity) (Real.exp_pos _).le)
    (dilationWeight_pos x).le) (mul_nonneg (abs_nonneg _) (Real.exp_pos _).le)) (by positivity)

theorem canonicalPrice_time_deriv_le_dilationBound {k h x t a T : ℝ}
    (hk : 0 < k) (hh : 0 ≤ h) (hhk : h ≤ k) (ha : 0 < a) (hat : a ≤ t) (htT : t ≤ T)
    (hz : (x,t) ∈ canonicalContinuationRegion k h) :
    deriv (canonicalPrice k h x) t ≤ actualTemporalDerivativeBound k h x a T := by
  have ht : 0 < t := ha.trans_le hat
  have he := canonicalIntrinsicPremium_dilation_differential_bound hk hh hhk hz
  have hd := canonicalIntrinsicPremium_deriv_bounds (x := x) hk hh hhk ht
  have hs1 := mul_le_mul_of_nonneg_right (neg_le_abs x) hd.1
  have hs2 := mul_le_mul_of_nonneg_left hd.2 (abs_nonneg x)
  have htime : deriv (canonicalIntrinsicPremium k h x) t = deriv (canonicalPrice k h x) t :=
    deriv_sub_const (1-Real.exp x)
  rw [htime] at he
  have htn := canonicalPrice_time_deriv_nonneg (h := h) hk.le x t
  have ham := mul_le_mul_of_nonneg_right hat htn
  have hex : Real.exp ((10+3*|k-h-1|)*t) ≤ Real.exp ((10+3*|k-h-1|)*T) :=
    Real.exp_le_exp.mpr (mul_le_mul_of_nonneg_left htT (by positivity))
  have hC : 0 ≤ 2*|k-h-1|+4*h+1 := by positivity
  have hmul := mul_le_mul_of_nonneg_right (mul_le_mul_of_nonneg_left hex hC) (dilationWeight_pos x).le
  unfold actualTemporalDerivativeBound
  apply (le_div_iff₀ (show 0 < 2*a by positivity)).mpr
  nlinarith only [he,hs1,hs2,ham,hmul]

end AmericanConvexity.Stopping
