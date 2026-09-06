import AmericanPutConvexity.Stopping.ActualForcingRegularity
import AmericanPutConvexity.Stopping.ActualHistoryHolder

/-! # One-half Holder regularity of the actual local density

The density equation is used with its constructed C1 forcing. The history
estimate needs only bounded continuity of the density, so this first
regularity gain is not circular and does not differentiate the density.
-/

namespace AmericanPutConvexity.Stopping

open Set Filter MeasureTheory
open scoped Topology ContDiff NNReal BoundedContinuousFunction

theorem canonicalHeatDensity_holder_of_C1_forcing
    {k h a T t C : ℝ} {f g : ℝ → ℝ}
    (hk : 0 < k) (hh : 0 ≤ h) (hhk : h ≤ k) (ha : 0 < a)
    (ht : t ∈ Ioo a T) (hf : Continuous f) (hC : 0 ≤ C) (hCf : ∀ s, ‖f s‖ ≤ C)
    (hg : ContDiffAt ℝ 1 g t)
    (heq : ∀ s ∈ Icc a T, f s = g s+
      heatHistory (fun u => canonicalLogBoundary k h (u/2)) (s-a) f s) :
    ∃ (A : ℝ) (U : Set ℝ), 0 ≤ A ∧ U ∈ 𝓝 t ∧ ∀ s₁ ∈ U, ∀ s₂ ∈ U, s₁ < s₂ →
      ‖f s₂-f s₁‖ ≤ A*Real.sqrt (s₂-s₁) := by
  obtain ⟨L,hL,hH⟩ := exists_canonicalHeatHistory_holder_bound (T := T) hk hh hhk ha
  obtain ⟨M,V,hV,hgV⟩ := hg.exists_lipschitzOnWith
  let U := V ∩ Ioo a T ∩ Ioo (t-1/2) (t+1/2)
  have hU : U ∈ 𝓝 t := inter_mem (inter_mem hV (Ioo_mem_nhds ht.1 ht.2))
    (Ioo_mem_nhds (by linarith) (by linarith))
  refine ⟨(M : ℝ)+34*L*C/Real.sqrt (2*Real.pi),U,by positivity,hU,?_⟩
  intro s₁ hs₁ s₂ hs₂ hst
  have h₁ : s₁ ∈ Ioo a T := hs₁.1.2
  have h₂ : s₂ ∈ Ioo a T := hs₂.1.2
  have hsmall : s₂-s₁ ≤ 1 := by linarith [hs₁.2.1,hs₂.2.2]
  have hdelta : s₂-s₁ ≤ Real.sqrt (s₂-s₁) := Real.le_sqrt_self_iff.mpr hsmall
  have hgBound : ‖g s₂-g s₁‖ ≤ (M : ℝ)*(s₂-s₁) := by
    simpa only [dist_eq_norm,Real.norm_of_nonneg (sub_nonneg.mpr hst.le)] using
      hgV.dist_le_mul s₂ hs₂.1.1 s₁ hs₁.1.1
  have hhistory := hH s₁ s₂ h₁.1 hst h₂.2.le f C hf hC hCf
  rw [heq s₂ ⟨h₂.1.le,h₂.2.le⟩,heq s₁ ⟨h₁.1.le,h₁.2.le⟩,
    show g s₂+heatHistory (fun u => canonicalLogBoundary k h (u/2)) (s₂-a) f s₂-
      (g s₁+heatHistory (fun u => canonicalLogBoundary k h (u/2)) (s₁-a) f s₁) =
      (g s₂-g s₁)+(heatHistory (fun u => canonicalLogBoundary k h (u/2)) (s₂-a) f s₂-
        heatHistory (fun u => canonicalLogBoundary k h (u/2)) (s₁-a) f s₁) by ring]
  calc
    _ ≤ ‖g s₂-g s₁‖+‖heatHistory (fun u => canonicalLogBoundary k h (u/2)) (s₂-a) f s₂-
        heatHistory (fun u => canonicalLogBoundary k h (u/2)) (s₁-a) f s₁‖ := norm_add_le _ _
    _ ≤ (M : ℝ)*Real.sqrt (s₂-s₁)+
        (34*L*C/Real.sqrt (2*Real.pi))*Real.sqrt (s₂-s₁) :=
      add_le_add (hgBound.trans (mul_le_mul_of_nonneg_left hdelta M.coe_nonneg)) hhistory
    _ = _ := by ring

theorem actualHeatSource_density_holder
    {k h D t : ℝ} {χ : ℝ × ℝ → ℝ}
    (hk : 0 < k) (hh : 0 ≤ h) (hhk : h ≤ k)
    (hD : 0 < D) (hDt : D < t) (hc : ContDiff ℝ ∞ χ) (hcomp : HasCompactSupport χ)
    (he : χ =ᶠ[𝓝 (canonicalLogBoundary k h t,2*t)] 1)
    (hs : ∀ z ∈ tsupport χ, 2*t-D/2 < z.2)
    (htrans : ∀ z ∈ tsupport (heatPartial χ (1,0)),
      z.1 ≠ canonicalLogBoundary k h (z.2/2))
    (f : CausalBoundaryData (2*t-D/2))
    (heq : ∀ s ∈ Icc (2*t-D/2) (2*t+D/2),
      f.1 s = 2*heatSourcePotentialSpatial (heatLocalizationSource χ (canonicalHeatTheta k h)) D
        (canonicalLogBoundary k h (s/2),s)+
        ∫ u in Ioo 0 (s-(2*t-D/2)),
          heatBoundaryKernel u (canonicalLogBoundary k h (s/2)-
            canonicalLogBoundary k h ((s-u)/2))*f.1 (s-u)) :
    ∃ (A : ℝ) (U : Set ℝ), 0 ≤ A ∧ U ∈ 𝓝 (2*t) ∧ ∀ s₁ ∈ U, ∀ s₂ ∈ U, s₁ < s₂ →
      ‖f.1 s₂-f.1 s₁‖ ≤ A*Real.sqrt (s₂-s₁) := by
  have ha : 0 < 2*t-D/2 := by linarith
  exact canonicalHeatDensity_holder_of_C1_forcing hk hh hhk ha
    (show 2*t ∈ Ioo (2*t-D/2) (2*t+D/2) by constructor <;> linarith)
    f.1.continuous (norm_nonneg f.1) f.1.norm_coe_le_norm
    (actualHeatSourceForcing_contDiffAt hk hh hhk ha.le hD (by linarith)
      hc hcomp he hs htrans (by linarith)) heq

end AmericanPutConvexity.Stopping
