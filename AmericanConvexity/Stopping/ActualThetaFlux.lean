import AmericanConvexity.Stopping.ActualHeatFlux
import AmericanConvexity.Stopping.ActualThetaContactGrowth

/-! # The positive continuous right boundary derivative of pricing theta

The inverse heat gauge transfers the constructed one-sided derivative back
to pricing time. The gauge's derivative term vanishes because theta is zero
at contact. Positivity follows from the already-proved linear lower bound.
This is not a two-sided spatial derivative of the zero exercise extension.
-/

namespace AmericanConvexity.Stopping

open Set Filter Boundary
open scoped Topology

noncomputable def inverseThetaHeatGauge (k h x t : ℝ) : ℝ :=
  Real.exp (-((k-h-1)/2*x+(k+(k-h-1)^2/4)*t))

theorem canonicalTheta_eq_inverse_heat (k h x t : ℝ) :
    canonicalTheta k h x t = inverseThetaHeatGauge k h x t*canonicalHeatTheta k h (x,2*t) := by
  unfold inverseThetaHeatGauge canonicalHeatTheta heatFromPrice
  dsimp only
  rw [show 2*t/2 = t by ring,show (k+(k-h-1)^2/4)*(2*t)/2 = (k+(k-h-1)^2/4)*t by ring,
    ← mul_assoc,← Real.exp_add,neg_add_cancel,Real.exp_zero,one_mul]

theorem inverseThetaHeatGauge_hasDeriv_space (k h x t : ℝ) :
    HasDerivAt (fun y => inverseThetaHeatGauge k h y t)
      (-((k-h-1)/2)*inverseThetaHeatGauge k h x t) x := by
  convert! (((((hasDerivAt_id x).const_mul ((k-h-1)/2)).add_const
    ((k+(k-h-1)^2/4)*t)).neg).exp) using 1
  simp [inverseThetaHeatGauge,mul_comm]

theorem canonicalTheta_hasDerivWithinAt_of_heat_flux {k h t v : ℝ}
    (hk : 0 < k) (hh : 0 ≤ h) (hhk : h ≤ k) (ht : 0 < t)
    (hd : HasDerivWithinAt (fun x => canonicalHeatTheta k h (x,2*t)) v
      (Ici (canonicalLogBoundary k h t)) (canonicalLogBoundary k h t)) :
    HasDerivWithinAt (fun x => canonicalTheta k h x t)
      (inverseThetaHeatGauge k h (canonicalLogBoundary k h t) t*v)
      (Ici (canonicalLogBoundary k h t)) (canonicalLogBoundary k h t) := by
  have hg := (inverseThetaHeatGauge_hasDeriv_space k h (canonicalLogBoundary k h t) t).hasDerivWithinAt.mul hd
  have hz : canonicalHeatTheta k h (canonicalLogBoundary k h t,2*t) = 0 :=
    canonicalHeatTheta_exercise_zero hk hh hhk (by positivity)
      (by rw [show (2*t)/2 = t by ring])
  have he : (fun x => inverseThetaHeatGauge k h x t*canonicalHeatTheta k h (x,2*t)) =
      (fun x => canonicalTheta k h x t) := funext (fun x => (canonicalTheta_eq_inverse_heat k h x t).symm)
  simp only [hz,mul_zero,zero_add] at hg
  change HasDerivWithinAt (fun x => inverseThetaHeatGauge k h x t*canonicalHeatTheta k h (x,2*t))
    (inverseThetaHeatGauge k h (canonicalLogBoundary k h t) t*v)
    (Ici (canonicalLogBoundary k h t)) (canonicalLogBoundary k h t) at hg
  rw [he] at hg
  exact hg

theorem exists_canonicalTheta_local_right_flux {k h t : ℝ}
    (hk : 0 < k) (hh : 0 ≤ h) (hhk : h ≤ k) (ht : 0 < t) :
    ∃ F : ℝ → ℝ, ContinuousAt F t ∧ ∀ᶠ s in 𝓝 t,
      HasDerivWithinAt (fun x => canonicalTheta k h x s) (F s)
        (Ici (canonicalLogBoundary k h s)) (canonicalLogBoundary k h s) := by
  obtain ⟨H,hH,htrace⟩ := exists_canonicalHeatTheta_continuous_right_flux hk hh hhk ht
  let F := fun s => inverseThetaHeatGauge k h (canonicalLogBoundary k h s) s*H (2*s)
  have hF : ContinuousAt F t := by
    apply ContinuousAt.mul
    · unfold inverseThetaHeatGauge
      apply Real.continuous_exp.continuousAt.comp
      exact (((canonicalLogBoundary_continuousAt hk hh hhk ht.le).const_mul _).add
        (continuousAt_id.const_mul _)).neg
    · exact hH.continuousAt.comp (x := t) (f := fun s : ℝ => 2*s) (by fun_prop)
  refine ⟨F,hF,?_⟩
  filter_upwards [(show ContinuousAt (fun s : ℝ => 2*s) t by fun_prop).preimage_mem_nhds htrace,
    Ioi_mem_nhds ht] with s hs hsp
  have hd : HasDerivWithinAt (fun x => canonicalHeatTheta k h (x,2*s)) (H (2*s))
      (Ici (canonicalLogBoundary k h s)) (canonicalLogBoundary k h s) := by
    change HasDerivWithinAt (fun x => canonicalHeatTheta k h (x,2*s)) (H (2*s))
      (Ici (canonicalLogBoundary k h ((2*s)/2))) (canonicalLogBoundary k h ((2*s)/2)) at hs
    simpa only [show 2*s/2 = s by ring] using hs
  exact canonicalTheta_hasDerivWithinAt_of_heat_flux hk hh hhk hsp hd

