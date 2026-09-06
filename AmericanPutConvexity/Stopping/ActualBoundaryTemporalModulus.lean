import AmericanPutConvexity.Stopping.ActualTemporalModulus
import AmericanPutConvexity.Stopping.ActualBoundaryIncrement

/-! # A scalar at-strike price controls local boundary displacement

Combining quadratic separation with the actual temporal comparison removes
the price increment at a moving spot from the boundary estimate. An explicit
small-time bound for the at-strike price would turn this into a rate.
-/

namespace AmericanPutConvexity.Stopping

open Set

theorem canonicalLogBoundary_increment_le_atStrike {k h t : ℝ} (hk : 0 < k)
    (hh : 0 ≤ h) (hhk : h ≤ k) (ht : 0 < t) :
    ∃ η : ℝ, 0 < η ∧ ∀ s u : ℝ, dist s t < η → dist u t < η → s ≤ u →
      0 < s ∧ 0 < u ∧
      (k-h*Real.exp (canonicalLogBoundary k h t))/4 *
          (canonicalLogBoundary k h s-canonicalLogBoundary k h u)^2 ≤
        canonicalPrice k h 0 (u-s) := by
  obtain ⟨η,hη,hbound⟩ := canonicalLogBoundary_increment_bounds hk hh hhk ht
  refine ⟨η,hη,?_⟩
  intro s u hs hu hsu
  obtain ⟨hs0,hu0,_hgrad,hprice⟩ := hbound s u hs hu hsu
  refine ⟨hs0,hu0,hprice.trans ?_⟩
  have he := canonicalTimeIncrement_le_atStrike hk hh hhk (sub_nonneg.mpr hsu)
    (canonicalLogBoundary k h s) hs0.le
  simpa only [canonicalTimeIncrement,show s+(u-s)=u by ring] using he

theorem zeroDividend_canonicalLogBoundary_increment_le_atStrike {k t : ℝ}
    (hk : 0 < k) (ht : 0 < t) :
    ∃ η : ℝ, 0 < η ∧ ∀ s u : ℝ, dist s t < η → dist u t < η → s ≤ u →
      0 < s ∧ 0 < u ∧ k/4*(canonicalLogBoundary k 0 s-canonicalLogBoundary k 0 u)^2 ≤
        canonicalPrice k 0 0 (u-s) := by
  simpa only [zero_mul,sub_zero] using canonicalLogBoundary_increment_le_atStrike hk le_rfl hk.le ht

theorem liuRange_canonicalLogBoundary_increment_le_atStrike {k h t : ℝ}
    (hh : 0 ≤ h) (hliu : h+1 ≤ k) (ht : 0 < t) :
    ∃ η : ℝ, 0 < η ∧ ∀ s u : ℝ, dist s t < η → dist u t < η → s ≤ u →
      0 < s ∧ 0 < u ∧
      (k-h*Real.exp (canonicalLogBoundary k h t))/4 *
          (canonicalLogBoundary k h s-canonicalLogBoundary k h u)^2 ≤
        canonicalPrice k h 0 (u-s) :=
  canonicalLogBoundary_increment_le_atStrike (by linarith) hh (by linarith) ht

end AmericanPutConvexity.Stopping
