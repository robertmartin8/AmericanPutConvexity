import AmericanPutConvexity.Stopping.ActualStockConvexity
import Mathlib.Analysis.Convex.Deriv

/-! # One-sided boundary speeds and the remaining corner obstruction

Convexity gives finite left and right derivatives at every positive time.
Both are negative, but their equality is not assumed or proved here. The
equivalence below isolates exactly what is needed for first differentiability.
-/

namespace AmericanPutConvexity.Stopping

open Set Boundary

theorem canonicalLogBoundary_oneSidedDerivs {k h t : ℝ} (hk : 0 < k)
    (hh : 0 ≤ h) (hhk : h ≤ k) (ht : 0 < t) :
    HasDerivWithinAt (canonicalLogBoundary k h)
        (derivWithin (canonicalLogBoundary k h) (Iio t) t) (Iio t) t ∧
      HasDerivWithinAt (canonicalLogBoundary k h)
        (derivWithin (canonicalLogBoundary k h) (Ioi t) t) (Ioi t) t ∧
      derivWithin (canonicalLogBoundary k h) (Iio t) t ≤
        derivWithin (canonicalLogBoundary k h) (Ioi t) t ∧
      derivWithin (canonicalLogBoundary k h) (Ioi t) t < 0 := by
  have hc := canonicalLogBoundary_convexOn hk hh hhk
  have hi : t ∈ interior (Ioi (0 : ℝ)) := by rw [interior_Ioi]; exact ht
  refine ⟨hc.hasDerivWithinAt_leftDeriv_of_mem_interior hi,
    hc.hasDerivWithinAt_rightDeriv_of_mem_interior hi,
    hc.leftDeriv_le_rightDeriv_of_mem_interior hi,?_⟩
  have hu : t+1 ∈ Ioi (0 : ℝ) := by change 0 < t+1; linarith
  have htu : t < t+1 := by linarith
  apply (hc.rightDeriv_le_slope_of_mem_interior hi hu htu).trans_lt
  rw [slope_def_field]
  exact div_neg_of_neg_of_pos
    (sub_neg.mpr (canonicalLogBoundary_strictAntiOn hk hh hhk ht hu htu)) (by linarith)

theorem canonicalLogBoundary_oneSidedDerivs_monotone {k h : ℝ} (hk : 0 < k)
    (hh : 0 ≤ h) (hhk : h ≤ k) :
    MonotoneOn (fun t => derivWithin (canonicalLogBoundary k h) (Iio t) t) (Ioi 0) ∧
      MonotoneOn (fun t => derivWithin (canonicalLogBoundary k h) (Ioi t) t) (Ioi 0) := by
  have hc := canonicalLogBoundary_convexOn hk hh hhk
  constructor
  · simpa only [interior_Ioi] using hc.monotoneOn_leftDeriv
  · simpa only [interior_Ioi] using hc.monotoneOn_rightDeriv

theorem canonicalLogBoundary_differentiableAt_iff_oneSided_eq {k h t : ℝ} (hk : 0 < k)
    (hh : 0 ≤ h) (hhk : h ≤ k) (ht : 0 < t) :
    DifferentiableAt ℝ (canonicalLogBoundary k h) t ↔
      derivWithin (canonicalLogBoundary k h) (Iio t) t =
        derivWithin (canonicalLogBoundary k h) (Ioi t) t := by
  constructor
  · intro hd
    rw [hd.derivWithin (uniqueDiffWithinAt_Iio t),hd.derivWithin (uniqueDiffWithinAt_Ioi t)]
  · intro heq
    obtain ⟨hl,hr,_,_⟩ := canonicalLogBoundary_oneSidedDerivs hk hh hhk ht
    rw [heq] at hl
    have hd := hl.Iic_of_Iio.union hr.Ici_of_Ioi
    rw [Iic_union_Ici] at hd
    exact (hd.hasDerivAt (by simp)).differentiableAt

theorem canonicalLogBoundary_deriv_neg_of_differentiableAt {k h t : ℝ} (hk : 0 < k)
    (hh : 0 ≤ h) (hhk : h ≤ k) (ht : 0 < t)
    (hd : DifferentiableAt ℝ (canonicalLogBoundary k h) t) :
    deriv (canonicalLogBoundary k h) t < 0 := by
  have hn := (canonicalLogBoundary_oneSidedDerivs hk hh hhk ht).2.2.2
  rwa [hd.derivWithin (uniqueDiffWithinAt_Ioi t)] at hn

theorem zeroDividend_canonicalLogBoundary_oneSided_speed {k t : ℝ}
    (hk : 0 < k) (ht : 0 < t) :
    derivWithin (canonicalLogBoundary k 0) (Iio t) t ≤
        derivWithin (canonicalLogBoundary k 0) (Ioi t) t ∧
      derivWithin (canonicalLogBoundary k 0) (Ioi t) t < 0 :=
  (canonicalLogBoundary_oneSidedDerivs hk le_rfl hk.le ht).2.2

theorem liuRange_canonicalLogBoundary_oneSided_speed {k h t : ℝ}
    (hh : 0 ≤ h) (hliu : h+1 ≤ k) (ht : 0 < t) :
    derivWithin (canonicalLogBoundary k h) (Iio t) t ≤
        derivWithin (canonicalLogBoundary k h) (Ioi t) t ∧
      derivWithin (canonicalLogBoundary k h) (Ioi t) t < 0 :=
  (canonicalLogBoundary_oneSidedDerivs (by linarith) hh (by linarith) ht).2.2

end AmericanPutConvexity.Stopping
