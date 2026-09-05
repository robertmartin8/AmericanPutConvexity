import AmericanConvexity.Stopping.ActualTheta
import AmericanConvexity.Stopping.ActualIncrementPositivity

/-! # Strict positivity of the actual time derivative in continuation

A positive continuation premium supplies an earlier positive theta value by
the mean value theorem. An explicit parabolic positivity barrier transports
that value forward at the same spot. No boundary velocity is used.
-/

namespace AmericanConvexity.Stopping

open Set Filter Boundary Boundary.Comparison
open scoped Topology ContDiff

noncomputable def canonicalThetaGauge (k h x t : ℝ) : ℝ :=
  canonicalTheta k h x t/profile (k-h-1) k x

theorem canonicalThetaGauge_continuousAt {k h x t : ℝ} (hk : 0 < k)
    (hh : 0 ≤ h) (hhk : h ≤ k) (ht : 0 < t) :
    ContinuousAt (fun z : ℝ × ℝ => canonicalThetaGauge k h z.1 z.2) (x,t) := by
  have hf := profile_data (β := k-h-1) hk.le
  exact (canonicalTheta_continuousAt hk hh hhk ht).div
    (hf.smooth.continuous.comp continuous_fst).continuousAt (hf.pos x).ne'

theorem canonicalThetaGauge_contDiffAt {k h : ℝ} {z : ℝ × ℝ} (hk : 0 < k)
    (hh : 0 ≤ h) (hhk : h ≤ k) (hz : z ∈ canonicalContinuationRegion k h) :
    ContDiffAt ℝ 2 (fun y : ℝ × ℝ => canonicalThetaGauge k h y.1 y.2) z := by
  have hf := profile_data (β := k-h-1) hk.le
  exact ((canonicalTheta_contDiffAt hk hh hhk hz).of_le (WithTop.coe_le_coe.mpr le_top)).div
    ((hf.smooth.of_le (WithTop.coe_le_coe.mpr le_top)).contDiffAt.comp z contDiffAt_fst)
    (hf.pos z.1).ne'

theorem canonicalThetaGauge_equation {k h x t : ℝ} (hk : 0 < k)
    (hh : 0 ≤ h) (hhk : h ≤ k) (hz : (x,t) ∈ canonicalContinuationRegion k h) :
    deriv (canonicalThetaGauge k h x) t =
      deriv (deriv (fun y => canonicalThetaGauge k h y t)) x+
        incrementDrift k h x*deriv (fun y => canonicalThetaGauge k h y t) x := by
  have hs : ContDiffAt ℝ 2 (fun z : ℝ × ℝ => canonicalTheta k h z.1 z.2) (x,t) :=
    (canonicalTheta_contDiffAt hk hh hhk hz).of_le (WithTop.coe_le_coe.mpr le_top)
  have hsx : ContDiffAt ℝ 2 (fun y => canonicalTheta k h y t) x :=
    hs.comp (f := fun y : ℝ => (y,t)) x (by fun_prop)
  have hst : DifferentiableAt ℝ (canonicalTheta k h x) t :=
    (hs.comp (f := fun s : ℝ => (x,s)) t (by fun_prop)).differentiableAt (by norm_num)
  have hf : ProfileData ((k-h-1)-0) k (profile (k-h-1) k) := by
    simpa only [sub_zero] using profile_data (β := k-h-1) hk.le
  have he := gauge_equation (c := 0) (d := 0) hf hsx hst (canonicalTheta_equation hk hh hhk hz)
  have hfun : Comparison.gauge (canonicalTheta k h) (profile (k-h-1) k) 0 0 =
      canonicalThetaGauge k h := by
    funext y s
    simp [Comparison.gauge,canonicalThetaGauge]
  rw [hfun] at he
  simpa only [zero_mul,add_zero,sub_zero,incrementDrift,logSlope,mul_div_assoc] using he

theorem canonicalThetaGauge_nonneg {k h : ℝ} (hk : 0 < k) (x t : ℝ) :
    0 ≤ canonicalThetaGauge k h x t :=
  div_nonneg (canonicalTheta_nonneg hk.le x t) ((profile_data hk.le).pos x).le

