import AmericanConvexity.Stopping.SeparatedSourceCurve
import AmericanConvexity.Stopping.SeparatedSourceBridge

/-! # C1 boundary forcing from a separated continuous source

The fixed-window spatial source potential equals the differentiated source-time
integral before the causal cutoff. This gives C1 regularity along any C1 curve
disjoint from the source support, without differentiating the source itself.
-/

namespace AmericanConvexity.Stopping

open Set Filter
open scoped Topology ContDiff

theorem separated_heatSourcePotentialSpatial_eq_integral
    {Q : ℝ × ℝ → ℝ} {a D : ℝ}
    (hD : 0 < D) (hQ : Continuous Q) (hc : HasCompactSupport Q)
    (hcausal : ∀ w : ℝ × ℝ, w.2 ≤ a → Q w = 0)
    {x t : ℝ} (hz : (x,t) ∉ tsupport Q) (ht : t < a+D) :
    heatSourcePotentialSpatial Q D (x,t) =
      sourcePlaneIntegral (heatPartial causalHeatKernelPlane (0,1)) Q (x,t) := by
  obtain ⟨C,hC⟩ := hc.exists_bound_of_continuous hQ
  have hd := heatSourcePotential_hasDerivAt hD hQ hc hC x t
  have hi := sourcePlaneIntegral_hasDeriv_space
    (fun _ hv => causalHeatKernelPlane_smoothAt hv) hQ hc hz
  have he : (fun y => heatSourcePotential Q D (y,t)) =ᶠ[𝓝 x]
      (fun y => causalHeatSourceIntegral Q (y,t)) :=
    (show ContinuousAt (fun y : ℝ => (y,t)) x by fun_prop).preimage_mem_nhds
      (separated_heatSourcePotential_eventuallyEq hQ hc hcausal hz ht)
  exact hd.deriv.symm.trans (he.deriv_eq.trans hi.deriv)

theorem separated_heatSourceForcing_curve_contDiffOn_one
    {Q : ℝ × ℝ → ℝ} {a D : ℝ} {b v : ℝ → ℝ} {U : Set ℝ}
    (hD : 0 < D) (hQ : Continuous Q) (hc : HasCompactSupport Q)
    (hcausal : ∀ w : ℝ × ℝ, w.2 ≤ a → Q w = 0)
    (hU : IsOpen U) (hb : ∀ t ∈ U, HasDerivAt b (v t) t)
    (hv : ContinuousOn v U) (hsep : ∀ t ∈ U, (b t,t) ∉ tsupport Q)
    (htime : ∀ t ∈ U, t < a+D) :
    ContDiffOn ℝ 1 (fun t => 2*heatSourcePotentialSpatial Q D (b t,t)) U := by
  have hi := sourcePlaneIntegral_curve_contDiffOn_one
    (fun _ hz => heatPartial_smoothAt (causalHeatKernelPlane_smoothAt hz) (0,1))
    hQ hc hU hb hv hsep
  apply (contDiffOn_const.mul hi).congr
  intro t ht
  rw [separated_heatSourcePotentialSpatial_eq_integral hD hQ hc hcausal
    (hsep t ht) (htime t ht)]

end AmericanConvexity.Stopping
