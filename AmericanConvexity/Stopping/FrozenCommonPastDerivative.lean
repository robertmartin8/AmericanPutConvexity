import AmericanConvexity.Stopping.ThreeQuarterRemainderDerivative
import AmericanConvexity.Stopping.RightIntegralDerivative

/-! # Right derivative of the common-past frozen history

The source interval is fixed. Three-quarter comparison errors give a
uniform integrable bound on slopes for observations to its right, so
dominated convergence exchanges the right derivative and the integral.
-/

namespace AmericanConvexity.Stopping

open Set Filter MeasureTheory
open scoped Topology

theorem frozenHeatHistoryRemainder_time_sub_threeQuarter_bound
    {b f : ℝ → ℝ} {s t₁ t₂ v c A L C D : ℝ}
    (hst : s < t₁) (htt : t₁ ≤ t₂) (hu1 : t₂-s ≤ 1)
    (hA : 0 ≤ A) (hL : 0 ≤ L) (hD : 0 ≤ D)
    (hb : ∀ t ∈ Icc t₁ t₂, DifferentiableAt ℝ b t)
    (hx : ∀ t ∈ Icc t₁ t₂, ‖b t-b s‖ ≤ L*(t-s)) (hv : ‖v‖ ≤ L)
    (hr : ∀ t ∈ Icc t₁ t₂, ‖b t-b s-v*(t-s)‖ ≤ A*(t-s)*(t-s)^(3/4 : ℝ))
    (hw : ∀ t ∈ Icc t₁ t₂, ‖deriv b t-v‖ ≤ A*(t-s)^(3/4 : ℝ))
    (hfs : ‖f s‖ ≤ C) (hm : ‖f s-c‖ ≤ D*(t₁-s)^(3/4 : ℝ)) :
    ‖frozenHeatHistoryRemainder b f v c t₂ s-frozenHeatHistoryRemainder b f v c t₁ s‖ ≤
      ((((8+5*L^2)*A*C+8*L*D)/Real.sqrt (2*Real.pi))*(t₁-s)^(-3/4 : ℝ))*(t₂-t₁) := by
  have hC : 0 ≤ C := (norm_nonneg _).trans hfs
  have hbound (t : ℝ) (ht : t ∈ Icc t₁ t₂) :
      ‖deriv (fun r => frozenHeatHistoryRemainder b f v c r s) t‖ ≤
        (((8+5*L^2)*A*C+8*L*D)/Real.sqrt (2*Real.pi))*(t₁-s)^(-3/4 : ℝ) := by
    apply (frozenHeatHistoryRemainder_deriv_threeQuarter_bound (hst.trans_le ht.1)
      (by linarith [ht.2]) hA hL (hb t ht).hasDerivAt (hx t ht) hv (hr t ht) (hw t ht) hfs
      (hm.trans (mul_le_mul_of_nonneg_left (Real.rpow_le_rpow (sub_nonneg.mpr hst.le)
        (by linarith [ht.1]) (by norm_num : (0 : ℝ) ≤ 3/4)) hD))).trans
    exact mul_le_mul_of_nonneg_left
      (Real.rpow_le_rpow_of_nonpos (sub_pos.mpr hst) (by linarith [ht.1])
        (by norm_num : (-3/4 : ℝ) ≤ 0)) (by positivity)
  have he := (convex_Icc t₁ t₂).norm_image_sub_le_of_norm_deriv_le
    (fun t ht => (frozenHeatHistoryRemainder_hasDerivAt (hst.trans_le ht.1) (hb t ht).hasDerivAt).differentiableAt)
    hbound (left_mem_Icc.mpr htt) (right_mem_Icc.mpr htt)
  simpa only [Real.norm_of_nonneg (sub_nonneg.mpr htt)] using he

