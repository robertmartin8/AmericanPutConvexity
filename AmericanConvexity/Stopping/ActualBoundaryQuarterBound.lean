import AmericanConvexity.Stopping.ActualExpiryUpperBound
import AmericanConvexity.Stopping.ActualBoundaryTemporalModulus

/-! # A local quarter-power modulus for the actual exercise boundary

The explicit square-root time modulus for price and quadratic separation from
contact give a quarter-power boundary modulus. This is an intermediate
regularity result, not differentiability or smoothness of the boundary.
-/

namespace AmericanConvexity.Stopping

open Set

theorem quarter_bound_of_square_bound {A H D z : ℝ} (hA : 0 < A) (hH : 0 ≤ H)
    (hD : 0 ≤ D) (hz : 0 ≤ z) (hz1 : z ≤ 1)
    (hbound : A/4*D^2 ≤ Real.sqrt z+H*z) :
    D ≤ (1+4*(1+H)/A)*Real.sqrt (Real.sqrt z) := by
  have hs : z ≤ Real.sqrt z := by
    nlinarith [Real.sqrt_nonneg z,Real.sq_sqrt hz]
  have hu : Real.sqrt z+H*z ≤ (1+H)*Real.sqrt z := by
    nlinarith [mul_le_mul_of_nonneg_left hs hH]
  let C := 4*(1+H)/A
  have hC : 0 ≤ C := by dsimp [C]; positivity
  have hd2 : D^2 ≤ C*Real.sqrt z := by
    dsimp only [C]
    rw [div_mul_eq_mul_div,le_div_iff₀ hA]
    nlinarith
  apply (sq_le_sq₀ hD (mul_nonneg (by positivity) (Real.sqrt_nonneg _))).mp
  rw [mul_pow,Real.sq_sqrt (Real.sqrt_nonneg z)]
  exact hd2.trans (mul_le_mul_of_nonneg_right (by change C ≤ (1+C)^2; nlinarith) (Real.sqrt_nonneg z))

theorem canonicalLogBoundary_squared_increment_sqrt_bound {k h t : ℝ}
    (hk : 0 < k) (hh : 0 ≤ h) (hhk : h ≤ k) (ht : 0 < t) :
    ∃ η : ℝ, 0 < η ∧ ∀ s u : ℝ, dist s t < η → dist u t < η → s ≤ u →
      0 < s ∧ 0 < u ∧
      (k-h*Real.exp (canonicalLogBoundary k h t))/4 *
          (canonicalLogBoundary k h s-canonicalLogBoundary k h u)^2 ≤
        Real.sqrt (u-s)+|k-h-1| * (u-s) := by
  obtain ⟨η,hη,hbound⟩ := canonicalLogBoundary_increment_le_atStrike hk hh hhk ht
  refine ⟨η,hη,?_⟩
  intro s u hs hu hsu
  obtain ⟨hs0,hu0,hb⟩ := hbound s u hs hu hsu
  exact ⟨hs0,hu0,hb.trans (canonicalPrice_atStrike_sqrt_bound hk (sub_nonneg.mpr hsu))⟩

/-- The nested square root is the quarter-power modulus for nonnegative
distance. This theorem applies to every pair of maturities in one neighborhood. -/
theorem canonicalLogBoundary_local_quarter_bound {k h t : ℝ}
    (hk : 0 < k) (hh : 0 ≤ h) (hhk : h ≤ k) (ht : 0 < t) :
    ∃ η C : ℝ, 0 < η ∧ 0 < C ∧ ∀ s u : ℝ, dist s t < η → dist u t < η →
      dist (canonicalLogBoundary k h s) (canonicalLogBoundary k h u) ≤
        C*Real.sqrt (Real.sqrt (dist s u)) := by
  obtain ⟨η₀,hη₀,hbound⟩ := canonicalLogBoundary_squared_increment_sqrt_bound hk hh hhk ht
  let A := k-h*Real.exp (canonicalLogBoundary k h t)
  have hA : 0 < A := canonicalBoundary_forcing_pos hk hh hhk ht
  let C := 1+4*(1+|k-h-1|)/A
  have hC : 0 < C := by dsimp [C]; positivity
  let η := min η₀ (1/2)
  have hη : 0 < η := lt_min hη₀ (by norm_num)
  have hη₁ : η ≤ 1/2 := min_le_right _ _
  have hηsmall : η ≤ η₀ := min_le_left _ _
  have hordered : ∀ s u : ℝ, dist s t < η → dist u t < η → s ≤ u →
      dist (canonicalLogBoundary k h s) (canonicalLogBoundary k h u) ≤
        C*Real.sqrt (Real.sqrt (dist s u)) := by
    intro s u hs hu hsu
    obtain ⟨hs0,hu0,hb⟩ := hbound s u (hs.trans_le hηsmall) (hu.trans_le hηsmall) hsu
    have hm : canonicalLogBoundary k h u ≤ canonicalLogBoundary k h s :=
      canonicalLogBoundary_antitoneOn hk hh hhk hs0.le hu0.le hsu
    have hd : dist u s < 1 :=
      (dist_triangle u t s).trans_lt
        ((add_lt_add hu (by simpa only [dist_comm] using hs)).trans_le (by linarith))
    have hz1 : u-s ≤ 1 := by
      rw [Real.dist_eq,abs_of_nonneg (sub_nonneg.mpr hsu)] at hd
      exact hd.le
    have he := quarter_bound_of_square_bound hA (abs_nonneg (k-h-1))
      (sub_nonneg.mpr hm) (sub_nonneg.mpr hsu) hz1 hb
    simpa only [Real.dist_eq,abs_of_nonneg (sub_nonneg.mpr hm),
      abs_of_nonpos (sub_nonpos.mpr hsu),neg_sub] using he
  refine ⟨η,C,hη,hC,?_⟩
  intro s u hs hu
  rcases le_total s u with hsu | hus
  · exact hordered s u hs hu hsu
  · simpa only [dist_comm] using hordered u s hu hs hus

theorem zeroDividend_canonicalLogBoundary_local_quarter_bound {k t : ℝ}
    (hk : 0 < k) (ht : 0 < t) :
    ∃ η C : ℝ, 0 < η ∧ 0 < C ∧ ∀ s u : ℝ, dist s t < η → dist u t < η →
      dist (canonicalLogBoundary k 0 s) (canonicalLogBoundary k 0 u) ≤
        C*Real.sqrt (Real.sqrt (dist s u)) :=
  canonicalLogBoundary_local_quarter_bound hk le_rfl hk.le ht

theorem liuRange_canonicalLogBoundary_local_quarter_bound {k h t : ℝ}
    (hh : 0 ≤ h) (hliu : h+1 ≤ k) (ht : 0 < t) :
    ∃ η C : ℝ, 0 < η ∧ 0 < C ∧ ∀ s u : ℝ, dist s t < η → dist u t < η →
      dist (canonicalLogBoundary k h s) (canonicalLogBoundary k h u) ≤
        C*Real.sqrt (Real.sqrt (dist s u)) :=
  canonicalLogBoundary_local_quarter_bound (by linarith) hh (by linarith) ht

end AmericanConvexity.Stopping
