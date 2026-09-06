import AmericanPutConvexity.Stopping.HeatSourceDerivative
import AmericanPutConvexity.Stopping.HeatHistoryOperator

/-! # A causal source potential with continuous spatial derivative

The fixed elapsed-time window is sufficient on the first causal window.
Neither the source nor the moving graph is differentiated. The spatial
derivative's uniform bound is integrable all the way to elapsed time zero.
This file does not yet assert the inhomogeneous heat PDE.
-/

namespace AmericanPutConvexity.Stopping

open Set Filter MeasureTheory
open MathFin.FeynmanKacHeatEquation
open scoped Topology

noncomputable def heatSourcePotential (Q : ℝ × ℝ → ℝ) (D : ℝ) (z : ℝ × ℝ) : ℝ :=
  ∫ u in Ioo 0 D, heatSourceAverage Q u z

noncomputable def heatSourcePotentialSpatial (Q : ℝ × ℝ → ℝ) (D : ℝ) (z : ℝ × ℝ) : ℝ :=
  ∫ u in Ioo 0 D, heatSourceSpatial Q u z

theorem heatSourceAverage_integrable_time {Q : ℝ × ℝ → ℝ} {C D : ℝ}
    (hQ : Continuous Q) (hC : ∀ z, ‖Q z‖ ≤ C) (z : ℝ × ℝ) :
    IntegrableOn (fun u => heatSourceAverage Q u z) (Ioo 0 D) := by
  apply (integrableOn_const (C := heatSourceAverageConstant*C) (s := Ioo 0 D)
    (hs := measure_Ioo_lt_top.ne)).mono'
    (((heatSourceAverage_continuous hQ hC).comp (continuous_id.prodMk continuous_const)).aestronglyMeasurable)
  exact Eventually.of_forall (fun u => heatSourceAverage_bound hC u z)

theorem heatSourceSpatial_integrable_time {Q : ℝ × ℝ → ℝ} {C D : ℝ}
    (hD : 0 < D) (hQ : Continuous Q) (hC : ∀ z, ‖Q z‖ ≤ C) (z : ℝ × ℝ) :
    IntegrableOn (fun u => heatSourceSpatial Q u z) (Ioo 0 D) := by
  have hc : ContinuousOn (fun u => heatSourceSpatial Q u z) (Ioo 0 D) := by
    intro u hu
    exact ((heatSourceSpatial_continuousAt hQ hC hu.1).comp
      (x := u) (f := fun v : ℝ => (v,z)) (by fun_prop)).continuousWithinAt
  apply ((integrableOn_inverse_sqrt hD).const_mul (heatSourceGradientConstant*C)).mono'
    (hc.aestronglyMeasurable measurableSet_Ioo)
  exact Eventually.of_forall (fun u => heatSourceSpatial_bound hC u z)

theorem heatSourcePotential_continuous {Q : ℝ × ℝ → ℝ} {C D : ℝ}
    (hQ : Continuous Q) (hC : ∀ z, ‖Q z‖ ≤ C) : Continuous (heatSourcePotential Q D) := by
  apply continuous_of_dominated (bound := fun _ => heatSourceAverageConstant*C)
  · intro z
    exact (heatSourceAverage_integrable_time hQ hC z).aestronglyMeasurable
  · intro z
    exact Eventually.of_forall (fun u => heatSourceAverage_bound hC u z)
  · exact integrableOn_const (hs := measure_Ioo_lt_top.ne)
  · exact Eventually.of_forall (fun u =>
      (heatSourceAverage_continuous hQ hC).comp (continuous_const.prodMk continuous_id))

theorem heatSourcePotentialSpatial_continuous {Q : ℝ × ℝ → ℝ} {C D : ℝ}
    (hD : 0 < D) (hQ : Continuous Q) (hC : ∀ z, ‖Q z‖ ≤ C) :
    Continuous (heatSourcePotentialSpatial Q D) := by
  apply continuous_of_dominated (bound := fun u => (heatSourceGradientConstant*C)*(Real.sqrt u)⁻¹)
  · intro z
    exact (heatSourceSpatial_integrable_time hD hQ hC z).aestronglyMeasurable
  · intro z
    exact Eventually.of_forall (fun u => heatSourceSpatial_bound hC u z)
  · exact (integrableOn_inverse_sqrt hD).const_mul _
  · filter_upwards [ae_restrict_mem measurableSet_Ioo] with u hu
    apply continuous_iff_continuousAt.mpr
    intro z
    exact (heatSourceSpatial_continuousAt hQ hC hu.1).comp
      (x := z) (f := fun z : ℝ × ℝ => (u,z)) (by fun_prop)