theorem canonicalTheta_positive_earlier {k h x t : ℝ} (hk : 0 < k)
    (hh : 0 ≤ h) (hhk : h ≤ k) (hz : (x,t) ∈ canonicalContinuationRegion k h) :
    ∃ s ∈ Ioo 0 t, 0 < canonicalTheta k h x s := by
  have ht := hz.1
  have hc : ContinuousOn (canonicalPrice k h x) (Icc 0 t) :=
    ((canonicalPrice_continuous hk.le).comp
      (show Continuous (fun s : ℝ => (x,s)) by fun_prop)).continuousOn
  obtain ⟨s,hs,he⟩ := exists_deriv_eq_slope (canonicalPrice k h x) ht hc
    (fun s hs => (canonicalPrice_differentiableAt_time hk hh hhk hs.1).differentiableWithinAt)
  refine ⟨s,hs,?_⟩
  unfold canonicalTheta
  rw [he,canonicalPrice_initial hk.le,sub_zero]
  exact div_pos (sub_pos.mpr hz.2) ht

theorem canonicalTheta_pos {k h x t : ℝ} (hk : 0 < k)
    (hh : 0 ≤ h) (hhk : h ≤ k) (hz : (x,t) ∈ canonicalContinuationRegion k h) :
    0 < canonicalTheta k h x t := by
  obtain ⟨a,ha,hsource⟩ := canonicalTheta_positive_earlier hk hh hhk hz
  have hax : canonicalLogBoundary k h a < x := by
    by_contra! hn
    rw [canonicalTheta_exercise_zero hk hh hhk ha.1 hn] at hsource
    exact (lt_irrefl _ hsource)
  obtain ⟨M,hM⟩ := incrementDrift_bounded (h := h) hk
  have hregion (y s : ℝ) (hy : canonicalLogBoundary k h a < y) (hs : a < s) :
      (y,s) ∈ canonicalContinuationRegion k h := by
    rw [canonicalContinuationRegion_eq_logBoundary hk hh hhk]
    exact ⟨ha.1.trans hs,(canonicalLogBoundary_antitoneOn hk hh hhk ha.1.le
      (ha.1.trans hs).le hs.le).trans_lt hy⟩
  have hpos := positive_later_of_positive_point (U := canonicalThetaGauge k h)
    (D := fun y _ => incrementDrift k h y) (β := canonicalLogBoundary k h a)
    (a := a) (T := t) (x := x) (y := x) (M := M) ha.2 hax hax
    (fun z hz => (canonicalThetaGauge_continuousAt hk hh hhk (ha.1.trans_le hz.2.1)).continuousWithinAt)
    (fun y s hy hs _ => canonicalThetaGauge_contDiffAt hk hh hhk (hregion y s hy hs))
    (fun y s hy hs _ => canonicalThetaGauge_equation hk hh hhk (hregion y s hy hs))
    (fun y _ _ _ _ => hM y)
    (fun y s _ _ _ => canonicalThetaGauge_nonneg hk y s)
    (div_pos hsource ((profile_data hk.le).pos x))
  exact (div_pos_iff.mp hpos).resolve_right (by
    intro hn
    exact (not_lt_of_ge ((profile_data (β := k-h-1) hk.le).pos x).le) hn.2) |>.1

theorem zeroDividend_canonicalTheta_pos {k x t : ℝ} (hk : 0 < k)
    (hz : (x,t) ∈ canonicalContinuationRegion k 0) : 0 < canonicalTheta k 0 x t :=
  canonicalTheta_pos hk le_rfl hk.le hz

theorem liuRange_canonicalTheta_pos {k h x t : ℝ} (hh : 0 ≤ h) (hliu : h+1 ≤ k)
    (hz : (x,t) ∈ canonicalContinuationRegion k h) : 0 < canonicalTheta k h x t :=
  canonicalTheta_pos (by linarith) hh (by linarith) hz

end AmericanConvexity.Stopping
