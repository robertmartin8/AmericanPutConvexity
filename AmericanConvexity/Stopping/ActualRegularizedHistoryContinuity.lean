import AmericanConvexity.Stopping.ActualFrozenDerivative
import AmericanConvexity.Stopping.MovingEndpointContinuity
import AmericanConvexity.Stopping.RegularizedHistoryDerivative

/-! # Continuous regularized history-rate formula on the actual graph

The actual velocity and density moduli yield a single integrable majorant
for nearby observations. Dominated convergence handles the varying upper
elapsed-time endpoint. Identification of this continuous formula with the
intrinsic right derivative throughout a neighborhood is a separate step.
-/

namespace AmericanConvexity.Stopping

open Set Filter MeasureTheory
open scoped Topology

noncomputable def regularizedHistoryRate (b f : ℝ → ℝ) (a t : ℝ) : ℝ :=
  (∫ u in Ioo 0 (t-a), regularizedHistoryDerivative b f t u)+
    heatBoundaryKernel (t-a) (deriv b t*(t-a))*f t

theorem canonicalRegularizedHistoryRate_continuousAt {k h t C : ℝ} {f : ℝ → ℝ}
    (hk : 0 < k) (hh : 0 ≤ h) (hhk : h ≤ k) (ht : 0 < t)
    (hf : Continuous f) (hCf : ∀ s, ‖f s‖ ≤ C) (hm : LocalThreeQuarterHolderAt f t) :
    ∃ a : ℝ, 0 < a ∧ a < t ∧
      ContinuousAt (regularizedHistoryRate (fun s => canonicalLogBoundary k h (s/2)) f a) t := by
  obtain ⟨A,l,u,hA,hl,htU,_,hrem⟩ := exists_canonicalHeatGraph_threeQuarter_window hk hh hhk ht
  obtain ⟨L,hL,hv,hmove⟩ := exists_canonicalHeatGraph_C1_window_bound (T := u) hk hh hhk hl
  obtain ⟨D,V,hD,hV,hmod⟩ := hm
  obtain ⟨ρ,hρ,hρ1,hsub⟩ := exists_short_closed_window (inter_mem hV (Ioo_mem_nhds htU.1 htU.2))
  let E := ρ/2
  let a := t-ρ/4
  let W := Ioo (t-ρ/8) (t+ρ/8)
  have hE : 0 < E := half_pos hρ
  have hE1 : E ≤ 1 := by dsimp [E]; linarith
  have hW : W ∈ 𝓝 t := Ioo_mem_nhds (by linarith) (by linarith)
  have ha : 0 < a := by
    have he := (hsub (show t-ρ ∈ Icc (t-ρ) (t+ρ) by constructor <;> linarith)).2.1
    dsimp [a]
    linarith
  have hat : a < t := by dsimp [a]; linarith
  have hw (r : ℝ) (hr : r ∈ W) : r ∈ Icc (t-ρ) (t+ρ) := by
    have hr' : t-ρ/8 < r ∧ r < t+ρ/8 := hr
    constructor <;> linarith [hr'.1,hr'.2]
  have hs (r z : ℝ) (hr : r ∈ W) (hz : z ∈ Ioo 0 E) : r-z ∈ Icc (t-ρ) (t+ρ) := by
    have hr' : t-ρ/8 < r ∧ r < t+ρ/8 := hr
    have hz' : 0 < z ∧ z < ρ/2 := hz
    constructor <;> linarith [hr'.1,hr'.2,hz'.1,hz'.2]
  have hU : Icc (t-ρ) (t+ρ) ⊆ Ioo l u := fun _ hz => (hsub hz).2
  have hI (z : ℝ) (hz : z ∈ Icc (t-ρ) (t+ρ)) : z ∈ Icc l u :=
    ⟨(hU hz).1.le,(hU hz).2.le⟩
  have hC : 0 ≤ C := (norm_nonneg (f t)).trans (hCf t)
  let M := ((8+5*L^2)*A*C+8*L*D)/Real.sqrt (2*Real.pi)
  have hM : 0 ≤ M := by dsimp [M]; positivity
  have hbound (r : ℝ) (hr : r ∈ W) (z : ℝ) (hz : z ∈ Ioo 0 E) :
      ‖regularizedHistoryDerivative (fun s => canonicalLogBoundary k h (s/2)) f r z‖ ≤ M*z^(-3/4 : ℝ) := by
    have hbr := (canonicalHeatGraph_hasDerivAt hk hh hhk (hl.trans (hU (hw r hr)).1)).differentiableAt
    apply regularizedHistoryDerivative_threeQuarter_bound hz.1 (hz.2.le.trans hE1) hA hL hbr
      (by
        have he := hmove (r-z) (hI _ (hs r z hr hz)) r (hI _ (hw r hr)) (by linarith [hz.1])
        simpa only [sub_sub_cancel] using he)
      (hv r (hI _ (hw r hr)))
      (by
        have he := hrem (r-z) (hU (hs r z hr hz)) r (hU (hw r hr))
          (by linarith [hz.1]) r ⟨by linarith [hz.1],le_rfl⟩
        simpa only [sub_sub_cancel] using he) (hCf (r-z))
    rw [norm_sub_rev]
    have he := hmod (r-z) (hsub (hs r z hr hz)).1 r (hsub (hw r hr)).1 (by linarith [hz.1])
    simpa only [sub_sub_cancel] using he
  have hsource (r : ℝ) (hr : r ∈ W) :
      ContinuousOn (regularizedHistoryDerivative (fun s => canonicalLogBoundary k h (s/2)) f r) (Ioo 0 E) := by
    apply regularizedHistoryDerivative_source_continuousOn
      (canonicalHeatGraph_hasDerivAt hk hh hhk (hl.trans (hU (hw r hr)).1)).differentiableAt _ hf.continuousOn
    intro s hst
    have hpos : 0 < s := by
      have he := hl.trans (hU (hs r (r-s) hr ⟨by linarith [hst.2],by linarith [hst.1]⟩)).1
      simpa only [sub_sub_cancel] using he
    exact (canonicalHeatGraph_hasDerivAt hk hh hhk hpos).continuousAt.continuousWithinAt
  have htime (z : ℝ) (hz : z ∈ Ioo 0 E) :
      ContinuousAt (fun r => regularizedHistoryDerivative (fun s => canonicalLogBoundary k h (s/2)) f r z) t := by
    have htW : t ∈ W := ⟨by linarith,by linarith⟩
    exact regularizedHistoryDerivative_continuousAt_time hz.1
      (canonicalHeatGraph_hasDerivAt hk hh hhk ht).continuousAt
      (canonicalHeatGraph_hasDerivAt hk hh hhk (hl.trans (hU (hs t z htW hz)).1)).continuousAt
      (canonicalHeatGraph_deriv_continuousAt hk hh hhk ht) hf.continuousAt hf.continuousAt
  have hint := integral_Ioo_moving_right_continuousAt hE hM hW
    (show ContinuousAt (fun r : ℝ => r-a) t by fun_prop)
    (by dsimp [a,E]; linarith : t-a < E) hsource htime hbound
  have hgap : ContinuousAt (fun r : ℝ => r-a) t := by fun_prop
  have hvel := canonicalHeatGraph_deriv_continuousAt hk hh hhk ht
  have href := ((heatBoundaryKernel_smoothAt (x := deriv (fun s => canonicalLogBoundary k h (s/2)) t*(t-a))
    (sub_pos.mpr hat)).continuousAt.comp (x := t)
      (f := fun r : ℝ => (r-a,deriv (fun s => canonicalLogBoundary k h (s/2)) r*(r-a)))
      (hgap.prodMk (hvel.mul hgap))).mul hf.continuousAt
  exact ⟨a,ha,hat,hint.add href⟩

