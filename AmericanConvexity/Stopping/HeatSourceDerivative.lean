import AmericanConvexity.Stopping.HeatSourceMoments
import AmericanConvexity.Stopping.CompactKernelDerivative

/-! # Differentiating a source's Gaussian average

Only the heat kernel is differentiated; the space-time source is merely
continuous and compactly supported. The rescaled expression retains the
uniform inverse-square-root derivative bound from HeatSourceMoments.
-/

namespace AmericanConvexity.Stopping

open Set Filter MeasureTheory
open MathFin.FeynmanKacHeatEquation
open scoped Topology

theorem hasCompactSupport_space_slice {Q : ℝ × ℝ → ℝ}
    (hQ : HasCompactSupport Q) (s : ℝ) : HasCompactSupport (fun y => Q (y,s)) := by
  apply (hQ.image continuous_fst).of_isClosed_subset (isClosed_tsupport _)
  apply closure_minimal _ (hQ.image continuous_fst).isClosed
  intro y hy
  exact ⟨(y,s),subset_tsupport Q hy,rfl⟩

theorem compact_heat_convolution_hasDeriv {f : ℝ → ℝ} {u : ℝ}
    (hf : Continuous f) (hc : HasCompactSupport f) (hu : 0 < u) (x : ℝ) :
    HasDerivAt (fun x => ∫ y, heatKernel u (y-x)*f y)
      (∫ y, heatBoundaryKernel u (y-x)*f y) x := by
  apply compact_kernelIntegral_hasDeriv hf hc isOpen_univ
    (F := fun x y => heatKernel u (y-x)) (F' := fun x y => heatBoundaryKernel u (y-x))
  · exact (show Continuous (fun z : ℝ × ℝ => heatKernel u (z.2-z.1)) by
      apply continuous_iff_continuousAt.mpr
      intro z
      exact (heatKernel_smoothAt (x := z.2-z.1) hu).continuousAt.comp
        (x := z) (f := fun z : ℝ × ℝ => (u,z.2-z.1)) (by fun_prop)).continuousOn
  · exact (show Continuous (fun z : ℝ × ℝ => heatBoundaryKernel u (z.2-z.1)) by
      apply continuous_iff_continuousAt.mpr
      intro z
      exact (heatBoundaryKernel_smoothAt (x := z.2-z.1) hu).continuousAt.comp
        (x := z) (f := fun z : ℝ × ℝ => (u,z.2-z.1)) (by fun_prop)).continuousOn
  · intro v _ y
    convert! (heatKernel_hasDeriv_space hu (y-v)).comp v
      ((hasDerivAt_const v y).sub (hasDerivAt_id v)) using 1
    unfold heatBoundaryKernel
    ring
  · exact mem_univ _

theorem heatSourceAverage_eq_convolution {Q : ℝ × ℝ → ℝ} {u : ℝ}
    (hu : 0 < u) (z : ℝ × ℝ) :
    heatSourceAverage Q u z = ∫ y, heatKernel u (y-z.1)*Q (y,z.2-u) :=
  (heatKernel_integral_rescale hu (fun y => Q (y,z.2-u)) z.1).symm

theorem heatSourceSpatial_eq_convolution {Q : ℝ × ℝ → ℝ} {u : ℝ}
    (hu : 0 < u) (z : ℝ × ℝ) :
    heatSourceSpatial Q u z = ∫ y, heatBoundaryKernel u (y-z.1)*Q (y,z.2-u) :=
  (heatBoundaryKernel_integral_rescale hu (fun y => Q (y,z.2-u)) z.1).symm

theorem heatSourceAverage_hasDerivAt {Q : ℝ × ℝ → ℝ} {u : ℝ}
    (hQ : Continuous Q) (hc : HasCompactSupport Q) (hu : 0 < u) (x s : ℝ) :
    HasDerivAt (fun y => heatSourceAverage Q u (y,s)) (heatSourceSpatial Q u (x,s)) x := by
  have hd := compact_heat_convolution_hasDeriv
    (hQ.comp (continuous_id.prodMk continuous_const)) (hasCompactSupport_space_slice hc (s-u)) hu x
  have he : (fun y => heatSourceAverage Q u (y,s)) =
      (fun y => ∫ v, heatKernel u (v-y)*Q (v,s-u)) :=
    funext (fun y => heatSourceAverage_eq_convolution hu (y,s))
  rw [he,heatSourceSpatial_eq_convolution hu]
  exact hd

noncomputable def heatSourceAverageConstant : ℝ := ∫ y, ‖heatKernel 1 y‖

theorem heatSourceAverage_bound {Q : ℝ × ℝ → ℝ} {C : ℝ}
    (hC : ∀ z, ‖Q z‖ ≤ C) (u : ℝ) (z : ℝ × ℝ) :
    ‖heatSourceAverage Q u z‖ ≤ heatSourceAverageConstant*C :=
  heatSourceMoment_bound (integrable_heatKernel (by norm_num)) hC u z

theorem heatSourceAverage_zero_of_past {Q : ℝ × ℝ → ℝ} {a u : ℝ}
    (hQ : ∀ z : ℝ × ℝ, z.2 ≤ a → Q z = 0)
    (z : ℝ × ℝ) (hz : z.2-u ≤ a) : heatSourceAverage Q u z = 0 := by
  unfold heatSourceAverage heatSourceMoment
  apply integral_eq_zero_of_ae
  exact Eventually.of_forall (fun y => by dsimp only; rw [hQ _ hz,mul_zero]; rfl)

theorem heatSourceAverage_causal {Q : ℝ × ℝ → ℝ} {a u : ℝ}
    (hQ : ∀ z : ℝ × ℝ, z.2 ≤ a → Q z = 0) (hu : 0 ≤ u)
    (z : ℝ × ℝ) (hz : z.2 ≤ a) : heatSourceAverage Q u z = 0 :=
  heatSourceAverage_zero_of_past hQ z (by linarith)

theorem heatSourceSpatial_causal {Q : ℝ × ℝ → ℝ} {a u : ℝ}
    (hQ : ∀ z : ℝ × ℝ, z.2 ≤ a → Q z = 0) (hu : 0 ≤ u)
    (z : ℝ × ℝ) (hz : z.2 ≤ a) : heatSourceSpatial Q u z = 0 := by
  unfold heatSourceSpatial heatSourceMoment
  have hi : (∫ y, heatBoundaryKernel 1 y*Q (z.1+Real.sqrt u*y,z.2-u)) = 0 := by
    apply integral_eq_zero_of_ae
    exact Eventually.of_forall (fun y => by dsimp only; rw [hQ _ (by dsimp; linarith),mul_zero]; rfl)
  rw [hi,mul_zero]

end AmericanConvexity.Stopping