theorem heatSourcePotential_hasDerivAt {Q : ℝ × ℝ → ℝ} {C D : ℝ}
    (hD : 0 < D) (hQ : Continuous Q) (hc : HasCompactSupport Q)
    (hC : ∀ z, ‖Q z‖ ≤ C) (x s : ℝ) :
    HasDerivAt (fun y => heatSourcePotential Q D (y,s))
      (heatSourcePotentialSpatial Q D (x,s)) x := by
  apply (hasDerivAt_integral_of_dominated_loc_of_deriv_le
    (F := fun y u => heatSourceAverage Q u (y,s))
    (F' := fun y u => heatSourceSpatial Q u (y,s))
    (bound := fun u => (heatSourceGradientConstant*C)*(Real.sqrt u)⁻¹)
    (s := univ) (by simp)
    (Eventually.of_forall (fun y => (heatSourceAverage_integrable_time hQ hC (y,s)).aestronglyMeasurable))
    (heatSourceAverage_integrable_time hQ hC (x,s))
    ((heatSourceSpatial_integrable_time hD hQ hC (x,s)).aestronglyMeasurable)
    (Eventually.of_forall (fun u y _ => heatSourceSpatial_bound hC u (y,s)))
    ((integrableOn_inverse_sqrt hD).const_mul _) ?_).2
  filter_upwards [ae_restrict_mem measurableSet_Ioo] with u hu
  intro y _
  exact heatSourceAverage_hasDerivAt hQ hc hu.1 y s

theorem heatSourcePotentialSpatial_bound {Q : ℝ × ℝ → ℝ} {C D : ℝ}
    (hD : 0 < D) (hC : ∀ z, ‖Q z‖ ≤ C) (z : ℝ × ℝ) :
    ‖heatSourcePotentialSpatial Q D z‖ ≤ 2*heatSourceGradientConstant*C*Real.sqrt D := by
  calc
    _ ≤ ∫ u in Ioo 0 D, (heatSourceGradientConstant*C)*(Real.sqrt u)⁻¹ :=
      norm_integral_le_of_norm_le ((integrableOn_inverse_sqrt hD).const_mul _)
        (Eventually.of_forall (fun u => heatSourceSpatial_bound hC u z))
    _ = _ := by rw [integral_const_mul,integral_inverse_sqrt hD]; ring

theorem heatSourcePotential_bound {Q : ℝ × ℝ → ℝ} {C D : ℝ}
    (hC : ∀ z, ‖Q z‖ ≤ C) (z : ℝ × ℝ) :
    ‖heatSourcePotential Q D z‖ ≤ volume.real (Ioo 0 D)*(heatSourceAverageConstant*C) := by
  calc
    _ ≤ ∫ _ in Ioo 0 D, heatSourceAverageConstant*C :=
      norm_integral_le_of_norm_le (integrableOn_const (hs := measure_Ioo_lt_top.ne))
        (Eventually.of_forall (fun u => heatSourceAverage_bound hC u z))
    _ = _ := by rw [setIntegral_const,smul_eq_mul]

theorem heatSourcePotential_causal {Q : ℝ × ℝ → ℝ} {a D : ℝ}
    (hQ : ∀ z : ℝ × ℝ, z.2 ≤ a → Q z = 0) (z : ℝ × ℝ) (hz : z.2 ≤ a) :
    heatSourcePotential Q D z = 0 := by
  apply setIntegral_eq_zero_of_forall_eq_zero
  intro u hu
  exact heatSourceAverage_causal hQ hu.1.le z hz

theorem heatSourcePotentialSpatial_causal {Q : ℝ × ℝ → ℝ} {a D : ℝ}
    (hQ : ∀ z : ℝ × ℝ, z.2 ≤ a → Q z = 0) (z : ℝ × ℝ) (hz : z.2 ≤ a) :
    heatSourcePotentialSpatial Q D z = 0 := by
  apply setIntegral_eq_zero_of_forall_eq_zero
  intro u hu
  exact heatSourceSpatial_causal hQ hu.1.le z hz

/-- On the first causal window the fixed truncation includes the entire
past, and the rescaled definition is exactly the ordinary heat convolution. -/
theorem heatSourcePotential_eq_causal_integral {Q : ℝ × ℝ → ℝ} {a D : ℝ}
    (hQ : ∀ z : ℝ × ℝ, z.2 ≤ a → Q z = 0) (z : ℝ × ℝ) (hz : z.2 ≤ a+D) :
    heatSourcePotential Q D z =
      ∫ u in Ioo 0 (z.2-a), ∫ y, heatKernel u (y-z.1)*Q (y,z.2-u) := by
  have he : heatSourcePotential Q D z =
      ∫ u in Ioo 0 (z.2-a), heatSourceAverage Q u z := by
    apply setIntegral_eq_of_subset_of_forall_sdiff_eq_zero measurableSet_Ioo
      (show Ioo 0 (z.2-a) ⊆ Ioo 0 D from fun u hu => ⟨hu.1,by linarith [hu.2]⟩)
    intro u hu
    have hua : z.2-a ≤ u := by
      by_contra hn
      exact hu.2 ⟨hu.1.1,lt_of_not_ge hn⟩
    exact heatSourceAverage_zero_of_past hQ z (by linarith)
  rw [he]
  apply setIntegral_congr_fun measurableSet_Ioo
  intro u hu
  exact heatSourceAverage_eq_convolution hu.1 z

end AmericanPutConvexity.Stopping
