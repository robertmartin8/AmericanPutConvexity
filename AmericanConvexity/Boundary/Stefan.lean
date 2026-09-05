import AmericanConvexity.Boundary.Problem

/-!
# The auxiliary Stefan problem

CCJZ (2.1)--(2.3). These are equations and regularity requirements, not a
well-posedness theorem. Positivity and boundary-speed signs are conclusions
to prove, not fields. In particular, no negative speed at time zero is assumed.
The singular initial datum of the limiting problem is NOT an ordinary function
`q₀`; this predicate is for the smooth approximation problems only.
-/

namespace AmericanConvexity.Boundary

open Filter MeasureTheory
open scoped Topology ContDiff

/-- Right derivative on the initial half-line, independent of a left extension. -/
noncomputable def initialRightDeriv (f : ℝ → ℝ) : ℝ → ℝ :=
  derivWithin f (Set.Ici 0)

/-- Printed (2.3), with derivatives interpreted from the right at the corner.
Positive initial slope is deliberately not part of these conditions. -/
structure StefanInitialData (k : ℝ) (q₀ : ℝ → ℝ) : Prop where
  smooth : ContDiffOn ℝ 4 q₀ (Set.Ici 0)
  integrable : IntegrableOn q₀ (Set.Ioi 0)
  positive : ∀ x, 0 < x → 0 < q₀ x
  at_zero : q₀ 0 = 0
  decay : Tendsto q₀ atTop (nhds 0)
  compatibility : (initialRightDeriv q₀ 0) ^ 2 =
    k * (initialRightDeriv (initialRightDeriv q₀) 0 +
      (k - 1) * initialRightDeriv q₀ 0 - k * q₀ 0)

/-- On a smooth global extension, the intrinsic initial derivatives agree
with ordinary derivatives. This allows convenient explicit profile formulas. -/
theorem initialRightDeriv_eq_deriv {f : ℝ → ℝ} (hf : Differentiable ℝ f)
    {x : ℝ} (hx : 0 ≤ x) : initialRightDeriv f x = deriv f x :=
  (hf x).hasDerivAt.hasDerivWithinAt.derivWithin (uniqueDiffOn_Ici 0 x hx)

theorem initialRightDeriv_twice_eq {f : ℝ → ℝ}
    (hf : Differentiable ℝ f) (hdf : Differentiable ℝ (deriv f)) :
    initialRightDeriv (initialRightDeriv f) 0 = deriv (deriv f) 0 := by
  change derivWithin (initialRightDeriv f) (Set.Ici 0) 0 = deriv (deriv f) 0
  have heq : Set.EqOn (initialRightDeriv f) (deriv f) (Set.Ici 0) :=
    fun _ hx => initialRightDeriv_eq_deriv hf hx
  exact (derivWithin_congr heq (initialRightDeriv_eq_deriv hf le_rfl)).trans
    (initialRightDeriv_eq_deriv hdf le_rfl)

/-- Verify the intrinsic half-line conditions using a smooth extension. -/
theorem StefanInitialData.of_contDiff {k : ℝ} {f : ℝ → ℝ}
    (hf : ContDiff ℝ 4 f) (hi : IntegrableOn f (Set.Ioi 0))
    (hp : ∀ x, 0 < x → 0 < f x) (hz : f 0 = 0)
    (hdecay : Tendsto f atTop (nhds 0))
    (hcompat : (deriv f 0) ^ 2 = k * spatialOperator k f 0) :
    StefanInitialData k f := by
  have hd := hf.differentiable (by decide)
  have hdd := (hf.of_le (show (2 : ℕ∞ω) ≤ 4 by decide)).differentiable_deriv_two
  refine ⟨hf.contDiffOn, hi, hp, hz, hdecay, ?_⟩
  rw [initialRightDeriv_eq_deriv hd le_rfl, initialRightDeriv_twice_eq hd hdd]
  exact hcompat

/-- A classical smooth-data Stefan solution, extended by zero to the left.
This interface does not yet include the higher corner regularity needed for
the approximation theorem; that must be proved and recorded separately. -/
structure StefanSolution (k : ℝ) (q₀ : ℝ → ℝ)
    (q : ℝ → ℝ → ℝ) (s : ℝ → ℝ) : Prop where
  rate_pos : 0 < k
  initial_data : StefanInitialData k q₀
  boundary_initial : s 0 = 0
  boundary_continuous : ContinuousOn s (Set.Ici 0)
  boundary_smooth : ContDiffOn ℝ ∞ s (Set.Ioi 0)
  continuous : ContinuousOn (fun z : ℝ × ℝ => q z.1 z.2) {z | 0 ≤ z.2}
  smooth : ContDiffOn ℝ ∞ (fun z : ℝ × ℝ => q z.1 z.2) (continuationRegion s)
  initial : ∀ x, 0 ≤ x → q x 0 = q₀ x
  zero_extension : ∀ x t, 0 ≤ t → x ≤ s t → q x t = 0
  equation : ∀ x t, 0 < t → s t < x →
    deriv (q x) t = spatialOperator k (fun y => q y t) x
  stefan : ∀ t, 0 < t → HasDerivWithinAt (fun x => q x t)
    (-k * deriv s t) (Set.Ici (s t)) (s t)
  gradient_trace : ∀ t, 0 < t →
    Tendsto (fun x => deriv (fun y => q y t) x)
      (nhdsWithin (s t) (Set.Ioi (s t))) (nhds (-k * deriv s t))
  decay : ∀ t, 0 ≤ t → Tendsto (fun x => q x t) atTop (nhds 0)

/-- The one-sided slope is the Stefan flux; no derivative across the zero
extension is used, since that extension generally has a kink. -/
theorem StefanSolution.right_slope {k : ℝ} {q₀ s : ℝ → ℝ} {q : ℝ → ℝ → ℝ}
    (h : StefanSolution k q₀ q s) {t : ℝ} (ht : 0 < t) :
    derivWithin (fun x => q x t) (Set.Ici (s t)) (s t) = -k * deriv s t :=
  (h.stefan t ht).derivWithin (uniqueDiffWithinAt_Ici (s t))

/-- A positive right slope implies negative speed, conditional on proving
that slope sign (e.g. by a Hopf lemma). This does not assume or prove Hopf. -/
theorem StefanSolution.speed_neg_of_right_slope_pos
    {k : ℝ} {q₀ s : ℝ → ℝ} {q : ℝ → ℝ → ℝ}
    (h : StefanSolution k q₀ q s) {t : ℝ} (ht : 0 < t)
    (hslope : 0 < derivWithin (fun x => q x t) (Set.Ici (s t)) (s t)) :
    deriv s t < 0 := by
  rw [h.right_slope ht] at hslope
  nlinarith [h.rate_pos]

end AmericanConvexity.Boundary
