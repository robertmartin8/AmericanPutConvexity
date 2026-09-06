import AmericanPutConvexity.Stopping.HeatHistoryOperator
import AmericanPutConvexity.Stopping.HeatBoundaryEquation

/-! # Observation-time estimates for the moving-boundary history kernel

In original source time s the kernel is H(t-s,b(t)-b(s)). Differentiating
in t holds both b(s) and the density at s fixed. Uniform bounds for b' and
the graph displacement yield a (t-s)^(-3/2) derivative bound. This is the
far-from-diagonal half of the time-regularity estimate; the diagonal uses
the already integrable (t-s)^(-1/2) size bound.
-/

namespace AmericanPutConvexity.Stopping

open Set Filter MeasureTheory
open MathFin.FeynmanKacHeatEquation
open scoped Topology

theorem heatBoundaryKernel_scaling_derivative {u : ℝ} (hu : 0 < u) (x : ℝ) :
    deriv (fun v => heatBoundaryKernel v x) u =
      -heatBoundaryKernel u x/u-(x/(2*u))*deriv (heatBoundaryKernel u) x := by
  rw [(heatBoundaryKernel_hasDeriv_time hu x).deriv,(heatBoundaryKernel_hasDeriv_space hu x).deriv]
  unfold heatBoundaryKernel
  field_simp
  ring

theorem heatBoundaryKernel_motion_bound {u L x : ℝ}
    (hu : 0 < u) (hx : ‖x‖ ≤ L*u) :
    ‖heatBoundaryKernel u x‖ ≤ 3*L/Real.sqrt (2*Real.pi*u) := by
  have he := heatBoundaryKernel_sub_bound hu 0 x
  have hzero : heatBoundaryKernel u 0 = 0 := by simp [heatBoundaryKernel]
  rw [hzero,sub_zero,sub_zero] at he
  calc
    _ ≤ (3/(u*Real.sqrt (2*Real.pi*u)))*(L*u) :=
      he.trans (mul_le_mul_of_nonneg_left hx (by positivity))
    _ = _ := by field_simp

theorem heatBoundaryKernel_time_deriv_motion_bound {u L x : ℝ}
    (hu : 0 < u) (hL : 0 ≤ L) (hx : ‖x‖ ≤ L*u) :
    ‖deriv (fun v => heatBoundaryKernel v x) u‖ ≤ 5*L/(u*Real.sqrt (2*Real.pi*u)) := by
  have hs : 0 < Real.sqrt (2*Real.pi*u) := Real.sqrt_pos.mpr (by positivity)
  rw [heatBoundaryKernel_scaling_derivative hu x]
  calc
    _ ≤ ‖-heatBoundaryKernel u x/u‖+‖(x/(2*u))*deriv (heatBoundaryKernel u) x‖ := norm_sub_le _ _
    _ = ‖heatBoundaryKernel u x‖/u+(‖x‖/(2*u))*‖deriv (heatBoundaryKernel u) x‖ := by
      rw [norm_div,norm_neg,norm_mul,norm_div,Real.norm_of_nonneg hu.le,
        Real.norm_of_nonneg (by positivity : 0 ≤ 2*u)]
    _ ≤ (3*L/Real.sqrt (2*Real.pi*u))/u+
        ((L*u)/(2*u))*(3/(u*Real.sqrt (2*Real.pi*u))) := by
      apply add_le_add
      · exact div_le_div_of_nonneg_right (heatBoundaryKernel_motion_bound hu hx) hu.le
      · exact mul_le_mul (div_le_div_of_nonneg_right hx (by positivity))
          (heatBoundaryKernel_deriv_bound hu x) (norm_nonneg _) (by positivity)
    _ ≤ 5*L/(u*Real.sqrt (2*Real.pi*u)) := by
      field_simp
      nlinarith

noncomputable def movingHeatHistoryKernel (b : ℝ → ℝ) (t s : ℝ) : ℝ :=
  heatBoundaryKernel (t-s) (b t-b s)

