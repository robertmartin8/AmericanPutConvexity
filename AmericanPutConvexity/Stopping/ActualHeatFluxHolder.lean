import AmericanPutConvexity.Stopping.ActualDensityHolder

/-! # One-half Holder regularity of the actual right heat flux

The constructed density is the actual continuation-sided spatial derivative
near the contact where the cutoff is one. Its one-half Holder estimate
therefore transfers to an intrinsic derivative, without an assumed trace.
-/

namespace AmericanPutConvexity.Stopping

open Set Filter Boundary
open scoped Topology ContDiff BoundedContinuousFunction

noncomputable def canonicalHeatThetaRightFlux (k h s : ℝ) : ℝ :=
  derivWithin (fun x => canonicalHeatTheta k h (x,s))
    (Ici (canonicalLogBoundary k h (s/2))) (canonicalLogBoundary k h (s/2))

theorem canonicalHeatTheta_hasDerivWithinAt_right_flux {k h s : ℝ}
    (hk : 0 < k) (hh : 0 ≤ h) (hhk : h ≤ k) (hs : 0 < s) :
    HasDerivWithinAt (fun x => canonicalHeatTheta k h (x,s))
      (canonicalHeatThetaRightFlux k h s)
      (Ici (canonicalLogBoundary k h (s/2))) (canonicalLogBoundary k h (s/2)) := by
  obtain ⟨v,hv⟩ := canonicalHeatTheta_has_right_flux hk hh hhk hs
  unfold canonicalHeatThetaRightFlux
  rw [hv.derivWithin (uniqueDiffWithinAt_Ici _)]
  exact hv

theorem canonicalHeatThetaRightFlux_holder {k h t : ℝ}
    (hk : 0 < k) (hh : 0 ≤ h) (hhk : h ≤ k) (ht : 0 < t) :
    ∃ (A : ℝ) (U : Set ℝ), 0 ≤ A ∧ U ∈ 𝓝 (2*t) ∧ ∀ s₁ ∈ U, ∀ s₂ ∈ U, s₁ < s₂ →
      ‖canonicalHeatThetaRightFlux k h s₂-canonicalHeatThetaRightFlux k h s₁‖ ≤
        A*Real.sqrt (s₂-s₁) := by
  obtain ⟨D,hD,hDt,χ,hc,hcomp,hχ,hs,htrans,f,heq⟩ := exists_actualHeatSource_density hk hh hhk ht
  obtain ⟨A,V,hA,hV,hholder⟩ := actualHeatSource_density_holder hk hh hhk
    hD hDt hc hcomp hχ hs htrans f heq
  have ha : 0 < 2*t-D/2 := by linarith
  obtain ⟨_,htrace⟩ := actualHeatTheta_localized_representation (T := 2*t+D/4)
    hk hh hhk ha hD (by linarith) hc hcomp hs htrans f
    (fun s hst => heq s ⟨hst.1,by linarith [hst.2]⟩)
  have hg : ContinuousAt (fun s : ℝ => (canonicalLogBoundary k h (s/2),s)) (2*t) :=
    (canonicalHeatGraph_hasDerivAt hk hh hhk (by positivity : 0 < 2*t)).continuousAt.prodMk
      continuousAt_id
  have hχ' : χ =ᶠ[𝓝 (canonicalLogBoundary k h ((2*t)/2),2*t)] 1 := by
    simpa only [mul_div_cancel_left₀ _ (by norm_num : (2 : ℝ) ≠ 0)] using hχ
  have hnear : ∀ᶠ s in 𝓝 (2*t), χ =ᶠ[𝓝 (canonicalLogBoundary k h (s/2),s)] 1 :=
    hg.preimage_mem_nhds (eventually_eventually_nhds.mpr hχ')
  have he : ∀ᶠ s in 𝓝 (2*t), canonicalHeatThetaRightFlux k h s = f.1 s := by
    filter_upwards [hnear,Ioo_mem_nhds (by linarith : 2*t-D/2 < 2*t)
      (by linarith : 2*t < 2*t+D/4)] with s hχs hst
    have hd := htrace s hst.1 hst.2.le
    have he' : (fun x => canonicalHeatTheta k h (x,s)) =ᶠ[𝓝 (canonicalLogBoundary k h (s/2))]
        (fun x => χ (x,s)*canonicalHeatTheta k h (x,s)) := by
      filter_upwards [(show ContinuousAt (fun x : ℝ => (x,s)) (canonicalLogBoundary k h (s/2)) by
        fun_prop).preimage_mem_nhds hχs] with x hx
      change χ (x,s) = 1 at hx
      rw [hx,one_mul]
    exact (hd.congr_of_eventuallyEq (nhdsWithin_le_nhds he') he'.self_of_nhds).derivWithin
      (uniqueDiffWithinAt_Ici _)
  refine ⟨A,V ∩ {s | canonicalHeatThetaRightFlux k h s = f.1 s},hA,inter_mem hV he,?_⟩
  intro s₁ hs₁ s₂ hs₂ hst
  rw [hs₂.2,hs₁.2]
  exact hholder s₁ hs₁.1 s₂ hs₂.1 hst

theorem zeroDividend_canonicalHeatThetaRightFlux_holder {k t : ℝ}
    (hk : 0 < k) (ht : 0 < t) :
    ∃ (A : ℝ) (U : Set ℝ), 0 ≤ A ∧ U ∈ 𝓝 (2*t) ∧ ∀ s₁ ∈ U, ∀ s₂ ∈ U, s₁ < s₂ →
      ‖canonicalHeatThetaRightFlux k 0 s₂-canonicalHeatThetaRightFlux k 0 s₁‖ ≤
        A*Real.sqrt (s₂-s₁) :=
  canonicalHeatThetaRightFlux_holder hk le_rfl hk.le ht

theorem liuRange_canonicalHeatThetaRightFlux_holder {k h t : ℝ}
    (hh : 0 ≤ h) (hliu : h+1 ≤ k) (ht : 0 < t) :
    ∃ (A : ℝ) (U : Set ℝ), 0 ≤ A ∧ U ∈ 𝓝 (2*t) ∧ ∀ s₁ ∈ U, ∀ s₂ ∈ U, s₁ < s₂ →
      ‖canonicalHeatThetaRightFlux k h s₂-canonicalHeatThetaRightFlux k h s₁‖ ≤
        A*Real.sqrt (s₂-s₁) :=
  canonicalHeatThetaRightFlux_holder (by linarith) hh (by linarith) ht

end AmericanPutConvexity.Stopping
