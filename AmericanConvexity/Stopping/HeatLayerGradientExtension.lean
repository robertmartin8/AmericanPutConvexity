import AmericanConvexity.Stopping.MovingHeatLayerBridge

/-! # A jointly continuous continuation-side gradient extension for heat layers

The flat normal kernel is an approximate identity. The moving-graph
correction has a uniform integrable inverse-square-root bound, including
at zero spatial distance. Separating these terms proves joint continuity
in space and time, not just fixed-time limits or boundary-time continuity.
The graph needs only uniform Lipschitz displacement on the time window.
-/

namespace AmericanConvexity.Stopping

open Set Filter MeasureTheory
open scoped Topology

/-- Normal kernel with its right jump filled in at zero spatial distance.
The first coordinate is distance from the current graph, not absolute space. -/
noncomputable def movingHeatNormalExtension (b f : ℝ → ℝ) (D : ℝ) (z : ℝ × ℝ) : ℝ :=
  heatBoundaryExtension f z.1 z.2 +
    ∫ u in Ioo 0 D, movingHeatRemainder
      (fun u => b z.2-b (z.2-u)) (fun u => f (z.2-u)) z.1 u

theorem movingHeatNormalExtension_continuousOn {b f : ℝ → ℝ}
    {D L C : ℝ} {S : Set ℝ} (hD : 0 < D) (hL : 0 ≤ L)
    (hb : Continuous b) (hf : Continuous f) (hC : ∀ t, ‖f t‖ ≤ C)
    (hmove : ∀ t ∈ S, ∀ u ∈ Ioo 0 D, ‖b t-b (t-u)‖ ≤ L*u) :
    ContinuousOn (movingHeatNormalExtension b f D) {z | z.2 ∈ S} := by
  apply (heatBoundaryExtension_continuous hf hC).continuousOn.add
  apply continuousOn_of_dominated
    (bound := fun u => (3*L/Real.sqrt (2*Real.pi)*C)*(Real.sqrt u)⁻¹)
  · intro z hz
    exact (movingHeatRemainder_integrable hD hL
      (continuous_const.sub (hb.comp (continuous_const.sub continuous_id))).continuousOn
      (hmove z.2 hz) (hf.comp (continuous_const.sub continuous_id)) (fun u => hC (z.2-u)) z.1).aestronglyMeasurable
  · intro z hz
    filter_upwards [ae_restrict_mem measurableSet_Ioo] with u hu
    exact movingHeatRemainder_bound hL hu.1 (hmove z.2 hz u hu) (hC (z.2-u)) z.1
  · exact (integrableOn_inverse_sqrt hD).const_mul _
  · filter_upwards [ae_restrict_mem measurableSet_Ioo] with u hu
    have hkernel : Continuous (heatBoundaryKernel u) := continuous_iff_continuousAt.mpr
      (fun x => (heatBoundaryKernel_hasDeriv_space hu.1 x).continuousAt)
    have harg : Continuous (fun z : ℝ × ℝ => z.1+(b z.2-b (z.2-u))) := by fun_prop
    exact (((hkernel.comp harg).sub (hkernel.comp continuous_fst)).mul
      (hf.comp (continuous_snd.sub continuous_const))).continuousOn

theorem movingHeatNormalExtension_boundary (b f : ℝ → ℝ) (D t : ℝ) :
    movingHeatNormalExtension b f D (0,t) = f t+heatHistory b D f t := by
  simp only [movingHeatNormalExtension,heatBoundaryExtension_boundary,movingHeatRemainder,
    zero_add,heatBoundaryKernel,zero_div,zero_mul,sub_zero,heatHistory]

