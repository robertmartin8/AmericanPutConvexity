import AmericanConvexity.Stopping.QuadraticSeparation

/-! # Quadratic upper growth from a flat contact point -/

namespace AmericanConvexity.Stopping

open Set

theorem quadratic_upper_of_deriv2_upper {f : ℝ → ℝ} {b R C : ℝ}
    (hbR : b ≤ R) (hf : ContinuousOn f (Icc b R))
    (hgrad : ContinuousOn (deriv f) (Icc b R))
    (hd : ∀ x ∈ Ioo b R, DifferentiableAt ℝ f x)
    (hdd : ∀ x ∈ Ioo b R, DifferentiableAt ℝ (deriv f) x)
    (hupper : ∀ x ∈ Ioo b R, deriv (deriv f) x ≤ C)
    (hf0 : f b = 0) (hd0 : deriv f b = 0) :
    ∀ x ∈ Icc b R, deriv f x ≤ C*(x-b) ∧ f x ≤ C/2*(x-b)^2 := by
  have hfirst : ∀ x ∈ Icc b R, deriv f x ≤ C*(x-b) := by
    intro x hx
    have he := (convex_Icc b R).image_sub_le_mul_sub_of_deriv_le hgrad
      (fun y hy => (hdd y (by simpa only [interior_Icc] using hy)).differentiableWithinAt)
      (fun y hy => hupper y (by simpa only [interior_Icc] using hy))
      b ⟨le_rfl,hbR⟩ x hx hx.1
    simpa only [hd0,sub_zero] using he
  let Q : ℝ → ℝ := fun y => C/2*(y-b)^2
  have hQ (y : ℝ) : HasDerivAt Q (C*(y-b)) y := by
    convert! ((((hasDerivAt_id y).sub_const b).pow 2).const_mul (C/2)) using 1
    simp
    ring
  have hmono : AntitoneOn (fun y => f y-Q y) (Icc b R) := by
    apply antitoneOn_of_deriv_nonpos (convex_Icc b R)
      (hf.sub (show Continuous Q by fun_prop).continuousOn)
    · intro y hy
      exact ((hd y (by simpa only [interior_Icc] using hy)).sub
        (hQ y).differentiableAt).differentiableWithinAt
    · intro y hy
      have hy' : y ∈ Ioo b R := by simpa only [interior_Icc] using hy
      rw [deriv_sub (hd y hy') (hQ y).differentiableAt,(hQ y).deriv]
      exact sub_nonpos.mpr (hfirst y ⟨hy'.1.le,hy'.2.le⟩)
  intro x hx
  refine ⟨hfirst x hx,?_⟩
  have he := hmono (show b ∈ Icc b R from ⟨le_rfl,hbR⟩) hx hx.1
  dsimp only [Q] at he
  simp only [hf0,sub_self,zero_pow (by decide : 2 ≠ 0),mul_zero] at he
  linarith

end AmericanConvexity.Stopping
