import AmericanConvexity.Stopping.PlanePricingDerivative

/-! # The causal heat kernel off its space-time singularity

The ordinary Gaussian is extended by zero at nonpositive elapsed time. It
is smooth away from (0,0), including across time zero at nonzero spatial
distance. This permits layer differentiation in the evaluation variables
while the moving graph is only continuous in source time.
-/

namespace AmericanConvexity.Stopping

open Set Filter
open MathFin.FeynmanKacHeatEquation
open scoped Topology ContDiff

noncomputable def causalHeatKernel (t x : ℝ) : ℝ := if 0 < t then heatKernel t x else 0

theorem causalHeatKernel_eq {t : ℝ} (ht : 0 < t) (x : ℝ) :
    causalHeatKernel t x = heatKernel t x := if_pos ht

theorem causalHeatKernel_zero {t : ℝ} (ht : t ≤ 0) (x : ℝ) :
    causalHeatKernel t x = 0 := if_neg (not_lt_of_ge ht)

theorem causalHeatKernel_nonneg (t x : ℝ) : 0 ≤ causalHeatKernel t x := by
  by_cases ht : 0 < t
  · rw [causalHeatKernel_eq ht]
    exact heatKernel_nonneg ht x
  · rw [causalHeatKernel_zero (le_of_not_gt ht)]

theorem causalHeatKernel_eq_boundary {x : ℝ} (hx : x ≠ 0) (t : ℝ) :
    causalHeatKernel t x = (t/Real.sqrt (x^2))*causalHeatBoundaryKernel t (Real.sqrt (x^2)) := by
  have hr : 0 < Real.sqrt (x^2) := Real.sqrt_pos.mpr (sq_pos_of_ne_zero hx)
  by_cases ht : 0 < t
  · rw [causalHeatKernel_eq ht,causalHeatBoundaryKernel_eq ht hr]
    unfold heatBoundaryKernel
    have he : heatKernel t (Real.sqrt (x^2)) = heatKernel t x := by
      simp only [heatKernel,Real.sq_sqrt (sq_nonneg x)]
    rw [he]
    field_simp
  · rw [causalHeatKernel_zero (le_of_not_gt ht),causalHeatBoundaryKernel_zero (le_of_not_gt ht),mul_zero]

theorem causalHeatKernel_smoothAt_space {t x : ℝ} (hx : x ≠ 0) :
    ContDiffAt ℝ ∞ (fun z : ℝ × ℝ => causalHeatKernel z.1 z.2) (t,x) := by
  have hr : ContDiffAt ℝ ∞ (fun z : ℝ × ℝ => Real.sqrt (z.2^2)) (t,x) :=
    (contDiffAt_snd.pow 2).sqrt (pow_ne_zero 2 hx)
  have hr0 : Real.sqrt (x^2) ≠ 0 := (Real.sqrt_pos.mpr (sq_pos_of_ne_zero hx)).ne'
  have hc := (contDiffAt_fst.div hr hr0).mul
    ((causalHeatBoundaryKernel_smoothAt (t := t) hr0).comp (t,x) (contDiffAt_fst.prodMk hr))
  apply hc.congr_of_eventuallyEq
  filter_upwards [continuousAt_snd.preimage_mem_nhds (isOpen_ne.mem_nhds hx)] with z hz
  exact causalHeatKernel_eq_boundary hz z.1

theorem causalHeatKernel_smoothAt {t x : ℝ} (hz : t ≠ 0 ∨ x ≠ 0) :
    ContDiffAt ℝ ∞ (fun z : ℝ × ℝ => causalHeatKernel z.1 z.2) (t,x) := by
  rcases hz with ht | hx
  · rcases lt_or_gt_of_ne ht with ht | ht
    · apply (contDiffAt_const (c := (0 : ℝ))).congr_of_eventuallyEq
      filter_upwards [continuousAt_fst.preimage_mem_nhds (Iio_mem_nhds ht)] with z hz
      exact causalHeatKernel_zero hz.le z.2
    · apply (heatKernel_smoothAt (x := x) ht).congr_of_eventuallyEq
      filter_upwards [continuousAt_fst.preimage_mem_nhds (Ioi_mem_nhds ht)] with z hz
      exact causalHeatKernel_eq hz z.2
  · exact causalHeatKernel_smoothAt_space hx

