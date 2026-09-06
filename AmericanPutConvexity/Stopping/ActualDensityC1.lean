import AmericanPutConvexity.Stopping.FullHistoryRateContinuity
import AmericanPutConvexity.Stopping.ActualDensityRightDerivative
import AmericanPutConvexity.Stopping.ContinuousRightDerivative

/-! # Ordinary C1 regularity of the actual boundary density

The regularized history rate is continuous for a fixed causal start. Adding
the C1 forcing gives a continuous right derivative of the density, which is
therefore its ordinary derivative. No second boundary derivative is assumed.
-/

namespace AmericanPutConvexity.Stopping

open Set Filter MeasureTheory
open scoped Topology ContDiff BoundedContinuousFunction

theorem canonicalHeatDensity_contDiffAt_one_of_C1_forcing
    {k h a T t C : ℝ} {f g : ℝ → ℝ}
    (hk : 0 < k) (hh : 0 ≤ h) (hhk : h ≤ k) (ha : 0 < a)
    (ht : t ∈ Ioo a T) (hf : Continuous f) (hC : 0 ≤ C) (hCf : ∀ s, ‖f s‖ ≤ C)
    (hg : ContDiffAt ℝ 1 g t)
    (heq : ∀ s ∈ Icc a T, f s = g s+
      heatHistory (fun u => canonicalLogBoundary k h (u/2)) (s-a) f s) :
    ContDiffAt ℝ 1 f t := by
  have hm := canonicalHeatDensity_threeQuarter_of_C1_forcing hk hh hhk ha ht hf hC hCf hg heq
  have hnear : ∀ᶠ r in 𝓝 t, r ∈ Ioo a T ∧ ContDiffAt ℝ 1 g r ∧ LocalThreeQuarterHolderAt f r := by
    filter_upwards [Ioo_mem_nhds ht.1 ht.2,hg.eventually (by norm_num),hm.eventually] with r hr hgr hmr
    exact ⟨hr,hgr,hmr⟩
  obtain ⟨U,hsub,hU,htU⟩ := mem_nhds_iff.mp hnear
  have hgU : ContDiffOn ℝ 1 g U := fun r hr => (hsub hr).2.1.contDiffWithinAt
  have hrate : ContinuousOn (regularizedHistoryRate (fun s => canonicalLogBoundary k h (s/2)) f a) U := by
    intro r hr
    exact (canonicalRegularizedHistoryRate_continuousAt_all_starts hk hh hhk ha
      (hsub hr).1.1 hf hCf (hsub hr).2.2).continuousWithinAt
  have hd : ∀ r ∈ U, HasDerivWithinAt f
      (deriv g r+regularizedHistoryRate (fun s => canonicalLogBoundary k h (s/2)) f a r) (Ici r) r := by
    intro r hr
    have hgr := ((hsub hr).2.1.differentiableAt (by norm_num)).hasDerivAt
    have hhr := canonicalHistory_hasDerivWithinAt_regularizedRate hk hh hhk ha
      (hsub hr).1.1 hf hCf (hsub hr).2.2
    have he : f =ᶠ[𝓝 r] (fun s => g s+heatHistoryFrom
        (fun u => canonicalLogBoundary k h (u/2)) f a s) := by
      filter_upwards [Ioo_mem_nhds (hsub hr).1.1 (hsub hr).1.2] with s hs
      rw [heatHistoryFrom_eq_elapsed _ _ hs.1.le]
      exact heq s ⟨hs.1.le,hs.2.le⟩
    exact (hgr.hasDerivWithinAt.add hhr).congr_of_eventuallyEq
      (nhdsWithin_le_nhds he) he.self_of_nhds
  exact (contDiffOn_one_of_continuous_right_derivative hU hf.continuousOn
    ((hgU.continuousOn_deriv_of_isOpen hU le_rfl).add hrate) hd).contDiffAt (hU.mem_nhds htU)

theorem actualHeatSource_density_contDiffAt_one
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
    ContDiffAt ℝ 1 f.1 (2*t) := by
  have ha : 0 < 2*t-D/2 := by linarith
  exact canonicalHeatDensity_contDiffAt_one_of_C1_forcing hk hh hhk ha
    (show 2*t ∈ Ioo (2*t-D/2) (2*t+D/2) by constructor <;> linarith)
    f.1.continuous (norm_nonneg f.1) f.1.norm_coe_le_norm
    (actualHeatSourceForcing_contDiffAt hk hh hhk ha.le hD (by linarith)
      hc hcomp he hs htrans (by linarith)) heq

end AmericanPutConvexity.Stopping
