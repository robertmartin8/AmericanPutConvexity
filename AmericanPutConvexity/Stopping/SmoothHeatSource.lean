import AmericanPutConvexity.Stopping.HeatSourcePotential
import AmericanPutConvexity.Stopping.PlanePricingDerivative
import Mathlib.Analysis.Calculus.ContDiff.Deriv

/-! # Derivatives of a smooth compact source's heat potential

When the source is smooth and compact, its derivatives are bounded. Gaussian
averaging and finite elapsed-time integration therefore commute with spatial
and time derivatives without singular bounds. This is the smooth-source
part of the local inhomogeneous heat-equation argument.
-/

namespace AmericanPutConvexity.Stopping

open Set Filter MeasureTheory
open MathFin.FeynmanKacHeatEquation
open scoped Topology ContDiff

theorem heatPartial_contDiff {Q : ℝ × ℝ → ℝ} (hQ : ContDiff ℝ ∞ Q) (v : ℝ × ℝ) :
    ContDiff ℝ ∞ (heatPartial Q v) :=
  contDiff_iff_contDiffAt.mpr (fun _ => heatPartial_smoothAt hQ.contDiffAt v)

theorem heatPartial_hasCompactSupport {Q : ℝ × ℝ → ℝ} (hc : HasCompactSupport Q) (v : ℝ × ℝ) :
    HasCompactSupport (heatPartial Q v) := hc.fderiv_apply ℝ v

