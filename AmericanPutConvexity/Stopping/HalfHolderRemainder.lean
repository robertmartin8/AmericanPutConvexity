import AmericanPutConvexity.Stopping.LocalHalfHolder

/-! # First-order Taylor remainder from a square-root derivative modulus

The mean-value inequality bounds the remainder uniformly using the derivative
at any anchor between the endpoints. The bound is order (t-s)^(3/2) and
requires no second derivative.
-/

namespace AmericanPutConvexity.Stopping

open Set Filter
open scoped Topology

theorem firstOrder_remainder_of_halfHolder_deriv
    {b : ℝ → ℝ} {A l u s t r : ℝ} (hA : 0 ≤ A)
    (hb : ∀ z ∈ Ioo l u, DifferentiableAt ℝ b z)
    (hholder : ∀ s₁ ∈ Ioo l u, ∀ s₂ ∈ Ioo l u, s₁ < s₂ →
      ‖deriv b s₂-deriv b s₁‖ ≤ A*Real.sqrt (s₂-s₁))
    (hs : s ∈ Ioo l u) (ht : t ∈ Ioo l u) (hst : s ≤ t) (hr : r ∈ Icc s t) :
    ‖b t-b s-deriv b r*(t-s)‖ ≤ A*(t-s)*Real.sqrt (t-s) := by
  have hsub : Icc s t ⊆ Ioo l u := fun z hz => ⟨hs.1.trans_le hz.1,hz.2.trans_lt ht.2⟩
  have hbound (z : ℝ) (hz : z ∈ Icc s t) :
      ‖deriv b z-deriv b r‖ ≤ A*Real.sqrt (t-s) := by
    rcases lt_trichotomy r z with hlt | heq | hgt
    · exact (hholder r (hsub hr) z (hsub hz) hlt).trans
        (mul_le_mul_of_nonneg_left (Real.sqrt_le_sqrt (by linarith [hz.2,hr.1])) hA)
    · rw [heq,sub_self,norm_zero]
      positivity
    · rw [norm_sub_rev]
      exact (hholder z (hsub hz) r (hsub hr) hgt).trans
        (mul_le_mul_of_nonneg_left (Real.sqrt_le_sqrt (by linarith [hr.2,hz.1])) hA)
  have hd (z : ℝ) (hz : z ∈ Icc s t) :
      HasDerivWithinAt (fun y => b y-deriv b r*y) (deriv b z-deriv b r) (Icc s t) z := by
    simpa only [mul_one] using! ((hb z (hsub hz)).hasDerivAt.sub
      ((hasDerivAt_id z).const_mul (deriv b r))).hasDerivWithinAt
  have he := Convex.norm_image_sub_le_of_norm_hasDerivWithin_le hd hbound
    (convex_Icc s t) (left_mem_Icc.mpr hst) (right_mem_Icc.mpr hst)
  rw [Real.norm_of_nonneg (sub_nonneg.mpr hst)] at he
  convert! he using 1
  · congr 1
    ring
  · ring

theorem LocalHalfHolderAt.exists_positive_deriv_window
    {b : ℝ → ℝ} {t : ℝ} (ht : 0 < t) (hholder : LocalHalfHolderAt (deriv b) t)
    (hb : ∀ s, 0 < s → DifferentiableAt ℝ b s) :
    ∃ (A l u : ℝ), 0 ≤ A ∧ 0 < l ∧ t ∈ Ioo l u ∧
      (∀ s₁ ∈ Ioo l u, ∀ s₂ ∈ Ioo l u, s₁ < s₂ →
        ‖deriv b s₂-deriv b s₁‖ ≤ A*Real.sqrt (s₂-s₁)) ∧
      ∀ s₁ ∈ Ioo l u, ∀ s₂ ∈ Ioo l u, s₁ ≤ s₂ → ∀ r ∈ Icc s₁ s₂,
        ‖b s₂-b s₁-deriv b r*(s₂-s₁)‖ ≤ A*(s₂-s₁)*Real.sqrt (s₂-s₁) := by
  obtain ⟨A,U,hA,hU,hbound⟩ := hholder
  obtain ⟨l,u,htu,hsub⟩ := mem_nhds_iff_exists_Ioo_subset.mp hU
  let a := max l (t/2)
  have ha : 0 < a := (half_pos ht).trans_le (le_max_right _ _)
  have hta : t ∈ Ioo a u := ⟨max_lt htu.1 (half_lt_self ht),htu.2⟩
  have hsub' : Ioo a u ⊆ U := fun _ hs => hsub ⟨(le_max_left _ _).trans_lt hs.1,hs.2⟩
  have hh : ∀ s₁ ∈ Ioo a u, ∀ s₂ ∈ Ioo a u, s₁ < s₂ →
      ‖deriv b s₂-deriv b s₁‖ ≤ A*Real.sqrt (s₂-s₁) :=
    fun s₁ hs₁ s₂ hs₂ hst => hbound s₁ (hsub' hs₁) s₂ (hsub' hs₂) hst
  refine ⟨A,a,u,hA,ha,hta,hh,?_⟩
  intro s₁ hs₁ s₂ hs₂ hst r hr
  exact firstOrder_remainder_of_halfHolder_deriv hA
    (fun _ hs => hb _ (ha.trans hs.1)) hh hs₁ hs₂ hst hr

end AmericanPutConvexity.Stopping
