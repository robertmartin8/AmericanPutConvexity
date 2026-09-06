import AmericanPutConvexity.Boundary.ComparisonMaximum

/-!
# Exact simple initial roots at positive comparison levels

For a positive level below some initial continuation value, there are exactly
two roots, both strictly inside `x>0`, and both are simple. This identifies the
actual initial data, not just its algebraic profile. It does not yet assert
stability of the root count at positive times.
-/

namespace AmericanPutConvexity.Boundary

open Set

/-- A two-point cover with two distinct members is exactly those members. -/
theorem eq_pair_of_subset_pair {s : Set ℝ} {a b : ℝ}
    (hcover : ∃ u v : ℝ, s ⊆ {u,v}) (ha : a ∈ s) (hb : b ∈ s) (hab : a ≠ b) : s = {a,b} := by
  obtain ⟨u,v,hsub⟩ := hcover
  have ha' := hsub ha
  have hb' := hsub hb
  simp only [mem_insert_iff, mem_singleton_iff] at ha' hb'
  apply Subset.antisymm ?_ (insert_subset_iff.mpr ⟨ha,singleton_subset_iff.mpr hb⟩)
  intro x hx
  have hx' := hsub hx
  simp only [mem_insert_iff, mem_singleton_iff] at hx' ⊢
  rcases ha' with rfl | rfl <;> rcases hb' with rfl | rfl <;> aesop

/-- A continuous profile below a level at both ends and above it in the
middle has two interior roots. A two-point cover excludes any others. -/
theorem two_roots_of_initial_hump {F : ℝ → ℝ} {l m r ε : ℝ}
    (hF : Continuous F) (hlm : l < m) (hmr : m < r)
    (hl : F l < ε) (hm : ε < F m) (hr : F r < ε)
    (hcover : ∃ a b : ℝ, {x | F x = ε} ⊆ {a,b}) :
    ∃ a b : ℝ, l < a ∧ a < m ∧ m < b ∧ b < r ∧ {x | F x = ε} = {a,b} := by
  obtain ⟨a,ha,haeq⟩ := intermediate_value_Icc hlm.le hF.continuousOn ⟨hl.le,hm.le⟩
  obtain ⟨b,hb,hbeq⟩ := intermediate_value_Icc' hmr.le hF.continuousOn ⟨hr.le,hm.le⟩
  have hla : l < a := lt_of_le_of_ne ha.1 (by intro he; rw [← he] at haeq; linarith)
  have ham : a < m := lt_of_le_of_ne ha.2 (by intro he; rw [he] at haeq; linarith)
  have hmb : m < b := lt_of_le_of_ne hb.1 (by intro he; rw [← he] at hbeq; linarith)
  have hbr : b < r := lt_of_le_of_ne hb.2 (by intro he; rw [he] at hbeq; linarith)
  exact ⟨a,b,hla,ham,hmb,hbr,eq_pair_of_subset_pair hcover haeq hbeq (ham.trans hmb).ne⟩

namespace Comparison

variable {k h c d : ℝ} {p : ℝ → ℝ → ℝ} {b : ℝ → ℝ}

/-- Simplicity transfers to the actual initial spatial derivative, using
equality with the algebraic profile on a neighborhood inside `x>0`. -/
theorem straightDifference_initial_simple_root (hp : DividendPutSolution k h p b)
    (hc : 0 < c) {ε x : ℝ} (hx : 0 < x)
    (hroot : straightDifference p k h c d x 0 = ε)
    (hhigher : ∃ y, 0 < y ∧ ε < straightDifference p k h c d y 0) :
    deriv (fun y => straightDifference p k h c d y 0) x ≠ 0 := by
  let f := profile (k - h - 1 - c) k
  let g := profile (k - h - 1 + 2 - c) h
  have hf : ProfileData (k - h - 1 - c) k f := profile_data hp.rate_pos.le
  have hg : ProfileData (k - h - 1 + 2 - c) h g := profile_data hp.dividend_nonneg
  have heq : (fun y => straightDifference p k h c d y 0) =ᶠ[nhds x] initialDifference f g d := by
    filter_upwards [Ioi_mem_nhds hx] with y hy
    exact normalizedDifference_initial hp.toContinuousBoundaryPutSolution hf d hy.le
  rw [heq.deriv_eq]
  obtain ⟨y,hy,hyp⟩ := hhigher
  apply initialDifference_simple_level rfl hc hf hg
  refine ⟨y,?_⟩
  rw [← normalizedDifference_initial hp.toContinuousBoundaryPutSolution hf d hx.le, ← normalizedDifference_initial hp.toContinuousBoundaryPutSolution hf d hy.le]
  change straightDifference p k h c d x 0 < straightDifference p k h c d y 0
  rwa [hroot]

