# Elaborated audit: American put option value and exercise boundary

Snapshot: `61e3cf5483353229962626c9a94ad5a0d4dd8bb3`. Generated and checked with Lean 4.32.0 on 2026-09-05.

This file contains actual Lean output, not a transcription of source. The financial definitions are printed with explicit arguments, full names, universes, proof terms, and deep terms enabled. No printer ellipses occur in this file. The statements in section 5 come from the elaborated environment without their proof bodies; each has its own actual `#print axioms` output.

## Read this first

Four of the requested checks are directly exhibited:

- **Probability measure:** `actualMeasure_probability` shows the resolved instance for `completedMeasure gaussianLimit`, on `completedMeasurableSpace gaussianLimit`.
- **GBM and discounting:** `putReward` and `MathFin.gbmValue` give stock value `S * exp (((r-q)-σ²/2)*θ + σ*W θ)` and discount factor `exp (-r*θ)`.
- **All a.s.-bounded stopping times:** the stored value uses all pointwise-bounded `BoundedRule` records. `AEBoundedRule` instead permits extended nonnegative stopping times bounded by the horizon almost surely. `aeExerciseValues_eq` proves equality of the entire sets of expected rewards, and `actualValue_eq_ae_value` specializes it to the actual completed measure and usual filtration.
- **Boundary over positive stock prices:** the original definition includes `S=0` and restricts to `S≤K`. The freshly checked `actualBoundary_eq_sup_positive_contact` proves equality with the supremum of payoff-contact stock prices over **all `S>0`**, for positive time-to-expiry and the manuscript parameter range.

**The same-filtration Brownian certificate needs a distinction.** The named theorem `brownian_filtered` certifies `IsFilteredPreBrownian brownian brownianFiltration gaussianLimit`: the **raw natural filtration and original measure**. It does not certify that predicate for `brownianUsualFiltration` and `completedMeasure gaussianLimit`. A search of the project's Lean sources found no theorem directly stating that latter predicate. Section 5 therefore also prints the actual **usual-filtration Gaussian conditional-transition theorem** and adaptedness theorem, with their axiom reports. These are evidence for the augmentation step, not a relabelling of the raw theorem. This packet does **not** claim that the requested five-part audit has been closed by a direct usual-filtration Brownian-predicate certificate. Nor does this observation itself establish that the process or the financial theorem is wrong.

**Right-continuation definition:** the packet now prints `Filtration.rightCont_def` and `Filtration.rightCont_eq`, together with the checked specialization `actualUsualFiltration_eq_iInf`. On the project's index type `ℝ≥0`, right continuation is exactly `𝓕.rightCont t = ⨅ s > t, 𝓕 s` (intersection of sigma-algebras). The general definition has a fallback to `𝓕 t` when there are no right-neighborhood points; the dense, no-maximum index type `ℝ≥0` excludes that branch. These outputs resolve the definitional opacity of `irreducible_def`; they do not by themselves prove invariance of the stopping value under filtration extension.

**Positive-time qualification:** the contact equivalence is stated for `τ>0`. At `τ=0`, the value equals the payoff for every stock price, including `S>K`; hence that equivalence over all positive stock prices would be false at expiry.

## Contents and scope

1. Value, boundary, stopping rules, payoff and explicit GBM.
2. Completed measure, probability instance and filtration construction.
3. Constructed Brownian process, predicates and the raw-filtration certificate.
4. Equality with the value over all a.s.-bounded stopping times.
5. Elaborated statements and separate axiom reports: usual transitions/adaptedness, contact equivalence, strict boundary bounds, payoff/value bounds, and positive-stock supremum.

The three requested financial statements are:
```text
τ > 0, S > 0:
  value K r q σ S τ = max (K-S) 0 ↔ S ≤ boundary K r q σ τ

K > 0, r > 0, 0 ≤ q ≤ r, σ > 0, τ > 0:
  0 < boundary K r q σ τ ∧ boundary K r q σ τ < K

K ≥ 0, r ≥ 0, S ≥ 0:
  max (K-S) 0 ≤ value K r q σ S τ ∧ value K r q σ S τ ≤ K
```
The exact additional hypotheses and argument order are in the elaborated statements below. In particular the contact statement needs `K>0, r≥0, σ>0`, but imposes no restriction on `q`.

The named `AmericanConvexity.Review.*` declarations are **new review-only specializations**, not pre-existing production theorem names. Their checked proofs are in [ValueAuditStatements.lean](ValueAuditStatements.lean). They add no PDE or convexity assumptions. No production Lean source or manuscript was changed.

For the recursive request, see:

- [Full non-Mathlib dependency print appendix](value-elaborated-recursive.md): **453 declarations**, including generated/private declarations, reached by recursively inspecting actual declaration types and bodies from the six stated roots, stopping at Mathlib and Lean/core. All 453 have corresponding `#print` output. To keep this construction appendix usable, **proof terms are suppressed there**; `⋯` there is a printer omission, not `sorry`. Data definitions and theorem/structure types are elaborated. The critical financial spine in the present file has proof printing enabled.
- [Dependency inventory and stopping frontier](value-print-dependencies.md): declaration ownership plus every stopping-frontier name. This makes the recursive scope explicit rather than implying that the selected readable trail alone is a closed dependency dump.

## Reproduction and provenance

[ElaboratedValueAudit.lean](ElaboratedValueAudit.lean) produces the output in this file. It uses ordinary `#print` for definitions/certificates and a small `#audit_statement` command that retrieves `ConstantInfo.type` for statement-only output. No type or axiom text below was hand-edited.

The review file compiled successfully, as did the print driver and all recursive-output chunks. This is a fresh compilation of the **review declarations against imported project artifacts**, not a fresh replay or rebuild of the entire project.

**CI provenance remains pending.** The checked-in workflow `.github/workflows/lean_action_ci.yml` configures an Ubuntu runner and a Lean build with Mathlib caching. It does not explicitly compile the review helpers, emit this packet, run the fresh-kernel dependency replay, or archive those results. No remote run establishing those checks for this packet was obtained in this session. The review files are currently uncommitted, so the existing remote workflow cannot yet reproduce them from the recorded project commit.

A citable follow-up should commit the audit drivers, rebuild project and review modules on a fresh runner, run both the print driver and the dependency replay, and retain the outputs with the exact commit, Lean version, and dependency revisions. The resulting successful run URL and archived artifacts would provide the external reproducibility evidence; the present local output is not labelled as that evidence.

Commands used, from the repository root:
```sh
lake env lean -o .lake/build/lib/lean/AmericanConvexity/Stopping/AEHorizonValue.olean AmericanConvexity/Stopping/AEHorizonValue.lean
lake env lean -o paper/review/ValueAuditStatements.olean paper/review/ValueAuditStatements.lean
LEAN_PATH=".:$(lake env printenv LEAN_PATH)" lake env lean paper/review/ElaboratedValueAudit.lean
```
The first command regenerated a missing cached module; it did not edit its source. A checkout without other prerequisite compiled modules must build those first.

Package revisions:
```text
MathFin:             784a8311f75a1519a23717856df9982bd6a9a370
BrownianMotion:      4d52fa776130a29d4ad7d6eda2035a919c0b4696
Mathlib:             81a5d257c8e410db227a6665ed08f64fea08e997
kolmogorov_extension4:
                     f33cbc388e5d444606dffa7eec507a26b62c15bb
```

---

## 1. Value, boundary, stopping rules and GBM

### `AmericanConvexity.Stopping.brownianUsualAmericanPut`

Command: `#print AmericanConvexity.Stopping.brownianUsualAmericanPut`

```lean
def AmericanConvexity.Stopping.brownianUsualAmericanPut : Real → Real → Real → Real → Real → NNReal → Real :=
fun K r q σ S T =>
  @AmericanConvexity.Stopping.americanPutValue.{0} (NNReal → Real)
    (@AmericanConvexity.Stopping.completedMeasurableSpace.{0} (NNReal → Real)
      (@MeasurableSpace.pi.{0, 0} NNReal (fun a => Real) fun a => Real.measurableSpace) ProbabilityTheory.gaussianLimit)
    (@AmericanConvexity.Stopping.completedMeasure.{0} (NNReal → Real)
      (@MeasurableSpace.pi.{0, 0} NNReal (fun a => Real) fun a => Real.measurableSpace) ProbabilityTheory.gaussianLimit)
    AmericanConvexity.Stopping.brownianUsualFiltration ProbabilityTheory.brownian K r q σ S T
```

### `AmericanConvexity.Stopping.brownianUsualExerciseBoundary`

Command: `#print AmericanConvexity.Stopping.brownianUsualExerciseBoundary`

```lean
def AmericanConvexity.Stopping.brownianUsualExerciseBoundary : Real → Real → Real → Real → NNReal → Real :=
fun K r q σ T =>
  @AmericanConvexity.Stopping.exerciseThreshold.{0} (NNReal → Real)
    (@AmericanConvexity.Stopping.completedMeasurableSpace.{0} (NNReal → Real)
      (@MeasurableSpace.pi.{0, 0} NNReal (fun a => Real) fun a => Real.measurableSpace) ProbabilityTheory.gaussianLimit)
    (@AmericanConvexity.Stopping.completedMeasure.{0} (NNReal → Real)
      (@MeasurableSpace.pi.{0, 0} NNReal (fun a => Real) fun a => Real.measurableSpace) ProbabilityTheory.gaussianLimit)
    AmericanConvexity.Stopping.brownianUsualFiltration ProbabilityTheory.brownian K r q σ T
```

### `AmericanConvexity.Stopping.americanPutValue`

Command: `#print AmericanConvexity.Stopping.americanPutValue`

```lean
def AmericanConvexity.Stopping.americanPutValue.{u_1} : {Ω : Type u_1} →
  [inst : MeasurableSpace.{u_1} Ω] →
    @MeasureTheory.Measure.{u_1} Ω inst →
      @MeasureTheory.Filtration.{u_1, 0} Ω NNReal (@PartialOrder.toPreorder.{0} NNReal NNReal.instPartialOrder) inst →
        (NNReal → Ω → Real) → Real → Real → Real → Real → Real → NNReal → Real :=
fun {Ω} [inst : MeasurableSpace.{u_1} Ω] P 𝓕 W K r q σ S T =>
  @SupSet.sSup.{0} Real Real.instSupSet (@AmericanConvexity.Stopping.exerciseValues.{u_1} Ω inst P 𝓕 W K r q σ S T)
```

### `AmericanConvexity.Stopping.exerciseValues`

Command: `#print AmericanConvexity.Stopping.exerciseValues`

```lean
def AmericanConvexity.Stopping.exerciseValues.{u_1} : {Ω : Type u_1} →
  [inst : MeasurableSpace.{u_1} Ω] →
    @MeasureTheory.Measure.{u_1} Ω inst →
      @MeasureTheory.Filtration.{u_1, 0} Ω NNReal (@PartialOrder.toPreorder.{0} NNReal NNReal.instPartialOrder) inst →
        (NNReal → Ω → Real) → Real → Real → Real → Real → Real → NNReal → Set.{0} Real :=
fun {Ω} [inst : MeasurableSpace.{u_1} Ω] P 𝓕 W K r q σ S T =>
  @Set.range.{0, u_1 + 1} Real (@AmericanConvexity.Stopping.BoundedRule.{u_1} Ω inst 𝓕 T) fun θ =>
    @MeasureTheory.integral.{u_1, 0} Ω Real Real.normedAddCommGroup
      (@InnerProductSpace.toNormedSpace.{0, 0} Real Real Real.instRCLike
        (@NormedAddCommGroup.toSeminormedAddCommGroup.{0} Real Real.normedAddCommGroup)
        (@RCLike.toInnerProductSpaceReal.{0} Real Real.instRCLike))
      inst P fun ω =>
      @AmericanConvexity.Stopping.putReward.{u_1} Ω W K r q σ S
        (@AmericanConvexity.Stopping.BoundedRule.time.{u_1} Ω inst 𝓕 T θ) ω
```

### `AmericanConvexity.Stopping.exerciseThreshold`

Command: `#print AmericanConvexity.Stopping.exerciseThreshold`

```lean
def AmericanConvexity.Stopping.exerciseThreshold.{u_1} : {Ω : Type u_1} →
  [inst : MeasurableSpace.{u_1} Ω] →
    @MeasureTheory.Measure.{u_1} Ω inst →
      @MeasureTheory.Filtration.{u_1, 0} Ω NNReal (@PartialOrder.toPreorder.{0} NNReal NNReal.instPartialOrder) inst →
        (NNReal → Ω → Real) → Real → Real → Real → Real → NNReal → Real :=
fun {Ω} [inst : MeasurableSpace.{u_1} Ω] P 𝓕 W K r q σ T =>
  @SupSet.sSup.{0} Real Real.instSupSet (@AmericanConvexity.Stopping.exerciseSet.{u_1} Ω inst P 𝓕 W K r q σ T)
```

### `AmericanConvexity.Stopping.exerciseSet`

Command: `#print AmericanConvexity.Stopping.exerciseSet`

```lean
def AmericanConvexity.Stopping.exerciseSet.{u_1} : {Ω : Type u_1} →
  [inst : MeasurableSpace.{u_1} Ω] →
    @MeasureTheory.Measure.{u_1} Ω inst →
      @MeasureTheory.Filtration.{u_1, 0} Ω NNReal (@PartialOrder.toPreorder.{0} NNReal NNReal.instPartialOrder) inst →
        (NNReal → Ω → Real) → Real → Real → Real → Real → NNReal → Set.{0} Real :=
fun {Ω} [inst : MeasurableSpace.{u_1} Ω] P 𝓕 W K r q σ T =>
  @setOf.{0} Real fun S =>
    And (@LE.le.{0} Real Real.instLE (@OfNat.ofNat.{0} Real (nat_lit 0) (@Zero.toOfNat0.{0} Real Real.instZero)) S)
      (And (@LE.le.{0} Real Real.instLE S K)
        (@Eq.{1} Real (@AmericanConvexity.Stopping.americanPutValue.{u_1} Ω inst P 𝓕 W K r q σ S T)
          (@HSub.hSub.{0, 0, 0} Real Real Real (@instHSub.{0} Real Real.instSub) K S)))
```

### `AmericanConvexity.Stopping.BoundedRule`

Command: `#print AmericanConvexity.Stopping.BoundedRule`

```lean
structure AmericanConvexity.Stopping.BoundedRule.{u_1} {Ω : Type u_1} [MeasurableSpace.{u_1} Ω]
  (𝓕 : @MeasureTheory.Filtration.{u_1, 0} Ω NNReal (@PartialOrder.toPreorder.{0} NNReal NNReal.instPartialOrder) inst✝)
  (T : NNReal) : Type u_1
number of parameters: 4
fields:
  AmericanConvexity.Stopping.BoundedRule.time.{u_1} : Ω → NNReal
  AmericanConvexity.Stopping.BoundedRule.stopping.{u_1} : @MeasureTheory.IsStoppingTime.{u_1, 0} Ω NNReal inst✝
      (@PartialOrder.toPreorder.{0} NNReal NNReal.instPartialOrder) 𝓕 fun ω =>
      @WithTop.some.{0} NNReal (@AmericanConvexity.Stopping.BoundedRule.time.{u_1} Ω inst✝ 𝓕 T self ω)
  AmericanConvexity.Stopping.BoundedRule.le_horizon.{u_1} : ∀ (ω : Ω),
      @LE.le.{0} NNReal (@Preorder.toLE.{0} NNReal (@PartialOrder.toPreorder.{0} NNReal NNReal.instPartialOrder))
        (@AmericanConvexity.Stopping.BoundedRule.time.{u_1} Ω inst✝ 𝓕 T self ω) T
constructor:
  AmericanConvexity.Stopping.BoundedRule.mk.{u_1} {Ω : Type u_1} [MeasurableSpace.{u_1} Ω]
    {𝓕 :
      @MeasureTheory.Filtration.{u_1, 0} Ω NNReal (@PartialOrder.toPreorder.{0} NNReal NNReal.instPartialOrder) inst✝}
    {T : NNReal} (time : Ω → NNReal)
    (stopping :
      @MeasureTheory.IsStoppingTime.{u_1, 0} Ω NNReal inst✝
        (@PartialOrder.toPreorder.{0} NNReal NNReal.instPartialOrder) 𝓕 fun ω => @WithTop.some.{0} NNReal (time ω))
    (le_horizon :
      ∀ (ω : Ω),
        @LE.le.{0} NNReal (@Preorder.toLE.{0} NNReal (@PartialOrder.toPreorder.{0} NNReal NNReal.instPartialOrder))
          (time ω) T) :
    @AmericanConvexity.Stopping.BoundedRule.{u_1} Ω inst✝ 𝓕 T
```

### `AmericanConvexity.Stopping.BoundedRule.time`

Command: `#print AmericanConvexity.Stopping.BoundedRule.time`

```lean
@[reducible] def AmericanConvexity.Stopping.BoundedRule.time.{u_1} : {Ω : Type u_1} →
  [inst : MeasurableSpace.{u_1} Ω] →
    {𝓕 :
        @MeasureTheory.Filtration.{u_1, 0} Ω NNReal (@PartialOrder.toPreorder.{0} NNReal NNReal.instPartialOrder)
          inst} →
      {T : NNReal} → @AmericanConvexity.Stopping.BoundedRule.{u_1} Ω inst 𝓕 T → Ω → NNReal :=
fun Ω [MeasurableSpace.{u_1} Ω] 𝓕 T self => self.1
```

### `AmericanConvexity.Stopping.putReward`

Command: `#print AmericanConvexity.Stopping.putReward`

```lean
def AmericanConvexity.Stopping.putReward.{u_1} : {Ω : Type u_1} →
  (NNReal → Ω → Real) → Real → Real → Real → Real → Real → (Ω → NNReal) → Ω → Real :=
fun {Ω} W K r q σ S θ ω =>
  @HMul.hMul.{0, 0, 0} Real Real Real (@instHMul.{0} Real Real.instMul)
    (Real.exp
      (@HMul.hMul.{0, 0, 0} Real Real Real (@instHMul.{0} Real Real.instMul) (@Neg.neg.{0} Real Real.instNeg r) ↑(θ ω)))
    (@Max.max.{0} Real Real.instMax
      (@HSub.hSub.{0, 0, 0} Real Real Real (@instHSub.{0} Real Real.instSub) K
        (MathFin.gbmValue S (@HSub.hSub.{0, 0, 0} Real Real Real (@instHSub.{0} Real Real.instSub) r q) σ (↑(θ ω))
          (W (θ ω) ω)))
      (@OfNat.ofNat.{0} Real (nat_lit 0) (@Zero.toOfNat0.{0} Real Real.instZero)))
```

### `MathFin.gbmValue`

Command: `#print MathFin.gbmValue`

```lean
def MathFin.gbmValue : Real → Real → Real → Real → Real → Real :=
fun S₀ μ σ t x =>
  @HMul.hMul.{0, 0, 0} Real Real Real (@instHMul.{0} Real Real.instMul) S₀
    (Real.exp
      (@HAdd.hAdd.{0, 0, 0} Real Real Real (@instHAdd.{0} Real Real.instAdd)
        (@HMul.hMul.{0, 0, 0} Real Real Real (@instHMul.{0} Real Real.instMul)
          (@HSub.hSub.{0, 0, 0} Real Real Real (@instHSub.{0} Real Real.instSub) μ
            (@HDiv.hDiv.{0, 0, 0} Real Real Real
              (@instHDiv.{0} Real (@DivInvMonoid.toDiv.{0} Real Real.instDivInvMonoid))
              (@HPow.hPow.{0, 0, 0} Real Nat Real
                (@instHPow.{0, 0} Real Nat (@NPow.toPow.{0} Real (@Monoid.toNPow.{0} Real Real.instMonoid))) σ
                (@OfNat.ofNat.{0} Nat (nat_lit 2) (instOfNatNat (nat_lit 2))))
              (@OfNat.ofNat.{0} Real (nat_lit 2)
                (@instOfNatAtLeastTwo.{0} Real (nat_lit 2) Real.instNatCast
                  MathFin.discreteTaylorRemainder2D._proof_1))))
          t)
        (@HMul.hMul.{0, 0, 0} Real Real Real (@instHMul.{0} Real Real.instMul) σ x)))
```

### `MeasureTheory.IsStoppingTime`

Command: `#print MeasureTheory.IsStoppingTime`

```lean
def MeasureTheory.IsStoppingTime.{u_1, u_3} : {Ω : Type u_1} →
  {ι : Type u_3} →
    {m : MeasurableSpace.{u_1} Ω} →
      [inst : Preorder.{u_3} ι] → @MeasureTheory.Filtration.{u_1, u_3} Ω ι inst m → (Ω → WithTop.{u_3} ι) → Prop :=
fun {Ω} {ι} {m} [inst : Preorder.{u_3} ι] f τ =>
  ∀ (i : ι),
    @MeasurableSet.{u_1} Ω (@MeasureTheory.Filtration.seq.{u_1, u_3} Ω ι inst m f i)
      (@setOf.{u_1} Ω fun ω =>
        @LE.le.{u_3} (WithTop.{u_3} ι) (@Preorder.toLE.{u_3} (WithTop.{u_3} ι) (@WithTop.instPreorder.{u_3} ι inst))
          (τ ω) (@WithTop.some.{u_3} ι i))
```

## 2. Actual measure and filtration

### `AmericanConvexity.Stopping.completedMeasurableSpace`

Command: `#print AmericanConvexity.Stopping.completedMeasurableSpace`

