import AmericanConvexity.Boundary.NeumannHalfLine

/-! # Bounded Dirichlet uniqueness on a continuous moving half-line

A quadratic barrier justifies truncation without assuming decay at infinity.
The terminal time is included; no derivative of the moving boundary is used.
-/

namespace AmericanConvexity.Boundary

open Set Filter
open scoped Topology ContDiff

theorem strict_dirichlet_heat_maximum {u : ℝ → ℝ → ℝ} {b : ℝ → ℝ} {a T R κ : ℝ}
    (hκ : 0 ≤ κ) (hQ : IsCompact (movingStrip b R a T)) (hb : ContinuousOn b (Icc a T))
    (hu : ContinuousOn (fun z : ℝ × ℝ => u z.1 z.2) (movingStrip b R a T))
    (htd : ∀ x t, a < t → t ≤ T → b t < x → x < R → DifferentiableAt ℝ (u x) t)
    (hpde : ∀ x t, a < t → t ≤ T → b t < x → x < R →
      deriv (u x) t < κ*deriv (deriv (fun y => u y t)) x)
    (hinitial : ∀ x, b a ≤ x → x ≤ R → u x a ≤ 0)
    (hleft : ∀ t, a ≤ t → t ≤ T → u (b t) t ≤ 0)
    (hright : ∀ t, a ≤ t → t ≤ T → u R t ≤ 0) :
    ∀ z ∈ movingStrip b R a T, u z.1 z.2 ≤ 0 := by
  intro z hz
  by_contra hn
  have hzpos : 0 < u z.1 z.2 := lt_of_not_ge hn
  obtain ⟨w,hw,hmax⟩ := hQ.exists_isMaxOn ⟨z,hz⟩ hu
  have hwpos : 0 < u w.1 w.2 := hzpos.trans_le (hmax hz)
  obtain ⟨hwa,hwT,hwb,hwR⟩ := hw
  have hat : a < w.2 := lt_of_le_of_ne hwa (by
    intro he
    have hh := hinitial w.1 (by simpa [← he] using hwb) hwR
    have : u w.1 w.2 ≤ 0 := by simpa [he] using hh
    linarith)
  have hbx : b w.2 < w.1 := lt_of_le_of_ne hwb (by
    intro he; have := hleft w.2 hwa hwT; rw [he] at this; linarith)
  have hxR : w.1 < R := lt_of_le_of_ne hwR (by
    intro he; have := hright w.2 hwa hwT; rw [← he] at this; linarith)
  have hspace : ∀ᶠ y in 𝓝 w.1, (y,w.2) ∈ movingStrip b R a T := by
    filter_upwards [Ioo_mem_nhds hbx hxR] with y hy
    exact ⟨hwa,hwT,hy.1.le,hy.2.le⟩
  have hmspace : IsLocalMax (fun y => u y w.2) w.1 := by
    filter_upwards [hspace] with y hy using hmax hy
  have hcspace : ContinuousAt (fun y => u y w.2) w.1 :=
    Tendsto.comp (hu w ⟨hwa,hwT,hwb,hwR⟩) (tendsto_nhdsWithin_iff.mpr
      ⟨continuousAt_id.prodMk continuousAt_const,hspace⟩)
  have hbcont := hb w.2 ⟨hwa,hwT⟩
  have htime : ∀ᶠ s in 𝓝[<] w.2, (w.1,s) ∈ movingStrip b R a T := by
    have hi : ∀ᶠ s in 𝓝[<] w.2, s ∈ Icc a T := by
      filter_upwards [nhdsWithin_le_nhds (Ioi_mem_nhds hat),self_mem_nhdsWithin] with s hs hs'
      exact ⟨hs.le,(show s < w.2 from hs').le.trans hwT⟩
    have hbsmall : ∀ᶠ s in 𝓝[<] w.2, b s < w.1 :=
      (hbcont.mono_left (le_inf nhdsWithin_le_nhds (le_principal_iff.mpr hi))).eventually (Iio_mem_nhds hbx)
    filter_upwards [hi,hbsmall] with s hs hbs
    exact ⟨hs.1,hs.2,hbs.le,hwR⟩
  have hmt : ∀ᶠ s in 𝓝[<] w.2, u w.1 s ≤ u w.1 w.2 := by
    filter_upwards [htime] with s hs using hmax hs
  have hdt := deriv_nonneg_at_left_max (htd w.1 w.2 hat hwT hbx hxR) hmt
  have hdxx := mul_nonpos_of_nonneg_of_nonpos hκ (second_deriv_nonpos_at_local_max hmspace hcspace)
  have hineq := hpde w.1 w.2 hat hwT hbx hxR
  linarith

theorem bounded_dirichlet_heat_maximum {u : ℝ → ℝ → ℝ} {b : ℝ → ℝ} {a T κ C : ℝ}
    (hκ : 0 ≤ κ) (hb : ContinuousOn b (Icc a T))
    (hu : ContinuousOn (fun z : ℝ × ℝ => u z.1 z.2) (movingHalfStrip b a T))
    (hbound : ∀ z ∈ movingHalfStrip b a T, u z.1 z.2 ≤ C)
    (hxs : ∀ x t, a < t → t ≤ T → b t < x → ContDiffAt ℝ 2 (fun y => u y t) x)
    (htd : ∀ x t, a < t → t ≤ T → b t < x → DifferentiableAt ℝ (u x) t)
    (hpde : ∀ x t, a < t → t ≤ T → b t < x →
      deriv (u x) t ≤ κ*deriv (deriv (fun y => u y t)) x)
    (hinitial : ∀ x, b a ≤ x → u x a ≤ 0)
    (hleft : ∀ t, a ≤ t → t ≤ T → u (b t) t ≤ 0) :
    ∀ z ∈ movingHalfStrip b a T, u z.1 z.2 ≤ 0 := by
  intro z hz
  by_contra hn
  have hzpos : 0 < u z.1 z.2 := lt_of_not_ge hn
  have hCpos : 0 < C := hzpos.trans_le (hbound z hz)
  have haT : a ≤ T := hz.1.trans hz.2.1
  obtain ⟨tM,htM,hmax⟩ := isCompact_Icc.exists_isMaxOn (nonempty_Icc.mpr haT) hb
  let H := b tM+1
  have hH (t : ℝ) (ht : t ∈ Icc a T) : b t < H := by
    have hh := hmax ht
    change b t ≤ b tM at hh
    dsimp [H]
    linarith
  let P := neumannQuadraticBarrier H κ a
  let ε := u z.1 z.2/(2*P z.1 z.2)
  have hPz : 0 < P z.1 z.2 := neumannQuadraticBarrier_pos hκ hz.1
  have hε : 0 < ε := div_pos hzpos (by positivity)
  let R := max (z.1+1) (H+C/ε+1)
  have hzR : z.1 < R := (lt_add_one _).trans_le (le_max_left _ _)
  have hRH : H < R := by
    have hh : H+C/ε+1 ≤ R := le_max_right _ _
    have hq : 0 < C/ε := div_pos hCpos hε
    linarith
  have hR (t : ℝ) (ht : t ∈ Icc a T) : b t ≤ R := (hH t ht).le.trans hRH.le
  have hRkill : C ≤ ε*(R-H)^2 := by
    have hq : 0 ≤ C/ε := (div_pos hCpos hε).le
    have hh : C/ε+1 ≤ R-H := by
      have := le_max_right (z.1+1) (H+C/ε+1); dsimp [R]; linarith
    have hs := mul_self_le_mul_self (by linarith : 0 ≤ C/ε+1) hh
    have hs' : C/ε ≤ (R-H)^2 := by nlinarith [sq_nonneg (C/ε)]
    have hh' := mul_le_mul_of_nonneg_left hs' hε.le
    have he : ε*(C/ε) = C := by field_simp
    rwa [he] at hh'
  let v := fun x t => u x t-ε*P x t
  have hsub : movingStrip b R a T ⊆ movingHalfStrip b a T :=
    fun _ hz => ⟨hz.1,hz.2.1,hz.2.2.1⟩
  have hv : ContinuousOn (fun w : ℝ × ℝ => v w.1 w.2) (movingStrip b R a T) :=
    (hu.mono hsub).sub (show ContinuousOn (fun w : ℝ × ℝ => ε*P w.1 w.2) _ by
      dsimp [P,neumannQuadraticBarrier]; fun_prop)
  have hdt (x t : ℝ) (hat : a < t) (htT : t ≤ T) (hbx : b t < x) :
      HasDerivAt (v x) (deriv (u x) t-ε*(2*κ+1)) t :=
    (htd x t hat htT hbx).hasDerivAt.sub ((neumannQuadraticBarrier_time H κ a x t).const_mul ε)
  have hdx (x t : ℝ) (hat : a < t) (htT : t ≤ T) (hbx : b t < x) :
      HasDerivAt (fun y => v y t) (deriv (fun y => u y t) x-ε*(2*(x-H))) x :=
    ((hxs x t hat htT hbx).differentiableAt (by norm_num)).hasDerivAt.sub
      ((neumannQuadraticBarrier_space H κ a x t).const_mul ε)
  have hdxx (x t : ℝ) (hat : a < t) (htT : t ≤ T) (hbx : b t < x) :
      deriv (deriv (fun y => v y t)) x = deriv (deriv (fun y => u y t)) x-2*ε := by
    have he : deriv (fun y => v y t) =ᶠ[𝓝 x]
        (fun y => deriv (fun w => u w t) y-ε*(2*(y-H))) := by
      filter_upwards [Ioi_mem_nhds hbx] with y hy using (hdx y t hat htT hy).deriv
    have hdu : ContDiffAt ℝ 1 (deriv (fun y => u y t)) x :=
      (hxs x t hat htT hbx).derivWithin (by norm_num)
    have hdlin : HasDerivAt (fun y => ε*(2*(y-H))) (2*ε) x := by
      convert! (((hasDerivAt_id x).sub_const H).const_mul 2).const_mul ε using 1
      ring
    rw [he.deriv_eq]
    exact ((hdu.differentiableAt (by norm_num)).hasDerivAt.sub hdlin).deriv
  have hstrict (x t : ℝ) (hat : a < t) (htT : t ≤ T) (hbx : b t < x) (_ : x < R) :
      deriv (v x) t < κ*deriv (deriv (fun y => v y t)) x := by
    rw [(hdt x t hat htT hbx).deriv,hdxx x t hat htT hbx]
    have hh := hpde x t hat htT hbx
    nlinarith
  have hvnonpos := strict_dirichlet_heat_maximum hκ (movingStrip_isCompact hb hR) hb hv
    (fun x t hat htT hbx _ => (hdt x t hat htT hbx).differentiableAt) hstrict
    (fun x hbx _ => by
      have hi := hinitial x hbx
      have hp := neumannQuadraticBarrier_pos (H := H) (x := x) hκ (le_refl a)
      dsimp [v,P]
      nlinarith)
    (fun t hat htT => by
      have hl := hleft t hat htT
      have hp := neumannQuadraticBarrier_pos (H := H) (x := b t) hκ hat
      dsimp [v,P]
      nlinarith)
    (fun t hat htT => by
      have hub := hbound (R,t) ⟨hat,htT,hR t ⟨hat,htT⟩⟩
      have htime : 0 ≤ (2*κ+1)*(t-a) := mul_nonneg (by linarith) (sub_nonneg.mpr hat)
      dsimp [v,P,neumannQuadraticBarrier]
      nlinarith)
    z ⟨hz.1,hz.2.1,hz.2.2,hzR.le⟩
  have he : ε*P z.1 z.2 = u z.1 z.2/2 := by dsimp [ε]; field_simp
  change u z.1 z.2-ε*P z.1 z.2 ≤ 0 at hvnonpos
  rw [he] at hvnonpos
  linarith

theorem bounded_dirichlet_heat_zero {u : ℝ → ℝ → ℝ} {b : ℝ → ℝ} {a T κ C : ℝ}
    (hκ : 0 ≤ κ) (hb : ContinuousOn b (Icc a T))
    (hu : ContinuousOn (fun z : ℝ × ℝ => u z.1 z.2) (movingHalfStrip b a T))
    (hbound : ∀ z ∈ movingHalfStrip b a T, ‖u z.1 z.2‖ ≤ C)
    (hxs : ∀ x t, a < t → t ≤ T → b t < x → ContDiffAt ℝ 2 (fun y => u y t) x)
    (htd : ∀ x t, a < t → t ≤ T → b t < x → DifferentiableAt ℝ (u x) t)
    (hpde : ∀ x t, a < t → t ≤ T → b t < x →
      deriv (u x) t = κ*deriv (deriv (fun y => u y t)) x)
    (hinitial : ∀ x, b a ≤ x → u x a = 0)
    (hleft : ∀ t, a ≤ t → t ≤ T → u (b t) t = 0) :
    ∀ z ∈ movingHalfStrip b a T, u z.1 z.2 = 0 := by
  have hp := bounded_dirichlet_heat_maximum hκ hb hu
    (fun z hz => (le_abs_self _).trans (by simpa only [Real.norm_eq_abs] using hbound z hz))
    hxs htd (fun x t ha ht hx => (hpde x t ha ht hx).le)
    (fun x hx => (hinitial x hx).le) (fun t ha ht => (hleft t ha ht).le)
  have hn := bounded_dirichlet_heat_maximum (u := fun x t => -u x t) hκ hb hu.neg
    (fun z hz => by
      have hh := hbound z hz
      rw [Real.norm_eq_abs,abs_le] at hh
      linarith [hh.1])
    (fun x t ha ht hx => (hxs x t ha ht hx).neg)
    (fun x t ha ht hx => (htd x t ha ht hx).neg)
    (fun x t ha ht hx => by
      have hh := hpde x t ha ht hx
      simp only [deriv.fun_neg']
      linarith)
    (fun x hx => by rw [hinitial x hx,neg_zero])
    (fun t ha ht => by rw [hleft t ha ht,neg_zero])
  intro z hz
  exact le_antisymm (hp z hz) (neg_nonpos.mp (hn z hz))

end AmericanConvexity.Boundary