/-- At every positive level with a higher initial value, the explicit initial
profile has exactly two SIMPLE roots, both to the right of expiry's corner.
The zero-level-set equality here holds even on the whole real line. -/
theorem initialDifference_exact_two_simple_roots (hp : DividendPutSolution k h p b)
    (hc : 0 < c) (hd : d ≤ 0) {ε : ℝ} (hε : 0 < ε)
    (hhigher : ∃ x, 0 < x ∧ ε < straightDifference p k h c d x 0) :
    ∃ a z : ℝ, 0 < a ∧ a < z ∧
      {x | initialDifference (profile (k - h - 1 - c) k) (profile (k - h - 1 + 2 - c) h) d x = ε} = {a,z} ∧
      deriv (initialDifference (profile (k - h - 1 - c) k) (profile (k - h - 1 + 2 - c) h) d) a ≠ 0 ∧
      deriv (initialDifference (profile (k - h - 1 - c) k) (profile (k - h - 1 + 2 - c) h) d) z ≠ 0 := by
  let f := profile (k - h - 1 - c) k
  let g := profile (k - h - 1 + 2 - c) h
  let F := initialDifference f g d
  have hf : ProfileData (k - h - 1 - c) k f := profile_data hp.rate_pos.le
  have hg : ProfileData (k - h - 1 + 2 - c) h g := profile_data hp.dividend_nonneg
  have hdF : Differentiable ℝ F := fun x => (initialDifference_hasDeriv hf hg d x).differentiableAt
  have hF : Continuous F := hdF.continuous
  have heq (x : ℝ) (hx : 0 ≤ x) : straightDifference p k h c d x 0 = F x :=
    normalizedDifference_initial hp.toContinuousBoundaryPutSolution hf d hx
  have hzero : F 0 < ε := by
    have hv := straightDifference_boundary_nonpos hp.toContinuousBoundaryPutSolution hc.le hd (t := 0) le_rfl
    rw [hp.boundary_initial, heq 0 le_rfl] at hv
    exact hv.trans_lt hε
  obtain ⟨m,hm,hmp⟩ := hhigher
  rw [heq m hm.le] at hmp
  obtain ⟨X,hX,htail⟩ := straightDifference_right_negative hp.toContinuousBoundaryPutSolution hc hd
  let R := max X m + 1
  have hmR : m < R := by dsimp [R]; linarith [le_max_right X m]
  have hXR : X ≤ R := by dsimp [R]; linarith [le_max_left X m]
  have hRpos : 0 ≤ R := hX.le.trans hXR
  have hRp : F R < ε := by
    have hv := htail R hXR 0 le_rfl
    rw [heq R hRpos] at hv
    exact hv.trans hε
  obtain ⟨a,z,ha,ham,hmz,_,hroots⟩ := two_roots_of_initial_hump hF hm hmR hzero hmp hRp
    (initialDifference_level_subset_pair rfl hc hf hg d ε)
  have haeq : F a = ε := by
    have : a ∈ {x | F x = ε} := by rw [hroots]; simp
    exact this
  have hzeq : F z = ε := by
    have : z ∈ {x | F x = ε} := by rw [hroots]; simp
    exact this
  refine ⟨a,z,ha,ham.trans hmz,hroots,?_,?_⟩
  · exact initialDifference_simple_level rfl hc hf hg ⟨m,by change F a < F m; rwa [haeq]⟩
  · exact initialDifference_simple_level rfl hc hf hg ⟨m,by change F z < F m; rwa [hzeq]⟩

/-- The INITIAL zero set of the actual pricing difference on its continuation
half-line has exactly two points. No positive-time zero count is claimed. -/
theorem straightDifference_initial_exact_two_roots (hp : DividendPutSolution k h p b)
    (hc : 0 < c) (hd : d ≤ 0) {ε : ℝ} (hε : 0 < ε)
    (hhigher : ∃ x, 0 < x ∧ ε < straightDifference p k h c d x 0) :
    ∃ a z : ℝ, 0 < a ∧ a < z ∧ {x | 0 < x ∧ straightDifference p k h c d x 0 = ε} = {a,z} := by
  obtain ⟨a,z,ha,haz,hroots,_,_⟩ := initialDifference_exact_two_simple_roots hp hc hd hε hhigher
  refine ⟨a,z,ha,haz,?_⟩
  ext x
  have hchar : initialDifference (profile (k - h - 1 - c) k)
      (profile (k - h - 1 + 2 - c) h) d x = ε ↔ x = a ∨ x = z := by
    change x ∈ {y | initialDifference (profile (k - h - 1 - c) k)
      (profile (k - h - 1 + 2 - c) h) d y = ε} ↔ _
    rw [hroots]
    simp
  by_cases hx : 0 < x
  · simp only [mem_setOf_eq, hx, true_and, mem_insert_iff, mem_singleton_iff]
    unfold straightDifference
    rw [normalizedDifference_initial (c := c) hp.toContinuousBoundaryPutSolution (profile_data hp.rate_pos.le) d hx.le]
    exact hchar
  · simp only [mem_setOf_eq, hx, false_and, mem_insert_iff, mem_singleton_iff]
    have hxa : x ≠ a := by intro he; subst x; exact hx ha
    have hxz : x ≠ z := by intro he; subst x; exact hx (ha.trans haz)
    simp [hxa,hxz]

end Comparison
end AmericanPutConvexity.Boundary
