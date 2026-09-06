# Semantic dependency spine: first review packet

Source snapshot: `61e3cf5483353229962626c9a94ad5a0d4dd8bb3`.
Extracted from current project source; no Lean source changes or new build/replay.
Excerpts below retain complete declaration bodies, with source links and line numbers.
They are review excerpts, not a standalone compilable Lean module: imports,
namespaces, local variables, and open/scoped commands remain in the linked files.

## Scope

This packet starts with the exact first layer requested, then includes the object
definitions, physical normalization, and a selected expansion of the analytic
interval branch. It is **not a recursively closed dependency trace**. The remaining
frontier below is explicit: omitted project lemmas have not been relabeled as
Mathlib facts or external PDE assumptions.

```text
BoundedRule + putReward
  -> exerciseValues -> americanPutValue
  -> exerciseSet -> exerciseThreshold
  -> brownianUsualExerciseBoundary
  -> canonicalStockBoundary (strike 1, volatility sqrt 2)
  -> canonicalLogBoundary (Real.log)

canonicalPrice (the same normalized stopping value)
  -> canonicalPrice_continuousBoundaryPutSolution [proved structure fields]
  -> spatial comparison superlevel intervals
  -> no-return contact
  -> below-line time intervals
  + boundary negativity, monotonicity, near-expiry bound
  -> canonicalLogBoundary_convexOn

physical stopping price <-> normalized stopping price [grid normalization + limits]
  -> physical boundary = K * canonicalStockBoundary
  -> physical logarithmic-boundary normalization
```

The geometric helper assumes a line-interval property. The main theorem
discharges it with `canonicalLogBoundary_below_line_time_interval`; it is not
an extra hypothesis on the final theorem. Conversely, the contract
`ContinuousBoundaryPutSolution` does contain analytic hypotheses, so the
construction `canonicalPrice_continuousBoundaryPutSolution` is included.

Parameter conventions: `k = 2*r/σ^2`, `h = 2*q/σ^2`, and normalized
time `t = σ^2*τ/2`. The normalized result assumes `0 < k` and
`0 ≤ h ≤ k`, not Liu's stronger `h+1 ≤ k`.
On positive times, `toNNReal` does not change the time value.
The price supremum is over stopping times, not merely deterministic
times or a selected family of hitting times.

## Remaining review frontier

These are genuine project-specific supporting nodes, not claimed audited leaves:

- **Elementary geometry:** `boundaryRatio_monotone_of_line_intervals` and
  `convexOn_of_ratio_monotone_and_line_intervals` in
  [LineIntervalConvexity.lean](/Users/robert/dev/AmericanConvexity/AmericanConvexity/Boundary/LineIntervalConvexity.lean).
- **Contact barrier and future positivity:** `no_contact_of_past_line_below_and_terminal_positive`
  in [Tangency.lean](/Users/robert/dev/AmericanConvexity/AmericanConvexity/Boundary/Tangency.lean)
  and `straightDifference_positive_at_earlier_time` in
  [ComparisonMaximum.lean](/Users/robert/dev/AmericanConvexity/AmericanConvexity/Boundary/ComparisonMaximum.lean).
  The former's interval hypothesis is supplied by the spatial comparison theorem.
- **Comparison formulas and initial shape:** `normalizedDifference_initial_superlevel`
  in [ComparisonShape.lean](/Users/robert/dev/AmericanConvexity/AmericanConvexity/Boundary/ComparisonShape.lean),
  and the equation, regularity, and tail lemmas referenced in
  `straightDifference_three_point_bound`.
- **Near expiry:** `canonicalLogBoundary_exists_sqrt_upper_bound` in
  [ActualNearExpiry.lean](/Users/robert/dev/AmericanConvexity/AmericanConvexity/Stopping/ActualNearExpiry.lean).
  Lean uses an explicit subsolution barrier, not the manuscript's European-put
  asymptotic. Both give the same below-every-linear-function premise.
- **Actual-price PDE and boundary traces:** the named field proofs in
  `canonicalPrice_continuousBoundaryPutSolution`, especially
  `canonicalPrice_continuation_pde`, `canonicalPrice_contDiffOn`,
  `canonicalPrice_smooth_fit`, and `canonicalPrice_gradient_trace`.
  The structure is not itself evidence that those fields follow from the
  stopping value; the displayed constructor shows the supporting theorem names.
- **Nondegeneracy and monotonicity:** `canonicalStockBoundary_pos`,
  `canonicalStockBoundary_lt_one`, and `canonicalStockBoundary_antitone`.
  They ensure the logarithm is of a positive exercise threshold.
- **Normalization:** `brownianGridPrice_normalization`,
  `brownianGridPrice_tendsto_usual`, and
  `brownianGridPrice_tendsto_usual_of_mesh`, explicitly used below.
- **Smoothing calculus:** inequalities and derivative lemmas in
  [SmoothValley.lean](/Users/robert/dev/AmericanConvexity/AmericanConvexity/Boundary/SmoothValley.lean)
  and the ordered-triple compactness and elementary local-extremum lemmas used
  by `parabolic_smoothValley_nonpos`.

Two manuscript distinctions worth keeping visible: the geometric theorem gives
nonstrict logarithmic convexity (not strict logarithmic curvature), and Lean's
near-expiry argument differs from the paper's. Neither changes the parameter
range or the stopping object.


## 1. Requested first layer: root and its five direct project-specific callees

### canonicalLogBoundary_convexOn

[Stopping/ActualLogConvexity.lean:18](/Users/robert/dev/AmericanConvexity/AmericanConvexity/Stopping/ActualLogConvexity.lean:18)

```lean
theorem canonicalLogBoundary_convexOn {k h : ℝ} (hk : 0 < k)
    (hh : 0 ≤ h) (hhk : h ≤ k) : ConvexOn ℝ (Ioi 0) (canonicalLogBoundary k h) := by
  apply convexOn_of_negative_line_intervals
    (fun _ ht => canonicalLogBoundary_neg hk hh hhk ht)
    ((canonicalLogBoundary_antitoneOn hk hh hhk).mono (Ioi_subset_Ici_self))
  · intro c T _ hT
    have hnear := canonicalLogBoundary_below_linear_eventually hk hh hhk c
    have hpos : ∀ᶠ t : ℝ in 𝓝[>] 0, 0 < t := self_mem_nhdsWithin
    have hless : ∀ᶠ t : ℝ in 𝓝[>] 0, t < T := nhdsWithin_le_nhds (Iio_mem_nhds hT)
    exact (hpos.and (hless.and hnear)).exists
  · intro c d hc hd
    exact canonicalLogBoundary_below_line_time_interval hk hh hhk hc hd
```

