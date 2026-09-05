import AmericanConvexity.Boundary.InitialRoots

/-!
# Confinement of comparison roots near expiry

Continuity on compact sets, the proved uniform tail, and continuity of the
exercise boundary confine every positive-level root at small positive times
to any open neighborhood of the initial roots. No initial derivative
convergence, parabolic zero-count theorem, or interval invariant is assumed.
This is confinement only: multiple roots inside one neighborhood are not yet
excluded.
-/

namespace AmericanConvexity.Boundary

open Set Filter
open scoped Topology

/-- Relative joint continuity suffices for uniform avoidance of a level on
a compact set with no initial roots. Clamping time at zero is only a device
for applying compactness; no PDE is asserted for the extension. -/
theorem eventually_avoid_level_on_compact {V : ℝ → ℝ → ℝ} {K : Set ℝ} {ε : ℝ}
    (hV : ContinuousOn (fun z : ℝ × ℝ => V z.1 z.2) {z | 0 ≤ z.2})
    (hK : IsCompact K) (hzero : ∀ x ∈ K, V x 0 ≠ ε) :
    ∀ᶠ t in 𝓝[≥] 0, ∀ x ∈ K, V x t ≠ ε := by
  have hclamp : Continuous (fun z : ℝ × ℝ => V z.2 (max z.1 0)) :=
    hV.comp_continuous (show Continuous (fun z : ℝ × ℝ => (z.2,max z.1 0)) by fun_prop)
      (fun z => le_max_right z.1 0)
  have he : ∀ᶠ t in 𝓝 (0 : ℝ), ∀ x ∈ K, V x (max t 0) ≠ ε :=
    hK.eventually_forall_of_forall_eventually (fun x hx => by
      have hne : V x (max 0 0) ≠ ε := by simpa using hzero x hx
      exact hclamp.continuousAt.eventually (eventually_ne_nhds hne))
  filter_upwards [nhdsWithin_le_nhds he, self_mem_nhdsWithin] with t ht ht0
  simpa only [max_eq_left (show 0 ≤ t from ht0)] using ht

namespace Comparison

variable {k h c d : ℝ} {p : ℝ → ℝ → ℝ} {b : ℝ → ℝ}

/-- At expiry and below strike the actual difference is nonpositive. This
uses the correct nonzero payoff there, not the zero-payoff initial formula. -/
theorem straightDifference_initial_nonpos_left (hp : DividendPutSolution k h p b)
    (hc : 0 ≤ c) (hd : d ≤ 0) {x : ℝ} (hx : x ≤ 0) :
    straightDifference p k h c d x 0 ≤ 0 := by
  have hpay : p x 0 = 1 - Real.exp x := by
    rw [hp.initial]
    apply max_eq_left
    have := Real.exp_le_one_iff.mpr hx
    linarith
  have hq := straightPrice_dominates hp.dividend_nonneg hp.dividend_le_rate hc hd (t := 0) le_rfl hx
  apply div_nonpos_of_nonpos_of_nonneg _ ((profile_data hp.rate_pos.le).pos _).le
  change p x 0 - straightPrice k h c d x 0 ≤ 0
  rw [hpay]
  exact sub_nonpos.mpr hq

/-- Every small-positive-time root in the moving continuation domain lies
in an arbitrary OPEN set containing the positive initial roots. The initial
root set need not be finite for this confinement lemma. -/
theorem straightDifference_roots_eventually_in_open (hp : DividendPutSolution k h p b)
    (hc : 0 < c) (hd : d ≤ 0) {ε : ℝ} (hε : 0 < ε)
    {U : Set ℝ} (hU : IsOpen U)
    (hroots : {x | 0 < x ∧ straightDifference p k h c d x 0 = ε} ⊆ U) :
    ∀ᶠ t in 𝓝[≥] 0, ∀ x, b t < x → straightDifference p k h c d x t = ε → x ∈ U := by
  obtain ⟨R,_,htail⟩ := straightDifference_right_negative hp.toContinuousBoundaryPutSolution hc hd
  let K := Icc (-1 : ℝ) R \ U
  have hK : IsCompact K := isCompact_Icc.diff hU
  have hzero : ∀ x ∈ K, straightDifference p k h c d x 0 ≠ ε := by
    intro x hx heq
    by_cases hx0 : 0 < x
    · exact hx.2 (hroots ⟨hx0,heq⟩)
    · have := straightDifference_initial_nonpos_left hp hc.le hd (le_of_not_gt hx0)
      linarith
  have hV := normalizedDifference_continuousOn (c := c) (d := d) hp.toContinuousBoundaryPutSolution
    (profile_data hp.rate_pos.le) (profile_data hp.dividend_nonneg)
  have havoid := eventually_avoid_level_on_compact hV hK hzero
  have hb : ∀ᶠ t in 𝓝[≥] 0, -1 < b t :=
    (hp.boundary_continuous 0 (show (0 : ℝ) ∈ Ici 0 by simp)).eventually
      (Ioi_mem_nhds (show (-1 : ℝ) < b 0 by rw [hp.boundary_initial]; norm_num))
  filter_upwards [havoid,hb,self_mem_nhdsWithin] with t ht hbt ht0
  intro x hbx hxeq
  by_contra hxU
  have hxR : x < R := by
    by_contra hn
    have := htail x (le_of_not_gt hn) t ht0
    linarith
  exact ht x ⟨⟨(hbt.trans hbx).le,hxR.le⟩,hxU⟩ hxeq

/-- The actual initial two-root theorem now supplies the neighborhoods to
the positive-time confinement result. Arbitrarily small open neighborhoods
are allowed; confinement is not yet a bound on the number of later roots. -/
theorem straightDifference_two_root_confinement (hp : DividendPutSolution k h p b)
    (hc : 0 < c) (hd : d ≤ 0) {ε : ℝ} (hε : 0 < ε)
    (hhigher : ∃ x, 0 < x ∧ ε < straightDifference p k h c d x 0) :
    ∃ a z : ℝ, 0 < a ∧ a < z ∧
      {x | 0 < x ∧ straightDifference p k h c d x 0 = ε} = {a,z} ∧
      ∀ U : Set ℝ, IsOpen U → a ∈ U → z ∈ U →
        ∀ᶠ t in 𝓝[≥] 0, ∀ x, b t < x → straightDifference p k h c d x t = ε → x ∈ U := by
  obtain ⟨a,z,ha,haz,hroots⟩ := straightDifference_initial_exact_two_roots hp hc hd hε hhigher
  refine ⟨a,z,ha,haz,hroots,?_⟩
  intro U hU haU hzU
  apply straightDifference_roots_eventually_in_open hp hc hd hε hU
  rw [hroots]
  exact insert_subset_iff.mpr ⟨haU,singleton_subset_iff.mpr hzU⟩

end Comparison
end AmericanConvexity.Boundary
