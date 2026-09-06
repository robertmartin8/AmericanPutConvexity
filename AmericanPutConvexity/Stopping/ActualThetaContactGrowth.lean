import AmericanPutConvexity.Stopping.ActualThetaPositivity
import AmericanPutConvexity.Stopping.ActualContactDifferentiability
import AmericanPutConvexity.Boundary.QuantitativeHopf

/-! # Nondegenerate linear growth of theta from actual contact

A line whose speed is larger than a local Lipschitz constant lies inside
continuation before its terminal contact. The quantitative Hopf barrier gives
linear lower growth there without assuming a normal derivative exists.
-/

namespace AmericanPutConvexity.Stopping

open Set Filter Boundary Boundary.Comparison
open scoped Topology ContDiff

theorem canonicalTheta_linear_lower_at_boundary {k h t : ℝ} (hk : 0 < k)
    (hh : 0 ≤ h) (hhk : h ≤ k) (ht : 0 < t) :
    ∃ m : ℝ, 0 < m ∧ ∀ y ∈ Icc 0 1,
      m*y ≤ canonicalTheta k h (canonicalLogBoundary k h t+y) t := by
  obtain ⟨L,hL,hLip⟩ := canonicalLogBoundary_local_pointwise_lipschitz hk hh hhk ht
  obtain ⟨η,hη,hηball⟩ := Metric.mem_nhds_iff.mp hLip
  let ρ := min (t/2) (η/2)
  have hρ : 0 < ρ := lt_min (half_pos ht) (half_pos hη)
  have hρt : ρ ≤ t/2 := min_le_left _ _
  have hρη : ρ ≤ η/2 := min_le_right _ _
  let a := t-ρ
  let c := L+1
  let d := canonicalLogBoundary k h t+c*t
  let U := movingLineTransform (canonicalThetaGauge k h) c d
  have ha : 0 < a := by dsimp [a]; linarith
  have hat : a < t := by dsimp [a]; linarith
  have hline (s : ℝ) (hs : s ∈ Icc a t) :
      canonicalLogBoundary k h s ≤ d-c*s ∧
      (s < t → canonicalLogBoundary k h s < d-c*s) := by
    have hdist : dist s t < η := by
      rw [Real.dist_eq,abs_of_nonpos (sub_nonpos.mpr hs.2)]
      dsimp [a] at hs
      linarith [hs.1]
    have he := hηball hdist
    change ‖canonicalLogBoundary k h s-canonicalLogBoundary k h t‖ ≤ L*‖s-t‖ at he
    rw [Real.norm_eq_abs,Real.norm_eq_abs,abs_of_nonpos (sub_nonpos.mpr hs.2)] at he
    have hb := le_abs_self (canonicalLogBoundary k h s-canonicalLogBoundary k h t)
    dsimp [d,c]
    constructor
    · nlinarith [hs.2]
    · intro hst
      nlinarith
  have hregion (y s : ℝ) (hy : 0 < y) (hs : s ∈ Icc a t) :
      (y+(d-c*s),s) ∈ canonicalContinuationRegion k h := by
    rw [canonicalContinuationRegion_eq_logBoundary hk hh hhk]
    exact ⟨ha.trans_le hs.1,by linarith [(hline s hs).1]⟩
  have hU : ContinuousOn (fun z : ℝ × ℝ => U z.1 z.2) (movingStrip (fun _ => 0) 1 a t) := by
    intro z hz
    have hc := canonicalThetaGauge_continuousAt
      (x := z.1+(d-c*z.2)) hk hh hhk (ha.trans_le hz.1)
    exact (hc.comp (f := fun z : ℝ × ℝ => (z.1+(d-c*z.2),z.2)) (by fun_prop)).continuousWithinAt
  have hUs (y s : ℝ) (hy : 0 < y) (hs : s ∈ Icc a t) :
      ContDiffAt ℝ 2 (fun z : ℝ × ℝ => U z.1 z.2) (y,s) :=
    (canonicalThetaGauge_contDiffAt hk hh hhk (hregion y s hy hs)).comp
      (f := fun z : ℝ × ℝ => (z.1+(d-c*z.2),z.2)) (y,s) (by fun_prop)
  obtain ⟨M,hM⟩ := incrementDrift_bounded (h := h) hk
  obtain ⟨m,hm,hbound⟩ := terminal_linear_lower (u := U)
    (D := fun y s => incrementDrift k h (y+(d-c*s))-c) (M := M+c)
    (by norm_num : (0 : ℝ) < 1) hat.le hU
    (fun y s hy _ has hst => (hUs y s hy ⟨has.le,hst⟩).comp
      (f := fun z : ℝ => (z,s)) y (by fun_prop))
    (fun y s hy _ has hst => ((hUs y s hy ⟨has.le,hst⟩).comp
      (f := fun z : ℝ => (y,z)) s (by fun_prop)).differentiableAt (by norm_num))
    (fun y s hy _ has hst => (movingLineTransform_equation (D := fun y _ => incrementDrift k h y)
      ((canonicalThetaGauge_contDiffAt hk hh hhk (hregion y s hy ⟨has.le,hst⟩)).differentiableAt
        (by norm_num)) (canonicalThetaGauge_equation hk hh hhk (hregion y s hy ⟨has.le,hst⟩))).ge)
    (fun y s _ _ _ _ => by linarith [(abs_le.mp (hM (y+(d-c*s)))).1])
    (by
      intro y hy
      have hz : (y+(d-c*a),a) ∈ canonicalContinuationRegion k h := by
        rw [canonicalContinuationRegion_eq_logBoundary hk hh hhk]
        exact ⟨ha,by linarith [(hline a ⟨le_rfl,hat.le⟩).2 hat,hy.1]⟩
      exact div_pos (canonicalTheta_pos hk hh hhk hz) ((profile_data hk.le).pos _))
    (fun s _ _ => canonicalThetaGauge_nonneg hk _ s)
    (fun s hs => div_pos (canonicalTheta_pos hk hh hhk (hregion 1 s (by norm_num) hs))
      ((profile_data hk.le).pos _))
  refine ⟨m,hm,?_⟩
  intro y hy
  have he := hbound y hy
  have hfinal : y+(d-c*t) = canonicalLogBoundary k h t+y := by dsimp [d]; ring
  change m*y ≤ canonicalThetaGauge k h (y+(d-c*t)) t at he
  rw [hfinal] at he
  exact he.trans (div_le_self (canonicalTheta_nonneg hk.le _ t) ((profile_data hk.le).ge_one _))

