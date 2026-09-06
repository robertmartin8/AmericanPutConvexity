import AmericanPutConvexity.Stopping.ActualRegularizedHistoryContinuity
import AmericanPutConvexity.Stopping.HistoryRightAssembly

/-! # Explicit rate in the local right-history derivative

This makes the value of the constructed local right derivative explicit.
The source start supplied here and the start supplied by the continuity
construction need not coincide; identifying rates across starts is still
needed before deducing continuity of the intrinsic derivative.
-/

namespace AmericanPutConvexity.Stopping

open Set Filter MeasureTheory
open scoped Topology

theorem canonicalLocalHistory_hasDerivWithinAt_regularizedRate {k h t C : ℝ} {f : ℝ → ℝ}
    (hk : 0 < k) (hh : 0 ≤ h) (hhk : h ≤ k) (ht : 0 < t)
    (hf : Continuous f) (hCf : ∀ s, ‖f s‖ ≤ C) (hm : LocalThreeQuarterHolderAt f t) :
    ∃ a : ℝ, 0 < a ∧ a < t ∧
      HasDerivWithinAt (heatHistoryFrom (fun s => canonicalLogBoundary k h (s/2)) f a)
        (regularizedHistoryRate (fun s => canonicalLogBoundary k h (s/2)) f a t) (Ici t) t := by
  obtain ⟨T,hT,_,hTt,hcommon⟩ := canonicalCommonPast_hasDerivWithinAt_right hk hh hhk ht hf hCf hm
  have ha : 0 < t-T := by linarith
  have hat : t-T < t := by linarith
  have hnew := (canonicalRecentFrozenHistory_quotient_tendsto hk hh hhk ht hf.continuousOn hm).comp
    (tendsto_sub_nhdsGT t)
  have hline := linearHeatHistoryIntegral_shift_hasDerivAt
    (v := deriv (fun s => canonicalLogBoundary k h (s/2)) t) (c := f t) hat
  have he : ∀ᶠ r in 𝓝[>] t,
      heatHistoryFrom (fun s => canonicalLogBoundary k h (s/2)) f (t-T) r-
        heatHistoryFrom (fun s => canonicalLogBoundary k h (s/2)) f (t-T) t =
      ((∫ u in Ioo 0 T, frozenHeatHistoryRemainder (fun s => canonicalLogBoundary k h (s/2)) f
          (deriv (fun s => canonicalLogBoundary k h (s/2)) t) (f t) r (t-u))-
        (∫ u in Ioo 0 T, frozenHeatHistoryRemainder (fun s => canonicalLogBoundary k h (s/2)) f
          (deriv (fun s => canonicalLogBoundary k h (s/2)) t) (f t) t (t-u)))+
      (linearHeatHistoryIntegral (deriv (fun s => canonicalLogBoundary k h (s/2)) t) (f t) (r-(t-T))-
        linearHeatHistoryIntegral (deriv (fun s => canonicalLogBoundary k h (s/2)) t) (f t) (t-(t-T)))+
      recentFrozenHistory (fun s => canonicalLogBoundary k h (s/2)) f t (r-t) := by
    filter_upwards [self_mem_nhdsWithin] with r hr
    have hir := canonicalHeatHistory_source_integrable hk hh hhk ha (hat.trans hr) le_rfl hf hCf
    have hit := canonicalHeatHistory_source_integrable hk hh hhk ha hat le_rfl hf hCf
    simpa only [sub_sub_cancel] using heatHistoryFrom_frozen_increment_elapsed hat hr hit hir
  have hd := hasDerivWithinAt_Ici_of_increment_remainder
    (R := fun r => recentFrozenHistory (fun s => canonicalLogBoundary k h (s/2)) f t (r-t))
    hcommon hline.hasDerivWithinAt hnew he
  refine ⟨t-T,ha,hat,?_⟩
  convert! hd using 1
  unfold regularizedHistoryRate
  simp only [sub_sub_cancel]
  congr 1
  apply setIntegral_congr_fun measurableSet_Ioo
  intro u hu
  exact regularizedHistoryDerivative_eq_frozen_deriv hu.1
    (canonicalHeatGraph_hasDerivAt hk hh hhk ht).differentiableAt

end AmericanPutConvexity.Stopping
