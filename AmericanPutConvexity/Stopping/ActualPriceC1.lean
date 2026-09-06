import AmericanPutConvexity.Stopping.ActualTimeDerivativeContinuity

/-! # Joint C1 regularity of the actual stopping price

The time derivative is continuous in all three regions: exercise, continuation,
and contact. Together with the spatial-gradient trace and joint differentiability
this gives a genuine C1 price on positive-time space-time, not a smooth boundary.
-/

namespace AmericanPutConvexity.Stopping

open Set Filter Boundary
open scoped Topology ContDiff

theorem canonicalPrice_time_deriv_eq_partial {k h x t : ℝ} (hk : 0 < k)
    (hh : 0 ≤ h) (hhk : h ≤ k) (ht : 0 < t) :
    deriv (canonicalPrice k h x) t =
      heatPartial (fun z : ℝ × ℝ => canonicalPrice k h z.1 z.2) (0,1) (x,t) :=
  (heatPartial_space (canonicalPrice_joint_differentiableAt hk hh hhk ht)).deriv

theorem canonicalPrice_time_deriv_continuousAt {k h x t : ℝ} (hk : 0 < k)
    (hh : 0 ≤ h) (hhk : h ≤ k) (ht : 0 < t) :
    ContinuousAt (fun z : ℝ × ℝ => deriv (canonicalPrice k h z.1) z.2) (x,t) := by
  rcases lt_trichotomy x (canonicalLogBoundary k h t) with hx | hx | hx
  · have hb : ContinuousAt (fun z : ℝ × ℝ => canonicalLogBoundary k h z.2) (x,t) := by
      have hb0 := canonicalLogBoundary_continuousAt hk hh hhk ht.le
      exact hb0.comp (x := (x,t)) (f := fun z : ℝ × ℝ => z.2) continuousAt_snd
    have hi : ∀ᶠ z : ℝ × ℝ in 𝓝 (x,t), z.1 < canonicalLogBoundary k h z.2 :=
      continuousAt_fst.eventually_lt hb hx
    apply (continuousAt_const (y := (0 : ℝ))).congr_of_eventuallyEq
    filter_upwards [hi,continuousAt_snd.preimage_mem_nhds (Ioi_mem_nhds ht)] with z hz hzt
    exact canonicalPrice_time_deriv_exercise hk hh hhk hzt hz.le
  · rw [hx]
    exact canonicalPrice_time_deriv_continuousAt_contact hk hh hhk ht
  · have hz : (x,t) ∈ canonicalContinuationRegion k h := by
      rw [canonicalContinuationRegion_eq_logBoundary hk hh hhk]
      exact ⟨ht,hx⟩
    apply (heatPartial_smoothAt (canonicalPrice_contDiffAt hk.le hz) (0,1)).continuousAt.congr_of_eventuallyEq
    filter_upwards [continuousAt_snd.preimage_mem_nhds (Ioi_mem_nhds ht)] with z hzt
    exact canonicalPrice_time_deriv_eq_partial hk hh hhk hzt

theorem fderiv_plane_eq_partials {F : ℝ × ℝ → ℝ} {x t : ℝ}
    (hF : DifferentiableAt ℝ F (x,t)) :
    fderiv ℝ F (x,t) =
      deriv (fun y => F (y,t)) x • ContinuousLinearMap.fst ℝ ℝ ℝ +
      deriv (fun s => F (x,s)) t • ContinuousLinearMap.snd ℝ ℝ ℝ := by
  have hx := (heatPartial_time hF).deriv
  have ht := (heatPartial_space hF).deriv
  apply ContinuousLinearMap.ext
  intro z
  change fderiv ℝ F (x,t) z = deriv (fun y => F (y,t)) x*z.1+deriv (fun s => F (x,s)) t*z.2
  rw [hx,ht]
  have he : z = z.1 • ((1,0) : ℝ × ℝ)+z.2 • ((0,1) : ℝ × ℝ) := by
    ext <;> simp
  calc
    fderiv ℝ F (x,t) z = fderiv ℝ F (x,t) (z.1 • (1,0)+z.2 • (0,1)) := congrArg _ he
    _ = _ := by simp only [map_add,map_smul,smul_eq_mul,heatPartial]; ring

theorem canonicalPrice_fderiv_continuousAt {k h x t : ℝ} (hk : 0 < k)
    (hh : 0 ≤ h) (hhk : h ≤ k) (ht : 0 < t) :
    ContinuousAt (fderiv ℝ (fun z : ℝ × ℝ => canonicalPrice k h z.1 z.2)) (x,t) := by
  have hx := canonicalPrice_gradient_continuousAt (x := x) hk hh hhk ht
  have hs := canonicalPrice_time_deriv_continuousAt (x := x) hk hh hhk ht
  have hc := (hx.smul (continuousAt_const (y := ContinuousLinearMap.fst ℝ ℝ ℝ))).add
    (hs.smul (continuousAt_const (y := ContinuousLinearMap.snd ℝ ℝ ℝ)))
  apply hc.congr_of_eventuallyEq
  filter_upwards [continuousAt_snd.preimage_mem_nhds (Ioi_mem_nhds ht)] with z hzt
  exact fderiv_plane_eq_partials (canonicalPrice_joint_differentiableAt hk hh hhk hzt)

theorem canonicalPrice_contDiffAt_one {k h x t : ℝ} (hk : 0 < k)
    (hh : 0 ≤ h) (hhk : h ≤ k) (ht : 0 < t) :
    ContDiffAt ℝ 1 (fun z : ℝ × ℝ => canonicalPrice k h z.1 z.2) (x,t) := by
  rw [contDiffAt_one_iff]
  refine ⟨fderiv ℝ (fun z : ℝ × ℝ => canonicalPrice k h z.1 z.2),
    {z : ℝ × ℝ | 0 < z.2},continuousAt_snd.preimage_mem_nhds (Ioi_mem_nhds ht),?_,?_⟩
  · intro z hz
    exact (canonicalPrice_fderiv_continuousAt hk hh hhk hz).continuousWithinAt
  · intro z hz
    exact (canonicalPrice_joint_differentiableAt hk hh hhk hz).hasFDerivAt

theorem canonicalPrice_contDiffOn_one {k h : ℝ} (hk : 0 < k)
    (hh : 0 ≤ h) (hhk : h ≤ k) :
    ContDiffOn ℝ 1 (fun z : ℝ × ℝ => canonicalPrice k h z.1 z.2) {z | 0 < z.2} :=
  fun _ hz => (canonicalPrice_contDiffAt_one hk hh hhk hz).contDiffWithinAt

theorem zeroDividend_canonicalPrice_contDiffOn_one {k : ℝ} (hk : 0 < k) :
    ContDiffOn ℝ 1 (fun z : ℝ × ℝ => canonicalPrice k 0 z.1 z.2) {z | 0 < z.2} :=
  canonicalPrice_contDiffOn_one hk le_rfl hk.le

theorem liuRange_canonicalPrice_contDiffOn_one {k h : ℝ} (hh : 0 ≤ h) (hliu : h+1 ≤ k) :
    ContDiffOn ℝ 1 (fun z : ℝ × ℝ => canonicalPrice k h z.1 z.2) {z | 0 < z.2} :=
  canonicalPrice_contDiffOn_one (by linarith) hh (by linarith)

end AmericanPutConvexity.Stopping