theorem canonicalTheta_contact_slope_bounds {k h t : ℝ} (hk : 0 < k)
    (hh : 0 ≤ h) (hhk : h ≤ k) (ht : 0 < t) :
    ∃ δ m M : ℝ, 0 < δ ∧ 0 < m ∧ 0 < M ∧
      ∀ x ∈ Ioo (canonicalLogBoundary k h t) (canonicalLogBoundary k h t+δ),
        m ≤ canonicalTheta k h x t/(x-canonicalLogBoundary k h t) ∧
        canonicalTheta k h x t/(x-canonicalLogBoundary k h t) ≤ M := by
  obtain ⟨m,hm,hlo⟩ := canonicalTheta_linear_lower_at_boundary hk hh hhk ht
  obtain ⟨η,M,hη,hM,hupper⟩ := canonicalPrice_time_deriv_linear_near_boundary hk hh hhk ht
  have hb := canonicalLogBoundary_neg hk hh hhk ht
  let δ := min 1 (-canonicalLogBoundary k h t/2)
  have hδ : 0 < δ := lt_min (by norm_num) (div_pos (neg_pos.mpr hb) (by norm_num))
  refine ⟨δ,m,M,hδ,hm,hM,?_⟩
  intro x hx
  have hdx : 0 < x-canonicalLogBoundary k h t := sub_pos.mpr hx.1
  have hd1 : x-canonicalLogBoundary k h t ≤ 1 := by
    have he : δ ≤ 1 := min_le_left _ _
    linarith [hx.2]
  have hx0 : x ≤ 0 := by
    have he : δ ≤ -canonicalLogBoundary k h t/2 := min_le_right _ _
    linarith [hx.2]
  have hl := hlo (x-canonicalLogBoundary k h t) ⟨hdx.le,hd1⟩
  rw [add_sub_cancel] at hl
  have hu := ((hupper t (by simpa only [dist_self] using hη)).2 x ⟨hx.1.le,hx0⟩).2
  exact ⟨(le_div_iff₀ hdx).mpr hl,(div_le_iff₀ hdx).mpr hu⟩

