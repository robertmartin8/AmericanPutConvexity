import AmericanPutConvexity.Stopping.HeatHistoryTimeMajorant

/-! # Integrable history integrals in original source time

Reflection between source and elapsed time and interval splitting are
justified with genuine integrability, not the default value of a divergent
Bochner integral. A C1 graph is not needed for these preliminary steps.
-/

namespace AmericanPutConvexity.Stopping

open Set Filter MeasureTheory
open scoped Topology

theorem setIntegral_Ioo_reflect (F : ℝ → ℝ) {a b : ℝ} (hab : a ≤ b) (c : ℝ) :
    (∫ s in Ioo a b, F s) = ∫ u in Ioo (c-b) (c-a), F (c-u) := by
  have he := intervalIntegral.integral_comp_sub_left (a := c-b) (b := c-a) F c
  rw [sub_sub_cancel,sub_sub_cancel,intervalIntegral.integral_of_le (sub_le_sub_left hab c),
    intervalIntegral.integral_of_le hab,integral_Ioc_eq_integral_Ioo,integral_Ioc_eq_integral_Ioo] at he
  exact he.symm

theorem integrableOn_Ioo_reflect_iff (F : ℝ → ℝ) {a b : ℝ} (hab : a ≤ b) (c : ℝ) :
    IntegrableOn F (Ioo a b) ↔ IntegrableOn (fun u => F (c-u)) (Ioo (c-b) (c-a)) := by
  rw [← intervalIntegrable_iff_integrableOn_Ioo_of_le hab,
    ← intervalIntegrable_iff_integrableOn_Ioo_of_le (sub_le_sub_left hab c)]
  constructor
  · intro hi
    exact (hi.comp_sub_left c).symm
  · intro hi
    simpa only [sub_sub_cancel] using hi.symm.comp_sub_left c

theorem setIntegral_Ioo_split {F : ℝ → ℝ} {a b c : ℝ} (hab : a ≤ b) (hbc : b ≤ c)
    (hi₁ : IntegrableOn F (Ioo a b)) (hi₂ : IntegrableOn F (Ioo b c)) :
    (∫ s in Ioo a c, F s) = (∫ s in Ioo a b, F s)+(∫ s in Ioo b c, F s) := by
  have he := intervalIntegral.integral_add_adjacent_intervals
    ((intervalIntegrable_iff_integrableOn_Ioo_of_le hab).mpr hi₁)
    ((intervalIntegrable_iff_integrableOn_Ioo_of_le hbc).mpr hi₂)
  simpa only [intervalIntegral.integral_of_le hab,intervalIntegral.integral_of_le hbc,
    intervalIntegral.integral_of_le (hab.trans hbc),integral_Ioc_eq_integral_Ioo] using he.symm

theorem movingHeatHistoryKernel_elapsed_bound {b f : ℝ → ℝ} {r t u L C : ℝ}
    (htr : t ≤ r) (hu : 0 < u) (hL : 0 ≤ L)
    (hmove : ‖b r-b (t-u)‖ ≤ L*(r-(t-u))) (hf : ‖f (t-u)‖ ≤ C) :
    ‖movingHeatHistoryKernel b r (t-u)*f (t-u)‖ ≤
      (3*L*C/Real.sqrt (2*Real.pi))*(Real.sqrt u)⁻¹ := by
  have hpos : 0 < r-(t-u) := by linarith
  have hk : ‖movingHeatHistoryKernel b r (t-u)‖ ≤ 3*L/Real.sqrt (2*Real.pi*u) := by
    apply (heatBoundaryKernel_motion_bound hpos hmove).trans
    apply div_le_div_of_nonneg_left (by positivity) (by positivity)
    exact Real.sqrt_le_sqrt (mul_le_mul_of_nonneg_left (by linarith) (by positivity))
  rw [norm_mul]
  calc
    _ ≤ (3*L/Real.sqrt (2*Real.pi*u))*C := mul_le_mul hk hf (norm_nonneg _) (by positivity)
    _ = _ := by rw [Real.sqrt_mul (by positivity : 0 ≤ 2*Real.pi)]; ring

