import AmericanPutConvexity.Stopping.ActualTemporalDerivativeBound

/-! # Local temporal Lipschitz regularity of the actual stopping price

The maximum argument only differentiates where the intrinsic premium is
strictly positive, hence in continuation. It also controls increments crossing
the exercise/continuation interface without assuming a time derivative there.
-/

namespace AmericanPutConvexity.Stopping

open Set Filter Boundary
open scoped Topology ContDiff

theorem increment_le_of_deriv_bound_on_positive {f : ℝ → ℝ} {s t M : ℝ}
    (hst : s ≤ t) (hM : 0 ≤ M) (hf : ContinuousOn f (Icc s t)) (hfs : 0 ≤ f s)
    (hd : ∀ y ∈ Ioc s t, 0 < f y → DifferentiableAt ℝ f y ∧ deriv f y ≤ M) :
    f t-f s ≤ M*(t-s) := by
  rcases hst.eq_or_lt with he | hst
  · simp only [he,sub_self,mul_zero,le_refl]
  apply le_of_forall_pos_le_add
  intro ε hε
  by_contra! hpos
  let N := M+ε/(t-s)
  have hNM : M < N := lt_add_of_pos_right M (div_pos hε (sub_pos.mpr hst))
  have hN : 0 ≤ N := (hM.trans_lt hNM).le
  have hNt : N*(t-s) = M*(t-s)+ε := by
    dsimp only [N]
    rw [add_mul,div_mul_cancel₀ _ (sub_ne_zero.mpr hst.ne')]
  let F : ℝ → ℝ := fun y => f y-N*(y-s)
  have hF : ContinuousOn F (Icc s t) := hf.sub (by fun_prop)
  obtain ⟨y,hy,hmax⟩ := isCompact_Icc.exists_isMaxOn ⟨s,le_rfl,hst.le⟩ hF
  have hlarge : f s < F y := by
    have he : F t ≤ F y := hmax (show t ∈ Icc s t from ⟨hst.le,le_rfl⟩)
    dsimp only [F] at he ⊢
    rw [hNt] at he
    linarith
  have hsy : s < y := by
    by_contra! hn
    have he : y = s := le_antisymm hn hy.1
    simp only [he,F,sub_self,mul_zero,sub_zero,lt_self_iff_false] at hlarge
  have hfy : 0 < f y := by
    have hn := mul_nonneg hN (sub_nonneg.mpr hy.1)
    dsimp only [F] at hlarge
    linarith
  obtain ⟨hdy,hle⟩ := hd y ⟨hsy,hy.2⟩ hfy
  have hlin : HasDerivAt (fun z => N*(z-s)) N y := by
    convert! (((hasDerivAt_id y).sub_const s).const_mul N) using 1
    simp
  have hdf : DifferentiableAt ℝ F y := hdy.sub hlin.differentiableAt
  have htm : ∀ᶠ z in 𝓝[<] y, F z ≤ F y := by
    filter_upwards [nhdsWithin_le_nhds (Ioi_mem_nhds hsy),self_mem_nhdsWithin] with z hz hzy
    exact hmax ⟨hz.le,(show z < y from hzy).le.trans hy.2⟩
  have hder := deriv_nonneg_at_left_max hdf htm
  change 0 ≤ deriv (fun z => f z-N*(z-s)) y at hder
  rw [deriv_fun_sub hdy hlin.differentiableAt,hlin.deriv] at hder
  linarith

/-- On every positive-time compact interval, actual-price increments are
Lipschitz at each fixed log spot, with an explicit constant. -/
theorem canonicalPrice_temporal_lipschitz_on_interval {k h x a T s t : ℝ}
    (hk : 0 < k) (hh : 0 ≤ h) (hhk : h ≤ k) (ha : 0 < a)
    (hs : s ∈ Icc a T) (ht : t ∈ Icc a T) :
    |canonicalPrice k h x t-canonicalPrice k h x s| ≤
      actualTemporalDerivativeBound k h x a T*|t-s| := by
  have hordered (v w : ℝ) (hv : v ∈ Icc a T) (hw : w ∈ Icc a T) (hvw : v ≤ w) :
      canonicalPrice k h x w-canonicalPrice k h x v ≤ actualTemporalDerivativeBound k h x a T*(w-v) := by
    have hf : ContinuousOn (canonicalIntrinsicPremium k h x) (Icc v w) :=
      ((canonicalIntrinsicPremium_continuous hk.le).comp
        (show Continuous (fun z : ℝ => (x,z)) by fun_prop)).continuousOn
    have he := increment_le_of_deriv_bound_on_positive hvw
      (actualTemporalDerivativeBound_nonneg (k := k) (x := x) (T := T) hh ha) hf
      (canonicalIntrinsicPremium_nonneg hk.le x v) ?_
    · simpa only [canonicalIntrinsicPremium,sub_sub_sub_cancel_right] using he
    intro y hy hpos
    have hay : a ≤ y := hv.1.trans hy.1.le
    have hyt : y ≤ T := hy.2.trans hw.2
    have hpy : 0 < y := ha.trans_le hay
    have hx : canonicalLogBoundary k h y < x := by
      by_contra! hn
      rw [canonicalIntrinsicPremium_eq_zero_in_exercise hk hh hhk hpy hn] at hpos
      exact lt_irrefl _ hpos
    have hz : (x,y) ∈ canonicalContinuationRegion k h := by
      rw [canonicalContinuationRegion_eq_logBoundary hk hh hhk]
      exact ⟨hpy,hx⟩
    refine ⟨((canonicalIntrinsicPremium_joint_contDiffAt hk.le hz).comp
      (f := fun z : ℝ => (x,z)) y (by fun_prop)).differentiableAt (by norm_num), ?_⟩
    change deriv (fun z => canonicalPrice k h x z-(1-Real.exp x)) y ≤ _
    rw [deriv_sub_const]
    exact canonicalPrice_time_deriv_le_dilationBound hk hh hhk ha hay hyt hz
  rcases le_total s t with hst | hts
  · rw [abs_of_nonneg (sub_nonneg.mpr (canonicalPrice_monotone_time hk.le x hst)),
      abs_of_nonneg (sub_nonneg.mpr hst)]
    exact hordered s t hs ht hst
  · rw [abs_of_nonpos (sub_nonpos.mpr (canonicalPrice_monotone_time hk.le x hts)),
      abs_of_nonpos (sub_nonpos.mpr hts),neg_sub,neg_sub]
    exact hordered t s ht hs hts

theorem zeroDividend_canonicalPrice_temporal_lipschitz_on_interval {k x a T s t : ℝ}
    (hk : 0 < k) (ha : 0 < a) (hs : s ∈ Icc a T) (ht : t ∈ Icc a T) :
    |canonicalPrice k 0 x t-canonicalPrice k 0 x s| ≤
      actualTemporalDerivativeBound k 0 x a T*|t-s| :=
  canonicalPrice_temporal_lipschitz_on_interval hk le_rfl hk.le ha hs ht

theorem liuRange_canonicalPrice_temporal_lipschitz_on_interval {k h x a T s t : ℝ}
    (hh : 0 ≤ h) (hliu : h+1 ≤ k) (ha : 0 < a) (hs : s ∈ Icc a T) (ht : t ∈ Icc a T) :
    |canonicalPrice k h x t-canonicalPrice k h x s| ≤
      actualTemporalDerivativeBound k h x a T*|t-s| :=
  canonicalPrice_temporal_lipschitz_on_interval (by linarith) hh (by linarith) ha hs ht

end AmericanPutConvexity.Stopping
