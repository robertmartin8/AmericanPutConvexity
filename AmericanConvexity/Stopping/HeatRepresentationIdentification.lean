import AmericanConvexity.Stopping.HeatRepresentationExterior
import AmericanConvexity.Boundary.DirichletHalfLine

/-! # Identifying the source-plus-layer representation

The represented candidate and a bounded Dirichlet solution with the same
source agree by a proved maximum principle. Thus the candidate's right
normal derivative becomes the given solution's derivative. No derivative
trace of the given solution is assumed.
-/

namespace AmericanConvexity.Stopping

open Set Filter MeasureTheory Boundary
open scoped Topology ContDiff

theorem bounded_inhomogeneous_heat_unique {U W Q : ℝ × ℝ → ℝ}
    {b : ℝ → ℝ} {a T Cu Cw : ℝ} (hb : ContinuousOn b (Icc a T))
    (hU : ContinuousOn U (movingHalfStrip b a T)) (hW : ContinuousOn W (movingHalfStrip b a T))
    (hUb : ∀ z ∈ movingHalfStrip b a T, ‖U z‖ ≤ Cu)
    (hWb : ∀ z ∈ movingHalfStrip b a T, ‖W z‖ ≤ Cw)
    (hUx : ∀ x t, a < t → t ≤ T → b t < x → ContDiffAt ℝ 2 (fun y => U (y,t)) x)
    (hWx : ∀ x t, a < t → t ≤ T → b t < x → ContDiffAt ℝ 2 (fun y => W (y,t)) x)
    (hUt : ∀ x t, a < t → t ≤ T → b t < x → DifferentiableAt ℝ (fun s => U (x,s)) t)
    (hWt : ∀ x t, a < t → t ≤ T → b t < x → DifferentiableAt ℝ (fun s => W (x,s)) t)
    (hUe : ∀ x t, a < t → t ≤ T → b t < x →
      deriv (fun s => U (x,s)) t = (1/2)*deriv (deriv (fun y => U (y,t))) x+Q (x,t))
    (hWe : ∀ x t, a < t → t ≤ T → b t < x →
      deriv (fun s => W (x,s)) t = (1/2)*deriv (deriv (fun y => W (y,t))) x+Q (x,t))
    (hinit : ∀ x, b a ≤ x → U (x,a) = W (x,a))
    (hleft : ∀ t, a ≤ t → t ≤ T → U (b t,t) = W (b t,t)) :
    ∀ z ∈ movingHalfStrip b a T, U z = W z := by
  have he := bounded_dirichlet_heat_zero (u := fun x t => U (x,t)-W (x,t))
    (C := Cu+Cw) (by norm_num : (0 : ℝ) ≤ 1/2) hb (hU.sub hW)
    (fun z hz => (norm_sub_le _ _).trans (add_le_add (hUb z hz) (hWb z hz)))
    (fun x t ha ht hx => (hUx x t ha ht hx).sub (hWx x t ha ht hx))
    (fun x t ha ht hx => (hUt x t ha ht hx).sub (hWt x t ha ht hx))
    (fun x t ha ht hx => by
      rw [deriv_fun_sub (hUt x t ha ht hx) (hWt x t ha ht hx),
        heat_deriv2_sub_at (hUx x t ha ht hx) (hWx x t ha ht hx),
        hUe x t ha ht hx,hWe x t ha ht hx]
      ring)
    (fun x hx => sub_eq_zero.mpr (hinit x hx))
    (fun t ha ht => sub_eq_zero.mpr (hleft t ha ht))
  intro z hz
  exact sub_eq_zero.mp (he z hz)

