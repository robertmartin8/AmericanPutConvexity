import AmericanConvexity.Stopping.HeatHistorySourceTime

/-! # The frozen straight-line reference integral

With slope and density value fixed, changing observation time changes only
the upper elapsed-time limit. Its difference is Lipschitz away from the
initial source time. Every split is justified by genuine integrability.
-/

namespace AmericanConvexity.Stopping

open Set Filter MeasureTheory

noncomputable def linearHeatHistoryIntegral (v c T : ℝ) : ℝ :=
  ∫ u in Ioo 0 T, heatBoundaryKernel u (v*u)*c

theorem linearHeatHistory_integrand_bound {u v c L C : ℝ}
    (hu : 0 < u) (hL : 0 ≤ L) (hv : ‖v‖ ≤ L) (hc : ‖c‖ ≤ C) :
    ‖heatBoundaryKernel u (v*u)*c‖ ≤ (3*L*C/Real.sqrt (2*Real.pi))*(Real.sqrt u)⁻¹ := by
  have hm : ‖v*u‖ ≤ L*u := by
    rw [norm_mul,Real.norm_of_nonneg hu.le]
    exact mul_le_mul_of_nonneg_right hv hu.le
  rw [norm_mul]
  calc
    _ ≤ (3*L/Real.sqrt (2*Real.pi*u))*C :=
      mul_le_mul (heatBoundaryKernel_motion_bound hu hm) hc (norm_nonneg _) (by positivity)
    _ = _ := by rw [Real.sqrt_mul (by positivity : 0 ≤ 2*Real.pi)]; ring

theorem linearHeatHistory_integrable {T : ℝ} (hT : 0 < T) (v c : ℝ) :
    IntegrableOn (fun u => heatBoundaryKernel u (v*u)*c) (Ioo 0 T) := by
  have hcont : ContinuousOn (fun u => heatBoundaryKernel u (v*u)*c) (Ioo 0 T) := by
    intro u hu
    exact (((heatBoundaryKernel_smoothAt hu.1).continuousAt.comp
      (x := u) (f := fun z : ℝ => (z,v*z)) (by fun_prop)).mul continuousAt_const).continuousWithinAt
  apply ((integrableOn_inverse_sqrt hT).const_mul (3*‖v‖*‖c‖/Real.sqrt (2*Real.pi))).mono'
    (hcont.aestronglyMeasurable measurableSet_Ioo)
  filter_upwards [ae_restrict_mem measurableSet_Ioo] with u hu
  exact linearHeatHistory_integrand_bound hu.1 (norm_nonneg _) le_rfl le_rfl

theorem linearHeatHistory_time_sub_bound {T₁ T₂ v c L C : ℝ}
    (hT₁ : 0 < T₁) (hTT : T₁ ≤ T₂) (hL : 0 ≤ L) (hC : 0 ≤ C)
    (hv : ‖v‖ ≤ L) (hc : ‖c‖ ≤ C) :
    ‖linearHeatHistoryIntegral v c T₂-linearHeatHistoryIntegral v c T₁‖ ≤
      (3*L*C/(Real.sqrt (2*Real.pi)*Real.sqrt T₁))*(T₂-T₁) := by
  have hi₁ := linearHeatHistory_integrable hT₁ v c
  have hi₂ := linearHeatHistory_integrable (hT₁.trans_le hTT) v c
  have hiNew : IntegrableOn (fun u => heatBoundaryKernel u (v*u)*c) (Ioo T₁ T₂) :=
    hi₂.mono_set (fun _ hu => ⟨hT₁.trans hu.1,hu.2⟩)
  have he : linearHeatHistoryIntegral v c T₂-linearHeatHistoryIntegral v c T₁ =
      ∫ u in Ioo T₁ T₂, heatBoundaryKernel u (v*u)*c := by
    unfold linearHeatHistoryIntegral
    rw [setIntegral_Ioo_split hT₁.le hTT hi₁ hiNew]
    ring
  rw [he]
  have hbound (u : ℝ) (hu : u ∈ Ioo T₁ T₂) :
      ‖heatBoundaryKernel u (v*u)*c‖ ≤ 3*L*C/(Real.sqrt (2*Real.pi)*Real.sqrt T₁) := by
    have hp := linearHeatHistory_integrand_bound (hT₁.trans hu.1) hL hv hc
    have heq : (3*L*C/Real.sqrt (2*Real.pi))*(Real.sqrt u)⁻¹ =
        3*L*C/(Real.sqrt (2*Real.pi)*Real.sqrt u) := by ring
    rw [heq] at hp
    apply hp.trans
    apply div_le_div_of_nonneg_left (by positivity) (by positivity)
    exact mul_le_mul_of_nonneg_left (Real.sqrt_le_sqrt hu.1.le) (Real.sqrt_nonneg _)
  simpa only [Real.volume_real_Ioo_of_le hTT] using
    norm_setIntegral_le_of_norm_le_const (measure_Ioo_lt_top : volume (Ioo T₁ T₂) < ⊤) hbound

end AmericanConvexity.Stopping
