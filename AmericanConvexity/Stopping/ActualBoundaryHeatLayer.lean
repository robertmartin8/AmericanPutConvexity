import AmericanConvexity.Stopping.ActualBoundaryHeatJump
import AmericanConvexity.Stopping.HeatLayerPotential

/-! # Layer-potential flux on the actual boundary's local graph

The spatial argument of `movingHeatLayer` is displacement to the right of
the current exercise boundary. Elapsed heat time s corresponds to pricing
time t-s/2. These theorems establish both the interior flux trace and a
genuine one-sided derivative for every bounded continuous local density.
They do not assert that actual theta already has this layer representation.
-/

namespace AmericanConvexity.Stopping

open Set Filter MeasureTheory Boundary
open scoped Topology

theorem canonicalLogBoundary_heatLayer_flux {k h t : ℝ} (hk : 0 < k)
    (hh : 0 ≤ h) (hhk : h ≤ k) (ht : 0 < t) :
    ∃ T : ℝ, 0 < T ∧ T < t ∧ ∀ (g : ℝ → ℝ) (C : ℝ),
      Continuous g → (∀ s, ‖g s‖ ≤ C) → (∀ s, T ≤ s → g s = 0) →
      let d := fun s => canonicalLogBoundary k h t-canonicalLogBoundary k h (t-s/2)
      HasDerivWithinAt (movingHeatLayer d g T) (movingHeatLayerFlux d g T) (Ici 0) 0 ∧
        Tendsto (deriv (movingHeatLayer d g T)) (𝓝[>] (0 : ℝ)) (𝓝 (movingHeatLayerFlux d g T)) := by
  obtain ⟨T,L,hT,hTt,hL,hd,hmove⟩ := canonicalLogBoundary_heat_displacement hk hh hhk ht
  refine ⟨T,hT,hTt,?_⟩
  intro g C hg hC hs
  exact ⟨movingHeatLayer_hasDerivWithinAt_contact hT hL hd hmove hg hC hs,
    movingHeatLayer_deriv_tendsto hT hL hd hmove hg hC hs⟩

theorem zeroDividend_canonicalLogBoundary_heatLayer_flux {k t : ℝ}
    (hk : 0 < k) (ht : 0 < t) :
    ∃ T : ℝ, 0 < T ∧ T < t ∧ ∀ (g : ℝ → ℝ) (C : ℝ),
      Continuous g → (∀ s, ‖g s‖ ≤ C) → (∀ s, T ≤ s → g s = 0) →
      let d := fun s => canonicalLogBoundary k 0 t-canonicalLogBoundary k 0 (t-s/2)
      HasDerivWithinAt (movingHeatLayer d g T) (movingHeatLayerFlux d g T) (Ici 0) 0 ∧
        Tendsto (deriv (movingHeatLayer d g T)) (𝓝[>] (0 : ℝ)) (𝓝 (movingHeatLayerFlux d g T)) :=
  canonicalLogBoundary_heatLayer_flux hk le_rfl hk.le ht

theorem liuRange_canonicalLogBoundary_heatLayer_flux {k h t : ℝ}
    (hh : 0 ≤ h) (hliu : h+1 ≤ k) (ht : 0 < t) :
    ∃ T : ℝ, 0 < T ∧ T < t ∧ ∀ (g : ℝ → ℝ) (C : ℝ),
      Continuous g → (∀ s, ‖g s‖ ≤ C) → (∀ s, T ≤ s → g s = 0) →
      let d := fun s => canonicalLogBoundary k h t-canonicalLogBoundary k h (t-s/2)
      HasDerivWithinAt (movingHeatLayer d g T) (movingHeatLayerFlux d g T) (Ici 0) 0 ∧
        Tendsto (deriv (movingHeatLayer d g T)) (𝓝[>] (0 : ℝ)) (𝓝 (movingHeatLayerFlux d g T)) :=
  canonicalLogBoundary_heatLayer_flux (by linarith) hh (by linarith) ht

end AmericanConvexity.Stopping
