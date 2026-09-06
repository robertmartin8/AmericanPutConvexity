import AmericanPutConvexity.Stopping.HeatRepresentationCandidate
import AmericanPutConvexity.Boundary.NeumannExterior

/-! # The representation candidate vanishes on the exercise side

The density equation cancels the left normal derivative. Bounded Neumann
uniqueness then gives the zero exterior solution, including its boundary
value. The right derivative remains the constructed density.
-/

namespace AmericanPutConvexity.Stopping

open Set Filter MeasureTheory Boundary
open scoped Topology ContDiff

theorem unshift_hasDerivWithinAt_Iic {F : ℝ → ℝ} {b v : ℝ}
    (hF : HasDerivWithinAt (fun x => F (b+x)) v (Iic 0) 0) :
    HasDerivWithinAt F v (Iic b) b := by
  have hi : HasDerivWithinAt (fun x : ℝ => x-b) 1 (Iic b) b :=
    ((hasDerivAt_id b).sub_const b).hasDerivWithinAt
  have he := hF.comp_of_eq b hi (show MapsTo (fun x : ℝ => x-b) (Iic b) (Iic 0) from
    by intro x hx; change x ≤ b at hx; change x-b ≤ 0; linarith) (sub_self b).symm
  simpa [Function.comp_def] using! he

theorem unshift_hasDerivWithinAt_Ici {F : ℝ → ℝ} {b v : ℝ}
    (hF : HasDerivWithinAt (fun x => F (b+x)) v (Ici 0) 0) :
    HasDerivWithinAt F v (Ici b) b := by
  have hi : HasDerivWithinAt (fun x : ℝ => x-b) 1 (Ici b) b :=
    ((hasDerivAt_id b).sub_const b).hasDerivWithinAt
  have he := hF.comp_of_eq b hi (show MapsTo (fun x : ℝ => x-b) (Ici b) (Ici 0) from
    by intro x hx; change b ≤ x at hx; change 0 ≤ x-b; linarith) (sub_self b).symm
  simpa [Function.comp_def] using! he

theorem heatRepresentationCandidate_normal_traces {Q : ℝ × ℝ → ℝ}
    {b f : ℝ → ℝ} {a D Cq Cf L t : ℝ} (hD : 0 < D) (hL : 0 ≤ L)
    (hQ : Continuous Q) (hc : HasCompactSupport Q) (hCq : ∀ z, ‖Q z‖ ≤ Cq)
    (hb : Continuous b) (hf : Continuous f) (hCf : ∀ s, ‖f s‖ ≤ Cf)
    (hfa : ∀ s, s ≤ a → f s = 0) (ht : t ≤ a+D)
    (hmove : ∀ u ∈ Ioo 0 D, ‖b t-b (t-u)‖ ≤ L*u)
    (heq : f t = 2*heatSourcePotentialSpatial Q D (b t,t)+heatHistory b D f t) :
    HasDerivWithinAt (fun x => heatRepresentationCandidate Q b f D (x,t)) 0 (Iic (b t)) (b t) ∧
    HasDerivWithinAt (fun x => heatRepresentationCandidate Q b f D (x,t)) (f t) (Ici (b t)) (b t) := by
  obtain ⟨hl,hr⟩ := heatRepresentationCandidate_shifted_traces hD hL hQ hc hCq hb hf hCf hfa ht hmove heq
  exact ⟨unshift_hasDerivWithinAt_Iic hl,unshift_hasDerivWithinAt_Ici hr⟩

theorem heatRepresentationCandidate_zero_exterior {Q : ℝ × ℝ → ℝ}
    {b f : ℝ → ℝ} {a D T Cf L : ℝ} (hD : 0 < D) (hL : 0 ≤ L) (hT : T < a+D)
    (hQ : Continuous Q) (hc : HasCompactSupport Q)
    (hQa : ∀ z : ℝ × ℝ, z.2 ≤ a → Q z = 0)
    (hb : Continuous b) (hf : Continuous f) (hCf : ∀ t, ‖f t‖ ≤ Cf)
    (hfa : ∀ t, t ≤ a → f t = 0)
    (hsmooth : ∀ z : ℝ × ℝ, a < z.2 → z.1 ≠ b z.2 → ContDiffAt ℝ ∞ Q z)
    (hzero : ∀ x t, a < t → t ≤ T → x < b t → Q (x,t) = 0)
    (hmove : ∀ t, a < t → t ≤ T → ∀ u ∈ Ioo 0 D, ‖b t-b (t-u)‖ ≤ L*u)
    (heq : ∀ t, a < t → t ≤ T →
      f t = 2*heatSourcePotentialSpatial Q D (b t,t)+heatHistory b D f t) :
    ∀ z ∈ movingLeftHalfStrip b a T, heatRepresentationCandidate Q b f D z = 0 := by
  obtain ⟨Cq,hCq⟩ := hc.exists_bound_of_continuous hQ
  have hreg (x t : ℝ) (ha : a < t) (ht : t ≤ T) (hx : x < b t) :=
    heatRepresentationCandidate_regular hD hQ hc hQa hb hf hfa hsmooth ha
      (ht.trans_lt hT) hx.ne
  apply bounded_neumann_heat_zero_left (u := fun x t => heatRepresentationCandidate Q b f D (x,t))
    (by norm_num : (0 : ℝ) ≤ 1/2) hb.continuousOn
  · exact (heatRepresentationCandidate_continuousOn hD hQ hCq hb hf hCf hfa).mono
      (fun z hz => (hz.2.1.trans_lt hT).le)
  · intro z hz
    exact heatRepresentationCandidate_bound hD hCq hCf hfa z (hz.2.1.trans_lt hT).le
  · intro x t ha ht hx
    exact (hreg x t ha ht hx).1
  · intro x t ha ht hx
    exact (hreg x t ha ht hx).2.1
  · intro x t ha ht hx
    simpa only [hzero x t ha ht hx,add_zero] using (hreg x t ha ht hx).2.2
  · intro x _
    exact heatRepresentationCandidate_causal hQa hfa (x,a) le_rfl
  · intro t ha ht
    exact (heatRepresentationCandidate_normal_traces hD hL hQ hc hCq hb hf hCf hfa
      (ht.trans_lt hT).le (hmove t ha ht) (heq t ha ht)).1

end AmericanPutConvexity.Stopping
