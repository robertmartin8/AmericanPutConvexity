import AmericanConvexity.Boundary.RootConfinement

/-!
# Positive-time initialization from initial derivative traces

Confinement and local monotonicity prove an at-most-two-root bound for small
positive times. The remaining regularity input is explicit: the spatial
derivative must extend continuously to each simple initial root from `t>=0`.
That input is NOT yet derived from the pricing PDE and is not added to its
solution contract. This module does not propagate the count to later times.
-/

namespace AmericanConvexity.Boundary

open Set Filter
open scoped Topology

/-- A relative product neighborhood contains a spatial interval times a
one-sided time neighborhood. This turns a local derivative trace into a
uniform sign on a small spatial interval. -/
theorem exists_interval_eventually_of_relative_eventually {a : ℝ} {P : ℝ × ℝ → Prop}
    (hP : ∀ᶠ z in 𝓝[{z : ℝ × ℝ | 0 ≤ z.2}] (a,0), P z) :
    ∃ l r : ℝ, l < a ∧ a < r ∧ ∀ᶠ t in 𝓝[≥] 0, ∀ x ∈ Ioo l r, P (x,t) := by
  have hdomain : {z : ℝ × ℝ | 0 ≤ z.2} = univ ×ˢ Ici 0 := by ext z; simp
  rw [hdomain,nhdsWithin_prod_eq,nhdsWithin_univ] at hP
  obtain ⟨S,hS,T,hT,hST⟩ := mem_prod_iff.mp hP
  obtain ⟨l,r,⟨hla,har⟩,hI⟩ := mem_nhds_iff_exists_Ioo_subset.mp hS
  refine ⟨l,r,hla,har,?_⟩
  filter_upwards [hT] with t ht
  intro x hx
  exact hST ⟨hI hx,ht⟩