theorem movingHeatHistoryKernel_hasDerivAt {b : ℝ → ℝ} {t s v : ℝ}
    (hts : s < t) (hb : HasDerivAt b v t) :
    HasDerivAt (fun r => movingHeatHistoryKernel b r s)
      (deriv (fun u => heatBoundaryKernel u (b t-b s)) (t-s)+
        v*deriv (heatBoundaryKernel (t-s)) (b t-b s)) t := by
  let F := fun z : ℝ × ℝ => heatBoundaryKernel z.1 z.2
  have hd : DifferentiableAt ℝ F (t-s,b t-b s) :=
    (heatBoundaryKernel_smoothAt (sub_pos.mpr hts)).differentiableAt (by simp)
  have hcurve := hd.hasFDerivAt.comp_hasDerivAt t
    (((hasDerivAt_id t).sub_const s).prodMk (hb.sub_const (b s)))
  have hv : ((1,v) : ℝ × ℝ) = (1,0)+v • ((0,1) : ℝ × ℝ) := by ext <;> simp
  have he : fderiv ℝ F (t-s,b t-b s) (1,v) =
      deriv (fun u => heatBoundaryKernel u (b t-b s)) (t-s)+
        v*deriv (heatBoundaryKernel (t-s)) (b t-b s) := by
    rw [hv,map_add,map_smul]
    rw [(heatPartial_time hd).deriv,(heatPartial_space hd).deriv]
    rfl
  simpa only [Function.comp_def,he] using! hcurve

theorem movingHeatHistoryKernel_deriv_bound {b : ℝ → ℝ} {t s v L : ℝ}
    (hts : s < t) (hL : 0 ≤ L) (hb : HasDerivAt b v t)
    (hv : ‖v‖ ≤ L) (hmove : ‖b t-b s‖ ≤ L*(t-s)) :
    ‖deriv (fun r => movingHeatHistoryKernel b r s) t‖ ≤
      8*L/((t-s)*Real.sqrt (2*Real.pi*(t-s))) := by
  rw [(movingHeatHistoryKernel_hasDerivAt hts hb).deriv]
  calc
    _ ≤ ‖deriv (fun u => heatBoundaryKernel u (b t-b s)) (t-s)‖+
        ‖v*deriv (heatBoundaryKernel (t-s)) (b t-b s)‖ := norm_add_le _ _
    _ ≤ 5*L/((t-s)*Real.sqrt (2*Real.pi*(t-s)))+
        L*(3/((t-s)*Real.sqrt (2*Real.pi*(t-s)))) := by
      apply add_le_add (heatBoundaryKernel_time_deriv_motion_bound (sub_pos.mpr hts) hL hmove)
      rw [norm_mul]
      exact mul_le_mul hv (heatBoundaryKernel_deriv_bound (sub_pos.mpr hts) _) (norm_nonneg _) hL
    _ = _ := by ring

/-- A fixed positive distance from source time controls observation-time
increments. No derivative of the density is used or needed. -/
theorem movingHeatHistoryKernel_time_sub_bound {b : ℝ → ℝ} {s t₁ t₂ L : ℝ}
    (hst : s < t₁) (htt : t₁ ≤ t₂) (hL : 0 ≤ L)
    (hb : ∀ t ∈ Icc t₁ t₂, DifferentiableAt ℝ b t)
    (hv : ∀ t ∈ Icc t₁ t₂, ‖deriv b t‖ ≤ L)
    (hmove : ∀ t ∈ Icc t₁ t₂, ‖b t-b s‖ ≤ L*(t-s)) :
    ‖movingHeatHistoryKernel b t₂ s-movingHeatHistoryKernel b t₁ s‖ ≤
      (8*L/((t₁-s)*Real.sqrt (2*Real.pi*(t₁-s))))*(t₂-t₁) := by
  have hderiv (t : ℝ) (ht : t ∈ Icc t₁ t₂) :
      ‖deriv (fun r => movingHeatHistoryKernel b r s) t‖ ≤
        8*L/((t₁-s)*Real.sqrt (2*Real.pi*(t₁-s))) := by
    apply (movingHeatHistoryKernel_deriv_bound (hst.trans_le ht.1) hL (hb t ht).hasDerivAt
      (hv t ht) (hmove t ht)).trans
    apply div_le_div_of_nonneg_left (by positivity) (by positivity)
    apply mul_le_mul (by linarith [ht.1] : t₁-s ≤ t-s)
      (Real.sqrt_le_sqrt (mul_le_mul_of_nonneg_left (by linarith [ht.1]) (by positivity)))
      (Real.sqrt_nonneg _) (by linarith [ht.1])
  have he := (convex_Icc t₁ t₂).norm_image_sub_le_of_norm_deriv_le
    (fun t ht => (movingHeatHistoryKernel_hasDerivAt (hst.trans_le ht.1) (hb t ht).hasDerivAt).differentiableAt)
    hderiv (left_mem_Icc.mpr htt) (right_mem_Icc.mpr htt)
  simpa only [Real.norm_of_nonneg (sub_nonneg.mpr htt)] using he

end AmericanPutConvexity.Stopping
