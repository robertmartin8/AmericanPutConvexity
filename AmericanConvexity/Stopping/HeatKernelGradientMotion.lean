import AmericanConvexity.Stopping.HeatHistoryTimeKernel

/-! # Spatial gradient variation of the heat boundary kernel on moving graphs

The heat equation converts the existing time-derivative bound into a second
spatial derivative bound. On a displacement interval of size O(u), this
controls variation of the spatial kernel gradient without a new Gaussian
moment estimate.
-/

namespace AmericanConvexity.Stopping

open Set

theorem heatBoundaryKernel_second_deriv_motion_bound {u L x : ℝ}
    (hu : 0 < u) (hL : 0 ≤ L) (hx : ‖x‖ ≤ L*u) :
    ‖deriv (deriv (heatBoundaryKernel u)) x‖ ≤
      10*L/(u*Real.sqrt (2*Real.pi*u)) := by
  have he : deriv (deriv (heatBoundaryKernel u)) x =
      2*deriv (fun s => heatBoundaryKernel s x) u := by
    rw [heatBoundaryKernel_equation hu x]
    ring
  rw [he,norm_mul,Real.norm_of_nonneg (by norm_num : (0 : ℝ) ≤ 2)]
  convert! mul_le_mul_of_nonneg_left (heatBoundaryKernel_time_deriv_motion_bound hu hL hx)
    (by norm_num : (0 : ℝ) ≤ 2) using 1
  ring

theorem heatBoundaryKernel_gradient_sub_motion_bound {u L x y : ℝ}
    (hu : 0 < u) (hL : 0 ≤ L) (hx : ‖x‖ ≤ L*u) (hy : ‖y‖ ≤ L*u) :
    ‖deriv (heatBoundaryKernel u) x-deriv (heatBoundaryKernel u) y‖ ≤
      (10*L/(u*Real.sqrt (2*Real.pi*u)))*‖x-y‖ := by
  have hxm : x ∈ Icc (-(L*u)) (L*u) := abs_le.mp hx
  have hym : y ∈ Icc (-(L*u)) (L*u) := abs_le.mp hy
  exact (convex_Icc (-(L*u)) (L*u)).norm_image_sub_le_of_norm_deriv_le
    (fun z _ => (heatBoundaryKernel_hasDeriv_space2 hu z).differentiableAt)
    (fun z hz => heatBoundaryKernel_second_deriv_motion_bound hu hL (abs_le.mpr hz)) hym hxm

end AmericanConvexity.Stopping
