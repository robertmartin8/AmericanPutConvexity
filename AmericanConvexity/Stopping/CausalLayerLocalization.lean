import AmericanConvexity.Stopping.MovingHeatLayerEquation

/-! # Localizing a continuous causal density without changing its layer

A cutoff after the target time makes a causal density compactly supported.
The causal heat kernel ignores the changed future. Thus the layer's PDE
and spatial regularity need continuity and causality, not compact support
of the density or any derivatives of the moving graph.
-/

namespace AmericanConvexity.Stopping

open Set Filter Metric
open scoped Topology ContDiff

theorem exists_compact_causal_density {f : ℝ → ℝ} {a : ℝ}
    (hf : Continuous f) (hcausal : ∀ u, u ≤ a → f u = 0) (T : ℝ) :
    ∃ g : ℝ → ℝ, Continuous g ∧ HasCompactSupport g ∧ ∀ u, u ≤ T → g u = f u := by
  let ψ : ContDiffBump T := {
    rIn := max (T-a) 1
    rOut := max (T-a) 1+1
    rIn_pos := lt_of_lt_of_le zero_lt_one (le_max_right _ _)
    rIn_lt_rOut := lt_add_one _ }
  refine ⟨fun u => ψ u*f u,ψ.continuous.mul hf,ψ.hasCompactSupport.mul_right,?_⟩
  intro u hu
  dsimp only
  by_cases hua : u ≤ a
  · rw [hcausal u hua,mul_zero]
  · have he : ψ u = 1 := by
      apply ψ.one_of_mem_closedBall
      change dist u T ≤ max (T-a) 1
      rw [Real.dist_eq,abs_of_nonpos (sub_nonpos.mpr hu)]
      linarith [le_max_left (T-a) 1,lt_of_not_ge hua]
    rw [he,one_mul]

theorem causalMovingHeatLayer_congr_past {b f g : ℝ → ℝ} {T t : ℝ}
    (he : ∀ u, u ≤ T → f u = g u) (ht : t ≤ T) (x : ℝ) :
    causalMovingHeatLayer b f (x,t) = causalMovingHeatLayer b g (x,t) := by
  unfold causalMovingHeatLayer movingPlaneIntegral causalHeatKernelPlane
  apply MeasureTheory.integral_congr_ae
  apply Eventually.of_forall
  intro u
  dsimp only
  by_cases hu : u ≤ T
  · rw [he u hu]
  · rw [causalHeatKernel_zero (by linarith [lt_of_not_ge hu] : t-u ≤ 0)]
    simp only [zero_mul]

theorem causalMovingHeatLayer_equation_of_causal {b f : ℝ → ℝ} {a : ℝ}
    (hb : Continuous b) (hf : Continuous f) (hcausal : ∀ u, u ≤ a → f u = 0)
    {x t : ℝ} (hx : x ≠ b t) :
    deriv (fun s => causalMovingHeatLayer b f (x,s)) t =
      (1/2)*deriv (deriv (fun y => causalMovingHeatLayer b f (y,t))) x := by
  obtain ⟨g,hg,hgc,he⟩ := exists_compact_causal_density hf hcausal (t+1)
  have hspace : (fun y => causalMovingHeatLayer b f (y,t)) =
      (fun y => causalMovingHeatLayer b g (y,t)) :=
    funext (fun y => causalMovingHeatLayer_congr_past (fun u hu => (he u hu).symm) (by linarith) y)
  have htime : (fun s => causalMovingHeatLayer b f (x,s)) =ᶠ[𝓝 t]
      (fun s => causalMovingHeatLayer b g (x,s)) := by
    filter_upwards [Iio_mem_nhds (lt_add_one t)] with s hs
    exact causalMovingHeatLayer_congr_past (fun u hu => (he u hu).symm) hs.le x
  rw [htime.deriv_eq,hspace]
  exact causalMovingHeatLayer_equation hb hg hgc hx

theorem causalMovingHeatLayer_contDiffAt_space_of_causal {b f : ℝ → ℝ} {a : ℝ}
    (hb : Continuous b) (hf : Continuous f) (hcausal : ∀ u, u ≤ a → f u = 0)
    {x t : ℝ} (hx : x ≠ b t) :
    ContDiffAt ℝ 2 (fun y => causalMovingHeatLayer b f (y,t)) x := by
  obtain ⟨g,hg,hgc,he⟩ := exists_compact_causal_density hf hcausal t
  have hspace : (fun y => causalMovingHeatLayer b f (y,t)) =
      (fun y => causalMovingHeatLayer b g (y,t)) :=
    funext (fun y => causalMovingHeatLayer_congr_past (fun u hu => (he u hu).symm) le_rfl y)
  rw [hspace]
  exact causalMovingHeatLayer_contDiffAt_space hb hg hgc hx

theorem causalMovingHeatLayer_differentiableAt_time_of_causal {b f : ℝ → ℝ} {a : ℝ}
    (hb : Continuous b) (hf : Continuous f) (hcausal : ∀ u, u ≤ a → f u = 0)
    {x t : ℝ} (hx : x ≠ b t) :
    DifferentiableAt ℝ (fun s => causalMovingHeatLayer b f (x,s)) t := by
  obtain ⟨g,hg,hgc,he⟩ := exists_compact_causal_density hf hcausal (t+1)
  have htime : (fun s => causalMovingHeatLayer b f (x,s)) =ᶠ[𝓝 t]
      (fun s => causalMovingHeatLayer b g (x,s)) := by
    filter_upwards [Iio_mem_nhds (lt_add_one t)] with s hs
    exact causalMovingHeatLayer_congr_past (fun u hu => (he u hu).symm) hs.le x
  exact (compact_movingPlaneIntegral_hasDeriv_time
    (fun _ hz => causalHeatKernelPlane_smoothAt hz) hb hg hgc hx).differentiableAt.congr_of_eventuallyEq htime

end AmericanConvexity.Stopping