```lean
@[reducible] def AmericanConvexity.Stopping.completedMeasurableSpace.{u_1} : {Ω : Type u_1} →
  [mΩ : MeasurableSpace.{u_1} Ω] → @MeasureTheory.Measure.{u_1} Ω mΩ → MeasurableSpace.{u_1} Ω :=
fun {Ω} [mΩ : MeasurableSpace.{u_1} Ω] P =>
  @eventuallyMeasurableSpace.{u_1} Ω mΩ
    (@MeasureTheory.ae.{u_1, u_1} Ω (@MeasureTheory.Measure.{u_1} Ω mΩ) (@MeasureTheory.Measure.instFunLike.{u_1} Ω mΩ)
      (@MeasureTheory.Measure.instOuterMeasureClass.{u_1} Ω mΩ) P)
    (@AmericanConvexity.Stopping.completedMeasurableSpace._proof_1.{u_1} Ω mΩ P)
```

### `AmericanConvexity.Stopping.completedMeasure`

Command: `#print AmericanConvexity.Stopping.completedMeasure`

```lean
def AmericanConvexity.Stopping.completedMeasure.{u_1} : {Ω : Type u_1} →
  [mΩ : MeasurableSpace.{u_1} Ω] →
    (P : @MeasureTheory.Measure.{u_1} Ω mΩ) →
      @MeasureTheory.Measure.{u_1} Ω (@AmericanConvexity.Stopping.completedMeasurableSpace.{u_1} Ω mΩ P) :=
fun {Ω} [mΩ : MeasurableSpace.{u_1} Ω] P => @MeasureTheory.Measure.completion.{u_1} Ω mΩ P
```

### `AmericanConvexity.Stopping.brownianUsualFiltration`

Command: `#print AmericanConvexity.Stopping.brownianUsualFiltration`

```lean
def AmericanConvexity.Stopping.brownianUsualFiltration : @MeasureTheory.Filtration.{0, 0} (NNReal → Real) NNReal
  (@PartialOrder.toPreorder.{0} NNReal NNReal.instPartialOrder)
  (@AmericanConvexity.Stopping.completedMeasurableSpace.{0} (NNReal → Real)
    (@MeasurableSpace.pi.{0, 0} NNReal (fun a => Real) fun a => Real.measurableSpace)
    ProbabilityTheory.gaussianLimit) :=
@MeasureTheory.Filtration.rightCont.{0, 0} (NNReal → Real) NNReal
  (@AmericanConvexity.Stopping.completedMeasurableSpace.{0} (NNReal → Real)
    (@MeasurableSpace.pi.{0, 0} NNReal (fun a => Real) fun a => Real.measurableSpace) ProbabilityTheory.gaussianLimit)
  NNReal.instPartialOrder
  (@AmericanConvexity.Stopping.ambientNullAugmentation.{0} (NNReal → Real)
    (@AmericanConvexity.Stopping.completedMeasurableSpace.{0} (NNReal → Real)
      (@MeasurableSpace.pi.{0, 0} NNReal (fun a => Real) fun a => Real.measurableSpace) ProbabilityTheory.gaussianLimit)
    (@AmericanConvexity.Stopping.completedAmbientFiltration.{0} (NNReal → Real)
      (@MeasurableSpace.pi.{0, 0} NNReal (fun a => Real) fun a => Real.measurableSpace) ProbabilityTheory.gaussianLimit
      AmericanConvexity.Stopping.brownianFiltration)
    (@AmericanConvexity.Stopping.completedMeasure.{0} (NNReal → Real)
      (@MeasurableSpace.pi.{0, 0} NNReal (fun a => Real) fun a => Real.measurableSpace)
      ProbabilityTheory.gaussianLimit))
```

### `AmericanConvexity.Stopping.completedAmbientFiltration`

Command: `#print AmericanConvexity.Stopping.completedAmbientFiltration`

```lean
def AmericanConvexity.Stopping.completedAmbientFiltration.{u_1} : {Ω : Type u_1} →
  [mΩ : MeasurableSpace.{u_1} Ω] →
    (P : @MeasureTheory.Measure.{u_1} Ω mΩ) →
      @MeasureTheory.Filtration.{u_1, 0} Ω NNReal (@PartialOrder.toPreorder.{0} NNReal NNReal.instPartialOrder) mΩ →
        @MeasureTheory.Filtration.{u_1, 0} Ω NNReal (@PartialOrder.toPreorder.{0} NNReal NNReal.instPartialOrder)
          (@AmericanConvexity.Stopping.completedMeasurableSpace.{u_1} Ω mΩ P) :=
fun {Ω} [mΩ : MeasurableSpace.{u_1} Ω] P 𝓕 =>
  @MeasureTheory.Filtration.mk.{u_1, 0} Ω NNReal (@PartialOrder.toPreorder.{0} NNReal NNReal.instPartialOrder)
    (@AmericanConvexity.Stopping.completedMeasurableSpace.{u_1} Ω mΩ P)
    (fun t =>
      @MeasureTheory.Filtration.seq.{u_1, 0} Ω NNReal (@PartialOrder.toPreorder.{0} NNReal NNReal.instPartialOrder) mΩ 𝓕
        t)
    (@AmericanConvexity.Stopping.completedAmbientFiltration._proof_1.{u_1} Ω mΩ 𝓕)
    (@AmericanConvexity.Stopping.completedAmbientFiltration._proof_2.{u_1} Ω mΩ P 𝓕)
```

### `AmericanConvexity.Stopping.ambientNullAugmentation`

Command: `#print AmericanConvexity.Stopping.ambientNullAugmentation`

```lean
def AmericanConvexity.Stopping.ambientNullAugmentation.{u_1} : {Ω : Type u_1} →
  [mΩ : MeasurableSpace.{u_1} Ω] →
    @MeasureTheory.Filtration.{u_1, 0} Ω NNReal (@PartialOrder.toPreorder.{0} NNReal NNReal.instPartialOrder) mΩ →
      @MeasureTheory.Measure.{u_1} Ω mΩ →
        @MeasureTheory.Filtration.{u_1, 0} Ω NNReal (@PartialOrder.toPreorder.{0} NNReal NNReal.instPartialOrder) mΩ :=
fun {Ω} [mΩ : MeasurableSpace.{u_1} Ω] 𝓕 P =>
  @Max.max.{u_1}
    (@MeasureTheory.Filtration.{u_1, 0} Ω NNReal (@PartialOrder.toPreorder.{0} NNReal NNReal.instPartialOrder) mΩ)
    (@MeasureTheory.Filtration.instMax.{u_1, 0} Ω NNReal mΩ
      (@PartialOrder.toPreorder.{0} NNReal NNReal.instPartialOrder))
    𝓕
    (@MeasureTheory.Filtration.const.{u_1, 0} Ω NNReal mΩ (@PartialOrder.toPreorder.{0} NNReal NNReal.instPartialOrder)
      (@MathFin.ItoLocalMartingale.nullsAlg.{u_1} Ω mΩ P) (@MathFin.ItoLocalMartingale.nullsAlg_le.{u_1} Ω mΩ P))
```

### `MathFin.ItoLocalMartingale.nullsAlg`

Command: `#print MathFin.ItoLocalMartingale.nullsAlg`

```lean
@[reducible] def MathFin.ItoLocalMartingale.nullsAlg.{u_1} : {Ω : Type u_1} →
  (m0 : MeasurableSpace.{u_1} Ω) → @MeasureTheory.Measure.{u_1} Ω m0 → MeasurableSpace.{u_1} Ω :=
fun {Ω} m0 μ =>
  @MeasurableSpace.generateFrom.{u_1} Ω
    (@setOf.{u_1} (Set.{u_1} Ω) fun s =>
      And (@MeasurableSet.{u_1} Ω m0 s)
        (@Eq.{1} ENNReal
          (@DFunLike.coe.{u_1 + 1, u_1 + 1, 1} (@MeasureTheory.Measure.{u_1} Ω m0) (Set.{u_1} Ω) (fun x => ENNReal)
            (@MeasureTheory.Measure.instFunLike.{u_1} Ω m0) μ s)
          (@OfNat.ofNat.{0} ENNReal (nat_lit 0) (@Zero.toOfNat0.{0} ENNReal ENNReal.instZero))))
```

### `AmericanConvexity.Stopping.brownianFiltration`

Command: `#print AmericanConvexity.Stopping.brownianFiltration`

```lean
def AmericanConvexity.Stopping.brownianFiltration : @MeasureTheory.Filtration.{0, 0} (NNReal → Real) NNReal
  (@PartialOrder.toPreorder.{0} NNReal NNReal.instPartialOrder)
  (@inferInstance.{1} (MeasurableSpace.{0} (NNReal → Real))
    (@MeasurableSpace.pi.{0, 0} NNReal (fun a => Real) fun a => Real.measurableSpace)) :=
@MeasureTheory.Filtration.natural.{0, 0, 0} (NNReal → Real) NNReal
  (@inferInstance.{1} (MeasurableSpace.{0} (NNReal → Real))
    (@MeasurableSpace.pi.{0, 0} NNReal (fun a => Real) fun a => Real.measurableSpace))
  (fun i => Real)
  (fun i =>
    @UniformSpace.toTopologicalSpace.{0} Real (@PseudoMetricSpace.toUniformSpace.{0} Real Real.pseudoMetricSpace))
  AmericanConvexity.Stopping.brownianFiltration._proof_1 (fun i => Real.measurableSpace) (fun i => Real.borelSpace)
  (@PartialOrder.toPreorder.{0} NNReal NNReal.instPartialOrder) ProbabilityTheory.brownian
  AmericanConvexity.Stopping.brownianFiltration._proof_2
```

### `MeasureTheory.Filtration.natural`

Command: `#print MeasureTheory.Filtration.natural`

```lean
def MeasureTheory.Filtration.natural.{u_1, u_2, u_3} : {Ω : Type u_1} →
  {ι : Type u_2} →
    {m : MeasurableSpace.{u_1} Ω} →
      {β : ι → Type u_3} →
        [inst : (i : ι) → TopologicalSpace.{u_3} (β i)] →
          [∀ (i : ι), @TopologicalSpace.MetrizableSpace.{u_3} (β i) (inst i)] →
            [mβ : (i : ι) → MeasurableSpace.{u_3} (β i)] →
              [∀ (i : ι), @BorelSpace.{u_3} (β i) (inst i) (mβ i)] →
                [inst_3 : Preorder.{u_2} ι] →
                  (u : (i : ι) → Ω → β i) →
                    (∀ (i : ι), @MeasureTheory.StronglyMeasurable.{u_1, u_3} Ω (β i) (inst i) m (u i)) →
                      @MeasureTheory.Filtration.{u_1, u_2} Ω ι inst_3 m :=
fun {Ω} {ι} {m} {β} [inst : (i : ι) → TopologicalSpace.{u_3} (β i)]
    [inst_1 : ∀ (i : ι), @TopologicalSpace.MetrizableSpace.{u_3} (β i) (inst i)]
    [mβ : (i : ι) → MeasurableSpace.{u_3} (β i)] [inst_2 : ∀ (i : ι), @BorelSpace.{u_3} (β i) (inst i) (mβ i)]
    [inst_3 : Preorder.{u_2} ι] u hum =>
  @MeasureTheory.Filtration.mk.{u_1, u_2} Ω ι inst_3 m
    (fun i =>
      ⨆ j,
        ⨆ (_ : @LE.le.{u_2} ι (@Preorder.toLE.{u_2} ι inst_3) j i),
          @MeasurableSpace.comap.{u_1, u_3} Ω (β j) (u j) (mβ j))
    (@MeasureTheory.Filtration.natural._proof_2.{u_2, u_1, u_3} Ω ι β mβ inst_3 u) fun i =>
    @MeasureTheory.Filtration.natural._proof_1.{u_1, u_2, u_3} Ω ι m β inst inst_1 mβ inst_2 inst_3 u hum i
```

### `MeasureTheory.Filtration.rightCont`

Command: `#print MeasureTheory.Filtration.rightCont`

```lean
@[irreducible] def MeasureTheory.Filtration.rightCont.{u_3, u_4} : {Ω : Type u_3} →
  {ι : Type u_4} →
    {m : MeasurableSpace.{u_3} Ω} →
      [inst : PartialOrder.{u_4} ι] →
        @MeasureTheory.Filtration.{u_3, u_4} Ω ι (@PartialOrder.toPreorder.{u_4} ι inst) m →
          @MeasureTheory.Filtration.{u_3, u_4} Ω ι (@PartialOrder.toPreorder.{u_4} ι inst) m :=
MeasureTheory.Filtration.wrapped✝.{u_4, u_3}.1
```

### `MeasureTheory.Filtration.rightCont_def`

Command: `#print MeasureTheory.Filtration.rightCont_def`