theorem heatSourceMoment_hasDeriv_space {Q : ℝ × ℝ → ℝ} {M : ℝ → ℝ}
    (hQ : ContDiff ℝ ∞ Q) (hc : HasCompactSupport Q) (hM : Integrable M) (u x t : ℝ) :
    HasDerivAt (fun y => heatSourceMoment M Q u (y,t))
      (heatSourceMoment M (heatPartial Q (1,0)) u (x,t)) x := by
  obtain ⟨C,hC⟩ := hc.exists_bound_of_continuous hQ.continuous
  have hD := heatPartial_contDiff hQ (1,0)
  obtain ⟨C',hC'⟩ := (heatPartial_hasCompactSupport hc (1,0)).exists_bound_of_continuous hD.continuous
  apply (hasDerivAt_integral_of_dominated_loc_of_deriv_le
    (F := fun v y => M y*Q (v+Real.sqrt u*y,t-u))
    (F' := fun v y => M y*heatPartial Q (1,0) (v+Real.sqrt u*y,t-u))
    (bound := fun y => ‖M y‖*C') (s := univ) (by simp)
    (Eventually.of_forall (fun v => (heatSourceMoment_integrable hM hQ.continuous hC u (v,t)).aestronglyMeasurable))
    (heatSourceMoment_integrable hM hQ.continuous hC u (x,t))
    ((heatSourceMoment_integrable hM hD.continuous hC' u (x,t)).aestronglyMeasurable)
    (Eventually.of_forall (fun y v _ => by
      rw [norm_mul]
      exact mul_le_mul_of_nonneg_left (hC' _) (norm_nonneg _)))
    (hM.norm.mul_const C') ?_).2
  apply Eventually.of_forall
  intro y v _
  have hd := (heatPartial_time (x := t-u) (hQ.contDiffAt.differentiableAt (by simp))).comp v
    ((hasDerivAt_id v).add_const (Real.sqrt u*y))
  simpa only [mul_one,id_eq,Function.comp_apply] using! hd.const_mul (M y)

theorem heatSourceMoment_hasDeriv_time {Q : ℝ × ℝ → ℝ} {M : ℝ → ℝ}
    (hQ : ContDiff ℝ ∞ Q) (hc : HasCompactSupport Q) (hM : Integrable M) (u x t : ℝ) :
    HasDerivAt (fun s => heatSourceMoment M Q u (x,s))
      (heatSourceMoment M (heatPartial Q (0,1)) u (x,t)) t := by
  obtain ⟨C,hC⟩ := hc.exists_bound_of_continuous hQ.continuous
  have hD := heatPartial_contDiff hQ (0,1)
  obtain ⟨C',hC'⟩ := (heatPartial_hasCompactSupport hc (0,1)).exists_bound_of_continuous hD.continuous
  apply (hasDerivAt_integral_of_dominated_loc_of_deriv_le
    (F := fun s y => M y*Q (x+Real.sqrt u*y,s-u))
    (F' := fun s y => M y*heatPartial Q (0,1) (x+Real.sqrt u*y,s-u))
    (bound := fun y => ‖M y‖*C') (s := univ) (by simp)
    (Eventually.of_forall (fun s => (heatSourceMoment_integrable hM hQ.continuous hC u (x,s)).aestronglyMeasurable))
    (heatSourceMoment_integrable hM hQ.continuous hC u (x,t))
    ((heatSourceMoment_integrable hM hD.continuous hC' u (x,t)).aestronglyMeasurable)
    (Eventually.of_forall (fun y s _ => by
      rw [norm_mul]
      exact mul_le_mul_of_nonneg_left (hC' _) (norm_nonneg _)))
    (hM.norm.mul_const C') ?_).2
  apply Eventually.of_forall
  intro y s _
  have hd := (heatPartial_space (t := x+Real.sqrt u*y) (hQ.contDiffAt.differentiableAt (by simp))).comp s
    ((hasDerivAt_id s).sub_const u)
  simpa only [mul_one,id_eq,Function.comp_apply] using! hd.const_mul (M y)

theorem smooth_heatSourcePotential_hasDeriv_space {Q : ℝ × ℝ → ℝ}
    (hQ : ContDiff ℝ ∞ Q) (hc : HasCompactSupport Q) (D x t : ℝ) :
    HasDerivAt (fun y => heatSourcePotential Q D (y,t))
      (heatSourcePotential (heatPartial Q (1,0)) D (x,t)) x := by
  obtain ⟨C,hC⟩ := hc.exists_bound_of_continuous hQ.continuous
  have hD := heatPartial_contDiff hQ (1,0)
  obtain ⟨C',hC'⟩ := (heatPartial_hasCompactSupport hc (1,0)).exists_bound_of_continuous hD.continuous
  apply (hasDerivAt_integral_of_dominated_loc_of_deriv_le
    (F := fun y u => heatSourceAverage Q u (y,t))
    (F' := fun y u => heatSourceAverage (heatPartial Q (1,0)) u (y,t))
    (bound := fun _ => heatSourceAverageConstant*C') (s := univ) (by simp)
    (Eventually.of_forall (fun y => (heatSourceAverage_integrable_time hQ.continuous hC (y,t)).aestronglyMeasurable))
    (heatSourceAverage_integrable_time hQ.continuous hC (x,t))
    ((heatSourceAverage_integrable_time hD.continuous hC' (x,t)).aestronglyMeasurable)
    (Eventually.of_forall (fun u y _ => heatSourceAverage_bound hC' u (y,t)))
    (integrableOn_const (hs := measure_Ioo_lt_top.ne))
    (Eventually.of_forall (fun u y _ => heatSourceMoment_hasDeriv_space hQ hc
      (integrable_heatKernel (by norm_num)) u y t))).2

theorem smooth_heatSourcePotential_hasDeriv_time {Q : ℝ × ℝ → ℝ}
    (hQ : ContDiff ℝ ∞ Q) (hc : HasCompactSupport Q) (D x t : ℝ) :
    HasDerivAt (fun s => heatSourcePotential Q D (x,s))
      (heatSourcePotential (heatPartial Q (0,1)) D (x,t)) t := by
  obtain ⟨C,hC⟩ := hc.exists_bound_of_continuous hQ.continuous
  have hD := heatPartial_contDiff hQ (0,1)
  obtain ⟨C',hC'⟩ := (heatPartial_hasCompactSupport hc (0,1)).exists_bound_of_continuous hD.continuous
  apply (hasDerivAt_integral_of_dominated_loc_of_deriv_le
    (F := fun s u => heatSourceAverage Q u (x,s))
    (F' := fun s u => heatSourceAverage (heatPartial Q (0,1)) u (x,s))
    (bound := fun _ => heatSourceAverageConstant*C') (s := univ) (by simp)
    (Eventually.of_forall (fun s => (heatSourceAverage_integrable_time hQ.continuous hC (x,s)).aestronglyMeasurable))
    (heatSourceAverage_integrable_time hQ.continuous hC (x,t))
    ((heatSourceAverage_integrable_time hD.continuous hC' (x,t)).aestronglyMeasurable)
    (Eventually.of_forall (fun u s _ => heatSourceAverage_bound hC' u (x,s)))
    (integrableOn_const (hs := measure_Ioo_lt_top.ne))
    (Eventually.of_forall (fun u s _ => heatSourceMoment_hasDeriv_time hQ hc
      (integrable_heatKernel (by norm_num)) u x s))).2

theorem smooth_heatSourcePotential_deriv2_space {Q : ℝ × ℝ → ℝ}
    (hQ : ContDiff ℝ ∞ Q) (hc : HasCompactSupport Q) (D x t : ℝ) :
    deriv (deriv (fun y => heatSourcePotential Q D (y,t))) x =
      heatSourcePotential (heatPartial (heatPartial Q (1,0)) (1,0)) D (x,t) := by
  have he : deriv (fun y => heatSourcePotential Q D (y,t)) =
      (fun y => heatSourcePotential (heatPartial Q (1,0)) D (y,t)) :=
    funext (fun y => (smooth_heatSourcePotential_hasDeriv_space hQ hc D y t).deriv)
  rw [he]
  exact (smooth_heatSourcePotential_hasDeriv_space (heatPartial_contDiff hQ (1,0))
    (heatPartial_hasCompactSupport hc (1,0)) D x t).deriv

theorem smooth_heatSourceSpatial_eq_average_partial {Q : ℝ × ℝ → ℝ} {u : ℝ}
    (hQ : ContDiff ℝ ∞ Q) (hc : HasCompactSupport Q) (hu : 0 < u) (z : ℝ × ℝ) :
    heatSourceSpatial Q u z = heatSourceAverage (heatPartial Q (1,0)) u z :=
  (heatSourceAverage_hasDerivAt hQ.continuous hc hu z.1 z.2).unique
    (heatSourceMoment_hasDeriv_space hQ hc (integrable_heatKernel (by norm_num)) u z.1 z.2)

theorem smooth_heatSourcePotential_contDiff_space {Q : ℝ × ℝ → ℝ}
    (hQ : ContDiff ℝ ∞ Q) (hc : HasCompactSupport Q) (D t : ℝ) (n : ℕ) :
    ContDiff ℝ n (fun x => heatSourcePotential Q D (x,t)) := by
  induction n generalizing Q with
  | zero =>
    obtain ⟨C,hC⟩ := hc.exists_bound_of_continuous hQ.continuous
    exact contDiff_zero.mpr ((heatSourcePotential_continuous hQ.continuous hC).comp
      (continuous_id.prodMk continuous_const))
  | succ n ih =>
    rw [show ((n+1 : ℕ) : ℕ∞ω) = (n : ℕ∞ω)+1 by norm_cast,contDiff_succ_iff_deriv]
    refine ⟨fun x => (smooth_heatSourcePotential_hasDeriv_space hQ hc D x t).differentiableAt,
      by simp,?_⟩
    have he : deriv (fun x => heatSourcePotential Q D (x,t)) =
        (fun x => heatSourcePotential (heatPartial Q (1,0)) D (x,t)) :=
      funext (fun x => (smooth_heatSourcePotential_hasDeriv_space hQ hc D x t).deriv)
    rw [he]
    exact ih (heatPartial_contDiff hQ (1,0)) (heatPartial_hasCompactSupport hc (1,0))

end AmericanPutConvexity.Stopping
