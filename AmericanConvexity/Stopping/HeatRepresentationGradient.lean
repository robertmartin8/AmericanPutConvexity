import AmericanConvexity.Stopping.HeatLayerGradientExtension
import AmericanConvexity.Stopping.HeatRepresentationIdentification

/-! # The represented solution's jointly continuous right gradient

The source potential has a globally continuous spatial derivative. Combining
it with the right-gradient extension of the layer gives a joint extension
for the candidate F-V/2, with the density as its boundary value.
-/

namespace AmericanConvexity.Stopping

open Set Filter MeasureTheory Boundary
open scoped Topology

noncomputable def heatRepresentationRightGradient (Q : ℝ × ℝ → ℝ)
    (b f : ℝ → ℝ) (D : ℝ) (z : ℝ × ℝ) : ℝ :=
  heatSourcePotentialSpatial Q D z-(1/2)*causalMovingHeatLayerRightGradient b f D z

theorem heatRepresentationRightGradient_continuousOn {Q : ℝ × ℝ → ℝ}
    {b f : ℝ → ℝ} {D L Cq Cf : ℝ} {S : Set ℝ} (hD : 0 < D) (hL : 0 ≤ L)
    (hQ : Continuous Q) (hCq : ∀ z, ‖Q z‖ ≤ Cq)
    (hb : Continuous b) (hf : Continuous f) (hCf : ∀ t, ‖f t‖ ≤ Cf)
    (hmove : ∀ t ∈ S, ∀ u ∈ Ioo 0 D, ‖b t-b (t-u)‖ ≤ L*u) :
    ContinuousOn (heatRepresentationRightGradient Q b f D) {z | z.2 ∈ S} :=
  (heatSourcePotentialSpatial_continuous hD hQ hCq).continuousOn.sub
    (continuousOn_const.mul (causalMovingHeatLayerRightGradient_continuousOn hD hL hb hf hCf hmove))

theorem heatRepresentationCandidate_hasDerivAt_rightGradient {Q : ℝ × ℝ → ℝ}
    {b f : ℝ → ℝ} {a D L Cq Cf x t : ℝ} (hD : 0 < D) (hL : 0 ≤ L)
    (hQ : Continuous Q) (hc : HasCompactSupport Q) (hCq : ∀ z, ‖Q z‖ ≤ Cq)
    (hb : Continuous b) (hf : Continuous f) (hCf : ∀ s, ‖f s‖ ≤ Cf)
    (hfa : ∀ s, s ≤ a → f s = 0) (ht : t ≤ a+D) (hx : b t < x)
    (hmove : ∀ u ∈ Ioo 0 D, ‖b t-b (t-u)‖ ≤ L*u) :
    HasDerivAt (fun y => heatRepresentationCandidate Q b f D (y,t))
      (heatRepresentationRightGradient Q b f D (x,t)) x := by
  exact (heatSourcePotential_hasDerivAt hD hQ hc hCq x t).sub
    ((causalMovingHeatLayer_hasDerivAt_normalExtension hD hL hb hf hCf hfa ht hx hmove).const_mul (1/2))

theorem heatRepresentationRightGradient_boundary {Q : ℝ × ℝ → ℝ}
    {b f : ℝ → ℝ} {D t : ℝ}
    (heq : f t = 2*heatSourcePotentialSpatial Q D (b t,t)+heatHistory b D f t) :
    heatRepresentationRightGradient Q b f D (b t,t) = f t := by
  rw [heatRepresentationRightGradient,causalMovingHeatLayerRightGradient_boundary]
  linarith

/-- Identification on the closed continuation strip transfers the genuine
interior derivative; equality is used on a spatial neighborhood of x. -/
theorem heatRepresentation_transfer_interior_gradient {Q W : ℝ × ℝ → ℝ}
    {b f : ℝ → ℝ} {a D T x t Cq Cf L : ℝ} (hD : 0 < D) (hL : 0 ≤ L)
    (hQ : Continuous Q) (hc : HasCompactSupport Q) (hCq : ∀ z, ‖Q z‖ ≤ Cq)
    (hb : Continuous b) (hf : Continuous f) (hCf : ∀ s, ‖f s‖ ≤ Cf)
    (hfa : ∀ s, s ≤ a → f s = 0) (hta : a ≤ t) (htT : t ≤ T)
    (htD : t ≤ a+D) (hx : b t < x)
    (hmove : ∀ u ∈ Ioo 0 D, ‖b t-b (t-u)‖ ≤ L*u)
    (hident : ∀ z ∈ movingHalfStrip b a T, heatRepresentationCandidate Q b f D z = W z) :
    HasDerivAt (fun y => W (y,t)) (heatRepresentationRightGradient Q b f D (x,t)) x := by
  apply (heatRepresentationCandidate_hasDerivAt_rightGradient hD hL hQ hc hCq hb hf hCf hfa htD hx hmove).congr_of_eventuallyEq
  filter_upwards [Ioi_mem_nhds hx] with y hy
  exact (hident (y,t) ⟨hta,htT,hy.le⟩).symm

end AmericanConvexity.Stopping
