import AmericanPutConvexity.Stopping.HeatHistoryOperator

/-! # Constructing the continuous heat-layer density

The weakly singular boundary equation f=g+Kf is solved by a contraction on
bounded continuous causal functions. Its small-time norm bound is proved
from the actual heat kernel, not assumed as an abstract solvability axiom.
On the first time window the truncated history equals the full causal past.
-/

namespace AmericanPutConvexity.Stopping

open Set Filter MeasureTheory
open scoped Topology BoundedContinuousFunction

noncomputable def heatDensityStep {b : ℝ → ℝ} {a D L : ℝ}
    (hD : 0 < D) (hL : 0 ≤ L) (hb : Continuous b)
    (hmove : ∀ t s, 0 < s → ‖b t-b (t-s)‖ ≤ L*s)
    (g f : CausalBoundaryData a) : CausalBoundaryData a :=
  ⟨g.1+heatHistoryBCF hD hL hb hmove f.1,fun t ht => by
    change g.1 t+heatHistory b D f.1 t = 0
    rw [g.2 t ht,heatHistory_causal f.2 ht,add_zero]⟩

theorem heatDensityStep_contracting {b : ℝ → ℝ} {a D L : ℝ}
    (hD : 0 < D) (hL : 0 ≤ L) (hb : Continuous b)
    (hmove : ∀ t s, 0 < s → ‖b t-b (t-s)‖ ≤ L*s)
    (hsmall : heatHistoryNormBound L D < 1) (g : CausalBoundaryData a) :
    ContractingWith ⟨heatHistoryNormBound L D,heatHistoryNormBound_nonneg hL⟩
      (heatDensityStep hD hL hb hmove g) := by
  refine ⟨hsmall,LipschitzWith.of_dist_le_mul ?_⟩
  intro f₁ f₂
  change dist (g.1+heatHistoryBCF hD hL hb hmove f₁.1)
      (g.1+heatHistoryBCF hD hL hb hmove f₂.1) ≤ heatHistoryNormBound L D*dist f₁.1 f₂.1
  rw [dist_add_left]
  exact heatHistoryBCF_dist hD hL hb hmove f₁.1 f₂.1

theorem exists_unique_causal_heat_density {b : ℝ → ℝ} {a D L : ℝ}
    (hD : 0 < D) (hL : 0 ≤ L) (hb : Continuous b)
    (hmove : ∀ t s, 0 < s → ‖b t-b (t-s)‖ ≤ L*s)
    (hsmall : heatHistoryNormBound L D < 1) (g : CausalBoundaryData a) :
    ∃! f : CausalBoundaryData a, ∀ t, f.1 t = g.1 t+heatHistory b D f.1 t := by
  have hc := heatDensityStep_contracting hD hL hb hmove hsmall g
  let f := hc.fixedPoint
  have hf : heatDensityStep hD hL hb hmove g f = f := hc.fixedPoint_isFixedPt
  refine ⟨f,?_,?_⟩
  · intro t
    exact (congrArg (fun p : CausalBoundaryData a => p.1 t) hf).symm
  · intro p hp
    apply hc.fixedPoint_unique
    apply Subtype.ext
    apply BoundedContinuousFunction.ext
    intro t
    exact (hp t).symm

theorem heatHistory_eq_causal_past {b f : ℝ → ℝ} {a D t : ℝ}
    (hf : ∀ u, u ≤ a → f u = 0) (ht : t ≤ a+D) :
    heatHistory b D f t = ∫ s in Ioo 0 (t-a), heatBoundaryKernel s (b t-b (t-s))*f (t-s) := by
  apply setIntegral_eq_of_subset_of_forall_sdiff_eq_zero measurableSet_Ioo
    (show Ioo 0 (t-a) ⊆ Ioo 0 D from fun s hs => ⟨hs.1,by linarith [hs.2]⟩)
  intro s hs
  have hsa : t-a ≤ s := by
    by_contra hn
    exact hs.2 ⟨hs.1.1,lt_of_not_ge hn⟩
  rw [hf (t-s) (by linarith),mul_zero]

/-- A positive window and a causal continuous solution are constructed; the
equation on that window integrates over the whole elapsed causal past. -/
theorem exists_local_causal_heat_density {b : ℝ → ℝ} {a L : ℝ}
    (hL : 0 ≤ L) (hb : Continuous b)
    (hmove : ∀ t s, 0 < s → ‖b t-b (t-s)‖ ≤ L*s) (g : CausalBoundaryData a) :
    ∃ D : ℝ, 0 < D ∧ ∃ f : CausalBoundaryData a,
      ∀ t ∈ Icc a (a+D), f.1 t = g.1 t+
        ∫ s in Ioo 0 (t-a), heatBoundaryKernel s (b t-b (t-s))*f.1 (t-s) := by
  obtain ⟨D,hD,hsmall⟩ := exists_small_heatHistory_window L
  obtain ⟨f,hf,_⟩ := exists_unique_causal_heat_density hD hL hb hmove hsmall g
  refine ⟨D,hD,f,?_⟩
  intro t ht
  rw [hf t,heatHistory_eq_causal_past f.2 ht.2]

end AmericanPutConvexity.Stopping
