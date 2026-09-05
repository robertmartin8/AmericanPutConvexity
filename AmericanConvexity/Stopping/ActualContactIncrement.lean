import AmericanConvexity.Stopping.ActualQuadraticUpper
import AmericanConvexity.Stopping.ActualContactDifferentiability

/-! # Quadratic time increments at the earlier exercise boundary

Locally Lipschitz boundary motion and quadratic upper growth of the premium
give a uniform second-order bound on time increments taken at contact.
This is boundary data for a subsequent comparison of time difference quotients.
-/

namespace AmericanConvexity.Stopping

open Set Filter Boundary
open scoped Topology

theorem canonicalLogBoundary_local_pairwise_lipschitz {k h t : ℝ} (hk : 0 < k)
    (hh : 0 ≤ h) (hhk : h ≤ k) (ht : 0 < t) :
    ∃ η L : ℝ, 0 < η ∧ 0 ≤ L ∧ ∀ s u : ℝ, dist s t < η → dist u t < η →
      dist (canonicalLogBoundary k h s) (canonicalLogBoundary k h u) ≤ L*dist s u := by
  obtain ⟨L,S,hS,hLip⟩ := canonicalLogBoundary_locallyLipschitzOn hk hh hhk ht
  rw [nhdsWithin_eq_nhds.mpr (Ioi_mem_nhds ht)] at hS
  obtain ⟨η,hη,hball⟩ := Metric.mem_nhds_iff.mp hS
  exact ⟨η,L,hη,L.coe_nonneg,fun s u hs hu => hLip.dist_le_mul s (hball hs) u (hball hu)⟩

theorem canonicalPrice_contact_increment_quadratic {k h t : ℝ} (hk : 0 < k)
    (hh : 0 ≤ h) (hhk : h ≤ k) (ht : 0 < t) :
    ∃ η A : ℝ, 0 < η ∧ 0 < A ∧ ∀ s u : ℝ, dist s t < η → dist u t < η → s ≤ u →
      0 < s ∧ 0 < u ∧
      0 ≤ canonicalPrice k h (canonicalLogBoundary k h s) u -
        canonicalPrice k h (canonicalLogBoundary k h s) s ∧
      canonicalPrice k h (canonicalLogBoundary k h s) u -
        canonicalPrice k h (canonicalLogBoundary k h s) s ≤ A*(u-s)^2 := by
  obtain ⟨δ,C,hδ,hC,hupper⟩ := canonicalIntrinsicPremium_upper_near_boundary hk hh hhk ht
  obtain ⟨ρ,L,hρ,hL,hLip⟩ := canonicalLogBoundary_local_pairwise_lipschitz hk hh hhk ht
  have hbnear : ∀ᶠ s in 𝓝 t,
      dist (canonicalLogBoundary k h s) (canonicalLogBoundary k h t) < δ/2 :=
    Metric.tendsto_nhds.mp (canonicalLogBoundary_continuousAt hk hh hhk ht.le)
      (δ/2) (half_pos hδ)
  obtain ⟨ζ,hζ,hζball⟩ := Metric.mem_nhds_iff.mp hbnear
  let η := min δ (min ρ ζ)
  have hη : 0 < η := lt_min hδ (lt_min hρ hζ)
  have hηδ : η ≤ δ := min_le_left _ _
  have hηρ : η ≤ ρ := (min_le_right _ _).trans (min_le_left _ _)
  have hηζ : η ≤ ζ := (min_le_right _ _).trans (min_le_right _ _)
  let A := C/2*L^2+1
  have hA : 0 < A := by dsimp [A]; positivity
  refine ⟨η,A,hη,hA,?_⟩
  intro s u hs hu hsu
  obtain ⟨hs0,_⟩ := hupper s (hs.trans_le hηδ)
  obtain ⟨hu0,huupper⟩ := hupper u (hu.trans_le hηδ)
  have hbs := hζball (show s ∈ Metric.ball t ζ from hs.trans_le hηζ)
  have hbu := hζball (show u ∈ Metric.ball t ζ from hu.trans_le hηζ)
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
  have hprice := (huupper (canonicalLogBoundary k h s) hspot).2
  rw [canonicalIntrinsicPremium,← canonicalPrice_value_matching hk hh hhk hs0] at hprice
  have hdist := hLip s u (hs.trans_le hηρ) (hu.trans_le hηρ)
  rw [Real.dist_eq,abs_of_nonneg (sub_nonneg.mpr hmono),Real.dist_eq,
    abs_of_nonpos (sub_nonpos.mpr hsu),neg_sub] at hdist
  have hsq : (canonicalLogBoundary k h s-canonicalLogBoundary k h u)^2 ≤ (L*(u-s))^2 :=
    pow_le_pow_left₀ (sub_nonneg.mpr hmono) hdist 2
  have hmul := mul_le_mul_of_nonneg_left hsq (by positivity : 0 ≤ C/2)
  refine ⟨hs0,hu0,sub_nonneg.mpr (canonicalPrice_monotone_time hk.le _ hsu),?_⟩
  calc
    _ ≤ C/2*(canonicalLogBoundary k h s-canonicalLogBoundary k h u)^2 := hprice
    _ ≤ C/2*(L*(u-s))^2 := hmul
    _ ≤ A*(u-s)^2 := by dsimp [A]; nlinarith [sq_nonneg (u-s)]

