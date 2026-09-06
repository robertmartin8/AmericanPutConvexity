import AmericanPutConvexity.Stopping.ActualTemporalDerivativeBound

/-! # Locally uniform upper bounds on the premium's spatial curvature

The pricing PDE turns the proved time-derivative bound into a second-spatial
derivative bound in continuation. No second price derivative at contact is
asserted.
-/

namespace AmericanPutConvexity.Stopping

open Set Filter Boundary
open scoped Topology

noncomputable def actualSpatialSecondBound (k h x a T : ℝ) : ℝ :=
  actualTemporalDerivativeBound k h x a T+(|k-h-1|+k)*Real.exp x+k

theorem actualSpatialSecondBound_pos {k h x a T : ℝ} (hk : 0 < k)
    (hh : 0 ≤ h) (ha : 0 < a) : 0 < actualSpatialSecondBound k h x a T := by
  have hD := actualTemporalDerivativeBound_nonneg (k := k) (x := x) (T := T) hh ha
  unfold actualSpatialSecondBound
  have hm : 0 ≤ (|k-h-1|+k)*Real.exp x := by positivity
  linarith

theorem actualSpatialSecondBound_continuous (k h a T : ℝ) :
    Continuous (fun x => actualSpatialSecondBound k h x a T) := by
  unfold actualSpatialSecondBound actualTemporalDerivativeBound dilationWeight
  fun_prop

theorem canonicalIntrinsicPremium_deriv2_le_bound {k h x t a T : ℝ}
    (hk : 0 < k) (hh : 0 ≤ h) (hhk : h ≤ k) (ha : 0 < a) (hat : a ≤ t) (htT : t ≤ T)
    (hz : (x,t) ∈ canonicalContinuationRegion k h) :
    deriv (deriv (fun y => canonicalIntrinsicPremium k h y t)) x ≤
      actualSpatialSecondBound k h x a T := by
  have ht : 0 < t := ha.trans_le hat
  have hpde := canonicalIntrinsicPremium_equation hk.le hz
  have htime := canonicalPrice_time_deriv_le_dilationBound hk hh hhk ha hat htT hz
  have hgrad := canonicalIntrinsicPremium_deriv_bounds (x := x) hk hh hhk ht
  have hu := canonicalIntrinsicPremium_le_exp (h := h) hk.le x t
  have hproduct := mul_le_mul_of_nonneg_left hu hk.le
  have hα0 := mul_le_mul_of_nonneg_right (neg_le_abs (k-h-1)) hgrad.1
  have hα1 := mul_le_mul_of_nonneg_left hgrad.2 (abs_nonneg (k-h-1))
  have hdiv : 0 ≤ h*Real.exp x := mul_nonneg hh (Real.exp_pos x).le
  have hdt : deriv (canonicalIntrinsicPremium k h x) t = deriv (canonicalPrice k h x) t :=
    deriv_sub_const (1-Real.exp x)
  rw [hdt] at hpde
  unfold actualSpatialSecondBound
  nlinarith only [hpde,htime,hproduct,hα0,hα1,hdiv]

theorem canonicalIntrinsicPremium_deriv2_upper_near {k h x t : ℝ}
    (hk : 0 < k) (hh : 0 ≤ h) (hhk : h ≤ k) (ht : 0 < t) :
    ∃ C : ℝ, 0 < C ∧ ∀ᶠ z : ℝ × ℝ in 𝓝 (x,t),
      z ∈ canonicalContinuationRegion k h →
        deriv (deriv (fun y => canonicalIntrinsicPremium k h y z.2)) z.1 ≤ C := by
  let C := actualSpatialSecondBound k h x (t/2) (t+1)+1
  have hC : 0 < C := by
    have he := actualSpatialSecondBound_pos (x := x) (T := t+1) hk hh (by positivity : 0 < t/2)
    dsimp [C]
    linarith
  have hc : ContinuousAt (fun z : ℝ × ℝ => actualSpatialSecondBound k h z.1 (t/2) (t+1)) (x,t) :=
    ((actualSpatialSecondBound_continuous k h (t/2) (t+1)).comp continuous_fst).continuousAt
  have hless : ∀ᶠ z : ℝ × ℝ in 𝓝 (x,t), actualSpatialSecondBound k h z.1 (t/2) (t+1) < C :=
    hc.eventually (Iio_mem_nhds (by dsimp [C]; linarith))
  refine ⟨C,hC,?_⟩
  filter_upwards [hless,
    continuousAt_snd.preimage_mem_nhds (Ioi_mem_nhds (show t/2 < t by linarith)),
    continuousAt_snd.preimage_mem_nhds (Iio_mem_nhds (show t < t+1 by linarith))]
    with z hbound hlo hhi
  intro hz
  exact (canonicalIntrinsicPremium_deriv2_le_bound hk hh hhk (by positivity) hlo.le hhi.le hz).trans hbound.le

end AmericanPutConvexity.Stopping