noncomputable def canonicalThetaRightFlux (k h t : ℝ) : ℝ :=
  derivWithin (fun x => canonicalTheta k h x t) (Ici (canonicalLogBoundary k h t))
    (canonicalLogBoundary k h t)

theorem canonicalTheta_hasDerivWithinAt_right_flux {k h t : ℝ}
    (hk : 0 < k) (hh : 0 ≤ h) (hhk : h ≤ k) (ht : 0 < t) :
    HasDerivWithinAt (fun x => canonicalTheta k h x t) (canonicalThetaRightFlux k h t)
      (Ici (canonicalLogBoundary k h t)) (canonicalLogBoundary k h t) := by
  obtain ⟨F,_,hF⟩ := exists_canonicalTheta_local_right_flux hk hh hhk ht
  have hd := hF.self_of_nhds
  rw [canonicalThetaRightFlux,hd.derivWithin (uniqueDiffWithinAt_Ici _)]
  exact hd

theorem canonicalThetaRightFlux_continuousAt {k h t : ℝ}
    (hk : 0 < k) (hh : 0 ≤ h) (hhk : h ≤ k) (ht : 0 < t) :
    ContinuousAt (canonicalThetaRightFlux k h) t := by
  obtain ⟨F,hFc,hF⟩ := exists_canonicalTheta_local_right_flux hk hh hhk ht
  apply hFc.congr_of_eventuallyEq
  filter_upwards [hF] with s hs
  exact hs.derivWithin (uniqueDiffWithinAt_Ici _)

theorem canonicalThetaRightFlux_pos {k h t : ℝ}
    (hk : 0 < k) (hh : 0 ≤ h) (hhk : h ≤ k) (ht : 0 < t) :
    0 < canonicalThetaRightFlux k h t := by
  have hd := (canonicalTheta_hasDerivWithinAt_right_flux hk hh hhk ht).mono Ioi_subset_Ici_self
  have hlim := (hasDerivWithinAt_iff_tendsto_slope' (by simp :
    canonicalLogBoundary k h t ∉ Ioi (canonicalLogBoundary k h t))).mp hd
  obtain ⟨δ,m,M,hδ,hm,_,hbound⟩ := canonicalTheta_contact_slope_bounds hk hh hhk ht
  apply hm.trans_le
  apply ge_of_tendsto hlim
  filter_upwards [self_mem_nhdsWithin,nhdsWithin_le_nhds
    (Iio_mem_nhds (show canonicalLogBoundary k h t < canonicalLogBoundary k h t+δ by linarith))]
    with x hx hxδ
  rw [slope_def_field,canonicalTheta_exercise_zero hk hh hhk ht le_rfl,sub_zero]
  exact (hbound x ⟨hx,hxδ⟩).1

theorem canonicalThetaRightFlux_continuousOn {k h : ℝ}
    (hk : 0 < k) (hh : 0 ≤ h) (hhk : h ≤ k) :
    ContinuousOn (canonicalThetaRightFlux k h) (Ioi 0) :=
  fun _ ht => (canonicalThetaRightFlux_continuousAt hk hh hhk ht).continuousWithinAt

/-- The actual contact slope ratio converges, rather than merely being bounded.
This is a fixed-time spatial limit, not a joint interior-gradient trace. -/
theorem canonicalTheta_contact_ratio_tendsto {k h t : ℝ}
    (hk : 0 < k) (hh : 0 ≤ h) (hhk : h ≤ k) (ht : 0 < t) :
    Tendsto (fun x => canonicalTheta k h x t/(x-canonicalLogBoundary k h t))
      (𝓝[>] (canonicalLogBoundary k h t)) (𝓝 (canonicalThetaRightFlux k h t)) := by
  have hd := (canonicalTheta_hasDerivWithinAt_right_flux hk hh hhk ht).mono Ioi_subset_Ici_self
  have hlim := (hasDerivWithinAt_iff_tendsto_slope' (by simp :
    canonicalLogBoundary k h t ∉ Ioi (canonicalLogBoundary k h t))).mp hd
  change Tendsto (fun x => slope (fun y => canonicalTheta k h y t) (canonicalLogBoundary k h t) x)
    (𝓝[>] (canonicalLogBoundary k h t)) (𝓝 (canonicalThetaRightFlux k h t)) at hlim
  simpa only [slope_def_field,canonicalTheta_exercise_zero hk hh hhk ht le_rfl,sub_zero] using hlim

theorem zeroDividend_canonicalThetaRightFlux_pos {k t : ℝ} (hk : 0 < k) (ht : 0 < t) :
    0 < canonicalThetaRightFlux k 0 t := canonicalThetaRightFlux_pos hk le_rfl hk.le ht

theorem liuRange_canonicalThetaRightFlux_pos {k h t : ℝ}
    (hh : 0 ≤ h) (hliu : h+1 ≤ k) (ht : 0 < t) :
    0 < canonicalThetaRightFlux k h t := canonicalThetaRightFlux_pos (by linarith) hh (by linarith) ht

end AmericanConvexity.Stopping