theorem movingHeatNormalExtension_eq_integral {b f : ℝ → ℝ} {a D L C x t : ℝ}
    (hD : 0 < D) (hL : 0 ≤ L) (hb : Continuous b) (hf : Continuous f)
    (hC : ∀ s, ‖f s‖ ≤ C) (hfa : ∀ s, s ≤ a → f s = 0)
    (ht : t ≤ a+D) (hx : 0 < x)
    (hmove : ∀ u ∈ Ioo 0 D, ‖b t-b (t-u)‖ ≤ L*u) :
    movingHeatNormalExtension b f D (x,t) =
      ∫ u in Ioo 0 D, heatBoundaryKernel u (x+(b t-b (t-u)))*f (t-u) := by
  have hg : Continuous (fun u => f (t-u)) := hf.comp (continuous_const.sub continuous_id)
  have hflat : heatBoundaryExtension f x t =
      ∫ u in Ioo 0 D, heatBoundaryKernel u x*f (t-u) := by
    rw [heatBoundaryExtension_eq_integral f hx t]
    apply setIntegral_eq_of_subset_of_forall_sdiff_eq_zero measurableSet_Ioi Ioo_subset_Ioi_self
    intro u hu
    have hDu : D ≤ u := by
      by_contra hn
      exact hu.2 ⟨hu.1,lt_of_not_ge hn⟩
    rw [hfa (t-u) (by linarith),mul_zero]
  have hiAll : IntegrableOn (fun u => heatBoundaryKernel u x*f (t-u)) (Ioi 0) :=
    (heatBoundaryKernel_integrable hx).mul_bdd hg.aestronglyMeasurable
      (Eventually.of_forall fun u => hC (t-u))
  have hi : IntegrableOn (fun u => heatBoundaryKernel u x*f (t-u)) (Ioo 0 D) :=
    hiAll.mono_set Ioo_subset_Ioi_self
  have hr : IntegrableOn (movingHeatRemainder (fun u => b t-b (t-u))
      (fun u => f (t-u)) x) (Ioo 0 D) :=
    movingHeatRemainder_integrable hD hL
      (continuous_const.sub (hb.comp (continuous_const.sub continuous_id))).continuousOn
      hmove hg (fun u => hC (t-u)) x
  unfold movingHeatNormalExtension
  dsimp only
  rw [hflat,← integral_add hi hr]
  apply setIntegral_congr_fun measurableSet_Ioo
  intro u _
  dsimp [movingHeatRemainder]
  ring

theorem causalMovingHeatLayer_hasDerivAt_normalExtension {b f : ℝ → ℝ}
    {a D L C x t : ℝ} (hD : 0 < D) (hL : 0 ≤ L)
    (hb : Continuous b) (hf : Continuous f) (hC : ∀ s, ‖f s‖ ≤ C)
    (hfa : ∀ s, s ≤ a → f s = 0) (ht : t ≤ a+D) (hx : b t < x)
    (hmove : ∀ u ∈ Ioo 0 D, ‖b t-b (t-u)‖ ≤ L*u) :
    HasDerivAt (fun y => causalMovingHeatLayer b f (y,t))
      (-movingHeatNormalExtension b f D (x-b t,t)) x := by
  have hd := movingHeatLayer_hasDerivAt hD hL
    (continuous_const.sub (hb.comp (continuous_const.sub continuous_id))).continuousOn
    hmove (hf.comp (continuous_const.sub continuous_id)) (fun u => hC (t-u)) (sub_pos.mpr hx)
  have he : (fun y => causalMovingHeatLayer b f (y,t)) =
      (fun y => movingHeatLayer (fun u => b t-b (t-u)) (fun u => f (t-u)) D (y-b t)) := by
    funext y
    rw [causalMovingHeatLayer_eq_elapsed hfa ht,elapsedMovingHeatLayer_eq]
  rw [he,movingHeatNormalExtension_eq_integral hD hL hb hf hC hfa ht (sub_pos.mpr hx) hmove]
  simpa only [mul_one,integral_neg] using! hd.comp x ((hasDerivAt_id x).sub_const (b t))

/-- Absolute-space version of the continuation-side gradient extension. -/
noncomputable def causalMovingHeatLayerRightGradient (b f : ℝ → ℝ) (D : ℝ)
    (z : ℝ × ℝ) : ℝ := -movingHeatNormalExtension b f D (z.1-b z.2,z.2)

theorem causalMovingHeatLayerRightGradient_continuousOn {b f : ℝ → ℝ}
    {D L C : ℝ} {S : Set ℝ} (hD : 0 < D) (hL : 0 ≤ L)
    (hb : Continuous b) (hf : Continuous f) (hC : ∀ t, ‖f t‖ ≤ C)
    (hmove : ∀ t ∈ S, ∀ u ∈ Ioo 0 D, ‖b t-b (t-u)‖ ≤ L*u) :
    ContinuousOn (causalMovingHeatLayerRightGradient b f D) {z | z.2 ∈ S} := by
  apply ((movingHeatNormalExtension_continuousOn hD hL hb hf hC hmove).comp
    (show ContinuousOn (fun z : ℝ × ℝ => (z.1-b z.2,z.2)) {z | z.2 ∈ S} by fun_prop)
    (fun _ hz => hz)).neg

theorem causalMovingHeatLayerRightGradient_boundary (b f : ℝ → ℝ) (D t : ℝ) :
    causalMovingHeatLayerRightGradient b f D (b t,t) = -(f t+heatHistory b D f t) := by
  simp only [causalMovingHeatLayerRightGradient,sub_self,movingHeatNormalExtension_boundary]

end AmericanConvexity.Stopping
