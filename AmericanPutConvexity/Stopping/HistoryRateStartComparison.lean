import AmericanPutConvexity.Stopping.HistoryRateIntegrability
import AmericanPutConvexity.Stopping.HeatHistorySourceTime

/-! # Regularized rates at different causal starts

Changing the source start adds exactly the older-source motion derivative.
The frozen straight-line derivative integrates to its endpoint difference,
which cancels the change in the explicit endpoint term of the rate.
-/

namespace AmericanPutConvexity.Stopping

open Set MeasureTheory

theorem regularizedHistoryRate_split {b f : ℝ → ℝ} {a₀ a t : ℝ}
    (ha : a₀ < a) (hat : a < t)
    (hR : IntegrableOn (regularizedHistoryDerivative b f t) (Ioo 0 (t-a₀)))
    (hO : IntegrableOn (fun s => heatBoundaryMotionDerivative (t-s) (b t-b s) (deriv b t)*f s) (Ioo a₀ a)) :
    regularizedHistoryRate b f a₀ t =
      (∫ s in Ioo a₀ a, heatBoundaryMotionDerivative (t-s) (b t-b s) (deriv b t)*f s)+
      regularizedHistoryRate b f a t := by
  have hsmall : 0 < t-a := sub_pos.mpr hat
  have hle : t-a ≤ t-a₀ := by linarith
  have hi₁ : IntegrableOn (regularizedHistoryDerivative b f t) (Ioo 0 (t-a)) :=
    hR.mono_set (fun _ hu => ⟨hu.1,hu.2.trans_le hle⟩)
  have hi₂ : IntegrableOn (regularizedHistoryDerivative b f t) (Ioo (t-a) (t-a₀)) :=
    hR.mono_set (fun _ hu => ⟨hsmall.trans hu.1,hu.2⟩)
  have hOE : IntegrableOn (fun u => heatBoundaryMotionDerivative u (b t-b (t-u)) (deriv b t)*f (t-u))
      (Ioo (t-a) (t-a₀)) := by
    have he := (integrableOn_Ioo_reflect_iff _ ha.le t).mp hO
    simpa only [sub_sub_cancel] using he
  have heO : (∫ s in Ioo a₀ a, heatBoundaryMotionDerivative (t-s) (b t-b s) (deriv b t)*f s) =
      ∫ u in Ioo (t-a) (t-a₀), heatBoundaryMotionDerivative u (b t-b (t-u)) (deriv b t)*f (t-u) := by
    simpa only [sub_sub_cancel] using setIntegral_Ioo_reflect
      (fun s => heatBoundaryMotionDerivative (t-s) (b t-b s) (deriv b t)*f s) ha.le t
  have heR : (∫ u in Ioo (t-a) (t-a₀), regularizedHistoryDerivative b f t u) =
      (∫ s in Ioo a₀ a, heatBoundaryMotionDerivative (t-s) (b t-b s) (deriv b t)*f s)-
      (heatBoundaryKernel (t-a₀) (deriv b t*(t-a₀))*f t-
        heatBoundaryKernel (t-a) (deriv b t*(t-a))*f t) := by
    unfold regularizedHistoryDerivative
    rw [integral_sub hOE (linearHeatMotion_integrable hsmall),linearHeatMotion_integral hsmall hle,← heO]
  unfold regularizedHistoryRate
  rw [setIntegral_Ioo_split hsmall.le hle hi₁ hi₂,heR]
  ring

theorem canonicalRegularizedHistoryRate_split {k h a₀ a t : ℝ} {f : ℝ → ℝ}
    (hk : 0 < k) (hh : 0 ≤ h) (hhk : h ≤ k) (ha₀ : 0 < a₀) (ha : a₀ < a) (hat : a < t)
    (hf : Continuous f) (hm : LocalThreeQuarterHolderAt f t) :
    regularizedHistoryRate (fun s => canonicalLogBoundary k h (s/2)) f a₀ t =
      (∫ s in Ioo a₀ a, heatBoundaryMotionDerivative (t-s)
        (canonicalLogBoundary k h (t/2)-canonicalLogBoundary k h (s/2))
        (deriv (fun u => canonicalLogBoundary k h (u/2)) t)*f s)+
      regularizedHistoryRate (fun s => canonicalLogBoundary k h (s/2)) f a t :=
  regularizedHistoryRate_split ha hat
    (canonicalRegularizedHistoryDerivative_integrable hk hh hhk ha₀ (ha.trans hat) hf hm)
    (canonicalOlderHistoryRate_integrable hk hh hhk ha₀ hat hf)

end AmericanPutConvexity.Stopping