```lean
theorem MeasureTheory.Filtration.rightCont_def.{u_3, u_4} : ∀ {Ω : Type u_3} {ι : Type u_4}
  {m : MeasurableSpace.{u_3} Ω} [inst : PartialOrder.{u_4} ι]
  (𝓕 : @MeasureTheory.Filtration.{u_3, u_4} Ω ι (@PartialOrder.toPreorder.{u_4} ι inst) m),
  @Eq.{max (u_3 + 1) (u_4 + 1)} (@MeasureTheory.Filtration.{u_3, u_4} Ω ι (@PartialOrder.toPreorder.{u_4} ι inst) m)
    (@MeasureTheory.Filtration.rightCont.{u_3, u_4} Ω ι m inst 𝓕)
    (@MeasureTheory.Filtration.mk.{u_3, u_4} Ω ι (@PartialOrder.toPreorder.{u_4} ι inst) m
      (fun i =>
        @ite.{u_3 + 1} (MeasurableSpace.{u_3} Ω)
          (@Filter.NeBot.{u_4} ι
            (@nhdsWithin.{u_4} ι (@Preorder.topology.{u_4} ι (@PartialOrder.toPreorder.{u_4} ι inst)) i
              (@Set.Ioi.{u_4} ι (@PartialOrder.toPreorder.{u_4} ι inst) i)))
          (Classical.propDecidable
            (@Filter.NeBot.{u_4} ι
              (@nhdsWithin.{u_4} ι (@Preorder.topology.{u_4} ι (@PartialOrder.toPreorder.{u_4} ι inst)) i
                (@Set.Ioi.{u_4} ι (@PartialOrder.toPreorder.{u_4} ι inst) i))))
          (⨅ j,
            ⨅ (_ : @GT.gt.{u_4} ι (@Preorder.toLT.{u_4} ι (@PartialOrder.toPreorder.{u_4} ι inst)) j i),
              @MeasureTheory.Filtration.seq.{u_3, u_4} Ω ι (@PartialOrder.toPreorder.{u_4} ι inst) m 𝓕 j)
          (@MeasureTheory.Filtration.seq.{u_3, u_4} Ω ι (@PartialOrder.toPreorder.{u_4} ι inst) m 𝓕 i))
      (fun i j hij => @MeasureTheory.Filtration.definition._proof_2✝.{u_3, u_4} Ω ι m inst 𝓕 i j hij) fun i =>
      @MeasureTheory.Filtration.definition._proof_3✝.{u_3, u_4} Ω ι m inst 𝓕 i) :=
fun {Ω} {ι} {m} [inst : PartialOrder.{u_4} ι] 𝓕 =>
  @id.{0}
    (@Eq.{max (u_3 + 1) (u_4 + 1)} (@MeasureTheory.Filtration.{u_3, u_4} Ω ι (@PartialOrder.toPreorder.{u_4} ι inst) m)
      (@MeasureTheory.Filtration.rightCont.{u_3, u_4} Ω ι m inst 𝓕)
      (@MeasureTheory.Filtration.mk.{u_3, u_4} Ω ι (@PartialOrder.toPreorder.{u_4} ι inst) m
        (fun i =>
          @ite.{u_3 + 1} (MeasurableSpace.{u_3} Ω)
            (@Filter.NeBot.{u_4} ι
              (@nhdsWithin.{u_4} ι (@Preorder.topology.{u_4} ι (@PartialOrder.toPreorder.{u_4} ι inst)) i
                (@Set.Ioi.{u_4} ι (@PartialOrder.toPreorder.{u_4} ι inst) i)))
            (Classical.propDecidable
              (@Filter.NeBot.{u_4} ι
                (@nhdsWithin.{u_4} ι (@Preorder.topology.{u_4} ι (@PartialOrder.toPreorder.{u_4} ι inst)) i
                  (@Set.Ioi.{u_4} ι (@PartialOrder.toPreorder.{u_4} ι inst) i))))
            (⨅ j,
              ⨅ (_ : @GT.gt.{u_4} ι (@Preorder.toLT.{u_4} ι (@PartialOrder.toPreorder.{u_4} ι inst)) j i),
                @MeasureTheory.Filtration.seq.{u_3, u_4} Ω ι (@PartialOrder.toPreorder.{u_4} ι inst) m 𝓕 j)
            (@MeasureTheory.Filtration.seq.{u_3, u_4} Ω ι (@PartialOrder.toPreorder.{u_4} ι inst) m 𝓕 i))
        (fun i j hij => @MeasureTheory.Filtration.definition._proof_2✝.{u_3, u_4} Ω ι m inst 𝓕 i j hij) fun i =>
        @MeasureTheory.Filtration.definition._proof_3✝.{u_3, u_4} Ω ι m inst 𝓕 i))
    (@Eq.mpr.{0}
      (@Eq.{max (u_3 + 1) (u_4 + 1)}
        (@MeasureTheory.Filtration.{u_3, u_4} Ω ι (@PartialOrder.toPreorder.{u_4} ι inst) m)
        (@MeasureTheory.Filtration.wrapped✝.{u_4, u_3}.1 Ω ι m inst 𝓕)
        (@MeasureTheory.Filtration.mk.{u_3, u_4} Ω ι (@PartialOrder.toPreorder.{u_4} ι inst) m
          (fun i =>
            @ite.{u_3 + 1} (MeasurableSpace.{u_3} Ω)
              (@Filter.NeBot.{u_4} ι
                (@nhdsWithin.{u_4} ι (@Preorder.topology.{u_4} ι (@PartialOrder.toPreorder.{u_4} ι inst)) i
                  (@Set.Ioi.{u_4} ι (@PartialOrder.toPreorder.{u_4} ι inst) i)))
              (Classical.propDecidable
                (@Filter.NeBot.{u_4} ι
                  (@nhdsWithin.{u_4} ι (@Preorder.topology.{u_4} ι (@PartialOrder.toPreorder.{u_4} ι inst)) i
                    (@Set.Ioi.{u_4} ι (@PartialOrder.toPreorder.{u_4} ι inst) i))))
              (⨅ j,
                ⨅ (_ : @GT.gt.{u_4} ι (@Preorder.toLT.{u_4} ι (@PartialOrder.toPreorder.{u_4} ι inst)) j i),
                  @MeasureTheory.Filtration.seq.{u_3, u_4} Ω ι (@PartialOrder.toPreorder.{u_4} ι inst) m 𝓕 j)
              (@MeasureTheory.Filtration.seq.{u_3, u_4} Ω ι (@PartialOrder.toPreorder.{u_4} ι inst) m 𝓕 i))
          (fun i j hij => @MeasureTheory.Filtration.definition._proof_2✝.{u_3, u_4} Ω ι m inst 𝓕 i j hij) fun i =>
          @MeasureTheory.Filtration.definition._proof_3✝.{u_3, u_4} Ω ι m inst 𝓕 i))
      (@Eq.{max (u_3 + 1) (u_4 + 1)}
        (@MeasureTheory.Filtration.{u_3, u_4} Ω ι (@PartialOrder.toPreorder.{u_4} ι inst) m)
        (@(@Subtype.mk.{max (u_3 + 2) (u_4 + 2)}
                ({Ω : Type u_3} →
                  {ι : Type u_4} →
                    {m : MeasurableSpace.{u_3} Ω} →
                      [inst : PartialOrder.{u_4} ι] →
                        @MeasureTheory.Filtration.{u_3, u_4} Ω ι (@PartialOrder.toPreorder.{u_4} ι inst) m →
                          @MeasureTheory.Filtration.{u_3, u_4} Ω ι (@PartialOrder.toPreorder.{u_4} ι inst) m)
                (@Eq.{max (u_4 + 2) (u_3 + 2)}
                  ({Ω : Type u_3} →
                    {ι : Type u_4} →
                      {m : MeasurableSpace.{u_3} Ω} →
                        [inst : PartialOrder.{u_4} ι] →
                          @MeasureTheory.Filtration.{u_3, u_4} Ω ι (@PartialOrder.toPreorder.{u_4} ι inst) m →
                            @MeasureTheory.Filtration.{u_3, u_4} Ω ι (@PartialOrder.toPreorder.{u_4} ι inst) m)
                  @MeasureTheory.Filtration.definition✝.{u_3, u_4})
                (@MeasureTheory.Filtration.definition✝.{u_3, u_4})
                (@rfl.{max (u_4 + 2) (u_3 + 2)}
                  ({Ω : Type u_3} →
                    {ι : Type u_4} →
                      {m : MeasurableSpace.{u_3} Ω} →
                        [inst : PartialOrder.{u_4} ι] →
                          @MeasureTheory.Filtration.{u_3, u_4} Ω ι (@PartialOrder.toPreorder.{u_4} ι inst) m →
                            @MeasureTheory.Filtration.{u_3, u_4} Ω ι (@PartialOrder.toPreorder.{u_4} ι inst) m)
                  @MeasureTheory.Filtration.definition✝.{u_3, u_4})).1
          Ω ι m inst 𝓕)
        (@MeasureTheory.Filtration.mk.{u_3, u_4} Ω ι (@PartialOrder.toPreorder.{u_4} ι inst) m
          (fun i =>
            @ite.{u_3 + 1} (MeasurableSpace.{u_3} Ω)
              (@Filter.NeBot.{u_4} ι
                (@nhdsWithin.{u_4} ι (@Preorder.topology.{u_4} ι (@PartialOrder.toPreorder.{u_4} ι inst)) i
                  (@Set.Ioi.{u_4} ι (@PartialOrder.toPreorder.{u_4} ι inst) i)))
              (Classical.propDecidable
                (@Filter.NeBot.{u_4} ι
                  (@nhdsWithin.{u_4} ι (@Preorder.topology.{u_4} ι (@PartialOrder.toPreorder.{u_4} ι inst)) i
                    (@Set.Ioi.{u_4} ι (@PartialOrder.toPreorder.{u_4} ι inst) i))))
              (⨅ j,
                ⨅ (_ : @GT.gt.{u_4} ι (@Preorder.toLT.{u_4} ι (@PartialOrder.toPreorder.{u_4} ι inst)) j i),
                  @MeasureTheory.Filtration.seq.{u_3, u_4} Ω ι (@PartialOrder.toPreorder.{u_4} ι inst) m 𝓕 j)
              (@MeasureTheory.Filtration.seq.{u_3, u_4} Ω ι (@PartialOrder.toPreorder.{u_4} ι inst) m 𝓕 i))
          (fun i j hij => @MeasureTheory.Filtration.definition._proof_2✝.{u_3, u_4} Ω ι m inst 𝓕 i j hij) fun i =>
          @MeasureTheory.Filtration.definition._proof_3✝.{u_3, u_4} Ω ι m inst 𝓕 i))
      (@id.{0}
        (@Eq.{1} Prop
          (@Eq.{max (u_3 + 1) (u_4 + 1)}
            (@MeasureTheory.Filtration.{u_3, u_4} Ω ι (@PartialOrder.toPreorder.{u_4} ι inst) m)
            (@MeasureTheory.Filtration.wrapped✝.{u_4, u_3}.1 Ω ι m inst 𝓕)
            (@MeasureTheory.Filtration.mk.{u_3, u_4} Ω ι (@PartialOrder.toPreorder.{u_4} ι inst) m
              (fun i =>
                @ite.{u_3 + 1} (MeasurableSpace.{u_3} Ω)
                  (@Filter.NeBot.{u_4} ι
                    (@nhdsWithin.{u_4} ι (@Preorder.topology.{u_4} ι (@PartialOrder.toPreorder.{u_4} ι inst)) i
                      (@Set.Ioi.{u_4} ι (@PartialOrder.toPreorder.{u_4} ι inst) i)))
                  (Classical.propDecidable
                    (@Filter.NeBot.{u_4} ι
                      (@nhdsWithin.{u_4} ι (@Preorder.topology.{u_4} ι (@PartialOrder.toPreorder.{u_4} ι inst)) i
                        (@Set.Ioi.{u_4} ι (@PartialOrder.toPreorder.{u_4} ι inst) i))))
                  (⨅ j,
                    ⨅ (_ : @GT.gt.{u_4} ι (@Preorder.toLT.{u_4} ι (@PartialOrder.toPreorder.{u_4} ι inst)) j i),
                      @MeasureTheory.Filtration.seq.{u_3, u_4} Ω ι (@PartialOrder.toPreorder.{u_4} ι inst) m 𝓕 j)
                  (@MeasureTheory.Filtration.seq.{u_3, u_4} Ω ι (@PartialOrder.toPreorder.{u_4} ι inst) m 𝓕 i))
              (fun i j hij => @MeasureTheory.Filtration.definition._proof_2✝.{u_3, u_4} Ω ι m inst 𝓕 i j hij) fun i =>
              @MeasureTheory.Filtration.definition._proof_3✝.{u_3, u_4} Ω ι m inst 𝓕 i))
          (@Eq.{max (u_3 + 1) (u_4 + 1)}
            (@MeasureTheory.Filtration.{u_3, u_4} Ω ι (@PartialOrder.toPreorder.{u_4} ι inst) m)
            (@(@Subtype.mk.{max (u_3 + 2) (u_4 + 2)}
                    ({Ω : Type u_3} →
                      {ι : Type u_4} →
                        {m : MeasurableSpace.{u_3} Ω} →
                          [inst : PartialOrder.{u_4} ι] →
                            @MeasureTheory.Filtration.{u_3, u_4} Ω ι (@PartialOrder.toPreorder.{u_4} ι inst) m →
                              @MeasureTheory.Filtration.{u_3, u_4} Ω ι (@PartialOrder.toPreorder.{u_4} ι inst) m)
                    (@Eq.{max (u_4 + 2) (u_3 + 2)}
                      ({Ω : Type u_3} →
                        {ι : Type u_4} →
                          {m : MeasurableSpace.{u_3} Ω} →
                            [inst : PartialOrder.{u_4} ι] →
                              @MeasureTheory.Filtration.{u_3, u_4} Ω ι (@PartialOrder.toPreorder.{u_4} ι inst) m →
                                @MeasureTheory.Filtration.{u_3, u_4} Ω ι (@PartialOrder.toPreorder.{u_4} ι inst) m)
                      @MeasureTheory.Filtration.definition✝.{u_3, u_4})
                    (@MeasureTheory.Filtration.definition✝.{u_3, u_4})
                    (@rfl.{max (u_4 + 2) (u_3 + 2)}
                      ({Ω : Type u_3} →
                        {ι : Type u_4} →
                          {m : MeasurableSpace.{u_3} Ω} →
                            [inst : PartialOrder.{u_4} ι] →
                              @MeasureTheory.Filtration.{u_3, u_4} Ω ι (@PartialOrder.toPreorder.{u_4} ι inst) m →
                                @MeasureTheory.Filtration.{u_3, u_4} Ω ι (@PartialOrder.toPreorder.{u_4} ι inst) m)
                      @MeasureTheory.Filtration.definition✝.{u_3, u_4})).1
              Ω ι m inst 𝓕)
            (@MeasureTheory.Filtration.mk.{u_3, u_4} Ω ι (@PartialOrder.toPreorder.{u_4} ι inst) m
              (fun i =>
                @ite.{u_3 + 1} (MeasurableSpace.{u_3} Ω)
                  (@Filter.NeBot.{u_4} ι
                    (@nhdsWithin.{u_4} ι (@Preorder.topology.{u_4} ι (@PartialOrder.toPreorder.{u_4} ι inst)) i
                      (@Set.Ioi.{u_4} ι (@PartialOrder.toPreorder.{u_4} ι inst) i)))
                  (Classical.propDecidable
                    (@Filter.NeBot.{u_4} ι
                      (@nhdsWithin.{u_4} ι (@Preorder.topology.{u_4} ι (@PartialOrder.toPreorder.{u_4} ι inst)) i
                        (@Set.Ioi.{u_4} ι (@PartialOrder.toPreorder.{u_4} ι inst) i))))
                  (⨅ j,
                    ⨅ (_ : @GT.gt.{u_4} ι (@Preorder.toLT.{u_4} ι (@PartialOrder.toPreorder.{u_4} ι inst)) j i),
                      @MeasureTheory.Filtration.seq.{u_3, u_4} Ω ι (@PartialOrder.toPreorder.{u_4} ι inst) m 𝓕 j)
                  (@MeasureTheory.Filtration.seq.{u_3, u_4} Ω ι (@PartialOrder.toPreorder.{u_4} ι inst) m 𝓕 i))
              (fun i j hij => @MeasureTheory.Filtration.definition._proof_2✝.{u_3, u_4} Ω ι m inst 𝓕 i j hij) fun i =>
              @MeasureTheory.Filtration.definition._proof_3✝.{u_3, u_4} Ω ι m inst 𝓕 i)))
        (@congrArg.{max 1 (u_4 + 2) (u_3 + 2), 1}
          (@Subtype.{max (u_4 + 2) (u_3 + 2)}
            ({Ω : Type u_3} →
              {ι : Type u_4} →
                {m : MeasurableSpace.{u_3} Ω} →
                  [inst : PartialOrder.{u_4} ι] →
                    @MeasureTheory.Filtration.{u_3, u_4} Ω ι (@PartialOrder.toPreorder.{u_4} ι inst) m →
                      @MeasureTheory.Filtration.{u_3, u_4} Ω ι (@PartialOrder.toPreorder.{u_4} ι inst) m)
            (@Eq.{max (u_4 + 2) (u_3 + 2)}
              ({Ω : Type u_3} →
                {ι : Type u_4} →
                  {m : MeasurableSpace.{u_3} Ω} →
                    [inst : PartialOrder.{u_4} ι] →
                      @MeasureTheory.Filtration.{u_3, u_4} Ω ι (@PartialOrder.toPreorder.{u_4} ι inst) m →
                        @MeasureTheory.Filtration.{u_3, u_4} Ω ι (@PartialOrder.toPreorder.{u_4} ι inst) m)
              @MeasureTheory.Filtration.definition✝.{u_3, u_4}))
          Prop MeasureTheory.Filtration.wrapped✝.{u_4, u_3}
          (@Subtype.mk.{max (u_3 + 2) (u_4 + 2)}
            ({Ω : Type u_3} →
              {ι : Type u_4} →
                {m : MeasurableSpace.{u_3} Ω} →
                  [inst : PartialOrder.{u_4} ι] →
                    @MeasureTheory.Filtration.{u_3, u_4} Ω ι (@PartialOrder.toPreorder.{u_4} ι inst) m →
                      @MeasureTheory.Filtration.{u_3, u_4} Ω ι (@PartialOrder.toPreorder.{u_4} ι inst) m)
            (@Eq.{max (u_4 + 2) (u_3 + 2)}
              ({Ω : Type u_3} →
                {ι : Type u_4} →
                  {m : MeasurableSpace.{u_3} Ω} →
                    [inst : PartialOrder.{u_4} ι] →
                      @MeasureTheory.Filtration.{u_3, u_4} Ω ι (@PartialOrder.toPreorder.{u_4} ι inst) m →
                        @MeasureTheory.Filtration.{u_3, u_4} Ω ι (@PartialOrder.toPreorder.{u_4} ι inst) m)
              @MeasureTheory.Filtration.definition✝.{u_3, u_4})
            (@MeasureTheory.Filtration.definition✝.{u_3, u_4})
            (@rfl.{max (u_4 + 2) (u_3 + 2)}
              ({Ω : Type u_3} →
                {ι : Type u_4} →
                  {m : MeasurableSpace.{u_3} Ω} →
                    [inst : PartialOrder.{u_4} ι] →
                      @MeasureTheory.Filtration.{u_3, u_4} Ω ι (@PartialOrder.toPreorder.{u_4} ι inst) m →
                        @MeasureTheory.Filtration.{u_3, u_4} Ω ι (@PartialOrder.toPreorder.{u_4} ι inst) m)
              @MeasureTheory.Filtration.definition✝.{u_3, u_4}))
          (fun _a =>
            @Eq.{max (u_3 + 1) (u_4 + 1)}
              (@MeasureTheory.Filtration.{u_3, u_4} Ω ι (@PartialOrder.toPreorder.{u_4} ι inst) m) (@_a.1 Ω ι m inst 𝓕)
              (@MeasureTheory.Filtration.mk.{u_3, u_4} Ω ι (@PartialOrder.toPreorder.{u_4} ι inst) m
                (fun i =>
                  @ite.{u_3 + 1} (MeasurableSpace.{u_3} Ω)
                    (@Filter.NeBot.{u_4} ι
                      (@nhdsWithin.{u_4} ι (@Preorder.topology.{u_4} ι (@PartialOrder.toPreorder.{u_4} ι inst)) i
                        (@Set.Ioi.{u_4} ι (@PartialOrder.toPreorder.{u_4} ι inst) i)))
                    (Classical.propDecidable
                      (@Filter.NeBot.{u_4} ι
                        (@nhdsWithin.{u_4} ι (@Preorder.topology.{u_4} ι (@PartialOrder.toPreorder.{u_4} ι inst)) i
                          (@Set.Ioi.{u_4} ι (@PartialOrder.toPreorder.{u_4} ι inst) i))))
                    (⨅ j,
                      ⨅ (_ : @GT.gt.{u_4} ι (@Preorder.toLT.{u_4} ι (@PartialOrder.toPreorder.{u_4} ι inst)) j i),
                        @MeasureTheory.Filtration.seq.{u_3, u_4} Ω ι (@PartialOrder.toPreorder.{u_4} ι inst) m 𝓕 j)
                    (@MeasureTheory.Filtration.seq.{u_3, u_4} Ω ι (@PartialOrder.toPreorder.{u_4} ι inst) m 𝓕 i))
                (fun i j hij => @MeasureTheory.Filtration.definition._proof_2✝.{u_3, u_4} Ω ι m inst 𝓕 i j hij) fun i =>
                @MeasureTheory.Filtration.definition._proof_3✝.{u_3, u_4} Ω ι m inst 𝓕 i))
          (have this :=
            @Subtype.ext.{max (u_4 + 2) (u_3 + 2)}
              ({Ω : Type u_3} →
                {ι : Type u_4} →
                  {m : MeasurableSpace.{u_3} Ω} →
                    [inst : PartialOrder.{u_4} ι] →
                      @MeasureTheory.Filtration.{u_3, u_4} Ω ι (@PartialOrder.toPreorder.{u_4} ι inst) m →
                        @MeasureTheory.Filtration.{u_3, u_4} Ω ι (@PartialOrder.toPreorder.{u_4} ι inst) m)
              (@Eq.{max (u_4 + 2) (u_3 + 2)}
                ({Ω : Type u_3} →
                  {ι : Type u_4} →
                    {m : MeasurableSpace.{u_3} Ω} →
                      [inst : PartialOrder.{u_4} ι] →
                        @MeasureTheory.Filtration.{u_3, u_4} Ω ι (@PartialOrder.toPreorder.{u_4} ι inst) m →
                          @MeasureTheory.Filtration.{u_3, u_4} Ω ι (@PartialOrder.toPreorder.{u_4} ι inst) m)
                @MeasureTheory.Filtration.definition✝.{u_3, u_4})
              MeasureTheory.Filtration.wrapped✝.{u_4, u_3}
              (@Subtype.mk.{max (u_3 + 2) (u_4 + 2)}
                ({Ω : Type u_3} →
                  {ι : Type u_4} →
                    {m : MeasurableSpace.{u_3} Ω} →
                      [inst : PartialOrder.{u_4} ι] →
                        @MeasureTheory.Filtration.{u_3, u_4} Ω ι (@PartialOrder.toPreorder.{u_4} ι inst) m →
                          @MeasureTheory.Filtration.{u_3, u_4} Ω ι (@PartialOrder.toPreorder.{u_4} ι inst) m)
                (@Eq.{max (u_4 + 2) (u_3 + 2)}
                  ({Ω : Type u_3} →
                    {ι : Type u_4} →
                      {m : MeasurableSpace.{u_3} Ω} →
                        [inst : PartialOrder.{u_4} ι] →
                          @MeasureTheory.Filtration.{u_3, u_4} Ω ι (@PartialOrder.toPreorder.{u_4} ι inst) m →
                            @MeasureTheory.Filtration.{u_3, u_4} Ω ι (@PartialOrder.toPreorder.{u_4} ι inst) m)
                  @MeasureTheory.Filtration.definition✝.{u_3, u_4})
                (@MeasureTheory.Filtration.definition✝.{u_3, u_4})
                (@rfl.{max (u_4 + 2) (u_3 + 2)}
                  ({Ω : Type u_3} →
                    {ι : Type u_4} →
                      {m : MeasurableSpace.{u_3} Ω} →
                        [inst : PartialOrder.{u_4} ι] →
                          @MeasureTheory.Filtration.{u_3, u_4} Ω ι (@PartialOrder.toPreorder.{u_4} ι inst) m →
                            @MeasureTheory.Filtration.{u_3, u_4} Ω ι (@PartialOrder.toPreorder.{u_4} ι inst) m)
                  @MeasureTheory.Filtration.definition✝.{u_3, u_4}))
              (@Eq.symm.{max (u_3 + 2) (u_4 + 2)}
                ({Ω : Type u_3} →
                  {ι : Type u_4} →
                    {m : MeasurableSpace.{u_3} Ω} →
                      [inst : PartialOrder.{u_4} ι] →
                        @MeasureTheory.Filtration.{u_3, u_4} Ω ι (@PartialOrder.toPreorder.{u_4} ι inst) m →
                          @MeasureTheory.Filtration.{u_3, u_4} Ω ι (@PartialOrder.toPreorder.{u_4} ι inst) m)
                (@MeasureTheory.Filtration.definition✝.{u_3, u_4})
                (@Subtype.val.{max (u_3 + 2) (u_4 + 2)}
                  ({Ω : Type u_3} →
                    {ι : Type u_4} →
                      {m : MeasurableSpace.{u_3} Ω} →
                        [inst : PartialOrder.{u_4} ι] →
                          @MeasureTheory.Filtration.{u_3, u_4} Ω ι (@PartialOrder.toPreorder.{u_4} ι inst) m →
                            @MeasureTheory.Filtration.{u_3, u_4} Ω ι (@PartialOrder.toPreorder.{u_4} ι inst) m)
                  (@Eq.{max (u_4 + 2) (u_3 + 2)}
                    ({Ω : Type u_3} →
                      {ι : Type u_4} →
                        {m : MeasurableSpace.{u_3} Ω} →
                          [inst : PartialOrder.{u_4} ι] →
                            @MeasureTheory.Filtration.{u_3, u_4} Ω ι (@PartialOrder.toPreorder.{u_4} ι inst) m →
                              @MeasureTheory.Filtration.{u_3, u_4} Ω ι (@PartialOrder.toPreorder.{u_4} ι inst) m)
                    @MeasureTheory.Filtration.definition✝.{u_3, u_4})
                  MeasureTheory.Filtration.wrapped✝.{u_4, u_3})
                (@Subtype.property.{max (u_3 + 2) (u_4 + 2)}
                  ({Ω : Type u_3} →
                    {ι : Type u_4} →
                      {m : MeasurableSpace.{u_3} Ω} →
                        [inst : PartialOrder.{u_4} ι] →
                          @MeasureTheory.Filtration.{u_3, u_4} Ω ι (@PartialOrder.toPreorder.{u_4} ι inst) m →
                            @MeasureTheory.Filtration.{u_3, u_4} Ω ι (@PartialOrder.toPreorder.{u_4} ι inst) m)
                  (@Eq.{max (u_4 + 2) (u_3 + 2)}
                    ({Ω : Type u_3} →
                      {ι : Type u_4} →
                        {m : MeasurableSpace.{u_3} Ω} →
                          [inst : PartialOrder.{u_4} ι] →
                            @MeasureTheory.Filtration.{u_3, u_4} Ω ι (@PartialOrder.toPreorder.{u_4} ι inst) m →
                              @MeasureTheory.Filtration.{u_3, u_4} Ω ι (@PartialOrder.toPreorder.{u_4} ι inst) m)
                    @MeasureTheory.Filtration.definition✝.{u_3, u_4})
                  MeasureTheory.Filtration.wrapped✝.{u_4, u_3}));
          this)))
      (@Eq.refl.{max (u_3 + 1) (u_4 + 1)}
        (@MeasureTheory.Filtration.{u_3, u_4} Ω ι (@PartialOrder.toPreorder.{u_4} ι inst) m)
        (@(@Subtype.mk.{max (u_3 + 2) (u_4 + 2)}
                ({Ω : Type u_3} →
                  {ι : Type u_4} →
                    {m : MeasurableSpace.{u_3} Ω} →
                      [inst : PartialOrder.{u_4} ι] →
                        @MeasureTheory.Filtration.{u_3, u_4} Ω ι (@PartialOrder.toPreorder.{u_4} ι inst) m →
                          @MeasureTheory.Filtration.{u_3, u_4} Ω ι (@PartialOrder.toPreorder.{u_4} ι inst) m)
                (@Eq.{max (u_4 + 2) (u_3 + 2)}
                  ({Ω : Type u_3} →
                    {ι : Type u_4} →
                      {m : MeasurableSpace.{u_3} Ω} →
                        [inst : PartialOrder.{u_4} ι] →
                          @MeasureTheory.Filtration.{u_3, u_4} Ω ι (@PartialOrder.toPreorder.{u_4} ι inst) m →
                            @MeasureTheory.Filtration.{u_3, u_4} Ω ι (@PartialOrder.toPreorder.{u_4} ι inst) m)
                  @MeasureTheory.Filtration.definition✝.{u_3, u_4})
                (@MeasureTheory.Filtration.definition✝.{u_3, u_4})
                (@rfl.{max (u_4 + 2) (u_3 + 2)}
                  ({Ω : Type u_3} →
                    {ι : Type u_4} →
                      {m : MeasurableSpace.{u_3} Ω} →
                        [inst : PartialOrder.{u_4} ι] →
                          @MeasureTheory.Filtration.{u_3, u_4} Ω ι (@PartialOrder.toPreorder.{u_4} ι inst) m →
                            @MeasureTheory.Filtration.{u_3, u_4} Ω ι (@PartialOrder.toPreorder.{u_4} ι inst) m)
                  @MeasureTheory.Filtration.definition✝.{u_3, u_4})).1
          Ω ι m inst 𝓕)))
'MeasureTheory.Filtration.rightCont_def' depends on axioms: [propext, Classical.choice.{u}, Quot.sound.{u}]
```

### `MeasureTheory.Filtration.rightCont_eq`

Command: `#print MeasureTheory.Filtration.rightCont_eq`