/-- The left-boundary data for positive time difference quotients tends to
zero uniformly in the base maturity on a fixed positive-time neighborhood. -/
theorem canonicalPrice_contact_difference_quotient_bound {k h t : ℝ} (hk : 0 < k)
    (hh : 0 ≤ h) (hhk : h ≤ k) (ht : 0 < t) :
    ∃ η A : ℝ, 0 < η ∧ 0 < A ∧ ∀ s δ : ℝ, dist s t < η → 0 < δ → δ < η →
      0 < s ∧
      0 ≤ (canonicalPrice k h (canonicalLogBoundary k h s) (s+δ) -
        canonicalPrice k h (canonicalLogBoundary k h s) s)/δ ∧
      (canonicalPrice k h (canonicalLogBoundary k h s) (s+δ) -
        canonicalPrice k h (canonicalLogBoundary k h s) s)/δ ≤ A*δ := by
  obtain ⟨ρ,A,hρ,hA,hbound⟩ := canonicalPrice_contact_increment_quadratic hk hh hhk ht
  refine ⟨ρ/2,A,half_pos hρ,hA,?_⟩
  intro s δ hs hδ hδρ
  have hu : dist (s+δ) t < ρ := by
    have he := dist_triangle (s+δ) s t
    have hd : dist (s+δ) s = δ := by rw [Real.dist_eq]; simp [abs_of_pos hδ]
    rw [hd] at he
    linarith
  obtain ⟨hs0,_,hlo,hhi⟩ := hbound s (s+δ) (by linarith) hu (by linarith)
  refine ⟨hs0,div_nonneg hlo hδ.le,(div_le_iff₀ hδ).mpr ?_⟩
  convert! hhi using 1
  ring

theorem zeroDividend_canonicalPrice_contact_increment_quadratic {k t : ℝ}
    (hk : 0 < k) (ht : 0 < t) :
    ∃ η A : ℝ, 0 < η ∧ 0 < A ∧ ∀ s u : ℝ, dist s t < η → dist u t < η → s ≤ u →
      0 < s ∧ 0 < u ∧
      0 ≤ canonicalPrice k 0 (canonicalLogBoundary k 0 s) u -
        canonicalPrice k 0 (canonicalLogBoundary k 0 s) s ∧
      canonicalPrice k 0 (canonicalLogBoundary k 0 s) u -
        canonicalPrice k 0 (canonicalLogBoundary k 0 s) s ≤ A*(u-s)^2 :=
  canonicalPrice_contact_increment_quadratic hk le_rfl hk.le ht

theorem liuRange_canonicalPrice_contact_increment_quadratic {k h t : ℝ}
    (hh : 0 ≤ h) (hliu : h+1 ≤ k) (ht : 0 < t) :
    ∃ η A : ℝ, 0 < η ∧ 0 < A ∧ ∀ s u : ℝ, dist s t < η → dist u t < η → s ≤ u →
      0 < s ∧ 0 < u ∧
      0 ≤ canonicalPrice k h (canonicalLogBoundary k h s) u -
        canonicalPrice k h (canonicalLogBoundary k h s) s ∧
      canonicalPrice k h (canonicalLogBoundary k h s) u -
        canonicalPrice k h (canonicalLogBoundary k h s) s ≤ A*(u-s)^2 :=
  canonicalPrice_contact_increment_quadratic (by linarith) hh (by linarith) ht

end AmericanConvexity.Stopping
