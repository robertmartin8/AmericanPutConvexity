import AmericanPutConvexity.Stopping.ActualDensityC1

/-! # C1 regularity of the intrinsic actual heat flux

The localized layer density agrees with the intrinsic one-sided spatial flux
on an open time neighborhood. Its ordinary C1 regularity therefore transfers
to the actual flux, with no assumed derivative of that flux.
-/

namespace AmericanPutConvexity.Stopping

open Set Filter Boundary
open scoped Topology ContDiff BoundedContinuousFunction

theorem canonicalHeatThetaRightFlux_contDiffAt_one {k h t : ℝ}
    (hk : 0 < k) (hh : 0 ≤ h) (hhk : h ≤ k) (ht : 0 < t) :
    ContDiffAt ℝ 1 (canonicalHeatThetaRightFlux k h) (2*t) := by
  obtain ⟨D,hD,hDt,χ,hc,hcomp,hχ,hs,htrans,f,heq⟩ := exists_actualHeatSource_density hk hh hhk ht
  have hd := actualHeatSource_density_contDiffAt_one hk hh hhk hD hDt hc hcomp hχ hs htrans f heq
  have ha : 0 < 2*t-D/2 := by linarith
  obtain ⟨_,htrace⟩ := actualHeatTheta_localized_representation (T := 2*t+D/4)
    hk hh hhk ha hD (by linarith) hc hcomp hs htrans f
    (fun s hst => heq s ⟨hst.1,by linarith [hst.2]⟩)
  have hg : ContinuousAt (fun s : ℝ => (canonicalLogBoundary k h (s/2),s)) (2*t) :=
    (canonicalHeatGraph_hasDerivAt hk hh hhk (by positivity : 0 < 2*t)).continuousAt.prodMk continuousAt_id
  have hχ' : χ =ᶠ[𝓝 (canonicalLogBoundary k h ((2*t)/2),2*t)] 1 := by
    simpa only [mul_div_cancel_left₀ _ (by norm_num : (2 : ℝ) ≠ 0)] using hχ
  have hnear : ∀ᶠ s in 𝓝 (2*t), χ =ᶠ[𝓝 (canonicalLogBoundary k h (s/2),s)] 1 :=
    hg.preimage_mem_nhds (eventually_eventually_nhds.mpr hχ')
  have he : canonicalHeatThetaRightFlux k h =ᶠ[𝓝 (2*t)] f.1 := by
    filter_upwards [hnear,Ioo_mem_nhds (by linarith : 2*t-D/2 < 2*t)
      (by linarith : 2*t < 2*t+D/4)] with s hχs hst
    have hd' := htrace s hst.1 hst.2.le
    have he' : (fun x => canonicalHeatTheta k h (x,s)) =ᶠ[𝓝 (canonicalLogBoundary k h (s/2))]
        (fun x => χ (x,s)*canonicalHeatTheta k h (x,s)) := by
      filter_upwards [(show ContinuousAt (fun x : ℝ => (x,s)) (canonicalLogBoundary k h (s/2)) by
        fun_prop).preimage_mem_nhds hχs] with x hx
      change χ (x,s) = 1 at hx
      rw [hx,one_mul]
    exact (hd'.congr_of_eventuallyEq (nhdsWithin_le_nhds he') he'.self_of_nhds).derivWithin
      (uniqueDiffWithinAt_Ici _)
  exact hd.congr_of_eventuallyEq he

theorem canonicalHeatThetaRightFlux_contDiffOn_one {k h : ℝ}
    (hk : 0 < k) (hh : 0 ≤ h) (hhk : h ≤ k) :
    ContDiffOn ℝ 1 (canonicalHeatThetaRightFlux k h) (Ioi 0) := by
  intro s hs
  have hc := canonicalHeatThetaRightFlux_contDiffAt_one hk hh hhk (half_pos hs)
  rw [mul_div_cancel₀ s (by norm_num : (2 : ℝ) ≠ 0)] at hc
  exact hc.contDiffWithinAt

theorem zeroDividend_canonicalHeatThetaRightFlux_contDiffOn_one {k : ℝ} (hk : 0 < k) :
    ContDiffOn ℝ 1 (canonicalHeatThetaRightFlux k 0) (Ioi 0) :=
  canonicalHeatThetaRightFlux_contDiffOn_one hk le_rfl hk.le

theorem liuRange_canonicalHeatThetaRightFlux_contDiffOn_one {k h : ℝ}
    (hh : 0 ≤ h) (hliu : h+1 ≤ k) :
    ContDiffOn ℝ 1 (canonicalHeatThetaRightFlux k h) (Ioi 0) :=
  canonicalHeatThetaRightFlux_contDiffOn_one (by linarith) hh (by linarith)

end AmericanPutConvexity.Stopping
