import AmericanConvexity.Stopping.ActualRegularizedHistoryContinuity
import AmericanConvexity.Stopping.HistoryReferenceDerivative

/-! # Integrability needed to compare regularized rates across source starts -/

namespace AmericanConvexity.Stopping

open Set Filter MeasureTheory
open scoped Topology

theorem linearHeatMotion_integrable {v c d D : ℝ} (hd : 0 < d) :
    IntegrableOn (fun u => heatBoundaryMotionDerivative u (v*u) v*c) (Ioo d D) := by
  have hc : ContinuousOn (fun u => heatBoundaryMotionDerivative u (v*u) v*c) (Icc d D) := by
    intro u hu
    exact ((heatBoundaryMotionDerivative_continuousAt (continuousAt_id (x := u))
      (show ContinuousAt (fun z : ℝ => v*z) u by fun_prop) (hd.trans_le hu.1)).mul
      (continuousAt_const (y := c))).continuousWithinAt
  exact hc.integrableOn_Icc.mono_set Ioo_subset_Icc_self

theorem linearHeatMotion_integral {v c d D : ℝ} (hd : 0 < d) (hdD : d ≤ D) :
    (∫ u in Ioo d D, heatBoundaryMotionDerivative u (v*u) v*c) =
      heatBoundaryKernel D (v*D)*c-heatBoundaryKernel d (v*d)*c := by
  have hder (u : ℝ) (hu : u ∈ Icc d D) :
      HasDerivAt (fun z => heatBoundaryKernel z (v*z)*c)
        (heatBoundaryMotionDerivative u (v*u) v*c) u := by
    simpa only [sub_zero] using!
      (linearHeatHistoryKernel_hasDerivAt (s := 0) (v := v) (hd.trans_le hu.1)).mul_const c
  have he := intervalIntegral.integral_eq_sub_of_hasDerivAt
    (fun u hu => hder u (by simpa only [uIcc_of_le hdD] using hu))
    ((intervalIntegrable_iff_integrableOn_Ioo_of_le hdD).mpr (linearHeatMotion_integrable hd))
  simpa only [intervalIntegral.integral_of_le hdD,integral_Ioc_eq_integral_Ioo] using he

theorem canonicalRegularizedHistoryDerivative_integrable {k h a t : ℝ} {f : ℝ → ℝ}
    (hk : 0 < k) (hh : 0 ≤ h) (hhk : h ≤ k) (ha : 0 < a) (hat : a < t)
    (hf : Continuous f) (hm : LocalThreeQuarterHolderAt f t) :
    IntegrableOn (regularizedHistoryDerivative (fun s => canonicalLogBoundary k h (s/2)) f t) (Ioo 0 (t-a)) := by
  obtain ⟨T,M,hT,_,_,_,hbound⟩ := canonicalFrozenHistoryDerivative_tail_control hk hh hhk (ha.trans hat) hf.continuousOn hm
  let δ := min (T/2) ((t-a)/2)
  have hδ : 0 < δ := lt_min (half_pos hT) (half_pos (sub_pos.mpr hat))
  have hδT : δ ≤ T := (min_le_left _ _).trans (by linarith)
  have hδta : δ ≤ t-a := (min_le_right _ _).trans (by linarith)
  have hi₁ : IntegrableOn (regularizedHistoryDerivative (fun s => canonicalLogBoundary k h (s/2)) f t) (Ioo 0 δ) := by
    apply (hbound δ hδ hδT).1.congr_fun _ measurableSet_Ioo
    intro u hu
    exact (regularizedHistoryDerivative_eq_frozen_deriv hu.1
      (canonicalHeatGraph_hasDerivAt hk hh hhk (ha.trans hat)).differentiableAt).symm
  have hc : ContinuousOn (regularizedHistoryDerivative (fun s => canonicalLogBoundary k h (s/2)) f t)
      (Ioo 0 (t-a/2)) := by
    apply regularizedHistoryDerivative_source_continuousOn
      (canonicalHeatGraph_hasDerivAt hk hh hhk (ha.trans hat)).differentiableAt _ hf.continuousOn
    intro s hs
    have hpos : 0 < s := by linarith [hs.1]
    exact (canonicalHeatGraph_hasDerivAt hk hh hhk hpos).continuousAt.continuousWithinAt
  have hi₂ : IntegrableOn (regularizedHistoryDerivative (fun s => canonicalLogBoundary k h (s/2)) f t)
      (Ioo δ (t-a)) :=
    (hc.mono (show Icc δ (t-a) ⊆ Ioo 0 (t-a/2) from
      fun u hu => ⟨hδ.trans_le hu.1,by linarith [hu.2]⟩)).integrableOn_Icc.mono_set Ioo_subset_Icc_self
  exact (intervalIntegrable_iff_integrableOn_Ioo_of_le (sub_pos.mpr hat).le).mp
    (((intervalIntegrable_iff_integrableOn_Ioo_of_le hδ.le).mpr hi₁).trans
      ((intervalIntegrable_iff_integrableOn_Ioo_of_le hδta).mpr hi₂))

theorem canonicalOlderHistoryRate_integrable {k h a₀ a t : ℝ} {f : ℝ → ℝ}
    (hk : 0 < k) (hh : 0 ≤ h) (hhk : h ≤ k) (ha₀ : 0 < a₀) (hat : a < t)
    (hf : Continuous f) :
    IntegrableOn (fun s => heatBoundaryMotionDerivative (t-s)
      (canonicalLogBoundary k h (t/2)-canonicalLogBoundary k h (s/2))
      (deriv (fun u => canonicalLogBoundary k h (u/2)) t)*f s) (Ioo a₀ a) := by
  have hc : ContinuousOn (fun s => heatBoundaryMotionDerivative (t-s)
      (canonicalLogBoundary k h (t/2)-canonicalLogBoundary k h (s/2))
      (deriv (fun u => canonicalLogBoundary k h (u/2)) t)*f s) (Icc a₀ a) := by
    intro s hs
    have hbc := (canonicalHeatGraph_hasDerivAt hk hh hhk (ha₀.trans_le hs.1)).continuousAt
    exact ((heatBoundaryMotionDerivative_continuousAt
      (show ContinuousAt (fun z : ℝ => t-z) s by fun_prop)
      ((continuousAt_const (y := canonicalLogBoundary k h (t/2))).sub hbc)
      (sub_pos.mpr (hs.2.trans_lt hat))).mul hf.continuousAt).continuousWithinAt
  exact hc.integrableOn_Icc.mono_set Ioo_subset_Icc_self

end AmericanConvexity.Stopping