```lean
theorem MeasureTheory.Filtration.rightCont_eq.{u_1, u_2} : ∀ {Ω : Type u_1} {ι : Type u_2} {m : MeasurableSpace.{u_1} Ω}
  [inst : LinearOrder.{u_2} ι]
  [@DenselyOrdered.{u_2} ι
      (@Preorder.toLT.{u_2} ι
        (@PartialOrder.toPreorder.{u_2} ι
          (@SemilatticeInf.toPartialOrder.{u_2} ι
            (@Lattice.toSemilatticeInf.{u_2} ι
              (@DistribLattice.toLattice.{u_2} ι (@instDistribLatticeOfLinearOrder.{u_2} ι inst))))))]
  [@NoMaxOrder.{u_2} ι
      (@Preorder.toLT.{u_2} ι
        (@PartialOrder.toPreorder.{u_2} ι
          (@SemilatticeInf.toPartialOrder.{u_2} ι
            (@Lattice.toSemilatticeInf.{u_2} ι
              (@DistribLattice.toLattice.{u_2} ι (@instDistribLatticeOfLinearOrder.{u_2} ι inst))))))]
  (𝓕 :
    @MeasureTheory.Filtration.{u_1, u_2} Ω ι
      (@PartialOrder.toPreorder.{u_2} ι
        (@SemilatticeInf.toPartialOrder.{u_2} ι
          (@Lattice.toSemilatticeInf.{u_2} ι
            (@DistribLattice.toLattice.{u_2} ι (@instDistribLatticeOfLinearOrder.{u_2} ι inst)))))
      m)
  (i : ι),
  @Eq.{u_1 + 1} (MeasurableSpace.{u_1} Ω)
    (@MeasureTheory.Filtration.seq.{u_1, u_2} Ω ι
      (@PartialOrder.toPreorder.{u_2} ι
        (@SemilatticeInf.toPartialOrder.{u_2} ι
          (@Lattice.toSemilatticeInf.{u_2} ι
            (@DistribLattice.toLattice.{u_2} ι (@instDistribLatticeOfLinearOrder.{u_2} ι inst)))))
      m
      (@MeasureTheory.Filtration.rightCont.{u_1, u_2} Ω ι m
        (@SemilatticeInf.toPartialOrder.{u_2} ι
          (@Lattice.toSemilatticeInf.{u_2} ι
            (@DistribLattice.toLattice.{u_2} ι (@instDistribLatticeOfLinearOrder.{u_2} ι inst))))
        𝓕)
      i)
    (⨅ j,
      ⨅ (_ :
        @GT.gt.{u_2} ι
          (@Preorder.toLT.{u_2} ι
            (@PartialOrder.toPreorder.{u_2} ι
              (@SemilatticeInf.toPartialOrder.{u_2} ι
                (@Lattice.toSemilatticeInf.{u_2} ι
                  (@DistribLattice.toLattice.{u_2} ι (@instDistribLatticeOfLinearOrder.{u_2} ι inst))))))
          j i),
        @MeasureTheory.Filtration.seq.{u_1, u_2} Ω ι
          (@PartialOrder.toPreorder.{u_2} ι
            (@SemilatticeInf.toPartialOrder.{u_2} ι
              (@Lattice.toSemilatticeInf.{u_2} ι
                (@DistribLattice.toLattice.{u_2} ι (@instDistribLatticeOfLinearOrder.{u_2} ι inst)))))
          m 𝓕 j) :=
fun {Ω} {ι} {m} [inst : LinearOrder.{u_2} ι]
    [inst_1 :
      @DenselyOrdered.{u_2} ι
        (@Preorder.toLT.{u_2} ι
          (@PartialOrder.toPreorder.{u_2} ι
            (@SemilatticeInf.toPartialOrder.{u_2} ι
              (@Lattice.toSemilatticeInf.{u_2} ι
                (@DistribLattice.toLattice.{u_2} ι (@instDistribLatticeOfLinearOrder.{u_2} ι inst))))))]
    [inst_2 :
      @NoMaxOrder.{u_2} ι
        (@Preorder.toLT.{u_2} ι
          (@PartialOrder.toPreorder.{u_2} ι
            (@SemilatticeInf.toPartialOrder.{u_2} ι
              (@Lattice.toSemilatticeInf.{u_2} ι
                (@DistribLattice.toLattice.{u_2} ι (@instDistribLatticeOfLinearOrder.{u_2} ι inst))))))]
    𝓕 i =>
  @MeasureTheory.Filtration.rightCont_eq_of_not_isMax.{u_1, u_2} Ω ι m inst inst_1 𝓕 i
    (@not_isMax.{u_2} ι
      (@PartialOrder.toPreorder.{u_2} ι
        (@SemilatticeInf.toPartialOrder.{u_2} ι
          (@Lattice.toSemilatticeInf.{u_2} ι
            (@DistribLattice.toLattice.{u_2} ι (@instDistribLatticeOfLinearOrder.{u_2} ι inst)))))
      inst_2 i)
'MeasureTheory.Filtration.rightCont_eq' depends on axioms: [propext, Classical.choice.{u}, Quot.sound.{u}]
```

### `AmericanConvexity.Review.actualUsualFiltration_eq_iInf`

Command: `#print AmericanConvexity.Review.actualUsualFiltration_eq_iInf`

```lean
theorem AmericanConvexity.Review.actualUsualFiltration_eq_iInf : ∀ (t : NNReal),
  @Eq.{1} (MeasurableSpace.{0} (NNReal → Real))
    (@MeasureTheory.Filtration.seq.{0, 0} (NNReal → Real) NNReal
      (@PartialOrder.toPreorder.{0} NNReal NNReal.instPartialOrder)
      (@AmericanConvexity.Stopping.completedMeasurableSpace.{0} (NNReal → Real)
        (@MeasurableSpace.pi.{0, 0} NNReal (fun a => Real) fun a => Real.measurableSpace)
        ProbabilityTheory.gaussianLimit)
      AmericanConvexity.Stopping.brownianUsualFiltration t)
    (⨅ s,
      ⨅ (_ :
        @GT.gt.{0} NNReal (@Preorder.toLT.{0} NNReal (@PartialOrder.toPreorder.{0} NNReal NNReal.instPartialOrder)) s
          t),
        @MeasureTheory.Filtration.seq.{0, 0} (NNReal → Real) NNReal
          (@PartialOrder.toPreorder.{0} NNReal NNReal.instPartialOrder)
          (@AmericanConvexity.Stopping.completedMeasurableSpace.{0} (NNReal → Real)
            (@MeasurableSpace.pi.{0, 0} NNReal (fun a => Real) fun a => Real.measurableSpace)
            ProbabilityTheory.gaussianLimit)
          (@AmericanConvexity.Stopping.ambientNullAugmentation.{0} (NNReal → Real)
            (@AmericanConvexity.Stopping.completedMeasurableSpace.{0} (NNReal → Real)
              (@MeasurableSpace.pi.{0, 0} NNReal (fun a => Real) fun a => Real.measurableSpace)
              ProbabilityTheory.gaussianLimit)
            (@AmericanConvexity.Stopping.completedAmbientFiltration.{0} (NNReal → Real)
              (@MeasurableSpace.pi.{0, 0} NNReal (fun a => Real) fun a => Real.measurableSpace)
              ProbabilityTheory.gaussianLimit AmericanConvexity.Stopping.brownianFiltration)
            (@AmericanConvexity.Stopping.completedMeasure.{0} (NNReal → Real)
              (@MeasurableSpace.pi.{0, 0} NNReal (fun a => Real) fun a => Real.measurableSpace)
              ProbabilityTheory.gaussianLimit))
          s) :=
fun t =>
  @MeasureTheory.Filtration.rightCont_eq.{0, 0} (NNReal → Real) NNReal
    (@AmericanConvexity.Stopping.completedMeasurableSpace.{0} (NNReal → Real)
      (@MeasurableSpace.pi.{0, 0} NNReal (fun a => Real) fun a => Real.measurableSpace) ProbabilityTheory.gaussianLimit)
    NNReal.instLinearOrder NNReal.instDenselyOrdered
    (@IsStrictOrderedRing.toNoMaxOrder.{0} NNReal NNReal.instSemiring NNReal.instPartialOrder
      NNReal.instIsStrictOrderedRing_1)
    (@AmericanConvexity.Stopping.ambientNullAugmentation.{0} (NNReal → Real)
      (@AmericanConvexity.Stopping.completedMeasurableSpace.{0} (NNReal → Real)
        (@MeasurableSpace.pi.{0, 0} NNReal (fun a => Real) fun a => Real.measurableSpace)
        ProbabilityTheory.gaussianLimit)
      (@AmericanConvexity.Stopping.completedAmbientFiltration.{0} (NNReal → Real)
        (@MeasurableSpace.pi.{0, 0} NNReal (fun a => Real) fun a => Real.measurableSpace)
        ProbabilityTheory.gaussianLimit AmericanConvexity.Stopping.brownianFiltration)
      (@AmericanConvexity.Stopping.completedMeasure.{0} (NNReal → Real)
        (@MeasurableSpace.pi.{0, 0} NNReal (fun a => Real) fun a => Real.measurableSpace)
        ProbabilityTheory.gaussianLimit))
    t
'AmericanConvexity.Review.actualUsualFiltration_eq_iInf' depends on axioms: [propext,
 Classical.choice.{u},
 Quot.sound.{u}]
```

### `MeasureTheory.Filtration.const`

Command: `#print MeasureTheory.Filtration.const`

```lean
def MeasureTheory.Filtration.const.{u_1, u_2} : {Ω : Type u_1} →
  (ι : Type u_2) →
    {m : MeasurableSpace.{u_1} Ω} →
      [inst : Preorder.{u_2} ι] →
        (m' : MeasurableSpace.{u_1} Ω) →
          @LE.le.{u_1} (MeasurableSpace.{u_1} Ω) (@MeasurableSpace.instLE.{u_1} Ω) m' m →
            @MeasureTheory.Filtration.{u_1, u_2} Ω ι inst m :=
fun {Ω} ι {m} [inst : Preorder.{u_2} ι] m' hm' =>
  @MeasureTheory.Filtration.mk.{u_1, u_2} Ω ι inst m (fun x => m')
    (@MeasureTheory.Filtration.const._proof_1.{u_2, u_1} Ω ι inst m') fun x => hm'
```

### `AmericanConvexity.Stopping.completion_isProbabilityMeasure`

Command: `#print AmericanConvexity.Stopping.completion_isProbabilityMeasure`

```lean
theorem AmericanConvexity.Stopping.completion_isProbabilityMeasure.{u_1} : ∀ {Ω : Type u_1}
  [mΩ : MeasurableSpace.{u_1} Ω] (P : @MeasureTheory.Measure.{u_1} Ω mΩ)
  [@MeasureTheory.IsProbabilityMeasure.{u_1} Ω mΩ P],
  @MeasureTheory.IsProbabilityMeasure.{u_1} Ω (@AmericanConvexity.Stopping.completedMeasurableSpace.{u_1} Ω mΩ P)
    (@AmericanConvexity.Stopping.completedMeasure.{u_1} Ω mΩ P) :=
fun {Ω} [mΩ : MeasurableSpace.{u_1} Ω] P [inst : @MeasureTheory.IsProbabilityMeasure.{u_1} Ω mΩ P] =>
  @MeasureTheory.IsProbabilityMeasure.mk.{u_1} Ω (@AmericanConvexity.Stopping.completedMeasurableSpace.{u_1} Ω mΩ P)
    (@AmericanConvexity.Stopping.completedMeasure.{u_1} Ω mΩ P)
    (@id.{0}
      (@Eq.{1} ENNReal
        (@DFunLike.coe.{u_1 + 1, u_1 + 1, 1}
          (@MeasureTheory.Measure.{u_1} Ω (@AmericanConvexity.Stopping.completedMeasurableSpace.{u_1} Ω mΩ P))
          (Set.{u_1} Ω) (fun x => ENNReal)
          (@MeasureTheory.Measure.instFunLike.{u_1} Ω
            (@AmericanConvexity.Stopping.completedMeasurableSpace.{u_1} Ω mΩ P))
          (@AmericanConvexity.Stopping.completedMeasure.{u_1} Ω mΩ P) (@Set.univ.{u_1} Ω))
        (@OfNat.ofNat.{0} ENNReal (nat_lit 1) (@One.toOfNat1.{0} ENNReal ENNReal.instOne)))
      (@MeasureTheory.IsProbabilityMeasure.measure_univ.{u_1} Ω mΩ P inst))
```

### `ProbabilityTheory.IsProbabilityMeasure_gaussianLimit`

Command: `#print ProbabilityTheory.IsProbabilityMeasure_gaussianLimit`

```lean
theorem ProbabilityTheory.IsProbabilityMeasure_gaussianLimit : @MeasureTheory.IsProbabilityMeasure.{0} (NNReal → Real)
  (@MeasurableSpace.pi.{0, 0} NNReal (fun a => Real) fun a => Real.measurableSpace) ProbabilityTheory.gaussianLimit :=
@MeasureTheory.isProbabilityMeasure_projectiveLimit.{0, 0} NNReal (fun x => Real) (fun i => Real.measurableSpace)
  (fun i =>
    @UniformSpace.toTopologicalSpace.{0} Real (@PseudoMetricSpace.toUniformSpace.{0} Real Real.pseudoMetricSpace))
  (fun i => Real.borelSpace)
  (fun i =>
    @instPolishSpaceOfSeparableSpaceOfIsCompletelyMetrizableSpace.{0} Real
      (@UniformSpace.toTopologicalSpace.{0} Real (@PseudoMetricSpace.toUniformSpace.{0} Real Real.pseudoMetricSpace))
      (@TopologicalSpace.SecondCountableTopology.to_separableSpace.{0} Real
        (@UniformSpace.toTopologicalSpace.{0} Real (@PseudoMetricSpace.toUniformSpace.{0} Real Real.pseudoMetricSpace))
        instSecondCountableTopologyReal)
      (@TopologicalSpace.IsCompletelyMetrizableSpace.of_completeSpace_metrizable.{0} Real
        (@PseudoMetricSpace.toUniformSpace.{0} Real Real.pseudoMetricSpace) Real.instCompleteSpace
        (@EMetric.instIsCountablyGeneratedUniformity.{0} Real
          (@EMetricSpace.toPseudoEMetricSpace.{0} Real (@MetricSpace.toEMetricSpace.{0} Real Real.metricSpace)))
        (@T6Space.toT0Space.{0} Real
          (@UniformSpace.toTopologicalSpace.{0} Real
            (@PseudoMetricSpace.toUniformSpace.{0} Real Real.pseudoMetricSpace))
          (@instT6SpaceOfMetrizableSpace.{0} Real
            (@UniformSpace.toTopologicalSpace.{0} Real
              (@PseudoMetricSpace.toUniformSpace.{0} Real Real.pseudoMetricSpace))
            (@EMetricSpace.metrizableSpace.{0} Real (@MetricSpace.toEMetricSpace.{0} Real Real.metricSpace))))))
  (@instNonemptyOfInhabited.{1} NNReal NNReal.instInhabited) ProbabilityTheory.gaussianProjectiveFamily
  (fun i =>
    @ProbabilityTheory.IsGaussian.toIsProbabilityMeasure.{0} (↥i → Real)
      (@Pi.topologicalSpace.{0, 0} (↥i) (fun a => Real) fun i =>
        @UniformSpace.toTopologicalSpace.{0} Real (@PseudoMetricSpace.toUniformSpace.{0} Real Real.pseudoMetricSpace))
      (@Pi.addCommMonoid.{0, 0} (↥i) (fun a => Real) fun i => Real.instAddCommMonoid)
      (@Pi.Function.module.{0, 0, 0} (↥i) Real Real Real.semiring Real.instAddCommMonoid
        (@Semiring.toModule.{0} Real Real.semiring))
      (@MeasurableSpace.pi.{0, 0} (↥i) (fun a => Real) fun a => Real.measurableSpace)
      (ProbabilityTheory.gaussianProjectiveFamily i) (ProbabilityTheory.isGaussian_gaussianProjectiveFamily i))
  ProbabilityTheory.isProjectiveMeasureFamily_gaussianProjectiveFamily
```

### `AmericanConvexity.Review.actualMeasure_probability`

Command: `#print AmericanConvexity.Review.actualMeasure_probability`

```lean
theorem AmericanConvexity.Review.actualMeasure_probability : @MeasureTheory.IsProbabilityMeasure.{0} (NNReal → Real)
  (@AmericanConvexity.Stopping.completedMeasurableSpace.{0} (NNReal → Real)
    (@MeasurableSpace.pi.{0, 0} NNReal (fun a => Real) fun a => Real.measurableSpace) ProbabilityTheory.gaussianLimit)
  (@AmericanConvexity.Stopping.completedMeasure.{0} (NNReal → Real)
    (@MeasurableSpace.pi.{0, 0} NNReal (fun a => Real) fun a => Real.measurableSpace)
    ProbabilityTheory.gaussianLimit) :=
@inferInstance.{0}
  (@MeasureTheory.IsProbabilityMeasure.{0} (NNReal → Real)
    (@AmericanConvexity.Stopping.completedMeasurableSpace.{0} (NNReal → Real)
      (@MeasurableSpace.pi.{0, 0} NNReal (fun a => Real) fun a => Real.measurableSpace) ProbabilityTheory.gaussianLimit)
    (@AmericanConvexity.Stopping.completedMeasure.{0} (NNReal → Real)
      (@MeasurableSpace.pi.{0, 0} NNReal (fun a => Real) fun a => Real.measurableSpace)
      ProbabilityTheory.gaussianLimit))
  (@AmericanConvexity.Stopping.completion_isProbabilityMeasure.{0} (NNReal → Real)
    (@MeasurableSpace.pi.{0, 0} NNReal (fun a => Real) fun a => Real.measurableSpace) ProbabilityTheory.gaussianLimit
    ProbabilityTheory.IsProbabilityMeasure_gaussianLimit)
```

## 3. Brownian construction and the filtration distinction

### `ProbabilityTheory.gaussianLimit`

Command: `#print ProbabilityTheory.gaussianLimit`

```lean
def ProbabilityTheory.gaussianLimit : @MeasureTheory.Measure.{0} (NNReal → Real)
  (@MeasurableSpace.pi.{0, 0} NNReal (fun a => Real) fun a => Real.measurableSpace) :=
@MeasureTheory.projectiveLimit.{0, 0} NNReal (fun a => Real) (fun a => Real.measurableSpace)
  (fun i =>
    @UniformSpace.toTopologicalSpace.{0} Real (@PseudoMetricSpace.toUniformSpace.{0} Real Real.pseudoMetricSpace))
  (fun i => Real.borelSpace) ProbabilityTheory.gaussianLimit._proof_1 ProbabilityTheory.gaussianProjectiveFamily
  ProbabilityTheory.gaussianLimit._proof_2 ProbabilityTheory.isProjectiveMeasureFamily_gaussianProjectiveFamily
```

### `ProbabilityTheory.gaussianProjectiveFamily`

Command: `#print ProbabilityTheory.gaussianProjectiveFamily`