theorem frozenCommonPast_hasDerivWithinAt_right
    {b f : ℝ → ℝ} {t T η v c A L C D : ℝ}
    (hT : 0 < T) (hη : 0 < η) (hspan : T+η ≤ 1)
    (hA : 0 ≤ A) (hL : 0 ≤ L) (hD : 0 ≤ D)
    (hb : ∀ r ∈ Icc t (t+η), DifferentiableAt ℝ b r) (hv : ‖v‖ ≤ L)
    (hx : ∀ u ∈ Ioo 0 T, ∀ r ∈ Icc t (t+η), ‖b r-b (t-u)‖ ≤ L*(r-(t-u)))
    (hr : ∀ u ∈ Ioo 0 T, ∀ r ∈ Icc t (t+η),
      ‖b r-b (t-u)-v*(r-(t-u))‖ ≤ A*(r-(t-u))*(r-(t-u))^(3/4 : ℝ))
    (hw : ∀ u ∈ Ioo 0 T, ∀ r ∈ Icc t (t+η),
      ‖deriv b r-v‖ ≤ A*(r-(t-u))^(3/4 : ℝ))
    (hfs : ∀ u ∈ Ioo 0 T, ‖f (t-u)‖ ≤ C)
    (hm : ∀ u ∈ Ioo 0 T, ‖f (t-u)-c‖ ≤ D*u^(3/4 : ℝ))
    (hi : ∀ r ∈ Icc t (t+η),
      IntegrableOn (fun u => frozenHeatHistoryRemainder b f v c r (t-u)) (Ioo 0 T)) :
    HasDerivWithinAt (fun r => ∫ u in Ioo 0 T, frozenHeatHistoryRemainder b f v c r (t-u))
      (∫ u in Ioo 0 T, deriv (fun r => frozenHeatHistoryRemainder b f v c r (t-u)) t) (Ici t) t := by
  let M := ((8+5*L^2)*A*C+8*L*D)/Real.sqrt (2*Real.pi)
  have hnear : ∀ᶠ r in 𝓝[>] t, r ∈ Icc t (t+η) := by
    filter_upwards [self_mem_nhdsWithin,
      (nhdsWithin_le_nhds (Iio_mem_nhds (by linarith : t < t+η)) :
        ∀ᶠ r in 𝓝[>] t, r < t+η)] with r hr hrt
    exact ⟨le_of_lt hr,hrt.le⟩
  have hp : IntegrableOn (fun u : ℝ => M*u^(-3/4 : ℝ)) (Ioo 0 T) :=
    ((intervalIntegral.integrableOn_Ioo_rpow_iff hT).mpr (by norm_num)).const_mul M
  apply hasDerivWithinAt_integral_Ici_of_dominated_slope
    (μ := volume.restrict (Ioo 0 T))
    (F := fun r u => frozenHeatHistoryRemainder b f v c r (t-u))
    (G := fun u => deriv (fun r => frozenHeatHistoryRemainder b f v c r (t-u)) t)
    (B := fun u => M*u^(-3/4 : ℝ))
    (hi t ⟨le_rfl,by linarith⟩) (hnear.mono (fun r hr => hi r hr)) hp
  · filter_upwards [hnear] with r hrt
    filter_upwards [ae_restrict_mem measurableSet_Ioo] with u hu
    have hsub : Icc t r ⊆ Icc t (t+η) := fun _ hs => ⟨hs.1,hs.2.trans hrt.2⟩
    have he := frozenHeatHistoryRemainder_time_sub_threeQuarter_bound
      (by linarith [hu.1] : t-u < t) hrt.1 (by linarith [hu.2,hrt.2] : r-(t-u) ≤ 1)
      hA hL hD (fun s hs => hb s (hsub hs)) (fun s hs => hx u hu s (hsub hs)) hv
      (fun s hs => hr u hu s (hsub hs)) (fun s hs => hw u hu s (hsub hs)) (hfs u hu)
      (by simpa only [sub_sub_cancel] using hm u hu)
    simpa only [sub_sub_cancel] using he
  · filter_upwards [ae_restrict_mem measurableSet_Ioo] with u hu
    exact (frozenHeatHistoryRemainder_hasDerivAt (by linarith [hu.1] : t-u < t)
      (hb t ⟨le_rfl,by linarith⟩).hasDerivAt).differentiableAt.hasDerivAt

end AmericanConvexity.Stopping
