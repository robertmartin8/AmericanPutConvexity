import AmericanPutConvexity.Stopping.HistoryRightAssembly
import AmericanPutConvexity.Stopping.OlderHistoryDerivative

/-! # Right derivative of actual history from any positive causal start

Changing the local start only adds or subtracts an older-source integral,
whose ordinary derivative is proved. Thus the local right derivative
extends to the original causal start used by the density equation.
-/

namespace AmericanPutConvexity.Stopping

open Set Filter MeasureTheory
open scoped Topology

theorem canonicalHeatHistoryFrom_split {k h a₀ a t C : ℝ} {f : ℝ → ℝ}
    (hk : 0 < k) (hh : 0 ≤ h) (hhk : h ≤ k) (ha₀ : 0 < a₀)
    (ha : a₀ < a) (hat : a < t) (hf : Continuous f) (hCf : ∀ s, ‖f s‖ ≤ C) :
    heatHistoryFrom (fun s => canonicalLogBoundary k h (s/2)) f a₀ t =
      (∫ s in Ioo a₀ a, movingHeatHistoryKernel (fun u => canonicalLogBoundary k h (u/2)) t s*f s)+
      heatHistoryFrom (fun s => canonicalLogBoundary k h (s/2)) f a t := by
  unfold heatHistoryFrom
  exact setIntegral_Ioo_split ha.le hat.le
    (canonicalHeatHistory_source_integrable hk hh hhk ha₀ ha hat.le hf hCf)
    (canonicalHeatHistory_source_integrable hk hh hhk (ha₀.trans ha) hat le_rfl hf hCf)

theorem canonicalFullHistory_hasDerivWithinAt_right {k h a₀ t C : ℝ} {f : ℝ → ℝ}
    (hk : 0 < k) (hh : 0 ≤ h) (hhk : h ≤ k) (ha₀ : 0 < a₀) (hat : a₀ < t)
    (hf : Continuous f) (hCf : ∀ s, ‖f s‖ ≤ C) (hm : LocalThreeQuarterHolderAt f t) :
    ∃ d : ℝ,
      HasDerivWithinAt (heatHistoryFrom (fun s => canonicalLogBoundary k h (s/2)) f a₀) d (Ici t) t := by
  obtain ⟨a,d,ha,hat',hd⟩ := canonicalLocalHistory_hasDerivWithinAt_right hk hh hhk (ha₀.trans hat) hf hCf hm
  rcases lt_trichotomy a₀ a with hlt | heq | hgt
  · have ho := canonicalOlderHistory_hasDerivAt hk hh hhk ha₀ hlt hat' hf hCf
    have he : (heatHistoryFrom (fun s => canonicalLogBoundary k h (s/2)) f a₀) =ᶠ[𝓝 t]
        (fun r => (∫ s in Ioo a₀ a, movingHeatHistoryKernel
          (fun u => canonicalLogBoundary k h (u/2)) r s*f s)+
          heatHistoryFrom (fun s => canonicalLogBoundary k h (s/2)) f a r) := by
      filter_upwards [Ioi_mem_nhds hat'] with r hr
      exact canonicalHeatHistoryFrom_split hk hh hhk ha₀ hlt hr hf hCf
    exact ⟨_,(ho.hasDerivWithinAt.add hd).congr_of_eventuallyEq
      (nhdsWithin_le_nhds he) he.self_of_nhds⟩
  · subst a
    exact ⟨d,hd⟩
  · have ho := canonicalOlderHistory_hasDerivAt hk hh hhk ha hgt hat hf hCf
    have he : (heatHistoryFrom (fun s => canonicalLogBoundary k h (s/2)) f a₀) =ᶠ[𝓝 t]
        (fun r => heatHistoryFrom (fun s => canonicalLogBoundary k h (s/2)) f a r-
          (∫ s in Ioo a a₀, movingHeatHistoryKernel (fun u => canonicalLogBoundary k h (u/2)) r s*f s)) := by
      filter_upwards [Ioi_mem_nhds hat] with r hr
      have hs := canonicalHeatHistoryFrom_split hk hh hhk ha hgt hr hf hCf
      linarith
    exact ⟨_,(hd.sub ho.hasDerivWithinAt).congr_of_eventuallyEq
      (nhdsWithin_le_nhds he) he.self_of_nhds⟩

theorem canonicalFullElapsedHistory_hasDerivWithinAt_right {k h a₀ t C : ℝ} {f : ℝ → ℝ}
    (hk : 0 < k) (hh : 0 ≤ h) (hhk : h ≤ k) (ha₀ : 0 < a₀) (hat : a₀ < t)
    (hf : Continuous f) (hCf : ∀ s, ‖f s‖ ≤ C) (hm : LocalThreeQuarterHolderAt f t) :
    ∃ d : ℝ, HasDerivWithinAt
      (fun r => heatHistory (fun s => canonicalLogBoundary k h (s/2)) (r-a₀) f r) d (Ici t) t := by
  obtain ⟨d,hd⟩ := canonicalFullHistory_hasDerivWithinAt_right hk hh hhk ha₀ hat hf hCf hm
  have he : (fun r => heatHistory (fun s => canonicalLogBoundary k h (s/2)) (r-a₀) f r) =ᶠ[𝓝 t]
      heatHistoryFrom (fun s => canonicalLogBoundary k h (s/2)) f a₀ := by
    filter_upwards [Ioi_mem_nhds hat] with r hr
    exact (heatHistoryFrom_eq_elapsed _ _ hr.le).symm
  exact ⟨d,hd.congr_of_eventuallyEq (nhdsWithin_le_nhds he) he.self_of_nhds⟩

end AmericanPutConvexity.Stopping