```lean
def ProbabilityTheory.gaussianProjectiveFamily : (I : Finset.{0} NNReal) →
  @MeasureTheory.Measure.{0} (↥I → Real)
    (@MeasurableSpace.pi.{0, 0} (↥I) (fun a => Real) fun a => Real.measurableSpace) :=
fun I =>
  @MeasureTheory.Measure.map.{0, 0}
    (WithLp.{0}
      (@OfNat.ofNat.{0} ENNReal (nat_lit 2)
        (@instOfNatAtLeastTwo.{0} ENNReal (nat_lit 2)
          (@AddMonoidWithOne.toNatCast.{0} ENNReal
            (@AddCommMonoidWithOne.toAddMonoidWithOne.{0} ENNReal ENNReal.instAddCommMonoidWithOne))
          ProbabilityTheory.gaussianProjectiveFamily._proof_1))
      (↥I → Real))
    (↥I → Real)
    (@WithLp.measurableSpace.{0}
      (@OfNat.ofNat.{0} ENNReal (nat_lit 2)
        (@instOfNatAtLeastTwo.{0} ENNReal (nat_lit 2)
          (@AddMonoidWithOne.toNatCast.{0} ENNReal
            (@AddCommMonoidWithOne.toAddMonoidWithOne.{0} ENNReal ENNReal.instAddCommMonoidWithOne))
          PiLp.innerProductSpace._proof_1))
      ((i : ↥I) → (fun x => Real) i) (@MeasurableSpace.pi.{0, 0} (↥I) (fun x => Real) fun a => Real.measurableSpace))
    (@MeasurableSpace.pi.{0, 0} (↥I) (fun a => Real) fun a => Real.measurableSpace)
    (@DFunLike.coe.{1, 1, 1}
      (@MeasurableEquiv.{0, 0}
        (WithLp.{0}
          (@OfNat.ofNat.{0} ENNReal (nat_lit 2)
            (@instOfNatAtLeastTwo.{0} ENNReal (nat_lit 2)
              (@AddMonoidWithOne.toNatCast.{0} ENNReal
                (@AddCommMonoidWithOne.toAddMonoidWithOne.{0} ENNReal ENNReal.instAddCommMonoidWithOne))
              ProbabilityTheory.gaussianProjectiveFamily._proof_1))
          (↥I → Real))
        (↥I → Real)
        (@WithLp.measurableSpace.{0}
          (@OfNat.ofNat.{0} ENNReal (nat_lit 2)
            (@instOfNatAtLeastTwo.{0} ENNReal (nat_lit 2)
              (@AddMonoidWithOne.toNatCast.{0} ENNReal
                (@AddCommMonoidWithOne.toAddMonoidWithOne.{0} ENNReal ENNReal.instAddCommMonoidWithOne))
              ProbabilityTheory.gaussianProjectiveFamily._proof_1))
          (↥I → Real) (@MeasurableSpace.pi.{0, 0} (↥I) (fun a => Real) fun a => Real.measurableSpace))
        (@MeasurableSpace.pi.{0, 0} (↥I) (fun a => Real) fun a => Real.measurableSpace))
      (WithLp.{0}
        (@OfNat.ofNat.{0} ENNReal (nat_lit 2)
          (@instOfNatAtLeastTwo.{0} ENNReal (nat_lit 2)
            (@AddMonoidWithOne.toNatCast.{0} ENNReal
              (@AddCommMonoidWithOne.toAddMonoidWithOne.{0} ENNReal ENNReal.instAddCommMonoidWithOne))
            ProbabilityTheory.gaussianProjectiveFamily._proof_1))
        (↥I → Real))
      (fun x => ↥I → Real)
      (@EquivLike.toFunLike.{1, 1, 1}
        (@MeasurableEquiv.{0, 0}
          (WithLp.{0}
            (@OfNat.ofNat.{0} ENNReal (nat_lit 2)
              (@instOfNatAtLeastTwo.{0} ENNReal (nat_lit 2)
                (@AddMonoidWithOne.toNatCast.{0} ENNReal
                  (@AddCommMonoidWithOne.toAddMonoidWithOne.{0} ENNReal ENNReal.instAddCommMonoidWithOne))
                ProbabilityTheory.gaussianProjectiveFamily._proof_1))
            (↥I → Real))
          (↥I → Real)
          (@WithLp.measurableSpace.{0}
            (@OfNat.ofNat.{0} ENNReal (nat_lit 2)
              (@instOfNatAtLeastTwo.{0} ENNReal (nat_lit 2)
                (@AddMonoidWithOne.toNatCast.{0} ENNReal
                  (@AddCommMonoidWithOne.toAddMonoidWithOne.{0} ENNReal ENNReal.instAddCommMonoidWithOne))
                ProbabilityTheory.gaussianProjectiveFamily._proof_1))
            (↥I → Real) (@MeasurableSpace.pi.{0, 0} (↥I) (fun a => Real) fun a => Real.measurableSpace))
          (@MeasurableSpace.pi.{0, 0} (↥I) (fun a => Real) fun a => Real.measurableSpace))
        (WithLp.{0}
          (@OfNat.ofNat.{0} ENNReal (nat_lit 2)
            (@instOfNatAtLeastTwo.{0} ENNReal (nat_lit 2)
              (@AddMonoidWithOne.toNatCast.{0} ENNReal
                (@AddCommMonoidWithOne.toAddMonoidWithOne.{0} ENNReal ENNReal.instAddCommMonoidWithOne))
              ProbabilityTheory.gaussianProjectiveFamily._proof_1))
          (↥I → Real))
        (↥I → Real)
        (@MeasurableEquiv.instEquivLike.{0, 0}
          (WithLp.{0}
            (@OfNat.ofNat.{0} ENNReal (nat_lit 2)
              (@instOfNatAtLeastTwo.{0} ENNReal (nat_lit 2)
                (@AddMonoidWithOne.toNatCast.{0} ENNReal
                  (@AddCommMonoidWithOne.toAddMonoidWithOne.{0} ENNReal ENNReal.instAddCommMonoidWithOne))
                ProbabilityTheory.gaussianProjectiveFamily._proof_1))
            (↥I → Real))
          (↥I → Real)
          (@WithLp.measurableSpace.{0}
            (@OfNat.ofNat.{0} ENNReal (nat_lit 2)
              (@instOfNatAtLeastTwo.{0} ENNReal (nat_lit 2)
                (@AddMonoidWithOne.toNatCast.{0} ENNReal
                  (@AddCommMonoidWithOne.toAddMonoidWithOne.{0} ENNReal ENNReal.instAddCommMonoidWithOne))
                ProbabilityTheory.gaussianProjectiveFamily._proof_1))
            (↥I → Real) (@MeasurableSpace.pi.{0, 0} (↥I) (fun a => Real) fun a => Real.measurableSpace))
          (@MeasurableSpace.pi.{0, 0} (↥I) (fun a => Real) fun a => Real.measurableSpace)))
      (@MeasurableEquiv.symm.{0, 0} (↥I → Real)
        (WithLp.{0}
          (@OfNat.ofNat.{0} ENNReal (nat_lit 2)
            (@instOfNatAtLeastTwo.{0} ENNReal (nat_lit 2)
              (@AddMonoidWithOne.toNatCast.{0} ENNReal
                (@AddCommMonoidWithOne.toAddMonoidWithOne.{0} ENNReal ENNReal.instAddCommMonoidWithOne))
              ProbabilityTheory.gaussianProjectiveFamily._proof_1))
          (↥I → Real))
        (@MeasurableSpace.pi.{0, 0} (↥I) (fun a => Real) fun a => Real.measurableSpace)
        (@WithLp.measurableSpace.{0}
          (@OfNat.ofNat.{0} ENNReal (nat_lit 2)
            (@instOfNatAtLeastTwo.{0} ENNReal (nat_lit 2)
              (@AddMonoidWithOne.toNatCast.{0} ENNReal
                (@AddCommMonoidWithOne.toAddMonoidWithOne.{0} ENNReal ENNReal.instAddCommMonoidWithOne))
              ProbabilityTheory.gaussianProjectiveFamily._proof_1))
          (↥I → Real) (@MeasurableSpace.pi.{0, 0} (↥I) (fun a => Real) fun a => Real.measurableSpace))
        (@MeasurableEquiv.toLp.{0}
          (@OfNat.ofNat.{0} ENNReal (nat_lit 2)
            (@instOfNatAtLeastTwo.{0} ENNReal (nat_lit 2)
              (@AddMonoidWithOne.toNatCast.{0} ENNReal
                (@AddCommMonoidWithOne.toAddMonoidWithOne.{0} ENNReal ENNReal.instAddCommMonoidWithOne))
              ProbabilityTheory.gaussianProjectiveFamily._proof_1))
          (↥I → Real) (@MeasurableSpace.pi.{0, 0} (↥I) (fun a => Real) fun a => Real.measurableSpace))))
    (@ProbabilityTheory.multivariateGaussian.{0} (↥I) (@Finset.Subtype.fintype.{0} NNReal I)
      (fun a b =>
        @Subtype.instDecidableEq.{1} NNReal
          (@Membership.mem.{0, 0} NNReal (Finset.{0} NNReal)
            (@SetLike.instMembership.{0, 0} (Finset.{0} NNReal) NNReal (@Finset.instSetLike.{0} NNReal)) I)
          (fun a b => @LinearOrder.toDecidableEq.{0} NNReal NNReal.instLinearOrder a b) a b)
      (@OfNat.ofNat.{0} (EuclideanSpace.{0, 0} Real ↥I) (nat_lit 0)
        (@Zero.toOfNat0.{0} (EuclideanSpace.{0, 0} Real ↥I)
          (@NegZeroClass.toZero.{0} (EuclideanSpace.{0, 0} Real ↥I)
            (@SubNegZeroMonoid.toNegZeroClass.{0} (EuclideanSpace.{0, 0} Real ↥I)
              (@SubtractionMonoid.toSubNegZeroMonoid.{0} (EuclideanSpace.{0, 0} Real ↥I)
                (@SubtractionCommMonoid.toSubtractionMonoid.{0} (EuclideanSpace.{0, 0} Real ↥I)
                  (@AddCommGroup.toDivisionAddCommMonoid.{0} (EuclideanSpace.{0, 0} Real ↥I)
                    (@WithLp.instAddCommGroup.{0}
                      (@OfNat.ofNat.{0} ENNReal (nat_lit 2)
                        (@instOfNatAtLeastTwo.{0} ENNReal (nat_lit 2)
                          (@AddMonoidWithOne.toNatCast.{0} ENNReal
                            (@AddCommMonoidWithOne.toAddMonoidWithOne.{0} ENNReal ENNReal.instAddCommMonoidWithOne))
                          PiLp.innerProductSpace._proof_1))
                      ((i : ↥I) → (fun x => Real) i)
                      (@Pi.addCommGroup.{0, 0} (↥I) (fun x => Real) fun i => Real.instAddCommGroup)))))))))
      (ProbabilityTheory.brownianCovMatrix I))
```

### `ProbabilityTheory.brownianCovMatrix`

Command: `#print ProbabilityTheory.brownianCovMatrix`

```lean
def ProbabilityTheory.brownianCovMatrix : (I : Finset.{0} NNReal) → Matrix.{0, 0, 0} (↥I) (↥I) Real :=
fun I =>
  @DFunLike.coe.{1, 1, 1} (Equiv.{1, 1} (↥I → ↥I → Real) (Matrix.{0, 0, 0} (↥I) (↥I) Real)) (↥I → ↥I → Real)
    (fun x => Matrix.{0, 0, 0} (↥I) (↥I) Real)
    (@EquivLike.toFunLike.{1, 1, 1} (Equiv.{1, 1} (↥I → ↥I → Real) (Matrix.{0, 0, 0} (↥I) (↥I) Real)) (↥I → ↥I → Real)
      (Matrix.{0, 0, 0} (↥I) (↥I) Real)
      (@Equiv.instEquivLike.{1, 1} (↥I → ↥I → Real) (Matrix.{0, 0, 0} (↥I) (↥I) Real)))
    (@Matrix.of.{0, 0, 0} (↥I) (↥I) Real) fun s t =>
    @Min.min.{0} Real Real.instMin
      ↑(@Subtype.val.{1} NNReal
          (fun x =>
            @Membership.mem.{0, 0} NNReal (Finset.{0} NNReal)
              (@SetLike.instMembership.{0, 0} (Finset.{0} NNReal) NNReal (@Finset.instSetLike.{0} NNReal)) I x)
          s)
      ↑(@Subtype.val.{1} NNReal
          (fun x =>
            @Membership.mem.{0, 0} NNReal (Finset.{0} NNReal)
              (@SetLike.instMembership.{0, 0} (Finset.{0} NNReal) NNReal (@Finset.instSetLike.{0} NNReal)) I x)
          t)
```

### `MeasureTheory.projectiveLimit`

Command: `#print MeasureTheory.projectiveLimit`

```lean
def MeasureTheory.projectiveLimit.{u_1, u_2} : {ι : Type u_1} →
  {α : ι → Type u_2} →
    [inst : (i : ι) → MeasurableSpace.{u_2} (α i)] →
      [inst_1 : (i : ι) → TopologicalSpace.{u_2} (α i)] →
        [∀ (i : ι), @BorelSpace.{u_2} (α i) (inst_1 i) (inst i)] →
          [∀ (i : ι), @PolishSpace.{u_2} (α i) (inst_1 i)] →
            (P :
                (J : Finset.{u_1} ι) →
                  @MeasureTheory.Measure.{max u_1 u_2}
                    ((j : ↥J) →
                      α
                        (@Subtype.val.{u_1 + 1} ι
                          (fun x =>
                            @Membership.mem.{u_1, u_1} ι (Finset.{u_1} ι)
                              (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} ι) ι (@Finset.instSetLike.{u_1} ι)) J x)
                          j))
                    (@MeasurableSpace.pi.{u_1, u_2} (↥J)
                      (fun j =>
                        α
                          (@Subtype.val.{u_1 + 1} ι
                            (fun x =>
                              @Membership.mem.{u_1, u_1} ι (Finset.{u_1} ι)
                                (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} ι) ι (@Finset.instSetLike.{u_1} ι)) J
                                x)
                            j))
                      fun a =>
                      inst
                        (@Subtype.val.{u_1 + 1} ι
                          (fun x =>
                            @Membership.mem.{u_1, u_1} ι (Finset.{u_1} ι)
                              (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} ι) ι (@Finset.instSetLike.{u_1} ι)) J x)
                          a))) →
              [∀ (i : Finset.{u_1} ι),
                    @MeasureTheory.IsFiniteMeasure.{max u_1 u_2}
                      ((j : ↥i) →
                        α
                          (@Subtype.val.{u_1 + 1} ι
                            (fun x =>
                              @Membership.mem.{u_1, u_1} ι (Finset.{u_1} ι)
                                (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} ι) ι (@Finset.instSetLike.{u_1} ι)) i
                                x)
                            j))
                      (@MeasurableSpace.pi.{u_1, u_2} (↥i)
                        (fun j =>
                          α
                            (@Subtype.val.{u_1 + 1} ι
                              (fun x =>
                                @Membership.mem.{u_1, u_1} ι (Finset.{u_1} ι)
                                  (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} ι) ι (@Finset.instSetLike.{u_1} ι))
                                  i x)
                              j))
                        fun a =>
                        inst
                          (@Subtype.val.{u_1 + 1} ι
                            (fun x =>
                              @Membership.mem.{u_1, u_1} ι (Finset.{u_1} ι)
                                (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} ι) ι (@Finset.instSetLike.{u_1} ι)) i
                                x)
                            a))
                      (P i)] →
                @MeasureTheory.IsProjectiveMeasureFamily.{u_1, u_2} ι α inst P →
                  @MeasureTheory.Measure.{max u_1 u_2} ((i : ι) → α i) (@MeasurableSpace.pi.{u_1, u_2} ι α inst) :=
fun {ι} {α} [inst : (i : ι) → MeasurableSpace.{u_2} (α i)] [inst_1 : (i : ι) → TopologicalSpace.{u_2} (α i)]
    [inst_2 : ∀ (i : ι), @BorelSpace.{u_2} (α i) (inst_1 i) (inst i)]
    [inst_3 : ∀ (i : ι), @PolishSpace.{u_2} (α i) (inst_1 i)] P
    [inst_4 :
      ∀ (i : Finset.{u_1} ι),
        @MeasureTheory.IsFiniteMeasure.{max u_1 u_2}
          ((j : ↥i) →
            α
              (@Subtype.val.{u_1 + 1} ι
                (fun x =>
                  @Membership.mem.{u_1, u_1} ι (Finset.{u_1} ι)
                    (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} ι) ι (@Finset.instSetLike.{u_1} ι)) i x)
                j))
          (@MeasurableSpace.pi.{u_1, u_2} (↥i)
            (fun j =>
              α
                (@Subtype.val.{u_1 + 1} ι
                  (fun x =>
                    @Membership.mem.{u_1, u_1} ι (Finset.{u_1} ι)
                      (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} ι) ι (@Finset.instSetLike.{u_1} ι)) i x)
                  j))
            fun a =>
            inst
              (@Subtype.val.{u_1 + 1} ι
                (fun x =>
                  @Membership.mem.{u_1, u_1} ι (Finset.{u_1} ι)
                    (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} ι) ι (@Finset.instSetLike.{u_1} ι)) i x)
                a))
          (P i)]
    hP =>
  @MeasureTheory.AddContent.measure.{max u_1 u_2} ((i : ι) → α i)
    (@MeasureTheory.measurableCylinders.{u_2, u_1} ι α inst) (@MeasurableSpace.pi.{u_1, u_2} ι α inst)
    (@MeasureTheory.projectiveFamilyContent.{u_1, u_2} ι α inst P hP)
    (@MeasureTheory.isSetSemiring_measurableCylinders.{u_1, u_2} ι α inst)
    (@MeasureTheory.projectiveLimitWithWeakestHypotheses._proof_1.{u_2, u_1} ι α inst)
    (@MeasureTheory.projectiveFamilyContent_iUnion_le_sum.{u_1, u_2} ι α inst P inst_1 inst_2 inst_3 inst_4 hP)
```

### `ProbabilityTheory.brownian`

Command: `#print ProbabilityTheory.brownian`

```lean
def ProbabilityTheory.brownian : NNReal → (NNReal → Real) → Real :=
@ProbabilityTheory.IsPreBrownianReal.mk.{0} (NNReal → Real)
  (@MeasurableSpace.pi.{0, 0} NNReal (fun a => Real) fun a => Real.measurableSpace) ProbabilityTheory.gaussianLimit
  ProbabilityTheory.preBrownian ProbabilityTheory.isPreBrownianReal_preBrownian
```

### `ProbabilityTheory.preBrownian`

Command: `#print ProbabilityTheory.preBrownian`

```lean
def ProbabilityTheory.preBrownian : NNReal → (NNReal → Real) → Real :=
fun t ω => ω t
```

### `ProbabilityTheory.IsPreBrownianReal.mk`

Command: `#print ProbabilityTheory.IsPreBrownianReal.mk`

```lean
protected def ProbabilityTheory.IsPreBrownianReal.mk.{u_2} : {Ω : Type u_2} →
  {mΩ : MeasurableSpace.{u_2} Ω} →
    {P : @MeasureTheory.Measure.{u_2} Ω mΩ} →
      (X : NNReal → Ω → Real) → @ProbabilityTheory.IsPreBrownianReal.{u_2} Ω mΩ X P → NNReal → Ω → Real :=
fun {Ω} {mΩ} {P} X h =>
  @Exists.choose.{u_2 + 1} (NNReal → Ω → Real)
    (fun Y =>
      And (∀ (t : NNReal), @Measurable.{u_2, 0} Ω Real mΩ Real.measurableSpace (Y t))
        (And
          (∀ (t : NNReal),
            @Filter.EventuallyEq.{u_2, 0} Ω Real
              (@MeasureTheory.ae.{u_2, u_2} Ω (@MeasureTheory.Measure.{u_2} Ω mΩ)
                (@MeasureTheory.Measure.instFunLike.{u_2} Ω mΩ)
                (@MeasureTheory.Measure.instOuterMeasureClass.{u_2} Ω mΩ) P)
              (Y t) (X t))
          (∀ (ω : Ω) (t β : NNReal),
            @LT.lt.{0} NNReal (@Preorder.toLT.{0} NNReal (@PartialOrder.toPreorder.{0} NNReal NNReal.instPartialOrder))
                (@OfNat.ofNat.{0} NNReal (nat_lit 0) (@Zero.toOfNat0.{0} NNReal NNReal.instZero)) β →
              @LT.lt.{0} Real Real.instLT (↑β)
                  (⨆ n,
                    @HDiv.hDiv.{0, 0, 0} Real Real Real
                      (@instHDiv.{0} Real (@DivInvMonoid.toDiv.{0} Real Real.instDivInvMonoid))
                      (@HSub.hSub.{0, 0, 0} Real Real Real (@instHSub.{0} Real Real.instSub)
                        (@Nat.cast.{0} Real Real.instNatCast
                          (@HAdd.hAdd.{0, 0, 0} Nat Nat Nat (@instHAdd.{0} Nat instAddNat) n
                            (@OfNat.ofNat.{0} Nat (nat_lit 2) (instOfNatNat (nat_lit 2)))))
                        (@OfNat.ofNat.{0} Real (nat_lit 1) (@One.toOfNat1.{0} Real Real.instOne)))
                      (@HMul.hMul.{0, 0, 0} Real Real Real (@instHMul.{0} Real Real.instMul)
                        (@OfNat.ofNat.{0} Real (nat_lit 2)
                          (@instOfNatAtLeastTwo.{0} Real (nat_lit 2) Real.instNatCast
                            ProbabilityTheory.IsPreBrownianReal.mk._proof_1))
                        (@Nat.cast.{0} Real Real.instNatCast
                          (@HAdd.hAdd.{0, 0, 0} Nat Nat Nat (@instHAdd.{0} Nat instAddNat) n
                            (@OfNat.ofNat.{0} Nat (nat_lit 2) (instOfNatNat (nat_lit 2))))))) →
                ∃ U,
                  And
                    (@Membership.mem.{0, 0} (Set.{0} NNReal) (Filter.{0} NNReal) (@Filter.instMembership.{0} NNReal)
                      (@nhds.{0} NNReal NNReal.instTopologicalSpace t) U)
                    (∃ C,
                      @HolderOnWith.{0, 0} NNReal Real
                        (@EMetricSpace.toPseudoEMetricSpace.{0} NNReal
                          (@MetricSpace.toEMetricSpace.{0} NNReal instMetricSpaceNNReal))
                        (@EMetricSpace.toPseudoEMetricSpace.{0} Real
                          (@MetricSpace.toEMetricSpace.{0} Real Real.metricSpace))
                        C β (fun x => Y x ω) U))))
    (@ProbabilityTheory.IsPreBrownianReal.exists_continuous_modification.{u_2} Ω mΩ X P h)
```

### `ProbabilityTheory.isBrownianReal_brownian`

Command: `#print ProbabilityTheory.isBrownianReal_brownian`

```lean
theorem ProbabilityTheory.isBrownianReal_brownian : @ProbabilityTheory.IsBrownianReal.{0} (NNReal → Real)
  (@MeasurableSpace.pi.{0, 0} NNReal (fun a => Real) fun a => Real.measurableSpace) ProbabilityTheory.brownian
  ProbabilityTheory.gaussianLimit :=
@ProbabilityTheory.IsPreBrownianReal.isBrownianReal_mk.{0} (NNReal → Real)
  (@MeasurableSpace.pi.{0, 0} NNReal (fun a => Real) fun a => Real.measurableSpace) ProbabilityTheory.gaussianLimit
  ProbabilityTheory.preBrownian ProbabilityTheory.isPreBrownianReal_preBrownian
```

### `ProbabilityTheory.IsBrownianReal`

Command: `#print ProbabilityTheory.IsBrownianReal`

