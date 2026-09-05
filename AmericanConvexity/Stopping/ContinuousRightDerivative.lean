import AmericanConvexity.Stopping.LocalThreeQuarterHolder
import Mathlib.Analysis.Calculus.MeanValue
import Mathlib.Analysis.Calculus.ContDiff.Deriv
import Mathlib.MeasureTheory.Integral.IntervalIntegral.FundThmCalculus

/-! # A continuous right derivative is an ordinary derivative

Compare the continuous function with the integral of its continuous proposed
derivative on a closed interval. Uniqueness for right derivatives gives equality
on that interval, hence ordinary differentiability at every interior point.
-/

namespace AmericanConvexity.Stopping

open Set Filter MeasureTheory
open scoped Topology

theorem hasDerivAt_of_continuous_right_derivative {f g : ℝ → ℝ} {U : Set ℝ}
    (hU : IsOpen U) (hf : ContinuousOn f U) (hg : ContinuousOn g U)
    (hd : ∀ x ∈ U, HasDerivWithinAt f (g x) (Ici x) x) {t : ℝ} (ht : t ∈ U) :
    HasDerivAt f (g t) t := by
  obtain ⟨ε,hε,_,hsub⟩ := exists_short_closed_window (hU.mem_nhds ht)
  let a := t-ε
  let b := t+ε
  let P := fun x : ℝ => f a+∫ s in a..x, g s
  have hP : ∀ x ∈ Icc a b, HasDerivAt P (g x) x := by
    intro x hx
    have hxU := hsub hx
    have hi : IntervalIntegrable g volume a x := by
      apply ContinuousOn.intervalIntegrable
      rw [uIcc_of_le hx.1]
      exact hg.mono (fun s hs => hsub ⟨hs.1,hs.2.trans hx.2⟩)
    simpa only [P,zero_add] using!
      (hasDerivAt_const x (f a)).add (intervalIntegral.integral_hasDerivAt_right hi
        (hg.stronglyMeasurableAtFilter hU _ hxU)
        ((hg x hxU).continuousAt (hU.mem_nhds hxU)))
  have he : ∀ x ∈ Icc a b, f x = P x := by
    apply eq_of_has_deriv_right_eq
      (fun x hx => hd x (hsub ⟨hx.1,hx.2.le⟩))
      (fun x hx => (hP x ⟨hx.1,hx.2.le⟩).hasDerivWithinAt)
      (hf.mono hsub) (fun x hx => (hP x hx).continuousAt.continuousWithinAt)
    simp [P,a]
  have hevent : f =ᶠ[𝓝 t] P := by
    filter_upwards [Ioo_mem_nhds (show a < t by dsimp [a]; linarith)
      (show t < b by dsimp [b]; linarith)] with x hx
    exact he x ⟨hx.1.le,hx.2.le⟩
  exact (hP t ⟨by dsimp [a]; linarith,by dsimp [b]; linarith⟩).congr_of_eventuallyEq hevent

theorem contDiffOn_one_of_continuous_right_derivative {f g : ℝ → ℝ} {U : Set ℝ}
    (hU : IsOpen U) (hf : ContinuousOn f U) (hg : ContinuousOn g U)
    (hd : ∀ x ∈ U, HasDerivWithinAt f (g x) (Ici x) x) : ContDiffOn ℝ 1 f U := by
  have hder := fun x hx => hasDerivAt_of_continuous_right_derivative hU hf hg hd (t := x) hx
  apply (contDiffOn_one_iff_derivWithin hU.uniqueDiffOn).mpr
  refine ⟨fun x hx => (hder x hx).differentiableAt.differentiableWithinAt,?_⟩
  exact hg.congr (fun x hx => (hder x hx).hasDerivWithinAt.derivWithin
    (hU.uniqueDiffOn x hx))

end AmericanConvexity.Stopping
