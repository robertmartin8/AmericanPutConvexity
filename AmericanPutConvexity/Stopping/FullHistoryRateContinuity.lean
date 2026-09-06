import AmericanPutConvexity.Stopping.HistoryRateIdentification
import AmericanPutConvexity.Stopping.OlderHistoryRateContinuity

/-! # Continuous intrinsic right derivative from the original causal start

The rate comparison and continuity of the old-source rate remove the
dependence on the local start chosen in the continuity construction.
-/

namespace AmericanPutConvexity.Stopping

open Set Filter MeasureTheory
open scoped Topology

theorem canonicalFullHistoryRightDerivative_continuousAt {k h a₀ t C : ℝ} {f : ℝ → ℝ}
    (hk : 0 < k) (hh : 0 ≤ h) (hhk : h ≤ k) (ha₀ : 0 < a₀) (hat : a₀ < t)
    (hf : Continuous f) (hCf : ∀ s, ‖f s‖ ≤ C) (hm : LocalThreeQuarterHolderAt f t) :
    ContinuousAt (historyRightDerivative (fun s => canonicalLogBoundary k h (s/2)) f a₀) t := by
  obtain ⟨a,ha,hat',hc⟩ := canonicalLocalHistoryRightDerivative_continuousAt hk hh hhk (ha₀.trans hat) hf hCf hm
  rcases lt_trichotomy a₀ a with hlt | heq | hgt
  · have ho := canonicalOlderHistoryRate_continuousAt hk hh hhk ha₀ hlt hat' hf
    have he : historyRightDerivative (fun s => canonicalLogBoundary k h (s/2)) f a₀ =ᶠ[𝓝 t]
        (fun r => (∫ s in Ioo a₀ a, heatBoundaryMotionDerivative (r-s)
          (canonicalLogBoundary k h (r/2)-canonicalLogBoundary k h (s/2))
          (deriv (fun u => canonicalLogBoundary k h (u/2)) r)*f s)+
          historyRightDerivative (fun s => canonicalLogBoundary k h (s/2)) f a r) := by
      filter_upwards [hm.eventually,Ioi_mem_nhds hat'] with r hr hrt
      rw [canonicalHistoryRightDerivative_eq_regularizedRate hk hh hhk ha₀ (hlt.trans hrt) hf hCf hr,
        canonicalHistoryRightDerivative_eq_regularizedRate hk hh hhk ha hrt hf hCf hr]
      exact canonicalRegularizedHistoryRate_split hk hh hhk ha₀ hlt hrt hf hr
    exact (ho.add hc).congr_of_eventuallyEq he
  · subst a
    exact hc
  · have ho := canonicalOlderHistoryRate_continuousAt hk hh hhk ha hgt hat hf
    have he : historyRightDerivative (fun s => canonicalLogBoundary k h (s/2)) f a₀ =ᶠ[𝓝 t]
        (fun r => historyRightDerivative (fun s => canonicalLogBoundary k h (s/2)) f a r-
          (∫ s in Ioo a a₀, heatBoundaryMotionDerivative (r-s)
          (canonicalLogBoundary k h (r/2)-canonicalLogBoundary k h (s/2))
          (deriv (fun u => canonicalLogBoundary k h (u/2)) r)*f s)) := by
      filter_upwards [hm.eventually,Ioi_mem_nhds hat] with r hr hrt
      rw [canonicalHistoryRightDerivative_eq_regularizedRate hk hh hhk ha₀ hrt hf hCf hr,
        canonicalHistoryRightDerivative_eq_regularizedRate hk hh hhk ha (hgt.trans hrt) hf hCf hr]
      have hs := canonicalRegularizedHistoryRate_split hk hh hhk ha hgt hrt hf hr
      linarith
    exact (hc.sub ho).congr_of_eventuallyEq he

theorem canonicalRegularizedHistoryRate_continuousAt_all_starts {k h a t C : ℝ} {f : ℝ → ℝ}
    (hk : 0 < k) (hh : 0 ≤ h) (hhk : h ≤ k) (ha : 0 < a) (hat : a < t)
    (hf : Continuous f) (hCf : ∀ s, ‖f s‖ ≤ C) (hm : LocalThreeQuarterHolderAt f t) :
    ContinuousAt (regularizedHistoryRate (fun s => canonicalLogBoundary k h (s/2)) f a) t := by
  have he : regularizedHistoryRate (fun s => canonicalLogBoundary k h (s/2)) f a =ᶠ[𝓝 t]
      historyRightDerivative (fun s => canonicalLogBoundary k h (s/2)) f a := by
    filter_upwards [hm.eventually,Ioi_mem_nhds hat] with r hr hrt
    exact (canonicalHistoryRightDerivative_eq_regularizedRate hk hh hhk ha hrt hf hCf hr).symm
  exact (canonicalFullHistoryRightDerivative_continuousAt hk hh hhk ha hat hf hCf hm).congr_of_eventuallyEq he

end AmericanPutConvexity.Stopping
