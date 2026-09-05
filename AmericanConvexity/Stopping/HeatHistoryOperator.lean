import AmericanConvexity.Stopping.HeatLayerPotential
import AmericanConvexity.Stopping.HeatBoundaryContraction

/-! # The weakly singular heat-boundary history operator

For a Lipschitz moving graph, the normal-kernel history operator maps
bounded continuous densities to bounded continuous functions. Its norm is
at most a constant times sqrt(D), where D is the elapsed-time window.
This provides the small-time contraction needed to construct a density.
-/

namespace AmericanConvexity.Stopping

open Set Filter MeasureTheory
open scoped Topology BoundedContinuousFunction

theorem integral_inverse_sqrt {D : ℝ} (hD : 0 < D) :
    (∫ s in Ioo 0 D, (Real.sqrt s)⁻¹) = 2*Real.sqrt D := by
  have he : (∫ s in Ioo 0 D, (Real.sqrt s)⁻¹) =
      ∫ s in Ioo 0 D, s^(-1/2 : ℝ) := by
    apply setIntegral_congr_fun measurableSet_Ioo
    intro s hs
    dsimp only
    rw [show (-1/2 : ℝ) = -(1/2) by ring,Real.rpow_neg hs.1.le,Real.sqrt_eq_rpow]
  rw [he,← integral_Ioc_eq_integral_Ioo,← intervalIntegral.integral_of_le hD.le,
    integral_rpow (Or.inl (by norm_num : (-1 : ℝ) < -1/2))]
  norm_num only [show (-1/2 : ℝ)+1 = 1/2 by ring,Real.zero_rpow (by norm_num : (1/2 : ℝ) ≠ 0),sub_zero]
  rw [← Real.sqrt_eq_rpow]
  ring

noncomputable def heatHistory (b : ℝ → ℝ) (D : ℝ) (f : ℝ → ℝ) (t : ℝ) : ℝ :=
  ∫ s in Ioo 0 D, heatBoundaryKernel s (b t-b (t-s))*f (t-s)

noncomputable def heatHistoryNormBound (L D : ℝ) : ℝ :=
  (6*L/Real.sqrt (2*Real.pi))*Real.sqrt D

theorem heatHistoryNormBound_nonneg {L D : ℝ} (hL : 0 ≤ L) :
    0 ≤ heatHistoryNormBound L D := by unfold heatHistoryNormBound; positivity

theorem heatHistoryNormBound_mono {L : ℝ} (hL : 0 ≤ L) :
    Monotone (heatHistoryNormBound L) := by
  intro D E hDE
  exact mul_le_mul_of_nonneg_left (Real.sqrt_le_sqrt hDE) (by positivity)

theorem exists_small_heatHistory_window (L : ℝ) :
    ∃ D : ℝ, 0 < D ∧ heatHistoryNormBound L D < 1 := by
  have hc : Continuous (heatHistoryNormBound L) := by unfold heatHistoryNormBound; fun_prop
  have hz : heatHistoryNormBound L 0 < 1 := by simp [heatHistoryNormBound]
  obtain ⟨ε,hε,hball⟩ := Metric.mem_nhds_iff.mp (hc.continuousAt.preimage_mem_nhds (Iio_mem_nhds hz))
  refine ⟨ε/2,half_pos hε,hball ?_⟩
  change dist (ε/2) 0 < ε
  rw [dist_zero_right,Real.norm_of_nonneg (half_pos hε).le]
  linarith

theorem heatHistory_integrable {b f : ℝ → ℝ} {D L C : ℝ}
    (hD : 0 < D) (hL : 0 ≤ L) (hb : Continuous b)
    (hmove : ∀ t s, 0 < s → ‖b t-b (t-s)‖ ≤ L*s)
    (hf : Continuous f) (hC : ∀ t, ‖f t‖ ≤ C) (t : ℝ) :
    IntegrableOn (fun s => heatBoundaryKernel s (b t-b (t-s))*f (t-s)) (Ioo 0 D) := by
  have hi := movingHeatRemainder_integrable hD hL
    (continuous_const.sub (hb.comp (continuous_const.sub continuous_id))).continuousOn
    (fun s hs => hmove t s hs.1) (hf.comp (continuous_const.sub continuous_id))
    (fun s => hC (t-s)) 0
  have he : movingHeatRemainder (fun s => b t-b (t-s)) (fun s => f (t-s)) 0 =
      (fun s => heatBoundaryKernel s (b t-b (t-s))*f (t-s)) := by
    funext s
    simp only [movingHeatRemainder,zero_add,heatBoundaryKernel,zero_div,zero_mul,sub_zero]
  change IntegrableOn (movingHeatRemainder (fun s => b t-b (t-s)) (fun s => f (t-s)) 0)
    (Ioo 0 D) at hi
  rwa [he] at hi