theorem injOn_of_deriv_fixed_sign {F : ℝ → ℝ} {l r : ℝ}
    (hsgn : (∀ x ∈ Ioo l r, 0 < deriv F x) ∨ (∀ x ∈ Ioo l r, deriv F x < 0)) :
    InjOn F (Ioo l r) := by
  rcases hsgn with hp | hn
  · exact (strictMonoOn_of_deriv_pos (convex_Ioo l r)
      (fun x hx => (differentiableAt_of_deriv_ne_zero (hp x hx).ne').continuousAt.continuousWithinAt)
      (fun x hx => hp x (interior_subset hx))).injOn
  · exact (strictAntiOn_of_deriv_neg (convex_Ioo l r)
      (fun x hx => (differentiableAt_of_deriv_ne_zero (hn x hx).ne).continuousAt.continuousWithinAt)
      (fun x hx => hn x (interior_subset hx))).injOn

/-- A nonzero initial derivative with a continuous one-sided joint trace
gives injectivity near that root for all sufficiently small times. -/
theorem eventually_injOn_near_simple_root {V : ℝ → ℝ → ℝ} {a : ℝ}
    (htrace : ContinuousWithinAt (fun z : ℝ × ℝ => deriv (fun x => V x z.2) z.1)
      {z | 0 ≤ z.2} (a,0))
    (hneq : deriv (fun x => V x 0) a ≠ 0) :
    ∃ l r : ℝ, l < a ∧ a < r ∧ ∀ᶠ t in 𝓝[≥] 0, InjOn (fun x => V x t) (Ioo l r) := by
  rcases lt_or_gt_of_ne hneq with hn | hp
  · obtain ⟨l,r,hl,hr,he⟩ := exists_interval_eventually_of_relative_eventually
      (htrace.eventually (Iio_mem_nhds hn))
    refine ⟨l,r,hl,hr,he.mono (fun _ ht => injOn_of_deriv_fixed_sign (Or.inr ht))⟩
  · obtain ⟨l,r,hl,hr,he⟩ := exists_interval_eventually_of_relative_eventually
      (htrace.eventually (Ioi_mem_nhds hp))
    refine ⟨l,r,hl,hr,he.mono (fun _ ht => injOn_of_deriv_fixed_sign (Or.inl ht))⟩

/-- Two injective neighborhoods can contain at most two roots of one level,
even if the neighborhoods overlap or one contains no root. -/
theorem level_subset_pair_of_two_injective_sets {F : ℝ → ℝ} {S U V : Set ℝ} {ε : ℝ}
    (hcover : S ⊆ U ∪ V) (hlevel : ∀ x ∈ S, F x = ε)
    (hU : InjOn F U) (hV : InjOn F V) : ∃ a b : ℝ, S ⊆ {a,b} := by
  have hone (W : Set ℝ) (hW : InjOn F W) : ∃ a : ℝ, ∀ x ∈ S, x ∈ W → x = a := by
    by_cases he : ∃ a, a ∈ S ∧ a ∈ W
    · obtain ⟨a,haS,haW⟩ := he
      exact ⟨a,fun x hxS hxW => hW hxW haW ((hlevel x hxS).trans (hlevel a haS).symm)⟩
    · exact ⟨0,fun x hxS hxW => False.elim (he ⟨x,hxS,hxW⟩)⟩
  obtain ⟨a,ha⟩ := hone U hU
  obtain ⟨b,hb⟩ := hone V hV
  refine ⟨a,b,?_⟩
  intro x hx
  rcases hcover hx with hxU | hxV
  · simp [ha x hx hxU]
  · simp [hb x hx hxV]

namespace Comparison

/-- Small-positive-time at-most-two-root initialization, conditional ONLY
on the initial spatial derivative traces. The initial root count, simplicity,
corner/tail control, compact confinement, and local injectivity are proved.
This premise is still open for `DividendPutSolution`; this is not yet an
unconditional zero-number initialization theorem. -/
theorem straightDifference_initialization_of_derivative_traces {k h c d ε : ℝ}
    {p : ℝ → ℝ → ℝ} {b : ℝ → ℝ} (hp : DividendPutSolution k h p b)
    (hc : 0 < c) (hd : d ≤ 0) (hε : 0 < ε)
    (hhigher : ∃ x, 0 < x ∧ ε < straightDifference p k h c d x 0)
    (htrace : ∀ a, 0 < a → straightDifference p k h c d a 0 = ε →
      ContinuousWithinAt (fun z : ℝ × ℝ => deriv (fun x => straightDifference p k h c d x z.2) z.1)
        {z | 0 ≤ z.2} (a,0)) :
    ∀ᶠ t in 𝓝[≥] 0, ∃ a z : ℝ, {x | b t < x ∧ straightDifference p k h c d x t = ε} ⊆ {a,z} := by
  obtain ⟨a,z,ha,haz,hroots,hconfine⟩ := straightDifference_two_root_confinement hp hc hd hε hhigher
  have haeq : straightDifference p k h c d a 0 = ε := by
    have hm : a ∈ {x | 0 < x ∧ straightDifference p k h c d x 0 = ε} := by rw [hroots]; simp
    exact hm.2
  have hzeq : straightDifference p k h c d z 0 = ε := by
    have hm : z ∈ {x | 0 < x ∧ straightDifference p k h c d x 0 = ε} := by rw [hroots]; simp
    exact hm.2
  obtain ⟨l₁,r₁,hl₁,hr₁,hI₁⟩ := eventually_injOn_near_simple_root (htrace a ha haeq)
    (straightDifference_initial_simple_root hp hc ha haeq hhigher)
  obtain ⟨l₂,r₂,hl₂,hr₂,hI₂⟩ := eventually_injOn_near_simple_root (htrace z (ha.trans haz) hzeq)
    (straightDifference_initial_simple_root hp hc (ha.trans haz) hzeq hhigher)
  have hconf := hconfine (Ioo l₁ r₁ ∪ Ioo l₂ r₂) (isOpen_Ioo.union isOpen_Ioo)
    (Or.inl ⟨hl₁,hr₁⟩) (Or.inr ⟨hl₂,hr₂⟩)
  filter_upwards [hconf,hI₁,hI₂] with t ht hi₁ hi₂
  exact level_subset_pair_of_two_injective_sets (fun _ hx => ht _ hx.1 hx.2)
    (fun _ hx => hx.2) hi₁ hi₂

/-- Complete level-initialization split: either the entire evolution stays
below the level by the proved maximum principle, or the small-positive-time
zero count is at most two. The latter branch still needs the derivative trace. -/
theorem straightDifference_level_initialization {k h c d ε : ℝ}
    {p : ℝ → ℝ → ℝ} {b : ℝ → ℝ} (hp : DividendPutSolution k h p b)
    (hc : 0 < c) (hd : d ≤ 0) (hε : 0 < ε)
    (htrace : ∀ a, 0 < a → straightDifference p k h c d a 0 = ε →
      ContinuousWithinAt (fun z : ℝ × ℝ => deriv (fun x => straightDifference p k h c d x z.2) z.1)
        {z | 0 ≤ z.2} (a,0)) :
    (∀ t, 0 ≤ t → ∀ x, b t < x → straightDifference p k h c d x t ≤ ε) ∨
    (∀ᶠ t in 𝓝[≥] 0, ∃ a z : ℝ, {x | b t < x ∧ straightDifference p k h c d x t = ε} ⊆ {a,z}) := by
  by_cases hhigher : ∃ x, 0 < x ∧ ε < straightDifference p k h c d x 0
  · exact Or.inr (straightDifference_initialization_of_derivative_traces hp hc hd hε hhigher htrace)
  · left
    have hinit (x : ℝ) (hx : b 0 ≤ x) : straightDifference p k h c d x 0 ≤ ε := by
      rw [hp.boundary_initial] at hx
      rcases eq_or_lt_of_le hx with he | he
      · subst x
        have hv := straightDifference_boundary_nonpos hp.toContinuousBoundaryPutSolution hc.le hd (t := 0) le_rfl
        rw [hp.boundary_initial] at hv
        exact hv.trans hε.le
      · by_contra hn
        exact hhigher ⟨x,he,lt_of_not_ge hn⟩
    intro t ht x hx
    exact straightDifference_le_of_initial_le hp.toContinuousBoundaryPutSolution hc hd le_rfl hε.le hinit ht hx.le

/-- Zero-dividend checkpoint with the original CCJZ solution contract.
Derivative-trace regularity and subsequent zero-count propagation remain open. -/
theorem zeroDividend_level_initialization {k c d ε : ℝ}
    {p : ℝ → ℝ → ℝ} {b : ℝ → ℝ} (hp : NormalizedPutSolution k p b)
    (hc : 0 < c) (hd : d ≤ 0) (hε : 0 < ε)
    (htrace : ∀ a, 0 < a → straightDifference p k 0 c d a 0 = ε →
      ContinuousWithinAt (fun z : ℝ × ℝ => deriv (fun x => straightDifference p k 0 c d x z.2) z.1)
        {z | 0 ≤ z.2} (a,0)) :
    (∀ t, 0 ≤ t → ∀ x, b t < x → straightDifference p k 0 c d x t ≤ ε) ∨
    (∀ᶠ t in 𝓝[≥] 0, ∃ a z : ℝ, {x | b t < x ∧ straightDifference p k 0 c d x t = ε} ⊆ {a,z}) :=
  straightDifference_level_initialization (dividendPutSolution_zero_iff.mpr hp) hc hd hε htrace

end Comparison
end AmericanConvexity.Boundary
