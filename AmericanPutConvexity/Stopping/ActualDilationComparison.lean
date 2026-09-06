import AmericanPutConvexity.Stopping.ActualPremiumDilation
import AmericanPutConvexity.Stopping.DilationWeight

/-! # Comparison for the actual premium under parabolic dilation

No smoothness of the free boundary is assumed. A positive corrected maximum
must evaluate both prices in continuation, where the exact pricing PDE applies.
-/

namespace AmericanPutConvexity.Stopping

open Set Filter Boundary
open scoped Topology ContDiff

noncomputable def dilationErrorCoefficient (k h ρ : ℝ) : ℝ :=
  (2*|k-h-1|+4*h+1)*(ρ-1)

theorem dilationErrorCoefficient_nonneg {k h ρ : ℝ} (hh : 0 ≤ h) (hρ : 1 ≤ ρ) :
    0 ≤ dilationErrorCoefficient k h ρ := by
  unfold dilationErrorCoefficient
  exact mul_nonneg (by positivity) (sub_nonneg.mpr hρ)

theorem dilationErrorCoefficient_ge_increment {k h ρ : ℝ} (hh : 0 ≤ h) (hρ : 1 ≤ ρ) :
    ρ-1 ≤ dilationErrorCoefficient k h ρ := by
  have hm := mul_nonneg (show 0 ≤ 2*|k-h-1|+4*h by positivity) (sub_nonneg.mpr hρ)
  unfold dilationErrorCoefficient
  nlinarith

theorem canonicalPremiumDilation_initial_bound {k h ρ : ℝ} (hk : 0 ≤ k)
    (hh : 0 ≤ h) (hρ : 1 ≤ ρ) (hρ2 : ρ ≤ 2) (x : ℝ) :
    canonicalPremiumDilation k h ρ x 0 ≤ dilationErrorCoefficient k h ρ*dilationWeight x := by
  have hD := dilationErrorCoefficient_nonneg (k := k) hh hρ
  have hinc := dilationErrorCoefficient_ge_increment (k := k) hh hρ
  have he := (dilation_exp_sub_le_weight hρ hρ2 (x := x)).trans
    (mul_le_mul_of_nonneg_right hinc (dilationWeight_pos x).le)
  unfold canonicalPremiumDilation canonicalIntrinsicPremium
  simp only [mul_zero,canonicalPrice_initial hk]
  rcases le_total x 0 with hx | hx
  · rw [putPayoff_of_nonpos hx,putPayoff_of_nonpos (show ρ*x ≤ 0 by nlinarith)]
    simpa only [sub_self] using mul_nonneg hD (dilationWeight_pos x).le
  · have hp (y : ℝ) (hy : 0 ≤ y) : putPayoff y = 0 :=
      max_eq_right (sub_nonpos.mpr (Real.one_le_exp_iff.mpr hy))
    rw [hp x hx,hp (ρ*x) (by nlinarith)]
    linarith

theorem canonicalPremiumDilation_source_bound {k h ρ x t : ℝ} (hk : 0 < k)
    (hh : 0 ≤ h) (hhk : h ≤ k) (hρ : 1 ≤ ρ) (hρ2 : ρ ≤ 2) (ht : 0 < t)
    (hz : (x,t) ∈ canonicalContinuationRegion k h)
    (hzρ : (ρ*x,ρ^2*t) ∈ canonicalContinuationRegion k h) :
    pricingOperator k h (fun z => canonicalPremiumDilation k h ρ z.1 z.2) (x,t) ≤
      dilationErrorCoefficient k h ρ*dilationWeight x := by
  have hρ0 : 0 < ρ := by linarith
  have hδ : 0 ≤ ρ-1 := sub_nonneg.mpr hρ
  have htρ : 0 < ρ^2*t := by positivity
  have hd := canonicalIntrinsicPremium_deriv_bounds (x := ρ*x) hk hh hhk htρ
  have hu := canonicalIntrinsicPremium_nonneg (h := h) hk.le (ρ*x) (ρ^2*t)
  have hdu := hd.2.trans (dilation_exp_le_weight hρ0.le hρ2)
  have hρdu : ρ*deriv (fun y => canonicalIntrinsicPremium k h y (ρ^2*t)) (ρ*x) ≤
      2*dilationWeight x := (mul_le_mul_of_nonneg_left hdu hρ0.le).trans
        (mul_le_mul_of_nonneg_right hρ2 (dilationWeight_pos x).le)
  have ha := mul_le_mul_of_nonneg_right (le_abs_self (k-h-1))
    (mul_nonneg (mul_nonneg hρ0.le hδ) hd.1)
  have hb := mul_le_mul_of_nonneg_left hρdu (mul_nonneg (abs_nonneg (k-h-1)) hδ)
  have hc := mul_le_mul_of_nonneg_left (dilation_exp_source_le_weight hρ hρ2 (x := x)) hh
  have hs : 0 ≤ ρ^2-1 := by nlinarith
  have hkill := mul_nonneg (mul_nonneg hk.le hs) hu
  have hkill0 := mul_nonneg hk.le hs
  have hn := mul_nonneg hδ (dilationWeight_pos x).le
  rw [canonicalPremiumDilation_equation hk hh hhk hρ0 ht hz hzρ]
  unfold dilationErrorCoefficient
  nlinarith

