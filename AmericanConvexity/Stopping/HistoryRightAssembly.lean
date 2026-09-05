import AmericanConvexity.Stopping.ActualRecentRemainder
import AmericanConvexity.Stopping.ActualCommonPastDerivative
import AmericanConvexity.Stopping.HistoryReferenceDerivative
import AmericanConvexity.Stopping.RightDerivativeAssembly

/-! # Right differentiation of the assembled local actual history

The common-past derivative, vanishing new-source quotient and exact
straight-line reference derivative use the same frozen values. All
differences and source-time transformations have genuine integrability.
-/

namespace AmericanConvexity.Stopping

open Set Filter MeasureTheory
open scoped Topology

theorem heatHistoryFrom_frozen_increment_elapsed {b f : ℝ → ℝ} {a t r : ℝ}
    (hat : a < t) (htr : t < r)
    (hit : IntegrableOn (fun s => movingHeatHistoryKernel b t s*f s) (Ioo a t))
    (hir : IntegrableOn (fun s => movingHeatHistoryKernel b r s*f s) (Ioo a r)) :
    heatHistoryFrom b f a r-heatHistoryFrom b f a t =
      ((∫ u in Ioo 0 (t-a), frozenHeatHistoryRemainder b f (deriv b t) (f t) r (t-u))-
        (∫ u in Ioo 0 (t-a), frozenHeatHistoryRemainder b f (deriv b t) (f t) t (t-u)))+
      (linearHeatHistoryIntegral (deriv b t) (f t) (r-a)-
        linearHeatHistoryIntegral (deriv b t) (f t) (t-a))+
      recentFrozenHistory b f t (r-t) := by
  have hRt := frozenHeatHistoryRemainder_source_integrable hat le_rfl (deriv b t) (f t) hit
  have hRr := frozenHeatHistoryRemainder_source_integrable hat htr.le (deriv b t) (f t)
    (hir.mono_set (fun _ hs => ⟨hs.1,hs.2.trans htr⟩))
  have he := heatHistoryFrom_frozen_decomposition (v := deriv b t) (c := f t) hat htr hit hir
  rw [integral_sub hRr hRt] at he
  have hc (z : ℝ) :
      (∫ s in Ioo a t, frozenHeatHistoryRemainder b f (deriv b t) (f t) z s) =
        ∫ u in Ioo 0 (t-a), frozenHeatHistoryRemainder b f (deriv b t) (f t) z (t-u) := by
    simpa only [sub_self] using
      setIntegral_Ioo_reflect (fun s => frozenHeatHistoryRemainder b f (deriv b t) (f t) z s) hat.le t
  have hn : (∫ s in Ioo t r, frozenHeatHistoryRemainder b f (deriv b t) (f t) r s) =
      recentFrozenHistory b f t (r-t) := by
    unfold recentFrozenHistory
    rw [show t+(r-t) = r by ring]
    simpa only [sub_self] using
      setIntegral_Ioo_reflect (fun s => frozenHeatHistoryRemainder b f (deriv b t) (f t) r s) htr.le r
  rw [hc r,hc t,hn] at he
  linarith

theorem canonicalLocalHistory_hasDerivWithinAt_right {k h t C : ℝ} {f : ℝ → ℝ}
    (hk : 0 < k) (hh : 0 ≤ h) (hhk : h ≤ k) (ht : 0 < t)
    (hf : Continuous f) (hCf : ∀ s, ‖f s‖ ≤ C) (hm : LocalThreeQuarterHolderAt f t) :
    ∃ a d : ℝ, 0 < a ∧ a < t ∧
      HasDerivWithinAt (heatHistoryFrom (fun s => canonicalLogBoundary k h (s/2)) f a) d (Ici t) t := by
  obtain ⟨T,hT,_,hTt,hcommon⟩ := canonicalCommonPast_hasDerivWithinAt_right hk hh hhk ht hf hCf hm
  have ha : 0 < t-T := by linarith
  have hat : t-T < t := by linarith
  have hnew := (canonicalRecentFrozenHistory_quotient_tendsto hk hh hhk ht hf.continuousOn hm).comp
    (tendsto_sub_nhdsGT t)
  have hline := linearHeatHistoryIntegral_shift_hasDerivAt
    (v := deriv (fun s => canonicalLogBoundary k h (s/2)) t) (c := f t) hat
  refine ⟨t-T,_,ha,hat,hasDerivWithinAt_Ici_of_increment_remainder
    (R := fun r => recentFrozenHistory (fun s => canonicalLogBoundary k h (s/2)) f t (r-t))
    hcommon hline.hasDerivWithinAt hnew ?_⟩
  filter_upwards [self_mem_nhdsWithin] with r hr
  have hir := canonicalHeatHistory_source_integrable hk hh hhk ha (hat.trans hr) le_rfl hf hCf
  have hit := canonicalHeatHistory_source_integrable hk hh hhk ha hat le_rfl hf hCf
  simpa only [sub_sub_cancel] using heatHistoryFrom_frozen_increment_elapsed hat hr hit hir

end AmericanConvexity.Stopping