theorem zeroDividend_canonicalRegularizedHistoryRate_continuousAt {k t C : ℝ} {f : ℝ → ℝ}
    (hk : 0 < k) (ht : 0 < t) (hf : Continuous f) (hCf : ∀ s, ‖f s‖ ≤ C)
    (hm : LocalThreeQuarterHolderAt f t) :
    ∃ a : ℝ, 0 < a ∧ a < t ∧
      ContinuousAt (regularizedHistoryRate (fun s => canonicalLogBoundary k 0 (s/2)) f a) t :=
  canonicalRegularizedHistoryRate_continuousAt hk le_rfl hk.le ht hf hCf hm

theorem liuRange_canonicalRegularizedHistoryRate_continuousAt {k h t C : ℝ} {f : ℝ → ℝ}
    (hh : 0 ≤ h) (hliu : h+1 ≤ k) (ht : 0 < t) (hf : Continuous f) (hCf : ∀ s, ‖f s‖ ≤ C)
    (hm : LocalThreeQuarterHolderAt f t) :
    ∃ a : ℝ, 0 < a ∧ a < t ∧
      ContinuousAt (regularizedHistoryRate (fun s => canonicalLogBoundary k h (s/2)) f a) t :=
  canonicalRegularizedHistoryRate_continuousAt (by linarith) hh (by linarith) ht hf hCf hm

end AmericanConvexity.Stopping