theorem canonicalPremiumDilation_no_positive_corrected_max {k h ρ x t : ℝ}
    (hk : 0 < k) (hh : 0 ≤ h) (hhk : h ≤ k) (hρ : 1 ≤ ρ) (hρ2 : ρ ≤ 2) (ht : 0 < t)
    (hm : IsLocalMax (fun y => canonicalPremiumDilation k h ρ y t-
      dilationBarrier (k-h-1) (dilationErrorCoefficient k h ρ) y t) x)
    (htm : ∀ᶠ s in 𝓝[<] t,
      canonicalPremiumDilation k h ρ x s-dilationBarrier (k-h-1) (dilationErrorCoefficient k h ρ) x s ≤
      canonicalPremiumDilation k h ρ x t-dilationBarrier (k-h-1) (dilationErrorCoefficient k h ρ) x t)
    (hpos : 0 < canonicalPremiumDilation k h ρ x t-
      dilationBarrier (k-h-1) (dilationErrorCoefficient k h ρ) x t) : False := by
  let D := dilationErrorCoefficient k h ρ
  let E : ℝ × ℝ → ℝ := fun z => dilationBarrier (k-h-1) D z.1 z.2
  let W : ℝ × ℝ → ℝ := fun z => canonicalPremiumDilation k h ρ z.1 z.2
  have hD : 0 ≤ D := dilationErrorCoefficient_nonneg hh hρ
  have hE : ContDiffAt ℝ 2 E (x,t) := (dilationBarrier_contDiff (k-h-1) D).contDiffAt
  have hρ0 : 0 < ρ := by linarith
  have hx := canonicalPremiumDilation_positive_max_continuation
    (E := fun y => dilationBarrier (k-h-1) D y t) hk hh hhk hρ0 ht
    (dilationBarrier_nonneg hD) (dilationBarrier_hasDeriv_x (k-h-1) D x t).differentiableAt
    (dilationBarrier_deriv_x_nonpos hD) hm hpos
  have hz : (x,t) ∈ canonicalContinuationRegion k h := by
    rw [canonicalContinuationRegion_eq_logBoundary hk hh hhk]
    exact ⟨ht,hx.1⟩
  have hzρ : (ρ*x,ρ^2*t) ∈ canonicalContinuationRegion k h := by
    rw [canonicalContinuationRegion_eq_logBoundary hk hh hhk]
    exact ⟨by positivity,hx.2⟩
  have hW : ContDiffAt ℝ 2 W (x,t) := canonicalPremiumDilation_contDiffAt hk.le hz hzρ
  have hdiff : ContDiffAt ℝ 2 (fun z => W z-E z) (x,t) := hW.sub hE
  have hd : DifferentiableAt ℝ (fun s => W (x,s)-E (x,s)) t :=
    (hdiff.comp (f := fun s : ℝ => (x,s)) t (by fun_prop)).differentiableAt (by norm_num)
  have htime := deriv_nonneg_at_left_max hd htm
  have hspace := second_deriv_nonpos_at_local_max hm
    (hdiff.continuousAt.comp (f := fun y : ℝ => (y,t)) (by fun_prop))
  have hsum := pricingOperator_add hdiff hE k h
  simp only [sub_add_cancel] at hsum
  have hsource := canonicalPremiumDilation_source_bound hk hh hhk hρ hρ2 ht hz hzρ
  have hsuper := dilationBarrier_supersolution (h := h) (x := x) hk.le hD ht.le
  have hle : pricingOperator k h (fun z => W z-E z) (x,t) ≤ 0 := by
    change pricingOperator k h W (x,t) ≤ D*dilationWeight x at hsource
    change D*dilationWeight x ≤ pricingOperator k h E (x,t) at hsuper
    linarith
  unfold pricingOperator at hle
  dsimp only at hle
  have hzero : deriv (fun y => W (y,t)-E (y,t)) x = 0 := hm.deriv_eq_zero
  rw [hzero,mul_zero,sub_zero] at hle
  have hp : 0 < k*(W (x,t)-E (x,t)) := mul_pos hk hpos
  change deriv (deriv (fun y => W (y,t)-E (y,t))) x ≤ 0 at hspace
  linarith