### convexOn_of_negative_line_intervals

[Boundary/LineIntervalConvexity.lean:90](/Users/robert/dev/AmericanConvexity/AmericanConvexity/Boundary/LineIntervalConvexity.lean:90)

```lean
theorem convexOn_of_negative_line_intervals {b : ℝ → ℝ}
    (hneg : ∀ t, 0 < t → b t < 0) (hanti : AntitoneOn b (Ioi 0))
    (hnear : ∀ c T : ℝ, 0 < c → 0 < T → ∃ v, 0 < v ∧ v < T ∧ b v < -c*v)
    (hline : ∀ c d : ℝ, 0 < c → d ≤ 0 → OrdConnected {t | 0 < t ∧ b t < d-c*t}) :
    ConvexOn ℝ (Ioi 0) b :=
  convexOn_of_ratio_monotone_and_line_intervals hanti
    (boundaryRatio_monotone_of_line_intervals hneg hnear hline) hline
```

### canonicalLogBoundary_neg

[Stopping/PositiveExerciseBoundary.lean:96](/Users/robert/dev/AmericanConvexity/AmericanConvexity/Stopping/PositiveExerciseBoundary.lean:96)

```lean
theorem canonicalLogBoundary_neg {k h t : ℝ} (hk : 0 < k)
    (hh : 0 ≤ h) (hhk : h ≤ k) (ht : 0 < t) : canonicalLogBoundary k h t < 0 :=
  Real.log_neg (canonicalStockBoundary_pos hk hh hhk ht.le) (canonicalStockBoundary_lt_one hk.le ht)
```

### canonicalLogBoundary_antitoneOn

[Stopping/ActualBoundaryContinuity.lean:85](/Users/robert/dev/AmericanConvexity/AmericanConvexity/Stopping/ActualBoundaryContinuity.lean:85)

```lean
theorem canonicalLogBoundary_antitoneOn {k h : ℝ} (hk : 0 < k)
    (hh : 0 ≤ h) (hhk : h ≤ k) :
    AntitoneOn (canonicalLogBoundary k h) (Ici 0) := by
  intro s hs t ht hst
  exact Real.log_le_log (canonicalStockBoundary_pos hk hh hhk ht)
    (canonicalStockBoundary_antitone hk.le hst)
```

### canonicalLogBoundary_below_linear_eventually

[Stopping/ActualNearExpiry.lean:80](/Users/robert/dev/AmericanConvexity/AmericanConvexity/Stopping/ActualNearExpiry.lean:80)

```lean
theorem canonicalLogBoundary_below_linear_eventually {k h : ℝ} (hk : 0 < k)
    (hh : 0 ≤ h) (hhk : h ≤ k) (M : ℝ) :
    ∀ᶠ t in 𝓝[>] (0 : ℝ), canonicalLogBoundary k h t < -M*t := by
  obtain ⟨T,hT,hbound⟩ := canonicalLogBoundary_exists_sqrt_upper_bound hk hh hhk
  have hc : Continuous (fun t : ℝ => 64*M*Real.sqrt t) := by fun_prop
  have he : ∀ᶠ t in 𝓝[>] (0 : ℝ), 64*M*Real.sqrt t < 1 :=
    nhdsWithin_le_nhds (hc.continuousAt.eventually (Iio_mem_nhds (by norm_num)))
  filter_upwards [he,nhdsWithin_le_nhds (Iio_mem_nhds hT),self_mem_nhdsWithin] with t hsm htT ht
  have ht0 : 0 < t := ht
  have hs := Real.sqrt_pos.mpr ht0
  have hm := mul_lt_mul_of_pos_right hsm hs
  have hs2 := Real.sq_sqrt ht0.le
  have hMt : M*t < Real.sqrt t/64 := by
    nlinarith [congrArg (fun y : ℝ => M*y) hs2]
  exact (hbound t ht0 htT.le).trans (by linarith)
```

### canonicalLogBoundary_below_line_time_interval

[Stopping/ActualComparisonIntervals.lean:66](/Users/robert/dev/AmericanConvexity/AmericanConvexity/Stopping/ActualComparisonIntervals.lean:66)

```lean
theorem canonicalLogBoundary_below_line_time_interval {k h c d : ℝ}
    (hk : 0 < k) (hh : 0 ≤ h) (hhk : h ≤ k) (hc : 0 < c) (hd : d ≤ 0) :
    OrdConnected {t | 0 < t ∧ canonicalLogBoundary k h t < d-c*t} := by
  rw [ordConnected_iff]
  intro a ha U hU _ m hm
  refine ⟨ha.1.trans_le hm.1,?_⟩
  by_contra! hn
  let f : ℝ → ℝ := fun t => canonicalLogBoundary k h t-(d-c*t)
  have hf : ContinuousOn f (Icc a m) :=
    ((canonicalLogBoundary_continuousOn hk hh hhk).mono
      (fun t ht => ha.1.le.trans ht.1)).sub (by fun_prop)
  obtain ⟨T,haT,hTm,hzero,hpast⟩ := exists_first_nonnegative_contact hm.1 hf
    (show f a < 0 from sub_neg.mpr ha.2) (show 0 ≤ f m from sub_nonneg.mpr hn)
  have hmU : m < U := lt_of_le_of_ne hm.2 (by
    intro he
    rw [he] at hn
    exact not_le_of_gt hU.2 hn)
  apply canonicalLogBoundary_no_return_contact hk hh hhk hc hd ha.1 haT (hTm.trans_lt hmU)
    (sub_eq_zero.mp hzero) ?_ hU.2
  intro t ht
  exact sub_neg.mp (hpast t ht)
```


## 2. Object definitions: stopping value, exercise set, canonical objects

### BoundedRule

[Stopping/Rules.lean:18](/Users/robert/dev/AmericanConvexity/AmericanConvexity/Stopping/Rules.lean:18)

```lean
structure BoundedRule (𝓕 : Filtration ℝ≥0 ‹MeasurableSpace Ω›) (T : ℝ≥0) where
  time : Ω → ℝ≥0
  stopping : IsStoppingTime 𝓕 (fun ω => (time ω : WithTop ℝ≥0))
  le_horizon : ∀ ω, time ω ≤ T
```

### putReward

