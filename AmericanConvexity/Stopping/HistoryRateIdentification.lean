import AmericanConvexity.Stopping.HistoryRateStartComparison
import AmericanConvexity.Stopping.LocalHistoryRateIdentity
import AmericanConvexity.Stopping.FullHistoryRightDerivative

/-! # Regularized rate equals the intrinsic right derivative at every start

The comparison identity transports the explicit local derivative to any
positive causal start. Local Holder regularity persists on a neighborhood,
so the identification is also valid there with the source start fixed.
-/

namespace AmericanConvexity.Stopping

open Set Filter MeasureTheory
open scoped Topology

theorem LocalThreeQuarterHolderAt.eventually {f : ℝ → ℝ} {t : ℝ}
    (hm : LocalThreeQuarterHolderAt f t) : ∀ᶠ r in 𝓝 t, LocalThreeQuarterHolderAt f r := by
  obtain ⟨A,U,hA,hU,hb⟩ := hm
  filter_upwards [isOpen_interior.mem_nhds (mem_interior_iff_mem_nhds.mpr hU)] with r hr
  exact ⟨A,U,hA,mem_interior_iff_mem_nhds.mp hr,hb⟩

theorem canonicalHistory_hasDerivWithinAt_regularizedRate {k h a₀ t C : ℝ} {f : ℝ → ℝ}
    (hk : 0 < k) (hh : 0 ≤ h) (hhk : h ≤ k) (ha₀ : 0 < a₀) (hat : a₀ < t)
    (hf : Continuous f) (hCf : ∀ s, ‖f s‖ ≤ C) (hm : LocalThreeQuarterHolderAt f t) :
    HasDerivWithinAt (heatHistoryFrom (fun s => canonicalLogBoundary k h (s/2)) f a₀)
      (regularizedHistoryRate (fun s => canonicalLogBoundary k h (s/2)) f a₀ t) (Ici t) t := by
  obtain ⟨a,ha,hat',hd⟩ := canonicalLocalHistory_hasDerivWithinAt_regularizedRate hk hh hhk (ha₀.trans hat) hf hCf hm
  rcases lt_trichotomy a₀ a with hlt | heq | hgt
  · have ho := canonicalOlderHistory_hasDerivAt hk hh hhk ha₀ hlt hat' hf hCf
    have he : (heatHistoryFrom (fun s => canonicalLogBoundary k h (s/2)) f a₀) =ᶠ[𝓝 t]
        (fun r => (∫ s in Ioo a₀ a, movingHeatHistoryKernel
          (fun u => canonicalLogBoundary k h (u/2)) r s*f s)+
          heatHistoryFrom (fun s => canonicalLogBoundary k h (s/2)) f a r) := by
      filter_upwards [Ioi_mem_nhds hat'] with r hr
      exact canonicalHeatHistoryFrom_split hk hh hhk ha₀ hlt hr hf hCf
    rw [canonicalRegularizedHistoryRate_split hk hh hhk ha₀ hlt hat' hf hm]
    exact (ho.hasDerivWithinAt.add hd).congr_of_eventuallyEq (nhdsWithin_le_nhds he) he.self_of_nhds
  · subst a
    exact hd
  · have ho := canonicalOlderHistory_hasDerivAt hk hh hhk ha hgt hat hf hCf
    have he : (heatHistoryFrom (fun s => canonicalLogBoundary k h (s/2)) f a₀) =ᶠ[𝓝 t]
        (fun r => heatHistoryFrom (fun s => canonicalLogBoundary k h (s/2)) f a r-
          (∫ s in Ioo a a₀, movingHeatHistoryKernel (fun u => canonicalLogBoundary k h (u/2)) r s*f s)) := by
      filter_upwards [Ioi_mem_nhds hat] with r hr
      have hs := canonicalHeatHistoryFrom_split hk hh hhk ha hgt hr hf hCf
      linarith
    have hrate := canonicalRegularizedHistoryRate_split hk hh hhk ha hgt hat hf hm
    have hd' := (hd.sub ho.hasDerivWithinAt).congr_of_eventuallyEq (nhdsWithin_le_nhds he) he.self_of_nhds
    convert! hd' using 1
    linarith

noncomputable def historyRightDerivative (b f : ℝ → ℝ) (a t : ℝ) : ℝ :=
  derivWithin (heatHistoryFrom b f a) (Ici t) t

theorem canonicalHistoryRightDerivative_eq_regularizedRate {k h a t C : ℝ} {f : ℝ → ℝ}
    (hk : 0 < k) (hh : 0 ≤ h) (hhk : h ≤ k) (ha : 0 < a) (hat : a < t)
    (hf : Continuous f) (hCf : ∀ s, ‖f s‖ ≤ C) (hm : LocalThreeQuarterHolderAt f t) :
    historyRightDerivative (fun s => canonicalLogBoundary k h (s/2)) f a t =
      regularizedHistoryRate (fun s => canonicalLogBoundary k h (s/2)) f a t :=
  (canonicalHistory_hasDerivWithinAt_regularizedRate hk hh hhk ha hat hf hCf hm).derivWithin
    (uniqueDiffWithinAt_Ici _)

theorem canonicalLocalHistoryRightDerivative_continuousAt {k h t C : ℝ} {f : ℝ → ℝ}
    (hk : 0 < k) (hh : 0 ≤ h) (hhk : h ≤ k) (ht : 0 < t)
    (hf : Continuous f) (hCf : ∀ s, ‖f s‖ ≤ C) (hm : LocalThreeQuarterHolderAt f t) :
    ∃ a : ℝ, 0 < a ∧ a < t ∧
      ContinuousAt (historyRightDerivative (fun s => canonicalLogBoundary k h (s/2)) f a) t := by
  obtain ⟨a,ha,hat,hc⟩ := canonicalRegularizedHistoryRate_continuousAt hk hh hhk ht hf hCf hm
  have he : historyRightDerivative (fun s => canonicalLogBoundary k h (s/2)) f a =ᶠ[𝓝 t]
      regularizedHistoryRate (fun s => canonicalLogBoundary k h (s/2)) f a := by
    filter_upwards [hm.eventually,Ioi_mem_nhds hat] with r hr hrt
    exact canonicalHistoryRightDerivative_eq_regularizedRate hk hh hhk ha hrt hf hCf hr
  exact ⟨a,ha,hat,hc.congr_of_eventuallyEq he⟩

end AmericanConvexity.Stopping
