import AmericanConvexity.Stopping.ThreeQuarterOperations
import AmericanConvexity.Stopping.HeatRemainderRecent

/-! # First-order remainder from a three-quarter derivative modulus

The anchor can be any point between the source and observation. The bound
has order 7/4 and requires no second derivative.
-/

namespace AmericanConvexity.Stopping

open Set Filter
open scoped Topology

theorem threeQuarter_pair_bound_on_subinterval
    {f : ℝ → ℝ} {A l u s t x y : ℝ} (hA : 0 ≤ A)
    (hm : ∀ r ∈ Ioo l u, ∀ z ∈ Ioo l u, r < z →
      ‖f z-f r‖ ≤ A*(z-r)^(3/4 : ℝ))
    (hsub : Icc s t ⊆ Ioo l u) (hx : x ∈ Icc s t) (hy : y ∈ Icc s t) :
    ‖f x-f y‖ ≤ A*(t-s)^(3/4 : ℝ) := by
  have hst : 0 ≤ t-s := sub_nonneg.mpr (hx.1.trans hx.2)
  rcases lt_trichotomy y x with hlt | heq | hgt
  · exact (hm y (hsub hy) x (hsub hx) hlt).trans
      (mul_le_mul_of_nonneg_left (Real.rpow_le_rpow (sub_nonneg.mpr hlt.le)
        (by linarith [hx.2,hy.1]) (by norm_num : (0 : ℝ) ≤ 3/4)) hA)
  · rw [heq,sub_self,norm_zero]
    exact mul_nonneg hA (Real.rpow_nonneg hst _)
  · rw [norm_sub_rev]
    exact (hm x (hsub hx) y (hsub hy) hgt).trans
      (mul_le_mul_of_nonneg_left (Real.rpow_le_rpow (sub_nonneg.mpr hgt.le)
        (by linarith [hy.2,hx.1]) (by norm_num : (0 : ℝ) ≤ 3/4)) hA)

theorem firstOrder_remainder_of_threeQuarter_deriv
    {b : ℝ → ℝ} {A l u s t r : ℝ} (hA : 0 ≤ A)
    (hb : ∀ z ∈ Ioo l u, DifferentiableAt ℝ b z)
    (hm : ∀ x ∈ Ioo l u, ∀ y ∈ Ioo l u, x < y →
      ‖deriv b y-deriv b x‖ ≤ A*(y-x)^(3/4 : ℝ))
    (hs : s ∈ Ioo l u) (ht : t ∈ Ioo l u) (hst : s ≤ t) (hr : r ∈ Icc s t) :
    ‖b t-b s-deriv b r*(t-s)‖ ≤ A*(t-s)*(t-s)^(3/4 : ℝ) := by
  have hsub : Icc s t ⊆ Ioo l u := fun z hz => ⟨hs.1.trans_le hz.1,hz.2.trans_lt ht.2⟩
  have he := firstOrder_remainder_of_deriv_deviation hst (fun z hz => hb z (hsub hz))
    (fun z hz => threeQuarter_pair_bound_on_subinterval hA hm hsub hz hr)
  simpa only [mul_assoc,mul_comm (t-s) ((t-s)^(3/4 : ℝ))] using he

theorem LocalThreeQuarterHolderAt.exists_positive_deriv_window
    {b : ℝ → ℝ} {t : ℝ} (ht : 0 < t) (hm : LocalThreeQuarterHolderAt (deriv b) t)
    (hb : ∀ s, 0 < s → DifferentiableAt ℝ b s) :
    ∃ A l u : ℝ, 0 ≤ A ∧ 0 < l ∧ t ∈ Ioo l u ∧
      (∀ x ∈ Ioo l u, ∀ y ∈ Ioo l u, x < y →
        ‖deriv b y-deriv b x‖ ≤ A*(y-x)^(3/4 : ℝ)) ∧
      ∀ x ∈ Ioo l u, ∀ y ∈ Ioo l u, x ≤ y → ∀ r ∈ Icc x y,
        ‖b y-b x-deriv b r*(y-x)‖ ≤ A*(y-x)*(y-x)^(3/4 : ℝ) := by
  obtain ⟨A,U,hA,hU,hbound⟩ := hm
  obtain ⟨l,u,htu,hsub⟩ := mem_nhds_iff_exists_Ioo_subset.mp hU
  let a := max l (t/2)
  have ha : 0 < a := (half_pos ht).trans_le (le_max_right _ _)
  have hta : t ∈ Ioo a u := ⟨max_lt htu.1 (half_lt_self ht),htu.2⟩
  have hsub' : Ioo a u ⊆ U := fun _ hs => hsub ⟨(le_max_left _ _).trans_lt hs.1,hs.2⟩
  have hh : ∀ x ∈ Ioo a u, ∀ y ∈ Ioo a u, x < y →
      ‖deriv b y-deriv b x‖ ≤ A*(y-x)^(3/4 : ℝ) :=
    fun x hx y hy hxy => hbound x (hsub' hx) y (hsub' hy) hxy
  refine ⟨A,a,u,hA,ha,hta,hh,?_⟩
  intro x hx y hy hxy r hr
  exact firstOrder_remainder_of_threeQuarter_deriv hA
    (fun _ hs => hb _ (ha.trans hs.1)) hh hx hy hxy hr

end AmericanConvexity.Stopping