[Stopping/Reward.lean:20](/Users/robert/dev/AmericanConvexity/AmericanConvexity/Stopping/Reward.lean:20)

```lean
noncomputable def putReward (W : ℝ≥0 → Ω → ℝ) (K r q σ S : ℝ) (θ : Ω → ℝ≥0) (ω : Ω) : ℝ :=
  Real.exp (-r*(θ ω : ℝ))*max (K-MathFin.gbmValue S (r-q) σ (θ ω) (W (θ ω) ω)) 0
```

### exerciseValues

[Stopping/AmericanValue.lean:19](/Users/robert/dev/AmericanConvexity/AmericanConvexity/Stopping/AmericanValue.lean:19)

```lean
noncomputable def exerciseValues (P : Measure Ω) (𝓕 : Filtration ℝ≥0 ‹MeasurableSpace Ω›)
    (W : ℝ≥0 → Ω → ℝ) (K r q σ S : ℝ) (T : ℝ≥0) : Set ℝ :=
  range (fun θ : BoundedRule 𝓕 T => ∫ ω, putReward W K r q σ S θ.time ω ∂P)
```

### americanPutValue

[Stopping/AmericanValue.lean:23](/Users/robert/dev/AmericanConvexity/AmericanConvexity/Stopping/AmericanValue.lean:23)

```lean
noncomputable def americanPutValue (P : Measure Ω) (𝓕 : Filtration ℝ≥0 ‹MeasurableSpace Ω›)
    (W : ℝ≥0 → Ω → ℝ) (K r q σ S : ℝ) (T : ℝ≥0) : ℝ :=
  sSup (exerciseValues P 𝓕 W K r q σ S T)
```

### exerciseSet

[Stopping/ExerciseRegion.lean:21](/Users/robert/dev/AmericanConvexity/AmericanConvexity/Stopping/ExerciseRegion.lean:21)

```lean
noncomputable def exerciseSet (P : Measure Ω) (𝓕 : Filtration ℝ≥0 ‹MeasurableSpace Ω›)
    (W : ℝ≥0 → Ω → ℝ) (K r q σ : ℝ) (T : ℝ≥0) : Set ℝ :=
  {S | 0 ≤ S ∧ S ≤ K ∧ americanPutValue P 𝓕 W K r q σ S T = K-S}
```

### exerciseThreshold

[Stopping/ExerciseRegion.lean:25](/Users/robert/dev/AmericanConvexity/AmericanConvexity/Stopping/ExerciseRegion.lean:25)

```lean
noncomputable def exerciseThreshold (P : Measure Ω) (𝓕 : Filtration ℝ≥0 ‹MeasurableSpace Ω›)
    (W : ℝ≥0 → Ω → ℝ) (K r q σ : ℝ) (T : ℝ≥0) : ℝ :=
  sSup (exerciseSet P 𝓕 W K r q σ T)
```

### brownianUsualFiltration

[Stopping/UsualBrownianValue.lean:11](/Users/robert/dev/AmericanConvexity/AmericanConvexity/Stopping/UsualBrownianValue.lean:11)

```lean
noncomputable def brownianUsualFiltration :
    Filtration ℝ≥0 (completedMeasurableSpace gaussianLimit) :=
  (ambientNullAugmentation (mΩ := completedMeasurableSpace gaussianLimit)
    (completedAmbientFiltration gaussianLimit brownianFiltration)
    (completedMeasure gaussianLimit)).rightCont
```

### brownianUsualAmericanPut

[Stopping/UsualBrownianValue.lean:50](/Users/robert/dev/AmericanConvexity/AmericanConvexity/Stopping/UsualBrownianValue.lean:50)

```lean
noncomputable def brownianUsualAmericanPut (K r q σ S : ℝ) (T : ℝ≥0) : ℝ :=
  @americanPutValue (ℝ≥0 → ℝ) (completedMeasurableSpace gaussianLimit)
    (completedMeasure gaussianLimit) brownianUsualFiltration brownian K r q σ S T
```

### brownianUsualExerciseBoundary

[Stopping/UsualBrownianValue.lean:112](/Users/robert/dev/AmericanConvexity/AmericanConvexity/Stopping/UsualBrownianValue.lean:112)

```lean
noncomputable def brownianUsualExerciseBoundary (K r q σ : ℝ) (T : ℝ≥0) : ℝ :=
  @exerciseThreshold (ℝ≥0 → ℝ) (completedMeasurableSpace gaussianLimit)
    (completedMeasure gaussianLimit) brownianUsualFiltration brownian K r q σ T
```

### canonicalPrice

[Stopping/CanonicalPrice.lean:16](/Users/robert/dev/AmericanConvexity/AmericanConvexity/Stopping/CanonicalPrice.lean:16)

```lean
noncomputable def canonicalPrice (k h x t : ℝ) : ℝ :=
  brownianUsualAmericanPut 1 k h (Real.sqrt 2) (Real.exp x) t.toNNReal
```

### canonicalStockBoundary

[Stopping/StrictExerciseGeometry.lean:76](/Users/robert/dev/AmericanConvexity/AmericanConvexity/Stopping/StrictExerciseGeometry.lean:76)

```lean
noncomputable def canonicalStockBoundary (k h t : ℝ) : ℝ :=
  brownianUsualExerciseBoundary 1 k h (Real.sqrt 2) t.toNNReal
```

### canonicalLogBoundary

[Stopping/PositiveExerciseBoundary.lean:84](/Users/robert/dev/AmericanConvexity/AmericanConvexity/Stopping/PositiveExerciseBoundary.lean:84)

```lean
noncomputable def canonicalLogBoundary (k h t : ℝ) : ℝ :=
  Real.log (canonicalStockBoundary k h t)
```


## 3. Exact stopping-price and boundary normalization

### brownianUsualAmericanPut_normalization_log

[Stopping/ActualNormalization.lean:14](/Users/robert/dev/AmericanConvexity/AmericanConvexity/Stopping/ActualNormalization.lean:14)

