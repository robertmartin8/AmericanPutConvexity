import AmericanConvexity.Stopping.ActualTimeIncrement
import AmericanConvexity.Boundary.StationaryBarrier

/-! # Stationary comparison for actual-price time increments

The comparison applies on the earlier continuation region, where both time
slices solve the pricing equation. All lateral and initial estimates are
explicit hypotheses; no derivative of the actual exercise boundary is used.
-/

namespace AmericanConvexity.Stopping

open Set Filter Boundary
open scoped Topology ContDiff

theorem canonicalTimeIncrement_le_stationary {k h δ a T R : ℝ} {G : ℝ → ℝ}
    (hk : 0 < k) (hh : 0 ≤ h) (hhk : h ≤ k) (hδ : 0 ≤ δ) (ha : 0 < a)
    (hR : ∀ t ∈ Icc a T, canonicalLogBoundary k h t ≤ R)
    (hG : ContDiff ℝ 2 G)
    (hoperator : ∀ x t, a < t → t ≤ T → canonicalLogBoundary k h t < x → x < R →
      deriv (deriv G) x+(k-h-1)*deriv G x-k*G x ≤ 0)
    (hinitial : ∀ x, canonicalLogBoundary k h a ≤ x → x ≤ R →
      canonicalTimeIncrement k h δ x a ≤ G x)
    (hleft : ∀ t ∈ Icc a T,
      canonicalTimeIncrement k h δ (canonicalLogBoundary k h t) t ≤ G (canonicalLogBoundary k h t))
    (hright : ∀ t ∈ Icc a T, canonicalTimeIncrement k h δ R t ≤ G R) :
    ∀ z ∈ movingStrip (canonicalLogBoundary k h) R a T,
      canonicalTimeIncrement k h δ z.1 z.2 ≤ G z.1 := by
  let w : ℝ → ℝ → ℝ := fun x t => canonicalTimeIncrement k h δ x t-G x
  have hb : ContinuousOn (canonicalLogBoundary k h) (Icc a T) :=
    (canonicalLogBoundary_continuousOn hk hh hhk).mono (fun _ ht => ha.le.trans ht.1)
  have hw : ContinuousOn (fun z : ℝ × ℝ => w z.1 z.2)
      (movingStrip (canonicalLogBoundary k h) R a T) :=
    ((canonicalTimeIncrement_continuous hk.le δ).sub (hG.continuous.comp continuous_fst)).continuousOn
  have hdt (x t : ℝ) (hat : a < t) (htT : t ≤ T)
      (hx : canonicalLogBoundary k h t < x) (hxR : x < R) : DifferentiableAt ℝ (w x) t := by
    have hc := canonicalTimeIncrement_contDiffAt hk hh hhk hδ (ha.trans hat) hx
    exact ((hc.comp (f := fun s : ℝ => (x,s)) t (by fun_prop)).differentiableAt
      (by norm_num)).sub_const (G x)
  have hpde (x t : ℝ) (hat : a < t) (htT : t ≤ T)
      (hx : canonicalLogBoundary k h t < x) (hxR : x < R) :
      deriv (w x) t ≤ deriv (deriv (fun y => w y t)) x +
        (k-h-1)*deriv (fun y => w y t) x-k*w x t := by
    have hc := canonicalTimeIncrement_contDiffAt hk hh hhk hδ (ha.trans hat) hx
    have hs : ContDiffAt ℝ 2 (fun y => canonicalTimeIncrement k h δ y t) x :=
      hc.comp (f := fun y : ℝ => (y,t)) x (by fun_prop)
    have hsecond : deriv (deriv (fun y => w y t)) x =
        deriv (deriv (fun y => canonicalTimeIncrement k h δ y t)) x-deriv (deriv G) x := by
      simpa only [w,iteratedDeriv_succ,iteratedDeriv_zero] using
        iteratedDeriv_fun_sub (n := 2) hs hG.contDiffAt
    have hfirst : deriv (fun y => w y t) x =
        deriv (fun y => canonicalTimeIncrement k h δ y t) x-deriv G x :=
      deriv_fun_sub (hs.differentiableAt (by norm_num)) (hG.differentiable (by norm_num) x)
    rw [hsecond,hfirst]
    change deriv (fun s => canonicalTimeIncrement k h δ x s-G x) t ≤ _
    rw [deriv_sub_const,canonicalTimeIncrement_equation hk hh hhk hδ (ha.trans hat) hx]
    have hle := hoperator x t hat htT hx hxR
    dsimp only [w]
    linarith
  have hmax := discounted_parabolic_maximum hk (movingStrip_isCompact hb hR) hb hw hdt hpde
    (fun x hx hxR => sub_nonpos.mpr (hinitial x hx hxR))
    (fun t hat htT => sub_nonpos.mpr (hleft t ⟨hat,htT⟩))
    (fun t hat htT => sub_nonpos.mpr (hright t ⟨hat,htT⟩))
  intro z hz
  exact sub_nonpos.mp (hmax z hz)