theorem heatKernel_equation {t : ℝ} (ht : 0 < t) (x : ℝ) :
    deriv (fun s => heatKernel s x) t = (1/2)*deriv (deriv (heatKernel t)) x := by
  have he : deriv (heatKernel t) = fun y => -heatBoundaryKernel t y := by
    funext y
    rw [(heatKernel_hasDeriv_space ht y).deriv]
    unfold heatBoundaryKernel
    ring
  have hd : deriv (fun y => -heatBoundaryKernel t y) x = -((t-x^2)/t^2*heatKernel t x) := by
    rw [deriv.fun_neg']
    dsimp only
    rw [(heatBoundaryKernel_hasDeriv_space ht x).deriv]
  rw [(heatKernel_hasDeriv_time ht x).deriv,he,hd]
  ring

theorem causalHeatKernel_equation {t x : ℝ} (hz : t ≠ 0 ∨ x ≠ 0) :
    deriv (fun s => causalHeatKernel s x) t =
      (1/2)*deriv (deriv (causalHeatKernel t)) x := by
  have hc := causalHeatKernel_smoothAt hz
  rcases le_or_gt t 0 with ht | ht
  · have hm : IsLocalMin (fun s => causalHeatKernel s x) t := by
      apply Eventually.of_forall
      intro s
      change causalHeatKernel t x ≤ causalHeatKernel s x
      rw [causalHeatKernel_zero ht]
      exact causalHeatKernel_nonneg s x
    rw [hm.deriv_eq_zero]
    have he : causalHeatKernel t = fun _ => 0 := funext (causalHeatKernel_zero ht)
    simp [he]
  · have htime : (fun s => causalHeatKernel s x) =ᶠ[𝓝 t] (fun s => heatKernel s x) := by
      filter_upwards [Ioi_mem_nhds ht] with s hs
      exact causalHeatKernel_eq hs x
    have hspace : causalHeatKernel t = heatKernel t := funext (causalHeatKernel_eq ht)
    rw [htime.deriv_eq,hspace]
    exact heatKernel_equation ht x

noncomputable def causalHeatKernelPlane (z : ℝ × ℝ) : ℝ := causalHeatKernel z.1 z.2

theorem causalHeatKernelPlane_smoothAt {z : ℝ × ℝ} (hz : z.1 ≠ 0 ∨ z.2 ≠ 0) :
    ContDiffAt ℝ ∞ causalHeatKernelPlane z := causalHeatKernel_smoothAt hz

theorem causalHeatKernelPlane_equation {t x : ℝ} (hz : t ≠ 0 ∨ x ≠ 0) :
    heatPartial causalHeatKernelPlane (1,0) (t,x) =
      (1/2)*heatPartial (heatPartial causalHeatKernelPlane (0,1)) (0,1) (t,x) := by
  have hc := causalHeatKernelPlane_smoothAt (z := (t,x)) hz
  have ht := heatPartial_time (hc.differentiableAt (by simp))
  have hx := heatPartial_space ((heatPartial_smoothAt hc (0,1)).differentiableAt (by simp))
  have hnear : ∀ᶠ y in 𝓝 x, t ≠ 0 ∨ y ≠ 0 := by
    rcases hz with ht | hx
    · exact Eventually.of_forall (fun _ => Or.inl ht)
    · filter_upwards [isOpen_ne.mem_nhds hx] with y hy
      exact Or.inr hy
  have he : (fun y => heatPartial causalHeatKernelPlane (0,1) (t,y)) =ᶠ[𝓝 x]
      deriv (causalHeatKernel t) := by
    filter_upwards [hnear] with y hy
    exact (heatPartial_space ((causalHeatKernelPlane_smoothAt hy).differentiableAt (by simp))).deriv.symm
  rw [← ht.deriv,← hx.deriv,he.deriv_eq]
  exact causalHeatKernel_equation hz

end AmericanConvexity.Stopping