theorem movingHeatHistoryKernel_elapsed_integrable {b f : ℝ → ℝ} {r t D L C : ℝ}
    (hD : 0 < D) (htr : t ≤ r) (hL : 0 ≤ L) (hb : Continuous b) (hf : Continuous f)
    (hmove : ∀ u ∈ Ioo 0 D, ‖b r-b (t-u)‖ ≤ L*(r-(t-u)))
    (hC : ∀ s, ‖f s‖ ≤ C) :
    IntegrableOn (fun u => movingHeatHistoryKernel b r (t-u)*f (t-u)) (Ioo 0 D) := by
  have hc : ContinuousOn (fun u => movingHeatHistoryKernel b r (t-u)*f (t-u)) (Ioo 0 D) := by
    intro u hu
    have hpos : 0 < r-(t-u) := by linarith [hu.1]
    exact (((heatBoundaryKernel_smoothAt (x := b r-b (t-u)) hpos).continuousAt.comp
      (x := u) (f := fun u : ℝ => (r-(t-u),b r-b (t-u))) (by fun_prop)).mul
      (hf.continuousAt.comp (show ContinuousAt (fun u : ℝ => t-u) u by fun_prop))).continuousWithinAt
  apply ((integrableOn_inverse_sqrt hD).const_mul (3*L*C/Real.sqrt (2*Real.pi))).mono'
    (hc.aestronglyMeasurable measurableSet_Ioo)
  filter_upwards [ae_restrict_mem measurableSet_Ioo] with u hu
  exact movingHeatHistoryKernel_elapsed_bound htr hu.1 hL (hmove u hu) (hC (t-u))

theorem movingHeatHistoryKernel_source_integrable {b f : ℝ → ℝ} {a t r L C : ℝ}
    (hat : a < t) (htr : t ≤ r) (hL : 0 ≤ L) (hb : Continuous b) (hf : Continuous f)
    (hmove : ∀ s ∈ Ioo a t, ‖b r-b s‖ ≤ L*(r-s)) (hC : ∀ s, ‖f s‖ ≤ C) :
    IntegrableOn (fun s => movingHeatHistoryKernel b r s*f s) (Ioo a t) := by
  rw [integrableOn_Ioo_reflect_iff _ hat.le t,sub_self]
  apply movingHeatHistoryKernel_elapsed_integrable (sub_pos.mpr hat) htr hL hb hf ?_ hC
  intro u hu
  exact hmove (t-u) ⟨by linarith [hu.2],by linarith [hu.1]⟩

theorem movingHeatHistoryKernel_recent_bound {b f : ℝ → ℝ} {t D L C : ℝ}
    (hD : 0 < D) (hL : 0 ≤ L)
    (hmove : ∀ u ∈ Ioo 0 D, ‖b t-b (t-u)‖ ≤ L*u) (hC : ∀ s, ‖f s‖ ≤ C) :
    ‖∫ u in Ioo 0 D, movingHeatHistoryKernel b t (t-u)*f (t-u)‖ ≤
      (6*L*C/Real.sqrt (2*Real.pi))*Real.sqrt D := by
  calc
    _ ≤ ∫ u in Ioo 0 D, (3*L*C/Real.sqrt (2*Real.pi))*(Real.sqrt u)⁻¹ := by
      apply norm_integral_le_of_norm_le ((integrableOn_inverse_sqrt hD).const_mul _)
      filter_upwards [ae_restrict_mem measurableSet_Ioo] with u hu
      apply movingHeatHistoryKernel_elapsed_bound le_rfl hu.1 hL _ (hC _)
      simpa only [sub_sub_cancel] using hmove u hu
    _ = _ := by rw [integral_const_mul,integral_inverse_sqrt hD]; ring

noncomputable def heatHistoryFrom (b f : ℝ → ℝ) (a t : ℝ) : ℝ :=
  ∫ s in Ioo a t, movingHeatHistoryKernel b t s*f s

theorem heatHistoryFrom_eq_elapsed (b f : ℝ → ℝ) {a t : ℝ} (hat : a ≤ t) :
    heatHistoryFrom b f a t = heatHistory b (t-a) f t := by
  rw [heatHistoryFrom,setIntegral_Ioo_reflect _ hat t,sub_self]
  simp only [movingHeatHistoryKernel,sub_sub_cancel,heatHistory]

end AmericanPutConvexity.Stopping
