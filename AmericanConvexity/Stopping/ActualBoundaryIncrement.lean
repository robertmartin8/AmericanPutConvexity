import AmericanConvexity.Stopping.ActualQuadraticSeparation

/-! # Quantitative control of actual boundary increments

Uniform separation at the later maturity bounds boundary displacement by
price and gradient increments at the earlier exercise spot. This isolates
the temporal estimates needed for stronger free-boundary regularity.
-/

namespace AmericanConvexity.Stopping

open Set Filter Boundary
open scoped Topology

theorem canonicalLogBoundary_increment_bounds {k h t : ℝ} (hk : 0 < k)
    (hh : 0 ≤ h) (hhk : h ≤ k) (ht : 0 < t) :
    ∃ η : ℝ, 0 < η ∧ ∀ s u : ℝ, dist s t < η → dist u t < η → s ≤ u →
      0 < s ∧ 0 < u ∧
      (k-h*Real.exp (canonicalLogBoundary k h t))/2 *
          (canonicalLogBoundary k h s-canonicalLogBoundary k h u) ≤
        deriv (fun y => canonicalPrice k h y u) (canonicalLogBoundary k h s) -
          deriv (fun y => canonicalPrice k h y s) (canonicalLogBoundary k h s) ∧
      (k-h*Real.exp (canonicalLogBoundary k h t))/4 *
          (canonicalLogBoundary k h s-canonicalLogBoundary k h u)^2 ≤
        canonicalPrice k h (canonicalLogBoundary k h s) u -
          canonicalPrice k h (canonicalLogBoundary k h s) s := by
  obtain ⟨δ,hδ,hsep⟩ := canonicalIntrinsicPremium_separation_near_boundary hk hh hhk ht
  have hbnear : ∀ᶠ s in 𝓝 t,
      dist (canonicalLogBoundary k h s) (canonicalLogBoundary k h t) < δ/2 :=
    Metric.tendsto_nhds.mp (canonicalLogBoundary_continuousAt hk hh hhk ht.le)
      (δ/2) (half_pos hδ)
  obtain ⟨ρ,hρ,hρball⟩ := Metric.mem_nhds_iff.mp hbnear
  let η := min δ ρ
  have hη : 0 < η := lt_min hδ hρ
  refine ⟨η,hη,?_⟩
  intro s u hs hu hsu
  obtain ⟨hs0,_⟩ := hsep s (hs.trans_le (min_le_left _ _))
  obtain ⟨hu0,husep⟩ := hsep u (hu.trans_le (min_le_left _ _))
  have hbs := hρball (show s ∈ Metric.ball t ρ from hs.trans_le (min_le_right _ _))
  have hbu := hρball (show u ∈ Metric.ball t ρ from hu.trans_le (min_le_right _ _))
  change dist (canonicalLogBoundary k h s) (canonicalLogBoundary k h t) < δ/2 at hbs
  change dist (canonicalLogBoundary k h u) (canonicalLogBoundary k h t) < δ/2 at hbu
  have hmove : dist (canonicalLogBoundary k h s) (canonicalLogBoundary k h u) < δ := by
    have he := (dist_triangle (canonicalLogBoundary k h s) (canonicalLogBoundary k h t)
      (canonicalLogBoundary k h u)).trans_lt (add_lt_add hbs (by rwa [dist_comm] at hbu))
    linarith
  have hmono : canonicalLogBoundary k h u ≤ canonicalLogBoundary k h s :=
    canonicalLogBoundary_antitoneOn hk hh hhk hs0.le hu0.le hsu
  have hspot : canonicalLogBoundary k h s ∈
      Icc (canonicalLogBoundary k h u) (canonicalLogBoundary k h u+δ) := by
    refine ⟨hmono,?_⟩
    rw [Real.dist_eq,abs_of_nonneg (sub_nonneg.mpr hmono)] at hmove
    linarith
  obtain ⟨hgrad,hprice⟩ := husep (canonicalLogBoundary k h s) hspot
  refine ⟨hs0,hu0,?_,?_⟩
  · rw [(canonicalPrice_hasDerivAt_boundary hk hh hhk hs0).deriv,sub_neg_eq_add]
    rwa [canonicalIntrinsicPremium_spatial_deriv hk hh hhk hu0] at hgrad
  · rwa [canonicalIntrinsicPremium,← canonicalPrice_value_matching hk hh hhk hs0] at hprice

theorem zeroDividend_canonicalLogBoundary_increment_bounds {k t : ℝ} (hk : 0 < k) (ht : 0 < t) :
    ∃ η : ℝ, 0 < η ∧ ∀ s u : ℝ, dist s t < η → dist u t < η → s ≤ u →
      0 < s ∧ 0 < u ∧
      k/2*(canonicalLogBoundary k 0 s-canonicalLogBoundary k 0 u) ≤
        deriv (fun y => canonicalPrice k 0 y u) (canonicalLogBoundary k 0 s) -
          deriv (fun y => canonicalPrice k 0 y s) (canonicalLogBoundary k 0 s) ∧
      k/4*(canonicalLogBoundary k 0 s-canonicalLogBoundary k 0 u)^2 ≤
        canonicalPrice k 0 (canonicalLogBoundary k 0 s) u -
          canonicalPrice k 0 (canonicalLogBoundary k 0 s) s := by
  simpa only [zero_mul,sub_zero] using canonicalLogBoundary_increment_bounds hk le_rfl hk.le ht

theorem liuRange_canonicalLogBoundary_increment_bounds {k h t : ℝ}
    (hh : 0 ≤ h) (hliu : h+1 ≤ k) (ht : 0 < t) :
    ∃ η : ℝ, 0 < η ∧ ∀ s u : ℝ, dist s t < η → dist u t < η → s ≤ u →
      0 < s ∧ 0 < u ∧
      (k-h*Real.exp (canonicalLogBoundary k h t))/2 *
          (canonicalLogBoundary k h s-canonicalLogBoundary k h u) ≤
        deriv (fun y => canonicalPrice k h y u) (canonicalLogBoundary k h s) -
          deriv (fun y => canonicalPrice k h y s) (canonicalLogBoundary k h s) ∧
      (k-h*Real.exp (canonicalLogBoundary k h t))/4 *
          (canonicalLogBoundary k h s-canonicalLogBoundary k h u)^2 ≤
        canonicalPrice k h (canonicalLogBoundary k h s) u -
          canonicalPrice k h (canonicalLogBoundary k h s) s :=
  canonicalLogBoundary_increment_bounds (by linarith) hh (by linarith) ht

end AmericanConvexity.Stopping