```lean
structure ProbabilityTheory.IsBrownianReal.{u_1} {Ω : Type u_1} {mΩ : MeasurableSpace.{u_1} Ω} (X : NNReal → Ω → Real)
  (P : @MeasureTheory.Measure.{u_1} Ω mΩ := by volume_tac) : Prop
number of parameters: 4
parents:
  ProbabilityTheory.IsBrownianReal.toIsPreBrownianReal.{u_1} : @ProbabilityTheory.IsPreBrownianReal.{u_1} Ω mΩ X P
fields:
  ProbabilityTheory.IsPreBrownianReal.hasLaw.{u_1} : ∀ (I : Finset.{0} NNReal),
      @ProbabilityTheory.HasLaw.{u_1, 0} Ω (↥I → Real) mΩ
        (@MeasurableSpace.pi.{0, 0} (↥I) (fun a => Real) fun a => Real.measurableSpace)
        (fun ω => @Finset.restrict.{0, 0} NNReal (fun x => Real) I fun x => X x ω)
        (ProbabilityTheory.BrownianReal.projectiveFamily I) P
  ProbabilityTheory.IsBrownianReal.cont.{u_1} : @Filter.Eventually.{u_1} Ω
      (fun ω =>
        @Continuous.{0, 0} NNReal Real NNReal.instTopologicalSpace
          (@UniformSpace.toTopologicalSpace.{0} Real
            (@PseudoMetricSpace.toUniformSpace.{0} Real Real.pseudoMetricSpace))
          fun x => X x ω)
      (@MeasureTheory.ae.{u_1, u_1} Ω
        (autoParam.{u_1 + 1} (@MeasureTheory.Measure.{u_1} Ω mΩ) ProbabilityTheory.IsBrownianReal._auto_1)
        (@MeasureTheory.Measure.instFunLike.{u_1} Ω mΩ) (@MeasureTheory.Measure.instOuterMeasureClass.{u_1} Ω mΩ) P)
constructor:
  ProbabilityTheory.IsBrownianReal.mk.{u_1} {Ω : Type u_1} {mΩ : MeasurableSpace.{u_1} Ω} {X : NNReal → Ω → Real}
    {P : autoParam.{u_1 + 1} (@MeasureTheory.Measure.{u_1} Ω mΩ) ProbabilityTheory.IsBrownianReal._auto_1}
    (toIsPreBrownianReal : @ProbabilityTheory.IsPreBrownianReal.{u_1} Ω mΩ X P)
    (cont :
      @Filter.Eventually.{u_1} Ω
        (fun ω =>
          @Continuous.{0, 0} NNReal Real NNReal.instTopologicalSpace
            (@UniformSpace.toTopologicalSpace.{0} Real
              (@PseudoMetricSpace.toUniformSpace.{0} Real Real.pseudoMetricSpace))
            fun x => X x ω)
        (@MeasureTheory.ae.{u_1, u_1} Ω
          (autoParam.{u_1 + 1} (@MeasureTheory.Measure.{u_1} Ω mΩ) ProbabilityTheory.IsBrownianReal._auto_1)
          (@MeasureTheory.Measure.instFunLike.{u_1} Ω mΩ) (@MeasureTheory.Measure.instOuterMeasureClass.{u_1} Ω mΩ)
          P)) :
    @ProbabilityTheory.IsBrownianReal.{u_1} Ω mΩ X P
field notation resolution order:
  ProbabilityTheory.IsBrownianReal.{u_1}, ProbabilityTheory.IsPreBrownianReal.{u_1}
```

### `ProbabilityTheory.IsPreBrownianReal`

Command: `#print ProbabilityTheory.IsPreBrownianReal`

```lean
structure ProbabilityTheory.IsPreBrownianReal.{u_1} {Ω : Type u_1} {mΩ : MeasurableSpace.{u_1} Ω}
  (X : NNReal → Ω → Real) (P : @MeasureTheory.Measure.{u_1} Ω mΩ := by volume_tac) : Prop
number of parameters: 4
fields:
  ProbabilityTheory.IsPreBrownianReal.hasLaw.{u_1} : ∀ (I : Finset.{0} NNReal),
      @ProbabilityTheory.HasLaw.{u_1, 0} Ω (↥I → Real) mΩ
        (@MeasurableSpace.pi.{0, 0} (↥I) (fun a => Real) fun a => Real.measurableSpace)
        (fun ω => @Finset.restrict.{0, 0} NNReal (fun x => Real) I fun x => X x ω)
        (ProbabilityTheory.BrownianReal.projectiveFamily I) P
constructor:
  ProbabilityTheory.IsPreBrownianReal.mk'.{u_1} {Ω : Type u_1} {mΩ : MeasurableSpace.{u_1} Ω} {X : NNReal → Ω → Real}
    {P : autoParam.{u_1 + 1} (@MeasureTheory.Measure.{u_1} Ω mΩ) ProbabilityTheory.IsPreBrownianReal._auto_1}
    (hasLaw :
      ∀ (I : Finset.{0} NNReal),
        @ProbabilityTheory.HasLaw.{u_1, 0} Ω (↥I → Real) mΩ
          (@MeasurableSpace.pi.{0, 0} (↥I) (fun a => Real) fun a => Real.measurableSpace)
          (fun ω => @Finset.restrict.{0, 0} NNReal (fun x => Real) I fun x => X x ω)
          (ProbabilityTheory.BrownianReal.projectiveFamily I) P) :
    @ProbabilityTheory.IsPreBrownianReal.{u_1} Ω mΩ X P
```

### `ProbabilityTheory.IsFilteredPreBrownian`

Command: `#print ProbabilityTheory.IsFilteredPreBrownian`

```lean
class ProbabilityTheory.IsFilteredPreBrownian.{u_2} {Ω : Type u_2} {mΩ : MeasurableSpace.{u_2} Ω}
  (X : NNReal → Ω → Real)
  (𝓕 : @MeasureTheory.Filtration.{u_2, 0} Ω NNReal (@PartialOrder.toPreorder.{0} NNReal NNReal.instPartialOrder) mΩ)
  (P : @MeasureTheory.Measure.{u_2} Ω mΩ) : Prop
number of parameters: 5
parents:
  ProbabilityTheory.IsFilteredPreBrownian.toIsPreBrownianReal.{u_2} : @ProbabilityTheory.IsPreBrownianReal.{u_2} Ω mΩ X
    P
fields:
  ProbabilityTheory.IsPreBrownianReal.hasLaw.{u_1} : ∀ (I : Finset.{0} NNReal),
      @ProbabilityTheory.HasLaw.{u_2, 0} Ω (↥I → Real) mΩ
        (@MeasurableSpace.pi.{0, 0} (↥I) (fun a => Real) fun a => Real.measurableSpace)
        (fun ω => @Finset.restrict.{0, 0} NNReal (fun x => Real) I fun x => X x ω)
        (ProbabilityTheory.BrownianReal.projectiveFamily I) P
  ProbabilityTheory.IsFilteredPreBrownian.stronglyAdapted.{u_2} : @MeasureTheory.StronglyAdapted.{u_2, 0, 0} Ω NNReal mΩ
      (@PartialOrder.toPreorder.{0} NNReal NNReal.instPartialOrder) (fun i => Real)
      (fun i =>
        @UniformSpace.toTopologicalSpace.{0} Real (@PseudoMetricSpace.toUniformSpace.{0} Real Real.pseudoMetricSpace))
      𝓕 X
  ProbabilityTheory.IsFilteredPreBrownian.indep.{u_2} : ∀ (s t : NNReal),
      @LE.le.{0} NNReal (@Preorder.toLE.{0} NNReal (@PartialOrder.toPreorder.{0} NNReal NNReal.instPartialOrder)) s t →
        @ProbabilityTheory.Indep.{u_2} Ω
          (@MeasurableSpace.comap.{u_2, 0} Ω Real
            (@HSub.hSub.{u_2, u_2, u_2} (Ω → Real) (Ω → Real) (Ω → Real)
              (@instHSub.{u_2} (Ω → Real) (@Pi.instSub.{u_2, 0} Ω (fun a => Real) fun i => Real.instSub)) (X t) (X s))
            (@inferInstance.{1} (MeasurableSpace.{0} Real) Real.measurableSpace))
          (@MeasureTheory.Filtration.seq.{u_2, 0} Ω NNReal (@PartialOrder.toPreorder.{0} NNReal NNReal.instPartialOrder)
            mΩ 𝓕 s)
          mΩ P
constructor:
  ProbabilityTheory.IsFilteredPreBrownian.mk.{u_2} {Ω : Type u_2} {mΩ : MeasurableSpace.{u_2} Ω} {X : NNReal → Ω → Real}
    {𝓕 : @MeasureTheory.Filtration.{u_2, 0} Ω NNReal (@PartialOrder.toPreorder.{0} NNReal NNReal.instPartialOrder) mΩ}
    {P : @MeasureTheory.Measure.{u_2} Ω mΩ} (toIsPreBrownianReal : @ProbabilityTheory.IsPreBrownianReal.{u_2} Ω mΩ X P)
    (stronglyAdapted :
      @MeasureTheory.StronglyAdapted.{u_2, 0, 0} Ω NNReal mΩ
        (@PartialOrder.toPreorder.{0} NNReal NNReal.instPartialOrder) (fun i => Real)
        (fun i =>
          @UniformSpace.toTopologicalSpace.{0} Real (@PseudoMetricSpace.toUniformSpace.{0} Real Real.pseudoMetricSpace))
        𝓕 X)
    (indep :
      ∀ (s t : NNReal),
        @LE.le.{0} NNReal (@Preorder.toLE.{0} NNReal (@PartialOrder.toPreorder.{0} NNReal NNReal.instPartialOrder)) s
            t →
          @ProbabilityTheory.Indep.{u_2} Ω
            (@MeasurableSpace.comap.{u_2, 0} Ω Real
              (@HSub.hSub.{u_2, u_2, u_2} (Ω → Real) (Ω → Real) (Ω → Real)
                (@instHSub.{u_2} (Ω → Real) (@Pi.instSub.{u_2, 0} Ω (fun a => Real) fun i => Real.instSub)) (X t) (X s))
              (@inferInstance.{1} (MeasurableSpace.{0} Real) Real.measurableSpace))
            (@MeasureTheory.Filtration.seq.{u_2, 0} Ω NNReal
              (@PartialOrder.toPreorder.{0} NNReal NNReal.instPartialOrder) mΩ 𝓕 s)
            mΩ P) :
    @ProbabilityTheory.IsFilteredPreBrownian.{u_2} Ω mΩ X 𝓕 P
field notation resolution order:
  ProbabilityTheory.IsFilteredPreBrownian.{u_2}, ProbabilityTheory.IsPreBrownianReal.{u_1}
```

### `AmericanConvexity.Stopping.brownian_filtered`

Command: `#print AmericanConvexity.Stopping.brownian_filtered`

```lean
theorem AmericanConvexity.Stopping.brownian_filtered : @ProbabilityTheory.IsFilteredPreBrownian.{0} (NNReal → Real)
  (@inferInstance.{1} (MeasurableSpace.{0} (NNReal → Real))
    (@MeasurableSpace.pi.{0, 0} NNReal (fun a => Real) fun a => Real.measurableSpace))
  ProbabilityTheory.brownian AmericanConvexity.Stopping.brownianFiltration ProbabilityTheory.gaussianLimit :=
@ProbabilityTheory.IsPreBrownianReal.isFilteredPreBrownian.{0} (NNReal → Real)
  (@MeasurableSpace.pi.{0, 0} NNReal (fun a => Real) fun a => Real.measurableSpace) ProbabilityTheory.brownian
  ProbabilityTheory.gaussianLimit
  (@ProbabilityTheory.IsBrownianReal.toIsPreBrownianReal.{0} (NNReal → Real)
    (@MeasurableSpace.pi.{0, 0} NNReal (fun a => Real) fun a => Real.measurableSpace) ProbabilityTheory.brownian
    ProbabilityTheory.gaussianLimit ProbabilityTheory.isBrownianReal_brownian)
  ProbabilityTheory.measurable_brownian
```

### `AmericanConvexity.Stopping.brownianLogState`

Command: `#print AmericanConvexity.Stopping.brownianLogState`

```lean
def AmericanConvexity.Stopping.brownianLogState : Real → Real → Real → NNReal → (NNReal → Real) → Real :=
fun β σ x t ω =>
  @HAdd.hAdd.{0, 0, 0} Real Real Real (@instHAdd.{0} Real Real.instAdd)
    (@HAdd.hAdd.{0, 0, 0} Real Real Real (@instHAdd.{0} Real Real.instAdd) x
      (@HMul.hMul.{0, 0, 0} Real Real Real (@instHMul.{0} Real Real.instMul) β ↑t))
    (@HMul.hMul.{0, 0, 0} Real Real Real (@instHMul.{0} Real Real.instMul) σ (ProbabilityTheory.brownian t ω))
```

### `AmericanConvexity.Stopping.brownianHeatFlow`

Command: `#print AmericanConvexity.Stopping.brownianHeatFlow`

```lean
def AmericanConvexity.Stopping.brownianHeatFlow : (Real → Real) → NNReal → Real → Real :=
fun f t x =>
  @MeasureTheory.integral.{0, 0} (NNReal → Real) Real Real.normedAddCommGroup
    (@InnerProductSpace.toNormedSpace.{0, 0} Real Real Real.instRCLike
      (@NormedAddCommGroup.toSeminormedAddCommGroup.{0} Real Real.normedAddCommGroup)
      (@RCLike.toInnerProductSpaceReal.{0} Real Real.instRCLike))
    (@MeasurableSpace.pi.{0, 0} NNReal (fun a => Real) fun a => Real.measurableSpace) ProbabilityTheory.gaussianLimit
    fun ω =>
    f (@HAdd.hAdd.{0, 0, 0} Real Real Real (@instHAdd.{0} Real Real.instAdd) x (ProbabilityTheory.brownian t ω))
```

## 4. All a.s.-bounded stopping times

### `AmericanConvexity.Stopping.AEBoundedRule`

Command: `#print AmericanConvexity.Stopping.AEBoundedRule`

```lean
structure AmericanConvexity.Stopping.AEBoundedRule.{u_1} {Ω : Type u_1} [MeasurableSpace.{u_1} Ω]
  (P : @MeasureTheory.Measure.{u_1} Ω inst✝)
  (𝓕 : @MeasureTheory.Filtration.{u_1, 0} Ω NNReal (@PartialOrder.toPreorder.{0} NNReal NNReal.instPartialOrder) inst✝)
  (T : NNReal) : Type u_1
number of parameters: 5
fields:
  AmericanConvexity.Stopping.AEBoundedRule.time.{u_1} : Ω → WithTop.{0} NNReal
  AmericanConvexity.Stopping.AEBoundedRule.stopping.{u_1} : @MeasureTheory.IsStoppingTime.{u_1, 0} Ω NNReal inst✝
      (@PartialOrder.toPreorder.{0} NNReal NNReal.instPartialOrder) 𝓕
      (@AmericanConvexity.Stopping.AEBoundedRule.time.{u_1} Ω inst✝ P 𝓕 T self)
  AmericanConvexity.Stopping.AEBoundedRule.ae_le_horizon.{u_1} : @Filter.Eventually.{u_1} Ω
      (fun ω =>
        @LE.le.{0} (WithTop.{0} NNReal)
          (@Preorder.toLE.{0} (WithTop.{0} NNReal)
            (@WithTop.instPreorder.{0} NNReal (@PartialOrder.toPreorder.{0} NNReal NNReal.instPartialOrder)))
          (@AmericanConvexity.Stopping.AEBoundedRule.time.{u_1} Ω inst✝ P 𝓕 T self ω) (@WithTop.some.{0} NNReal T))
      (@MeasureTheory.ae.{u_1, u_1} Ω (@MeasureTheory.Measure.{u_1} Ω inst✝)
        (@MeasureTheory.Measure.instFunLike.{u_1} Ω inst✝) (@MeasureTheory.Measure.instOuterMeasureClass.{u_1} Ω inst✝)
        P)
constructor:
  AmericanConvexity.Stopping.AEBoundedRule.mk.{u_1} {Ω : Type u_1} [MeasurableSpace.{u_1} Ω]
    {P : @MeasureTheory.Measure.{u_1} Ω inst✝}
    {𝓕 :
      @MeasureTheory.Filtration.{u_1, 0} Ω NNReal (@PartialOrder.toPreorder.{0} NNReal NNReal.instPartialOrder) inst✝}
    {T : NNReal} (time : Ω → WithTop.{0} NNReal)
    (stopping :
      @MeasureTheory.IsStoppingTime.{u_1, 0} Ω NNReal inst✝
        (@PartialOrder.toPreorder.{0} NNReal NNReal.instPartialOrder) 𝓕 time)
    (ae_le_horizon :
      @Filter.Eventually.{u_1} Ω
        (fun ω =>
          @LE.le.{0} (WithTop.{0} NNReal)
            (@Preorder.toLE.{0} (WithTop.{0} NNReal)
              (@WithTop.instPreorder.{0} NNReal (@PartialOrder.toPreorder.{0} NNReal NNReal.instPartialOrder)))
            (time ω) (@WithTop.some.{0} NNReal T))
        (@MeasureTheory.ae.{u_1, u_1} Ω (@MeasureTheory.Measure.{u_1} Ω inst✝)
          (@MeasureTheory.Measure.instFunLike.{u_1} Ω inst✝)
          (@MeasureTheory.Measure.instOuterMeasureClass.{u_1} Ω inst✝) P)) :
    @AmericanConvexity.Stopping.AEBoundedRule.{u_1} Ω inst✝ P 𝓕 T
```

### `AmericanConvexity.Stopping.AEBoundedRule.finiteTime`

Command: `#print AmericanConvexity.Stopping.AEBoundedRule.finiteTime`

```lean
def AmericanConvexity.Stopping.AEBoundedRule.finiteTime.{u_1} : {Ω : Type u_1} →
  [inst : MeasurableSpace.{u_1} Ω] →
    {P : @MeasureTheory.Measure.{u_1} Ω inst} →
      {𝓕 :
          @MeasureTheory.Filtration.{u_1, 0} Ω NNReal (@PartialOrder.toPreorder.{0} NNReal NNReal.instPartialOrder)
            inst} →
        {T : NNReal} → @AmericanConvexity.Stopping.AEBoundedRule.{u_1} Ω inst P 𝓕 T → Ω → NNReal :=
fun {Ω} [inst : MeasurableSpace.{u_1} Ω] {P} {𝓕} {T} θ ω =>
  @WithTop.untopD.{0} NNReal (@OfNat.ofNat.{0} NNReal (nat_lit 0) (@Zero.toOfNat0.{0} NNReal NNReal.instZero))
    (@AmericanConvexity.Stopping.AEBoundedRule.time.{u_1} Ω inst P 𝓕 T θ ω)
```

### `AmericanConvexity.Stopping.AEBoundedRule.clip`

Command: `#print AmericanConvexity.Stopping.AEBoundedRule.clip`

```lean
def AmericanConvexity.Stopping.AEBoundedRule.clip.{u_1} : {Ω : Type u_1} →
  [inst : MeasurableSpace.{u_1} Ω] →
    {P : @MeasureTheory.Measure.{u_1} Ω inst} →
      {𝓕 :
          @MeasureTheory.Filtration.{u_1, 0} Ω NNReal (@PartialOrder.toPreorder.{0} NNReal NNReal.instPartialOrder)
            inst} →
        {T : NNReal} →
          @AmericanConvexity.Stopping.AEBoundedRule.{u_1} Ω inst P 𝓕 T →
            @AmericanConvexity.Stopping.BoundedRule.{u_1} Ω inst 𝓕 T :=
fun {Ω} [inst : MeasurableSpace.{u_1} Ω] {P} {𝓕} {T} θ =>
  @AmericanConvexity.Stopping.BoundedRule.ofWithTop.{u_1} Ω inst 𝓕 T
    (fun ω =>
      @Min.min.{0} (WithTop.{0} NNReal)
        (@SemilatticeInf.toMin.{0} (WithTop.{0} NNReal) (@WithTop.semilatticeInf.{0} NNReal NNReal.instSemilatticeInf))
        (@AmericanConvexity.Stopping.AEBoundedRule.time.{u_1} Ω inst P 𝓕 T θ ω) (@WithTop.some.{0} NNReal T))
    (@AmericanConvexity.Stopping.AEBoundedRule.clip._proof_1.{u_1} Ω inst P 𝓕 T θ)
    (@AmericanConvexity.Stopping.AEBoundedRule.clip._proof_2.{u_1} Ω inst P 𝓕 T θ)
```

### `AmericanConvexity.Stopping.BoundedRule.ofWithTop`

Command: `#print AmericanConvexity.Stopping.BoundedRule.ofWithTop`

```lean
def AmericanConvexity.Stopping.BoundedRule.ofWithTop.{u_1} : {Ω : Type u_1} →
  [inst : MeasurableSpace.{u_1} Ω] →
    {𝓕 :
        @MeasureTheory.Filtration.{u_1, 0} Ω NNReal (@PartialOrder.toPreorder.{0} NNReal NNReal.instPartialOrder)
          inst} →
      {T : NNReal} →
        (τ : Ω → WithTop.{0} NNReal) →
          @MeasureTheory.IsStoppingTime.{u_1, 0} Ω NNReal inst
              (@PartialOrder.toPreorder.{0} NNReal NNReal.instPartialOrder) 𝓕 τ →
            (∀ (ω : Ω),
                @LE.le.{0} (WithTop.{0} NNReal)
                  (@Preorder.toLE.{0} (WithTop.{0} NNReal)
                    (@WithTop.instPreorder.{0} NNReal (@PartialOrder.toPreorder.{0} NNReal NNReal.instPartialOrder)))
                  (τ ω) (@WithTop.some.{0} NNReal T)) →
              @AmericanConvexity.Stopping.BoundedRule.{u_1} Ω inst 𝓕 T :=
fun {Ω} [inst : MeasurableSpace.{u_1} Ω] {𝓕} {T} τ hτ hbound =>
  @AmericanConvexity.Stopping.BoundedRule.mk.{u_1} Ω inst 𝓕 T
    (fun ω =>
      @WithTop.untop.{0} NNReal (τ ω) (@AmericanConvexity.Stopping.BoundedRule.ofWithTop._proof_1.{u_1} Ω T τ hbound ω))
    (@AmericanConvexity.Stopping.BoundedRule.ofWithTop._proof_2.{u_1} Ω inst 𝓕 T τ hτ hbound)
    (@AmericanConvexity.Stopping.BoundedRule.ofWithTop._proof_3.{u_1} Ω T τ hbound)
```

### `AmericanConvexity.Stopping.aeExerciseValues`

Command: `#print AmericanConvexity.Stopping.aeExerciseValues`

