import AmericanPutConvexity.Stopping.HeatHistoryThreeQuarter

/-! # The complete history gains regularity from C1,1/2 data

A square-root modulus of the graph velocity and density supplies both
comparison estimates in the complete-history theorem. The slope and density
are frozen at the earlier observation time; no second derivative is used.
-/

namespace AmericanPutConvexity.Stopping

open Set

theorem halfHolder_pair_bound_on_subinterval {g : ℝ → ℝ} {A a T l u x y : ℝ}
    (hA : 0 ≤ A)
    (hmod : ∀ s ∈ Icc a T, ∀ t ∈ Icc a T, s ≤ t → ‖g t-g s‖ ≤ A*Real.sqrt (t-s))
    (hsub : Icc l u ⊆ Icc a T) (hx : x ∈ Icc l u) (hy : y ∈ Icc l u) :
    ‖g x-g y‖ ≤ A*Real.sqrt (u-l) := by
  rcases le_total y x with hle | hle
  · exact (hmod y (hsub hy) x (hsub hx) hle).trans
      (mul_le_mul_of_nonneg_left (Real.sqrt_le_sqrt (by linarith [hx.2,hy.1])) hA)
  · rw [norm_sub_rev]
    exact (hmod x (hsub hx) y (hsub hy) hle).trans
      (mul_le_mul_of_nonneg_left (Real.sqrt_le_sqrt (by linarith [hy.2,hx.1])) hA)

theorem heatHistoryFrom_threeQuarter_of_halfHolder {b f : ℝ → ℝ} {a t₁ t₂ A L C D : ℝ}
    (hat : a < t₁) (htt : t₁ < t₂) (hspan : t₂-a ≤ 1)
    (hA : 0 ≤ A) (hL : 0 ≤ L) (hC : 0 ≤ C) (hD : 0 ≤ D)
    (hb : Continuous b) (hf : Continuous f) (hCf : ∀ s, ‖f s‖ ≤ C)
    (hd : ∀ r ∈ Icc a t₂, DifferentiableAt ℝ b r)
    (hvel : ∀ r ∈ Icc a t₂, ‖deriv b r‖ ≤ L)
    (hvelmod : ∀ s ∈ Icc a t₂, ∀ t ∈ Icc a t₂, s ≤ t →
      ‖deriv b t-deriv b s‖ ≤ A*Real.sqrt (t-s))
    (hfmod : ∀ s ∈ Icc a t₂, ∀ t ∈ Icc a t₂, s ≤ t → ‖f t-f s‖ ≤ D*Real.sqrt (t-s)) :
    ‖heatHistoryFrom b f a t₂-heatHistoryFrom b f a t₁‖ ≤
      heatHistoryThreeQuarterConstant A L C D (t₁-a)*(t₂-t₁)^(3/4 : ℝ) := by
  have ht₁ : t₁ ∈ Icc a t₂ := ⟨hat.le,htt.le⟩
  have ht₂ : t₂ ∈ Icc a t₂ := ⟨(hat.trans htt).le,le_rfl⟩
  have hm (s : ℝ) (hs : s ∈ Icc a t₂) (r : ℝ) (hr : r ∈ Icc a t₂) (hsr : s ≤ r) :
      ‖b r-b s‖ ≤ L*(r-s) := by
    have he := (convex_Icc a t₂).norm_image_sub_le_of_norm_deriv_le hd hvel hs hr
    simpa only [Real.norm_of_nonneg (sub_nonneg.mpr hsr)] using he
  have hi₁ := movingHeatHistoryKernel_source_integrable hat le_rfl hL hb hf
    (fun s hs => hm s ⟨hs.1.le,hs.2.le.trans htt.le⟩ t₁ ht₁ hs.2.le) hCf
  have hi₂ := movingHeatHistoryKernel_source_integrable (hat.trans htt) le_rfl hL hb hf
    (fun s hs => hm s ⟨hs.1.le,hs.2.le⟩ t₂ ht₂ hs.2.le) hCf
  have hsub : Icc t₁ t₂ ⊆ Icc a t₂ := fun _ hr => ⟨hat.le.trans hr.1,hr.2⟩
  apply heatHistoryFrom_frozen_threeQuarter hat htt hspan hA hL hC hD hb hf
    (hvel t₁ ht₁) (hCf t₁) hi₁ hi₂ (fun r hr => hd r (hsub hr))
    (fun s hs r hr => hm s ⟨hs.1.le,hs.2.le.trans htt.le⟩ r (hsub hr) (hs.2.le.trans hr.1))
    _ _ (fun s _ => hCf s) _ _ _
  · intro s hs r hr
    have hsr : s ≤ r := hs.2.le.trans hr.1
    have hI : Icc s r ⊆ Icc a t₂ := fun _ hz => ⟨hs.1.le.trans hz.1,hz.2.trans hr.2⟩
    have he := firstOrder_remainder_of_deriv_deviation hsr (fun z hz => hd z (hI hz))
      (fun z hz => halfHolder_pair_bound_on_subinterval hA hvelmod hI hz ⟨hs.2.le,hr.1⟩)
    convert! he using 1
    ring
  · intro s hs r hr
    exact (hvelmod t₁ ht₁ r (hsub hr) hr.1).trans
      (mul_le_mul_of_nonneg_left (Real.sqrt_le_sqrt (by linarith [hs.2])) hA)
  · intro s hs
    rw [norm_sub_rev]
    exact hfmod s ⟨hs.1.le,hs.2.le.trans htt.le⟩ t₁ ht₁ hs.2.le
  · intro s hs
    have hI : Icc s t₂ ⊆ Icc a t₂ := fun _ hz => ⟨hat.le.trans (hs.1.le.trans hz.1),hz.2⟩
    exact firstOrder_remainder_of_deriv_deviation hs.2.le (fun z hz => hd z (hI hz))
      (fun z hz => halfHolder_pair_bound_on_subinterval hA hvelmod hsub
        ⟨hs.1.le.trans hz.1,hz.2⟩ (left_mem_Icc.mpr htt.le))
  · intro s hs
    exact halfHolder_pair_bound_on_subinterval hD hfmod hsub
      ⟨hs.1.le,hs.2.le⟩ (left_mem_Icc.mpr htt.le)

end AmericanPutConvexity.Stopping
