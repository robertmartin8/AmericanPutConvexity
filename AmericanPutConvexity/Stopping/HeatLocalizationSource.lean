import AmericanPutConvexity.Stopping.ActualHeatTheta

/-! # The source created by localizing a heat solution

Only the cutoff's spatial transition region requires a derivative of the
solution. Keeping that region away from contact makes the actual theta source
continuous, even though theta is not spatially differentiable at contact.
-/

namespace AmericanPutConvexity.Stopping

open Set Filter Boundary
open scoped Topology ContDiff

noncomputable def heatLocalizationSource (χ W : ℝ × ℝ → ℝ) (z : ℝ × ℝ) : ℝ :=
  (heatPartial χ (0,1) z-(1/2)*heatPartial (heatPartial χ (1,0)) (1,0) z)*W z-
    heatPartial χ (1,0) z*heatPartial W (1,0) z

theorem heatPartial_tsupport_subset (F : ℝ × ℝ → ℝ) (v : ℝ × ℝ) :
    tsupport (heatPartial F v) ⊆ tsupport F := tsupport_fderiv_apply_subset ℝ v

theorem heatLocalizationSource_tsupport_subset (χ W : ℝ × ℝ → ℝ) :
    tsupport (heatLocalizationSource χ W) ⊆ tsupport χ := by
  apply closure_minimal _ (isClosed_tsupport _)
  intro z hz
  by_contra hn
  have ht : heatPartial χ (0,1) z = 0 :=
    image_eq_zero_of_notMem_tsupport (fun hm => hn (heatPartial_tsupport_subset χ (0,1) hm))
  have hx : heatPartial χ (1,0) z = 0 :=
    image_eq_zero_of_notMem_tsupport (fun hm => hn (heatPartial_tsupport_subset χ (1,0) hm))
  have hxx : heatPartial (heatPartial χ (1,0)) (1,0) z = 0 :=
    image_eq_zero_of_notMem_tsupport (fun hm => hn
      (heatPartial_tsupport_subset χ (1,0) (heatPartial_tsupport_subset _ (1,0) hm)))
  exact hz (by simp [heatLocalizationSource,ht,hx,hxx])

theorem heatLocalizationSource_hasCompactSupport {χ : ℝ × ℝ → ℝ}
    (hc : HasCompactSupport χ) (W : ℝ × ℝ → ℝ) :
    HasCompactSupport (heatLocalizationSource χ W) :=
  hc.of_isClosed_subset (isClosed_tsupport _) (heatLocalizationSource_tsupport_subset χ W)

theorem heatLocalizationSource_causal {χ : ℝ × ℝ → ℝ} {a : ℝ}
    (hs : ∀ z ∈ tsupport χ, a < z.2) (W : ℝ × ℝ → ℝ)
    (z : ℝ × ℝ) (hz : z.2 ≤ a) : heatLocalizationSource χ W z = 0 :=
  image_eq_zero_of_notMem_tsupport (fun hm => (not_lt_of_ge hz)
    (hs z (heatLocalizationSource_tsupport_subset χ W hm)))

theorem heatLocalizationSource_equation {χ W : ℝ × ℝ → ℝ} {x s : ℝ}
    (hc : ContDiffAt ℝ ∞ χ (x,s)) (hW : ContDiffAt ℝ ∞ W (x,s))
    (he : deriv (fun v => W (x,v)) s =
      (1/2)*deriv (deriv (fun y => W (y,s))) x) :
    deriv (fun v => χ (x,v)*W (x,v)) s-
        (1/2)*deriv (deriv (fun y => χ (y,s)*W (y,s))) x =
      heatLocalizationSource χ W (x,s) := by
  have hcx : ContDiffAt ℝ 2 (fun y => χ (y,s)) x :=
    (hc.comp x (show ContDiffAt ℝ ∞ (fun y : ℝ => (y,s)) x by fun_prop)).of_le
      (WithTop.coe_le_coe.mpr le_top)
  have hWx : ContDiffAt ℝ 2 (fun y => W (y,s)) x :=
    (hW.comp x (show ContDiffAt ℝ ∞ (fun y : ℝ => (y,s)) x by fun_prop)).of_le
      (WithTop.coe_le_coe.mpr le_top)
  have hct := heatPartial_space (hc.differentiableAt (by simp))
  have hWt := heatPartial_space (hW.differentiableAt (by simp))
  have ht := (hct.mul hWt).deriv
  simp only [Pi.mul_def] at ht
  rw [ht,Boundary.Comparison.deriv2_mul_at hcx hWx,
    (heatPartial_time (hc.differentiableAt (by simp))).deriv,
    (heatPartial_time (hW.differentiableAt (by simp))).deriv,
    heatPartial_spatial_second hc,heatPartial_spatial_second hW]
  rw [hWt.deriv,heatPartial_spatial_second hW] at he
  unfold heatLocalizationSource
  rw [he]
  ring

