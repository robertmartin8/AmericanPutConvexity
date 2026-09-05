import AmericanConvexity.Stopping.ActualHeatRepresentation

/-! # A constructed continuous right normal flux for actual heat theta

The density is obtained from the already-proved causal integral equation,
then identified as the derivative of localized actual theta. Where the cutoff
is one it is the derivative of actual theta itself. Continuity is inherited
from the constructed density, not postulated as a boundary trace condition.
-/

namespace AmericanConvexity.Stopping

open Set Filter Boundary
open scoped Topology ContDiff BoundedContinuousFunction

theorem exists_canonicalHeatTheta_continuous_right_flux {k h t : ℝ}
    (hk : 0 < k) (hh : 0 ≤ h) (hhk : h ≤ k) (ht : 0 < t) :
    ∃ F : ℝ → ℝ, Continuous F ∧ ∀ᶠ s in 𝓝 (2*t),
      HasDerivWithinAt (fun x => canonicalHeatTheta k h (x,s)) (F s)
        (Ici (canonicalLogBoundary k h (s/2))) (canonicalLogBoundary k h (s/2)) := by
  obtain ⟨D,hD,hDt,χ,hc,hcomp,hχ,hs,htrans,f,heq⟩ := exists_actualHeatSource_density hk hh hhk ht
  have ha : 0 < 2*t-D/2 := by linarith
  obtain ⟨_,htrace⟩ := actualHeatTheta_localized_representation (T := 2*t+D/4)
    hk hh hhk ha hD (by linarith) hc hcomp hs htrans f
    (fun s hst => heq s ⟨hst.1,by linarith [hst.2]⟩)
  have hg : ContinuousAt (fun s : ℝ => (canonicalLogBoundary k h (s/2),s)) (2*t) := by
    have hb : ContinuousAt (fun s : ℝ => canonicalLogBoundary k h (s/2)) (2*t) :=
      (canonicalLogBoundary_continuousAt hk hh hhk (by positivity : 0 ≤ (2*t)/2)).comp
      (x := 2*t) (f := fun s : ℝ => s/2) (by fun_prop)
    exact hb.prodMk continuousAt_id
  have hχ' : χ =ᶠ[𝓝 (canonicalLogBoundary k h ((2*t)/2),2*t)] 1 := by
    simpa only [mul_div_cancel_left₀ _ (by norm_num : (2 : ℝ) ≠ 0)] using hχ
  have hnear : ∀ᶠ s in 𝓝 (2*t), χ =ᶠ[𝓝 (canonicalLogBoundary k h (s/2),s)] 1 :=
    hg.preimage_mem_nhds (eventually_eventually_nhds.mpr hχ')
  refine ⟨f.1,f.1.continuous,?_⟩
  filter_upwards [hnear,Ioo_mem_nhds (by linarith : 2*t-D/2 < 2*t)
    (by linarith : 2*t < 2*t+D/4)] with s hχs hst
  have hd := htrace s hst.1 hst.2.le
  have he : (fun x => canonicalHeatTheta k h (x,s)) =ᶠ[𝓝 (canonicalLogBoundary k h (s/2))]
      (fun x => χ (x,s)*canonicalHeatTheta k h (x,s)) := by
    filter_upwards [(show ContinuousAt (fun x : ℝ => (x,s)) (canonicalLogBoundary k h (s/2)) by
      fun_prop).preimage_mem_nhds hχs] with x hx
    change χ (x,s) = 1 at hx
    rw [hx,one_mul]
  exact hd.congr_of_eventuallyEq (nhdsWithin_le_nhds he) he.self_of_nhds

theorem canonicalHeatTheta_has_right_flux {k h s : ℝ}
    (hk : 0 < k) (hh : 0 ≤ h) (hhk : h ≤ k) (hs : 0 < s) :
    ∃ v : ℝ, HasDerivWithinAt (fun x => canonicalHeatTheta k h (x,s)) v
      (Ici (canonicalLogBoundary k h (s/2))) (canonicalLogBoundary k h (s/2)) := by
  obtain ⟨F,_,hF⟩ := exists_canonicalHeatTheta_continuous_right_flux hk hh hhk (half_pos hs)
  have he := hF.self_of_nhds
  rw [show 2*(s/2) = s by ring] at he
  exact ⟨F s,he⟩

theorem zeroDividend_exists_canonicalHeatTheta_continuous_right_flux {k t : ℝ}
    (hk : 0 < k) (ht : 0 < t) :
    ∃ F : ℝ → ℝ, Continuous F ∧ ∀ᶠ s in 𝓝 (2*t),
      HasDerivWithinAt (fun x => canonicalHeatTheta k 0 (x,s)) (F s)
        (Ici (canonicalLogBoundary k 0 (s/2))) (canonicalLogBoundary k 0 (s/2)) :=
  exists_canonicalHeatTheta_continuous_right_flux hk le_rfl hk.le ht

theorem liuRange_exists_canonicalHeatTheta_continuous_right_flux {k h t : ℝ}
    (hh : 0 ≤ h) (hliu : h+1 ≤ k) (ht : 0 < t) :
    ∃ F : ℝ → ℝ, Continuous F ∧ ∀ᶠ s in 𝓝 (2*t),
      HasDerivWithinAt (fun x => canonicalHeatTheta k h (x,s)) (F s)
        (Ici (canonicalLogBoundary k h (s/2))) (canonicalLogBoundary k h (s/2)) :=
  exists_canonicalHeatTheta_continuous_right_flux (by linarith) hh (by linarith) ht

end AmericanConvexity.Stopping