/-- Small left-boundary data and a uniform increment bound give an explicit
spatial barrier estimate. The positive gap separates the initial and right
boundaries from the barrier's zero reference point. -/
theorem canonicalTimeIncrement_le_exponential {k h δ a T R β ρ g A M : ℝ}
    (hk : 0 < k) (hh : 0 ≤ h) (hhk : h ≤ k) (hδ : 0 ≤ δ) (ha : 0 < a)
    (haT : a ≤ T) (hρ : 0 < ρ) (hαρ : k-h-1 ≤ ρ) (hg : 0 < g)
    (hA : 0 ≤ A) (hM : 0 ≤ M)
    (hR : ∀ t ∈ Icc a T, canonicalLogBoundary k h t ≤ R)
    (hβ : ∀ t ∈ Icc a T, β ≤ canonicalLogBoundary k h t)
    (hgap : β+g ≤ canonicalLogBoundary k h a)
    (hbound : ∀ z ∈ movingStrip (canonicalLogBoundary k h) R a T,
      canonicalTimeIncrement k h δ z.1 z.2 ≤ M*δ)
    (hleft : ∀ t ∈ Icc a T,
      canonicalTimeIncrement k h δ (canonicalLogBoundary k h t) t ≤ A*δ^2) :
    ∀ z ∈ movingStrip (canonicalLogBoundary k h) R a T,
      canonicalTimeIncrement k h δ z.1 z.2 ≤
        A*δ^2+δ*(M/stationaryBoundaryBarrier ρ 0 g)*stationaryBoundaryBarrier ρ β z.1 := by
  let N := δ*(M/stationaryBoundaryBarrier ρ 0 g)
  have hbase : 0 < stationaryBoundaryBarrier ρ 0 g := stationaryBoundaryBarrier_pos hρ hg
  have hN : 0 ≤ N := mul_nonneg hδ (div_nonneg hM hbase.le)
  have hE : 0 ≤ A*δ^2 := mul_nonneg hA (sq_nonneg δ)
  have hlarge (x : ℝ) (hx : β+g ≤ x) :
      M*δ ≤ A*δ^2+N*stationaryBoundaryBarrier ρ β x := by
    have hprof : stationaryBoundaryBarrier ρ 0 g ≤ stationaryBoundaryBarrier ρ β x :=
      stationaryBoundaryBarrier_mono_distance hρ.le (by linarith)
    have heq : N*stationaryBoundaryBarrier ρ 0 g = M*δ := by
      dsimp [N]
      field_simp
    have he := mul_le_mul_of_nonneg_left hprof hN
    rw [heq] at he
    linarith
  apply canonicalTimeIncrement_le_stationary hk hh hhk hδ ha hR
    (hG := (show ContDiff ℝ 2 (fun x => A*δ^2+N*stationaryBoundaryBarrier ρ β x) from
      by unfold stationaryBoundaryBarrier; fun_prop))
  · intro x t hat htT hx _
    exact stationaryBoundaryBarrier_affine_operator_nonpos hρ.le hαρ hk.le
      ((hβ t ⟨hat.le,htT⟩).trans hx.le) hE hN
  · intro x hx hxR
    exact (hbound (x,a) ⟨le_rfl,haT,hx,hxR⟩).trans (hlarge x (hgap.trans hx))
  · intro t ht
    have hnonneg := mul_nonneg hN (stationaryBoundaryBarrier_nonneg hρ.le (hβ t ht))
    exact (hleft t ht).trans (by linarith)
  · intro t ht
    exact (hbound (R,t) ⟨ht.1,ht.2,hR t ht,le_rfl⟩).trans
      (hlarge R (hgap.trans (hR a ⟨le_rfl,haT⟩)))

end AmericanConvexity.Stopping
