import AmericanPutConvexity.Stopping.ActualHeatFlux
import AmericanPutConvexity.Stopping.HeatRepresentationGradient

/-! # A joint continuation-side gradient trace for actual heat theta

The identified representation supplies a jointly continuous gradient
extension near each positive-time contact. The cutoff is removed on a
space-time neighborhood. Neither boundary differentiability nor a gradient
trace is assumed; both the interior derivative and its limiting contact
value are identified from the constructed layer density.
-/

namespace AmericanPutConvexity.Stopping

open Set Filter MeasureTheory Boundary
open scoped Topology ContDiff BoundedContinuousFunction

theorem exists_canonicalHeatTheta_local_rightGradient {k h t : ℝ}
    (hk : 0 < k) (hh : 0 ≤ h) (hhk : h ≤ k) (ht : 0 < t) :
    ∃ G : ℝ × ℝ → ℝ,
      ContinuousAt G (canonicalLogBoundary k h t,2*t) ∧
      HasDerivWithinAt (fun x => canonicalHeatTheta k h (x,2*t))
        (G (canonicalLogBoundary k h t,2*t))
        (Ici (canonicalLogBoundary k h t)) (canonicalLogBoundary k h t) ∧
      ∀ᶠ z in 𝓝 (canonicalLogBoundary k h t,2*t),
        canonicalLogBoundary k h (z.2/2) < z.1 →
        HasDerivAt (fun x => canonicalHeatTheta k h (x,z.2)) (G z) z.1 := by
  obtain ⟨D,hD,hDt,χ,hc,hcomp,hχ,hs,htrans,f,heq⟩ := exists_actualHeatSource_density hk hh hhk ht
  let a := 2*t-D/2
  let T := 2*t+D/4
  let b := fun s => canonicalLogBoundary k h (max a s/2)
  let Q := heatLocalizationSource χ (canonicalHeatTheta k h)
  let G := heatRepresentationRightGradient Q b f.1 D
  have ha : 0 < a := by dsimp [a]; linarith
  have hT : T < a+D := by dsimp [T,a]; linarith
  have hmid : 2*t ∈ Ioo a T := by dsimp [a,T]; constructor <;> linarith
  have hb : Continuous b := canonicalHeatGraph_clamp_continuous hk hh hhk ha
  have hb_eq (s : ℝ) (has : a ≤ s) : b s = canonicalLogBoundary k h (s/2) := by
    dsimp [b]
    rw [max_eq_right has]
  have hb0 : b (2*t) = canonicalLogBoundary k h t := by
    rw [hb_eq (2*t) hmid.1.le,show (2*t)/2 = t by ring]
  have hQ : Continuous Q := actualHeatLocalizationSource_continuous hk hh hhk ha.le hc hs htrans
  have hQc : HasCompactSupport Q := heatLocalizationSource_hasCompactSupport hcomp _
  obtain ⟨Cq,hCq⟩ := hQc.exists_bound_of_continuous hQ
  obtain ⟨L,hL,hmove⟩ := canonicalHeatGraph_clamp_window_bound (T := T) hk hh hhk ha
  have hm : ∀ s ∈ Icc a T, ∀ u ∈ Ioo 0 D, ‖b s-b (s-u)‖ ≤ L*u :=
    fun s hst u hu => hmove s hst.1 hst.2 u hu.1
  have hGc : ContinuousOn G {z | z.2 ∈ Icc a T} :=
    heatRepresentationRightGradient_continuousOn hD hL hQ hCq hb f.1.continuous
      (fun s => f.1.norm_coe_le_norm s) hm
  have htime : ∀ᶠ z : ℝ × ℝ in 𝓝 (canonicalLogBoundary k h t,2*t), z.2 ∈ Ioo a T :=
    continuousAt_snd.preimage_mem_nhds (Ioo_mem_nhds hmid.1 hmid.2)
  have hGat : ContinuousAt G (canonicalLogBoundary k h t,2*t) :=
    (hGc _ ⟨hmid.1.le,hmid.2.le⟩).continuousAt
      (htime.mono fun _ hz => ⟨hz.1.le,hz.2.le⟩)
  obtain ⟨hident,htrace⟩ := actualHeatTheta_localized_representation (T := T)
    hk hh hhk ha hD hT hc hcomp hs htrans f
    (fun s hst => heq s ⟨hst.1,by dsimp [T] at hst; linarith [hst.2]⟩)
  have hfeq : f.1 (2*t) = 2*heatSourcePotentialSpatial Q D (b (2*t),2*t)+heatHistory b D f.1 (2*t) := by
    rw [heatHistory_eq_causal_past f.2 (hmid.2.le.trans hT.le),hb0]
    rw [heq (2*t) ⟨hmid.1.le,by linarith⟩]
    rw [show (2*t)/2 = t by ring]
    congr 1
    apply setIntegral_congr_fun measurableSet_Ioo
    intro u hu
    dsimp only
    rw [hb_eq (2*t-u) (by dsimp [a]; linarith [hu.2])]
  have hGval : G (canonicalLogBoundary k h t,2*t) = f.1 (2*t) := by
    rw [← hb0]
    exact heatRepresentationRightGradient_boundary hfeq
  have heχ : ∀ᶠ z in 𝓝 (canonicalLogBoundary k h t,2*t), χ =ᶠ[𝓝 z] 1 :=
    eventually_eventually_nhds.mpr hχ
  have hremove (z : ℝ × ℝ) (hz : χ =ᶠ[𝓝 z] 1) :
      (fun x => canonicalHeatTheta k h (x,z.2)) =ᶠ[𝓝 z.1]
        (fun x => χ (x,z.2)*canonicalHeatTheta k h (x,z.2)) := by
    filter_upwards [(show ContinuousAt (fun x : ℝ => (x,z.2)) z.1 by fun_prop).preimage_mem_nhds hz] with x hx
    change χ (x,z.2) = 1 at hx
    rw [hx,one_mul]
  refine ⟨G,hGat,?_,?_⟩
  · rw [hGval]
    have hd := htrace (2*t) hmid.1 hmid.2.le
    rw [show (2*t)/2 = t by ring] at hd
    have he := hremove (canonicalLogBoundary k h t,2*t) hχ
    exact hd.congr_of_eventuallyEq (nhdsWithin_le_nhds he) he.self_of_nhds
  · filter_upwards [htime,heχ] with z hzt hχz
    intro hx
    have hx' : b z.2 < z.1 := by rw [hb_eq z.2 hzt.1.le]; exact hx
    have hd := heatRepresentation_transfer_interior_gradient hD hL hQ hQc hCq hb
      f.1.continuous (fun s => f.1.norm_coe_le_norm s) f.2 hzt.1.le hzt.2.le
      (hzt.2.le.trans hT.le) hx' (hm z.2 ⟨hzt.1.le,hzt.2.le⟩) hident
    exact hd.congr_of_eventuallyEq (hremove z hχz)

