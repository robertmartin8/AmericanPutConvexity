import AmericanPutConvexity.Stopping.SeparatedSourceForcing
import AmericanPutConvexity.Stopping.HeatSourceSeparation
import AmericanPutConvexity.Stopping.ActualHistoryTimeBounds
import Mathlib.Analysis.Calculus.ContDiff.RCLike

/-! # Actual boundary forcing is C1 near a constant cutoff

The actual heat-coordinate boundary is already C1. A cutoff constant near
contact separates its source from that contact, allowing source-kernel
differentiation along the graph. No C2 boundary hypothesis is introduced.
-/

namespace AmericanPutConvexity.Stopping

open Set Filter
open scoped Topology ContDiff NNReal

theorem canonicalHeatSourceForcing_contDiffAt_of_separated
    {k h a D s : ℝ} {Q : ℝ × ℝ → ℝ}
    (hk : 0 < k) (hh : 0 ≤ h) (hhk : h ≤ k)
    (hD : 0 < D) (hQ : Continuous Q) (hc : HasCompactSupport Q)
    (hcausal : ∀ z : ℝ × ℝ, z.2 ≤ a → Q z = 0)
    (hs : 0 < s) (hsep : (canonicalLogBoundary k h (s/2),s) ∉ tsupport Q)
    (hwindow : s < a+D) :
    ContDiffAt ℝ 1
      (fun u => 2*heatSourcePotentialSpatial Q D (canonicalLogBoundary k h (u/2),u)) s := by
  let b := fun u => canonicalLogBoundary k h (u/2)
  have hb : ContinuousAt (fun u => (b u,u)) s :=
    (canonicalHeatGraph_hasDerivAt hk hh hhk hs).continuousAt.prodMk continuousAt_id
  have he : ∀ᶠ u in 𝓝 s, 0 < u ∧ (b u,u) ∉ tsupport Q ∧ u < a+D := by
    filter_upwards [Ioi_mem_nhds hs,
      hb.preimage_mem_nhds ((isClosed_tsupport Q).isOpen_compl.mem_nhds hsep),
      Iio_mem_nhds hwindow] with u hu husep hut
    exact ⟨hu,husep,hut⟩
  obtain ⟨U,hUS,hU,hsU⟩ := mem_nhds_iff.mp he
  have hd (u : ℝ) (hu : u ∈ U) : HasDerivAt b (deriv b u) u :=
    (canonicalHeatGraph_hasDerivAt hk hh hhk (hUS hu).1).differentiableAt.hasDerivAt
  exact (separated_heatSourceForcing_curve_contDiffOn_one hD hQ hc hcausal hU hd
    (fun u hu => (canonicalHeatGraph_deriv_continuousAt hk hh hhk
      (hUS hu).1).continuousWithinAt)
    (fun _ hu => (hUS hu).2.1) (fun _ hu => (hUS hu).2.2)).contDiffAt (hU.mem_nhds hsU)

theorem actualHeatSourceForcing_contDiffAt
    {k h a D t : ℝ} {χ : ℝ × ℝ → ℝ}
    (hk : 0 < k) (hh : 0 ≤ h) (hhk : h ≤ k) (ha : 0 ≤ a)
    (hD : 0 < D) (ht : 0 < t) (hc : ContDiff ℝ ∞ χ) (hcomp : HasCompactSupport χ)
    (he : χ =ᶠ[𝓝 (canonicalLogBoundary k h t,2*t)] 1)
    (hs : ∀ z ∈ tsupport χ, a < z.2)
    (htrans : ∀ z ∈ tsupport (heatPartial χ (1,0)),
      z.1 ≠ canonicalLogBoundary k h (z.2/2)) (hwindow : 2*t < a+D) :
    ContDiffAt ℝ 1 (fun s => 2*heatSourcePotentialSpatial
      (heatLocalizationSource χ (canonicalHeatTheta k h)) D
      (canonicalLogBoundary k h (s/2),s)) (2*t) := by
  apply canonicalHeatSourceForcing_contDiffAt_of_separated hk hh hhk hD
    (actualHeatLocalizationSource_continuous hk hh hhk ha hc hs htrans)
    (heatLocalizationSource_hasCompactSupport hcomp _)
    (heatLocalizationSource_causal hs _) (by positivity) _ hwindow
  simpa only [mul_div_cancel_left₀ t (by norm_num : (2 : ℝ) ≠ 0)] using
    heatLocalizationSource_notMem_tsupport_of_constant he (canonicalHeatTheta k h)

theorem actualHeatSourceForcing_locallyLipschitz
    {k h a D t : ℝ} {χ : ℝ × ℝ → ℝ}
    (hk : 0 < k) (hh : 0 ≤ h) (hhk : h ≤ k) (ha : 0 ≤ a)
    (hD : 0 < D) (ht : 0 < t) (hc : ContDiff ℝ ∞ χ) (hcomp : HasCompactSupport χ)
    (he : χ =ᶠ[𝓝 (canonicalLogBoundary k h t,2*t)] 1)
    (hs : ∀ z ∈ tsupport χ, a < z.2)
    (htrans : ∀ z ∈ tsupport (heatPartial χ (1,0)),
      z.1 ≠ canonicalLogBoundary k h (z.2/2)) (hwindow : 2*t < a+D) :
    ∃ (L : ℝ≥0) (U : Set ℝ), U ∈ 𝓝 (2*t) ∧ LipschitzOnWith L
      (fun s => 2*heatSourcePotentialSpatial
        (heatLocalizationSource χ (canonicalHeatTheta k h)) D
        (canonicalLogBoundary k h (s/2),s)) U :=
  (actualHeatSourceForcing_contDiffAt hk hh hhk ha hD ht hc hcomp he hs htrans hwindow).exists_lipschitzOnWith

end AmericanPutConvexity.Stopping
