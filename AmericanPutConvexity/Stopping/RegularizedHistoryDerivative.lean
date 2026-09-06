import AmericanPutConvexity.Stopping.FrozenDerivativeIntegrability

/-! # Explicit regularized history derivative with moving reference values

The reference values vary when checking continuity of this formula, but
remain frozen when interpreting it as a derivative at a particular time.
Continuity therefore only requires continuity of the velocity and density,
not their derivatives.
-/

namespace AmericanPutConvexity.Stopping

open Set Filter MeasureTheory
open MathFin.FeynmanKacHeatEquation
open scoped Topology

noncomputable def regularizedHistoryDerivative (b f : ℝ → ℝ) (t u : ℝ) : ℝ :=
  heatBoundaryMotionDerivative u (b t-b (t-u)) (deriv b t)*f (t-u)-
    heatBoundaryMotionDerivative u (deriv b t*u) (deriv b t)*f t

theorem regularizedHistoryDerivative_eq_frozen_deriv {b f : ℝ → ℝ} {t u : ℝ}
    (hu : 0 < u) (hb : DifferentiableAt ℝ b t) :
    regularizedHistoryDerivative b f t u =
      deriv (fun r => frozenHeatHistoryRemainder b f (deriv b t) (f t) r (t-u)) t := by
  rw [(frozenHeatHistoryRemainder_hasDerivAt (by linarith : t-u < t) hb.hasDerivAt).deriv]
  simp only [sub_sub_cancel,regularizedHistoryDerivative]

theorem heatBoundaryMotionDerivative_continuousAt_varying
    {α : Type*} [TopologicalSpace α] {U X W : α → ℝ} {t : α}
    (hU : ContinuousAt U t) (hX : ContinuousAt X t)
    (hW : ContinuousAt W t) (hu : 0 < U t) :
    ContinuousAt (fun z => heatBoundaryMotionDerivative (U z) (X z) (W z)) t := by
  have hpair := hU.prodMk hX
  have hK := (heatBoundaryKernel_smoothAt (x := X t) hu).continuousAt.comp (x := t) hpair
  have hG := (heatKernel_smoothAt (x := X t) hu).continuousAt.comp (x := t) hpair
  have hgrad := ((hU.sub (hX.pow 2)).div (hU.pow 2) (pow_ne_zero _ hu.ne')).mul hG
  have hc := (hK.neg.div hU hu.ne').add
    ((hW.sub (hX.div (continuousAt_const.mul hU)
      (mul_ne_zero (by norm_num : (2 : ℝ) ≠ 0) hu.ne'))).mul hgrad)
  apply hc.congr_of_eventuallyEq
  filter_upwards [hU.preimage_mem_nhds (Ioi_mem_nhds hu)] with z hz
  change 0 < U z at hz
  simp only [heatBoundaryMotionDerivative,(heatBoundaryKernel_hasDeriv_space hz (X z)).deriv]
  rfl

theorem regularizedHistoryDerivative_continuousAt_time {b f : ℝ → ℝ} {t u : ℝ}
    (hu : 0 < u) (hbt : ContinuousAt b t) (hbs : ContinuousAt b (t-u))
    (hbv : ContinuousAt (deriv b) t) (hft : ContinuousAt f t) (hfs : ContinuousAt f (t-u)) :
    ContinuousAt (fun r => regularizedHistoryDerivative b f r u) t := by
  have hc : ContinuousAt (fun r : ℝ => r-u) t := by fun_prop
  have hM := heatBoundaryMotionDerivative_continuousAt_varying (continuousAt_const (y := u))
    (hbt.sub (hbs.comp (x := t) (f := fun r : ℝ => r-u) hc)) hbv hu
  have hLin := heatBoundaryMotionDerivative_continuousAt_varying (continuousAt_const (y := u))
    (hbv.mul (continuousAt_const (y := u))) hbv hu
  exact (hM.mul (hfs.comp (x := t) (f := fun r : ℝ => r-u) hc)).sub (hLin.mul hft)

theorem regularizedHistoryDerivative_source_continuousOn {b f : ℝ → ℝ} {t T : ℝ}
    (hb : DifferentiableAt ℝ b t) (hbc : ContinuousOn b (Ioo (t-T) t))
    (hf : ContinuousOn f (Ioo (t-T) t)) :
    ContinuousOn (regularizedHistoryDerivative b f t) (Ioo 0 T) := by
  apply (frozenHeatHistoryRemainder_deriv_source_continuousOn hb.hasDerivAt hbc hf).congr
  intro u hu
  exact regularizedHistoryDerivative_eq_frozen_deriv hu.1 hb

theorem regularizedHistoryDerivative_threeQuarter_bound
    {b f : ℝ → ℝ} {t u A L C D : ℝ} (hu : 0 < u) (hu1 : u ≤ 1)
    (hA : 0 ≤ A) (hL : 0 ≤ L) (hb : DifferentiableAt ℝ b t)
    (hx : ‖b t-b (t-u)‖ ≤ L*u) (hv : ‖deriv b t‖ ≤ L)
    (hr : ‖b t-b (t-u)-deriv b t*u‖ ≤ A*u*u^(3/4 : ℝ))
    (hfs : ‖f (t-u)‖ ≤ C) (hm : ‖f (t-u)-f t‖ ≤ D*u^(3/4 : ℝ)) :
    ‖regularizedHistoryDerivative b f t u‖ ≤
      (((8+5*L^2)*A*C+8*L*D)/Real.sqrt (2*Real.pi))*u^(-3/4 : ℝ) := by
  rw [regularizedHistoryDerivative_eq_frozen_deriv hu hb]
  have he := frozenHeatHistoryRemainder_deriv_threeQuarter_bound
    (t := t) (s := t-u) (by linarith) (by simpa only [sub_sub_cancel] using hu1) hA hL hb.hasDerivAt
    (by simpa only [sub_sub_cancel] using hx) hv
    (by simpa only [sub_sub_cancel] using hr)
    (by simp only [sub_self,norm_zero,sub_sub_cancel]; exact mul_nonneg hA (Real.rpow_nonneg hu.le _))
    hfs (by simpa only [sub_sub_cancel] using hm)
  simpa only [sub_sub_cancel] using he

end AmericanPutConvexity.Stopping