```lean
def AmericanConvexity.Stopping.aeExerciseValues.{u_1} : {Ω : Type u_1} →
  [inst : MeasurableSpace.{u_1} Ω] →
    @MeasureTheory.Measure.{u_1} Ω inst →
      @MeasureTheory.Filtration.{u_1, 0} Ω NNReal (@PartialOrder.toPreorder.{0} NNReal NNReal.instPartialOrder) inst →
        (NNReal → Ω → Real) → Real → Real → Real → Real → Real → NNReal → Set.{0} Real :=
fun {Ω} [inst : MeasurableSpace.{u_1} Ω] P 𝓕 W K r q σ S T =>
  @Set.range.{0, u_1 + 1} Real (@AmericanConvexity.Stopping.AEBoundedRule.{u_1} Ω inst P 𝓕 T) fun θ =>
    @MeasureTheory.integral.{u_1, 0} Ω Real Real.normedAddCommGroup
      (@InnerProductSpace.toNormedSpace.{0, 0} Real Real Real.instRCLike
        (@NormedAddCommGroup.toSeminormedAddCommGroup.{0} Real Real.normedAddCommGroup)
        (@RCLike.toInnerProductSpaceReal.{0} Real Real.instRCLike))
      inst P fun ω =>
      @AmericanConvexity.Stopping.putReward.{u_1} Ω W K r q σ S
        (@AmericanConvexity.Stopping.AEBoundedRule.finiteTime.{u_1} Ω inst P 𝓕 T θ) ω
```

### `AmericanConvexity.Stopping.aeAmericanPutValue`

Command: `#print AmericanConvexity.Stopping.aeAmericanPutValue`

```lean
def AmericanConvexity.Stopping.aeAmericanPutValue.{u_1} : {Ω : Type u_1} →
  [inst : MeasurableSpace.{u_1} Ω] →
    @MeasureTheory.Measure.{u_1} Ω inst →
      @MeasureTheory.Filtration.{u_1, 0} Ω NNReal (@PartialOrder.toPreorder.{0} NNReal NNReal.instPartialOrder) inst →
        (NNReal → Ω → Real) → Real → Real → Real → Real → Real → NNReal → Real :=
fun {Ω} [inst : MeasurableSpace.{u_1} Ω] P 𝓕 W K r q σ S T =>
  @SupSet.sSup.{0} Real Real.instSupSet (@AmericanConvexity.Stopping.aeExerciseValues.{u_1} Ω inst P 𝓕 W K r q σ S T)
```

### `AmericanConvexity.Stopping.aeExerciseValues_eq`

Command: `#print AmericanConvexity.Stopping.aeExerciseValues_eq`

```lean
theorem AmericanConvexity.Stopping.aeExerciseValues_eq.{u_1} : ∀ {Ω : Type u_1} [inst : MeasurableSpace.{u_1} Ω]
  (P : @MeasureTheory.Measure.{u_1} Ω inst)
  (𝓕 : @MeasureTheory.Filtration.{u_1, 0} Ω NNReal (@PartialOrder.toPreorder.{0} NNReal NNReal.instPartialOrder) inst)
  (W : NNReal → Ω → Real) (K r q σ S : Real) (T : NNReal),
  @Eq.{1} (Set.{0} Real) (@AmericanConvexity.Stopping.aeExerciseValues.{u_1} Ω inst P 𝓕 W K r q σ S T)
    (@AmericanConvexity.Stopping.exerciseValues.{u_1} Ω inst P 𝓕 W K r q σ S T) :=
fun {Ω} [inst : MeasurableSpace.{u_1} Ω] P 𝓕 W K r q σ S T =>
  @Set.Subset.antisymm.{0} Real (@AmericanConvexity.Stopping.aeExerciseValues.{u_1} Ω inst P 𝓕 W K r q σ S T)
    (@AmericanConvexity.Stopping.exerciseValues.{u_1} Ω inst P 𝓕 W K r q σ S T)
    (fun ⦃a⦄ a_1 =>
      @Exists.casesOn.{u_1 + 1} (@AmericanConvexity.Stopping.AEBoundedRule.{u_1} Ω inst P 𝓕 T)
        (fun y =>
          @Eq.{1} Real
            ((fun θ =>
                @MeasureTheory.integral.{u_1, 0} Ω Real Real.normedAddCommGroup
                  (@InnerProductSpace.toNormedSpace.{0, 0} Real Real Real.instRCLike
                    (@NormedAddCommGroup.toSeminormedAddCommGroup.{0} Real Real.normedAddCommGroup)
                    (@RCLike.toInnerProductSpaceReal.{0} Real Real.instRCLike))
                  inst P fun ω =>
                  @AmericanConvexity.Stopping.putReward.{u_1} Ω W K r q σ S
                    (@AmericanConvexity.Stopping.AEBoundedRule.finiteTime.{u_1} Ω inst P 𝓕 T θ) ω)
              y)
            a)
        (fun x =>
          @Membership.mem.{0, 0} Real (Set.{0} Real) (@Set.instMembership.{0} Real)
            (@AmericanConvexity.Stopping.exerciseValues.{u_1} Ω inst P 𝓕 W K r q σ S T) a)
        a_1 fun θ h =>
        @Eq.ndrec.{0, 1} Real
          ((fun θ =>
              @MeasureTheory.integral.{u_1, 0} Ω Real Real.normedAddCommGroup
                (@InnerProductSpace.toNormedSpace.{0, 0} Real Real Real.instRCLike
                  (@NormedAddCommGroup.toSeminormedAddCommGroup.{0} Real Real.normedAddCommGroup)
                  (@RCLike.toInnerProductSpaceReal.{0} Real Real.instRCLike))
                inst P fun ω =>
                @AmericanConvexity.Stopping.putReward.{u_1} Ω W K r q σ S
                  (@AmericanConvexity.Stopping.AEBoundedRule.finiteTime.{u_1} Ω inst P 𝓕 T θ) ω)
            θ)
          (fun ⦃a⦄ =>
            @Membership.mem.{0, 0} Real (Set.{0} Real) (@Set.instMembership.{0} Real)
              (@AmericanConvexity.Stopping.exerciseValues.{u_1} Ω inst P 𝓕 W K r q σ S T) a)
          (@Exists.intro.{u_1 + 1} (@AmericanConvexity.Stopping.BoundedRule.{u_1} Ω inst 𝓕 T)
            (fun y =>
              @Eq.{1} Real
                ((fun θ =>
                    @MeasureTheory.integral.{u_1, 0} Ω Real Real.normedAddCommGroup
                      (@InnerProductSpace.toNormedSpace.{0, 0} Real Real Real.instRCLike
                        (@NormedAddCommGroup.toSeminormedAddCommGroup.{0} Real Real.normedAddCommGroup)
                        (@RCLike.toInnerProductSpaceReal.{0} Real Real.instRCLike))
                      inst P fun ω =>
                      @AmericanConvexity.Stopping.putReward.{u_1} Ω W K r q σ S
                        (@AmericanConvexity.Stopping.BoundedRule.time.{u_1} Ω inst 𝓕 T θ) ω)
                  y)
                ((fun θ =>
                    @MeasureTheory.integral.{u_1, 0} Ω Real Real.normedAddCommGroup
                      (@InnerProductSpace.toNormedSpace.{0, 0} Real Real Real.instRCLike
                        (@NormedAddCommGroup.toSeminormedAddCommGroup.{0} Real Real.normedAddCommGroup)
                        (@RCLike.toInnerProductSpaceReal.{0} Real Real.instRCLike))
                      inst P fun ω =>
                      @AmericanConvexity.Stopping.putReward.{u_1} Ω W K r q σ S
                        (@AmericanConvexity.Stopping.AEBoundedRule.finiteTime.{u_1} Ω inst P 𝓕 T θ) ω)
                  θ))
            (@AmericanConvexity.Stopping.AEBoundedRule.clip.{u_1} Ω inst P 𝓕 T θ)
            (@AmericanConvexity.Stopping.AEBoundedRule.clip_expectedReward.{u_1} Ω inst P 𝓕 T θ W K r q σ S))
          a h)
    fun ⦃a⦄ a_1 =>
    @Exists.casesOn.{u_1 + 1} (@AmericanConvexity.Stopping.BoundedRule.{u_1} Ω inst 𝓕 T)
      (fun y =>
        @Eq.{1} Real
          ((fun θ =>
              @MeasureTheory.integral.{u_1, 0} Ω Real Real.normedAddCommGroup
                (@InnerProductSpace.toNormedSpace.{0, 0} Real Real Real.instRCLike
                  (@NormedAddCommGroup.toSeminormedAddCommGroup.{0} Real Real.normedAddCommGroup)
                  (@RCLike.toInnerProductSpaceReal.{0} Real Real.instRCLike))
                inst P fun ω =>
                @AmericanConvexity.Stopping.putReward.{u_1} Ω W K r q σ S
                  (@AmericanConvexity.Stopping.BoundedRule.time.{u_1} Ω inst 𝓕 T θ) ω)
            y)
          a)
      (fun x =>
        @Membership.mem.{0, 0} Real (Set.{0} Real) (@Set.instMembership.{0} Real)
          (@AmericanConvexity.Stopping.aeExerciseValues.{u_1} Ω inst P 𝓕 W K r q σ S T) a)
      a_1 fun θ h =>
      @Eq.ndrec.{0, 1} Real
        ((fun θ =>
            @MeasureTheory.integral.{u_1, 0} Ω Real Real.normedAddCommGroup
              (@InnerProductSpace.toNormedSpace.{0, 0} Real Real Real.instRCLike
                (@NormedAddCommGroup.toSeminormedAddCommGroup.{0} Real Real.normedAddCommGroup)
                (@RCLike.toInnerProductSpaceReal.{0} Real Real.instRCLike))
              inst P fun ω =>
              @AmericanConvexity.Stopping.putReward.{u_1} Ω W K r q σ S
                (@AmericanConvexity.Stopping.BoundedRule.time.{u_1} Ω inst 𝓕 T θ) ω)
          θ)
        (fun ⦃a⦄ =>
          @Membership.mem.{0, 0} Real (Set.{0} Real) (@Set.instMembership.{0} Real)
            (@AmericanConvexity.Stopping.aeExerciseValues.{u_1} Ω inst P 𝓕 W K r q σ S T) a)
        (@Exists.intro.{u_1 + 1} (@AmericanConvexity.Stopping.AEBoundedRule.{u_1} Ω inst P 𝓕 T)
          (fun y =>
            @Eq.{1} Real
              ((fun θ =>
                  @MeasureTheory.integral.{u_1, 0} Ω Real Real.normedAddCommGroup
                    (@InnerProductSpace.toNormedSpace.{0, 0} Real Real Real.instRCLike
                      (@NormedAddCommGroup.toSeminormedAddCommGroup.{0} Real Real.normedAddCommGroup)
                      (@RCLike.toInnerProductSpaceReal.{0} Real Real.instRCLike))
                    inst P fun ω =>
                    @AmericanConvexity.Stopping.putReward.{u_1} Ω W K r q σ S
                      (@AmericanConvexity.Stopping.AEBoundedRule.finiteTime.{u_1} Ω inst P 𝓕 T θ) ω)
                y)
              ((fun θ =>
                  @MeasureTheory.integral.{u_1, 0} Ω Real Real.normedAddCommGroup
                    (@InnerProductSpace.toNormedSpace.{0, 0} Real Real Real.instRCLike
                      (@NormedAddCommGroup.toSeminormedAddCommGroup.{0} Real Real.normedAddCommGroup)
                      (@RCLike.toInnerProductSpaceReal.{0} Real Real.instRCLike))
                    inst P fun ω =>
                    @AmericanConvexity.Stopping.putReward.{u_1} Ω W K r q σ S
                      (@AmericanConvexity.Stopping.BoundedRule.time.{u_1} Ω inst 𝓕 T θ) ω)
                θ))
          (@AmericanConvexity.Stopping.BoundedRule.toAEBoundedRule.{u_1} Ω inst P 𝓕 T θ)
          (@id.{0}
            (@Eq.{1} Real
              ((fun θ =>
                  @MeasureTheory.integral.{u_1, 0} Ω Real Real.normedAddCommGroup
                    (@InnerProductSpace.toNormedSpace.{0, 0} Real Real Real.instRCLike
                      (@NormedAddCommGroup.toSeminormedAddCommGroup.{0} Real Real.normedAddCommGroup)
                      (@RCLike.toInnerProductSpaceReal.{0} Real Real.instRCLike))
                    inst P fun ω =>
                    @AmericanConvexity.Stopping.putReward.{u_1} Ω W K r q σ S
                      (@AmericanConvexity.Stopping.AEBoundedRule.finiteTime.{u_1} Ω inst P 𝓕 T θ) ω)
                (@AmericanConvexity.Stopping.BoundedRule.toAEBoundedRule.{u_1} Ω inst P 𝓕 T θ))
              ((fun θ =>
                  @MeasureTheory.integral.{u_1, 0} Ω Real Real.normedAddCommGroup
                    (@InnerProductSpace.toNormedSpace.{0, 0} Real Real Real.instRCLike
                      (@NormedAddCommGroup.toSeminormedAddCommGroup.{0} Real Real.normedAddCommGroup)
                      (@RCLike.toInnerProductSpaceReal.{0} Real Real.instRCLike))
                    inst P fun ω =>
                    @AmericanConvexity.Stopping.putReward.{u_1} Ω W K r q σ S
                      (@AmericanConvexity.Stopping.BoundedRule.time.{u_1} Ω inst 𝓕 T θ) ω)
                θ))
            (@Eq.mpr.{0}
              (@Eq.{1} Real
                (@MeasureTheory.integral.{u_1, 0} Ω Real Real.normedAddCommGroup
                  (@InnerProductSpace.toNormedSpace.{0, 0} Real Real Real.instRCLike
                    (@NormedAddCommGroup.toSeminormedAddCommGroup.{0} Real Real.normedAddCommGroup)
                    (@RCLike.toInnerProductSpaceReal.{0} Real Real.instRCLike))
                  inst P fun ω =>
                  @AmericanConvexity.Stopping.putReward.{u_1} Ω W K r q σ S
                    (@AmericanConvexity.Stopping.AEBoundedRule.finiteTime.{u_1} Ω inst P 𝓕 T
                      (@AmericanConvexity.Stopping.BoundedRule.toAEBoundedRule.{u_1} Ω inst P 𝓕 T θ))
                    ω)
                ((fun θ =>
                    @MeasureTheory.integral.{u_1, 0} Ω Real Real.normedAddCommGroup
                      (@InnerProductSpace.toNormedSpace.{0, 0} Real Real Real.instRCLike
                        (@NormedAddCommGroup.toSeminormedAddCommGroup.{0} Real Real.normedAddCommGroup)
                        (@RCLike.toInnerProductSpaceReal.{0} Real Real.instRCLike))
                      inst P fun ω =>
                      @AmericanConvexity.Stopping.putReward.{u_1} Ω W K r q σ S
                        (@AmericanConvexity.Stopping.BoundedRule.time.{u_1} Ω inst 𝓕 T θ) ω)
                  θ))
              (@Eq.{1} Real
                (@MeasureTheory.integral.{u_1, 0} Ω Real Real.normedAddCommGroup
                  (@InnerProductSpace.toNormedSpace.{0, 0} Real Real Real.instRCLike
                    (@NormedAddCommGroup.toSeminormedAddCommGroup.{0} Real Real.normedAddCommGroup)
                    (@RCLike.toInnerProductSpaceReal.{0} Real Real.instRCLike))
                  inst P fun ω =>
                  @AmericanConvexity.Stopping.putReward.{u_1} Ω W K r q σ S
                    (@AmericanConvexity.Stopping.BoundedRule.time.{u_1} Ω inst 𝓕 T θ) ω)
                ((fun θ =>
                    @MeasureTheory.integral.{u_1, 0} Ω Real Real.normedAddCommGroup
                      (@InnerProductSpace.toNormedSpace.{0, 0} Real Real Real.instRCLike
                        (@NormedAddCommGroup.toSeminormedAddCommGroup.{0} Real Real.normedAddCommGroup)
                        (@RCLike.toInnerProductSpaceReal.{0} Real Real.instRCLike))
                      inst P fun ω =>
                      @AmericanConvexity.Stopping.putReward.{u_1} Ω W K r q σ S
                        (@AmericanConvexity.Stopping.BoundedRule.time.{u_1} Ω inst 𝓕 T θ) ω)
                  θ))
              (@id.{0}
                (@Eq.{1} Prop
                  (@Eq.{1} Real
                    (@MeasureTheory.integral.{u_1, 0} Ω Real Real.normedAddCommGroup
                      (@InnerProductSpace.toNormedSpace.{0, 0} Real Real Real.instRCLike
                        (@NormedAddCommGroup.toSeminormedAddCommGroup.{0} Real Real.normedAddCommGroup)
                        (@RCLike.toInnerProductSpaceReal.{0} Real Real.instRCLike))
                      inst P fun ω =>
                      @AmericanConvexity.Stopping.putReward.{u_1} Ω W K r q σ S
                        (@AmericanConvexity.Stopping.AEBoundedRule.finiteTime.{u_1} Ω inst P 𝓕 T
                          (@AmericanConvexity.Stopping.BoundedRule.toAEBoundedRule.{u_1} Ω inst P 𝓕 T θ))
                        ω)
                    ((fun θ =>
                        @MeasureTheory.integral.{u_1, 0} Ω Real Real.normedAddCommGroup
                          (@InnerProductSpace.toNormedSpace.{0, 0} Real Real Real.instRCLike
                            (@NormedAddCommGroup.toSeminormedAddCommGroup.{0} Real Real.normedAddCommGroup)
                            (@RCLike.toInnerProductSpaceReal.{0} Real Real.instRCLike))
                          inst P fun ω =>
                          @AmericanConvexity.Stopping.putReward.{u_1} Ω W K r q σ S
                            (@AmericanConvexity.Stopping.BoundedRule.time.{u_1} Ω inst 𝓕 T θ) ω)
                      θ))
                  (@Eq.{1} Real
                    (@MeasureTheory.integral.{u_1, 0} Ω Real Real.normedAddCommGroup
                      (@InnerProductSpace.toNormedSpace.{0, 0} Real Real Real.instRCLike
                        (@NormedAddCommGroup.toSeminormedAddCommGroup.{0} Real Real.normedAddCommGroup)
                        (@RCLike.toInnerProductSpaceReal.{0} Real Real.instRCLike))
                      inst P fun ω =>
                      @AmericanConvexity.Stopping.putReward.{u_1} Ω W K r q σ S
                        (@AmericanConvexity.Stopping.BoundedRule.time.{u_1} Ω inst 𝓕 T θ) ω)
                    ((fun θ =>
                        @MeasureTheory.integral.{u_1, 0} Ω Real Real.normedAddCommGroup
                          (@InnerProductSpace.toNormedSpace.{0, 0} Real Real Real.instRCLike
                            (@NormedAddCommGroup.toSeminormedAddCommGroup.{0} Real Real.normedAddCommGroup)
                            (@RCLike.toInnerProductSpaceReal.{0} Real Real.instRCLike))
                          inst P fun ω =>
                          @AmericanConvexity.Stopping.putReward.{u_1} Ω W K r q σ S
                            (@AmericanConvexity.Stopping.BoundedRule.time.{u_1} Ω inst 𝓕 T θ) ω)
                      θ)))
                (@congrArg.{u_1 + 1, 1} (Ω → NNReal) Prop
                  (@AmericanConvexity.Stopping.AEBoundedRule.finiteTime.{u_1} Ω inst P 𝓕 T
                    (@AmericanConvexity.Stopping.BoundedRule.toAEBoundedRule.{u_1} Ω inst P 𝓕 T θ))
                  (@AmericanConvexity.Stopping.BoundedRule.time.{u_1} Ω inst 𝓕 T θ)
                  (fun _a =>
                    @Eq.{1} Real
                      (@MeasureTheory.integral.{u_1, 0} Ω Real Real.normedAddCommGroup
                        (@InnerProductSpace.toNormedSpace.{0, 0} Real Real Real.instRCLike
                          (@NormedAddCommGroup.toSeminormedAddCommGroup.{0} Real Real.normedAddCommGroup)
                          (@RCLike.toInnerProductSpaceReal.{0} Real Real.instRCLike))
                        inst P fun ω => @AmericanConvexity.Stopping.putReward.{u_1} Ω W K r q σ S _a ω)
                      ((fun θ =>
                          @MeasureTheory.integral.{u_1, 0} Ω Real Real.normedAddCommGroup
                            (@InnerProductSpace.toNormedSpace.{0, 0} Real Real Real.instRCLike
                              (@NormedAddCommGroup.toSeminormedAddCommGroup.{0} Real Real.normedAddCommGroup)
                              (@RCLike.toInnerProductSpaceReal.{0} Real Real.instRCLike))
                            inst P fun ω =>
                            @AmericanConvexity.Stopping.putReward.{u_1} Ω W K r q σ S
                              (@AmericanConvexity.Stopping.BoundedRule.time.{u_1} Ω inst 𝓕 T θ) ω)
                        θ))
                  (@AmericanConvexity.Stopping.BoundedRule.toAEBoundedRule_finiteTime.{u_1} Ω inst P 𝓕 T θ)))
              (@Eq.refl.{1} Real
                (@MeasureTheory.integral.{u_1, 0} Ω Real Real.normedAddCommGroup
                  (@InnerProductSpace.toNormedSpace.{0, 0} Real Real Real.instRCLike
                    (@NormedAddCommGroup.toSeminormedAddCommGroup.{0} Real Real.normedAddCommGroup)
                    (@RCLike.toInnerProductSpaceReal.{0} Real Real.instRCLike))
                  inst P fun ω =>
                  @AmericanConvexity.Stopping.putReward.{u_1} Ω W K r q σ S
                    (@AmericanConvexity.Stopping.BoundedRule.time.{u_1} Ω inst 𝓕 T θ) ω)))))
        a h
```

### `AmericanConvexity.Stopping.aeAmericanPutValue_eq`

Command: `#print AmericanConvexity.Stopping.aeAmericanPutValue_eq`