/-- The required flux is a right-sided trace. Theta has no two-sided spatial
derivative at exercise contact, since it is zero on the left and grows at
least linearly on the right. This does not contradict C1 regularity of price. -/
theorem canonicalTheta_not_differentiableAt_contact {k h t : ℝ} (hk : 0 < k)
    (hh : 0 ≤ h) (hhk : h ≤ k) (ht : 0 < t) :
    ¬ DifferentiableAt ℝ (fun x => canonicalTheta k h x t) (canonicalLogBoundary k h t) := by
  intro hd
  have hleft : HasDerivWithinAt (fun x => canonicalTheta k h x t) 0
      (Iic (canonicalLogBoundary k h t)) (canonicalLogBoundary k h t) :=
    (hasDerivWithinAt_const _ _ (0 : ℝ)).congr_of_mem
      (fun x hx => canonicalTheta_exercise_zero hk hh hhk ht hx) self_mem_Iic
  have hzero := hleft.deriv_eq_zero (uniqueDiffWithinAt_Iic _)
  have hlim := hd.hasDerivAt.tendsto_slope.mono_left (nhdsGT_le_nhdsNE _)
  rw [hzero] at hlim
  obtain ⟨δ,m,M,hδ,hm,_,hbound⟩ := canonicalTheta_contact_slope_bounds hk hh hhk ht
  have hbad : m ≤ (0 : ℝ) := by
    apply ge_of_tendsto hlim
    filter_upwards [self_mem_nhdsWithin,nhdsWithin_le_nhds
      (Iio_mem_nhds (show canonicalLogBoundary k h t < canonicalLogBoundary k h t+δ by linarith))]
      with x hx hxδ
    rw [slope_def_field,canonicalTheta_exercise_zero hk hh hhk ht le_rfl,sub_zero]
    exact (hbound x ⟨hx,hxδ⟩).1
  exact (not_le_of_gt hm) hbad

theorem zeroDividend_canonicalTheta_contact_slope_bounds {k t : ℝ} (hk : 0 < k) (ht : 0 < t) :
    ∃ δ m M : ℝ, 0 < δ ∧ 0 < m ∧ 0 < M ∧
      ∀ x ∈ Ioo (canonicalLogBoundary k 0 t) (canonicalLogBoundary k 0 t+δ),
        m ≤ canonicalTheta k 0 x t/(x-canonicalLogBoundary k 0 t) ∧
        canonicalTheta k 0 x t/(x-canonicalLogBoundary k 0 t) ≤ M :=
  canonicalTheta_contact_slope_bounds hk le_rfl hk.le ht

theorem liuRange_canonicalTheta_contact_slope_bounds {k h t : ℝ}
    (hh : 0 ≤ h) (hliu : h+1 ≤ k) (ht : 0 < t) :
    ∃ δ m M : ℝ, 0 < δ ∧ 0 < m ∧ 0 < M ∧
      ∀ x ∈ Ioo (canonicalLogBoundary k h t) (canonicalLogBoundary k h t+δ),
        m ≤ canonicalTheta k h x t/(x-canonicalLogBoundary k h t) ∧
        canonicalTheta k h x t/(x-canonicalLogBoundary k h t) ≤ M :=
  canonicalTheta_contact_slope_bounds (by linarith) hh (by linarith) ht

end AmericanPutConvexity.Stopping
