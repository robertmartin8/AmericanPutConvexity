import AmericanConvexity.Stopping.CausalLayerLocalization
import AmericanConvexity.Stopping.HeatLayerMatching

/-! # Joining the layer's PDE, continuity, bounds, and normal traces

The original-source-time integral used for the PDE is exactly the
elapsed-time layer used for the jump formula on a causal time window.
Joint continuity includes the graph, and boundedness does not require
spatial decay of the density or a derivative of the graph.
-/

namespace AmericanConvexity.Stopping

open Set Filter MeasureTheory
open MathFin.FeynmanKacHeatEquation
open scoped Topology

noncomputable def elapsedMovingHeatLayer (b f : ℝ → ℝ) (D : ℝ) (z : ℝ × ℝ) : ℝ :=
  ∫ u in Ioo 0 D, heatKernel u (z.1-b (z.2-u))*f (z.2-u)

theorem elapsedMovingHeatLayer_eq (b f : ℝ → ℝ) (D : ℝ) (z : ℝ × ℝ) :
    elapsedMovingHeatLayer b f D z =
      movingHeatLayer (fun u => b z.2-b (z.2-u)) (fun u => f (z.2-u)) D (z.1-b z.2) := by
  unfold elapsedMovingHeatLayer movingHeatLayer
  apply setIntegral_congr_fun measurableSet_Ioo
  intro u _
  dsimp only
  rw [show z.1-b z.2+(b z.2-b (z.2-u)) = z.1-b (z.2-u) by ring]

theorem causalMovingHeatLayer_eq_elapsed {b f : ℝ → ℝ} {a D t : ℝ}
    (hcausal : ∀ u, u ≤ a → f u = 0) (ht : t ≤ a+D) (x : ℝ) :
    causalMovingHeatLayer b f (x,t) = elapsedMovingHeatLayer b f D (x,t) := by
  unfold causalMovingHeatLayer movingPlaneIntegral causalHeatKernelPlane
  dsimp only
  have he := integral_sub_left_eq_self
    (fun u => causalHeatKernel (t-u) (x-b u)*f u) volume t
  simp only [sub_sub_cancel] at he
  rw [← he]
  calc
    _ = ∫ u in Ioo 0 D, causalHeatKernel u (x-b (t-u))*f (t-u) := by
      symm
      apply setIntegral_eq_integral_of_forall_compl_eq_zero
      intro u hu
      by_cases hu0 : 0 < u
      · have hDu : D ≤ u := by
          by_contra hn
          exact hu ⟨hu0,lt_of_not_ge hn⟩
        rw [hcausal (t-u) (by linarith),mul_zero]
      · rw [causalHeatKernel_zero (le_of_not_gt hu0),zero_mul]
    _ = elapsedMovingHeatLayer b f D (x,t) := by
      apply setIntegral_congr_fun measurableSet_Ioo
      intro u hu
      dsimp only
      rw [causalHeatKernel_eq hu.1]

theorem elapsedMovingHeatLayer_integrable {b f : ℝ → ℝ} {D C : ℝ}
    (hD : 0 < D) (hb : Continuous b) (hf : Continuous f) (hC : ∀ u, ‖f u‖ ≤ C)
    (z : ℝ × ℝ) :
    IntegrableOn (fun u => heatKernel u (z.1-b (z.2-u))*f (z.2-u)) (Ioo 0 D) := by
  have hc : ContinuousOn (fun u => heatKernel u (z.1-b (z.2-u))*f (z.2-u)) (Ioo 0 D) := by
    intro u hu
    exact (((heatKernel_smoothAt (x := z.1-b (z.2-u)) hu.1).continuousAt.comp
      (x := u) (f := fun u => (u,z.1-b (z.2-u))) (by fun_prop)).mul
      (hf.continuousAt.comp (show ContinuousAt (fun u : ℝ => z.2-u) u by fun_prop))).continuousWithinAt
  apply ((integrableOn_inverse_sqrt hD).const_mul ((Real.sqrt (2*Real.pi))⁻¹*C)).mono'
    (hc.aestronglyMeasurable measurableSet_Ioo)
  filter_upwards [ae_restrict_mem measurableSet_Ioo] with u hu
  rw [norm_mul]
  calc
    _ ≤ ((Real.sqrt (2*Real.pi))⁻¹*(Real.sqrt u)⁻¹)*C :=
      mul_le_mul (heatKernel_inverse_sqrt_bound hu.1 _) (hC _) (norm_nonneg _) (by positivity)
    _ = _ := by ring

theorem elapsedMovingHeatLayer_continuous {b f : ℝ → ℝ} {D C : ℝ}
    (hD : 0 < D) (hb : Continuous b) (hf : Continuous f) (hC : ∀ u, ‖f u‖ ≤ C) :
    Continuous (elapsedMovingHeatLayer b f D) := by
  apply continuous_of_dominated
    (bound := fun u => ((Real.sqrt (2*Real.pi))⁻¹*C)*(Real.sqrt u)⁻¹)
  · intro z
    exact (elapsedMovingHeatLayer_integrable hD hb hf hC z).aestronglyMeasurable
  · intro z
    filter_upwards [ae_restrict_mem measurableSet_Ioo] with u hu
    rw [norm_mul]
    calc
      _ ≤ ((Real.sqrt (2*Real.pi))⁻¹*(Real.sqrt u)⁻¹)*C :=
        mul_le_mul (heatKernel_inverse_sqrt_bound hu.1 _) (hC _) (norm_nonneg _) (by positivity)
      _ = _ := by ring
  · exact (integrableOn_inverse_sqrt hD).const_mul _
  · filter_upwards [ae_restrict_mem measurableSet_Ioo] with u hu
    apply continuous_iff_continuousAt.mpr
    intro z
    exact ((heatKernel_smoothAt (x := z.1-b (z.2-u)) hu.1).continuousAt.comp
      (x := z) (f := fun z : ℝ × ℝ => (u,z.1-b (z.2-u))) (by fun_prop)).mul
        (hf.continuousAt.comp (show ContinuousAt (fun z : ℝ × ℝ => z.2-u) z by fun_prop))

