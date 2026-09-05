import AmericanConvexity.Boundary.ZeroCountGeometry
import AmericanConvexity.Boundary.ComparisonMaximum

/-!
# Spatial zero-count consequences for the actual comparison

At a positive level, the exercise-boundary and far-field values are strictly
below that level. Thus a bound of two level roots implies an interval-shaped
superlevel set. Applying this at every positive level gives the positive-set
invariant used by the tangency argument.

The root-count hypothesis remains explicit: this file does not prove its
parabolic propagation, nor add it to the pricing-solution contract.
-/

namespace AmericanConvexity.Boundary.Comparison

open Set

variable {k h c d : ℝ} {p : ℝ → ℝ → ℝ} {b : ℝ → ℝ}

/-- The actual continuation superlevel is an interval if its level set has
at most two points. Continuity, boundary signs, and truncation are discharged
from the pricing contract and the checked comparison estimates. -/
theorem straightDifference_superlevel_of_two_roots
    (hp : DividendPutSolution k h p b) (hc : 0 < c) (hd : d ≤ 0)
    {t ε : ℝ} (ht : 0 < t) (hε : 0 < ε)
    (hroots : ∃ a z : ℝ,
      {x | b t < x ∧ straightDifference p k h c d x t = ε} ⊆ {a,z}) :
    OrdConnected {x | b t < x ∧ ε < straightDifference p k h c d x t} := by
  obtain ⟨R,hR,htail⟩ := straightDifference_right_negative hp hc hd
  have hcont : Continuous (fun x => straightDifference p k h c d x t) := by
    exact (normalizedDifference_continuousOn (c := c) (d := d) hp
      (profile_data hp.rate_pos.le) (profile_data hp.dividend_nonneg)).comp_continuous
      (show Continuous (fun x : ℝ => (x,t)) by fun_prop) (fun _ => ht.le)
  have hleft : straightDifference p k h c d (b t) t < ε :=
    (straightDifference_boundary_nonpos hp hc.le hd ht.le).trans_lt hε
  have hright : straightDifference p k h c d R t < ε :=
    (htail R le_rfl t ht.le).trans hε
  have htrunc : ∃ a z : ℝ,
      {x | b t < x ∧ x < R ∧ straightDifference p k h c d x t = ε} ⊆ {a,z} := by
    obtain ⟨a,z,haz⟩ := hroots
    exact ⟨a,z,fun _ hx => haz ⟨hx.1,hx.2.2⟩⟩
  have hinterval := superlevel_ordConnected_of_two_roots hcont.continuousOn hleft hright htrunc
  have heq : {x | b t < x ∧ ε < straightDifference p k h c d x t} =
      {x | b t < x ∧ x < R ∧ ε < straightDifference p k h c d x t} := by
    ext x
    constructor
    · intro hx
      refine ⟨hx.1,?_,hx.2⟩
      by_contra hn
      have hneg := htail x (le_of_not_gt hn) t ht.le
      linarith [hx.2]
    · exact fun hx => ⟨hx.1,hx.2.2⟩
  rw [heq]
  exact hinterval

/-- Only levels with a positive value above them need a two-root bound.
The alternative is an empty superlevel set, including a critical peak level. -/
theorem straightDifference_positive_interval_of_level_counts
    (hp : DividendPutSolution k h p b) (hc : 0 < c) (hd : d ≤ 0)
    {t : ℝ} (ht : 0 < t)
    (hcounts : ∀ ε : ℝ, 0 < ε →
      (∃ x, b t < x ∧ ε < straightDifference p k h c d x t) →
      ∃ a z : ℝ, {x | b t < x ∧ straightDifference p k h c d x t = ε} ⊆ {a,z}) :
    OrdConnected {x | b t < x ∧ 0 < straightDifference p k h c d x t} := by
  apply positive_set_ordConnected_of_positive_levels (S := Ioi (b t))
  intro ε hε
  by_cases hpos : ∃ x, b t < x ∧ ε < straightDifference p k h c d x t
  · exact straightDifference_superlevel_of_two_roots hp hc hd ht hε (hcounts ε hε hpos)
  · have he : {x | x ∈ Ioi (b t) ∧ ε < straightDifference p k h c d x t} = ∅ := by
      apply eq_empty_iff_forall_notMem.mpr
      exact fun x hx => hpos ⟨x,hx⟩
    rw [he]
    exact ordConnected_empty

/-- Zero-dividend milestone, on the original normalized pricing contract.
This is a specialization of the straight-line route, not an independent
formalization of the published CCJZ propagation argument. -/
theorem zeroDividend_positive_interval_of_level_counts
    (hp : NormalizedPutSolution k p b) (hc : 0 < c) (hd : d ≤ 0)
    {t : ℝ} (ht : 0 < t)
    (hcounts : ∀ ε : ℝ, 0 < ε →
      (∃ x, b t < x ∧ ε < straightDifference p k 0 c d x t) →
      ∃ a z : ℝ, {x | b t < x ∧ straightDifference p k 0 c d x t = ε} ⊆ {a,z}) :
    OrdConnected {x | b t < x ∧ 0 < straightDifference p k 0 c d x t} :=
  straightDifference_positive_interval_of_level_counts
    (dividendPutSolution_zero_iff.mpr hp) hc hd ht hcounts

end AmericanConvexity.Boundary.Comparison
