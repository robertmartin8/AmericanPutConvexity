import AmericanConvexity.Stopping.ThreeQuarterRemainderDerivative

/-! # Genuine integrability of the frozen-history derivative

At a fixed observation time the reference slope and density value are held
constant. The explicit derivative is continuous away from the diagonal;
the three-quarter modulus supplies an integrable majorant at the diagonal.
This does not yet exchange differentiation with the moving-endpoint integral.
-/

namespace AmericanConvexity.Stopping

open Set Filter MeasureTheory
open MathFin.FeynmanKacHeatEquation
open scoped Topology

theorem heatBoundaryMotionDerivative_continuousAt
    {U X : ℝ → ℝ} {w t : ℝ} (hU : ContinuousAt U t) (hX : ContinuousAt X t)
    (hu : 0 < U t) :
    ContinuousAt (fun z => heatBoundaryMotionDerivative (U z) (X z) w) t := by
  have hpair := hU.prodMk hX
  have hK := (heatBoundaryKernel_smoothAt (x := X t) hu).continuousAt.comp (x := t) hpair
  have hG := (heatKernel_smoothAt (x := X t) hu).continuousAt.comp (x := t) hpair
  have hgrad := ((hU.sub (hX.pow 2)).div (hU.pow 2) (pow_ne_zero _ hu.ne')).mul hG
  have hc := ((hK.neg.div hU hu.ne').add
    (((continuousAt_const (y := w)).sub (hX.div (continuousAt_const.mul hU)
      (mul_ne_zero (by norm_num : (2 : ℝ) ≠ 0) hu.ne'))).mul hgrad))
  apply hc.congr_of_eventuallyEq
  filter_upwards [hU.preimage_mem_nhds (Ioi_mem_nhds hu)] with z hz
  change 0 < U z at hz
  simp only [heatBoundaryMotionDerivative,(heatBoundaryKernel_hasDeriv_space hz (X z)).deriv]
  rfl

theorem frozenHeatHistoryRemainder_deriv_source_continuousOn
    {b f : ℝ → ℝ} {t w v c T : ℝ} (hd : HasDerivAt b w t)
    (hb : ContinuousOn b (Ioo (t-T) t)) (hf : ContinuousOn f (Ioo (t-T) t)) :
    ContinuousOn (fun u => deriv (fun r => frozenHeatHistoryRemainder b f v c r (t-u)) t)
      (Ioo 0 T) := by
  intro u hu
  have hs : t-u ∈ Ioo (t-T) t := ⟨by linarith [hu.2],by linarith [hu.1]⟩
  have hbc := ((hb _ hs).continuousAt (isOpen_Ioo.mem_nhds hs)).comp
    (x := u) (f := fun z : ℝ => t-z) (by fun_prop)
  have hfc := ((hf _ hs).continuousAt (isOpen_Ioo.mem_nhds hs)).comp
    (x := u) (f := fun z : ℝ => t-z) (by fun_prop)
  have hM := heatBoundaryMotionDerivative_continuousAt (w := w)
    (continuousAt_id (x := u)) ((continuousAt_const (y := b t)).sub hbc) hu.1
  have hLin := heatBoundaryMotionDerivative_continuousAt (w := v)
    (continuousAt_id (x := u)) (show ContinuousAt (fun z : ℝ => v*z) u by fun_prop) hu.1
  apply ((hM.mul hfc).sub (hLin.mul (continuousAt_const (y := c)))).continuousWithinAt.congr
  · intro z hz
    rw [(frozenHeatHistoryRemainder_hasDerivAt (by linarith [hz.1] : t-z < t) hd).deriv]
    simp only [sub_sub_cancel]
    rfl
  · rw [(frozenHeatHistoryRemainder_hasDerivAt (by linarith [hu.1] : t-u < t) hd).deriv]
    simp only [sub_sub_cancel]
    rfl

theorem frozenHeatHistoryRemainder_deriv_integrable_threeQuarter
    {b f : ℝ → ℝ} {t w v c A L C D T : ℝ}
    (hT : 0 < T) (hT1 : T ≤ 1) (hA : 0 ≤ A) (hL : 0 ≤ L)
    (hd : HasDerivAt b w t) (hb : ContinuousOn b (Ioo (t-T) t))
    (hf : ContinuousOn f (Ioo (t-T) t)) (hv : ‖v‖ ≤ L)
    (hx : ∀ u ∈ Ioo 0 T, ‖b t-b (t-u)‖ ≤ L*u)
    (hr : ∀ u ∈ Ioo 0 T, ‖b t-b (t-u)-v*u‖ ≤ A*u*u^(3/4 : ℝ))
    (hw : ∀ u ∈ Ioo 0 T, ‖w-v‖ ≤ A*u^(3/4 : ℝ))
    (hfs : ∀ u ∈ Ioo 0 T, ‖f (t-u)‖ ≤ C)
    (hm : ∀ u ∈ Ioo 0 T, ‖f (t-u)-c‖ ≤ D*u^(3/4 : ℝ)) :
    IntegrableOn (fun u => deriv (fun r => frozenHeatHistoryRemainder b f v c r (t-u)) t) (Ioo 0 T) ∧
      ‖∫ u in Ioo 0 T, deriv (fun r => frozenHeatHistoryRemainder b f v c r (t-u)) t‖ ≤
        (4*(((8+5*L^2)*A*C+8*L*D)/Real.sqrt (2*Real.pi)))*T^(1/4 : ℝ) := by
  apply integrable_and_integral_of_inverse_threeQuarter_bound hT
    ((frozenHeatHistoryRemainder_deriv_source_continuousOn hd hb hf).aestronglyMeasurable measurableSet_Ioo)
  intro u hu
  have he := frozenHeatHistoryRemainder_deriv_threeQuarter_bound
    (t := t) (s := t-u) (by linarith [hu.1])
    (by linarith [hu.2]) hA hL hd
    (by simpa only [sub_sub_cancel] using hx u hu) hv
    (by simpa only [sub_sub_cancel] using hr u hu)
    (by simpa only [sub_sub_cancel] using hw u hu) (hfs u hu)
    (by simpa only [sub_sub_cancel] using hm u hu)
  simpa only [sub_sub_cancel] using he

end AmericanConvexity.Stopping