/-- Joint approach through continuation, with an intrinsic one-sided derivative
as the limit. In particular, spatial distance and time may tend to contact
at unrelated rates. -/
theorem canonicalHeatTheta_gradient_tendsto_contact {k h t : ℝ}
    (hk : 0 < k) (hh : 0 ≤ h) (hhk : h ≤ k) (ht : 0 < t) :
    Tendsto (fun z : ℝ × ℝ => deriv (fun x => canonicalHeatTheta k h (x,z.2)) z.1)
      (𝓝[{z : ℝ × ℝ | canonicalLogBoundary k h (z.2/2) < z.1}]
        (canonicalLogBoundary k h t,2*t))
      (𝓝 (derivWithin (fun x => canonicalHeatTheta k h (x,2*t))
        (Ici (canonicalLogBoundary k h t)) (canonicalLogBoundary k h t))) := by
  obtain ⟨G,hG,hGb,hGi⟩ := exists_canonicalHeatTheta_local_rightGradient hk hh hhk ht
  rw [hGb.derivWithin (uniqueDiffWithinAt_Ici _)]
  apply (hG.tendsto.mono_left nhdsWithin_le_nhds).congr'
  filter_upwards [nhdsWithin_le_nhds hGi,self_mem_nhdsWithin] with z hz hzc
  exact (hz hzc).deriv.symm

theorem zeroDividend_canonicalHeatTheta_gradient_tendsto_contact {k t : ℝ}
    (hk : 0 < k) (ht : 0 < t) :
    Tendsto (fun z : ℝ × ℝ => deriv (fun x => canonicalHeatTheta k 0 (x,z.2)) z.1)
      (𝓝[{z : ℝ × ℝ | canonicalLogBoundary k 0 (z.2/2) < z.1}]
        (canonicalLogBoundary k 0 t,2*t))
      (𝓝 (derivWithin (fun x => canonicalHeatTheta k 0 (x,2*t))
        (Ici (canonicalLogBoundary k 0 t)) (canonicalLogBoundary k 0 t))) :=
  canonicalHeatTheta_gradient_tendsto_contact hk le_rfl hk.le ht

theorem liuRange_canonicalHeatTheta_gradient_tendsto_contact {k h t : ℝ}
    (hh : 0 ≤ h) (hliu : h+1 ≤ k) (ht : 0 < t) :
    Tendsto (fun z : ℝ × ℝ => deriv (fun x => canonicalHeatTheta k h (x,z.2)) z.1)
      (𝓝[{z : ℝ × ℝ | canonicalLogBoundary k h (z.2/2) < z.1}]
        (canonicalLogBoundary k h t,2*t))
      (𝓝 (derivWithin (fun x => canonicalHeatTheta k h (x,2*t))
        (Ici (canonicalLogBoundary k h t)) (canonicalLogBoundary k h t))) :=
  canonicalHeatTheta_gradient_tendsto_contact (by linarith) hh (by linarith) ht

end AmericanPutConvexity.Stopping