```lean
theorem brownianUsualAmericanPut_normalization_log {K r q σ : ℝ}
    (hK : 0 < K) (hr : 0 ≤ r) (hσ : 0 < σ) (T : ℝ≥0) (x : ℝ) :
    brownianUsualAmericanPut K r q σ (Real.exp (x+Real.log K)) T =
      K*canonicalPrice (normalizedRate r σ) (normalizedRate q σ) x (σ^2/2*(T : ℝ)) := by
  let a := (σ^2/2).toNNReal
  have ha : 0 < a := Real.toNNReal_pos.mpr (by positivity)
  have hk : 0 ≤ normalizedRate r σ := by unfold normalizedRate; positivity
  have hleft := brownianGridPrice_tendsto_usual (q := q) (σ := σ) hK.le hr T (x+Real.log K)
  have hmesh : Tendsto (fun n => a*gridStep n) atTop (𝓝 0) := by
    simpa only [mul_zero] using (tendsto_const_nhds (x := a)).mul gridStep_tendsto_zero
  have hright := (tendsto_const_nhds (x := K)).mul
    (brownianGridPrice_tendsto_usual_of_mesh (q := normalizedRate q σ) (σ := Real.sqrt 2)
      (by norm_num : (0 : ℝ) ≤ 1) hk (a*T) x (fun n => mul_pos ha (gridStep_pos n)) hmesh)
  have hseq : (fun n => brownianGridPrice K r q σ T (gridStep n) (x+Real.log K)) =
      fun n => K*brownianGridPrice 1 (normalizedRate r σ) (normalizedRate q σ) (Real.sqrt 2)
        (a*T) (a*gridStep n) x :=
    funext (fun n => brownianGridPrice_normalization hK hσ T (gridStep n) x)
  rw [hseq] at hleft
  have htime : (σ^2/2*(T : ℝ)).toNNReal = a*T := by
    apply NNReal.coe_injective
    rw [Real.coe_toNNReal _ (by positivity),NNReal.coe_mul]
    simp only [a,Real.coe_toNNReal _ (by positivity : 0 ≤ σ^2/2)]
  simpa only [canonicalPrice,htime] using tendsto_nhds_unique hleft hright
```

### brownianUsualAmericanPut_normalization

[Stopping/ActualNormalization.lean:38](/Users/robert/dev/AmericanConvexity/AmericanConvexity/Stopping/ActualNormalization.lean:38)

```lean
theorem brownianUsualAmericanPut_normalization {K r q σ S : ℝ}
    (hK : 0 < K) (hr : 0 ≤ r) (hσ : 0 < σ) (hS : 0 < S) (T : ℝ≥0) :
    brownianUsualAmericanPut K r q σ S T =
      K*canonicalPrice (normalizedRate r σ) (normalizedRate q σ)
        (Real.log (S/K)) (σ^2/2*(T : ℝ)) := by
  have he : Real.exp (Real.log (S/K)+Real.log K) = S := by
    rw [Real.exp_add,Real.exp_log (div_pos hS hK),Real.exp_log hK,div_mul_cancel₀ _ hK.ne']
  simpa only [he] using brownianUsualAmericanPut_normalization_log hK hr hσ T (Real.log (S/K))
```

### brownianUsualExerciseBoundary_normalization

[Stopping/ActualBoundaryNormalization.lean:23](/Users/robert/dev/AmericanConvexity/AmericanConvexity/Stopping/ActualBoundaryNormalization.lean:23)

```lean
theorem brownianUsualExerciseBoundary_normalization {K r q σ : ℝ}
    (hK : 0 < K) (hr : 0 < r) (hq : 0 ≤ q) (hqr : q ≤ r) (hσ : 0 < σ)
    {τ : ℝ} (hτ : 0 < τ) :
    brownianUsualExerciseBoundary K r q σ τ.toNNReal =
      K*Real.exp (canonicalLogBoundary (normalizedRate r σ) (normalizedRate q σ) (σ^2/2*τ)) := by
  obtain ⟨hk,hh,hhk⟩ := normalized_rates_admissible hr hq hqr hσ
  let b := canonicalLogBoundary (normalizedRate r σ) (normalizedRate q σ)
  let B := K*Real.exp (b (σ^2/2*τ))
  have ht : 0 < σ^2/2*τ := by positivity
  have hBpos : 0 < B := mul_pos hK (Real.exp_pos _)
  have hBK : B ≤ K := by
    have he := mul_le_mul_of_nonneg_left
      (Real.exp_le_one_iff.mpr (canonicalLogBoundary_neg hk hh hhk ht).le) hK.le
    simpa only [mul_one] using he
  have hcontact (S : ℝ) (hS : 0 < S) :
      brownianUsualAmericanPut K r q σ S τ.toNNReal = max (K-S) 0 ↔ S ≤ B := by
    rw [brownianUsualAmericanPut_normalization hK hr.le hσ hS,
      Real.coe_toNNReal _ hτ.le,← putPayoff_in_stock_units hK hS,mul_right_inj' hK.ne',
      canonicalPrice_contact_iff_logBoundary hk hh hhk ht]
    rw [← Real.exp_le_exp,Real.exp_log (div_pos hS hK),div_le_iff₀ hK]
    dsimp [B,b]
    rw [mul_comm K]
  let μ := completedMeasure gaussianLimit
  have hz : ∀ᵐ ω ∂μ, brownian 0 ω = 0 := isBrownianReal_brownian.eval_zero_ae_eq_zero
  letI : MeasurableSpace (ℝ≥0 → ℝ) := completedMeasurableSpace gaussianLimit
  change exerciseThreshold μ brownianUsualFiltration brownian K r q σ τ.toNNReal = B
  have hmem : B ∈ exerciseSet μ brownianUsualFiltration brownian K r q σ τ.toNNReal := by
    refine ⟨hBpos.le,hBK,?_⟩
    have he := (hcontact B hBpos).mpr le_rfl
    rw [max_eq_left (sub_nonneg.mpr hBK)] at he
    convert! he using 1
  apply le_antisymm _ (le_csSup exerciseSet_bddAbove hmem)
  apply csSup_le ⟨0,zero_mem_exerciseSet brownian_completed_measurable hz hK.le hr.le⟩
  intro S hS
  by_cases hSpos : 0 < S
  · apply (hcontact S hSpos).mp
    exact hS.2.2.trans (max_eq_left (sub_nonneg.mpr hS.2.1)).symm
  · exact (le_of_not_gt hSpos).trans hBpos.le
```

### brownianUsualExerciseBoundary_eq_scaled_canonical

[Stopping/ActualBoundaryNormalization.lean:62](/Users/robert/dev/AmericanConvexity/AmericanConvexity/Stopping/ActualBoundaryNormalization.lean:62)

