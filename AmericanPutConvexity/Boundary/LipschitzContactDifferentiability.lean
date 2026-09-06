import Mathlib.Analysis.Calculus.MeanValue
import Mathlib.Topology.MetricSpace.Lipschitz

/-! # Joint differentiability at a spatially flat Lipschitz contact graph

If a function vanishes on a Lipschitz graph and its spatial derivative is
continuous and zero at contact, its full first derivative at contact is zero.
The graph itself need not be differentiable.
-/

namespace AmericanPutConvexity.Boundary

open Set Filter
open scoped Topology

theorem hasFDerivAt_zero_of_flat_lipschitz_contact {U : ℝ → ℝ → ℝ} {b : ℝ → ℝ}
    {t C : ℝ} (hC : 0 ≤ C) (hb : ContinuousAt b t)
    (hlip : ∀ᶠ s in 𝓝 t, ‖b s-b t‖ ≤ C*‖s-t‖)
    (hzero : ∀ᶠ s in 𝓝 t, U (b s) s = 0)
    (hdiff : ∀ᶠ s in 𝓝 t, ∀ x, DifferentiableAt ℝ (fun y => U y s) x)
    (hg : ContinuousAt (fun z : ℝ × ℝ => deriv (fun y => U y z.2) z.1) (b t,t))
    (hgzero : deriv (fun y => U y t) (b t) = 0) :
    HasFDerivAt (fun z : ℝ × ℝ => U z.1 z.2) (0 : (ℝ × ℝ) →L[ℝ] ℝ) (b t,t) := by
  rw [hasFDerivAt_iff_isLittleO,Asymptotics.isLittleO_iff]
  intro ε hε
  have hden : 0 < C+1 := by linarith
  have htol : 0 < ε/(C+1) := div_pos hε hden
  have hgn : ContinuousAt (fun z : ℝ × ℝ => ‖deriv (fun y => U y z.2) z.1‖) (b t,t) := hg.norm
  have hnear : {z : ℝ × ℝ | ‖deriv (fun y => U y z.2) z.1‖ < ε/(C+1)} ∈ 𝓝 (b t,t) := by
    apply hgn.eventually (Iio_mem_nhds _)
    simpa only [hgzero,norm_zero] using htol
  obtain ⟨δ,hδ,hδball⟩ := Metric.mem_nhds_iff.mp hnear
  have hxnear : ∀ᶠ z : ℝ × ℝ in 𝓝 (b t,t), |z.1-b t| < δ := by
    have hc : ContinuousAt (fun z : ℝ × ℝ => z.1) (b t,t) := continuousAt_fst
    simpa only [Metric.mem_ball,Real.dist_eq] using
      (hc.tendsto.eventually (Metric.ball_mem_nhds (b t) hδ))
  have htnear : ∀ᶠ z : ℝ × ℝ in 𝓝 (b t,t), |z.2-t| < δ := by
    have hc : ContinuousAt (fun z : ℝ × ℝ => z.2) (b t,t) := continuousAt_snd
    simpa only [Metric.mem_ball,Real.dist_eq] using
      (hc.tendsto.eventually (Metric.ball_mem_nhds t hδ))
  have hbnear : ∀ᶠ z : ℝ × ℝ in 𝓝 (b t,t), |b z.2-b t| < δ := by
    have hc : ContinuousAt (fun z : ℝ × ℝ => b z.2) (b t,t) := hb.comp continuousAt_snd
    simpa only [Metric.mem_ball,Real.dist_eq] using
      (hc.tendsto.eventually (Metric.ball_mem_nhds (b t) hδ))
  have hzero0 : U (b t) t = 0 := hzero.self_of_nhds
  filter_upwards [hxnear,htnear,hbnear,continuousAt_snd.tendsto.eventually hlip,
    continuousAt_snd.tendsto.eventually hzero,continuousAt_snd.tendsto.eventually hdiff]
    with z hx ht hbs hl hz hd
  have hgrad (y : ℝ) (hy : y ∈ Ioo (b t-δ) (b t+δ)) :
      ‖deriv (fun w => U w z.2) y‖ ≤ ε/(C+1) := by
    have hmem : (y,z.2) ∈ Metric.ball (b t,t) δ := by
      rw [Metric.mem_ball,Prod.dist_eq,max_lt_iff,Real.dist_eq,Real.dist_eq]
      exact ⟨abs_lt.mpr ⟨by linarith [hy.1],by linarith [hy.2]⟩,ht⟩
    exact (hδball hmem).le
  have hxb : z.1 ∈ Ioo (b t-δ) (b t+δ) := by
    obtain ⟨h1,h2⟩ := abs_lt.mp hx
    constructor <;> linarith
  have hbb : b z.2 ∈ Ioo (b t-δ) (b t+δ) := by
    obtain ⟨h1,h2⟩ := abs_lt.mp hbs
    constructor <;> linarith
  have hmean := (convex_Ioo (b t-δ) (b t+δ)).norm_image_sub_le_of_norm_deriv_le
    (fun y _ => hd y) hgrad hbb hxb
  rw [hz,sub_zero] at hmean
  have hfst : ‖z.1-b t‖ ≤ ‖z-(b t,t)‖ := norm_fst_le (z-(b t,t))
  have hsnd : ‖z.2-t‖ ≤ ‖z-(b t,t)‖ := norm_snd_le (z-(b t,t))
  have hdist : ‖z.1-b z.2‖ ≤ (C+1)*‖z-(b t,t)‖ := by
    have htri : ‖z.1-b z.2‖ ≤ ‖z.1-b t‖+‖b z.2-b t‖ := by
      convert! norm_sub_le (z.1-b t) (b z.2-b t) using 1
      congr 1
      ring
    nlinarith [mul_le_mul_of_nonneg_left hsnd hC]
  have hfinal := hmean.trans (mul_le_mul_of_nonneg_left hdist htol.le)
  rw [← mul_assoc,div_mul_cancel₀ _ hden.ne'] at hfinal
  change ‖U z.1 z.2-U (b t) t-0‖ ≤ ε*‖z-(b t,t)‖
  simpa only [hzero0,sub_zero] using hfinal

end AmericanPutConvexity.Boundary
