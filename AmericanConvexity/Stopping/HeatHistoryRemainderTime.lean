import AmericanConvexity.Stopping.HeatHistoryRemainderDerivative

/-! # Time increments of the density-weighted frozen-line remainder

The source value and both reference parameters remain fixed as observation
time varies. A derivative bound proportional to inverse elapsed time gives
the far-from-diagonal part of the improved history modulus.
-/

namespace AmericanConvexity.Stopping

open Set

theorem heatBoundaryMotionDerivative_linear_bound {u v L : ℝ}
    (hu : 0 < u) (hL : 0 ≤ L) (hv : ‖v‖ ≤ L) :
    ‖heatBoundaryMotionDerivative u (v*u) v‖ ≤
      8*L/(u*Real.sqrt (2*Real.pi*u)) := by
  have hm : ‖v*u‖ ≤ L*u := by
    rw [norm_mul,Real.norm_of_nonneg hu.le]
    exact mul_le_mul_of_nonneg_right hv hu.le
  have hd := movingHeatHistoryKernel_hasDerivAt_motion (s := 0) hu ((hasDerivAt_id u).const_mul v)
  have he := movingHeatHistoryKernel_deriv_bound (s := 0) hu hL ((hasDerivAt_id u).const_mul v)
    (by simpa only [mul_one] using hv) (by simpa only [id_eq,mul_zero,sub_zero] using hm)
  rw [hd.deriv] at he
  simpa only [id_eq,mul_one,mul_zero,sub_zero] using he

noncomputable def frozenHeatHistoryRemainder (b f : ℝ → ℝ) (v c t s : ℝ) : ℝ :=
  movingHeatHistoryKernel b t s*f s-heatBoundaryKernel (t-s) (v*(t-s))*c

theorem frozenHeatHistoryRemainder_hasDerivAt {b f : ℝ → ℝ} {t s w v c : ℝ}
    (hst : s < t) (hb : HasDerivAt b w t) :
    HasDerivAt (fun r => frozenHeatHistoryRemainder b f v c r s)
      (heatBoundaryMotionDerivative (t-s) (b t-b s) w*f s-
        heatBoundaryMotionDerivative (t-s) (v*(t-s)) v*c) t :=
  ((movingHeatHistoryKernel_hasDerivAt_motion hst hb).mul_const (f s)).sub
    ((linearHeatHistoryKernel_hasDerivAt hst).mul_const c)

theorem frozenHeatHistoryRemainder_deriv_bound {b f : ℝ → ℝ} {t s w v c A L C D : ℝ}
    (hst : s < t) (hu1 : t-s ≤ 1) (hA : 0 ≤ A) (hL : 0 ≤ L)
    (hb : HasDerivAt b w t) (hx : ‖b t-b s‖ ≤ L*(t-s)) (hv : ‖v‖ ≤ L)
    (hrem : ‖b t-b s-v*(t-s)‖ ≤ A*(t-s)*Real.sqrt (t-s))
    (hw : ‖w-v‖ ≤ A*Real.sqrt (t-s)) (hfs : ‖f s‖ ≤ C)
    (hmod : ‖f s-c‖ ≤ D*Real.sqrt (t-s)) :
    ‖deriv (fun r => frozenHeatHistoryRemainder b f v c r s) t‖ ≤
      ((8+5*L^2)*A*C+8*L*D)/(Real.sqrt (2*Real.pi)*(t-s)) := by
  have hu := sub_pos.mpr hst
  have hs : 0 < Real.sqrt (t-s) := Real.sqrt_pos.mpr hu
  have hp : 0 < Real.sqrt (2*Real.pi) := Real.sqrt_pos.mpr (by positivity)
  have hR := heatBoundaryMotionDerivative_linear_remainder_bound hu hu1 hA hL hx hv hrem hw
  have hK := heatBoundaryMotionDerivative_linear_bound hu hL hv
  rw [(frozenHeatHistoryRemainder_hasDerivAt hst hb).deriv]
  calc
    _ = ‖(heatBoundaryMotionDerivative (t-s) (b t-b s) w-
        heatBoundaryMotionDerivative (t-s) (v*(t-s)) v)*f s+
        heatBoundaryMotionDerivative (t-s) (v*(t-s)) v*(f s-c)‖ := by congr 1; ring
    _ ≤ ‖(heatBoundaryMotionDerivative (t-s) (b t-b s) w-
        heatBoundaryMotionDerivative (t-s) (v*(t-s)) v)*f s‖+
        ‖heatBoundaryMotionDerivative (t-s) (v*(t-s)) v*(f s-c)‖ := norm_add_le _ _
    _ ≤ (((8+5*L^2)*A)/(Real.sqrt (2*Real.pi)*(t-s)))*C+
        (8*L/((t-s)*Real.sqrt (2*Real.pi*(t-s))))*(D*Real.sqrt (t-s)) := by
      rw [norm_mul,norm_mul]
      exact add_le_add (mul_le_mul hR hfs (norm_nonneg _) (by positivity))
        (mul_le_mul hK hmod (norm_nonneg _) (by positivity))
    _ = _ := by
      rw [Real.sqrt_mul (by positivity : 0 ≤ 2*Real.pi)]
      field_simp

