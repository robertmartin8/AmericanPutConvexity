import AmericanConvexity.Stopping.MovingHeatKernelBound
import AmericanConvexity.Stopping.HeatBoundaryExtension

/-! # The heat normal-kernel jump on a Lipschitz moving graph

In elapsed time, let d(s) be the displacement from the earlier boundary
to the current boundary, with |d(s)| <= L*s. The flat boundary kernel has
unit limiting mass. Its change under this displacement is integrably
dominated, even when the evaluation point tends to the boundary.

This proves the jump formula for the integrated normal kernel. Identifying
an actual PDE solution with a layer potential, and differentiating that
potential in the interior, are separate obligations, not assumptions hidden
in this theorem.
-/

namespace AmericanConvexity.Stopping

open Set Filter MeasureTheory
open scoped Topology

noncomputable def movingHeatRemainder (d g : ℝ → ℝ) (x s : ℝ) : ℝ :=
  (heatBoundaryKernel s (x+d s)-heatBoundaryKernel s x)*g s

theorem movingHeatRemainder_bound {d g : ℝ → ℝ} {L C s : ℝ}
    (hL : 0 ≤ L) (hs : 0 < s) (hd : ‖d s‖ ≤ L*s) (hg : ‖g s‖ ≤ C) (x : ℝ) :
    ‖movingHeatRemainder d g x s‖ ≤
      (3*L/Real.sqrt (2*Real.pi)*C)*(Real.sqrt s)⁻¹ := by
  unfold movingHeatRemainder
  rw [norm_mul]
  calc
    _ ≤ ((3*L/Real.sqrt (2*Real.pi))/Real.sqrt s)*C :=
      mul_le_mul (heatBoundaryKernel_lipschitz_motion_bound hs hd x) hg
        (norm_nonneg _) (by positivity)
    _ = _ := by ring

theorem movingHeatRemainder_continuousOn {d g : ℝ → ℝ} {T : ℝ}
    (hd : ContinuousOn d (Ioo 0 T)) (hg : Continuous g) (x : ℝ) :
    ContinuousOn (movingHeatRemainder d g x) (Ioo 0 T) := by
  intro s hs
  have h1 := (heatBoundaryKernel_smoothAt (x := x+d s) hs.1).continuousAt.comp_continuousWithinAt
    (f := fun u : ℝ => (u,x+d u))
    (continuousWithinAt_id.prodMk (continuousWithinAt_const.add (hd s hs)))
  have h2 : ContinuousWithinAt (fun u => heatBoundaryKernel u x) (Ioo 0 T) s :=
    (heatBoundaryKernel_smoothAt (x := x) hs.1).continuousAt.comp_continuousWithinAt
    (f := fun u : ℝ => (u,x))
    (continuousWithinAt_id.prodMk continuousWithinAt_const)
  exact (h1.sub h2).mul hg.continuousAt.continuousWithinAt

theorem movingHeatRemainder_integrable {d g : ℝ → ℝ} {T L C : ℝ}
    (hT : 0 < T) (hL : 0 ≤ L) (hd : ContinuousOn d (Ioo 0 T))
    (hmove : ∀ s ∈ Ioo 0 T, ‖d s‖ ≤ L*s) (hg : Continuous g)
    (hC : ∀ s, ‖g s‖ ≤ C) (x : ℝ) :
    IntegrableOn (movingHeatRemainder d g x) (Ioo 0 T) := by
  apply ((integrableOn_inverse_sqrt hT).const_mul (3*L/Real.sqrt (2*Real.pi)*C)).mono'
    ((movingHeatRemainder_continuousOn hd hg x).aestronglyMeasurable measurableSet_Ioo)
  filter_upwards [ae_restrict_mem measurableSet_Ioo] with s hs
  exact movingHeatRemainder_bound hL hs.1 (hmove s hs) (hC s) x

/-- The correction is continuous even across the spatial contact point. -/
theorem movingHeatRemainder_integral_continuous {d g : ℝ → ℝ} {T L C : ℝ}
    (hT : 0 < T) (hL : 0 ≤ L) (hd : ContinuousOn d (Ioo 0 T))
    (hmove : ∀ s ∈ Ioo 0 T, ‖d s‖ ≤ L*s) (hg : Continuous g)
    (hC : ∀ s, ‖g s‖ ≤ C) :
    Continuous (fun x => ∫ s in Ioo 0 T, movingHeatRemainder d g x s) := by
  apply continuous_of_dominated
    (bound := fun s => (3*L/Real.sqrt (2*Real.pi)*C)*(Real.sqrt s)⁻¹)
  · intro x
    exact (movingHeatRemainder_integrable hT hL hd hmove hg hC x).aestronglyMeasurable
  · intro x
    filter_upwards [ae_restrict_mem measurableSet_Ioo] with s hs
    exact movingHeatRemainder_bound hL hs.1 (hmove s hs) (hC s) x
  · exact (integrableOn_inverse_sqrt hT).const_mul _
  · filter_upwards [ae_restrict_mem measurableSet_Ioo] with s hs
    have hkernel : Continuous (heatBoundaryKernel s) := continuous_iff_continuousAt.mpr
      (fun y => (heatBoundaryKernel_hasDeriv_space hs.1 y).continuousAt)
    exact ((hkernel.comp (continuous_id.add continuous_const)).sub hkernel).mul continuous_const