```lean
theorem AmericanConvexity.Stopping.aeAmericanPutValue_eq.{u_1} : ∀ {Ω : Type u_1} [inst : MeasurableSpace.{u_1} Ω]
  (P : @MeasureTheory.Measure.{u_1} Ω inst)
  (𝓕 : @MeasureTheory.Filtration.{u_1, 0} Ω NNReal (@PartialOrder.toPreorder.{0} NNReal NNReal.instPartialOrder) inst)
  (W : NNReal → Ω → Real) (K r q σ S : Real) (T : NNReal),
  @Eq.{1} Real (@AmericanConvexity.Stopping.aeAmericanPutValue.{u_1} Ω inst P 𝓕 W K r q σ S T)
    (@AmericanConvexity.Stopping.americanPutValue.{u_1} Ω inst P 𝓕 W K r q σ S T) :=
fun {Ω} [inst : MeasurableSpace.{u_1} Ω] P 𝓕 W K r q σ S T =>
  @id.{0}
    (@Eq.{1} Real (@AmericanConvexity.Stopping.aeAmericanPutValue.{u_1} Ω inst P 𝓕 W K r q σ S T)
      (@AmericanConvexity.Stopping.americanPutValue.{u_1} Ω inst P 𝓕 W K r q σ S T))
    (@id.{0}
      (@Eq.{1} Real
        (@SupSet.sSup.{0} Real Real.instSupSet
          (@AmericanConvexity.Stopping.aeExerciseValues.{u_1} Ω inst P 𝓕 W K r q σ S T))
        (@AmericanConvexity.Stopping.americanPutValue.{u_1} Ω inst P 𝓕 W K r q σ S T))
      (@Eq.mpr.{0}
        (@Eq.{1} Real
          (@SupSet.sSup.{0} Real Real.instSupSet
            (@AmericanConvexity.Stopping.aeExerciseValues.{u_1} Ω inst P 𝓕 W K r q σ S T))
          (@SupSet.sSup.{0} Real Real.instSupSet
            (@AmericanConvexity.Stopping.exerciseValues.{u_1} Ω inst P 𝓕 W K r q σ S T)))
        (@Eq.{1} Real
          (@SupSet.sSup.{0} Real Real.instSupSet
            (@AmericanConvexity.Stopping.exerciseValues.{u_1} Ω inst P 𝓕 W K r q σ S T))
          (@SupSet.sSup.{0} Real Real.instSupSet
            (@AmericanConvexity.Stopping.exerciseValues.{u_1} Ω inst P 𝓕 W K r q σ S T)))
        (@id.{0}
          (@Eq.{1} Prop
            (@Eq.{1} Real
              (@SupSet.sSup.{0} Real Real.instSupSet
                (@AmericanConvexity.Stopping.aeExerciseValues.{u_1} Ω inst P 𝓕 W K r q σ S T))
              (@SupSet.sSup.{0} Real Real.instSupSet
                (@AmericanConvexity.Stopping.exerciseValues.{u_1} Ω inst P 𝓕 W K r q σ S T)))
            (@Eq.{1} Real
              (@SupSet.sSup.{0} Real Real.instSupSet
                (@AmericanConvexity.Stopping.exerciseValues.{u_1} Ω inst P 𝓕 W K r q σ S T))
              (@SupSet.sSup.{0} Real Real.instSupSet
                (@AmericanConvexity.Stopping.exerciseValues.{u_1} Ω inst P 𝓕 W K r q σ S T))))
          (@congrArg.{1, 1} (Set.{0} Real) Prop
            (@AmericanConvexity.Stopping.aeExerciseValues.{u_1} Ω inst P 𝓕 W K r q σ S T)
            (@AmericanConvexity.Stopping.exerciseValues.{u_1} Ω inst P 𝓕 W K r q σ S T)
            (fun _a =>
              @Eq.{1} Real (@SupSet.sSup.{0} Real Real.instSupSet _a)
                (@SupSet.sSup.{0} Real Real.instSupSet
                  (@AmericanConvexity.Stopping.exerciseValues.{u_1} Ω inst P 𝓕 W K r q σ S T)))
            (@AmericanConvexity.Stopping.aeExerciseValues_eq.{u_1} Ω inst P 𝓕 W K r q σ S T)))
        (@Eq.refl.{1} Real
          (@SupSet.sSup.{0} Real Real.instSupSet
            (@AmericanConvexity.Stopping.exerciseValues.{u_1} Ω inst P 𝓕 W K r q σ S T)))))
```

### `AmericanConvexity.Review.actualValue_eq_ae_value`

Command: `#print AmericanConvexity.Review.actualValue_eq_ae_value`

```lean
theorem AmericanConvexity.Review.actualValue_eq_ae_value : ∀ (K r q σ S : Real) (τ : NNReal),
  @Eq.{1} Real (AmericanConvexity.Stopping.brownianUsualAmericanPut K r q σ S τ)
    (@AmericanConvexity.Stopping.aeAmericanPutValue.{0} (NNReal → Real)
      (@AmericanConvexity.Stopping.completedMeasurableSpace.{0} (NNReal → Real)
        (@MeasurableSpace.pi.{0, 0} NNReal (fun a => Real) fun a => Real.measurableSpace)
        ProbabilityTheory.gaussianLimit)
      (@AmericanConvexity.Stopping.completedMeasure.{0} (NNReal → Real)
        (@MeasurableSpace.pi.{0, 0} NNReal (fun a => Real) fun a => Real.measurableSpace)
        ProbabilityTheory.gaussianLimit)
      AmericanConvexity.Stopping.brownianUsualFiltration ProbabilityTheory.brownian K r q σ S τ) :=
fun K r q σ S τ =>
  @Eq.symm.{1} Real
    (@AmericanConvexity.Stopping.aeAmericanPutValue.{0} (NNReal → Real)
      (@AmericanConvexity.Stopping.completedMeasurableSpace.{0} (NNReal → Real)
        (@MeasurableSpace.pi.{0, 0} NNReal (fun a => Real) fun a => Real.measurableSpace)
        ProbabilityTheory.gaussianLimit)
      (@AmericanConvexity.Stopping.completedMeasure.{0} (NNReal → Real)
        (@MeasurableSpace.pi.{0, 0} NNReal (fun a => Real) fun a => Real.measurableSpace)
        ProbabilityTheory.gaussianLimit)
      AmericanConvexity.Stopping.brownianUsualFiltration ProbabilityTheory.brownian K r q σ S τ)
    (@AmericanConvexity.Stopping.americanPutValue.{0} (NNReal → Real)
      (@AmericanConvexity.Stopping.completedMeasurableSpace.{0} (NNReal → Real)
        (@MeasurableSpace.pi.{0, 0} NNReal (fun a => Real) fun a => Real.measurableSpace)
        ProbabilityTheory.gaussianLimit)
      (@AmericanConvexity.Stopping.completedMeasure.{0} (NNReal → Real)
        (@MeasurableSpace.pi.{0, 0} NNReal (fun a => Real) fun a => Real.measurableSpace)
        ProbabilityTheory.gaussianLimit)
      AmericanConvexity.Stopping.brownianUsualFiltration ProbabilityTheory.brownian K r q σ S τ)
    (@AmericanConvexity.Stopping.aeAmericanPutValue_eq.{0} (NNReal → Real)
      (@AmericanConvexity.Stopping.completedMeasurableSpace.{0} (NNReal → Real)
        (@MeasurableSpace.pi.{0, 0} NNReal (fun a => Real) fun a => Real.measurableSpace)
        ProbabilityTheory.gaussianLimit)
      (@AmericanConvexity.Stopping.completedMeasure.{0} (NNReal → Real)
        (@MeasurableSpace.pi.{0, 0} NNReal (fun a => Real) fun a => Real.measurableSpace)
        ProbabilityTheory.gaussianLimit)
      AmericanConvexity.Stopping.brownianUsualFiltration ProbabilityTheory.brownian K r q σ S τ)
```

## 5. Statements and individual axiom reports

### `AmericanConvexity.Stopping.brownianLogState_usual_condExp_transition`

```lean
AmericanConvexity.Stopping.brownianLogState_usual_condExp_transition : ∀ {f : Real → Real},
  @Continuous.{0, 0} Real Real
      (@UniformSpace.toTopologicalSpace.{0} Real (@PseudoMetricSpace.toUniformSpace.{0} Real Real.pseudoMetricSpace))
      (@UniformSpace.toTopologicalSpace.{0} Real (@PseudoMetricSpace.toUniformSpace.{0} Real Real.pseudoMetricSpace))
      f →
    ∀ {C : Real},
      (∀ (y : Real), @LE.le.{0} Real Real.instLE (@Norm.norm.{0} Real Real.norm (f y)) C) →
        ∀ {i j : NNReal},
          @LE.le.{0} NNReal (@Preorder.toLE.{0} NNReal (@PartialOrder.toPreorder.{0} NNReal NNReal.instPartialOrder)) i
              j →
            ∀ (β σ x : Real),
              @Filter.EventuallyEq.{0, 0} (NNReal → Real) Real
                (@MeasureTheory.ae.{0, 0} (NNReal → Real)
                  (@MeasureTheory.Measure.{0} (NNReal → Real)
                    (@AmericanConvexity.Stopping.completedMeasurableSpace.{0} (NNReal → Real)
                      (@MeasurableSpace.pi.{0, 0} NNReal (fun a => Real) fun a => Real.measurableSpace)
                      ProbabilityTheory.gaussianLimit))
                  (@MeasureTheory.Measure.instFunLike.{0} (NNReal → Real)
                    (@AmericanConvexity.Stopping.completedMeasurableSpace.{0} (NNReal → Real)
                      (@MeasurableSpace.pi.{0, 0} NNReal (fun a => Real) fun a => Real.measurableSpace)
                      ProbabilityTheory.gaussianLimit))
                  (@MeasureTheory.Measure.instOuterMeasureClass.{0} (NNReal → Real)
                    (@AmericanConvexity.Stopping.completedMeasurableSpace.{0} (NNReal → Real)
                      (@MeasurableSpace.pi.{0, 0} NNReal (fun a => Real) fun a => Real.measurableSpace)
                      ProbabilityTheory.gaussianLimit))
                  (@AmericanConvexity.Stopping.completedMeasure.{0} (NNReal → Real)
                    (@MeasurableSpace.pi.{0, 0} NNReal (fun a => Real) fun a => Real.measurableSpace)
                    ProbabilityTheory.gaussianLimit))
                (@MeasureTheory.condExp.{0, 0} (NNReal → Real) Real
                  (@MeasureTheory.Filtration.seq.{0, 0} (NNReal → Real) NNReal
                    (@PartialOrder.toPreorder.{0} NNReal NNReal.instPartialOrder)
                    (@AmericanConvexity.Stopping.completedMeasurableSpace.{0} (NNReal → Real)
                      (@MeasurableSpace.pi.{0, 0} NNReal (fun a => Real) fun a => Real.measurableSpace)
                      ProbabilityTheory.gaussianLimit)
                    AmericanConvexity.Stopping.brownianUsualFiltration i)
                  (@AmericanConvexity.Stopping.completedMeasurableSpace.{0} (NNReal → Real)
                    (@MeasurableSpace.pi.{0, 0} NNReal (fun a => Real) fun a => Real.measurableSpace)
                    ProbabilityTheory.gaussianLimit)
                  Real.normedAddCommGroup
                  (@InnerProductSpace.toNormedSpace.{0, 0} Real Real Real.instRCLike
                    (@NormedAddCommGroup.toSeminormedAddCommGroup.{0} Real Real.normedAddCommGroup)
                    (@RCLike.toInnerProductSpaceReal.{0} Real Real.instRCLike))
                  (@AmericanConvexity.Stopping.completedMeasure.{0} (NNReal → Real)
                    (@MeasurableSpace.pi.{0, 0} NNReal (fun a => Real) fun a => Real.measurableSpace)
                    ProbabilityTheory.gaussianLimit)
                  fun ω => f (AmericanConvexity.Stopping.brownianLogState β σ x j ω))
                fun ω =>
                AmericanConvexity.Stopping.brownianHeatFlow f
                  (@HMul.hMul.{0, 0, 0} Real Real Real (@instHMul.{0} Real Real.instMul)
                      (@HPow.hPow.{0, 0, 0} Real Nat Real
                        (@instHPow.{0, 0} Real Nat (@NPow.toPow.{0} Real (@Monoid.toNPow.{0} Real Real.instMonoid))) σ
                        (@OfNat.ofNat.{0} Nat (nat_lit 2) (instOfNatNat (nat_lit 2))))
                      (@HSub.hSub.{0, 0, 0} Real Real Real (@instHSub.{0} Real Real.instSub) ↑j ↑i)).toNNReal
                  (@HAdd.hAdd.{0, 0, 0} Real Real Real (@instHAdd.{0} Real Real.instAdd)
                    (AmericanConvexity.Stopping.brownianLogState β σ x i ω)
                    (@HMul.hMul.{0, 0, 0} Real Real Real (@instHMul.{0} Real Real.instMul) β
                      (@HSub.hSub.{0, 0, 0} Real Real Real (@instHSub.{0} Real Real.instSub) ↑j ↑i)))
'AmericanConvexity.Stopping.brownianLogState_usual_condExp_transition' depends on axioms: [propext,
 Classical.choice.{u},
 Quot.sound.{u}]
```

### `AmericanConvexity.Stopping.brownianUsual_adapted`

```lean
AmericanConvexity.Stopping.brownianUsual_adapted : @MeasureTheory.Adapted.{0, 0, 0} (NNReal → Real) NNReal
  (@AmericanConvexity.Stopping.completedMeasurableSpace.{0} (NNReal → Real)
    (@MeasurableSpace.pi.{0, 0} NNReal (fun a => Real) fun a => Real.measurableSpace) ProbabilityTheory.gaussianLimit)
  (@PartialOrder.toPreorder.{0} NNReal NNReal.instPartialOrder) (fun i => Real) (fun i => Real.measurableSpace)
  AmericanConvexity.Stopping.brownianUsualFiltration ProbabilityTheory.brownian
'AmericanConvexity.Stopping.brownianUsual_adapted' depends on axioms: [propext, Classical.choice.{u}, Quot.sound.{u}]
```

### `AmericanConvexity.Review.actualValue_contact_iff`

```lean
AmericanConvexity.Review.actualValue_contact_iff : ∀ {K r q σ S : Real} {τ : NNReal},
  @LT.lt.{0} Real Real.instLT (@OfNat.ofNat.{0} Real (nat_lit 0) (@Zero.toOfNat0.{0} Real Real.instZero)) K →
    @LE.le.{0} Real Real.instLE (@OfNat.ofNat.{0} Real (nat_lit 0) (@Zero.toOfNat0.{0} Real Real.instZero)) r →
      @LT.lt.{0} Real Real.instLT (@OfNat.ofNat.{0} Real (nat_lit 0) (@Zero.toOfNat0.{0} Real Real.instZero)) σ →
        @LT.lt.{0} Real Real.instLT (@OfNat.ofNat.{0} Real (nat_lit 0) (@Zero.toOfNat0.{0} Real Real.instZero)) S →
          @LT.lt.{0} NNReal (@Preorder.toLT.{0} NNReal (@PartialOrder.toPreorder.{0} NNReal NNReal.instPartialOrder))
              (@OfNat.ofNat.{0} NNReal (nat_lit 0) (@Zero.toOfNat0.{0} NNReal NNReal.instZero)) τ →
            Iff
              (@Eq.{1} Real (AmericanConvexity.Stopping.brownianUsualAmericanPut K r q σ S τ)
                (@Max.max.{0} Real Real.instMax
                  (@HSub.hSub.{0, 0, 0} Real Real Real (@instHSub.{0} Real Real.instSub) K S)
                  (@OfNat.ofNat.{0} Real (nat_lit 0) (@Zero.toOfNat0.{0} Real Real.instZero))))
              (@LE.le.{0} Real Real.instLE S (AmericanConvexity.Stopping.brownianUsualExerciseBoundary K r q σ τ))
'AmericanConvexity.Review.actualValue_contact_iff' depends on axioms: [propext, Classical.choice.{u}, Quot.sound.{u}]
```

### `AmericanConvexity.Review.actualBoundary_strict_bounds`

```lean
AmericanConvexity.Review.actualBoundary_strict_bounds : ∀ {K r q σ : Real} {τ : NNReal},
  @LT.lt.{0} Real Real.instLT (@OfNat.ofNat.{0} Real (nat_lit 0) (@Zero.toOfNat0.{0} Real Real.instZero)) K →
    @LT.lt.{0} Real Real.instLT (@OfNat.ofNat.{0} Real (nat_lit 0) (@Zero.toOfNat0.{0} Real Real.instZero)) r →
      @LE.le.{0} Real Real.instLE (@OfNat.ofNat.{0} Real (nat_lit 0) (@Zero.toOfNat0.{0} Real Real.instZero)) q →
        @LE.le.{0} Real Real.instLE q r →
          @LT.lt.{0} Real Real.instLT (@OfNat.ofNat.{0} Real (nat_lit 0) (@Zero.toOfNat0.{0} Real Real.instZero)) σ →
            @LT.lt.{0} NNReal (@Preorder.toLT.{0} NNReal (@PartialOrder.toPreorder.{0} NNReal NNReal.instPartialOrder))
                (@OfNat.ofNat.{0} NNReal (nat_lit 0) (@Zero.toOfNat0.{0} NNReal NNReal.instZero)) τ →
              And
                (@LT.lt.{0} Real Real.instLT (@OfNat.ofNat.{0} Real (nat_lit 0) (@Zero.toOfNat0.{0} Real Real.instZero))
                  (AmericanConvexity.Stopping.brownianUsualExerciseBoundary K r q σ τ))
                (@LT.lt.{0} Real Real.instLT (AmericanConvexity.Stopping.brownianUsualExerciseBoundary K r q σ τ) K)
'AmericanConvexity.Review.actualBoundary_strict_bounds' depends on axioms: [propext,
 Classical.choice.{u},
 Quot.sound.{u}]
```

### `AmericanConvexity.Review.actualValue_bounds`

```lean
AmericanConvexity.Review.actualValue_bounds : ∀ {K r q σ S : Real} (τ : NNReal),
  @LE.le.{0} Real Real.instLE (@OfNat.ofNat.{0} Real (nat_lit 0) (@Zero.toOfNat0.{0} Real Real.instZero)) K →
    @LE.le.{0} Real Real.instLE (@OfNat.ofNat.{0} Real (nat_lit 0) (@Zero.toOfNat0.{0} Real Real.instZero)) r →
      @LE.le.{0} Real Real.instLE (@OfNat.ofNat.{0} Real (nat_lit 0) (@Zero.toOfNat0.{0} Real Real.instZero)) S →
        And
          (@LE.le.{0} Real Real.instLE
            (@Max.max.{0} Real Real.instMax (@HSub.hSub.{0, 0, 0} Real Real Real (@instHSub.{0} Real Real.instSub) K S)
              (@OfNat.ofNat.{0} Real (nat_lit 0) (@Zero.toOfNat0.{0} Real Real.instZero)))
            (AmericanConvexity.Stopping.brownianUsualAmericanPut K r q σ S τ))
          (@LE.le.{0} Real Real.instLE (AmericanConvexity.Stopping.brownianUsualAmericanPut K r q σ S τ) K)
'AmericanConvexity.Review.actualValue_bounds' depends on axioms: [propext, Classical.choice.{u}, Quot.sound.{u}]
```

### `AmericanConvexity.Review.actualBoundary_eq_sup_positive_contact`

```lean
AmericanConvexity.Review.actualBoundary_eq_sup_positive_contact : ∀ {K r q σ : Real} {τ : NNReal},
  @LT.lt.{0} Real Real.instLT (@OfNat.ofNat.{0} Real (nat_lit 0) (@Zero.toOfNat0.{0} Real Real.instZero)) K →
    @LT.lt.{0} Real Real.instLT (@OfNat.ofNat.{0} Real (nat_lit 0) (@Zero.toOfNat0.{0} Real Real.instZero)) r →
      @LE.le.{0} Real Real.instLE (@OfNat.ofNat.{0} Real (nat_lit 0) (@Zero.toOfNat0.{0} Real Real.instZero)) q →
        @LE.le.{0} Real Real.instLE q r →
          @LT.lt.{0} Real Real.instLT (@OfNat.ofNat.{0} Real (nat_lit 0) (@Zero.toOfNat0.{0} Real Real.instZero)) σ →
            @LT.lt.{0} NNReal (@Preorder.toLT.{0} NNReal (@PartialOrder.toPreorder.{0} NNReal NNReal.instPartialOrder))
                (@OfNat.ofNat.{0} NNReal (nat_lit 0) (@Zero.toOfNat0.{0} NNReal NNReal.instZero)) τ →
              @Eq.{1} Real (AmericanConvexity.Stopping.brownianUsualExerciseBoundary K r q σ τ)
                (@SupSet.sSup.{0} Real Real.instSupSet
                  (@setOf.{0} Real fun S =>
                    And
                      (@LT.lt.{0} Real Real.instLT
                        (@OfNat.ofNat.{0} Real (nat_lit 0) (@Zero.toOfNat0.{0} Real Real.instZero)) S)
                      (@Eq.{1} Real (AmericanConvexity.Stopping.brownianUsualAmericanPut K r q σ S τ)
                        (@Max.max.{0} Real Real.instMax
                          (@HSub.hSub.{0, 0, 0} Real Real Real (@instHSub.{0} Real Real.instSub) K S)
                          (@OfNat.ofNat.{0} Real (nat_lit 0) (@Zero.toOfNat0.{0} Real Real.instZero))))))
'AmericanConvexity.Review.actualBoundary_eq_sup_positive_contact' depends on axioms: [propext,
 Classical.choice.{u},
 Quot.sound.{u}]
```
