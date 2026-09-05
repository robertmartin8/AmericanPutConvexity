import AmericanConvexity.Boundary.ParabolicHopf

/-! # A quantitative terminal Hopf bound without a derivative hypothesis

The explicit exponential barrier gives linear lower growth directly. No
existence of a terminal normal derivative is assumed or inferred here.
-/

namespace AmericanConvexity.Boundary

open Set Filter
open scoped Topology ContDiff

theorem terminal_linear_lower_of_barrier {u D : ℝ → ℝ → ℝ} {L a T η lam : ℝ}
    (hL : 0 < L) (haT : a ≤ T) (hη : 0 < η) (hlam : 0 < lam)
    (hu : ContinuousOn (fun z : ℝ × ℝ => u z.1 z.2) (movingStrip (fun _ => 0) L a T))
    (hux : ∀ x t, 0 < x → x < L → a < t → t ≤ T → ContDiffAt ℝ 2 (fun y => u y t) x)
    (hut : ∀ x t, 0 < x → x < L → a < t → t ≤ T → DifferentiableAt ℝ (u x) t)
    (hpde : ∀ x t, 0 < x → x < L → a < t → t ≤ T →
      deriv (deriv (fun y => u y t)) x + D x t * deriv (fun y => u y t) x ≤ deriv (u x) t)
    (hD : ∀ x t, 0 < x → x < L → a < t → t ≤ T → 0 ≤ lam + D x t)
    (hbottom : ∀ x, 0 ≤ x → x ≤ L → expBarrier η lam x ≤ u x a)
    (hleft : ∀ t, a ≤ t → t ≤ T → 0 ≤ u 0 t)
    (hright : ∀ t, a ≤ t → t ≤ T → expBarrier η lam L ≤ u L t) :
    ∀ x ∈ Icc 0 L, η*lam*x ≤ u x T := by
  let w : ℝ → ℝ → ℝ := fun x t => expBarrier η lam x - u x t
  have hB : ContDiff ℝ 2 (expBarrier η lam) :=
    (expBarrier_smooth η lam).of_le (WithTop.coe_le_coe.mpr le_top)
  have hw : ContinuousOn (fun z : ℝ × ℝ => w z.1 z.2) (movingStrip (fun _ => 0) L a T) :=
    ((hB.continuous.comp continuous_fst).continuousOn).sub hu
  have hwt (x t : ℝ) (hat : a < t) (htT : t ≤ T) (hx : 0 < x) (hxL : x < L) :
      DifferentiableAt ℝ (w x) t :=
    (hasDerivAt_const t (expBarrier η lam x)).differentiableAt.sub (hut x t hx hxL hat htT)
  have hwpde (x t : ℝ) (hat : a < t) (htT : t ≤ T) (hx : 0 < x) (hxL : x < L) :
      deriv (w x) t ≤ deriv (deriv (fun y => w y t)) x + D x t * deriv (fun y => w y t) x := by
    have hs := hux x t hx hxL hat htT
    have hxx : deriv (deriv (fun y => w y t)) x =
        deriv (deriv (expBarrier η lam)) x - deriv (deriv (fun y => u y t)) x := by
      simpa only [iteratedDeriv_succ, iteratedDeriv_zero, w] using
        iteratedDeriv_fun_sub (n := 2) hB.contDiffAt hs
    rw [hxx]
    dsimp [w]
    rw [deriv_const_sub, deriv_fun_sub (hB.differentiable (by norm_num) x)
      (hs.differentiableAt (by norm_num))]
    have hbar := expBarrier_operator_nonneg (x := x) hη.le hlam.le (hD x t hx hxL hat htT)
    have hineq := hpde x t hx hxL hat htT
    nlinarith
  have hcomp := parabolic_maximum (u := w) (D := D) (b := fun _ => 0)
    continuousOn_const (fun _ _ => hL.le) hw hwt hwpde
    (fun x hx hxL => sub_nonpos.mpr (hbottom x hx hxL))
    (fun t hat htT => by simpa [w, expBarrier] using neg_nonpos.mpr (hleft t hat htT))
    (fun t hat htT => sub_nonpos.mpr (hright t hat htT))
  intro x hx
  obtain ⟨hx,hxL⟩ := hx
  have he := Real.add_one_le_exp (lam * x)
  have hb : η * lam * x ≤ expBarrier η lam x := by
    dsimp [expBarrier]
    nlinarith [mul_le_mul_of_nonneg_left he hη.le]
  exact hb.trans (sub_nonpos.mp (hcomp (x,T) ⟨haT, le_rfl, hx, hxL⟩))

theorem terminal_linear_lower {u D : ℝ → ℝ → ℝ} {L a T M : ℝ}
    (hL : 0 < L) (haT : a ≤ T)
    (hu : ContinuousOn (fun z : ℝ × ℝ => u z.1 z.2) (movingStrip (fun _ => 0) L a T))
    (hux : ∀ x t, 0 < x → x < L → a < t → t ≤ T → ContDiffAt ℝ 2 (fun y => u y t) x)
    (hut : ∀ x t, 0 < x → x < L → a < t → t ≤ T → DifferentiableAt ℝ (u x) t)
    (hpde : ∀ x t, 0 < x → x < L → a < t → t ≤ T →
      deriv (deriv (fun y => u y t)) x + D x t * deriv (fun y => u y t) x ≤ deriv (u x) t)
    (hD : ∀ x t, 0 < x → x < L → a < t → t ≤ T → -M ≤ D x t)
    (hbottom : ∀ x ∈ Icc 0 L, 0 < u x a)
    (hleft : ∀ t, a ≤ t → t ≤ T → 0 ≤ u 0 t)
    (hright : ∀ t ∈ Icc a T, 0 < u L t) :
    ∃ m : ℝ, 0 < m ∧ ∀ x ∈ Icc 0 L, m*x ≤ u x T := by
  have hbcont : ContinuousOn (fun x => u x a) (Icc 0 L) :=
    hu.comp (continuousOn_id.prodMk continuousOn_const) (fun _ hx => ⟨le_rfl,haT,hx⟩)
  have hrcont : ContinuousOn (u L) (Icc a T) :=
    hu.comp (continuousOn_const.prodMk continuousOn_id) (fun _ ht => ⟨ht.1,ht.2,hL.le,le_rfl⟩)
  let lam := |M|+1
  have hlam : 0 < lam := by dsimp [lam]; positivity
  obtain ⟨η,hη,hb,hr⟩ := exists_expBarrier_below_edges hL haT hlam.le hbcont hrcont hbottom hright
  refine ⟨η*lam,mul_pos hη hlam,?_⟩
  exact terminal_linear_lower_of_barrier hL haT hη hlam hu hux hut hpde
    (fun x t hx hxL hat htT => by
      have := hD x t hx hxL hat htT
      dsimp [lam]
      linarith [le_abs_self M]) hb hleft hr

end AmericanConvexity.Boundary