/-- Right approach to a moving graph retains the unit jump of the flat kernel.
The density is a bounded continuous function of elapsed time and vanishes
beyond the local time window. No differentiability of the graph is assumed. -/
theorem movingHeatBoundaryKernel_jump {d g : ℝ → ℝ} {T L C : ℝ}
    (hT : 0 < T) (hL : 0 ≤ L) (hd : ContinuousOn d (Ioo 0 T))
    (hmove : ∀ s ∈ Ioo 0 T, ‖d s‖ ≤ L*s) (hg : Continuous g)
    (hC : ∀ s, ‖g s‖ ≤ C) (hsupport : ∀ s, T ≤ s → g s = 0) :
    Tendsto (fun x => ∫ s in Ioo 0 T, heatBoundaryKernel s (x+d s)*g s)
      (𝓝[>] (0 : ℝ))
      (𝓝 (g 0 + ∫ s in Ioo 0 T, heatBoundaryKernel s (d s)*g s)) := by
  have hflat (x : ℝ) (hx : 0 < x) :
      (∫ s in Ioo 0 T, heatBoundaryKernel s x*g s) =
        heatBoundaryExtension (fun y => g (-y)) x 0 := by
    rw [heatBoundaryExtension_eq_integral _ hx 0]
    simp only [zero_sub,neg_neg]
    symm
    apply setIntegral_eq_of_subset_of_forall_sdiff_eq_zero measurableSet_Ioi Ioo_subset_Ioi_self
    intro s hs
    rw [hsupport s (by
      by_contra hn
      exact hs.2 ⟨hs.1,lt_of_not_ge hn⟩),mul_zero]
  have hflatInt (x : ℝ) (hx : 0 < x) :
      IntegrableOn (fun s => heatBoundaryKernel s x*g s) (Ioo 0 T) := by
    have hi : IntegrableOn (fun s => heatBoundaryKernel s x*g s) (Ioi 0) :=
      (heatBoundaryKernel_integrable hx).mul_bdd hg.aestronglyMeasurable
        (Eventually.of_forall hC)
    exact hi.mono_set Ioo_subset_Ioi_self
  have heq (x : ℝ) (hx : 0 < x) :
      (∫ s in Ioo 0 T, heatBoundaryKernel s (x+d s)*g s) =
        heatBoundaryExtension (fun y => g (-y)) x 0 +
          ∫ s in Ioo 0 T, movingHeatRemainder d g x s := by
    rw [← hflat x hx,← integral_add (hflatInt x hx)
      (movingHeatRemainder_integrable hT hL hd hmove hg hC x)]
    apply setIntegral_congr_fun measurableSet_Ioo
    intro s _
    dsimp [movingHeatRemainder]
    ring
  have hlimFlat : Tendsto (fun x : ℝ => heatBoundaryExtension (fun y => g (-y)) x 0)
      (𝓝 (0 : ℝ)) (𝓝 (g 0)) := by
    have hc : Continuous (fun x : ℝ => heatBoundaryExtension (fun y => g (-y)) x 0) :=
      (heatBoundaryExtension_continuous (hg.comp continuous_neg)
      (fun y => hC (-y))).comp (continuous_id.prodMk continuous_const)
    simpa only [heatBoundaryExtension_boundary,neg_zero] using hc.continuousAt.tendsto (x := 0)
  have hlimRest : Tendsto (fun x => ∫ s in Ioo 0 T, movingHeatRemainder d g x s)
      (𝓝 (0 : ℝ)) (𝓝 (∫ s in Ioo 0 T, heatBoundaryKernel s (d s)*g s)) := by
    simpa only [movingHeatRemainder,zero_add,heatBoundaryKernel,zero_div,zero_mul,sub_zero]
      using (movingHeatRemainder_integral_continuous hT hL hd hmove hg hC).continuousAt.tendsto
        (x := 0)
  apply ((hlimFlat.add hlimRest).mono_left nhdsWithin_le_nhds).congr'
  filter_upwards [self_mem_nhdsWithin] with x hx
  exact (heq x hx).symm

/-- The spatial derivative of the single-layer heat kernel is minus the
boundary kernel. This fixes the sign of the normal jump explicitly. -/
theorem movingHeatKernel_deriv_integral (d g : ℝ → ℝ) (x T : ℝ) :
    (∫ s in Ioo 0 T,
      deriv (MathFin.FeynmanKacHeatEquation.heatKernel s) (x+d s)*g s) =
      -(∫ s in Ioo 0 T, heatBoundaryKernel s (x+d s)*g s) := by
  rw [← integral_neg]
  apply setIntegral_congr_fun measurableSet_Ioo
  intro s hs
  dsimp only
  rw [(heatKernel_hasDeriv_space hs.1 (x+d s)).deriv]
  dsimp [heatBoundaryKernel]
  ring

theorem movingHeatKernel_deriv_jump {d g : ℝ → ℝ} {T L C : ℝ}
    (hT : 0 < T) (hL : 0 ≤ L) (hd : ContinuousOn d (Ioo 0 T))
    (hmove : ∀ s ∈ Ioo 0 T, ‖d s‖ ≤ L*s) (hg : Continuous g)
    (hC : ∀ s, ‖g s‖ ≤ C) (hsupport : ∀ s, T ≤ s → g s = 0) :
    Tendsto (fun x => ∫ s in Ioo 0 T,
      deriv (MathFin.FeynmanKacHeatEquation.heatKernel s) (x+d s)*g s)
      (𝓝[>] (0 : ℝ))
      (𝓝 (-(g 0 + ∫ s in Ioo 0 T, heatBoundaryKernel s (d s)*g s))) := by
  simpa only [movingHeatKernel_deriv_integral] using
    (movingHeatBoundaryKernel_jump hT hL hd hmove hg hC hsupport).neg

end AmericanConvexity.Stopping
