import AmericanPutConvexity.Boundary.Stefan

/-!
# An endpoint check on CCJZ (2008), Lemma 2.1

The printed conditions (2.3) do not imply `q₀'(0) > 0`. The smooth positive
integrable profile `x³ exp(-x)` satisfies those conditions but has zero first
and second derivative at zero. The Stefan relation `qₓ(0,0) = -k s'(0)`
therefore prevents the printed conclusion `s'(0) < 0` for this profile when `k > 0`.

This is an issue at the initial endpoint of that auxiliary lemma, NOT a
counterexample to the paper's main convexity theorem. Condition (3.1) and the
particular profiles constructed in the appendix do impose a positive initial slope.
-/

namespace AmericanPutConvexity.Boundary

open Filter MeasureTheory
open scoped Topology

noncomputable def flatInitialProfile (x : ℝ) : ℝ := x ^ 3 * Real.exp (-x)

private theorem hasDerivAt_flatInitialProfile (x : ℝ) :
    HasDerivAt flatInitialProfile ((3 * x ^ 2 - x ^ 3) * Real.exp (-x)) x := by
  convert! ((hasDerivAt_id x).pow 3).mul ((hasDerivAt_id x).neg.exp) using 1
  simp only [Pi.neg_apply, Pi.pow_apply, id_eq]
  ring

private theorem deriv_flatInitialProfile :
    deriv flatInitialProfile = fun x => (3 * x ^ 2 - x ^ 3) * Real.exp (-x) := by
  funext x
  exact (hasDerivAt_flatInitialProfile x).deriv

/-- A concrete profile satisfying all the printed conditions (2.3), while its
initial slope is zero. Global `C⁴` regularity here is stronger than the paper's
regularity on the closed nonnegative half-line.
-/
theorem flatInitialProfile_conditions (k : ℝ) :
    ContDiff ℝ 4 flatInitialProfile ∧
    IntegrableOn flatInitialProfile (Set.Ioi 0) ∧
    (∀ x : ℝ, 0 < x → 0 < flatInitialProfile x) ∧
    flatInitialProfile 0 = 0 ∧
    (deriv flatInitialProfile 0) ^ 2 =
      k * (deriv (deriv flatInitialProfile) 0 +
        (k - 1) * deriv flatInitialProfile 0 - k * flatInitialProfile 0) ∧
    Tendsto flatInitialProfile atTop (nhds 0) ∧
    deriv flatInitialProfile 0 = 0 := by
  have hd0 : deriv flatInitialProfile 0 = 0 := by
    rw [deriv_flatInitialProfile]
    norm_num
  have hd20 : deriv (deriv flatInitialProfile) 0 = 0 := by
    rw [deriv_flatInitialProfile]
    have h := ((((hasDerivAt_id (0 : ℝ)).pow 2).const_mul 3).sub
      ((hasDerivAt_id (0 : ℝ)).pow 3)).mul ((hasDerivAt_id (0 : ℝ)).neg.exp)
    convert! h.deriv using 1
    norm_num
  refine ⟨?_, ?_, ?_, ?_, ?_, ?_, hd0⟩
  · unfold flatInitialProfile
    fun_prop
  · have h := Real.GammaIntegral_convergent (s := 4) (by norm_num)
    norm_num only [show (4 : ℝ) - 1 = 3 by norm_num, Real.rpow_ofNat] at h
    change IntegrableOn (fun x : ℝ => x ^ 3 * Real.exp (-x)) (Set.Ioi 0)
    simpa only [mul_comm] using h
  · intro x hx
    exact mul_pos (pow_pos hx _) (Real.exp_pos _)
  · simp [flatInitialProfile]
  · simp [hd0, hd20, flatInitialProfile]
  · exact Real.tendsto_pow_mul_exp_neg_atTop_nhds_zero 3

/-- With zero initial profile slope, the Stefan relation forces zero boundary
speed, contradicting strict negativity at the initial endpoint.
-/
theorem initial_speed_eq_zero {k speed : ℝ} (hk : 0 < k)
    (hStefan : deriv flatInitialProfile 0 = -k * speed) : speed = 0 := by
  have hd0 := (flatInitialProfile_conditions k).2.2.2.2.2.2
  rw [hd0] at hStefan
  nlinarith

/-- The earlier endpoint example satisfies the new intrinsic initial-data
predicate too. Thus that predicate has not silently acquired a positive-slope
condition while being translated into Lean. -/
theorem flatInitialProfile_initialData (k : ℝ) : StefanInitialData k flatInitialProfile := by
  rcases flatInitialProfile_conditions k with ⟨hs, hi, hp, hz, hc, hd, _⟩
  exact StefanInitialData.of_contDiff hs hi hp hz hd hc

end AmericanPutConvexity.Boundary