theorem canonicalPremiumDilation_le_on_rectangle {k h ρ L R T : ℝ}
    (hk : 0 < k) (hh : 0 ≤ h) (hhk : h ≤ k) (hρ : 1 ≤ ρ) (hρ2 : ρ ≤ 2)
    (hleft : ∀ t ∈ Icc 0 T, canonicalPremiumDilation k h ρ L t ≤
      dilationBarrier (k-h-1) (dilationErrorCoefficient k h ρ) L t)
    (hright : ∀ t ∈ Icc 0 T, canonicalPremiumDilation k h ρ R t ≤
      dilationBarrier (k-h-1) (dilationErrorCoefficient k h ρ) R t) :
    ∀ z ∈ Icc L R ×ˢ Icc 0 T, canonicalPremiumDilation k h ρ z.1 z.2 ≤
      dilationBarrier (k-h-1) (dilationErrorCoefficient k h ρ) z.1 z.2 := by
  intro z hz
  by_contra! hpos
  let D := dilationErrorCoefficient k h ρ
  let F : ℝ × ℝ → ℝ := fun w => canonicalPremiumDilation k h ρ w.1 w.2-
    dilationBarrier (k-h-1) D w.1 w.2
  have hc : Continuous F := (canonicalPremiumDilation_continuous hk.le ρ).sub
    (dilationBarrier_contDiff (k-h-1) D).continuous
  obtain ⟨w,hw,hmax⟩ := (isCompact_Icc.prod isCompact_Icc).exists_isMaxOn ⟨z,hz⟩ hc.continuousOn
  have hF : 0 < F w := (sub_pos.mpr hpos).trans_le (hmax hz)
  have hwL : L < w.1 := by
    by_contra! hn
    have he : w.1 = L := le_antisymm hn hw.1.1
    have hb := hleft w.2 hw.2
    dsimp only [F] at hF
    rw [he] at hF
    linarith
  have hwR : w.1 < R := by
    by_contra! hn
    have he : w.1 = R := le_antisymm hw.1.2 hn
    have hb := hright w.2 hw.2
    dsimp only [F] at hF
    rw [he] at hF
    linarith
  have hwt : 0 < w.2 := by
    by_contra! hn
    have he : w.2 = 0 := le_antisymm hn hw.2.1
    have hb := (canonicalPremiumDilation_initial_bound hk.le hh hρ hρ2 w.1).trans
      (dilationBarrier_le_of_nonneg_time (α := k-h-1) (dilationErrorCoefficient_nonneg hh hρ)
        (le_refl (0 : ℝ)))
    dsimp only [F] at hF
    rw [he] at hF
    linarith
  have hspace : IsLocalMax (fun x => F (x,w.2)) w.1 := by
    filter_upwards [Ioo_mem_nhds hwL hwR] with x hx
    exact hmax (show (x,w.2) ∈ Icc L R ×ˢ Icc 0 T from ⟨⟨hx.1.le,hx.2.le⟩,hw.2⟩)
  have htime : ∀ᶠ t in 𝓝[<] w.2, F (w.1,t) ≤ F w := by
    filter_upwards [nhdsWithin_le_nhds (Ioi_mem_nhds hwt),self_mem_nhdsWithin] with t ht htw
    exact hmax (show (w.1,t) ∈ Icc L R ×ˢ Icc 0 T from
      ⟨hw.1,ht.le,(show t < w.2 from htw).le.trans hw.2.2⟩)
  exact canonicalPremiumDilation_no_positive_corrected_max hk hh hhk hρ hρ2 hwt hspace htime hF

