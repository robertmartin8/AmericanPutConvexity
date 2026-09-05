import AmericanConvexity.Stopping.FullHistoryRightDerivative
import AmericanConvexity.Stopping.ActualDensityThreeQuarter

/-! # Right derivative of the constructed actual boundary density

The full original history now has a right derivative. The C1 forcing and
the same density equation transfer this to the density, with no assumed
density derivative or second graph derivative.
-/

namespace AmericanConvexity.Stopping

open Set Filter MeasureTheory
open scoped Topology ContDiff BoundedContinuousFunction

theorem canonicalHeatDensity_hasDerivWithinAt_right_of_C1_forcing
    {k h a T t C : ℝ} {f g : ℝ → ℝ}
    (hk : 0 < k) (hh : 0 ≤ h) (hhk : h ≤ k) (ha : 0 < a)
    (ht : t ∈ Ioo a T) (hf : Continuous f) (hC : 0 ≤ C) (hCf : ∀ s, ‖f s‖ ≤ C)
    (hg : ContDiffAt ℝ 1 g t)
    (heq : ∀ s ∈ Icc a T, f s = g s+
      heatHistory (fun u => canonicalLogBoundary k h (u/2)) (s-a) f s) :
    ∃ d : ℝ, HasDerivWithinAt f d (Ici t) t := by
  have hm := canonicalHeatDensity_threeQuarter_of_C1_forcing hk hh hhk ha ht hf hC hCf hg heq
  obtain ⟨d,hd⟩ := canonicalFullElapsedHistory_hasDerivWithinAt_right hk hh hhk ha ht.1 hf hCf hm
  have hgd := (hg.differentiableAt (by norm_num)).hasDerivAt
  have he : f =ᶠ[𝓝 t] (fun s => g s+heatHistory (fun u => canonicalLogBoundary k h (u/2)) (s-a) f s) := by
    filter_upwards [Ioo_mem_nhds ht.1 ht.2] with s hs
    exact heq s ⟨hs.1.le,hs.2.le⟩
  exact ⟨_,(hgd.hasDerivWithinAt.add hd).congr_of_eventuallyEq
    (nhdsWithin_le_nhds he) he.self_of_nhds⟩

theorem actualHeatSource_density_hasDerivWithinAt_right
    {k h D t : ℝ} {χ : ℝ × ℝ → ℝ}
    (hk : 0 < k) (hh : 0 ≤ h) (hhk : h ≤ k)
    (hD : 0 < D) (hDt : D < t) (hc : ContDiff ℝ ∞ χ) (hcomp : HasCompactSupport χ)
    (he : χ =ᶠ[𝓝 (canonicalLogBoundary k h t,2*t)] 1)
    (hs : ∀ z ∈ tsupport χ, 2*t-D/2 < z.2)
    (htrans : ∀ z ∈ tsupport (heatPartial χ (1,0)), z.1 ≠ canonicalLogBoundary k h (z.2/2))
    (f : CausalBoundaryData (2*t-D/2))
    (heq : ∀ s ∈ Icc (2*t-D/2) (2*t+D/2),
      f.1 s = 2*heatSourcePotentialSpatial (heatLocalizationSource χ (canonicalHeatTheta k h)) D
        (canonicalLogBoundary k h (s/2),s)+
        ∫ u in Ioo 0 (s-(2*t-D/2)), heatBoundaryKernel u
          (canonicalLogBoundary k h (s/2)-canonicalLogBoundary k h ((s-u)/2))*f.1 (s-u)) :
    ∃ d : ℝ, HasDerivWithinAt f.1 d (Ici (2*t)) (2*t) := by
  have ha : 0 < 2*t-D/2 := by linarith
  exact canonicalHeatDensity_hasDerivWithinAt_right_of_C1_forcing hk hh hhk ha
    (show 2*t ∈ Ioo (2*t-D/2) (2*t+D/2) by constructor <;> linarith)
    f.1.continuous (norm_nonneg f.1) f.1.norm_coe_le_norm
    (actualHeatSourceForcing_contDiffAt hk hh hhk ha.le hD (by linarith)
      hc hcomp he hs htrans (by linarith)) heq

end AmericanConvexity.Stopping