```lean
theorem brownianUsualExerciseBoundary_eq_scaled_canonical {K r q σ : ℝ}
    (hK : 0 < K) (hr : 0 < r) (hq : 0 ≤ q) (hqr : q ≤ r) (hσ : 0 < σ)
    {τ : ℝ} (hτ : 0 < τ) :
    brownianUsualExerciseBoundary K r q σ τ.toNNReal =
      K*canonicalStockBoundary (normalizedRate r σ) (normalizedRate q σ) (σ^2/2*τ) := by
  obtain ⟨hk,hh,hhk⟩ := normalized_rates_admissible hr hq hqr hσ
  rw [brownianUsualExerciseBoundary_normalization hK hr hq hqr hσ hτ,
    exp_canonicalLogBoundary hk hh hhk (by positivity)]
```

### brownianUsualLogBoundary_normalization

[Stopping/ActualBoundaryNormalization.lean:71](/Users/robert/dev/AmericanConvexity/AmericanConvexity/Stopping/ActualBoundaryNormalization.lean:71)

```lean
theorem brownianUsualLogBoundary_normalization {K r q σ : ℝ}
    (hK : 0 < K) (hr : 0 < r) (hq : 0 ≤ q) (hqr : q ≤ r) (hσ : 0 < σ)
    {τ : ℝ} (hτ : 0 < τ) :
    Real.log (brownianUsualExerciseBoundary K r q σ τ.toNNReal/K) =
      canonicalLogBoundary (normalizedRate r σ) (normalizedRate q σ) (σ^2/2*τ) := by
  rw [brownianUsualExerciseBoundary_normalization hK hr hq hqr hσ hτ,
    mul_div_cancel_left₀ _ hK.ne',Real.log_exp]
```


## 4. Where the solution and interval hypotheses are discharged

### ContinuousBoundaryPutSolution

[Boundary/ContinuousBoundaryProblem.lean:15](/Users/robert/dev/AmericanConvexity/AmericanConvexity/Boundary/ContinuousBoundaryProblem.lean:15)

```lean
structure ContinuousBoundaryPutSolution (k h : ℝ) (p : ℝ → ℝ → ℝ) (b : ℝ → ℝ) : Prop where
  rate_pos : 0 < k
  dividend_nonneg : 0 ≤ h
  dividend_le_rate : h ≤ k
  boundary_initial : b 0 = 0
  boundary_continuous : ContinuousOn b (Ici 0)
  price_continuous : ContinuousOn (fun z : ℝ × ℝ => p z.1 z.2) {z | 0 ≤ z.2}
  price_smooth : ContDiffOn ℝ ∞ (fun z : ℝ × ℝ => p z.1 z.2) (continuationRegion b)
  initial : ∀ x, p x 0 = putPayoff x
  dominates : ∀ x t, 0 ≤ t → putPayoff x ≤ p x t
  bounded : ∀ x t, 0 ≤ t → p x t ≤ 1
  exercise : ∀ x t, 0 < t → x ≤ b t → p x t = 1-Real.exp x
  continuation : ∀ x t, 0 < t → b t < x → putPayoff x < p x t
  equation : ∀ x t, 0 < t → b t < x →
    deriv (p x) t = dividendSpatialOperator k h (fun y => p y t) x
  smooth_fit : ∀ t, 0 < t → HasDerivWithinAt (fun x => p x t)
    (-Real.exp (b t)) (Ici (b t)) (b t)
  gradient_trace : ∀ t, 0 < t → Tendsto (fun x => deriv (fun y => p y t) x)
    (𝓝[>] (b t)) (𝓝 (-Real.exp (b t)))
  decay : ∀ t, 0 ≤ t → Tendsto (fun x => p x t) atTop (𝓝 0)
```

### canonicalPrice_continuousBoundaryPutSolution

[Stopping/ActualContinuousContract.lean:15](/Users/robert/dev/AmericanConvexity/AmericanConvexity/Stopping/ActualContinuousContract.lean:15)

```lean
theorem canonicalPrice_continuousBoundaryPutSolution {k h : ℝ}
    (hk : 0 < k) (hh : 0 ≤ h) (hhk : h ≤ k) :
    ContinuousBoundaryPutSolution k h (canonicalPrice k h) (canonicalLogBoundary k h) := by
  have hregion : canonicalContinuationRegion k h = continuationRegion (canonicalLogBoundary k h) :=
    canonicalContinuationRegion_eq_logBoundary hk hh hhk
  refine {
    rate_pos := hk
    dividend_nonneg := hh
    dividend_le_rate := hhk
    boundary_initial := canonicalLogBoundary_initial hk
    boundary_continuous := canonicalLogBoundary_continuousOn hk hh hhk
    price_continuous := (canonicalPrice_continuous hk.le).continuousOn
    price_smooth := ?_
    initial := canonicalPrice_initial hk.le
    dominates := fun x t _ => (canonicalPrice_bounds hk.le x t).1
    bounded := fun x t _ => (canonicalPrice_bounds hk.le x t).2
    exercise := ?_
    continuation := ?_
    equation := ?_
    smooth_fit := fun _ ht => canonicalPrice_smooth_fit hk hh hhk ht
    gradient_trace := fun _ ht => canonicalPrice_gradient_trace hk hh hhk ht
    decay := fun t _ => canonicalPrice_decay hk.le t }
  · rw [← hregion]
    exact canonicalPrice_contDiffOn hk.le
  · intro x t ht hx
    rw [(canonicalPrice_contact_iff_logBoundary hk hh hhk ht).mpr hx]
    exact putPayoff_of_nonpos (hx.trans (canonicalLogBoundary_neg hk hh hhk ht).le)
  · intro x t ht hx
    have hz : (x,t) ∈ canonicalContinuationRegion k h := by
      rw [hregion]
      exact ⟨ht,hx⟩
    exact hz.2
  · intro x t ht hx
    have hz : (x,t) ∈ canonicalContinuationRegion k h := by
      rw [hregion]
      exact ⟨ht,hx⟩
    exact canonicalPrice_continuation_pde hk.le hz
```

### canonicalLogBoundary_no_return_contact

[Stopping/ActualComparisonIntervals.lean:35](/Users/robert/dev/AmericanConvexity/AmericanConvexity/Stopping/ActualComparisonIntervals.lean:35)