/-- Actual-price parabolic dilation estimate, with an explicit error linear
in `ρ-1`. It holds from expiry onward, without any free-boundary derivative. -/
theorem canonicalPremiumDilation_le_barrier {k h ρ t : ℝ} (hk : 0 < k)
    (hh : 0 ≤ h) (hhk : h ≤ k) (hρ : 1 ≤ ρ) (hρ2 : ρ ≤ 2) (ht : 0 ≤ t) (x : ℝ) :
    canonicalPremiumDilation k h ρ x t ≤
      dilationBarrier (k-h-1) (dilationErrorCoefficient k h ρ) x t := by
  rcases hρ.eq_or_lt with he | hρ1
  · subst ρ
    simp only [canonicalPremiumDilation,one_pow,one_mul,sub_self,
      dilationBarrier,dilationErrorCoefficient,mul_zero,zero_mul,le_refl]
  let D := dilationErrorCoefficient k h ρ
  have hD : 0 < D := (sub_pos.mpr hρ1).trans_le (dilationErrorCoefficient_ge_increment hh hρ)
  let L := min x (min 0 (Real.log D))
  let R := max x (max 0 (-Real.log D))
  have hcrude (y s : ℝ) : canonicalPremiumDilation k h ρ y s ≤ Real.exp (ρ*y) := by
    have hu := canonicalIntrinsicPremium_le_exp (h := h) hk.le (ρ*y) (ρ^2*s)
    have hn := canonicalIntrinsicPremium_nonneg (h := h) hk.le y s
    unfold canonicalPremiumDilation
    linarith
  apply canonicalPremiumDilation_le_on_rectangle hk hh hhk hρ hρ2
    (L := L) (R := R) (T := t) ?_ ?_ (x,t) ⟨⟨min_le_left _ _,le_max_left _ _⟩,ht,le_rfl⟩
  · intro s hs
    exact (hcrude L s).trans ((dilation_exp_le_weight_far_left hρ hD
      ((min_le_right _ _).trans (min_le_left _ _))
      ((min_le_right _ _).trans (min_le_right _ _))).trans
        (dilationBarrier_le_of_nonneg_time hD.le hs.1))
  · intro s hs
    exact (hcrude R s).trans ((dilation_exp_le_weight_far_right hρ2 hD
      ((le_max_left _ _).trans (le_max_right _ _))
      ((le_max_right _ _).trans (le_max_right _ _))).trans
        (dilationBarrier_le_of_nonneg_time hD.le hs.1))

theorem zeroDividend_canonicalPremiumDilation_le_barrier {k ρ t : ℝ} (hk : 0 < k)
    (hρ : 1 ≤ ρ) (hρ2 : ρ ≤ 2) (ht : 0 ≤ t) (x : ℝ) :
    canonicalPremiumDilation k 0 ρ x t ≤
      dilationBarrier (k-0-1) (dilationErrorCoefficient k 0 ρ) x t :=
  canonicalPremiumDilation_le_barrier hk le_rfl hk.le hρ hρ2 ht x

theorem liuRange_canonicalPremiumDilation_le_barrier {k h ρ t : ℝ}
    (hh : 0 ≤ h) (hliu : h+1 ≤ k) (hρ : 1 ≤ ρ) (hρ2 : ρ ≤ 2) (ht : 0 ≤ t) (x : ℝ) :
    canonicalPremiumDilation k h ρ x t ≤
      dilationBarrier (k-h-1) (dilationErrorCoefficient k h ρ) x t :=
  canonicalPremiumDilation_le_barrier (by linarith) hh (by linarith) hρ hρ2 ht x

end AmericanPutConvexity.Stopping
