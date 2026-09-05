import AmericanConvexity.Stopping.ActualHeatGradientTrace
import AmericanConvexity.Stopping.ActualThetaFlux

/-! # Joint continuation-side convergence to the actual pricing-theta flux

The inverse gauge transfers the joint heat-gradient extension to pricing
theta. The gauge derivative term is retained inside continuation and vanishes
at contact. This is stronger than a fixed-time right derivative and does not
assert a two-sided derivative of the zero exercise extension.
-/

namespace AmericanConvexity.Stopping

open Set Filter Boundary
open scoped Topology

theorem canonicalTheta_hasDerivAt_of_heat_gradient {k h x t v : ℝ}
    (hd : HasDerivAt (fun y => canonicalHeatTheta k h (y,2*t)) v x) :
    HasDerivAt (fun y => canonicalTheta k h y t)
      (-((k-h-1)/2)*canonicalTheta k h x t+inverseThetaHeatGauge k h x t*v) x := by
  have hg := (inverseThetaHeatGauge_hasDeriv_space k h x t).mul hd
  change HasDerivAt (fun y => inverseThetaHeatGauge k h y t*canonicalHeatTheta k h (y,2*t))
    (-((k-h-1)/2)*inverseThetaHeatGauge k h x t*canonicalHeatTheta k h (x,2*t)+
      inverseThetaHeatGauge k h x t*v) x at hg
  have he : (fun y => inverseThetaHeatGauge k h y t*canonicalHeatTheta k h (y,2*t)) =
      (fun y => canonicalTheta k h y t) := funext (fun y => (canonicalTheta_eq_inverse_heat k h y t).symm)
  rw [he,mul_assoc,← canonicalTheta_eq_inverse_heat] at hg
  exact hg

theorem exists_canonicalTheta_local_rightGradient {k h t : ℝ}
    (hk : 0 < k) (hh : 0 ≤ h) (hhk : h ≤ k) (ht : 0 < t) :
    ∃ F : ℝ × ℝ → ℝ, ContinuousAt F (canonicalLogBoundary k h t,t) ∧
      F (canonicalLogBoundary k h t,t) = canonicalThetaRightFlux k h t ∧
      ∀ᶠ z in 𝓝 (canonicalLogBoundary k h t,t),
        canonicalLogBoundary k h z.2 < z.1 →
        HasDerivAt (fun x => canonicalTheta k h x z.2) (F z) z.1 := by
  obtain ⟨G,hG,hGb,hGi⟩ := exists_canonicalHeatTheta_local_rightGradient hk hh hhk ht
  let F := fun z : ℝ × ℝ => -((k-h-1)/2)*canonicalTheta k h z.1 z.2+
    inverseThetaHeatGauge k h z.1 z.2*G (z.1,2*z.2)
  have hmap : ContinuousAt (fun z : ℝ × ℝ => (z.1,2*z.2)) (canonicalLogBoundary k h t,t) := by fun_prop
  have hFc : ContinuousAt F (canonicalLogBoundary k h t,t) := by
    apply ContinuousAt.add
    · exact (canonicalTheta_continuousAt hk hh hhk ht).const_mul _
    · apply ContinuousAt.mul
      · unfold inverseThetaHeatGauge
        fun_prop
      · exact hG.comp (x := (canonicalLogBoundary k h t,t))
          (f := fun z : ℝ × ℝ => (z.1,2*z.2)) hmap
  have hGb' := canonicalTheta_hasDerivWithinAt_of_heat_flux hk hh hhk ht hGb
  have hvalue : F (canonicalLogBoundary k h t,t) = canonicalThetaRightFlux k h t := by
    dsimp [F]
    rw [canonicalTheta_exercise_zero hk hh hhk ht le_rfl,mul_zero,zero_add]
    exact (hGb'.derivWithin (uniqueDiffWithinAt_Ici _)).symm
  refine ⟨F,hFc,hvalue,?_⟩
  filter_upwards [hmap.preimage_mem_nhds hGi] with z hz
  change (canonicalLogBoundary k h ((2*z.2)/2) < z.1 →
    HasDerivAt (fun x => canonicalHeatTheta k h (x,2*z.2)) (G (z.1,2*z.2)) z.1) at hz
  rw [show (2*z.2)/2 = z.2 by ring] at hz
  intro hx
  exact canonicalTheta_hasDerivAt_of_heat_gradient (hz hx)

theorem canonicalTheta_gradient_tendsto_contact {k h t : ℝ}
    (hk : 0 < k) (hh : 0 ≤ h) (hhk : h ≤ k) (ht : 0 < t) :
    Tendsto (fun z : ℝ × ℝ => deriv (fun x => canonicalTheta k h x z.2) z.1)
      (𝓝[{z : ℝ × ℝ | canonicalLogBoundary k h z.2 < z.1}]
        (canonicalLogBoundary k h t,t)) (𝓝 (canonicalThetaRightFlux k h t)) := by
  obtain ⟨F,hF,hFb,hFi⟩ := exists_canonicalTheta_local_rightGradient hk hh hhk ht
  rw [← hFb]
  apply (hF.tendsto.mono_left nhdsWithin_le_nhds).congr'
  filter_upwards [nhdsWithin_le_nhds hFi,self_mem_nhdsWithin] with z hz hzc
  exact (hz hzc).deriv.symm

theorem zeroDividend_canonicalTheta_gradient_tendsto_contact {k t : ℝ}
    (hk : 0 < k) (ht : 0 < t) :
    Tendsto (fun z : ℝ × ℝ => deriv (fun x => canonicalTheta k 0 x z.2) z.1)
      (𝓝[{z : ℝ × ℝ | canonicalLogBoundary k 0 z.2 < z.1}]
        (canonicalLogBoundary k 0 t,t)) (𝓝 (canonicalThetaRightFlux k 0 t)) :=
  canonicalTheta_gradient_tendsto_contact hk le_rfl hk.le ht

theorem liuRange_canonicalTheta_gradient_tendsto_contact {k h t : ℝ}
    (hh : 0 ≤ h) (hliu : h+1 ≤ k) (ht : 0 < t) :
    Tendsto (fun z : ℝ × ℝ => deriv (fun x => canonicalTheta k h x z.2) z.1)
      (𝓝[{z : ℝ × ℝ | canonicalLogBoundary k h z.2 < z.1}]
        (canonicalLogBoundary k h t,t)) (𝓝 (canonicalThetaRightFlux k h t)) :=
  canonicalTheta_gradient_tendsto_contact (by linarith) hh (by linarith) ht

end AmericanConvexity.Stopping
