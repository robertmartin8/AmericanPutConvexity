import AmericanPutConvexity.Stopping.PhysicalBoundaryConvexity
import AmericanPutConvexity.Stopping.AEHorizonValue

/-!
# American put option exercise-boundary geometry

The Solution supplies a concrete Brownian probability model. The certificates
below constrain the two supplied definitions; neither is an arbitrary boundary
or price. All subsequent financial objects are explicitly defined here.
The theorem concerns this constructed model, not all probability-space
representations. Time is time-to-expiry, and all model parameters are constant.
-/

namespace PalomarPut

open MeasureTheory ProbabilityTheory Set
open AmericanPutConvexity.Stopping
open scoped NNReal

/-- The underlying sample space, with its ordinary product Borel sigma algebra. -/
abbrev Path := ℝ≥0 → ℝ

/-- The raw probability measure of the constructed Brownian model. Its
implementation is supplied by the Solution and constrained by the certificates. -/
noncomputable abbrev law : Measure Path := gaussianLimit

/-- A continuous Brownian process on that space, supplied by the Solution. -/
noncomputable abbrev W : ℝ≥0 → Path → ℝ := brownian

theorem law_probability : IsProbabilityMeasure law := inferInstanceAs (IsProbabilityMeasure gaussianLimit)

theorem W_measurable (t : ℝ≥0) : Measurable (W t) := measurable_brownian t

theorem W_continuous (ω : Path) : Continuous (fun t => W t ω) := continuous_brownian ω

theorem W_zero : ∀ᵐ ω ∂law, W 0 ω = 0 := isBrownianReal_brownian.eval_zero_ae_eq_zero

/-- Increments have the centered normal law with variance equal to elapsed time. -/
theorem W_increment_law (s t : ℝ≥0) (hst : s ≤ t) :
    HasLaw (fun ω => W t ω - W s ω) (gaussianReal 0 (t-s)) law := by
  have he : nndist t s = t-s := by
    apply NNReal.coe_injective
    rw [coe_nndist]
    change |(t : ℝ)-(s : ℝ)| = ((t-s : ℝ≥0) : ℝ)
    rw [NNReal.coe_sub hst, abs_of_nonneg (sub_nonneg.mpr (show (s : ℝ) ≤ t from hst))]
  change HasLaw (brownian t - brownian s) (gaussianReal 0 (t-s)) gaussianLimit
  rw [← he]
  exact hasLaw_brownian_sub

/-- The entire future increment process is independent of the entire past. -/
theorem W_independent_past (s : ℝ≥0) :
    IndepFun (fun ω (t : ℝ≥0) => W (s+t) ω - W s ω)
      (fun ω (t : Set.Iic s) => W t ω) law := isBrownianReal_brownian.toIsPreBrownianReal.indepFun_shift s

/-- Ambient sigma algebra completed under the displayed Brownian measure. -/
@[reducible] noncomputable def completedSpace : MeasurableSpace Path :=
  eventuallyMeasurableSpace inferInstance (ae law)

/-- The probability measure used in every financial expectation below. -/
noncomputable def probability : @Measure Path completedSpace := law.completion