theorem frozenHeatHistoryRemainder_time_sub_bound
    {b f : ℝ → ℝ} {s t₁ t₂ v c A L C D : ℝ}
    (hst : s < t₁) (htt : t₁ ≤ t₂) (hu1 : t₂-s ≤ 1)
    (hA : 0 ≤ A) (hL : 0 ≤ L) (hD : 0 ≤ D)
    (hb : ∀ t ∈ Icc t₁ t₂, DifferentiableAt ℝ b t)
    (hx : ∀ t ∈ Icc t₁ t₂, ‖b t-b s‖ ≤ L*(t-s)) (hv : ‖v‖ ≤ L)
    (hrem : ∀ t ∈ Icc t₁ t₂, ‖b t-b s-v*(t-s)‖ ≤ A*(t-s)*Real.sqrt (t-s))
    (hw : ∀ t ∈ Icc t₁ t₂, ‖deriv b t-v‖ ≤ A*Real.sqrt (t-s))
    (hfs : ‖f s‖ ≤ C) (hmod : ‖f s-c‖ ≤ D*Real.sqrt (t₁-s)) :
    ‖frozenHeatHistoryRemainder b f v c t₂ s-frozenHeatHistoryRemainder b f v c t₁ s‖ ≤
      (((8+5*L^2)*A*C+8*L*D)/(Real.sqrt (2*Real.pi)*(t₁-s)))*(t₂-t₁) := by
  have hC : 0 ≤ C := (norm_nonneg _).trans hfs
  have hbound (t : ℝ) (ht : t ∈ Icc t₁ t₂) :
      ‖deriv (fun r => frozenHeatHistoryRemainder b f v c r s) t‖ ≤
        ((8+5*L^2)*A*C+8*L*D)/(Real.sqrt (2*Real.pi)*(t₁-s)) := by
    apply (frozenHeatHistoryRemainder_deriv_bound (hst.trans_le ht.1)
      (by linarith [ht.2]) hA hL (hb t ht).hasDerivAt (hx t ht) hv
      (hrem t ht) (hw t ht) hfs
      (hmod.trans (mul_le_mul_of_nonneg_left (Real.sqrt_le_sqrt (by linarith [ht.1])) hD))).trans
    apply div_le_div_of_nonneg_left (by positivity) (by positivity)
    exact mul_le_mul_of_nonneg_left (by linarith [ht.1]) (Real.sqrt_nonneg _)
  have he := (convex_Icc t₁ t₂).norm_image_sub_le_of_norm_deriv_le
    (fun t ht => (frozenHeatHistoryRemainder_hasDerivAt (hst.trans_le ht.1) (hb t ht).hasDerivAt).differentiableAt)
    hbound (left_mem_Icc.mpr htt) (right_mem_Icc.mpr htt)
  simpa only [Real.norm_of_nonneg (sub_nonneg.mpr htt)] using he

theorem frozenHeatHistoryRemainder_source_continuousOn
    {b f : ℝ → ℝ} {t r T v c : ℝ} (htr : t ≤ r)
    (hb : ContinuousOn b (Ioo (t-T) t)) (hf : ContinuousOn f (Ioo (t-T) t)) :
    ContinuousOn (fun u => frozenHeatHistoryRemainder b f v c r (t-u)) (Ioo 0 T) := by
  intro u hu
  have hsrc : t-u ∈ Ioo (t-T) t := ⟨by linarith [hu.2],by linarith [hu.1]⟩
  have helapsed : 0 < r-(t-u) := by linarith [hu.1]
  have hbc : ContinuousAt (fun z => b (t-z)) u :=
    ((hb _ hsrc).continuousAt (isOpen_Ioo.mem_nhds hsrc)).comp
      (x := u) (f := fun z : ℝ => t-z) (by fun_prop)
  have hfc : ContinuousAt (fun z => f (t-z)) u :=
    ((hf _ hsrc).continuousAt (isOpen_Ioo.mem_nhds hsrc)).comp
      (x := u) (f := fun z : ℝ => t-z) (by fun_prop)
  have hK : ContinuousAt (fun z => heatBoundaryKernel (r-(t-z)) (b r-b (t-z))) u :=
    (heatBoundaryKernel_smoothAt helapsed).continuousAt.comp
      (x := u) (f := fun z : ℝ => (r-(t-z),b r-b (t-z)))
      ((show ContinuousAt (fun z : ℝ => r-(t-z)) u by fun_prop).prodMk (continuousAt_const.sub hbc))
  have hLin : ContinuousAt (fun z => heatBoundaryKernel (r-(t-z)) (v*(r-(t-z)))) u :=
    (heatBoundaryKernel_smoothAt helapsed).continuousAt.comp
      (x := u) (f := fun z : ℝ => (r-(t-z),v*(r-(t-z)))) (by fun_prop)
  exact ((hK.mul hfc).sub (hLin.mul continuousAt_const)).continuousWithinAt

end AmericanConvexity.Stopping