```lean
theorem canonicalLogBoundary_no_return_contact {k h c d a T U : ℝ}
    (hk : 0 < k) (hh : 0 ≤ h) (hhk : h ≤ k) (hc : 0 < c) (hd : d ≤ 0)
    (ha : 0 < a) (haT : a < T) (hTU : T < U)
    (hcontact : canonicalLogBoundary k h T = d-c*T)
    (hpast : ∀ t ∈ Ico a T, canonicalLogBoundary k h t < d-c*t)
    (hfuture : canonicalLogBoundary k h U < d-c*U) : False := by
  let hp := canonicalPrice_continuousBoundaryPutSolution hk hh hhk
  have hU : 0 < U := (ha.trans haT).trans hTU
  have hpos : 0 < straightDifference (canonicalPrice k h) k h c d (d-c*U) U := by
    simpa only [lineDifference,movingLineTransform,zero_add] using
      lineDifference_on_line_pos hp hU hfuture
  obtain ⟨x,hx,hpx⟩ := straightDifference_positive_at_earlier_time hp hc hd
    (ha.trans haT).le hTU.le hfuture.le hpos
  exact no_contact_of_past_line_below_and_terminal_positive hp ha haT hcontact hpast hx hpx
    (fun _ ht => canonicalStraightDifference_positive_interval hk hh hhk hc hd ht)
```

### canonicalStraightDifference_superlevel_interval

[Stopping/ActualComparisonIntervals.lean:18](/Users/robert/dev/AmericanConvexity/AmericanConvexity/Stopping/ActualComparisonIntervals.lean:18)

```lean
theorem canonicalStraightDifference_superlevel_interval {k h c d t ε : ℝ}
    (hk : 0 < k) (hh : 0 ≤ h) (hhk : h ≤ k) (hc : 0 < c) (hd : d ≤ 0)
    (ht : 0 < t) (hε : 0 ≤ ε) :
    OrdConnected {x | canonicalLogBoundary k h t < x ∧
      ε < straightDifference (canonicalPrice k h) k h c d x t} :=
  straightDifference_superlevel_interval (canonicalPrice_continuousBoundaryPutSolution hk hh hhk)
    hc hd ht hε
```

### straightDifference_three_point_bound

[Boundary/ComparisonUnimodality.lean:20](/Users/robert/dev/AmericanConvexity/AmericanConvexity/Boundary/ComparisonUnimodality.lean:20)

```lean
theorem straightDifference_three_point_bound (hp : ContinuousBoundaryPutSolution k h p b)
    (hc : 0 < c) (hd : d ≤ 0) {x y z t : ℝ} (ht : 0 < t)
    (hx : b t ≤ x) (hxy : x ≤ y) (hyz : y ≤ z) :
    min (straightDifference p k h c d x t) (straightDifference p k h c d z t) ≤
      max (straightDifference p k h c d y t) 0 := by
  obtain ⟨X,hX,htail⟩ := straightDifference_right_negative hp hc hd
  let R := max X (z+1)
  have hR : 0 < R := hX.trans_le (le_max_left _ _)
  have hzR : z ≤ R := by dsimp [R]; linarith [le_max_right X (z+1)]
  let f := profile (k-h-1-c) k
  let g := profile (k-h-1+2-c) h
  have hf : ProfileData (k-h-1-c) k f := profile_data hp.rate_pos.le
  have hg : ProfileData (k-h-1+2-c) h g := profile_data hp.dividend_nonneg
  have hb : ContinuousOn b (Icc 0 t) := hp.boundary_continuous.mono (fun _ hs => hs.1)
  have hbR : ∀ s ∈ Icc 0 t, b s ≤ R := by
    intro s hs
    rcases eq_or_lt_of_le hs.1 with he | he
    · simpa [← he,hp.boundary_initial] using hR.le
    · exact (hp.boundary_nonpos he).trans hR.le
  have hinit : ∀ a m e, b 0 ≤ a → a ≤ m → m ≤ e → e ≤ R →
      min (straightDifference p k h c d a 0) (straightDifference p k h c d e 0) ≤
        max (straightDifference p k h c d m 0) 0 := by
    intro a m e ha ham hme _
    rw [hp.boundary_initial] at ha
    rcases eq_or_lt_of_le ha with he | he
    · subst a
      have hh := straightDifference_boundary_nonpos hp hc.le hd (t := 0) le_rfl
      rw [hp.boundary_initial] at hh
      exact (min_le_left _ _).trans (hh.trans (le_max_right _ _))
    · apply three_point_bound_of_positive_superlevels
        (S := Ioi (0 : ℝ)) (F := fun a => straightDifference p k h c d a 0) _ he
        (he.trans_le (ham.trans hme)) ham hme
      intro ε hε
      exact normalizedDifference_initial_superlevel hp hc (by linarith) d
  exact parabolic_three_point_bound (U := straightDifference p k h c d)
    (D := fun a s => k-h-1+2*deriv f (a+c*s-d)/f (a+c*s-d)) hb hbR
    ((normalizedDifference_continuousOn (c := c) (d := d) hp hf hg).mono (fun _ hs => hs.1))
    (fun a s hs _ hba _ => (normalizedDifference_contDiffAt hp hf hg hs hba).of_le
      (WithTop.coe_le_coe.mpr le_top))
    (fun a s hs _ hba _ => normalizedDifference_equation hp hf hg hs hba)
    (fun s hs _ => straightDifference_boundary_nonpos hp hc.le hd hs)
    (fun s hs _ => (htail R (le_max_left _ _) s hs).le)
    hinit ht.le le_rfl hx hxy hyz hzR
```

### parabolic_three_point_bound

[Boundary/ParabolicUnimodality.lean:26](/Users/robert/dev/AmericanConvexity/AmericanConvexity/Boundary/ParabolicUnimodality.lean:26)

