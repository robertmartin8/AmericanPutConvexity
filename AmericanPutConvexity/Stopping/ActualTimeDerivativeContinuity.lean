import AmericanPutConvexity.Stopping.ActualTemporalTraceBound

/-! # Joint continuity of the actual time derivative at contact

The uniform linear continuation-side estimate squeezes the time derivative
to zero as space-time approaches contact. On the exercise side it is zero.
This is a genuine joint trace, not merely differentiability at a fixed point.
-/

namespace AmericanPutConvexity.Stopping

open Set Filter Boundary
open scoped Topology

theorem canonicalPrice_time_deriv_exercise {k h x t : ℝ} (hk : 0 < k)
    (hh : 0 ≤ h) (hhk : h ≤ k) (ht : 0 < t) (hx : x ≤ canonicalLogBoundary k h t) :
    deriv (canonicalPrice k h x) t = 0 := by
  rcases hx.eq_or_lt with hx | hx
  · rw [hx]
    exact canonicalPrice_time_deriv_contact hk hh hhk ht
  · have hb := canonicalLogBoundary_continuousAt hk hh hhk ht.le
    have hnear : ∀ᶠ s in 𝓝 t, x < canonicalLogBoundary k h s :=
      hb.eventually (Ioi_mem_nhds hx)
    have he : canonicalPrice k h x =ᶠ[𝓝 t] (fun _ => 1-Real.exp x) := by
      filter_upwards [hnear,Ioi_mem_nhds ht] with s hs hs0
      exact canonicalPrice_exercise_value hk hh hhk hs0 hs.le
    simpa only [deriv_const] using he.deriv_eq

theorem canonicalPrice_time_deriv_continuousAt_contact {k h t : ℝ} (hk : 0 < k)
    (hh : 0 ≤ h) (hhk : h ≤ k) (ht : 0 < t) :
    ContinuousAt (fun z : ℝ × ℝ => deriv (canonicalPrice k h z.1) z.2)
      (canonicalLogBoundary k h t,t) := by
  obtain ⟨η,N,hη,hN,hbound⟩ := canonicalPrice_time_deriv_linear_near_boundary hk hh hhk ht
  have hb : ContinuousAt (fun z : ℝ × ℝ => canonicalLogBoundary k h z.2)
      (canonicalLogBoundary k h t,t) := by
    have hb0 := canonicalLogBoundary_continuousAt hk hh hhk ht.le
    exact hb0.comp (x := (canonicalLogBoundary k h t,t))
      (f := fun z : ℝ × ℝ => z.2) continuousAt_snd
  have hmajor : ContinuousAt (fun z : ℝ × ℝ => N*max 0 (z.1-canonicalLogBoundary k h z.2))
      (canonicalLogBoundary k h t,t) :=
    continuousAt_const.mul (continuousAt_const.max (continuousAt_fst.sub hb))
  have hlim : Tendsto (fun z : ℝ × ℝ => N*max 0 (z.1-canonicalLogBoundary k h z.2))
      (𝓝 (canonicalLogBoundary k h t,t)) (𝓝 0) := by
    simpa only [sub_self,max_self,mul_zero] using hmajor.tendsto
  have hupper : ∀ᶠ z : ℝ × ℝ in 𝓝 (canonicalLogBoundary k h t,t),
      deriv (canonicalPrice k h z.1) z.2 ≤ N*max 0 (z.1-canonicalLogBoundary k h z.2) := by
    filter_upwards [continuousAt_snd.preimage_mem_nhds (Metric.ball_mem_nhds t hη),
      continuousAt_fst.preimage_mem_nhds (Iio_mem_nhds (canonicalLogBoundary_neg hk hh hhk ht))]
      with z hz hz0
    obtain ⟨hs0,hsbound⟩ := hbound z.2 hz
    rcases le_or_gt z.1 (canonicalLogBoundary k h z.2) with hx | hx
    · rw [canonicalPrice_time_deriv_exercise hk hh hhk hs0 hx]
      exact mul_nonneg hN.le (le_max_left _ _)
    · exact (hsbound z.1 ⟨hx.le,hz0.le⟩).2.trans
        (mul_le_mul_of_nonneg_left (le_max_right _ _) hN.le)
  have hzero := squeeze_zero' (Filter.Eventually.of_forall
    (fun z : ℝ × ℝ => canonicalPrice_time_deriv_nonneg hk.le z.1 z.2)) hupper hlim
  change Tendsto _ _ _
  simpa only [canonicalPrice_time_deriv_contact hk hh hhk ht] using hzero

theorem zeroDividend_canonicalPrice_time_deriv_continuousAt_contact {k t : ℝ}
    (hk : 0 < k) (ht : 0 < t) :
    ContinuousAt (fun z : ℝ × ℝ => deriv (canonicalPrice k 0 z.1) z.2)
      (canonicalLogBoundary k 0 t,t) :=
  canonicalPrice_time_deriv_continuousAt_contact hk le_rfl hk.le ht

theorem liuRange_canonicalPrice_time_deriv_continuousAt_contact {k h t : ℝ}
    (hh : 0 ≤ h) (hliu : h+1 ≤ k) (ht : 0 < t) :
    ContinuousAt (fun z : ℝ × ℝ => deriv (canonicalPrice k h z.1) z.2)
      (canonicalLogBoundary k h t,t) :=
  canonicalPrice_time_deriv_continuousAt_contact (by linarith) hh (by linarith) ht

end AmericanPutConvexity.Stopping
