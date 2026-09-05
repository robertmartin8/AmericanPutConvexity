import AmericanConvexity.Stopping.HeatHistoryReference
import Mathlib.MeasureTheory.Integral.IntervalIntegral.FundThmCalculus

/-! # Derivative of the frozen straight-line reference integral -/

namespace AmericanConvexity.Stopping

open Set Filter MeasureTheory
open scoped Topology

theorem linearHeatHistoryIntegral_hasDerivAt {v c T : ℝ} (hT : 0 < T) :
    HasDerivAt (linearHeatHistoryIntegral v c) (heatBoundaryKernel T (v*T)*c) T := by
  have hc : ContinuousOn (fun u => heatBoundaryKernel u (v*u)*c) (Ioi 0) := by
    intro u hu
    exact (((heatBoundaryKernel_smoothAt hu).continuousAt.comp
      (x := u) (f := fun z : ℝ => (z,v*z)) (by fun_prop)).mul continuousAt_const).continuousWithinAt
  have hi := (intervalIntegrable_iff_integrableOn_Ioo_of_le hT.le).mpr
    (linearHeatHistory_integrable hT v c)
  have hd := intervalIntegral.integral_hasDerivAt_right hi
    (hc.stronglyMeasurableAtFilter isOpen_Ioi _ hT) ((hc T hT).continuousAt (Ioi_mem_nhds hT))
  apply hd.congr_of_eventuallyEq
  filter_upwards [Ioi_mem_nhds hT] with u hu
  rw [intervalIntegral.integral_of_le hu.le,integral_Ioc_eq_integral_Ioo]
  rfl

theorem linearHeatHistoryIntegral_shift_hasDerivAt {v c a t : ℝ} (hat : a < t) :
    HasDerivAt (fun r => linearHeatHistoryIntegral v c (r-a))
      (heatBoundaryKernel (t-a) (v*(t-a))*c) t := by
  simpa only [mul_one,id_eq,Function.comp_def] using!
    (linearHeatHistoryIntegral_hasDerivAt (v := v) (c := c) (sub_pos.mpr hat)).comp t
      ((hasDerivAt_id t).sub_const a)

end AmericanConvexity.Stopping