theorem heatHistory_continuous {b f : ℝ → ℝ} {D L C : ℝ}
    (hD : 0 < D) (hL : 0 ≤ L) (hb : Continuous b)
    (hmove : ∀ t s, 0 < s → ‖b t-b (t-s)‖ ≤ L*s)
    (hf : Continuous f) (hC : ∀ t, ‖f t‖ ≤ C) :
    Continuous (heatHistory b D f) := by
  have hc := movingHeatLayerFlux_continuous
    (d := fun t s => b t-b (t-s)) (g := fun t s => f (t-s)) hD hL
    (fun _ => (continuous_const.sub (hb.comp (continuous_const.sub continuous_id))).continuousOn)
    (fun t s hs => hmove t s hs.1)
    (fun _ => hf.comp (continuous_const.sub continuous_id)) (fun t s => hC (t-s))
    (fun _ _ => hb.sub (hb.comp (continuous_id.sub continuous_const)))
    (fun _ => hf.comp (continuous_id.sub continuous_const))
  have he : heatHistory b D f = fun t =>
      -movingHeatLayerFlux (fun s => b t-b (t-s)) (fun s => f (t-s)) D-f t := by
    funext t
    simp only [movingHeatLayerFlux,heatHistory,sub_zero,neg_neg,add_sub_cancel_left]
  rw [he]
  exact hc.neg.sub hf

theorem heatHistory_bound {b f : ℝ → ℝ} {D L C : ℝ}
    (hD : 0 < D) (hL : 0 ≤ L)
    (hmove : ∀ t s, 0 < s → ‖b t-b (t-s)‖ ≤ L*s)
    (hC : ∀ t, ‖f t‖ ≤ C) (t : ℝ) :
    ‖heatHistory b D f t‖ ≤ heatHistoryNormBound L D*C := by
  calc
    _ ≤ ∫ s in Ioo 0 D, (3*L/Real.sqrt (2*Real.pi)*C)*(Real.sqrt s)⁻¹ := by
      apply norm_integral_le_of_norm_le ((integrableOn_inverse_sqrt hD).const_mul _)
      filter_upwards [ae_restrict_mem measurableSet_Ioo] with s hs
      simpa only [movingHeatRemainder,zero_add,heatBoundaryKernel,zero_div,zero_mul,sub_zero]
        using movingHeatRemainder_bound (d := fun s => b t-b (t-s)) (g := fun s => f (t-s)) hL hs.1
          (hmove t s hs.1) (hC (t-s)) 0
    _ = _ := by rw [integral_const_mul,integral_inverse_sqrt hD]; unfold heatHistoryNormBound; ring

theorem heatHistory_causal {b f : ℝ → ℝ} {a D t : ℝ}
    (hf : ∀ u, u ≤ a → f u = 0) (ht : t ≤ a) : heatHistory b D f t = 0 := by
  apply setIntegral_eq_zero_of_forall_eq_zero
  intro s hs
  rw [hf (t-s) (by linarith [hs.1]),mul_zero]

theorem heatHistory_sub {b : ℝ → ℝ} {D L : ℝ}
    (hD : 0 < D) (hL : 0 ≤ L) (hb : Continuous b)
    (hmove : ∀ t s, 0 < s → ‖b t-b (t-s)‖ ≤ L*s)
    (f g : ℝ →ᵇ ℝ) (t : ℝ) :
    heatHistory b D (fun s => f s-g s) t = heatHistory b D f t-heatHistory b D g t := by
  simp only [heatHistory,mul_sub]
  rw [integral_sub (heatHistory_integrable hD hL hb hmove f.continuous f.norm_coe_le_norm t)
    (heatHistory_integrable hD hL hb hmove g.continuous g.norm_coe_le_norm t)]

noncomputable def heatHistoryBCF {b : ℝ → ℝ} {D L : ℝ}
    (hD : 0 < D) (hL : 0 ≤ L) (hb : Continuous b)
    (hmove : ∀ t s, 0 < s → ‖b t-b (t-s)‖ ≤ L*s) (f : ℝ →ᵇ ℝ) : ℝ →ᵇ ℝ :=
  BoundedContinuousFunction.ofNormedAddCommGroup (heatHistory b D f)
    (heatHistory_continuous hD hL hb hmove f.continuous f.norm_coe_le_norm)
    (heatHistoryNormBound L D*‖f‖) (heatHistory_bound hD hL hmove f.norm_coe_le_norm)

theorem heatHistoryBCF_dist {b : ℝ → ℝ} {D L : ℝ}
    (hD : 0 < D) (hL : 0 ≤ L) (hb : Continuous b)
    (hmove : ∀ t s, 0 < s → ‖b t-b (t-s)‖ ≤ L*s) (f g : ℝ →ᵇ ℝ) :
    dist (heatHistoryBCF hD hL hb hmove f) (heatHistoryBCF hD hL hb hmove g) ≤
      heatHistoryNormBound L D*dist f g := by
  simp only [dist_eq_norm]
  apply (BoundedContinuousFunction.norm_le
    (mul_nonneg (heatHistoryNormBound_nonneg hL) (norm_nonneg _))).mpr
  intro t
  change ‖heatHistory b D f t-heatHistory b D g t‖ ≤ _
  rw [← heatHistory_sub hD hL hb hmove]
  exact heatHistory_bound hD hL hmove (f-g).norm_coe_le_norm t

end AmericanConvexity.Stopping
