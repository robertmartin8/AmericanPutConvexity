import AmericanPutConvexity.Boundary.NeumannHalfLine
import Mathlib.Analysis.Calculus.Deriv.Shift

/-! # Neumann uniqueness on the exterior side of a moving graph

Reflection transfers the bounded half-line theorem to x <= b(t). This is
the side used to recover the zero Dirichlet trace of a heat-layer solution.
Only the left-sided derivative is supplied at the exterior boundary.
-/

namespace AmericanPutConvexity.Boundary

open Set Filter
open scoped Topology ContDiff

def movingLeftHalfStrip (b : ℝ → ℝ) (a T : ℝ) : Set (ℝ × ℝ) :=
  {z | a ≤ z.2 ∧ z.2 ≤ T ∧ z.1 ≤ b z.2}

theorem bounded_neumann_heat_zero_left {u : ℝ → ℝ → ℝ} {b : ℝ → ℝ} {a T κ C : ℝ}
    (hκ : 0 ≤ κ) (hb : ContinuousOn b (Icc a T))
    (hu : ContinuousOn (fun z : ℝ × ℝ => u z.1 z.2) (movingLeftHalfStrip b a T))
    (hbound : ∀ z ∈ movingLeftHalfStrip b a T, ‖u z.1 z.2‖ ≤ C)
    (hxs : ∀ x t, a < t → t ≤ T → x < b t → ContDiffAt ℝ 2 (fun y => u y t) x)
    (htd : ∀ x t, a < t → t ≤ T → x < b t → DifferentiableAt ℝ (u x) t)
    (hpde : ∀ x t, a < t → t ≤ T → x < b t →
      deriv (u x) t = κ*deriv (deriv (fun y => u y t)) x)
    (hinitial : ∀ x, x ≤ b a → u x a = 0)
    (hleft : ∀ t, a < t → t ≤ T →
      HasDerivWithinAt (fun x => u x t) 0 (Iic (b t)) (b t)) :
    ∀ z ∈ movingLeftHalfStrip b a T, u z.1 z.2 = 0 := by
  have hmap : MapsTo (fun z : ℝ × ℝ => (-z.1,z.2))
      (movingHalfStrip (fun t => -b t) a T) (movingLeftHalfStrip b a T) := by
    intro z hz
    exact ⟨hz.1,hz.2.1,by have := hz.2.2; linarith⟩
  have huc : ContinuousOn (fun z : ℝ × ℝ => u (-z.1) z.2)
      (movingHalfStrip (fun t => -b t) a T) :=
    hu.comp (show ContinuousOn (fun z : ℝ × ℝ => (-z.1,z.2)) _ by fun_prop) hmap
  have he := bounded_neumann_heat_zero (u := fun x t => u (-x) t)
    (b := fun t => -b t) hκ hb.neg huc
    (fun z hz => hbound (-z.1,z.2) (hmap hz))
    (fun x t ha ht hx => (hxs (-x) t ha ht (by linarith)).comp x (by fun_prop))
    (fun x t ha ht hx => htd (-x) t ha ht (by linarith))
    (fun x t ha ht hx => by
      have hxx : deriv (deriv (fun y => u (-y) t)) x = deriv (deriv (fun y => u y t)) (-x) := by
        rw [show deriv (fun y => u (-y) t) = (fun y => -deriv (fun w => u w t) (-y)) from
          funext (fun y => deriv_comp_neg (fun w => u w t) y)]
        simp only [deriv.fun_neg,deriv_comp_neg,neg_neg]
      rw [hxx]
      exact hpde (-x) t ha ht (by linarith))
    (fun x hx => hinitial (-x) (by linarith))
    (fun t ha ht => by
      have hn : HasDerivWithinAt (fun x : ℝ => -x) (-1) (Ici (-b t)) (-b t) :=
        (hasDerivAt_neg (-b t)).hasDerivWithinAt
      have hc := (hleft t ha ht).comp_of_eq (-b t) hn
        (show MapsTo (fun x : ℝ => -x) (Ici (-b t)) (Iic (b t)) from by
          intro x hx; change -b t ≤ x at hx; change -x ≤ b t; linarith) (by simp)
      simpa only [Function.comp_def,zero_mul] using hc)
  intro z hz
  have hh := he (-z.1,z.2) (show (-z.1,z.2) ∈ movingHalfStrip (fun t => -b t) a T from
    ⟨hz.1,hz.2.1,by have := hz.2.2; linarith⟩)
  simpa only [neg_neg] using hh

end AmericanPutConvexity.Boundary