theorem elapsedMovingHeatLayer_bound {b f : ℝ → ℝ} {D C : ℝ}
    (hD : 0 < D) (hC : ∀ u, ‖f u‖ ≤ C) (z : ℝ × ℝ) :
    ‖elapsedMovingHeatLayer b f D z‖ ≤ (2*C/Real.sqrt (2*Real.pi))*Real.sqrt D := by
  calc
    _ ≤ ∫ u in Ioo 0 D, ((Real.sqrt (2*Real.pi))⁻¹*C)*(Real.sqrt u)⁻¹ := by
      apply norm_integral_le_of_norm_le ((integrableOn_inverse_sqrt hD).const_mul _)
      filter_upwards [ae_restrict_mem measurableSet_Ioo] with u hu
      rw [norm_mul]
      calc
        _ ≤ ((Real.sqrt (2*Real.pi))⁻¹*(Real.sqrt u)⁻¹)*C :=
          mul_le_mul (heatKernel_inverse_sqrt_bound hu.1 _) (hC _) (norm_nonneg _) (by positivity)
        _ = _ := by ring
    _ = _ := by rw [integral_const_mul,integral_inverse_sqrt hD]; ring

theorem causalMovingHeatLayer_continuousOn_window {b f : ℝ → ℝ} {a D C : ℝ}
    (hD : 0 < D) (hb : Continuous b) (hf : Continuous f) (hC : ∀ u, ‖f u‖ ≤ C)
    (hcausal : ∀ u, u ≤ a → f u = 0) :
    ContinuousOn (causalMovingHeatLayer b f) {z | z.2 ≤ a+D} := by
  apply (elapsedMovingHeatLayer_continuous hD hb hf hC).continuousOn.congr
  intro z hz
  exact causalMovingHeatLayer_eq_elapsed hcausal hz z.1

theorem causalMovingHeatLayer_zero_initial {b f : ℝ → ℝ} {a t : ℝ}
    (hcausal : ∀ u, u ≤ a → f u = 0) (ht : t ≤ a) (x : ℝ) :
    causalMovingHeatLayer b f (x,t) = 0 := by
  unfold causalMovingHeatLayer movingPlaneIntegral causalHeatKernelPlane
  apply integral_eq_zero_of_ae
  apply Eventually.of_forall
  intro u
  dsimp only
  by_cases hu : u ≤ a
  · rw [hcausal u hu,mul_zero]
    rfl
  · rw [causalHeatKernel_zero (by linarith [lt_of_not_ge hu] : t-u ≤ 0),zero_mul]
    rfl

theorem causalMovingHeatLayer_bound_window {b f : ℝ → ℝ} {a D C t : ℝ}
    (hD : 0 < D) (hC : ∀ u, ‖f u‖ ≤ C) (hcausal : ∀ u, u ≤ a → f u = 0)
    (ht : t ≤ a+D) (x : ℝ) :
    ‖causalMovingHeatLayer b f (x,t)‖ ≤ (2*C/Real.sqrt (2*Real.pi))*Real.sqrt D := by
  rw [causalMovingHeatLayer_eq_elapsed hcausal ht]
  exact elapsedMovingHeatLayer_bound hD hC (x,t)

theorem causalMovingHeatLayer_normal_traces {b f : ℝ → ℝ} {a D C L t : ℝ}
    (hD : 0 < D) (hL : 0 ≤ L) (hb : Continuous b) (hf : Continuous f)
    (hC : ∀ u, ‖f u‖ ≤ C) (hcausal : ∀ u, u ≤ a → f u = 0) (ht : t ≤ a+D)
    (hmove : ∀ u ∈ Ioo 0 D, ‖b t-b (t-u)‖ ≤ L*u) :
    HasDerivWithinAt (fun x => causalMovingHeatLayer b f (b t+x,t))
      (f t-heatHistory b D f t) (Iic 0) 0 ∧
    HasDerivWithinAt (fun x => causalMovingHeatLayer b f (b t+x,t))
      (-(f t+heatHistory b D f t)) (Ici 0) 0 := by
  have hd : ContinuousOn (fun u => b t-b (t-u)) (Ioo 0 D) :=
    (continuous_const.sub (hb.comp (continuous_const.sub continuous_id))).continuousOn
  have hg : Continuous (fun u => f (t-u)) := hf.comp (continuous_const.sub continuous_id)
  have hs : ∀ u, D ≤ u → f (t-u) = 0 := fun u hu => hcausal (t-u) (by linarith)
  have he : (fun x => causalMovingHeatLayer b f (b t+x,t)) =
      movingHeatLayer (fun u => b t-b (t-u)) (fun u => f (t-u)) D := by
    funext x
    rw [causalMovingHeatLayer_eq_elapsed hcausal ht,elapsedMovingHeatLayer_eq]
    simp only [add_sub_cancel_left]
  rw [he]
  constructor
  · simpa only [sub_zero,heatHistory] using
      movingHeatLayer_hasDerivWithinAt_contact_left hD hL hd hmove hg (fun u => hC (t-u)) hs
  · simpa only [sub_zero,heatHistory] using
      movingHeatLayer_hasDerivWithinAt_contact hD hL hd hmove hg (fun u => hC (t-u)) hs

end AmericanConvexity.Stopping
