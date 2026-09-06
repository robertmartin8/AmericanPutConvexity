import AmericanPutConvexity.Boundary.DiscountedMaximum
import Mathlib.Analysis.SpecialFunctions.ExpDeriv

/-! # Stationary exponential barriers for discounted pricing

The profile vanishes at a fixed spatial reference point and is a supersolution
to the pricing equation to its right, provided its exponential rate dominates
the drift. Its growth at the reference point is at most linear.
-/

namespace AmericanPutConvexity.Boundary

noncomputable def stationaryBoundaryBarrier (ρ β x : ℝ) : ℝ :=
  1-Real.exp (-ρ*(x-β))

theorem stationaryBoundaryBarrier_contDiff (ρ β : ℝ) :
    ContDiff ℝ 2 (stationaryBoundaryBarrier ρ β) := by
  unfold stationaryBoundaryBarrier
  fun_prop

theorem stationaryBoundaryBarrier_hasDerivAt (ρ β x : ℝ) :
    HasDerivAt (stationaryBoundaryBarrier ρ β) (ρ*Real.exp (-ρ*(x-β))) x := by
  convert! ((((hasDerivAt_id x).sub_const β).const_mul (-ρ)).exp.const_sub 1) using 1
  simp
  ring

theorem stationaryBoundaryBarrier_deriv2 (ρ β x : ℝ) :
    deriv (deriv (stationaryBoundaryBarrier ρ β)) x = -ρ^2*Real.exp (-ρ*(x-β)) := by
  have he : deriv (stationaryBoundaryBarrier ρ β) = fun y => ρ*Real.exp (-ρ*(y-β)) :=
    funext (fun y => (stationaryBoundaryBarrier_hasDerivAt ρ β y).deriv)
  rw [he]
  convert! (((((hasDerivAt_id x).sub_const β).const_mul (-ρ)).exp).const_mul ρ).deriv using 1
  simp
  ring

theorem stationaryBoundaryBarrier_nonneg {ρ β x : ℝ} (hρ : 0 ≤ ρ) (hx : β ≤ x) :
    0 ≤ stationaryBoundaryBarrier ρ β x := by
  unfold stationaryBoundaryBarrier
  exact sub_nonneg.mpr (Real.exp_le_one_iff.mpr (by nlinarith))

theorem stationaryBoundaryBarrier_pos {ρ β x : ℝ} (hρ : 0 < ρ) (hx : β < x) :
    0 < stationaryBoundaryBarrier ρ β x := by
  unfold stationaryBoundaryBarrier
  exact sub_pos.mpr (Real.exp_lt_one_iff.mpr (by nlinarith))

theorem stationaryBoundaryBarrier_mono_distance {ρ β x γ y : ℝ} (hρ : 0 ≤ ρ)
    (hxy : x-β ≤ y-γ) : stationaryBoundaryBarrier ρ β x ≤ stationaryBoundaryBarrier ρ γ y := by
  unfold stationaryBoundaryBarrier
  have he : -ρ*(y-γ) ≤ -ρ*(x-β) := by nlinarith
  linarith [Real.exp_le_exp.mpr he]

theorem stationaryBoundaryBarrier_le_linear (ρ β x : ℝ) :
    stationaryBoundaryBarrier ρ β x ≤ ρ*(x-β) := by
  unfold stationaryBoundaryBarrier
  linarith [Real.add_one_le_exp (-ρ*(x-β))]

theorem stationaryBoundaryBarrier_operator_nonpos {ρ β x α k : ℝ}
    (hρ : 0 ≤ ρ) (hαρ : α ≤ ρ) (hk : 0 ≤ k) (hx : β ≤ x) :
    deriv (deriv (stationaryBoundaryBarrier ρ β)) x +
      α*deriv (stationaryBoundaryBarrier ρ β) x-k*stationaryBoundaryBarrier ρ β x ≤ 0 := by
  rw [stationaryBoundaryBarrier_deriv2,(stationaryBoundaryBarrier_hasDerivAt ρ β x).deriv]
  have hd : 0 ≤ ρ*(ρ-α)*Real.exp (-ρ*(x-β)) := by positivity
  have hv := mul_nonneg hk (stationaryBoundaryBarrier_nonneg hρ hx)
  nlinarith

theorem stationaryBoundaryBarrier_affine_operator_nonpos {ρ β x α k E N : ℝ}
    (hρ : 0 ≤ ρ) (hαρ : α ≤ ρ) (hk : 0 ≤ k) (hx : β ≤ x)
    (hE : 0 ≤ E) (hN : 0 ≤ N) :
    deriv (deriv (fun y => E+N*stationaryBoundaryBarrier ρ β y)) x +
      α*deriv (fun y => E+N*stationaryBoundaryBarrier ρ β y) x -
        k*(E+N*stationaryBoundaryBarrier ρ β x) ≤ 0 := by
  simp only [deriv_const_add',deriv_const_mul_field']
  have hop := mul_le_mul_of_nonneg_left
    (stationaryBoundaryBarrier_operator_nonpos hρ hαρ hk hx) hN
  have hkill := mul_nonneg hk hE
  nlinarith

end AmericanPutConvexity.Boundary