```lean
theorem parabolic_three_point_bound {U D : ℝ → ℝ → ℝ} {b : ℝ → ℝ} {R T : ℝ}
    (hb : ContinuousOn b (Icc 0 T)) (hbR : ∀ t ∈ Icc 0 T, b t ≤ R)
    (hU : ContinuousOn (fun z : ℝ × ℝ => U z.1 z.2) (movingStrip b R 0 T))
    (hs : ∀ x t, 0 < t → t ≤ T → b t < x → x < R →
      ContDiffAt ℝ 2 (fun z : ℝ × ℝ => U z.1 z.2) (x,t))
    (hpde : ∀ x t, 0 < t → t ≤ T → b t < x → x < R →
      deriv (U x) t = deriv (deriv (fun y => U y t)) x + D x t * deriv (fun y => U y t) x)
    (hleft : ∀ t, 0 ≤ t → t ≤ T → U (b t) t ≤ 0)
    (hright : ∀ t, 0 ≤ t → t ≤ T → U R t ≤ 0)
    (hinit : ∀ x y z, b 0 ≤ x → x ≤ y → y ≤ z → z ≤ R →
      min (U x 0) (U z 0) ≤ max (U y 0) 0)
    {x y z t : ℝ} (ht : 0 ≤ t) (htT : t ≤ T)
    (hbx : b t ≤ x) (hxy : x ≤ y) (hyz : y ≤ z) (hzR : z ≤ R) :
    min (U x t) (U z t) ≤ max (U y t) 0 := by
  by_contra hn
  let gap := min (U x t) (U z t)-max (U y t) 0
  have hg : 0 < gap := sub_pos.mpr (lt_of_not_ge hn)
  let δ := gap/4
  have hδ : 0 < δ := div_pos hg (by norm_num)
  let η := δ/(t+1)
  have hden : 0 < t+1 := by linarith
  have hη : 0 < η := div_pos hδ hden
  have hpen : η*(t+1) = δ := by dsimp [η]; field_simp
  have hh := parabolic_smoothValley_nonpos hδ hη hb hbR hU hs hpde hleft hright hinit
    _ (sameTimeTriple_mem ht htT hbx hxy hyz hzR)
  change smoothValley δ (U x t) (U y t) (U z t)-η*t ≤ 0 at hh
  have hlo := (smoothValley_bounds hδ.le (U x t) (U y t) (U z t)).1
  change gap-δ ≤ smoothValley δ (U x t) (U y t) (U z t) at hlo
  have hδeq : 4*δ = gap := by dsimp [δ]; ring
  nlinarith
```

### smoothPositive

[Boundary/SmoothValley.lean:14](/Users/robert/dev/AmericanConvexity/AmericanConvexity/Boundary/SmoothValley.lean:14)

```lean
noncomputable def smoothPositive (δ x : ℝ) : ℝ :=
  (x + Real.sqrt (x^2+δ^2))/2
```

### smoothPositiveSlope

[Boundary/SmoothValley.lean:17](/Users/robert/dev/AmericanConvexity/AmericanConvexity/Boundary/SmoothValley.lean:17)

```lean
noncomputable def smoothPositiveSlope (δ x : ℝ) : ℝ :=
  (1+x/Real.sqrt (x^2+δ^2))/2
```

### smoothMinimum

[Boundary/SmoothValley.lean:20](/Users/robert/dev/AmericanConvexity/AmericanConvexity/Boundary/SmoothValley.lean:20)

```lean
noncomputable def smoothMinimum (δ x z : ℝ) : ℝ := x-smoothPositive δ (x-z)
```

### smoothValley

[Boundary/SmoothValley.lean:22](/Users/robert/dev/AmericanConvexity/AmericanConvexity/Boundary/SmoothValley.lean:22)

```lean
noncomputable def smoothValley (δ x y z : ℝ) : ℝ :=
  smoothMinimum δ x z - smoothPositive δ y
```

### parabolic_smoothValley_nonpos

[Boundary/ParabolicValley.lean:50](/Users/robert/dev/AmericanConvexity/AmericanConvexity/Boundary/ParabolicValley.lean:50)

