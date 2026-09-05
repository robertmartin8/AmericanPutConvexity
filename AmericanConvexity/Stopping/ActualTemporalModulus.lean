import AmericanConvexity.Stopping.ActualTemporalComparison
import AmericanConvexity.Stopping.ActualBoundaryNondegeneracy

/-! # The at-strike short-maturity price controls all temporal increments

The maximum initial time value occurs at strike. The actual temporal
comparison propagates that bound to every maturity and every log spot.
-/

namespace AmericanConvexity.Stopping

open Set Filter MeasureTheory ProbabilityTheory Boundary
open scoped Topology NNReal

theorem canonicalPrice_antitone_spatial {k h : ℝ} (hk : 0 ≤ k) (t : ℝ) :
    Antitone (fun x => canonicalPrice k h x t) := by
  let μ := completedMeasure gaussianLimit
  letI : MeasurableSpace (ℝ≥0 → ℝ) := completedMeasurableSpace gaussianLimit
  intro x y hxy
  exact value_antitone_spot (P := μ) (𝓕 := brownianUsualFiltration) (q := h) (σ := Real.sqrt 2)
    (T := t.toNNReal) brownian_completed_measurable (by norm_num : (0 : ℝ) ≤ 1) hk
    (Real.exp_pos x).le (Real.exp_pos y).le (Real.exp_le_exp.mpr hxy)

theorem canonicalIntrinsicPremium_monotone_spatial {k h t : ℝ} (hk : 0 < k)
    (hh : 0 ≤ h) (hhk : h ≤ k) (ht : 0 < t) :
    Monotone (fun x => canonicalIntrinsicPremium k h x t) := by
  apply monotone_of_deriv_nonneg
  · intro x
    exact (canonicalPrice_differentiableAt_spatial hk hh hhk ht x).sub
      ((Real.hasDerivAt_exp x).const_sub 1).differentiableAt
  · intro x
    rw [canonicalIntrinsicPremium_spatial_deriv hk hh hhk ht]
    rcases le_or_gt x (canonicalLogBoundary k h t) with hx | hx
    · rw [(canonicalPrice_hasDerivAt_exercise hk hh hhk ht hx).deriv]
      simp
    · linarith [canonicalPrice_spatial_deriv_gt_exercise hk hh hhk ht hx]

theorem canonicalPrice_expiry_gap_le_atStrike {k h t : ℝ} (hk : 0 < k)
    (hh : 0 ≤ h) (hhk : h ≤ k) (ht : 0 ≤ t) (x : ℝ) :
    canonicalPrice k h x t-putPayoff x ≤ canonicalPrice k h 0 t := by
  rcases ht.eq_or_lt with he | ht
  · simp only [← he,canonicalPrice_initial hk.le,sub_self,putPayoff,Real.exp_zero,sub_self,max_self,le_refl]
  rcases le_total x 0 with hx | hx
  · have hm := canonicalIntrinsicPremium_monotone_spatial hk hh hhk ht hx
    rw [putPayoff_of_nonpos hx]
    simpa only [canonicalIntrinsicPremium,Real.exp_zero,sub_self,sub_zero] using hm
  · have hp : putPayoff x = 0 := max_eq_right (sub_nonpos.mpr (Real.one_le_exp_iff.mpr hx))
    rw [hp,sub_zero]
    exact canonicalPrice_antitone_spatial hk.le t hx

theorem canonicalTimeIncrement_le_atStrike {k h δ : ℝ} (hk : 0 < k)
    (hh : 0 ≤ h) (hhk : h ≤ k) (hδ : 0 ≤ δ) (x : ℝ) {t : ℝ} (ht : 0 ≤ t) :
    canonicalTimeIncrement k h δ x t ≤ canonicalPrice k h 0 δ :=
  canonicalTimeIncrement_le_of_initial_bound hk hh hhk hδ
    ((putPayoff_nonneg 0).trans (canonicalPrice_bounds (h := h) hk.le 0 δ).1)
    (canonicalPrice_expiry_gap_le_atStrike hk hh hhk hδ) x ht

/-- A single scalar function controls temporal increments uniformly over all
log spots and nonnegative maturities. No rate of decay is claimed here. -/
theorem canonicalPrice_temporal_modulus {k h s t : ℝ} (hk : 0 < k)
    (hh : 0 ≤ h) (hhk : h ≤ k) (hs : 0 ≤ s) (ht : 0 ≤ t) (x : ℝ) :
    |canonicalPrice k h x t-canonicalPrice k h x s| ≤ canonicalPrice k h 0 |t-s| := by
  rcases le_total s t with hst | hts
  · rw [abs_of_nonneg (sub_nonneg.mpr (canonicalPrice_monotone_time hk.le x hst)),
      abs_of_nonneg (sub_nonneg.mpr hst)]
    have he := canonicalTimeIncrement_le_atStrike hk hh hhk (sub_nonneg.mpr hst) x hs
    simpa only [canonicalTimeIncrement,show s+(t-s)=t by ring] using he
  · rw [abs_of_nonpos (sub_nonpos.mpr (canonicalPrice_monotone_time hk.le x hts)),
      abs_of_nonpos (sub_nonpos.mpr hts),neg_sub]
    have he := canonicalTimeIncrement_le_atStrike hk hh hhk (sub_nonneg.mpr hts) x ht
    simpa only [canonicalTimeIncrement,show t+(s-t)=s by ring,neg_sub] using he

theorem canonicalPrice_atStrike_tendsto_zero {k h : ℝ} (hk : 0 ≤ k) :
    Tendsto (canonicalPrice k h 0) (𝓝 (0 : ℝ)) (𝓝 0) := by
  have hm : ContinuousAt (fun t : ℝ => ((0 : ℝ),t)) 0 := by fun_prop
  have he := (canonicalPrice_continuous (h := h) hk).continuousAt.comp
    (f := fun t : ℝ => ((0 : ℝ),t)) hm
  simpa only [Function.comp_def,canonicalPrice_initial hk,putPayoff,Real.exp_zero,sub_self,max_self] using he.tendsto

theorem zeroDividend_canonicalPrice_temporal_modulus {k s t : ℝ} (hk : 0 < k)
    (hs : 0 ≤ s) (ht : 0 ≤ t) (x : ℝ) :
    |canonicalPrice k 0 x t-canonicalPrice k 0 x s| ≤ canonicalPrice k 0 0 |t-s| :=
  canonicalPrice_temporal_modulus hk le_rfl hk.le hs ht x

theorem liuRange_canonicalPrice_temporal_modulus {k h s t : ℝ}
    (hh : 0 ≤ h) (hliu : h+1 ≤ k) (hs : 0 ≤ s) (ht : 0 ≤ t) (x : ℝ) :
    |canonicalPrice k h x t-canonicalPrice k h x s| ≤ canonicalPrice k h 0 |t-s| :=
  canonicalPrice_temporal_modulus (by linarith) hh (by linarith) hs ht x

end AmericanConvexity.Stopping