/-- Usual natural filtration: generate from past Brownian observations, adjoin
all ambient null sets in the completed space, then take right limits. -/
noncomputable def filtration : Filtration ℝ≥0 completedSpace :=
  let raw := Filtration.natural W (fun t => (W_measurable t).stronglyMeasurable)
  let lifted : Filtration ℝ≥0 completedSpace := {
    seq := fun t => raw t
    mono' := fun _ _ h => raw.mono h
    le' := fun t => (raw.le t).trans (fun _ hs => hs.nullMeasurableSet) }
  let nulls := MeasurableSpace.generateFrom
    {s : Set Path | MeasurableSet[completedSpace] s ∧ probability s = 0}
  (lifted ⊔ Filtration.const ℝ≥0 nulls
    (MeasurableSpace.generateFrom_le fun _ hs => hs.1)).rightCont

private noncomputable abbrev concreteMeasure := completedMeasure gaussianLimit

attribute [local instance] completedSpace

theorem probability_isProbability : IsProbabilityMeasure probability := inferInstanceAs (IsProbabilityMeasure concreteMeasure)

theorem probability_isComplete : probability.IsComplete := inferInstanceAs (concreteMeasure.IsComplete)

theorem filtration_rightContinuous : filtration.IsRightContinuous := by
  change brownianUsualFiltration.IsRightContinuous
  infer_instance

theorem filtration_complete (s : Set Path) (hs : probability s = 0) (t : ℝ≥0) :
    MeasurableSet[filtration t] s := by
  change MeasurableSet[brownianUsualFiltration t] s
  exact Filtration.IsComplete.measurableSet_of_null (μ := concreteMeasure) hs t

/-- The Brownian observations are measurable in the same filtration used for stopping. -/
theorem W_adapted (t : ℝ≥0) : Measurable[filtration t] (W t) := by
  exact (brownian_adapted t).mono (brownian_completedRaw_le_usual t) le_rfl

/-- All extended nonnegative stopping times of this filtration whose horizon
bound holds almost surely. Infinity is allowed only on a null set. -/
structure Rule (T : ℝ≥0) where
  time : Path → WithTop ℝ≥0
  stopping : IsStoppingTime filtration time
  ae_le_horizon : ∀ᵐ ω ∂probability, time ω ≤ T

/-- Black–Scholes stock with drift `r-q` and volatility `σ`. -/
noncomputable def stock (r q σ S : ℝ) (t : ℝ≥0) (ω : Path) : ℝ :=
  S * Real.exp ((r-q-σ^2/2)*(t : ℝ) + σ*W t ω)

/-- The supremum over every admissible stopping time of its expected payoff,
discounted at `r`. Replacing infinity by zero affects only a null set. -/
noncomputable def value (K r q σ S : ℝ) (T : ℝ≥0) : ℝ :=
  sSup (Set.range (fun θ : Rule T =>
    ∫ ω, Real.exp (-r*(((θ.time ω).untopD 0 : ℝ≥0) : ℝ)) *
      max (K-stock r q σ S ((θ.time ω).untopD 0) ω) 0 ∂probability))

/-- The payoff-contact threshold in `[0,K]`; the contact characterization below
identifies the entire positive-spot exercise region at positive time-to-expiry. -/
noncomputable def boundary (K r q σ : ℝ) (T : ℝ≥0) : ℝ :=
  sSup {S | 0 ≤ S ∧ S ≤ K ∧ value K r q σ S T = K-S}

private theorem value_eq (K r q σ S : ℝ) (T : ℝ≥0) :
    value K r q σ S T = brownianUsualAmericanPut K r q σ S T := by
  change _ = americanPutValue concreteMeasure
    brownianUsualFiltration brownian K r q σ S T
  rw [← aeAmericanPutValue_eq]
  apply congrArg sSup
  ext x
  constructor
  · rintro ⟨θ, rfl⟩
    exact ⟨⟨θ.time, θ.stopping, θ.ae_le_horizon⟩, rfl⟩
  · rintro ⟨θ, rfl⟩
    exact ⟨⟨θ.time, θ.stopping, θ.ae_le_horizon⟩, rfl⟩

private theorem boundary_eq (K r q σ : ℝ) (T : ℝ≥0) :
    boundary K r q σ T = brownianUsualExerciseBoundary K r q σ T := by
  unfold boundary brownianUsualExerciseBoundary exerciseThreshold exerciseSet
  simp only [value_eq, brownianUsualAmericanPut]

theorem value_bounds {K r q σ S : ℝ} (hK : 0 < K) (hr : 0 < r)
    (_hq : 0 ≤ q) (_hqr : q ≤ r) (_hσ : 0 < σ) (hS : 0 < S) (T : ℝ≥0) :
    max (K-S) 0 ≤ value K r q σ S T ∧ value K r q σ S T ≤ K := by
  rw [value_eq]
  exact ⟨payoff_le_value brownian_completed_measurable
    isBrownianReal_brownian.eval_zero_ae_eq_zero hK.le hr.le hS.le,
    value_le_strike brownian_completed_measurable hK.le hr.le hS.le⟩

theorem boundary_bounds {K r q σ : ℝ} (hK : 0 < K) (hr : 0 < r)
    (hq : 0 ≤ q) (hqr : q ≤ r) (hσ : 0 < σ) {τ : ℝ} (hτ : 0 < τ) :
    0 < boundary K r q σ τ.toNNReal ∧ boundary K r q σ τ.toNNReal < K := by
  rw [boundary_eq, brownianUsualExerciseBoundary_normalization hK hr hq hqr hσ hτ]
  obtain ⟨hk, hh, hhk⟩ := normalized_rates_admissible hr hq hqr hσ
  constructor
  · positivity
  · simpa only [mul_one] using mul_lt_mul_of_pos_left
      (Real.exp_lt_one_iff.mpr (canonicalLogBoundary_neg hk hh hhk (by positivity))) hK

theorem exercise_iff {K r q σ S : ℝ} (hK : 0 < K) (hr : 0 < r)
    (hq : 0 ≤ q) (hqr : q ≤ r) (hσ : 0 < σ) (hS : 0 < S)
    {τ : ℝ} (hτ : 0 < τ) :
    value K r q σ S τ.toNNReal = max (K-S) 0 ↔
      S ≤ boundary K r q σ τ.toNNReal := by
  rw [value_eq, boundary_eq, brownianUsualExerciseBoundary_normalization hK hr hq hqr hσ hτ]
  obtain ⟨hk, hh, hhk⟩ := normalized_rates_admissible hr hq hqr hσ
  rw [brownianUsualAmericanPut_normalization hK hr.le hσ hS,
    Real.coe_toNNReal _ hτ.le, ← AmericanPutConvexity.Boundary.putPayoff_in_stock_units hK hS,
    mul_right_inj' hK.ne', canonicalPrice_contact_iff_logBoundary hk hh hhk (by positivity)]
  rw [← Real.exp_le_exp, Real.exp_log (div_pos hS hK), div_le_iff₀ hK]
  rw [mul_comm K]

/-- At positive time-to-expiry the boundary is also the supremum of the entire
positive-spot exercise set, with no restriction to in-the-money prices. -/
theorem boundary_eq_sup_exercise {K r q σ : ℝ} (hK : 0 < K) (hr : 0 < r)
    (hq : 0 ≤ q) (hqr : q ≤ r) (hσ : 0 < σ) {τ : ℝ} (hτ : 0 < τ) :
    boundary K r q σ τ.toNNReal =
      sSup {S | 0 < S ∧ value K r q σ S τ.toNNReal = max (K-S) 0} := by
  have hp := (boundary_bounds hK hr hq hqr hσ hτ).1
  have hm : boundary K r q σ τ.toNNReal ∈
      {S | 0 < S ∧ value K r q σ S τ.toNNReal = max (K-S) 0} :=
    ⟨hp, (exercise_iff hK hr hq hqr hσ hp hτ).mpr le_rfl⟩
  have hu : ∀ S ∈ {S | 0 < S ∧ value K r q σ S τ.toNNReal = max (K-S) 0},
      S ≤ boundary K r q σ τ.toNNReal := by
    intro S hS
    exact (exercise_iff hK hr hq hqr hσ hS.1 hτ).mp hS.2
  exact le_antisymm (le_csSup ⟨_, hu⟩ hm) (csSup_le ⟨_, hm⟩ hu)

/-- The logarithmic exercise boundary is convex in positive time-to-expiry. -/
theorem log_boundary_convex {K r q σ : ℝ} (hK : 0 < K) (hr : 0 < r)
    (hq : 0 ≤ q) (hqr : q ≤ r) (hσ : 0 < σ) :
    ConvexOn ℝ (Ioi 0)
      (fun τ : ℝ => Real.log (boundary K r q σ τ.toNNReal / K)) := by
  simpa only [boundary_eq] using brownianUsualLogBoundary_convexOn hK hr hq hqr hσ

/-- The stock-price exercise boundary is strictly convex. -/
theorem boundary_strictConvex {K r q σ : ℝ} (hK : 0 < K) (hr : 0 < r)
    (hq : 0 ≤ q) (hqr : q ≤ r) (hσ : 0 < σ) :
    StrictConvexOn ℝ (Ioi 0)
      (fun τ : ℝ => boundary K r q σ τ.toNNReal) := by
  simpa only [boundary_eq] using brownianUsualStockBoundary_strictConvexOn hK hr hq hqr hσ

end PalomarPut