theorem heatRepresentationCandidate_identification {Q W : ℝ × ℝ → ℝ}
    {b f : ℝ → ℝ} {a D T Cf Cw L : ℝ} (hD : 0 < D) (hL : 0 ≤ L) (hT : T < a+D)
    (hQ : Continuous Q) (hc : HasCompactSupport Q)
    (hQa : ∀ z : ℝ × ℝ, z.2 ≤ a → Q z = 0)
    (hb : Continuous b) (hf : Continuous f) (hCf : ∀ t, ‖f t‖ ≤ Cf)
    (hfa : ∀ t, t ≤ a → f t = 0)
    (hsmooth : ∀ z : ℝ × ℝ, a < z.2 → z.1 ≠ b z.2 → ContDiffAt ℝ ∞ Q z)
    (hzero : ∀ x t, a < t → t ≤ T → x < b t → Q (x,t) = 0)
    (hmove : ∀ t, a < t → t ≤ T → ∀ u ∈ Ioo 0 D, ‖b t-b (t-u)‖ ≤ L*u)
    (heq : ∀ t, a < t → t ≤ T →
      f t = 2*heatSourcePotentialSpatial Q D (b t,t)+heatHistory b D f t)
    (hW : ContinuousOn W (movingHalfStrip b a T))
    (hWb : ∀ z ∈ movingHalfStrip b a T, ‖W z‖ ≤ Cw)
    (hWx : ∀ x t, a < t → t ≤ T → b t < x → ContDiffAt ℝ 2 (fun y => W (y,t)) x)
    (hWt : ∀ x t, a < t → t ≤ T → b t < x → DifferentiableAt ℝ (fun s => W (x,s)) t)
    (hWe : ∀ x t, a < t → t ≤ T → b t < x →
      deriv (fun s => W (x,s)) t = (1/2)*deriv (deriv (fun y => W (y,t))) x+Q (x,t))
    (hinit : ∀ x, b a ≤ x → W (x,a) = 0)
    (hleft : ∀ t, a ≤ t → t ≤ T → W (b t,t) = 0) :
    ∀ z ∈ movingHalfStrip b a T, heatRepresentationCandidate Q b f D z = W z := by
  obtain ⟨Cq,hCq⟩ := hc.exists_bound_of_continuous hQ
  have hreg (x t : ℝ) (ha : a < t) (ht : t ≤ T) (hx : b t < x) :=
    heatRepresentationCandidate_regular hD hQ hc hQa hb hf hfa hsmooth ha
      (ht.trans_lt hT) hx.ne'
  have hexterior := heatRepresentationCandidate_zero_exterior hD hL hT hQ hc hQa
    hb hf hCf hfa hsmooth hzero hmove heq
  apply bounded_inhomogeneous_heat_unique hb.continuousOn
    ((heatRepresentationCandidate_continuousOn hD hQ hCq hb hf hCf hfa).mono
      (fun z hz => (hz.2.1.trans_lt hT).le)) hW
    (fun z hz => heatRepresentationCandidate_bound hD hCq hCf hfa z (hz.2.1.trans_lt hT).le) hWb
    (fun x t ha ht hx => (hreg x t ha ht hx).1) hWx
    (fun x t ha ht hx => (hreg x t ha ht hx).2.1) hWt
    (fun x t ha ht hx => (hreg x t ha ht hx).2.2) hWe
  · intro x hx
    rw [hinit x hx,heatRepresentationCandidate_causal hQa hfa (x,a) le_rfl]
  · intro t ha ht
    rw [hleft t ha ht]
    exact hexterior (b t,t) ⟨ha,ht,le_rfl⟩

theorem heatRepresentation_transfer_right_trace {Q W : ℝ × ℝ → ℝ}
    {b f : ℝ → ℝ} {a D T t Cq Cf L : ℝ} (hD : 0 < D) (hL : 0 ≤ L)
    (hQ : Continuous Q) (hc : HasCompactSupport Q) (hCq : ∀ z, ‖Q z‖ ≤ Cq)
    (hb : Continuous b) (hf : Continuous f) (hCf : ∀ s, ‖f s‖ ≤ Cf)
    (hfa : ∀ s, s ≤ a → f s = 0) (hta : a ≤ t) (htT : t ≤ T) (htD : t ≤ a+D)
    (hmove : ∀ u ∈ Ioo 0 D, ‖b t-b (t-u)‖ ≤ L*u)
    (heq : f t = 2*heatSourcePotentialSpatial Q D (b t,t)+heatHistory b D f t)
    (hident : ∀ z ∈ movingHalfStrip b a T, heatRepresentationCandidate Q b f D z = W z) :
    HasDerivWithinAt (fun x => W (x,t)) (f t) (Ici (b t)) (b t) := by
  have hd := (heatRepresentationCandidate_normal_traces hD hL hQ hc hCq hb hf hCf hfa htD hmove heq).2
  apply hd.congr
  · intro x hx
    exact (hident (x,t) ⟨hta,htT,hx⟩).symm
  · exact (hident (b t,t) ⟨hta,htT,le_rfl⟩).symm

end AmericanConvexity.Stopping