theorem continuous_mul_of_continuousAt_tsupport {A F : ℝ × ℝ → ℝ}
    (hA : Continuous A) (hF : ∀ z ∈ tsupport A, ContinuousAt F z) :
    Continuous (fun z => A z*F z) := by
  apply continuous_iff_continuousAt.mpr
  intro z
  by_cases hz : z ∈ tsupport A
  · exact hA.continuousAt.mul (hF z hz)
  · apply (continuousAt_const (y := (0 : ℝ))).congr_of_eventuallyEq
    filter_upwards [notMem_tsupport_iff_eventuallyEq.mp hz] with y hy
    simp [hy]

theorem canonicalHeatTheta_eventuallyEq_zero_exercise {k h x s : ℝ}
    (hk : 0 < k) (hh : 0 ≤ h) (hhk : h ≤ k) (hs : 0 < s)
    (hx : x < canonicalLogBoundary k h (s/2)) :
    canonicalHeatTheta k h =ᶠ[𝓝 (x,s)] 0 := by
  have hb : ContinuousAt (fun z : ℝ × ℝ => canonicalLogBoundary k h (z.2/2)) (x,s) :=
    (canonicalLogBoundary_continuousAt hk hh hhk (by positivity : 0 ≤ s/2)).comp
      (x := (x,s)) (f := fun z : ℝ × ℝ => z.2/2) (by fun_prop)
  have hnear : ∀ᶠ z : ℝ × ℝ in 𝓝 (x,s), z.1 < canonicalLogBoundary k h (z.2/2) :=
    continuousAt_fst.eventually_lt hb hx
  filter_upwards [hnear,continuousAt_snd.preimage_mem_nhds (Ioi_mem_nhds hs)] with z hz hzs
  exact canonicalHeatTheta_exercise_zero hk hh hhk hzs hz.le

theorem canonicalHeatTheta_contDiffAt_off_contact {k h x s : ℝ}
    (hk : 0 < k) (hh : 0 ≤ h) (hhk : h ≤ k) (hs : 0 < s)
    (hx : x ≠ canonicalLogBoundary k h (s/2)) :
    ContDiffAt ℝ ∞ (canonicalHeatTheta k h) (x,s) := by
  rcases lt_or_gt_of_ne hx with hx | hx
  · exact (contDiffAt_const (c := (0 : ℝ))).congr_of_eventuallyEq
      (canonicalHeatTheta_eventuallyEq_zero_exercise hk hh hhk hs hx)
  · exact canonicalHeatTheta_contDiffAt hk hh hhk hs hx

/-- The spatial cutoff transitions avoid the graph; no contact derivative of
actual theta is a premise. Time support is separated from singular expiry. -/
theorem actualHeatLocalizationSource_continuous {k h a : ℝ} {χ : ℝ × ℝ → ℝ}
    (hk : 0 < k) (hh : 0 ≤ h) (hhk : h ≤ k) (ha : 0 ≤ a)
    (hc : ContDiff ℝ ∞ χ) (hs : ∀ z ∈ tsupport χ, a < z.2)
    (htrans : ∀ z ∈ tsupport (heatPartial χ (1,0)),
      z.1 ≠ canonicalLogBoundary k h (z.2/2)) :
    Continuous (heatLocalizationSource χ (canonicalHeatTheta k h)) := by
  have hc1 (v : ℝ × ℝ) : ContDiff ℝ ∞ (heatPartial χ v) :=
    contDiff_iff_contDiffAt.mpr (fun _ => heatPartial_smoothAt hc.contDiffAt v)
  have hc2 : ContDiff ℝ ∞ (heatPartial (heatPartial χ (1,0)) (1,0)) :=
    contDiff_iff_contDiffAt.mpr (fun _ => heatPartial_smoothAt (hc1 (1,0)).contDiffAt (1,0))
  have h0 : Continuous (fun z => heatPartial χ (0,1) z*canonicalHeatTheta k h z) :=
    continuous_mul_of_continuousAt_tsupport (hc1 (0,1)).continuous
      (fun z hz => canonicalHeatTheta_continuousAt hk hh hhk
        (ha.trans_lt (hs z (heatPartial_tsupport_subset χ (0,1) hz))))
  have h2 : Continuous (fun z => heatPartial (heatPartial χ (1,0)) (1,0) z*
      canonicalHeatTheta k h z) :=
    continuous_mul_of_continuousAt_tsupport hc2.continuous
      (fun z hz => canonicalHeatTheta_continuousAt hk hh hhk
        (ha.trans_lt (hs z (heatPartial_tsupport_subset χ (1,0)
          (heatPartial_tsupport_subset _ (1,0) hz)))))
  have h1 : Continuous (fun z => heatPartial χ (1,0) z*
      heatPartial (canonicalHeatTheta k h) (1,0) z) :=
    continuous_mul_of_continuousAt_tsupport (hc1 (1,0)).continuous
      (fun z hz => (heatPartial_smoothAt
        (canonicalHeatTheta_contDiffAt_off_contact hk hh hhk
          (ha.trans_lt (hs z (heatPartial_tsupport_subset χ (1,0) hz)))
          (htrans z hz)) (1,0)).continuousAt)
  convert! (h0.sub ((continuous_const (y := (1/2 : ℝ))).mul h2)).sub h1 using 1
  funext z
  dsimp [heatLocalizationSource]
  ring

