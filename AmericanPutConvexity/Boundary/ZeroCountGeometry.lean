import AmericanPutConvexity.Boundary.InitialRoots

/-!
# From at most two level roots to an interval-shaped superlevel set

These are spatial continuity arguments, not parabolic zero-number theorems.
Strictly negative endpoint data are essential: two positive pieces would
force at least three distinct roots, including a possible isolated zero
between positive values. Positive-level interval results then imply the
zero-level result by choosing a small positive level below both endpoints.
-/

namespace AmericanPutConvexity.Boundary

open Set

theorem not_three_mem_of_subset_pair {S : Set ℝ} {a b c : ℝ}
    (hS : ∃ u v : ℝ, S ⊆ {u,v}) (ha : a ∈ S) (hb : b ∈ S) (hc : c ∈ S)
    (hab : a < b) (hbc : b < c) : False := by
  have heq := eq_pair_of_subset_pair hS ha hc (hab.trans hbc).ne
  rw [heq] at hb
  rcases hb with he | he
  · exact hab.ne' he
  · exact hbc.ne (mem_singleton_iff.mp he)

/-- Negative endpoint values and at most two level roots force each strict
superlevel set in the interval to be order-connected, including the empty case. -/
theorem superlevel_ordConnected_of_two_roots {F : ℝ → ℝ} {l r ε : ℝ}
    (hF : ContinuousOn F (Icc l r)) (hl : F l < ε) (hr : F r < ε)
    (hroots : ∃ a b : ℝ, {x | l < x ∧ x < r ∧ F x = ε} ⊆ {a,b}) :
    OrdConnected {x | l < x ∧ x < r ∧ ε < F x} := by
  rw [ordConnected_iff]
  intro x hx z hz _ y hy
  refine ⟨hx.1.trans_le hy.1, hy.2.trans_lt hz.2.1, ?_⟩
  by_contra hn
  have hyle : F y ≤ ε := le_of_not_gt hn
  have hxy : x < y := lt_of_le_of_ne hy.1 (by intro he; rw [← he] at hyle; linarith [hx.2.2])
  have hyz : y < z := lt_of_le_of_ne hy.2 (by intro he; rw [he] at hyle; linarith [hz.2.2])
  obtain ⟨a,ha,haeq⟩ := intermediate_value_Icc hx.1.le
    (hF.mono (Icc_subset_Icc le_rfl (hx.2.1.le))) ⟨hl.le,hx.2.2.le⟩
  obtain ⟨b,hb,hbeq⟩ := intermediate_value_Icc' hxy.le
    (hF.mono (Icc_subset_Icc hx.1.le ((hy.2.trans_lt hz.2.1).le))) ⟨hyle,hx.2.2.le⟩
  obtain ⟨c,hc,hceq⟩ := intermediate_value_Icc' hz.2.1.le
    (hF.mono (Icc_subset_Icc hz.1.le le_rfl)) ⟨hr.le,hz.2.2.le⟩
  have hla : l < a := lt_of_le_of_ne ha.1 (by intro he; rw [← he] at haeq; linarith)
  have hax : a < x := lt_of_le_of_ne ha.2 (by intro he; rw [he] at haeq; linarith [hx.2.2])
  have hxb : x < b := lt_of_le_of_ne hb.1 (by intro he; rw [← he] at hbeq; linarith [hx.2.2])
  have hzc : z < c := lt_of_le_of_ne hc.1 (by intro he; rw [← he] at hceq; linarith [hz.2.2])
  have hcr : c < r := lt_of_le_of_ne hc.2 (by intro he; rw [he] at hceq; linarith)
  exact not_three_mem_of_subset_pair hroots
    ⟨hla,hax.trans hx.2.1,haeq⟩
    ⟨hx.1.trans hxb,(hb.2.trans hy.2).trans_lt hz.2.1,hbeq⟩
    ⟨hz.1.trans hzc,hcr,hceq⟩ (hax.trans hxb) ((hb.2.trans_lt hyz).trans hzc)

/-- The positive set is an interval if all positive strict superlevel sets
are intervals. This is the epsilon-to-zero step without an interchange of
limits or an assumption that zero-level roots are simple. -/
theorem positive_set_ordConnected_of_positive_levels {F : ℝ → ℝ} {S : Set ℝ}
    (hlevels : ∀ ε : ℝ, 0 < ε → OrdConnected {x | x ∈ S ∧ ε < F x}) :
    OrdConnected {x | x ∈ S ∧ 0 < F x} := by
  rw [ordConnected_iff]
  intro x hx z hz _ y hy
  let ε := min (F x) (F z) / 2
  have hε : 0 < ε := div_pos (lt_min hx.2 hz.2) (by norm_num)
  have hxε : ε < F x := by dsimp [ε]; linarith [min_le_left (F x) (F z), hx.2]
  have hzε : ε < F z := by dsimp [ε]; linarith [min_le_right (F x) (F z), hz.2]
  have hm := (hlevels ε hε).out ⟨hx.1,hxε⟩ ⟨hz.1,hzε⟩ hy
  exact ⟨hm.1,hε.trans hm.2⟩

end AmericanPutConvexity.Boundary