```lean
theorem parabolic_smoothValley_nonpos {U D : ℝ → ℝ → ℝ} {b : ℝ → ℝ} {R T δ η : ℝ}
    (hδ : 0 < δ) (hη : 0 < η)
    (hb : ContinuousOn b (Icc 0 T)) (hbR : ∀ t ∈ Icc 0 T, b t ≤ R)
    (hU : ContinuousOn (fun z : ℝ × ℝ => U z.1 z.2) (movingStrip b R 0 T))
    (hs : ∀ x t, 0 < t → t ≤ T → b t < x → x < R →
      ContDiffAt ℝ 2 (fun z : ℝ × ℝ => U z.1 z.2) (x,t))
    (hpde : ∀ x t, 0 < t → t ≤ T → b t < x → x < R →
      deriv (U x) t = deriv (deriv (fun y => U y t)) x + D x t * deriv (fun y => U y t) x)
    (hleft : ∀ t, 0 ≤ t → t ≤ T → U (b t) t ≤ 0)
    (hright : ∀ t, 0 ≤ t → t ≤ T → U R t ≤ 0)
    (hinit : ∀ x y z, b 0 ≤ x → x ≤ y → y ≤ z → z ≤ R →
      min (U x 0) (U z 0) ≤ max (U y 0) 0) :
    ∀ w ∈ orderedTriples (movingStrip b R 0 T), valleyOnTriple U δ η w ≤ 0 := by
  intro q hq
  by_contra hn
  have hpos : 0 < valleyOnTriple U δ η q := lt_of_not_ge hn
  have hK := orderedTriples_isCompact (movingStrip_isCompact hb hbR)
  obtain ⟨w,hw,hmax⟩ := hK.exists_isMaxOn ⟨q,hq⟩ (valleyOnTriple_continuousOn hU δ η)
  have hwpos := hpos.trans_le (hmax hq)
  rcases w with ⟨⟨x,t⟩,⟨y,s⟩,⟨z,r⟩⟩
  rcases hw with ⟨⟨hwx,hwy,hwz⟩,h12,h13,hxy,hyz⟩
  change t = s at h12
  change t = r at h13
  subst s
  subst r
  change 0 ≤ t ∧ t ≤ T ∧ b t ≤ x ∧ x ≤ R at hwx
  change 0 ≤ t ∧ t ≤ T ∧ b t ≤ z ∧ z ≤ R at hwz
  change x ≤ y at hxy
  change y ≤ z at hyz
  change 0 < smoothValley δ (U x t) (U y t) (U z t) - η*t at hwpos
  have hgap : max (U y t) 0 < min (U x t) (U z t) := by
    have hh := (smoothValley_bounds hδ.le (U x t) (U y t) (U z t)).2
    nlinarith [mul_nonneg hη.le hwx.1]
  have hxp : 0 < U x t := (le_max_right _ _).trans_lt (hgap.trans_le (min_le_left _ _))
  have hzp : 0 < U z t := (le_max_right _ _).trans_lt (hgap.trans_le (min_le_right _ _))
  have hxy' : x < y := lt_of_le_of_ne hxy (by
    intro he; subst y; linarith [min_le_left (U x t) (U z t),le_max_left (U x t) 0])
  have hyz' : y < z := lt_of_le_of_ne hyz (by
    intro he; subst z; linarith [min_le_right (U x t) (U y t),le_max_left (U y t) 0])
  have ht : 0 < t := lt_of_le_of_ne hwx.1 (by
    intro he; subst t
    exact (not_lt_of_ge (hinit x y z hwx.2.2.1 hxy hyz hwz.2.2.2)) hgap)
  have hbx : b t < x := lt_of_le_of_ne hwx.2.2.1 (by
    intro he; have hh := hleft t hwx.1 hwx.2.1; rw [he] at hh; linarith)
  have hzR : z < R := lt_of_le_of_ne hwz.2.2.2 (by
    intro he; have hh := hright t hwx.1 hwx.2.1; rw [← he] at hh; linarith)
  have hmX : IsLocalMax (fun a => U a t) x := by
    filter_upwards [Ioo_mem_nhds hbx hxy'] with a ha
    have hh := hmax (sameTimeTriple_mem hwx.1 hwx.2.1 ha.1.le ha.2.le hyz hzR.le)
    change smoothValley δ (U a t) (U y t) (U z t)-η*t ≤
      smoothValley δ (U x t) (U y t) (U z t)-η*t at hh
    apply (smoothMinimum_strictMono_left hδ (U z t)).le_iff_le.mp
    unfold smoothValley at hh
    linarith
  have hmZ : IsLocalMax (fun a => U a t) z := by
    filter_upwards [Ioo_mem_nhds hyz' hzR] with a ha
    have hh := hmax (sameTimeTriple_mem hwx.1 hwx.2.1 hbx.le hxy ha.1.le ha.2.le)
    change smoothValley δ (U x t) (U y t) (U a t)-η*t ≤
      smoothValley δ (U x t) (U y t) (U z t)-η*t at hh
    apply (smoothMinimum_strictMono_right hδ (U x t)).le_iff_le.mp
    unfold smoothValley at hh
    linarith
  have hmY : IsLocalMin (fun a => U a t) y := by
    filter_upwards [Ioo_mem_nhds hxy' hyz'] with a ha
    have hh := hmax (sameTimeTriple_mem hwx.1 hwx.2.1 hbx.le ha.1.le ha.2.le hzR.le)
    change smoothValley δ (U x t) (U a t) (U z t)-η*t ≤
      smoothValley δ (U x t) (U y t) (U z t)-η*t at hh
    apply (smoothPositive_strictMono hδ).le_iff_le.mp
    unfold smoothValley at hh
    linarith
  have hxR := (hxy'.trans hyz').trans hzR
  have hby := hbx.trans hxy'
  have hyR := hyz'.trans hzR
  have hbz := hby.trans hyz'
  have hcx : ContinuousAt (fun a => U a t) x := by
    exact Tendsto.comp (g := fun q : ℝ × ℝ => U q.1 q.2) (f := fun a : ℝ => (a,t))
      (hs x t ht hwx.2.1 hbx hxR).continuousAt
      (show ContinuousAt (fun a : ℝ => (a,t)) x by fun_prop)
  have hcy : ContinuousAt (fun a => U a t) y := by
    exact Tendsto.comp (g := fun q : ℝ × ℝ => U q.1 q.2) (f := fun a : ℝ => (a,t))
      (hs y t ht hwx.2.1 hby hyR).continuousAt
      (show ContinuousAt (fun a : ℝ => (a,t)) y by fun_prop)
  have hcz : ContinuousAt (fun a => U a t) z := by
    exact Tendsto.comp (g := fun q : ℝ × ℝ => U q.1 q.2) (f := fun a : ℝ => (a,t))
      (hs z t ht hwx.2.1 hbz hzR).continuousAt
      (show ContinuousAt (fun a : ℝ => (a,t)) z by fun_prop)
  have htx : deriv (U x) t ≤ 0 := by
    rw [hpde x t ht hwx.2.1 hbx hxR,hmX.deriv_eq_zero,mul_zero,add_zero]
    exact second_deriv_nonpos_at_local_max hmX hcx
  have htz : deriv (U z) t ≤ 0 := by
    rw [hpde z t ht hwx.2.1 hbz hzR,hmZ.deriv_eq_zero,mul_zero,add_zero]
    exact second_deriv_nonpos_at_local_max hmZ hcz
  have hty : 0 ≤ deriv (U y) t := by
    rw [hpde y t ht hwx.2.1 hby hyR,hmY.deriv_eq_zero,mul_zero,add_zero]
    exact second_deriv_nonneg_at_local_min hmY hcy
  have hdt (a : ℝ) (hba : b t < a) (haR : a < R) : HasDerivAt (U a) (deriv (U a) t) t :=
    ((hs a t ht hwx.2.1 hba haR).comp t
      (show ContDiffAt ℝ 2 (fun s : ℝ => (a,s)) t by fun_prop)).differentiableAt (by norm_num) |>.hasDerivAt
  have hd := (smoothValley_hasDeriv hδ (hdt x hbx hxR) (hdt y hby hyR) (hdt z hbz hzR)).sub
    ((hasDerivAt_id t).const_mul η)
  have htime : ∀ᶠ s in 𝓝[<] t, 0 ≤ s ∧ s ≤ T := by
    filter_upwards [nhdsWithin_le_nhds (Ioi_mem_nhds ht),self_mem_nhdsWithin] with s hs hst
    exact ⟨hs.le,(show s < t from hst).le.trans hwx.2.1⟩
  have hbs : ∀ᶠ s in 𝓝[<] t, b s < x :=
    ((hb t ⟨hwx.1,hwx.2.1⟩).mono_left
      (le_inf nhdsWithin_le_nhds (le_principal_iff.mpr htime))).eventually (Iio_mem_nhds hbx)
  have htm : ∀ᶠ s in 𝓝[<] t,
      smoothValley δ (U x s) (U y s) (U z s)-η*s ≤ smoothValley δ (U x t) (U y t) (U z t)-η*t := by
    filter_upwards [htime,hbs] with s hs hsb
    exact hmax (sameTimeTriple_mem hs.1 hs.2 hsb.le hxy hyz hzR.le)
  have hnonneg := deriv_nonneg_at_left_max hd.differentiableAt htm
  rw [hd.deriv] at hnonneg
  have hdx := smoothPositiveSlope_bounds hδ (U x t-U z t)
  have hdy := smoothPositiveSlope_bounds hδ (U y t)
  have htermx := mul_nonpos_of_nonneg_of_nonpos (sub_nonneg.mpr hdx.2.le) htx
  have htermz := mul_nonpos_of_nonneg_of_nonpos hdx.1.le htz
  have htermy := mul_nonneg hdy.1.le hty
  linarith
```