theorem actualHeatLocalizationSource_bounded {k h a : ℝ} {χ : ℝ × ℝ → ℝ}
    (hk : 0 < k) (hh : 0 ≤ h) (hhk : h ≤ k) (ha : 0 ≤ a)
    (hc : ContDiff ℝ ∞ χ) (hcomp : HasCompactSupport χ)
    (hs : ∀ z ∈ tsupport χ, a < z.2)
    (htrans : ∀ z ∈ tsupport (heatPartial χ (1,0)),
      z.1 ≠ canonicalLogBoundary k h (z.2/2)) :
    ∃ C : ℝ, ∀ z, ‖heatLocalizationSource χ (canonicalHeatTheta k h) z‖ ≤ C :=
  (heatLocalizationSource_hasCompactSupport hcomp _).exists_bound_of_continuous
    (actualHeatLocalizationSource_continuous hk hh hhk ha hc hs htrans)

theorem actualHeatLocalizationSource_equation {k h x s : ℝ} {χ : ℝ × ℝ → ℝ}
    (hk : 0 < k) (hh : 0 ≤ h) (hhk : h ≤ k) (hc : ContDiff ℝ ∞ χ)
    (hs : 0 < s) (hx : canonicalLogBoundary k h (s/2) < x) :
    deriv (fun v => χ (x,v)*canonicalHeatTheta k h (x,v)) s-
        (1/2)*deriv (deriv (fun y => χ (y,s)*canonicalHeatTheta k h (y,s))) x =
      heatLocalizationSource χ (canonicalHeatTheta k h) (x,s) :=
  heatLocalizationSource_equation hc.contDiffAt (canonicalHeatTheta_contDiffAt hk hh hhk hs hx)
    (canonicalHeatTheta_equation hk hh hhk hs hx)

theorem actualHeatLocalizationSource_exercise_zero {k h x s : ℝ} {χ : ℝ × ℝ → ℝ}
    (hk : 0 < k) (hh : 0 ≤ h) (hhk : h ≤ k) (hs : 0 < s)
    (hx : x ≤ canonicalLogBoundary k h (s/2))
    (htrans : ∀ z ∈ tsupport (heatPartial χ (1,0)),
      z.1 ≠ canonicalLogBoundary k h (z.2/2)) :
    heatLocalizationSource χ (canonicalHeatTheta k h) (x,s) = 0 := by
  unfold heatLocalizationSource
  rw [canonicalHeatTheta_exercise_zero hk hh hhk hs hx,mul_zero,zero_sub]
  rcases hx.lt_or_eq with hx | hx
  · have he := (canonicalHeatTheta_eventuallyEq_zero_exercise hk hh hhk hs hx).fderiv_eq (𝕜 := ℝ)
    have hd : heatPartial (canonicalHeatTheta k h) (1,0) (x,s) = 0 := by
      simp only [heatPartial,he,Pi.zero_def,fderiv_const_apply,zero_apply]
    rw [hd,mul_zero,neg_zero]
  · have hd : heatPartial χ (1,0) (x,s) = 0 :=
      image_eq_zero_of_notMem_tsupport (fun hz => htrans (x,s) hz hx)
    rw [hd,zero_mul,neg_zero]

theorem actualHeatTheta_localization_continuous {k h a : ℝ} {χ : ℝ × ℝ → ℝ}
    (hk : 0 < k) (hh : 0 ≤ h) (hhk : h ≤ k) (ha : 0 ≤ a)
    (hc : Continuous χ) (hs : ∀ z ∈ tsupport χ, a < z.2) :
    Continuous (fun z => χ z*canonicalHeatTheta k h z) :=
  continuous_mul_of_continuousAt_tsupport hc
    (fun z hz => canonicalHeatTheta_continuousAt hk hh hhk (ha.trans_lt (hs z hz)))

theorem actualHeatTheta_localization_bounded {k h a : ℝ} {χ : ℝ × ℝ → ℝ}
    (hk : 0 < k) (hh : 0 ≤ h) (hhk : h ≤ k) (ha : 0 ≤ a)
    (hc : Continuous χ) (hcomp : HasCompactSupport χ) (hs : ∀ z ∈ tsupport χ, a < z.2) :
    ∃ C : ℝ, ∀ z, ‖χ z*canonicalHeatTheta k h z‖ ≤ C :=
  hcomp.mul_right.exists_bound_of_continuous
    (actualHeatTheta_localization_continuous hk hh hhk ha hc hs)

end AmericanPutConvexity.Stopping
