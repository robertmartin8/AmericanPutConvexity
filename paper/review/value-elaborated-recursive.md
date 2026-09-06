# Recursive elaborated value-definition appendix

Snapshot: `61e3cf5483353229962626c9a94ad5a0d4dd8bb3`; Lean 4.32.0.

Read [the semantic summary and critical fully printed spine](value-elaborated-audit.md) first. This appendix is the larger construction trail, not a claim that the same-filtration Brownian-predicate audit is complete.

[RecursiveValuePrint.lean](RecursiveValuePrint.lean) collects the transitive type/body dependency closure of the six roots listed in [the inventory](value-print-dependencies.md), stopping at Mathlib and Lean/core. It emits ordinary `#print` commands for all **453** remaining declarations, including private/generated declarations. No output chunk was truncated and every inventoried name was printed exactly once.

**Printing policy:** `pp.explicit`, `pp.fullNames`, `pp.universes`, and `pp.deepTerms` are enabled. **Proof terms are suppressed** (`pp.proofs false`, threshold zero) to avoid reproducing enormous construction proofs. Consequently `⋯` denotes a pretty-printer proof omission; it does not denote an unproved axiom. The traversal itself still follows those proof bodies. This is not a full proof-term dump. The readable companion has proof printing enabled and no such omissions for its selected financial definitions and certificates.

Reproduce the inventory and chunks from the repository root:

```sh
lake env lean paper/review/RecursiveValuePrint.lean
AUDIT_START=0 AUDIT_COUNT=453 lake env lean paper/review/RecursiveValuePrint.lean
```

Roots:

- `AmericanConvexity.Stopping.brownianUsualAmericanPut`
- `AmericanConvexity.Stopping.brownianUsualExerciseBoundary`
- `AmericanConvexity.Stopping.completion_isProbabilityMeasure`
- `ProbabilityTheory.IsProbabilityMeasure_gaussianLimit`
- `ProbabilityTheory.isBrownianReal_brownian`
- `AmericanConvexity.Stopping.brownian_filtered`

---

## `HasBoundedCoveringNumber`

Command: `#print HasBoundedCoveringNumber`

```lean
structure HasBoundedCoveringNumber.{u_1} {T : Type u_1} [PseudoEMetricSpace.{u_1} T] (A : Set.{u_1} T) (c : ENNReal)
  (d : Real) : Prop
number of parameters: 5
fields:
  HasBoundedCoveringNumber.ediam_lt_top.{u_1} : @LT.lt.{0} ENNReal
      (@Preorder.toLT.{0} ENNReal (@PartialOrder.toPreorder.{0} ENNReal ENNReal.instPartialOrder))
      (@Metric.ediam.{u_1} T inst✝ A) (@Top.top.{0} ENNReal ENNReal.instTop)
  HasBoundedCoveringNumber.coveringNumber_le.{u_1} : ∀ (ε : NNReal),
      @LE.le.{0} ENNReal ENNReal.instLE (↑ε) (@Metric.ediam.{u_1} T inst✝ A) →
        @LE.le.{0} ENNReal ENNReal.instLE (↑(@Metric.coveringNumber.{u_1} T inst✝ ε A))
          (@HMul.hMul.{0, 0, 0} ENNReal ENNReal ENNReal
            (@instHMul.{0} ENNReal
              (@Distrib.toMul.{0} ENNReal
                (@instDistribOfSemiring.{0} ENNReal (@CommSemiring.toSemiring.{0} ENNReal ENNReal.instCommSemiring))))
            c
            (@HPow.hPow.{0, 0, 0} ENNReal Real ENNReal (@instHPow.{0, 0} ENNReal Real ENNReal.instPowReal)
              (@Inv.inv.{0} ENNReal ENNReal.instInv ↑ε) d))
constructor:
  HasBoundedCoveringNumber.mk.{u_1} {T : Type u_1} [PseudoEMetricSpace.{u_1} T] {A : Set.{u_1} T} {c : ENNReal}
    {d : Real}
    (ediam_lt_top :
      @LT.lt.{0} ENNReal (@Preorder.toLT.{0} ENNReal (@PartialOrder.toPreorder.{0} ENNReal ENNReal.instPartialOrder))
        (@Metric.ediam.{u_1} T inst✝ A) (@Top.top.{0} ENNReal ENNReal.instTop))
    (coveringNumber_le :
      ∀ (ε : NNReal),
        @LE.le.{0} ENNReal ENNReal.instLE (↑ε) (@Metric.ediam.{u_1} T inst✝ A) →
          @LE.le.{0} ENNReal ENNReal.instLE (↑(@Metric.coveringNumber.{u_1} T inst✝ ε A))
            (@HMul.hMul.{0, 0, 0} ENNReal ENNReal ENNReal
              (@instHMul.{0} ENNReal
                (@Distrib.toMul.{0} ENNReal
                  (@instDistribOfSemiring.{0} ENNReal (@CommSemiring.toSemiring.{0} ENNReal ENNReal.instCommSemiring))))
              c
              (@HPow.hPow.{0, 0, 0} ENNReal Real ENNReal (@instHPow.{0, 0} ENNReal Real ENNReal.instPowReal)
                (@Inv.inv.{0} ENNReal ENNReal.instInv ↑ε) d))) :
    @HasBoundedCoveringNumber.{u_1} T inst✝ A c d
```

## `IsCoverWithBoundedCoveringNumber`

Command: `#print IsCoverWithBoundedCoveringNumber`

```lean
structure IsCoverWithBoundedCoveringNumber.{u_1} {T : Type u_1} [PseudoEMetricSpace.{u_1} T] (C : Nat → Set.{u_1} T)
  (A : Set.{u_1} T) (c : Nat → ENNReal) (d : Nat → Real) : Prop
number of parameters: 6
fields:
  IsCoverWithBoundedCoveringNumber.c_ne_top.{u_1} : ∀ (n : Nat),
      @Ne.{1} ENNReal (c n) (@Top.top.{0} ENNReal ENNReal.instTop)
  IsCoverWithBoundedCoveringNumber.d_pos.{u_1} : ∀ (n : Nat),
      @LT.lt.{0} Real Real.instLT (@OfNat.ofNat.{0} Real (nat_lit 0) (@Zero.toOfNat0.{0} Real Real.instZero)) (d n)
  IsCoverWithBoundedCoveringNumber.isOpen.{u_1} : ∀ (n : Nat),
      @IsOpen.{u_1} T (@UniformSpace.toTopologicalSpace.{u_1} T (@PseudoEMetricSpace.toUniformSpace.{u_1} T inst✝))
        (C n)
  IsCoverWithBoundedCoveringNumber.totallyBounded.{u_1} : ∀ (n : Nat),
      @TotallyBounded.{u_1} T (@PseudoEMetricSpace.toUniformSpace.{u_1} T inst✝) (C n)
  IsCoverWithBoundedCoveringNumber.hasBoundedCoveringNumber.{u_1} : ∀ (n : Nat),
      @HasBoundedCoveringNumber.{u_1} T inst✝ (C n) (c n) (d n)
  IsCoverWithBoundedCoveringNumber.mono.{u_1} : ∀ (n m : Nat),
      @LE.le.{0} Nat instLENat n m → @LE.le.{u_1} (Set.{u_1} T) (@Set.instLE.{u_1} T) (C n) (C m)
  IsCoverWithBoundedCoveringNumber.subset_iUnion.{u_1} : @LE.le.{u_1} (Set.{u_1} T) (@Set.instLE.{u_1} T) A (⋃ i, C i)
constructor:
  IsCoverWithBoundedCoveringNumber.mk.{u_1} {T : Type u_1} [PseudoEMetricSpace.{u_1} T] {C : Nat → Set.{u_1} T}
    {A : Set.{u_1} T} {c : Nat → ENNReal} {d : Nat → Real}
    (c_ne_top : ∀ (n : Nat), @Ne.{1} ENNReal (c n) (@Top.top.{0} ENNReal ENNReal.instTop))
    (d_pos :
      ∀ (n : Nat),
        @LT.lt.{0} Real Real.instLT (@OfNat.ofNat.{0} Real (nat_lit 0) (@Zero.toOfNat0.{0} Real Real.instZero)) (d n))
    (isOpen :
      ∀ (n : Nat),
        @IsOpen.{u_1} T (@UniformSpace.toTopologicalSpace.{u_1} T (@PseudoEMetricSpace.toUniformSpace.{u_1} T inst✝))
          (C n))
    (totallyBounded : ∀ (n : Nat), @TotallyBounded.{u_1} T (@PseudoEMetricSpace.toUniformSpace.{u_1} T inst✝) (C n))
    (hasBoundedCoveringNumber : ∀ (n : Nat), @HasBoundedCoveringNumber.{u_1} T inst✝ (C n) (c n) (d n))
    (mono : ∀ (n m : Nat), @LE.le.{0} Nat instLENat n m → @LE.le.{u_1} (Set.{u_1} T) (@Set.instLE.{u_1} T) (C n) (C m))
    (subset_iUnion : @LE.le.{u_1} (Set.{u_1} T) (@Set.instLE.{u_1} T) A (⋃ i, C i)) :
    @IsCoverWithBoundedCoveringNumber.{u_1} T inst✝ C A c d
```

## `allProj`

Command: `#print allProj`

```lean
def allProj.{u_1, u_2} : {ι : Type u_1} →
  {α : ι → Type u_2} →
    [inst : (i : ι) → TopologicalSpace.{u_2} (α i)] →
      {s : Nat → Set.{max u_1 u_2} ((i : ι) → α i)} →
        (∀ (n : Nat),
            @Membership.mem.{max u_1 u_2, max u_1 u_2} (Set.{max u_1 u_2} ((i : ι) → α i))
              (Set.{max u_1 u_2} (Set.{max u_1 u_2} ((i : ι) → α i)))
              (@Set.instMembership.{max u_1 u_2} (Set.{max u_1 u_2} ((i : ι) → α i)))
              (@MeasureTheory.closedCompactCylinders.{u_1, u_2} ι α inst) (s n)) →
          Set.{u_1} ι :=
fun {ι} {α} [inst : (i : ι) → TopologicalSpace.{u_2} (α i)] {s} hs =>
  ⋃ n,
    @SetLike.coe.{u_1, u_1} (Finset.{u_1} ι) ι (@Finset.instSetLike.{u_1} ι)
      (@MeasureTheory.closedCompactCylinders.finset.{u_1, u_2} ι α inst (s n) ⋯)
```

## `chainingSequence`

Command: `#print chainingSequence`

```lean
def chainingSequence.{u_1} : {E : Type u_1} →
  [PseudoEMetricSpace.{u_1} E] → (Nat → Finset.{u_1} E) → E → Nat → Nat → E :=
fun {E} [inst : PseudoEMetricSpace.{u_1} E] C x k n =>
  @ite.{u_1 + 1} E (@LE.le.{0} Nat instLENat n k) (n.decLe k)
    (@chainingSequenceReverse.{u_1} E inst C x k (@HSub.hSub.{0, 0, 0} Nat Nat Nat (@instHSub.{0} Nat instSubNat) k n))
    x
```

## `chainingSequenceReverse`

Command: `#print chainingSequenceReverse`

```lean
def chainingSequenceReverse.{u_1} : {E : Type u_1} →
  [PseudoEMetricSpace.{u_1} E] → (Nat → Finset.{u_1} E) → E → Nat → Nat → E :=
fun {E} [inst : PseudoEMetricSpace.{u_1} E] C x k x_1 =>
  @Nat.brecOn.{u_1 + 1} (fun x => E) x_1 (@chainingSequenceReverse._f.{u_1} E inst C x k)
```

## `chainingSequenceReverse_add_one`

Command: `#print chainingSequenceReverse_add_one`

```lean
@[defeq] theorem chainingSequenceReverse_add_one.{u_1} : ∀ {E : Type u_1} {x : E} [inst : PseudoEMetricSpace.{u_1} E]
  {C : Nat → Finset.{u_1} E} {k : Nat} (n : Nat),
  @Eq.{u_1 + 1} E
    (@chainingSequenceReverse.{u_1} E inst C x k
      (@HAdd.hAdd.{0, 0, 0} Nat Nat Nat (@instHAdd.{0} Nat instAddNat) n
        (@OfNat.ofNat.{0} Nat (nat_lit 1) (instOfNatNat (nat_lit 1)))))
    (@nearestPt.{u_1} E
      (@WeakPseudoEMetricSpace.toEDist.{u_1} E
        (@UniformSpace.toTopologicalSpace.{u_1} E (@PseudoEMetricSpace.toUniformSpace.{u_1} E inst))
        (@PseudoEMetricSpace.toWeakPseudoEMetricSpace.{u_1} E inst))
      (C
        (@HSub.hSub.{0, 0, 0} Nat Nat Nat (@instHSub.{0} Nat instSubNat) k
          (@HAdd.hAdd.{0, 0, 0} Nat Nat Nat (@instHAdd.{0} Nat instAddNat) n
            (@OfNat.ofNat.{0} Nat (nat_lit 1) (instOfNatNat (nat_lit 1))))))
      (@chainingSequenceReverse.{u_1} E inst C x k n)) :=
⋯
```

## `chainingSequenceReverse_mem`

Command: `#print chainingSequenceReverse_mem`

```lean
theorem chainingSequenceReverse_mem.{u_1} : ∀ {E : Type u_1} {x : E} {A : Set.{u_1} E}
  [inst : PseudoEMetricSpace.{u_1} E] {ε : Nat → NNReal} {C : Nat → Finset.{u_1} E} {k n : Nat},
  (∀ (i : Nat),
      @Metric.IsCover.{u_1} E inst (ε i) A
        (@SetLike.coe.{u_1, u_1} (Finset.{u_1} E) E (@Finset.instSetLike.{u_1} E) (C i))) →
    @Set.Nonempty.{u_1} E A →
      @Membership.mem.{u_1, u_1} E (Finset.{u_1} E)
          (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} E) E (@Finset.instSetLike.{u_1} E)) (C k) x →
        @Membership.mem.{u_1, u_1} E (Finset.{u_1} E)
          (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} E) E (@Finset.instSetLike.{u_1} E))
          (C (@HSub.hSub.{0, 0, 0} Nat Nat Nat (@instHSub.{0} Nat instSubNat) k n))
          (@chainingSequenceReverse.{u_1} E inst C x k n) :=
⋯
```

## `chainingSequenceReverse_of_pos`

Command: `#print chainingSequenceReverse_of_pos`

```lean
theorem chainingSequenceReverse_of_pos.{u_1} : ∀ {E : Type u_1} {x : E} [inst : PseudoEMetricSpace.{u_1} E]
  {C : Nat → Finset.{u_1} E} {k n : Nat},
  @LT.lt.{0} Nat instLTNat (@OfNat.ofNat.{0} Nat (nat_lit 0) (instOfNatNat (nat_lit 0))) n →
    @Eq.{u_1 + 1} E (@chainingSequenceReverse.{u_1} E inst C x k n)
      (@nearestPt.{u_1} E
        (@WeakPseudoEMetricSpace.toEDist.{u_1} E
          (@UniformSpace.toTopologicalSpace.{u_1} E (@PseudoEMetricSpace.toUniformSpace.{u_1} E inst))
          (@PseudoEMetricSpace.toWeakPseudoEMetricSpace.{u_1} E inst))
        (C (@HSub.hSub.{0, 0, 0} Nat Nat Nat (@instHSub.{0} Nat instSubNat) k n))
        (@chainingSequenceReverse.{u_1} E inst C x k
          (@HSub.hSub.{0, 0, 0} Nat Nat Nat (@instHSub.{0} Nat instSubNat) n
            (@OfNat.ofNat.{0} Nat (nat_lit 1) (instOfNatNat (nat_lit 1)))))) :=
⋯
```

## `chainingSequence_chainingSequence`

Command: `#print chainingSequence_chainingSequence`

```lean
theorem chainingSequence_chainingSequence.{u_1} : ∀ {E : Type u_1} {x : E} [inst : PseudoEMetricSpace.{u_1} E]
  {C : Nat → Finset.{u_1} E} {k : Nat} (n : Nat),
  @LE.le.{0} Nat instLENat n k →
    ∀ (m : Nat),
      @LE.le.{0} Nat instLENat m n →
        @Eq.{u_1 + 1} E (@chainingSequence.{u_1} E inst C (@chainingSequence.{u_1} E inst C x k n) n m)
          (@chainingSequence.{u_1} E inst C x k m) :=
⋯
```

## `chainingSequence_mem`

Command: `#print chainingSequence_mem`

```lean
theorem chainingSequence_mem.{u_1} : ∀ {E : Type u_1} {x : E} {A : Set.{u_1} E} [inst : PseudoEMetricSpace.{u_1} E]
  {ε : Nat → NNReal} {C : Nat → Finset.{u_1} E} {k : Nat},
  (∀ (i : Nat),
      @Metric.IsCover.{u_1} E inst (ε i) A
        (@SetLike.coe.{u_1, u_1} (Finset.{u_1} E) E (@Finset.instSetLike.{u_1} E) (C i))) →
    @Set.Nonempty.{u_1} E A →
      @Membership.mem.{u_1, u_1} E (Finset.{u_1} E)
          (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} E) E (@Finset.instSetLike.{u_1} E)) (C k) x →
        ∀ (n : Nat),
          @LE.le.{0} Nat instLENat n k →
            @Membership.mem.{u_1, u_1} E (Finset.{u_1} E)
              (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} E) E (@Finset.instSetLike.{u_1} E)) (C n)
              (@chainingSequence.{u_1} E inst C x k n) :=
⋯
```

## `chainingSequence_of_eq`

Command: `#print chainingSequence_of_eq`

```lean
theorem chainingSequence_of_eq.{u_1} : ∀ {E : Type u_1} {x : E} [inst : PseudoEMetricSpace.{u_1} E]
  {C : Nat → Finset.{u_1} E} {k : Nat}, @Eq.{u_1 + 1} E (@chainingSequence.{u_1} E inst C x k k) x :=
⋯
```

## `chainingSequence_of_lt`

Command: `#print chainingSequence_of_lt`

```lean
theorem chainingSequence_of_lt.{u_1} : ∀ {E : Type u_1} {x : E} [inst : PseudoEMetricSpace.{u_1} E]
  {C : Nat → Finset.{u_1} E} {k n : Nat},
  @LT.lt.{0} Nat instLTNat n k →
    @Eq.{u_1 + 1} E (@chainingSequence.{u_1} E inst C x k n)
      (@nearestPt.{u_1} E
        (@WeakPseudoEMetricSpace.toEDist.{u_1} E
          (@UniformSpace.toTopologicalSpace.{u_1} E (@PseudoEMetricSpace.toUniformSpace.{u_1} E inst))
          (@PseudoEMetricSpace.toWeakPseudoEMetricSpace.{u_1} E inst))
        (C n)
        (@chainingSequence.{u_1} E inst C x k
          (@HAdd.hAdd.{0, 0, 0} Nat Nat Nat (@instHAdd.{0} Nat instAddNat) n
            (@OfNat.ofNat.{0} Nat (nat_lit 1) (instOfNatNat (nat_lit 1)))))) :=
⋯
```

## `congrArg₂`

Command: `#print congrArg₂`

```lean
theorem congrArg₂.{u_1, u_2, u_3} : ∀ {α : Sort u_1} {β : Sort u_2} {γ : Sort u_3} (f : α → β → γ) {x x' : α}
  {y y' : β}, @Eq.{u_1} α x x' → @Eq.{u_2} β y y' → @Eq.{u_3} γ (f x y) (f x' y') :=
⋯
```

## `congr_arg`

Command: `#print congr_arg`

```lean
theorem congr_arg.{u, v} : ∀ {α : Sort u} {β : Sort v} {a₁ a₂ : α} (f : α → β),
  @Eq.{u} α a₁ a₂ → @Eq.{v} β (f a₁) (f a₂) :=
@congrArg.{u, v}
```

## `congr_arg₂`

Command: `#print congr_arg₂`

```lean
theorem congr_arg₂.{u_1, u_2, u_3} : ∀ {α : Sort u_1} {β : Sort u_2} {γ : Sort u_3} (f : α → β → γ) {x x' : α}
  {y y' : β}, @Eq.{u_1} α x x' → @Eq.{u_2} β y y' → @Eq.{u_3} γ (f x y) (f x' y') :=
@congrArg₂.{u_1, u_2, u_3}
```

## `countable_denseCountable`

Command: `#print countable_denseCountable`

```lean
theorem countable_denseCountable.{u_1} : ∀ {T : Type u_1} [inst : TopologicalSpace.{u_1} T]
  [inst_1 : @SecondCountableTopology.{u_1} T inst], @Set.Countable.{u_1} T (@denseCountable.{u_1} T inst inst_1) :=
⋯
```

## `coveringNumber_closedBall_le`

Command: `#print coveringNumber_closedBall_le`

```lean
theorem coveringNumber_closedBall_le.{u_1} : ∀ {E : Type u_1} [inst : NormedAddCommGroup.{u_1} E]
  [inst_1 :
    @InnerProductSpace.{0, u_1} Real E Real.instRCLike (@NormedAddCommGroup.toSeminormedAddCommGroup.{u_1} E inst)]
  [@FiniteDimensional.{0, u_1} Real E Real.instDivisionRing (@NormedAddCommGroup.toAddCommGroup.{u_1} E inst)
      (@NormedSpace.toModule.{0, u_1} Real E Real.normedField
        (@NormedAddCommGroup.toSeminormedAddCommGroup.{u_1} E inst)
        (@InnerProductSpace.toNormedSpace.{0, u_1} Real E Real.instRCLike
          (@NormedAddCommGroup.toSeminormedAddCommGroup.{u_1} E inst) inst_1))]
  [inst_3 : MeasurableSpace.{u_1} E]
  [@BorelSpace.{u_1} E
      (@UniformSpace.toTopologicalSpace.{u_1} E
        (@PseudoMetricSpace.toUniformSpace.{u_1} E
          (@SeminormedAddCommGroup.toPseudoMetricSpace.{u_1} E
            (@NormedAddCommGroup.toSeminormedAddCommGroup.{u_1} E inst))))
      inst_3]
  (ε : NNReal) (x : E) (r : NNReal),
  @LE.le.{0} ENNReal ENNReal.instLE
    (↑(@Metric.coveringNumber.{u_1} E
        (@EMetricSpace.toPseudoEMetricSpace.{u_1} E
          (@MetricSpace.toEMetricSpace.{u_1} E (@NormedAddCommGroup.toMetricSpace.{u_1} E inst)))
        ε
        (@Metric.closedEBall.{u_1} E
          (@EMetricSpace.toPseudoEMetricSpace.{u_1} E
            (@MetricSpace.toEMetricSpace.{u_1} E (@NormedAddCommGroup.toMetricSpace.{u_1} E inst)))
          x ↑r)))
    (@HPow.hPow.{0, 0, 0} ENNReal Nat ENNReal
      (@instHPow.{0, 0} ENNReal Nat
        (@NPow.toPow.{0} ENNReal
          (@Monoid.toNPow.{0} ENNReal
            (@Semiring.toMonoid.{0} ENNReal (@CommSemiring.toSemiring.{0} ENNReal ENNReal.instCommSemiring)))))
      (@HAdd.hAdd.{0, 0, 0} ENNReal ENNReal ENNReal (@instHAdd.{0} ENNReal ENNReal.instAdd)
        (@HDiv.hDiv.{0, 0, 0} ENNReal ENNReal ENNReal
          (@instHDiv.{0} ENNReal (@DivInvMonoid.toDiv.{0} ENNReal ENNReal.instDivInvMonoid))
          (@HMul.hMul.{0, 0, 0} ENNReal ENNReal ENNReal
            (@instHMul.{0} ENNReal
              (@Distrib.toMul.{0} ENNReal
                (@instDistribOfSemiring.{0} ENNReal (@CommSemiring.toSemiring.{0} ENNReal ENNReal.instCommSemiring))))
            (@OfNat.ofNat.{0} ENNReal (nat_lit 2)
              (@instOfNatAtLeastTwo.{0} ENNReal (nat_lit 2)
                (@AddMonoidWithOne.toNatCast.{0} ENNReal
                  (@AddCommMonoidWithOne.toAddMonoidWithOne.{0} ENNReal ENNReal.instAddCommMonoidWithOne))
                ⋯))
            ↑r)
          ↑ε)
        (@OfNat.ofNat.{0} ENNReal (nat_lit 1) (@One.toOfNat1.{0} ENNReal ENNReal.instOne)))
      (@Module.finrank.{0, u_1} Real E Real.semiring
        (@AddCommGroup.toAddCommMonoid.{u_1} E (@NormedAddCommGroup.toAddCommGroup.{u_1} E inst))
        (@NormedSpace.toModule.{0, u_1} Real E Real.normedField
          (@NormedAddCommGroup.toSeminormedAddCommGroup.{u_1} E inst)
          (@InnerProductSpace.toNormedSpace.{0, u_1} Real E Real.instRCLike
            (@NormedAddCommGroup.toSeminormedAddCommGroup.{u_1} E inst) inst_1)))) :=
⋯
```

## `coveringNumber_closedBall_le_three_mul`

Command: `#print coveringNumber_closedBall_le_three_mul`

```lean
theorem coveringNumber_closedBall_le_three_mul.{u_1} : ∀ {E : Type u_1} [inst : NormedAddCommGroup.{u_1} E]
  [inst_1 :
    @InnerProductSpace.{0, u_1} Real E Real.instRCLike (@NormedAddCommGroup.toSeminormedAddCommGroup.{u_1} E inst)]
  [@FiniteDimensional.{0, u_1} Real E Real.instDivisionRing (@NormedAddCommGroup.toAddCommGroup.{u_1} E inst)
      (@NormedSpace.toModule.{0, u_1} Real E Real.normedField
        (@NormedAddCommGroup.toSeminormedAddCommGroup.{u_1} E inst)
        (@InnerProductSpace.toNormedSpace.{0, u_1} Real E Real.instRCLike
          (@NormedAddCommGroup.toSeminormedAddCommGroup.{u_1} E inst) inst_1))]
  [inst_3 : MeasurableSpace.{u_1} E]
  [@BorelSpace.{u_1} E
      (@UniformSpace.toTopologicalSpace.{u_1} E
        (@PseudoMetricSpace.toUniformSpace.{u_1} E
          (@SeminormedAddCommGroup.toPseudoMetricSpace.{u_1} E
            (@NormedAddCommGroup.toSeminormedAddCommGroup.{u_1} E inst))))
      inst_3]
  {ε : NNReal} [Nontrivial.{u_1} E] {x : E} {r : NNReal},
  @Ne.{1} NNReal r (@OfNat.ofNat.{0} NNReal (nat_lit 0) (@Zero.toOfNat0.{0} NNReal NNReal.instZero)) →
    @LE.le.{0} NNReal (@Preorder.toLE.{0} NNReal (@PartialOrder.toPreorder.{0} NNReal NNReal.instPartialOrder)) ε r →
      @LE.le.{0} ENNReal ENNReal.instLE
        (↑(@Metric.coveringNumber.{u_1} E
            (@EMetricSpace.toPseudoEMetricSpace.{u_1} E
              (@MetricSpace.toEMetricSpace.{u_1} E (@NormedAddCommGroup.toMetricSpace.{u_1} E inst)))
            ε
            (@Metric.closedEBall.{u_1} E
              (@EMetricSpace.toPseudoEMetricSpace.{u_1} E
                (@MetricSpace.toEMetricSpace.{u_1} E (@NormedAddCommGroup.toMetricSpace.{u_1} E inst)))
              x ↑r)))
        (@HPow.hPow.{0, 0, 0} ENNReal Nat ENNReal
          (@instHPow.{0, 0} ENNReal Nat
            (@NPow.toPow.{0} ENNReal
              (@Monoid.toNPow.{0} ENNReal
                (@Semiring.toMonoid.{0} ENNReal (@CommSemiring.toSemiring.{0} ENNReal ENNReal.instCommSemiring)))))
          (@HDiv.hDiv.{0, 0, 0} ENNReal ENNReal ENNReal
            (@instHDiv.{0} ENNReal (@DivInvMonoid.toDiv.{0} ENNReal ENNReal.instDivInvMonoid))
            (@HMul.hMul.{0, 0, 0} ENNReal ENNReal ENNReal
              (@instHMul.{0} ENNReal
                (@Distrib.toMul.{0} ENNReal
                  (@instDistribOfSemiring.{0} ENNReal (@CommSemiring.toSemiring.{0} ENNReal ENNReal.instCommSemiring))))
              (@OfNat.ofNat.{0} ENNReal (nat_lit 3)
                (@instOfNatAtLeastTwo.{0} ENNReal (nat_lit 3)
                  (@AddMonoidWithOne.toNatCast.{0} ENNReal
                    (@AddCommMonoidWithOne.toAddMonoidWithOne.{0} ENNReal ENNReal.instAddCommMonoidWithOne))
                  ⋯))
              ↑r)
            ↑ε)
          (@Module.finrank.{0, u_1} Real E Real.semiring
            (@AddCommGroup.toAddCommMonoid.{u_1} E (@NormedAddCommGroup.toAddCommGroup.{u_1} E inst))
            (@NormedSpace.toModule.{0, u_1} Real E Real.normedField
              (@NormedAddCommGroup.toSeminormedAddCommGroup.{u_1} E inst)
              (@InnerProductSpace.toNormedSpace.{0, u_1} Real E Real.instRCLike
                (@NormedAddCommGroup.toSeminormedAddCommGroup.{u_1} E inst) inst_1)))) :=
⋯
```

## `coveringNumber_le_volume_div`

Command: `#print coveringNumber_le_volume_div`

```lean
theorem coveringNumber_le_volume_div.{u_1} : ∀ {E : Type u_1} [inst : NormedAddCommGroup.{u_1} E]
  [inst_1 :
    @InnerProductSpace.{0, u_1} Real E Real.instRCLike (@NormedAddCommGroup.toSeminormedAddCommGroup.{u_1} E inst)]
  [inst_2 :
    @FiniteDimensional.{0, u_1} Real E Real.instDivisionRing (@NormedAddCommGroup.toAddCommGroup.{u_1} E inst)
      (@NormedSpace.toModule.{0, u_1} Real E Real.normedField
        (@NormedAddCommGroup.toSeminormedAddCommGroup.{u_1} E inst)
        (@InnerProductSpace.toNormedSpace.{0, u_1} Real E Real.instRCLike
          (@NormedAddCommGroup.toSeminormedAddCommGroup.{u_1} E inst) inst_1))]
  [inst_3 : MeasurableSpace.{u_1} E]
  [inst_4 :
    @BorelSpace.{u_1} E
      (@UniformSpace.toTopologicalSpace.{u_1} E
        (@PseudoMetricSpace.toUniformSpace.{u_1} E
          (@SeminormedAddCommGroup.toPseudoMetricSpace.{u_1} E
            (@NormedAddCommGroup.toSeminormedAddCommGroup.{u_1} E inst))))
      inst_3]
  {ε : NNReal} (A : Set.{u_1} E),
  @LT.lt.{0} NNReal (@Preorder.toLT.{0} NNReal (@PartialOrder.toPreorder.{0} NNReal NNReal.instPartialOrder))
      (@OfNat.ofNat.{0} NNReal (nat_lit 0) (@Zero.toOfNat0.{0} NNReal NNReal.instZero)) ε →
    @LE.le.{0} ENNReal ENNReal.instLE
      (↑(@Metric.coveringNumber.{u_1} E
          (@EMetricSpace.toPseudoEMetricSpace.{u_1} E
            (@MetricSpace.toEMetricSpace.{u_1} E (@NormedAddCommGroup.toMetricSpace.{u_1} E inst)))
          ε A))
      (@HDiv.hDiv.{0, 0, 0} ENNReal ENNReal ENNReal
        (@instHDiv.{0} ENNReal (@DivInvMonoid.toDiv.{0} ENNReal ENNReal.instDivInvMonoid))
        (@DFunLike.coe.{u_1 + 1, u_1 + 1, 1}
          (@MeasureTheory.Measure.{u_1} E
            (@MeasureTheory.MeasureSpace.toMeasurableSpace.{u_1} E
              (@measureSpaceOfInnerProductSpace.{u_1} E inst inst_1 inst_2 inst_3 inst_4)))
          (Set.{u_1} E) (fun x => ENNReal)
          (@MeasureTheory.Measure.instFunLike.{u_1} E
            (@MeasureTheory.MeasureSpace.toMeasurableSpace.{u_1} E
              (@measureSpaceOfInnerProductSpace.{u_1} E inst inst_1 inst_2 inst_3 inst_4)))
          (@MeasureTheory.MeasureSpace.volume.{u_1} E
            (@measureSpaceOfInnerProductSpace.{u_1} E inst inst_1 inst_2 inst_3 inst_4))
          (@HAdd.hAdd.{u_1, u_1, u_1} (Set.{u_1} E) (Set.{u_1} E) (Set.{u_1} E)
            (@instHAdd.{u_1} (Set.{u_1} E)
              (@Set.add.{u_1} E
                (@AddCommMagma.toAdd.{u_1} E
                  (@AddCommSemigroup.toAddCommMagma.{u_1} E
                    (@AddCommMonoid.toAddCommSemigroup.{u_1} E
                      (@AddCommGroup.toAddCommMonoid.{u_1} E (@NormedAddCommGroup.toAddCommGroup.{u_1} E inst)))))))
            A
            (@Metric.closedEBall.{u_1} E
              (@EMetricSpace.toPseudoEMetricSpace.{u_1} E
                (@MetricSpace.toEMetricSpace.{u_1} E (@NormedAddCommGroup.toMetricSpace.{u_1} E inst)))
              (@OfNat.ofNat.{u_1} E (nat_lit 0)
                (@Zero.toOfNat0.{u_1} E
                  (@NegZeroClass.toZero.{u_1} E
                    (@SubNegZeroMonoid.toNegZeroClass.{u_1} E
                      (@SubtractionMonoid.toSubNegZeroMonoid.{u_1} E
                        (@SubtractionCommMonoid.toSubtractionMonoid.{u_1} E
                          (@AddCommGroup.toDivisionAddCommMonoid.{u_1} E
                            (@NormedAddCommGroup.toAddCommGroup.{u_1} E inst))))))))
              (@HDiv.hDiv.{0, 0, 0} ENNReal ENNReal ENNReal
                (@instHDiv.{0} ENNReal (@DivInvMonoid.toDiv.{0} ENNReal ENNReal.instDivInvMonoid)) (↑ε)
                (@OfNat.ofNat.{0} ENNReal (nat_lit 2)
                  (@instOfNatAtLeastTwo.{0} ENNReal (nat_lit 2)
                    (@AddMonoidWithOne.toNatCast.{0} ENNReal
                      (@AddCommMonoidWithOne.toAddMonoidWithOne.{0} ENNReal ENNReal.instAddCommMonoidWithOne))
                    ⋯))))))
        (@DFunLike.coe.{u_1 + 1, u_1 + 1, 1}
          (@MeasureTheory.Measure.{u_1} E
            (@MeasureTheory.MeasureSpace.toMeasurableSpace.{u_1} E
              (@measureSpaceOfInnerProductSpace.{u_1} E inst inst_1 inst_2 inst_3 inst_4)))
          (Set.{u_1} E) (fun x => ENNReal)
          (@MeasureTheory.Measure.instFunLike.{u_1} E
            (@MeasureTheory.MeasureSpace.toMeasurableSpace.{u_1} E
              (@measureSpaceOfInnerProductSpace.{u_1} E inst inst_1 inst_2 inst_3 inst_4)))
          (@MeasureTheory.MeasureSpace.volume.{u_1} E
            (@measureSpaceOfInnerProductSpace.{u_1} E inst inst_1 inst_2 inst_3 inst_4))
          (@Metric.closedEBall.{u_1} E
            (@EMetricSpace.toPseudoEMetricSpace.{u_1} E
              (@MetricSpace.toEMetricSpace.{u_1} E (@NormedAddCommGroup.toMetricSpace.{u_1} E inst)))
            (@OfNat.ofNat.{u_1} E (nat_lit 0)
              (@Zero.toOfNat0.{u_1} E
                (@NegZeroClass.toZero.{u_1} E
                  (@SubNegZeroMonoid.toNegZeroClass.{u_1} E
                    (@SubtractionMonoid.toSubNegZeroMonoid.{u_1} E
                      (@SubtractionCommMonoid.toSubtractionMonoid.{u_1} E
                        (@AddCommGroup.toDivisionAddCommMonoid.{u_1} E
                          (@NormedAddCommGroup.toAddCommGroup.{u_1} E inst))))))))
            (@HDiv.hDiv.{0, 0, 0} ENNReal ENNReal ENNReal
              (@instHDiv.{0} ENNReal (@DivInvMonoid.toDiv.{0} ENNReal ENNReal.instDivInvMonoid)) (↑ε)
              (@OfNat.ofNat.{0} ENNReal (nat_lit 2)
                (@instOfNatAtLeastTwo.{0} ENNReal (nat_lit 2)
                  (@AddMonoidWithOne.toNatCast.{0} ENNReal
                    (@AddCommMonoidWithOne.toAddMonoidWithOne.{0} ENNReal ENNReal.instAddCommMonoidWithOne))
                  ⋯)))))) :=
⋯
```

## `denseCountable`

Command: `#print denseCountable`

```lean
def denseCountable.{u_1} : (T : Type u_1) →
  [inst : TopologicalSpace.{u_1} T] → [@SecondCountableTopology.{u_1} T inst] → Set.{u_1} T :=
fun T [inst : TopologicalSpace.{u_1} T] [@SecondCountableTopology.{u_1} T inst] =>
  @Exists.choose.{u_1 + 1} (Set.{u_1} T) (fun s => And (@Set.Countable.{u_1} T s) (@Dense.{u_1} T inst s)) ⋯
```

## `dense_denseCountable`

Command: `#print dense_denseCountable`

```lean
theorem dense_denseCountable.{u_1} : ∀ {T : Type u_1} [inst : TopologicalSpace.{u_1} T]
  [inst_1 : @SecondCountableTopology.{u_1} T inst], @Dense.{u_1} T inst (@denseCountable.{u_1} T inst inst_1) :=
⋯
```

## `edist_chainingSequence_add_one`

Command: `#print edist_chainingSequence_add_one`

```lean
theorem edist_chainingSequence_add_one.{u_1} : ∀ {E : Type u_1} {x : E} {A : Set.{u_1} E}
  [inst : PseudoEMetricSpace.{u_1} E] {ε : Nat → NNReal} {C : Nat → Finset.{u_1} E} {k : Nat},
  (∀ (i : Nat),
      @Metric.IsCover.{u_1} E inst (ε i) A
        (@SetLike.coe.{u_1, u_1} (Finset.{u_1} E) E (@Finset.instSetLike.{u_1} E) (C i))) →
    (∀ (i : Nat),
        @LE.le.{u_1} (Set.{u_1} E) (@Set.instLE.{u_1} E)
          (@SetLike.coe.{u_1, u_1} (Finset.{u_1} E) E (@Finset.instSetLike.{u_1} E) (C i)) A) →
      @Membership.mem.{u_1, u_1} E (Finset.{u_1} E)
          (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} E) E (@Finset.instSetLike.{u_1} E)) (C k) x →
        ∀ (n : Nat),
          @LT.lt.{0} Nat instLTNat n k →
            @LE.le.{0} ENNReal ENNReal.instLE
              (@EDist.edist.{u_1} E
                (@WeakPseudoEMetricSpace.toEDist.{u_1} E
                  (@UniformSpace.toTopologicalSpace.{u_1} E (@PseudoEMetricSpace.toUniformSpace.{u_1} E inst))
                  (@PseudoEMetricSpace.toWeakPseudoEMetricSpace.{u_1} E inst))
                (@chainingSequence.{u_1} E inst C x k
                  (@HAdd.hAdd.{0, 0, 0} Nat Nat Nat (@instHAdd.{0} Nat instAddNat) n
                    (@OfNat.ofNat.{0} Nat (nat_lit 1) (instOfNatNat (nat_lit 1)))))
                (@chainingSequence.{u_1} E inst C x k n))
              ↑(ε n) :=
⋯
```

## `edist_chainingSequence_add_one_self`

Command: `#print edist_chainingSequence_add_one_self`

```lean
theorem edist_chainingSequence_add_one_self.{u_1} : ∀ {E : Type u_1} {x : E} {A : Set.{u_1} E}
  [inst : PseudoEMetricSpace.{u_1} E] {ε : Nat → NNReal} {C : Nat → Finset.{u_1} E} {k : Nat},
  (∀ (i : Nat),
      @Metric.IsCover.{u_1} E inst (ε i) A
        (@SetLike.coe.{u_1, u_1} (Finset.{u_1} E) E (@Finset.instSetLike.{u_1} E) (C i))) →
    (∀ (i : Nat),
        @LE.le.{u_1} (Set.{u_1} E) (@Set.instLE.{u_1} E)
          (@SetLike.coe.{u_1, u_1} (Finset.{u_1} E) E (@Finset.instSetLike.{u_1} E) (C i)) A) →
      @Membership.mem.{u_1, u_1} E (Finset.{u_1} E)
          (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} E) E (@Finset.instSetLike.{u_1} E))
          (C
            (@HAdd.hAdd.{0, 0, 0} Nat Nat Nat (@instHAdd.{0} Nat instAddNat) k
              (@OfNat.ofNat.{0} Nat (nat_lit 1) (instOfNatNat (nat_lit 1)))))
          x →
        @LE.le.{0} ENNReal ENNReal.instLE
          (@EDist.edist.{u_1} E
            (@WeakPseudoEMetricSpace.toEDist.{u_1} E
              (@UniformSpace.toTopologicalSpace.{u_1} E (@PseudoEMetricSpace.toUniformSpace.{u_1} E inst))
              (@PseudoEMetricSpace.toWeakPseudoEMetricSpace.{u_1} E inst))
            (@chainingSequence.{u_1} E inst C x
              (@HAdd.hAdd.{0, 0, 0} Nat Nat Nat (@instHAdd.{0} Nat instAddNat) k
                (@OfNat.ofNat.{0} Nat (nat_lit 1) (instOfNatNat (nat_lit 1))))
              k)
            x)
          ↑(ε k) :=
⋯
```

## `edist_chainingSequence_le`

Command: `#print edist_chainingSequence_le`

```lean
theorem edist_chainingSequence_le.{u_1} : ∀ {E : Type u_1} {x y : E} {A : Set.{u_1} E}
  [inst : PseudoEMetricSpace.{u_1} E] {ε : Nat → NNReal} {C : Nat → Finset.{u_1} E} {k n : Nat},
  (∀ (i : Nat),
      @Metric.IsCover.{u_1} E inst (ε i) A
        (@SetLike.coe.{u_1, u_1} (Finset.{u_1} E) E (@Finset.instSetLike.{u_1} E) (C i))) →
    (∀ (i : Nat),
        @LE.le.{u_1} (Set.{u_1} E) (@Set.instLE.{u_1} E)
          (@SetLike.coe.{u_1, u_1} (Finset.{u_1} E) E (@Finset.instSetLike.{u_1} E) (C i)) A) →
      @Membership.mem.{u_1, u_1} E (Finset.{u_1} E)
          (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} E) E (@Finset.instSetLike.{u_1} E)) (C k) x →
        @Membership.mem.{u_1, u_1} E (Finset.{u_1} E)
            (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} E) E (@Finset.instSetLike.{u_1} E)) (C n) y →
          ∀ (m : Nat),
            @LE.le.{0} Nat instLENat m k →
              @LE.le.{0} Nat instLENat m n →
                @LE.le.{0} ENNReal ENNReal.instLE
                  (@EDist.edist.{u_1} E
                    (@WeakPseudoEMetricSpace.toEDist.{u_1} E
                      (@UniformSpace.toTopologicalSpace.{u_1} E (@PseudoEMetricSpace.toUniformSpace.{u_1} E inst))
                      (@PseudoEMetricSpace.toWeakPseudoEMetricSpace.{u_1} E inst))
                    (@chainingSequence.{u_1} E inst C x k m) (@chainingSequence.{u_1} E inst C y n m))
                  (@HAdd.hAdd.{0, 0, 0} ENNReal ENNReal ENNReal (@instHAdd.{0} ENNReal ENNReal.instAdd)
                    (@HAdd.hAdd.{0, 0, 0} ENNReal ENNReal ENNReal (@instHAdd.{0} ENNReal ENNReal.instAdd)
                      (@EDist.edist.{u_1} E
                        (@WeakPseudoEMetricSpace.toEDist.{u_1} E
                          (@UniformSpace.toTopologicalSpace.{u_1} E (@PseudoEMetricSpace.toUniformSpace.{u_1} E inst))
                          (@PseudoEMetricSpace.toWeakPseudoEMetricSpace.{u_1} E inst))
                        x y)
                      (∑ i ∈ Finset.range (@HSub.hSub.{0, 0, 0} Nat Nat Nat (@instHSub.{0} Nat instSubNat) k m),
                        ↑(ε (@HAdd.hAdd.{0, 0, 0} Nat Nat Nat (@instHAdd.{0} Nat instAddNat) m i))))
                    (∑ j ∈ Finset.range (@HSub.hSub.{0, 0, 0} Nat Nat Nat (@instHSub.{0} Nat instSubNat) n m),
                      ↑(ε (@HAdd.hAdd.{0, 0, 0} Nat Nat Nat (@instHAdd.{0} Nat instAddNat) m j)))) :=
⋯
```

## `edist_chainingSequence_le_sum`

Command: `#print edist_chainingSequence_le_sum`

```lean
theorem edist_chainingSequence_le_sum.{u_1} : ∀ {E : Type u_1} {x : E} {A : Set.{u_1} E}
  [inst : PseudoEMetricSpace.{u_1} E] {ε : Nat → NNReal} {C : Nat → Finset.{u_1} E} {k : Nat},
  (∀ (i : Nat),
      @Metric.IsCover.{u_1} E inst (ε i) A
        (@SetLike.coe.{u_1, u_1} (Finset.{u_1} E) E (@Finset.instSetLike.{u_1} E) (C i))) →
    (∀ (i : Nat),
        @LE.le.{u_1} (Set.{u_1} E) (@Set.instLE.{u_1} E)
          (@SetLike.coe.{u_1, u_1} (Finset.{u_1} E) E (@Finset.instSetLike.{u_1} E) (C i)) A) →
      @Membership.mem.{u_1, u_1} E (Finset.{u_1} E)
          (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} E) E (@Finset.instSetLike.{u_1} E)) (C k) x →
        ∀ (m : Nat),
          @LE.le.{0} Nat instLENat m k →
            @LE.le.{0} ENNReal ENNReal.instLE
              (@EDist.edist.{u_1} E
                (@WeakPseudoEMetricSpace.toEDist.{u_1} E
                  (@UniformSpace.toTopologicalSpace.{u_1} E (@PseudoEMetricSpace.toUniformSpace.{u_1} E inst))
                  (@PseudoEMetricSpace.toWeakPseudoEMetricSpace.{u_1} E inst))
                (@chainingSequence.{u_1} E inst C x k m) x)
              (∑ i ∈ Finset.range (@HSub.hSub.{0, 0, 0} Nat Nat Nat (@instHSub.{0} Nat instSubNat) k m),
                ↑(ε (@HAdd.hAdd.{0, 0, 0} Nat Nat Nat (@instHAdd.{0} Nat instAddNat) m i))) :=
⋯
```

## `edist_chainingSequence_le_sum_edist`

Command: `#print edist_chainingSequence_le_sum_edist`

```lean
theorem edist_chainingSequence_le_sum_edist.{u_1, u_2} : ∀ {E : Type u_1} {x : E} [inst : PseudoEMetricSpace.{u_1} E]
  {C : Nat → Finset.{u_1} E} {k : Nat} {T : Type u_2} [inst_1 : PseudoEMetricSpace.{u_2} T] (f : E → T) {m : Nat},
  @LE.le.{0} Nat instLENat m k →
    @LE.le.{0} ENNReal ENNReal.instLE
      (@EDist.edist.{u_2} T
        (@WeakPseudoEMetricSpace.toEDist.{u_2} T
          (@UniformSpace.toTopologicalSpace.{u_2} T (@PseudoEMetricSpace.toUniformSpace.{u_2} T inst_1))
          (@PseudoEMetricSpace.toWeakPseudoEMetricSpace.{u_2} T inst_1))
        (f x) (f (@chainingSequence.{u_1} E inst C x k m)))
      (∑ i ∈ Finset.range (@HSub.hSub.{0, 0, 0} Nat Nat Nat (@instHSub.{0} Nat instSubNat) k m),
        @EDist.edist.{u_2} T
          (@WeakPseudoEMetricSpace.toEDist.{u_2} T
            (@UniformSpace.toTopologicalSpace.{u_2} T (@PseudoEMetricSpace.toUniformSpace.{u_2} T inst_1))
            (@PseudoEMetricSpace.toWeakPseudoEMetricSpace.{u_2} T inst_1))
          (f
            (@chainingSequence.{u_1} E inst C x k
              (@HAdd.hAdd.{0, 0, 0} Nat Nat Nat (@instHAdd.{0} Nat instAddNat) m i)))
          (f
            (@chainingSequence.{u_1} E inst C x k
              (@HAdd.hAdd.{0, 0, 0} Nat Nat Nat (@instHAdd.{0} Nat instAddNat)
                (@HAdd.hAdd.{0, 0, 0} Nat Nat Nat (@instHAdd.{0} Nat instAddNat) m i)
                (@OfNat.ofNat.{0} Nat (nat_lit 1) (instOfNatNat (nat_lit 1))))))) :=
⋯
```

## `edist_chainingSequence_le_sum_edist'`

Command: `#print edist_chainingSequence_le_sum_edist'`

```lean
theorem edist_chainingSequence_le_sum_edist'.{u_1, u_2} : ∀ {E : Type u_1} {x : E} [inst : PseudoEMetricSpace.{u_1} E]
  {C : Nat → Finset.{u_1} E} {k : Nat} {T : Type u_2} [inst_1 : PseudoEMetricSpace.{u_2} T] (f : E → T) {m : Nat},
  @LE.le.{0} Nat instLENat m k →
    @LE.le.{0} ENNReal ENNReal.instLE
      (@EDist.edist.{u_2} T
        (@WeakPseudoEMetricSpace.toEDist.{u_2} T
          (@UniformSpace.toTopologicalSpace.{u_2} T (@PseudoEMetricSpace.toUniformSpace.{u_2} T inst_1))
          (@PseudoEMetricSpace.toWeakPseudoEMetricSpace.{u_2} T inst_1))
        (f (@chainingSequence.{u_1} E inst C x k m)) (f x))
      (∑ i ∈ Finset.range (@HSub.hSub.{0, 0, 0} Nat Nat Nat (@instHSub.{0} Nat instSubNat) k m),
        @EDist.edist.{u_2} T
          (@WeakPseudoEMetricSpace.toEDist.{u_2} T
            (@UniformSpace.toTopologicalSpace.{u_2} T (@PseudoEMetricSpace.toUniformSpace.{u_2} T inst_1))
            (@PseudoEMetricSpace.toWeakPseudoEMetricSpace.{u_2} T inst_1))
          (f
            (@chainingSequence.{u_1} E inst C x k
              (@HAdd.hAdd.{0, 0, 0} Nat Nat Nat (@instHAdd.{0} Nat instAddNat)
                (@HAdd.hAdd.{0, 0, 0} Nat Nat Nat (@instHAdd.{0} Nat instAddNat) m i)
                (@OfNat.ofNat.{0} Nat (nat_lit 1) (instOfNatNat (nat_lit 1))))))
          (f
            (@chainingSequence.{u_1} E inst C x k
              (@HAdd.hAdd.{0, 0, 0} Nat Nat Nat (@instHAdd.{0} Nat instAddNat) m i)))) :=
⋯
```

## `edist_chainingSequence_pow_two_le`

Command: `#print edist_chainingSequence_pow_two_le`

```lean
theorem edist_chainingSequence_pow_two_le.{u_1} : ∀ {E : Type u_1} {x y : E} {A : Set.{u_1} E}
  [inst : PseudoEMetricSpace.{u_1} E] {C : Nat → Finset.{u_1} E} {k n : Nat} {ε₀ : NNReal},
  (∀ (i : Nat),
      @Metric.IsCover.{u_1} E inst
        (@HMul.hMul.{0, 0, 0} NNReal NNReal NNReal
          (@instHMul.{0} NNReal (@Distrib.toMul.{0} NNReal (@instDistribOfSemiring.{0} NNReal NNReal.instSemiring))) ε₀
          (@HPow.hPow.{0, 0, 0} NNReal Nat NNReal
            (@instHPow.{0, 0} NNReal Nat
              (@NPow.toPow.{0} NNReal (@Monoid.toNPow.{0} NNReal (@Semiring.toMonoid.{0} NNReal NNReal.instSemiring))))
            (@Inv.inv.{0} NNReal NNReal.instInv
              (@OfNat.ofNat.{0} NNReal (nat_lit 2)
                (@instOfNatAtLeastTwo.{0} NNReal (nat_lit 2)
                  (@AddMonoidWithOne.toNatCast.{0} NNReal
                    (@AddCommMonoidWithOne.toAddMonoidWithOne.{0} NNReal
                      (@NonAssocSemiring.toAddCommMonoidWithOne.{0} NNReal
                        (@Semiring.toNonAssocSemiring.{0} NNReal NNReal.instSemiring))))
                  ⋯)))
            i))
        A (@SetLike.coe.{u_1, u_1} (Finset.{u_1} E) E (@Finset.instSetLike.{u_1} E) (C i))) →
    (∀ (i : Nat),
        @LE.le.{u_1} (Set.{u_1} E) (@Set.instLE.{u_1} E)
          (@SetLike.coe.{u_1, u_1} (Finset.{u_1} E) E (@Finset.instSetLike.{u_1} E) (C i)) A) →
      @Membership.mem.{u_1, u_1} E (Finset.{u_1} E)
          (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} E) E (@Finset.instSetLike.{u_1} E)) (C k) x →
        @Membership.mem.{u_1, u_1} E (Finset.{u_1} E)
            (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} E) E (@Finset.instSetLike.{u_1} E)) (C n) y →
          ∀ (m : Nat),
            @LE.le.{0} Nat instLENat m k →
              @LE.le.{0} Nat instLENat m n →
                @LE.le.{0} ENNReal ENNReal.instLE
                  (@EDist.edist.{u_1} E
                    (@WeakPseudoEMetricSpace.toEDist.{u_1} E
                      (@UniformSpace.toTopologicalSpace.{u_1} E (@PseudoEMetricSpace.toUniformSpace.{u_1} E inst))
                      (@PseudoEMetricSpace.toWeakPseudoEMetricSpace.{u_1} E inst))
                    (@chainingSequence.{u_1} E inst C x k m) (@chainingSequence.{u_1} E inst C y n m))
                  (@HAdd.hAdd.{0, 0, 0} ENNReal ENNReal ENNReal (@instHAdd.{0} ENNReal ENNReal.instAdd)
                    (@EDist.edist.{u_1} E
                      (@WeakPseudoEMetricSpace.toEDist.{u_1} E
                        (@UniformSpace.toTopologicalSpace.{u_1} E (@PseudoEMetricSpace.toUniformSpace.{u_1} E inst))
                        (@PseudoEMetricSpace.toWeakPseudoEMetricSpace.{u_1} E inst))
                      x y)
                    (@HMul.hMul.{0, 0, 0} ENNReal ENNReal ENNReal
                      (@instHMul.{0} ENNReal
                        (@Distrib.toMul.{0} ENNReal
                          (@instDistribOfSemiring.{0} ENNReal
                            (@CommSemiring.toSemiring.{0} ENNReal ENNReal.instCommSemiring))))
                      (@HMul.hMul.{0, 0, 0} ENNReal ENNReal ENNReal
                        (@instHMul.{0} ENNReal
                          (@Distrib.toMul.{0} ENNReal
                            (@instDistribOfSemiring.{0} ENNReal
                              (@CommSemiring.toSemiring.{0} ENNReal ENNReal.instCommSemiring))))
                        (↑ε₀)
                        (@OfNat.ofNat.{0} ENNReal (nat_lit 4)
                          (@instOfNatAtLeastTwo.{0} ENNReal (nat_lit 4)
                            (@AddMonoidWithOne.toNatCast.{0} ENNReal
                              (@AddCommMonoidWithOne.toAddMonoidWithOne.{0} ENNReal ENNReal.instAddCommMonoidWithOne))
                            ⋯)))
                      (@HPow.hPow.{0, 0, 0} ENNReal Nat ENNReal
                        (@instHPow.{0, 0} ENNReal Nat
                          (@NPow.toPow.{0} ENNReal
                            (@Monoid.toNPow.{0} ENNReal
                              (@Semiring.toMonoid.{0} ENNReal
                                (@CommSemiring.toSemiring.{0} ENNReal ENNReal.instCommSemiring)))))
                        (@Inv.inv.{0} ENNReal ENNReal.instInv
                          (@OfNat.ofNat.{0} ENNReal (nat_lit 2)
                            (@instOfNatAtLeastTwo.{0} ENNReal (nat_lit 2)
                              (@AddMonoidWithOne.toNatCast.{0} ENNReal
                                (@AddCommMonoidWithOne.toAddMonoidWithOne.{0} ENNReal ENNReal.instAddCommMonoidWithOne))
                              ⋯)))
                        m))) :=
⋯
```

## `edist_limUnder_const`

Command: `#print edist_limUnder_const`

```lean
theorem edist_limUnder_const.{u_1, u_2} : ∀ {T : Type u_1} {E : Type u_2} [inst : PseudoEMetricSpace.{u_2} E]
  [inst_1 : Nonempty.{u_2 + 1} E] {c : E} {l : Filter.{u_1} T} [@Filter.NeBot.{u_1} T l],
  @Eq.{1} ENNReal
    (@EDist.edist.{u_2} E
      (@WeakPseudoEMetricSpace.toEDist.{u_2} E
        (@UniformSpace.toTopologicalSpace.{u_2} E (@PseudoEMetricSpace.toUniformSpace.{u_2} E inst))
        (@PseudoEMetricSpace.toWeakPseudoEMetricSpace.{u_2} E inst))
      (@Filter.limUnder.{u_2, u_1} E
        (@UniformSpace.toTopologicalSpace.{u_2} E (@PseudoEMetricSpace.toUniformSpace.{u_2} E inst)) T inst_1 l fun x =>
        c)
      c)
    (@OfNat.ofNat.{0} ENNReal (nat_lit 0) (@Zero.toOfNat0.{0} ENNReal ENNReal.instZero)) :=
⋯
```

## `edist_limUnder_prod_eq_zero`

Command: `#print edist_limUnder_prod_eq_zero`

```lean
theorem edist_limUnder_prod_eq_zero.{u_1, u_2, u_3} : ∀ {α : Type u_1} {β : Type u_2} {E : Type u_3}
  [inst : PseudoEMetricSpace.{u_3} E] [inst_1 : Nonempty.{u_3 + 1} E] {l₁ : Filter.{u_1} α} {l₂ : Filter.{u_2} β}
  [@Filter.NeBot.{u_1} α l₁] [@Filter.NeBot.{u_2} β l₂] {f : α → E} {g : β → E},
  (∃ c,
      @Filter.Tendsto.{u_1, u_3} α E f l₁
        (@nhds.{u_3} E (@UniformSpace.toTopologicalSpace.{u_3} E (@PseudoEMetricSpace.toUniformSpace.{u_3} E inst))
          c)) →
    (∃ c,
        @Filter.Tendsto.{u_2, u_3} β E g l₂
          (@nhds.{u_3} E (@UniformSpace.toTopologicalSpace.{u_3} E (@PseudoEMetricSpace.toUniformSpace.{u_3} E inst))
            c)) →
      @Eq.{1} ENNReal
        (@EDist.edist.{u_3} (Prod.{u_3, u_3} E E)
          (@WeakPseudoEMetricSpace.toEDist.{u_3} (Prod.{u_3, u_3} E E)
            (@UniformSpace.toTopologicalSpace.{u_3} (Prod.{u_3, u_3} E E)
              (@PseudoEMetricSpace.toUniformSpace.{u_3} (Prod.{u_3, u_3} E E)
                (@Prod.pseudoEMetricSpaceMax.{u_3, u_3} E E inst inst)))
            (@PseudoEMetricSpace.toWeakPseudoEMetricSpace.{u_3} (Prod.{u_3, u_3} E E)
              (@Prod.pseudoEMetricSpaceMax.{u_3, u_3} E E inst inst)))
          (@Filter.limUnder.{u_3, max u_1 u_2} (Prod.{u_3, u_3} E E)
            (@instTopologicalSpaceProd.{u_3, u_3} E E
              (@UniformSpace.toTopologicalSpace.{u_3} E (@PseudoEMetricSpace.toUniformSpace.{u_3} E inst))
              (@UniformSpace.toTopologicalSpace.{u_3} E (@PseudoEMetricSpace.toUniformSpace.{u_3} E inst)))
            (Prod.{u_1, u_2} α β) ⋯
            (@SProd.sprod.{u_1, u_2, max u_1 u_2} (Filter.{u_1} α) (Filter.{u_2} β)
              (Filter.{max u_2 u_1} (Prod.{u_1, u_2} α β)) (@Filter.instSProd.{u_1, u_2} α β) l₁ l₂)
            fun p => @Prod.mk.{u_3, u_3} E E (f (@Prod.fst.{u_1, u_2} α β p)) (g (@Prod.snd.{u_1, u_2} α β p)))
          (@Prod.mk.{u_3, u_3} E E
            (@Filter.limUnder.{u_3, u_1} E
              (@UniformSpace.toTopologicalSpace.{u_3} E (@PseudoEMetricSpace.toUniformSpace.{u_3} E inst)) α inst_1 l₁
              f)
            (@Filter.limUnder.{u_3, u_2} E
              (@UniformSpace.toTopologicalSpace.{u_3} E (@PseudoEMetricSpace.toUniformSpace.{u_3} E inst)) β inst_1 l₂
              g)))
        (@OfNat.ofNat.{0} ENNReal (nat_lit 0) (@Zero.toOfNat0.{0} ENNReal ENNReal.instZero)) :=
⋯
```

## `edist_nearestPt_le`

Command: `#print edist_nearestPt_le`

```lean
theorem edist_nearestPt_le.{u_1} : ∀ {E : Type u_1} {x y : E} [inst : PseudoEMetricSpace.{u_1} E] {s : Finset.{u_1} E},
  @Membership.mem.{u_1, u_1} E (Finset.{u_1} E)
      (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} E) E (@Finset.instSetLike.{u_1} E)) s y →
    @LE.le.{0} ENNReal ENNReal.instLE
      (@EDist.edist.{u_1} E
        (@WeakPseudoEMetricSpace.toEDist.{u_1} E
          (@UniformSpace.toTopologicalSpace.{u_1} E (@PseudoEMetricSpace.toUniformSpace.{u_1} E inst))
          (@PseudoEMetricSpace.toWeakPseudoEMetricSpace.{u_1} E inst))
        x
        (@nearestPt.{u_1} E
          (@WeakPseudoEMetricSpace.toEDist.{u_1} E
            (@UniformSpace.toTopologicalSpace.{u_1} E (@PseudoEMetricSpace.toUniformSpace.{u_1} E inst))
            (@PseudoEMetricSpace.toWeakPseudoEMetricSpace.{u_1} E inst))
          s x))
      (@EDist.edist.{u_1} E
        (@WeakPseudoEMetricSpace.toEDist.{u_1} E
          (@UniformSpace.toTopologicalSpace.{u_1} E (@PseudoEMetricSpace.toUniformSpace.{u_1} E inst))
          (@PseudoEMetricSpace.toWeakPseudoEMetricSpace.{u_1} E inst))
        x y) :=
⋯
```

## `edist_nearestPt_of_isCover`

Command: `#print edist_nearestPt_of_isCover`

```lean
theorem edist_nearestPt_of_isCover.{u_1} : ∀ {E : Type u_1} {x : E} {A : Set.{u_1} E} {C : Finset.{u_1} E} {ε : NNReal}
  [inst : PseudoEMetricSpace.{u_1} E],
  @Metric.IsCover.{u_1} E inst ε A (@SetLike.coe.{u_1, u_1} (Finset.{u_1} E) E (@Finset.instSetLike.{u_1} E) C) →
    @Membership.mem.{u_1, u_1} E (Set.{u_1} E) (@Set.instMembership.{u_1} E) A x →
      @LE.le.{0} ENNReal ENNReal.instLE
        (@EDist.edist.{u_1} E
          (@WeakPseudoEMetricSpace.toEDist.{u_1} E
            (@UniformSpace.toTopologicalSpace.{u_1} E (@PseudoEMetricSpace.toUniformSpace.{u_1} E inst))
            (@PseudoEMetricSpace.toWeakPseudoEMetricSpace.{u_1} E inst))
          x
          (@nearestPt.{u_1} E
            (@WeakPseudoEMetricSpace.toEDist.{u_1} E
              (@UniformSpace.toTopologicalSpace.{u_1} E (@PseudoEMetricSpace.toUniformSpace.{u_1} E inst))
              (@PseudoEMetricSpace.toWeakPseudoEMetricSpace.{u_1} E inst))
            C x))
        ↑ε :=
⋯
```

## `exists_modification_on_of_edist_modification_on`

Command: `#print exists_modification_on_of_edist_modification_on`

```lean
theorem exists_modification_on_of_edist_modification_on.{u_1, u_2, u_3} : ∀ {T : Type u_1} {Ω : Type u_2} {E : Type u_3}
  {mΩ : MeasurableSpace.{u_2} Ω} {P : @MeasureTheory.Measure.{u_2} Ω mΩ} [inst : PseudoEMetricSpace.{u_3} E]
  [inst_1 : MeasurableSpace.{u_3} E]
  [@BorelSpace.{u_3} E (@UniformSpace.toTopologicalSpace.{u_3} E (@PseudoEMetricSpace.toUniformSpace.{u_3} E inst))
      inst_1]
  {X Y : T → Ω → E},
  (∀ (t : T), @Measurable.{u_2, u_3} Ω E mΩ inst_1 (Y t)) →
    ∀ {U : Set.{u_1} T},
      (∀ (t : T),
          @Membership.mem.{u_1, u_1} T (Set.{u_1} T) (@Set.instMembership.{u_1} T) U t →
            @Filter.Eventually.{u_2} Ω
              (fun ω =>
                @Eq.{1} ENNReal
                  (@EDist.edist.{u_3} E
                    (@WeakPseudoEMetricSpace.toEDist.{u_3} E
                      (@UniformSpace.toTopologicalSpace.{u_3} E (@PseudoEMetricSpace.toUniformSpace.{u_3} E inst))
                      (@PseudoEMetricSpace.toWeakPseudoEMetricSpace.{u_3} E inst))
                    (Y t ω) (X t ω))
                  (@OfNat.ofNat.{0} ENNReal (nat_lit 0) (@Zero.toOfNat0.{0} ENNReal ENNReal.instZero)))
              (@MeasureTheory.ae.{u_2, u_2} Ω (@MeasureTheory.Measure.{u_2} Ω mΩ)
                (@MeasureTheory.Measure.instFunLike.{u_2} Ω mΩ) ⋯ P)) →
        ∃ Z,
          And (∀ (t : T), @Measurable.{u_2, u_3} Ω E mΩ inst_1 (Z t))
            (And
              (∀ (t : T) (ω : Ω),
                @Eq.{1} ENNReal
                  (@EDist.edist.{u_3} E
                    (@WeakPseudoEMetricSpace.toEDist.{u_3} E
                      (@UniformSpace.toTopologicalSpace.{u_3} E (@PseudoEMetricSpace.toUniformSpace.{u_3} E inst))
                      (@PseudoEMetricSpace.toWeakPseudoEMetricSpace.{u_3} E inst))
                    (Z t ω) (Y t ω))
                  (@OfNat.ofNat.{0} ENNReal (nat_lit 0) (@Zero.toOfNat0.{0} ENNReal ENNReal.instZero)))
              (∀ (t : T),
                @Membership.mem.{u_1, u_1} T (Set.{u_1} T) (@Set.instMembership.{u_1} T) U t →
                  @Filter.EventuallyEq.{u_2, u_3} Ω E
                    (@MeasureTheory.ae.{u_2, u_2} Ω (@MeasureTheory.Measure.{u_2} Ω mΩ)
                      (@MeasureTheory.Measure.instFunLike.{u_2} Ω mΩ) ⋯ P)
                    (Z t) (X t))) :=
⋯
```

## `exists_nat_proj`

Command: `#print exists_nat_proj`

```lean
theorem exists_nat_proj.{u_1, u_2} : ∀ {ι : Type u_1} {α : ι → Type u_2} [inst : (i : ι) → TopologicalSpace.{u_2} (α i)]
  {s : Nat → Set.{max u_1 u_2} ((i : ι) → α i)}
  (hs :
    ∀ (n : Nat),
      @Membership.mem.{max u_1 u_2, max u_1 u_2} (Set.{max u_1 u_2} ((i : ι) → α i))
        (Set.{max u_1 u_2} (Set.{max u_1 u_2} ((i : ι) → α i)))
        (@Set.instMembership.{max u_1 u_2} (Set.{max u_1 u_2} ((i : ι) → α i)))
        (@MeasureTheory.closedCompactCylinders.{u_1, u_2} ι α inst) (s n))
  (i : ι),
  @Membership.mem.{u_1, u_1} ι (Set.{u_1} ι) (@Set.instMembership.{u_1} ι) (@allProj.{u_1, u_2} ι α inst s hs) i →
    ∃ n,
      @Membership.mem.{u_1, u_1} ι (Finset.{u_1} ι)
        (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} ι) ι (@Finset.instSetLike.{u_1} ι))
        (@MeasureTheory.closedCompactCylinders.finset.{u_1, u_2} ι α inst (s n) ⋯) i :=
⋯
```

## `iInter_subset_piCylinderSet`

Command: `#print iInter_subset_piCylinderSet`

```lean
theorem iInter_subset_piCylinderSet.{u_1, u_2} : ∀ {ι : Type u_1} {α : ι → Type u_2}
  [inst : (i : ι) → TopologicalSpace.{u_2} (α i)] {s : Nat → Set.{max u_1 u_2} ((i : ι) → α i)}
  (hs :
    ∀ (n : Nat),
      @Membership.mem.{max u_1 u_2, max u_1 u_2} (Set.{max u_1 u_2} ((i : ι) → α i))
        (Set.{max u_1 u_2} (Set.{max u_1 u_2} ((i : ι) → α i)))
        (@Set.instMembership.{max u_1 u_2} (Set.{max u_1 u_2} ((i : ι) → α i)))
        (@MeasureTheory.closedCompactCylinders.{u_1, u_2} ι α inst) (s n)),
  @LE.le.{max u_1 u_2}
    (Set.{max u_1 u_2}
      ((i : @Set.Elem.{u_1} ι (@allProj.{u_1, u_2} ι α inst s hs)) →
        α
          (@Subtype.val.{u_1 + 1} ι
            (fun x =>
              @Membership.mem.{u_1, u_1} ι (Set.{u_1} ι) (@Set.instMembership.{u_1} ι)
                (@allProj.{u_1, u_2} ι α inst s hs) x)
            i)))
    (@Set.instLE.{max u_1 u_2}
      ((i : @Set.Elem.{u_1} ι (@allProj.{u_1, u_2} ι α inst s hs)) →
        α
          (@Subtype.val.{u_1 + 1} ι
            (fun x =>
              @Membership.mem.{u_1, u_1} ι (Set.{u_1} ι) (@Set.instMembership.{u_1} ι)
                (@allProj.{u_1, u_2} ι α inst s hs) x)
            i)))
    (⋂ n, @projCylinder.{u_1, u_2} ι α inst s hs n) (@piCylinderSet.{u_1, u_2} ι α inst s hs) :=
⋯
```

## `indexProj`

Command: `#print indexProj`

```lean
def indexProj.{u_1, u_2} : {ι : Type u_1} →
  {α : ι → Type u_2} →
    [inst : (i : ι) → TopologicalSpace.{u_2} (α i)] →
      {s : Nat → Set.{max u_1 u_2} ((i : ι) → α i)} →
        (hs :
            ∀ (n : Nat),
              @Membership.mem.{max u_1 u_2, max u_1 u_2} (Set.{max u_1 u_2} ((i : ι) → α i))
                (Set.{max u_1 u_2} (Set.{max u_1 u_2} ((i : ι) → α i)))
                (@Set.instMembership.{max u_1 u_2} (Set.{max u_1 u_2} ((i : ι) → α i)))
                (@MeasureTheory.closedCompactCylinders.{u_1, u_2} ι α inst) (s n)) →
          @Set.Elem.{u_1} ι (@allProj.{u_1, u_2} ι α inst s hs) → Nat :=
fun {ι} {α} [inst : (i : ι) → TopologicalSpace.{u_2} (α i)] {s} hs i =>
  @Nat.find
    (fun n =>
      @Membership.mem.{u_1, u_1} ι (Finset.{u_1} ι)
        (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} ι) ι (@Finset.instSetLike.{u_1} ι))
        (@MeasureTheory.closedCompactCylinders.finset.{u_1, u_2} ι α inst (s n) ⋯)
        (@Subtype.val.{u_1 + 1} ι
          (fun x =>
            @Membership.mem.{u_1, u_1} ι (Set.{u_1} ι) (@Set.instMembership.{u_1} ι) (@allProj.{u_1, u_2} ι α inst s hs)
              x)
          i))
    (fun a =>
      @Finset.decidableMem.{u_1} ι (fun a b => Classical.propDecidable (@Eq.{u_1 + 1} ι a b))
        (@Subtype.val.{u_1 + 1} ι
          (fun x =>
            @Membership.mem.{u_1, u_1} ι (Set.{u_1} ι) (@Set.instMembership.{u_1} ι) (@allProj.{u_1, u_2} ι α inst s hs)
              x)
          i)
        (@MeasureTheory.closedCompactCylinders.finset.{u_1, u_2} ι α inst (s a) ⋯))
    ⋯
```

## `indexProj_le`

Command: `#print indexProj_le`

```lean
theorem indexProj_le.{u_1, u_2} : ∀ {ι : Type u_1} {α : ι → Type u_2} [inst : (i : ι) → TopologicalSpace.{u_2} (α i)]
  {s : Nat → Set.{max u_1 u_2} ((i : ι) → α i)}
  (hs :
    ∀ (n : Nat),
      @Membership.mem.{max u_1 u_2, max u_1 u_2} (Set.{max u_1 u_2} ((i : ι) → α i))
        (Set.{max u_1 u_2} (Set.{max u_1 u_2} ((i : ι) → α i)))
        (@Set.instMembership.{max u_1 u_2} (Set.{max u_1 u_2} ((i : ι) → α i)))
        (@MeasureTheory.closedCompactCylinders.{u_1, u_2} ι α inst) (s n))
  (n : Nat) (i : ↥(@MeasureTheory.closedCompactCylinders.finset.{u_1, u_2} ι α inst (s n) ⋯)),
  @LE.le.{0} Nat instLENat
    (@indexProj.{u_1, u_2} ι α inst s hs
      (@Subtype.mk.{u_1 + 1} ι
        (fun x =>
          @Membership.mem.{u_1, u_1} ι (Set.{u_1} ι) (@Set.instMembership.{u_1} ι) (@allProj.{u_1, u_2} ι α inst s hs)
            x)
        (@Subtype.val.{u_1 + 1} ι
          (fun x =>
            @Membership.mem.{u_1, u_1} ι (Finset.{u_1} ι)
              (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} ι) ι (@Finset.instSetLike.{u_1} ι))
              (@MeasureTheory.closedCompactCylinders.finset.{u_1, u_2} ι α inst (s n) ⋯) x)
          i)
        ⋯))
    n :=
⋯
```

## `isClosed_piCylinderSet`

Command: `#print isClosed_piCylinderSet`

```lean
theorem isClosed_piCylinderSet.{u_1, u_2} : ∀ {ι : Type u_1} {α : ι → Type u_2}
  [inst : (i : ι) → TopologicalSpace.{u_2} (α i)] {s : Nat → Set.{max u_1 u_2} ((i : ι) → α i)}
  (hs :
    ∀ (n : Nat),
      @Membership.mem.{max u_1 u_2, max u_1 u_2} (Set.{max u_1 u_2} ((i : ι) → α i))
        (Set.{max u_1 u_2} (Set.{max u_1 u_2} ((i : ι) → α i)))
        (@Set.instMembership.{max u_1 u_2} (Set.{max u_1 u_2} ((i : ι) → α i)))
        (@MeasureTheory.closedCompactCylinders.{u_1, u_2} ι α inst) (s n)),
  @IsClosed.{max u_1 u_2}
    ((i : @Set.Elem.{u_1} ι (@allProj.{u_1, u_2} ι α inst s hs)) →
      α
        (@Subtype.val.{u_1 + 1} ι
          (fun x =>
            @Membership.mem.{u_1, u_1} ι (Set.{u_1} ι) (@Set.instMembership.{u_1} ι) (@allProj.{u_1, u_2} ι α inst s hs)
              x)
          i))
    (@Pi.topologicalSpace.{u_2, u_1} (@Set.Elem.{u_1} ι (@allProj.{u_1, u_2} ι α inst s hs))
      (fun i =>
        α
          (@Subtype.val.{u_1 + 1} ι
            (fun x =>
              @Membership.mem.{u_1, u_1} ι (Set.{u_1} ι) (@Set.instMembership.{u_1} ι)
                (@allProj.{u_1, u_2} ι α inst s hs) x)
            i))
      fun i =>
      inst
        (@Subtype.val.{u_1 + 1} ι
          (fun x =>
            @Membership.mem.{u_1, u_1} ι (Set.{u_1} ι) (@Set.instMembership.{u_1} ι) (@allProj.{u_1, u_2} ι α inst s hs)
              x)
          i))
    (@piCylinderSet.{u_1, u_2} ι α inst s hs) :=
⋯
```

## `isClosed_projCylinder`

Command: `#print isClosed_projCylinder`

```lean
theorem isClosed_projCylinder.{u_1, u_2} : ∀ {ι : Type u_1} {α : ι → Type u_2}
  [inst : (i : ι) → TopologicalSpace.{u_2} (α i)] {s : Nat → Set.{max u_1 u_2} ((i : ι) → α i)}
  (hs :
    ∀ (n : Nat),
      @Membership.mem.{max u_1 u_2, max u_1 u_2} (Set.{max u_1 u_2} ((i : ι) → α i))
        (Set.{max u_1 u_2} (Set.{max u_1 u_2} ((i : ι) → α i)))
        (@Set.instMembership.{max u_1 u_2} (Set.{max u_1 u_2} ((i : ι) → α i)))
        (@MeasureTheory.closedCompactCylinders.{u_1, u_2} ι α inst) (s n)),
  (∀ (n : Nat),
      @IsClosed.{max u_1 u_2}
        ((i : ↥(@MeasureTheory.closedCompactCylinders.finset.{u_1, u_2} ι α inst (s n) ⋯)) →
          α
            (@Subtype.val.{u_1 + 1} ι
              (fun x =>
                @Membership.mem.{u_1, u_1} ι (Finset.{u_1} ι)
                  (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} ι) ι (@Finset.instSetLike.{u_1} ι))
                  (@MeasureTheory.closedCompactCylinders.finset.{u_1, u_2} ι α inst (s n) ⋯) x)
              i))
        (@Pi.topologicalSpace.{u_2, u_1} (↥(@MeasureTheory.closedCompactCylinders.finset.{u_1, u_2} ι α inst (s n) ⋯))
          (fun i =>
            α
              (@Subtype.val.{u_1 + 1} ι
                (fun x =>
                  @Membership.mem.{u_1, u_1} ι (Finset.{u_1} ι)
                    (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} ι) ι (@Finset.instSetLike.{u_1} ι))
                    (@MeasureTheory.closedCompactCylinders.finset.{u_1, u_2} ι α inst (s n) ⋯) x)
                i))
          fun i =>
          inst
            (@Subtype.val.{u_1 + 1} ι
              (fun x =>
                @Membership.mem.{u_1, u_1} ι (Finset.{u_1} ι)
                  (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} ι) ι (@Finset.instSetLike.{u_1} ι))
                  (@MeasureTheory.closedCompactCylinders.finset.{u_1, u_2} ι α inst (s n) ⋯) x)
              i))
        (@MeasureTheory.closedCompactCylinders.set.{u_1, u_2} ι α inst (s n) ⋯)) →
    ∀ (n : Nat),
      @IsClosed.{max u_1 u_2}
        ((i : @Set.Elem.{u_1} ι (@allProj.{u_1, u_2} ι α inst s hs)) →
          α
            (@Subtype.val.{u_1 + 1} ι
              (fun x =>
                @Membership.mem.{u_1, u_1} ι (Set.{u_1} ι) (@Set.instMembership.{u_1} ι)
                  (@allProj.{u_1, u_2} ι α inst s hs) x)
              i))
        (@Pi.topologicalSpace.{u_2, u_1} (@Set.Elem.{u_1} ι (@allProj.{u_1, u_2} ι α inst s hs))
          (fun i =>
            α
              (@Subtype.val.{u_1 + 1} ι
                (fun x =>
                  @Membership.mem.{u_1, u_1} ι (Set.{u_1} ι) (@Set.instMembership.{u_1} ι)
                    (@allProj.{u_1, u_2} ι α inst s hs) x)
                i))
          fun i =>
          inst
            (@Subtype.val.{u_1 + 1} ι
              (fun x =>
                @Membership.mem.{u_1, u_1} ι (Set.{u_1} ι) (@Set.instMembership.{u_1} ι)
                  (@allProj.{u_1, u_2} ι α inst s hs) x)
              i))
        (@projCylinder.{u_1, u_2} ι α inst s hs n) :=
⋯
```

## `isCompactSystem_closedCompactCylinders`

Command: `#print isCompactSystem_closedCompactCylinders`

```lean
theorem isCompactSystem_closedCompactCylinders.{u_1, u_2} : ∀ {ι : Type u_1} {α : ι → Type u_2}
  [inst : (i : ι) → TopologicalSpace.{u_2} (α i)],
  @IsCompactSystem.{max u_1 u_2} ((i : ι) → α i) (@MeasureTheory.closedCompactCylinders.{u_1, u_2} ι α inst) :=
⋯
```

## `isCompact_piCylinderSet`

Command: `#print isCompact_piCylinderSet`

```lean
theorem isCompact_piCylinderSet.{u_1, u_2} : ∀ {ι : Type u_1} {α : ι → Type u_2}
  [inst : (i : ι) → TopologicalSpace.{u_2} (α i)] {s : Nat → Set.{max u_1 u_2} ((i : ι) → α i)}
  (hs :
    ∀ (n : Nat),
      @Membership.mem.{max u_1 u_2, max u_1 u_2} (Set.{max u_1 u_2} ((i : ι) → α i))
        (Set.{max u_1 u_2} (Set.{max u_1 u_2} ((i : ι) → α i)))
        (@Set.instMembership.{max u_1 u_2} (Set.{max u_1 u_2} ((i : ι) → α i)))
        (@MeasureTheory.closedCompactCylinders.{u_1, u_2} ι α inst) (s n)),
  @IsCompact.{max u_1 u_2}
    ((i : @Set.Elem.{u_1} ι (@allProj.{u_1, u_2} ι α inst s hs)) →
      α
        (@Subtype.val.{u_1 + 1} ι
          (fun x =>
            @Membership.mem.{u_1, u_1} ι (Set.{u_1} ι) (@Set.instMembership.{u_1} ι) (@allProj.{u_1, u_2} ι α inst s hs)
              x)
          i))
    (@Pi.topologicalSpace.{u_2, u_1} (@Set.Elem.{u_1} ι (@allProj.{u_1, u_2} ι α inst s hs))
      (fun i =>
        α
          (@Subtype.val.{u_1 + 1} ι
            (fun x =>
              @Membership.mem.{u_1, u_1} ι (Set.{u_1} ι) (@Set.instMembership.{u_1} ι)
                (@allProj.{u_1, u_2} ι α inst s hs) x)
            i))
      fun i =>
      inst
        (@Subtype.val.{u_1 + 1} ι
          (fun x =>
            @Membership.mem.{u_1, u_1} ι (Set.{u_1} ι) (@Set.instMembership.{u_1} ι) (@allProj.{u_1, u_2} ι α inst s hs)
              x)
          i))
    (@piCylinderSet.{u_1, u_2} ι α inst s hs) :=
⋯
```

## `isCoverWithBoundedCoveringNumber_Ico_nnreal`

Command: `#print isCoverWithBoundedCoveringNumber_Ico_nnreal`

```lean
theorem isCoverWithBoundedCoveringNumber_Ico_nnreal : @IsCoverWithBoundedCoveringNumber.{0} NNReal
  (@EMetricSpace.toPseudoEMetricSpace.{0} NNReal (@MetricSpace.toEMetricSpace.{0} NNReal instMetricSpaceNNReal))
  (fun n =>
    @Set.Ico.{0} NNReal (@PartialOrder.toPreorder.{0} NNReal NNReal.instPartialOrder)
      (@OfNat.ofNat.{0} NNReal (nat_lit 0) (@Zero.toOfNat0.{0} NNReal NNReal.instZero))
      (@HAdd.hAdd.{0, 0, 0} NNReal NNReal NNReal
        (@instHAdd.{0} NNReal (@Distrib.toAdd.{0} NNReal (@instDistribOfSemiring.{0} NNReal NNReal.instSemiring)))
        (@Nat.cast.{0} NNReal
          (@AddMonoidWithOne.toNatCast.{0} NNReal
            (@AddCommMonoidWithOne.toAddMonoidWithOne.{0} NNReal
              (@NonAssocSemiring.toAddCommMonoidWithOne.{0} NNReal
                (@Semiring.toNonAssocSemiring.{0} NNReal NNReal.instSemiring))))
          n)
        (@OfNat.ofNat.{0} NNReal (nat_lit 1) (@One.toOfNat1.{0} NNReal NNReal.instOne))))
  (@Set.univ.{0} NNReal)
  (fun n =>
    @HMul.hMul.{0, 0, 0} ENNReal ENNReal ENNReal
      (@instHMul.{0} ENNReal
        (@Distrib.toMul.{0} ENNReal
          (@instDistribOfSemiring.{0} ENNReal (@CommSemiring.toSemiring.{0} ENNReal ENNReal.instCommSemiring))))
      (@OfNat.ofNat.{0} ENNReal (nat_lit 3)
        (@instOfNatAtLeastTwo.{0} ENNReal (nat_lit 3)
          (@AddMonoidWithOne.toNatCast.{0} ENNReal
            (@AddCommMonoidWithOne.toAddMonoidWithOne.{0} ENNReal ENNReal.instAddCommMonoidWithOne))
          ⋯))
      (@HAdd.hAdd.{0, 0, 0} ENNReal ENNReal ENNReal (@instHAdd.{0} ENNReal ENNReal.instAdd)
        (@Nat.cast.{0} ENNReal
          (@AddMonoidWithOne.toNatCast.{0} ENNReal
            (@AddCommMonoidWithOne.toAddMonoidWithOne.{0} ENNReal ENNReal.instAddCommMonoidWithOne))
          n)
        (@OfNat.ofNat.{0} ENNReal (nat_lit 1) (@One.toOfNat1.{0} ENNReal ENNReal.instOne))))
  fun x => @OfNat.ofNat.{0} Real (nat_lit 1) (@One.toOfNat1.{0} Real Real.instOne) :=
⋯
```

## `le_volume_of_isSeparated`

Command: `#print le_volume_of_isSeparated`

```lean
theorem le_volume_of_isSeparated.{u_1} : ∀ {E : Type u_1} [inst : NormedAddCommGroup.{u_1} E]
  [inst_1 :
    @InnerProductSpace.{0, u_1} Real E Real.instRCLike (@NormedAddCommGroup.toSeminormedAddCommGroup.{u_1} E inst)]
  [inst_2 :
    @FiniteDimensional.{0, u_1} Real E Real.instDivisionRing (@NormedAddCommGroup.toAddCommGroup.{u_1} E inst)
      (@NormedSpace.toModule.{0, u_1} Real E Real.normedField
        (@NormedAddCommGroup.toSeminormedAddCommGroup.{u_1} E inst)
        (@InnerProductSpace.toNormedSpace.{0, u_1} Real E Real.instRCLike
          (@NormedAddCommGroup.toSeminormedAddCommGroup.{u_1} E inst) inst_1))]
  [inst_3 : MeasurableSpace.{u_1} E]
  [inst_4 :
    @BorelSpace.{u_1} E
      (@UniformSpace.toTopologicalSpace.{u_1} E
        (@PseudoMetricSpace.toUniformSpace.{u_1} E
          (@SeminormedAddCommGroup.toPseudoMetricSpace.{u_1} E
            (@NormedAddCommGroup.toSeminormedAddCommGroup.{u_1} E inst))))
      inst_3]
  {ε : NNReal} {A C : Set.{u_1} E},
  @Metric.IsSeparated.{u_1} E
      (@EMetricSpace.toPseudoEMetricSpace.{u_1} E
        (@MetricSpace.toEMetricSpace.{u_1} E (@NormedAddCommGroup.toMetricSpace.{u_1} E inst)))
      (↑ε) C →
    @LE.le.{u_1} (Set.{u_1} E) (@Set.instLE.{u_1} E) C A →
      @LE.le.{0} ENNReal ENNReal.instLE
        (@HMul.hMul.{0, 0, 0} ENNReal ENNReal ENNReal
          (@instHMul.{0} ENNReal
            (@Distrib.toMul.{0} ENNReal
              (@instDistribOfSemiring.{0} ENNReal (@CommSemiring.toSemiring.{0} ENNReal ENNReal.instCommSemiring))))
          (↑(@Set.encard.{u_1} E C))
          (@DFunLike.coe.{u_1 + 1, u_1 + 1, 1}
            (@MeasureTheory.Measure.{u_1} E
              (@MeasureTheory.MeasureSpace.toMeasurableSpace.{u_1} E
                (@measureSpaceOfInnerProductSpace.{u_1} E inst inst_1 inst_2 inst_3 inst_4)))
            (Set.{u_1} E) (fun x => ENNReal)
            (@MeasureTheory.Measure.instFunLike.{u_1} E
              (@MeasureTheory.MeasureSpace.toMeasurableSpace.{u_1} E
                (@measureSpaceOfInnerProductSpace.{u_1} E inst inst_1 inst_2 inst_3 inst_4)))
            (@MeasureTheory.MeasureSpace.volume.{u_1} E
              (@measureSpaceOfInnerProductSpace.{u_1} E inst inst_1 inst_2 inst_3 inst_4))
            (@Metric.closedEBall.{u_1} E
              (@EMetricSpace.toPseudoEMetricSpace.{u_1} E
                (@MetricSpace.toEMetricSpace.{u_1} E (@NormedAddCommGroup.toMetricSpace.{u_1} E inst)))
              (@OfNat.ofNat.{u_1} E (nat_lit 0)
                (@Zero.toOfNat0.{u_1} E
                  (@NegZeroClass.toZero.{u_1} E
                    (@SubNegZeroMonoid.toNegZeroClass.{u_1} E
                      (@SubtractionMonoid.toSubNegZeroMonoid.{u_1} E
                        (@SubtractionCommMonoid.toSubtractionMonoid.{u_1} E
                          (@AddCommGroup.toDivisionAddCommMonoid.{u_1} E
                            (@NormedAddCommGroup.toAddCommGroup.{u_1} E inst))))))))
              (@HDiv.hDiv.{0, 0, 0} ENNReal ENNReal ENNReal
                (@instHDiv.{0} ENNReal (@DivInvMonoid.toDiv.{0} ENNReal ENNReal.instDivInvMonoid)) (↑ε)
                (@OfNat.ofNat.{0} ENNReal (nat_lit 2)
                  (@instOfNatAtLeastTwo.{0} ENNReal (nat_lit 2)
                    (@AddMonoidWithOne.toNatCast.{0} ENNReal
                      (@AddCommMonoidWithOne.toAddMonoidWithOne.{0} ENNReal ENNReal.instAddCommMonoidWithOne))
                    ⋯))))))
        (@DFunLike.coe.{u_1 + 1, u_1 + 1, 1}
          (@MeasureTheory.Measure.{u_1} E
            (@MeasureTheory.MeasureSpace.toMeasurableSpace.{u_1} E
              (@measureSpaceOfInnerProductSpace.{u_1} E inst inst_1 inst_2 inst_3 inst_4)))
          (Set.{u_1} E) (fun x => ENNReal)
          (@MeasureTheory.Measure.instFunLike.{u_1} E
            (@MeasureTheory.MeasureSpace.toMeasurableSpace.{u_1} E
              (@measureSpaceOfInnerProductSpace.{u_1} E inst inst_1 inst_2 inst_3 inst_4)))
          (@MeasureTheory.MeasureSpace.volume.{u_1} E
            (@measureSpaceOfInnerProductSpace.{u_1} E inst inst_1 inst_2 inst_3 inst_4))
          (@HAdd.hAdd.{u_1, u_1, u_1} (Set.{u_1} E) (Set.{u_1} E) (Set.{u_1} E)
            (@instHAdd.{u_1} (Set.{u_1} E)
              (@Set.add.{u_1} E
                (@AddCommMagma.toAdd.{u_1} E
                  (@AddCommSemigroup.toAddCommMagma.{u_1} E
                    (@AddCommMonoid.toAddCommSemigroup.{u_1} E
                      (@AddCommGroup.toAddCommMonoid.{u_1} E (@NormedAddCommGroup.toAddCommGroup.{u_1} E inst)))))))
            A
            (@Metric.closedEBall.{u_1} E
              (@EMetricSpace.toPseudoEMetricSpace.{u_1} E
                (@MetricSpace.toEMetricSpace.{u_1} E (@NormedAddCommGroup.toMetricSpace.{u_1} E inst)))
              (@OfNat.ofNat.{u_1} E (nat_lit 0)
                (@Zero.toOfNat0.{u_1} E
                  (@NegZeroClass.toZero.{u_1} E
                    (@SubNegZeroMonoid.toNegZeroClass.{u_1} E
                      (@SubtractionMonoid.toSubNegZeroMonoid.{u_1} E
                        (@SubtractionCommMonoid.toSubtractionMonoid.{u_1} E
                          (@AddCommGroup.toDivisionAddCommMonoid.{u_1} E
                            (@NormedAddCommGroup.toAddCommGroup.{u_1} E inst))))))))
              (@HDiv.hDiv.{0, 0, 0} ENNReal ENNReal ENNReal
                (@instHDiv.{0} ENNReal (@DivInvMonoid.toDiv.{0} ENNReal ENNReal.instDivInvMonoid)) (↑ε)
                (@OfNat.ofNat.{0} ENNReal (nat_lit 2)
                  (@instOfNatAtLeastTwo.{0} ENNReal (nat_lit 2)
                    (@AddMonoidWithOne.toNatCast.{0} ENNReal
                      (@AddCommMonoidWithOne.toAddMonoidWithOne.{0} ENNReal ENNReal.instAddCommMonoidWithOne))
                    ⋯)))))) :=
⋯
```

## `le_volume_of_isSeparated_of_countable`

Command: `#print le_volume_of_isSeparated_of_countable`

```lean
theorem le_volume_of_isSeparated_of_countable.{u_1} : ∀ {E : Type u_1} [inst : NormedAddCommGroup.{u_1} E]
  [inst_1 :
    @InnerProductSpace.{0, u_1} Real E Real.instRCLike (@NormedAddCommGroup.toSeminormedAddCommGroup.{u_1} E inst)]
  [inst_2 :
    @FiniteDimensional.{0, u_1} Real E Real.instDivisionRing (@NormedAddCommGroup.toAddCommGroup.{u_1} E inst)
      (@NormedSpace.toModule.{0, u_1} Real E Real.normedField
        (@NormedAddCommGroup.toSeminormedAddCommGroup.{u_1} E inst)
        (@InnerProductSpace.toNormedSpace.{0, u_1} Real E Real.instRCLike
          (@NormedAddCommGroup.toSeminormedAddCommGroup.{u_1} E inst) inst_1))]
  [inst_3 : MeasurableSpace.{u_1} E]
  [inst_4 :
    @BorelSpace.{u_1} E
      (@UniformSpace.toTopologicalSpace.{u_1} E
        (@PseudoMetricSpace.toUniformSpace.{u_1} E
          (@SeminormedAddCommGroup.toPseudoMetricSpace.{u_1} E
            (@NormedAddCommGroup.toSeminormedAddCommGroup.{u_1} E inst))))
      inst_3]
  {ε : NNReal} {A C : Set.{u_1} E},
  @Set.Countable.{u_1} E C →
    @Metric.IsSeparated.{u_1} E
        (@EMetricSpace.toPseudoEMetricSpace.{u_1} E
          (@MetricSpace.toEMetricSpace.{u_1} E (@NormedAddCommGroup.toMetricSpace.{u_1} E inst)))
        (↑ε) C →
      @LE.le.{u_1} (Set.{u_1} E) (@Set.instLE.{u_1} E) C A →
        @LE.le.{0} ENNReal ENNReal.instLE
          (@HMul.hMul.{0, 0, 0} ENNReal ENNReal ENNReal
            (@instHMul.{0} ENNReal
              (@Distrib.toMul.{0} ENNReal
                (@instDistribOfSemiring.{0} ENNReal (@CommSemiring.toSemiring.{0} ENNReal ENNReal.instCommSemiring))))
            (↑(@Set.encard.{u_1} E C))
            (@DFunLike.coe.{u_1 + 1, u_1 + 1, 1}
              (@MeasureTheory.Measure.{u_1} E
                (@MeasureTheory.MeasureSpace.toMeasurableSpace.{u_1} E
                  (@measureSpaceOfInnerProductSpace.{u_1} E inst inst_1 inst_2 inst_3 inst_4)))
              (Set.{u_1} E) (fun x => ENNReal)
              (@MeasureTheory.Measure.instFunLike.{u_1} E
                (@MeasureTheory.MeasureSpace.toMeasurableSpace.{u_1} E
                  (@measureSpaceOfInnerProductSpace.{u_1} E inst inst_1 inst_2 inst_3 inst_4)))
              (@MeasureTheory.MeasureSpace.volume.{u_1} E
                (@measureSpaceOfInnerProductSpace.{u_1} E inst inst_1 inst_2 inst_3 inst_4))
              (@Metric.closedEBall.{u_1} E
                (@EMetricSpace.toPseudoEMetricSpace.{u_1} E
                  (@MetricSpace.toEMetricSpace.{u_1} E (@NormedAddCommGroup.toMetricSpace.{u_1} E inst)))
                (@OfNat.ofNat.{u_1} E (nat_lit 0)
                  (@Zero.toOfNat0.{u_1} E
                    (@NegZeroClass.toZero.{u_1} E
                      (@SubNegZeroMonoid.toNegZeroClass.{u_1} E
                        (@SubtractionMonoid.toSubNegZeroMonoid.{u_1} E
                          (@SubtractionCommMonoid.toSubtractionMonoid.{u_1} E
                            (@AddCommGroup.toDivisionAddCommMonoid.{u_1} E
                              (@NormedAddCommGroup.toAddCommGroup.{u_1} E inst))))))))
                (@HDiv.hDiv.{0, 0, 0} ENNReal ENNReal ENNReal
                  (@instHDiv.{0} ENNReal (@DivInvMonoid.toDiv.{0} ENNReal ENNReal.instDivInvMonoid)) (↑ε)
                  (@OfNat.ofNat.{0} ENNReal (nat_lit 2)
                    (@instOfNatAtLeastTwo.{0} ENNReal (nat_lit 2)
                      (@AddMonoidWithOne.toNatCast.{0} ENNReal
                        (@AddCommMonoidWithOne.toAddMonoidWithOne.{0} ENNReal ENNReal.instAddCommMonoidWithOne))
                      ⋯))))))
          (@DFunLike.coe.{u_1 + 1, u_1 + 1, 1}
            (@MeasureTheory.Measure.{u_1} E
              (@MeasureTheory.MeasureSpace.toMeasurableSpace.{u_1} E
                (@measureSpaceOfInnerProductSpace.{u_1} E inst inst_1 inst_2 inst_3 inst_4)))
            (Set.{u_1} E) (fun x => ENNReal)
            (@MeasureTheory.Measure.instFunLike.{u_1} E
              (@MeasureTheory.MeasureSpace.toMeasurableSpace.{u_1} E
                (@measureSpaceOfInnerProductSpace.{u_1} E inst inst_1 inst_2 inst_3 inst_4)))
            (@MeasureTheory.MeasureSpace.volume.{u_1} E
              (@measureSpaceOfInnerProductSpace.{u_1} E inst inst_1 inst_2 inst_3 inst_4))
            (@HAdd.hAdd.{u_1, u_1, u_1} (Set.{u_1} E) (Set.{u_1} E) (Set.{u_1} E)
              (@instHAdd.{u_1} (Set.{u_1} E)
                (@Set.add.{u_1} E
                  (@AddCommMagma.toAdd.{u_1} E
                    (@AddCommSemigroup.toAddCommMagma.{u_1} E
                      (@AddCommMonoid.toAddCommSemigroup.{u_1} E
                        (@AddCommGroup.toAddCommMonoid.{u_1} E (@NormedAddCommGroup.toAddCommGroup.{u_1} E inst)))))))
              A
              (@Metric.closedEBall.{u_1} E
                (@EMetricSpace.toPseudoEMetricSpace.{u_1} E
                  (@MetricSpace.toEMetricSpace.{u_1} E (@NormedAddCommGroup.toMetricSpace.{u_1} E inst)))
                (@OfNat.ofNat.{u_1} E (nat_lit 0)
                  (@Zero.toOfNat0.{u_1} E
                    (@NegZeroClass.toZero.{u_1} E
                      (@SubNegZeroMonoid.toNegZeroClass.{u_1} E
                        (@SubtractionMonoid.toSubNegZeroMonoid.{u_1} E
                          (@SubtractionCommMonoid.toSubtractionMonoid.{u_1} E
                            (@AddCommGroup.toDivisionAddCommMonoid.{u_1} E
                              (@NormedAddCommGroup.toAddCommGroup.{u_1} E inst))))))))
                (@HDiv.hDiv.{0, 0, 0} ENNReal ENNReal ENNReal
                  (@instHDiv.{0} ENNReal (@DivInvMonoid.toDiv.{0} ENNReal ENNReal.instDivInvMonoid)) (↑ε)
                  (@OfNat.ofNat.{0} ENNReal (nat_lit 2)
                    (@instOfNatAtLeastTwo.{0} ENNReal (nat_lit 2)
                      (@AddMonoidWithOne.toNatCast.{0} ENNReal
                        (@AddCommMonoidWithOne.toAddMonoidWithOne.{0} ENNReal ENNReal.instAddCommMonoidWithOne))
                      ⋯)))))) :=
⋯
```

## `measurable_limUnder_of_exists_tendsto`

Command: `#print measurable_limUnder_of_exists_tendsto`

```lean
theorem measurable_limUnder_of_exists_tendsto.{u_1, u_2, u_3} : ∀ {ι : Type u_1} {X : Type u_2} {E : Type u_3}
  {mX : MeasurableSpace.{u_2} X} [inst : TopologicalSpace.{u_3} E]
  [@TopologicalSpace.PseudoMetrizableSpace.{u_3} E inst] [inst_2 : MeasurableSpace.{u_3} E]
  [@BorelSpace.{u_3} E inst inst_2] {l : Filter.{u_1} ι} [@Filter.IsCountablyGenerated.{u_1} ι l] {f : ι → X → E}
  [hE : Nonempty.{u_3 + 1} E],
  (∀ (x : X), ∃ c, @Filter.Tendsto.{u_1, u_3} ι E (fun x_1 => f x_1 x) l (@nhds.{u_3} E inst c)) →
    (∀ (i : ι), @Measurable.{u_2, u_3} X E mX inst_2 (f i)) →
      @Measurable.{u_2, u_3} X E mX inst_2 fun x => @Filter.limUnder.{u_3, u_1} E inst ι hE l fun x_1 => f x_1 x :=
⋯
```

## `measure_add_ge_le_add_measure_ge`

Command: `#print measure_add_ge_le_add_measure_ge`

```lean
theorem measure_add_ge_le_add_measure_ge.{u_1} : ∀ {Ω : Type u_1} {x : MeasurableSpace.{u_1} Ω}
  {P : @MeasureTheory.Measure.{u_1} Ω x} {f g : Ω → ENNReal} {x_1 u : ENNReal},
  @LE.le.{0} ENNReal ENNReal.instLE u x_1 →
    @LE.le.{0} ENNReal ENNReal.instLE
      (@DFunLike.coe.{u_1 + 1, u_1 + 1, 1} (@MeasureTheory.Measure.{u_1} Ω x) (Set.{u_1} Ω) (fun x => ENNReal)
        (@MeasureTheory.Measure.instFunLike.{u_1} Ω x) P
        (@setOf.{u_1} Ω fun ω =>
          @LE.le.{0} ENNReal ENNReal.instLE x_1
            (@HAdd.hAdd.{0, 0, 0} ENNReal ENNReal ENNReal (@instHAdd.{0} ENNReal ENNReal.instAdd) (f ω) (g ω))))
      (@HAdd.hAdd.{0, 0, 0} ENNReal ENNReal ENNReal (@instHAdd.{0} ENNReal ENNReal.instAdd)
        (@DFunLike.coe.{u_1 + 1, u_1 + 1, 1} (@MeasureTheory.Measure.{u_1} Ω x) (Set.{u_1} Ω) (fun x => ENNReal)
          (@MeasureTheory.Measure.instFunLike.{u_1} Ω x) P
          (@setOf.{u_1} Ω fun ω => @LE.le.{0} ENNReal ENNReal.instLE u (f ω)))
        (@DFunLike.coe.{u_1 + 1, u_1 + 1, 1} (@MeasureTheory.Measure.{u_1} Ω x) (Set.{u_1} Ω) (fun x => ENNReal)
          (@MeasureTheory.Measure.instFunLike.{u_1} Ω x) P
          (@setOf.{u_1} Ω fun ω =>
            @LE.le.{0} ENNReal ENNReal.instLE
              (@HSub.hSub.{0, 0, 0} ENNReal ENNReal ENNReal (@instHSub.{0} ENNReal ENNReal.instSub) x_1 u) (g ω)))) :=
⋯
```

## `measure_add_ge_le_add_measure_ge_half`

Command: `#print measure_add_ge_le_add_measure_ge_half`

```lean
theorem measure_add_ge_le_add_measure_ge_half.{u_1} : ∀ {Ω : Type u_1} {x : MeasurableSpace.{u_1} Ω}
  {P : @MeasureTheory.Measure.{u_1} Ω x} {f g : Ω → ENNReal} {x_1 : ENNReal},
  @LE.le.{0} ENNReal ENNReal.instLE
    (@DFunLike.coe.{u_1 + 1, u_1 + 1, 1} (@MeasureTheory.Measure.{u_1} Ω x) (Set.{u_1} Ω) (fun x => ENNReal)
      (@MeasureTheory.Measure.instFunLike.{u_1} Ω x) P
      (@setOf.{u_1} Ω fun ω =>
        @LE.le.{0} ENNReal ENNReal.instLE x_1
          (@HAdd.hAdd.{0, 0, 0} ENNReal ENNReal ENNReal (@instHAdd.{0} ENNReal ENNReal.instAdd) (f ω) (g ω))))
    (@HAdd.hAdd.{0, 0, 0} ENNReal ENNReal ENNReal (@instHAdd.{0} ENNReal ENNReal.instAdd)
      (@DFunLike.coe.{u_1 + 1, u_1 + 1, 1} (@MeasureTheory.Measure.{u_1} Ω x) (Set.{u_1} Ω) (fun x => ENNReal)
        (@MeasureTheory.Measure.instFunLike.{u_1} Ω x) P
        (@setOf.{u_1} Ω fun ω =>
          @LE.le.{0} ENNReal ENNReal.instLE
            (@HDiv.hDiv.{0, 0, 0} ENNReal ENNReal ENNReal
              (@instHDiv.{0} ENNReal (@DivInvMonoid.toDiv.{0} ENNReal ENNReal.instDivInvMonoid)) x_1
              (@OfNat.ofNat.{0} ENNReal (nat_lit 2)
                (@instOfNatAtLeastTwo.{0} ENNReal (nat_lit 2)
                  (@AddMonoidWithOne.toNatCast.{0} ENNReal
                    (@AddCommMonoidWithOne.toAddMonoidWithOne.{0} ENNReal ENNReal.instAddCommMonoidWithOne))
                  ⋯)))
            (f ω)))
      (@DFunLike.coe.{u_1 + 1, u_1 + 1, 1} (@MeasureTheory.Measure.{u_1} Ω x) (Set.{u_1} Ω) (fun x => ENNReal)
        (@MeasureTheory.Measure.instFunLike.{u_1} Ω x) P
        (@setOf.{u_1} Ω fun ω =>
          @LE.le.{0} ENNReal ENNReal.instLE
            (@HDiv.hDiv.{0, 0, 0} ENNReal ENNReal ENNReal
              (@instHDiv.{0} ENNReal (@DivInvMonoid.toDiv.{0} ENNReal ENNReal.instDivInvMonoid)) x_1
              (@OfNat.ofNat.{0} ENNReal (nat_lit 2)
                (@instOfNatAtLeastTwo.{0} ENNReal (nat_lit 2)
                  (@AddMonoidWithOne.toNatCast.{0} ENNReal
                    (@AddCommMonoidWithOne.toAddMonoidWithOne.{0} ENNReal ENNReal.instAddCommMonoidWithOne))
                  ⋯)))
            (g ω)))) :=
⋯
```

## `mem_indexProj`

Command: `#print mem_indexProj`

```lean
theorem mem_indexProj.{u_1, u_2} : ∀ {ι : Type u_1} {α : ι → Type u_2} [inst : (i : ι) → TopologicalSpace.{u_2} (α i)]
  {s : Nat → Set.{max u_1 u_2} ((i : ι) → α i)}
  (hs :
    ∀ (n : Nat),
      @Membership.mem.{max u_1 u_2, max u_1 u_2} (Set.{max u_1 u_2} ((i : ι) → α i))
        (Set.{max u_1 u_2} (Set.{max u_1 u_2} ((i : ι) → α i)))
        (@Set.instMembership.{max u_1 u_2} (Set.{max u_1 u_2} ((i : ι) → α i)))
        (@MeasureTheory.closedCompactCylinders.{u_1, u_2} ι α inst) (s n))
  (i : @Set.Elem.{u_1} ι (@allProj.{u_1, u_2} ι α inst s hs)),
  @Membership.mem.{u_1, u_1} ι (Finset.{u_1} ι)
    (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} ι) ι (@Finset.instSetLike.{u_1} ι))
    (@MeasureTheory.closedCompactCylinders.finset.{u_1, u_2} ι α inst (s (@indexProj.{u_1, u_2} ι α inst s hs i)) ⋯)
    (@Subtype.val.{u_1 + 1} ι
      (fun x =>
        @Membership.mem.{u_1, u_1} ι (Set.{u_1} ι) (@Set.instMembership.{u_1} ι) (@allProj.{u_1, u_2} ι α inst s hs) x)
      i) :=
⋯
```

## `mem_piCylinderSet`

Command: `#print mem_piCylinderSet`

```lean
theorem mem_piCylinderSet.{u_1, u_2} : ∀ {ι : Type u_1} {α : ι → Type u_2}
  [inst : (i : ι) → TopologicalSpace.{u_2} (α i)] {s : Nat → Set.{max u_1 u_2} ((i : ι) → α i)}
  (hs :
    ∀ (n : Nat),
      @Membership.mem.{max u_1 u_2, max u_1 u_2} (Set.{max u_1 u_2} ((i : ι) → α i))
        (Set.{max u_1 u_2} (Set.{max u_1 u_2} ((i : ι) → α i)))
        (@Set.instMembership.{max u_1 u_2} (Set.{max u_1 u_2} ((i : ι) → α i)))
        (@MeasureTheory.closedCompactCylinders.{u_1, u_2} ι α inst) (s n))
  (x :
    (i : @Set.Elem.{u_1} ι (@allProj.{u_1, u_2} ι α inst s hs)) →
      α
        (@Subtype.val.{u_1 + 1} ι
          (fun x =>
            @Membership.mem.{u_1, u_1} ι (Set.{u_1} ι) (@Set.instMembership.{u_1} ι) (@allProj.{u_1, u_2} ι α inst s hs)
              x)
          i)),
  Iff
    (@Membership.mem.{max u_1 u_2, max u_1 u_2}
      ((i : @Set.Elem.{u_1} ι (@allProj.{u_1, u_2} ι α inst s hs)) →
        α
          (@Subtype.val.{u_1 + 1} ι
            (fun x =>
              @Membership.mem.{u_1, u_1} ι (Set.{u_1} ι) (@Set.instMembership.{u_1} ι)
                (@allProj.{u_1, u_2} ι α inst s hs) x)
            i))
      (Set.{max u_1 u_2}
        ((i : @Set.Elem.{u_1} ι (@allProj.{u_1, u_2} ι α inst s hs)) →
          α
            (@Subtype.val.{u_1 + 1} ι
              (fun x =>
                @Membership.mem.{u_1, u_1} ι (Set.{u_1} ι) (@Set.instMembership.{u_1} ι)
                  (@allProj.{u_1, u_2} ι α inst s hs) x)
              i)))
      (@Set.instMembership.{max u_1 u_2}
        ((i : @Set.Elem.{u_1} ι (@allProj.{u_1, u_2} ι α inst s hs)) →
          α
            (@Subtype.val.{u_1 + 1} ι
              (fun x =>
                @Membership.mem.{u_1, u_1} ι (Set.{u_1} ι) (@Set.instMembership.{u_1} ι)
                  (@allProj.{u_1, u_2} ι α inst s hs) x)
              i)))
      (@piCylinderSet.{u_1, u_2} ι α inst s hs) x)
    (∀ (i : @Set.Elem.{u_1} ι (@allProj.{u_1, u_2} ι α inst s hs)),
      @Membership.mem.{u_2, u_2}
        (α
          (@Subtype.val.{u_1 + 1} ι
            (fun x =>
              @Membership.mem.{u_1, u_1} ι (Set.{u_1} ι) (@Set.instMembership.{u_1} ι)
                (@allProj.{u_1, u_2} ι α inst s hs) x)
            i))
        (Set.{u_2}
          (α
            (@Subtype.val.{u_1 + 1} ι
              (fun x =>
                @Membership.mem.{u_1, u_1} ι (Finset.{u_1} ι)
                  (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} ι) ι (@Finset.instSetLike.{u_1} ι))
                  (@MeasureTheory.closedCompactCylinders.finset.{u_1, u_2} ι α inst
                    (s (@indexProj.{u_1, u_2} ι α inst s hs i)) ⋯)
                  x)
              (@Subtype.mk.{u_1 + 1} ι
                (fun x =>
                  @Membership.mem.{u_1, u_1} ι (Finset.{u_1} ι)
                    (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} ι) ι (@Finset.instSetLike.{u_1} ι))
                    (@MeasureTheory.closedCompactCylinders.finset.{u_1, u_2} ι α inst
                      (s (@indexProj.{u_1, u_2} ι α inst s hs i)) ⋯)
                    x)
                (@Subtype.val.{u_1 + 1} ι
                  (fun x =>
                    @Membership.mem.{u_1, u_1} ι (Set.{u_1} ι) (@Set.instMembership.{u_1} ι)
                      (@allProj.{u_1, u_2} ι α inst s hs) x)
                  i)
                ⋯))))
        (@Set.instMembership.{u_2}
          (α
            (@Subtype.val.{u_1 + 1} ι
              (fun x =>
                @Membership.mem.{u_1, u_1} ι (Finset.{u_1} ι)
                  (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} ι) ι (@Finset.instSetLike.{u_1} ι))
                  (@MeasureTheory.closedCompactCylinders.finset.{u_1, u_2} ι α inst
                    (s (@indexProj.{u_1, u_2} ι α inst s hs i)) ⋯)
                  x)
              (@Subtype.mk.{u_1 + 1} ι
                (fun x =>
                  @Membership.mem.{u_1, u_1} ι (Finset.{u_1} ι)
                    (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} ι) ι (@Finset.instSetLike.{u_1} ι))
                    (@MeasureTheory.closedCompactCylinders.finset.{u_1, u_2} ι α inst
                      (s (@indexProj.{u_1, u_2} ι α inst s hs i)) ⋯)
                    x)
                (@Subtype.val.{u_1 + 1} ι
                  (fun x =>
                    @Membership.mem.{u_1, u_1} ι (Set.{u_1} ι) (@Set.instMembership.{u_1} ι)
                      (@allProj.{u_1, u_2} ι α inst s hs) x)
                  i)
                ⋯))))
        (@Set.image.{max u_1 u_2, u_2}
          ((j :
              ↥(@MeasureTheory.closedCompactCylinders.finset.{u_1, u_2} ι α inst
                  (s (@indexProj.{u_1, u_2} ι α inst s hs i)) ⋯)) →
            α
              (@Subtype.val.{u_1 + 1} ι
                (fun x =>
                  @Membership.mem.{u_1, u_1} ι (Finset.{u_1} ι)
                    (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} ι) ι (@Finset.instSetLike.{u_1} ι))
                    (@MeasureTheory.closedCompactCylinders.finset.{u_1, u_2} ι α inst
                      (s (@indexProj.{u_1, u_2} ι α inst s hs i)) ⋯)
                    x)
                j))
          (α
            (@Subtype.val.{u_1 + 1} ι
              (fun x =>
                @Membership.mem.{u_1, u_1} ι (Finset.{u_1} ι)
                  (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} ι) ι (@Finset.instSetLike.{u_1} ι))
                  (@MeasureTheory.closedCompactCylinders.finset.{u_1, u_2} ι α inst
                    (s (@indexProj.{u_1, u_2} ι α inst s hs i)) ⋯)
                  x)
              (@Subtype.mk.{u_1 + 1} ι
                (fun x =>
                  @Membership.mem.{u_1, u_1} ι (Finset.{u_1} ι)
                    (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} ι) ι (@Finset.instSetLike.{u_1} ι))
                    (@MeasureTheory.closedCompactCylinders.finset.{u_1, u_2} ι α inst
                      (s (@indexProj.{u_1, u_2} ι α inst s hs i)) ⋯)
                    x)
                (@Subtype.val.{u_1 + 1} ι
                  (fun x =>
                    @Membership.mem.{u_1, u_1} ι (Set.{u_1} ι) (@Set.instMembership.{u_1} ι)
                      (@allProj.{u_1, u_2} ι α inst s hs) x)
                  i)
                ⋯)))
          (fun a =>
            a
              (@Subtype.mk.{u_1 + 1} ι
                (fun x =>
                  @Membership.mem.{u_1, u_1} ι (Finset.{u_1} ι)
                    (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} ι) ι (@Finset.instSetLike.{u_1} ι))
                    (@MeasureTheory.closedCompactCylinders.finset.{u_1, u_2} ι α inst
                      (s (@indexProj.{u_1, u_2} ι α inst s hs i)) ⋯)
                    x)
                (@Subtype.val.{u_1 + 1} ι
                  (fun x =>
                    @Membership.mem.{u_1, u_1} ι (Set.{u_1} ι) (@Set.instMembership.{u_1} ι)
                      (@allProj.{u_1, u_2} ι α inst s hs) x)
                  i)
                ⋯))
          (@MeasureTheory.closedCompactCylinders.set.{u_1, u_2} ι α inst (s (@indexProj.{u_1, u_2} ι α inst s hs i)) ⋯))
        (x i)) :=
⋯
```

## `mem_projCylinder`

Command: `#print mem_projCylinder`

```lean
theorem mem_projCylinder.{u_1, u_2} : ∀ {ι : Type u_1} {α : ι → Type u_2}
  [inst : (i : ι) → TopologicalSpace.{u_2} (α i)] {s : Nat → Set.{max u_1 u_2} ((i : ι) → α i)}
  (hs :
    ∀ (n : Nat),
      @Membership.mem.{max u_1 u_2, max u_1 u_2} (Set.{max u_1 u_2} ((i : ι) → α i))
        (Set.{max u_1 u_2} (Set.{max u_1 u_2} ((i : ι) → α i)))
        (@Set.instMembership.{max u_1 u_2} (Set.{max u_1 u_2} ((i : ι) → α i)))
        (@MeasureTheory.closedCompactCylinders.{u_1, u_2} ι α inst) (s n))
  (n : Nat)
  (x :
    (i : @Set.Elem.{u_1} ι (@allProj.{u_1, u_2} ι α inst s hs)) →
      α
        (@Subtype.val.{u_1 + 1} ι
          (fun x =>
            @Membership.mem.{u_1, u_1} ι (Set.{u_1} ι) (@Set.instMembership.{u_1} ι) (@allProj.{u_1, u_2} ι α inst s hs)
              x)
          i)),
  Iff
    (@Membership.mem.{max u_1 u_2, max u_1 u_2}
      ((i : @Set.Elem.{u_1} ι (@allProj.{u_1, u_2} ι α inst s hs)) →
        α
          (@Subtype.val.{u_1 + 1} ι
            (fun x =>
              @Membership.mem.{u_1, u_1} ι (Set.{u_1} ι) (@Set.instMembership.{u_1} ι)
                (@allProj.{u_1, u_2} ι α inst s hs) x)
            i))
      (Set.{max u_1 u_2}
        ((i : @Set.Elem.{u_1} ι (@allProj.{u_1, u_2} ι α inst s hs)) →
          α
            (@Subtype.val.{u_1 + 1} ι
              (fun x =>
                @Membership.mem.{u_1, u_1} ι (Set.{u_1} ι) (@Set.instMembership.{u_1} ι)
                  (@allProj.{u_1, u_2} ι α inst s hs) x)
              i)))
      (@Set.instMembership.{max u_1 u_2}
        ((i : @Set.Elem.{u_1} ι (@allProj.{u_1, u_2} ι α inst s hs)) →
          α
            (@Subtype.val.{u_1 + 1} ι
              (fun x =>
                @Membership.mem.{u_1, u_1} ι (Set.{u_1} ι) (@Set.instMembership.{u_1} ι)
                  (@allProj.{u_1, u_2} ι α inst s hs) x)
              i)))
      (@projCylinder.{u_1, u_2} ι α inst s hs n) x)
    (@Membership.mem.{max u_1 u_2, max u_1 u_2}
      ((i : ↥(@MeasureTheory.closedCompactCylinders.finset.{u_1, u_2} ι α inst (s n) ⋯)) →
        α
          (@Subtype.val.{u_1 + 1} ι
            (fun x =>
              @Membership.mem.{u_1, u_1} ι (Set.{u_1} ι) (@Set.instMembership.{u_1} ι)
                (@allProj.{u_1, u_2} ι α inst s hs) x)
            (@Subtype.mk.{u_1 + 1} ι
              (fun x =>
                @Membership.mem.{u_1, u_1} ι (Set.{u_1} ι) (@Set.instMembership.{u_1} ι)
                  (@allProj.{u_1, u_2} ι α inst s hs) x)
              (@Subtype.val.{u_1 + 1} ι
                (fun x =>
                  @Membership.mem.{u_1, u_1} ι (Finset.{u_1} ι)
                    (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} ι) ι (@Finset.instSetLike.{u_1} ι))
                    (@MeasureTheory.closedCompactCylinders.finset.{u_1, u_2} ι α inst (s n) ⋯) x)
                i)
              ⋯)))
      (Set.{max u_1 u_2}
        ((i : ↥(@MeasureTheory.closedCompactCylinders.finset.{u_1, u_2} ι α inst (s n) ⋯)) →
          α
            (@Subtype.val.{u_1 + 1} ι
              (fun x =>
                @Membership.mem.{u_1, u_1} ι (Finset.{u_1} ι)
                  (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} ι) ι (@Finset.instSetLike.{u_1} ι))
                  (@MeasureTheory.closedCompactCylinders.finset.{u_1, u_2} ι α inst (s n) ⋯) x)
              i)))
      (@Set.instMembership.{max u_1 u_2}
        ((i : ↥(@MeasureTheory.closedCompactCylinders.finset.{u_1, u_2} ι α inst (s n) ⋯)) →
          α
            (@Subtype.val.{u_1 + 1} ι
              (fun x =>
                @Membership.mem.{u_1, u_1} ι (Finset.{u_1} ι)
                  (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} ι) ι (@Finset.instSetLike.{u_1} ι))
                  (@MeasureTheory.closedCompactCylinders.finset.{u_1, u_2} ι α inst (s n) ⋯) x)
              i)))
      (@MeasureTheory.closedCompactCylinders.set.{u_1, u_2} ι α inst (s n) ⋯) fun i =>
      x
        (@Subtype.mk.{u_1 + 1} ι
          (fun x =>
            @Membership.mem.{u_1, u_1} ι (Set.{u_1} ι) (@Set.instMembership.{u_1} ι) (@allProj.{u_1, u_2} ι α inst s hs)
              x)
          (@Subtype.val.{u_1 + 1} ι
            (fun x =>
              @Membership.mem.{u_1, u_1} ι (Finset.{u_1} ι)
                (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} ι) ι (@Finset.instSetLike.{u_1} ι))
                (@MeasureTheory.closedCompactCylinders.finset.{u_1, u_2} ι α inst (s n) ⋯) x)
            i)
          ⋯)) :=
⋯
```

## `neBot_comap_nhds`

Command: `#print neBot_comap_nhds`

```lean
theorem neBot_comap_nhds.{u_1} : ∀ {X : Type u_1} [inst : PseudoEMetricSpace.{u_1} X] {s : Set.{u_1} X},
  @Dense.{u_1} X (@UniformSpace.toTopologicalSpace.{u_1} X (@PseudoEMetricSpace.toUniformSpace.{u_1} X inst)) s →
    ∀ (x : X),
      @Filter.NeBot.{u_1}
        (@Subtype.{u_1 + 1} X fun x => @Membership.mem.{u_1, u_1} X (Set.{u_1} X) (@Set.instMembership.{u_1} X) s x)
        (@Filter.comap.{u_1, u_1}
          (@Subtype.{u_1 + 1} X fun x => @Membership.mem.{u_1, u_1} X (Set.{u_1} X) (@Set.instMembership.{u_1} X) s x) X
          (@Subtype.val.{u_1 + 1} X fun x =>
            @Membership.mem.{u_1, u_1} X (Set.{u_1} X) (@Set.instMembership.{u_1} X) s x)
          (@nhds.{u_1} X (@UniformSpace.toTopologicalSpace.{u_1} X (@PseudoEMetricSpace.toUniformSpace.{u_1} X inst))
            x)) :=
⋯
```

## `nearestPt`

Command: `#print nearestPt`

```lean
def nearestPt.{u_1} : {E : Type u_1} → [EDist.{u_1} E] → Finset.{u_1} E → E → E :=
fun {E} [inst : EDist.{u_1} E] s x =>
  @dite.{u_1 + 1} E (@Finset.Nonempty.{u_1} E s) (@Finset.decidableNonempty.{u_1} E s)
    (fun hs =>
      @Exists.choose.{u_1 + 1} E
        (fun x_1 =>
          And
            (@Membership.mem.{u_1, u_1} E (Finset.{u_1} E)
              (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} E) E (@Finset.instSetLike.{u_1} E)) s x_1)
            (∀ (x' : E),
              @Membership.mem.{u_1, u_1} E (Finset.{u_1} E)
                  (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} E) E (@Finset.instSetLike.{u_1} E)) s x' →
                @LE.le.{0} ENNReal
                  (@Preorder.toLE.{0} ENNReal
                    (@PartialOrder.toPreorder.{0} ENNReal
                      (@SemilatticeInf.toPartialOrder.{0} ENNReal
                        (@Lattice.toSemilatticeInf.{0} ENNReal
                          (@DistribLattice.toLattice.{0} ENNReal
                            (@instDistribLatticeOfLinearOrder.{0} ENNReal ENNReal.instLinearOrder))))))
                  (@EDist.edist.{u_1} E inst x x_1) (@EDist.edist.{u_1} E inst x x')))
        ⋯)
    fun hs => x
```

## `nearestPt_mem`

Command: `#print nearestPt_mem`

```lean
theorem nearestPt_mem.{u_1} : ∀ {E : Type u_1} {x : E} [inst : EDist.{u_1} E] {s : Finset.{u_1} E},
  @Finset.Nonempty.{u_1} E s →
    @Membership.mem.{u_1, u_1} E (Finset.{u_1} E)
      (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} E) E (@Finset.instSetLike.{u_1} E)) s
      (@nearestPt.{u_1} E inst s x) :=
⋯
```

## `nonempty_iInter_projCylinder`

Command: `#print nonempty_iInter_projCylinder`

```lean
theorem nonempty_iInter_projCylinder.{u_1, u_2} : ∀ {ι : Type u_1} {α : ι → Type u_2}
  [inst : (i : ι) → TopologicalSpace.{u_2} (α i)] {s : Nat → Set.{max u_1 u_2} ((i : ι) → α i)}
  (hs :
    ∀ (n : Nat),
      @Membership.mem.{max u_1 u_2, max u_1 u_2} (Set.{max u_1 u_2} ((i : ι) → α i))
        (Set.{max u_1 u_2} (Set.{max u_1 u_2} ((i : ι) → α i)))
        (@Set.instMembership.{max u_1 u_2} (Set.{max u_1 u_2} ((i : ι) → α i)))
        (@MeasureTheory.closedCompactCylinders.{u_1, u_2} ι α inst) (s n)),
  (∀ (i : Nat), @Set.Nonempty.{max u_1 u_2} ((i : ι) → α i) (s i)) →
    (∀ (n : Nat),
        @Set.Nonempty.{max u_1 u_2}
          ((i : @Set.Elem.{u_1} ι (@allProj.{u_1, u_2} ι α inst s hs)) →
            α
              (@Subtype.val.{u_1 + 1} ι
                (fun x =>
                  @Membership.mem.{u_1, u_1} ι (Set.{u_1} ι) (@Set.instMembership.{u_1} ι)
                    (@allProj.{u_1, u_2} ι α inst s hs) x)
                i))
          (⋂ i, ⋂ (_ : @LE.le.{0} Nat instLENat i n), @projCylinder.{u_1, u_2} ι α inst s hs i)) →
      @Set.Nonempty.{max u_1 u_2}
        ((i : @Set.Elem.{u_1} ι (@allProj.{u_1, u_2} ι α inst s hs)) →
          α
            (@Subtype.val.{u_1 + 1} ι
              (fun x =>
                @Membership.mem.{u_1, u_1} ι (Set.{u_1} ι) (@Set.instMembership.{u_1} ι)
                  (@allProj.{u_1, u_2} ι α inst s hs) x)
              i))
        (⋂ i, @projCylinder.{u_1, u_2} ι α inst s hs i) :=
⋯
```

## `nonempty_iInter_projCylinder_inter_piCylinderSet`

Command: `#print nonempty_iInter_projCylinder_inter_piCylinderSet`

```lean
theorem nonempty_iInter_projCylinder_inter_piCylinderSet.{u_1, u_2} : ∀ {ι : Type u_1} {α : ι → Type u_2}
  [inst : (i : ι) → TopologicalSpace.{u_2} (α i)] {s : Nat → Set.{max u_1 u_2} ((i : ι) → α i)}
  (hs :
    ∀ (n : Nat),
      @Membership.mem.{max u_1 u_2, max u_1 u_2} (Set.{max u_1 u_2} ((i : ι) → α i))
        (Set.{max u_1 u_2} (Set.{max u_1 u_2} ((i : ι) → α i)))
        (@Set.instMembership.{max u_1 u_2} (Set.{max u_1 u_2} ((i : ι) → α i)))
        (@MeasureTheory.closedCompactCylinders.{u_1, u_2} ι α inst) (s n)),
  (∀ (i : Nat), @Set.Nonempty.{max u_1 u_2} ((i : ι) → α i) (s i)) →
    (∀ (n : Nat),
        @Set.Nonempty.{max u_1 u_2}
          ((i : @Set.Elem.{u_1} ι (@allProj.{u_1, u_2} ι α inst s hs)) →
            α
              (@Subtype.val.{u_1 + 1} ι
                (fun x =>
                  @Membership.mem.{u_1, u_1} ι (Set.{u_1} ι) (@Set.instMembership.{u_1} ι)
                    (@allProj.{u_1, u_2} ι α inst s hs) x)
                i))
          (⋂ i, ⋂ (_ : @LE.le.{0} Nat instLENat i n), @projCylinder.{u_1, u_2} ι α inst s hs i)) →
      ∀ (n : Nat),
        @Set.Nonempty.{max u_1 u_2}
          ((i : @Set.Elem.{u_1} ι (@allProj.{u_1, u_2} ι α inst s hs)) →
            α
              (@Subtype.val.{u_1 + 1} ι
                (fun x =>
                  @Membership.mem.{u_1, u_1} ι (Set.{u_1} ι) (@Set.instMembership.{u_1} ι)
                    (@allProj.{u_1, u_2} ι α inst s hs) x)
                i))
          (@Inter.inter.{max u_1 u_2}
            (Set.{max u_1 u_2}
              ((i : @Set.Elem.{u_1} ι (@allProj.{u_1, u_2} ι α inst s hs)) →
                α
                  (@Subtype.val.{u_1 + 1} ι
                    (fun x =>
                      @Membership.mem.{u_1, u_1} ι (Set.{u_1} ι) (@Set.instMembership.{u_1} ι)
                        (@allProj.{u_1, u_2} ι α inst s hs) x)
                    i)))
            (@Set.instInter.{max u_1 u_2}
              ((i : @Set.Elem.{u_1} ι (@allProj.{u_1, u_2} ι α inst s hs)) →
                α
                  (@Subtype.val.{u_1 + 1} ι
                    (fun x =>
                      @Membership.mem.{u_1, u_1} ι (Set.{u_1} ι) (@Set.instMembership.{u_1} ι)
                        (@allProj.{u_1, u_2} ι α inst s hs) x)
                    i)))
            (⋂ i, ⋂ (_ : @LE.le.{0} Nat instLENat i n), @projCylinder.{u_1, u_2} ι α inst s hs i)
            (@piCylinderSet.{u_1, u_2} ι α inst s hs)) :=
⋯
```

## `nonempty_parallelepiped`

Command: `#print nonempty_parallelepiped`

```lean
theorem nonempty_parallelepiped.{u_1, u_2} : ∀ {ι : Type u_1} {E : Type u_2} [inst : Fintype.{u_1} ι]
  [inst_1 : AddCommGroup.{u_2} E]
  [inst_2 : @_root_.Module.{0, u_2} Real E Real.semiring (@AddCommGroup.toAddCommMonoid.{u_2} E inst_1)] {v : ι → E},
  @Set.Nonempty.{u_2} E (@parallelepiped.{u_1, u_2} ι E inst inst_1 inst_2 v) :=
⋯
```

## `nonempty_piCylinderSet`

Command: `#print nonempty_piCylinderSet`

```lean
theorem nonempty_piCylinderSet.{u_1, u_2} : ∀ {ι : Type u_1} {α : ι → Type u_2}
  [inst : (i : ι) → TopologicalSpace.{u_2} (α i)] {s : Nat → Set.{max u_1 u_2} ((i : ι) → α i)}
  (hs :
    ∀ (n : Nat),
      @Membership.mem.{max u_1 u_2, max u_1 u_2} (Set.{max u_1 u_2} ((i : ι) → α i))
        (Set.{max u_1 u_2} (Set.{max u_1 u_2} ((i : ι) → α i)))
        (@Set.instMembership.{max u_1 u_2} (Set.{max u_1 u_2} ((i : ι) → α i)))
        (@MeasureTheory.closedCompactCylinders.{u_1, u_2} ι α inst) (s n)),
  (∀ (i : Nat), @Set.Nonempty.{max u_1 u_2} ((i : ι) → α i) (s i)) →
    @Set.Nonempty.{max u_1 u_2}
      ((i : @Set.Elem.{u_1} ι (@allProj.{u_1, u_2} ι α inst s hs)) →
        α
          (@Subtype.val.{u_1 + 1} ι
            (fun x =>
              @Membership.mem.{u_1, u_1} ι (Set.{u_1} ι) (@Set.instMembership.{u_1} ι)
                (@allProj.{u_1, u_2} ι α inst s hs) x)
            i))
      (@piCylinderSet.{u_1, u_2} ι α inst s hs) :=
⋯
```

## `nonempty_projCylinder`

Command: `#print nonempty_projCylinder`

```lean
theorem nonempty_projCylinder.{u_1, u_2} : ∀ {ι : Type u_1} {α : ι → Type u_2}
  [inst : (i : ι) → TopologicalSpace.{u_2} (α i)] {s : Nat → Set.{max u_1 u_2} ((i : ι) → α i)}
  (hs :
    ∀ (n : Nat),
      @Membership.mem.{max u_1 u_2, max u_1 u_2} (Set.{max u_1 u_2} ((i : ι) → α i))
        (Set.{max u_1 u_2} (Set.{max u_1 u_2} ((i : ι) → α i)))
        (@Set.instMembership.{max u_1 u_2} (Set.{max u_1 u_2} ((i : ι) → α i)))
        (@MeasureTheory.closedCompactCylinders.{u_1, u_2} ι α inst) (s n))
  (n : Nat),
  @Set.Nonempty.{max u_1 u_2} ((i : ι) → α i) (s n) →
    @Set.Nonempty.{max u_1 u_2}
      ((i : @Set.Elem.{u_1} ι (@allProj.{u_1, u_2} ι α inst s hs)) →
        α
          (@Subtype.val.{u_1 + 1} ι
            (fun x =>
              @Membership.mem.{u_1, u_1} ι (Set.{u_1} ι) (@Set.instMembership.{u_1} ι)
                (@allProj.{u_1, u_2} ι α inst s hs) x)
            i))
      (@projCylinder.{u_1, u_2} ι α inst s hs n) :=
⋯
```

## `nonempty_projCylinder_iff`

Command: `#print nonempty_projCylinder_iff`

```lean
theorem nonempty_projCylinder_iff.{u_1, u_2} : ∀ {ι : Type u_1} {α : ι → Type u_2}
  [inst : (i : ι) → TopologicalSpace.{u_2} (α i)] {s : Nat → Set.{max u_1 u_2} ((i : ι) → α i)}
  [∀ (i : ι), Nonempty.{u_2 + 1} (α i)]
  (hs :
    ∀ (n : Nat),
      @Membership.mem.{max u_1 u_2, max u_1 u_2} (Set.{max u_1 u_2} ((i : ι) → α i))
        (Set.{max u_1 u_2} (Set.{max u_1 u_2} ((i : ι) → α i)))
        (@Set.instMembership.{max u_1 u_2} (Set.{max u_1 u_2} ((i : ι) → α i)))
        (@MeasureTheory.closedCompactCylinders.{u_1, u_2} ι α inst) (s n))
  (n : Nat),
  Iff
    (@Set.Nonempty.{max u_1 u_2}
      ((i : @Set.Elem.{u_1} ι (@allProj.{u_1, u_2} ι α inst s hs)) →
        α
          (@Subtype.val.{u_1 + 1} ι
            (fun x =>
              @Membership.mem.{u_1, u_1} ι (Set.{u_1} ι) (@Set.instMembership.{u_1} ι)
                (@allProj.{u_1, u_2} ι α inst s hs) x)
            i))
      (@projCylinder.{u_1, u_2} ι α inst s hs n))
    (@Set.Nonempty.{max u_1 u_2} ((i : ι) → α i) (s n)) :=
⋯
```

## `packingNumber_mul_le_volume`

Command: `#print packingNumber_mul_le_volume`

```lean
theorem packingNumber_mul_le_volume.{u_1} : ∀ {E : Type u_1} [inst : NormedAddCommGroup.{u_1} E]
  [inst_1 :
    @InnerProductSpace.{0, u_1} Real E Real.instRCLike (@NormedAddCommGroup.toSeminormedAddCommGroup.{u_1} E inst)]
  [inst_2 :
    @FiniteDimensional.{0, u_1} Real E Real.instDivisionRing (@NormedAddCommGroup.toAddCommGroup.{u_1} E inst)
      (@NormedSpace.toModule.{0, u_1} Real E Real.normedField
        (@NormedAddCommGroup.toSeminormedAddCommGroup.{u_1} E inst)
        (@InnerProductSpace.toNormedSpace.{0, u_1} Real E Real.instRCLike
          (@NormedAddCommGroup.toSeminormedAddCommGroup.{u_1} E inst) inst_1))]
  [inst_3 : MeasurableSpace.{u_1} E]
  [inst_4 :
    @BorelSpace.{u_1} E
      (@UniformSpace.toTopologicalSpace.{u_1} E
        (@PseudoMetricSpace.toUniformSpace.{u_1} E
          (@SeminormedAddCommGroup.toPseudoMetricSpace.{u_1} E
            (@NormedAddCommGroup.toSeminormedAddCommGroup.{u_1} E inst))))
      inst_3]
  (A : Set.{u_1} E) (ε : NNReal),
  @LE.le.{0} ENNReal ENNReal.instLE
    (@HMul.hMul.{0, 0, 0} ENNReal ENNReal ENNReal
      (@instHMul.{0} ENNReal
        (@Distrib.toMul.{0} ENNReal
          (@instDistribOfSemiring.{0} ENNReal (@CommSemiring.toSemiring.{0} ENNReal ENNReal.instCommSemiring))))
      (↑(@Metric.packingNumber.{u_1} E
          (@EMetricSpace.toPseudoEMetricSpace.{u_1} E
            (@MetricSpace.toEMetricSpace.{u_1} E (@NormedAddCommGroup.toMetricSpace.{u_1} E inst)))
          ε A))
      (@DFunLike.coe.{u_1 + 1, u_1 + 1, 1}
        (@MeasureTheory.Measure.{u_1} E
          (@MeasureTheory.MeasureSpace.toMeasurableSpace.{u_1} E
            (@measureSpaceOfInnerProductSpace.{u_1} E inst inst_1 inst_2 inst_3 inst_4)))
        (Set.{u_1} E) (fun x => ENNReal)
        (@MeasureTheory.Measure.instFunLike.{u_1} E
          (@MeasureTheory.MeasureSpace.toMeasurableSpace.{u_1} E
            (@measureSpaceOfInnerProductSpace.{u_1} E inst inst_1 inst_2 inst_3 inst_4)))
        (@MeasureTheory.MeasureSpace.volume.{u_1} E
          (@measureSpaceOfInnerProductSpace.{u_1} E inst inst_1 inst_2 inst_3 inst_4))
        (@Metric.closedEBall.{u_1} E
          (@EMetricSpace.toPseudoEMetricSpace.{u_1} E
            (@MetricSpace.toEMetricSpace.{u_1} E (@NormedAddCommGroup.toMetricSpace.{u_1} E inst)))
          (@OfNat.ofNat.{u_1} E (nat_lit 0)
            (@Zero.toOfNat0.{u_1} E
              (@NegZeroClass.toZero.{u_1} E
                (@SubNegZeroMonoid.toNegZeroClass.{u_1} E
                  (@SubtractionMonoid.toSubNegZeroMonoid.{u_1} E
                    (@SubtractionCommMonoid.toSubtractionMonoid.{u_1} E
                      (@AddCommGroup.toDivisionAddCommMonoid.{u_1} E
                        (@NormedAddCommGroup.toAddCommGroup.{u_1} E inst))))))))
          (@HDiv.hDiv.{0, 0, 0} ENNReal ENNReal ENNReal
            (@instHDiv.{0} ENNReal (@DivInvMonoid.toDiv.{0} ENNReal ENNReal.instDivInvMonoid)) (↑ε)
            (@OfNat.ofNat.{0} ENNReal (nat_lit 2)
              (@instOfNatAtLeastTwo.{0} ENNReal (nat_lit 2)
                (@AddMonoidWithOne.toNatCast.{0} ENNReal
                  (@AddCommMonoidWithOne.toAddMonoidWithOne.{0} ENNReal ENNReal.instAddCommMonoidWithOne))
                ⋯))))))
    (@DFunLike.coe.{u_1 + 1, u_1 + 1, 1}
      (@MeasureTheory.Measure.{u_1} E
        (@MeasureTheory.MeasureSpace.toMeasurableSpace.{u_1} E
          (@measureSpaceOfInnerProductSpace.{u_1} E inst inst_1 inst_2 inst_3 inst_4)))
      (Set.{u_1} E) (fun x => ENNReal)
      (@MeasureTheory.Measure.instFunLike.{u_1} E
        (@MeasureTheory.MeasureSpace.toMeasurableSpace.{u_1} E
          (@measureSpaceOfInnerProductSpace.{u_1} E inst inst_1 inst_2 inst_3 inst_4)))
      (@MeasureTheory.MeasureSpace.volume.{u_1} E
        (@measureSpaceOfInnerProductSpace.{u_1} E inst inst_1 inst_2 inst_3 inst_4))
      (@HAdd.hAdd.{u_1, u_1, u_1} (Set.{u_1} E) (Set.{u_1} E) (Set.{u_1} E)
        (@instHAdd.{u_1} (Set.{u_1} E)
          (@Set.add.{u_1} E
            (@AddCommMagma.toAdd.{u_1} E
              (@AddCommSemigroup.toAddCommMagma.{u_1} E
                (@AddCommMonoid.toAddCommSemigroup.{u_1} E
                  (@AddCommGroup.toAddCommMonoid.{u_1} E (@NormedAddCommGroup.toAddCommGroup.{u_1} E inst)))))))
        A
        (@Metric.closedEBall.{u_1} E
          (@EMetricSpace.toPseudoEMetricSpace.{u_1} E
            (@MetricSpace.toEMetricSpace.{u_1} E (@NormedAddCommGroup.toMetricSpace.{u_1} E inst)))
          (@OfNat.ofNat.{u_1} E (nat_lit 0)
            (@Zero.toOfNat0.{u_1} E
              (@NegZeroClass.toZero.{u_1} E
                (@SubNegZeroMonoid.toNegZeroClass.{u_1} E
                  (@SubtractionMonoid.toSubNegZeroMonoid.{u_1} E
                    (@SubtractionCommMonoid.toSubtractionMonoid.{u_1} E
                      (@AddCommGroup.toDivisionAddCommMonoid.{u_1} E
                        (@NormedAddCommGroup.toAddCommGroup.{u_1} E inst))))))))
          (@HDiv.hDiv.{0, 0, 0} ENNReal ENNReal ENNReal
            (@instHDiv.{0} ENNReal (@DivInvMonoid.toDiv.{0} ENNReal ENNReal.instDivInvMonoid)) (↑ε)
            (@OfNat.ofNat.{0} ENNReal (nat_lit 2)
              (@instOfNatAtLeastTwo.{0} ENNReal (nat_lit 2)
                (@AddMonoidWithOne.toNatCast.{0} ENNReal
                  (@AddCommMonoidWithOne.toAddMonoidWithOne.{0} ENNReal ENNReal.instAddCommMonoidWithOne))
                ⋯)))))) :=
⋯
```

## `piCylinderSet`

Command: `#print piCylinderSet`

```lean
def piCylinderSet.{u_1, u_2} : {ι : Type u_1} →
  {α : ι → Type u_2} →
    [inst : (i : ι) → TopologicalSpace.{u_2} (α i)] →
      {s : Nat → Set.{max u_1 u_2} ((i : ι) → α i)} →
        (hs :
            ∀ (n : Nat),
              @Membership.mem.{max u_1 u_2, max u_1 u_2} (Set.{max u_1 u_2} ((i : ι) → α i))
                (Set.{max u_1 u_2} (Set.{max u_1 u_2} ((i : ι) → α i)))
                (@Set.instMembership.{max u_1 u_2} (Set.{max u_1 u_2} ((i : ι) → α i)))
                (@MeasureTheory.closedCompactCylinders.{u_1, u_2} ι α inst) (s n)) →
          Set.{max u_1 u_2}
            ((i : @Set.Elem.{u_1} ι (@allProj.{u_1, u_2} ι α inst s hs)) →
              α
                (@Subtype.val.{u_1 + 1} ι
                  (fun x =>
                    @Membership.mem.{u_1, u_1} ι (Set.{u_1} ι) (@Set.instMembership.{u_1} ι)
                      (@allProj.{u_1, u_2} ι α inst s hs) x)
                  i)) :=
fun {ι} {α} [inst : (i : ι) → TopologicalSpace.{u_2} (α i)] {s} hs =>
  @setOf.{max u_1 u_2}
    ((i : @Set.Elem.{u_1} ι (@allProj.{u_1, u_2} ι α inst s hs)) →
      α
        (@Subtype.val.{u_1 + 1} ι
          (fun x =>
            @Membership.mem.{u_1, u_1} ι (Set.{u_1} ι) (@Set.instMembership.{u_1} ι) (@allProj.{u_1, u_2} ι α inst s hs)
              x)
          i))
    fun x =>
    ∀ (i : @Set.Elem.{u_1} ι (@allProj.{u_1, u_2} ι α inst s hs)),
      @Membership.mem.{u_2, u_2}
        (α
          (@Subtype.val.{u_1 + 1} ι
            (fun x =>
              @Membership.mem.{u_1, u_1} ι (Set.{u_1} ι) (@Set.instMembership.{u_1} ι)
                (@allProj.{u_1, u_2} ι α inst s hs) x)
            i))
        (Set.{u_2}
          (α
            (@Subtype.val.{u_1 + 1} ι
              (fun x =>
                @Membership.mem.{u_1, u_1} ι (Finset.{u_1} ι)
                  (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} ι) ι (@Finset.instSetLike.{u_1} ι))
                  (@MeasureTheory.closedCompactCylinders.finset.{u_1, u_2} ι α inst
                    (s (@indexProj.{u_1, u_2} ι α inst s hs i)) ⋯)
                  x)
              (@Subtype.mk.{u_1 + 1} ι
                (fun x =>
                  @Membership.mem.{u_1, u_1} ι (Finset.{u_1} ι)
                    (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} ι) ι (@Finset.instSetLike.{u_1} ι))
                    (@MeasureTheory.closedCompactCylinders.finset.{u_1, u_2} ι α inst
                      (s (@indexProj.{u_1, u_2} ι α inst s hs i)) ⋯)
                    x)
                (@Subtype.val.{u_1 + 1} ι
                  (fun x =>
                    @Membership.mem.{u_1, u_1} ι (Set.{u_1} ι) (@Set.instMembership.{u_1} ι)
                      (@allProj.{u_1, u_2} ι α inst s hs) x)
                  i)
                ⋯))))
        (@Set.instMembership.{u_2}
          (α
            (@Subtype.val.{u_1 + 1} ι
              (fun x =>
                @Membership.mem.{u_1, u_1} ι (Finset.{u_1} ι)
                  (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} ι) ι (@Finset.instSetLike.{u_1} ι))
                  (@MeasureTheory.closedCompactCylinders.finset.{u_1, u_2} ι α inst
                    (s (@indexProj.{u_1, u_2} ι α inst s hs i)) ⋯)
                  x)
              (@Subtype.mk.{u_1 + 1} ι
                (fun x =>
                  @Membership.mem.{u_1, u_1} ι (Finset.{u_1} ι)
                    (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} ι) ι (@Finset.instSetLike.{u_1} ι))
                    (@MeasureTheory.closedCompactCylinders.finset.{u_1, u_2} ι α inst
                      (s (@indexProj.{u_1, u_2} ι α inst s hs i)) ⋯)
                    x)
                (@Subtype.val.{u_1 + 1} ι
                  (fun x =>
                    @Membership.mem.{u_1, u_1} ι (Set.{u_1} ι) (@Set.instMembership.{u_1} ι)
                      (@allProj.{u_1, u_2} ι α inst s hs) x)
                  i)
                ⋯))))
        (@Set.image.{max u_1 u_2, u_2}
          ((j :
              ↥(@MeasureTheory.closedCompactCylinders.finset.{u_1, u_2} ι α inst
                  (s (@indexProj.{u_1, u_2} ι α inst s hs i)) ⋯)) →
            α
              (@Subtype.val.{u_1 + 1} ι
                (fun x =>
                  @Membership.mem.{u_1, u_1} ι (Finset.{u_1} ι)
                    (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} ι) ι (@Finset.instSetLike.{u_1} ι))
                    (@MeasureTheory.closedCompactCylinders.finset.{u_1, u_2} ι α inst
                      (s (@indexProj.{u_1, u_2} ι α inst s hs i)) ⋯)
                    x)
                j))
          (α
            (@Subtype.val.{u_1 + 1} ι
              (fun x =>
                @Membership.mem.{u_1, u_1} ι (Finset.{u_1} ι)
                  (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} ι) ι (@Finset.instSetLike.{u_1} ι))
                  (@MeasureTheory.closedCompactCylinders.finset.{u_1, u_2} ι α inst
                    (s (@indexProj.{u_1, u_2} ι α inst s hs i)) ⋯)
                  x)
              (@Subtype.mk.{u_1 + 1} ι
                (fun x =>
                  @Membership.mem.{u_1, u_1} ι (Finset.{u_1} ι)
                    (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} ι) ι (@Finset.instSetLike.{u_1} ι))
                    (@MeasureTheory.closedCompactCylinders.finset.{u_1, u_2} ι α inst
                      (s (@indexProj.{u_1, u_2} ι α inst s hs i)) ⋯)
                    x)
                (@Subtype.val.{u_1 + 1} ι
                  (fun x =>
                    @Membership.mem.{u_1, u_1} ι (Set.{u_1} ι) (@Set.instMembership.{u_1} ι)
                      (@allProj.{u_1, u_2} ι α inst s hs) x)
                  i)
                ⋯)))
          (fun a =>
            a
              (@Subtype.mk.{u_1 + 1} ι
                (fun x =>
                  @Membership.mem.{u_1, u_1} ι (Finset.{u_1} ι)
                    (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} ι) ι (@Finset.instSetLike.{u_1} ι))
                    (@MeasureTheory.closedCompactCylinders.finset.{u_1, u_2} ι α inst
                      (s (@indexProj.{u_1, u_2} ι α inst s hs i)) ⋯)
                    x)
                (@Subtype.val.{u_1 + 1} ι
                  (fun x =>
                    @Membership.mem.{u_1, u_1} ι (Set.{u_1} ι) (@Set.instMembership.{u_1} ι)
                      (@allProj.{u_1, u_2} ι α inst s hs) x)
                  i)
                ⋯))
          (@MeasureTheory.closedCompactCylinders.set.{u_1, u_2} ι α inst (s (@indexProj.{u_1, u_2} ι α inst s hs i)) ⋯))
        (x i)
```

## `piCylinderSet_eq_pi_univ`

Command: `#print piCylinderSet_eq_pi_univ`

```lean
theorem piCylinderSet_eq_pi_univ.{u_1, u_2} : ∀ {ι : Type u_1} {α : ι → Type u_2}
  [inst : (i : ι) → TopologicalSpace.{u_2} (α i)] {s : Nat → Set.{max u_1 u_2} ((i : ι) → α i)}
  (hs :
    ∀ (n : Nat),
      @Membership.mem.{max u_1 u_2, max u_1 u_2} (Set.{max u_1 u_2} ((i : ι) → α i))
        (Set.{max u_1 u_2} (Set.{max u_1 u_2} ((i : ι) → α i)))
        (@Set.instMembership.{max u_1 u_2} (Set.{max u_1 u_2} ((i : ι) → α i)))
        (@MeasureTheory.closedCompactCylinders.{u_1, u_2} ι α inst) (s n)),
  @Eq.{max (u_1 + 1) (u_2 + 1)}
    (Set.{max u_1 u_2}
      ((i : @Set.Elem.{u_1} ι (@allProj.{u_1, u_2} ι α inst s hs)) →
        α
          (@Subtype.val.{u_1 + 1} ι
            (fun x =>
              @Membership.mem.{u_1, u_1} ι (Set.{u_1} ι) (@Set.instMembership.{u_1} ι)
                (@allProj.{u_1, u_2} ι α inst s hs) x)
            i)))
    (@piCylinderSet.{u_1, u_2} ι α inst s hs)
    (@Set.pi.{u_1, u_2} (@Set.Elem.{u_1} ι (@allProj.{u_1, u_2} ι α inst s hs))
      (fun i =>
        α
          (@Subtype.val.{u_1 + 1} ι
            (fun x =>
              @Membership.mem.{u_1, u_1} ι (Finset.{u_1} ι)
                (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} ι) ι (@Finset.instSetLike.{u_1} ι))
                (@MeasureTheory.closedCompactCylinders.finset.{u_1, u_2} ι α inst
                  (s (@indexProj.{u_1, u_2} ι α inst s hs i)) ⋯)
                x)
            (@Subtype.mk.{u_1 + 1} ι
              (fun x =>
                @Membership.mem.{u_1, u_1} ι (Finset.{u_1} ι)
                  (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} ι) ι (@Finset.instSetLike.{u_1} ι))
                  (@MeasureTheory.closedCompactCylinders.finset.{u_1, u_2} ι α inst
                    (s (@indexProj.{u_1, u_2} ι α inst s hs i)) ⋯)
                  x)
              (@Subtype.val.{u_1 + 1} ι
                (fun x =>
                  @Membership.mem.{u_1, u_1} ι (Set.{u_1} ι) (@Set.instMembership.{u_1} ι)
                    (@allProj.{u_1, u_2} ι α inst s hs) x)
                i)
              ⋯)))
      (@Set.univ.{u_1} (@Set.Elem.{u_1} ι (@allProj.{u_1, u_2} ι α inst s hs))) fun i =>
      @Set.image.{max u_1 u_2, u_2}
        ((j :
            ↥(@MeasureTheory.closedCompactCylinders.finset.{u_1, u_2} ι α inst
                (s (@indexProj.{u_1, u_2} ι α inst s hs i)) ⋯)) →
          α
            (@Subtype.val.{u_1 + 1} ι
              (fun x =>
                @Membership.mem.{u_1, u_1} ι (Finset.{u_1} ι)
                  (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} ι) ι (@Finset.instSetLike.{u_1} ι))
                  (@MeasureTheory.closedCompactCylinders.finset.{u_1, u_2} ι α inst
                    (s (@indexProj.{u_1, u_2} ι α inst s hs i)) ⋯)
                  x)
              j))
        (α
          (@Subtype.val.{u_1 + 1} ι
            (fun x =>
              @Membership.mem.{u_1, u_1} ι (Finset.{u_1} ι)
                (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} ι) ι (@Finset.instSetLike.{u_1} ι))
                (@MeasureTheory.closedCompactCylinders.finset.{u_1, u_2} ι α inst
                  (s (@indexProj.{u_1, u_2} ι α inst s hs i)) ⋯)
                x)
            (@Subtype.mk.{u_1 + 1} ι
              (fun x =>
                @Membership.mem.{u_1, u_1} ι (Finset.{u_1} ι)
                  (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} ι) ι (@Finset.instSetLike.{u_1} ι))
                  (@MeasureTheory.closedCompactCylinders.finset.{u_1, u_2} ι α inst
                    (s (@indexProj.{u_1, u_2} ι α inst s hs i)) ⋯)
                  x)
              (@Subtype.val.{u_1 + 1} ι
                (fun x =>
                  @Membership.mem.{u_1, u_1} ι (Set.{u_1} ι) (@Set.instMembership.{u_1} ι)
                    (@allProj.{u_1, u_2} ι α inst s hs) x)
                i)
              ⋯)))
        (fun a =>
          a
            (@Subtype.mk.{u_1 + 1} ι
              (fun x =>
                @Membership.mem.{u_1, u_1} ι (Finset.{u_1} ι)
                  (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} ι) ι (@Finset.instSetLike.{u_1} ι))
                  (@MeasureTheory.closedCompactCylinders.finset.{u_1, u_2} ι α inst
                    (s (@indexProj.{u_1, u_2} ι α inst s hs i)) ⋯)
                  x)
              (@Subtype.val.{u_1 + 1} ι
                (fun x =>
                  @Membership.mem.{u_1, u_1} ι (Set.{u_1} ι) (@Set.instMembership.{u_1} ι)
                    (@allProj.{u_1, u_2} ι α inst s hs) x)
                i)
              ⋯))
        (@MeasureTheory.closedCompactCylinders.set.{u_1, u_2} ι α inst (s (@indexProj.{u_1, u_2} ι α inst s hs i))
          ⋯)) :=
⋯
```

## `pow_two_mul_abs`

Command: `#print pow_two_mul_abs`

```lean
theorem pow_two_mul_abs.{u_1} : ∀ {α : Type u_1} [inst : Ring.{u_1} α] [inst_1 : LinearOrder.{u_1} α]
  [@IsStrictOrderedRing.{u_1} α (@Ring.toSemiring.{u_1} α inst)
      (@SemilatticeInf.toPartialOrder.{u_1} α
        (@Lattice.toSemilatticeInf.{u_1} α
          (@DistribLattice.toLattice.{u_1} α (@instDistribLatticeOfLinearOrder.{u_1} α inst_1))))]
  (n : Nat) (a : α),
  @Eq.{u_1 + 1} α
    (@HPow.hPow.{u_1, 0, u_1} α Nat α
      (@instHPow.{u_1, 0} α Nat
        (@NPow.toPow.{u_1} α (@Monoid.toNPow.{u_1} α (@Semiring.toMonoid.{u_1} α (@Ring.toSemiring.{u_1} α inst)))))
      (@abs.{u_1} α (@DistribLattice.toLattice.{u_1} α (@instDistribLatticeOfLinearOrder.{u_1} α inst_1))
        (@AddGroupWithOne.toAddGroup.{u_1} α (@Ring.toAddGroupWithOne.{u_1} α inst)) a)
      (@HMul.hMul.{0, 0, 0} Nat Nat Nat (@instHMul.{0} Nat instMulNat)
        (@OfNat.ofNat.{0} Nat (nat_lit 2) (instOfNatNat (nat_lit 2))) n))
    (@HPow.hPow.{u_1, 0, u_1} α Nat α
      (@instHPow.{u_1, 0} α Nat
        (@NPow.toPow.{u_1} α (@Monoid.toNPow.{u_1} α (@Semiring.toMonoid.{u_1} α (@Ring.toSemiring.{u_1} α inst)))))
      a
      (@HMul.hMul.{0, 0, 0} Nat Nat Nat (@instHMul.{0} Nat instMulNat)
        (@OfNat.ofNat.{0} Nat (nat_lit 2) (instOfNatNat (nat_lit 2))) n)) :=
⋯
```

## `preimage_projCylinder`

Command: `#print preimage_projCylinder`

```lean
theorem preimage_projCylinder.{u_1, u_2} : ∀ {ι : Type u_1} {α : ι → Type u_2}
  [inst : (i : ι) → TopologicalSpace.{u_2} (α i)] {s : Nat → Set.{max u_1 u_2} ((i : ι) → α i)}
  (hs :
    ∀ (n : Nat),
      @Membership.mem.{max u_1 u_2, max u_1 u_2} (Set.{max u_1 u_2} ((i : ι) → α i))
        (Set.{max u_1 u_2} (Set.{max u_1 u_2} ((i : ι) → α i)))
        (@Set.instMembership.{max u_1 u_2} (Set.{max u_1 u_2} ((i : ι) → α i)))
        (@MeasureTheory.closedCompactCylinders.{u_1, u_2} ι α inst) (s n))
  (n : Nat),
  @Eq.{max (u_1 + 1) (u_2 + 1)} (Set.{max u_1 u_2} ((i : ι) → α i))
    (@Set.preimage.{max u_1 u_2, max u_1 u_2} ((i : ι) → α i)
      ((i : @Set.Elem.{u_1} ι (@allProj.{u_1, u_2} ι α inst s hs)) →
        α
          (@Subtype.val.{u_1 + 1} ι
            (fun x =>
              @Membership.mem.{u_1, u_1} ι (Set.{u_1} ι) (@Set.instMembership.{u_1} ι)
                (@allProj.{u_1, u_2} ι α inst s hs) x)
            i))
      (fun f i =>
        f
          (@Subtype.val.{u_1 + 1} ι
            (fun x =>
              @Membership.mem.{u_1, u_1} ι (Set.{u_1} ι) (@Set.instMembership.{u_1} ι)
                (@allProj.{u_1, u_2} ι α inst s hs) x)
            i))
      (@projCylinder.{u_1, u_2} ι α inst s hs n))
    (s n) :=
⋯
```

## `projCylinder`

Command: `#print projCylinder`

```lean
def projCylinder.{u_1, u_2} : {ι : Type u_1} →
  {α : ι → Type u_2} →
    [inst : (i : ι) → TopologicalSpace.{u_2} (α i)] →
      {s : Nat → Set.{max u_1 u_2} ((i : ι) → α i)} →
        (hs :
            ∀ (n : Nat),
              @Membership.mem.{max u_1 u_2, max u_1 u_2} (Set.{max u_1 u_2} ((i : ι) → α i))
                (Set.{max u_1 u_2} (Set.{max u_1 u_2} ((i : ι) → α i)))
                (@Set.instMembership.{max u_1 u_2} (Set.{max u_1 u_2} ((i : ι) → α i)))
                (@MeasureTheory.closedCompactCylinders.{u_1, u_2} ι α inst) (s n)) →
          Nat →
            Set.{max u_1 u_2}
              ((i : @Set.Elem.{u_1} ι (@allProj.{u_1, u_2} ι α inst s hs)) →
                α
                  (@Subtype.val.{u_1 + 1} ι
                    (fun x =>
                      @Membership.mem.{u_1, u_1} ι (Set.{u_1} ι) (@Set.instMembership.{u_1} ι)
                        (@allProj.{u_1, u_2} ι α inst s hs) x)
                    i)) :=
fun {ι} {α} [inst : (i : ι) → TopologicalSpace.{u_2} (α i)] {s} hs n =>
  @Set.preimage.{max u_1 u_2, max u_1 u_2}
    ((i : @Set.Elem.{u_1} ι (@allProj.{u_1, u_2} ι α inst s hs)) →
      α
        (@Subtype.val.{u_1 + 1} ι
          (fun x =>
            @Membership.mem.{u_1, u_1} ι (Set.{u_1} ι) (@Set.instMembership.{u_1} ι) (@allProj.{u_1, u_2} ι α inst s hs)
              x)
          i))
    ((i : ↥(@MeasureTheory.closedCompactCylinders.finset.{u_1, u_2} ι α inst (s n) ⋯)) →
      α
        (@Subtype.val.{u_1 + 1} ι
          (fun x =>
            @Membership.mem.{u_1, u_1} ι (Set.{u_1} ι) (@Set.instMembership.{u_1} ι) (@allProj.{u_1, u_2} ι α inst s hs)
              x)
          (@Subtype.mk.{u_1 + 1} ι
            (fun x =>
              @Membership.mem.{u_1, u_1} ι (Set.{u_1} ι) (@Set.instMembership.{u_1} ι)
                (@allProj.{u_1, u_2} ι α inst s hs) x)
            (@Subtype.val.{u_1 + 1} ι
              (fun x =>
                @Membership.mem.{u_1, u_1} ι (Finset.{u_1} ι)
                  (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} ι) ι (@Finset.instSetLike.{u_1} ι))
                  (@MeasureTheory.closedCompactCylinders.finset.{u_1, u_2} ι α inst (s n) ⋯) x)
              i)
            ⋯)))
    (fun f i =>
      f
        (@Subtype.mk.{u_1 + 1} ι
          (fun x =>
            @Membership.mem.{u_1, u_1} ι (Set.{u_1} ι) (@Set.instMembership.{u_1} ι) (@allProj.{u_1, u_2} ι α inst s hs)
              x)
          (@Subtype.val.{u_1 + 1} ι
            (fun x =>
              @Membership.mem.{u_1, u_1} ι (Finset.{u_1} ι)
                (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} ι) ι (@Finset.instSetLike.{u_1} ι))
                (@MeasureTheory.closedCompactCylinders.finset.{u_1, u_2} ι α inst (s n) ⋯) x)
            i)
          ⋯))
    (@MeasureTheory.closedCompactCylinders.set.{u_1, u_2} ι α inst (s n) ⋯)
```

## `scale_change`

Command: `#print scale_change`

```lean
theorem scale_change.{u_1, u_2} : ∀ {E : Type u_1} [inst : PseudoEMetricSpace.{u_1} E] {C : Nat → Finset.{u_1} E}
  {k : Nat} {F : Type u_2} [inst_1 : PseudoEMetricSpace.{u_2} F] (m : Nat) (X : E → F) (δ : ENNReal),
  @LE.le.{0} ENNReal ENNReal.instLE
    (⨆ s,
      ⨆ t,
        @EDist.edist.{u_2} F
          (@WeakPseudoEMetricSpace.toEDist.{u_2} F
            (@UniformSpace.toTopologicalSpace.{u_2} F (@PseudoEMetricSpace.toUniformSpace.{u_2} F inst_1))
            (@PseudoEMetricSpace.toWeakPseudoEMetricSpace.{u_2} F inst_1))
          (X
            (@Subtype.val.{u_1 + 1} E
              (fun x =>
                @Membership.mem.{u_1, u_1} E (Finset.{u_1} E)
                  (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} E) E (@Finset.instSetLike.{u_1} E)) (C k) x)
              s))
          (X
            (@Subtype.val.{u_1 + 1} E
              (fun x =>
                @Membership.mem.{u_1, u_1} E (Finset.{u_1} E)
                  (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} E) E (@Finset.instSetLike.{u_1} E)) (C k) x)
              (@Subtype.val.{u_1 + 1} (↥(C k))
                (fun t =>
                  @LE.le.{0} ENNReal ENNReal.instLE
                    (@EDist.edist.{u_1} (↥(C k))
                      (@WeakPseudoEMetricSpace.toEDist.{u_1} (↥(C k))
                        (@instTopologicalSpaceSubtype.{u_1} E
                          (fun x =>
                            @Membership.mem.{u_1, u_1} E (Finset.{u_1} E)
                              (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} E) E (@Finset.instSetLike.{u_1} E))
                              (C k) x)
                          (@UniformSpace.toTopologicalSpace.{u_1} E (@PseudoEMetricSpace.toUniformSpace.{u_1} E inst)))
                        (@instWeakPseudoEMetricSpaceSubtype.{u_1} E
                          (fun x =>
                            @Membership.mem.{u_1, u_1} E (Finset.{u_1} E)
                              (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} E) E (@Finset.instSetLike.{u_1} E))
                              (C k) x)
                          (@UniformSpace.toTopologicalSpace.{u_1} E (@PseudoEMetricSpace.toUniformSpace.{u_1} E inst))
                          (@PseudoEMetricSpace.toWeakPseudoEMetricSpace.{u_1} E inst)))
                      s t)
                    δ)
                t))))
    (@HAdd.hAdd.{0, 0, 0} ENNReal ENNReal ENNReal (@instHAdd.{0} ENNReal ENNReal.instAdd)
      (⨆ s,
        ⨆ t,
          @EDist.edist.{u_2} F
            (@WeakPseudoEMetricSpace.toEDist.{u_2} F
              (@UniformSpace.toTopologicalSpace.{u_2} F (@PseudoEMetricSpace.toUniformSpace.{u_2} F inst_1))
              (@PseudoEMetricSpace.toWeakPseudoEMetricSpace.{u_2} F inst_1))
            (X
              (@chainingSequence.{u_1} E inst C
                (@Subtype.val.{u_1 + 1} E
                  (fun x =>
                    @Membership.mem.{u_1, u_1} E (Finset.{u_1} E)
                      (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} E) E (@Finset.instSetLike.{u_1} E)) (C k) x)
                  s)
                k m))
            (X
              (@chainingSequence.{u_1} E inst C
                (@Subtype.val.{u_1 + 1} E
                  (fun x =>
                    @Membership.mem.{u_1, u_1} E (Finset.{u_1} E)
                      (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} E) E (@Finset.instSetLike.{u_1} E)) (C k) x)
                  (@Subtype.val.{u_1 + 1} (↥(C k))
                    (fun t =>
                      @LE.le.{0} ENNReal ENNReal.instLE
                        (@EDist.edist.{u_1} (↥(C k))
                          (@WeakPseudoEMetricSpace.toEDist.{u_1} (↥(C k))
                            (@instTopologicalSpaceSubtype.{u_1} E
                              (fun x =>
                                @Membership.mem.{u_1, u_1} E (Finset.{u_1} E)
                                  (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} E) E (@Finset.instSetLike.{u_1} E))
                                  (C k) x)
                              (@UniformSpace.toTopologicalSpace.{u_1} E
                                (@PseudoEMetricSpace.toUniformSpace.{u_1} E inst)))
                            (@instWeakPseudoEMetricSpaceSubtype.{u_1} E
                              (fun x =>
                                @Membership.mem.{u_1, u_1} E (Finset.{u_1} E)
                                  (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} E) E (@Finset.instSetLike.{u_1} E))
                                  (C k) x)
                              (@UniformSpace.toTopologicalSpace.{u_1} E
                                (@PseudoEMetricSpace.toUniformSpace.{u_1} E inst))
                              (@PseudoEMetricSpace.toWeakPseudoEMetricSpace.{u_1} E inst)))
                          s t)
                        δ)
                    t))
                k m)))
      (@HMul.hMul.{0, 0, 0} ENNReal ENNReal ENNReal
        (@instHMul.{0} ENNReal
          (@Distrib.toMul.{0} ENNReal
            (@instDistribOfSemiring.{0} ENNReal (@CommSemiring.toSemiring.{0} ENNReal ENNReal.instCommSemiring))))
        (@OfNat.ofNat.{0} ENNReal (nat_lit 2)
          (@instOfNatAtLeastTwo.{0} ENNReal (nat_lit 2)
            (@AddMonoidWithOne.toNatCast.{0} ENNReal
              (@AddCommMonoidWithOne.toAddMonoidWithOne.{0} ENNReal ENNReal.instAddCommMonoidWithOne))
            ⋯))
        (⨆ s,
          @EDist.edist.{u_2} F
            (@WeakPseudoEMetricSpace.toEDist.{u_2} F
              (@UniformSpace.toTopologicalSpace.{u_2} F (@PseudoEMetricSpace.toUniformSpace.{u_2} F inst_1))
              (@PseudoEMetricSpace.toWeakPseudoEMetricSpace.{u_2} F inst_1))
            (X
              (@Subtype.val.{u_1 + 1} E
                (fun x =>
                  @Membership.mem.{u_1, u_1} E (Finset.{u_1} E)
                    (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} E) E (@Finset.instSetLike.{u_1} E)) (C k) x)
                s))
            (X
              (@chainingSequence.{u_1} E inst C
                (@Subtype.val.{u_1 + 1} E
                  (fun x =>
                    @Membership.mem.{u_1, u_1} E (Finset.{u_1} E)
                      (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} E) E (@Finset.instSetLike.{u_1} E)) (C k) x)
                  s)
                k m))))) :=
⋯
```

## `scale_change_rpow`

Command: `#print scale_change_rpow`

```lean
theorem scale_change_rpow.{u_1, u_2} : ∀ {E : Type u_1} [inst : PseudoEMetricSpace.{u_1} E] {C : Nat → Finset.{u_1} E}
  {k : Nat} {F : Type u_2} [inst_1 : PseudoEMetricSpace.{u_2} F] (m : Nat) (X : E → F) (δ : ENNReal) (p : Real),
  @LE.le.{0} Real Real.instLE (@OfNat.ofNat.{0} Real (nat_lit 0) (@Zero.toOfNat0.{0} Real Real.instZero)) p →
    @LE.le.{0} ENNReal ENNReal.instLE
      (⨆ s,
        ⨆ t,
          @HPow.hPow.{0, 0, 0} ENNReal Real ENNReal (@instHPow.{0, 0} ENNReal Real ENNReal.instPowReal)
            (@EDist.edist.{u_2} F
              (@WeakPseudoEMetricSpace.toEDist.{u_2} F
                (@UniformSpace.toTopologicalSpace.{u_2} F (@PseudoEMetricSpace.toUniformSpace.{u_2} F inst_1))
                (@PseudoEMetricSpace.toWeakPseudoEMetricSpace.{u_2} F inst_1))
              (X
                (@Subtype.val.{u_1 + 1} E
                  (fun x =>
                    @Membership.mem.{u_1, u_1} E (Finset.{u_1} E)
                      (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} E) E (@Finset.instSetLike.{u_1} E)) (C k) x)
                  s))
              (X
                (@Subtype.val.{u_1 + 1} E
                  (fun x =>
                    @Membership.mem.{u_1, u_1} E (Finset.{u_1} E)
                      (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} E) E (@Finset.instSetLike.{u_1} E)) (C k) x)
                  (@Subtype.val.{u_1 + 1} (↥(C k))
                    (fun t =>
                      @LE.le.{0} ENNReal ENNReal.instLE
                        (@EDist.edist.{u_1} (↥(C k))
                          (@WeakPseudoEMetricSpace.toEDist.{u_1} (↥(C k))
                            (@instTopologicalSpaceSubtype.{u_1} E
                              (fun x =>
                                @Membership.mem.{u_1, u_1} E (Finset.{u_1} E)
                                  (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} E) E (@Finset.instSetLike.{u_1} E))
                                  (C k) x)
                              (@UniformSpace.toTopologicalSpace.{u_1} E
                                (@PseudoEMetricSpace.toUniformSpace.{u_1} E inst)))
                            (@instWeakPseudoEMetricSpaceSubtype.{u_1} E
                              (fun x =>
                                @Membership.mem.{u_1, u_1} E (Finset.{u_1} E)
                                  (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} E) E (@Finset.instSetLike.{u_1} E))
                                  (C k) x)
                              (@UniformSpace.toTopologicalSpace.{u_1} E
                                (@PseudoEMetricSpace.toUniformSpace.{u_1} E inst))
                              (@PseudoEMetricSpace.toWeakPseudoEMetricSpace.{u_1} E inst)))
                          s t)
                        δ)
                    t))))
            p)
      (@HAdd.hAdd.{0, 0, 0} ENNReal ENNReal ENNReal (@instHAdd.{0} ENNReal ENNReal.instAdd)
        (@HMul.hMul.{0, 0, 0} ENNReal ENNReal ENNReal
          (@instHMul.{0} ENNReal
            (@Distrib.toMul.{0} ENNReal
              (@instDistribOfSemiring.{0} ENNReal (@CommSemiring.toSemiring.{0} ENNReal ENNReal.instCommSemiring))))
          (@HPow.hPow.{0, 0, 0} ENNReal Real ENNReal (@instHPow.{0, 0} ENNReal Real ENNReal.instPowReal)
            (@OfNat.ofNat.{0} ENNReal (nat_lit 2)
              (@instOfNatAtLeastTwo.{0} ENNReal (nat_lit 2)
                (@AddMonoidWithOne.toNatCast.{0} ENNReal
                  (@AddCommMonoidWithOne.toAddMonoidWithOne.{0} ENNReal ENNReal.instAddCommMonoidWithOne))
                ⋯))
            p)
          (⨆ s,
            ⨆ t,
              @HPow.hPow.{0, 0, 0} ENNReal Real ENNReal (@instHPow.{0, 0} ENNReal Real ENNReal.instPowReal)
                (@EDist.edist.{u_2} F
                  (@WeakPseudoEMetricSpace.toEDist.{u_2} F
                    (@UniformSpace.toTopologicalSpace.{u_2} F (@PseudoEMetricSpace.toUniformSpace.{u_2} F inst_1))
                    (@PseudoEMetricSpace.toWeakPseudoEMetricSpace.{u_2} F inst_1))
                  (X
                    (@chainingSequence.{u_1} E inst C
                      (@Subtype.val.{u_1 + 1} E
                        (fun x =>
                          @Membership.mem.{u_1, u_1} E (Finset.{u_1} E)
                            (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} E) E (@Finset.instSetLike.{u_1} E)) (C k)
                            x)
                        s)
                      k m))
                  (X
                    (@chainingSequence.{u_1} E inst C
                      (@Subtype.val.{u_1 + 1} E
                        (fun x =>
                          @Membership.mem.{u_1, u_1} E (Finset.{u_1} E)
                            (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} E) E (@Finset.instSetLike.{u_1} E)) (C k)
                            x)
                        (@Subtype.val.{u_1 + 1} (↥(C k))
                          (fun t =>
                            @LE.le.{0} ENNReal ENNReal.instLE
                              (@EDist.edist.{u_1} (↥(C k))
                                (@WeakPseudoEMetricSpace.toEDist.{u_1} (↥(C k))
                                  (@instTopologicalSpaceSubtype.{u_1} E
                                    (fun x =>
                                      @Membership.mem.{u_1, u_1} E (Finset.{u_1} E)
                                        (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} E) E
                                          (@Finset.instSetLike.{u_1} E))
                                        (C k) x)
                                    (@UniformSpace.toTopologicalSpace.{u_1} E
                                      (@PseudoEMetricSpace.toUniformSpace.{u_1} E inst)))
                                  (@instWeakPseudoEMetricSpaceSubtype.{u_1} E
                                    (fun x =>
                                      @Membership.mem.{u_1, u_1} E (Finset.{u_1} E)
                                        (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} E) E
                                          (@Finset.instSetLike.{u_1} E))
                                        (C k) x)
                                    (@UniformSpace.toTopologicalSpace.{u_1} E
                                      (@PseudoEMetricSpace.toUniformSpace.{u_1} E inst))
                                    (@PseudoEMetricSpace.toWeakPseudoEMetricSpace.{u_1} E inst)))
                                s t)
                              δ)
                          t))
                      k m)))
                p))
        (@HMul.hMul.{0, 0, 0} ENNReal ENNReal ENNReal
          (@instHMul.{0} ENNReal
            (@Distrib.toMul.{0} ENNReal
              (@instDistribOfSemiring.{0} ENNReal (@CommSemiring.toSemiring.{0} ENNReal ENNReal.instCommSemiring))))
          (@HPow.hPow.{0, 0, 0} ENNReal Real ENNReal (@instHPow.{0, 0} ENNReal Real ENNReal.instPowReal)
            (@OfNat.ofNat.{0} ENNReal (nat_lit 4)
              (@instOfNatAtLeastTwo.{0} ENNReal (nat_lit 4)
                (@AddMonoidWithOne.toNatCast.{0} ENNReal
                  (@AddCommMonoidWithOne.toAddMonoidWithOne.{0} ENNReal ENNReal.instAddCommMonoidWithOne))
                ⋯))
            p)
          (⨆ s,
            @HPow.hPow.{0, 0, 0} ENNReal Real ENNReal (@instHPow.{0, 0} ENNReal Real ENNReal.instPowReal)
              (@EDist.edist.{u_2} F
                (@WeakPseudoEMetricSpace.toEDist.{u_2} F
                  (@UniformSpace.toTopologicalSpace.{u_2} F (@PseudoEMetricSpace.toUniformSpace.{u_2} F inst_1))
                  (@PseudoEMetricSpace.toWeakPseudoEMetricSpace.{u_2} F inst_1))
                (X
                  (@Subtype.val.{u_1 + 1} E
                    (fun x =>
                      @Membership.mem.{u_1, u_1} E (Finset.{u_1} E)
                        (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} E) E (@Finset.instSetLike.{u_1} E)) (C k) x)
                    s))
                (X
                  (@chainingSequence.{u_1} E inst C
                    (@Subtype.val.{u_1 + 1} E
                      (fun x =>
                        @Membership.mem.{u_1, u_1} E (Finset.{u_1} E)
                          (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} E) E (@Finset.instSetLike.{u_1} E)) (C k) x)
                      s)
                    k m)))
              p))) :=
⋯
```

## `subset_allProj`

Command: `#print subset_allProj`

```lean
theorem subset_allProj.{u_1, u_2} : ∀ {ι : Type u_1} {α : ι → Type u_2} [inst : (i : ι) → TopologicalSpace.{u_2} (α i)]
  {s : Nat → Set.{max u_1 u_2} ((i : ι) → α i)}
  (hs :
    ∀ (n : Nat),
      @Membership.mem.{max u_1 u_2, max u_1 u_2} (Set.{max u_1 u_2} ((i : ι) → α i))
        (Set.{max u_1 u_2} (Set.{max u_1 u_2} ((i : ι) → α i)))
        (@Set.instMembership.{max u_1 u_2} (Set.{max u_1 u_2} ((i : ι) → α i)))
        (@MeasureTheory.closedCompactCylinders.{u_1, u_2} ι α inst) (s n))
  (n : Nat),
  @LE.le.{u_1} (Set.{u_1} ι) (@Set.instLE.{u_1} ι)
    (@SetLike.coe.{u_1, u_1} (Finset.{u_1} ι) ι (@Finset.instSetLike.{u_1} ι)
      (@MeasureTheory.closedCompactCylinders.finset.{u_1, u_2} ι α inst (s n) ⋯))
    (@allProj.{u_1, u_2} ι α inst s hs) :=
⋯
```

## `subset_closure_dense_inter`

Command: `#print subset_closure_dense_inter`

```lean
theorem subset_closure_dense_inter.{u_4} : ∀ {α : Type u_4} [inst : TopologicalSpace.{u_4} α] {T' U : Set.{u_4} α},
  @Dense.{u_4} α inst T' →
    @IsOpen.{u_4} α inst U →
      @LE.le.{u_4} (Set.{u_4} α) (@Set.instLE.{u_4} α) U
        (@closure.{u_4} α inst (@Inter.inter.{u_4} (Set.{u_4} α) (@Set.instInter.{u_4} α) T' U)) :=
⋯
```

## `surjective_proj_allProj`

Command: `#print surjective_proj_allProj`

```lean
theorem surjective_proj_allProj.{u_1, u_2} : ∀ {ι : Type u_1} {α : ι → Type u_2}
  [inst : (i : ι) → TopologicalSpace.{u_2} (α i)] {s : Nat → Set.{max u_1 u_2} ((i : ι) → α i)}
  [∀ (i : ι), Nonempty.{u_2 + 1} (α i)]
  (hs :
    ∀ (n : Nat),
      @Membership.mem.{max u_1 u_2, max u_1 u_2} (Set.{max u_1 u_2} ((i : ι) → α i))
        (Set.{max u_1 u_2} (Set.{max u_1 u_2} ((i : ι) → α i)))
        (@Set.instMembership.{max u_1 u_2} (Set.{max u_1 u_2} ((i : ι) → α i)))
        (@MeasureTheory.closedCompactCylinders.{u_1, u_2} ι α inst) (s n)),
  @Function.Surjective.{max (u_1 + 1) (u_2 + 1), max (u_1 + 1) (u_2 + 1)} ((i : ι) → α i)
    ((i : @Set.Elem.{u_1} ι (@allProj.{u_1, u_2} ι α inst s hs)) →
      α
        (@Subtype.val.{u_1 + 1} ι
          (fun x =>
            @Membership.mem.{u_1, u_1} ι (Set.{u_1} ι) (@Set.instMembership.{u_1} ι) (@allProj.{u_1, u_2} ι α inst s hs)
              x)
          i))
    fun f i =>
    f
      (@Subtype.val.{u_1 + 1} ι
        (fun x =>
          @Membership.mem.{u_1, u_1} ι (Set.{u_1} ι) (@Set.instMembership.{u_1} ι) (@allProj.{u_1, u_2} ι α inst s hs)
            x)
        i) :=
⋯
```

## `volume_eq_top_of_packingNumber`

Command: `#print volume_eq_top_of_packingNumber`

```lean
theorem volume_eq_top_of_packingNumber.{u_1} : ∀ {E : Type u_1} [inst : NormedAddCommGroup.{u_1} E]
  [inst_1 :
    @InnerProductSpace.{0, u_1} Real E Real.instRCLike (@NormedAddCommGroup.toSeminormedAddCommGroup.{u_1} E inst)]
  [inst_2 :
    @FiniteDimensional.{0, u_1} Real E Real.instDivisionRing (@NormedAddCommGroup.toAddCommGroup.{u_1} E inst)
      (@NormedSpace.toModule.{0, u_1} Real E Real.normedField
        (@NormedAddCommGroup.toSeminormedAddCommGroup.{u_1} E inst)
        (@InnerProductSpace.toNormedSpace.{0, u_1} Real E Real.instRCLike
          (@NormedAddCommGroup.toSeminormedAddCommGroup.{u_1} E inst) inst_1))]
  [inst_3 : MeasurableSpace.{u_1} E]
  [inst_4 :
    @BorelSpace.{u_1} E
      (@UniformSpace.toTopologicalSpace.{u_1} E
        (@PseudoMetricSpace.toUniformSpace.{u_1} E
          (@SeminormedAddCommGroup.toPseudoMetricSpace.{u_1} E
            (@NormedAddCommGroup.toSeminormedAddCommGroup.{u_1} E inst))))
      inst_3]
  {ε : NNReal} (A : Set.{u_1} E),
  @LT.lt.{0} NNReal (@Preorder.toLT.{0} NNReal (@PartialOrder.toPreorder.{0} NNReal NNReal.instPartialOrder))
      (@OfNat.ofNat.{0} NNReal (nat_lit 0) (@Zero.toOfNat0.{0} NNReal NNReal.instZero)) ε →
    @Eq.{1} ENat
        (@Metric.packingNumber.{u_1} E
          (@EMetricSpace.toPseudoEMetricSpace.{u_1} E
            (@MetricSpace.toEMetricSpace.{u_1} E (@NormedAddCommGroup.toMetricSpace.{u_1} E inst)))
          ε A)
        (@Top.top.{0} ENat instTopENat) →
      @Eq.{1} ENNReal
        (@DFunLike.coe.{u_1 + 1, u_1 + 1, 1}
          (@MeasureTheory.Measure.{u_1} E
            (@MeasureTheory.MeasureSpace.toMeasurableSpace.{u_1} E
              (@measureSpaceOfInnerProductSpace.{u_1} E inst inst_1 inst_2 inst_3 inst_4)))
          (Set.{u_1} E) (fun x => ENNReal)
          (@MeasureTheory.Measure.instFunLike.{u_1} E
            (@MeasureTheory.MeasureSpace.toMeasurableSpace.{u_1} E
              (@measureSpaceOfInnerProductSpace.{u_1} E inst inst_1 inst_2 inst_3 inst_4)))
          (@MeasureTheory.MeasureSpace.volume.{u_1} E
            (@measureSpaceOfInnerProductSpace.{u_1} E inst inst_1 inst_2 inst_3 inst_4))
          (@HAdd.hAdd.{u_1, u_1, u_1} (Set.{u_1} E) (Set.{u_1} E) (Set.{u_1} E)
            (@instHAdd.{u_1} (Set.{u_1} E)
              (@Set.add.{u_1} E
                (@AddCommMagma.toAdd.{u_1} E
                  (@AddCommSemigroup.toAddCommMagma.{u_1} E
                    (@AddCommMonoid.toAddCommSemigroup.{u_1} E
                      (@AddCommGroup.toAddCommMonoid.{u_1} E (@NormedAddCommGroup.toAddCommGroup.{u_1} E inst)))))))
            A
            (@Metric.closedEBall.{u_1} E
              (@EMetricSpace.toPseudoEMetricSpace.{u_1} E
                (@MetricSpace.toEMetricSpace.{u_1} E (@NormedAddCommGroup.toMetricSpace.{u_1} E inst)))
              (@OfNat.ofNat.{u_1} E (nat_lit 0)
                (@Zero.toOfNat0.{u_1} E
                  (@NegZeroClass.toZero.{u_1} E
                    (@SubNegZeroMonoid.toNegZeroClass.{u_1} E
                      (@SubtractionMonoid.toSubNegZeroMonoid.{u_1} E
                        (@SubtractionCommMonoid.toSubtractionMonoid.{u_1} E
                          (@AddCommGroup.toDivisionAddCommMonoid.{u_1} E
                            (@NormedAddCommGroup.toAddCommGroup.{u_1} E inst))))))))
              (@HDiv.hDiv.{0, 0, 0} ENNReal ENNReal ENNReal
                (@instHDiv.{0} ENNReal (@DivInvMonoid.toDiv.{0} ENNReal ENNReal.instDivInvMonoid)) (↑ε)
                (@OfNat.ofNat.{0} ENNReal (nat_lit 2)
                  (@instOfNatAtLeastTwo.{0} ENNReal (nat_lit 2)
                    (@AddMonoidWithOne.toNatCast.{0} ENNReal
                      (@AddCommMonoidWithOne.toAddMonoidWithOne.{0} ENNReal ENNReal.instAddCommMonoidWithOne))
                    ⋯))))))
        (@Top.top.{0} ENNReal ENNReal.instTop) :=
⋯
```

## `volume_of_nonempty_of_subsingleton`

Command: `#print volume_of_nonempty_of_subsingleton`

```lean
theorem volume_of_nonempty_of_subsingleton.{u_1} : ∀ {E : Type u_1} [inst : NormedAddCommGroup.{u_1} E]
  [inst_1 :
    @InnerProductSpace.{0, u_1} Real E Real.instRCLike (@NormedAddCommGroup.toSeminormedAddCommGroup.{u_1} E inst)]
  [inst_2 :
    @FiniteDimensional.{0, u_1} Real E Real.instDivisionRing (@NormedAddCommGroup.toAddCommGroup.{u_1} E inst)
      (@NormedSpace.toModule.{0, u_1} Real E Real.normedField
        (@NormedAddCommGroup.toSeminormedAddCommGroup.{u_1} E inst)
        (@InnerProductSpace.toNormedSpace.{0, u_1} Real E Real.instRCLike
          (@NormedAddCommGroup.toSeminormedAddCommGroup.{u_1} E inst) inst_1))]
  [inst_3 : MeasurableSpace.{u_1} E] [inst_4 : Subsingleton.{u_1 + 1} E] {s : Set.{u_1} E},
  @Set.Nonempty.{u_1} E s →
    @Eq.{1} ENNReal
      (@DFunLike.coe.{u_1 + 1, u_1 + 1, 1}
        (@MeasureTheory.Measure.{u_1} E
          (@MeasureTheory.MeasureSpace.toMeasurableSpace.{u_1} E
            (@measureSpaceOfInnerProductSpace.{u_1} E inst inst_1 inst_2 inst_3 ⋯)))
        (Set.{u_1} E) (fun x => ENNReal)
        (@MeasureTheory.Measure.instFunLike.{u_1} E
          (@MeasureTheory.MeasureSpace.toMeasurableSpace.{u_1} E
            (@measureSpaceOfInnerProductSpace.{u_1} E inst inst_1 inst_2 inst_3 ⋯)))
        (@MeasureTheory.MeasureSpace.volume.{u_1} E
          (@measureSpaceOfInnerProductSpace.{u_1} E inst inst_1 inst_2 inst_3 ⋯))
        s)
      (@OfNat.ofNat.{0} ENNReal (nat_lit 1) (@One.toOfNat1.{0} ENNReal ENNReal.instOne)) :=
⋯
```

## `zero_mem_parallelepiped`

Command: `#print zero_mem_parallelepiped`

```lean
theorem zero_mem_parallelepiped.{u_1, u_2} : ∀ {ι : Type u_1} {E : Type u_2} [inst : Fintype.{u_1} ι]
  [inst_1 : AddCommGroup.{u_2} E]
  [inst_2 : @_root_.Module.{0, u_2} Real E Real.semiring (@AddCommGroup.toAddCommMonoid.{u_2} E inst_1)] {v : ι → E},
  @Membership.mem.{u_2, u_2} E (Set.{u_2} E) (@Set.instMembership.{u_2} E)
    (@parallelepiped.{u_1, u_2} ι E inst inst_1 inst_2 v)
    (@OfNat.ofNat.{u_2} E (nat_lit 0)
      (@Zero.toOfNat0.{u_2} E
        (@NegZeroClass.toZero.{u_2} E
          (@SubNegZeroMonoid.toNegZeroClass.{u_2} E
            (@SubtractionMonoid.toSubNegZeroMonoid.{u_2} E
              (@SubtractionCommMonoid.toSubtractionMonoid.{u_2} E
                (@AddCommGroup.toDivisionAddCommMonoid.{u_2} E inst_1))))))) :=
⋯
```

## `Dense.holderOnWith_extend`

Command: `#print Dense.holderOnWith_extend`

```lean
theorem Dense.holderOnWith_extend.{u_1, u_2} : ∀ {X : Type u_1} {Y : Type u_2} [inst : PseudoEMetricSpace.{u_1} X]
  [inst_1 : PseudoEMetricSpace.{u_2} Y] [@CompleteSpace.{u_2} Y (@PseudoEMetricSpace.toUniformSpace.{u_2} Y inst_1)]
  {C r : NNReal} {s : Set.{u_1} X} {f : @Set.Elem.{u_1} X s → Y} {U : Set.{u_1} X},
  @IsOpen.{u_1} X (@UniformSpace.toTopologicalSpace.{u_1} X (@PseudoEMetricSpace.toUniformSpace.{u_1} X inst)) U →
    ∀
      (hs :
        @Dense.{u_1} X (@UniformSpace.toTopologicalSpace.{u_1} X (@PseudoEMetricSpace.toUniformSpace.{u_1} X inst)) s),
      @HolderOnWith.{u_1, u_2} (@Set.Elem.{u_1} X s) Y
          (@instPseudoEMetricSpaceSubtype.{u_1} X
            (fun x => @Membership.mem.{u_1, u_1} X (Set.{u_1} X) (@Set.instMembership.{u_1} X) s x) inst)
          inst_1 C r f
          (@setOf.{u_1} (@Set.Elem.{u_1} X s) fun x =>
            @Membership.mem.{u_1, u_1} X (Set.{u_1} X) (@Set.instMembership.{u_1} X) U
              (@Subtype.val.{u_1 + 1} X
                (fun x => @Membership.mem.{u_1, u_1} X (Set.{u_1} X) (@Set.instMembership.{u_1} X) s x) x)) →
        @LT.lt.{0} NNReal (@Preorder.toLT.{0} NNReal (@PartialOrder.toPreorder.{0} NNReal NNReal.instPartialOrder))
            (@OfNat.ofNat.{0} NNReal (nat_lit 0) (@Zero.toOfNat0.{0} NNReal NNReal.instZero)) r →
          @HolderOnWith.{u_1, u_2} X Y inst inst_1 C r
            (@Dense.extend.{u_1, u_2} X Y
              (@UniformSpace.toTopologicalSpace.{u_1} X (@PseudoEMetricSpace.toUniformSpace.{u_1} X inst))
              (@UniformSpace.toTopologicalSpace.{u_2} Y (@PseudoEMetricSpace.toUniformSpace.{u_2} Y inst_1)) s hs f)
            U :=
⋯
```

## `Dense.holderWith_extend`

Command: `#print Dense.holderWith_extend`

```lean
theorem Dense.holderWith_extend.{u_1, u_2} : ∀ {X : Type u_1} {Y : Type u_2} [inst : PseudoEMetricSpace.{u_1} X]
  [inst_1 : PseudoEMetricSpace.{u_2} Y] [@CompleteSpace.{u_2} Y (@PseudoEMetricSpace.toUniformSpace.{u_2} Y inst_1)]
  {C r : NNReal} {s : Set.{u_1} X} {f : @Set.Elem.{u_1} X s → Y}
  (hs : @Dense.{u_1} X (@UniformSpace.toTopologicalSpace.{u_1} X (@PseudoEMetricSpace.toUniformSpace.{u_1} X inst)) s),
  @HolderWith.{u_1, u_2} (@Set.Elem.{u_1} X s) Y
      (@instPseudoEMetricSpaceSubtype.{u_1} X
        (fun x => @Membership.mem.{u_1, u_1} X (Set.{u_1} X) (@Set.instMembership.{u_1} X) s x) inst)
      inst_1 C r f →
    @LT.lt.{0} NNReal (@Preorder.toLT.{0} NNReal (@PartialOrder.toPreorder.{0} NNReal NNReal.instPartialOrder))
        (@OfNat.ofNat.{0} NNReal (nat_lit 0) (@Zero.toOfNat0.{0} NNReal NNReal.instZero)) r →
      @HolderWith.{u_1, u_2} X Y inst inst_1 C r
        (@Dense.extend.{u_1, u_2} X Y
          (@UniformSpace.toTopologicalSpace.{u_1} X (@PseudoEMetricSpace.toUniformSpace.{u_1} X inst))
          (@UniformSpace.toTopologicalSpace.{u_2} Y (@PseudoEMetricSpace.toUniformSpace.{u_2} Y inst_1)) s hs f) :=
⋯
```

## `ENNReal.lintegral_Lp_finsum_le`

Command: `#print ENNReal.lintegral_Lp_finsum_le`

```lean
theorem ENNReal.lintegral_Lp_finsum_le.{u_1, u_2} : ∀ {α : Type u_1} [inst : MeasurableSpace.{u_1} α]
  {μ : @MeasureTheory.Measure.{u_1} α inst} {p : Real} {ι : Type u_2} {f : ι → α → ENNReal} {I : Finset.{u_2} ι},
  (∀ (i : ι),
      @Membership.mem.{u_2, u_2} ι (Finset.{u_2} ι)
          (@SetLike.instMembership.{u_2, u_2} (Finset.{u_2} ι) ι (@Finset.instSetLike.{u_2} ι)) I i →
        @AEMeasurable.{u_1, 0} α ENNReal ENNReal.measurableSpace inst (f i) μ) →
    @LE.le.{0} Real Real.instLE (@OfNat.ofNat.{0} Real (nat_lit 1) (@One.toOfNat1.{0} Real Real.instOne)) p →
      @LE.le.{0} ENNReal ENNReal.instLE
        (@HPow.hPow.{0, 0, 0} ENNReal Real ENNReal (@instHPow.{0, 0} ENNReal Real ENNReal.instPowReal)
          (@MeasureTheory.lintegral.{u_1} α inst μ fun a =>
            @HPow.hPow.{0, 0, 0} ENNReal Real ENNReal (@instHPow.{0, 0} ENNReal Real ENNReal.instPowReal)
              ((∑ i ∈ I, f i) a) p)
          (@HDiv.hDiv.{0, 0, 0} Real Real Real (@instHDiv.{0} Real (@DivInvMonoid.toDiv.{0} Real Real.instDivInvMonoid))
            (@OfNat.ofNat.{0} Real (nat_lit 1) (@One.toOfNat1.{0} Real Real.instOne)) p))
        (∑ i ∈ I,
          @HPow.hPow.{0, 0, 0} ENNReal Real ENNReal (@instHPow.{0, 0} ENNReal Real ENNReal.instPowReal)
            (@MeasureTheory.lintegral.{u_1} α inst μ fun a =>
              @HPow.hPow.{0, 0, 0} ENNReal Real ENNReal (@instHPow.{0, 0} ENNReal Real ENNReal.instPowReal) (f i a) p)
            (@HDiv.hDiv.{0, 0, 0} Real Real Real
              (@instHDiv.{0} Real (@DivInvMonoid.toDiv.{0} Real Real.instDivInvMonoid))
              (@OfNat.ofNat.{0} Real (nat_lit 1) (@One.toOfNat1.{0} Real Real.instOne)) p)) :=
⋯
```

## `ENNReal.rpow_finsetSum_le_finsetSum_rpow`

Command: `#print ENNReal.rpow_finsetSum_le_finsetSum_rpow`

```lean
theorem ENNReal.rpow_finsetSum_le_finsetSum_rpow.{u_1} : ∀ {p : Real} {ι : Type u_1} {I : Finset.{u_1} ι}
  {f : ι → ENNReal},
  @LT.lt.{0} Real Real.instLT (@OfNat.ofNat.{0} Real (nat_lit 0) (@Zero.toOfNat0.{0} Real Real.instZero)) p →
    @LE.le.{0} Real Real.instLE p (@OfNat.ofNat.{0} Real (nat_lit 1) (@One.toOfNat1.{0} Real Real.instOne)) →
      @LE.le.{0} ENNReal ENNReal.instLE
        (@HPow.hPow.{0, 0, 0} ENNReal Real ENNReal (@instHPow.{0, 0} ENNReal Real ENNReal.instPowReal) (∑ i ∈ I, f i) p)
        (∑ i ∈ I,
          @HPow.hPow.{0, 0, 0} ENNReal Real ENNReal (@instHPow.{0, 0} ENNReal Real ENNReal.instPowReal) (f i) p) :=
⋯
```

## `ENNReal.sum_geometric_two_le`

Command: `#print ENNReal.sum_geometric_two_le`

```lean
theorem ENNReal.sum_geometric_two_le : ∀ (n : Nat),
  @LE.le.{0} ENNReal ENNReal.instLE
    (∑ i ∈ Finset.range n,
      @HPow.hPow.{0, 0, 0} ENNReal Nat ENNReal
        (@instHPow.{0, 0} ENNReal Nat
          (@NPow.toPow.{0} ENNReal
            (@Monoid.toNPow.{0} ENNReal
              (@Semiring.toMonoid.{0} ENNReal (@CommSemiring.toSemiring.{0} ENNReal ENNReal.instCommSemiring)))))
        (@HDiv.hDiv.{0, 0, 0} ENNReal ENNReal ENNReal
          (@instHDiv.{0} ENNReal (@DivInvMonoid.toDiv.{0} ENNReal ENNReal.instDivInvMonoid))
          (@OfNat.ofNat.{0} ENNReal (nat_lit 1) (@One.toOfNat1.{0} ENNReal ENNReal.instOne))
          (@OfNat.ofNat.{0} ENNReal (nat_lit 2)
            (@instOfNatAtLeastTwo.{0} ENNReal (nat_lit 2)
              (@AddMonoidWithOne.toNatCast.{0} ENNReal
                (@AddCommMonoidWithOne.toAddMonoidWithOne.{0} ENNReal ENNReal.instAddCommMonoidWithOne))
              ⋯)))
        i)
    (@OfNat.ofNat.{0} ENNReal (nat_lit 2)
      (@instOfNatAtLeastTwo.{0} ENNReal (nat_lit 2)
        (@AddMonoidWithOne.toNatCast.{0} ENNReal
          (@AddCommMonoidWithOne.toAddMonoidWithOne.{0} ENNReal ENNReal.instAddCommMonoidWithOne))
        ⋯)) :=
⋯
```

## `ENat.toENNReal_le'`

Command: `#print ENat.toENNReal_le'`

```lean
theorem ENat.toENNReal_le' : ∀ {m n : ENat}, @LE.le.{0} ENat instLEENat m n → @LE.le.{0} ENNReal ENNReal.instLE ↑m ↑n :=
⋯
```

## `Finset.iSup_sum_le`

Command: `#print Finset.iSup_sum_le`

```lean
theorem Finset.iSup_sum_le.{u_1, u_2, u_3} : ∀ {α : Type u_1} {ι : Type u_2} {β : Sort u_3}
  [inst : CompleteLattice.{u_1} α] [inst_1 : AddCommMonoid.{u_1} α]
  [@IsOrderedAddMonoid.{u_1} α inst_1
      (@PartialOrder.toPreorder.{u_1} α
        (@ChainCompletePartialOrder.toPartialOrder.{u_1} α
          (@ChainCompletePartialOrder.instOfCompleteLattice.{u_1} α inst)))]
  {I : Finset.{u_2} ι} (f : ι → β → α),
  @LE.le.{u_1} α
    (@Preorder.toLE.{u_1} α
      (@PartialOrder.toPreorder.{u_1} α
        (@ChainCompletePartialOrder.toPartialOrder.{u_1} α
          (@ChainCompletePartialOrder.instOfCompleteLattice.{u_1} α inst))))
    (⨆ b, ∑ i ∈ I, f i b) (∑ i ∈ I, ⨆ b, f i b) :=
⋯
```

## `Finset.sup_le_sum`

Command: `#print Finset.sup_le_sum`

```lean
theorem Finset.sup_le_sum.{u_1, u_2} : ∀ {α : Type u_1} {β : Type u_2} [inst : AddCommMonoid.{u_2} β]
  [inst_1 : LinearOrder.{u_2} β]
  [inst_2 :
    @OrderBot.{u_2} β
      (@Preorder.toLE.{u_2} β
        (@PartialOrder.toPreorder.{u_2} β
          (@SemilatticeInf.toPartialOrder.{u_2} β
            (@Lattice.toSemilatticeInf.{u_2} β
              (@DistribLattice.toLattice.{u_2} β (@instDistribLatticeOfLinearOrder.{u_2} β inst_1))))))]
  [@IsOrderedAddMonoid.{u_2} β inst
      (@PartialOrder.toPreorder.{u_2} β
        (@SemilatticeInf.toPartialOrder.{u_2} β
          (@Lattice.toSemilatticeInf.{u_2} β
            (@DistribLattice.toLattice.{u_2} β (@instDistribLatticeOfLinearOrder.{u_2} β inst_1)))))]
  (s : Finset.{u_1} α) (f : α → β),
  (∀ (i : α),
      @Membership.mem.{u_1, u_1} α (Finset.{u_1} α)
          (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} α) α (@Finset.instSetLike.{u_1} α)) s i →
        @LE.le.{u_2} β
          (@Preorder.toLE.{u_2} β
            (@PartialOrder.toPreorder.{u_2} β
              (@SemilatticeInf.toPartialOrder.{u_2} β
                (@Lattice.toSemilatticeInf.{u_2} β
                  (@DistribLattice.toLattice.{u_2} β (@instDistribLatticeOfLinearOrder.{u_2} β inst_1))))))
          (@OfNat.ofNat.{u_2} β (nat_lit 0)
            (@Zero.toOfNat0.{u_2} β
              (@AddZero.toZero.{u_2} β
                (@AddZeroClass.toAddZero.{u_2} β
                  (@AddMonoid.toAddZeroClass.{u_2} β (@AddCommMonoid.toAddMonoid.{u_2} β inst))))))
          (f i)) →
    @LE.le.{u_2} β
      (@Preorder.toLE.{u_2} β
        (@PartialOrder.toPreorder.{u_2} β
          (@SemilatticeInf.toPartialOrder.{u_2} β
            (@Lattice.toSemilatticeInf.{u_2} β
              (@DistribLattice.toLattice.{u_2} β (@instDistribLatticeOfLinearOrder.{u_2} β inst_1))))))
      (@Finset.sup.{u_2, u_1} β α
        (@Lattice.toSemilatticeSup.{u_2} β
          (@DistribLattice.toLattice.{u_2} β (@instDistribLatticeOfLinearOrder.{u_2} β inst_1)))
        inst_2 s f)
      (∑ a ∈ s, f a) :=
⋯
```

## `HasBoundedCoveringNumber.coveringNumber_le`

Command: `#print HasBoundedCoveringNumber.coveringNumber_le`

```lean
theorem HasBoundedCoveringNumber.coveringNumber_le.{u_1} : ∀ {T : Type u_1} [inst : PseudoEMetricSpace.{u_1} T]
  {A : Set.{u_1} T} {c : ENNReal} {d : Real},
  @HasBoundedCoveringNumber.{u_1} T inst A c d →
    ∀ (ε : NNReal),
      @LE.le.{0} ENNReal ENNReal.instLE (↑ε) (@Metric.ediam.{u_1} T inst A) →
        @LE.le.{0} ENNReal ENNReal.instLE (↑(@Metric.coveringNumber.{u_1} T inst ε A))
          (@HMul.hMul.{0, 0, 0} ENNReal ENNReal ENNReal
            (@instHMul.{0} ENNReal
              (@Distrib.toMul.{0} ENNReal
                (@instDistribOfSemiring.{0} ENNReal (@CommSemiring.toSemiring.{0} ENNReal ENNReal.instCommSemiring))))
            c
            (@HPow.hPow.{0, 0, 0} ENNReal Real ENNReal (@instHPow.{0, 0} ENNReal Real ENNReal.instPowReal)
              (@Inv.inv.{0} ENNReal ENNReal.instInv ↑ε) d)) :=
⋯
```

## `HasBoundedCoveringNumber.coveringNumber_lt_top`

Command: `#print HasBoundedCoveringNumber.coveringNumber_lt_top`

```lean
theorem HasBoundedCoveringNumber.coveringNumber_lt_top.{u_1} : ∀ {T : Type u_1} [inst : PseudoEMetricSpace.{u_1} T]
  {A : Set.{u_1} T} {c : ENNReal} {ε : NNReal} {d : Real},
  @HasBoundedCoveringNumber.{u_1} T inst A c d →
    @Ne.{1} NNReal ε (@OfNat.ofNat.{0} NNReal (nat_lit 0) (@Zero.toOfNat0.{0} NNReal NNReal.instZero)) →
      @Ne.{1} ENNReal c (@Top.top.{0} ENNReal ENNReal.instTop) →
        @LE.le.{0} Real Real.instLE (@OfNat.ofNat.{0} Real (nat_lit 0) (@Zero.toOfNat0.{0} Real Real.instZero)) d →
          @LT.lt.{0} ENat instLTENat (@Metric.coveringNumber.{u_1} T inst ε A) (@Top.top.{0} ENat instTopENat) :=
⋯
```

## `HasBoundedCoveringNumber.ediam_lt_top`

Command: `#print HasBoundedCoveringNumber.ediam_lt_top`

```lean
theorem HasBoundedCoveringNumber.ediam_lt_top.{u_1} : ∀ {T : Type u_1} [inst : PseudoEMetricSpace.{u_1} T]
  {A : Set.{u_1} T} {c : ENNReal} {d : Real},
  @HasBoundedCoveringNumber.{u_1} T inst A c d →
    @LT.lt.{0} ENNReal (@Preorder.toLT.{0} ENNReal (@PartialOrder.toPreorder.{0} ENNReal ENNReal.instPartialOrder))
      (@Metric.ediam.{u_1} T inst A) (@Top.top.{0} ENNReal ENNReal.instTop) :=
⋯
```

## `HasBoundedCoveringNumber.mk`

Command: `#print HasBoundedCoveringNumber.mk`

```lean
constructor HasBoundedCoveringNumber.mk.{u_1} : ∀ {T : Type u_1} [inst : PseudoEMetricSpace.{u_1} T] {A : Set.{u_1} T}
  {c : ENNReal} {d : Real},
  @LT.lt.{0} ENNReal (@Preorder.toLT.{0} ENNReal (@PartialOrder.toPreorder.{0} ENNReal ENNReal.instPartialOrder))
      (@Metric.ediam.{u_1} T inst A) (@Top.top.{0} ENNReal ENNReal.instTop) →
    (∀ (ε : NNReal),
        @LE.le.{0} ENNReal ENNReal.instLE (↑ε) (@Metric.ediam.{u_1} T inst A) →
          @LE.le.{0} ENNReal ENNReal.instLE (↑(@Metric.coveringNumber.{u_1} T inst ε A))
            (@HMul.hMul.{0, 0, 0} ENNReal ENNReal ENNReal
              (@instHMul.{0} ENNReal
                (@Distrib.toMul.{0} ENNReal
                  (@instDistribOfSemiring.{0} ENNReal (@CommSemiring.toSemiring.{0} ENNReal ENNReal.instCommSemiring))))
              c
              (@HPow.hPow.{0, 0, 0} ENNReal Real ENNReal (@instHPow.{0, 0} ENNReal Real ENNReal.instPowReal)
                (@Inv.inv.{0} ENNReal ENNReal.instInv ↑ε) d))) →
      @HasBoundedCoveringNumber.{u_1} T inst A c d
```

## `HasBoundedCoveringNumber.subset`

Command: `#print HasBoundedCoveringNumber.subset`

```lean
theorem HasBoundedCoveringNumber.subset.{u_1} : ∀ {T : Type u_1} [inst : PseudoEMetricSpace.{u_1} T] {A : Set.{u_1} T}
  {c : ENNReal} {d : Real} {B : Set.{u_1} T},
  @HasBoundedCoveringNumber.{u_1} T inst A c d →
    @LE.le.{u_1} (Set.{u_1} T) (@Set.instLE.{u_1} T) B A →
      @LE.le.{0} Real Real.instLE (@OfNat.ofNat.{0} Real (nat_lit 0) (@Zero.toOfNat0.{0} Real Real.instZero)) d →
        @HasBoundedCoveringNumber.{u_1} T inst B
          (@HMul.hMul.{0, 0, 0} ENNReal ENNReal ENNReal
            (@instHMul.{0} ENNReal
              (@Distrib.toMul.{0} ENNReal
                (@instDistribOfSemiring.{0} ENNReal (@CommSemiring.toSemiring.{0} ENNReal ENNReal.instCommSemiring))))
            (@HPow.hPow.{0, 0, 0} ENNReal Real ENNReal (@instHPow.{0, 0} ENNReal Real ENNReal.instPowReal)
              (@OfNat.ofNat.{0} ENNReal (nat_lit 2)
                (@instOfNatAtLeastTwo.{0} ENNReal (nat_lit 2)
                  (@AddMonoidWithOne.toNatCast.{0} ENNReal
                    (@AddCommMonoidWithOne.toAddMonoidWithOne.{0} ENNReal ENNReal.instAddCommMonoidWithOne))
                  ⋯))
              d)
            c)
          d :=
⋯
```

## `HolderOnWith.congr_edist`

Command: `#print HolderOnWith.congr_edist`

```lean
theorem HolderOnWith.congr_edist.{u_4, u_5} : ∀ {T : Type u_4} {E : Type u_5} [inst : PseudoEMetricSpace.{u_4} T]
  [inst_1 : PseudoEMetricSpace.{u_5} E] {f g : T → E} {U : Set.{u_4} T} {C β : NNReal},
  (∀ (s t : T),
      @Membership.mem.{u_4, u_4} T (Set.{u_4} T) (@Set.instMembership.{u_4} T) U s →
        @Membership.mem.{u_4, u_4} T (Set.{u_4} T) (@Set.instMembership.{u_4} T) U t →
          @Eq.{1} ENNReal
            (@EDist.edist.{u_5} E
              (@WeakPseudoEMetricSpace.toEDist.{u_5} E
                (@UniformSpace.toTopologicalSpace.{u_5} E (@PseudoEMetricSpace.toUniformSpace.{u_5} E inst_1))
                (@PseudoEMetricSpace.toWeakPseudoEMetricSpace.{u_5} E inst_1))
              (g s) (g t))
            (@EDist.edist.{u_5} E
              (@WeakPseudoEMetricSpace.toEDist.{u_5} E
                (@UniformSpace.toTopologicalSpace.{u_5} E (@PseudoEMetricSpace.toUniformSpace.{u_5} E inst_1))
                (@PseudoEMetricSpace.toWeakPseudoEMetricSpace.{u_5} E inst_1))
              (f s) (f t))) →
    @HolderOnWith.{u_4, u_5} T E inst inst_1 C β f U → @HolderOnWith.{u_4, u_5} T E inst inst_1 C β g U :=
⋯
```

## `HolderOnWith.mono_right'`

Command: `#print HolderOnWith.mono_right'`

```lean
theorem HolderOnWith.mono_right'.{u_3, u_4} : ∀ {X : Type u_3} {Y : Type u_4} [inst : PseudoEMetricSpace.{u_3} X]
  [inst_1 : PseudoEMetricSpace.{u_4} Y] {f : X → Y} {C r s : NNReal} {t : Set.{u_3} X},
  @HolderOnWith.{u_3, u_4} X Y inst inst_1 C r f t →
    @LE.le.{0} NNReal (@Preorder.toLE.{0} NNReal (@PartialOrder.toPreorder.{0} NNReal NNReal.instPartialOrder)) s r →
      ∀ {C' : NNReal},
        (∀ ⦃x : X⦄,
            @Membership.mem.{u_3, u_3} X (Set.{u_3} X) (@Set.instMembership.{u_3} X) t x →
              ∀ ⦃y : X⦄,
                @Membership.mem.{u_3, u_3} X (Set.{u_3} X) (@Set.instMembership.{u_3} X) t y →
                  @LE.le.{0} ENNReal ENNReal.instLE
                    (@EDist.edist.{u_3} X
                      (@WeakPseudoEMetricSpace.toEDist.{u_3} X
                        (@UniformSpace.toTopologicalSpace.{u_3} X (@PseudoEMetricSpace.toUniformSpace.{u_3} X inst))
                        (@PseudoEMetricSpace.toWeakPseudoEMetricSpace.{u_3} X inst))
                      x y)
                    ↑C') →
          ∃ C', @HolderOnWith.{u_3, u_4} X Y inst inst_1 C' s f t :=
⋯
```

## `InnerProductSpace.volume_closedBall_div`

Command: `#print InnerProductSpace.volume_closedBall_div`

```lean
theorem InnerProductSpace.volume_closedBall_div.{u_1} : ∀ {E : Type u_1} [inst : NormedAddCommGroup.{u_1} E]
  [inst_1 :
    @InnerProductSpace.{0, u_1} Real E Real.instRCLike (@NormedAddCommGroup.toSeminormedAddCommGroup.{u_1} E inst)]
  [inst_2 :
    @FiniteDimensional.{0, u_1} Real E Real.instDivisionRing (@NormedAddCommGroup.toAddCommGroup.{u_1} E inst)
      (@NormedSpace.toModule.{0, u_1} Real E Real.normedField
        (@NormedAddCommGroup.toSeminormedAddCommGroup.{u_1} E inst)
        (@InnerProductSpace.toNormedSpace.{0, u_1} Real E Real.instRCLike
          (@NormedAddCommGroup.toSeminormedAddCommGroup.{u_1} E inst) inst_1))]
  [inst_3 : MeasurableSpace.{u_1} E]
  [inst_4 :
    @BorelSpace.{u_1} E
      (@UniformSpace.toTopologicalSpace.{u_1} E
        (@PseudoMetricSpace.toUniformSpace.{u_1} E
          (@SeminormedAddCommGroup.toPseudoMetricSpace.{u_1} E
            (@NormedAddCommGroup.toSeminormedAddCommGroup.{u_1} E inst))))
      inst_3]
  (x y : E) {r s : Real},
  @LT.lt.{0} Real Real.instLT (@OfNat.ofNat.{0} Real (nat_lit 0) (@Zero.toOfNat0.{0} Real Real.instZero)) r →
    @LT.lt.{0} Real Real.instLT (@OfNat.ofNat.{0} Real (nat_lit 0) (@Zero.toOfNat0.{0} Real Real.instZero)) s →
      @Eq.{1} ENNReal
        (@HDiv.hDiv.{0, 0, 0} ENNReal ENNReal ENNReal
          (@instHDiv.{0} ENNReal (@DivInvMonoid.toDiv.{0} ENNReal ENNReal.instDivInvMonoid))
          (@DFunLike.coe.{u_1 + 1, u_1 + 1, 1}
            (@MeasureTheory.Measure.{u_1} E
              (@MeasureTheory.MeasureSpace.toMeasurableSpace.{u_1} E
                (@measureSpaceOfInnerProductSpace.{u_1} E inst inst_1 inst_2 inst_3 inst_4)))
            (Set.{u_1} E) (fun x => ENNReal)
            (@MeasureTheory.Measure.instFunLike.{u_1} E
              (@MeasureTheory.MeasureSpace.toMeasurableSpace.{u_1} E
                (@measureSpaceOfInnerProductSpace.{u_1} E inst inst_1 inst_2 inst_3 inst_4)))
            (@MeasureTheory.MeasureSpace.volume.{u_1} E
              (@measureSpaceOfInnerProductSpace.{u_1} E inst inst_1 inst_2 inst_3 inst_4))
            (@Metric.closedBall.{u_1} E
              (@SeminormedAddCommGroup.toPseudoMetricSpace.{u_1} E
                (@NormedAddCommGroup.toSeminormedAddCommGroup.{u_1} E inst))
              x r))
          (@DFunLike.coe.{u_1 + 1, u_1 + 1, 1}
            (@MeasureTheory.Measure.{u_1} E
              (@MeasureTheory.MeasureSpace.toMeasurableSpace.{u_1} E
                (@measureSpaceOfInnerProductSpace.{u_1} E inst inst_1 inst_2 inst_3 inst_4)))
            (Set.{u_1} E) (fun x => ENNReal)
            (@MeasureTheory.Measure.instFunLike.{u_1} E
              (@MeasureTheory.MeasureSpace.toMeasurableSpace.{u_1} E
                (@measureSpaceOfInnerProductSpace.{u_1} E inst inst_1 inst_2 inst_3 inst_4)))
            (@MeasureTheory.MeasureSpace.volume.{u_1} E
              (@measureSpaceOfInnerProductSpace.{u_1} E inst inst_1 inst_2 inst_3 inst_4))
            (@Metric.closedBall.{u_1} E
              (@SeminormedAddCommGroup.toPseudoMetricSpace.{u_1} E
                (@NormedAddCommGroup.toSeminormedAddCommGroup.{u_1} E inst))
              y s)))
        (@HPow.hPow.{0, 0, 0} ENNReal Nat ENNReal
          (@instHPow.{0, 0} ENNReal Nat
            (@NPow.toPow.{0} ENNReal
              (@Monoid.toNPow.{0} ENNReal
                (@Semiring.toMonoid.{0} ENNReal (@CommSemiring.toSemiring.{0} ENNReal ENNReal.instCommSemiring)))))
          (ENNReal.ofReal
            (@HDiv.hDiv.{0, 0, 0} Real Real Real
              (@instHDiv.{0} Real (@DivInvMonoid.toDiv.{0} Real Real.instDivInvMonoid)) r s))
          (@Module.finrank.{0, u_1} Real E Real.semiring
            (@AddCommGroup.toAddCommMonoid.{u_1} E (@NormedAddCommGroup.toAddCommGroup.{u_1} E inst))
            (@NormedSpace.toModule.{0, u_1} Real E Real.normedField
              (@NormedAddCommGroup.toSeminormedAddCommGroup.{u_1} E inst)
              (@InnerProductSpace.toNormedSpace.{0, u_1} Real E Real.instRCLike
                (@NormedAddCommGroup.toSeminormedAddCommGroup.{u_1} E inst) inst_1)))) :=
⋯
```

## `InnerProductSpace.volume_closedBall_div'`

Command: `#print InnerProductSpace.volume_closedBall_div'`

```lean
theorem InnerProductSpace.volume_closedBall_div'.{u_1} : ∀ {E : Type u_1} [inst : NormedAddCommGroup.{u_1} E]
  [inst_1 :
    @InnerProductSpace.{0, u_1} Real E Real.instRCLike (@NormedAddCommGroup.toSeminormedAddCommGroup.{u_1} E inst)]
  [inst_2 :
    @FiniteDimensional.{0, u_1} Real E Real.instDivisionRing (@NormedAddCommGroup.toAddCommGroup.{u_1} E inst)
      (@NormedSpace.toModule.{0, u_1} Real E Real.normedField
        (@NormedAddCommGroup.toSeminormedAddCommGroup.{u_1} E inst)
        (@InnerProductSpace.toNormedSpace.{0, u_1} Real E Real.instRCLike
          (@NormedAddCommGroup.toSeminormedAddCommGroup.{u_1} E inst) inst_1))]
  [inst_3 : MeasurableSpace.{u_1} E]
  [inst_4 :
    @BorelSpace.{u_1} E
      (@UniformSpace.toTopologicalSpace.{u_1} E
        (@PseudoMetricSpace.toUniformSpace.{u_1} E
          (@SeminormedAddCommGroup.toPseudoMetricSpace.{u_1} E
            (@NormedAddCommGroup.toSeminormedAddCommGroup.{u_1} E inst))))
      inst_3]
  (x y : E) (r s : ENNReal),
  @Eq.{1} ENNReal
    (@HDiv.hDiv.{0, 0, 0} ENNReal ENNReal ENNReal
      (@instHDiv.{0} ENNReal (@DivInvMonoid.toDiv.{0} ENNReal ENNReal.instDivInvMonoid))
      (@DFunLike.coe.{u_1 + 1, u_1 + 1, 1}
        (@MeasureTheory.Measure.{u_1} E
          (@MeasureTheory.MeasureSpace.toMeasurableSpace.{u_1} E
            (@measureSpaceOfInnerProductSpace.{u_1} E inst inst_1 inst_2 inst_3 inst_4)))
        (Set.{u_1} E) (fun x => ENNReal)
        (@MeasureTheory.Measure.instFunLike.{u_1} E
          (@MeasureTheory.MeasureSpace.toMeasurableSpace.{u_1} E
            (@measureSpaceOfInnerProductSpace.{u_1} E inst inst_1 inst_2 inst_3 inst_4)))
        (@MeasureTheory.MeasureSpace.volume.{u_1} E
          (@measureSpaceOfInnerProductSpace.{u_1} E inst inst_1 inst_2 inst_3 inst_4))
        (@Metric.closedEBall.{u_1} E
          (@EMetricSpace.toPseudoEMetricSpace.{u_1} E
            (@MetricSpace.toEMetricSpace.{u_1} E (@NormedAddCommGroup.toMetricSpace.{u_1} E inst)))
          x r))
      (@DFunLike.coe.{u_1 + 1, u_1 + 1, 1}
        (@MeasureTheory.Measure.{u_1} E
          (@MeasureTheory.MeasureSpace.toMeasurableSpace.{u_1} E
            (@measureSpaceOfInnerProductSpace.{u_1} E inst inst_1 inst_2 inst_3 inst_4)))
        (Set.{u_1} E) (fun x => ENNReal)
        (@MeasureTheory.Measure.instFunLike.{u_1} E
          (@MeasureTheory.MeasureSpace.toMeasurableSpace.{u_1} E
            (@measureSpaceOfInnerProductSpace.{u_1} E inst inst_1 inst_2 inst_3 inst_4)))
        (@MeasureTheory.MeasureSpace.volume.{u_1} E
          (@measureSpaceOfInnerProductSpace.{u_1} E inst inst_1 inst_2 inst_3 inst_4))
        (@Metric.closedEBall.{u_1} E
          (@EMetricSpace.toPseudoEMetricSpace.{u_1} E
            (@MetricSpace.toEMetricSpace.{u_1} E (@NormedAddCommGroup.toMetricSpace.{u_1} E inst)))
          y s)))
    (@HPow.hPow.{0, 0, 0} ENNReal Nat ENNReal
      (@instHPow.{0, 0} ENNReal Nat
        (@NPow.toPow.{0} ENNReal
          (@Monoid.toNPow.{0} ENNReal
            (@Semiring.toMonoid.{0} ENNReal (@CommSemiring.toSemiring.{0} ENNReal ENNReal.instCommSemiring)))))
      (@HDiv.hDiv.{0, 0, 0} ENNReal ENNReal ENNReal
        (@instHDiv.{0} ENNReal (@DivInvMonoid.toDiv.{0} ENNReal ENNReal.instDivInvMonoid)) r s)
      (@Module.finrank.{0, u_1} Real E Real.semiring
        (@AddCommGroup.toAddCommMonoid.{u_1} E (@NormedAddCommGroup.toAddCommGroup.{u_1} E inst))
        (@NormedSpace.toModule.{0, u_1} Real E Real.normedField
          (@NormedAddCommGroup.toSeminormedAddCommGroup.{u_1} E inst)
          (@InnerProductSpace.toNormedSpace.{0, u_1} Real E Real.instRCLike
            (@NormedAddCommGroup.toSeminormedAddCommGroup.{u_1} E inst) inst_1)))) :=
⋯
```

## `IsCompactSystem.iInter_eq_empty`

Command: `#print IsCompactSystem.iInter_eq_empty`

```lean
theorem IsCompactSystem.iInter_eq_empty.{u_1} : ∀ {α : Type u_1} {p : Set.{u_1} α → Prop} {C : Nat → Set.{u_1} α}
  (hp : @IsCompactSystem.{u_1} α p) (hC : ∀ (i : Nat), p (C i))
  (hC_empty :
    @Eq.{u_1 + 1} (Set.{u_1} α) (⋂ i, C i)
      (@EmptyCollection.emptyCollection.{u_1} (Set.{u_1} α) (@Set.instEmptyCollection.{u_1} α))),
  @Eq.{u_1 + 1} (Set.{u_1} α)
    (⋂ i, ⋂ (_ : @LE.le.{0} Nat instLENat i (@IsCompactSystem.support.{u_1} α p C hp hC hC_empty)), C i)
    (@EmptyCollection.emptyCollection.{u_1} (Set.{u_1} α) (@Set.instEmptyCollection.{u_1} α)) :=
⋯
```

## `IsCompactSystem.support`

Command: `#print IsCompactSystem.support`

```lean
def IsCompactSystem.support.{u_1} : {α : Type u_1} →
  {p : Set.{u_1} α → Prop} →
    {C : Nat → Set.{u_1} α} →
      @IsCompactSystem.{u_1} α p →
        (∀ (i : Nat), p (C i)) →
          @Eq.{u_1 + 1} (Set.{u_1} α) (⋂ i, C i)
              (@EmptyCollection.emptyCollection.{u_1} (Set.{u_1} α) (@Set.instEmptyCollection.{u_1} α)) →
            Nat :=
fun {α} {p} {C} hp hC hC_empty =>
  @Exists.choose.{1} Nat
    (fun n =>
      @Eq.{u_1 + 1} (Set.{u_1} α) (@Set.dissipate.{0, u_1} Nat α instLENat C n)
        (@EmptyCollection.emptyCollection.{u_1} (Set.{u_1} α) (@Set.instEmptyCollection.{u_1} α)))
    ⋯
```

## `IsCoverWithBoundedCoveringNumber.hasBoundedCoveringNumber`

Command: `#print IsCoverWithBoundedCoveringNumber.hasBoundedCoveringNumber`

```lean
theorem IsCoverWithBoundedCoveringNumber.hasBoundedCoveringNumber.{u_1} : ∀ {T : Type u_1}
  [inst : PseudoEMetricSpace.{u_1} T] {C : Nat → Set.{u_1} T} {A : Set.{u_1} T} {c : Nat → ENNReal} {d : Nat → Real},
  @IsCoverWithBoundedCoveringNumber.{u_1} T inst C A c d →
    ∀ (n : Nat), @HasBoundedCoveringNumber.{u_1} T inst (C n) (c n) (d n) :=
⋯
```

## `IsCoverWithBoundedCoveringNumber.isOpen`

Command: `#print IsCoverWithBoundedCoveringNumber.isOpen`

```lean
theorem IsCoverWithBoundedCoveringNumber.isOpen.{u_1} : ∀ {T : Type u_1} [inst : PseudoEMetricSpace.{u_1} T]
  {C : Nat → Set.{u_1} T} {A : Set.{u_1} T} {c : Nat → ENNReal} {d : Nat → Real},
  @IsCoverWithBoundedCoveringNumber.{u_1} T inst C A c d →
    ∀ (n : Nat),
      @IsOpen.{u_1} T (@UniformSpace.toTopologicalSpace.{u_1} T (@PseudoEMetricSpace.toUniformSpace.{u_1} T inst))
        (C n) :=
⋯
```

## `IsCoverWithBoundedCoveringNumber.mk`

Command: `#print IsCoverWithBoundedCoveringNumber.mk`

```lean
constructor IsCoverWithBoundedCoveringNumber.mk.{u_1} : ∀ {T : Type u_1} [inst : PseudoEMetricSpace.{u_1} T]
  {C : Nat → Set.{u_1} T} {A : Set.{u_1} T} {c : Nat → ENNReal} {d : Nat → Real},
  (∀ (n : Nat), @Ne.{1} ENNReal (c n) (@Top.top.{0} ENNReal ENNReal.instTop)) →
    (∀ (n : Nat),
        @LT.lt.{0} Real Real.instLT (@OfNat.ofNat.{0} Real (nat_lit 0) (@Zero.toOfNat0.{0} Real Real.instZero)) (d n)) →
      (∀ (n : Nat),
          @IsOpen.{u_1} T (@UniformSpace.toTopologicalSpace.{u_1} T (@PseudoEMetricSpace.toUniformSpace.{u_1} T inst))
            (C n)) →
        (∀ (n : Nat), @TotallyBounded.{u_1} T (@PseudoEMetricSpace.toUniformSpace.{u_1} T inst) (C n)) →
          (∀ (n : Nat), @HasBoundedCoveringNumber.{u_1} T inst (C n) (c n) (d n)) →
            (∀ (n m : Nat),
                @LE.le.{0} Nat instLENat n m → @LE.le.{u_1} (Set.{u_1} T) (@Set.instLE.{u_1} T) (C n) (C m)) →
              @LE.le.{u_1} (Set.{u_1} T) (@Set.instLE.{u_1} T) A (⋃ i, C i) →
                @IsCoverWithBoundedCoveringNumber.{u_1} T inst C A c d
```

## `IsCoverWithBoundedCoveringNumber.mono`

Command: `#print IsCoverWithBoundedCoveringNumber.mono`

```lean
theorem IsCoverWithBoundedCoveringNumber.mono.{u_1} : ∀ {T : Type u_1} [inst : PseudoEMetricSpace.{u_1} T]
  {C : Nat → Set.{u_1} T} {A : Set.{u_1} T} {c : Nat → ENNReal} {d : Nat → Real},
  @IsCoverWithBoundedCoveringNumber.{u_1} T inst C A c d →
    ∀ (n m : Nat), @LE.le.{0} Nat instLENat n m → @LE.le.{u_1} (Set.{u_1} T) (@Set.instLE.{u_1} T) (C n) (C m) :=
⋯
```

## `IsCoverWithBoundedCoveringNumber.subset_iUnion`

Command: `#print IsCoverWithBoundedCoveringNumber.subset_iUnion`

```lean
theorem IsCoverWithBoundedCoveringNumber.subset_iUnion.{u_1} : ∀ {T : Type u_1} [inst : PseudoEMetricSpace.{u_1} T]
  {C : Nat → Set.{u_1} T} {A : Set.{u_1} T} {c : Nat → ENNReal} {d : Nat → Real},
  @IsCoverWithBoundedCoveringNumber.{u_1} T inst C A c d →
    @LE.le.{u_1} (Set.{u_1} T) (@Set.instLE.{u_1} T) A (⋃ i, C i) :=
⋯
```

## `L2.posSemidef_interMatrix`

Command: `#print L2.posSemidef_interMatrix`

```lean
theorem L2.posSemidef_interMatrix.{u_1, u_2} : ∀ {ι : Type u_1} [Finite.{u_1 + 1} ι] {α : Type u_2}
  {mα : MeasurableSpace.{u_2} α} {μ : @MeasureTheory.Measure.{u_2} α mα} {v : ι → Set.{u_2} α},
  (∀ (j : ι), @MeasurableSet.{u_2} α mα (v j)) →
    autoParam.{0}
        (∀ (j : ι),
          @Ne.{1} ENNReal
            (@DFunLike.coe.{u_2 + 1, u_2 + 1, 1} (@MeasureTheory.Measure.{u_2} α mα) (Set.{u_2} α) (fun x => ENNReal)
              (@MeasureTheory.Measure.instFunLike.{u_2} α mα) μ (v j))
            (@Top.top.{0} ENNReal ENNReal.instTop))
        L2.posSemidef_interMatrix._auto_1 →
      @Matrix.PosSemidef.{u_1, 0} ι Real Real.instRing Real.partialOrder instStarRingReal
        (@DFunLike.coe.{max (u_1 + 1) 1, max (u_1 + 1) 1, max (u_1 + 1) 1}
          (Equiv.{max (u_1 + 1) 1, max 1 (u_1 + 1)} (ι → ι → Real) (Matrix.{u_1, u_1, 0} ι ι Real)) (ι → ι → Real)
          (fun x => Matrix.{u_1, u_1, 0} ι ι Real)
          (@EquivLike.toFunLike.{max (u_1 + 1) 1, max (u_1 + 1) 1, max (u_1 + 1) 1}
            (Equiv.{max (u_1 + 1) 1, max 1 (u_1 + 1)} (ι → ι → Real) (Matrix.{u_1, u_1, 0} ι ι Real)) (ι → ι → Real)
            (Matrix.{u_1, u_1, 0} ι ι Real)
            (@Equiv.instEquivLike.{max (u_1 + 1) 1, max (u_1 + 1) 1} (ι → ι → Real) (Matrix.{u_1, u_1, 0} ι ι Real)))
          (@Matrix.of.{0, u_1, u_1} ι ι Real) fun i j =>
          @MeasureTheory.Measure.real.{u_2} α mα μ
            (@Inter.inter.{u_2} (Set.{u_2} α) (@Set.instInter.{u_2} α) (v i) (v j))) :=
⋯
```

## `MathFin.gbmValue`

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

## `Measurable.measurableSet_edist_eqOn_zero_of_continuous`

Command: `#print Measurable.measurableSet_edist_eqOn_zero_of_continuous`

```lean
theorem Measurable.measurableSet_edist_eqOn_zero_of_continuous.{u_1, u_2, u_3} : ∀ {T : Type u_1} {Ω : Type u_2}
  {E : Type u_3} {mΩ : MeasurableSpace.{u_2} Ω} {U : Set.{u_1} T} [inst : PseudoEMetricSpace.{u_1} T]
  [inst_1 : PseudoEMetricSpace.{u_3} E]
  [@SecondCountableTopology.{u_1} T
      (@UniformSpace.toTopologicalSpace.{u_1} T (@PseudoEMetricSpace.toUniformSpace.{u_1} T inst))]
  {f g : T → Ω → E},
  @IsOpen.{u_1} T (@UniformSpace.toTopologicalSpace.{u_1} T (@PseudoEMetricSpace.toUniformSpace.{u_1} T inst)) U →
    (∀ (ω : Ω),
        @ContinuousOn.{u_1, u_3} T E
          (@UniformSpace.toTopologicalSpace.{u_1} T (@PseudoEMetricSpace.toUniformSpace.{u_1} T inst))
          (@UniformSpace.toTopologicalSpace.{u_3} E (@PseudoEMetricSpace.toUniformSpace.{u_3} E inst_1))
          (fun x => f x ω) U) →
      (∀ (ω : Ω),
          @ContinuousOn.{u_1, u_3} T E
            (@UniformSpace.toTopologicalSpace.{u_1} T (@PseudoEMetricSpace.toUniformSpace.{u_1} T inst))
            (@UniformSpace.toTopologicalSpace.{u_3} E (@PseudoEMetricSpace.toUniformSpace.{u_3} E inst_1))
            (fun x => g x ω) U) →
        (∀ (t : T),
            @Measurable.{u_2, 0} Ω ENNReal mΩ ENNReal.measurableSpace fun ω =>
              @EDist.edist.{u_3} E
                (@WeakPseudoEMetricSpace.toEDist.{u_3} E
                  (@UniformSpace.toTopologicalSpace.{u_3} E (@PseudoEMetricSpace.toUniformSpace.{u_3} E inst_1))
                  (@PseudoEMetricSpace.toWeakPseudoEMetricSpace.{u_3} E inst_1))
                (f t ω) (g t ω)) →
          @MeasurableSet.{u_2} Ω mΩ
            (@setOf.{u_2} Ω fun ω =>
              ∀ (t : T),
                @Membership.mem.{u_1, u_1} T (Set.{u_1} T) (@Set.instMembership.{u_1} T) U t →
                  @Eq.{1} ENNReal
                    (@EDist.edist.{u_3} E
                      (@WeakPseudoEMetricSpace.toEDist.{u_3} E
                        (@UniformSpace.toTopologicalSpace.{u_3} E (@PseudoEMetricSpace.toUniformSpace.{u_3} E inst_1))
                        (@PseudoEMetricSpace.toWeakPseudoEMetricSpace.{u_3} E inst_1))
                      (f t ω) (g t ω))
                    (@OfNat.ofNat.{0} ENNReal (nat_lit 0) (@Zero.toOfNat0.{0} ENNReal ENNReal.instZero))) :=
⋯
```

## `Measurable.measurableSet_edist_eq_zero_of_continuous`

Command: `#print Measurable.measurableSet_edist_eq_zero_of_continuous`

```lean
theorem Measurable.measurableSet_edist_eq_zero_of_continuous.{u_1, u_2, u_3} : ∀ {T : Type u_1} {Ω : Type u_2}
  {E : Type u_3} {mΩ : MeasurableSpace.{u_2} Ω} [inst : PseudoEMetricSpace.{u_1} T]
  [inst_1 : PseudoEMetricSpace.{u_3} E]
  [@SecondCountableTopology.{u_1} T
      (@UniformSpace.toTopologicalSpace.{u_1} T (@PseudoEMetricSpace.toUniformSpace.{u_1} T inst))]
  {f g : T → Ω → E},
  (∀ (ω : Ω),
      @Continuous.{u_1, u_3} T E
        (@UniformSpace.toTopologicalSpace.{u_1} T (@PseudoEMetricSpace.toUniformSpace.{u_1} T inst))
        (@UniformSpace.toTopologicalSpace.{u_3} E (@PseudoEMetricSpace.toUniformSpace.{u_3} E inst_1)) fun x => f x ω) →
    (∀ (ω : Ω),
        @Continuous.{u_1, u_3} T E
          (@UniformSpace.toTopologicalSpace.{u_1} T (@PseudoEMetricSpace.toUniformSpace.{u_1} T inst))
          (@UniformSpace.toTopologicalSpace.{u_3} E (@PseudoEMetricSpace.toUniformSpace.{u_3} E inst_1)) fun x =>
          g x ω) →
      (∀ (t : T),
          @Measurable.{u_2, 0} Ω ENNReal mΩ ENNReal.measurableSpace fun ω =>
            @EDist.edist.{u_3} E
              (@WeakPseudoEMetricSpace.toEDist.{u_3} E
                (@UniformSpace.toTopologicalSpace.{u_3} E (@PseudoEMetricSpace.toUniformSpace.{u_3} E inst_1))
                (@PseudoEMetricSpace.toWeakPseudoEMetricSpace.{u_3} E inst_1))
              (f t ω) (g t ω)) →
        @MeasurableSet.{u_2} Ω mΩ
          (@setOf.{u_2} Ω fun ω =>
            ∀ (t : T),
              @Eq.{1} ENNReal
                (@EDist.edist.{u_3} E
                  (@WeakPseudoEMetricSpace.toEDist.{u_3} E
                    (@UniformSpace.toTopologicalSpace.{u_3} E (@PseudoEMetricSpace.toUniformSpace.{u_3} E inst_1))
                    (@PseudoEMetricSpace.toWeakPseudoEMetricSpace.{u_3} E inst_1))
                  (f t ω) (g t ω))
                (@OfNat.ofNat.{0} ENNReal (nat_lit 0) (@Zero.toOfNat0.{0} ENNReal ENNReal.instZero))) :=
⋯
```

## `Measurable.of_edist_eq_zero`

Command: `#print Measurable.of_edist_eq_zero`

```lean
theorem Measurable.of_edist_eq_zero.{u_1, u_2} : ∀ {Ω : Type u_1} {E : Type u_2} {mΩ : MeasurableSpace.{u_1} Ω}
  [inst : PseudoEMetricSpace.{u_2} E] [inst_1 : MeasurableSpace.{u_2} E]
  [@BorelSpace.{u_2} E (@UniformSpace.toTopologicalSpace.{u_2} E (@PseudoEMetricSpace.toUniformSpace.{u_2} E inst))
      inst_1]
  {X Y : Ω → E},
  @Measurable.{u_1, u_2} Ω E mΩ inst_1 X →
    (∀ (ω : Ω),
        @Eq.{1} ENNReal
          (@EDist.edist.{u_2} E
            (@WeakPseudoEMetricSpace.toEDist.{u_2} E
              (@UniformSpace.toTopologicalSpace.{u_2} E (@PseudoEMetricSpace.toUniformSpace.{u_2} E inst))
              (@PseudoEMetricSpace.toWeakPseudoEMetricSpace.{u_2} E inst))
            (Y ω) (X ω))
          (@OfNat.ofNat.{0} ENNReal (nat_lit 0) (@Zero.toOfNat0.{0} ENNReal ENNReal.instZero))) →
      @Measurable.{u_1, u_2} Ω E mΩ inst_1 Y :=
⋯
```

## `MeasurableEquiv.coe_toLp_symm_eq`

Command: `#print MeasurableEquiv.coe_toLp_symm_eq`

```lean
@[defeq] theorem MeasurableEquiv.coe_toLp_symm_eq.{u_1} : ∀ {ι : Type u_1},
  @Eq.{u_1 + 1}
    (WithLp.{u_1}
        (@OfNat.ofNat.{0} ENNReal (nat_lit 2)
          (@instOfNatAtLeastTwo.{0} ENNReal (nat_lit 2)
            (@AddMonoidWithOne.toNatCast.{0} ENNReal
              (@AddCommMonoidWithOne.toAddMonoidWithOne.{0} ENNReal ENNReal.instAddCommMonoidWithOne))
            ⋯))
        (ι → Real) →
      ι → Real)
    (@DFunLike.coe.{u_1 + 1, u_1 + 1, u_1 + 1}
      (@MeasurableEquiv.{u_1, u_1}
        (WithLp.{u_1}
          (@OfNat.ofNat.{0} ENNReal (nat_lit 2)
            (@instOfNatAtLeastTwo.{0} ENNReal (nat_lit 2)
              (@AddMonoidWithOne.toNatCast.{0} ENNReal
                (@AddCommMonoidWithOne.toAddMonoidWithOne.{0} ENNReal ENNReal.instAddCommMonoidWithOne))
              ⋯))
          (ι → Real))
        (ι → Real)
        (@WithLp.measurableSpace.{u_1}
          (@OfNat.ofNat.{0} ENNReal (nat_lit 2)
            (@instOfNatAtLeastTwo.{0} ENNReal (nat_lit 2)
              (@AddMonoidWithOne.toNatCast.{0} ENNReal
                (@AddCommMonoidWithOne.toAddMonoidWithOne.{0} ENNReal ENNReal.instAddCommMonoidWithOne))
              ⋯))
          (ι → Real) (@MeasurableSpace.pi.{u_1, 0} ι (fun a => Real) fun a => Real.measurableSpace))
        (@MeasurableSpace.pi.{u_1, 0} ι (fun a => Real) fun a => Real.measurableSpace))
      (WithLp.{u_1}
        (@OfNat.ofNat.{0} ENNReal (nat_lit 2)
          (@instOfNatAtLeastTwo.{0} ENNReal (nat_lit 2)
            (@AddMonoidWithOne.toNatCast.{0} ENNReal
              (@AddCommMonoidWithOne.toAddMonoidWithOne.{0} ENNReal ENNReal.instAddCommMonoidWithOne))
            ⋯))
        (ι → Real))
      (fun x => ι → Real)
      (@EquivLike.toFunLike.{u_1 + 1, u_1 + 1, u_1 + 1}
        (@MeasurableEquiv.{u_1, u_1}
          (WithLp.{u_1}
            (@OfNat.ofNat.{0} ENNReal (nat_lit 2)
              (@instOfNatAtLeastTwo.{0} ENNReal (nat_lit 2)
                (@AddMonoidWithOne.toNatCast.{0} ENNReal
                  (@AddCommMonoidWithOne.toAddMonoidWithOne.{0} ENNReal ENNReal.instAddCommMonoidWithOne))
                ⋯))
            (ι → Real))
          (ι → Real)
          (@WithLp.measurableSpace.{u_1}
            (@OfNat.ofNat.{0} ENNReal (nat_lit 2)
              (@instOfNatAtLeastTwo.{0} ENNReal (nat_lit 2)
                (@AddMonoidWithOne.toNatCast.{0} ENNReal
                  (@AddCommMonoidWithOne.toAddMonoidWithOne.{0} ENNReal ENNReal.instAddCommMonoidWithOne))
                ⋯))
            (ι → Real) (@MeasurableSpace.pi.{u_1, 0} ι (fun a => Real) fun a => Real.measurableSpace))
          (@MeasurableSpace.pi.{u_1, 0} ι (fun a => Real) fun a => Real.measurableSpace))
        (WithLp.{u_1}
          (@OfNat.ofNat.{0} ENNReal (nat_lit 2)
            (@instOfNatAtLeastTwo.{0} ENNReal (nat_lit 2)
              (@AddMonoidWithOne.toNatCast.{0} ENNReal
                (@AddCommMonoidWithOne.toAddMonoidWithOne.{0} ENNReal ENNReal.instAddCommMonoidWithOne))
              ⋯))
          (ι → Real))
        (ι → Real)
        (@MeasurableEquiv.instEquivLike.{u_1, u_1}
          (WithLp.{u_1}
            (@OfNat.ofNat.{0} ENNReal (nat_lit 2)
              (@instOfNatAtLeastTwo.{0} ENNReal (nat_lit 2)
                (@AddMonoidWithOne.toNatCast.{0} ENNReal
                  (@AddCommMonoidWithOne.toAddMonoidWithOne.{0} ENNReal ENNReal.instAddCommMonoidWithOne))
                ⋯))
            (ι → Real))
          (ι → Real)
          (@WithLp.measurableSpace.{u_1}
            (@OfNat.ofNat.{0} ENNReal (nat_lit 2)
              (@instOfNatAtLeastTwo.{0} ENNReal (nat_lit 2)
                (@AddMonoidWithOne.toNatCast.{0} ENNReal
                  (@AddCommMonoidWithOne.toAddMonoidWithOne.{0} ENNReal ENNReal.instAddCommMonoidWithOne))
                ⋯))
            (ι → Real) (@MeasurableSpace.pi.{u_1, 0} ι (fun a => Real) fun a => Real.measurableSpace))
          (@MeasurableSpace.pi.{u_1, 0} ι (fun a => Real) fun a => Real.measurableSpace)))
      (@MeasurableEquiv.symm.{u_1, u_1} (ι → Real)
        (WithLp.{u_1}
          (@OfNat.ofNat.{0} ENNReal (nat_lit 2)
            (@instOfNatAtLeastTwo.{0} ENNReal (nat_lit 2)
              (@AddMonoidWithOne.toNatCast.{0} ENNReal
                (@AddCommMonoidWithOne.toAddMonoidWithOne.{0} ENNReal ENNReal.instAddCommMonoidWithOne))
              ⋯))
          (ι → Real))
        (@MeasurableSpace.pi.{u_1, 0} ι (fun a => Real) fun a => Real.measurableSpace)
        (@WithLp.measurableSpace.{u_1}
          (@OfNat.ofNat.{0} ENNReal (nat_lit 2)
            (@instOfNatAtLeastTwo.{0} ENNReal (nat_lit 2)
              (@AddMonoidWithOne.toNatCast.{0} ENNReal
                (@AddCommMonoidWithOne.toAddMonoidWithOne.{0} ENNReal ENNReal.instAddCommMonoidWithOne))
              ⋯))
          (ι → Real) (@MeasurableSpace.pi.{u_1, 0} ι (fun a => Real) fun a => Real.measurableSpace))
        (@MeasurableEquiv.toLp.{u_1}
          (@OfNat.ofNat.{0} ENNReal (nat_lit 2)
            (@instOfNatAtLeastTwo.{0} ENNReal (nat_lit 2)
              (@AddMonoidWithOne.toNatCast.{0} ENNReal
                (@AddCommMonoidWithOne.toAddMonoidWithOne.{0} ENNReal ENNReal.instAddCommMonoidWithOne))
              ⋯))
          (ι → Real) (@MeasurableSpace.pi.{u_1, 0} ι (fun a => Real) fun a => Real.measurableSpace))))
    (@DFunLike.coe.{u_1 + 1, u_1 + 1, u_1 + 1}
      (@ContinuousLinearEquiv.{0, 0, u_1, u_1} Real Real
        (@DivisionSemiring.toSemiring.{0} Real
          (@Semifield.toDivisionSemiring.{0} Real
            (@Field.toSemifield.{0} Real
              (@NormedField.toField.{0} Real
                (@DenselyNormedField.toNormedField.{0} Real (@RCLike.toDenselyNormedField.{0} Real Real.instRCLike))))))
        (@DivisionSemiring.toSemiring.{0} Real
          (@Semifield.toDivisionSemiring.{0} Real
            (@Field.toSemifield.{0} Real
              (@NormedField.toField.{0} Real
                (@DenselyNormedField.toNormedField.{0} Real (@RCLike.toDenselyNormedField.{0} Real Real.instRCLike))))))
        (@RingHom.id.{0} Real
          (@Semiring.toNonAssocSemiring.{0} Real
            (@DivisionSemiring.toSemiring.{0} Real
              (@Semifield.toDivisionSemiring.{0} Real
                (@Field.toSemifield.{0} Real
                  (@NormedField.toField.{0} Real
                    (@DenselyNormedField.toNormedField.{0} Real
                      (@RCLike.toDenselyNormedField.{0} Real Real.instRCLike))))))))
        (@RingHom.id.{0} Real
          (@Semiring.toNonAssocSemiring.{0} Real
            (@DivisionSemiring.toSemiring.{0} Real
              (@Semifield.toDivisionSemiring.{0} Real
                (@Field.toSemifield.{0} Real
                  (@NormedField.toField.{0} Real
                    (@DenselyNormedField.toNormedField.{0} Real
                      (@RCLike.toDenselyNormedField.{0} Real Real.instRCLike))))))))
        ⋯ ⋯ (EuclideanSpace.{0, u_1} Real ι)
        (@PiLp.topologicalSpace.{u_1, 0}
          (@OfNat.ofNat.{0} ENNReal (nat_lit 2)
            (@instOfNatAtLeastTwo.{0} ENNReal (nat_lit 2)
              (@AddMonoidWithOne.toNatCast.{0} ENNReal
                (@AddCommMonoidWithOne.toAddMonoidWithOne.{0} ENNReal ENNReal.instAddCommMonoidWithOne))
              PiLp.innerProductSpace._proof_1))
          ι (fun x => Real) fun i =>
          @UniformSpace.toTopologicalSpace.{0} Real
            (@PseudoMetricSpace.toUniformSpace.{0} Real
              (@SeminormedRing.toPseudoMetricSpace.{0} Real
                (@SeminormedCommRing.toSeminormedRing.{0} Real
                  (@NormedCommRing.toSeminormedCommRing.{0} Real
                    (@NormedField.toNormedCommRing.{0} Real
                      (@DenselyNormedField.toNormedField.{0} Real
                        (@RCLike.toDenselyNormedField.{0} Real Real.instRCLike))))))))
        (@AddCommGroup.toAddCommMonoid.{u_1} (EuclideanSpace.{0, u_1} Real ι)
          (@WithLp.instAddCommGroup.{u_1}
            (@OfNat.ofNat.{0} ENNReal (nat_lit 2)
              (@instOfNatAtLeastTwo.{0} ENNReal (nat_lit 2)
                (@AddMonoidWithOne.toNatCast.{0} ENNReal
                  (@AddCommMonoidWithOne.toAddMonoidWithOne.{0} ENNReal ENNReal.instAddCommMonoidWithOne))
                PiLp.innerProductSpace._proof_1))
            ((i : ι) → (fun x => Real) i)
            (@Pi.addCommGroup.{u_1, 0} ι (fun x => Real) fun i =>
              @Ring.toAddCommGroup.{0} Real
                (@DivisionRing.toRing.{0} Real
                  (@Field.toDivisionRing.{0} Real
                    (@NormedField.toField.{0} Real
                      (@DenselyNormedField.toNormedField.{0} Real
                        (@RCLike.toDenselyNormedField.{0} Real Real.instRCLike))))))))
        (ι → Real)
        (@Pi.topologicalSpace.{0, u_1} ι (fun a => Real) fun i =>
          @UniformSpace.toTopologicalSpace.{0} Real
            (@PseudoMetricSpace.toUniformSpace.{0} Real
              (@SeminormedRing.toPseudoMetricSpace.{0} Real
                (@SeminormedCommRing.toSeminormedRing.{0} Real
                  (@NormedCommRing.toSeminormedCommRing.{0} Real
                    (@NormedField.toNormedCommRing.{0} Real
                      (@DenselyNormedField.toNormedField.{0} Real
                        (@RCLike.toDenselyNormedField.{0} Real Real.instRCLike))))))))
        (@Pi.addCommMonoid.{u_1, 0} ι (fun a => Real) fun i =>
          @Semiring.toAddCommMonoid.{0} Real
            (@DivisionSemiring.toSemiring.{0} Real
              (@Semifield.toDivisionSemiring.{0} Real
                (@Field.toSemifield.{0} Real
                  (@NormedField.toField.{0} Real
                    (@DenselyNormedField.toNormedField.{0} Real
                      (@RCLike.toDenselyNormedField.{0} Real Real.instRCLike)))))))
        (@WithLp.instModule.{0, u_1}
          (@OfNat.ofNat.{0} ENNReal (nat_lit 2)
            (@instOfNatAtLeastTwo.{0} ENNReal (nat_lit 2)
              (@AddMonoidWithOne.toNatCast.{0} ENNReal
                (@AddCommMonoidWithOne.toAddMonoidWithOne.{0} ENNReal ENNReal.instAddCommMonoidWithOne))
              PiLp.innerProductSpace._proof_1))
          Real ((i : ι) → (fun x => Real) i)
          (@DivisionSemiring.toSemiring.{0} Real
            (@Semifield.toDivisionSemiring.{0} Real
              (@Field.toSemifield.{0} Real
                (@NormedField.toField.{0} Real
                  (@DenselyNormedField.toNormedField.{0} Real
                    (@RCLike.toDenselyNormedField.{0} Real Real.instRCLike))))))
          (@Pi.addCommGroup.{u_1, 0} ι (fun x => Real) fun i =>
            @Ring.toAddCommGroup.{0} Real
              (@DivisionRing.toRing.{0} Real
                (@Field.toDivisionRing.{0} Real
                  (@NormedField.toField.{0} Real
                    (@DenselyNormedField.toNormedField.{0} Real
                      (@RCLike.toDenselyNormedField.{0} Real Real.instRCLike))))))
          (@Pi.Function.module.{u_1, 0, 0} ι Real Real
            (@DivisionSemiring.toSemiring.{0} Real
              (@Semifield.toDivisionSemiring.{0} Real
                (@Field.toSemifield.{0} Real
                  (@NormedField.toField.{0} Real
                    (@DenselyNormedField.toNormedField.{0} Real
                      (@RCLike.toDenselyNormedField.{0} Real Real.instRCLike))))))
            (@Semiring.toAddCommMonoid.{0} Real
              (@Ring.toSemiring.{0} Real
                (@DivisionRing.toRing.{0} Real
                  (@Field.toDivisionRing.{0} Real
                    (@NormedField.toField.{0} Real
                      (@DenselyNormedField.toNormedField.{0} Real
                        (@RCLike.toDenselyNormedField.{0} Real Real.instRCLike)))))))
            (@Semiring.toModule.{0} Real
              (@DivisionSemiring.toSemiring.{0} Real
                (@Semifield.toDivisionSemiring.{0} Real
                  (@Field.toSemifield.{0} Real
                    (@NormedField.toField.{0} Real
                      (@DenselyNormedField.toNormedField.{0} Real
                        (@RCLike.toDenselyNormedField.{0} Real Real.instRCLike)))))))))
        (@Pi.Function.module.{u_1, 0, 0} ι Real Real
          (@DivisionSemiring.toSemiring.{0} Real
            (@Semifield.toDivisionSemiring.{0} Real
              (@Field.toSemifield.{0} Real
                (@NormedField.toField.{0} Real
                  (@DenselyNormedField.toNormedField.{0} Real
                    (@RCLike.toDenselyNormedField.{0} Real Real.instRCLike))))))
          (@Semiring.toAddCommMonoid.{0} Real
            (@DivisionSemiring.toSemiring.{0} Real
              (@Semifield.toDivisionSemiring.{0} Real
                (@Field.toSemifield.{0} Real
                  (@NormedField.toField.{0} Real
                    (@DenselyNormedField.toNormedField.{0} Real
                      (@RCLike.toDenselyNormedField.{0} Real Real.instRCLike)))))))
          (@Semiring.toModule.{0} Real
            (@DivisionSemiring.toSemiring.{0} Real
              (@Semifield.toDivisionSemiring.{0} Real
                (@Field.toSemifield.{0} Real
                  (@NormedField.toField.{0} Real
                    (@DenselyNormedField.toNormedField.{0} Real
                      (@RCLike.toDenselyNormedField.{0} Real Real.instRCLike)))))))))
      (EuclideanSpace.{0, u_1} Real ι) (fun x => ι → Real)
      (@EquivLike.toFunLike.{u_1 + 1, u_1 + 1, u_1 + 1}
        (@ContinuousLinearEquiv.{0, 0, u_1, u_1} Real Real
          (@DivisionSemiring.toSemiring.{0} Real
            (@Semifield.toDivisionSemiring.{0} Real
              (@Field.toSemifield.{0} Real
                (@NormedField.toField.{0} Real
                  (@DenselyNormedField.toNormedField.{0} Real
                    (@RCLike.toDenselyNormedField.{0} Real Real.instRCLike))))))
          (@DivisionSemiring.toSemiring.{0} Real
            (@Semifield.toDivisionSemiring.{0} Real
              (@Field.toSemifield.{0} Real
                (@NormedField.toField.{0} Real
                  (@DenselyNormedField.toNormedField.{0} Real
                    (@RCLike.toDenselyNormedField.{0} Real Real.instRCLike))))))
          (@RingHom.id.{0} Real
            (@Semiring.toNonAssocSemiring.{0} Real
              (@DivisionSemiring.toSemiring.{0} Real
                (@Semifield.toDivisionSemiring.{0} Real
                  (@Field.toSemifield.{0} Real
                    (@NormedField.toField.{0} Real
                      (@DenselyNormedField.toNormedField.{0} Real
                        (@RCLike.toDenselyNormedField.{0} Real Real.instRCLike))))))))
          (@RingHom.id.{0} Real
            (@Semiring.toNonAssocSemiring.{0} Real
              (@DivisionSemiring.toSemiring.{0} Real
                (@Semifield.toDivisionSemiring.{0} Real
                  (@Field.toSemifield.{0} Real
                    (@NormedField.toField.{0} Real
                      (@DenselyNormedField.toNormedField.{0} Real
                        (@RCLike.toDenselyNormedField.{0} Real Real.instRCLike))))))))
          ⋯ ⋯ (EuclideanSpace.{0, u_1} Real ι)
          (@PiLp.topologicalSpace.{u_1, 0}
            (@OfNat.ofNat.{0} ENNReal (nat_lit 2)
              (@instOfNatAtLeastTwo.{0} ENNReal (nat_lit 2)
                (@AddMonoidWithOne.toNatCast.{0} ENNReal
                  (@AddCommMonoidWithOne.toAddMonoidWithOne.{0} ENNReal ENNReal.instAddCommMonoidWithOne))
                PiLp.innerProductSpace._proof_1))
            ι (fun x => Real) fun i =>
            @UniformSpace.toTopologicalSpace.{0} Real
              (@PseudoMetricSpace.toUniformSpace.{0} Real
                (@SeminormedRing.toPseudoMetricSpace.{0} Real
                  (@SeminormedCommRing.toSeminormedRing.{0} Real
                    (@NormedCommRing.toSeminormedCommRing.{0} Real
                      (@NormedField.toNormedCommRing.{0} Real
                        (@DenselyNormedField.toNormedField.{0} Real
                          (@RCLike.toDenselyNormedField.{0} Real Real.instRCLike))))))))
          (@AddCommGroup.toAddCommMonoid.{u_1} (EuclideanSpace.{0, u_1} Real ι)
            (@WithLp.instAddCommGroup.{u_1}
              (@OfNat.ofNat.{0} ENNReal (nat_lit 2)
                (@instOfNatAtLeastTwo.{0} ENNReal (nat_lit 2)
                  (@AddMonoidWithOne.toNatCast.{0} ENNReal
                    (@AddCommMonoidWithOne.toAddMonoidWithOne.{0} ENNReal ENNReal.instAddCommMonoidWithOne))
                  PiLp.innerProductSpace._proof_1))
              ((i : ι) → (fun x => Real) i)
              (@Pi.addCommGroup.{u_1, 0} ι (fun x => Real) fun i =>
                @Ring.toAddCommGroup.{0} Real
                  (@DivisionRing.toRing.{0} Real
                    (@Field.toDivisionRing.{0} Real
                      (@NormedField.toField.{0} Real
                        (@DenselyNormedField.toNormedField.{0} Real
                          (@RCLike.toDenselyNormedField.{0} Real Real.instRCLike))))))))
          (ι → Real)
          (@Pi.topologicalSpace.{0, u_1} ι (fun a => Real) fun i =>
            @UniformSpace.toTopologicalSpace.{0} Real
              (@PseudoMetricSpace.toUniformSpace.{0} Real
                (@SeminormedRing.toPseudoMetricSpace.{0} Real
                  (@SeminormedCommRing.toSeminormedRing.{0} Real
                    (@NormedCommRing.toSeminormedCommRing.{0} Real
                      (@NormedField.toNormedCommRing.{0} Real
                        (@DenselyNormedField.toNormedField.{0} Real
                          (@RCLike.toDenselyNormedField.{0} Real Real.instRCLike))))))))
          (@Pi.addCommMonoid.{u_1, 0} ι (fun a => Real) fun i =>
            @Semiring.toAddCommMonoid.{0} Real
              (@DivisionSemiring.toSemiring.{0} Real
                (@Semifield.toDivisionSemiring.{0} Real
                  (@Field.toSemifield.{0} Real
                    (@NormedField.toField.{0} Real
                      (@DenselyNormedField.toNormedField.{0} Real
                        (@RCLike.toDenselyNormedField.{0} Real Real.instRCLike)))))))
          (@WithLp.instModule.{0, u_1}
            (@OfNat.ofNat.{0} ENNReal (nat_lit 2)
              (@instOfNatAtLeastTwo.{0} ENNReal (nat_lit 2)
                (@AddMonoidWithOne.toNatCast.{0} ENNReal
                  (@AddCommMonoidWithOne.toAddMonoidWithOne.{0} ENNReal ENNReal.instAddCommMonoidWithOne))
                PiLp.innerProductSpace._proof_1))
            Real ((i : ι) → (fun x => Real) i)
            (@DivisionSemiring.toSemiring.{0} Real
              (@Semifield.toDivisionSemiring.{0} Real
                (@Field.toSemifield.{0} Real
                  (@NormedField.toField.{0} Real
                    (@DenselyNormedField.toNormedField.{0} Real
                      (@RCLike.toDenselyNormedField.{0} Real Real.instRCLike))))))
            (@Pi.addCommGroup.{u_1, 0} ι (fun x => Real) fun i =>
              @Ring.toAddCommGroup.{0} Real
                (@DivisionRing.toRing.{0} Real
                  (@Field.toDivisionRing.{0} Real
                    (@NormedField.toField.{0} Real
                      (@DenselyNormedField.toNormedField.{0} Real
                        (@RCLike.toDenselyNormedField.{0} Real Real.instRCLike))))))
            (@Pi.Function.module.{u_1, 0, 0} ι Real Real
              (@DivisionSemiring.toSemiring.{0} Real
                (@Semifield.toDivisionSemiring.{0} Real
                  (@Field.toSemifield.{0} Real
                    (@NormedField.toField.{0} Real
                      (@DenselyNormedField.toNormedField.{0} Real
                        (@RCLike.toDenselyNormedField.{0} Real Real.instRCLike))))))
              (@Semiring.toAddCommMonoid.{0} Real
                (@Ring.toSemiring.{0} Real
                  (@DivisionRing.toRing.{0} Real
                    (@Field.toDivisionRing.{0} Real
                      (@NormedField.toField.{0} Real
                        (@DenselyNormedField.toNormedField.{0} Real
                          (@RCLike.toDenselyNormedField.{0} Real Real.instRCLike)))))))
              (@Semiring.toModule.{0} Real
                (@DivisionSemiring.toSemiring.{0} Real
                  (@Semifield.toDivisionSemiring.{0} Real
                    (@Field.toSemifield.{0} Real
                      (@NormedField.toField.{0} Real
                        (@DenselyNormedField.toNormedField.{0} Real
                          (@RCLike.toDenselyNormedField.{0} Real Real.instRCLike)))))))))
          (@Pi.Function.module.{u_1, 0, 0} ι Real Real
            (@DivisionSemiring.toSemiring.{0} Real
              (@Semifield.toDivisionSemiring.{0} Real
                (@Field.toSemifield.{0} Real
                  (@NormedField.toField.{0} Real
                    (@DenselyNormedField.toNormedField.{0} Real
                      (@RCLike.toDenselyNormedField.{0} Real Real.instRCLike))))))
            (@Semiring.toAddCommMonoid.{0} Real
              (@DivisionSemiring.toSemiring.{0} Real
                (@Semifield.toDivisionSemiring.{0} Real
                  (@Field.toSemifield.{0} Real
                    (@NormedField.toField.{0} Real
                      (@DenselyNormedField.toNormedField.{0} Real
                        (@RCLike.toDenselyNormedField.{0} Real Real.instRCLike)))))))
            (@Semiring.toModule.{0} Real
              (@DivisionSemiring.toSemiring.{0} Real
                (@Semifield.toDivisionSemiring.{0} Real
                  (@Field.toSemifield.{0} Real
                    (@NormedField.toField.{0} Real
                      (@DenselyNormedField.toNormedField.{0} Real
                        (@RCLike.toDenselyNormedField.{0} Real Real.instRCLike)))))))))
        (EuclideanSpace.{0, u_1} Real ι) (ι → Real)
        (@ContinuousLinearEquiv.equivLike.{0, 0, u_1, u_1} Real Real
          (@DivisionSemiring.toSemiring.{0} Real
            (@Semifield.toDivisionSemiring.{0} Real
              (@Field.toSemifield.{0} Real
                (@NormedField.toField.{0} Real
                  (@DenselyNormedField.toNormedField.{0} Real
                    (@RCLike.toDenselyNormedField.{0} Real Real.instRCLike))))))
          (@DivisionSemiring.toSemiring.{0} Real
            (@Semifield.toDivisionSemiring.{0} Real
              (@Field.toSemifield.{0} Real
                (@NormedField.toField.{0} Real
                  (@DenselyNormedField.toNormedField.{0} Real
                    (@RCLike.toDenselyNormedField.{0} Real Real.instRCLike))))))
          (@RingHom.id.{0} Real
            (@Semiring.toNonAssocSemiring.{0} Real
              (@DivisionSemiring.toSemiring.{0} Real
                (@Semifield.toDivisionSemiring.{0} Real
                  (@Field.toSemifield.{0} Real
                    (@NormedField.toField.{0} Real
                      (@DenselyNormedField.toNormedField.{0} Real
                        (@RCLike.toDenselyNormedField.{0} Real Real.instRCLike))))))))
          (@RingHom.id.{0} Real
            (@Semiring.toNonAssocSemiring.{0} Real
              (@DivisionSemiring.toSemiring.{0} Real
                (@Semifield.toDivisionSemiring.{0} Real
                  (@Field.toSemifield.{0} Real
                    (@NormedField.toField.{0} Real
                      (@DenselyNormedField.toNormedField.{0} Real
                        (@RCLike.toDenselyNormedField.{0} Real Real.instRCLike))))))))
          ⋯ ⋯ (EuclideanSpace.{0, u_1} Real ι)
          (@PiLp.topologicalSpace.{u_1, 0}
            (@OfNat.ofNat.{0} ENNReal (nat_lit 2)
              (@instOfNatAtLeastTwo.{0} ENNReal (nat_lit 2)
                (@AddMonoidWithOne.toNatCast.{0} ENNReal
                  (@AddCommMonoidWithOne.toAddMonoidWithOne.{0} ENNReal ENNReal.instAddCommMonoidWithOne))
                PiLp.innerProductSpace._proof_1))
            ι (fun x => Real) fun i =>
            @UniformSpace.toTopologicalSpace.{0} Real
              (@PseudoMetricSpace.toUniformSpace.{0} Real
                (@SeminormedRing.toPseudoMetricSpace.{0} Real
                  (@SeminormedCommRing.toSeminormedRing.{0} Real
                    (@NormedCommRing.toSeminormedCommRing.{0} Real
                      (@NormedField.toNormedCommRing.{0} Real
                        (@DenselyNormedField.toNormedField.{0} Real
                          (@RCLike.toDenselyNormedField.{0} Real Real.instRCLike))))))))
          (@AddCommGroup.toAddCommMonoid.{u_1} (EuclideanSpace.{0, u_1} Real ι)
            (@WithLp.instAddCommGroup.{u_1}
              (@OfNat.ofNat.{0} ENNReal (nat_lit 2)
                (@instOfNatAtLeastTwo.{0} ENNReal (nat_lit 2)
                  (@AddMonoidWithOne.toNatCast.{0} ENNReal
                    (@AddCommMonoidWithOne.toAddMonoidWithOne.{0} ENNReal ENNReal.instAddCommMonoidWithOne))
                  PiLp.innerProductSpace._proof_1))
              ((i : ι) → (fun x => Real) i)
              (@Pi.addCommGroup.{u_1, 0} ι (fun x => Real) fun i =>
                @Ring.toAddCommGroup.{0} Real
                  (@DivisionRing.toRing.{0} Real
                    (@Field.toDivisionRing.{0} Real
                      (@NormedField.toField.{0} Real
                        (@DenselyNormedField.toNormedField.{0} Real
                          (@RCLike.toDenselyNormedField.{0} Real Real.instRCLike))))))))
          (ι → Real)
          (@Pi.topologicalSpace.{0, u_1} ι (fun a => Real) fun i =>
            @UniformSpace.toTopologicalSpace.{0} Real
              (@PseudoMetricSpace.toUniformSpace.{0} Real
                (@SeminormedRing.toPseudoMetricSpace.{0} Real
                  (@SeminormedCommRing.toSeminormedRing.{0} Real
                    (@NormedCommRing.toSeminormedCommRing.{0} Real
                      (@NormedField.toNormedCommRing.{0} Real
                        (@DenselyNormedField.toNormedField.{0} Real
                          (@RCLike.toDenselyNormedField.{0} Real Real.instRCLike))))))))
          (@Pi.addCommMonoid.{u_1, 0} ι (fun a => Real) fun i =>
            @Semiring.toAddCommMonoid.{0} Real
              (@DivisionSemiring.toSemiring.{0} Real
                (@Semifield.toDivisionSemiring.{0} Real
                  (@Field.toSemifield.{0} Real
                    (@NormedField.toField.{0} Real
                      (@DenselyNormedField.toNormedField.{0} Real
                        (@RCLike.toDenselyNormedField.{0} Real Real.instRCLike)))))))
          (@WithLp.instModule.{0, u_1}
            (@OfNat.ofNat.{0} ENNReal (nat_lit 2)
              (@instOfNatAtLeastTwo.{0} ENNReal (nat_lit 2)
                (@AddMonoidWithOne.toNatCast.{0} ENNReal
                  (@AddCommMonoidWithOne.toAddMonoidWithOne.{0} ENNReal ENNReal.instAddCommMonoidWithOne))
                PiLp.innerProductSpace._proof_1))
            Real ((i : ι) → (fun x => Real) i)
            (@DivisionSemiring.toSemiring.{0} Real
              (@Semifield.toDivisionSemiring.{0} Real
                (@Field.toSemifield.{0} Real
                  (@NormedField.toField.{0} Real
                    (@DenselyNormedField.toNormedField.{0} Real
                      (@RCLike.toDenselyNormedField.{0} Real Real.instRCLike))))))
            (@Pi.addCommGroup.{u_1, 0} ι (fun x => Real) fun i =>
              @Ring.toAddCommGroup.{0} Real
                (@DivisionRing.toRing.{0} Real
                  (@Field.toDivisionRing.{0} Real
                    (@NormedField.toField.{0} Real
                      (@DenselyNormedField.toNormedField.{0} Real
                        (@RCLike.toDenselyNormedField.{0} Real Real.instRCLike))))))
            (@Pi.Function.module.{u_1, 0, 0} ι Real Real
              (@DivisionSemiring.toSemiring.{0} Real
                (@Semifield.toDivisionSemiring.{0} Real
                  (@Field.toSemifield.{0} Real
                    (@NormedField.toField.{0} Real
                      (@DenselyNormedField.toNormedField.{0} Real
                        (@RCLike.toDenselyNormedField.{0} Real Real.instRCLike))))))
              (@Semiring.toAddCommMonoid.{0} Real
                (@Ring.toSemiring.{0} Real
                  (@DivisionRing.toRing.{0} Real
                    (@Field.toDivisionRing.{0} Real
                      (@NormedField.toField.{0} Real
                        (@DenselyNormedField.toNormedField.{0} Real
                          (@RCLike.toDenselyNormedField.{0} Real Real.instRCLike)))))))
              (@Semiring.toModule.{0} Real
                (@DivisionSemiring.toSemiring.{0} Real
                  (@Semifield.toDivisionSemiring.{0} Real
                    (@Field.toSemifield.{0} Real
                      (@NormedField.toField.{0} Real
                        (@DenselyNormedField.toNormedField.{0} Real
                          (@RCLike.toDenselyNormedField.{0} Real Real.instRCLike)))))))))
          (@Pi.Function.module.{u_1, 0, 0} ι Real Real
            (@DivisionSemiring.toSemiring.{0} Real
              (@Semifield.toDivisionSemiring.{0} Real
                (@Field.toSemifield.{0} Real
                  (@NormedField.toField.{0} Real
                    (@DenselyNormedField.toNormedField.{0} Real
                      (@RCLike.toDenselyNormedField.{0} Real Real.instRCLike))))))
            (@Semiring.toAddCommMonoid.{0} Real
              (@DivisionSemiring.toSemiring.{0} Real
                (@Semifield.toDivisionSemiring.{0} Real
                  (@Field.toSemifield.{0} Real
                    (@NormedField.toField.{0} Real
                      (@DenselyNormedField.toNormedField.{0} Real
                        (@RCLike.toDenselyNormedField.{0} Real Real.instRCLike)))))))
            (@Semiring.toModule.{0} Real
              (@DivisionSemiring.toSemiring.{0} Real
                (@Semifield.toDivisionSemiring.{0} Real
                  (@Field.toSemifield.{0} Real
                    (@NormedField.toField.{0} Real
                      (@DenselyNormedField.toNormedField.{0} Real
                        (@RCLike.toDenselyNormedField.{0} Real Real.instRCLike))))))))))
      (@EuclideanSpace.equiv.{u_1, 0} ι Real Real.instRCLike)) :=
⋯
```

## `MeasureTheory.addContent_iUnion_eq_sum_of_regular`

Command: `#print MeasureTheory.addContent_iUnion_eq_sum_of_regular`

```lean
theorem MeasureTheory.addContent_iUnion_eq_sum_of_regular.{u_1} : ∀ {α : Type u_1} {C R : Set.{u_1} (Set.{u_1} α)},
  @MeasureTheory.IsSetRing.{u_1} α R →
    ∀ (m : @MeasureTheory.AddContent.{u_1, 0} α ENNReal ENNReal.instAddCommMonoid R),
      (∀ (s : Set.{u_1} α),
          @Membership.mem.{u_1, u_1} (Set.{u_1} α) (Set.{u_1} (Set.{u_1} α)) (@Set.instMembership.{u_1} (Set.{u_1} α)) R
              s →
            @Ne.{1} ENNReal
              (@DFunLike.coe.{u_1 + 1, u_1 + 1, 1}
                (@MeasureTheory.AddContent.{u_1, 0} α ENNReal ENNReal.instAddCommMonoid R) (Set.{u_1} α)
                (fun x => ENNReal)
                (@MeasureTheory.instFunLikeAddContentSet.{u_1, 0} α R ENNReal ENNReal.instAddCommMonoid) m s)
              (@Top.top.{0} ENNReal ENNReal.instTop)) →
        @IsCompactSystem.{u_1} α C →
          @LE.le.{u_1} (Set.{u_1} (Set.{u_1} α)) (@Set.instLE.{u_1} (Set.{u_1} α)) C R →
            (∀ (A : Set.{u_1} α),
                @Membership.mem.{u_1, u_1} (Set.{u_1} α) (Set.{u_1} (Set.{u_1} α))
                    (@Set.instMembership.{u_1} (Set.{u_1} α)) R A →
                  ∀ (ε : ENNReal),
                    @LT.lt.{0} ENNReal
                        (@Preorder.toLT.{0} ENNReal (@PartialOrder.toPreorder.{0} ENNReal ENNReal.instPartialOrder))
                        (@OfNat.ofNat.{0} ENNReal (nat_lit 0) (@Zero.toOfNat0.{0} ENNReal ENNReal.instZero)) ε →
                      ∃ K,
                        And
                          (@Membership.mem.{u_1, u_1} (Set.{u_1} α) (Set.{u_1} (Set.{u_1} α))
                            (@Set.instMembership.{u_1} (Set.{u_1} α)) C K)
                          (And (@LE.le.{u_1} (Set.{u_1} α) (@Set.instLE.{u_1} α) K A)
                            (@LE.le.{0} ENNReal ENNReal.instLE
                              (@DFunLike.coe.{u_1 + 1, u_1 + 1, 1}
                                (@MeasureTheory.AddContent.{u_1, 0} α ENNReal ENNReal.instAddCommMonoid R) (Set.{u_1} α)
                                (fun x => ENNReal)
                                (@MeasureTheory.instFunLikeAddContentSet.{u_1, 0} α R ENNReal ENNReal.instAddCommMonoid)
                                m (@SDiff.sdiff.{u_1} (Set.{u_1} α) (@Set.instSDiff.{u_1} α) A K))
                              ε))) →
              ∀ ⦃f : Nat → Set.{u_1} α⦄,
                (∀ (i : Nat),
                    @Membership.mem.{u_1, u_1} (Set.{u_1} α) (Set.{u_1} (Set.{u_1} α))
                      (@Set.instMembership.{u_1} (Set.{u_1} α)) R (f i)) →
                  @Membership.mem.{u_1, u_1} (Set.{u_1} α) (Set.{u_1} (Set.{u_1} α))
                      (@Set.instMembership.{u_1} (Set.{u_1} α)) R (⋃ i, f i) →
                    @Pairwise.{0} Nat
                        (@Function.onFun.{1, u_1 + 1, 1} Nat (Set.{u_1} α) Prop
                          (@Disjoint.{u_1} (Set.{u_1} α)
                            (@ChainCompletePartialOrder.toPartialOrder.{u_1} (Set.{u_1} α)
                              (@ChainCompletePartialOrder.instOfCompleteLattice.{u_1} (Set.{u_1} α)
                                (@CompleteBooleanAlgebra.toCompleteLattice.{u_1} (Set.{u_1} α)
                                  (@CompleteAtomicBooleanAlgebra.toCompleteBooleanAlgebra.{u_1} (Set.{u_1} α)
                                    (@Set.instCompleteAtomicBooleanAlgebra.{u_1} α)))))
                            (@HeytingAlgebra.toOrderBot.{u_1} (Set.{u_1} α)
                              (@Order.Frame.toHeytingAlgebra.{u_1} (Set.{u_1} α)
                                (@CompleteDistribLattice.toFrame.{u_1} (Set.{u_1} α)
                                  (@CompleteBooleanAlgebra.toCompleteDistribLattice.{u_1} (Set.{u_1} α)
                                    (@CompleteAtomicBooleanAlgebra.toCompleteBooleanAlgebra.{u_1} (Set.{u_1} α)
                                      (@Set.instCompleteAtomicBooleanAlgebra.{u_1} α)))))))
                          f) →
                      @Eq.{1} ENNReal
                        (@DFunLike.coe.{u_1 + 1, u_1 + 1, 1}
                          (@MeasureTheory.AddContent.{u_1, 0} α ENNReal ENNReal.instAddCommMonoid R) (Set.{u_1} α)
                          (fun x => ENNReal)
                          (@MeasureTheory.instFunLikeAddContentSet.{u_1, 0} α R ENNReal ENNReal.instAddCommMonoid) m
                          (⋃ i, f i))
                        (@tsum.{0, 0} ENNReal Nat ENNReal.instAddCommMonoid ENNReal.instTopologicalSpace
                          (fun i =>
                            @DFunLike.coe.{u_1 + 1, u_1 + 1, 1}
                              (@MeasureTheory.AddContent.{u_1, 0} α ENNReal ENNReal.instAddCommMonoid R) (Set.{u_1} α)
                              (fun x => ENNReal)
                              (@MeasureTheory.instFunLikeAddContentSet.{u_1, 0} α R ENNReal ENNReal.instAddCommMonoid) m
                              (f i))
                          (SummationFilter.unconditional.{0} Nat)) :=
⋯
```

## `MeasureTheory.exists_compact`

Command: `#print MeasureTheory.exists_compact`

```lean
theorem MeasureTheory.exists_compact.{u_1, u_2} : ∀ {ι : Type u_1} {α : ι → Type u_2}
  [inst : (i : ι) → MeasurableSpace.{u_2} (α i)]
  {P :
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
                    (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} ι) ι (@Finset.instSetLike.{u_1} ι)) J x)
                j))
          fun a =>
          inst
            (@Subtype.val.{u_1 + 1} ι
              (fun x =>
                @Membership.mem.{u_1, u_1} ι (Finset.{u_1} ι)
                  (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} ι) ι (@Finset.instSetLike.{u_1} ι)) J x)
              a))}
  [inst_1 : (i : ι) → TopologicalSpace.{u_2} (α i)] [∀ (i : ι), @OpensMeasurableSpace.{u_2} (α i) (inst_1 i) (inst i)]
  [∀ (i : ι), @SecondCountableTopology.{u_2} (α i) (inst_1 i)]
  [∀ (I : Finset.{u_1} ι),
      @MeasureTheory.IsFiniteMeasure.{max u_1 u_2}
        ((j : ↥I) →
          α
            (@Subtype.val.{u_1 + 1} ι
              (fun x =>
                @Membership.mem.{u_1, u_1} ι (Finset.{u_1} ι)
                  (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} ι) ι (@Finset.instSetLike.{u_1} ι)) I x)
              j))
        (@MeasurableSpace.pi.{u_1, u_2} (↥I)
          (fun j =>
            α
              (@Subtype.val.{u_1 + 1} ι
                (fun x =>
                  @Membership.mem.{u_1, u_1} ι (Finset.{u_1} ι)
                    (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} ι) ι (@Finset.instSetLike.{u_1} ι)) I x)
                j))
          fun a =>
          inst
            (@Subtype.val.{u_1 + 1} ι
              (fun x =>
                @Membership.mem.{u_1, u_1} ι (Finset.{u_1} ι)
                  (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} ι) ι (@Finset.instSetLike.{u_1} ι)) I x)
              a))
        (P I)],
  (∀ (J : Finset.{u_1} ι),
      @MeasureTheory.Measure.InnerRegularWRT.{max u_1 u_2}
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
                    (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} ι) ι (@Finset.instSetLike.{u_1} ι)) J x)
                j))
          fun a =>
          inst
            (@Subtype.val.{u_1 + 1} ι
              (fun x =>
                @Membership.mem.{u_1, u_1} ι (Finset.{u_1} ι)
                  (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} ι) ι (@Finset.instSetLike.{u_1} ι)) J x)
              a))
        (P J)
        (fun s =>
          And
            (@IsCompact.{max u_1 u_2}
              ((j : ↥J) →
                α
                  (@Subtype.val.{u_1 + 1} ι
                    (fun x =>
                      @Membership.mem.{u_1, u_1} ι (Finset.{u_1} ι)
                        (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} ι) ι (@Finset.instSetLike.{u_1} ι)) J x)
                    j))
              (@Pi.topologicalSpace.{u_2, u_1} (↥J)
                (fun j =>
                  α
                    (@Subtype.val.{u_1 + 1} ι
                      (fun x =>
                        @Membership.mem.{u_1, u_1} ι (Finset.{u_1} ι)
                          (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} ι) ι (@Finset.instSetLike.{u_1} ι)) J x)
                      j))
                fun i =>
                inst_1
                  (@Subtype.val.{u_1 + 1} ι
                    (fun x =>
                      @Membership.mem.{u_1, u_1} ι (Finset.{u_1} ι)
                        (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} ι) ι (@Finset.instSetLike.{u_1} ι)) J x)
                    i))
              s)
            (@IsClosed.{max u_1 u_2}
              ((j : ↥J) →
                α
                  (@Subtype.val.{u_1 + 1} ι
                    (fun x =>
                      @Membership.mem.{u_1, u_1} ι (Finset.{u_1} ι)
                        (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} ι) ι (@Finset.instSetLike.{u_1} ι)) J x)
                    j))
              (@Pi.topologicalSpace.{u_2, u_1} (↥J)
                (fun j =>
                  α
                    (@Subtype.val.{u_1 + 1} ι
                      (fun x =>
                        @Membership.mem.{u_1, u_1} ι (Finset.{u_1} ι)
                          (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} ι) ι (@Finset.instSetLike.{u_1} ι)) J x)
                      j))
                fun i =>
                inst_1
                  (@Subtype.val.{u_1 + 1} ι
                    (fun x =>
                      @Membership.mem.{u_1, u_1} ι (Finset.{u_1} ι)
                        (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} ι) ι (@Finset.instSetLike.{u_1} ι)) J x)
                    i))
              s))
        (@MeasurableSet.{max u_1 u_2}
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
                      (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} ι) ι (@Finset.instSetLike.{u_1} ι)) J x)
                  j))
            fun a =>
            inst
              (@Subtype.val.{u_1 + 1} ι
                (fun x =>
                  @Membership.mem.{u_1, u_1} ι (Finset.{u_1} ι)
                    (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} ι) ι (@Finset.instSetLike.{u_1} ι)) J x)
                a)))) →
    ∀ (J : Finset.{u_1} ι)
      (A :
        Set.{max u_1 u_2}
          ((i : ↥J) →
            α
              (@Subtype.val.{u_1 + 1} ι
                (fun x =>
                  @Membership.mem.{u_1, u_1} ι (Finset.{u_1} ι)
                    (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} ι) ι (@Finset.instSetLike.{u_1} ι)) J x)
                i))),
      @MeasurableSet.{max u_1 u_2}
          ((i : ↥J) →
            α
              (@Subtype.val.{u_1 + 1} ι
                (fun x =>
                  @Membership.mem.{u_1, u_1} ι (Finset.{u_1} ι)
                    (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} ι) ι (@Finset.instSetLike.{u_1} ι)) J x)
                i))
          (@MeasurableSpace.pi.{u_1, u_2} (↥J)
            (fun i =>
              α
                (@Subtype.val.{u_1 + 1} ι
                  (fun x =>
                    @Membership.mem.{u_1, u_1} ι (Finset.{u_1} ι)
                      (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} ι) ι (@Finset.instSetLike.{u_1} ι)) J x)
                  i))
            fun a =>
            inst
              (@Subtype.val.{u_1 + 1} ι
                (fun x =>
                  @Membership.mem.{u_1, u_1} ι (Finset.{u_1} ι)
                    (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} ι) ι (@Finset.instSetLike.{u_1} ι)) J x)
                a))
          A →
        ∀ (ε : ENNReal),
          @LT.lt.{0} ENNReal
              (@Preorder.toLT.{0} ENNReal (@PartialOrder.toPreorder.{0} ENNReal ENNReal.instPartialOrder))
              (@OfNat.ofNat.{0} ENNReal (nat_lit 0) (@Zero.toOfNat0.{0} ENNReal ENNReal.instZero)) ε →
            ∃ K,
              And
                (@IsCompact.{max u_1 u_2}
                  ((i : ↥J) →
                    α
                      (@Subtype.val.{u_1 + 1} ι
                        (fun x =>
                          @Membership.mem.{u_1, u_1} ι (Finset.{u_1} ι)
                            (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} ι) ι (@Finset.instSetLike.{u_1} ι)) J x)
                        i))
                  (@Pi.topologicalSpace.{u_2, u_1} (↥J)
                    (fun i =>
                      α
                        (@Subtype.val.{u_1 + 1} ι
                          (fun x =>
                            @Membership.mem.{u_1, u_1} ι (Finset.{u_1} ι)
                              (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} ι) ι (@Finset.instSetLike.{u_1} ι)) J x)
                          i))
                    fun i =>
                    inst_1
                      (@Subtype.val.{u_1 + 1} ι
                        (fun x =>
                          @Membership.mem.{u_1, u_1} ι (Finset.{u_1} ι)
                            (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} ι) ι (@Finset.instSetLike.{u_1} ι)) J x)
                        i))
                  K)
                (And
                  (@IsClosed.{max u_1 u_2}
                    ((i : ↥J) →
                      α
                        (@Subtype.val.{u_1 + 1} ι
                          (fun x =>
                            @Membership.mem.{u_1, u_1} ι (Finset.{u_1} ι)
                              (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} ι) ι (@Finset.instSetLike.{u_1} ι)) J x)
                          i))
                    (@Pi.topologicalSpace.{u_2, u_1} (↥J)
                      (fun i =>
                        α
                          (@Subtype.val.{u_1 + 1} ι
                            (fun x =>
                              @Membership.mem.{u_1, u_1} ι (Finset.{u_1} ι)
                                (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} ι) ι (@Finset.instSetLike.{u_1} ι)) J
                                x)
                            i))
                      fun i =>
                      inst_1
                        (@Subtype.val.{u_1 + 1} ι
                          (fun x =>
                            @Membership.mem.{u_1, u_1} ι (Finset.{u_1} ι)
                              (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} ι) ι (@Finset.instSetLike.{u_1} ι)) J x)
                          i))
                    K)
                  (And
                    (@LE.le.{max u_1 u_2}
                      (Set.{max u_1 u_2}
                        ((i : ↥J) →
                          α
                            (@Subtype.val.{u_1 + 1} ι
                              (fun x =>
                                @Membership.mem.{u_1, u_1} ι (Finset.{u_1} ι)
                                  (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} ι) ι (@Finset.instSetLike.{u_1} ι))
                                  J x)
                              i)))
                      (@Set.instLE.{max u_1 u_2}
                        ((i : ↥J) →
                          α
                            (@Subtype.val.{u_1 + 1} ι
                              (fun x =>
                                @Membership.mem.{u_1, u_1} ι (Finset.{u_1} ι)
                                  (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} ι) ι (@Finset.instSetLike.{u_1} ι))
                                  J x)
                              i)))
                      K A)
                    (@LE.le.{0} ENNReal ENNReal.instLE
                      (@DFunLike.coe.{max (u_1 + 1) (u_2 + 1), max (u_1 + 1) (u_2 + 1), 1}
                        (@MeasureTheory.Measure.{max u_1 u_2}
                          ((j : ↥J) →
                            α
                              (@Subtype.val.{u_1 + 1} ι
                                (fun x =>
                                  @Membership.mem.{u_1, u_1} ι (Finset.{u_1} ι)
                                    (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} ι) ι
                                      (@Finset.instSetLike.{u_1} ι))
                                    J x)
                                j))
                          (@MeasurableSpace.pi.{u_1, u_2} (↥J)
                            (fun j =>
                              α
                                (@Subtype.val.{u_1 + 1} ι
                                  (fun x =>
                                    @Membership.mem.{u_1, u_1} ι (Finset.{u_1} ι)
                                      (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} ι) ι
                                        (@Finset.instSetLike.{u_1} ι))
                                      J x)
                                  j))
                            fun a =>
                            inst
                              (@Subtype.val.{u_1 + 1} ι
                                (fun x =>
                                  @Membership.mem.{u_1, u_1} ι (Finset.{u_1} ι)
                                    (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} ι) ι
                                      (@Finset.instSetLike.{u_1} ι))
                                    J x)
                                a)))
                        (Set.{max u_1 u_2}
                          ((j : ↥J) →
                            α
                              (@Subtype.val.{u_1 + 1} ι
                                (fun x =>
                                  @Membership.mem.{u_1, u_1} ι (Finset.{u_1} ι)
                                    (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} ι) ι
                                      (@Finset.instSetLike.{u_1} ι))
                                    J x)
                                j)))
                        (fun x => ENNReal)
                        (@MeasureTheory.Measure.instFunLike.{max u_1 u_2}
                          ((j : ↥J) →
                            α
                              (@Subtype.val.{u_1 + 1} ι
                                (fun x =>
                                  @Membership.mem.{u_1, u_1} ι (Finset.{u_1} ι)
                                    (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} ι) ι
                                      (@Finset.instSetLike.{u_1} ι))
                                    J x)
                                j))
                          (@MeasurableSpace.pi.{u_1, u_2} (↥J)
                            (fun j =>
                              α
                                (@Subtype.val.{u_1 + 1} ι
                                  (fun x =>
                                    @Membership.mem.{u_1, u_1} ι (Finset.{u_1} ι)
                                      (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} ι) ι
                                        (@Finset.instSetLike.{u_1} ι))
                                      J x)
                                  j))
                            fun a =>
                            inst
                              (@Subtype.val.{u_1 + 1} ι
                                (fun x =>
                                  @Membership.mem.{u_1, u_1} ι (Finset.{u_1} ι)
                                    (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} ι) ι
                                      (@Finset.instSetLike.{u_1} ι))
                                    J x)
                                a)))
                        (P J)
                        (@SDiff.sdiff.{max u_1 u_2}
                          (Set.{max u_1 u_2}
                            ((j : ↥J) →
                              α
                                (@Subtype.val.{u_1 + 1} ι
                                  (fun x =>
                                    @Membership.mem.{u_1, u_1} ι (Finset.{u_1} ι)
                                      (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} ι) ι
                                        (@Finset.instSetLike.{u_1} ι))
                                      J x)
                                  j)))
                          (@Set.instSDiff.{max u_1 u_2}
                            ((j : ↥J) →
                              α
                                (@Subtype.val.{u_1 + 1} ι
                                  (fun x =>
                                    @Membership.mem.{u_1, u_1} ι (Finset.{u_1} ι)
                                      (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} ι) ι
                                        (@Finset.instSetLike.{u_1} ι))
                                      J x)
                                  j)))
                          A K))
                      ε))) :=
⋯
```

## `MeasureTheory.innerRegular_projectiveFamilyContent`

Command: `#print MeasureTheory.innerRegular_projectiveFamilyContent`

```lean
theorem MeasureTheory.innerRegular_projectiveFamilyContent.{u_1, u_2} : ∀ {ι : Type u_1} {α : ι → Type u_2}
  [inst : (i : ι) → MeasurableSpace.{u_2} (α i)]
  {P :
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
                    (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} ι) ι (@Finset.instSetLike.{u_1} ι)) J x)
                j))
          fun a =>
          inst
            (@Subtype.val.{u_1 + 1} ι
              (fun x =>
                @Membership.mem.{u_1, u_1} ι (Finset.{u_1} ι)
                  (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} ι) ι (@Finset.instSetLike.{u_1} ι)) J x)
              a))}
  [inst_1 : (i : ι) → TopologicalSpace.{u_2} (α i)] [∀ (i : ι), @OpensMeasurableSpace.{u_2} (α i) (inst_1 i) (inst i)]
  [∀ (i : ι), @SecondCountableTopology.{u_2} (α i) (inst_1 i)]
  [∀ (I : Finset.{u_1} ι),
      @MeasureTheory.IsFiniteMeasure.{max u_1 u_2}
        ((j : ↥I) →
          α
            (@Subtype.val.{u_1 + 1} ι
              (fun x =>
                @Membership.mem.{u_1, u_1} ι (Finset.{u_1} ι)
                  (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} ι) ι (@Finset.instSetLike.{u_1} ι)) I x)
              j))
        (@MeasurableSpace.pi.{u_1, u_2} (↥I)
          (fun j =>
            α
              (@Subtype.val.{u_1 + 1} ι
                (fun x =>
                  @Membership.mem.{u_1, u_1} ι (Finset.{u_1} ι)
                    (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} ι) ι (@Finset.instSetLike.{u_1} ι)) I x)
                j))
          fun a =>
          inst
            (@Subtype.val.{u_1 + 1} ι
              (fun x =>
                @Membership.mem.{u_1, u_1} ι (Finset.{u_1} ι)
                  (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} ι) ι (@Finset.instSetLike.{u_1} ι)) I x)
              a))
        (P I)]
  (hP : @MeasureTheory.IsProjectiveMeasureFamily.{u_1, u_2} ι α inst P),
  (∀ (J : Finset.{u_1} ι),
      @MeasureTheory.Measure.InnerRegularWRT.{max u_1 u_2}
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
                    (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} ι) ι (@Finset.instSetLike.{u_1} ι)) J x)
                j))
          fun a =>
          inst
            (@Subtype.val.{u_1 + 1} ι
              (fun x =>
                @Membership.mem.{u_1, u_1} ι (Finset.{u_1} ι)
                  (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} ι) ι (@Finset.instSetLike.{u_1} ι)) J x)
              a))
        (P J)
        (fun s =>
          And
            (@IsCompact.{max u_1 u_2}
              ((j : ↥J) →
                α
                  (@Subtype.val.{u_1 + 1} ι
                    (fun x =>
                      @Membership.mem.{u_1, u_1} ι (Finset.{u_1} ι)
                        (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} ι) ι (@Finset.instSetLike.{u_1} ι)) J x)
                    j))
              (@Pi.topologicalSpace.{u_2, u_1} (↥J)
                (fun j =>
                  α
                    (@Subtype.val.{u_1 + 1} ι
                      (fun x =>
                        @Membership.mem.{u_1, u_1} ι (Finset.{u_1} ι)
                          (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} ι) ι (@Finset.instSetLike.{u_1} ι)) J x)
                      j))
                fun i =>
                inst_1
                  (@Subtype.val.{u_1 + 1} ι
                    (fun x =>
                      @Membership.mem.{u_1, u_1} ι (Finset.{u_1} ι)
                        (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} ι) ι (@Finset.instSetLike.{u_1} ι)) J x)
                    i))
              s)
            (@IsClosed.{max u_1 u_2}
              ((j : ↥J) →
                α
                  (@Subtype.val.{u_1 + 1} ι
                    (fun x =>
                      @Membership.mem.{u_1, u_1} ι (Finset.{u_1} ι)
                        (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} ι) ι (@Finset.instSetLike.{u_1} ι)) J x)
                    j))
              (@Pi.topologicalSpace.{u_2, u_1} (↥J)
                (fun j =>
                  α
                    (@Subtype.val.{u_1 + 1} ι
                      (fun x =>
                        @Membership.mem.{u_1, u_1} ι (Finset.{u_1} ι)
                          (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} ι) ι (@Finset.instSetLike.{u_1} ι)) J x)
                      j))
                fun i =>
                inst_1
                  (@Subtype.val.{u_1 + 1} ι
                    (fun x =>
                      @Membership.mem.{u_1, u_1} ι (Finset.{u_1} ι)
                        (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} ι) ι (@Finset.instSetLike.{u_1} ι)) J x)
                    i))
              s))
        (@MeasurableSet.{max u_1 u_2}
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
                      (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} ι) ι (@Finset.instSetLike.{u_1} ι)) J x)
                  j))
            fun a =>
            inst
              (@Subtype.val.{u_1 + 1} ι
                (fun x =>
                  @Membership.mem.{u_1, u_1} ι (Finset.{u_1} ι)
                    (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} ι) ι (@Finset.instSetLike.{u_1} ι)) J x)
                a)))) →
    ∀ {s : Set.{max u_1 u_2} ((i : ι) → α i)},
      @Membership.mem.{max u_1 u_2, max u_1 u_2} (Set.{max u_1 u_2} ((i : ι) → α i))
          (Set.{max u_2 u_1} (Set.{max u_2 u_1} ((i : ι) → α i)))
          (@Set.instMembership.{max u_1 u_2} (Set.{max u_2 u_1} ((i : ι) → α i)))
          (@MeasureTheory.measurableCylinders.{u_2, u_1} ι α inst) s →
        ∀ (ε : ENNReal),
          @LT.lt.{0} ENNReal
              (@Preorder.toLT.{0} ENNReal (@PartialOrder.toPreorder.{0} ENNReal ENNReal.instPartialOrder))
              (@OfNat.ofNat.{0} ENNReal (nat_lit 0) (@Zero.toOfNat0.{0} ENNReal ENNReal.instZero)) ε →
            ∃ K,
              And
                (@Membership.mem.{max u_1 u_2, max u_1 u_2} (Set.{max u_1 u_2} ((i : ι) → α i))
                  (Set.{max u_1 u_2} (Set.{max u_1 u_2} ((i : ι) → α i)))
                  (@Set.instMembership.{max u_1 u_2} (Set.{max u_1 u_2} ((i : ι) → α i)))
                  (@MeasureTheory.closedCompactCylinders.{u_1, u_2} ι α inst_1) K)
                (And
                  (@LE.le.{max u_1 u_2} (Set.{max u_1 u_2} ((i : ι) → α i)) (@Set.instLE.{max u_1 u_2} ((i : ι) → α i))
                    K s)
                  (@LE.le.{0} ENNReal ENNReal.instLE
                    (@DFunLike.coe.{max (u_1 + 1) (u_2 + 1), max (u_1 + 1) (u_2 + 1), 1}
                      (@MeasureTheory.AddContent.{max u_1 u_2, 0} ((i : ι) → α i) ENNReal ENNReal.instAddCommMonoid
                        (@MeasureTheory.measurableCylinders.{u_2, u_1} ι α inst))
                      (Set.{max u_1 u_2} ((i : ι) → α i)) (fun x => ENNReal)
                      (@MeasureTheory.instFunLikeAddContentSet.{max u_1 u_2, 0} ((i : ι) → α i)
                        (@MeasureTheory.measurableCylinders.{u_2, u_1} ι α inst) ENNReal ENNReal.instAddCommMonoid)
                      (@MeasureTheory.projectiveFamilyContent.{u_1, u_2} ι α inst P hP)
                      (@SDiff.sdiff.{max u_1 u_2} (Set.{max u_1 u_2} ((i : ι) → α i))
                        (@Set.instSDiff.{max u_1 u_2} ((i : ι) → α i)) s K))
                    ε)) :=
⋯
```

## `MeasureTheory.isProbabilityMeasure_projectiveLimit`

Command: `#print MeasureTheory.isProbabilityMeasure_projectiveLimit`

```lean
theorem MeasureTheory.isProbabilityMeasure_projectiveLimit.{u_1, u_2} : ∀ {ι : Type u_1} {α : ι → Type u_2}
  [inst : (i : ι) → MeasurableSpace.{u_2} (α i)] [inst_1 : (i : ι) → TopologicalSpace.{u_2} (α i)]
  [inst_2 : ∀ (i : ι), @BorelSpace.{u_2} (α i) (inst_1 i) (inst i)]
  [inst_3 : ∀ (i : ι), @PolishSpace.{u_2} (α i) (inst_1 i)] [hι : Nonempty.{u_1 + 1} ι]
  {P :
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
                    (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} ι) ι (@Finset.instSetLike.{u_1} ι)) J x)
                j))
          fun a =>
          inst
            (@Subtype.val.{u_1 + 1} ι
              (fun x =>
                @Membership.mem.{u_1, u_1} ι (Finset.{u_1} ι)
                  (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} ι) ι (@Finset.instSetLike.{u_1} ι)) J x)
              a))}
  [inst_4 :
    ∀ (i : Finset.{u_1} ι),
      @MeasureTheory.IsProbabilityMeasure.{max u_1 u_2}
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
  (hP : @MeasureTheory.IsProjectiveMeasureFamily.{u_1, u_2} ι α inst P),
  @MeasureTheory.IsProbabilityMeasure.{max u_2 u_1} ((i : ι) → α i) (@MeasurableSpace.pi.{u_1, u_2} ι α inst)
    (@MeasureTheory.projectiveLimit.{u_1, u_2} ι α inst inst_1 inst_2 inst_3 P ⋯ hP) :=
⋯
```

## `MeasureTheory.isProjectiveLimit_projectiveLimit`

Command: `#print MeasureTheory.isProjectiveLimit_projectiveLimit`

```lean
theorem MeasureTheory.isProjectiveLimit_projectiveLimit.{u_1, u_2} : ∀ {ι : Type u_1} {α : ι → Type u_2}
  [inst : (i : ι) → MeasurableSpace.{u_2} (α i)]
  {P :
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
                    (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} ι) ι (@Finset.instSetLike.{u_1} ι)) J x)
                j))
          fun a =>
          inst
            (@Subtype.val.{u_1 + 1} ι
              (fun x =>
                @Membership.mem.{u_1, u_1} ι (Finset.{u_1} ι)
                  (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} ι) ι (@Finset.instSetLike.{u_1} ι)) J x)
              a))}
  [inst_1 : (i : ι) → TopologicalSpace.{u_2} (α i)] [inst_2 : ∀ (i : ι), @BorelSpace.{u_2} (α i) (inst_1 i) (inst i)]
  [inst_3 : ∀ (i : ι), @PolishSpace.{u_2} (α i) (inst_1 i)]
  [inst_4 :
    ∀ (I : Finset.{u_1} ι),
      @MeasureTheory.IsFiniteMeasure.{max u_1 u_2}
        ((j : ↥I) →
          α
            (@Subtype.val.{u_1 + 1} ι
              (fun x =>
                @Membership.mem.{u_1, u_1} ι (Finset.{u_1} ι)
                  (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} ι) ι (@Finset.instSetLike.{u_1} ι)) I x)
              j))
        (@MeasurableSpace.pi.{u_1, u_2} (↥I)
          (fun j =>
            α
              (@Subtype.val.{u_1 + 1} ι
                (fun x =>
                  @Membership.mem.{u_1, u_1} ι (Finset.{u_1} ι)
                    (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} ι) ι (@Finset.instSetLike.{u_1} ι)) I x)
                j))
          fun a =>
          inst
            (@Subtype.val.{u_1 + 1} ι
              (fun x =>
                @Membership.mem.{u_1, u_1} ι (Finset.{u_1} ι)
                  (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} ι) ι (@Finset.instSetLike.{u_1} ι)) I x)
              a))
        (P I)]
  (hP : @MeasureTheory.IsProjectiveMeasureFamily.{u_1, u_2} ι α inst P),
  @MeasureTheory.IsProjectiveLimit.{u_1, u_2} ι α inst
    (@MeasureTheory.projectiveLimit.{u_1, u_2} ι α inst inst_1 inst_2 inst_3 P inst_4 hP) P :=
⋯
```

## `MeasureTheory.projectiveFamilyContent_iUnion_le_sum`

Command: `#print MeasureTheory.projectiveFamilyContent_iUnion_le_sum`

```lean
theorem MeasureTheory.projectiveFamilyContent_iUnion_le_sum.{u_1, u_2} : ∀ {ι : Type u_1} {α : ι → Type u_2}
  [inst : (i : ι) → MeasurableSpace.{u_2} (α i)]
  {P :
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
                    (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} ι) ι (@Finset.instSetLike.{u_1} ι)) J x)
                j))
          fun a =>
          inst
            (@Subtype.val.{u_1 + 1} ι
              (fun x =>
                @Membership.mem.{u_1, u_1} ι (Finset.{u_1} ι)
                  (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} ι) ι (@Finset.instSetLike.{u_1} ι)) J x)
              a))}
  [inst_1 : (i : ι) → TopologicalSpace.{u_2} (α i)] [∀ (i : ι), @BorelSpace.{u_2} (α i) (inst_1 i) (inst i)]
  [∀ (i : ι), @PolishSpace.{u_2} (α i) (inst_1 i)]
  [∀ (I : Finset.{u_1} ι),
      @MeasureTheory.IsFiniteMeasure.{max u_1 u_2}
        ((j : ↥I) →
          α
            (@Subtype.val.{u_1 + 1} ι
              (fun x =>
                @Membership.mem.{u_1, u_1} ι (Finset.{u_1} ι)
                  (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} ι) ι (@Finset.instSetLike.{u_1} ι)) I x)
              j))
        (@MeasurableSpace.pi.{u_1, u_2} (↥I)
          (fun j =>
            α
              (@Subtype.val.{u_1 + 1} ι
                (fun x =>
                  @Membership.mem.{u_1, u_1} ι (Finset.{u_1} ι)
                    (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} ι) ι (@Finset.instSetLike.{u_1} ι)) I x)
                j))
          fun a =>
          inst
            (@Subtype.val.{u_1 + 1} ι
              (fun x =>
                @Membership.mem.{u_1, u_1} ι (Finset.{u_1} ι)
                  (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} ι) ι (@Finset.instSetLike.{u_1} ι)) I x)
              a))
        (P I)]
  (hP : @MeasureTheory.IsProjectiveMeasureFamily.{u_1, u_2} ι α inst P) ⦃f : Nat → Set.{max u_1 u_2} ((i : ι) → α i)⦄,
  (∀ (i : Nat),
      @Membership.mem.{max u_1 u_2, max u_1 u_2} (Set.{max u_1 u_2} ((i : ι) → α i))
        (Set.{max u_2 u_1} (Set.{max u_2 u_1} ((i : ι) → α i)))
        (@Set.instMembership.{max u_1 u_2} (Set.{max u_2 u_1} ((i : ι) → α i)))
        (@MeasureTheory.measurableCylinders.{u_2, u_1} ι α inst) (f i)) →
    @Membership.mem.{max u_1 u_2, max u_1 u_2} (Set.{max u_1 u_2} ((i : ι) → α i))
        (Set.{max u_2 u_1} (Set.{max u_2 u_1} ((i : ι) → α i)))
        (@Set.instMembership.{max u_1 u_2} (Set.{max u_2 u_1} ((i : ι) → α i)))
        (@MeasureTheory.measurableCylinders.{u_2, u_1} ι α inst) (⋃ i, f i) →
      @LE.le.{0} ENNReal ENNReal.instLE
        (@DFunLike.coe.{max (u_1 + 1) (u_2 + 1), max (u_1 + 1) (u_2 + 1), 1}
          (@MeasureTheory.AddContent.{max u_1 u_2, 0} ((i : ι) → α i) ENNReal ENNReal.instAddCommMonoid
            (@MeasureTheory.measurableCylinders.{u_2, u_1} ι α inst))
          (Set.{max u_1 u_2} ((i : ι) → α i)) (fun x => ENNReal)
          (@MeasureTheory.instFunLikeAddContentSet.{max u_1 u_2, 0} ((i : ι) → α i)
            (@MeasureTheory.measurableCylinders.{u_2, u_1} ι α inst) ENNReal ENNReal.instAddCommMonoid)
          (@MeasureTheory.projectiveFamilyContent.{u_1, u_2} ι α inst P hP) (⋃ i, f i))
        (@tsum.{0, 0} ENNReal Nat ENNReal.instAddCommMonoid ENNReal.instTopologicalSpace
          (fun i =>
            @DFunLike.coe.{max (u_1 + 1) (u_2 + 1), max (u_1 + 1) (u_2 + 1), 1}
              (@MeasureTheory.AddContent.{max u_1 u_2, 0} ((i : ι) → α i) ENNReal ENNReal.instAddCommMonoid
                (@MeasureTheory.measurableCylinders.{u_2, u_1} ι α inst))
              (Set.{max u_1 u_2} ((i : ι) → α i)) (fun x => ENNReal)
              (@MeasureTheory.instFunLikeAddContentSet.{max u_1 u_2, 0} ((i : ι) → α i)
                (@MeasureTheory.measurableCylinders.{u_2, u_1} ι α inst) ENNReal ENNReal.instAddCommMonoid)
              (@MeasureTheory.projectiveFamilyContent.{u_1, u_2} ι α inst P hP) (f i))
          (SummationFilter.unconditional.{0} Nat)) :=
⋯
```

## `MeasureTheory.projectiveFamilyContent_iUnion_le_sum_of_innerRegular`

Command: `#print MeasureTheory.projectiveFamilyContent_iUnion_le_sum_of_innerRegular`

```lean
theorem MeasureTheory.projectiveFamilyContent_iUnion_le_sum_of_innerRegular.{u_1, u_2} : ∀ {ι : Type u_1}
  {α : ι → Type u_2} [inst : (i : ι) → MeasurableSpace.{u_2} (α i)]
  {P :
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
                    (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} ι) ι (@Finset.instSetLike.{u_1} ι)) J x)
                j))
          fun a =>
          inst
            (@Subtype.val.{u_1 + 1} ι
              (fun x =>
                @Membership.mem.{u_1, u_1} ι (Finset.{u_1} ι)
                  (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} ι) ι (@Finset.instSetLike.{u_1} ι)) J x)
              a))}
  [inst_1 : (i : ι) → TopologicalSpace.{u_2} (α i)] [∀ (i : ι), @OpensMeasurableSpace.{u_2} (α i) (inst_1 i) (inst i)]
  [∀ (i : ι), @SecondCountableTopology.{u_2} (α i) (inst_1 i)]
  [∀ (I : Finset.{u_1} ι),
      @MeasureTheory.IsFiniteMeasure.{max u_1 u_2}
        ((j : ↥I) →
          α
            (@Subtype.val.{u_1 + 1} ι
              (fun x =>
                @Membership.mem.{u_1, u_1} ι (Finset.{u_1} ι)
                  (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} ι) ι (@Finset.instSetLike.{u_1} ι)) I x)
              j))
        (@MeasurableSpace.pi.{u_1, u_2} (↥I)
          (fun j =>
            α
              (@Subtype.val.{u_1 + 1} ι
                (fun x =>
                  @Membership.mem.{u_1, u_1} ι (Finset.{u_1} ι)
                    (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} ι) ι (@Finset.instSetLike.{u_1} ι)) I x)
                j))
          fun a =>
          inst
            (@Subtype.val.{u_1 + 1} ι
              (fun x =>
                @Membership.mem.{u_1, u_1} ι (Finset.{u_1} ι)
                  (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} ι) ι (@Finset.instSetLike.{u_1} ι)) I x)
              a))
        (P I)]
  (hP : @MeasureTheory.IsProjectiveMeasureFamily.{u_1, u_2} ι α inst P),
  (∀ (J : Finset.{u_1} ι),
      @MeasureTheory.Measure.InnerRegularWRT.{max u_1 u_2}
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
                    (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} ι) ι (@Finset.instSetLike.{u_1} ι)) J x)
                j))
          fun a =>
          inst
            (@Subtype.val.{u_1 + 1} ι
              (fun x =>
                @Membership.mem.{u_1, u_1} ι (Finset.{u_1} ι)
                  (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} ι) ι (@Finset.instSetLike.{u_1} ι)) J x)
              a))
        (P J)
        (fun s =>
          And
            (@IsCompact.{max u_1 u_2}
              ((j : ↥J) →
                α
                  (@Subtype.val.{u_1 + 1} ι
                    (fun x =>
                      @Membership.mem.{u_1, u_1} ι (Finset.{u_1} ι)
                        (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} ι) ι (@Finset.instSetLike.{u_1} ι)) J x)
                    j))
              (@Pi.topologicalSpace.{u_2, u_1} (↥J)
                (fun j =>
                  α
                    (@Subtype.val.{u_1 + 1} ι
                      (fun x =>
                        @Membership.mem.{u_1, u_1} ι (Finset.{u_1} ι)
                          (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} ι) ι (@Finset.instSetLike.{u_1} ι)) J x)
                      j))
                fun i =>
                inst_1
                  (@Subtype.val.{u_1 + 1} ι
                    (fun x =>
                      @Membership.mem.{u_1, u_1} ι (Finset.{u_1} ι)
                        (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} ι) ι (@Finset.instSetLike.{u_1} ι)) J x)
                    i))
              s)
            (@IsClosed.{max u_1 u_2}
              ((j : ↥J) →
                α
                  (@Subtype.val.{u_1 + 1} ι
                    (fun x =>
                      @Membership.mem.{u_1, u_1} ι (Finset.{u_1} ι)
                        (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} ι) ι (@Finset.instSetLike.{u_1} ι)) J x)
                    j))
              (@Pi.topologicalSpace.{u_2, u_1} (↥J)
                (fun j =>
                  α
                    (@Subtype.val.{u_1 + 1} ι
                      (fun x =>
                        @Membership.mem.{u_1, u_1} ι (Finset.{u_1} ι)
                          (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} ι) ι (@Finset.instSetLike.{u_1} ι)) J x)
                      j))
                fun i =>
                inst_1
                  (@Subtype.val.{u_1 + 1} ι
                    (fun x =>
                      @Membership.mem.{u_1, u_1} ι (Finset.{u_1} ι)
                        (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} ι) ι (@Finset.instSetLike.{u_1} ι)) J x)
                    i))
              s))
        (@MeasurableSet.{max u_1 u_2}
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
                      (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} ι) ι (@Finset.instSetLike.{u_1} ι)) J x)
                  j))
            fun a =>
            inst
              (@Subtype.val.{u_1 + 1} ι
                (fun x =>
                  @Membership.mem.{u_1, u_1} ι (Finset.{u_1} ι)
                    (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} ι) ι (@Finset.instSetLike.{u_1} ι)) J x)
                a)))) →
    ∀ ⦃f : Nat → Set.{max u_1 u_2} ((i : ι) → α i)⦄,
      (∀ (i : Nat),
          @Membership.mem.{max u_1 u_2, max u_1 u_2} (Set.{max u_1 u_2} ((i : ι) → α i))
            (Set.{max u_2 u_1} (Set.{max u_2 u_1} ((i : ι) → α i)))
            (@Set.instMembership.{max u_1 u_2} (Set.{max u_2 u_1} ((i : ι) → α i)))
            (@MeasureTheory.measurableCylinders.{u_2, u_1} ι α inst) (f i)) →
        @Membership.mem.{max u_1 u_2, max u_1 u_2} (Set.{max u_1 u_2} ((i : ι) → α i))
            (Set.{max u_2 u_1} (Set.{max u_2 u_1} ((i : ι) → α i)))
            (@Set.instMembership.{max u_1 u_2} (Set.{max u_2 u_1} ((i : ι) → α i)))
            (@MeasureTheory.measurableCylinders.{u_2, u_1} ι α inst) (⋃ i, f i) →
          @LE.le.{0} ENNReal ENNReal.instLE
            (@DFunLike.coe.{max (u_1 + 1) (u_2 + 1), max (u_1 + 1) (u_2 + 1), 1}
              (@MeasureTheory.AddContent.{max u_1 u_2, 0} ((i : ι) → α i) ENNReal ENNReal.instAddCommMonoid
                (@MeasureTheory.measurableCylinders.{u_2, u_1} ι α inst))
              (Set.{max u_1 u_2} ((i : ι) → α i)) (fun x => ENNReal)
              (@MeasureTheory.instFunLikeAddContentSet.{max u_1 u_2, 0} ((i : ι) → α i)
                (@MeasureTheory.measurableCylinders.{u_2, u_1} ι α inst) ENNReal ENNReal.instAddCommMonoid)
              (@MeasureTheory.projectiveFamilyContent.{u_1, u_2} ι α inst P hP) (⋃ i, f i))
            (@tsum.{0, 0} ENNReal Nat ENNReal.instAddCommMonoid ENNReal.instTopologicalSpace
              (fun i =>
                @DFunLike.coe.{max (u_1 + 1) (u_2 + 1), max (u_1 + 1) (u_2 + 1), 1}
                  (@MeasureTheory.AddContent.{max u_1 u_2, 0} ((i : ι) → α i) ENNReal ENNReal.instAddCommMonoid
                    (@MeasureTheory.measurableCylinders.{u_2, u_1} ι α inst))
                  (Set.{max u_1 u_2} ((i : ι) → α i)) (fun x => ENNReal)
                  (@MeasureTheory.instFunLikeAddContentSet.{max u_1 u_2, 0} ((i : ι) → α i)
                    (@MeasureTheory.measurableCylinders.{u_2, u_1} ι α inst) ENNReal ENNReal.instAddCommMonoid)
                  (@MeasureTheory.projectiveFamilyContent.{u_1, u_2} ι α inst P hP) (f i))
              (SummationFilter.unconditional.{0} Nat)) :=
⋯
```

## `MeasureTheory.projectiveFamilyContent_sigma_additive_of_innerRegular`

Command: `#print MeasureTheory.projectiveFamilyContent_sigma_additive_of_innerRegular`

```lean
theorem MeasureTheory.projectiveFamilyContent_sigma_additive_of_innerRegular.{u_1, u_2} : ∀ {ι : Type u_1}
  {α : ι → Type u_2} [inst : (i : ι) → MeasurableSpace.{u_2} (α i)]
  {P :
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
                    (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} ι) ι (@Finset.instSetLike.{u_1} ι)) J x)
                j))
          fun a =>
          inst
            (@Subtype.val.{u_1 + 1} ι
              (fun x =>
                @Membership.mem.{u_1, u_1} ι (Finset.{u_1} ι)
                  (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} ι) ι (@Finset.instSetLike.{u_1} ι)) J x)
              a))}
  [inst_1 : (i : ι) → TopologicalSpace.{u_2} (α i)] [∀ (i : ι), @OpensMeasurableSpace.{u_2} (α i) (inst_1 i) (inst i)]
  [∀ (i : ι), @SecondCountableTopology.{u_2} (α i) (inst_1 i)]
  [∀ (I : Finset.{u_1} ι),
      @MeasureTheory.IsFiniteMeasure.{max u_1 u_2}
        ((j : ↥I) →
          α
            (@Subtype.val.{u_1 + 1} ι
              (fun x =>
                @Membership.mem.{u_1, u_1} ι (Finset.{u_1} ι)
                  (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} ι) ι (@Finset.instSetLike.{u_1} ι)) I x)
              j))
        (@MeasurableSpace.pi.{u_1, u_2} (↥I)
          (fun j =>
            α
              (@Subtype.val.{u_1 + 1} ι
                (fun x =>
                  @Membership.mem.{u_1, u_1} ι (Finset.{u_1} ι)
                    (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} ι) ι (@Finset.instSetLike.{u_1} ι)) I x)
                j))
          fun a =>
          inst
            (@Subtype.val.{u_1 + 1} ι
              (fun x =>
                @Membership.mem.{u_1, u_1} ι (Finset.{u_1} ι)
                  (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} ι) ι (@Finset.instSetLike.{u_1} ι)) I x)
              a))
        (P I)]
  (hP : @MeasureTheory.IsProjectiveMeasureFamily.{u_1, u_2} ι α inst P),
  (∀ (J : Finset.{u_1} ι),
      @MeasureTheory.Measure.InnerRegularWRT.{max u_1 u_2}
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
                    (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} ι) ι (@Finset.instSetLike.{u_1} ι)) J x)
                j))
          fun a =>
          inst
            (@Subtype.val.{u_1 + 1} ι
              (fun x =>
                @Membership.mem.{u_1, u_1} ι (Finset.{u_1} ι)
                  (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} ι) ι (@Finset.instSetLike.{u_1} ι)) J x)
              a))
        (P J)
        (fun s =>
          And
            (@IsCompact.{max u_1 u_2}
              ((j : ↥J) →
                α
                  (@Subtype.val.{u_1 + 1} ι
                    (fun x =>
                      @Membership.mem.{u_1, u_1} ι (Finset.{u_1} ι)
                        (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} ι) ι (@Finset.instSetLike.{u_1} ι)) J x)
                    j))
              (@Pi.topologicalSpace.{u_2, u_1} (↥J)
                (fun j =>
                  α
                    (@Subtype.val.{u_1 + 1} ι
                      (fun x =>
                        @Membership.mem.{u_1, u_1} ι (Finset.{u_1} ι)
                          (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} ι) ι (@Finset.instSetLike.{u_1} ι)) J x)
                      j))
                fun i =>
                inst_1
                  (@Subtype.val.{u_1 + 1} ι
                    (fun x =>
                      @Membership.mem.{u_1, u_1} ι (Finset.{u_1} ι)
                        (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} ι) ι (@Finset.instSetLike.{u_1} ι)) J x)
                    i))
              s)
            (@IsClosed.{max u_1 u_2}
              ((j : ↥J) →
                α
                  (@Subtype.val.{u_1 + 1} ι
                    (fun x =>
                      @Membership.mem.{u_1, u_1} ι (Finset.{u_1} ι)
                        (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} ι) ι (@Finset.instSetLike.{u_1} ι)) J x)
                    j))
              (@Pi.topologicalSpace.{u_2, u_1} (↥J)
                (fun j =>
                  α
                    (@Subtype.val.{u_1 + 1} ι
                      (fun x =>
                        @Membership.mem.{u_1, u_1} ι (Finset.{u_1} ι)
                          (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} ι) ι (@Finset.instSetLike.{u_1} ι)) J x)
                      j))
                fun i =>
                inst_1
                  (@Subtype.val.{u_1 + 1} ι
                    (fun x =>
                      @Membership.mem.{u_1, u_1} ι (Finset.{u_1} ι)
                        (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} ι) ι (@Finset.instSetLike.{u_1} ι)) J x)
                    i))
              s))
        (@MeasurableSet.{max u_1 u_2}
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
                      (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} ι) ι (@Finset.instSetLike.{u_1} ι)) J x)
                  j))
            fun a =>
            inst
              (@Subtype.val.{u_1 + 1} ι
                (fun x =>
                  @Membership.mem.{u_1, u_1} ι (Finset.{u_1} ι)
                    (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} ι) ι (@Finset.instSetLike.{u_1} ι)) J x)
                a)))) →
    ∀ ⦃f : Nat → Set.{max u_1 u_2} ((i : ι) → α i)⦄,
      (∀ (i : Nat),
          @Membership.mem.{max u_1 u_2, max u_1 u_2} (Set.{max u_1 u_2} ((i : ι) → α i))
            (Set.{max u_2 u_1} (Set.{max u_2 u_1} ((i : ι) → α i)))
            (@Set.instMembership.{max u_1 u_2} (Set.{max u_2 u_1} ((i : ι) → α i)))
            (@MeasureTheory.measurableCylinders.{u_2, u_1} ι α inst) (f i)) →
        @Membership.mem.{max u_1 u_2, max u_1 u_2} (Set.{max u_1 u_2} ((i : ι) → α i))
            (Set.{max u_2 u_1} (Set.{max u_2 u_1} ((i : ι) → α i)))
            (@Set.instMembership.{max u_1 u_2} (Set.{max u_2 u_1} ((i : ι) → α i)))
            (@MeasureTheory.measurableCylinders.{u_2, u_1} ι α inst) (⋃ i, f i) →
          @Pairwise.{0} Nat
              (@Function.onFun.{1, (max u_1 u_2) + 1, 1} Nat (Set.{max u_1 u_2} ((i : ι) → α i)) Prop
                (@Disjoint.{max u_1 u_2} (Set.{max u_1 u_2} ((i : ι) → α i))
                  (@ChainCompletePartialOrder.toPartialOrder.{max u_1 u_2} (Set.{max u_1 u_2} ((i : ι) → α i))
                    (@ChainCompletePartialOrder.instOfCompleteLattice.{max u_1 u_2} (Set.{max u_1 u_2} ((i : ι) → α i))
                      (@CompleteBooleanAlgebra.toCompleteLattice.{max u_1 u_2} (Set.{max u_1 u_2} ((i : ι) → α i))
                        (@CompleteAtomicBooleanAlgebra.toCompleteBooleanAlgebra.{max u_1 u_2}
                          (Set.{max u_1 u_2} ((i : ι) → α i))
                          (@Set.instCompleteAtomicBooleanAlgebra.{max u_1 u_2} ((i : ι) → α i))))))
                  (@HeytingAlgebra.toOrderBot.{max u_1 u_2} (Set.{max u_1 u_2} ((i : ι) → α i))
                    (@Order.Frame.toHeytingAlgebra.{max u_1 u_2} (Set.{max u_1 u_2} ((i : ι) → α i))
                      (@CompleteDistribLattice.toFrame.{max u_1 u_2} (Set.{max u_1 u_2} ((i : ι) → α i))
                        (@CompleteBooleanAlgebra.toCompleteDistribLattice.{max u_1 u_2}
                          (Set.{max u_1 u_2} ((i : ι) → α i))
                          (@CompleteAtomicBooleanAlgebra.toCompleteBooleanAlgebra.{max u_1 u_2}
                            (Set.{max u_1 u_2} ((i : ι) → α i))
                            (@Set.instCompleteAtomicBooleanAlgebra.{max u_1 u_2} ((i : ι) → α i))))))))
                f) →
            @Eq.{1} ENNReal
              (@DFunLike.coe.{max (u_1 + 1) (u_2 + 1), max (u_1 + 1) (u_2 + 1), 1}
                (@MeasureTheory.AddContent.{max u_1 u_2, 0} ((i : ι) → α i) ENNReal ENNReal.instAddCommMonoid
                  (@MeasureTheory.measurableCylinders.{u_2, u_1} ι α inst))
                (Set.{max u_1 u_2} ((i : ι) → α i)) (fun x => ENNReal)
                (@MeasureTheory.instFunLikeAddContentSet.{max u_1 u_2, 0} ((i : ι) → α i)
                  (@MeasureTheory.measurableCylinders.{u_2, u_1} ι α inst) ENNReal ENNReal.instAddCommMonoid)
                (@MeasureTheory.projectiveFamilyContent.{u_1, u_2} ι α inst P hP) (⋃ i, f i))
              (@tsum.{0, 0} ENNReal Nat ENNReal.instAddCommMonoid ENNReal.instTopologicalSpace
                (fun i =>
                  @DFunLike.coe.{max (u_1 + 1) (u_2 + 1), max (u_1 + 1) (u_2 + 1), 1}
                    (@MeasureTheory.AddContent.{max u_1 u_2, 0} ((i : ι) → α i) ENNReal ENNReal.instAddCommMonoid
                      (@MeasureTheory.measurableCylinders.{u_2, u_1} ι α inst))
                    (Set.{max u_1 u_2} ((i : ι) → α i)) (fun x => ENNReal)
                    (@MeasureTheory.instFunLikeAddContentSet.{max u_1 u_2, 0} ((i : ι) → α i)
                      (@MeasureTheory.measurableCylinders.{u_2, u_1} ι α inst) ENNReal ENNReal.instAddCommMonoid)
                    (@MeasureTheory.projectiveFamilyContent.{u_1, u_2} ι α inst P hP) (f i))
                (SummationFilter.unconditional.{0} Nat)) :=
⋯
```

## `MeasureTheory.projectiveLimit`

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
fun {ι} {α} [inst : (i : ι) → MeasurableSpace.{u_2} (α i)] [(i : ι) → TopologicalSpace.{u_2} (α i)]
    [∀ (i : ι), @BorelSpace.{u_2} (α i) (inst_1 i) (inst i)] [∀ (i : ι), @PolishSpace.{u_2} (α i) (inst_1 i)] P
    [∀ (i : Finset.{u_1} ι),
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
    (@MeasureTheory.projectiveFamilyContent.{u_1, u_2} ι α inst P hP) ⋯ ⋯ ⋯
```

## `MeasureTheory.tendsto_zero_of_regular_addContent`

Command: `#print MeasureTheory.tendsto_zero_of_regular_addContent`

```lean
theorem MeasureTheory.tendsto_zero_of_regular_addContent.{u_1} : ∀ {α : Type u_1} {C R : Set.{u_1} (Set.{u_1} α)}
  {s : Nat → Set.{u_1} α},
  @MeasureTheory.IsSetRing.{u_1} α R →
    ∀ (m : @MeasureTheory.AddContent.{u_1, 0} α ENNReal ENNReal.instAddCommMonoid R),
      (∀ (n : Nat),
          @Membership.mem.{u_1, u_1} (Set.{u_1} α) (Set.{u_1} (Set.{u_1} α)) (@Set.instMembership.{u_1} (Set.{u_1} α)) R
            (s n)) →
        @Antitone.{0, u_1} Nat (Set.{u_1} α) Nat.instPreorder
            (@PartialOrder.toPreorder.{u_1} (Set.{u_1} α)
              (@ChainCompletePartialOrder.toPartialOrder.{u_1} (Set.{u_1} α)
                (@ChainCompletePartialOrder.instOfCompleteLattice.{u_1} (Set.{u_1} α)
                  (@CompleteBooleanAlgebra.toCompleteLattice.{u_1} (Set.{u_1} α)
                    (@CompleteAtomicBooleanAlgebra.toCompleteBooleanAlgebra.{u_1} (Set.{u_1} α)
                      (@Set.instCompleteAtomicBooleanAlgebra.{u_1} α))))))
            s →
          @Eq.{u_1 + 1} (Set.{u_1} α) (⋂ n, s n)
              (@EmptyCollection.emptyCollection.{u_1} (Set.{u_1} α) (@Set.instEmptyCollection.{u_1} α)) →
            @IsCompactSystem.{u_1} α C →
              @LE.le.{u_1} (Set.{u_1} (Set.{u_1} α)) (@Set.instLE.{u_1} (Set.{u_1} α)) C R →
                (∀ (A : Set.{u_1} α),
                    @Membership.mem.{u_1, u_1} (Set.{u_1} α) (Set.{u_1} (Set.{u_1} α))
                        (@Set.instMembership.{u_1} (Set.{u_1} α)) R A →
                      ∀ (ε : ENNReal),
                        @LT.lt.{0} ENNReal
                            (@Preorder.toLT.{0} ENNReal (@PartialOrder.toPreorder.{0} ENNReal ENNReal.instPartialOrder))
                            (@OfNat.ofNat.{0} ENNReal (nat_lit 0) (@Zero.toOfNat0.{0} ENNReal ENNReal.instZero)) ε →
                          ∃ K,
                            And
                              (@Membership.mem.{u_1, u_1} (Set.{u_1} α) (Set.{u_1} (Set.{u_1} α))
                                (@Set.instMembership.{u_1} (Set.{u_1} α)) C K)
                              (And (@LE.le.{u_1} (Set.{u_1} α) (@Set.instLE.{u_1} α) K A)
                                (@LE.le.{0} ENNReal ENNReal.instLE
                                  (@DFunLike.coe.{u_1 + 1, u_1 + 1, 1}
                                    (@MeasureTheory.AddContent.{u_1, 0} α ENNReal ENNReal.instAddCommMonoid R)
                                    (Set.{u_1} α) (fun x => ENNReal)
                                    (@MeasureTheory.instFunLikeAddContentSet.{u_1, 0} α R ENNReal
                                      ENNReal.instAddCommMonoid)
                                    m (@SDiff.sdiff.{u_1} (Set.{u_1} α) (@Set.instSDiff.{u_1} α) A K))
                                  ε))) →
                  @Filter.Tendsto.{0, 0} Nat ENNReal
                    (fun n =>
                      @DFunLike.coe.{u_1 + 1, u_1 + 1, 1}
                        (@MeasureTheory.AddContent.{u_1, 0} α ENNReal ENNReal.instAddCommMonoid R) (Set.{u_1} α)
                        (fun x => ENNReal)
                        (@MeasureTheory.instFunLikeAddContentSet.{u_1, 0} α R ENNReal ENNReal.instAddCommMonoid) m
                        (s n))
                    (@Filter.atTop.{0} Nat Nat.instPreorder)
                    (@nhds.{0} ENNReal ENNReal.instTopologicalSpace
                      (@OfNat.ofNat.{0} ENNReal (nat_lit 0) (@Zero.toOfNat0.{0} ENNReal ENNReal.instZero))) :=
⋯
```

## `MemHolder.mono`

Command: `#print MemHolder.mono`

```lean
theorem MemHolder.mono.{u_3, u_4} : ∀ {X : Type u_3} {Y : Type u_4} [inst : PseudoMetricSpace.{u_3} X]
  [hX : @BoundedSpace.{u_3} X (@PseudoMetricSpace.toBornology.{u_3} X inst)] [inst_1 : PseudoEMetricSpace.{u_4} Y]
  {f : X → Y} {r s : NNReal},
  @MemHolder.{u_3, u_4} X Y (@PseudoMetricSpace.toPseudoEMetricSpace.{u_3} X inst) inst_1 r f →
    @LE.le.{0} NNReal (@Preorder.toLE.{0} NNReal (@PartialOrder.toPreorder.{0} NNReal NNReal.instPartialOrder)) s r →
      @MemHolder.{u_3, u_4} X Y (@PseudoMetricSpace.toPseudoEMetricSpace.{u_3} X inst) inst_1 s f :=
⋯
```

## `Metric.closedEBall_add_closedEBall`

Command: `#print Metric.closedEBall_add_closedEBall`

```lean
theorem Metric.closedEBall_add_closedEBall.{u_1} : ∀ {E : Type u_1} [inst : SeminormedAddCommGroup.{u_1} E]
  [@NormedSpace.{0, u_1} Real E Real.normedField inst]
  [@ProperSpace.{u_1} E (@SeminormedAddCommGroup.toPseudoMetricSpace.{u_1} E inst)] (x y : E) (r s : ENNReal),
  @Eq.{u_1 + 1} (Set.{u_1} E)
    (@HAdd.hAdd.{u_1, u_1, u_1} (Set.{u_1} E) (Set.{u_1} E) (Set.{u_1} E)
      (@instHAdd.{u_1} (Set.{u_1} E)
        (@Set.add.{u_1} E
          (@AddCommMagma.toAdd.{u_1} E
            (@AddCommSemigroup.toAddCommMagma.{u_1} E
              (@AddCommMonoid.toAddCommSemigroup.{u_1} E
                (@AddCommGroup.toAddCommMonoid.{u_1} E (@SeminormedAddCommGroup.toAddCommGroup.{u_1} E inst)))))))
      (@Metric.closedEBall.{u_1} E
        (@PseudoMetricSpace.toPseudoEMetricSpace.{u_1} E (@SeminormedAddCommGroup.toPseudoMetricSpace.{u_1} E inst)) x
        r)
      (@Metric.closedEBall.{u_1} E
        (@PseudoMetricSpace.toPseudoEMetricSpace.{u_1} E (@SeminormedAddCommGroup.toPseudoMetricSpace.{u_1} E inst)) y
        s))
    (@Metric.closedEBall.{u_1} E
      (@PseudoMetricSpace.toPseudoEMetricSpace.{u_1} E (@SeminormedAddCommGroup.toPseudoMetricSpace.{u_1} E inst))
      (@HAdd.hAdd.{u_1, u_1, u_1} E E E
        (@instHAdd.{u_1} E
          (@AddCommMagma.toAdd.{u_1} E
            (@AddCommSemigroup.toAddCommMagma.{u_1} E
              (@AddCommMonoid.toAddCommSemigroup.{u_1} E
                (@AddCommGroup.toAddCommMonoid.{u_1} E (@SeminormedAddCommGroup.toAddCommGroup.{u_1} E inst))))))
        x y)
      (@HAdd.hAdd.{0, 0, 0} ENNReal ENNReal ENNReal (@instHAdd.{0} ENNReal ENNReal.instAdd) r s)) :=
⋯
```

## `Metric.nonempty_closedEBall`

Command: `#print Metric.nonempty_closedEBall`

```lean
theorem Metric.nonempty_closedEBall.{u_1} : ∀ {E : Type u_1} [inst : PseudoEMetricSpace.{u_1} E] {x : E} {r : ENNReal},
  @Set.Nonempty.{u_1} E (@Metric.closedEBall.{u_1} E inst x r) :=
⋯
```

## `Module.finrank_ne_zero`

Command: `#print Module.finrank_ne_zero`

```lean
theorem Module.finrank_ne_zero.{u_1, u_2} : ∀ {R : Type u_1} {M : Type u_2} [inst : Ring.{u_1} R]
  [inst_1 : AddCommGroup.{u_2} M]
  [inst_2 :
    @_root_.Module.{u_1, u_2} R M (@Ring.toSemiring.{u_1} R inst) (@AddCommGroup.toAddCommMonoid.{u_2} M inst_1)]
  [@StrongRankCondition.{u_1} R (@Ring.toSemiring.{u_1} R inst)]
  [@Module.Finite.{u_1, u_2} R M (@Ring.toSemiring.{u_1} R inst) (@AddCommGroup.toAddCommMonoid.{u_2} M inst_1) inst_2]
  [@IsDomain.{u_1} R (@Ring.toSemiring.{u_1} R inst)]
  [@Module.IsTorsionFree.{u_1, u_2} R M (@Ring.toSemiring.{u_1} R inst) (@AddCommGroup.toAddCommMonoid.{u_2} M inst_1)
      inst_2]
  [h : Nontrivial.{u_2} M],
  @Ne.{1} Nat
    (@Module.finrank.{u_1, u_2} R M (@Ring.toSemiring.{u_1} R inst) (@AddCommGroup.toAddCommMonoid.{u_2} M inst_1)
      inst_2)
    (@OfNat.ofNat.{0} Nat (nat_lit 0) (instOfNatNat (nat_lit 0))) :=
⋯
```

## `ProbabilityTheory.Cp`

Command: `#print ProbabilityTheory.Cp`

```lean
def ProbabilityTheory.Cp : Real → Real → Real → ENNReal :=
fun d p q =>
  @Max.max.{0} ENNReal ENNReal.instMax
    (@HDiv.hDiv.{0, 0, 0} ENNReal ENNReal ENNReal
      (@instHDiv.{0} ENNReal (@DivInvMonoid.toDiv.{0} ENNReal ENNReal.instDivInvMonoid))
      (@OfNat.ofNat.{0} ENNReal (nat_lit 1) (@One.toOfNat1.{0} ENNReal ENNReal.instOne))
      (@HPow.hPow.{0, 0, 0} ENNReal Real ENNReal (@instHPow.{0, 0} ENNReal Real ENNReal.instPowReal)
        (@HSub.hSub.{0, 0, 0} ENNReal ENNReal ENNReal (@instHSub.{0} ENNReal ENNReal.instSub)
          (@HPow.hPow.{0, 0, 0} ENNReal Real ENNReal (@instHPow.{0, 0} ENNReal Real ENNReal.instPowReal)
            (@OfNat.ofNat.{0} ENNReal (nat_lit 2)
              (@instOfNatAtLeastTwo.{0} ENNReal (nat_lit 2)
                (@AddMonoidWithOne.toNatCast.{0} ENNReal
                  (@AddCommMonoidWithOne.toAddMonoidWithOne.{0} ENNReal ENNReal.instAddCommMonoidWithOne))
                ProbabilityTheory.Cp._proof_1))
            (@HDiv.hDiv.{0, 0, 0} Real Real Real
              (@instHDiv.{0} Real (@DivInvMonoid.toDiv.{0} Real Real.instDivInvMonoid))
              (@HSub.hSub.{0, 0, 0} Real Real Real (@instHSub.{0} Real Real.instSub) q d) p))
          (@OfNat.ofNat.{0} ENNReal (nat_lit 1) (@One.toOfNat1.{0} ENNReal ENNReal.instOne)))
        p))
    (@HDiv.hDiv.{0, 0, 0} ENNReal ENNReal ENNReal
      (@instHDiv.{0} ENNReal (@DivInvMonoid.toDiv.{0} ENNReal ENNReal.instDivInvMonoid))
      (@OfNat.ofNat.{0} ENNReal (nat_lit 1) (@One.toOfNat1.{0} ENNReal ENNReal.instOne))
      (@HSub.hSub.{0, 0, 0} ENNReal ENNReal ENNReal (@instHSub.{0} ENNReal ENNReal.instSub)
        (@HPow.hPow.{0, 0, 0} ENNReal Real ENNReal (@instHPow.{0, 0} ENNReal Real ENNReal.instPowReal)
          (@OfNat.ofNat.{0} ENNReal (nat_lit 2)
            (@instOfNatAtLeastTwo.{0} ENNReal (nat_lit 2)
              (@AddMonoidWithOne.toNatCast.{0} ENNReal
                (@AddCommMonoidWithOne.toAddMonoidWithOne.{0} ENNReal ENNReal.instAddCommMonoidWithOne))
              ProbabilityTheory.Cp._proof_1))
          (@HSub.hSub.{0, 0, 0} Real Real Real (@instHSub.{0} Real Real.instSub) q d))
        (@OfNat.ofNat.{0} ENNReal (nat_lit 1) (@One.toOfNat1.{0} ENNReal ENNReal.instOne))))
```

## `ProbabilityTheory.IsFilteredPreBrownian`

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

## `ProbabilityTheory.IsLimitOfIndicator`

Command: `#print ProbabilityTheory.IsLimitOfIndicator`

```lean
def ProbabilityTheory.IsLimitOfIndicator.{u_1, u_2, u_3} : {T : Type u_1} →
  {Ω : Type u_2} →
    {E : Type u_3} →
      {mΩ : MeasurableSpace.{u_2} Ω} →
        [PseudoEMetricSpace.{u_3} E] →
          [hE : Nonempty.{u_3 + 1} E] →
            [inst : TopologicalSpace.{u_1} T] →
              [@SecondCountableTopology.{u_1} T inst] →
                (T → Ω → E) → (T → Ω → E) → @MeasureTheory.Measure.{u_2} Ω mΩ → Set.{u_1} T → Prop :=
fun {T} {Ω} {E} {mΩ} [inst : PseudoEMetricSpace.{u_3} E] [hE : Nonempty.{u_3 + 1} E] [inst_1 : TopologicalSpace.{u_1} T]
    [inst_2 : @SecondCountableTopology.{u_1} T inst_1] Y X P U =>
  ∃ A,
    And (@MeasurableSet.{u_2} Ω mΩ A)
      (And
        (@Filter.Eventually.{u_2} Ω
          (fun ω => @Membership.mem.{u_2, u_2} Ω (Set.{u_2} Ω) (@Set.instMembership.{u_2} Ω) A ω)
          (@MeasureTheory.ae.{u_2, u_2} Ω (@MeasureTheory.Measure.{u_2} Ω mΩ)
            (@MeasureTheory.Measure.instFunLike.{u_2} Ω mΩ) ⋯ P))
        (And
          (∀ (t : T),
            @Membership.mem.{u_1, u_1} T (Set.{u_1} T) (@Set.instMembership.{u_1} T) U t →
              ∀ (ω : Ω),
                @Membership.mem.{u_2, u_2} Ω (Set.{u_2} Ω) (@Set.instMembership.{u_2} Ω) A ω →
                  ∃ c,
                    @Filter.Tendsto.{u_1, u_3} (@Set.Elem.{u_1} T (@denseCountable.{u_1} T inst_1 inst_2)) E
                      (fun t' =>
                        X
                          (@Subtype.val.{u_1 + 1} T
                            (fun x =>
                              @Membership.mem.{u_1, u_1} T (Set.{u_1} T) (@Set.instMembership.{u_1} T)
                                (@denseCountable.{u_1} T inst_1 inst_2) x)
                            t')
                          ω)
                      (@Filter.comap.{u_1, u_1} (@Set.Elem.{u_1} T (@denseCountable.{u_1} T inst_1 inst_2)) T
                        (@Subtype.val.{u_1 + 1} T fun x =>
                          @Membership.mem.{u_1, u_1} T (Set.{u_1} T) (@Set.instMembership.{u_1} T)
                            (@denseCountable.{u_1} T inst_1 inst_2) x)
                        (@nhds.{u_1} T inst_1 t))
                      (@nhds.{u_3} E
                        (@UniformSpace.toTopologicalSpace.{u_3} E (@PseudoEMetricSpace.toUniformSpace.{u_3} E inst)) c))
          (And
            (∀ (t : T),
              @Membership.mem.{u_1, u_1} T (Set.{u_1} T) (@Set.instMembership.{u_1} T) U t →
                ∀ (ω : Ω),
                  @Eq.{1} ENNReal
                    (@EDist.edist.{u_3} E
                      (@WeakPseudoEMetricSpace.toEDist.{u_3} E
                        (@UniformSpace.toTopologicalSpace.{u_3} E (@PseudoEMetricSpace.toUniformSpace.{u_3} E inst))
                        (@PseudoEMetricSpace.toWeakPseudoEMetricSpace.{u_3} E inst))
                      (Y t ω)
                      (@Dense.extend.{u_1, u_3} T E inst_1
                        (@UniformSpace.toTopologicalSpace.{u_3} E (@PseudoEMetricSpace.toUniformSpace.{u_3} E inst))
                        (@denseCountable.{u_1} T inst_1 inst_2) ⋯
                        (fun t' =>
                          @ProbabilityTheory.indicatorProcess.{u_1, u_2, u_3} T Ω E hE X A
                            (@Subtype.val.{u_1 + 1} T
                              (fun x =>
                                @Membership.mem.{u_1, u_1} T (Set.{u_1} T) (@Set.instMembership.{u_1} T)
                                  (@denseCountable.{u_1} T inst_1 inst_2) x)
                              t')
                            ω)
                        t))
                    (@OfNat.ofNat.{0} ENNReal (nat_lit 0) (@Zero.toOfNat0.{0} ENNReal ENNReal.instZero)))
            (∀ t ∉ U,
              ∀ (ω : Ω),
                @Eq.{1} ENNReal
                  (@EDist.edist.{u_3} E
                    (@WeakPseudoEMetricSpace.toEDist.{u_3} E
                      (@UniformSpace.toTopologicalSpace.{u_3} E (@PseudoEMetricSpace.toUniformSpace.{u_3} E inst))
                      (@PseudoEMetricSpace.toWeakPseudoEMetricSpace.{u_3} E inst))
                    (Y t ω) (@Nonempty.some.{u_3 + 1} E hE))
                  (@OfNat.ofNat.{0} ENNReal (nat_lit 0) (@Zero.toOfNat0.{0} ENNReal ENNReal.instZero))))))
```

## `ProbabilityTheory.IsProbabilityMeasure_gaussianLimit`

Command: `#print ProbabilityTheory.IsProbabilityMeasure_gaussianLimit`

```lean
theorem ProbabilityTheory.IsProbabilityMeasure_gaussianLimit : @MeasureTheory.IsProbabilityMeasure.{0} (NNReal → Real)
  (@MeasurableSpace.pi.{0, 0} NNReal (fun a => Real) fun a => Real.measurableSpace) ProbabilityTheory.gaussianLimit :=
⋯
```

## `ProbabilityTheory.ae_mem_holderSet`

Command: `#print ProbabilityTheory.ae_mem_holderSet`

```lean
theorem ProbabilityTheory.ae_mem_holderSet.{u_1, u_2, u_3} : ∀ {T : Type u_1} {Ω : Type u_2} {E : Type u_3}
  {mΩ : MeasurableSpace.{u_2} Ω} {X : T → Ω → E} {c : ENNReal} {d p q : Real} {M β : NNReal}
  {P : @MeasureTheory.Measure.{u_2} Ω mΩ} {U : Set.{u_1} T} [inst : PseudoEMetricSpace.{u_1} T]
  [inst_1 : PseudoEMetricSpace.{u_3} E] [inst_2 : MeasurableSpace.{u_3} E]
  [@BorelSpace.{u_3} E (@UniformSpace.toTopologicalSpace.{u_3} E (@PseudoEMetricSpace.toUniformSpace.{u_3} E inst_1))
      inst_2],
  @HasBoundedCoveringNumber.{u_1} T inst U c d →
    @ProbabilityTheory.IsKolmogorovProcess.{u_1, u_2, u_3} T Ω E inst mΩ inst_1 X P p q M →
      @Ne.{1} ENNReal c (@Top.top.{0} ENNReal ENNReal.instTop) →
        @LT.lt.{0} Real Real.instLT (@OfNat.ofNat.{0} Real (nat_lit 0) (@Zero.toOfNat0.{0} Real Real.instZero)) d →
          @LT.lt.{0} Real Real.instLT d q →
            @LT.lt.{0} NNReal (@Preorder.toLT.{0} NNReal (@PartialOrder.toPreorder.{0} NNReal NNReal.instPartialOrder))
                (@OfNat.ofNat.{0} NNReal (nat_lit 0) (@Zero.toOfNat0.{0} NNReal NNReal.instZero)) β →
              @LT.lt.{0} Real Real.instLT (↑β)
                  (@HDiv.hDiv.{0, 0, 0} Real Real Real
                    (@instHDiv.{0} Real (@DivInvMonoid.toDiv.{0} Real Real.instDivInvMonoid))
                    (@HSub.hSub.{0, 0, 0} Real Real Real (@instHSub.{0} Real Real.instSub) q d) p) →
                ∀ {T' : Set.{u_1} T},
                  @Set.Countable.{u_1} T T' →
                    @Filter.Eventually.{u_2} Ω
                      (fun ω =>
                        @Membership.mem.{u_2, u_2} Ω (Set.{u_2} Ω) (@Set.instMembership.{u_2} Ω)
                          (@ProbabilityTheory.holderSet.{u_1, u_2, u_3} T Ω E inst inst_1 X T' p (↑β) U) ω)
                      (@MeasureTheory.ae.{u_2, u_2} Ω (@MeasureTheory.Measure.{u_2} Ω mΩ)
                        (@MeasureTheory.Measure.instFunLike.{u_2} Ω mΩ) ⋯ P) :=
⋯
```

## `ProbabilityTheory.brownian`

Command: `#print ProbabilityTheory.brownian`

```lean
def ProbabilityTheory.brownian : NNReal → (NNReal → Real) → Real :=
@ProbabilityTheory.IsPreBrownianReal.mk.{0} (NNReal → Real)
  (@MeasurableSpace.pi.{0, 0} NNReal (fun a => Real) fun a => Real.measurableSpace) ProbabilityTheory.gaussianLimit
  ProbabilityTheory.preBrownian ProbabilityTheory.isPreBrownianReal_preBrownian
```

## `ProbabilityTheory.brownianCovMatrix`

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

## `ProbabilityTheory.centralMoment_fun_two_mul_gaussianReal`

Command: `#print ProbabilityTheory.centralMoment_fun_two_mul_gaussianReal`

```lean
theorem ProbabilityTheory.centralMoment_fun_two_mul_gaussianReal : ∀ (μ : Real) (σ : NNReal) (n : Nat),
  @Eq.{1} Real
    (@ProbabilityTheory.centralMoment.{0} Real Real.measurableSpace (fun x => x)
      (@HMul.hMul.{0, 0, 0} Nat Nat Nat (@instHMul.{0} Nat instMulNat)
        (@OfNat.ofNat.{0} Nat (nat_lit 2) (instOfNatNat (nat_lit 2))) n)
      (ProbabilityTheory.gaussianReal μ
        (@HPow.hPow.{0, 0, 0} NNReal Nat NNReal
          (@instHPow.{0, 0} NNReal Nat
            (@NPow.toPow.{0} NNReal (@Monoid.toNPow.{0} NNReal (@Semiring.toMonoid.{0} NNReal NNReal.instSemiring))))
          σ (@OfNat.ofNat.{0} Nat (nat_lit 2) (instOfNatNat (nat_lit 2))))))
    (@HMul.hMul.{0, 0, 0} Real Real Real (@instHMul.{0} Real Real.instMul)
      (@HPow.hPow.{0, 0, 0} Real Nat Real
        (@instHPow.{0, 0} Real Nat (@NPow.toPow.{0} Real (@Monoid.toNPow.{0} Real Real.instMonoid))) (↑σ)
        (@HMul.hMul.{0, 0, 0} Nat Nat Nat (@instHMul.{0} Nat instMulNat)
          (@OfNat.ofNat.{0} Nat (nat_lit 2) (instOfNatNat (nat_lit 2))) n))
      (@Nat.cast.{0} Real Real.instNatCast
        (@HSub.hSub.{0, 0, 0} Nat Nat Nat (@instHSub.{0} Nat instSubNat)
            (@HMul.hMul.{0, 0, 0} Nat Nat Nat (@instHMul.{0} Nat instMulNat)
              (@OfNat.ofNat.{0} Nat (nat_lit 2) (instOfNatNat (nat_lit 2))) n)
            (@OfNat.ofNat.{0} Nat (nat_lit 1) (instOfNatNat (nat_lit 1)))).doubleFactorial)) :=
⋯
```

## `ProbabilityTheory.centralMoment_of_integral_id_eq_zero`

Command: `#print ProbabilityTheory.centralMoment_of_integral_id_eq_zero`

```lean
theorem ProbabilityTheory.centralMoment_of_integral_id_eq_zero.{u_1} : ∀ {Ω : Type u_1} {mΩ : MeasurableSpace.{u_1} Ω}
  {μ : @MeasureTheory.Measure.{u_1} Ω mΩ} {X : Ω → Real} (p : Nat),
  @Eq.{1} Real
      (@MeasureTheory.integral.{u_1, 0} Ω Real Real.normedAddCommGroup
        (@InnerProductSpace.toNormedSpace.{0, 0} Real Real Real.instRCLike
          (@NormedAddCommGroup.toSeminormedAddCommGroup.{0} Real Real.normedAddCommGroup)
          (@RCLike.toInnerProductSpaceReal.{0} Real Real.instRCLike))
        mΩ μ fun x => X x)
      (@OfNat.ofNat.{0} Real (nat_lit 0) (@Zero.toOfNat0.{0} Real Real.instZero)) →
    @Eq.{1} Real (@ProbabilityTheory.centralMoment.{u_1} Ω mΩ X p μ)
      (@MeasureTheory.integral.{u_1, 0} Ω Real Real.normedAddCommGroup
        (@InnerProductSpace.toNormedSpace.{0, 0} Real Real Real.instRCLike
          (@NormedAddCommGroup.toSeminormedAddCommGroup.{0} Real Real.normedAddCommGroup)
          (@RCLike.toInnerProductSpaceReal.{0} Real Real.instRCLike))
        mΩ μ fun ω =>
        @HPow.hPow.{0, 0, 0} Real Nat Real
          (@instHPow.{0, 0} Real Nat (@NPow.toPow.{0} Real (@Monoid.toNPow.{0} Real Real.instMonoid))) (X ω) p) :=
⋯
```

## `ProbabilityTheory.centralMoment_two_mul_gaussianReal`

Command: `#print ProbabilityTheory.centralMoment_two_mul_gaussianReal`

```lean
theorem ProbabilityTheory.centralMoment_two_mul_gaussianReal : ∀ (μ : Real) (σ : NNReal) (n : Nat),
  @Eq.{1} Real
    (@ProbabilityTheory.centralMoment.{0} Real Real.measurableSpace (@id.{1} Real)
      (@HMul.hMul.{0, 0, 0} Nat Nat Nat (@instHMul.{0} Nat instMulNat)
        (@OfNat.ofNat.{0} Nat (nat_lit 2) (instOfNatNat (nat_lit 2))) n)
      (ProbabilityTheory.gaussianReal μ
        (@HPow.hPow.{0, 0, 0} NNReal Nat NNReal
          (@instHPow.{0, 0} NNReal Nat
            (@NPow.toPow.{0} NNReal (@Monoid.toNPow.{0} NNReal (@Semiring.toMonoid.{0} NNReal NNReal.instSemiring))))
          σ (@OfNat.ofNat.{0} Nat (nat_lit 2) (instOfNatNat (nat_lit 2))))))
    (@HMul.hMul.{0, 0, 0} Real Real Real (@instHMul.{0} Real Real.instMul)
      (@HPow.hPow.{0, 0, 0} Real Nat Real
        (@instHPow.{0, 0} Real Nat (@NPow.toPow.{0} Real (@Monoid.toNPow.{0} Real Real.instMonoid))) (↑σ)
        (@HMul.hMul.{0, 0, 0} Nat Nat Nat (@instHMul.{0} Nat instMulNat)
          (@OfNat.ofNat.{0} Nat (nat_lit 2) (instOfNatNat (nat_lit 2))) n))
      (@Nat.cast.{0} Real Real.instNatCast
        (@HSub.hSub.{0, 0, 0} Nat Nat Nat (@instHSub.{0} Nat instSubNat)
            (@HMul.hMul.{0, 0, 0} Nat Nat Nat (@instHMul.{0} Nat instMulNat)
              (@OfNat.ofNat.{0} Nat (nat_lit 2) (instOfNatNat (nat_lit 2))) n)
            (@OfNat.ofNat.{0} Nat (nat_lit 1) (instOfNatNat (nat_lit 1)))).doubleFactorial)) :=
⋯
```

## `ProbabilityTheory.constL`

Command: `#print ProbabilityTheory.constL`

```lean
def ProbabilityTheory.constL.{u_4} : (T : Type u_4) →
  [PseudoEMetricSpace.{u_4} T] → ENNReal → Real → Real → Real → Real → Set.{u_4} T → ENNReal :=
fun T [inst : PseudoEMetricSpace.{u_4} T] c d p q β U =>
  @HMul.hMul.{0, 0, 0} ENNReal ENNReal ENNReal
    (@instHMul.{0} ENNReal
      (@Distrib.toMul.{0} ENNReal
        (@instDistribOfSemiring.{0} ENNReal (@CommSemiring.toSemiring.{0} ENNReal ENNReal.instCommSemiring))))
    (@HMul.hMul.{0, 0, 0} ENNReal ENNReal ENNReal
      (@instHMul.{0} ENNReal
        (@Distrib.toMul.{0} ENNReal
          (@instDistribOfSemiring.{0} ENNReal (@CommSemiring.toSemiring.{0} ENNReal ENNReal.instCommSemiring))))
      (@HMul.hMul.{0, 0, 0} ENNReal ENNReal ENNReal
        (@instHMul.{0} ENNReal
          (@Distrib.toMul.{0} ENNReal
            (@instDistribOfSemiring.{0} ENNReal (@CommSemiring.toSemiring.{0} ENNReal ENNReal.instCommSemiring))))
        (@HPow.hPow.{0, 0, 0} ENNReal Real ENNReal (@instHPow.{0, 0} ENNReal Real ENNReal.instPowReal)
          (@OfNat.ofNat.{0} ENNReal (nat_lit 2)
            (@instOfNatAtLeastTwo.{0} ENNReal (nat_lit 2)
              (@AddMonoidWithOne.toNatCast.{0} ENNReal
                (@AddCommMonoidWithOne.toAddMonoidWithOne.{0} ENNReal ENNReal.instAddCommMonoidWithOne))
              ProbabilityTheory.constL._proof_1))
          (@HAdd.hAdd.{0, 0, 0} Real Real Real (@instHAdd.{0} Real Real.instAdd)
            (@HAdd.hAdd.{0, 0, 0} Real Real Real (@instHAdd.{0} Real Real.instAdd)
              (@HMul.hMul.{0, 0, 0} Real Real Real (@instHMul.{0} Real Real.instMul)
                (@OfNat.ofNat.{0} Real (nat_lit 2)
                  (@instOfNatAtLeastTwo.{0} Real (nat_lit 2) Real.instNatCast ProbabilityTheory.constL._proof_1))
                p)
              (@HMul.hMul.{0, 0, 0} Real Real Real (@instHMul.{0} Real Real.instMul)
                (@OfNat.ofNat.{0} Real (nat_lit 5)
                  (@instOfNatAtLeastTwo.{0} Real (nat_lit 5) Real.instNatCast ProbabilityTheory.constL._proof_2))
                q))
            (@OfNat.ofNat.{0} Real (nat_lit 1) (@One.toOfNat1.{0} Real Real.instOne))))
        c)
      (@HPow.hPow.{0, 0, 0} ENNReal Real ENNReal (@instHPow.{0, 0} ENNReal Real ENNReal.instPowReal)
        (@HAdd.hAdd.{0, 0, 0} ENNReal ENNReal ENNReal (@instHAdd.{0} ENNReal ENNReal.instAdd)
          (@Metric.ediam.{u_4} T inst U)
          (@OfNat.ofNat.{0} ENNReal (nat_lit 1) (@One.toOfNat1.{0} ENNReal ENNReal.instOne)))
        (@HSub.hSub.{0, 0, 0} Real Real Real (@instHSub.{0} Real Real.instSub) q d)))
    (@tsum.{0, 0} ENNReal Nat ENNReal.instAddCommMonoid ENNReal.instTopologicalSpace
      (fun k =>
        @HMul.hMul.{0, 0, 0} ENNReal ENNReal ENNReal
          (@instHMul.{0} ENNReal
            (@Distrib.toMul.{0} ENNReal
              (@instDistribOfSemiring.{0} ENNReal (@CommSemiring.toSemiring.{0} ENNReal ENNReal.instCommSemiring))))
          (@HPow.hPow.{0, 0, 0} ENNReal Real ENNReal (@instHPow.{0, 0} ENNReal Real ENNReal.instPowReal)
            (@OfNat.ofNat.{0} ENNReal (nat_lit 2)
              (@instOfNatAtLeastTwo.{0} ENNReal (nat_lit 2)
                (@AddMonoidWithOne.toNatCast.{0} ENNReal
                  (@AddCommMonoidWithOne.toAddMonoidWithOne.{0} ENNReal ENNReal.instAddCommMonoidWithOne))
                ProbabilityTheory.constL._proof_1))
            (@HMul.hMul.{0, 0, 0} Real Real Real (@instHMul.{0} Real Real.instMul)
              (@Nat.cast.{0} Real Real.instNatCast k)
              (@HSub.hSub.{0, 0, 0} Real Real Real (@instHSub.{0} Real Real.instSub)
                (@HMul.hMul.{0, 0, 0} Real Real Real (@instHMul.{0} Real Real.instMul) β p)
                (@HSub.hSub.{0, 0, 0} Real Real Real (@instHSub.{0} Real Real.instSub) q d))))
          (@HAdd.hAdd.{0, 0, 0} ENNReal ENNReal ENNReal (@instHAdd.{0} ENNReal ENNReal.instAdd)
            (@HMul.hMul.{0, 0, 0} ENNReal ENNReal ENNReal
              (@instHMul.{0} ENNReal
                (@Distrib.toMul.{0} ENNReal
                  (@instDistribOfSemiring.{0} ENNReal (@CommSemiring.toSemiring.{0} ENNReal ENNReal.instCommSemiring))))
              (@HPow.hPow.{0, 0, 0} ENNReal Real ENNReal (@instHPow.{0, 0} ENNReal Real ENNReal.instPowReal)
                (@OfNat.ofNat.{0} ENNReal (nat_lit 4)
                  (@instOfNatAtLeastTwo.{0} ENNReal (nat_lit 4)
                    (@AddMonoidWithOne.toNatCast.{0} ENNReal
                      (@AddCommMonoidWithOne.toAddMonoidWithOne.{0} ENNReal ENNReal.instAddCommMonoidWithOne))
                    ProbabilityTheory.constL._proof_3))
                d)
              (@HPow.hPow.{0, 0, 0} ENNReal Real ENNReal (@instHPow.{0, 0} ENNReal Real ENNReal.instPowReal)
                (ENNReal.ofReal
                  (@HAdd.hAdd.{0, 0, 0} Real Real Real (@instHAdd.{0} Real Real.instAdd)
                    (Real.logb
                      (@OfNat.ofNat.{0} Real (nat_lit 2)
                        (@instOfNatAtLeastTwo.{0} Real (nat_lit 2) Real.instNatCast ProbabilityTheory.constL._proof_1))
                      c.toReal)
                    (@HMul.hMul.{0, 0, 0} Real Real Real (@instHMul.{0} Real Real.instMul)
                      (@HAdd.hAdd.{0, 0, 0} Real Real Real (@instHAdd.{0} Real Real.instAdd)
                        (@Nat.cast.{0} Real Real.instNatCast k)
                        (@OfNat.ofNat.{0} Real (nat_lit 2)
                          (@instOfNatAtLeastTwo.{0} Real (nat_lit 2) Real.instNatCast
                            ProbabilityTheory.constL._proof_1)))
                      d)))
                q))
            (ProbabilityTheory.Cp d p q)))
      (SummationFilter.unconditional.{0} Nat))
```

## `ProbabilityTheory.constL_lt_top`

Command: `#print ProbabilityTheory.constL_lt_top`

```lean
theorem ProbabilityTheory.constL_lt_top.{u_1} : ∀ {T : Type u_1} {c : ENNReal} {d p q : Real} {β : NNReal}
  {U : Set.{u_1} T} [inst : PseudoEMetricSpace.{u_1} T],
  @LT.lt.{0} ENNReal (@Preorder.toLT.{0} ENNReal (@PartialOrder.toPreorder.{0} ENNReal ENNReal.instPartialOrder))
      (@Metric.ediam.{u_1} T inst U) (@Top.top.{0} ENNReal ENNReal.instTop) →
    @Ne.{1} ENNReal c (@Top.top.{0} ENNReal ENNReal.instTop) →
      @LT.lt.{0} Real Real.instLT (@OfNat.ofNat.{0} Real (nat_lit 0) (@Zero.toOfNat0.{0} Real Real.instZero)) d →
        @LT.lt.{0} Real Real.instLT (@OfNat.ofNat.{0} Real (nat_lit 0) (@Zero.toOfNat0.{0} Real Real.instZero)) p →
          @LT.lt.{0} Real Real.instLT d q →
            @LT.lt.{0} Real Real.instLT (↑β)
                (@HDiv.hDiv.{0, 0, 0} Real Real Real
                  (@instHDiv.{0} Real (@DivInvMonoid.toDiv.{0} Real Real.instDivInvMonoid))
                  (@HSub.hSub.{0, 0, 0} Real Real Real (@instHSub.{0} Real Real.instSub) q d) p) →
              @LT.lt.{0} ENNReal
                (@Preorder.toLT.{0} ENNReal (@PartialOrder.toPreorder.{0} ENNReal ENNReal.instPartialOrder))
                (@ProbabilityTheory.constL.{u_1} T inst c d p q (↑β) U) (@Top.top.{0} ENNReal ENNReal.instTop) :=
⋯
```

## `ProbabilityTheory.continuousOn_holderModification`

Command: `#print ProbabilityTheory.continuousOn_holderModification`

```lean
theorem ProbabilityTheory.continuousOn_holderModification.{u_1, u_2, u_3} : ∀ {T : Type u_1} {Ω : Type u_2}
  {E : Type u_3} {mΩ : MeasurableSpace.{u_2} Ω} {X : T → Ω → E} {c : ENNReal} {d p q : Real} {M β : NNReal}
  {P : @MeasureTheory.Measure.{u_2} Ω mΩ} {U : Set.{u_1} T} [inst : PseudoEMetricSpace.{u_1} T]
  [inst_1 : PseudoEMetricSpace.{u_3} E] [@CompleteSpace.{u_3} E (@PseudoEMetricSpace.toUniformSpace.{u_3} E inst_1)]
  [hE : Nonempty.{u_3 + 1} E]
  [inst_3 :
    @SecondCountableTopology.{u_1} T
      (@UniformSpace.toTopologicalSpace.{u_1} T (@PseudoEMetricSpace.toUniformSpace.{u_1} T inst))],
  @HasBoundedCoveringNumber.{u_1} T inst U c d →
    ∀
      [inst_4 :
        @DecidablePred.{u_1 + 1} T fun x =>
          @Membership.mem.{u_1, u_1} T (Set.{u_1} T) (@Set.instMembership.{u_1} T) U x],
      @IsOpen.{u_1} T (@UniformSpace.toTopologicalSpace.{u_1} T (@PseudoEMetricSpace.toUniformSpace.{u_1} T inst)) U →
        @ProbabilityTheory.IsKolmogorovProcess.{u_1, u_2, u_3} T Ω E inst mΩ inst_1 X P p q M →
          @LT.lt.{0} NNReal (@Preorder.toLT.{0} NNReal (@PartialOrder.toPreorder.{0} NNReal NNReal.instPartialOrder))
              (@OfNat.ofNat.{0} NNReal (nat_lit 0) (@Zero.toOfNat0.{0} NNReal NNReal.instZero)) β →
            ∀ (ω : Ω),
              @ContinuousOn.{u_1, u_3} T E
                (@UniformSpace.toTopologicalSpace.{u_1} T (@PseudoEMetricSpace.toUniformSpace.{u_1} T inst))
                (@UniformSpace.toTopologicalSpace.{u_3} E (@PseudoEMetricSpace.toUniformSpace.{u_3} E inst_1))
                (fun t =>
                  @ProbabilityTheory.holderModification.{u_1, u_2, u_3} T Ω E inst inst_1 hE inst_3 X β p U inst_4 t ω)
                U :=
⋯
```

## `ProbabilityTheory.continuousOn_of_mem_holderSet`

Command: `#print ProbabilityTheory.continuousOn_of_mem_holderSet`

```lean
theorem ProbabilityTheory.continuousOn_of_mem_holderSet.{u_1, u_2, u_3} : ∀ {T : Type u_1} {Ω : Type u_2} {E : Type u_3}
  {X : T → Ω → E} {c : ENNReal} {d p : Real} {β : NNReal} {U : Set.{u_1} T} [inst : PseudoEMetricSpace.{u_1} T]
  [inst_1 : PseudoEMetricSpace.{u_3} E],
  @HasBoundedCoveringNumber.{u_1} T inst U c d →
    @LT.lt.{0} Real Real.instLT (@OfNat.ofNat.{0} Real (nat_lit 0) (@Zero.toOfNat0.{0} Real Real.instZero)) p →
      @LT.lt.{0} NNReal (@Preorder.toLT.{0} NNReal (@PartialOrder.toPreorder.{0} NNReal NNReal.instPartialOrder))
          (@OfNat.ofNat.{0} NNReal (nat_lit 0) (@Zero.toOfNat0.{0} NNReal NNReal.instZero)) β →
        ∀ {T' : Set.{u_1} T} {ω : Ω},
          @Membership.mem.{u_2, u_2} Ω (Set.{u_2} Ω) (@Set.instMembership.{u_2} Ω)
              (@ProbabilityTheory.holderSet.{u_1, u_2, u_3} T Ω E inst inst_1 X T' p (↑β) U) ω →
            @ContinuousOn.{u_1, u_3} (@Set.Elem.{u_1} T T') E
              (@instTopologicalSpaceSubtype.{u_1} T
                (fun x => @Membership.mem.{u_1, u_1} T (Set.{u_1} T) (@Set.instMembership.{u_1} T) T' x)
                (@UniformSpace.toTopologicalSpace.{u_1} T (@PseudoEMetricSpace.toUniformSpace.{u_1} T inst)))
              (@UniformSpace.toTopologicalSpace.{u_3} E (@PseudoEMetricSpace.toUniformSpace.{u_3} E inst_1))
              (fun t =>
                X
                  (@Subtype.val.{u_1 + 1} T
                    (fun x => @Membership.mem.{u_1, u_1} T (Set.{u_1} T) (@Set.instMembership.{u_1} T) T' x) t)
                  ω)
              (@setOf.{u_1} (@Set.Elem.{u_1} T T') fun x =>
                @Membership.mem.{u_1, u_1} T (Set.{u_1} T) (@Set.instMembership.{u_1} T) U
                  (@Subtype.val.{u_1 + 1} T
                    (fun x => @Membership.mem.{u_1, u_1} T (Set.{u_1} T) (@Set.instMembership.{u_1} T) T' x) x)) :=
⋯
```

## `ProbabilityTheory.countable_kolmogorov_chentsov`

Command: `#print ProbabilityTheory.countable_kolmogorov_chentsov`

```lean
theorem ProbabilityTheory.countable_kolmogorov_chentsov.{u_1, u_2, u_3} : ∀ {T : Type u_1} {Ω : Type u_2} {E : Type u_3}
  {mΩ : MeasurableSpace.{u_2} Ω} {X : T → Ω → E} {c : ENNReal} {d p q : Real} {M β : NNReal}
  {P : @MeasureTheory.Measure.{u_2} Ω mΩ} {U : Set.{u_1} T} [inst : PseudoEMetricSpace.{u_1} T]
  [inst_1 : PseudoEMetricSpace.{u_3} E] [inst_2 : MeasurableSpace.{u_3} E]
  [@BorelSpace.{u_3} E (@UniformSpace.toTopologicalSpace.{u_3} E (@PseudoEMetricSpace.toUniformSpace.{u_3} E inst_1))
      inst_2],
  @HasBoundedCoveringNumber.{u_1} T inst U c d →
    @ProbabilityTheory.IsAEKolmogorovProcess.{u_1, u_2, u_3} T Ω E inst mΩ inst_1 X P p q M →
      @LT.lt.{0} Real Real.instLT (@OfNat.ofNat.{0} Real (nat_lit 0) (@Zero.toOfNat0.{0} Real Real.instZero)) d →
        @LT.lt.{0} Real Real.instLT d q →
          @LT.lt.{0} NNReal (@Preorder.toLT.{0} NNReal (@PartialOrder.toPreorder.{0} NNReal NNReal.instPartialOrder))
              (@OfNat.ofNat.{0} NNReal (nat_lit 0) (@Zero.toOfNat0.{0} NNReal NNReal.instZero)) β →
            ∀ (T' : Set.{u_1} T) [hT' : Countable.{u_1 + 1} (@Set.Elem.{u_1} T T')],
              @LE.le.{u_1} (Set.{u_1} T) (@Set.instLE.{u_1} T) T' U →
                @LE.le.{0} ENNReal ENNReal.instLE
                  (@MeasureTheory.lintegral.{u_2} Ω mΩ P fun ω =>
                    ⨆ s,
                      ⨆ t,
                        @HDiv.hDiv.{0, 0, 0} ENNReal ENNReal ENNReal
                          (@instHDiv.{0} ENNReal (@DivInvMonoid.toDiv.{0} ENNReal ENNReal.instDivInvMonoid))
                          (@HPow.hPow.{0, 0, 0} ENNReal Real ENNReal (@instHPow.{0, 0} ENNReal Real ENNReal.instPowReal)
                            (@EDist.edist.{u_3} E
                              (@WeakPseudoEMetricSpace.toEDist.{u_3} E
                                (@UniformSpace.toTopologicalSpace.{u_3} E
                                  (@PseudoEMetricSpace.toUniformSpace.{u_3} E inst_1))
                                (@PseudoEMetricSpace.toWeakPseudoEMetricSpace.{u_3} E inst_1))
                              (X
                                (@Subtype.val.{u_1 + 1} T
                                  (fun x =>
                                    @Membership.mem.{u_1, u_1} T (Set.{u_1} T) (@Set.instMembership.{u_1} T) T' x)
                                  s)
                                ω)
                              (X
                                (@Subtype.val.{u_1 + 1} T
                                  (fun x =>
                                    @Membership.mem.{u_1, u_1} T (Set.{u_1} T) (@Set.instMembership.{u_1} T) T' x)
                                  t)
                                ω))
                            p)
                          (@HPow.hPow.{0, 0, 0} ENNReal Real ENNReal (@instHPow.{0, 0} ENNReal Real ENNReal.instPowReal)
                            (@EDist.edist.{u_1} (@Set.Elem.{u_1} T T')
                              (@WeakPseudoEMetricSpace.toEDist.{u_1} (@Set.Elem.{u_1} T T')
                                (@instTopologicalSpaceSubtype.{u_1} T
                                  (fun x =>
                                    @Membership.mem.{u_1, u_1} T (Set.{u_1} T) (@Set.instMembership.{u_1} T) T' x)
                                  (@UniformSpace.toTopologicalSpace.{u_1} T
                                    (@PseudoEMetricSpace.toUniformSpace.{u_1} T inst)))
                                (@instWeakPseudoEMetricSpaceSubtype.{u_1} T
                                  (fun x =>
                                    @Membership.mem.{u_1, u_1} T (Set.{u_1} T) (@Set.instMembership.{u_1} T) T' x)
                                  (@UniformSpace.toTopologicalSpace.{u_1} T
                                    (@PseudoEMetricSpace.toUniformSpace.{u_1} T inst))
                                  (@PseudoEMetricSpace.toWeakPseudoEMetricSpace.{u_1} T inst)))
                              s t)
                            (@HMul.hMul.{0, 0, 0} Real Real Real (@instHMul.{0} Real Real.instMul) (↑β) p)))
                  (@HMul.hMul.{0, 0, 0} ENNReal ENNReal ENNReal
                    (@instHMul.{0} ENNReal
                      (@Distrib.toMul.{0} ENNReal
                        (@instDistribOfSemiring.{0} ENNReal
                          (@CommSemiring.toSemiring.{0} ENNReal ENNReal.instCommSemiring))))
                    (↑M) (@ProbabilityTheory.constL.{u_1} T inst c d p q (↑β) U)) :=
⋯
```

## `ProbabilityTheory.edist_holderModification_eq_zero`

Command: `#print ProbabilityTheory.edist_holderModification_eq_zero`

```lean
theorem ProbabilityTheory.edist_holderModification_eq_zero.{u_1, u_2, u_3} : ∀ {T : Type u_1} {Ω : Type u_2}
  {E : Type u_3} {mΩ : MeasurableSpace.{u_2} Ω} {X : T → Ω → E} {c : ENNReal} {d p q : Real} {M β : NNReal}
  {P : @MeasureTheory.Measure.{u_2} Ω mΩ} {U : Set.{u_1} T} [inst : PseudoEMetricSpace.{u_1} T]
  [inst_1 : PseudoEMetricSpace.{u_3} E] [hE : Nonempty.{u_3 + 1} E]
  [inst_2 :
    @SecondCountableTopology.{u_1} T
      (@UniformSpace.toTopologicalSpace.{u_1} T (@PseudoEMetricSpace.toUniformSpace.{u_1} T inst))],
  @HasBoundedCoveringNumber.{u_1} T inst U c d →
    @IsOpen.{u_1} T (@UniformSpace.toTopologicalSpace.{u_1} T (@PseudoEMetricSpace.toUniformSpace.{u_1} T inst)) U →
      ∀
        [inst_3 :
          @DecidablePred.{u_1 + 1} T fun x =>
            @Membership.mem.{u_1, u_1} T (Set.{u_1} T) (@Set.instMembership.{u_1} T) U x],
        @ProbabilityTheory.IsKolmogorovProcess.{u_1, u_2, u_3} T Ω E inst mΩ inst_1 X P p q M →
          @LT.lt.{0} NNReal (@Preorder.toLT.{0} NNReal (@PartialOrder.toPreorder.{0} NNReal NNReal.instPartialOrder))
              (@OfNat.ofNat.{0} NNReal (nat_lit 0) (@Zero.toOfNat0.{0} NNReal NNReal.instZero)) β →
            ∀
              (t' :
                @Set.Elem.{u_1} T
                  (@denseCountable.{u_1} T
                    (@UniformSpace.toTopologicalSpace.{u_1} T (@PseudoEMetricSpace.toUniformSpace.{u_1} T inst))
                    inst_2)),
              @Membership.mem.{u_1, u_1} T (Set.{u_1} T) (@Set.instMembership.{u_1} T) U
                  (@Subtype.val.{u_1 + 1} T
                    (fun x =>
                      @Membership.mem.{u_1, u_1} T (Set.{u_1} T) (@Set.instMembership.{u_1} T)
                        (@denseCountable.{u_1} T
                          (@UniformSpace.toTopologicalSpace.{u_1} T (@PseudoEMetricSpace.toUniformSpace.{u_1} T inst))
                          inst_2)
                        x)
                    t') →
                ∀ {ω : Ω},
                  @Membership.mem.{u_2, u_2} Ω (Set.{u_2} Ω) (@Set.instMembership.{u_2} Ω)
                      (@ProbabilityTheory.holderSet.{u_1, u_2, u_3} T Ω E inst inst_1 X
                        (@denseCountable.{u_1} T
                          (@UniformSpace.toTopologicalSpace.{u_1} T (@PseudoEMetricSpace.toUniformSpace.{u_1} T inst))
                          inst_2)
                        p (↑β) U)
                      ω →
                    @Eq.{1} ENNReal
                      (@EDist.edist.{u_3} E
                        (@WeakPseudoEMetricSpace.toEDist.{u_3} E
                          (@UniformSpace.toTopologicalSpace.{u_3} E (@PseudoEMetricSpace.toUniformSpace.{u_3} E inst_1))
                          (@PseudoEMetricSpace.toWeakPseudoEMetricSpace.{u_3} E inst_1))
                        (@ProbabilityTheory.holderModification.{u_1, u_2, u_3} T Ω E inst inst_1 hE inst_2 X β p U
                          inst_3
                          (@Subtype.val.{u_1 + 1} T
                            (fun x =>
                              @Membership.mem.{u_1, u_1} T (Set.{u_1} T) (@Set.instMembership.{u_1} T)
                                (@denseCountable.{u_1} T
                                  (@UniformSpace.toTopologicalSpace.{u_1} T
                                    (@PseudoEMetricSpace.toUniformSpace.{u_1} T inst))
                                  inst_2)
                                x)
                            t')
                          ω)
                        (X
                          (@Subtype.val.{u_1 + 1} T
                            (fun x =>
                              @Membership.mem.{u_1, u_1} T (Set.{u_1} T) (@Set.instMembership.{u_1} T)
                                (@denseCountable.{u_1} T
                                  (@UniformSpace.toTopologicalSpace.{u_1} T
                                    (@PseudoEMetricSpace.toUniformSpace.{u_1} T inst))
                                  inst_2)
                                x)
                            t')
                          ω))
                      (@OfNat.ofNat.{0} ENNReal (nat_lit 0) (@Zero.toOfNat0.{0} ENNReal ENNReal.instZero)) :=
⋯
```

## `ProbabilityTheory.edist_modification_holderModification`

Command: `#print ProbabilityTheory.edist_modification_holderModification`

```lean
theorem ProbabilityTheory.edist_modification_holderModification.{u_1, u_2, u_3} : ∀ {T : Type u_1} {Ω : Type u_2}
  {E : Type u_3} {mΩ : MeasurableSpace.{u_2} Ω} {X : T → Ω → E} {c : ENNReal} {d p q : Real} {M β : NNReal}
  {P : @MeasureTheory.Measure.{u_2} Ω mΩ} {U : Set.{u_1} T} [inst : PseudoEMetricSpace.{u_1} T]
  [inst_1 : PseudoEMetricSpace.{u_3} E] [inst_2 : MeasurableSpace.{u_3} E]
  [@BorelSpace.{u_3} E (@UniformSpace.toTopologicalSpace.{u_3} E (@PseudoEMetricSpace.toUniformSpace.{u_3} E inst_1))
      inst_2]
  [@CompleteSpace.{u_3} E (@PseudoEMetricSpace.toUniformSpace.{u_3} E inst_1)] [hE : Nonempty.{u_3 + 1} E]
  [inst_5 :
    @SecondCountableTopology.{u_1} T
      (@UniformSpace.toTopologicalSpace.{u_1} T (@PseudoEMetricSpace.toUniformSpace.{u_1} T inst))]
  [@MeasureTheory.IsFiniteMeasure.{u_2} Ω mΩ P],
  @HasBoundedCoveringNumber.{u_1} T inst U c d →
    ∀
      [inst_7 :
        @DecidablePred.{u_1 + 1} T fun x =>
          @Membership.mem.{u_1, u_1} T (Set.{u_1} T) (@Set.instMembership.{u_1} T) U x],
      @IsOpen.{u_1} T (@UniformSpace.toTopologicalSpace.{u_1} T (@PseudoEMetricSpace.toUniformSpace.{u_1} T inst)) U →
        @ProbabilityTheory.IsKolmogorovProcess.{u_1, u_2, u_3} T Ω E inst mΩ inst_1 X P p q M →
          @Ne.{1} ENNReal c (@Top.top.{0} ENNReal ENNReal.instTop) →
            @LT.lt.{0} Real Real.instLT (@OfNat.ofNat.{0} Real (nat_lit 0) (@Zero.toOfNat0.{0} Real Real.instZero)) d →
              @LT.lt.{0} Real Real.instLT d q →
                @LT.lt.{0} NNReal
                    (@Preorder.toLT.{0} NNReal (@PartialOrder.toPreorder.{0} NNReal NNReal.instPartialOrder))
                    (@OfNat.ofNat.{0} NNReal (nat_lit 0) (@Zero.toOfNat0.{0} NNReal NNReal.instZero)) β →
                  @LT.lt.{0} Real Real.instLT (↑β)
                      (@HDiv.hDiv.{0, 0, 0} Real Real Real
                        (@instHDiv.{0} Real (@DivInvMonoid.toDiv.{0} Real Real.instDivInvMonoid))
                        (@HSub.hSub.{0, 0, 0} Real Real Real (@instHSub.{0} Real Real.instSub) q d) p) →
                    ∀ (t : T),
                      @Membership.mem.{u_1, u_1} T (Set.{u_1} T) (@Set.instMembership.{u_1} T) U t →
                        @Filter.Eventually.{u_2} Ω
                          (fun ω =>
                            @Eq.{1} ENNReal
                              (@EDist.edist.{u_3} E
                                (@WeakPseudoEMetricSpace.toEDist.{u_3} E
                                  (@UniformSpace.toTopologicalSpace.{u_3} E
                                    (@PseudoEMetricSpace.toUniformSpace.{u_3} E inst_1))
                                  (@PseudoEMetricSpace.toWeakPseudoEMetricSpace.{u_3} E inst_1))
                                (@ProbabilityTheory.holderModification.{u_1, u_2, u_3} T Ω E inst inst_1 hE inst_5 X β p
                                  U inst_7 t ω)
                                (X t ω))
                              (@OfNat.ofNat.{0} ENNReal (nat_lit 0) (@Zero.toOfNat0.{0} ENNReal ENNReal.instZero)))
                          (@MeasureTheory.ae.{u_2, u_2} Ω (@MeasureTheory.Measure.{u_2} Ω mΩ)
                            (@MeasureTheory.Measure.instFunLike.{u_2} Ω mΩ) ⋯ P) :=
⋯
```

## `ProbabilityTheory.exists_edist_modification_holder_aux'`

Command: `#print ProbabilityTheory.exists_edist_modification_holder_aux'`

```lean
theorem ProbabilityTheory.exists_edist_modification_holder_aux'.{u_1, u_2, u_3} : ∀ {T : Type u_1} {Ω : Type u_2}
  {E : Type u_3} {mΩ : MeasurableSpace.{u_2} Ω} {X : T → Ω → E} {c : ENNReal} {d p q : Real} {M β : NNReal}
  {P : @MeasureTheory.Measure.{u_2} Ω mΩ} {U : Set.{u_1} T} [inst : PseudoEMetricSpace.{u_1} T]
  [inst_1 : PseudoEMetricSpace.{u_3} E] [inst_2 : MeasurableSpace.{u_3} E]
  [@BorelSpace.{u_3} E (@UniformSpace.toTopologicalSpace.{u_3} E (@PseudoEMetricSpace.toUniformSpace.{u_3} E inst_1))
      inst_2]
  [@CompleteSpace.{u_3} E (@PseudoEMetricSpace.toUniformSpace.{u_3} E inst_1)] [hE : Nonempty.{u_3 + 1} E]
  [inst_5 :
    @SecondCountableTopology.{u_1} T
      (@UniformSpace.toTopologicalSpace.{u_1} T (@PseudoEMetricSpace.toUniformSpace.{u_1} T inst))]
  [@MeasureTheory.IsFiniteMeasure.{u_2} Ω mΩ P],
  @HasBoundedCoveringNumber.{u_1} T inst U c d →
    @IsOpen.{u_1} T (@UniformSpace.toTopologicalSpace.{u_1} T (@PseudoEMetricSpace.toUniformSpace.{u_1} T inst)) U →
      @ProbabilityTheory.IsKolmogorovProcess.{u_1, u_2, u_3} T Ω E inst mΩ inst_1 X P p q M →
        @Ne.{1} ENNReal c (@Top.top.{0} ENNReal ENNReal.instTop) →
          @LT.lt.{0} Real Real.instLT (@OfNat.ofNat.{0} Real (nat_lit 0) (@Zero.toOfNat0.{0} Real Real.instZero)) d →
            @LT.lt.{0} Real Real.instLT d q →
              @LT.lt.{0} NNReal
                  (@Preorder.toLT.{0} NNReal (@PartialOrder.toPreorder.{0} NNReal NNReal.instPartialOrder))
                  (@OfNat.ofNat.{0} NNReal (nat_lit 0) (@Zero.toOfNat0.{0} NNReal NNReal.instZero)) β →
                @LT.lt.{0} Real Real.instLT (↑β)
                    (@HDiv.hDiv.{0, 0, 0} Real Real Real
                      (@instHDiv.{0} Real (@DivInvMonoid.toDiv.{0} Real Real.instDivInvMonoid))
                      (@HSub.hSub.{0, 0, 0} Real Real Real (@instHSub.{0} Real Real.instSub) q d) p) →
                  ∃ Y,
                    And (∀ (t : T), @Measurable.{u_2, u_3} Ω E mΩ inst_2 (Y t))
                      (And
                        (∀ (t : T),
                          @Membership.mem.{u_1, u_1} T (Set.{u_1} T) (@Set.instMembership.{u_1} T) U t →
                            @Filter.Eventually.{u_2} Ω
                              (fun ω =>
                                @Eq.{1} ENNReal
                                  (@EDist.edist.{u_3} E
                                    (@WeakPseudoEMetricSpace.toEDist.{u_3} E
                                      (@UniformSpace.toTopologicalSpace.{u_3} E
                                        (@PseudoEMetricSpace.toUniformSpace.{u_3} E inst_1))
                                      (@PseudoEMetricSpace.toWeakPseudoEMetricSpace.{u_3} E inst_1))
                                    (Y t ω) (X t ω))
                                  (@OfNat.ofNat.{0} ENNReal (nat_lit 0) (@Zero.toOfNat0.{0} ENNReal ENNReal.instZero)))
                              (@MeasureTheory.ae.{u_2, u_2} Ω (@MeasureTheory.Measure.{u_2} Ω mΩ)
                                (@MeasureTheory.Measure.instFunLike.{u_2} Ω mΩ) ⋯ P))
                        (And (∀ (ω : Ω), ∃ C, @HolderOnWith.{u_1, u_3} T E inst inst_1 C β (fun x => Y x ω) U)
                          (@ProbabilityTheory.IsLimitOfIndicator.{u_1, u_2, u_3} T Ω E mΩ inst_1 hE
                            (@UniformSpace.toTopologicalSpace.{u_1} T (@PseudoEMetricSpace.toUniformSpace.{u_1} T inst))
                            inst_5 Y X P U))) :=
⋯
```

## `ProbabilityTheory.exists_modification_holder''`

Command: `#print ProbabilityTheory.exists_modification_holder''`

```lean
theorem ProbabilityTheory.exists_modification_holder''.{u_1, u_2, u_3} : ∀ {T : Type u_1} {Ω : Type u_2} {E : Type u_3}
  {mΩ : MeasurableSpace.{u_2} Ω} {X : T → Ω → E} {c : ENNReal} {d p q : Real} {M : NNReal}
  {P : @MeasureTheory.Measure.{u_2} Ω mΩ} {U : Set.{u_1} T} [inst : PseudoEMetricSpace.{u_1} T]
  [inst_1 : PseudoEMetricSpace.{u_3} E] [inst_2 : MeasurableSpace.{u_3} E]
  [@BorelSpace.{u_3} E (@UniformSpace.toTopologicalSpace.{u_3} E (@PseudoEMetricSpace.toUniformSpace.{u_3} E inst_1))
      inst_2]
  [@CompleteSpace.{u_3} E (@PseudoEMetricSpace.toUniformSpace.{u_3} E inst_1)] [hE : Nonempty.{u_3 + 1} E]
  [inst_5 :
    @SecondCountableTopology.{u_1} T
      (@UniformSpace.toTopologicalSpace.{u_1} T (@PseudoEMetricSpace.toUniformSpace.{u_1} T inst))]
  [@MeasureTheory.IsFiniteMeasure.{u_2} Ω mΩ P],
  @HasBoundedCoveringNumber.{u_1} T inst U c d →
    @IsOpen.{u_1} T (@UniformSpace.toTopologicalSpace.{u_1} T (@PseudoEMetricSpace.toUniformSpace.{u_1} T inst)) U →
      @ProbabilityTheory.IsKolmogorovProcess.{u_1, u_2, u_3} T Ω E inst mΩ inst_1 X P p q M →
        @Ne.{1} ENNReal c (@Top.top.{0} ENNReal ENNReal.instTop) →
          @LT.lt.{0} Real Real.instLT (@OfNat.ofNat.{0} Real (nat_lit 0) (@Zero.toOfNat0.{0} Real Real.instZero)) d →
            @LT.lt.{0} Real Real.instLT d q →
              ∃ Y,
                And (∀ (t : T), @Measurable.{u_2, u_3} Ω E mΩ inst_2 (Y t))
                  (And
                    (∀ (t : T),
                      @Membership.mem.{u_1, u_1} T (Set.{u_1} T) (@Set.instMembership.{u_1} T) U t →
                        @Filter.EventuallyEq.{u_2, u_3} Ω E
                          (@MeasureTheory.ae.{u_2, u_2} Ω (@MeasureTheory.Measure.{u_2} Ω mΩ)
                            (@MeasureTheory.Measure.instFunLike.{u_2} Ω mΩ) ⋯ P)
                          (Y t) (X t))
                    (And
                      (∀ (β : NNReal),
                        @LT.lt.{0} NNReal
                            (@Preorder.toLT.{0} NNReal (@PartialOrder.toPreorder.{0} NNReal NNReal.instPartialOrder))
                            (@OfNat.ofNat.{0} NNReal (nat_lit 0) (@Zero.toOfNat0.{0} NNReal NNReal.instZero)) β →
                          @LT.lt.{0} Real Real.instLT (↑β)
                              (@HDiv.hDiv.{0, 0, 0} Real Real Real
                                (@instHDiv.{0} Real (@DivInvMonoid.toDiv.{0} Real Real.instDivInvMonoid))
                                (@HSub.hSub.{0, 0, 0} Real Real Real (@instHSub.{0} Real Real.instSub) q d) p) →
                            ∀ (ω : Ω), ∃ C, @HolderOnWith.{u_1, u_3} T E inst inst_1 C β (fun x => Y x ω) U)
                      (@ProbabilityTheory.IsLimitOfIndicator.{u_1, u_2, u_3} T Ω E mΩ inst_1 hE
                        (@UniformSpace.toTopologicalSpace.{u_1} T (@PseudoEMetricSpace.toUniformSpace.{u_1} T inst))
                        inst_5 Y X P U))) :=
⋯
```

## `ProbabilityTheory.exists_modification_holder'''`

Command: `#print ProbabilityTheory.exists_modification_holder'''`

```lean
theorem ProbabilityTheory.exists_modification_holder'''.{u_1, u_2, u_3} : ∀ {T : Type u_1} {Ω : Type u_2} {E : Type u_3}
  {mΩ : MeasurableSpace.{u_2} Ω} {X : T → Ω → E} {d p q : Real} {M : NNReal} {P : @MeasureTheory.Measure.{u_2} Ω mΩ}
  [inst : PseudoEMetricSpace.{u_1} T] [inst_1 : PseudoEMetricSpace.{u_3} E] [inst_2 : MeasurableSpace.{u_3} E]
  [@BorelSpace.{u_3} E (@UniformSpace.toTopologicalSpace.{u_3} E (@PseudoEMetricSpace.toUniformSpace.{u_3} E inst_1))
      inst_2]
  [@CompleteSpace.{u_3} E (@PseudoEMetricSpace.toUniformSpace.{u_3} E inst_1)] [hE : Nonempty.{u_3 + 1} E]
  [inst_5 :
    @SecondCountableTopology.{u_1} T
      (@UniformSpace.toTopologicalSpace.{u_1} T (@PseudoEMetricSpace.toUniformSpace.{u_1} T inst))]
  [@MeasureTheory.IsFiniteMeasure.{u_2} Ω mΩ P] {C : Nat → Set.{u_1} T} {c : Nat → ENNReal},
  (@IsCoverWithBoundedCoveringNumber.{u_1} T inst C (@Set.univ.{u_1} T) c fun x => d) →
    @ProbabilityTheory.IsKolmogorovProcess.{u_1, u_2, u_3} T Ω E inst mΩ inst_1 X P p q M →
      (∀ (n : Nat), @Ne.{1} ENNReal (c n) (@Top.top.{0} ENNReal ENNReal.instTop)) →
        @LT.lt.{0} Real Real.instLT (@OfNat.ofNat.{0} Real (nat_lit 0) (@Zero.toOfNat0.{0} Real Real.instZero)) d →
          @LT.lt.{0} Real Real.instLT d q →
            ∃ Y,
              And (∀ (t : T), @Measurable.{u_2, u_3} Ω E mΩ inst_2 (Y t))
                (And
                  (∀ (t : T),
                    @Filter.EventuallyEq.{u_2, u_3} Ω E
                      (@MeasureTheory.ae.{u_2, u_2} Ω (@MeasureTheory.Measure.{u_2} Ω mΩ)
                        (@MeasureTheory.Measure.instFunLike.{u_2} Ω mΩ) ⋯ P)
                      (Y t) (X t))
                  (And
                    (∀ (ω : Ω) (t : T),
                      ∃ U,
                        And
                          (@Membership.mem.{u_1, u_1} (Set.{u_1} T) (Filter.{u_1} T) (@Filter.instMembership.{u_1} T)
                            (@nhds.{u_1} T
                              (@UniformSpace.toTopologicalSpace.{u_1} T
                                (@PseudoEMetricSpace.toUniformSpace.{u_1} T inst))
                              t)
                            U)
                          (∀ (β : NNReal),
                            @LT.lt.{0} NNReal
                                (@Preorder.toLT.{0} NNReal
                                  (@PartialOrder.toPreorder.{0} NNReal NNReal.instPartialOrder))
                                (@OfNat.ofNat.{0} NNReal (nat_lit 0) (@Zero.toOfNat0.{0} NNReal NNReal.instZero)) β →
                              @LT.lt.{0} Real Real.instLT (↑β)
                                  (@HDiv.hDiv.{0, 0, 0} Real Real Real
                                    (@instHDiv.{0} Real (@DivInvMonoid.toDiv.{0} Real Real.instDivInvMonoid))
                                    (@HSub.hSub.{0, 0, 0} Real Real Real (@instHSub.{0} Real Real.instSub) q d) p) →
                                ∃ C, @HolderOnWith.{u_1, u_3} T E inst inst_1 C β (fun x => Y x ω) U))
                    (@ProbabilityTheory.IsLimitOfIndicator.{u_1, u_2, u_3} T Ω E mΩ inst_1 hE
                      (@UniformSpace.toTopologicalSpace.{u_1} T (@PseudoEMetricSpace.toUniformSpace.{u_1} T inst))
                      inst_5 Y X P (@Set.univ.{u_1} T)))) :=
⋯
```

## `ProbabilityTheory.exists_modification_holder_aux'`

Command: `#print ProbabilityTheory.exists_modification_holder_aux'`

```lean
theorem ProbabilityTheory.exists_modification_holder_aux'.{u_1, u_2, u_3} : ∀ {T : Type u_1} {Ω : Type u_2}
  {E : Type u_3} {mΩ : MeasurableSpace.{u_2} Ω} {X : T → Ω → E} {c : ENNReal} {d p q : Real} {M β : NNReal}
  {P : @MeasureTheory.Measure.{u_2} Ω mΩ} {U : Set.{u_1} T} [inst : PseudoEMetricSpace.{u_1} T]
  [inst_1 : PseudoEMetricSpace.{u_3} E] [inst_2 : MeasurableSpace.{u_3} E]
  [@BorelSpace.{u_3} E (@UniformSpace.toTopologicalSpace.{u_3} E (@PseudoEMetricSpace.toUniformSpace.{u_3} E inst_1))
      inst_2]
  [@CompleteSpace.{u_3} E (@PseudoEMetricSpace.toUniformSpace.{u_3} E inst_1)] [hE : Nonempty.{u_3 + 1} E]
  [inst_5 :
    @SecondCountableTopology.{u_1} T
      (@UniformSpace.toTopologicalSpace.{u_1} T (@PseudoEMetricSpace.toUniformSpace.{u_1} T inst))]
  [@MeasureTheory.IsFiniteMeasure.{u_2} Ω mΩ P],
  @HasBoundedCoveringNumber.{u_1} T inst U c d →
    @IsOpen.{u_1} T (@UniformSpace.toTopologicalSpace.{u_1} T (@PseudoEMetricSpace.toUniformSpace.{u_1} T inst)) U →
      @ProbabilityTheory.IsKolmogorovProcess.{u_1, u_2, u_3} T Ω E inst mΩ inst_1 X P p q M →
        @Ne.{1} ENNReal c (@Top.top.{0} ENNReal ENNReal.instTop) →
          @LT.lt.{0} Real Real.instLT (@OfNat.ofNat.{0} Real (nat_lit 0) (@Zero.toOfNat0.{0} Real Real.instZero)) d →
            @LT.lt.{0} Real Real.instLT d q →
              @LT.lt.{0} NNReal
                  (@Preorder.toLT.{0} NNReal (@PartialOrder.toPreorder.{0} NNReal NNReal.instPartialOrder))
                  (@OfNat.ofNat.{0} NNReal (nat_lit 0) (@Zero.toOfNat0.{0} NNReal NNReal.instZero)) β →
                @LT.lt.{0} Real Real.instLT (↑β)
                    (@HDiv.hDiv.{0, 0, 0} Real Real Real
                      (@instHDiv.{0} Real (@DivInvMonoid.toDiv.{0} Real Real.instDivInvMonoid))
                      (@HSub.hSub.{0, 0, 0} Real Real Real (@instHSub.{0} Real Real.instSub) q d) p) →
                  ∃ Y,
                    And (∀ (t : T), @Measurable.{u_2, u_3} Ω E mΩ inst_2 (Y t))
                      (And
                        (∀ (t : T),
                          @Membership.mem.{u_1, u_1} T (Set.{u_1} T) (@Set.instMembership.{u_1} T) U t →
                            @Filter.EventuallyEq.{u_2, u_3} Ω E
                              (@MeasureTheory.ae.{u_2, u_2} Ω (@MeasureTheory.Measure.{u_2} Ω mΩ)
                                (@MeasureTheory.Measure.instFunLike.{u_2} Ω mΩ) ⋯ P)
                              (Y t) (X t))
                        (And (∀ (ω : Ω), ∃ C, @HolderOnWith.{u_1, u_3} T E inst inst_1 C β (fun x => Y x ω) U)
                          (@ProbabilityTheory.IsLimitOfIndicator.{u_1, u_2, u_3} T Ω E mΩ inst_1 hE
                            (@UniformSpace.toTopologicalSpace.{u_1} T (@PseudoEMetricSpace.toUniformSpace.{u_1} T inst))
                            inst_5 Y X P U))) :=
⋯
```

## `ProbabilityTheory.exists_modification_holder_iSup`

Command: `#print ProbabilityTheory.exists_modification_holder_iSup`

```lean
theorem ProbabilityTheory.exists_modification_holder_iSup.{u_1, u_2, u_3} : ∀ {T : Type u_1} {Ω : Type u_2}
  {E : Type u_3} {mΩ : MeasurableSpace.{u_2} Ω} {X : T → Ω → E} {d : Real} {P : @MeasureTheory.Measure.{u_2} Ω mΩ}
  [inst : PseudoEMetricSpace.{u_1} T] [inst_1 : PseudoEMetricSpace.{u_3} E] [inst_2 : MeasurableSpace.{u_3} E]
  [@BorelSpace.{u_3} E (@UniformSpace.toTopologicalSpace.{u_3} E (@PseudoEMetricSpace.toUniformSpace.{u_3} E inst_1))
      inst_2]
  [@CompleteSpace.{u_3} E (@PseudoEMetricSpace.toUniformSpace.{u_3} E inst_1)] [hE : Nonempty.{u_3 + 1} E]
  [@SecondCountableTopology.{u_1} T
      (@UniformSpace.toTopologicalSpace.{u_1} T (@PseudoEMetricSpace.toUniformSpace.{u_1} T inst))]
  [@MeasureTheory.IsFiniteMeasure.{u_2} Ω mΩ P] {C : Nat → Set.{u_1} T} {c : Nat → ENNReal} {p q : Nat → Real}
  {M : Nat → NNReal},
  (@IsCoverWithBoundedCoveringNumber.{u_1} T inst C (@Set.univ.{u_1} T) c fun x => d) →
    (∀ (n : Nat), @ProbabilityTheory.IsAEKolmogorovProcess.{u_1, u_2, u_3} T Ω E inst mΩ inst_1 X P (p n) (q n) (M n)) →
      (∀ (n : Nat), @Ne.{1} ENNReal (c n) (@Top.top.{0} ENNReal ENNReal.instTop)) →
        @LT.lt.{0} Real Real.instLT (@OfNat.ofNat.{0} Real (nat_lit 0) (@Zero.toOfNat0.{0} Real Real.instZero)) d →
          (∀ (n : Nat), @LT.lt.{0} Real Real.instLT d (q n)) →
            ∃ Y,
              And (∀ (t : T), @Measurable.{u_2, u_3} Ω E mΩ inst_2 (Y t))
                (And
                  (∀ (t : T),
                    @Filter.EventuallyEq.{u_2, u_3} Ω E
                      (@MeasureTheory.ae.{u_2, u_2} Ω (@MeasureTheory.Measure.{u_2} Ω mΩ)
                        (@MeasureTheory.Measure.instFunLike.{u_2} Ω mΩ) ⋯ P)
                      (Y t) (X t))
                  (∀ (ω : Ω) (t : T) (β : NNReal),
                    @LT.lt.{0} NNReal
                        (@Preorder.toLT.{0} NNReal (@PartialOrder.toPreorder.{0} NNReal NNReal.instPartialOrder))
                        (@OfNat.ofNat.{0} NNReal (nat_lit 0) (@Zero.toOfNat0.{0} NNReal NNReal.instZero)) β →
                      @LT.lt.{0} Real Real.instLT (↑β)
                          (⨆ n,
                            @HDiv.hDiv.{0, 0, 0} Real Real Real
                              (@instHDiv.{0} Real (@DivInvMonoid.toDiv.{0} Real Real.instDivInvMonoid))
                              (@HSub.hSub.{0, 0, 0} Real Real Real (@instHSub.{0} Real Real.instSub) (q n) d) (p n)) →
                        ∃ U,
                          And
                            (@Membership.mem.{u_1, u_1} (Set.{u_1} T) (Filter.{u_1} T) (@Filter.instMembership.{u_1} T)
                              (@nhds.{u_1} T
                                (@UniformSpace.toTopologicalSpace.{u_1} T
                                  (@PseudoEMetricSpace.toUniformSpace.{u_1} T inst))
                                t)
                              U)
                            (∃ C, @HolderOnWith.{u_1, u_3} T E inst inst_1 C β (fun x => Y x ω) U))) :=
⋯
```

## `ProbabilityTheory.exists_modification_holder_iSup'`

Command: `#print ProbabilityTheory.exists_modification_holder_iSup'`

```lean
theorem ProbabilityTheory.exists_modification_holder_iSup'.{u_1, u_2, u_3} : ∀ {T : Type u_1} {Ω : Type u_2}
  {E : Type u_3} {mΩ : MeasurableSpace.{u_2} Ω} {X : T → Ω → E} {d : Real} {P : @MeasureTheory.Measure.{u_2} Ω mΩ}
  [inst : PseudoEMetricSpace.{u_1} T] [inst_1 : PseudoEMetricSpace.{u_3} E] [inst_2 : MeasurableSpace.{u_3} E]
  [@BorelSpace.{u_3} E (@UniformSpace.toTopologicalSpace.{u_3} E (@PseudoEMetricSpace.toUniformSpace.{u_3} E inst_1))
      inst_2]
  [@CompleteSpace.{u_3} E (@PseudoEMetricSpace.toUniformSpace.{u_3} E inst_1)] [hE : Nonempty.{u_3 + 1} E]
  [@SecondCountableTopology.{u_1} T
      (@UniformSpace.toTopologicalSpace.{u_1} T (@PseudoEMetricSpace.toUniformSpace.{u_1} T inst))]
  [@MeasureTheory.IsFiniteMeasure.{u_2} Ω mΩ P] {C : Nat → Set.{u_1} T} {c : Nat → ENNReal} {p q : Nat → Real}
  {M : Nat → NNReal},
  (@IsCoverWithBoundedCoveringNumber.{u_1} T inst C (@Set.univ.{u_1} T) c fun x => d) →
    (∀ (n : Nat), @ProbabilityTheory.IsKolmogorovProcess.{u_1, u_2, u_3} T Ω E inst mΩ inst_1 X P (p n) (q n) (M n)) →
      (∀ (n : Nat), @Ne.{1} ENNReal (c n) (@Top.top.{0} ENNReal ENNReal.instTop)) →
        @LT.lt.{0} Real Real.instLT (@OfNat.ofNat.{0} Real (nat_lit 0) (@Zero.toOfNat0.{0} Real Real.instZero)) d →
          (∀ (n : Nat), @LT.lt.{0} Real Real.instLT d (q n)) →
            ∃ Y,
              And (∀ (t : T), @Measurable.{u_2, u_3} Ω E mΩ inst_2 (Y t))
                (And
                  (∀ (t : T),
                    @Filter.EventuallyEq.{u_2, u_3} Ω E
                      (@MeasureTheory.ae.{u_2, u_2} Ω (@MeasureTheory.Measure.{u_2} Ω mΩ)
                        (@MeasureTheory.Measure.instFunLike.{u_2} Ω mΩ) ⋯ P)
                      (Y t) (X t))
                  (∀ (ω : Ω) (t : T) (β : NNReal),
                    @LT.lt.{0} NNReal
                        (@Preorder.toLT.{0} NNReal (@PartialOrder.toPreorder.{0} NNReal NNReal.instPartialOrder))
                        (@OfNat.ofNat.{0} NNReal (nat_lit 0) (@Zero.toOfNat0.{0} NNReal NNReal.instZero)) β →
                      @LT.lt.{0} Real Real.instLT (↑β)
                          (⨆ n,
                            @HDiv.hDiv.{0, 0, 0} Real Real Real
                              (@instHDiv.{0} Real (@DivInvMonoid.toDiv.{0} Real Real.instDivInvMonoid))
                              (@HSub.hSub.{0, 0, 0} Real Real Real (@instHSub.{0} Real Real.instSub) (q n) d) (p n)) →
                        ∃ U,
                          And
                            (@Membership.mem.{u_1, u_1} (Set.{u_1} T) (Filter.{u_1} T) (@Filter.instMembership.{u_1} T)
                              (@nhds.{u_1} T
                                (@UniformSpace.toTopologicalSpace.{u_1} T
                                  (@PseudoEMetricSpace.toUniformSpace.{u_1} T inst))
                                t)
                              U)
                            (∃ C, @HolderOnWith.{u_1, u_3} T E inst inst_1 C β (fun x => Y x ω) U))) :=
⋯
```

## `ProbabilityTheory.exists_nat_pow_lt_iInf`

Command: `#print ProbabilityTheory.exists_nat_pow_lt_iInf`

```lean
theorem ProbabilityTheory.exists_nat_pow_lt_iInf.{u_1} : ∀ {T : Type u_1} [inst : PseudoEMetricSpace.{u_1} T]
  {J : Set.{u_1} T},
  @LT.lt.{0} ENNReal (@Preorder.toLT.{0} ENNReal (@PartialOrder.toPreorder.{0} ENNReal ENNReal.instPartialOrder))
      (@Metric.ediam.{u_1} T inst J) (@Top.top.{0} ENNReal ENNReal.instTop) →
    @Set.Finite.{u_1} T J →
      @Set.Nonempty.{u_1} T J →
        ∃ k,
          @LT.lt.{0} ENNReal
            (@Preorder.toLT.{0} ENNReal (@PartialOrder.toPreorder.{0} ENNReal ENNReal.instPartialOrder))
            (@HMul.hMul.{0, 0, 0} ENNReal ENNReal ENNReal
              (@instHMul.{0} ENNReal
                (@Distrib.toMul.{0} ENNReal
                  (@instDistribOfSemiring.{0} ENNReal (@CommSemiring.toSemiring.{0} ENNReal ENNReal.instCommSemiring))))
              (@Metric.ediam.{u_1} T inst J)
              (@HPow.hPow.{0, 0, 0} ENNReal Nat ENNReal
                (@instHPow.{0, 0} ENNReal Nat
                  (@NPow.toPow.{0} ENNReal
                    (@Monoid.toNPow.{0} ENNReal
                      (@Semiring.toMonoid.{0} ENNReal
                        (@CommSemiring.toSemiring.{0} ENNReal ENNReal.instCommSemiring)))))
                (@Inv.inv.{0} ENNReal ENNReal.instInv
                  (@OfNat.ofNat.{0} ENNReal (nat_lit 2)
                    (@instOfNatAtLeastTwo.{0} ENNReal (nat_lit 2)
                      (@AddMonoidWithOne.toNatCast.{0} ENNReal
                        (@AddCommMonoidWithOne.toAddMonoidWithOne.{0} ENNReal ENNReal.instAddCommMonoidWithOne))
                      ⋯)))
                k))
            (⨅ s,
              ⨅ t,
                ⨅ (_ :
                  @LT.lt.{0} ENNReal
                    (@Preorder.toLT.{0} ENNReal (@PartialOrder.toPreorder.{0} ENNReal ENNReal.instPartialOrder))
                    (@OfNat.ofNat.{0} ENNReal (nat_lit 0) (@Zero.toOfNat0.{0} ENNReal ENNReal.instZero))
                    (@EDist.edist.{u_1} (@Set.Elem.{u_1} T J)
                      (@WeakPseudoEMetricSpace.toEDist.{u_1} (@Set.Elem.{u_1} T J)
                        (@instTopologicalSpaceSubtype.{u_1} T
                          (fun x => @Membership.mem.{u_1, u_1} T (Set.{u_1} T) (@Set.instMembership.{u_1} T) J x)
                          (@UniformSpace.toTopologicalSpace.{u_1} T (@PseudoEMetricSpace.toUniformSpace.{u_1} T inst)))
                        (@instWeakPseudoEMetricSpaceSubtype.{u_1} T
                          (fun x => @Membership.mem.{u_1, u_1} T (Set.{u_1} T) (@Set.instMembership.{u_1} T) J x)
                          (@UniformSpace.toTopologicalSpace.{u_1} T (@PseudoEMetricSpace.toUniformSpace.{u_1} T inst))
                          (@PseudoEMetricSpace.toWeakPseudoEMetricSpace.{u_1} T inst)))
                      s t)),
                  @EDist.edist.{u_1} (@Set.Elem.{u_1} T J)
                    (@WeakPseudoEMetricSpace.toEDist.{u_1} (@Set.Elem.{u_1} T J)
                      (@instTopologicalSpaceSubtype.{u_1} T
                        (fun x => @Membership.mem.{u_1, u_1} T (Set.{u_1} T) (@Set.instMembership.{u_1} T) J x)
                        (@UniformSpace.toTopologicalSpace.{u_1} T (@PseudoEMetricSpace.toUniformSpace.{u_1} T inst)))
                      (@instWeakPseudoEMetricSpaceSubtype.{u_1} T
                        (fun x => @Membership.mem.{u_1, u_1} T (Set.{u_1} T) (@Set.instMembership.{u_1} T) J x)
                        (@UniformSpace.toTopologicalSpace.{u_1} T (@PseudoEMetricSpace.toUniformSpace.{u_1} T inst))
                        (@PseudoEMetricSpace.toWeakPseudoEMetricSpace.{u_1} T inst)))
                    s t) :=
⋯
```

## `ProbabilityTheory.exists_tendsto_of_mem_holderSet`

Command: `#print ProbabilityTheory.exists_tendsto_of_mem_holderSet`

```lean
theorem ProbabilityTheory.exists_tendsto_of_mem_holderSet.{u_1, u_2, u_3} : ∀ {T : Type u_1} {Ω : Type u_2}
  {E : Type u_3} {X : T → Ω → E} {c : ENNReal} {d p : Real} {β : NNReal} {U : Set.{u_1} T}
  [inst : PseudoEMetricSpace.{u_1} T] [inst_1 : PseudoEMetricSpace.{u_3} E]
  [@CompleteSpace.{u_3} E (@PseudoEMetricSpace.toUniformSpace.{u_3} E inst_1)],
  @HasBoundedCoveringNumber.{u_1} T inst U c d →
    @IsOpen.{u_1} T (@UniformSpace.toTopologicalSpace.{u_1} T (@PseudoEMetricSpace.toUniformSpace.{u_1} T inst)) U →
      @LT.lt.{0} Real Real.instLT (@OfNat.ofNat.{0} Real (nat_lit 0) (@Zero.toOfNat0.{0} Real Real.instZero)) p →
        @LT.lt.{0} NNReal (@Preorder.toLT.{0} NNReal (@PartialOrder.toPreorder.{0} NNReal NNReal.instPartialOrder))
            (@OfNat.ofNat.{0} NNReal (nat_lit 0) (@Zero.toOfNat0.{0} NNReal NNReal.instZero)) β →
          ∀ {T' : Set.{u_1} T},
            @Dense.{u_1} T (@UniformSpace.toTopologicalSpace.{u_1} T (@PseudoEMetricSpace.toUniformSpace.{u_1} T inst))
                T' →
              ∀ {ω : Ω},
                @Membership.mem.{u_2, u_2} Ω (Set.{u_2} Ω) (@Set.instMembership.{u_2} Ω)
                    (@ProbabilityTheory.holderSet.{u_1, u_2, u_3} T Ω E inst inst_1 X T' p (↑β) U) ω →
                  ∀ (t : T),
                    @Membership.mem.{u_1, u_1} T (Set.{u_1} T) (@Set.instMembership.{u_1} T) U t →
                      ∃ c,
                        @Filter.Tendsto.{u_1, u_3} (@Set.Elem.{u_1} T T') E
                          (fun t' =>
                            X
                              (@Subtype.val.{u_1 + 1} T
                                (fun x => @Membership.mem.{u_1, u_1} T (Set.{u_1} T) (@Set.instMembership.{u_1} T) T' x)
                                t')
                              ω)
                          (@Filter.comap.{u_1, u_1} (@Set.Elem.{u_1} T T') T
                            (@Subtype.val.{u_1 + 1} T fun x =>
                              @Membership.mem.{u_1, u_1} T (Set.{u_1} T) (@Set.instMembership.{u_1} T) T' x)
                            (@nhds.{u_1} T
                              (@UniformSpace.toTopologicalSpace.{u_1} T
                                (@PseudoEMetricSpace.toUniformSpace.{u_1} T inst))
                              t))
                          (@nhds.{u_3} E
                            (@UniformSpace.toTopologicalSpace.{u_3} E
                              (@PseudoEMetricSpace.toUniformSpace.{u_3} E inst_1))
                            c) :=
⋯
```

## `ProbabilityTheory.finite_kolmogorov_chentsov`

Command: `#print ProbabilityTheory.finite_kolmogorov_chentsov`

```lean
theorem ProbabilityTheory.finite_kolmogorov_chentsov.{u_1, u_2, u_3} : ∀ {T : Type u_1} {Ω : Type u_2} {E : Type u_3}
  {mΩ : MeasurableSpace.{u_2} Ω} {X : T → Ω → E} {c : ENNReal} {d p q : Real} {M β : NNReal}
  {P : @MeasureTheory.Measure.{u_2} Ω mΩ} {U : Set.{u_1} T} [inst : PseudoEMetricSpace.{u_1} T]
  [inst_1 : PseudoEMetricSpace.{u_3} E] [inst_2 : MeasurableSpace.{u_3} E]
  [@BorelSpace.{u_3} E (@UniformSpace.toTopologicalSpace.{u_3} E (@PseudoEMetricSpace.toUniformSpace.{u_3} E inst_1))
      inst_2],
  @HasBoundedCoveringNumber.{u_1} T inst U c d →
    @ProbabilityTheory.IsAEKolmogorovProcess.{u_1, u_2, u_3} T Ω E inst mΩ inst_1 X P p q M →
      @LT.lt.{0} Real Real.instLT (@OfNat.ofNat.{0} Real (nat_lit 0) (@Zero.toOfNat0.{0} Real Real.instZero)) d →
        @LT.lt.{0} Real Real.instLT d q →
          @LT.lt.{0} NNReal (@Preorder.toLT.{0} NNReal (@PartialOrder.toPreorder.{0} NNReal NNReal.instPartialOrder))
              (@OfNat.ofNat.{0} NNReal (nat_lit 0) (@Zero.toOfNat0.{0} NNReal NNReal.instZero)) β →
            ∀ (T' : Set.{u_1} T) [hT' : Finite.{u_1 + 1} (@Set.Elem.{u_1} T T')],
              @LE.le.{u_1} (Set.{u_1} T) (@Set.instLE.{u_1} T) T' U →
                @LE.le.{0} ENNReal ENNReal.instLE
                  (@MeasureTheory.lintegral.{u_2} Ω mΩ P fun ω =>
                    ⨆ s,
                      ⨆ t,
                        @HDiv.hDiv.{0, 0, 0} ENNReal ENNReal ENNReal
                          (@instHDiv.{0} ENNReal (@DivInvMonoid.toDiv.{0} ENNReal ENNReal.instDivInvMonoid))
                          (@HPow.hPow.{0, 0, 0} ENNReal Real ENNReal (@instHPow.{0, 0} ENNReal Real ENNReal.instPowReal)
                            (@EDist.edist.{u_3} E
                              (@WeakPseudoEMetricSpace.toEDist.{u_3} E
                                (@UniformSpace.toTopologicalSpace.{u_3} E
                                  (@PseudoEMetricSpace.toUniformSpace.{u_3} E inst_1))
                                (@PseudoEMetricSpace.toWeakPseudoEMetricSpace.{u_3} E inst_1))
                              (X
                                (@Subtype.val.{u_1 + 1} T
                                  (fun x =>
                                    @Membership.mem.{u_1, u_1} T (Set.{u_1} T) (@Set.instMembership.{u_1} T) T' x)
                                  s)
                                ω)
                              (X
                                (@Subtype.val.{u_1 + 1} T
                                  (fun x =>
                                    @Membership.mem.{u_1, u_1} T (Set.{u_1} T) (@Set.instMembership.{u_1} T) T' x)
                                  t)
                                ω))
                            p)
                          (@HPow.hPow.{0, 0, 0} ENNReal Real ENNReal (@instHPow.{0, 0} ENNReal Real ENNReal.instPowReal)
                            (@EDist.edist.{u_1} (@Set.Elem.{u_1} T T')
                              (@WeakPseudoEMetricSpace.toEDist.{u_1} (@Set.Elem.{u_1} T T')
                                (@instTopologicalSpaceSubtype.{u_1} T
                                  (fun x =>
                                    @Membership.mem.{u_1, u_1} T (Set.{u_1} T) (@Set.instMembership.{u_1} T) T' x)
                                  (@UniformSpace.toTopologicalSpace.{u_1} T
                                    (@PseudoEMetricSpace.toUniformSpace.{u_1} T inst)))
                                (@instWeakPseudoEMetricSpaceSubtype.{u_1} T
                                  (fun x =>
                                    @Membership.mem.{u_1, u_1} T (Set.{u_1} T) (@Set.instMembership.{u_1} T) T' x)
                                  (@UniformSpace.toTopologicalSpace.{u_1} T
                                    (@PseudoEMetricSpace.toUniformSpace.{u_1} T inst))
                                  (@PseudoEMetricSpace.toWeakPseudoEMetricSpace.{u_1} T inst)))
                              s t)
                            (@HMul.hMul.{0, 0, 0} Real Real Real (@instHMul.{0} Real Real.instMul) (↑β) p)))
                  (@HMul.hMul.{0, 0, 0} ENNReal ENNReal ENNReal
                    (@instHMul.{0} ENNReal
                      (@Distrib.toMul.{0} ENNReal
                        (@instDistribOfSemiring.{0} ENNReal
                          (@CommSemiring.toSemiring.{0} ENNReal ENNReal.instCommSemiring))))
                    (↑M) (@ProbabilityTheory.constL.{u_1} T inst c d p q (↑β) U)) :=
⋯
```

## `ProbabilityTheory.finite_set_bound_of_edist_le`

Command: `#print ProbabilityTheory.finite_set_bound_of_edist_le`

```lean
theorem ProbabilityTheory.finite_set_bound_of_edist_le.{u_1, u_2, u_3} : ∀ {T : Type u_1} {Ω : Type u_2} {E : Type u_3}
  [inst : PseudoEMetricSpace.{u_1} T] {mΩ : MeasurableSpace.{u_2} Ω} [inst_1 : PseudoEMetricSpace.{u_3} E]
  {P : @MeasureTheory.Measure.{u_2} Ω mΩ} {X : T → Ω → E} {M : NNReal} {d p q : Real} {J : Set.{u_1} T} {c : ENNReal}
  {δ : NNReal},
  @HasBoundedCoveringNumber.{u_1} T inst J c d →
    @Set.Finite.{u_1} T J →
      @ProbabilityTheory.IsAEKolmogorovProcess.{u_1, u_2, u_3} T Ω E inst mΩ inst_1 X P p q M →
        @Ne.{1} ENNReal c (@Top.top.{0} ENNReal ENNReal.instTop) →
          @LT.lt.{0} Real Real.instLT (@OfNat.ofNat.{0} Real (nat_lit 0) (@Zero.toOfNat0.{0} Real Real.instZero)) d →
            @LT.lt.{0} Real Real.instLT d q →
              @Ne.{1} NNReal δ (@OfNat.ofNat.{0} NNReal (nat_lit 0) (@Zero.toOfNat0.{0} NNReal NNReal.instZero)) →
                @LE.le.{0} ENNReal ENNReal.instLE
                  (@MeasureTheory.lintegral.{u_2} Ω mΩ P fun ω =>
                    ⨆ s,
                      ⨆ t,
                        @HPow.hPow.{0, 0, 0} ENNReal Real ENNReal (@instHPow.{0, 0} ENNReal Real ENNReal.instPowReal)
                          (@EDist.edist.{u_3} E
                            (@WeakPseudoEMetricSpace.toEDist.{u_3} E
                              (@UniformSpace.toTopologicalSpace.{u_3} E
                                (@PseudoEMetricSpace.toUniformSpace.{u_3} E inst_1))
                              (@PseudoEMetricSpace.toWeakPseudoEMetricSpace.{u_3} E inst_1))
                            (X
                              (@Subtype.val.{u_1 + 1} T
                                (fun x => @Membership.mem.{u_1, u_1} T (Set.{u_1} T) (@Set.instMembership.{u_1} T) J x)
                                s)
                              ω)
                            (X
                              (@Subtype.val.{u_1 + 1} T
                                (fun x => @Membership.mem.{u_1, u_1} T (Set.{u_1} T) (@Set.instMembership.{u_1} T) J x)
                                (@Subtype.val.{u_1 + 1} (@Set.Elem.{u_1} T J)
                                  (fun t =>
                                    @LE.le.{0} ENNReal ENNReal.instLE
                                      (@EDist.edist.{u_1} (@Set.Elem.{u_1} T J)
                                        (@WeakPseudoEMetricSpace.toEDist.{u_1} (@Set.Elem.{u_1} T J)
                                          (@instTopologicalSpaceSubtype.{u_1} T
                                            (fun x =>
                                              @Membership.mem.{u_1, u_1} T (Set.{u_1} T) (@Set.instMembership.{u_1} T) J
                                                x)
                                            (@UniformSpace.toTopologicalSpace.{u_1} T
                                              (@PseudoEMetricSpace.toUniformSpace.{u_1} T inst)))
                                          (@instWeakPseudoEMetricSpaceSubtype.{u_1} T
                                            (fun x =>
                                              @Membership.mem.{u_1, u_1} T (Set.{u_1} T) (@Set.instMembership.{u_1} T) J
                                                x)
                                            (@UniformSpace.toTopologicalSpace.{u_1} T
                                              (@PseudoEMetricSpace.toUniformSpace.{u_1} T inst))
                                            (@PseudoEMetricSpace.toWeakPseudoEMetricSpace.{u_1} T inst)))
                                        s t)
                                      ↑δ)
                                  t))
                              ω))
                          p)
                  (@HMul.hMul.{0, 0, 0} ENNReal ENNReal ENNReal
                    (@instHMul.{0} ENNReal
                      (@Distrib.toMul.{0} ENNReal
                        (@instDistribOfSemiring.{0} ENNReal
                          (@CommSemiring.toSemiring.{0} ENNReal ENNReal.instCommSemiring))))
                    (@HMul.hMul.{0, 0, 0} ENNReal ENNReal ENNReal
                      (@instHMul.{0} ENNReal
                        (@Distrib.toMul.{0} ENNReal
                          (@instDistribOfSemiring.{0} ENNReal
                            (@CommSemiring.toSemiring.{0} ENNReal ENNReal.instCommSemiring))))
                      (@HMul.hMul.{0, 0, 0} ENNReal ENNReal ENNReal
                        (@instHMul.{0} ENNReal
                          (@Distrib.toMul.{0} ENNReal
                            (@instDistribOfSemiring.{0} ENNReal
                              (@CommSemiring.toSemiring.{0} ENNReal ENNReal.instCommSemiring))))
                        (@HMul.hMul.{0, 0, 0} ENNReal ENNReal ENNReal
                          (@instHMul.{0} ENNReal
                            (@Distrib.toMul.{0} ENNReal
                              (@instDistribOfSemiring.{0} ENNReal
                                (@CommSemiring.toSemiring.{0} ENNReal ENNReal.instCommSemiring))))
                          (@HPow.hPow.{0, 0, 0} ENNReal Real ENNReal (@instHPow.{0, 0} ENNReal Real ENNReal.instPowReal)
                            (@OfNat.ofNat.{0} ENNReal (nat_lit 2)
                              (@instOfNatAtLeastTwo.{0} ENNReal (nat_lit 2)
                                (@AddMonoidWithOne.toNatCast.{0} ENNReal
                                  (@AddCommMonoidWithOne.toAddMonoidWithOne.{0} ENNReal
                                    ENNReal.instAddCommMonoidWithOne))
                                ⋯))
                            (@HAdd.hAdd.{0, 0, 0} Real Real Real (@instHAdd.{0} Real Real.instAdd)
                              (@HAdd.hAdd.{0, 0, 0} Real Real Real (@instHAdd.{0} Real Real.instAdd)
                                (@HMul.hMul.{0, 0, 0} Real Real Real (@instHMul.{0} Real Real.instMul)
                                  (@OfNat.ofNat.{0} Real (nat_lit 2)
                                    (@instOfNatAtLeastTwo.{0} Real (nat_lit 2) Real.instNatCast ⋯))
                                  p)
                                (@HMul.hMul.{0, 0, 0} Real Real Real (@instHMul.{0} Real Real.instMul)
                                  (@OfNat.ofNat.{0} Real (nat_lit 4)
                                    (@instOfNatAtLeastTwo.{0} Real (nat_lit 4) Real.instNatCast ⋯))
                                  q))
                              (@OfNat.ofNat.{0} Real (nat_lit 1) (@One.toOfNat1.{0} Real Real.instOne))))
                          ↑M)
                        c)
                      (@HPow.hPow.{0, 0, 0} ENNReal Real ENNReal (@instHPow.{0, 0} ENNReal Real ENNReal.instPowReal)
                        (↑δ) (@HSub.hSub.{0, 0, 0} Real Real Real (@instHSub.{0} Real Real.instSub) q d)))
                    (@HAdd.hAdd.{0, 0, 0} ENNReal ENNReal ENNReal (@instHAdd.{0} ENNReal ENNReal.instAdd)
                      (@HMul.hMul.{0, 0, 0} ENNReal ENNReal ENNReal
                        (@instHMul.{0} ENNReal
                          (@Distrib.toMul.{0} ENNReal
                            (@instDistribOfSemiring.{0} ENNReal
                              (@CommSemiring.toSemiring.{0} ENNReal ENNReal.instCommSemiring))))
                        (@HPow.hPow.{0, 0, 0} ENNReal Real ENNReal (@instHPow.{0, 0} ENNReal Real ENNReal.instPowReal)
                          (@OfNat.ofNat.{0} ENNReal (nat_lit 4)
                            (@instOfNatAtLeastTwo.{0} ENNReal (nat_lit 4)
                              (@AddMonoidWithOne.toNatCast.{0} ENNReal
                                (@AddCommMonoidWithOne.toAddMonoidWithOne.{0} ENNReal ENNReal.instAddCommMonoidWithOne))
                              ⋯))
                          d)
                        (@HPow.hPow.{0, 0, 0} ENNReal Real ENNReal (@instHPow.{0, 0} ENNReal Real ENNReal.instPowReal)
                          (ENNReal.ofReal
                            (Real.logb
                              (@OfNat.ofNat.{0} Real (nat_lit 2)
                                (@instOfNatAtLeastTwo.{0} Real (nat_lit 2) Real.instNatCast ⋯))
                              (@HMul.hMul.{0, 0, 0} Real Real Real (@instHMul.{0} Real Real.instMul)
                                (@HMul.hMul.{0, 0, 0} Real Real Real (@instHMul.{0} Real Real.instMul) c.toReal
                                  (@HPow.hPow.{0, 0, 0} Real Real Real (@instHPow.{0, 0} Real Real Real.instPow)
                                    (@OfNat.ofNat.{0} Real (nat_lit 4)
                                      (@instOfNatAtLeastTwo.{0} Real (nat_lit 4) Real.instNatCast ⋯))
                                    d))
                                (@HPow.hPow.{0, 0, 0} Real Real Real (@instHPow.{0, 0} Real Real Real.instPow)
                                  (@Inv.inv.{0} Real Real.instInv ↑δ) d))))
                          q))
                      (ProbabilityTheory.Cp d p q))) :=
⋯
```

## `ProbabilityTheory.finite_set_bound_of_edist_le_of_diam_le`

Command: `#print ProbabilityTheory.finite_set_bound_of_edist_le_of_diam_le`

```lean
theorem ProbabilityTheory.finite_set_bound_of_edist_le_of_diam_le.{u_1, u_2, u_3} : ∀ {T : Type u_1} {Ω : Type u_2}
  {E : Type u_3} [inst : PseudoEMetricSpace.{u_1} T] {mΩ : MeasurableSpace.{u_2} Ω}
  [inst_1 : PseudoEMetricSpace.{u_3} E] {P : @MeasureTheory.Measure.{u_2} Ω mΩ} {X : T → Ω → E} {M : NNReal}
  {d p q : Real} {J : Set.{u_1} T} {c : ENNReal} {δ : NNReal},
  @HasBoundedCoveringNumber.{u_1} T inst J c d →
    @Set.Finite.{u_1} T J →
      @ProbabilityTheory.IsAEKolmogorovProcess.{u_1, u_2, u_3} T Ω E inst mΩ inst_1 X P p q M →
        @LT.lt.{0} Real Real.instLT (@OfNat.ofNat.{0} Real (nat_lit 0) (@Zero.toOfNat0.{0} Real Real.instZero)) d →
          @LT.lt.{0} Real Real.instLT d q →
            @LE.le.{0} ENNReal ENNReal.instLE (@Metric.ediam.{u_1} T inst J)
                (@HDiv.hDiv.{0, 0, 0} ENNReal ENNReal ENNReal
                  (@instHDiv.{0} ENNReal (@DivInvMonoid.toDiv.{0} ENNReal ENNReal.instDivInvMonoid)) (↑δ)
                  (@OfNat.ofNat.{0} ENNReal (nat_lit 4)
                    (@instOfNatAtLeastTwo.{0} ENNReal (nat_lit 4)
                      (@AddMonoidWithOne.toNatCast.{0} ENNReal
                        (@AddCommMonoidWithOne.toAddMonoidWithOne.{0} ENNReal ENNReal.instAddCommMonoidWithOne))
                      ⋯))) →
              @LE.le.{0} ENNReal ENNReal.instLE
                (@MeasureTheory.lintegral.{u_2} Ω mΩ P fun ω =>
                  ⨆ s,
                    ⨆ t,
                      @HPow.hPow.{0, 0, 0} ENNReal Real ENNReal (@instHPow.{0, 0} ENNReal Real ENNReal.instPowReal)
                        (@EDist.edist.{u_3} E
                          (@WeakPseudoEMetricSpace.toEDist.{u_3} E
                            (@UniformSpace.toTopologicalSpace.{u_3} E
                              (@PseudoEMetricSpace.toUniformSpace.{u_3} E inst_1))
                            (@PseudoEMetricSpace.toWeakPseudoEMetricSpace.{u_3} E inst_1))
                          (X
                            (@Subtype.val.{u_1 + 1} T
                              (fun x => @Membership.mem.{u_1, u_1} T (Set.{u_1} T) (@Set.instMembership.{u_1} T) J x) s)
                            ω)
                          (X
                            (@Subtype.val.{u_1 + 1} T
                              (fun x => @Membership.mem.{u_1, u_1} T (Set.{u_1} T) (@Set.instMembership.{u_1} T) J x)
                              (@Subtype.val.{u_1 + 1} (@Set.Elem.{u_1} T J)
                                (fun t =>
                                  @LE.le.{0} ENNReal ENNReal.instLE
                                    (@EDist.edist.{u_1} (@Set.Elem.{u_1} T J)
                                      (@WeakPseudoEMetricSpace.toEDist.{u_1} (@Set.Elem.{u_1} T J)
                                        (@instTopologicalSpaceSubtype.{u_1} T
                                          (fun x =>
                                            @Membership.mem.{u_1, u_1} T (Set.{u_1} T) (@Set.instMembership.{u_1} T) J
                                              x)
                                          (@UniformSpace.toTopologicalSpace.{u_1} T
                                            (@PseudoEMetricSpace.toUniformSpace.{u_1} T inst)))
                                        (@instWeakPseudoEMetricSpaceSubtype.{u_1} T
                                          (fun x =>
                                            @Membership.mem.{u_1, u_1} T (Set.{u_1} T) (@Set.instMembership.{u_1} T) J
                                              x)
                                          (@UniformSpace.toTopologicalSpace.{u_1} T
                                            (@PseudoEMetricSpace.toUniformSpace.{u_1} T inst))
                                          (@PseudoEMetricSpace.toWeakPseudoEMetricSpace.{u_1} T inst)))
                                      s t)
                                    ↑δ)
                                t))
                            ω))
                        p)
                (@HMul.hMul.{0, 0, 0} ENNReal ENNReal ENNReal
                  (@instHMul.{0} ENNReal
                    (@Distrib.toMul.{0} ENNReal
                      (@instDistribOfSemiring.{0} ENNReal
                        (@CommSemiring.toSemiring.{0} ENNReal ENNReal.instCommSemiring))))
                  (@HMul.hMul.{0, 0, 0} ENNReal ENNReal ENNReal
                    (@instHMul.{0} ENNReal
                      (@Distrib.toMul.{0} ENNReal
                        (@instDistribOfSemiring.{0} ENNReal
                          (@CommSemiring.toSemiring.{0} ENNReal ENNReal.instCommSemiring))))
                    (@HMul.hMul.{0, 0, 0} ENNReal ENNReal ENNReal
                      (@instHMul.{0} ENNReal
                        (@Distrib.toMul.{0} ENNReal
                          (@instDistribOfSemiring.{0} ENNReal
                            (@CommSemiring.toSemiring.{0} ENNReal ENNReal.instCommSemiring))))
                      (@HMul.hMul.{0, 0, 0} ENNReal ENNReal ENNReal
                        (@instHMul.{0} ENNReal
                          (@Distrib.toMul.{0} ENNReal
                            (@instDistribOfSemiring.{0} ENNReal
                              (@CommSemiring.toSemiring.{0} ENNReal ENNReal.instCommSemiring))))
                        (@HMul.hMul.{0, 0, 0} ENNReal ENNReal ENNReal
                          (@instHMul.{0} ENNReal
                            (@Distrib.toMul.{0} ENNReal
                              (@instDistribOfSemiring.{0} ENNReal
                                (@CommSemiring.toSemiring.{0} ENNReal ENNReal.instCommSemiring))))
                          (@HPow.hPow.{0, 0, 0} ENNReal Real ENNReal (@instHPow.{0, 0} ENNReal Real ENNReal.instPowReal)
                            (@OfNat.ofNat.{0} ENNReal (nat_lit 4)
                              (@instOfNatAtLeastTwo.{0} ENNReal (nat_lit 4)
                                (@AddMonoidWithOne.toNatCast.{0} ENNReal
                                  (@AddCommMonoidWithOne.toAddMonoidWithOne.{0} ENNReal
                                    ENNReal.instAddCommMonoidWithOne))
                                ⋯))
                            p)
                          (@HPow.hPow.{0, 0, 0} ENNReal Real ENNReal (@instHPow.{0, 0} ENNReal Real ENNReal.instPowReal)
                            (@OfNat.ofNat.{0} ENNReal (nat_lit 2)
                              (@instOfNatAtLeastTwo.{0} ENNReal (nat_lit 2)
                                (@AddMonoidWithOne.toNatCast.{0} ENNReal
                                  (@AddCommMonoidWithOne.toAddMonoidWithOne.{0} ENNReal
                                    ENNReal.instAddCommMonoidWithOne))
                                ⋯))
                            q))
                        ↑M)
                      c)
                    (@HPow.hPow.{0, 0, 0} ENNReal Real ENNReal (@instHPow.{0, 0} ENNReal Real ENNReal.instPowReal) (↑δ)
                      (@HSub.hSub.{0, 0, 0} Real Real Real (@instHSub.{0} Real Real.instSub) q d)))
                  (ProbabilityTheory.Cp d p q)) :=
⋯
```

## `ProbabilityTheory.finite_set_bound_of_edist_le_of_le_diam`

Command: `#print ProbabilityTheory.finite_set_bound_of_edist_le_of_le_diam`

```lean
theorem ProbabilityTheory.finite_set_bound_of_edist_le_of_le_diam.{u_1, u_2, u_3} : ∀ {T : Type u_1} {Ω : Type u_2}
  {E : Type u_3} [inst : PseudoEMetricSpace.{u_1} T] {mΩ : MeasurableSpace.{u_2} Ω}
  [inst_1 : PseudoEMetricSpace.{u_3} E] {P : @MeasureTheory.Measure.{u_2} Ω mΩ} {X : T → Ω → E} {M : NNReal}
  {d p q : Real} {J : Set.{u_1} T} {c : ENNReal} {δ : NNReal},
  @HasBoundedCoveringNumber.{u_1} T inst J c d →
    @Set.Finite.{u_1} T J →
      @ProbabilityTheory.IsAEKolmogorovProcess.{u_1, u_2, u_3} T Ω E inst mΩ inst_1 X P p q M →
        @LT.lt.{0} Real Real.instLT (@OfNat.ofNat.{0} Real (nat_lit 0) (@Zero.toOfNat0.{0} Real Real.instZero)) d →
          @LT.lt.{0} Real Real.instLT d q →
            @Ne.{1} NNReal δ (@OfNat.ofNat.{0} NNReal (nat_lit 0) (@Zero.toOfNat0.{0} NNReal NNReal.instZero)) →
              @LE.le.{0} ENNReal ENNReal.instLE
                  (@HDiv.hDiv.{0, 0, 0} ENNReal ENNReal ENNReal
                    (@instHDiv.{0} ENNReal (@DivInvMonoid.toDiv.{0} ENNReal ENNReal.instDivInvMonoid)) (↑δ)
                    (@OfNat.ofNat.{0} ENNReal (nat_lit 4)
                      (@instOfNatAtLeastTwo.{0} ENNReal (nat_lit 4)
                        (@AddMonoidWithOne.toNatCast.{0} ENNReal
                          (@AddCommMonoidWithOne.toAddMonoidWithOne.{0} ENNReal ENNReal.instAddCommMonoidWithOne))
                        ⋯)))
                  (@Metric.ediam.{u_1} T inst J) →
                @LE.le.{0} ENNReal ENNReal.instLE
                  (@MeasureTheory.lintegral.{u_2} Ω mΩ P fun ω =>
                    ⨆ s,
                      ⨆ t,
                        @HPow.hPow.{0, 0, 0} ENNReal Real ENNReal (@instHPow.{0, 0} ENNReal Real ENNReal.instPowReal)
                          (@EDist.edist.{u_3} E
                            (@WeakPseudoEMetricSpace.toEDist.{u_3} E
                              (@UniformSpace.toTopologicalSpace.{u_3} E
                                (@PseudoEMetricSpace.toUniformSpace.{u_3} E inst_1))
                              (@PseudoEMetricSpace.toWeakPseudoEMetricSpace.{u_3} E inst_1))
                            (X
                              (@Subtype.val.{u_1 + 1} T
                                (fun x => @Membership.mem.{u_1, u_1} T (Set.{u_1} T) (@Set.instMembership.{u_1} T) J x)
                                s)
                              ω)
                            (X
                              (@Subtype.val.{u_1 + 1} T
                                (fun x => @Membership.mem.{u_1, u_1} T (Set.{u_1} T) (@Set.instMembership.{u_1} T) J x)
                                (@Subtype.val.{u_1 + 1} (@Set.Elem.{u_1} T J)
                                  (fun t =>
                                    @LE.le.{0} ENNReal ENNReal.instLE
                                      (@EDist.edist.{u_1} (@Set.Elem.{u_1} T J)
                                        (@WeakPseudoEMetricSpace.toEDist.{u_1} (@Set.Elem.{u_1} T J)
                                          (@instTopologicalSpaceSubtype.{u_1} T
                                            (fun x =>
                                              @Membership.mem.{u_1, u_1} T (Set.{u_1} T) (@Set.instMembership.{u_1} T) J
                                                x)
                                            (@UniformSpace.toTopologicalSpace.{u_1} T
                                              (@PseudoEMetricSpace.toUniformSpace.{u_1} T inst)))
                                          (@instWeakPseudoEMetricSpaceSubtype.{u_1} T
                                            (fun x =>
                                              @Membership.mem.{u_1, u_1} T (Set.{u_1} T) (@Set.instMembership.{u_1} T) J
                                                x)
                                            (@UniformSpace.toTopologicalSpace.{u_1} T
                                              (@PseudoEMetricSpace.toUniformSpace.{u_1} T inst))
                                            (@PseudoEMetricSpace.toWeakPseudoEMetricSpace.{u_1} T inst)))
                                        s t)
                                      ↑δ)
                                  t))
                              ω))
                          p)
                  (@HMul.hMul.{0, 0, 0} ENNReal ENNReal ENNReal
                    (@instHMul.{0} ENNReal
                      (@Distrib.toMul.{0} ENNReal
                        (@instDistribOfSemiring.{0} ENNReal
                          (@CommSemiring.toSemiring.{0} ENNReal ENNReal.instCommSemiring))))
                    (@HMul.hMul.{0, 0, 0} ENNReal ENNReal ENNReal
                      (@instHMul.{0} ENNReal
                        (@Distrib.toMul.{0} ENNReal
                          (@instDistribOfSemiring.{0} ENNReal
                            (@CommSemiring.toSemiring.{0} ENNReal ENNReal.instCommSemiring))))
                      (@HMul.hMul.{0, 0, 0} ENNReal ENNReal ENNReal
                        (@instHMul.{0} ENNReal
                          (@Distrib.toMul.{0} ENNReal
                            (@instDistribOfSemiring.{0} ENNReal
                              (@CommSemiring.toSemiring.{0} ENNReal ENNReal.instCommSemiring))))
                        (@HPow.hPow.{0, 0, 0} ENNReal Real ENNReal (@instHPow.{0, 0} ENNReal Real ENNReal.instPowReal)
                          (@OfNat.ofNat.{0} ENNReal (nat_lit 2)
                            (@instOfNatAtLeastTwo.{0} ENNReal (nat_lit 2)
                              (@AddMonoidWithOne.toNatCast.{0} ENNReal
                                (@AddCommMonoidWithOne.toAddMonoidWithOne.{0} ENNReal ENNReal.instAddCommMonoidWithOne))
                              ⋯))
                          (@HAdd.hAdd.{0, 0, 0} Real Real Real (@instHAdd.{0} Real Real.instAdd)
                            (@HAdd.hAdd.{0, 0, 0} Real Real Real (@instHAdd.{0} Real Real.instAdd)
                              (@HMul.hMul.{0, 0, 0} Real Real Real (@instHMul.{0} Real Real.instMul)
                                (@OfNat.ofNat.{0} Real (nat_lit 2)
                                  (@instOfNatAtLeastTwo.{0} Real (nat_lit 2) Real.instNatCast ⋯))
                                p)
                              (@HMul.hMul.{0, 0, 0} Real Real Real (@instHMul.{0} Real Real.instMul)
                                (@OfNat.ofNat.{0} Real (nat_lit 4)
                                  (@instOfNatAtLeastTwo.{0} Real (nat_lit 4) Real.instNatCast ⋯))
                                q))
                            (@OfNat.ofNat.{0} Real (nat_lit 1) (@One.toOfNat1.{0} Real Real.instOne))))
                        ↑M)
                      (@HPow.hPow.{0, 0, 0} ENNReal Real ENNReal (@instHPow.{0, 0} ENNReal Real ENNReal.instPowReal)
                        (↑δ) (@HSub.hSub.{0, 0, 0} Real Real Real (@instHSub.{0} Real Real.instSub) q d)))
                    (@HAdd.hAdd.{0, 0, 0} ENNReal ENNReal ENNReal (@instHAdd.{0} ENNReal ENNReal.instAdd)
                      (@HMul.hMul.{0, 0, 0} ENNReal ENNReal ENNReal
                        (@instHMul.{0} ENNReal
                          (@Distrib.toMul.{0} ENNReal
                            (@instDistribOfSemiring.{0} ENNReal
                              (@CommSemiring.toSemiring.{0} ENNReal ENNReal.instCommSemiring))))
                        (@HMul.hMul.{0, 0, 0} ENNReal ENNReal ENNReal
                          (@instHMul.{0} ENNReal
                            (@Distrib.toMul.{0} ENNReal
                              (@instDistribOfSemiring.{0} ENNReal
                                (@CommSemiring.toSemiring.{0} ENNReal ENNReal.instCommSemiring))))
                          (@HPow.hPow.{0, 0, 0} ENNReal Real ENNReal (@instHPow.{0, 0} ENNReal Real ENNReal.instPowReal)
                            (↑δ) d)
                          (@HPow.hPow.{0, 0, 0} ENNReal Real ENNReal (@instHPow.{0, 0} ENNReal Real ENNReal.instPowReal)
                            (@Nat.cast.{0} ENNReal
                              (@AddMonoidWithOne.toNatCast.{0} ENNReal
                                (@AddCommMonoidWithOne.toAddMonoidWithOne.{0} ENNReal ENNReal.instAddCommMonoidWithOne))
                              (@Metric.coveringNumber.{u_1} T inst
                                    (@HDiv.hDiv.{0, 0, 0} NNReal NNReal NNReal (@instHDiv.{0} NNReal NNReal.instDiv) δ
                                      (@OfNat.ofNat.{0} NNReal (nat_lit 4)
                                        (@instOfNatAtLeastTwo.{0} NNReal (nat_lit 4)
                                          (@AddMonoidWithOne.toNatCast.{0} NNReal
                                            (@AddCommMonoidWithOne.toAddMonoidWithOne.{0} NNReal
                                              (@NonAssocSemiring.toAddCommMonoidWithOne.{0} NNReal
                                                (@Semiring.toNonAssocSemiring.{0} NNReal NNReal.instSemiring))))
                                          ⋯)))
                                    J).toNat.log2)
                            q))
                        ↑(@Metric.coveringNumber.{u_1} T inst
                            (@HDiv.hDiv.{0, 0, 0} NNReal NNReal NNReal (@instHDiv.{0} NNReal NNReal.instDiv) δ
                              (@OfNat.ofNat.{0} NNReal (nat_lit 4)
                                (@instOfNatAtLeastTwo.{0} NNReal (nat_lit 4)
                                  (@AddMonoidWithOne.toNatCast.{0} NNReal
                                    (@AddCommMonoidWithOne.toAddMonoidWithOne.{0} NNReal
                                      (@NonAssocSemiring.toAddCommMonoidWithOne.{0} NNReal
                                        (@Semiring.toNonAssocSemiring.{0} NNReal NNReal.instSemiring))))
                                  ⋯)))
                            J))
                      (@HMul.hMul.{0, 0, 0} ENNReal ENNReal ENNReal
                        (@instHMul.{0} ENNReal
                          (@Distrib.toMul.{0} ENNReal
                            (@instDistribOfSemiring.{0} ENNReal
                              (@CommSemiring.toSemiring.{0} ENNReal ENNReal.instCommSemiring))))
                        c (ProbabilityTheory.Cp d p q)))) :=
⋯
```

## `ProbabilityTheory.finite_set_bound_of_edist_le_of_le_diam'`

Command: `#print ProbabilityTheory.finite_set_bound_of_edist_le_of_le_diam'`

```lean
theorem ProbabilityTheory.finite_set_bound_of_edist_le_of_le_diam'.{u_1, u_2, u_3} : ∀ {T : Type u_1} {Ω : Type u_2}
  {E : Type u_3} [inst : PseudoEMetricSpace.{u_1} T] {mΩ : MeasurableSpace.{u_2} Ω}
  [inst_1 : PseudoEMetricSpace.{u_3} E] {P : @MeasureTheory.Measure.{u_2} Ω mΩ} {X : T → Ω → E} {M : NNReal}
  {d p q : Real} {J : Set.{u_1} T} {c : ENNReal} {δ : NNReal},
  @HasBoundedCoveringNumber.{u_1} T inst J c d →
    @Set.Finite.{u_1} T J →
      @ProbabilityTheory.IsAEKolmogorovProcess.{u_1, u_2, u_3} T Ω E inst mΩ inst_1 X P p q M →
        @Ne.{1} ENNReal c (@Top.top.{0} ENNReal ENNReal.instTop) →
          @LT.lt.{0} Real Real.instLT (@OfNat.ofNat.{0} Real (nat_lit 0) (@Zero.toOfNat0.{0} Real Real.instZero)) d →
            @LT.lt.{0} Real Real.instLT d q →
              @Ne.{1} NNReal δ (@OfNat.ofNat.{0} NNReal (nat_lit 0) (@Zero.toOfNat0.{0} NNReal NNReal.instZero)) →
                @LE.le.{0} ENNReal ENNReal.instLE
                    (@HDiv.hDiv.{0, 0, 0} ENNReal ENNReal ENNReal
                      (@instHDiv.{0} ENNReal (@DivInvMonoid.toDiv.{0} ENNReal ENNReal.instDivInvMonoid)) (↑δ)
                      (@OfNat.ofNat.{0} ENNReal (nat_lit 4)
                        (@instOfNatAtLeastTwo.{0} ENNReal (nat_lit 4)
                          (@AddMonoidWithOne.toNatCast.{0} ENNReal
                            (@AddCommMonoidWithOne.toAddMonoidWithOne.{0} ENNReal ENNReal.instAddCommMonoidWithOne))
                          ⋯)))
                    (@Metric.ediam.{u_1} T inst J) →
                  @LE.le.{0} ENNReal ENNReal.instLE
                    (@MeasureTheory.lintegral.{u_2} Ω mΩ P fun ω =>
                      ⨆ s,
                        ⨆ t,
                          @HPow.hPow.{0, 0, 0} ENNReal Real ENNReal (@instHPow.{0, 0} ENNReal Real ENNReal.instPowReal)
                            (@EDist.edist.{u_3} E
                              (@WeakPseudoEMetricSpace.toEDist.{u_3} E
                                (@UniformSpace.toTopologicalSpace.{u_3} E
                                  (@PseudoEMetricSpace.toUniformSpace.{u_3} E inst_1))
                                (@PseudoEMetricSpace.toWeakPseudoEMetricSpace.{u_3} E inst_1))
                              (X
                                (@Subtype.val.{u_1 + 1} T
                                  (fun x =>
                                    @Membership.mem.{u_1, u_1} T (Set.{u_1} T) (@Set.instMembership.{u_1} T) J x)
                                  s)
                                ω)
                              (X
                                (@Subtype.val.{u_1 + 1} T
                                  (fun x =>
                                    @Membership.mem.{u_1, u_1} T (Set.{u_1} T) (@Set.instMembership.{u_1} T) J x)
                                  (@Subtype.val.{u_1 + 1} (@Set.Elem.{u_1} T J)
                                    (fun t =>
                                      @LE.le.{0} ENNReal ENNReal.instLE
                                        (@EDist.edist.{u_1} (@Set.Elem.{u_1} T J)
                                          (@WeakPseudoEMetricSpace.toEDist.{u_1} (@Set.Elem.{u_1} T J)
                                            (@instTopologicalSpaceSubtype.{u_1} T
                                              (fun x =>
                                                @Membership.mem.{u_1, u_1} T (Set.{u_1} T) (@Set.instMembership.{u_1} T)
                                                  J x)
                                              (@UniformSpace.toTopologicalSpace.{u_1} T
                                                (@PseudoEMetricSpace.toUniformSpace.{u_1} T inst)))
                                            (@instWeakPseudoEMetricSpaceSubtype.{u_1} T
                                              (fun x =>
                                                @Membership.mem.{u_1, u_1} T (Set.{u_1} T) (@Set.instMembership.{u_1} T)
                                                  J x)
                                              (@UniformSpace.toTopologicalSpace.{u_1} T
                                                (@PseudoEMetricSpace.toUniformSpace.{u_1} T inst))
                                              (@PseudoEMetricSpace.toWeakPseudoEMetricSpace.{u_1} T inst)))
                                          s t)
                                        ↑δ)
                                    t))
                                ω))
                            p)
                    (@HMul.hMul.{0, 0, 0} ENNReal ENNReal ENNReal
                      (@instHMul.{0} ENNReal
                        (@Distrib.toMul.{0} ENNReal
                          (@instDistribOfSemiring.{0} ENNReal
                            (@CommSemiring.toSemiring.{0} ENNReal ENNReal.instCommSemiring))))
                      (@HMul.hMul.{0, 0, 0} ENNReal ENNReal ENNReal
                        (@instHMul.{0} ENNReal
                          (@Distrib.toMul.{0} ENNReal
                            (@instDistribOfSemiring.{0} ENNReal
                              (@CommSemiring.toSemiring.{0} ENNReal ENNReal.instCommSemiring))))
                        (@HMul.hMul.{0, 0, 0} ENNReal ENNReal ENNReal
                          (@instHMul.{0} ENNReal
                            (@Distrib.toMul.{0} ENNReal
                              (@instDistribOfSemiring.{0} ENNReal
                                (@CommSemiring.toSemiring.{0} ENNReal ENNReal.instCommSemiring))))
                          (@HMul.hMul.{0, 0, 0} ENNReal ENNReal ENNReal
                            (@instHMul.{0} ENNReal
                              (@Distrib.toMul.{0} ENNReal
                                (@instDistribOfSemiring.{0} ENNReal
                                  (@CommSemiring.toSemiring.{0} ENNReal ENNReal.instCommSemiring))))
                            (@HPow.hPow.{0, 0, 0} ENNReal Real ENNReal
                              (@instHPow.{0, 0} ENNReal Real ENNReal.instPowReal)
                              (@OfNat.ofNat.{0} ENNReal (nat_lit 2)
                                (@instOfNatAtLeastTwo.{0} ENNReal (nat_lit 2)
                                  (@AddMonoidWithOne.toNatCast.{0} ENNReal
                                    (@AddCommMonoidWithOne.toAddMonoidWithOne.{0} ENNReal
                                      ENNReal.instAddCommMonoidWithOne))
                                  ⋯))
                              (@HAdd.hAdd.{0, 0, 0} Real Real Real (@instHAdd.{0} Real Real.instAdd)
                                (@HAdd.hAdd.{0, 0, 0} Real Real Real (@instHAdd.{0} Real Real.instAdd)
                                  (@HMul.hMul.{0, 0, 0} Real Real Real (@instHMul.{0} Real Real.instMul)
                                    (@OfNat.ofNat.{0} Real (nat_lit 2)
                                      (@instOfNatAtLeastTwo.{0} Real (nat_lit 2) Real.instNatCast ⋯))
                                    p)
                                  (@HMul.hMul.{0, 0, 0} Real Real Real (@instHMul.{0} Real Real.instMul)
                                    (@OfNat.ofNat.{0} Real (nat_lit 4)
                                      (@instOfNatAtLeastTwo.{0} Real (nat_lit 4) Real.instNatCast ⋯))
                                    q))
                                (@OfNat.ofNat.{0} Real (nat_lit 1) (@One.toOfNat1.{0} Real Real.instOne))))
                            ↑M)
                          c)
                        (@HPow.hPow.{0, 0, 0} ENNReal Real ENNReal (@instHPow.{0, 0} ENNReal Real ENNReal.instPowReal)
                          (↑δ) (@HSub.hSub.{0, 0, 0} Real Real Real (@instHSub.{0} Real Real.instSub) q d)))
                      (@HAdd.hAdd.{0, 0, 0} ENNReal ENNReal ENNReal (@instHAdd.{0} ENNReal ENNReal.instAdd)
                        (@HMul.hMul.{0, 0, 0} ENNReal ENNReal ENNReal
                          (@instHMul.{0} ENNReal
                            (@Distrib.toMul.{0} ENNReal
                              (@instDistribOfSemiring.{0} ENNReal
                                (@CommSemiring.toSemiring.{0} ENNReal ENNReal.instCommSemiring))))
                          (@HPow.hPow.{0, 0, 0} ENNReal Real ENNReal (@instHPow.{0, 0} ENNReal Real ENNReal.instPowReal)
                            (@OfNat.ofNat.{0} ENNReal (nat_lit 4)
                              (@instOfNatAtLeastTwo.{0} ENNReal (nat_lit 4)
                                (@AddMonoidWithOne.toNatCast.{0} ENNReal
                                  (@AddCommMonoidWithOne.toAddMonoidWithOne.{0} ENNReal
                                    ENNReal.instAddCommMonoidWithOne))
                                ⋯))
                            d)
                          (@HPow.hPow.{0, 0, 0} ENNReal Real ENNReal (@instHPow.{0, 0} ENNReal Real ENNReal.instPowReal)
                            (ENNReal.ofReal
                              (Real.logb
                                (@OfNat.ofNat.{0} Real (nat_lit 2)
                                  (@instOfNatAtLeastTwo.{0} Real (nat_lit 2) Real.instNatCast ⋯))
                                (@HMul.hMul.{0, 0, 0} Real Real Real (@instHMul.{0} Real Real.instMul)
                                  (@HMul.hMul.{0, 0, 0} Real Real Real (@instHMul.{0} Real Real.instMul) c.toReal
                                    (@HPow.hPow.{0, 0, 0} Real Real Real (@instHPow.{0, 0} Real Real Real.instPow)
                                      (@OfNat.ofNat.{0} Real (nat_lit 4)
                                        (@instOfNatAtLeastTwo.{0} Real (nat_lit 4) Real.instNatCast ⋯))
                                      d))
                                  (@HPow.hPow.{0, 0, 0} Real Real Real (@instHPow.{0, 0} Real Real Real.instPow)
                                    (@Inv.inv.{0} Real Real.instInv ↑δ) d))))
                            q))
                        (ProbabilityTheory.Cp d p q))) :=
⋯
```

## `ProbabilityTheory.gaussianLimit`

Command: `#print ProbabilityTheory.gaussianLimit`

```lean
def ProbabilityTheory.gaussianLimit : @MeasureTheory.Measure.{0} (NNReal → Real)
  (@MeasurableSpace.pi.{0, 0} NNReal (fun a => Real) fun a => Real.measurableSpace) :=
@MeasureTheory.projectiveLimit.{0, 0} NNReal (fun a => Real) (fun a => Real.measurableSpace)
  (fun i =>
    @UniformSpace.toTopologicalSpace.{0} Real (@PseudoMetricSpace.toUniformSpace.{0} Real Real.pseudoMetricSpace))
  ⋯ ProbabilityTheory.gaussianLimit._proof_1 ProbabilityTheory.gaussianProjectiveFamily
  ProbabilityTheory.gaussianLimit._proof_2 ProbabilityTheory.isProjectiveMeasureFamily_gaussianProjectiveFamily
```

## `ProbabilityTheory.gaussianProjectiveFamily`

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

## `ProbabilityTheory.hasLaw_preBrownian`

Command: `#print ProbabilityTheory.hasLaw_preBrownian`

```lean
theorem ProbabilityTheory.hasLaw_preBrownian : @ProbabilityTheory.HasLaw.{0, 0} (NNReal → Real) (NNReal → Real)
  (@MeasurableSpace.pi.{0, 0} NNReal (fun a => Real) fun a => Real.measurableSpace)
  (@MeasurableSpace.pi.{0, 0} NNReal (fun a => Real) fun a => Real.measurableSpace)
  (fun ω x => ProbabilityTheory.preBrownian x ω) ProbabilityTheory.gaussianLimit ProbabilityTheory.gaussianLimit :=
⋯
```

## `ProbabilityTheory.hasLaw_restrict_gaussianLimit`

Command: `#print ProbabilityTheory.hasLaw_restrict_gaussianLimit`

```lean
theorem ProbabilityTheory.hasLaw_restrict_gaussianLimit : ∀ {I : Finset.{0} NNReal},
  @ProbabilityTheory.HasLaw.{0, 0} (NNReal → Real) (↥I → Real)
    (@MeasurableSpace.pi.{0, 0} NNReal (fun a => Real) fun a => Real.measurableSpace)
    (@MeasurableSpace.pi.{0, 0} (↥I) (fun a => Real) fun a => Real.measurableSpace)
    (@Finset.restrict.{0, 0} NNReal (fun i => Real) I) (ProbabilityTheory.gaussianProjectiveFamily I)
    ProbabilityTheory.gaussianLimit :=
⋯
```

## `ProbabilityTheory.holderModification`

Command: `#print ProbabilityTheory.holderModification`

```lean
def ProbabilityTheory.holderModification.{u_1, u_2, u_3} : {T : Type u_1} →
  {Ω : Type u_2} →
    {E : Type u_3} →
      [inst : PseudoEMetricSpace.{u_1} T] →
        [PseudoEMetricSpace.{u_3} E] →
          [hE : Nonempty.{u_3 + 1} E] →
            [@SecondCountableTopology.{u_1} T
                  (@UniformSpace.toTopologicalSpace.{u_1} T (@PseudoEMetricSpace.toUniformSpace.{u_1} T inst))] →
              (T → Ω → E) →
                NNReal →
                  Real →
                    (U : Set.{u_1} T) →
                      [@DecidablePred.{u_1 + 1} T fun x =>
                            @Membership.mem.{u_1, u_1} T (Set.{u_1} T) (@Set.instMembership.{u_1} T) U x] →
                        T → Ω → E :=
fun {T} {Ω} {E} [inst : PseudoEMetricSpace.{u_1} T] [inst_1 : PseudoEMetricSpace.{u_3} E] [hE : Nonempty.{u_3 + 1} E]
    [inst_2 :
      @SecondCountableTopology.{u_1} T
        (@UniformSpace.toTopologicalSpace.{u_1} T (@PseudoEMetricSpace.toUniformSpace.{u_1} T inst))]
    X β p U
    [inst_3 :
      @DecidablePred.{u_1 + 1} T fun x => @Membership.mem.{u_1, u_1} T (Set.{u_1} T) (@Set.instMembership.{u_1} T) U x]
    t ω =>
  @ite.{u_3 + 1} E (@Membership.mem.{u_1, u_1} T (Set.{u_1} T) (@Set.instMembership.{u_1} T) U t) (inst_3 t)
    (@Filter.limUnder.{u_3, u_1} E
      (@UniformSpace.toTopologicalSpace.{u_3} E (@PseudoEMetricSpace.toUniformSpace.{u_3} E inst_1))
      (@Subtype.{u_1 + 1} T fun x =>
        @Membership.mem.{u_1, u_1} T (Set.{u_1} T) (@Set.instMembership.{u_1} T)
          (@denseCountable.{u_1} T
            (@UniformSpace.toTopologicalSpace.{u_1} T (@PseudoEMetricSpace.toUniformSpace.{u_1} T inst)) inst_2)
          x)
      hE
      (@Filter.comap.{u_1, u_1}
        (@Subtype.{u_1 + 1} T fun x =>
          @Membership.mem.{u_1, u_1} T (Set.{u_1} T) (@Set.instMembership.{u_1} T)
            (@denseCountable.{u_1} T
              (@UniformSpace.toTopologicalSpace.{u_1} T (@PseudoEMetricSpace.toUniformSpace.{u_1} T inst)) inst_2)
            x)
        T
        (@Subtype.val.{u_1 + 1} T fun x =>
          @Membership.mem.{u_1, u_1} T (Set.{u_1} T) (@Set.instMembership.{u_1} T)
            (@denseCountable.{u_1} T
              (@UniformSpace.toTopologicalSpace.{u_1} T (@PseudoEMetricSpace.toUniformSpace.{u_1} T inst)) inst_2)
            x)
        (@nhds.{u_1} T (@UniformSpace.toTopologicalSpace.{u_1} T (@PseudoEMetricSpace.toUniformSpace.{u_1} T inst)) t))
      fun t' =>
      @ProbabilityTheory.indicatorProcess.{u_1, u_2, u_3} T Ω E hE X
        (@ProbabilityTheory.holderSet.{u_1, u_2, u_3} T Ω E inst inst_1 X
          (@denseCountable.{u_1} T
            (@UniformSpace.toTopologicalSpace.{u_1} T (@PseudoEMetricSpace.toUniformSpace.{u_1} T inst)) inst_2)
          p (↑β) U)
        (@Subtype.val.{u_1 + 1} T
          (fun x =>
            @Membership.mem.{u_1, u_1} T (Set.{u_1} T) (@Set.instMembership.{u_1} T)
              (@denseCountable.{u_1} T
                (@UniformSpace.toTopologicalSpace.{u_1} T (@PseudoEMetricSpace.toUniformSpace.{u_1} T inst)) inst_2)
              x)
          t')
        ω)
    (@Nonempty.some.{u_3 + 1} E hE)
```

## `ProbabilityTheory.holderOnWith_holderModification`

Command: `#print ProbabilityTheory.holderOnWith_holderModification`

```lean
theorem ProbabilityTheory.holderOnWith_holderModification.{u_1, u_2, u_3} : ∀ {T : Type u_1} {Ω : Type u_2}
  {E : Type u_3} {mΩ : MeasurableSpace.{u_2} Ω} {X : T → Ω → E} {c : ENNReal} {d p q : Real} {M β : NNReal}
  {P : @MeasureTheory.Measure.{u_2} Ω mΩ} {U : Set.{u_1} T} [inst : PseudoEMetricSpace.{u_1} T]
  [inst_1 : PseudoEMetricSpace.{u_3} E] [@CompleteSpace.{u_3} E (@PseudoEMetricSpace.toUniformSpace.{u_3} E inst_1)]
  [hE : Nonempty.{u_3 + 1} E]
  [inst_3 :
    @SecondCountableTopology.{u_1} T
      (@UniformSpace.toTopologicalSpace.{u_1} T (@PseudoEMetricSpace.toUniformSpace.{u_1} T inst))],
  @HasBoundedCoveringNumber.{u_1} T inst U c d →
    ∀
      [inst_4 :
        @DecidablePred.{u_1 + 1} T fun x =>
          @Membership.mem.{u_1, u_1} T (Set.{u_1} T) (@Set.instMembership.{u_1} T) U x],
      @IsOpen.{u_1} T (@UniformSpace.toTopologicalSpace.{u_1} T (@PseudoEMetricSpace.toUniformSpace.{u_1} T inst)) U →
        @ProbabilityTheory.IsKolmogorovProcess.{u_1, u_2, u_3} T Ω E inst mΩ inst_1 X P p q M →
          @LT.lt.{0} NNReal (@Preorder.toLT.{0} NNReal (@PartialOrder.toPreorder.{0} NNReal NNReal.instPartialOrder))
              (@OfNat.ofNat.{0} NNReal (nat_lit 0) (@Zero.toOfNat0.{0} NNReal NNReal.instZero)) β →
            ∀ (ω : Ω),
              ∃ C,
                @HolderOnWith.{u_1, u_3} T E inst inst_1 C β
                  (fun x =>
                    @ProbabilityTheory.holderModification.{u_1, u_2, u_3} T Ω E inst inst_1 hE inst_3 X β p U inst_4 x
                      ω)
                  U :=
⋯
```

## `ProbabilityTheory.holderOnWith_of_mem_holderSet`

Command: `#print ProbabilityTheory.holderOnWith_of_mem_holderSet`

```lean
theorem ProbabilityTheory.holderOnWith_of_mem_holderSet.{u_1, u_2, u_3} : ∀ {T : Type u_1} {Ω : Type u_2} {E : Type u_3}
  {X : T → Ω → E} {c : ENNReal} {d p : Real} {β : NNReal} {U : Set.{u_1} T} [inst : PseudoEMetricSpace.{u_1} T]
  [inst_1 : PseudoEMetricSpace.{u_3} E],
  @HasBoundedCoveringNumber.{u_1} T inst U c d →
    @LT.lt.{0} Real Real.instLT (@OfNat.ofNat.{0} Real (nat_lit 0) (@Zero.toOfNat0.{0} Real Real.instZero)) p →
      @LT.lt.{0} NNReal (@Preorder.toLT.{0} NNReal (@PartialOrder.toPreorder.{0} NNReal NNReal.instPartialOrder))
          (@OfNat.ofNat.{0} NNReal (nat_lit 0) (@Zero.toOfNat0.{0} NNReal NNReal.instZero)) β →
        ∀ {T' : Set.{u_1} T} {ω : Ω},
          @Membership.mem.{u_2, u_2} Ω (Set.{u_2} Ω) (@Set.instMembership.{u_2} Ω)
              (@ProbabilityTheory.holderSet.{u_1, u_2, u_3} T Ω E inst inst_1 X T' p (↑β) U) ω →
            @HolderOnWith.{u_1, u_3} (@Set.Elem.{u_1} T T') E
              (@instPseudoEMetricSpaceSubtype.{u_1} T
                (fun x => @Membership.mem.{u_1, u_1} T (Set.{u_1} T) (@Set.instMembership.{u_1} T) T' x) inst)
              inst_1
              (@HPow.hPow.{0, 0, 0} ENNReal Real ENNReal (@instHPow.{0, 0} ENNReal Real ENNReal.instPowReal)
                  ((fun ω =>
                      ⨆ s,
                        ⨆ t,
                          @HDiv.hDiv.{0, 0, 0} ENNReal ENNReal ENNReal
                            (@instHDiv.{0} ENNReal (@DivInvMonoid.toDiv.{0} ENNReal ENNReal.instDivInvMonoid))
                            (@HPow.hPow.{0, 0, 0} ENNReal Real ENNReal
                              (@instHPow.{0, 0} ENNReal Real ENNReal.instPowReal)
                              (@EDist.edist.{u_3} E
                                (@WeakPseudoEMetricSpace.toEDist.{u_3} E
                                  (@UniformSpace.toTopologicalSpace.{u_3} E
                                    (@PseudoEMetricSpace.toUniformSpace.{u_3} E inst_1))
                                  (@PseudoEMetricSpace.toWeakPseudoEMetricSpace.{u_3} E inst_1))
                                (X
                                  (@Subtype.val.{u_1 + 1} T
                                    (fun x =>
                                      @Membership.mem.{u_1, u_1} T (Set.{u_1} T) (@Set.instMembership.{u_1} T)
                                        (@Inter.inter.{u_1} (Set.{u_1} T) (@Set.instInter.{u_1} T) T' U) x)
                                    s)
                                  ω)
                                (X
                                  (@Subtype.val.{u_1 + 1} T
                                    (fun x =>
                                      @Membership.mem.{u_1, u_1} T (Set.{u_1} T) (@Set.instMembership.{u_1} T)
                                        (@Inter.inter.{u_1} (Set.{u_1} T) (@Set.instInter.{u_1} T) T' U) x)
                                    t)
                                  ω))
                              p)
                            (@HPow.hPow.{0, 0, 0} ENNReal Real ENNReal
                              (@instHPow.{0, 0} ENNReal Real ENNReal.instPowReal)
                              (@EDist.edist.{u_1}
                                (@Set.Elem.{u_1} T (@Inter.inter.{u_1} (Set.{u_1} T) (@Set.instInter.{u_1} T) T' U))
                                (@WeakPseudoEMetricSpace.toEDist.{u_1}
                                  (@Set.Elem.{u_1} T (@Inter.inter.{u_1} (Set.{u_1} T) (@Set.instInter.{u_1} T) T' U))
                                  (@instTopologicalSpaceSubtype.{u_1} T
                                    (fun x =>
                                      @Membership.mem.{u_1, u_1} T (Set.{u_1} T) (@Set.instMembership.{u_1} T)
                                        (@Inter.inter.{u_1} (Set.{u_1} T) (@Set.instInter.{u_1} T) T' U) x)
                                    (@UniformSpace.toTopologicalSpace.{u_1} T
                                      (@PseudoEMetricSpace.toUniformSpace.{u_1} T inst)))
                                  (@instWeakPseudoEMetricSpaceSubtype.{u_1} T
                                    (fun x =>
                                      @Membership.mem.{u_1, u_1} T (Set.{u_1} T) (@Set.instMembership.{u_1} T)
                                        (@Inter.inter.{u_1} (Set.{u_1} T) (@Set.instInter.{u_1} T) T' U) x)
                                    (@UniformSpace.toTopologicalSpace.{u_1} T
                                      (@PseudoEMetricSpace.toUniformSpace.{u_1} T inst))
                                    (@PseudoEMetricSpace.toWeakPseudoEMetricSpace.{u_1} T inst)))
                                s t)
                              (@HMul.hMul.{0, 0, 0} Real Real Real (@instHMul.{0} Real Real.instMul) (↑β) p)))
                    ω)
                  (@Inv.inv.{0} Real Real.instInv p)).toNNReal
              β
              (fun t =>
                X
                  (@Subtype.val.{u_1 + 1} T
                    (fun x => @Membership.mem.{u_1, u_1} T (Set.{u_1} T) (@Set.instMembership.{u_1} T) T' x) t)
                  ω)
              (@setOf.{u_1} (@Set.Elem.{u_1} T T') fun t' =>
                @Membership.mem.{u_1, u_1} T (Set.{u_1} T) (@Set.instMembership.{u_1} T) U
                  (@Subtype.val.{u_1 + 1} T
                    (fun x => @Membership.mem.{u_1, u_1} T (Set.{u_1} T) (@Set.instMembership.{u_1} T) T' x) t')) :=
⋯
```

## `ProbabilityTheory.holderSet`

Command: `#print ProbabilityTheory.holderSet`

```lean
def ProbabilityTheory.holderSet.{u_1, u_2, u_3} : {T : Type u_1} →
  {Ω : Type u_2} →
    {E : Type u_3} →
      [PseudoEMetricSpace.{u_1} T] →
        [PseudoEMetricSpace.{u_3} E] → (T → Ω → E) → Set.{u_1} T → Real → Real → Set.{u_1} T → Set.{u_2} Ω :=
fun {T} {Ω} {E} [inst : PseudoEMetricSpace.{u_1} T] [inst_1 : PseudoEMetricSpace.{u_3} E] X T' p β U =>
  @setOf.{u_2} Ω fun ω =>
    And
      (@LT.lt.{0} ENNReal (@Preorder.toLT.{0} ENNReal (@PartialOrder.toPreorder.{0} ENNReal ENNReal.instPartialOrder))
        (⨆ s,
          ⨆ t,
            @HDiv.hDiv.{0, 0, 0} ENNReal ENNReal ENNReal
              (@instHDiv.{0} ENNReal (@DivInvMonoid.toDiv.{0} ENNReal ENNReal.instDivInvMonoid))
              (@HPow.hPow.{0, 0, 0} ENNReal Real ENNReal (@instHPow.{0, 0} ENNReal Real ENNReal.instPowReal)
                (@EDist.edist.{u_3} E
                  (@WeakPseudoEMetricSpace.toEDist.{u_3} E
                    (@UniformSpace.toTopologicalSpace.{u_3} E (@PseudoEMetricSpace.toUniformSpace.{u_3} E inst_1))
                    (@PseudoEMetricSpace.toWeakPseudoEMetricSpace.{u_3} E inst_1))
                  (X
                    (@Subtype.val.{u_1 + 1} T
                      (fun x =>
                        @Membership.mem.{u_1, u_1} T (Set.{u_1} T) (@Set.instMembership.{u_1} T)
                          (@Inter.inter.{u_1} (Set.{u_1} T) (@Set.instInter.{u_1} T) T' U) x)
                      s)
                    ω)
                  (X
                    (@Subtype.val.{u_1 + 1} T
                      (fun x =>
                        @Membership.mem.{u_1, u_1} T (Set.{u_1} T) (@Set.instMembership.{u_1} T)
                          (@Inter.inter.{u_1} (Set.{u_1} T) (@Set.instInter.{u_1} T) T' U) x)
                      t)
                    ω))
                p)
              (@HPow.hPow.{0, 0, 0} ENNReal Real ENNReal (@instHPow.{0, 0} ENNReal Real ENNReal.instPowReal)
                (@EDist.edist.{u_1} (@Set.Elem.{u_1} T (@Inter.inter.{u_1} (Set.{u_1} T) (@Set.instInter.{u_1} T) T' U))
                  (@WeakPseudoEMetricSpace.toEDist.{u_1}
                    (@Set.Elem.{u_1} T (@Inter.inter.{u_1} (Set.{u_1} T) (@Set.instInter.{u_1} T) T' U))
                    (@instTopologicalSpaceSubtype.{u_1} T
                      (fun x =>
                        @Membership.mem.{u_1, u_1} T (Set.{u_1} T) (@Set.instMembership.{u_1} T)
                          (@Inter.inter.{u_1} (Set.{u_1} T) (@Set.instInter.{u_1} T) T' U) x)
                      (@UniformSpace.toTopologicalSpace.{u_1} T (@PseudoEMetricSpace.toUniformSpace.{u_1} T inst)))
                    (@instWeakPseudoEMetricSpaceSubtype.{u_1} T
                      (fun x =>
                        @Membership.mem.{u_1, u_1} T (Set.{u_1} T) (@Set.instMembership.{u_1} T)
                          (@Inter.inter.{u_1} (Set.{u_1} T) (@Set.instInter.{u_1} T) T' U) x)
                      (@UniformSpace.toTopologicalSpace.{u_1} T (@PseudoEMetricSpace.toUniformSpace.{u_1} T inst))
                      (@PseudoEMetricSpace.toWeakPseudoEMetricSpace.{u_1} T inst)))
                  s t)
                (@HMul.hMul.{0, 0, 0} Real Real Real (@instHMul.{0} Real Real.instMul) β p)))
        (@Top.top.{0} ENNReal ENNReal.instTop))
      (∀ (s t : @Set.Elem.{u_1} T (@Inter.inter.{u_1} (Set.{u_1} T) (@Set.instInter.{u_1} T) T' U)),
        @Eq.{1} ENNReal
            (@EDist.edist.{u_1} (@Set.Elem.{u_1} T (@Inter.inter.{u_1} (Set.{u_1} T) (@Set.instInter.{u_1} T) T' U))
              (@WeakPseudoEMetricSpace.toEDist.{u_1}
                (@Set.Elem.{u_1} T (@Inter.inter.{u_1} (Set.{u_1} T) (@Set.instInter.{u_1} T) T' U))
                (@instTopologicalSpaceSubtype.{u_1} T
                  (fun x =>
                    @Membership.mem.{u_1, u_1} T (Set.{u_1} T) (@Set.instMembership.{u_1} T)
                      (@Inter.inter.{u_1} (Set.{u_1} T) (@Set.instInter.{u_1} T) T' U) x)
                  (@UniformSpace.toTopologicalSpace.{u_1} T (@PseudoEMetricSpace.toUniformSpace.{u_1} T inst)))
                (@instWeakPseudoEMetricSpaceSubtype.{u_1} T
                  (fun x =>
                    @Membership.mem.{u_1, u_1} T (Set.{u_1} T) (@Set.instMembership.{u_1} T)
                      (@Inter.inter.{u_1} (Set.{u_1} T) (@Set.instInter.{u_1} T) T' U) x)
                  (@UniformSpace.toTopologicalSpace.{u_1} T (@PseudoEMetricSpace.toUniformSpace.{u_1} T inst))
                  (@PseudoEMetricSpace.toWeakPseudoEMetricSpace.{u_1} T inst)))
              s t)
            (@OfNat.ofNat.{0} ENNReal (nat_lit 0) (@Zero.toOfNat0.{0} ENNReal ENNReal.instZero)) →
          @Eq.{1} ENNReal
            (@EDist.edist.{u_3} E
              (@WeakPseudoEMetricSpace.toEDist.{u_3} E
                (@UniformSpace.toTopologicalSpace.{u_3} E (@PseudoEMetricSpace.toUniformSpace.{u_3} E inst_1))
                (@PseudoEMetricSpace.toWeakPseudoEMetricSpace.{u_3} E inst_1))
              (X
                (@Subtype.val.{u_1 + 1} T
                  (fun x =>
                    @Membership.mem.{u_1, u_1} T (Set.{u_1} T) (@Set.instMembership.{u_1} T)
                      (@Inter.inter.{u_1} (Set.{u_1} T) (@Set.instInter.{u_1} T) T' U) x)
                  s)
                ω)
              (X
                (@Subtype.val.{u_1 + 1} T
                  (fun x =>
                    @Membership.mem.{u_1, u_1} T (Set.{u_1} T) (@Set.instMembership.{u_1} T)
                      (@Inter.inter.{u_1} (Set.{u_1} T) (@Set.instInter.{u_1} T) T' U) x)
                  t)
                ω))
            (@OfNat.ofNat.{0} ENNReal (nat_lit 0) (@Zero.toOfNat0.{0} ENNReal ENNReal.instZero)))
```

## `ProbabilityTheory.indicatorProcess`

Command: `#print ProbabilityTheory.indicatorProcess`

```lean
def ProbabilityTheory.indicatorProcess.{u_1, u_2, u_3} : {T : Type u_1} →
  {Ω : Type u_2} → {E : Type u_3} → [hE : Nonempty.{u_3 + 1} E] → (T → Ω → E) → Set.{u_2} Ω → T → Ω → E :=
fun {T} {Ω} {E} [hE : Nonempty.{u_3 + 1} E] X A t ω =>
  @ite.{u_3 + 1} E (@Membership.mem.{u_2, u_2} Ω (Set.{u_2} Ω) (@Set.instMembership.{u_2} Ω) A ω)
    (@Classical.decPred.{u_2 + 1} Ω
      (fun x => @Membership.mem.{u_2, u_2} Ω (Set.{u_2} Ω) (@Set.instMembership.{u_2} Ω) A x) ω)
    (X t ω) (@Nonempty.some.{u_3 + 1} E hE)
```

## `ProbabilityTheory.indicatorProcess_apply`

Command: `#print ProbabilityTheory.indicatorProcess_apply`

```lean
theorem ProbabilityTheory.indicatorProcess_apply.{u_1, u_2, u_3} : ∀ {T : Type u_1} {Ω : Type u_2} {E : Type u_3}
  [hE : Nonempty.{u_3 + 1} E] (X : T → Ω → E) (A : Set.{u_2} Ω) (t : T) (ω : Ω)
  [inst : Decidable (@Membership.mem.{u_2, u_2} Ω (Set.{u_2} Ω) (@Set.instMembership.{u_2} Ω) A ω)],
  @Eq.{u_3 + 1} E (@ProbabilityTheory.indicatorProcess.{u_1, u_2, u_3} T Ω E hE X A t ω)
    (@ite.{u_3 + 1} E (@Membership.mem.{u_2, u_2} Ω (Set.{u_2} Ω) (@Set.instMembership.{u_2} Ω) A ω) inst (X t ω)
      (@Nonempty.some.{u_3 + 1} E hE)) :=
⋯
```

## `ProbabilityTheory.indistinguishable_of_edist_modification`

Command: `#print ProbabilityTheory.indistinguishable_of_edist_modification`

```lean
theorem ProbabilityTheory.indistinguishable_of_edist_modification.{u_4, u_5, u_6} : ∀ {T : Type u_4} {Ω : Type u_5}
  {E : Type u_6} {mΩ : MeasurableSpace.{u_5} Ω} [inst : PseudoEMetricSpace.{u_6} E] [inst_1 : TopologicalSpace.{u_4} T]
  [@TopologicalSpace.SeparableSpace.{u_4} T inst_1] {P : @MeasureTheory.Measure.{u_5} Ω mΩ} {X Y : T → Ω → E},
  @Filter.Eventually.{u_5} Ω
      (fun ω =>
        @Continuous.{u_4, u_6} T E inst_1
          (@UniformSpace.toTopologicalSpace.{u_6} E (@PseudoEMetricSpace.toUniformSpace.{u_6} E inst)) fun x => X x ω)
      (@MeasureTheory.ae.{u_5, u_5} Ω (@MeasureTheory.Measure.{u_5} Ω mΩ)
        (@MeasureTheory.Measure.instFunLike.{u_5} Ω mΩ) ⋯ P) →
    @Filter.Eventually.{u_5} Ω
        (fun ω =>
          @Continuous.{u_4, u_6} T E inst_1
            (@UniformSpace.toTopologicalSpace.{u_6} E (@PseudoEMetricSpace.toUniformSpace.{u_6} E inst)) fun x => Y x ω)
        (@MeasureTheory.ae.{u_5, u_5} Ω (@MeasureTheory.Measure.{u_5} Ω mΩ)
          (@MeasureTheory.Measure.instFunLike.{u_5} Ω mΩ) ⋯ P) →
      (∀ (t : T),
          @Filter.Eventually.{u_5} Ω
            (fun ω =>
              @Eq.{1} ENNReal
                (@EDist.edist.{u_6} E
                  (@WeakPseudoEMetricSpace.toEDist.{u_6} E
                    (@UniformSpace.toTopologicalSpace.{u_6} E (@PseudoEMetricSpace.toUniformSpace.{u_6} E inst))
                    (@PseudoEMetricSpace.toWeakPseudoEMetricSpace.{u_6} E inst))
                  (X t ω) (Y t ω))
                (@OfNat.ofNat.{0} ENNReal (nat_lit 0) (@Zero.toOfNat0.{0} ENNReal ENNReal.instZero)))
            (@MeasureTheory.ae.{u_5, u_5} Ω (@MeasureTheory.Measure.{u_5} Ω mΩ)
              (@MeasureTheory.Measure.instFunLike.{u_5} Ω mΩ) ⋯ P)) →
        @Filter.Eventually.{u_5} Ω
          (fun ω =>
            ∀ (t : T),
              @Eq.{1} ENNReal
                (@EDist.edist.{u_6} E
                  (@WeakPseudoEMetricSpace.toEDist.{u_6} E
                    (@UniformSpace.toTopologicalSpace.{u_6} E (@PseudoEMetricSpace.toUniformSpace.{u_6} E inst))
                    (@PseudoEMetricSpace.toWeakPseudoEMetricSpace.{u_6} E inst))
                  (X t ω) (Y t ω))
                (@OfNat.ofNat.{0} ENNReal (nat_lit 0) (@Zero.toOfNat0.{0} ENNReal ENNReal.instZero)))
          (@MeasureTheory.ae.{u_5, u_5} Ω (@MeasureTheory.Measure.{u_5} Ω mΩ)
            (@MeasureTheory.Measure.instFunLike.{u_5} Ω mΩ) ⋯ P) :=
⋯
```

## `ProbabilityTheory.indistinguishable_of_edist_modification_on`

Command: `#print ProbabilityTheory.indistinguishable_of_edist_modification_on`

```lean
theorem ProbabilityTheory.indistinguishable_of_edist_modification_on.{u_4, u_5, u_6} : ∀ {T : Type u_4} {Ω : Type u_5}
  {E : Type u_6} {mΩ : MeasurableSpace.{u_5} Ω} [inst : PseudoEMetricSpace.{u_6} E] [inst_1 : TopologicalSpace.{u_4} T]
  [@TopologicalSpace.SeparableSpace.{u_4} T inst_1] {P : @MeasureTheory.Measure.{u_5} Ω mΩ} {U : Set.{u_4} T},
  @IsOpen.{u_4} T inst_1 U →
    ∀ {X Y : T → Ω → E},
      @Filter.Eventually.{u_5} Ω
          (fun ω =>
            @ContinuousOn.{u_4, u_6} T E inst_1
              (@UniformSpace.toTopologicalSpace.{u_6} E (@PseudoEMetricSpace.toUniformSpace.{u_6} E inst))
              (fun x => X x ω) U)
          (@MeasureTheory.ae.{u_5, u_5} Ω (@MeasureTheory.Measure.{u_5} Ω mΩ)
            (@MeasureTheory.Measure.instFunLike.{u_5} Ω mΩ) ⋯ P) →
        @Filter.Eventually.{u_5} Ω
            (fun ω =>
              @ContinuousOn.{u_4, u_6} T E inst_1
                (@UniformSpace.toTopologicalSpace.{u_6} E (@PseudoEMetricSpace.toUniformSpace.{u_6} E inst))
                (fun x => Y x ω) U)
            (@MeasureTheory.ae.{u_5, u_5} Ω (@MeasureTheory.Measure.{u_5} Ω mΩ)
              (@MeasureTheory.Measure.instFunLike.{u_5} Ω mΩ) ⋯ P) →
          (∀ (t : T),
              @Membership.mem.{u_4, u_4} T (Set.{u_4} T) (@Set.instMembership.{u_4} T) U t →
                @Filter.Eventually.{u_5} Ω
                  (fun ω =>
                    @Eq.{1} ENNReal
                      (@EDist.edist.{u_6} E
                        (@WeakPseudoEMetricSpace.toEDist.{u_6} E
                          (@UniformSpace.toTopologicalSpace.{u_6} E (@PseudoEMetricSpace.toUniformSpace.{u_6} E inst))
                          (@PseudoEMetricSpace.toWeakPseudoEMetricSpace.{u_6} E inst))
                        (X t ω) (Y t ω))
                      (@OfNat.ofNat.{0} ENNReal (nat_lit 0) (@Zero.toOfNat0.{0} ENNReal ENNReal.instZero)))
                  (@MeasureTheory.ae.{u_5, u_5} Ω (@MeasureTheory.Measure.{u_5} Ω mΩ)
                    (@MeasureTheory.Measure.instFunLike.{u_5} Ω mΩ) ⋯ P)) →
            @Filter.Eventually.{u_5} Ω
              (fun ω =>
                ∀ (t : T),
                  @Membership.mem.{u_4, u_4} T (Set.{u_4} T) (@Set.instMembership.{u_4} T) U t →
                    @Eq.{1} ENNReal
                      (@EDist.edist.{u_6} E
                        (@WeakPseudoEMetricSpace.toEDist.{u_6} E
                          (@UniformSpace.toTopologicalSpace.{u_6} E (@PseudoEMetricSpace.toUniformSpace.{u_6} E inst))
                          (@PseudoEMetricSpace.toWeakPseudoEMetricSpace.{u_6} E inst))
                        (X t ω) (Y t ω))
                      (@OfNat.ofNat.{0} ENNReal (nat_lit 0) (@Zero.toOfNat0.{0} ENNReal ENNReal.instZero)))
              (@MeasureTheory.ae.{u_5, u_5} Ω (@MeasureTheory.Measure.{u_5} Ω mΩ)
                (@MeasureTheory.Measure.instFunLike.{u_5} Ω mΩ) ⋯ P) :=
⋯
```

## `ProbabilityTheory.isBrownianReal_brownian`

Command: `#print ProbabilityTheory.isBrownianReal_brownian`

```lean
theorem ProbabilityTheory.isBrownianReal_brownian : @ProbabilityTheory.IsBrownianReal.{0} (NNReal → Real)
  (@MeasurableSpace.pi.{0, 0} NNReal (fun a => Real) fun a => Real.measurableSpace) ProbabilityTheory.brownian
  ProbabilityTheory.gaussianLimit :=
⋯
```

## `ProbabilityTheory.isGaussian_gaussianProjectiveFamily`

Command: `#print ProbabilityTheory.isGaussian_gaussianProjectiveFamily`

```lean
theorem ProbabilityTheory.isGaussian_gaussianProjectiveFamily : ∀ (I : Finset.{0} NNReal),
  @ProbabilityTheory.IsGaussian.{0} (↥I → Real)
    (@Pi.topologicalSpace.{0, 0} (↥I) (fun a => Real) fun i =>
      @UniformSpace.toTopologicalSpace.{0} Real (@PseudoMetricSpace.toUniformSpace.{0} Real Real.pseudoMetricSpace))
    (@Pi.addCommMonoid.{0, 0} (↥I) (fun a => Real) fun i => Real.instAddCommMonoid)
    (@Pi.Function.module.{0, 0, 0} (↥I) Real Real Real.semiring Real.instAddCommMonoid
      (@Semiring.toModule.{0} Real Real.semiring))
    (@MeasurableSpace.pi.{0, 0} (↥I) (fun a => Real) fun a => Real.measurableSpace)
    (ProbabilityTheory.gaussianProjectiveFamily I) :=
⋯
```

## `ProbabilityTheory.isLimitOfIndicator_holderModification`

Command: `#print ProbabilityTheory.isLimitOfIndicator_holderModification`

```lean
theorem ProbabilityTheory.isLimitOfIndicator_holderModification.{u_1, u_2, u_3} : ∀ {T : Type u_1} {Ω : Type u_2}
  {E : Type u_3} {mΩ : MeasurableSpace.{u_2} Ω} {X : T → Ω → E} {c : ENNReal} {d p q : Real} {M β : NNReal}
  {P : @MeasureTheory.Measure.{u_2} Ω mΩ} {U : Set.{u_1} T} [inst : PseudoEMetricSpace.{u_1} T]
  [inst_1 : PseudoEMetricSpace.{u_3} E] [inst_2 : MeasurableSpace.{u_3} E]
  [@BorelSpace.{u_3} E (@UniformSpace.toTopologicalSpace.{u_3} E (@PseudoEMetricSpace.toUniformSpace.{u_3} E inst_1))
      inst_2]
  [@CompleteSpace.{u_3} E (@PseudoEMetricSpace.toUniformSpace.{u_3} E inst_1)] [hE : Nonempty.{u_3 + 1} E]
  [inst_5 :
    @SecondCountableTopology.{u_1} T
      (@UniformSpace.toTopologicalSpace.{u_1} T (@PseudoEMetricSpace.toUniformSpace.{u_1} T inst))],
  @HasBoundedCoveringNumber.{u_1} T inst U c d →
    ∀
      [inst_6 :
        @DecidablePred.{u_1 + 1} T fun x =>
          @Membership.mem.{u_1, u_1} T (Set.{u_1} T) (@Set.instMembership.{u_1} T) U x],
      @IsOpen.{u_1} T (@UniformSpace.toTopologicalSpace.{u_1} T (@PseudoEMetricSpace.toUniformSpace.{u_1} T inst)) U →
        @ProbabilityTheory.IsKolmogorovProcess.{u_1, u_2, u_3} T Ω E inst mΩ inst_1 X P p q M →
          @Ne.{1} ENNReal c (@Top.top.{0} ENNReal ENNReal.instTop) →
            @LT.lt.{0} Real Real.instLT (@OfNat.ofNat.{0} Real (nat_lit 0) (@Zero.toOfNat0.{0} Real Real.instZero)) d →
              @LT.lt.{0} Real Real.instLT d q →
                @LT.lt.{0} NNReal
                    (@Preorder.toLT.{0} NNReal (@PartialOrder.toPreorder.{0} NNReal NNReal.instPartialOrder))
                    (@OfNat.ofNat.{0} NNReal (nat_lit 0) (@Zero.toOfNat0.{0} NNReal NNReal.instZero)) β →
                  @LT.lt.{0} Real Real.instLT (↑β)
                      (@HDiv.hDiv.{0, 0, 0} Real Real Real
                        (@instHDiv.{0} Real (@DivInvMonoid.toDiv.{0} Real Real.instDivInvMonoid))
                        (@HSub.hSub.{0, 0, 0} Real Real Real (@instHSub.{0} Real Real.instSub) q d) p) →
                    @ProbabilityTheory.IsLimitOfIndicator.{u_1, u_2, u_3} T Ω E mΩ inst_1 hE
                      (@UniformSpace.toTopologicalSpace.{u_1} T (@PseudoEMetricSpace.toUniformSpace.{u_1} T inst))
                      inst_5
                      (@ProbabilityTheory.holderModification.{u_1, u_2, u_3} T Ω E inst inst_1 hE inst_5 X β p U inst_6)
                      X P U :=
⋯
```

## `ProbabilityTheory.isPreBrownianReal_preBrownian`

Command: `#print ProbabilityTheory.isPreBrownianReal_preBrownian`

```lean
theorem ProbabilityTheory.isPreBrownianReal_preBrownian : @ProbabilityTheory.IsPreBrownianReal.{0} (NNReal → Real)
  (@MeasurableSpace.pi.{0, 0} NNReal (fun a => Real) fun a => Real.measurableSpace) ProbabilityTheory.preBrownian
  ProbabilityTheory.gaussianLimit :=
⋯
```

## `ProbabilityTheory.isProjectiveLimit_gaussianLimit`

Command: `#print ProbabilityTheory.isProjectiveLimit_gaussianLimit`

```lean
theorem ProbabilityTheory.isProjectiveLimit_gaussianLimit : @MeasureTheory.IsProjectiveLimit.{0, 0} NNReal
  (fun i => Real) (fun a => Real.measurableSpace) ProbabilityTheory.gaussianLimit
  ProbabilityTheory.gaussianProjectiveFamily :=
⋯
```

## `ProbabilityTheory.isProjectiveMeasureFamily_gaussianProjectiveFamily`

Command: `#print ProbabilityTheory.isProjectiveMeasureFamily_gaussianProjectiveFamily`

```lean
theorem ProbabilityTheory.isProjectiveMeasureFamily_gaussianProjectiveFamily : @MeasureTheory.IsProjectiveMeasureFamily.{0,
      0}
  NNReal (fun x => Real) (fun i => Real.measurableSpace) ProbabilityTheory.gaussianProjectiveFamily :=
⋯
```

## `ProbabilityTheory.lintegral_div_edist_le_sum_integral_edist_le`

Command: `#print ProbabilityTheory.lintegral_div_edist_le_sum_integral_edist_le`

```lean
theorem ProbabilityTheory.lintegral_div_edist_le_sum_integral_edist_le.{u_1, u_2, u_3} : ∀ {T : Type u_1} {Ω : Type u_2}
  {E : Type u_3} {mΩ : MeasurableSpace.{u_2} Ω} {X : T → Ω → E} {p q : Real} {M β : NNReal}
  {P : @MeasureTheory.Measure.{u_2} Ω mΩ} {U : Set.{u_1} T} [inst : PseudoEMetricSpace.{u_1} T]
  [inst_1 : PseudoEMetricSpace.{u_3} E] [inst_2 : MeasurableSpace.{u_3} E]
  [@BorelSpace.{u_3} E (@UniformSpace.toTopologicalSpace.{u_3} E (@PseudoEMetricSpace.toUniformSpace.{u_3} E inst_1))
      inst_2],
  @LT.lt.{0} ENNReal (@Preorder.toLT.{0} ENNReal (@PartialOrder.toPreorder.{0} ENNReal ENNReal.instPartialOrder))
      (@Metric.ediam.{u_1} T inst U) (@Top.top.{0} ENNReal ENNReal.instTop) →
    @ProbabilityTheory.IsAEKolmogorovProcess.{u_1, u_2, u_3} T Ω E inst mΩ inst_1 X P p q M →
      @LT.lt.{0} NNReal (@Preorder.toLT.{0} NNReal (@PartialOrder.toPreorder.{0} NNReal NNReal.instPartialOrder))
          (@OfNat.ofNat.{0} NNReal (nat_lit 0) (@Zero.toOfNat0.{0} NNReal NNReal.instZero)) β →
        ∀ {J : Set.{u_1} T} [Countable.{u_1 + 1} (@Set.Elem.{u_1} T J)],
          @LE.le.{u_1} (Set.{u_1} T) (@Set.instLE.{u_1} T) J U →
            @LE.le.{0} ENNReal ENNReal.instLE
              (@MeasureTheory.lintegral.{u_2} Ω mΩ P fun ω =>
                ⨆ s,
                  ⨆ t,
                    @HDiv.hDiv.{0, 0, 0} ENNReal ENNReal ENNReal
                      (@instHDiv.{0} ENNReal (@DivInvMonoid.toDiv.{0} ENNReal ENNReal.instDivInvMonoid))
                      (@HPow.hPow.{0, 0, 0} ENNReal Real ENNReal (@instHPow.{0, 0} ENNReal Real ENNReal.instPowReal)
                        (@EDist.edist.{u_3} E
                          (@WeakPseudoEMetricSpace.toEDist.{u_3} E
                            (@UniformSpace.toTopologicalSpace.{u_3} E
                              (@PseudoEMetricSpace.toUniformSpace.{u_3} E inst_1))
                            (@PseudoEMetricSpace.toWeakPseudoEMetricSpace.{u_3} E inst_1))
                          (X
                            (@Subtype.val.{u_1 + 1} T
                              (fun x => @Membership.mem.{u_1, u_1} T (Set.{u_1} T) (@Set.instMembership.{u_1} T) J x) s)
                            ω)
                          (X
                            (@Subtype.val.{u_1 + 1} T
                              (fun x => @Membership.mem.{u_1, u_1} T (Set.{u_1} T) (@Set.instMembership.{u_1} T) J x) t)
                            ω))
                        p)
                      (@HPow.hPow.{0, 0, 0} ENNReal Real ENNReal (@instHPow.{0, 0} ENNReal Real ENNReal.instPowReal)
                        (@EDist.edist.{u_1} (@Set.Elem.{u_1} T J)
                          (@WeakPseudoEMetricSpace.toEDist.{u_1} (@Set.Elem.{u_1} T J)
                            (@instTopologicalSpaceSubtype.{u_1} T
                              (fun x => @Membership.mem.{u_1, u_1} T (Set.{u_1} T) (@Set.instMembership.{u_1} T) J x)
                              (@UniformSpace.toTopologicalSpace.{u_1} T
                                (@PseudoEMetricSpace.toUniformSpace.{u_1} T inst)))
                            (@instWeakPseudoEMetricSpaceSubtype.{u_1} T
                              (fun x => @Membership.mem.{u_1, u_1} T (Set.{u_1} T) (@Set.instMembership.{u_1} T) J x)
                              (@UniformSpace.toTopologicalSpace.{u_1} T
                                (@PseudoEMetricSpace.toUniformSpace.{u_1} T inst))
                              (@PseudoEMetricSpace.toWeakPseudoEMetricSpace.{u_1} T inst)))
                          s t)
                        (@HMul.hMul.{0, 0, 0} Real Real Real (@instHMul.{0} Real Real.instMul) (↑β) p)))
              (@tsum.{0, 0} ENNReal Nat ENNReal.instAddCommMonoid ENNReal.instTopologicalSpace
                (fun k =>
                  @HMul.hMul.{0, 0, 0} ENNReal ENNReal ENNReal
                    (@instHMul.{0} ENNReal
                      (@Distrib.toMul.{0} ENNReal
                        (@instDistribOfSemiring.{0} ENNReal
                          (@CommSemiring.toSemiring.{0} ENNReal ENNReal.instCommSemiring))))
                    (@HPow.hPow.{0, 0, 0} ENNReal Real ENNReal (@instHPow.{0, 0} ENNReal Real ENNReal.instPowReal)
                      (@OfNat.ofNat.{0} ENNReal (nat_lit 2)
                        (@instOfNatAtLeastTwo.{0} ENNReal (nat_lit 2)
                          (@AddMonoidWithOne.toNatCast.{0} ENNReal
                            (@AddCommMonoidWithOne.toAddMonoidWithOne.{0} ENNReal ENNReal.instAddCommMonoidWithOne))
                          ⋯))
                      (@HMul.hMul.{0, 0, 0} Real Real Real (@instHMul.{0} Real Real.instMul)
                        (@HMul.hMul.{0, 0, 0} Real Real Real (@instHMul.{0} Real Real.instMul)
                          (@Nat.cast.{0} Real Real.instNatCast k) ↑β)
                        p))
                    (@MeasureTheory.lintegral.{u_2} Ω mΩ P fun ω =>
                      ⨆ s,
                        ⨆ t,
                          @HPow.hPow.{0, 0, 0} ENNReal Real ENNReal (@instHPow.{0, 0} ENNReal Real ENNReal.instPowReal)
                            (@EDist.edist.{u_3} E
                              (@WeakPseudoEMetricSpace.toEDist.{u_3} E
                                (@UniformSpace.toTopologicalSpace.{u_3} E
                                  (@PseudoEMetricSpace.toUniformSpace.{u_3} E inst_1))
                                (@PseudoEMetricSpace.toWeakPseudoEMetricSpace.{u_3} E inst_1))
                              (X
                                (@Subtype.val.{u_1 + 1} T
                                  (fun x =>
                                    @Membership.mem.{u_1, u_1} T (Set.{u_1} T) (@Set.instMembership.{u_1} T) J x)
                                  s)
                                ω)
                              (X
                                (@Subtype.val.{u_1 + 1} T
                                  (fun x =>
                                    @Membership.mem.{u_1, u_1} T (Set.{u_1} T) (@Set.instMembership.{u_1} T) J x)
                                  (@Subtype.val.{u_1 + 1} (@Set.Elem.{u_1} T J)
                                    (fun t =>
                                      @LE.le.{0} ENNReal ENNReal.instLE
                                        (@EDist.edist.{u_1} (@Set.Elem.{u_1} T J)
                                          (@WeakPseudoEMetricSpace.toEDist.{u_1} (@Set.Elem.{u_1} T J)
                                            (@instTopologicalSpaceSubtype.{u_1} T
                                              (fun x =>
                                                @Membership.mem.{u_1, u_1} T (Set.{u_1} T) (@Set.instMembership.{u_1} T)
                                                  J x)
                                              (@UniformSpace.toTopologicalSpace.{u_1} T
                                                (@PseudoEMetricSpace.toUniformSpace.{u_1} T inst)))
                                            (@instWeakPseudoEMetricSpaceSubtype.{u_1} T
                                              (fun x =>
                                                @Membership.mem.{u_1, u_1} T (Set.{u_1} T) (@Set.instMembership.{u_1} T)
                                                  J x)
                                              (@UniformSpace.toTopologicalSpace.{u_1} T
                                                (@PseudoEMetricSpace.toUniformSpace.{u_1} T inst))
                                              (@PseudoEMetricSpace.toWeakPseudoEMetricSpace.{u_1} T inst)))
                                          s t)
                                        (@HMul.hMul.{0, 0, 0} ENNReal ENNReal ENNReal
                                          (@instHMul.{0} ENNReal
                                            (@Distrib.toMul.{0} ENNReal
                                              (@instDistribOfSemiring.{0} ENNReal
                                                (@CommSemiring.toSemiring.{0} ENNReal ENNReal.instCommSemiring))))
                                          (@HMul.hMul.{0, 0, 0} ENNReal ENNReal ENNReal
                                            (@instHMul.{0} ENNReal
                                              (@Distrib.toMul.{0} ENNReal
                                                (@instDistribOfSemiring.{0} ENNReal
                                                  (@CommSemiring.toSemiring.{0} ENNReal ENNReal.instCommSemiring))))
                                            (@OfNat.ofNat.{0} ENNReal (nat_lit 2)
                                              (@instOfNatAtLeastTwo.{0} ENNReal (nat_lit 2)
                                                (@AddMonoidWithOne.toNatCast.{0} ENNReal
                                                  (@AddCommMonoidWithOne.toAddMonoidWithOne.{0} ENNReal
                                                    ENNReal.instAddCommMonoidWithOne))
                                                ⋯))
                                            (@HPow.hPow.{0, 0, 0} ENNReal Nat ENNReal
                                              (@instHPow.{0, 0} ENNReal Nat
                                                (@NPow.toPow.{0} ENNReal
                                                  (@Monoid.toNPow.{0} ENNReal
                                                    (@Semiring.toMonoid.{0} ENNReal
                                                      (@CommSemiring.toSemiring.{0} ENNReal
                                                        ENNReal.instCommSemiring)))))
                                              (@Inv.inv.{0} ENNReal ENNReal.instInv
                                                (@OfNat.ofNat.{0} ENNReal (nat_lit 2)
                                                  (@instOfNatAtLeastTwo.{0} ENNReal (nat_lit 2)
                                                    (@AddMonoidWithOne.toNatCast.{0} ENNReal
                                                      (@AddCommMonoidWithOne.toAddMonoidWithOne.{0} ENNReal
                                                        ENNReal.instAddCommMonoidWithOne))
                                                    ⋯)))
                                              k))
                                          (@HAdd.hAdd.{0, 0, 0} ENNReal ENNReal ENNReal
                                            (@instHAdd.{0} ENNReal ENNReal.instAdd) (@Metric.ediam.{u_1} T inst U)
                                            (@OfNat.ofNat.{0} ENNReal (nat_lit 1)
                                              (@One.toOfNat1.{0} ENNReal ENNReal.instOne)))))
                                    t))
                                ω))
                            p))
                (SummationFilter.unconditional.{0} Nat)) :=
⋯
```

## `ProbabilityTheory.lintegral_sup_cover_eq_of_lt_iInf_dist`

Command: `#print ProbabilityTheory.lintegral_sup_cover_eq_of_lt_iInf_dist`

```lean
theorem ProbabilityTheory.lintegral_sup_cover_eq_of_lt_iInf_dist.{u_1, u_2, u_3} : ∀ {T : Type u_1} {Ω : Type u_2}
  {E : Type u_3} [inst : PseudoEMetricSpace.{u_1} T] {mΩ : MeasurableSpace.{u_2} Ω}
  [inst_1 : PseudoEMetricSpace.{u_3} E] {P : @MeasureTheory.Measure.{u_2} Ω mΩ} {X : T → Ω → E} {M : NNReal}
  {p q : Real} {J : Set.{u_1} T} {δ : NNReal} {C : Set.{u_1} T} {ε : NNReal},
  @ProbabilityTheory.IsAEKolmogorovProcess.{u_1, u_2, u_3} T Ω E inst mΩ inst_1 X P p q M →
    @Set.Finite.{u_1} T J →
      @Metric.IsCover.{u_1} T inst ε J C →
        @LE.le.{u_1} (Set.{u_1} T) (@Set.instLE.{u_1} T) C J →
          @LT.lt.{0} ENNReal
              (@Preorder.toLT.{0} ENNReal (@PartialOrder.toPreorder.{0} ENNReal ENNReal.instPartialOrder)) (↑ε)
              (⨅ s,
                ⨅ t,
                  ⨅ (_ :
                    @LT.lt.{0} ENNReal
                      (@Preorder.toLT.{0} ENNReal (@PartialOrder.toPreorder.{0} ENNReal ENNReal.instPartialOrder))
                      (@OfNat.ofNat.{0} ENNReal (nat_lit 0) (@Zero.toOfNat0.{0} ENNReal ENNReal.instZero))
                      (@EDist.edist.{u_1} (@Set.Elem.{u_1} T J)
                        (@WeakPseudoEMetricSpace.toEDist.{u_1} (@Set.Elem.{u_1} T J)
                          (@instTopologicalSpaceSubtype.{u_1} T
                            (fun x => @Membership.mem.{u_1, u_1} T (Set.{u_1} T) (@Set.instMembership.{u_1} T) J x)
                            (@UniformSpace.toTopologicalSpace.{u_1} T
                              (@PseudoEMetricSpace.toUniformSpace.{u_1} T inst)))
                          (@instWeakPseudoEMetricSpaceSubtype.{u_1} T
                            (fun x => @Membership.mem.{u_1, u_1} T (Set.{u_1} T) (@Set.instMembership.{u_1} T) J x)
                            (@UniformSpace.toTopologicalSpace.{u_1} T (@PseudoEMetricSpace.toUniformSpace.{u_1} T inst))
                            (@PseudoEMetricSpace.toWeakPseudoEMetricSpace.{u_1} T inst)))
                        s t)),
                    @EDist.edist.{u_1} (@Set.Elem.{u_1} T J)
                      (@WeakPseudoEMetricSpace.toEDist.{u_1} (@Set.Elem.{u_1} T J)
                        (@instTopologicalSpaceSubtype.{u_1} T
                          (fun x => @Membership.mem.{u_1, u_1} T (Set.{u_1} T) (@Set.instMembership.{u_1} T) J x)
                          (@UniformSpace.toTopologicalSpace.{u_1} T (@PseudoEMetricSpace.toUniformSpace.{u_1} T inst)))
                        (@instWeakPseudoEMetricSpaceSubtype.{u_1} T
                          (fun x => @Membership.mem.{u_1, u_1} T (Set.{u_1} T) (@Set.instMembership.{u_1} T) J x)
                          (@UniformSpace.toTopologicalSpace.{u_1} T (@PseudoEMetricSpace.toUniformSpace.{u_1} T inst))
                          (@PseudoEMetricSpace.toWeakPseudoEMetricSpace.{u_1} T inst)))
                      s t) →
            @Eq.{1} ENNReal
              (@MeasureTheory.lintegral.{u_2} Ω mΩ P fun ω =>
                ⨆ s,
                  ⨆ t,
                    @HPow.hPow.{0, 0, 0} ENNReal Real ENNReal (@instHPow.{0, 0} ENNReal Real ENNReal.instPowReal)
                      (@EDist.edist.{u_3} E
                        (@WeakPseudoEMetricSpace.toEDist.{u_3} E
                          (@UniformSpace.toTopologicalSpace.{u_3} E (@PseudoEMetricSpace.toUniformSpace.{u_3} E inst_1))
                          (@PseudoEMetricSpace.toWeakPseudoEMetricSpace.{u_3} E inst_1))
                        (X
                          (@Subtype.val.{u_1 + 1} T
                            (fun x => @Membership.mem.{u_1, u_1} T (Set.{u_1} T) (@Set.instMembership.{u_1} T) C x) s)
                          ω)
                        (X
                          (@Subtype.val.{u_1 + 1} T
                            (fun x => @Membership.mem.{u_1, u_1} T (Set.{u_1} T) (@Set.instMembership.{u_1} T) C x)
                            (@Subtype.val.{u_1 + 1} (@Set.Elem.{u_1} T C)
                              (fun t =>
                                @LE.le.{0} ENNReal ENNReal.instLE
                                  (@EDist.edist.{u_1} (@Set.Elem.{u_1} T C)
                                    (@WeakPseudoEMetricSpace.toEDist.{u_1} (@Set.Elem.{u_1} T C)
                                      (@instTopologicalSpaceSubtype.{u_1} T
                                        (fun x =>
                                          @Membership.mem.{u_1, u_1} T (Set.{u_1} T) (@Set.instMembership.{u_1} T) C x)
                                        (@UniformSpace.toTopologicalSpace.{u_1} T
                                          (@PseudoEMetricSpace.toUniformSpace.{u_1} T inst)))
                                      (@instWeakPseudoEMetricSpaceSubtype.{u_1} T
                                        (fun x =>
                                          @Membership.mem.{u_1, u_1} T (Set.{u_1} T) (@Set.instMembership.{u_1} T) C x)
                                        (@UniformSpace.toTopologicalSpace.{u_1} T
                                          (@PseudoEMetricSpace.toUniformSpace.{u_1} T inst))
                                        (@PseudoEMetricSpace.toWeakPseudoEMetricSpace.{u_1} T inst)))
                                    s t)
                                  ↑δ)
                              t))
                          ω))
                      p)
              (@MeasureTheory.lintegral.{u_2} Ω mΩ P fun ω =>
                ⨆ s,
                  ⨆ t,
                    @HPow.hPow.{0, 0, 0} ENNReal Real ENNReal (@instHPow.{0, 0} ENNReal Real ENNReal.instPowReal)
                      (@EDist.edist.{u_3} E
                        (@WeakPseudoEMetricSpace.toEDist.{u_3} E
                          (@UniformSpace.toTopologicalSpace.{u_3} E (@PseudoEMetricSpace.toUniformSpace.{u_3} E inst_1))
                          (@PseudoEMetricSpace.toWeakPseudoEMetricSpace.{u_3} E inst_1))
                        (X
                          (@Subtype.val.{u_1 + 1} T
                            (fun x => @Membership.mem.{u_1, u_1} T (Set.{u_1} T) (@Set.instMembership.{u_1} T) J x) s)
                          ω)
                        (X
                          (@Subtype.val.{u_1 + 1} T
                            (fun x => @Membership.mem.{u_1, u_1} T (Set.{u_1} T) (@Set.instMembership.{u_1} T) J x)
                            (@Subtype.val.{u_1 + 1} (@Set.Elem.{u_1} T J)
                              (fun t =>
                                @LE.le.{0} ENNReal ENNReal.instLE
                                  (@EDist.edist.{u_1} (@Set.Elem.{u_1} T J)
                                    (@WeakPseudoEMetricSpace.toEDist.{u_1} (@Set.Elem.{u_1} T J)
                                      (@instTopologicalSpaceSubtype.{u_1} T
                                        (fun x =>
                                          @Membership.mem.{u_1, u_1} T (Set.{u_1} T) (@Set.instMembership.{u_1} T) J x)
                                        (@UniformSpace.toTopologicalSpace.{u_1} T
                                          (@PseudoEMetricSpace.toUniformSpace.{u_1} T inst)))
                                      (@instWeakPseudoEMetricSpaceSubtype.{u_1} T
                                        (fun x =>
                                          @Membership.mem.{u_1, u_1} T (Set.{u_1} T) (@Set.instMembership.{u_1} T) J x)
                                        (@UniformSpace.toTopologicalSpace.{u_1} T
                                          (@PseudoEMetricSpace.toUniformSpace.{u_1} T inst))
                                        (@PseudoEMetricSpace.toWeakPseudoEMetricSpace.{u_1} T inst)))
                                    s t)
                                  ↑δ)
                              t))
                          ω))
                      p) :=
⋯
```

## `ProbabilityTheory.lintegral_sup_rpow_edist_cover_of_dist_le`

Command: `#print ProbabilityTheory.lintegral_sup_rpow_edist_cover_of_dist_le`

```lean
theorem ProbabilityTheory.lintegral_sup_rpow_edist_cover_of_dist_le.{u_1, u_2, u_3} : ∀ {T : Type u_1} {Ω : Type u_2}
  {E : Type u_3} [inst : PseudoEMetricSpace.{u_1} T] {mΩ : MeasurableSpace.{u_2} Ω}
  [inst_1 : PseudoEMetricSpace.{u_3} E] {p q : Real} {M : NNReal} {P : @MeasureTheory.Measure.{u_2} Ω mΩ}
  {X : T → Ω → E} {J : Set.{u_1} T},
  @ProbabilityTheory.IsAEKolmogorovProcess.{u_1, u_2, u_3} T Ω E inst mΩ inst_1 X P p q M →
    ∀ {C : Finset.{u_1} T} {ε : NNReal},
      @Eq.{1} ENat (@Nat.cast.{0} ENat ENat.instNatCast (@Finset.card.{u_1} T C))
          (@Metric.coveringNumber.{u_1} T inst ε J) →
        ∀ {c : ENNReal},
          @LE.le.{0} ENNReal ENNReal.instLE
            (@MeasureTheory.lintegral.{u_2} Ω mΩ P fun ω =>
              ⨆ s,
                ⨆ t,
                  @HPow.hPow.{0, 0, 0} ENNReal Real ENNReal (@instHPow.{0, 0} ENNReal Real ENNReal.instPowReal)
                    (@EDist.edist.{u_3} E
                      (@WeakPseudoEMetricSpace.toEDist.{u_3} E
                        (@UniformSpace.toTopologicalSpace.{u_3} E (@PseudoEMetricSpace.toUniformSpace.{u_3} E inst_1))
                        (@PseudoEMetricSpace.toWeakPseudoEMetricSpace.{u_3} E inst_1))
                      (X
                        (@Subtype.val.{u_1 + 1} T
                          (fun x =>
                            @Membership.mem.{u_1, u_1} T (Finset.{u_1} T)
                              (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} T) T (@Finset.instSetLike.{u_1} T)) C x)
                          s)
                        ω)
                      (X
                        (@Subtype.val.{u_1 + 1} T
                          (fun x =>
                            @Membership.mem.{u_1, u_1} T (Finset.{u_1} T)
                              (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} T) T (@Finset.instSetLike.{u_1} T)) C x)
                          (@Subtype.val.{u_1 + 1} (↥C)
                            (fun t =>
                              @LE.le.{0} ENNReal ENNReal.instLE
                                (@EDist.edist.{u_1} (↥C)
                                  (@WeakPseudoEMetricSpace.toEDist.{u_1} (↥C)
                                    (@instTopologicalSpaceSubtype.{u_1} T
                                      (fun x =>
                                        @Membership.mem.{u_1, u_1} T (Finset.{u_1} T)
                                          (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} T) T
                                            (@Finset.instSetLike.{u_1} T))
                                          C x)
                                      (@UniformSpace.toTopologicalSpace.{u_1} T
                                        (@PseudoEMetricSpace.toUniformSpace.{u_1} T inst)))
                                    (@instWeakPseudoEMetricSpaceSubtype.{u_1} T
                                      (fun x =>
                                        @Membership.mem.{u_1, u_1} T (Finset.{u_1} T)
                                          (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} T) T
                                            (@Finset.instSetLike.{u_1} T))
                                          C x)
                                      (@UniformSpace.toTopologicalSpace.{u_1} T
                                        (@PseudoEMetricSpace.toUniformSpace.{u_1} T inst))
                                      (@PseudoEMetricSpace.toWeakPseudoEMetricSpace.{u_1} T inst)))
                                  s t)
                                c)
                            t))
                        ω))
                    p)
            (@HMul.hMul.{0, 0, 0} ENNReal ENNReal ENNReal
              (@instHMul.{0} ENNReal
                (@Distrib.toMul.{0} ENNReal
                  (@instDistribOfSemiring.{0} ENNReal (@CommSemiring.toSemiring.{0} ENNReal ENNReal.instCommSemiring))))
              (@HMul.hMul.{0, 0, 0} ENNReal ENNReal ENNReal
                (@instHMul.{0} ENNReal
                  (@Distrib.toMul.{0} ENNReal
                    (@instDistribOfSemiring.{0} ENNReal
                      (@CommSemiring.toSemiring.{0} ENNReal ENNReal.instCommSemiring))))
                (@HMul.hMul.{0, 0, 0} ENNReal ENNReal ENNReal
                  (@instHMul.{0} ENNReal
                    (@Distrib.toMul.{0} ENNReal
                      (@instDistribOfSemiring.{0} ENNReal
                        (@CommSemiring.toSemiring.{0} ENNReal ENNReal.instCommSemiring))))
                  (@HPow.hPow.{0, 0, 0} ENNReal Real ENNReal (@instHPow.{0, 0} ENNReal Real ENNReal.instPowReal)
                    (@OfNat.ofNat.{0} ENNReal (nat_lit 2)
                      (@instOfNatAtLeastTwo.{0} ENNReal (nat_lit 2)
                        (@AddMonoidWithOne.toNatCast.{0} ENNReal
                          (@AddCommMonoidWithOne.toAddMonoidWithOne.{0} ENNReal ENNReal.instAddCommMonoidWithOne))
                        ⋯))
                    (@HAdd.hAdd.{0, 0, 0} Real Real Real (@instHAdd.{0} Real Real.instAdd) p
                      (@OfNat.ofNat.{0} Real (nat_lit 1) (@One.toOfNat1.{0} Real Real.instOne))))
                  ↑M)
                (@HPow.hPow.{0, 0, 0} ENNReal Real ENNReal (@instHPow.{0, 0} ENNReal Real ENNReal.instPowReal)
                  (@HMul.hMul.{0, 0, 0} ENNReal ENNReal ENNReal
                    (@instHMul.{0} ENNReal
                      (@Distrib.toMul.{0} ENNReal
                        (@instDistribOfSemiring.{0} ENNReal
                          (@CommSemiring.toSemiring.{0} ENNReal ENNReal.instCommSemiring))))
                    (@HMul.hMul.{0, 0, 0} ENNReal ENNReal ENNReal
                      (@instHMul.{0} ENNReal
                        (@Distrib.toMul.{0} ENNReal
                          (@instDistribOfSemiring.{0} ENNReal
                            (@CommSemiring.toSemiring.{0} ENNReal ENNReal.instCommSemiring))))
                      (@OfNat.ofNat.{0} ENNReal (nat_lit 2)
                        (@instOfNatAtLeastTwo.{0} ENNReal (nat_lit 2)
                          (@AddMonoidWithOne.toNatCast.{0} ENNReal
                            (@AddCommMonoidWithOne.toAddMonoidWithOne.{0} ENNReal ENNReal.instAddCommMonoidWithOne))
                          ⋯))
                      c)
                    (@Nat.cast.{0} ENNReal
                      (@AddMonoidWithOne.toNatCast.{0} ENNReal
                        (@AddCommMonoidWithOne.toAddMonoidWithOne.{0} ENNReal ENNReal.instAddCommMonoidWithOne))
                      (@Metric.coveringNumber.{u_1} T inst ε J).toNat.log2))
                  q))
              ↑(@Metric.coveringNumber.{u_1} T inst ε J)) :=
⋯
```

## `ProbabilityTheory.lintegral_sup_rpow_edist_cover_rescale`

Command: `#print ProbabilityTheory.lintegral_sup_rpow_edist_cover_rescale`

```lean
theorem ProbabilityTheory.lintegral_sup_rpow_edist_cover_rescale.{u_1, u_2, u_3} : ∀ {T : Type u_1} {Ω : Type u_2}
  {E : Type u_3} [inst : PseudoEMetricSpace.{u_1} T] {mΩ : MeasurableSpace.{u_2} Ω}
  [inst_1 : PseudoEMetricSpace.{u_3} E] {p q : Real} {M : NNReal} {P : @MeasureTheory.Measure.{u_2} Ω mΩ}
  {X : T → Ω → E} {J : Set.{u_1} T},
  @ProbabilityTheory.IsAEKolmogorovProcess.{u_1, u_2, u_3} T Ω E inst mΩ inst_1 X P p q M →
    @Set.Finite.{u_1} T J →
      ∀ {C : Nat → Finset.{u_1} T} {ε₀ : NNReal},
        (∀ (i : Nat),
            @Metric.IsCover.{u_1} T inst
              (@HMul.hMul.{0, 0, 0} NNReal NNReal NNReal
                (@instHMul.{0} NNReal
                  (@Distrib.toMul.{0} NNReal (@instDistribOfSemiring.{0} NNReal NNReal.instSemiring)))
                ε₀
                (@HPow.hPow.{0, 0, 0} NNReal Nat NNReal
                  (@instHPow.{0, 0} NNReal Nat
                    (@NPow.toPow.{0} NNReal
                      (@Monoid.toNPow.{0} NNReal (@Semiring.toMonoid.{0} NNReal NNReal.instSemiring))))
                  (@Inv.inv.{0} NNReal NNReal.instInv
                    (@OfNat.ofNat.{0} NNReal (nat_lit 2)
                      (@instOfNatAtLeastTwo.{0} NNReal (nat_lit 2)
                        (@AddMonoidWithOne.toNatCast.{0} NNReal
                          (@AddCommMonoidWithOne.toAddMonoidWithOne.{0} NNReal
                            (@NonAssocSemiring.toAddCommMonoidWithOne.{0} NNReal
                              (@Semiring.toNonAssocSemiring.{0} NNReal NNReal.instSemiring))))
                        ⋯)))
                  i))
              J (@SetLike.coe.{u_1, u_1} (Finset.{u_1} T) T (@Finset.instSetLike.{u_1} T) (C i))) →
          (∀ (i : Nat),
              @LE.le.{u_1} (Set.{u_1} T) (@Set.instLE.{u_1} T)
                (@SetLike.coe.{u_1, u_1} (Finset.{u_1} T) T (@Finset.instSetLike.{u_1} T) (C i)) J) →
            (∀ (i : Nat),
                @Eq.{1} ENat (@Nat.cast.{0} ENat ENat.instNatCast (@Finset.card.{u_1} T (C i)))
                  (@Metric.coveringNumber.{u_1} T inst
                    (@HMul.hMul.{0, 0, 0} NNReal NNReal NNReal
                      (@instHMul.{0} NNReal
                        (@Distrib.toMul.{0} NNReal (@instDistribOfSemiring.{0} NNReal NNReal.instSemiring)))
                      ε₀
                      (@HPow.hPow.{0, 0, 0} NNReal Nat NNReal
                        (@instHPow.{0, 0} NNReal Nat
                          (@NPow.toPow.{0} NNReal
                            (@Monoid.toNPow.{0} NNReal (@Semiring.toMonoid.{0} NNReal NNReal.instSemiring))))
                        (@Inv.inv.{0} NNReal NNReal.instInv
                          (@OfNat.ofNat.{0} NNReal (nat_lit 2)
                            (@instOfNatAtLeastTwo.{0} NNReal (nat_lit 2)
                              (@AddMonoidWithOne.toNatCast.{0} NNReal
                                (@AddCommMonoidWithOne.toAddMonoidWithOne.{0} NNReal
                                  (@NonAssocSemiring.toAddCommMonoidWithOne.{0} NNReal
                                    (@Semiring.toNonAssocSemiring.{0} NNReal NNReal.instSemiring))))
                              ⋯)))
                        i))
                    J)) →
              ∀ {δ : NNReal},
                @LT.lt.{0} NNReal
                    (@Preorder.toLT.{0} NNReal (@PartialOrder.toPreorder.{0} NNReal NNReal.instPartialOrder))
                    (@OfNat.ofNat.{0} NNReal (nat_lit 0) (@Zero.toOfNat0.{0} NNReal NNReal.instZero)) δ →
                  @LE.le.{0} NNReal
                      (@Preorder.toLE.{0} NNReal (@PartialOrder.toPreorder.{0} NNReal NNReal.instPartialOrder)) δ
                      (@HMul.hMul.{0, 0, 0} NNReal NNReal NNReal
                        (@instHMul.{0} NNReal
                          (@Distrib.toMul.{0} NNReal (@instDistribOfSemiring.{0} NNReal NNReal.instSemiring)))
                        ε₀
                        (@OfNat.ofNat.{0} NNReal (nat_lit 4)
                          (@instOfNatAtLeastTwo.{0} NNReal (nat_lit 4)
                            (@AddMonoidWithOne.toNatCast.{0} NNReal
                              (@AddCommMonoidWithOne.toAddMonoidWithOne.{0} NNReal
                                (@NonAssocSemiring.toAddCommMonoidWithOne.{0} NNReal
                                  (@Semiring.toNonAssocSemiring.{0} NNReal NNReal.instSemiring))))
                            ⋯))) →
                    ∀ {k m : Nat},
                      @LE.le.{0} NNReal
                          (@Preorder.toLE.{0} NNReal (@PartialOrder.toPreorder.{0} NNReal NNReal.instPartialOrder))
                          (@HMul.hMul.{0, 0, 0} NNReal NNReal NNReal
                            (@instHMul.{0} NNReal
                              (@Distrib.toMul.{0} NNReal (@instDistribOfSemiring.{0} NNReal NNReal.instSemiring)))
                            ε₀
                            (@HPow.hPow.{0, 0, 0} NNReal Nat NNReal
                              (@instHPow.{0, 0} NNReal Nat
                                (@NPow.toPow.{0} NNReal
                                  (@Monoid.toNPow.{0} NNReal (@Semiring.toMonoid.{0} NNReal NNReal.instSemiring))))
                              (@Inv.inv.{0} NNReal NNReal.instInv
                                (@OfNat.ofNat.{0} NNReal (nat_lit 2)
                                  (@instOfNatAtLeastTwo.{0} NNReal (nat_lit 2)
                                    (@AddMonoidWithOne.toNatCast.{0} NNReal
                                      (@AddCommMonoidWithOne.toAddMonoidWithOne.{0} NNReal
                                        (@NonAssocSemiring.toAddCommMonoidWithOne.{0} NNReal
                                          (@Semiring.toNonAssocSemiring.{0} NNReal NNReal.instSemiring))))
                                    ⋯)))
                              m))
                          δ →
                        @LE.le.{0} NNReal
                            (@Preorder.toLE.{0} NNReal (@PartialOrder.toPreorder.{0} NNReal NNReal.instPartialOrder)) δ
                            (@HMul.hMul.{0, 0, 0} NNReal NNReal NNReal
                              (@instHMul.{0} NNReal
                                (@Distrib.toMul.{0} NNReal (@instDistribOfSemiring.{0} NNReal NNReal.instSemiring)))
                              (@HMul.hMul.{0, 0, 0} NNReal NNReal NNReal
                                (@instHMul.{0} NNReal
                                  (@Distrib.toMul.{0} NNReal (@instDistribOfSemiring.{0} NNReal NNReal.instSemiring)))
                                ε₀
                                (@OfNat.ofNat.{0} NNReal (nat_lit 4)
                                  (@instOfNatAtLeastTwo.{0} NNReal (nat_lit 4)
                                    (@AddMonoidWithOne.toNatCast.{0} NNReal
                                      (@AddCommMonoidWithOne.toAddMonoidWithOne.{0} NNReal
                                        (@NonAssocSemiring.toAddCommMonoidWithOne.{0} NNReal
                                          (@Semiring.toNonAssocSemiring.{0} NNReal NNReal.instSemiring))))
                                    ⋯)))
                              (@HPow.hPow.{0, 0, 0} NNReal Nat NNReal
                                (@instHPow.{0, 0} NNReal Nat
                                  (@NPow.toPow.{0} NNReal
                                    (@Monoid.toNPow.{0} NNReal (@Semiring.toMonoid.{0} NNReal NNReal.instSemiring))))
                                (@Inv.inv.{0} NNReal NNReal.instInv
                                  (@OfNat.ofNat.{0} NNReal (nat_lit 2)
                                    (@instOfNatAtLeastTwo.{0} NNReal (nat_lit 2)
                                      (@AddMonoidWithOne.toNatCast.{0} NNReal
                                        (@AddCommMonoidWithOne.toAddMonoidWithOne.{0} NNReal
                                          (@NonAssocSemiring.toAddCommMonoidWithOne.{0} NNReal
                                            (@Semiring.toNonAssocSemiring.{0} NNReal NNReal.instSemiring))))
                                      ⋯)))
                                m)) →
                          @LE.le.{0} Nat instLENat m k →
                            @LE.le.{0} ENNReal ENNReal.instLE
                              (@MeasureTheory.lintegral.{u_2} Ω mΩ P fun ω =>
                                ⨆ s,
                                  ⨆ t,
                                    @HPow.hPow.{0, 0, 0} ENNReal Real ENNReal
                                      (@instHPow.{0, 0} ENNReal Real ENNReal.instPowReal)
                                      (@EDist.edist.{u_3} E
                                        (@WeakPseudoEMetricSpace.toEDist.{u_3} E
                                          (@UniformSpace.toTopologicalSpace.{u_3} E
                                            (@PseudoEMetricSpace.toUniformSpace.{u_3} E inst_1))
                                          (@PseudoEMetricSpace.toWeakPseudoEMetricSpace.{u_3} E inst_1))
                                        (X
                                          (@chainingSequence.{u_1} T inst C
                                            (@Subtype.val.{u_1 + 1} T
                                              (fun x =>
                                                @Membership.mem.{u_1, u_1} T (Finset.{u_1} T)
                                                  (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} T) T
                                                    (@Finset.instSetLike.{u_1} T))
                                                  (C k) x)
                                              s)
                                            k m)
                                          ω)
                                        (X
                                          (@chainingSequence.{u_1} T inst C
                                            (@Subtype.val.{u_1 + 1} T
                                              (fun x =>
                                                @Membership.mem.{u_1, u_1} T (Finset.{u_1} T)
                                                  (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} T) T
                                                    (@Finset.instSetLike.{u_1} T))
                                                  (C k) x)
                                              (@Subtype.val.{u_1 + 1} (↥(C k))
                                                (fun t =>
                                                  @LE.le.{0} ENNReal ENNReal.instLE
                                                    (@EDist.edist.{u_1} (↥(C k))
                                                      (@WeakPseudoEMetricSpace.toEDist.{u_1} (↥(C k))
                                                        (@instTopologicalSpaceSubtype.{u_1} T
                                                          (fun x =>
                                                            @Membership.mem.{u_1, u_1} T (Finset.{u_1} T)
                                                              (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} T) T
                                                                (@Finset.instSetLike.{u_1} T))
                                                              (C k) x)
                                                          (@UniformSpace.toTopologicalSpace.{u_1} T
                                                            (@PseudoEMetricSpace.toUniformSpace.{u_1} T inst)))
                                                        (@instWeakPseudoEMetricSpaceSubtype.{u_1} T
                                                          (fun x =>
                                                            @Membership.mem.{u_1, u_1} T (Finset.{u_1} T)
                                                              (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} T) T
                                                                (@Finset.instSetLike.{u_1} T))
                                                              (C k) x)
                                                          (@UniformSpace.toTopologicalSpace.{u_1} T
                                                            (@PseudoEMetricSpace.toUniformSpace.{u_1} T inst))
                                                          (@PseudoEMetricSpace.toWeakPseudoEMetricSpace.{u_1} T inst)))
                                                      s t)
                                                    ↑δ)
                                                t))
                                            k m)
                                          ω))
                                      p)
                              (@HMul.hMul.{0, 0, 0} ENNReal ENNReal ENNReal
                                (@instHMul.{0} ENNReal
                                  (@Distrib.toMul.{0} ENNReal
                                    (@instDistribOfSemiring.{0} ENNReal
                                      (@CommSemiring.toSemiring.{0} ENNReal ENNReal.instCommSemiring))))
                                (@HMul.hMul.{0, 0, 0} ENNReal ENNReal ENNReal
                                  (@instHMul.{0} ENNReal
                                    (@Distrib.toMul.{0} ENNReal
                                      (@instDistribOfSemiring.{0} ENNReal
                                        (@CommSemiring.toSemiring.{0} ENNReal ENNReal.instCommSemiring))))
                                  (@HMul.hMul.{0, 0, 0} ENNReal ENNReal ENNReal
                                    (@instHMul.{0} ENNReal
                                      (@Distrib.toMul.{0} ENNReal
                                        (@instDistribOfSemiring.{0} ENNReal
                                          (@CommSemiring.toSemiring.{0} ENNReal ENNReal.instCommSemiring))))
                                    (@HPow.hPow.{0, 0, 0} ENNReal Real ENNReal
                                      (@instHPow.{0, 0} ENNReal Real ENNReal.instPowReal)
                                      (@OfNat.ofNat.{0} ENNReal (nat_lit 2)
                                        (@instOfNatAtLeastTwo.{0} ENNReal (nat_lit 2)
                                          (@AddMonoidWithOne.toNatCast.{0} ENNReal
                                            (@AddCommMonoidWithOne.toAddMonoidWithOne.{0} ENNReal
                                              ENNReal.instAddCommMonoidWithOne))
                                          ⋯))
                                      (@HAdd.hAdd.{0, 0, 0} Real Real Real (@instHAdd.{0} Real Real.instAdd) p
                                        (@OfNat.ofNat.{0} Real (nat_lit 1) (@One.toOfNat1.{0} Real Real.instOne))))
                                    ↑M)
                                  (@HPow.hPow.{0, 0, 0} ENNReal Real ENNReal
                                    (@instHPow.{0, 0} ENNReal Real ENNReal.instPowReal)
                                    (@HMul.hMul.{0, 0, 0} ENNReal ENNReal ENNReal
                                      (@instHMul.{0} ENNReal
                                        (@Distrib.toMul.{0} ENNReal
                                          (@instDistribOfSemiring.{0} ENNReal
                                            (@CommSemiring.toSemiring.{0} ENNReal ENNReal.instCommSemiring))))
                                      (@HMul.hMul.{0, 0, 0} ENNReal ENNReal ENNReal
                                        (@instHMul.{0} ENNReal
                                          (@Distrib.toMul.{0} ENNReal
                                            (@instDistribOfSemiring.{0} ENNReal
                                              (@CommSemiring.toSemiring.{0} ENNReal ENNReal.instCommSemiring))))
                                        (@OfNat.ofNat.{0} ENNReal (nat_lit 16)
                                          (@instOfNatAtLeastTwo.{0} ENNReal (nat_lit 16)
                                            (@AddMonoidWithOne.toNatCast.{0} ENNReal
                                              (@AddCommMonoidWithOne.toAddMonoidWithOne.{0} ENNReal
                                                ENNReal.instAddCommMonoidWithOne))
                                            ⋯))
                                        ↑δ)
                                      (@Nat.cast.{0} ENNReal
                                        (@AddMonoidWithOne.toNatCast.{0} ENNReal
                                          (@AddCommMonoidWithOne.toAddMonoidWithOne.{0} ENNReal
                                            ENNReal.instAddCommMonoidWithOne))
                                        (@Metric.coveringNumber.{u_1} T inst
                                              (@HDiv.hDiv.{0, 0, 0} NNReal NNReal NNReal
                                                (@instHDiv.{0} NNReal NNReal.instDiv) δ
                                                (@OfNat.ofNat.{0} NNReal (nat_lit 4)
                                                  (@instOfNatAtLeastTwo.{0} NNReal (nat_lit 4)
                                                    (@AddMonoidWithOne.toNatCast.{0} NNReal
                                                      (@AddCommMonoidWithOne.toAddMonoidWithOne.{0} NNReal
                                                        (@NonAssocSemiring.toAddCommMonoidWithOne.{0} NNReal
                                                          (@Semiring.toNonAssocSemiring.{0} NNReal
                                                            NNReal.instSemiring))))
                                                    ⋯)))
                                              J).toNat.log2))
                                    q))
                                ↑(@Metric.coveringNumber.{u_1} T inst
                                    (@HDiv.hDiv.{0, 0, 0} NNReal NNReal NNReal (@instHDiv.{0} NNReal NNReal.instDiv) δ
                                      (@OfNat.ofNat.{0} NNReal (nat_lit 4)
                                        (@instOfNatAtLeastTwo.{0} NNReal (nat_lit 4)
                                          (@AddMonoidWithOne.toNatCast.{0} NNReal
                                            (@AddCommMonoidWithOne.toAddMonoidWithOne.{0} NNReal
                                              (@NonAssocSemiring.toAddCommMonoidWithOne.{0} NNReal
                                                (@Semiring.toNonAssocSemiring.{0} NNReal NNReal.instSemiring))))
                                          ⋯)))
                                    J)) :=
⋯
```

## `ProbabilityTheory.lintegral_sup_rpow_edist_le_card_mul_rpow`

Command: `#print ProbabilityTheory.lintegral_sup_rpow_edist_le_card_mul_rpow`

```lean
theorem ProbabilityTheory.lintegral_sup_rpow_edist_le_card_mul_rpow.{u_1, u_2, u_3} : ∀ {T : Type u_1} {Ω : Type u_2}
  {E : Type u_3} [inst : PseudoEMetricSpace.{u_1} T] {mΩ : MeasurableSpace.{u_2} Ω}
  [inst_1 : PseudoEMetricSpace.{u_3} E] {p q : Real} {M : NNReal} {P : @MeasureTheory.Measure.{u_2} Ω mΩ}
  {X : T → Ω → E},
  @ProbabilityTheory.IsAEKolmogorovProcess.{u_1, u_2, u_3} T Ω E inst mΩ inst_1 X P p q M →
    ∀ {ε : ENNReal} (C : Finset.{u_1} (Prod.{u_1, u_1} T T)),
      (∀ (u : Prod.{u_1, u_1} T T),
          @Membership.mem.{u_1, u_1} (Prod.{u_1, u_1} T T) (Finset.{u_1} (Prod.{u_1, u_1} T T))
              (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} (Prod.{u_1, u_1} T T)) (Prod.{u_1, u_1} T T)
                (@Finset.instSetLike.{u_1} (Prod.{u_1, u_1} T T)))
              C u →
            @LE.le.{0} ENNReal ENNReal.instLE
              (@EDist.edist.{u_1} T
                (@WeakPseudoEMetricSpace.toEDist.{u_1} T
                  (@UniformSpace.toTopologicalSpace.{u_1} T (@PseudoEMetricSpace.toUniformSpace.{u_1} T inst))
                  (@PseudoEMetricSpace.toWeakPseudoEMetricSpace.{u_1} T inst))
                (@Prod.fst.{u_1, u_1} T T u) (@Prod.snd.{u_1, u_1} T T u))
              ε) →
        @LE.le.{0} ENNReal ENNReal.instLE
          (@MeasureTheory.lintegral.{u_2} Ω mΩ P fun ω =>
            ⨆ u,
              @HPow.hPow.{0, 0, 0} ENNReal Real ENNReal (@instHPow.{0, 0} ENNReal Real ENNReal.instPowReal)
                (@EDist.edist.{u_3} E
                  (@WeakPseudoEMetricSpace.toEDist.{u_3} E
                    (@UniformSpace.toTopologicalSpace.{u_3} E (@PseudoEMetricSpace.toUniformSpace.{u_3} E inst_1))
                    (@PseudoEMetricSpace.toWeakPseudoEMetricSpace.{u_3} E inst_1))
                  (X
                    (@Prod.fst.{u_1, u_1} T T
                      (@Subtype.val.{u_1 + 1} (Prod.{u_1, u_1} T T)
                        (fun x =>
                          @Membership.mem.{u_1, u_1} (Prod.{u_1, u_1} T T) (Finset.{u_1} (Prod.{u_1, u_1} T T))
                            (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} (Prod.{u_1, u_1} T T))
                              (Prod.{u_1, u_1} T T) (@Finset.instSetLike.{u_1} (Prod.{u_1, u_1} T T)))
                            C x)
                        u))
                    ω)
                  (X
                    (@Prod.snd.{u_1, u_1} T T
                      (@Subtype.val.{u_1 + 1} (Prod.{u_1, u_1} T T)
                        (fun x =>
                          @Membership.mem.{u_1, u_1} (Prod.{u_1, u_1} T T) (Finset.{u_1} (Prod.{u_1, u_1} T T))
                            (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} (Prod.{u_1, u_1} T T))
                              (Prod.{u_1, u_1} T T) (@Finset.instSetLike.{u_1} (Prod.{u_1, u_1} T T)))
                            C x)
                        u))
                    ω))
                p)
          (@HMul.hMul.{0, 0, 0} ENNReal ENNReal ENNReal
            (@instHMul.{0} ENNReal
              (@Distrib.toMul.{0} ENNReal
                (@instDistribOfSemiring.{0} ENNReal (@CommSemiring.toSemiring.{0} ENNReal ENNReal.instCommSemiring))))
            (@HMul.hMul.{0, 0, 0} ENNReal ENNReal ENNReal
              (@instHMul.{0} ENNReal
                (@Distrib.toMul.{0} ENNReal
                  (@instDistribOfSemiring.{0} ENNReal (@CommSemiring.toSemiring.{0} ENNReal ENNReal.instCommSemiring))))
              (@Nat.cast.{0} ENNReal
                (@AddMonoidWithOne.toNatCast.{0} ENNReal
                  (@AddCommMonoidWithOne.toAddMonoidWithOne.{0} ENNReal ENNReal.instAddCommMonoidWithOne))
                (@Finset.card.{u_1} (Prod.{u_1, u_1} T T) C))
              ↑M)
            (@HPow.hPow.{0, 0, 0} ENNReal Real ENNReal (@instHPow.{0, 0} ENNReal Real ENNReal.instPowReal) ε q)) :=
⋯
```

## `ProbabilityTheory.lintegral_sup_rpow_edist_le_card_mul_rpow_of_dist_le`

Command: `#print ProbabilityTheory.lintegral_sup_rpow_edist_le_card_mul_rpow_of_dist_le`

```lean
theorem ProbabilityTheory.lintegral_sup_rpow_edist_le_card_mul_rpow_of_dist_le.{u_1, u_2, u_3} : ∀ {T : Type u_1}
  {Ω : Type u_2} {E : Type u_3} [inst : PseudoEMetricSpace.{u_1} T] {mΩ : MeasurableSpace.{u_2} Ω}
  [inst_1 : PseudoEMetricSpace.{u_3} E] {p q : Real} {M : NNReal} {P : @MeasureTheory.Measure.{u_2} Ω mΩ}
  {X : T → Ω → E},
  @ProbabilityTheory.IsAEKolmogorovProcess.{u_1, u_2, u_3} T Ω E inst mΩ inst_1 X P p q M →
    ∀ {J : Finset.{u_1} T} {a c : ENNReal} {n : Nat},
      @LE.le.{0} ENNReal ENNReal.instLE
          (@Nat.cast.{0} ENNReal
            (@AddMonoidWithOne.toNatCast.{0} ENNReal
              (@AddCommMonoidWithOne.toAddMonoidWithOne.{0} ENNReal ENNReal.instAddCommMonoidWithOne))
            (@Finset.card.{u_1} T J))
          (@HPow.hPow.{0, 0, 0} ENNReal Nat ENNReal
            (@instHPow.{0, 0} ENNReal Nat
              (@NPow.toPow.{0} ENNReal
                (@Monoid.toNPow.{0} ENNReal
                  (@Semiring.toMonoid.{0} ENNReal (@CommSemiring.toSemiring.{0} ENNReal ENNReal.instCommSemiring)))))
            a n) →
        @LE.le.{0} ENNReal ENNReal.instLE
          (@MeasureTheory.lintegral.{u_2} Ω mΩ P fun ω =>
            ⨆ s,
              ⨆ t,
                @HPow.hPow.{0, 0, 0} ENNReal Real ENNReal (@instHPow.{0, 0} ENNReal Real ENNReal.instPowReal)
                  (@EDist.edist.{u_3} E
                    (@WeakPseudoEMetricSpace.toEDist.{u_3} E
                      (@UniformSpace.toTopologicalSpace.{u_3} E (@PseudoEMetricSpace.toUniformSpace.{u_3} E inst_1))
                      (@PseudoEMetricSpace.toWeakPseudoEMetricSpace.{u_3} E inst_1))
                    (X
                      (@Subtype.val.{u_1 + 1} T
                        (fun x =>
                          @Membership.mem.{u_1, u_1} T (Finset.{u_1} T)
                            (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} T) T (@Finset.instSetLike.{u_1} T)) J x)
                        s)
                      ω)
                    (X
                      (@Subtype.val.{u_1 + 1} T
                        (fun x =>
                          @Membership.mem.{u_1, u_1} T (Finset.{u_1} T)
                            (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} T) T (@Finset.instSetLike.{u_1} T)) J x)
                        (@Subtype.val.{u_1 + 1} (↥J)
                          (fun t =>
                            @LE.le.{0} ENNReal ENNReal.instLE
                              (@EDist.edist.{u_1} (↥J)
                                (@WeakPseudoEMetricSpace.toEDist.{u_1} (↥J)
                                  (@instTopologicalSpaceSubtype.{u_1} T
                                    (fun x =>
                                      @Membership.mem.{u_1, u_1} T (Finset.{u_1} T)
                                        (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} T) T
                                          (@Finset.instSetLike.{u_1} T))
                                        J x)
                                    (@UniformSpace.toTopologicalSpace.{u_1} T
                                      (@PseudoEMetricSpace.toUniformSpace.{u_1} T inst)))
                                  (@instWeakPseudoEMetricSpaceSubtype.{u_1} T
                                    (fun x =>
                                      @Membership.mem.{u_1, u_1} T (Finset.{u_1} T)
                                        (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} T) T
                                          (@Finset.instSetLike.{u_1} T))
                                        J x)
                                    (@UniformSpace.toTopologicalSpace.{u_1} T
                                      (@PseudoEMetricSpace.toUniformSpace.{u_1} T inst))
                                    (@PseudoEMetricSpace.toWeakPseudoEMetricSpace.{u_1} T inst)))
                                s t)
                              c)
                          t))
                      ω))
                  p)
          (@HMul.hMul.{0, 0, 0} ENNReal ENNReal ENNReal
            (@instHMul.{0} ENNReal
              (@Distrib.toMul.{0} ENNReal
                (@instDistribOfSemiring.{0} ENNReal (@CommSemiring.toSemiring.{0} ENNReal ENNReal.instCommSemiring))))
            (@HMul.hMul.{0, 0, 0} ENNReal ENNReal ENNReal
              (@instHMul.{0} ENNReal
                (@Distrib.toMul.{0} ENNReal
                  (@instDistribOfSemiring.{0} ENNReal (@CommSemiring.toSemiring.{0} ENNReal ENNReal.instCommSemiring))))
              (@HMul.hMul.{0, 0, 0} ENNReal ENNReal ENNReal
                (@instHMul.{0} ENNReal
                  (@Distrib.toMul.{0} ENNReal
                    (@instDistribOfSemiring.{0} ENNReal
                      (@CommSemiring.toSemiring.{0} ENNReal ENNReal.instCommSemiring))))
                (@HMul.hMul.{0, 0, 0} ENNReal ENNReal ENNReal
                  (@instHMul.{0} ENNReal
                    (@Distrib.toMul.{0} ENNReal
                      (@instDistribOfSemiring.{0} ENNReal
                        (@CommSemiring.toSemiring.{0} ENNReal ENNReal.instCommSemiring))))
                  (@HPow.hPow.{0, 0, 0} ENNReal Real ENNReal (@instHPow.{0, 0} ENNReal Real ENNReal.instPowReal)
                    (@OfNat.ofNat.{0} ENNReal (nat_lit 2)
                      (@instOfNatAtLeastTwo.{0} ENNReal (nat_lit 2)
                        (@AddMonoidWithOne.toNatCast.{0} ENNReal
                          (@AddCommMonoidWithOne.toAddMonoidWithOne.{0} ENNReal ENNReal.instAddCommMonoidWithOne))
                        ⋯))
                    p)
                  a)
                (@Nat.cast.{0} ENNReal
                  (@AddMonoidWithOne.toNatCast.{0} ENNReal
                    (@AddCommMonoidWithOne.toAddMonoidWithOne.{0} ENNReal ENNReal.instAddCommMonoidWithOne))
                  (@Finset.card.{u_1} T J)))
              ↑M)
            (@HPow.hPow.{0, 0, 0} ENNReal Real ENNReal (@instHPow.{0, 0} ENNReal Real ENNReal.instPowReal)
              (@HMul.hMul.{0, 0, 0} ENNReal ENNReal ENNReal
                (@instHMul.{0} ENNReal
                  (@Distrib.toMul.{0} ENNReal
                    (@instDistribOfSemiring.{0} ENNReal
                      (@CommSemiring.toSemiring.{0} ENNReal ENNReal.instCommSemiring))))
                c
                (@Nat.cast.{0} ENNReal
                  (@AddMonoidWithOne.toNatCast.{0} ENNReal
                    (@AddCommMonoidWithOne.toAddMonoidWithOne.{0} ENNReal ENNReal.instAddCommMonoidWithOne))
                  n))
              q)) :=
⋯
```

## `ProbabilityTheory.lintegral_sup_rpow_edist_le_of_minimal_cover`

Command: `#print ProbabilityTheory.lintegral_sup_rpow_edist_le_of_minimal_cover`

```lean
theorem ProbabilityTheory.lintegral_sup_rpow_edist_le_of_minimal_cover.{u_1, u_2, u_3} : ∀ {T : Type u_1} {Ω : Type u_2}
  {E : Type u_3} [inst : PseudoEMetricSpace.{u_1} T] {mΩ : MeasurableSpace.{u_2} Ω}
  [inst_1 : PseudoEMetricSpace.{u_3} E] {p q : Real} {M : NNReal} {P : @MeasureTheory.Measure.{u_2} Ω mΩ}
  {X : T → Ω → E} {J : Set.{u_1} T} {C : Nat → Finset.{u_1} T} {ε : Nat → NNReal} {k m : Nat},
  @LE.le.{0} Real Real.instLE (@OfNat.ofNat.{0} Real (nat_lit 1) (@One.toOfNat1.{0} Real Real.instOne)) p →
    @ProbabilityTheory.IsAEKolmogorovProcess.{u_1, u_2, u_3} T Ω E inst mΩ inst_1 X P p q M →
      (∀ (n : Nat), @LE.le.{0} ENNReal ENNReal.instLE (↑(ε n)) (@Metric.ediam.{u_1} T inst J)) →
        (∀ (n : Nat),
            @Metric.IsCover.{u_1} T inst (ε n) J
              (@SetLike.coe.{u_1, u_1} (Finset.{u_1} T) T (@Finset.instSetLike.{u_1} T) (C n))) →
          (∀ (n : Nat),
              @LE.le.{u_1} (Set.{u_1} T) (@Set.instLE.{u_1} T)
                (@SetLike.coe.{u_1, u_1} (Finset.{u_1} T) T (@Finset.instSetLike.{u_1} T) (C n)) J) →
            (∀ (n : Nat),
                @Eq.{1} ENat (@Nat.cast.{0} ENat ENat.instNatCast (@Finset.card.{u_1} T (C n)))
                  (@Metric.coveringNumber.{u_1} T inst (ε n) J)) →
              ∀ {c₁ : ENNReal} {d : Real},
                @HasBoundedCoveringNumber.{u_1} T inst J c₁ d →
                  @LE.le.{0} Nat instLENat m k →
                    @LE.le.{0} ENNReal ENNReal.instLE
                      (@MeasureTheory.lintegral.{u_2} Ω mΩ P fun ω =>
                        ⨆ t,
                          @HPow.hPow.{0, 0, 0} ENNReal Real ENNReal (@instHPow.{0, 0} ENNReal Real ENNReal.instPowReal)
                            (@EDist.edist.{u_3} E
                              (@WeakPseudoEMetricSpace.toEDist.{u_3} E
                                (@UniformSpace.toTopologicalSpace.{u_3} E
                                  (@PseudoEMetricSpace.toUniformSpace.{u_3} E inst_1))
                                (@PseudoEMetricSpace.toWeakPseudoEMetricSpace.{u_3} E inst_1))
                              (X
                                (@Subtype.val.{u_1 + 1} T
                                  (fun x =>
                                    @Membership.mem.{u_1, u_1} T (Finset.{u_1} T)
                                      (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} T) T
                                        (@Finset.instSetLike.{u_1} T))
                                      (C k) x)
                                  t)
                                ω)
                              (X
                                (@chainingSequence.{u_1} T inst C
                                  (@Subtype.val.{u_1 + 1} T
                                    (fun x =>
                                      @Membership.mem.{u_1, u_1} T (Finset.{u_1} T)
                                        (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} T) T
                                          (@Finset.instSetLike.{u_1} T))
                                        (C k) x)
                                    t)
                                  k m)
                                ω))
                            p)
                      (@HMul.hMul.{0, 0, 0} ENNReal ENNReal ENNReal
                        (@instHMul.{0} ENNReal
                          (@Distrib.toMul.{0} ENNReal
                            (@instDistribOfSemiring.{0} ENNReal
                              (@CommSemiring.toSemiring.{0} ENNReal ENNReal.instCommSemiring))))
                        (@HMul.hMul.{0, 0, 0} ENNReal ENNReal ENNReal
                          (@instHMul.{0} ENNReal
                            (@Distrib.toMul.{0} ENNReal
                              (@instDistribOfSemiring.{0} ENNReal
                                (@CommSemiring.toSemiring.{0} ENNReal ENNReal.instCommSemiring))))
                          (↑M) c₁)
                        (@HPow.hPow.{0, 0, 0} ENNReal Real ENNReal (@instHPow.{0, 0} ENNReal Real ENNReal.instPowReal)
                          (∑ j ∈ Finset.range (@HSub.hSub.{0, 0, 0} Nat Nat Nat (@instHSub.{0} Nat instSubNat) k m),
                            @HMul.hMul.{0, 0, 0} ENNReal ENNReal ENNReal
                              (@instHMul.{0} ENNReal
                                (@Distrib.toMul.{0} ENNReal
                                  (@instDistribOfSemiring.{0} ENNReal
                                    (@CommSemiring.toSemiring.{0} ENNReal ENNReal.instCommSemiring))))
                              (@HPow.hPow.{0, 0, 0} ENNReal Real ENNReal
                                (@instHPow.{0, 0} ENNReal Real ENNReal.instPowReal)
                                (↑(ε
                                    (@HAdd.hAdd.{0, 0, 0} Nat Nat Nat (@instHAdd.{0} Nat instAddNat)
                                      (@HAdd.hAdd.{0, 0, 0} Nat Nat Nat (@instHAdd.{0} Nat instAddNat) m j)
                                      (@OfNat.ofNat.{0} Nat (nat_lit 1) (instOfNatNat (nat_lit 1))))))
                                (@HDiv.hDiv.{0, 0, 0} Real Real Real
                                  (@instHDiv.{0} Real (@DivInvMonoid.toDiv.{0} Real Real.instDivInvMonoid))
                                  (@Neg.neg.{0} Real Real.instNeg d) p))
                              (@HPow.hPow.{0, 0, 0} ENNReal Real ENNReal
                                (@instHPow.{0, 0} ENNReal Real ENNReal.instPowReal)
                                (↑(ε (@HAdd.hAdd.{0, 0, 0} Nat Nat Nat (@instHAdd.{0} Nat instAddNat) m j)))
                                (@HDiv.hDiv.{0, 0, 0} Real Real Real
                                  (@instHDiv.{0} Real (@DivInvMonoid.toDiv.{0} Real Real.instDivInvMonoid)) q p)))
                          p)) :=
⋯
```

## `ProbabilityTheory.lintegral_sup_rpow_edist_le_of_minimal_cover_of_le_one`

Command: `#print ProbabilityTheory.lintegral_sup_rpow_edist_le_of_minimal_cover_of_le_one`

```lean
theorem ProbabilityTheory.lintegral_sup_rpow_edist_le_of_minimal_cover_of_le_one.{u_1, u_2, u_3} : ∀ {T : Type u_1}
  {Ω : Type u_2} {E : Type u_3} [inst : PseudoEMetricSpace.{u_1} T] {mΩ : MeasurableSpace.{u_2} Ω}
  [inst_1 : PseudoEMetricSpace.{u_3} E] {p q : Real} {M : NNReal} {P : @MeasureTheory.Measure.{u_2} Ω mΩ}
  {X : T → Ω → E} {J : Set.{u_1} T} {C : Nat → Finset.{u_1} T} {ε : Nat → NNReal} {k m : Nat},
  @LE.le.{0} Real Real.instLE p (@OfNat.ofNat.{0} Real (nat_lit 1) (@One.toOfNat1.{0} Real Real.instOne)) →
    @ProbabilityTheory.IsAEKolmogorovProcess.{u_1, u_2, u_3} T Ω E inst mΩ inst_1 X P p q M →
      (∀ (n : Nat), @LE.le.{0} ENNReal ENNReal.instLE (↑(ε n)) (@Metric.ediam.{u_1} T inst J)) →
        (∀ (n : Nat),
            @Metric.IsCover.{u_1} T inst (ε n) J
              (@SetLike.coe.{u_1, u_1} (Finset.{u_1} T) T (@Finset.instSetLike.{u_1} T) (C n))) →
          (∀ (n : Nat),
              @LE.le.{u_1} (Set.{u_1} T) (@Set.instLE.{u_1} T)
                (@SetLike.coe.{u_1, u_1} (Finset.{u_1} T) T (@Finset.instSetLike.{u_1} T) (C n)) J) →
            (∀ (n : Nat),
                @Eq.{1} ENat (@Nat.cast.{0} ENat ENat.instNatCast (@Finset.card.{u_1} T (C n)))
                  (@Metric.coveringNumber.{u_1} T inst (ε n) J)) →
              ∀ {c₁ : ENNReal} {d : Real},
                @HasBoundedCoveringNumber.{u_1} T inst J c₁ d →
                  @LE.le.{0} Nat instLENat m k →
                    @LE.le.{0} ENNReal ENNReal.instLE
                      (@MeasureTheory.lintegral.{u_2} Ω mΩ P fun ω =>
                        ⨆ t,
                          @HPow.hPow.{0, 0, 0} ENNReal Real ENNReal (@instHPow.{0, 0} ENNReal Real ENNReal.instPowReal)
                            (@EDist.edist.{u_3} E
                              (@WeakPseudoEMetricSpace.toEDist.{u_3} E
                                (@UniformSpace.toTopologicalSpace.{u_3} E
                                  (@PseudoEMetricSpace.toUniformSpace.{u_3} E inst_1))
                                (@PseudoEMetricSpace.toWeakPseudoEMetricSpace.{u_3} E inst_1))
                              (X
                                (@Subtype.val.{u_1 + 1} T
                                  (fun x =>
                                    @Membership.mem.{u_1, u_1} T (Finset.{u_1} T)
                                      (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} T) T
                                        (@Finset.instSetLike.{u_1} T))
                                      (C k) x)
                                  t)
                                ω)
                              (X
                                (@chainingSequence.{u_1} T inst C
                                  (@Subtype.val.{u_1 + 1} T
                                    (fun x =>
                                      @Membership.mem.{u_1, u_1} T (Finset.{u_1} T)
                                        (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} T) T
                                          (@Finset.instSetLike.{u_1} T))
                                        (C k) x)
                                    t)
                                  k m)
                                ω))
                            p)
                      (@HMul.hMul.{0, 0, 0} ENNReal ENNReal ENNReal
                        (@instHMul.{0} ENNReal
                          (@Distrib.toMul.{0} ENNReal
                            (@instDistribOfSemiring.{0} ENNReal
                              (@CommSemiring.toSemiring.{0} ENNReal ENNReal.instCommSemiring))))
                        (@HMul.hMul.{0, 0, 0} ENNReal ENNReal ENNReal
                          (@instHMul.{0} ENNReal
                            (@Distrib.toMul.{0} ENNReal
                              (@instDistribOfSemiring.{0} ENNReal
                                (@CommSemiring.toSemiring.{0} ENNReal ENNReal.instCommSemiring))))
                          (↑M) c₁)
                        (∑ j ∈ Finset.range (@HSub.hSub.{0, 0, 0} Nat Nat Nat (@instHSub.{0} Nat instSubNat) k m),
                          @HMul.hMul.{0, 0, 0} ENNReal ENNReal ENNReal
                            (@instHMul.{0} ENNReal
                              (@Distrib.toMul.{0} ENNReal
                                (@instDistribOfSemiring.{0} ENNReal
                                  (@CommSemiring.toSemiring.{0} ENNReal ENNReal.instCommSemiring))))
                            (@HPow.hPow.{0, 0, 0} ENNReal Real ENNReal
                              (@instHPow.{0, 0} ENNReal Real ENNReal.instPowReal)
                              (↑(ε
                                  (@HAdd.hAdd.{0, 0, 0} Nat Nat Nat (@instHAdd.{0} Nat instAddNat)
                                    (@HAdd.hAdd.{0, 0, 0} Nat Nat Nat (@instHAdd.{0} Nat instAddNat) m j)
                                    (@OfNat.ofNat.{0} Nat (nat_lit 1) (instOfNatNat (nat_lit 1))))))
                              (@Neg.neg.{0} Real Real.instNeg d))
                            (@HPow.hPow.{0, 0, 0} ENNReal Real ENNReal
                              (@instHPow.{0, 0} ENNReal Real ENNReal.instPowReal)
                              (↑(ε (@HAdd.hAdd.{0, 0, 0} Nat Nat Nat (@instHAdd.{0} Nat instAddNat) m j))) q))) :=
⋯
```

## `ProbabilityTheory.lintegral_sup_rpow_edist_le_of_minimal_cover_two`

Command: `#print ProbabilityTheory.lintegral_sup_rpow_edist_le_of_minimal_cover_two`

```lean
theorem ProbabilityTheory.lintegral_sup_rpow_edist_le_of_minimal_cover_two.{u_1, u_2, u_3} : ∀ {T : Type u_1}
  {Ω : Type u_2} {E : Type u_3} [inst : PseudoEMetricSpace.{u_1} T] {mΩ : MeasurableSpace.{u_2} Ω}
  [inst_1 : PseudoEMetricSpace.{u_3} E] {p q : Real} {M : NNReal} {P : @MeasureTheory.Measure.{u_2} Ω mΩ}
  {X : T → Ω → E} {J : Set.{u_1} T} {C : Nat → Finset.{u_1} T} {k m : Nat},
  @LE.le.{0} Real Real.instLE (@OfNat.ofNat.{0} Real (nat_lit 1) (@One.toOfNat1.{0} Real Real.instOne)) p →
    @ProbabilityTheory.IsAEKolmogorovProcess.{u_1, u_2, u_3} T Ω E inst mΩ inst_1 X P p q M →
      ∀ {ε₀ : NNReal},
        @LE.le.{0} ENNReal ENNReal.instLE (↑ε₀) (@Metric.ediam.{u_1} T inst J) →
          (∀ (n : Nat),
              @Metric.IsCover.{u_1} T inst
                (@HMul.hMul.{0, 0, 0} NNReal NNReal NNReal
                  (@instHMul.{0} NNReal
                    (@Distrib.toMul.{0} NNReal (@instDistribOfSemiring.{0} NNReal NNReal.instSemiring)))
                  ε₀
                  (@HPow.hPow.{0, 0, 0} NNReal Nat NNReal
                    (@instHPow.{0, 0} NNReal Nat
                      (@NPow.toPow.{0} NNReal
                        (@Monoid.toNPow.{0} NNReal (@Semiring.toMonoid.{0} NNReal NNReal.instSemiring))))
                    (@Inv.inv.{0} NNReal NNReal.instInv
                      (@OfNat.ofNat.{0} NNReal (nat_lit 2)
                        (@instOfNatAtLeastTwo.{0} NNReal (nat_lit 2)
                          (@AddMonoidWithOne.toNatCast.{0} NNReal
                            (@AddCommMonoidWithOne.toAddMonoidWithOne.{0} NNReal
                              (@NonAssocSemiring.toAddCommMonoidWithOne.{0} NNReal
                                (@Semiring.toNonAssocSemiring.{0} NNReal NNReal.instSemiring))))
                          ⋯)))
                    n))
                J (@SetLike.coe.{u_1, u_1} (Finset.{u_1} T) T (@Finset.instSetLike.{u_1} T) (C n))) →
            (∀ (n : Nat),
                @LE.le.{u_1} (Set.{u_1} T) (@Set.instLE.{u_1} T)
                  (@SetLike.coe.{u_1, u_1} (Finset.{u_1} T) T (@Finset.instSetLike.{u_1} T) (C n)) J) →
              (∀ (n : Nat),
                  @Eq.{1} ENat (@Nat.cast.{0} ENat ENat.instNatCast (@Finset.card.{u_1} T (C n)))
                    (@Metric.coveringNumber.{u_1} T inst
                      (@HMul.hMul.{0, 0, 0} NNReal NNReal NNReal
                        (@instHMul.{0} NNReal
                          (@Distrib.toMul.{0} NNReal (@instDistribOfSemiring.{0} NNReal NNReal.instSemiring)))
                        ε₀
                        (@HPow.hPow.{0, 0, 0} NNReal Nat NNReal
                          (@instHPow.{0, 0} NNReal Nat
                            (@NPow.toPow.{0} NNReal
                              (@Monoid.toNPow.{0} NNReal (@Semiring.toMonoid.{0} NNReal NNReal.instSemiring))))
                          (@Inv.inv.{0} NNReal NNReal.instInv
                            (@OfNat.ofNat.{0} NNReal (nat_lit 2)
                              (@instOfNatAtLeastTwo.{0} NNReal (nat_lit 2)
                                (@AddMonoidWithOne.toNatCast.{0} NNReal
                                  (@AddCommMonoidWithOne.toAddMonoidWithOne.{0} NNReal
                                    (@NonAssocSemiring.toAddCommMonoidWithOne.{0} NNReal
                                      (@Semiring.toNonAssocSemiring.{0} NNReal NNReal.instSemiring))))
                                ⋯)))
                          n))
                      J)) →
                ∀ {c₁ : ENNReal} {d : Real},
                  @LT.lt.{0} Real Real.instLT d q →
                    @HasBoundedCoveringNumber.{u_1} T inst J c₁ d →
                      @LE.le.{0} Nat instLENat m k →
                        @LE.le.{0} ENNReal ENNReal.instLE
                          (@MeasureTheory.lintegral.{u_2} Ω mΩ P fun ω =>
                            ⨆ t,
                              @HPow.hPow.{0, 0, 0} ENNReal Real ENNReal
                                (@instHPow.{0, 0} ENNReal Real ENNReal.instPowReal)
                                (@EDist.edist.{u_3} E
                                  (@WeakPseudoEMetricSpace.toEDist.{u_3} E
                                    (@UniformSpace.toTopologicalSpace.{u_3} E
                                      (@PseudoEMetricSpace.toUniformSpace.{u_3} E inst_1))
                                    (@PseudoEMetricSpace.toWeakPseudoEMetricSpace.{u_3} E inst_1))
                                  (X
                                    (@Subtype.val.{u_1 + 1} T
                                      (fun x =>
                                        @Membership.mem.{u_1, u_1} T (Finset.{u_1} T)
                                          (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} T) T
                                            (@Finset.instSetLike.{u_1} T))
                                          (C k) x)
                                      t)
                                    ω)
                                  (X
                                    (@chainingSequence.{u_1} T inst C
                                      (@Subtype.val.{u_1 + 1} T
                                        (fun x =>
                                          @Membership.mem.{u_1, u_1} T (Finset.{u_1} T)
                                            (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} T) T
                                              (@Finset.instSetLike.{u_1} T))
                                            (C k) x)
                                        t)
                                      k m)
                                    ω))
                                p)
                          (@HDiv.hDiv.{0, 0, 0} ENNReal ENNReal ENNReal
                            (@instHDiv.{0} ENNReal (@DivInvMonoid.toDiv.{0} ENNReal ENNReal.instDivInvMonoid))
                            (@HMul.hMul.{0, 0, 0} ENNReal ENNReal ENNReal
                              (@instHMul.{0} ENNReal
                                (@Distrib.toMul.{0} ENNReal
                                  (@instDistribOfSemiring.{0} ENNReal
                                    (@CommSemiring.toSemiring.{0} ENNReal ENNReal.instCommSemiring))))
                              (@HMul.hMul.{0, 0, 0} ENNReal ENNReal ENNReal
                                (@instHMul.{0} ENNReal
                                  (@Distrib.toMul.{0} ENNReal
                                    (@instDistribOfSemiring.{0} ENNReal
                                      (@CommSemiring.toSemiring.{0} ENNReal ENNReal.instCommSemiring))))
                                (@HMul.hMul.{0, 0, 0} ENNReal ENNReal ENNReal
                                  (@instHMul.{0} ENNReal
                                    (@Distrib.toMul.{0} ENNReal
                                      (@instDistribOfSemiring.{0} ENNReal
                                        (@CommSemiring.toSemiring.{0} ENNReal ENNReal.instCommSemiring))))
                                  (@HPow.hPow.{0, 0, 0} ENNReal Real ENNReal
                                    (@instHPow.{0, 0} ENNReal Real ENNReal.instPowReal)
                                    (@OfNat.ofNat.{0} ENNReal (nat_lit 2)
                                      (@instOfNatAtLeastTwo.{0} ENNReal (nat_lit 2)
                                        (@AddMonoidWithOne.toNatCast.{0} ENNReal
                                          (@AddCommMonoidWithOne.toAddMonoidWithOne.{0} ENNReal
                                            ENNReal.instAddCommMonoidWithOne))
                                        ⋯))
                                    d)
                                  ↑M)
                                c₁)
                              (@HPow.hPow.{0, 0, 0} ENNReal Real ENNReal
                                (@instHPow.{0, 0} ENNReal Real ENNReal.instPowReal)
                                (@HMul.hMul.{0, 0, 0} ENNReal ENNReal ENNReal
                                  (@instHMul.{0} ENNReal
                                    (@Distrib.toMul.{0} ENNReal
                                      (@instDistribOfSemiring.{0} ENNReal
                                        (@CommSemiring.toSemiring.{0} ENNReal ENNReal.instCommSemiring))))
                                  (@HMul.hMul.{0, 0, 0} ENNReal ENNReal ENNReal
                                    (@instHMul.{0} ENNReal
                                      (@Distrib.toMul.{0} ENNReal
                                        (@instDistribOfSemiring.{0} ENNReal
                                          (@CommSemiring.toSemiring.{0} ENNReal ENNReal.instCommSemiring))))
                                    (@OfNat.ofNat.{0} ENNReal (nat_lit 2)
                                      (@instOfNatAtLeastTwo.{0} ENNReal (nat_lit 2)
                                        (@AddMonoidWithOne.toNatCast.{0} ENNReal
                                          (@AddCommMonoidWithOne.toAddMonoidWithOne.{0} ENNReal
                                            ENNReal.instAddCommMonoidWithOne))
                                        ⋯))
                                    ↑ε₀)
                                  (@HPow.hPow.{0, 0, 0} ENNReal Nat ENNReal
                                    (@instHPow.{0, 0} ENNReal Nat
                                      (@NPow.toPow.{0} ENNReal
                                        (@Monoid.toNPow.{0} ENNReal
                                          (@Semiring.toMonoid.{0} ENNReal
                                            (@CommSemiring.toSemiring.{0} ENNReal ENNReal.instCommSemiring)))))
                                    (@Inv.inv.{0} ENNReal ENNReal.instInv
                                      (@OfNat.ofNat.{0} ENNReal (nat_lit 2)
                                        (@instOfNatAtLeastTwo.{0} ENNReal (nat_lit 2)
                                          (@AddMonoidWithOne.toNatCast.{0} ENNReal
                                            (@AddCommMonoidWithOne.toAddMonoidWithOne.{0} ENNReal
                                              ENNReal.instAddCommMonoidWithOne))
                                          ⋯)))
                                    m))
                                (@HSub.hSub.{0, 0, 0} Real Real Real (@instHSub.{0} Real Real.instSub) q d)))
                            (@HPow.hPow.{0, 0, 0} ENNReal Real ENNReal
                              (@instHPow.{0, 0} ENNReal Real ENNReal.instPowReal)
                              (@HSub.hSub.{0, 0, 0} ENNReal ENNReal ENNReal (@instHSub.{0} ENNReal ENNReal.instSub)
                                (@HPow.hPow.{0, 0, 0} ENNReal Real ENNReal
                                  (@instHPow.{0, 0} ENNReal Real ENNReal.instPowReal)
                                  (@OfNat.ofNat.{0} ENNReal (nat_lit 2)
                                    (@instOfNatAtLeastTwo.{0} ENNReal (nat_lit 2)
                                      (@AddMonoidWithOne.toNatCast.{0} ENNReal
                                        (@AddCommMonoidWithOne.toAddMonoidWithOne.{0} ENNReal
                                          ENNReal.instAddCommMonoidWithOne))
                                      ⋯))
                                  (@HDiv.hDiv.{0, 0, 0} Real Real Real
                                    (@instHDiv.{0} Real (@DivInvMonoid.toDiv.{0} Real Real.instDivInvMonoid))
                                    (@HSub.hSub.{0, 0, 0} Real Real Real (@instHSub.{0} Real Real.instSub) q d) p))
                                (@OfNat.ofNat.{0} ENNReal (nat_lit 1) (@One.toOfNat1.{0} ENNReal ENNReal.instOne)))
                              p)) :=
⋯
```

## `ProbabilityTheory.lintegral_sup_rpow_edist_le_of_minimal_cover_two_of_le_one`

Command: `#print ProbabilityTheory.lintegral_sup_rpow_edist_le_of_minimal_cover_two_of_le_one`

```lean
theorem ProbabilityTheory.lintegral_sup_rpow_edist_le_of_minimal_cover_two_of_le_one.{u_1, u_2, u_3} : ∀ {T : Type u_1}
  {Ω : Type u_2} {E : Type u_3} [inst : PseudoEMetricSpace.{u_1} T] {mΩ : MeasurableSpace.{u_2} Ω}
  [inst_1 : PseudoEMetricSpace.{u_3} E] {p q : Real} {M : NNReal} {P : @MeasureTheory.Measure.{u_2} Ω mΩ}
  {X : T → Ω → E} {J : Set.{u_1} T} {C : Nat → Finset.{u_1} T} {k m : Nat},
  @LE.le.{0} Real Real.instLE p (@OfNat.ofNat.{0} Real (nat_lit 1) (@One.toOfNat1.{0} Real Real.instOne)) →
    @ProbabilityTheory.IsAEKolmogorovProcess.{u_1, u_2, u_3} T Ω E inst mΩ inst_1 X P p q M →
      ∀ {ε₀ : NNReal},
        @LE.le.{0} ENNReal ENNReal.instLE (↑ε₀) (@Metric.ediam.{u_1} T inst J) →
          (∀ (n : Nat),
              @Metric.IsCover.{u_1} T inst
                (@HMul.hMul.{0, 0, 0} NNReal NNReal NNReal
                  (@instHMul.{0} NNReal
                    (@Distrib.toMul.{0} NNReal (@instDistribOfSemiring.{0} NNReal NNReal.instSemiring)))
                  ε₀
                  (@HPow.hPow.{0, 0, 0} NNReal Nat NNReal
                    (@instHPow.{0, 0} NNReal Nat
                      (@NPow.toPow.{0} NNReal
                        (@Monoid.toNPow.{0} NNReal (@Semiring.toMonoid.{0} NNReal NNReal.instSemiring))))
                    (@Inv.inv.{0} NNReal NNReal.instInv
                      (@OfNat.ofNat.{0} NNReal (nat_lit 2)
                        (@instOfNatAtLeastTwo.{0} NNReal (nat_lit 2)
                          (@AddMonoidWithOne.toNatCast.{0} NNReal
                            (@AddCommMonoidWithOne.toAddMonoidWithOne.{0} NNReal
                              (@NonAssocSemiring.toAddCommMonoidWithOne.{0} NNReal
                                (@Semiring.toNonAssocSemiring.{0} NNReal NNReal.instSemiring))))
                          ⋯)))
                    n))
                J (@SetLike.coe.{u_1, u_1} (Finset.{u_1} T) T (@Finset.instSetLike.{u_1} T) (C n))) →
            (∀ (n : Nat),
                @LE.le.{u_1} (Set.{u_1} T) (@Set.instLE.{u_1} T)
                  (@SetLike.coe.{u_1, u_1} (Finset.{u_1} T) T (@Finset.instSetLike.{u_1} T) (C n)) J) →
              (∀ (n : Nat),
                  @Eq.{1} ENat (@Nat.cast.{0} ENat ENat.instNatCast (@Finset.card.{u_1} T (C n)))
                    (@Metric.coveringNumber.{u_1} T inst
                      (@HMul.hMul.{0, 0, 0} NNReal NNReal NNReal
                        (@instHMul.{0} NNReal
                          (@Distrib.toMul.{0} NNReal (@instDistribOfSemiring.{0} NNReal NNReal.instSemiring)))
                        ε₀
                        (@HPow.hPow.{0, 0, 0} NNReal Nat NNReal
                          (@instHPow.{0, 0} NNReal Nat
                            (@NPow.toPow.{0} NNReal
                              (@Monoid.toNPow.{0} NNReal (@Semiring.toMonoid.{0} NNReal NNReal.instSemiring))))
                          (@Inv.inv.{0} NNReal NNReal.instInv
                            (@OfNat.ofNat.{0} NNReal (nat_lit 2)
                              (@instOfNatAtLeastTwo.{0} NNReal (nat_lit 2)
                                (@AddMonoidWithOne.toNatCast.{0} NNReal
                                  (@AddCommMonoidWithOne.toAddMonoidWithOne.{0} NNReal
                                    (@NonAssocSemiring.toAddCommMonoidWithOne.{0} NNReal
                                      (@Semiring.toNonAssocSemiring.{0} NNReal NNReal.instSemiring))))
                                ⋯)))
                          n))
                      J)) →
                ∀ {c₁ : ENNReal} {d : Real},
                  @LT.lt.{0} Real Real.instLT d q →
                    @HasBoundedCoveringNumber.{u_1} T inst J c₁ d →
                      @LE.le.{0} Nat instLENat m k →
                        @LE.le.{0} ENNReal ENNReal.instLE
                          (@MeasureTheory.lintegral.{u_2} Ω mΩ P fun ω =>
                            ⨆ t,
                              @HPow.hPow.{0, 0, 0} ENNReal Real ENNReal
                                (@instHPow.{0, 0} ENNReal Real ENNReal.instPowReal)
                                (@EDist.edist.{u_3} E
                                  (@WeakPseudoEMetricSpace.toEDist.{u_3} E
                                    (@UniformSpace.toTopologicalSpace.{u_3} E
                                      (@PseudoEMetricSpace.toUniformSpace.{u_3} E inst_1))
                                    (@PseudoEMetricSpace.toWeakPseudoEMetricSpace.{u_3} E inst_1))
                                  (X
                                    (@Subtype.val.{u_1 + 1} T
                                      (fun x =>
                                        @Membership.mem.{u_1, u_1} T (Finset.{u_1} T)
                                          (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} T) T
                                            (@Finset.instSetLike.{u_1} T))
                                          (C k) x)
                                      t)
                                    ω)
                                  (X
                                    (@chainingSequence.{u_1} T inst C
                                      (@Subtype.val.{u_1 + 1} T
                                        (fun x =>
                                          @Membership.mem.{u_1, u_1} T (Finset.{u_1} T)
                                            (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} T) T
                                              (@Finset.instSetLike.{u_1} T))
                                            (C k) x)
                                        t)
                                      k m)
                                    ω))
                                p)
                          (@HDiv.hDiv.{0, 0, 0} ENNReal ENNReal ENNReal
                            (@instHDiv.{0} ENNReal (@DivInvMonoid.toDiv.{0} ENNReal ENNReal.instDivInvMonoid))
                            (@HMul.hMul.{0, 0, 0} ENNReal ENNReal ENNReal
                              (@instHMul.{0} ENNReal
                                (@Distrib.toMul.{0} ENNReal
                                  (@instDistribOfSemiring.{0} ENNReal
                                    (@CommSemiring.toSemiring.{0} ENNReal ENNReal.instCommSemiring))))
                              (@HMul.hMul.{0, 0, 0} ENNReal ENNReal ENNReal
                                (@instHMul.{0} ENNReal
                                  (@Distrib.toMul.{0} ENNReal
                                    (@instDistribOfSemiring.{0} ENNReal
                                      (@CommSemiring.toSemiring.{0} ENNReal ENNReal.instCommSemiring))))
                                (@HMul.hMul.{0, 0, 0} ENNReal ENNReal ENNReal
                                  (@instHMul.{0} ENNReal
                                    (@Distrib.toMul.{0} ENNReal
                                      (@instDistribOfSemiring.{0} ENNReal
                                        (@CommSemiring.toSemiring.{0} ENNReal ENNReal.instCommSemiring))))
                                  (@HPow.hPow.{0, 0, 0} ENNReal Real ENNReal
                                    (@instHPow.{0, 0} ENNReal Real ENNReal.instPowReal)
                                    (@OfNat.ofNat.{0} ENNReal (nat_lit 2)
                                      (@instOfNatAtLeastTwo.{0} ENNReal (nat_lit 2)
                                        (@AddMonoidWithOne.toNatCast.{0} ENNReal
                                          (@AddCommMonoidWithOne.toAddMonoidWithOne.{0} ENNReal
                                            ENNReal.instAddCommMonoidWithOne))
                                        ⋯))
                                    d)
                                  ↑M)
                                c₁)
                              (@HPow.hPow.{0, 0, 0} ENNReal Real ENNReal
                                (@instHPow.{0, 0} ENNReal Real ENNReal.instPowReal)
                                (@HMul.hMul.{0, 0, 0} ENNReal ENNReal ENNReal
                                  (@instHMul.{0} ENNReal
                                    (@Distrib.toMul.{0} ENNReal
                                      (@instDistribOfSemiring.{0} ENNReal
                                        (@CommSemiring.toSemiring.{0} ENNReal ENNReal.instCommSemiring))))
                                  (@HMul.hMul.{0, 0, 0} ENNReal ENNReal ENNReal
                                    (@instHMul.{0} ENNReal
                                      (@Distrib.toMul.{0} ENNReal
                                        (@instDistribOfSemiring.{0} ENNReal
                                          (@CommSemiring.toSemiring.{0} ENNReal ENNReal.instCommSemiring))))
                                    (@OfNat.ofNat.{0} ENNReal (nat_lit 2)
                                      (@instOfNatAtLeastTwo.{0} ENNReal (nat_lit 2)
                                        (@AddMonoidWithOne.toNatCast.{0} ENNReal
                                          (@AddCommMonoidWithOne.toAddMonoidWithOne.{0} ENNReal
                                            ENNReal.instAddCommMonoidWithOne))
                                        ⋯))
                                    ↑ε₀)
                                  (@HPow.hPow.{0, 0, 0} ENNReal Nat ENNReal
                                    (@instHPow.{0, 0} ENNReal Nat
                                      (@NPow.toPow.{0} ENNReal
                                        (@Monoid.toNPow.{0} ENNReal
                                          (@Semiring.toMonoid.{0} ENNReal
                                            (@CommSemiring.toSemiring.{0} ENNReal ENNReal.instCommSemiring)))))
                                    (@Inv.inv.{0} ENNReal ENNReal.instInv
                                      (@OfNat.ofNat.{0} ENNReal (nat_lit 2)
                                        (@instOfNatAtLeastTwo.{0} ENNReal (nat_lit 2)
                                          (@AddMonoidWithOne.toNatCast.{0} ENNReal
                                            (@AddCommMonoidWithOne.toAddMonoidWithOne.{0} ENNReal
                                              ENNReal.instAddCommMonoidWithOne))
                                          ⋯)))
                                    m))
                                (@HSub.hSub.{0, 0, 0} Real Real Real (@instHSub.{0} Real Real.instSub) q d)))
                            (@HSub.hSub.{0, 0, 0} ENNReal ENNReal ENNReal (@instHSub.{0} ENNReal ENNReal.instSub)
                              (@HPow.hPow.{0, 0, 0} ENNReal Real ENNReal
                                (@instHPow.{0, 0} ENNReal Real ENNReal.instPowReal)
                                (@OfNat.ofNat.{0} ENNReal (nat_lit 2)
                                  (@instOfNatAtLeastTwo.{0} ENNReal (nat_lit 2)
                                    (@AddMonoidWithOne.toNatCast.{0} ENNReal
                                      (@AddCommMonoidWithOne.toAddMonoidWithOne.{0} ENNReal
                                        ENNReal.instAddCommMonoidWithOne))
                                    ⋯))
                                (@HSub.hSub.{0, 0, 0} Real Real Real (@instHSub.{0} Real Real.instSub) q d))
                              (@OfNat.ofNat.{0} ENNReal (nat_lit 1) (@One.toOfNat1.{0} ENNReal ENNReal.instOne)))) :=
⋯
```

## `ProbabilityTheory.lintegral_sup_rpow_edist_le_sum`

Command: `#print ProbabilityTheory.lintegral_sup_rpow_edist_le_sum`

```lean
theorem ProbabilityTheory.lintegral_sup_rpow_edist_le_sum.{u_1, u_2, u_3} : ∀ {T : Type u_1} {Ω : Type u_2}
  {E : Type u_3} [inst : PseudoEMetricSpace.{u_1} T] {mΩ : MeasurableSpace.{u_2} Ω}
  [inst_1 : PseudoEMetricSpace.{u_3} E] {p q : Real} {M : NNReal} {P : @MeasureTheory.Measure.{u_2} Ω mΩ}
  {X : T → Ω → E} {J : Set.{u_1} T} {C : Nat → Finset.{u_1} T} {ε : Nat → NNReal} {k m : Nat},
  @LE.le.{0} Real Real.instLE (@OfNat.ofNat.{0} Real (nat_lit 1) (@One.toOfNat1.{0} Real Real.instOne)) p →
    @ProbabilityTheory.IsAEKolmogorovProcess.{u_1, u_2, u_3} T Ω E inst mΩ inst_1 X P p q M →
      (∀ (n : Nat),
          @Metric.IsCover.{u_1} T inst (ε n) J
            (@SetLike.coe.{u_1, u_1} (Finset.{u_1} T) T (@Finset.instSetLike.{u_1} T) (C n))) →
        (∀ (n : Nat),
            @LE.le.{u_1} (Set.{u_1} T) (@Set.instLE.{u_1} T)
              (@SetLike.coe.{u_1, u_1} (Finset.{u_1} T) T (@Finset.instSetLike.{u_1} T) (C n)) J) →
          @LE.le.{0} Nat instLENat m k →
            @LE.le.{0} ENNReal ENNReal.instLE
              (@MeasureTheory.lintegral.{u_2} Ω mΩ P fun ω =>
                ⨆ t,
                  @HPow.hPow.{0, 0, 0} ENNReal Real ENNReal (@instHPow.{0, 0} ENNReal Real ENNReal.instPowReal)
                    (@EDist.edist.{u_3} E
                      (@WeakPseudoEMetricSpace.toEDist.{u_3} E
                        (@UniformSpace.toTopologicalSpace.{u_3} E (@PseudoEMetricSpace.toUniformSpace.{u_3} E inst_1))
                        (@PseudoEMetricSpace.toWeakPseudoEMetricSpace.{u_3} E inst_1))
                      (X
                        (@Subtype.val.{u_1 + 1} T
                          (fun x =>
                            @Membership.mem.{u_1, u_1} T (Finset.{u_1} T)
                              (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} T) T (@Finset.instSetLike.{u_1} T))
                              (C k) x)
                          t)
                        ω)
                      (X
                        (@chainingSequence.{u_1} T inst C
                          (@Subtype.val.{u_1 + 1} T
                            (fun x =>
                              @Membership.mem.{u_1, u_1} T (Finset.{u_1} T)
                                (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} T) T (@Finset.instSetLike.{u_1} T))
                                (C k) x)
                            t)
                          k m)
                        ω))
                    p)
              (@HMul.hMul.{0, 0, 0} ENNReal ENNReal ENNReal
                (@instHMul.{0} ENNReal
                  (@Distrib.toMul.{0} ENNReal
                    (@instDistribOfSemiring.{0} ENNReal
                      (@CommSemiring.toSemiring.{0} ENNReal ENNReal.instCommSemiring))))
                (↑M)
                (@HPow.hPow.{0, 0, 0} ENNReal Real ENNReal (@instHPow.{0, 0} ENNReal Real ENNReal.instPowReal)
                  (∑ i ∈ Finset.range (@HSub.hSub.{0, 0, 0} Nat Nat Nat (@instHSub.{0} Nat instSubNat) k m),
                    @HMul.hMul.{0, 0, 0} ENNReal ENNReal ENNReal
                      (@instHMul.{0} ENNReal
                        (@Distrib.toMul.{0} ENNReal
                          (@instDistribOfSemiring.{0} ENNReal
                            (@CommSemiring.toSemiring.{0} ENNReal ENNReal.instCommSemiring))))
                      (@HPow.hPow.{0, 0, 0} ENNReal Real ENNReal (@instHPow.{0, 0} ENNReal Real ENNReal.instPowReal)
                        (@Nat.cast.{0} ENNReal
                          (@AddMonoidWithOne.toNatCast.{0} ENNReal
                            (@AddCommMonoidWithOne.toAddMonoidWithOne.{0} ENNReal ENNReal.instAddCommMonoidWithOne))
                          (@Finset.card.{u_1} T
                            (C
                              (@HAdd.hAdd.{0, 0, 0} Nat Nat Nat (@instHAdd.{0} Nat instAddNat)
                                (@HAdd.hAdd.{0, 0, 0} Nat Nat Nat (@instHAdd.{0} Nat instAddNat) m i)
                                (@OfNat.ofNat.{0} Nat (nat_lit 1) (instOfNatNat (nat_lit 1)))))))
                        (@HDiv.hDiv.{0, 0, 0} Real Real Real
                          (@instHDiv.{0} Real (@DivInvMonoid.toDiv.{0} Real Real.instDivInvMonoid))
                          (@OfNat.ofNat.{0} Real (nat_lit 1) (@One.toOfNat1.{0} Real Real.instOne)) p))
                      (@HPow.hPow.{0, 0, 0} ENNReal Real ENNReal (@instHPow.{0, 0} ENNReal Real ENNReal.instPowReal)
                        (↑(ε (@HAdd.hAdd.{0, 0, 0} Nat Nat Nat (@instHAdd.{0} Nat instAddNat) m i)))
                        (@HDiv.hDiv.{0, 0, 0} Real Real Real
                          (@instHDiv.{0} Real (@DivInvMonoid.toDiv.{0} Real Real.instDivInvMonoid)) q p)))
                  p)) :=
⋯
```

## `ProbabilityTheory.lintegral_sup_rpow_edist_le_sum_of_le_one`

Command: `#print ProbabilityTheory.lintegral_sup_rpow_edist_le_sum_of_le_one`

```lean
theorem ProbabilityTheory.lintegral_sup_rpow_edist_le_sum_of_le_one.{u_1, u_2, u_3} : ∀ {T : Type u_1} {Ω : Type u_2}
  {E : Type u_3} [inst : PseudoEMetricSpace.{u_1} T] {mΩ : MeasurableSpace.{u_2} Ω}
  [inst_1 : PseudoEMetricSpace.{u_3} E] {p q : Real} {M : NNReal} {P : @MeasureTheory.Measure.{u_2} Ω mΩ}
  {X : T → Ω → E} {J : Set.{u_1} T} {C : Nat → Finset.{u_1} T} {ε : Nat → NNReal} {k m : Nat},
  @LE.le.{0} Real Real.instLE p (@OfNat.ofNat.{0} Real (nat_lit 1) (@One.toOfNat1.{0} Real Real.instOne)) →
    @ProbabilityTheory.IsAEKolmogorovProcess.{u_1, u_2, u_3} T Ω E inst mΩ inst_1 X P p q M →
      (∀ (n : Nat),
          @Metric.IsCover.{u_1} T inst (ε n) J
            (@SetLike.coe.{u_1, u_1} (Finset.{u_1} T) T (@Finset.instSetLike.{u_1} T) (C n))) →
        (∀ (n : Nat),
            @LE.le.{u_1} (Set.{u_1} T) (@Set.instLE.{u_1} T)
              (@SetLike.coe.{u_1, u_1} (Finset.{u_1} T) T (@Finset.instSetLike.{u_1} T) (C n)) J) →
          @LE.le.{0} Nat instLENat m k →
            @LE.le.{0} ENNReal ENNReal.instLE
              (@MeasureTheory.lintegral.{u_2} Ω mΩ P fun ω =>
                ⨆ t,
                  @HPow.hPow.{0, 0, 0} ENNReal Real ENNReal (@instHPow.{0, 0} ENNReal Real ENNReal.instPowReal)
                    (@EDist.edist.{u_3} E
                      (@WeakPseudoEMetricSpace.toEDist.{u_3} E
                        (@UniformSpace.toTopologicalSpace.{u_3} E (@PseudoEMetricSpace.toUniformSpace.{u_3} E inst_1))
                        (@PseudoEMetricSpace.toWeakPseudoEMetricSpace.{u_3} E inst_1))
                      (X
                        (@Subtype.val.{u_1 + 1} T
                          (fun x =>
                            @Membership.mem.{u_1, u_1} T (Finset.{u_1} T)
                              (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} T) T (@Finset.instSetLike.{u_1} T))
                              (C k) x)
                          t)
                        ω)
                      (X
                        (@chainingSequence.{u_1} T inst C
                          (@Subtype.val.{u_1 + 1} T
                            (fun x =>
                              @Membership.mem.{u_1, u_1} T (Finset.{u_1} T)
                                (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} T) T (@Finset.instSetLike.{u_1} T))
                                (C k) x)
                            t)
                          k m)
                        ω))
                    p)
              (@HMul.hMul.{0, 0, 0} ENNReal ENNReal ENNReal
                (@instHMul.{0} ENNReal
                  (@Distrib.toMul.{0} ENNReal
                    (@instDistribOfSemiring.{0} ENNReal
                      (@CommSemiring.toSemiring.{0} ENNReal ENNReal.instCommSemiring))))
                (↑M)
                (∑ i ∈ Finset.range (@HSub.hSub.{0, 0, 0} Nat Nat Nat (@instHSub.{0} Nat instSubNat) k m),
                  @HMul.hMul.{0, 0, 0} ENNReal ENNReal ENNReal
                    (@instHMul.{0} ENNReal
                      (@Distrib.toMul.{0} ENNReal
                        (@instDistribOfSemiring.{0} ENNReal
                          (@CommSemiring.toSemiring.{0} ENNReal ENNReal.instCommSemiring))))
                    (@Nat.cast.{0} ENNReal
                      (@AddMonoidWithOne.toNatCast.{0} ENNReal
                        (@AddCommMonoidWithOne.toAddMonoidWithOne.{0} ENNReal ENNReal.instAddCommMonoidWithOne))
                      (@Finset.card.{u_1} T
                        (C
                          (@HAdd.hAdd.{0, 0, 0} Nat Nat Nat (@instHAdd.{0} Nat instAddNat)
                            (@HAdd.hAdd.{0, 0, 0} Nat Nat Nat (@instHAdd.{0} Nat instAddNat) m i)
                            (@OfNat.ofNat.{0} Nat (nat_lit 1) (instOfNatNat (nat_lit 1)))))))
                    (@HPow.hPow.{0, 0, 0} ENNReal Real ENNReal (@instHPow.{0, 0} ENNReal Real ENNReal.instPowReal)
                      (↑(ε (@HAdd.hAdd.{0, 0, 0} Nat Nat Nat (@instHAdd.{0} Nat instAddNat) m i))) q))) :=
⋯
```

## `ProbabilityTheory.lintegral_sup_rpow_edist_le_sum_rpow`

Command: `#print ProbabilityTheory.lintegral_sup_rpow_edist_le_sum_rpow`

```lean
theorem ProbabilityTheory.lintegral_sup_rpow_edist_le_sum_rpow.{u_1, u_2, u_3} : ∀ {T : Type u_1} {Ω : Type u_2}
  {E : Type u_3} [inst : PseudoEMetricSpace.{u_1} T] {mΩ : MeasurableSpace.{u_2} Ω}
  [inst_1 : PseudoEMetricSpace.{u_3} E] {p q : Real} {M : NNReal} {P : @MeasureTheory.Measure.{u_2} Ω mΩ}
  {X : T → Ω → E} {C : Nat → Finset.{u_1} T} {k m : Nat},
  @LE.le.{0} Real Real.instLE (@OfNat.ofNat.{0} Real (nat_lit 1) (@One.toOfNat1.{0} Real Real.instOne)) p →
    @ProbabilityTheory.IsAEKolmogorovProcess.{u_1, u_2, u_3} T Ω E inst mΩ inst_1 X P p q M →
      @LE.le.{0} Nat instLENat m k →
        @LE.le.{0} ENNReal ENNReal.instLE
          (@MeasureTheory.lintegral.{u_2} Ω mΩ P fun ω =>
            ⨆ t,
              @HPow.hPow.{0, 0, 0} ENNReal Real ENNReal (@instHPow.{0, 0} ENNReal Real ENNReal.instPowReal)
                (@EDist.edist.{u_3} E
                  (@WeakPseudoEMetricSpace.toEDist.{u_3} E
                    (@UniformSpace.toTopologicalSpace.{u_3} E (@PseudoEMetricSpace.toUniformSpace.{u_3} E inst_1))
                    (@PseudoEMetricSpace.toWeakPseudoEMetricSpace.{u_3} E inst_1))
                  (X
                    (@Subtype.val.{u_1 + 1} T
                      (fun x =>
                        @Membership.mem.{u_1, u_1} T (Finset.{u_1} T)
                          (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} T) T (@Finset.instSetLike.{u_1} T)) (C k) x)
                      t)
                    ω)
                  (X
                    (@chainingSequence.{u_1} T inst C
                      (@Subtype.val.{u_1 + 1} T
                        (fun x =>
                          @Membership.mem.{u_1, u_1} T (Finset.{u_1} T)
                            (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} T) T (@Finset.instSetLike.{u_1} T)) (C k)
                            x)
                        t)
                      k m)
                    ω))
                p)
          (@HPow.hPow.{0, 0, 0} ENNReal Real ENNReal (@instHPow.{0, 0} ENNReal Real ENNReal.instPowReal)
            (∑ i ∈ Finset.range (@HSub.hSub.{0, 0, 0} Nat Nat Nat (@instHSub.{0} Nat instSubNat) k m),
              @HPow.hPow.{0, 0, 0} ENNReal Real ENNReal (@instHPow.{0, 0} ENNReal Real ENNReal.instPowReal)
                (@MeasureTheory.lintegral.{u_2} Ω mΩ P fun ω =>
                  ⨆ t,
                    @HPow.hPow.{0, 0, 0} ENNReal Real ENNReal (@instHPow.{0, 0} ENNReal Real ENNReal.instPowReal)
                      (@EDist.edist.{u_3} E
                        (@WeakPseudoEMetricSpace.toEDist.{u_3} E
                          (@UniformSpace.toTopologicalSpace.{u_3} E (@PseudoEMetricSpace.toUniformSpace.{u_3} E inst_1))
                          (@PseudoEMetricSpace.toWeakPseudoEMetricSpace.{u_3} E inst_1))
                        (X
                          (@chainingSequence.{u_1} T inst C
                            (@Subtype.val.{u_1 + 1} T
                              (fun x =>
                                @Membership.mem.{u_1, u_1} T (Finset.{u_1} T)
                                  (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} T) T (@Finset.instSetLike.{u_1} T))
                                  (C k) x)
                              t)
                            k (@HAdd.hAdd.{0, 0, 0} Nat Nat Nat (@instHAdd.{0} Nat instAddNat) m i))
                          ω)
                        (X
                          (@chainingSequence.{u_1} T inst C
                            (@Subtype.val.{u_1 + 1} T
                              (fun x =>
                                @Membership.mem.{u_1, u_1} T (Finset.{u_1} T)
                                  (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} T) T (@Finset.instSetLike.{u_1} T))
                                  (C k) x)
                              t)
                            k
                            (@HAdd.hAdd.{0, 0, 0} Nat Nat Nat (@instHAdd.{0} Nat instAddNat)
                              (@HAdd.hAdd.{0, 0, 0} Nat Nat Nat (@instHAdd.{0} Nat instAddNat) m i)
                              (@OfNat.ofNat.{0} Nat (nat_lit 1) (instOfNatNat (nat_lit 1)))))
                          ω))
                      p)
                (@HDiv.hDiv.{0, 0, 0} Real Real Real
                  (@instHDiv.{0} Real (@DivInvMonoid.toDiv.{0} Real Real.instDivInvMonoid))
                  (@OfNat.ofNat.{0} Real (nat_lit 1) (@One.toOfNat1.{0} Real Real.instOne)) p))
            p) :=
⋯
```

## `ProbabilityTheory.lintegral_sup_rpow_edist_le_sum_rpow_of_le_one`

Command: `#print ProbabilityTheory.lintegral_sup_rpow_edist_le_sum_rpow_of_le_one`

```lean
theorem ProbabilityTheory.lintegral_sup_rpow_edist_le_sum_rpow_of_le_one.{u_1, u_2, u_3} : ∀ {T : Type u_1}
  {Ω : Type u_2} {E : Type u_3} [inst : PseudoEMetricSpace.{u_1} T] {mΩ : MeasurableSpace.{u_2} Ω}
  [inst_1 : PseudoEMetricSpace.{u_3} E] {p q : Real} {M : NNReal} {P : @MeasureTheory.Measure.{u_2} Ω mΩ}
  {X : T → Ω → E} {C : Nat → Finset.{u_1} T} {k m : Nat},
  @LE.le.{0} Real Real.instLE p (@OfNat.ofNat.{0} Real (nat_lit 1) (@One.toOfNat1.{0} Real Real.instOne)) →
    @ProbabilityTheory.IsAEKolmogorovProcess.{u_1, u_2, u_3} T Ω E inst mΩ inst_1 X P p q M →
      @LE.le.{0} Nat instLENat m k →
        @LE.le.{0} ENNReal ENNReal.instLE
          (@MeasureTheory.lintegral.{u_2} Ω mΩ P fun ω =>
            ⨆ t,
              @HPow.hPow.{0, 0, 0} ENNReal Real ENNReal (@instHPow.{0, 0} ENNReal Real ENNReal.instPowReal)
                (@EDist.edist.{u_3} E
                  (@WeakPseudoEMetricSpace.toEDist.{u_3} E
                    (@UniformSpace.toTopologicalSpace.{u_3} E (@PseudoEMetricSpace.toUniformSpace.{u_3} E inst_1))
                    (@PseudoEMetricSpace.toWeakPseudoEMetricSpace.{u_3} E inst_1))
                  (X
                    (@Subtype.val.{u_1 + 1} T
                      (fun x =>
                        @Membership.mem.{u_1, u_1} T (Finset.{u_1} T)
                          (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} T) T (@Finset.instSetLike.{u_1} T)) (C k) x)
                      t)
                    ω)
                  (X
                    (@chainingSequence.{u_1} T inst C
                      (@Subtype.val.{u_1 + 1} T
                        (fun x =>
                          @Membership.mem.{u_1, u_1} T (Finset.{u_1} T)
                            (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} T) T (@Finset.instSetLike.{u_1} T)) (C k)
                            x)
                        t)
                      k m)
                    ω))
                p)
          (∑ i ∈ Finset.range (@HSub.hSub.{0, 0, 0} Nat Nat Nat (@instHSub.{0} Nat instSubNat) k m),
            @MeasureTheory.lintegral.{u_2} Ω mΩ P fun ω =>
              ⨆ t,
                @HPow.hPow.{0, 0, 0} ENNReal Real ENNReal (@instHPow.{0, 0} ENNReal Real ENNReal.instPowReal)
                  (@EDist.edist.{u_3} E
                    (@WeakPseudoEMetricSpace.toEDist.{u_3} E
                      (@UniformSpace.toTopologicalSpace.{u_3} E (@PseudoEMetricSpace.toUniformSpace.{u_3} E inst_1))
                      (@PseudoEMetricSpace.toWeakPseudoEMetricSpace.{u_3} E inst_1))
                    (X
                      (@chainingSequence.{u_1} T inst C
                        (@Subtype.val.{u_1 + 1} T
                          (fun x =>
                            @Membership.mem.{u_1, u_1} T (Finset.{u_1} T)
                              (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} T) T (@Finset.instSetLike.{u_1} T))
                              (C k) x)
                          t)
                        k (@HAdd.hAdd.{0, 0, 0} Nat Nat Nat (@instHAdd.{0} Nat instAddNat) m i))
                      ω)
                    (X
                      (@chainingSequence.{u_1} T inst C
                        (@Subtype.val.{u_1 + 1} T
                          (fun x =>
                            @Membership.mem.{u_1, u_1} T (Finset.{u_1} T)
                              (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} T) T (@Finset.instSetLike.{u_1} T))
                              (C k) x)
                          t)
                        k
                        (@HAdd.hAdd.{0, 0, 0} Nat Nat Nat (@instHAdd.{0} Nat instAddNat)
                          (@HAdd.hAdd.{0, 0, 0} Nat Nat Nat (@instHAdd.{0} Nat instAddNat) m i)
                          (@OfNat.ofNat.{0} Nat (nat_lit 1) (instOfNatNat (nat_lit 1)))))
                      ω))
                  p) :=
⋯
```

## `ProbabilityTheory.lintegral_sup_rpow_edist_succ`

Command: `#print ProbabilityTheory.lintegral_sup_rpow_edist_succ`

```lean
theorem ProbabilityTheory.lintegral_sup_rpow_edist_succ.{u_1, u_2, u_3} : ∀ {T : Type u_1} {Ω : Type u_2} {E : Type u_3}
  [inst : PseudoEMetricSpace.{u_1} T] {mΩ : MeasurableSpace.{u_2} Ω} [inst_1 : PseudoEMetricSpace.{u_3} E] {p q : Real}
  {M : NNReal} {P : @MeasureTheory.Measure.{u_2} Ω mΩ} {X : T → Ω → E} {J : Set.{u_1} T} {C : Nat → Finset.{u_1} T}
  {ε : Nat → NNReal} {j k : Nat},
  @ProbabilityTheory.IsAEKolmogorovProcess.{u_1, u_2, u_3} T Ω E inst mΩ inst_1 X P p q M →
    (∀ (n : Nat),
        @Metric.IsCover.{u_1} T inst (ε n) J
          (@SetLike.coe.{u_1, u_1} (Finset.{u_1} T) T (@Finset.instSetLike.{u_1} T) (C n))) →
      (∀ (n : Nat),
          @LE.le.{u_1} (Set.{u_1} T) (@Set.instLE.{u_1} T)
            (@SetLike.coe.{u_1, u_1} (Finset.{u_1} T) T (@Finset.instSetLike.{u_1} T) (C n)) J) →
        @LT.lt.{0} Nat instLTNat j k →
          @LE.le.{0} ENNReal ENNReal.instLE
            (@MeasureTheory.lintegral.{u_2} Ω mΩ P fun ω =>
              ⨆ t,
                @HPow.hPow.{0, 0, 0} ENNReal Real ENNReal (@instHPow.{0, 0} ENNReal Real ENNReal.instPowReal)
                  (@EDist.edist.{u_3} E
                    (@WeakPseudoEMetricSpace.toEDist.{u_3} E
                      (@UniformSpace.toTopologicalSpace.{u_3} E (@PseudoEMetricSpace.toUniformSpace.{u_3} E inst_1))
                      (@PseudoEMetricSpace.toWeakPseudoEMetricSpace.{u_3} E inst_1))
                    (X
                      (@chainingSequence.{u_1} T inst C
                        (@Subtype.val.{u_1 + 1} T
                          (fun x =>
                            @Membership.mem.{u_1, u_1} T (Finset.{u_1} T)
                              (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} T) T (@Finset.instSetLike.{u_1} T))
                              (C k) x)
                          t)
                        k j)
                      ω)
                    (X
                      (@chainingSequence.{u_1} T inst C
                        (@Subtype.val.{u_1 + 1} T
                          (fun x =>
                            @Membership.mem.{u_1, u_1} T (Finset.{u_1} T)
                              (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} T) T (@Finset.instSetLike.{u_1} T))
                              (C k) x)
                          t)
                        k
                        (@HAdd.hAdd.{0, 0, 0} Nat Nat Nat (@instHAdd.{0} Nat instAddNat) j
                          (@OfNat.ofNat.{0} Nat (nat_lit 1) (instOfNatNat (nat_lit 1)))))
                      ω))
                  p)
            (@HMul.hMul.{0, 0, 0} ENNReal ENNReal ENNReal
              (@instHMul.{0} ENNReal
                (@Distrib.toMul.{0} ENNReal
                  (@instDistribOfSemiring.{0} ENNReal (@CommSemiring.toSemiring.{0} ENNReal ENNReal.instCommSemiring))))
              (@HMul.hMul.{0, 0, 0} ENNReal ENNReal ENNReal
                (@instHMul.{0} ENNReal
                  (@Distrib.toMul.{0} ENNReal
                    (@instDistribOfSemiring.{0} ENNReal
                      (@CommSemiring.toSemiring.{0} ENNReal ENNReal.instCommSemiring))))
                (@Nat.cast.{0} ENNReal
                  (@AddMonoidWithOne.toNatCast.{0} ENNReal
                    (@AddCommMonoidWithOne.toAddMonoidWithOne.{0} ENNReal ENNReal.instAddCommMonoidWithOne))
                  (@Finset.card.{u_1} T
                    (C
                      (@HAdd.hAdd.{0, 0, 0} Nat Nat Nat (@instHAdd.{0} Nat instAddNat) j
                        (@OfNat.ofNat.{0} Nat (nat_lit 1) (instOfNatNat (nat_lit 1)))))))
                ↑M)
              (@HPow.hPow.{0, 0, 0} ENNReal Real ENNReal (@instHPow.{0, 0} ENNReal Real ENNReal.instPowReal) (↑(ε j))
                q)) :=
⋯
```

## `ProbabilityTheory.measurable_brownian`

Command: `#print ProbabilityTheory.measurable_brownian`

```lean
theorem ProbabilityTheory.measurable_brownian : ∀ (t : NNReal),
  @Measurable.{0, 0} (NNReal → Real) Real
    (@MeasurableSpace.pi.{0, 0} NNReal (fun a => Real) fun a => Real.measurableSpace) Real.measurableSpace
    (ProbabilityTheory.brownian t) :=
⋯
```

## `ProbabilityTheory.measurable_edist_holderModification`

Command: `#print ProbabilityTheory.measurable_edist_holderModification`

```lean
theorem ProbabilityTheory.measurable_edist_holderModification.{u_1, u_2, u_3} : ∀ {T : Type u_1} {Ω : Type u_2}
  {E : Type u_3} {mΩ : MeasurableSpace.{u_2} Ω} {P : @MeasureTheory.Measure.{u_2} Ω mΩ}
  [inst : PseudoEMetricSpace.{u_1} T] [inst_1 : PseudoEMetricSpace.{u_3} E] [inst_2 : MeasurableSpace.{u_3} E]
  [@BorelSpace.{u_3} E (@UniformSpace.toTopologicalSpace.{u_3} E (@PseudoEMetricSpace.toUniformSpace.{u_3} E inst_1))
      inst_2]
  [@CompleteSpace.{u_3} E (@PseudoEMetricSpace.toUniformSpace.{u_3} E inst_1)] [hE : Nonempty.{u_3 + 1} E]
  [inst_5 :
    @SecondCountableTopology.{u_1} T
      (@UniformSpace.toTopologicalSpace.{u_1} T (@PseudoEMetricSpace.toUniformSpace.{u_1} T inst))]
  {U₁ U₂ : Set.{u_1} T}
  [inst_6 :
    @DecidablePred.{u_1 + 1} T fun x => @Membership.mem.{u_1, u_1} T (Set.{u_1} T) (@Set.instMembership.{u_1} T) U₁ x]
  [inst_7 :
    @DecidablePred.{u_1 + 1} T fun x => @Membership.mem.{u_1, u_1} T (Set.{u_1} T) (@Set.instMembership.{u_1} T) U₂ x],
  @IsOpen.{u_1} T (@UniformSpace.toTopologicalSpace.{u_1} T (@PseudoEMetricSpace.toUniformSpace.{u_1} T inst)) U₁ →
    @IsOpen.{u_1} T (@UniformSpace.toTopologicalSpace.{u_1} T (@PseudoEMetricSpace.toUniformSpace.{u_1} T inst)) U₂ →
      ∀ {X₁ X₂ : T → Ω → E} {c₁ c₂ : ENNReal} {p₁ p₂ q₁ q₂ d₁ d₂ : Real} {M₁ M₂ β₁ β₂ : NNReal},
        @HasBoundedCoveringNumber.{u_1} T inst U₁ c₁ d₁ →
          @HasBoundedCoveringNumber.{u_1} T inst U₂ c₂ d₂ →
            @ProbabilityTheory.IsKolmogorovProcess.{u_1, u_2, u_3} T Ω E inst mΩ inst_1 X₁ P p₁ q₁ M₁ →
              @ProbabilityTheory.IsKolmogorovProcess.{u_1, u_2, u_3} T Ω E inst mΩ inst_1 X₂ P p₂ q₂ M₂ →
                @Ne.{1} ENNReal c₁ (@Top.top.{0} ENNReal ENNReal.instTop) →
                  @Ne.{1} ENNReal c₂ (@Top.top.{0} ENNReal ENNReal.instTop) →
                    @LT.lt.{0} Real Real.instLT
                        (@OfNat.ofNat.{0} Real (nat_lit 0) (@Zero.toOfNat0.{0} Real Real.instZero)) d₁ →
                      @LT.lt.{0} Real Real.instLT
                          (@OfNat.ofNat.{0} Real (nat_lit 0) (@Zero.toOfNat0.{0} Real Real.instZero)) d₂ →
                        @LT.lt.{0} Real Real.instLT d₁ q₁ →
                          @LT.lt.{0} Real Real.instLT d₂ q₂ →
                            @LT.lt.{0} NNReal
                                (@Preorder.toLT.{0} NNReal
                                  (@PartialOrder.toPreorder.{0} NNReal NNReal.instPartialOrder))
                                (@OfNat.ofNat.{0} NNReal (nat_lit 0) (@Zero.toOfNat0.{0} NNReal NNReal.instZero)) β₁ →
                              @LT.lt.{0} NNReal
                                  (@Preorder.toLT.{0} NNReal
                                    (@PartialOrder.toPreorder.{0} NNReal NNReal.instPartialOrder))
                                  (@OfNat.ofNat.{0} NNReal (nat_lit 0) (@Zero.toOfNat0.{0} NNReal NNReal.instZero)) β₂ →
                                @LT.lt.{0} Real Real.instLT (↑β₁)
                                    (@HDiv.hDiv.{0, 0, 0} Real Real Real
                                      (@instHDiv.{0} Real (@DivInvMonoid.toDiv.{0} Real Real.instDivInvMonoid))
                                      (@HSub.hSub.{0, 0, 0} Real Real Real (@instHSub.{0} Real Real.instSub) q₁ d₁)
                                      p₁) →
                                  @LT.lt.{0} Real Real.instLT (↑β₂)
                                      (@HDiv.hDiv.{0, 0, 0} Real Real Real
                                        (@instHDiv.{0} Real (@DivInvMonoid.toDiv.{0} Real Real.instDivInvMonoid))
                                        (@HSub.hSub.{0, 0, 0} Real Real Real (@instHSub.{0} Real Real.instSub) q₂ d₂)
                                        p₂) →
                                    (∀ (i j : T),
                                        @Measurable.{u_2, u_3} Ω (Prod.{u_3, u_3} E E) mΩ
                                          (@borel.{u_3} (Prod.{u_3, u_3} E E)
                                            (@instTopologicalSpaceProd.{u_3, u_3} E E
                                              (@UniformSpace.toTopologicalSpace.{u_3} E
                                                (@PseudoEMetricSpace.toUniformSpace.{u_3} E inst_1))
                                              (@UniformSpace.toTopologicalSpace.{u_3} E
                                                (@PseudoEMetricSpace.toUniformSpace.{u_3} E inst_1))))
                                          fun ω => @Prod.mk.{u_3, u_3} E E (X₁ i ω) (X₂ j ω)) →
                                      ∀ (s t : T),
                                        @Measurable.{u_2, 0} Ω ENNReal mΩ ENNReal.measurableSpace fun ω =>
                                          @EDist.edist.{u_3} E
                                            (@WeakPseudoEMetricSpace.toEDist.{u_3} E
                                              (@UniformSpace.toTopologicalSpace.{u_3} E
                                                (@PseudoEMetricSpace.toUniformSpace.{u_3} E inst_1))
                                              (@PseudoEMetricSpace.toWeakPseudoEMetricSpace.{u_3} E inst_1))
                                            (@ProbabilityTheory.holderModification.{u_1, u_2, u_3} T Ω E inst inst_1 hE
                                              inst_5 X₁ β₁ p₁ U₁ inst_6 s ω)
                                            (@ProbabilityTheory.holderModification.{u_1, u_2, u_3} T Ω E inst inst_1 hE
                                              inst_5 X₂ β₂ p₂ U₂ inst_7 t ω) :=
⋯
```

## `ProbabilityTheory.measurable_edist_holderModification'`

Command: `#print ProbabilityTheory.measurable_edist_holderModification'`

```lean
theorem ProbabilityTheory.measurable_edist_holderModification'.{u_1, u_2, u_3} : ∀ {T : Type u_1} {Ω : Type u_2}
  {E : Type u_3} {mΩ : MeasurableSpace.{u_2} Ω} {X : T → Ω → E} {c : ENNReal} {d p q : Real} {M : NNReal}
  {P : @MeasureTheory.Measure.{u_2} Ω mΩ} {U : Set.{u_1} T} [inst : PseudoEMetricSpace.{u_1} T]
  [inst_1 : PseudoEMetricSpace.{u_3} E] [inst_2 : MeasurableSpace.{u_3} E]
  [@BorelSpace.{u_3} E (@UniformSpace.toTopologicalSpace.{u_3} E (@PseudoEMetricSpace.toUniformSpace.{u_3} E inst_1))
      inst_2]
  [@CompleteSpace.{u_3} E (@PseudoEMetricSpace.toUniformSpace.{u_3} E inst_1)] [hE : Nonempty.{u_3 + 1} E]
  [inst_5 :
    @SecondCountableTopology.{u_1} T
      (@UniformSpace.toTopologicalSpace.{u_1} T (@PseudoEMetricSpace.toUniformSpace.{u_1} T inst))]
  {β₁ β₂ : NNReal},
  @HasBoundedCoveringNumber.{u_1} T inst U c d →
    ∀
      [inst_6 :
        @DecidablePred.{u_1 + 1} T fun x =>
          @Membership.mem.{u_1, u_1} T (Set.{u_1} T) (@Set.instMembership.{u_1} T) U x],
      @IsOpen.{u_1} T (@UniformSpace.toTopologicalSpace.{u_1} T (@PseudoEMetricSpace.toUniformSpace.{u_1} T inst)) U →
        @ProbabilityTheory.IsKolmogorovProcess.{u_1, u_2, u_3} T Ω E inst mΩ inst_1 X P p q M →
          @Ne.{1} ENNReal c (@Top.top.{0} ENNReal ENNReal.instTop) →
            @LT.lt.{0} Real Real.instLT (@OfNat.ofNat.{0} Real (nat_lit 0) (@Zero.toOfNat0.{0} Real Real.instZero)) d →
              @LT.lt.{0} Real Real.instLT d q →
                @LT.lt.{0} NNReal
                    (@Preorder.toLT.{0} NNReal (@PartialOrder.toPreorder.{0} NNReal NNReal.instPartialOrder))
                    (@OfNat.ofNat.{0} NNReal (nat_lit 0) (@Zero.toOfNat0.{0} NNReal NNReal.instZero)) β₁ →
                  @LT.lt.{0} Real Real.instLT (↑β₁)
                      (@HDiv.hDiv.{0, 0, 0} Real Real Real
                        (@instHDiv.{0} Real (@DivInvMonoid.toDiv.{0} Real Real.instDivInvMonoid))
                        (@HSub.hSub.{0, 0, 0} Real Real Real (@instHSub.{0} Real Real.instSub) q d) p) →
                    @LT.lt.{0} NNReal
                        (@Preorder.toLT.{0} NNReal (@PartialOrder.toPreorder.{0} NNReal NNReal.instPartialOrder))
                        (@OfNat.ofNat.{0} NNReal (nat_lit 0) (@Zero.toOfNat0.{0} NNReal NNReal.instZero)) β₂ →
                      @LT.lt.{0} Real Real.instLT (↑β₂)
                          (@HDiv.hDiv.{0, 0, 0} Real Real Real
                            (@instHDiv.{0} Real (@DivInvMonoid.toDiv.{0} Real Real.instDivInvMonoid))
                            (@HSub.hSub.{0, 0, 0} Real Real Real (@instHSub.{0} Real Real.instSub) q d) p) →
                        ∀ (s t : T),
                          @Measurable.{u_2, 0} Ω ENNReal mΩ ENNReal.measurableSpace fun ω =>
                            @EDist.edist.{u_3} E
                              (@WeakPseudoEMetricSpace.toEDist.{u_3} E
                                (@UniformSpace.toTopologicalSpace.{u_3} E
                                  (@PseudoEMetricSpace.toUniformSpace.{u_3} E inst_1))
                                (@PseudoEMetricSpace.toWeakPseudoEMetricSpace.{u_3} E inst_1))
                              (@ProbabilityTheory.holderModification.{u_1, u_2, u_3} T Ω E inst inst_1 hE inst_5 X β₁ p
                                U inst_6 s ω)
                              (@ProbabilityTheory.holderModification.{u_1, u_2, u_3} T Ω E inst inst_1 hE inst_5 X β₂ p
                                U inst_6 t ω) :=
⋯
```

## `ProbabilityTheory.measurable_holderModification`

Command: `#print ProbabilityTheory.measurable_holderModification`

```lean
theorem ProbabilityTheory.measurable_holderModification.{u_1, u_2, u_3} : ∀ {T : Type u_1} {Ω : Type u_2} {E : Type u_3}
  {mΩ : MeasurableSpace.{u_2} Ω} {X : T → Ω → E} {c : ENNReal} {d p q : Real} {M β : NNReal}
  {P : @MeasureTheory.Measure.{u_2} Ω mΩ} {U : Set.{u_1} T} [inst : PseudoEMetricSpace.{u_1} T]
  [inst_1 : PseudoEMetricSpace.{u_3} E] [inst_2 : MeasurableSpace.{u_3} E]
  [@BorelSpace.{u_3} E (@UniformSpace.toTopologicalSpace.{u_3} E (@PseudoEMetricSpace.toUniformSpace.{u_3} E inst_1))
      inst_2]
  [@CompleteSpace.{u_3} E (@PseudoEMetricSpace.toUniformSpace.{u_3} E inst_1)] [hE : Nonempty.{u_3 + 1} E]
  [inst_5 :
    @SecondCountableTopology.{u_1} T
      (@UniformSpace.toTopologicalSpace.{u_1} T (@PseudoEMetricSpace.toUniformSpace.{u_1} T inst))],
  @HasBoundedCoveringNumber.{u_1} T inst U c d →
    ∀
      [inst_6 :
        @DecidablePred.{u_1 + 1} T fun x =>
          @Membership.mem.{u_1, u_1} T (Set.{u_1} T) (@Set.instMembership.{u_1} T) U x],
      @IsOpen.{u_1} T (@UniformSpace.toTopologicalSpace.{u_1} T (@PseudoEMetricSpace.toUniformSpace.{u_1} T inst)) U →
        @ProbabilityTheory.IsKolmogorovProcess.{u_1, u_2, u_3} T Ω E inst mΩ inst_1 X P p q M →
          @Ne.{1} ENNReal c (@Top.top.{0} ENNReal ENNReal.instTop) →
            @LT.lt.{0} Real Real.instLT (@OfNat.ofNat.{0} Real (nat_lit 0) (@Zero.toOfNat0.{0} Real Real.instZero)) d →
              @LT.lt.{0} Real Real.instLT d q →
                @LT.lt.{0} NNReal
                    (@Preorder.toLT.{0} NNReal (@PartialOrder.toPreorder.{0} NNReal NNReal.instPartialOrder))
                    (@OfNat.ofNat.{0} NNReal (nat_lit 0) (@Zero.toOfNat0.{0} NNReal NNReal.instZero)) β →
                  @LT.lt.{0} Real Real.instLT (↑β)
                      (@HDiv.hDiv.{0, 0, 0} Real Real Real
                        (@instHDiv.{0} Real (@DivInvMonoid.toDiv.{0} Real Real.instDivInvMonoid))
                        (@HSub.hSub.{0, 0, 0} Real Real Real (@instHSub.{0} Real Real.instSub) q d) p) →
                    ∀ (t : T),
                      @Measurable.{u_2, u_3} Ω E mΩ inst_2
                        (@ProbabilityTheory.holderModification.{u_1, u_2, u_3} T Ω E inst inst_1 hE inst_5 X β p U
                          inst_6 t) :=
⋯
```

## `ProbabilityTheory.measurable_pair_indicatorProcess`

Command: `#print ProbabilityTheory.measurable_pair_indicatorProcess`

```lean
theorem ProbabilityTheory.measurable_pair_indicatorProcess.{u_2, u_3, u_4, u_5} : ∀ {Ω : Type u_2} {E : Type u_3}
  {mΩ : MeasurableSpace.{u_2} Ω} [hE : Nonempty.{u_3 + 1} E] {T₁ : Type u_4} {T₂ : Type u_5}
  [inst : TopologicalSpace.{u_3} E] [inst_1 : MeasurableSpace.{u_3} E] [@BorelSpace.{u_3} E inst inst_1]
  {X₁ : T₁ → Ω → E} {X₂ : T₂ → Ω → E},
  (∀ (t : T₁), @Measurable.{u_2, u_3} Ω E mΩ inst_1 (X₁ t)) →
    (∀ (t : T₂), @Measurable.{u_2, u_3} Ω E mΩ inst_1 (X₂ t)) →
      (∀ (i : T₁) (j : T₂),
          @Measurable.{u_2, u_3} Ω (Prod.{u_3, u_3} E E) mΩ
            (@borel.{u_3} (Prod.{u_3, u_3} E E) (@instTopologicalSpaceProd.{u_3, u_3} E E inst inst)) fun ω =>
            @Prod.mk.{u_3, u_3} E E (X₁ i ω) (X₂ j ω)) →
        ∀ {A₁ A₂ : Set.{u_2} Ω},
          @MeasurableSet.{u_2} Ω mΩ A₁ →
            @MeasurableSet.{u_2} Ω mΩ A₂ →
              ∀ (s : T₁) (t : T₂),
                @Measurable.{u_2, u_3} Ω (Prod.{u_3, u_3} E E) mΩ
                  (@borel.{u_3} (Prod.{u_3, u_3} E E) (@instTopologicalSpaceProd.{u_3, u_3} E E inst inst)) fun ω =>
                  @Prod.mk.{u_3, u_3} E E (@ProbabilityTheory.indicatorProcess.{u_4, u_2, u_3} T₁ Ω E hE X₁ A₁ s ω)
                    (@ProbabilityTheory.indicatorProcess.{u_5, u_2, u_3} T₂ Ω E hE X₂ A₂ t ω) :=
⋯
```

## `ProbabilityTheory.measurable_pair_limUnder_comap`

Command: `#print ProbabilityTheory.measurable_pair_limUnder_comap`

```lean
theorem ProbabilityTheory.measurable_pair_limUnder_comap.{u_2, u_3, u_4} : ∀ {Ω : Type u_2} {E : Type u_3}
  {mΩ : MeasurableSpace.{u_2} Ω} [inst : PseudoEMetricSpace.{u_3} E] [hE : Nonempty.{u_3 + 1} E] {T : Type u_4}
  [inst_1 : PseudoEMetricSpace.{u_4} T] {X₁ X₂ : T → Ω → E} {T' : Set.{u_4} T},
  @Dense.{u_4} T (@UniformSpace.toTopologicalSpace.{u_4} T (@PseudoEMetricSpace.toUniformSpace.{u_4} T inst_1)) T' →
    (∀ (i j : T),
        @Measurable.{u_2, u_3} Ω (Prod.{u_3, u_3} E E) mΩ
          (@borel.{u_3} (Prod.{u_3, u_3} E E)
            (@instTopologicalSpaceProd.{u_3, u_3} E E
              (@UniformSpace.toTopologicalSpace.{u_3} E (@PseudoEMetricSpace.toUniformSpace.{u_3} E inst))
              (@UniformSpace.toTopologicalSpace.{u_3} E (@PseudoEMetricSpace.toUniformSpace.{u_3} E inst))))
          fun ω => @Prod.mk.{u_3, u_3} E E (X₁ i ω) (X₂ j ω)) →
      ∀ (s t : T),
        (∀ (ω : Ω),
            ∃ x,
              @Filter.Tendsto.{u_4, u_3} (@Set.Elem.{u_4} T T') E
                (fun t' =>
                  X₁
                    (@Subtype.val.{u_4 + 1} T
                      (fun x => @Membership.mem.{u_4, u_4} T (Set.{u_4} T) (@Set.instMembership.{u_4} T) T' x) t')
                    ω)
                (@Filter.comap.{u_4, u_4} (@Set.Elem.{u_4} T T') T
                  (@Subtype.val.{u_4 + 1} T fun x =>
                    @Membership.mem.{u_4, u_4} T (Set.{u_4} T) (@Set.instMembership.{u_4} T) T' x)
                  (@nhds.{u_4} T
                    (@UniformSpace.toTopologicalSpace.{u_4} T (@PseudoEMetricSpace.toUniformSpace.{u_4} T inst_1)) s))
                (@nhds.{u_3} E
                  (@UniformSpace.toTopologicalSpace.{u_3} E (@PseudoEMetricSpace.toUniformSpace.{u_3} E inst)) x)) →
          (∀ (ω : Ω),
              ∃ x,
                @Filter.Tendsto.{u_4, u_3} (@Set.Elem.{u_4} T T') E
                  (fun t' =>
                    X₂
                      (@Subtype.val.{u_4 + 1} T
                        (fun x => @Membership.mem.{u_4, u_4} T (Set.{u_4} T) (@Set.instMembership.{u_4} T) T' x) t')
                      ω)
                  (@Filter.comap.{u_4, u_4} (@Set.Elem.{u_4} T T') T
                    (@Subtype.val.{u_4 + 1} T fun x =>
                      @Membership.mem.{u_4, u_4} T (Set.{u_4} T) (@Set.instMembership.{u_4} T) T' x)
                    (@nhds.{u_4} T
                      (@UniformSpace.toTopologicalSpace.{u_4} T (@PseudoEMetricSpace.toUniformSpace.{u_4} T inst_1)) t))
                  (@nhds.{u_3} E
                    (@UniformSpace.toTopologicalSpace.{u_3} E (@PseudoEMetricSpace.toUniformSpace.{u_3} E inst)) x)) →
            @Measurable.{u_2, u_3} Ω (Prod.{u_3, u_3} E E) mΩ
              (@borel.{u_3} (Prod.{u_3, u_3} E E)
                (@instTopologicalSpaceProd.{u_3, u_3} E E
                  (@UniformSpace.toTopologicalSpace.{u_3} E (@PseudoEMetricSpace.toUniformSpace.{u_3} E inst))
                  (@UniformSpace.toTopologicalSpace.{u_3} E (@PseudoEMetricSpace.toUniformSpace.{u_3} E inst))))
              fun ω =>
              @Prod.mk.{u_3, u_3} E E
                (@Filter.limUnder.{u_3, u_4} E
                  (@UniformSpace.toTopologicalSpace.{u_3} E (@PseudoEMetricSpace.toUniformSpace.{u_3} E inst))
                  (@Subtype.{u_4 + 1} T fun x =>
                    @Membership.mem.{u_4, u_4} T (Set.{u_4} T) (@Set.instMembership.{u_4} T) T' x)
                  hE
                  (@Filter.comap.{u_4, u_4}
                    (@Subtype.{u_4 + 1} T fun x =>
                      @Membership.mem.{u_4, u_4} T (Set.{u_4} T) (@Set.instMembership.{u_4} T) T' x)
                    T
                    (@Subtype.val.{u_4 + 1} T fun x =>
                      @Membership.mem.{u_4, u_4} T (Set.{u_4} T) (@Set.instMembership.{u_4} T) T' x)
                    (@nhds.{u_4} T
                      (@UniformSpace.toTopologicalSpace.{u_4} T (@PseudoEMetricSpace.toUniformSpace.{u_4} T inst_1)) s))
                  fun t' =>
                  X₁
                    (@Subtype.val.{u_4 + 1} T
                      (fun x => @Membership.mem.{u_4, u_4} T (Set.{u_4} T) (@Set.instMembership.{u_4} T) T' x) t')
                    ω)
                (@Filter.limUnder.{u_3, u_4} E
                  (@UniformSpace.toTopologicalSpace.{u_3} E (@PseudoEMetricSpace.toUniformSpace.{u_3} E inst))
                  (@Subtype.{u_4 + 1} T fun x =>
                    @Membership.mem.{u_4, u_4} T (Set.{u_4} T) (@Set.instMembership.{u_4} T) T' x)
                  hE
                  (@Filter.comap.{u_4, u_4}
                    (@Subtype.{u_4 + 1} T fun x =>
                      @Membership.mem.{u_4, u_4} T (Set.{u_4} T) (@Set.instMembership.{u_4} T) T' x)
                    T
                    (@Subtype.val.{u_4 + 1} T fun x =>
                      @Membership.mem.{u_4, u_4} T (Set.{u_4} T) (@Set.instMembership.{u_4} T) T' x)
                    (@nhds.{u_4} T
                      (@UniformSpace.toTopologicalSpace.{u_4} T (@PseudoEMetricSpace.toUniformSpace.{u_4} T inst_1)) t))
                  fun t' =>
                  X₂
                    (@Subtype.val.{u_4 + 1} T
                      (fun x => @Membership.mem.{u_4, u_4} T (Set.{u_4} T) (@Set.instMembership.{u_4} T) T' x) t')
                    ω) :=
⋯
```

## `ProbabilityTheory.measurable_pair_limUnder_indicatorProcess`

Command: `#print ProbabilityTheory.measurable_pair_limUnder_indicatorProcess`

```lean
theorem ProbabilityTheory.measurable_pair_limUnder_indicatorProcess.{u_2, u_3, u_4} : ∀ {Ω : Type u_2} {E : Type u_3}
  {mΩ : MeasurableSpace.{u_2} Ω} [inst : PseudoEMetricSpace.{u_3} E] [hE : Nonempty.{u_3 + 1} E] {T : Type u_4}
  [inst_1 : PseudoEMetricSpace.{u_4} T]
  [inst_2 :
    @SecondCountableTopology.{u_4} T
      (@UniformSpace.toTopologicalSpace.{u_4} T (@PseudoEMetricSpace.toUniformSpace.{u_4} T inst_1))]
  [inst_3 : MeasurableSpace.{u_3} E]
  [@BorelSpace.{u_3} E (@UniformSpace.toTopologicalSpace.{u_3} E (@PseudoEMetricSpace.toUniformSpace.{u_3} E inst))
      inst_3]
  {X X' : T → Ω → E},
  (∀ (t : T), @Measurable.{u_2, u_3} Ω E mΩ inst_3 (X t)) →
    (∀ (t : T), @Measurable.{u_2, u_3} Ω E mΩ inst_3 (X' t)) →
      (∀ (i j : T),
          @Measurable.{u_2, u_3} Ω (Prod.{u_3, u_3} E E) mΩ
            (@borel.{u_3} (Prod.{u_3, u_3} E E)
              (@instTopologicalSpaceProd.{u_3, u_3} E E
                (@UniformSpace.toTopologicalSpace.{u_3} E (@PseudoEMetricSpace.toUniformSpace.{u_3} E inst))
                (@UniformSpace.toTopologicalSpace.{u_3} E (@PseudoEMetricSpace.toUniformSpace.{u_3} E inst))))
            fun ω => @Prod.mk.{u_3, u_3} E E (X i ω) (X' j ω)) →
        ∀ {A₁ A₂ : Set.{u_2} Ω},
          @MeasurableSet.{u_2} Ω mΩ A₁ →
            @MeasurableSet.{u_2} Ω mΩ A₂ →
              ∀ (s t : T),
                (∀ (ω : Ω),
                    @Membership.mem.{u_2, u_2} Ω (Set.{u_2} Ω) (@Set.instMembership.{u_2} Ω) A₁ ω →
                      ∃ c,
                        @Filter.Tendsto.{u_4, u_3}
                          (@Set.Elem.{u_4} T
                            (@denseCountable.{u_4} T
                              (@UniformSpace.toTopologicalSpace.{u_4} T
                                (@PseudoEMetricSpace.toUniformSpace.{u_4} T inst_1))
                              inst_2))
                          E
                          (fun t' =>
                            X
                              (@Subtype.val.{u_4 + 1} T
                                (fun x =>
                                  @Membership.mem.{u_4, u_4} T (Set.{u_4} T) (@Set.instMembership.{u_4} T)
                                    (@denseCountable.{u_4} T
                                      (@UniformSpace.toTopologicalSpace.{u_4} T
                                        (@PseudoEMetricSpace.toUniformSpace.{u_4} T inst_1))
                                      inst_2)
                                    x)
                                t')
                              ω)
                          (@Filter.comap.{u_4, u_4}
                            (@Set.Elem.{u_4} T
                              (@denseCountable.{u_4} T
                                (@UniformSpace.toTopologicalSpace.{u_4} T
                                  (@PseudoEMetricSpace.toUniformSpace.{u_4} T inst_1))
                                inst_2))
                            T
                            (@Subtype.val.{u_4 + 1} T fun x =>
                              @Membership.mem.{u_4, u_4} T (Set.{u_4} T) (@Set.instMembership.{u_4} T)
                                (@denseCountable.{u_4} T
                                  (@UniformSpace.toTopologicalSpace.{u_4} T
                                    (@PseudoEMetricSpace.toUniformSpace.{u_4} T inst_1))
                                  inst_2)
                                x)
                            (@nhds.{u_4} T
                              (@UniformSpace.toTopologicalSpace.{u_4} T
                                (@PseudoEMetricSpace.toUniformSpace.{u_4} T inst_1))
                              s))
                          (@nhds.{u_3} E
                            (@UniformSpace.toTopologicalSpace.{u_3} E (@PseudoEMetricSpace.toUniformSpace.{u_3} E inst))
                            c)) →
                  (∀ (ω : Ω),
                      @Membership.mem.{u_2, u_2} Ω (Set.{u_2} Ω) (@Set.instMembership.{u_2} Ω) A₂ ω →
                        ∃ c,
                          @Filter.Tendsto.{u_4, u_3}
                            (@Set.Elem.{u_4} T
                              (@denseCountable.{u_4} T
                                (@UniformSpace.toTopologicalSpace.{u_4} T
                                  (@PseudoEMetricSpace.toUniformSpace.{u_4} T inst_1))
                                inst_2))
                            E
                            (fun t' =>
                              X'
                                (@Subtype.val.{u_4 + 1} T
                                  (fun x =>
                                    @Membership.mem.{u_4, u_4} T (Set.{u_4} T) (@Set.instMembership.{u_4} T)
                                      (@denseCountable.{u_4} T
                                        (@UniformSpace.toTopologicalSpace.{u_4} T
                                          (@PseudoEMetricSpace.toUniformSpace.{u_4} T inst_1))
                                        inst_2)
                                      x)
                                  t')
                                ω)
                            (@Filter.comap.{u_4, u_4}
                              (@Set.Elem.{u_4} T
                                (@denseCountable.{u_4} T
                                  (@UniformSpace.toTopologicalSpace.{u_4} T
                                    (@PseudoEMetricSpace.toUniformSpace.{u_4} T inst_1))
                                  inst_2))
                              T
                              (@Subtype.val.{u_4 + 1} T fun x =>
                                @Membership.mem.{u_4, u_4} T (Set.{u_4} T) (@Set.instMembership.{u_4} T)
                                  (@denseCountable.{u_4} T
                                    (@UniformSpace.toTopologicalSpace.{u_4} T
                                      (@PseudoEMetricSpace.toUniformSpace.{u_4} T inst_1))
                                    inst_2)
                                  x)
                              (@nhds.{u_4} T
                                (@UniformSpace.toTopologicalSpace.{u_4} T
                                  (@PseudoEMetricSpace.toUniformSpace.{u_4} T inst_1))
                                t))
                            (@nhds.{u_3} E
                              (@UniformSpace.toTopologicalSpace.{u_3} E
                                (@PseudoEMetricSpace.toUniformSpace.{u_3} E inst))
                              c)) →
                    @Measurable.{u_2, u_3} Ω (Prod.{u_3, u_3} E E) mΩ
                      (@borel.{u_3} (Prod.{u_3, u_3} E E)
                        (@instTopologicalSpaceProd.{u_3, u_3} E E
                          (@UniformSpace.toTopologicalSpace.{u_3} E (@PseudoEMetricSpace.toUniformSpace.{u_3} E inst))
                          (@UniformSpace.toTopologicalSpace.{u_3} E (@PseudoEMetricSpace.toUniformSpace.{u_3} E inst))))
                      fun ω =>
                      @Prod.mk.{u_3, u_3} E E
                        (@Filter.limUnder.{u_3, u_4} E
                          (@UniformSpace.toTopologicalSpace.{u_3} E (@PseudoEMetricSpace.toUniformSpace.{u_3} E inst))
                          (@Subtype.{u_4 + 1} T fun x =>
                            @Membership.mem.{u_4, u_4} T (Set.{u_4} T) (@Set.instMembership.{u_4} T)
                              (@denseCountable.{u_4} T
                                (@UniformSpace.toTopologicalSpace.{u_4} T
                                  (@PseudoEMetricSpace.toUniformSpace.{u_4} T inst_1))
                                inst_2)
                              x)
                          hE
                          (@Filter.comap.{u_4, u_4}
                            (@Subtype.{u_4 + 1} T fun x =>
                              @Membership.mem.{u_4, u_4} T (Set.{u_4} T) (@Set.instMembership.{u_4} T)
                                (@denseCountable.{u_4} T
                                  (@UniformSpace.toTopologicalSpace.{u_4} T
                                    (@PseudoEMetricSpace.toUniformSpace.{u_4} T inst_1))
                                  inst_2)
                                x)
                            T
                            (@Subtype.val.{u_4 + 1} T fun x =>
                              @Membership.mem.{u_4, u_4} T (Set.{u_4} T) (@Set.instMembership.{u_4} T)
                                (@denseCountable.{u_4} T
                                  (@UniformSpace.toTopologicalSpace.{u_4} T
                                    (@PseudoEMetricSpace.toUniformSpace.{u_4} T inst_1))
                                  inst_2)
                                x)
                            (@nhds.{u_4} T
                              (@UniformSpace.toTopologicalSpace.{u_4} T
                                (@PseudoEMetricSpace.toUniformSpace.{u_4} T inst_1))
                              s))
                          fun t' =>
                          @ProbabilityTheory.indicatorProcess.{u_4, u_2, u_3} T Ω E hE X A₁
                            (@Subtype.val.{u_4 + 1} T
                              (fun x =>
                                @Membership.mem.{u_4, u_4} T (Set.{u_4} T) (@Set.instMembership.{u_4} T)
                                  (@denseCountable.{u_4} T
                                    (@UniformSpace.toTopologicalSpace.{u_4} T
                                      (@PseudoEMetricSpace.toUniformSpace.{u_4} T inst_1))
                                    inst_2)
                                  x)
                              t')
                            ω)
                        (@Filter.limUnder.{u_3, u_4} E
                          (@UniformSpace.toTopologicalSpace.{u_3} E (@PseudoEMetricSpace.toUniformSpace.{u_3} E inst))
                          (@Subtype.{u_4 + 1} T fun x =>
                            @Membership.mem.{u_4, u_4} T (Set.{u_4} T) (@Set.instMembership.{u_4} T)
                              (@denseCountable.{u_4} T
                                (@UniformSpace.toTopologicalSpace.{u_4} T
                                  (@PseudoEMetricSpace.toUniformSpace.{u_4} T inst_1))
                                inst_2)
                              x)
                          hE
                          (@Filter.comap.{u_4, u_4}
                            (@Subtype.{u_4 + 1} T fun x =>
                              @Membership.mem.{u_4, u_4} T (Set.{u_4} T) (@Set.instMembership.{u_4} T)
                                (@denseCountable.{u_4} T
                                  (@UniformSpace.toTopologicalSpace.{u_4} T
                                    (@PseudoEMetricSpace.toUniformSpace.{u_4} T inst_1))
                                  inst_2)
                                x)
                            T
                            (@Subtype.val.{u_4 + 1} T fun x =>
                              @Membership.mem.{u_4, u_4} T (Set.{u_4} T) (@Set.instMembership.{u_4} T)
                                (@denseCountable.{u_4} T
                                  (@UniformSpace.toTopologicalSpace.{u_4} T
                                    (@PseudoEMetricSpace.toUniformSpace.{u_4} T inst_1))
                                  inst_2)
                                x)
                            (@nhds.{u_4} T
                              (@UniformSpace.toTopologicalSpace.{u_4} T
                                (@PseudoEMetricSpace.toUniformSpace.{u_4} T inst_1))
                              t))
                          fun t' =>
                          @ProbabilityTheory.indicatorProcess.{u_4, u_2, u_3} T Ω E hE X' A₂
                            (@Subtype.val.{u_4 + 1} T
                              (fun x =>
                                @Membership.mem.{u_4, u_4} T (Set.{u_4} T) (@Set.instMembership.{u_4} T)
                                  (@denseCountable.{u_4} T
                                    (@UniformSpace.toTopologicalSpace.{u_4} T
                                      (@PseudoEMetricSpace.toUniformSpace.{u_4} T inst_1))
                                    inst_2)
                                  x)
                              t')
                            ω) :=
⋯
```

## `ProbabilityTheory.measurable_preBrownian`

Command: `#print ProbabilityTheory.measurable_preBrownian`

```lean
theorem ProbabilityTheory.measurable_preBrownian : ∀ (t : NNReal),
  @Measurable.{0, 0} (NNReal → Real) Real
    (@MeasurableSpace.pi.{0, 0} NNReal (fun a => Real) fun a => Real.measurableSpace) Real.measurableSpace
    (ProbabilityTheory.preBrownian t) :=
⋯
```

## `ProbabilityTheory.measurePreserving_equiv_multivariateGaussian`

Command: `#print ProbabilityTheory.measurePreserving_equiv_multivariateGaussian`

```lean
theorem ProbabilityTheory.measurePreserving_equiv_multivariateGaussian : ∀ (I : Finset.{0} NNReal),
  @MeasureTheory.MeasurePreserving.{0, 0}
    (WithLp.{0}
      (@OfNat.ofNat.{0} ENNReal (nat_lit 2)
        (@instOfNatAtLeastTwo.{0} ENNReal (nat_lit 2)
          (@AddMonoidWithOne.toNatCast.{0} ENNReal
            (@AddCommMonoidWithOne.toAddMonoidWithOne.{0} ENNReal ENNReal.instAddCommMonoidWithOne))
          ⋯))
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
              ⋯))
          (↥I → Real))
        (↥I → Real)
        (@WithLp.measurableSpace.{0}
          (@OfNat.ofNat.{0} ENNReal (nat_lit 2)
            (@instOfNatAtLeastTwo.{0} ENNReal (nat_lit 2)
              (@AddMonoidWithOne.toNatCast.{0} ENNReal
                (@AddCommMonoidWithOne.toAddMonoidWithOne.{0} ENNReal ENNReal.instAddCommMonoidWithOne))
              ⋯))
          (↥I → Real) (@MeasurableSpace.pi.{0, 0} (↥I) (fun a => Real) fun a => Real.measurableSpace))
        (@MeasurableSpace.pi.{0, 0} (↥I) (fun a => Real) fun a => Real.measurableSpace))
      (WithLp.{0}
        (@OfNat.ofNat.{0} ENNReal (nat_lit 2)
          (@instOfNatAtLeastTwo.{0} ENNReal (nat_lit 2)
            (@AddMonoidWithOne.toNatCast.{0} ENNReal
              (@AddCommMonoidWithOne.toAddMonoidWithOne.{0} ENNReal ENNReal.instAddCommMonoidWithOne))
            ⋯))
        (↥I → Real))
      (fun x => ↥I → Real)
      (@EquivLike.toFunLike.{1, 1, 1}
        (@MeasurableEquiv.{0, 0}
          (WithLp.{0}
            (@OfNat.ofNat.{0} ENNReal (nat_lit 2)
              (@instOfNatAtLeastTwo.{0} ENNReal (nat_lit 2)
                (@AddMonoidWithOne.toNatCast.{0} ENNReal
                  (@AddCommMonoidWithOne.toAddMonoidWithOne.{0} ENNReal ENNReal.instAddCommMonoidWithOne))
                ⋯))
            (↥I → Real))
          (↥I → Real)
          (@WithLp.measurableSpace.{0}
            (@OfNat.ofNat.{0} ENNReal (nat_lit 2)
              (@instOfNatAtLeastTwo.{0} ENNReal (nat_lit 2)
                (@AddMonoidWithOne.toNatCast.{0} ENNReal
                  (@AddCommMonoidWithOne.toAddMonoidWithOne.{0} ENNReal ENNReal.instAddCommMonoidWithOne))
                ⋯))
            (↥I → Real) (@MeasurableSpace.pi.{0, 0} (↥I) (fun a => Real) fun a => Real.measurableSpace))
          (@MeasurableSpace.pi.{0, 0} (↥I) (fun a => Real) fun a => Real.measurableSpace))
        (WithLp.{0}
          (@OfNat.ofNat.{0} ENNReal (nat_lit 2)
            (@instOfNatAtLeastTwo.{0} ENNReal (nat_lit 2)
              (@AddMonoidWithOne.toNatCast.{0} ENNReal
                (@AddCommMonoidWithOne.toAddMonoidWithOne.{0} ENNReal ENNReal.instAddCommMonoidWithOne))
              ⋯))
          (↥I → Real))
        (↥I → Real)
        (@MeasurableEquiv.instEquivLike.{0, 0}
          (WithLp.{0}
            (@OfNat.ofNat.{0} ENNReal (nat_lit 2)
              (@instOfNatAtLeastTwo.{0} ENNReal (nat_lit 2)
                (@AddMonoidWithOne.toNatCast.{0} ENNReal
                  (@AddCommMonoidWithOne.toAddMonoidWithOne.{0} ENNReal ENNReal.instAddCommMonoidWithOne))
                ⋯))
            (↥I → Real))
          (↥I → Real)
          (@WithLp.measurableSpace.{0}
            (@OfNat.ofNat.{0} ENNReal (nat_lit 2)
              (@instOfNatAtLeastTwo.{0} ENNReal (nat_lit 2)
                (@AddMonoidWithOne.toNatCast.{0} ENNReal
                  (@AddCommMonoidWithOne.toAddMonoidWithOne.{0} ENNReal ENNReal.instAddCommMonoidWithOne))
                ⋯))
            (↥I → Real) (@MeasurableSpace.pi.{0, 0} (↥I) (fun a => Real) fun a => Real.measurableSpace))
          (@MeasurableSpace.pi.{0, 0} (↥I) (fun a => Real) fun a => Real.measurableSpace)))
      (@MeasurableEquiv.symm.{0, 0} (↥I → Real)
        (WithLp.{0}
          (@OfNat.ofNat.{0} ENNReal (nat_lit 2)
            (@instOfNatAtLeastTwo.{0} ENNReal (nat_lit 2)
              (@AddMonoidWithOne.toNatCast.{0} ENNReal
                (@AddCommMonoidWithOne.toAddMonoidWithOne.{0} ENNReal ENNReal.instAddCommMonoidWithOne))
              ⋯))
          (↥I → Real))
        (@MeasurableSpace.pi.{0, 0} (↥I) (fun a => Real) fun a => Real.measurableSpace)
        (@WithLp.measurableSpace.{0}
          (@OfNat.ofNat.{0} ENNReal (nat_lit 2)
            (@instOfNatAtLeastTwo.{0} ENNReal (nat_lit 2)
              (@AddMonoidWithOne.toNatCast.{0} ENNReal
                (@AddCommMonoidWithOne.toAddMonoidWithOne.{0} ENNReal ENNReal.instAddCommMonoidWithOne))
              ⋯))
          (↥I → Real) (@MeasurableSpace.pi.{0, 0} (↥I) (fun a => Real) fun a => Real.measurableSpace))
        (@MeasurableEquiv.toLp.{0}
          (@OfNat.ofNat.{0} ENNReal (nat_lit 2)
            (@instOfNatAtLeastTwo.{0} ENNReal (nat_lit 2)
              (@AddMonoidWithOne.toNatCast.{0} ENNReal
                (@AddCommMonoidWithOne.toAddMonoidWithOne.{0} ENNReal ENNReal.instAddCommMonoidWithOne))
              ⋯))
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
    (ProbabilityTheory.gaussianProjectiveFamily I) :=
⋯
```

## `ProbabilityTheory.posSemidef_brownianCovMatrix`

Command: `#print ProbabilityTheory.posSemidef_brownianCovMatrix`

```lean
theorem ProbabilityTheory.posSemidef_brownianCovMatrix : ∀ (I : Finset.{0} NNReal),
  @Matrix.PosSemidef.{0, 0} (↥I) Real Real.instRing Real.partialOrder instStarRingReal
    (ProbabilityTheory.brownianCovMatrix I) :=
⋯
```

## `ProbabilityTheory.preBrownian`

Command: `#print ProbabilityTheory.preBrownian`

```lean
def ProbabilityTheory.preBrownian : NNReal → (NNReal → Real) → Real :=
fun t ω => ω t
```

## `ProbabilityTheory.scale_change_lintegral_iSup`

Command: `#print ProbabilityTheory.scale_change_lintegral_iSup`

```lean
theorem ProbabilityTheory.scale_change_lintegral_iSup.{u_1, u_2, u_3} : ∀ {T : Type u_1} {Ω : Type u_2} {E : Type u_3}
  [inst : PseudoEMetricSpace.{u_1} T] {mΩ : MeasurableSpace.{u_2} Ω} [inst_1 : PseudoEMetricSpace.{u_3} E]
  {P : @MeasureTheory.Measure.{u_2} Ω mΩ} {X : T → Ω → E} {M : NNReal} {p q : Real} {C : Nat → Finset.{u_1} T},
  @ProbabilityTheory.IsAEKolmogorovProcess.{u_1, u_2, u_3} T Ω E inst mΩ inst_1 X P p q M →
    ∀ (δ : ENNReal) (m k : Nat),
      @LE.le.{0} ENNReal ENNReal.instLE
        (@MeasureTheory.lintegral.{u_2} Ω mΩ P fun ω =>
          ⨆ s,
            ⨆ t,
              @HPow.hPow.{0, 0, 0} ENNReal Real ENNReal (@instHPow.{0, 0} ENNReal Real ENNReal.instPowReal)
                (@EDist.edist.{u_3} E
                  (@WeakPseudoEMetricSpace.toEDist.{u_3} E
                    (@UniformSpace.toTopologicalSpace.{u_3} E (@PseudoEMetricSpace.toUniformSpace.{u_3} E inst_1))
                    (@PseudoEMetricSpace.toWeakPseudoEMetricSpace.{u_3} E inst_1))
                  (X
                    (@Subtype.val.{u_1 + 1} T
                      (fun x =>
                        @Membership.mem.{u_1, u_1} T (Finset.{u_1} T)
                          (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} T) T (@Finset.instSetLike.{u_1} T)) (C k) x)
                      s)
                    ω)
                  (X
                    (@Subtype.val.{u_1 + 1} T
                      (fun x =>
                        @Membership.mem.{u_1, u_1} T (Finset.{u_1} T)
                          (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} T) T (@Finset.instSetLike.{u_1} T)) (C k) x)
                      (@Subtype.val.{u_1 + 1} (↥(C k))
                        (fun t =>
                          @LE.le.{0} ENNReal ENNReal.instLE
                            (@EDist.edist.{u_1} (↥(C k))
                              (@WeakPseudoEMetricSpace.toEDist.{u_1} (↥(C k))
                                (@instTopologicalSpaceSubtype.{u_1} T
                                  (fun x =>
                                    @Membership.mem.{u_1, u_1} T (Finset.{u_1} T)
                                      (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} T) T
                                        (@Finset.instSetLike.{u_1} T))
                                      (C k) x)
                                  (@UniformSpace.toTopologicalSpace.{u_1} T
                                    (@PseudoEMetricSpace.toUniformSpace.{u_1} T inst)))
                                (@instWeakPseudoEMetricSpaceSubtype.{u_1} T
                                  (fun x =>
                                    @Membership.mem.{u_1, u_1} T (Finset.{u_1} T)
                                      (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} T) T
                                        (@Finset.instSetLike.{u_1} T))
                                      (C k) x)
                                  (@UniformSpace.toTopologicalSpace.{u_1} T
                                    (@PseudoEMetricSpace.toUniformSpace.{u_1} T inst))
                                  (@PseudoEMetricSpace.toWeakPseudoEMetricSpace.{u_1} T inst)))
                              s t)
                            δ)
                        t))
                    ω))
                p)
        (@HAdd.hAdd.{0, 0, 0} ENNReal ENNReal ENNReal (@instHAdd.{0} ENNReal ENNReal.instAdd)
          (@HMul.hMul.{0, 0, 0} ENNReal ENNReal ENNReal
            (@instHMul.{0} ENNReal
              (@Distrib.toMul.{0} ENNReal
                (@instDistribOfSemiring.{0} ENNReal (@CommSemiring.toSemiring.{0} ENNReal ENNReal.instCommSemiring))))
            (@HPow.hPow.{0, 0, 0} ENNReal Real ENNReal (@instHPow.{0, 0} ENNReal Real ENNReal.instPowReal)
              (@OfNat.ofNat.{0} ENNReal (nat_lit 2)
                (@instOfNatAtLeastTwo.{0} ENNReal (nat_lit 2)
                  (@AddMonoidWithOne.toNatCast.{0} ENNReal
                    (@AddCommMonoidWithOne.toAddMonoidWithOne.{0} ENNReal ENNReal.instAddCommMonoidWithOne))
                  ⋯))
              p)
            (@MeasureTheory.lintegral.{u_2} Ω mΩ P fun ω =>
              ⨆ s,
                ⨆ t,
                  @HPow.hPow.{0, 0, 0} ENNReal Real ENNReal (@instHPow.{0, 0} ENNReal Real ENNReal.instPowReal)
                    (@EDist.edist.{u_3} E
                      (@WeakPseudoEMetricSpace.toEDist.{u_3} E
                        (@UniformSpace.toTopologicalSpace.{u_3} E (@PseudoEMetricSpace.toUniformSpace.{u_3} E inst_1))
                        (@PseudoEMetricSpace.toWeakPseudoEMetricSpace.{u_3} E inst_1))
                      (X
                        (@chainingSequence.{u_1} T inst C
                          (@Subtype.val.{u_1 + 1} T
                            (fun x =>
                              @Membership.mem.{u_1, u_1} T (Finset.{u_1} T)
                                (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} T) T (@Finset.instSetLike.{u_1} T))
                                (C k) x)
                            s)
                          k m)
                        ω)
                      (X
                        (@chainingSequence.{u_1} T inst C
                          (@Subtype.val.{u_1 + 1} T
                            (fun x =>
                              @Membership.mem.{u_1, u_1} T (Finset.{u_1} T)
                                (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} T) T (@Finset.instSetLike.{u_1} T))
                                (C k) x)
                            (@Subtype.val.{u_1 + 1} (↥(C k))
                              (fun t =>
                                @LE.le.{0} ENNReal ENNReal.instLE
                                  (@EDist.edist.{u_1} (↥(C k))
                                    (@WeakPseudoEMetricSpace.toEDist.{u_1} (↥(C k))
                                      (@instTopologicalSpaceSubtype.{u_1} T
                                        (fun x =>
                                          @Membership.mem.{u_1, u_1} T (Finset.{u_1} T)
                                            (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} T) T
                                              (@Finset.instSetLike.{u_1} T))
                                            (C k) x)
                                        (@UniformSpace.toTopologicalSpace.{u_1} T
                                          (@PseudoEMetricSpace.toUniformSpace.{u_1} T inst)))
                                      (@instWeakPseudoEMetricSpaceSubtype.{u_1} T
                                        (fun x =>
                                          @Membership.mem.{u_1, u_1} T (Finset.{u_1} T)
                                            (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} T) T
                                              (@Finset.instSetLike.{u_1} T))
                                            (C k) x)
                                        (@UniformSpace.toTopologicalSpace.{u_1} T
                                          (@PseudoEMetricSpace.toUniformSpace.{u_1} T inst))
                                        (@PseudoEMetricSpace.toWeakPseudoEMetricSpace.{u_1} T inst)))
                                    s t)
                                  δ)
                              t))
                          k m)
                        ω))
                    p))
          (@HMul.hMul.{0, 0, 0} ENNReal ENNReal ENNReal
            (@instHMul.{0} ENNReal
              (@Distrib.toMul.{0} ENNReal
                (@instDistribOfSemiring.{0} ENNReal (@CommSemiring.toSemiring.{0} ENNReal ENNReal.instCommSemiring))))
            (@HPow.hPow.{0, 0, 0} ENNReal Real ENNReal (@instHPow.{0, 0} ENNReal Real ENNReal.instPowReal)
              (@OfNat.ofNat.{0} ENNReal (nat_lit 4)
                (@instOfNatAtLeastTwo.{0} ENNReal (nat_lit 4)
                  (@AddMonoidWithOne.toNatCast.{0} ENNReal
                    (@AddCommMonoidWithOne.toAddMonoidWithOne.{0} ENNReal ENNReal.instAddCommMonoidWithOne))
                  ⋯))
              p)
            (@MeasureTheory.lintegral.{u_2} Ω mΩ P fun ω =>
              ⨆ s,
                @HPow.hPow.{0, 0, 0} ENNReal Real ENNReal (@instHPow.{0, 0} ENNReal Real ENNReal.instPowReal)
                  (@EDist.edist.{u_3} E
                    (@WeakPseudoEMetricSpace.toEDist.{u_3} E
                      (@UniformSpace.toTopologicalSpace.{u_3} E (@PseudoEMetricSpace.toUniformSpace.{u_3} E inst_1))
                      (@PseudoEMetricSpace.toWeakPseudoEMetricSpace.{u_3} E inst_1))
                    (X
                      (@Subtype.val.{u_1 + 1} T
                        (fun x =>
                          @Membership.mem.{u_1, u_1} T (Finset.{u_1} T)
                            (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} T) T (@Finset.instSetLike.{u_1} T)) (C k)
                            x)
                        s)
                      ω)
                    (X
                      (@chainingSequence.{u_1} T inst C
                        (@Subtype.val.{u_1 + 1} T
                          (fun x =>
                            @Membership.mem.{u_1, u_1} T (Finset.{u_1} T)
                              (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} T) T (@Finset.instSetLike.{u_1} T))
                              (C k) x)
                          s)
                        k m)
                      ω))
                  p))) :=
⋯
```

## `ProbabilityTheory.second_term_bound`

Command: `#print ProbabilityTheory.second_term_bound`

```lean
theorem ProbabilityTheory.second_term_bound.{u_1, u_2, u_3} : ∀ {T : Type u_1} {Ω : Type u_2} {E : Type u_3}
  [inst : PseudoEMetricSpace.{u_1} T] {mΩ : MeasurableSpace.{u_2} Ω} [inst_1 : PseudoEMetricSpace.{u_3} E] {p q : Real}
  {M : NNReal} {P : @MeasureTheory.Measure.{u_2} Ω mΩ} {X : T → Ω → E} {J : Set.{u_1} T} {C : Nat → Finset.{u_1} T}
  {k m : Nat},
  @ProbabilityTheory.IsAEKolmogorovProcess.{u_1, u_2, u_3} T Ω E inst mΩ inst_1 X P p q M →
    ∀ {ε₀ : NNReal},
      @LE.le.{0} ENNReal ENNReal.instLE (↑ε₀) (@Metric.ediam.{u_1} T inst J) →
        (∀ (n : Nat),
            @Metric.IsCover.{u_1} T inst
              (@HMul.hMul.{0, 0, 0} NNReal NNReal NNReal
                (@instHMul.{0} NNReal
                  (@Distrib.toMul.{0} NNReal (@instDistribOfSemiring.{0} NNReal NNReal.instSemiring)))
                ε₀
                (@HPow.hPow.{0, 0, 0} NNReal Nat NNReal
                  (@instHPow.{0, 0} NNReal Nat
                    (@NPow.toPow.{0} NNReal
                      (@Monoid.toNPow.{0} NNReal (@Semiring.toMonoid.{0} NNReal NNReal.instSemiring))))
                  (@Inv.inv.{0} NNReal NNReal.instInv
                    (@OfNat.ofNat.{0} NNReal (nat_lit 2)
                      (@instOfNatAtLeastTwo.{0} NNReal (nat_lit 2)
                        (@AddMonoidWithOne.toNatCast.{0} NNReal
                          (@AddCommMonoidWithOne.toAddMonoidWithOne.{0} NNReal
                            (@NonAssocSemiring.toAddCommMonoidWithOne.{0} NNReal
                              (@Semiring.toNonAssocSemiring.{0} NNReal NNReal.instSemiring))))
                        ⋯)))
                  n))
              J (@SetLike.coe.{u_1, u_1} (Finset.{u_1} T) T (@Finset.instSetLike.{u_1} T) (C n))) →
          (∀ (n : Nat),
              @LE.le.{u_1} (Set.{u_1} T) (@Set.instLE.{u_1} T)
                (@SetLike.coe.{u_1, u_1} (Finset.{u_1} T) T (@Finset.instSetLike.{u_1} T) (C n)) J) →
            (∀ (n : Nat),
                @Eq.{1} ENat (@Nat.cast.{0} ENat ENat.instNatCast (@Finset.card.{u_1} T (C n)))
                  (@Metric.coveringNumber.{u_1} T inst
                    (@HMul.hMul.{0, 0, 0} NNReal NNReal NNReal
                      (@instHMul.{0} NNReal
                        (@Distrib.toMul.{0} NNReal (@instDistribOfSemiring.{0} NNReal NNReal.instSemiring)))
                      ε₀
                      (@HPow.hPow.{0, 0, 0} NNReal Nat NNReal
                        (@instHPow.{0, 0} NNReal Nat
                          (@NPow.toPow.{0} NNReal
                            (@Monoid.toNPow.{0} NNReal (@Semiring.toMonoid.{0} NNReal NNReal.instSemiring))))
                        (@Inv.inv.{0} NNReal NNReal.instInv
                          (@OfNat.ofNat.{0} NNReal (nat_lit 2)
                            (@instOfNatAtLeastTwo.{0} NNReal (nat_lit 2)
                              (@AddMonoidWithOne.toNatCast.{0} NNReal
                                (@AddCommMonoidWithOne.toAddMonoidWithOne.{0} NNReal
                                  (@NonAssocSemiring.toAddCommMonoidWithOne.{0} NNReal
                                    (@Semiring.toNonAssocSemiring.{0} NNReal NNReal.instSemiring))))
                              ⋯)))
                        n))
                    J)) →
              ∀ {c₁ : ENNReal} {d : Real},
                @LT.lt.{0} Real Real.instLT d q →
                  @HasBoundedCoveringNumber.{u_1} T inst J c₁ d →
                    @LE.le.{0} Nat instLENat m k →
                      @LE.le.{0} ENNReal ENNReal.instLE
                        (@MeasureTheory.lintegral.{u_2} Ω mΩ P fun ω =>
                          ⨆ t,
                            @HPow.hPow.{0, 0, 0} ENNReal Real ENNReal
                              (@instHPow.{0, 0} ENNReal Real ENNReal.instPowReal)
                              (@EDist.edist.{u_3} E
                                (@WeakPseudoEMetricSpace.toEDist.{u_3} E
                                  (@UniformSpace.toTopologicalSpace.{u_3} E
                                    (@PseudoEMetricSpace.toUniformSpace.{u_3} E inst_1))
                                  (@PseudoEMetricSpace.toWeakPseudoEMetricSpace.{u_3} E inst_1))
                                (X
                                  (@Subtype.val.{u_1 + 1} T
                                    (fun x =>
                                      @Membership.mem.{u_1, u_1} T (Finset.{u_1} T)
                                        (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} T) T
                                          (@Finset.instSetLike.{u_1} T))
                                        (C k) x)
                                    t)
                                  ω)
                                (X
                                  (@chainingSequence.{u_1} T inst C
                                    (@Subtype.val.{u_1 + 1} T
                                      (fun x =>
                                        @Membership.mem.{u_1, u_1} T (Finset.{u_1} T)
                                          (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} T) T
                                            (@Finset.instSetLike.{u_1} T))
                                          (C k) x)
                                      t)
                                    k m)
                                  ω))
                              p)
                        (@HMul.hMul.{0, 0, 0} ENNReal ENNReal ENNReal
                          (@instHMul.{0} ENNReal
                            (@Distrib.toMul.{0} ENNReal
                              (@instDistribOfSemiring.{0} ENNReal
                                (@CommSemiring.toSemiring.{0} ENNReal ENNReal.instCommSemiring))))
                          (@HMul.hMul.{0, 0, 0} ENNReal ENNReal ENNReal
                            (@instHMul.{0} ENNReal
                              (@Distrib.toMul.{0} ENNReal
                                (@instDistribOfSemiring.{0} ENNReal
                                  (@CommSemiring.toSemiring.{0} ENNReal ENNReal.instCommSemiring))))
                            (@HMul.hMul.{0, 0, 0} ENNReal ENNReal ENNReal
                              (@instHMul.{0} ENNReal
                                (@Distrib.toMul.{0} ENNReal
                                  (@instDistribOfSemiring.{0} ENNReal
                                    (@CommSemiring.toSemiring.{0} ENNReal ENNReal.instCommSemiring))))
                              (@HMul.hMul.{0, 0, 0} ENNReal ENNReal ENNReal
                                (@instHMul.{0} ENNReal
                                  (@Distrib.toMul.{0} ENNReal
                                    (@instDistribOfSemiring.{0} ENNReal
                                      (@CommSemiring.toSemiring.{0} ENNReal ENNReal.instCommSemiring))))
                                (@HPow.hPow.{0, 0, 0} ENNReal Real ENNReal
                                  (@instHPow.{0, 0} ENNReal Real ENNReal.instPowReal)
                                  (@OfNat.ofNat.{0} ENNReal (nat_lit 2)
                                    (@instOfNatAtLeastTwo.{0} ENNReal (nat_lit 2)
                                      (@AddMonoidWithOne.toNatCast.{0} ENNReal
                                        (@AddCommMonoidWithOne.toAddMonoidWithOne.{0} ENNReal
                                          ENNReal.instAddCommMonoidWithOne))
                                      ⋯))
                                  d)
                                ↑M)
                              c₁)
                            (@HPow.hPow.{0, 0, 0} ENNReal Real ENNReal
                              (@instHPow.{0, 0} ENNReal Real ENNReal.instPowReal)
                              (@HMul.hMul.{0, 0, 0} ENNReal ENNReal ENNReal
                                (@instHMul.{0} ENNReal
                                  (@Distrib.toMul.{0} ENNReal
                                    (@instDistribOfSemiring.{0} ENNReal
                                      (@CommSemiring.toSemiring.{0} ENNReal ENNReal.instCommSemiring))))
                                (@HMul.hMul.{0, 0, 0} ENNReal ENNReal ENNReal
                                  (@instHMul.{0} ENNReal
                                    (@Distrib.toMul.{0} ENNReal
                                      (@instDistribOfSemiring.{0} ENNReal
                                        (@CommSemiring.toSemiring.{0} ENNReal ENNReal.instCommSemiring))))
                                  (@OfNat.ofNat.{0} ENNReal (nat_lit 2)
                                    (@instOfNatAtLeastTwo.{0} ENNReal (nat_lit 2)
                                      (@AddMonoidWithOne.toNatCast.{0} ENNReal
                                        (@AddCommMonoidWithOne.toAddMonoidWithOne.{0} ENNReal
                                          ENNReal.instAddCommMonoidWithOne))
                                      ⋯))
                                  ↑ε₀)
                                (@HPow.hPow.{0, 0, 0} ENNReal Nat ENNReal
                                  (@instHPow.{0, 0} ENNReal Nat
                                    (@NPow.toPow.{0} ENNReal
                                      (@Monoid.toNPow.{0} ENNReal
                                        (@Semiring.toMonoid.{0} ENNReal
                                          (@CommSemiring.toSemiring.{0} ENNReal ENNReal.instCommSemiring)))))
                                  (@Inv.inv.{0} ENNReal ENNReal.instInv
                                    (@OfNat.ofNat.{0} ENNReal (nat_lit 2)
                                      (@instOfNatAtLeastTwo.{0} ENNReal (nat_lit 2)
                                        (@AddMonoidWithOne.toNatCast.{0} ENNReal
                                          (@AddCommMonoidWithOne.toAddMonoidWithOne.{0} ENNReal
                                            ENNReal.instAddCommMonoidWithOne))
                                        ⋯)))
                                  m))
                              (@HSub.hSub.{0, 0, 0} Real Real Real (@instHSub.{0} Real Real.instSub) q d)))
                          (ProbabilityTheory.Cp d p q)) :=
⋯
```

## `ProbabilityTheory.uniformContinuousOn_holderModification`

Command: `#print ProbabilityTheory.uniformContinuousOn_holderModification`

```lean
theorem ProbabilityTheory.uniformContinuousOn_holderModification.{u_1, u_2, u_3} : ∀ {T : Type u_1} {Ω : Type u_2}
  {E : Type u_3} {mΩ : MeasurableSpace.{u_2} Ω} {X : T → Ω → E} {c : ENNReal} {d p q : Real} {M β : NNReal}
  {P : @MeasureTheory.Measure.{u_2} Ω mΩ} {U : Set.{u_1} T} [inst : PseudoEMetricSpace.{u_1} T]
  [inst_1 : PseudoEMetricSpace.{u_3} E] [@CompleteSpace.{u_3} E (@PseudoEMetricSpace.toUniformSpace.{u_3} E inst_1)]
  [hE : Nonempty.{u_3 + 1} E]
  [inst_3 :
    @SecondCountableTopology.{u_1} T
      (@UniformSpace.toTopologicalSpace.{u_1} T (@PseudoEMetricSpace.toUniformSpace.{u_1} T inst))],
  @HasBoundedCoveringNumber.{u_1} T inst U c d →
    ∀
      [inst_4 :
        @DecidablePred.{u_1 + 1} T fun x =>
          @Membership.mem.{u_1, u_1} T (Set.{u_1} T) (@Set.instMembership.{u_1} T) U x],
      @IsOpen.{u_1} T (@UniformSpace.toTopologicalSpace.{u_1} T (@PseudoEMetricSpace.toUniformSpace.{u_1} T inst)) U →
        @ProbabilityTheory.IsKolmogorovProcess.{u_1, u_2, u_3} T Ω E inst mΩ inst_1 X P p q M →
          @LT.lt.{0} NNReal (@Preorder.toLT.{0} NNReal (@PartialOrder.toPreorder.{0} NNReal NNReal.instPartialOrder))
              (@OfNat.ofNat.{0} NNReal (nat_lit 0) (@Zero.toOfNat0.{0} NNReal NNReal.instZero)) β →
            ∀ (ω : Ω),
              @UniformContinuousOn.{u_1, u_3} T E (@PseudoEMetricSpace.toUniformSpace.{u_1} T inst)
                (@PseudoEMetricSpace.toUniformSpace.{u_3} E inst_1)
                (fun t =>
                  @ProbabilityTheory.holderModification.{u_1, u_2, u_3} T Ω E inst inst_1 hE inst_3 X β p U inst_4 t ω)
                U :=
⋯
```

## `ProbabilityTheory.uniformContinuousOn_of_mem_holderSet`

Command: `#print ProbabilityTheory.uniformContinuousOn_of_mem_holderSet`

```lean
theorem ProbabilityTheory.uniformContinuousOn_of_mem_holderSet.{u_1, u_2, u_3} : ∀ {T : Type u_1} {Ω : Type u_2}
  {E : Type u_3} {X : T → Ω → E} {c : ENNReal} {d p : Real} {β : NNReal} {U : Set.{u_1} T}
  [inst : PseudoEMetricSpace.{u_1} T] [inst_1 : PseudoEMetricSpace.{u_3} E],
  @HasBoundedCoveringNumber.{u_1} T inst U c d →
    @LT.lt.{0} Real Real.instLT (@OfNat.ofNat.{0} Real (nat_lit 0) (@Zero.toOfNat0.{0} Real Real.instZero)) p →
      @LT.lt.{0} NNReal (@Preorder.toLT.{0} NNReal (@PartialOrder.toPreorder.{0} NNReal NNReal.instPartialOrder))
          (@OfNat.ofNat.{0} NNReal (nat_lit 0) (@Zero.toOfNat0.{0} NNReal NNReal.instZero)) β →
        ∀ {T' : Set.{u_1} T} {ω : Ω},
          @Membership.mem.{u_2, u_2} Ω (Set.{u_2} Ω) (@Set.instMembership.{u_2} Ω)
              (@ProbabilityTheory.holderSet.{u_1, u_2, u_3} T Ω E inst inst_1 X T' p (↑β) U) ω →
            @UniformContinuousOn.{u_1, u_3} (@Set.Elem.{u_1} T T') E
              (@instUniformSpaceSubtype.{u_1} T
                (fun x => @Membership.mem.{u_1, u_1} T (Set.{u_1} T) (@Set.instMembership.{u_1} T) T' x)
                (@PseudoEMetricSpace.toUniformSpace.{u_1} T inst))
              (@PseudoEMetricSpace.toUniformSpace.{u_3} E inst_1)
              (fun t =>
                X
                  (@Subtype.val.{u_1 + 1} T
                    (fun x => @Membership.mem.{u_1, u_1} T (Set.{u_1} T) (@Set.instMembership.{u_1} T) T' x) t)
                  ω)
              (@setOf.{u_1} (@Set.Elem.{u_1} T T') fun x =>
                @Membership.mem.{u_1, u_1} T (Set.{u_1} T) (@Set.instMembership.{u_1} T) U
                  (@Subtype.val.{u_1 + 1} T
                    (fun x => @Membership.mem.{u_1, u_1} T (Set.{u_1} T) (@Set.instMembership.{u_1} T) T' x) x)) :=
⋯
```

## `PseudoEMetricSpace.boundedSpace_toPseudoMetricSpace`

Command: `#print PseudoEMetricSpace.boundedSpace_toPseudoMetricSpace`

```lean
theorem PseudoEMetricSpace.boundedSpace_toPseudoMetricSpace.{u_1} : ∀ {X : Type u_1} [inst : PseudoEMetricSpace.{u_1} X]
  {C : NNReal}
  (hX :
    ∀ (x y : X),
      @LE.le.{0} ENNReal ENNReal.instLE
        (@EDist.edist.{u_1} X
          (@WeakPseudoEMetricSpace.toEDist.{u_1} X
            (@UniformSpace.toTopologicalSpace.{u_1} X (@PseudoEMetricSpace.toUniformSpace.{u_1} X inst))
            (@PseudoEMetricSpace.toWeakPseudoEMetricSpace.{u_1} X inst))
          x y)
        ↑C),
  @BoundedSpace.{u_1} X
    (@PseudoMetricSpace.toBornology.{u_1} X (@PseudoEMetricSpace.toPseudoMetricSpace.{u_1} X inst ⋯)) :=
⋯
```

## `TotallyBounded.coveringNumber_ne_top`

Command: `#print TotallyBounded.coveringNumber_ne_top`

```lean
theorem TotallyBounded.coveringNumber_ne_top.{u_1} : ∀ {E : Type u_1} [inst : PseudoEMetricSpace.{u_1} E]
  {A : Set.{u_1} E},
  @TotallyBounded.{u_1} E (@PseudoEMetricSpace.toUniformSpace.{u_1} E inst) A →
    ∀ {r : NNReal},
      @Ne.{1} NNReal r (@OfNat.ofNat.{0} NNReal (nat_lit 0) (@Zero.toOfNat0.{0} NNReal NNReal.instZero)) →
        @Ne.{1} ENat (@Metric.coveringNumber.{u_1} E inst r A) (@Top.top.{0} ENat instTopENat) :=
⋯
```

## `UniformContinuousOn.exists_tendsto`

Command: `#print UniformContinuousOn.exists_tendsto`

```lean
theorem UniformContinuousOn.exists_tendsto.{u_1, u_2} : ∀ {α : Type u_1} {β : Type u_2} [inst : UniformSpace.{u_1} α]
  [@FirstCountableTopology.{u_1} α (@UniformSpace.toTopologicalSpace.{u_1} α inst)] [inst_2 : UniformSpace.{u_2} β]
  [@CompleteSpace.{u_2} β inst_2] {s t : Set.{u_1} α},
  @Dense.{u_1} α (@UniformSpace.toTopologicalSpace.{u_1} α inst) s →
    @IsOpen.{u_1} α (@UniformSpace.toTopologicalSpace.{u_1} α inst) t →
      ∀ {f : @Set.Elem.{u_1} α s → β},
        @UniformContinuousOn.{u_1, u_2} (@Set.Elem.{u_1} α s) β
            (@instUniformSpaceSubtype.{u_1} α
              (fun x => @Membership.mem.{u_1, u_1} α (Set.{u_1} α) (@Set.instMembership.{u_1} α) s x) inst)
            inst_2 f
            (@setOf.{u_1} (@Set.Elem.{u_1} α s) fun x =>
              @Membership.mem.{u_1, u_1} α (Set.{u_1} α) (@Set.instMembership.{u_1} α) t
                (@Subtype.val.{u_1 + 1} α
                  (fun x => @Membership.mem.{u_1, u_1} α (Set.{u_1} α) (@Set.instMembership.{u_1} α) s x) x)) →
          ∀ (a : α),
            @Membership.mem.{u_1, u_1} α (Set.{u_1} α) (@Set.instMembership.{u_1} α) t a →
              ∃ c,
                @Filter.Tendsto.{u_1, u_2} (@Set.Elem.{u_1} α s) β f
                  (@Filter.comap.{u_1, u_1} (@Set.Elem.{u_1} α s) α
                    (@Subtype.val.{u_1 + 1} α fun x =>
                      @Membership.mem.{u_1, u_1} α (Set.{u_1} α) (@Set.instMembership.{u_1} α) s x)
                    (@nhds.{u_1} α (@UniformSpace.toTopologicalSpace.{u_1} α inst) a))
                  (@nhds.{u_2} β (@UniformSpace.toTopologicalSpace.{u_2} β inst_2) c) :=
⋯
```

## `chainingSequence.eq_1`

Command: `#print chainingSequence.eq_1`

```lean
@[backward_defeq] theorem chainingSequence.eq_1.{u_1} : ∀ {E : Type u_1} [inst : PseudoEMetricSpace.{u_1} E]
  (C : Nat → Finset.{u_1} E) (x : E) (k n : Nat),
  @Eq.{u_1 + 1} E (@chainingSequence.{u_1} E inst C x k n)
    (@ite.{u_1 + 1} E (@LE.le.{0} Nat instLENat n k) (n.decLe k)
      (@chainingSequenceReverse.{u_1} E inst C x k
        (@HSub.hSub.{0, 0, 0} Nat Nat Nat (@instHSub.{0} Nat instSubNat) k n))
      x) :=
⋯
```

## `chainingSequenceReverse._f`

Command: `#print chainingSequenceReverse._f`

```lean
@[reducible] def chainingSequenceReverse._f.{u_1} : {E : Type u_1} →
  [PseudoEMetricSpace.{u_1} E] →
    (Nat → Finset.{u_1} E) → E → Nat → (x : Nat) → @Nat.below.{u_1 + 1} (fun x => E) x → E :=
fun {E} [inst : PseudoEMetricSpace.{u_1} E] C x k x_1 f =>
  chainingSequenceReverse.match_1.{u_1 + 1} (fun x => @Nat.below.{u_1 + 1} (fun x => E) x → E) x_1 (fun _ x_2 => x)
    (fun n x =>
      @nearestPt.{u_1} E
        (@WeakPseudoEMetricSpace.toEDist.{u_1} E
          (@UniformSpace.toTopologicalSpace.{u_1} E (@PseudoEMetricSpace.toUniformSpace.{u_1} E inst))
          (@PseudoEMetricSpace.toWeakPseudoEMetricSpace.{u_1} E inst))
        (C
          (@HSub.hSub.{0, 0, 0} Nat Nat Nat (@instHSub.{0} Nat instSubNat) k
            (@HAdd.hAdd.{0, 0, 0} Nat Nat Nat (@instHAdd.{0} Nat instAddNat) n
              (@OfNat.ofNat.{0} Nat (nat_lit 1) (instOfNatNat (nat_lit 1))))))
        x.1)
    f
```

## `chainingSequenceReverse.match_1`

Command: `#print chainingSequenceReverse.match_1`

```lean
@[implicit_reducible] def chainingSequenceReverse.match_1.{u_1} : (motive : Nat → Sort u_1) →
  (x : Nat) →
    (Unit → motive (@OfNat.ofNat.{0} Nat (nat_lit 0) (instOfNatNat (nat_lit 0)))) →
      ((n : Nat) → motive n.succ) → motive x :=
fun motive x h_1 h_2 => @Nat.casesOn.{u_1} (fun x => motive x) x (h_1 Unit.unit) fun n => h_2 n
```

## `denseCountable._proof_1`

Command: `#print denseCountable._proof_1`

```lean
theorem denseCountable._proof_1.{u_1} : ∀ (T : Type u_1) [inst : TopologicalSpace.{u_1} T]
  [@SecondCountableTopology.{u_1} T inst], ∃ s, And (@Set.Countable.{u_1} T s) (@Dense.{u_1} T inst s) :=
⋯
```

## `indexProj._proof_1`

Command: `#print indexProj._proof_1`

```lean
theorem indexProj._proof_1.{u_1, u_2} : ∀ {ι : Type u_1} {α : ι → Type u_2}
  [inst : (i : ι) → TopologicalSpace.{u_2} (α i)] {s : Nat → Set.{max u_1 u_2} ((i : ι) → α i)}
  (hs :
    ∀ (n : Nat),
      @Membership.mem.{max u_1 u_2, max u_1 u_2} (Set.{max u_1 u_2} ((i : ι) → α i))
        (Set.{max u_1 u_2} (Set.{max u_1 u_2} ((i : ι) → α i)))
        (@Set.instMembership.{max u_1 u_2} (Set.{max u_1 u_2} ((i : ι) → α i)))
        (@MeasureTheory.closedCompactCylinders.{u_1, u_2} ι α inst) (s n))
  (i : @Set.Elem.{u_1} ι (@allProj.{u_1, u_2} ι α inst s hs)),
  ∃ n,
    @Membership.mem.{u_1, u_1} ι (Finset.{u_1} ι)
      (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} ι) ι (@Finset.instSetLike.{u_1} ι))
      (@MeasureTheory.closedCompactCylinders.finset.{u_1, u_2} ι α inst (s n) ⋯)
      (@Subtype.val.{u_1 + 1} ι
        (fun x =>
          @Membership.mem.{u_1, u_1} ι (Set.{u_1} ι) (@Set.instMembership.{u_1} ι) (@allProj.{u_1, u_2} ι α inst s hs)
            x)
        i) :=
⋯
```

## `nearestPt._proof_1`

Command: `#print nearestPt._proof_1`

```lean
theorem nearestPt._proof_1.{u_1} : ∀ {E : Type u_1} [inst : EDist.{u_1} E] (s : Finset.{u_1} E) (x : E),
  @Finset.Nonempty.{u_1} E s →
    ∃ x_1,
      And
        (@Membership.mem.{u_1, u_1} E (Finset.{u_1} E)
          (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} E) E (@Finset.instSetLike.{u_1} E)) s x_1)
        (∀ (x' : E),
          @Membership.mem.{u_1, u_1} E (Finset.{u_1} E)
              (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} E) E (@Finset.instSetLike.{u_1} E)) s x' →
            @LE.le.{0} ENNReal
              (@Preorder.toLE.{0} ENNReal
                (@PartialOrder.toPreorder.{0} ENNReal
                  (@SemilatticeInf.toPartialOrder.{0} ENNReal
                    (@Lattice.toSemilatticeInf.{0} ENNReal
                      (@DistribLattice.toLattice.{0} ENNReal
                        (@instDistribLatticeOfLinearOrder.{0} ENNReal ENNReal.instLinearOrder))))))
              (@EDist.edist.{u_1} E inst x x_1) (@EDist.edist.{u_1} E inst x x')) :=
⋯
```

## `nearestPt.eq_1`

Command: `#print nearestPt.eq_1`

```lean
@[backward_defeq] theorem nearestPt.eq_1.{u_1} : ∀ {E : Type u_1} [inst : EDist.{u_1} E] (s : Finset.{u_1} E) (x : E),
  @Eq.{u_1 + 1} E (@nearestPt.{u_1} E inst s x)
    (@dite.{u_1 + 1} E (@Finset.Nonempty.{u_1} E s) (@Finset.decidableNonempty.{u_1} E s)
      (fun hs =>
        @Exists.choose.{u_1 + 1} E
          (fun x_1 =>
            And
              (@Membership.mem.{u_1, u_1} E (Finset.{u_1} E)
                (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} E) E (@Finset.instSetLike.{u_1} E)) s x_1)
              (∀ (x' : E),
                @Membership.mem.{u_1, u_1} E (Finset.{u_1} E)
                    (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} E) E (@Finset.instSetLike.{u_1} E)) s x' →
                  @LE.le.{0} ENNReal
                    (@Preorder.toLE.{0} ENNReal
                      (@PartialOrder.toPreorder.{0} ENNReal
                        (@SemilatticeInf.toPartialOrder.{0} ENNReal
                          (@Lattice.toSemilatticeInf.{0} ENNReal
                            (@DistribLattice.toLattice.{0} ENNReal
                              (@instDistribLatticeOfLinearOrder.{0} ENNReal ENNReal.instLinearOrder))))))
                    (@EDist.edist.{u_1} E inst x x_1) (@EDist.edist.{u_1} E inst x x')))
          ⋯)
      fun hs => x) :=
⋯
```

## `piCylinderSet._proof_1`

Command: `#print piCylinderSet._proof_1`

```lean
theorem piCylinderSet._proof_1.{u_1, u_2} : ∀ {ι : Type u_1} {α : ι → Type u_2}
  [inst : (i : ι) → TopologicalSpace.{u_2} (α i)] {s : Nat → Set.{max u_1 u_2} ((i : ι) → α i)}
  (hs :
    ∀ (n : Nat),
      @Membership.mem.{max u_1 u_2, max u_1 u_2} (Set.{max u_1 u_2} ((i : ι) → α i))
        (Set.{max u_1 u_2} (Set.{max u_1 u_2} ((i : ι) → α i)))
        (@Set.instMembership.{max u_1 u_2} (Set.{max u_1 u_2} ((i : ι) → α i)))
        (@MeasureTheory.closedCompactCylinders.{u_1, u_2} ι α inst) (s n))
  (i : @Set.Elem.{u_1} ι (@allProj.{u_1, u_2} ι α inst s hs)),
  @Membership.mem.{max u_1 u_2, max u_1 u_2} (Set.{max u_1 u_2} ((i : ι) → α i))
    (Set.{max u_1 u_2} (Set.{max u_1 u_2} ((i : ι) → α i)))
    (@Set.instMembership.{max u_1 u_2} (Set.{max u_1 u_2} ((i : ι) → α i)))
    (@MeasureTheory.closedCompactCylinders.{u_1, u_2} ι α inst) (s (@indexProj.{u_1, u_2} ι α inst s hs i)) :=
⋯
```

## `projCylinder._proof_1`

Command: `#print projCylinder._proof_1`

```lean
theorem projCylinder._proof_1.{u_1, u_2} : ∀ {ι : Type u_1} {α : ι → Type u_2}
  [inst : (i : ι) → TopologicalSpace.{u_2} (α i)] {s : Nat → Set.{max u_1 u_2} ((i : ι) → α i)}
  (hs :
    ∀ (n : Nat),
      @Membership.mem.{max u_1 u_2, max u_1 u_2} (Set.{max u_1 u_2} ((i : ι) → α i))
        (Set.{max u_1 u_2} (Set.{max u_1 u_2} ((i : ι) → α i)))
        (@Set.instMembership.{max u_1 u_2} (Set.{max u_1 u_2} ((i : ι) → α i)))
        (@MeasureTheory.closedCompactCylinders.{u_1, u_2} ι α inst) (s n))
  (n : Nat) (i : ↥(@MeasureTheory.closedCompactCylinders.finset.{u_1, u_2} ι α inst (s n) ⋯)),
  @Membership.mem.{u_1, u_1} ι (Set.{u_1} ι) (@Set.instMembership.{u_1} ι) (@allProj.{u_1, u_2} ι α inst s hs)
    (@Subtype.val.{u_1 + 1} ι
      (fun x =>
        @Membership.mem.{u_1, u_1} ι (Finset.{u_1} ι)
          (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} ι) ι (@Finset.instSetLike.{u_1} ι))
          (@MeasureTheory.closedCompactCylinders.finset.{u_1, u_2} ι α inst (s n) ⋯) x)
      i) :=
⋯
```

## `_private.KolmogorovExtension4.CompactSystem.0.exists_nat_proj._simp_1_2`

Command: `#print _private.KolmogorovExtension4.CompactSystem.0.exists_nat_proj._simp_1_2`

```lean
private theorem exists_nat_proj._simp_1_2.{u, v} : ∀ {α : Type u} {ι : Sort v} {x : α} {s : ι → Set.{u} α},
  @Eq.{1} Prop (@Membership.mem.{u, u} α (Set.{u} α) (@Set.instMembership.{u} α) (⋃ i, s i) x)
    (∃ i, @Membership.mem.{u, u} α (Set.{u} α) (@Set.instMembership.{u} α) (s i) x) :=
⋯
```

## `_private.KolmogorovExtension4.CompactSystem.0.exists_nat_proj._simp_1_3`

Command: `#print _private.KolmogorovExtension4.CompactSystem.0.exists_nat_proj._simp_1_3`

```lean
private theorem exists_nat_proj._simp_1_3.{u_1} : ∀ {α : Type u_1} {a : α} {s : Finset.{u_1} α},
  @Eq.{1} Prop
    (@Membership.mem.{u_1, u_1} α (Set.{u_1} α) (@Set.instMembership.{u_1} α)
      (@SetLike.coe.{u_1, u_1} (Finset.{u_1} α) α (@Finset.instSetLike.{u_1} α) s) a)
    (@Membership.mem.{u_1, u_1} α (Finset.{u_1} α)
      (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} α) α (@Finset.instSetLike.{u_1} α)) s a) :=
⋯
```

## `_private.KolmogorovExtension4.CompactSystem.0.isCompactSystem_closedCompactCylinders._simp_1_1`

Command: `#print _private.KolmogorovExtension4.CompactSystem.0.isCompactSystem_closedCompactCylinders._simp_1_1`

```lean
private theorem isCompactSystem_closedCompactCylinders._simp_1_1.{u_1, u_2, u_5} : ∀ {α : Type u_1} {β : Type u_2}
  {ι : Sort u_5} {f : α → β} {s : ι → Set.{u_2} β},
  @Eq.{u_1 + 1} (Set.{u_1} α) (⋂ i, @Set.preimage.{u_1, u_2} α β f (s i)) (@Set.preimage.{u_1, u_2} α β f (⋂ i, s i)) :=
⋯
```

## `_private.KolmogorovExtension4.CompactSystem.0.mem_piCylinderSet._simp_1_2`

Command: `#print _private.KolmogorovExtension4.CompactSystem.0.mem_piCylinderSet._simp_1_2`

```lean
private theorem mem_piCylinderSet._simp_1_2.{u, v} : ∀ {α : Type u} {β : Type v} (f : α → β) (s : Set.{u} α) (y : β),
  @Eq.{1} Prop (@Membership.mem.{v, v} β (Set.{v} β) (@Set.instMembership.{v} β) (@Set.image.{u, v} α β f s) y)
    (∃ x, And (@Membership.mem.{u, u} α (Set.{u} α) (@Set.instMembership.{u} α) s x) (@Eq.{v + 1} β (f x) y)) :=
⋯
```

## `_private.KolmogorovExtension4.CompactSystem.0.mem_piCylinderSet._simp_1_3`

Command: `#print _private.KolmogorovExtension4.CompactSystem.0.mem_piCylinderSet._simp_1_3`

```lean
private theorem mem_piCylinderSet._simp_1_3.{u} : ∀ {α : Sort u} {p : α → Prop}
  {q : (@Subtype.{u} α fun a => p a) → Prop},
  @Eq.{1} Prop (∀ (x : @Subtype.{u} α fun a => p a), q x)
    (∀ (a : α) (b : p a), q (@Subtype.mk.{u} α (fun a => p a) a b)) :=
⋯
```

## `_private.KolmogorovExtension4.CompactSystem.0.mem_projCylinder._simp_1_2`

Command: `#print _private.KolmogorovExtension4.CompactSystem.0.mem_projCylinder._simp_1_2`

```lean
private theorem mem_projCylinder._simp_1_2.{u, v} : ∀ {α : Type u} {β : Type v} {f : α → β} {s : Set.{v} β} {a : α},
  @Eq.{1} Prop (@Membership.mem.{u, u} α (Set.{u} α) (@Set.instMembership.{u} α) (@Set.preimage.{u, v} α β f s) a)
    (@Membership.mem.{v, v} β (Set.{v} β) (@Set.instMembership.{v} β) s (f a)) :=
⋯
```

## `_private.KolmogorovExtension4.CompactSystem.0.nonempty_iInter_projCylinder._simp_1_1`

Command: `#print _private.KolmogorovExtension4.CompactSystem.0.nonempty_iInter_projCylinder._simp_1_1`

```lean
private theorem nonempty_iInter_projCylinder._simp_1_1.{u, v} : ∀ {α : Type u} {ι : Sort v} {x : α} {s : ι → Set.{u} α},
  @Eq.{1} Prop (@Membership.mem.{u, u} α (Set.{u} α) (@Set.instMembership.{u} α) (⋂ i, s i) x)
    (∀ (i : ι), @Membership.mem.{u, u} α (Set.{u} α) (@Set.instMembership.{u} α) (s i) x) :=
⋯
```

## `_private.KolmogorovExtension4.CompactSystem.0.nonempty_iInter_projCylinder_inter_piCylinderSet._simp_1_1`

Command: `#print _private.KolmogorovExtension4.CompactSystem.0.nonempty_iInter_projCylinder_inter_piCylinderSet._simp_1_1`

```lean
private theorem nonempty_iInter_projCylinder_inter_piCylinderSet._simp_1_1.{u, v} : ∀ {α : Type u} {ι : Sort v} {x : α}
  {s : ι → Set.{u} α},
  @Eq.{1} Prop (@Membership.mem.{u, u} α (Set.{u} α) (@Set.instMembership.{u} α) (⋂ i, s i) x)
    (∀ (i : ι), @Membership.mem.{u, u} α (Set.{u} α) (@Set.instMembership.{u} α) (s i) x) :=
⋯
```

## `_private.KolmogorovExtension4.CompactSystem.0.nonempty_iInter_projCylinder_inter_piCylinderSet._simp_1_2`

Command: `#print _private.KolmogorovExtension4.CompactSystem.0.nonempty_iInter_projCylinder_inter_piCylinderSet._simp_1_2`

```lean
private theorem nonempty_iInter_projCylinder_inter_piCylinderSet._simp_1_2.{u_1, u_2} : ∀ {ι : Type u_1}
  {α : ι → Type u_2} [inst : (i : ι) → TopologicalSpace.{u_2} (α i)] {s : Nat → Set.{max u_1 u_2} ((i : ι) → α i)}
  (hs :
    ∀ (n : Nat),
      @Membership.mem.{max u_1 u_2, max u_1 u_2} (Set.{max u_1 u_2} ((i : ι) → α i))
        (Set.{max u_1 u_2} (Set.{max u_1 u_2} ((i : ι) → α i)))
        (@Set.instMembership.{max u_1 u_2} (Set.{max u_1 u_2} ((i : ι) → α i)))
        (@MeasureTheory.closedCompactCylinders.{u_1, u_2} ι α inst) (s n))
  (n : Nat)
  (x :
    (i : @Set.Elem.{u_1} ι (@allProj.{u_1, u_2} ι α inst s hs)) →
      α
        (@Subtype.val.{u_1 + 1} ι
          (fun x =>
            @Membership.mem.{u_1, u_1} ι (Set.{u_1} ι) (@Set.instMembership.{u_1} ι) (@allProj.{u_1, u_2} ι α inst s hs)
              x)
          i)),
  @Eq.{1} Prop
    (@Membership.mem.{max u_1 u_2, max u_1 u_2}
      ((i : @Set.Elem.{u_1} ι (@allProj.{u_1, u_2} ι α inst s hs)) →
        α
          (@Subtype.val.{u_1 + 1} ι
            (fun x =>
              @Membership.mem.{u_1, u_1} ι (Set.{u_1} ι) (@Set.instMembership.{u_1} ι)
                (@allProj.{u_1, u_2} ι α inst s hs) x)
            i))
      (Set.{max u_1 u_2}
        ((i : @Set.Elem.{u_1} ι (@allProj.{u_1, u_2} ι α inst s hs)) →
          α
            (@Subtype.val.{u_1 + 1} ι
              (fun x =>
                @Membership.mem.{u_1, u_1} ι (Set.{u_1} ι) (@Set.instMembership.{u_1} ι)
                  (@allProj.{u_1, u_2} ι α inst s hs) x)
              i)))
      (@Set.instMembership.{max u_1 u_2}
        ((i : @Set.Elem.{u_1} ι (@allProj.{u_1, u_2} ι α inst s hs)) →
          α
            (@Subtype.val.{u_1 + 1} ι
              (fun x =>
                @Membership.mem.{u_1, u_1} ι (Set.{u_1} ι) (@Set.instMembership.{u_1} ι)
                  (@allProj.{u_1, u_2} ι α inst s hs) x)
              i)))
      (@projCylinder.{u_1, u_2} ι α inst s hs n) x)
    (@Membership.mem.{max u_1 u_2, max u_1 u_2}
      ((i : ↥(@MeasureTheory.closedCompactCylinders.finset.{u_1, u_2} ι α inst (s n) ⋯)) →
        α
          (@Subtype.val.{u_1 + 1} ι
            (fun x =>
              @Membership.mem.{u_1, u_1} ι (Set.{u_1} ι) (@Set.instMembership.{u_1} ι)
                (@allProj.{u_1, u_2} ι α inst s hs) x)
            (@Subtype.mk.{u_1 + 1} ι
              (fun x =>
                @Membership.mem.{u_1, u_1} ι (Set.{u_1} ι) (@Set.instMembership.{u_1} ι)
                  (@allProj.{u_1, u_2} ι α inst s hs) x)
              (@Subtype.val.{u_1 + 1} ι
                (fun x =>
                  @Membership.mem.{u_1, u_1} ι (Finset.{u_1} ι)
                    (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} ι) ι (@Finset.instSetLike.{u_1} ι))
                    (@MeasureTheory.closedCompactCylinders.finset.{u_1, u_2} ι α inst (s n) ⋯) x)
                i)
              ⋯)))
      (Set.{max u_1 u_2}
        ((i : ↥(@MeasureTheory.closedCompactCylinders.finset.{u_1, u_2} ι α inst (s n) ⋯)) →
          α
            (@Subtype.val.{u_1 + 1} ι
              (fun x =>
                @Membership.mem.{u_1, u_1} ι (Finset.{u_1} ι)
                  (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} ι) ι (@Finset.instSetLike.{u_1} ι))
                  (@MeasureTheory.closedCompactCylinders.finset.{u_1, u_2} ι α inst (s n) ⋯) x)
              i)))
      (@Set.instMembership.{max u_1 u_2}
        ((i : ↥(@MeasureTheory.closedCompactCylinders.finset.{u_1, u_2} ι α inst (s n) ⋯)) →
          α
            (@Subtype.val.{u_1 + 1} ι
              (fun x =>
                @Membership.mem.{u_1, u_1} ι (Finset.{u_1} ι)
                  (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} ι) ι (@Finset.instSetLike.{u_1} ι))
                  (@MeasureTheory.closedCompactCylinders.finset.{u_1, u_2} ι α inst (s n) ⋯) x)
              i)))
      (@MeasureTheory.closedCompactCylinders.set.{u_1, u_2} ι α inst (s n) ⋯) fun i =>
      x
        (@Subtype.mk.{u_1 + 1} ι
          (fun x =>
            @Membership.mem.{u_1, u_1} ι (Set.{u_1} ι) (@Set.instMembership.{u_1} ι) (@allProj.{u_1, u_2} ι α inst s hs)
              x)
          (@Subtype.val.{u_1 + 1} ι
            (fun x =>
              @Membership.mem.{u_1, u_1} ι (Finset.{u_1} ι)
                (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} ι) ι (@Finset.instSetLike.{u_1} ι))
                (@MeasureTheory.closedCompactCylinders.finset.{u_1, u_2} ι α inst (s n) ⋯) x)
            i)
          ⋯)) :=
⋯
```

## `_private.KolmogorovExtension4.CompactSystem.0.nonempty_piCylinderSet._simp_1_2`

Command: `#print _private.KolmogorovExtension4.CompactSystem.0.nonempty_piCylinderSet._simp_1_2`

```lean
private theorem nonempty_piCylinderSet._simp_1_2.{u, v} : ∀ {α : Type u} {β : Type v} (f : α → β) (s : Set.{u} α)
  (y : β),
  @Eq.{1} Prop (@Membership.mem.{v, v} β (Set.{v} β) (@Set.instMembership.{v} β) (@Set.image.{u, v} α β f s) y)
    (∃ x, And (@Membership.mem.{u, u} α (Set.{u} α) (@Set.instMembership.{u} α) s x) (@Eq.{v + 1} β (f x) y)) :=
⋯
```

## `_private.KolmogorovExtension4.CompactSystem.0.nonempty_piCylinderSet._simp_1_3`

Command: `#print _private.KolmogorovExtension4.CompactSystem.0.nonempty_piCylinderSet._simp_1_3`

```lean
private theorem nonempty_piCylinderSet._simp_1_3.{u} : ∀ {α : Type u} {s : Set.{u} α} {p : @Set.Elem.{u} α s → Prop},
  @Eq.{1} Prop (∀ (x : @Set.Elem.{u} α s), p x)
    (∀ (x : α) (h : @Membership.mem.{u, u} α (Set.{u} α) (@Set.instMembership.{u} α) s x),
      p (@Subtype.mk.{u + 1} α (fun x => @Membership.mem.{u, u} α (Set.{u} α) (@Set.instMembership.{u} α) s x) x h)) :=
⋯
```

## `_private.KolmogorovExtension4.CompactSystem.0.nonempty_projCylinder_iff._simp_1_1`

Command: `#print _private.KolmogorovExtension4.CompactSystem.0.nonempty_projCylinder_iff._simp_1_1`

```lean
private theorem nonempty_projCylinder_iff._simp_1_1.{u_1} : ∀ {α : Type u_1} {s : Finset.{u_1} α}
  (x : @Set.Elem.{u_1} α (@SetLike.coe.{u_1, u_1} (Finset.{u_1} α) α (@Finset.instSetLike.{u_1} α) s)),
  @Eq.{1} Prop
    (@Membership.mem.{u_1, u_1} α (Finset.{u_1} α)
      (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} α) α (@Finset.instSetLike.{u_1} α)) s
      (@Subtype.val.{u_1 + 1} α
        (fun x =>
          @Membership.mem.{u_1, u_1} α (Set.{u_1} α) (@Set.instMembership.{u_1} α)
            (@SetLike.coe.{u_1, u_1} (Finset.{u_1} α) α (@Finset.instSetLike.{u_1} α) s) x)
        x))
    True :=
⋯
```

## `_private.KolmogorovExtension4.CompactSystem.0.piCylinderSet_eq_pi_univ._simp_1_2`

Command: `#print _private.KolmogorovExtension4.CompactSystem.0.piCylinderSet_eq_pi_univ._simp_1_2`

```lean
private theorem piCylinderSet_eq_pi_univ._simp_1_2.{u_1, u_2} : ∀ {ι : Type u_1} {α : ι → Type u_2}
  {t : (i : ι) → Set.{u_2} (α i)} {f : (i : ι) → α i},
  @Eq.{1} Prop
    (@Membership.mem.{max u_1 u_2, max u_2 u_1} ((i : ι) → α i) (Set.{max u_1 u_2} ((i : ι) → α i))
      (@Set.instMembership.{max u_1 u_2} ((i : ι) → α i)) (@Set.pi.{u_1, u_2} ι α (@Set.univ.{u_1} ι) t) f)
    (∀ (i : ι), @Membership.mem.{u_2, u_2} (α i) (Set.{u_2} (α i)) (@Set.instMembership.{u_2} (α i)) (t i) (f i)) :=
⋯
```

## `_private.BrownianMotion.Continuity.Chaining.0.chainingSequenceReverse_of_pos._proof_1_1`

Command: `#print _private.BrownianMotion.Continuity.Chaining.0.chainingSequenceReverse_of_pos._proof_1_1`

```lean
private theorem chainingSequenceReverse_of_pos._proof_1_1 : ∀ {n : Nat},
  @LT.lt.{0} Nat instLTNat (@OfNat.ofNat.{0} Nat (nat_lit 0) (instOfNatNat (nat_lit 0))) n →
    Not
        (@Eq.{1} Nat n
          (@HAdd.hAdd.{0, 0, 0} Nat Nat Nat (@instHAdd.{0} Nat instAddNat)
            (@HSub.hSub.{0, 0, 0} Nat Nat Nat (@instHSub.{0} Nat instSubNat) n
              (@OfNat.ofNat.{0} Nat (nat_lit 1) (instOfNatNat (nat_lit 1))))
            (@OfNat.ofNat.{0} Nat (nat_lit 1) (instOfNatNat (nat_lit 1))))) →
      False :=
⋯
```

## `_private.BrownianMotion.Continuity.Chaining.0.chainingSequence_chainingSequence._proof_1_1`

Command: `#print _private.BrownianMotion.Continuity.Chaining.0.chainingSequence_chainingSequence._proof_1_1`

```lean
private theorem chainingSequence_chainingSequence._proof_1_1 : ∀ {k : Nat} (l m : Nat),
  Not
      (@LT.lt.{0} Nat instLTNat m
        (@HAdd.hAdd.{0, 0, 0} Nat Nat Nat (@instHAdd.{0} Nat instAddNat) m
          (@HAdd.hAdd.{0, 0, 0} Nat Nat Nat (@instHAdd.{0} Nat instAddNat) l
            (@OfNat.ofNat.{0} Nat (nat_lit 1) (instOfNatNat (nat_lit 1)))))) →
    False :=
⋯
```

## `_private.BrownianMotion.Continuity.Chaining.0.chainingSequence_chainingSequence._proof_1_2`

Command: `#print _private.BrownianMotion.Continuity.Chaining.0.chainingSequence_chainingSequence._proof_1_2`

```lean
private theorem chainingSequence_chainingSequence._proof_1_2 : ∀ {k : Nat} (l m : Nat),
  @LE.le.{0} Nat instLENat
      (@HAdd.hAdd.{0, 0, 0} Nat Nat Nat (@instHAdd.{0} Nat instAddNat) m
        (@HAdd.hAdd.{0, 0, 0} Nat Nat Nat (@instHAdd.{0} Nat instAddNat) l
          (@OfNat.ofNat.{0} Nat (nat_lit 1) (instOfNatNat (nat_lit 1)))))
      k →
    Not (@LT.lt.{0} Nat instLTNat m k) → False :=
⋯
```

## `_private.BrownianMotion.Continuity.Chaining.0.chainingSequence_chainingSequence._proof_1_3`

Command: `#print _private.BrownianMotion.Continuity.Chaining.0.chainingSequence_chainingSequence._proof_1_3`

```lean
private theorem chainingSequence_chainingSequence._proof_1_3 : ∀ {k : Nat} (l m : Nat),
  @LE.le.{0} Nat instLENat
      (@HAdd.hAdd.{0, 0, 0} Nat Nat Nat (@instHAdd.{0} Nat instAddNat) m
        (@HAdd.hAdd.{0, 0, 0} Nat Nat Nat (@instHAdd.{0} Nat instAddNat) l
          (@OfNat.ofNat.{0} Nat (nat_lit 1) (instOfNatNat (nat_lit 1)))))
      k →
    Not
        (@LE.le.{0} Nat instLENat
          (@HAdd.hAdd.{0, 0, 0} Nat Nat Nat (@instHAdd.{0} Nat instAddNat)
            (@HAdd.hAdd.{0, 0, 0} Nat Nat Nat (@instHAdd.{0} Nat instAddNat) m
              (@OfNat.ofNat.{0} Nat (nat_lit 1) (instOfNatNat (nat_lit 1))))
            l)
          k) →
      False :=
⋯
```

## `_private.BrownianMotion.Continuity.Chaining.0.chainingSequence_mem._proof_1_2`

Command: `#print _private.BrownianMotion.Continuity.Chaining.0.chainingSequence_mem._proof_1_2`

```lean
private theorem chainingSequence_mem._proof_1_2 : ∀ {k : Nat} (n : Nat),
  @LE.le.{0} Nat instLENat n k →
    Not
        (@Eq.{1} Nat n
          (@HSub.hSub.{0, 0, 0} Nat Nat Nat (@instHSub.{0} Nat instSubNat) k
            (@HSub.hSub.{0, 0, 0} Nat Nat Nat (@instHSub.{0} Nat instSubNat) k n))) →
      False :=
⋯
```

## `_private.BrownianMotion.Continuity.Chaining.0.chainingSequence_of_lt._proof_1_2`

Command: `#print _private.BrownianMotion.Continuity.Chaining.0.chainingSequence_of_lt._proof_1_2`

```lean
private theorem chainingSequence_of_lt._proof_1_2 : ∀ {k n : Nat},
  @LT.lt.{0} Nat instLTNat n k → Not (@LE.le.{0} Nat instLENat n k) → False :=
⋯
```

## `_private.BrownianMotion.Continuity.Chaining.0.chainingSequence_of_lt._proof_1_3`

Command: `#print _private.BrownianMotion.Continuity.Chaining.0.chainingSequence_of_lt._proof_1_3`

```lean
private theorem chainingSequence_of_lt._proof_1_3 : ∀ {k n : Nat},
  @LT.lt.{0} Nat instLTNat n k →
    Not
        (@LT.lt.{0} Nat instLTNat (@OfNat.ofNat.{0} Nat (nat_lit 0) (instOfNatNat (nat_lit 0)))
          (@HSub.hSub.{0, 0, 0} Nat Nat Nat (@instHSub.{0} Nat instSubNat) k n)) →
      False :=
⋯
```

## `_private.BrownianMotion.Continuity.Chaining.0.chainingSequence_of_lt._proof_1_4`

Command: `#print _private.BrownianMotion.Continuity.Chaining.0.chainingSequence_of_lt._proof_1_4`

```lean
private theorem chainingSequence_of_lt._proof_1_4 : ∀ {k n : Nat},
  @LT.lt.{0} Nat instLTNat n k →
    Not
        (@LE.le.{0} Nat instLENat
          (@HAdd.hAdd.{0, 0, 0} Nat Nat Nat (@instHAdd.{0} Nat instAddNat) n
            (@OfNat.ofNat.{0} Nat (nat_lit 1) (instOfNatNat (nat_lit 1))))
          k) →
      False :=
⋯
```

## `_private.BrownianMotion.Continuity.Chaining.0.chainingSequence_of_lt._proof_1_5`

Command: `#print _private.BrownianMotion.Continuity.Chaining.0.chainingSequence_of_lt._proof_1_5`

```lean
private theorem chainingSequence_of_lt._proof_1_5 : ∀ {k n : Nat},
  @LT.lt.{0} Nat instLTNat n k →
    Not
        (@Eq.{1} Nat
          (@HSub.hSub.{0, 0, 0} Nat Nat Nat (@instHSub.{0} Nat instSubNat) k
            (@HSub.hSub.{0, 0, 0} Nat Nat Nat (@instHSub.{0} Nat instSubNat) k n))
          n) →
      False :=
⋯
```

## `_private.BrownianMotion.Continuity.Chaining.0.edist_chainingSequence_add_one._proof_1_1`

Command: `#print _private.BrownianMotion.Continuity.Chaining.0.edist_chainingSequence_add_one._proof_1_1`

```lean
private theorem edist_chainingSequence_add_one._proof_1_1 : ∀ {k : Nat} (n : Nat),
  @LT.lt.{0} Nat instLTNat n k →
    Not
        (@LE.le.{0} Nat instLENat
          (@HAdd.hAdd.{0, 0, 0} Nat Nat Nat (@instHAdd.{0} Nat instAddNat) n
            (@OfNat.ofNat.{0} Nat (nat_lit 1) (instOfNatNat (nat_lit 1))))
          k) →
      False :=
⋯
```

## `_private.BrownianMotion.Continuity.Chaining.0.edist_chainingSequence_add_one_self._proof_1_1`

Command: `#print _private.BrownianMotion.Continuity.Chaining.0.edist_chainingSequence_add_one_self._proof_1_1`

```lean
private theorem edist_chainingSequence_add_one_self._proof_1_1 : ∀ {k : Nat},
  Not
      (@LT.lt.{0} Nat instLTNat k
        (@HAdd.hAdd.{0, 0, 0} Nat Nat Nat (@instHAdd.{0} Nat instAddNat) k
          (@OfNat.ofNat.{0} Nat (nat_lit 1) (instOfNatNat (nat_lit 1))))) →
    False :=
⋯
```

## `_private.BrownianMotion.Continuity.Chaining.0.edist_chainingSequence_le._abel_1_1`

Command: `#print _private.BrownianMotion.Continuity.Chaining.0.edist_chainingSequence_le._abel_1_1`

```lean
private theorem edist_chainingSequence_le._abel_1_1.{u_1} : ∀ {E : Type u_1} {x y : E}
  [inst : PseudoEMetricSpace.{u_1} E] {C : Nat → Finset.{u_1} E} {k n : Nat} (m : Nat),
  @Eq.{1} ENNReal
    (@HAdd.hAdd.{0, 0, 0} ENNReal ENNReal ENNReal (@instHAdd.{0} ENNReal ENNReal.instAdd)
      (@EDist.edist.{u_1} E
        (@WeakPseudoEMetricSpace.toEDist.{u_1} E
          (@UniformSpace.toTopologicalSpace.{u_1} E (@PseudoEMetricSpace.toUniformSpace.{u_1} E inst))
          (@PseudoEMetricSpace.toWeakPseudoEMetricSpace.{u_1} E inst))
        (@chainingSequence.{u_1} E inst C x k m) x)
      (@HAdd.hAdd.{0, 0, 0} ENNReal ENNReal ENNReal (@instHAdd.{0} ENNReal ENNReal.instAdd)
        (@EDist.edist.{u_1} E
          (@WeakPseudoEMetricSpace.toEDist.{u_1} E
            (@UniformSpace.toTopologicalSpace.{u_1} E (@PseudoEMetricSpace.toUniformSpace.{u_1} E inst))
            (@PseudoEMetricSpace.toWeakPseudoEMetricSpace.{u_1} E inst))
          x y)
        (@EDist.edist.{u_1} E
          (@WeakPseudoEMetricSpace.toEDist.{u_1} E
            (@UniformSpace.toTopologicalSpace.{u_1} E (@PseudoEMetricSpace.toUniformSpace.{u_1} E inst))
            (@PseudoEMetricSpace.toWeakPseudoEMetricSpace.{u_1} E inst))
          y (@chainingSequence.{u_1} E inst C y n m))))
    (@HAdd.hAdd.{0, 0, 0} ENNReal ENNReal ENNReal (@instHAdd.{0} ENNReal ENNReal.instAdd)
      (@HAdd.hAdd.{0, 0, 0} ENNReal ENNReal ENNReal (@instHAdd.{0} ENNReal ENNReal.instAdd)
        (@EDist.edist.{u_1} E
          (@WeakPseudoEMetricSpace.toEDist.{u_1} E
            (@UniformSpace.toTopologicalSpace.{u_1} E (@PseudoEMetricSpace.toUniformSpace.{u_1} E inst))
            (@PseudoEMetricSpace.toWeakPseudoEMetricSpace.{u_1} E inst))
          x y)
        (@EDist.edist.{u_1} E
          (@WeakPseudoEMetricSpace.toEDist.{u_1} E
            (@UniformSpace.toTopologicalSpace.{u_1} E (@PseudoEMetricSpace.toUniformSpace.{u_1} E inst))
            (@PseudoEMetricSpace.toWeakPseudoEMetricSpace.{u_1} E inst))
          (@chainingSequence.{u_1} E inst C x k m) x))
      (@EDist.edist.{u_1} E
        (@WeakPseudoEMetricSpace.toEDist.{u_1} E
          (@UniformSpace.toTopologicalSpace.{u_1} E (@PseudoEMetricSpace.toUniformSpace.{u_1} E inst))
          (@PseudoEMetricSpace.toWeakPseudoEMetricSpace.{u_1} E inst))
        y (@chainingSequence.{u_1} E inst C y n m))) :=
⋯
```

## `_private.BrownianMotion.Continuity.Chaining.0.edist_chainingSequence_le_sum._proof_1_2`

Command: `#print _private.BrownianMotion.Continuity.Chaining.0.edist_chainingSequence_le_sum._proof_1_2`

```lean
private theorem edist_chainingSequence_le_sum._proof_1_2 : ∀ {k : Nat} (m : Nat),
  @LE.le.{0} Nat instLENat m k →
    ∀ (i : Nat),
      @LT.lt.{0} Nat instLTNat i (@HSub.hSub.{0, 0, 0} Nat Nat Nat (@instHSub.{0} Nat instSubNat) k m) →
        Not (@LT.lt.{0} Nat instLTNat (@HAdd.hAdd.{0, 0, 0} Nat Nat Nat (@instHAdd.{0} Nat instAddNat) m i) k) →
          False :=
⋯
```

## `_private.BrownianMotion.Continuity.Chaining.0.edist_chainingSequence_le_sum._simp_1_1`

Command: `#print _private.BrownianMotion.Continuity.Chaining.0.edist_chainingSequence_le_sum._simp_1_1`

```lean
private theorem edist_chainingSequence_le_sum._simp_1_1 : ∀ {n m : Nat},
  @Eq.{1} Prop
    (@Membership.mem.{0, 0} Nat (Finset.{0} Nat)
      (@SetLike.instMembership.{0, 0} (Finset.{0} Nat) Nat (@Finset.instSetLike.{0} Nat)) (Finset.range n) m)
    (@LT.lt.{0} Nat instLTNat m n) :=
⋯
```

## `_private.BrownianMotion.Continuity.Chaining.0.edist_chainingSequence_le_sum_edist._proof_1_1`

Command: `#print _private.BrownianMotion.Continuity.Chaining.0.edist_chainingSequence_le_sum_edist._proof_1_1`

```lean
private theorem edist_chainingSequence_le_sum_edist._proof_1_1 : ∀ {k m : Nat},
  @LE.le.{0} Nat instLENat m k →
    @Eq.{1} Nat
      (@HAdd.hAdd.{0, 0, 0} Nat Nat Nat (@instHAdd.{0} Nat instAddNat) m
        (@HSub.hSub.{0, 0, 0} Nat Nat Nat (@instHSub.{0} Nat instSubNat) k m))
      k :=
⋯
```

## `_private.BrownianMotion.Continuity.Chaining.0.edist_chainingSequence_pow_two_le._simp_1_1`

Command: `#print _private.BrownianMotion.Continuity.Chaining.0.edist_chainingSequence_pow_two_le._simp_1_1`

```lean
private theorem edist_chainingSequence_pow_two_le._simp_1_1.{u_1} : ∀ {G : Type u_1} [inst : Semigroup.{u_1} G]
  (a b c : G),
  @Eq.{u_1 + 1} G
    (@HMul.hMul.{u_1, u_1, u_1} G G G (@instHMul.{u_1} G (@Semigroup.toMul.{u_1} G inst)) a
      (@HMul.hMul.{u_1, u_1, u_1} G G G (@instHMul.{u_1} G (@Semigroup.toMul.{u_1} G inst)) b c))
    (@HMul.hMul.{u_1, u_1, u_1} G G G (@instHMul.{u_1} G (@Semigroup.toMul.{u_1} G inst))
      (@HMul.hMul.{u_1, u_1, u_1} G G G (@instHMul.{u_1} G (@Semigroup.toMul.{u_1} G inst)) a b) c) :=
⋯
```

## `_private.BrownianMotion.Continuity.Chaining.0.edist_chainingSequence_pow_two_le._simp_1_2`

Command: `#print _private.BrownianMotion.Continuity.Chaining.0.edist_chainingSequence_pow_two_le._simp_1_2`

```lean
private theorem edist_chainingSequence_pow_two_le._simp_1_2.{u_1} : ∀ {M₀ : Type u_1} [inst : MonoidWithZero.{u_1} M₀]
  {a : M₀} {n : Nat}
  [@IsReduced.{u_1} M₀
      (@MulZeroClass.toZero.{u_1} M₀
        (@MulZeroOneClass.toMulZeroClass.{u_1} M₀ (@MonoidWithZero.toMulZeroOneClass.{u_1} M₀ inst)))
      (@NPow.toPow.{u_1} M₀ (@Monoid.toNPow.{u_1} M₀ (@MonoidWithZero.toMonoid.{u_1} M₀ inst)))]
  [Nontrivial.{u_1} M₀],
  @Eq.{1} Prop
    (@Eq.{u_1 + 1} M₀
      (@HPow.hPow.{u_1, 0, u_1} M₀ Nat M₀
        (@instHPow.{u_1, 0} M₀ Nat
          (@NPow.toPow.{u_1} M₀ (@Monoid.toNPow.{u_1} M₀ (@MonoidWithZero.toMonoid.{u_1} M₀ inst))))
        a n)
      (@OfNat.ofNat.{u_1} M₀ (nat_lit 0)
        (@Zero.toOfNat0.{u_1} M₀
          (@MulZeroClass.toZero.{u_1} M₀
            (@MulZeroOneClass.toMulZeroClass.{u_1} M₀ (@MonoidWithZero.toMulZeroOneClass.{u_1} M₀ inst))))))
    (And
      (@Eq.{u_1 + 1} M₀ a
        (@OfNat.ofNat.{u_1} M₀ (nat_lit 0)
          (@Zero.toOfNat0.{u_1} M₀
            (@MulZeroClass.toZero.{u_1} M₀
              (@MulZeroOneClass.toMulZeroClass.{u_1} M₀ (@MonoidWithZero.toMulZeroOneClass.{u_1} M₀ inst))))))
      (@Ne.{1} Nat n (@OfNat.ofNat.{0} Nat (nat_lit 0) (instOfNatNat (nat_lit 0))))) :=
⋯
```

## `_private.BrownianMotion.Continuity.Chaining.0.edist_chainingSequence_pow_two_le._simp_1_3`

Command: `#print _private.BrownianMotion.Continuity.Chaining.0.edist_chainingSequence_pow_two_le._simp_1_3`

```lean
private theorem edist_chainingSequence_pow_two_le._simp_1_3.{u_1} : ∀ {R : Type u_1} [inst : AddMonoidWithOne.{u_1} R]
  [@CharZero.{u_1} R inst] (n : Nat) [inst_2 : n.AtLeastTwo],
  @Eq.{1} Prop
    (@Eq.{u_1 + 1} R
      (@OfNat.ofNat.{u_1} R n (@instOfNatAtLeastTwo.{u_1} R n (@AddMonoidWithOne.toNatCast.{u_1} R inst) inst_2))
      (@OfNat.ofNat.{u_1} R (nat_lit 0)
        (@Zero.toOfNat0.{u_1} R
          (@AddZero.toZero.{u_1} R
            (@AddZeroClass.toAddZero.{u_1} R
              (@AddMonoid.toAddZeroClass.{u_1} R (@AddMonoidWithOne.toAddMonoid.{u_1} R inst)))))))
    False :=
⋯
```

## `_private.BrownianMotion.Continuity.CoveringNumber.0.le_volume_of_isSeparated._simp_1_1`

Command: `#print _private.BrownianMotion.Continuity.CoveringNumber.0.le_volume_of_isSeparated._simp_1_1`

```lean
private theorem le_volume_of_isSeparated._simp_1_1.{u_1} : ∀ {α : Type u_1} (a : α),
  @Eq.{1} Prop
    (@Set.Nonempty.{u_1} α (@Singleton.singleton.{u_1, u_1} α (Set.{u_1} α) (@Set.instSingletonSet.{u_1} α) a)) True :=
⋯
```

## `_private.BrownianMotion.Continuity.CoveringNumber.0.le_volume_of_isSeparated._simp_1_2`

Command: `#print _private.BrownianMotion.Continuity.CoveringNumber.0.le_volume_of_isSeparated._simp_1_2`

```lean
private theorem le_volume_of_isSeparated._simp_1_2.{u} : ∀ {α : Type u} {s : Set.{u} α},
  @Eq.{1} Prop
    (@LE.le.{u} (Set.{u} α) (@Set.instLE.{u} α) s
      (@EmptyCollection.emptyCollection.{u} (Set.{u} α) (@Set.instEmptyCollection.{u} α)))
    (@Eq.{u + 1} (Set.{u} α) s (@EmptyCollection.emptyCollection.{u} (Set.{u} α) (@Set.instEmptyCollection.{u} α))) :=
⋯
```

## `_private.BrownianMotion.Continuity.CoveringNumber.0.le_volume_of_isSeparated._simp_1_3`

Command: `#print _private.BrownianMotion.Continuity.CoveringNumber.0.le_volume_of_isSeparated._simp_1_3`

```lean
private theorem le_volume_of_isSeparated._simp_1_3.{u_1} : ∀ {α : Type u_1} {s : Set.{u_1} α},
  @Eq.{1} Prop (@Eq.{1} ENat (@Set.encard.{u_1} α s) (@Top.top.{0} ENat instTopENat)) (@Set.Infinite.{u_1} α s) :=
⋯
```

## `_private.BrownianMotion.Continuity.CoveringNumber.0.le_volume_of_isSeparated._simp_1_4`

Command: `#print _private.BrownianMotion.Continuity.CoveringNumber.0.le_volume_of_isSeparated._simp_1_4`

```lean
private theorem le_volume_of_isSeparated._simp_1_4.{u, u_1} : ∀ {α : Type u} {ι : Sort u_1} {f : ι → α} {x : α},
  @Eq.{1} Prop (@Membership.mem.{u, u} α (Set.{u} α) (@Set.instMembership.{u} α) (@Set.range.{u, u_1} α ι f) x)
    (∃ y, @Eq.{u + 1} α (f y) x) :=
⋯
```

## `_private.BrownianMotion.Continuity.CoveringNumber.0.le_volume_of_isSeparated._simp_1_5`

Command: `#print _private.BrownianMotion.Continuity.CoveringNumber.0.le_volume_of_isSeparated._simp_1_5`

```lean
private theorem le_volume_of_isSeparated._simp_1_5.{u_1} : ∀ {α : Sort u_1} {p : α → Prop} {q : (∃ x, p x) → Prop},
  @Eq.{1} Prop (∀ (h : ∃ x, p x), q h) (∀ (x : α) (h : p x), q ⋯) :=
⋯
```

## `_private.BrownianMotion.Continuity.CoveringNumber.0.volume_eq_top_of_packingNumber._simp_1_1`

Command: `#print _private.BrownianMotion.Continuity.CoveringNumber.0.volume_eq_top_of_packingNumber._simp_1_1`

```lean
private theorem volume_eq_top_of_packingNumber._simp_1_1.{u_1} : ∀ {ι : Sort u_1} (f : ι → ENNReal) (a : ENNReal),
  @Eq.{1} ENNReal
    (⨆ i,
      @HMul.hMul.{0, 0, 0} ENNReal ENNReal ENNReal
        (@instHMul.{0} ENNReal
          (@Distrib.toMul.{0} ENNReal
            (@instDistribOfSemiring.{0} ENNReal (@CommSemiring.toSemiring.{0} ENNReal ENNReal.instCommSemiring))))
        (f i) a)
    (@HMul.hMul.{0, 0, 0} ENNReal ENNReal ENNReal
      (@instHMul.{0} ENNReal
        (@Distrib.toMul.{0} ENNReal
          (@instDistribOfSemiring.{0} ENNReal (@CommSemiring.toSemiring.{0} ENNReal ENNReal.instCommSemiring))))
      (⨆ i, f i) a) :=
⋯
```

## `_private.BrownianMotion.Continuity.CoveringNumber.0.volume_eq_top_of_packingNumber._simp_1_2`

Command: `#print _private.BrownianMotion.Continuity.CoveringNumber.0.volume_eq_top_of_packingNumber._simp_1_2`

```lean
private theorem volume_eq_top_of_packingNumber._simp_1_2.{u_1} : ∀ {ι : Sort u_1} (f : ι → ENat),
  @Eq.{1} ENNReal (⨆ i, ↑(f i)) ↑(⨆ i, f i) :=
⋯
```

## `_private.BrownianMotion.Continuity.HasBoundedInternalCoveringNumber.0.isCoverWithBoundedCoveringNumber_Ico_nnreal._simp_1_2`

Command: `#print _private.BrownianMotion.Continuity.HasBoundedInternalCoveringNumber.0.isCoverWithBoundedCoveringNumber_Ico_nnreal._simp_1_2`

```lean
private theorem isCoverWithBoundedCoveringNumber_Ico_nnreal._simp_1_2.{u, v} : ∀ {α : Type u} {β : Type v} (f : α → β)
  (s : Set.{u} α) (y : β),
  @Eq.{1} Prop (@Membership.mem.{v, v} β (Set.{v} β) (@Set.instMembership.{v} β) (@Set.image.{u, v} α β f s) y)
    (∃ x, And (@Membership.mem.{u, u} α (Set.{u} α) (@Set.instMembership.{u} α) s x) (@Eq.{v + 1} β (f x) y)) :=
⋯
```

## `_private.BrownianMotion.Continuity.HasBoundedInternalCoveringNumber.0.isCoverWithBoundedCoveringNumber_Ico_nnreal._simp_1_3`

Command: `#print _private.BrownianMotion.Continuity.HasBoundedInternalCoveringNumber.0.isCoverWithBoundedCoveringNumber_Ico_nnreal._simp_1_3`

```lean
private theorem isCoverWithBoundedCoveringNumber_Ico_nnreal._simp_1_3.{u_1} : ∀ {α : Type u_1} [inst : Preorder.{u_1} α]
  {a b x : α},
  @Eq.{1} Prop (@Membership.mem.{u_1, u_1} α (Set.{u_1} α) (@Set.instMembership.{u_1} α) (@Set.Ico.{u_1} α inst a b) x)
    (And (@LE.le.{u_1} α (@Preorder.toLE.{u_1} α inst) a x) (@LT.lt.{u_1} α (@Preorder.toLT.{u_1} α inst) x b)) :=
⋯
```

## `_private.BrownianMotion.Continuity.HasBoundedInternalCoveringNumber.0.isCoverWithBoundedCoveringNumber_Ico_nnreal._simp_1_4`

Command: `#print _private.BrownianMotion.Continuity.HasBoundedInternalCoveringNumber.0.isCoverWithBoundedCoveringNumber_Ico_nnreal._simp_1_4`

```lean
private theorem isCoverWithBoundedCoveringNumber_Ico_nnreal._simp_1_4.{u_1} : ∀ {α : Type u_1} [inst : LE.{u_1} α]
  [inst_1 : Zero.{u_1} α] [@IsBotZeroClass.{u_1} α inst inst_1] {a : α},
  @Eq.{1} Prop (@LE.le.{u_1} α inst (@OfNat.ofNat.{u_1} α (nat_lit 0) (@Zero.toOfNat0.{u_1} α inst_1)) a) True :=
⋯
```

## `_private.BrownianMotion.Continuity.HasBoundedInternalCoveringNumber.0.isCoverWithBoundedCoveringNumber_Ico_nnreal._simp_1_7`

Command: `#print _private.BrownianMotion.Continuity.HasBoundedInternalCoveringNumber.0.isCoverWithBoundedCoveringNumber_Ico_nnreal._simp_1_7`

```lean
private theorem isCoverWithBoundedCoveringNumber_Ico_nnreal._simp_1_7.{u} : ∀ {α : Type u}
  [inst : PseudoEMetricSpace.{u} α] {x y : α} {ε : ENNReal},
  @Eq.{1} Prop (@Membership.mem.{u, u} α (Set.{u} α) (@Set.instMembership.{u} α) (@Metric.closedEBall.{u} α inst x ε) y)
    (@LE.le.{0} ENNReal ENNReal.instLE (@EDist.edist.{u} α (@PseudoEMetricSpace.toEDist.{u} α inst) y x) ε) :=
⋯
```

## `_private.BrownianMotion.Continuity.HasBoundedInternalCoveringNumber.0.isCoverWithBoundedCoveringNumber_Ico_nnreal._simp_1_8`

Command: `#print _private.BrownianMotion.Continuity.HasBoundedInternalCoveringNumber.0.isCoverWithBoundedCoveringNumber_Ico_nnreal._simp_1_8`

```lean
private theorem isCoverWithBoundedCoveringNumber_Ico_nnreal._simp_1_8.{u_1} : ∀ {R : Type u_1}
  [inst : AddMonoidWithOne.{u_1} R] [@CharZero.{u_1} R inst] (n : Nat) [inst_2 : n.AtLeastTwo],
  @Eq.{1} Prop
    (@Eq.{u_1 + 1} R
      (@OfNat.ofNat.{u_1} R n (@instOfNatAtLeastTwo.{u_1} R n (@AddMonoidWithOne.toNatCast.{u_1} R inst) inst_2))
      (@OfNat.ofNat.{u_1} R (nat_lit 0)
        (@Zero.toOfNat0.{u_1} R
          (@AddZero.toZero.{u_1} R
            (@AddZeroClass.toAddZero.{u_1} R
              (@AddMonoid.toAddZeroClass.{u_1} R (@AddMonoidWithOne.toAddMonoid.{u_1} R inst)))))))
    False :=
⋯
```

## `_private.BrownianMotion.Continuity.HasBoundedInternalCoveringNumber.0.isCoverWithBoundedCoveringNumber_Ico_nnreal._simp_1_9`

Command: `#print _private.BrownianMotion.Continuity.HasBoundedInternalCoveringNumber.0.isCoverWithBoundedCoveringNumber_Ico_nnreal._simp_1_9`

```lean
private theorem isCoverWithBoundedCoveringNumber_Ico_nnreal._simp_1_9.{u, v} : ∀ {α : Type u} {ι : Sort v} {x : α}
  {s : ι → Set.{u} α},
  @Eq.{1} Prop (@Membership.mem.{u, u} α (Set.{u} α) (@Set.instMembership.{u} α) (⋃ i, s i) x)
    (∃ i, @Membership.mem.{u, u} α (Set.{u} α) (@Set.instMembership.{u} α) (s i) x) :=
⋯
```

## `_private.BrownianMotion.Continuity.HasBoundedInternalCoveringNumber.0.isCoverWithBoundedCoveringNumber_Ico_nnreal.match_1_5`

Command: `#print _private.BrownianMotion.Continuity.HasBoundedInternalCoveringNumber.0.isCoverWithBoundedCoveringNumber_Ico_nnreal.match_1_5`

```lean
private def isCoverWithBoundedCoveringNumber_Ico_nnreal.match_1_5 : ∀ (n : Nat) (x : Real)
  (motive :
    (∃ x_1,
        And
          (@LT.lt.{0} NNReal (@Preorder.toLT.{0} NNReal (@PartialOrder.toPreorder.{0} NNReal NNReal.instPartialOrder))
            x_1
            (@HAdd.hAdd.{0, 0, 0} NNReal NNReal NNReal
              (@instHAdd.{0} NNReal (@Distrib.toAdd.{0} NNReal (@instDistribOfSemiring.{0} NNReal NNReal.instSemiring)))
              (@Nat.cast.{0} NNReal
                (@AddMonoidWithOne.toNatCast.{0} NNReal
                  (@AddCommMonoidWithOne.toAddMonoidWithOne.{0} NNReal
                    (@NonAssocSemiring.toAddCommMonoidWithOne.{0} NNReal
                      (@Semiring.toNonAssocSemiring.{0} NNReal NNReal.instSemiring))))
                n)
              (@OfNat.ofNat.{0} NNReal (nat_lit 1) (@One.toOfNat1.{0} NNReal NNReal.instOne))))
          (@Eq.{1} Real (↑x_1) x)) →
      Prop)
  (x_1 :
    ∃ x_1,
      And
        (@LT.lt.{0} NNReal (@Preorder.toLT.{0} NNReal (@PartialOrder.toPreorder.{0} NNReal NNReal.instPartialOrder)) x_1
          (@HAdd.hAdd.{0, 0, 0} NNReal NNReal NNReal
            (@instHAdd.{0} NNReal (@Distrib.toAdd.{0} NNReal (@instDistribOfSemiring.{0} NNReal NNReal.instSemiring)))
            (@Nat.cast.{0} NNReal
              (@AddMonoidWithOne.toNatCast.{0} NNReal
                (@AddCommMonoidWithOne.toAddMonoidWithOne.{0} NNReal
                  (@NonAssocSemiring.toAddCommMonoidWithOne.{0} NNReal
                    (@Semiring.toNonAssocSemiring.{0} NNReal NNReal.instSemiring))))
              n)
            (@OfNat.ofNat.{0} NNReal (nat_lit 1) (@One.toOfNat1.{0} NNReal NNReal.instOne))))
        (@Eq.{1} Real (↑x_1) x)),
  (∀ (y : NNReal)
      (hy :
        @LT.lt.{0} NNReal (@Preorder.toLT.{0} NNReal (@PartialOrder.toPreorder.{0} NNReal NNReal.instPartialOrder)) y
          (@HAdd.hAdd.{0, 0, 0} NNReal NNReal NNReal
            (@instHAdd.{0} NNReal (@Distrib.toAdd.{0} NNReal (@instDistribOfSemiring.{0} NNReal NNReal.instSemiring)))
            (@Nat.cast.{0} NNReal
              (@AddMonoidWithOne.toNatCast.{0} NNReal
                (@AddCommMonoidWithOne.toAddMonoidWithOne.{0} NNReal
                  (@NonAssocSemiring.toAddCommMonoidWithOne.{0} NNReal
                    (@Semiring.toNonAssocSemiring.{0} NNReal NNReal.instSemiring))))
              n)
            (@OfNat.ofNat.{0} NNReal (nat_lit 1) (@One.toOfNat1.{0} NNReal NNReal.instOne))))
      (hy_eq : @Eq.{1} Real (↑y) x), motive ⋯) →
    motive x_1 :=
⋯
```

## `_private.BrownianMotion.Continuity.KolmogorovChentsovInequality.0.measure_add_ge_le_add_measure_ge._simp_1_1`

Command: `#print _private.BrownianMotion.Continuity.KolmogorovChentsovInequality.0.measure_add_ge_le_add_measure_ge._simp_1_1`

```lean
private theorem measure_add_ge_le_add_measure_ge._simp_1_1.{u} : ∀ {α : Type u} (x : α) (a b : Set.{u} α),
  @Eq.{1} Prop
    (@Membership.mem.{u, u} α (Set.{u} α) (@Set.instMembership.{u} α)
      (@Union.union.{u} (Set.{u} α) (@Set.instUnion.{u} α) a b) x)
    (Or (@Membership.mem.{u, u} α (Set.{u} α) (@Set.instMembership.{u} α) a x)
      (@Membership.mem.{u, u} α (Set.{u} α) (@Set.instMembership.{u} α) b x)) :=
⋯
```

## `_private.BrownianMotion.Continuity.KolmogorovChentsovInequality.0.measure_add_ge_le_add_measure_ge_half._simp_1_1`

Command: `#print _private.BrownianMotion.Continuity.KolmogorovChentsovInequality.0.measure_add_ge_le_add_measure_ge_half._simp_1_1`

```lean
private theorem measure_add_ge_le_add_measure_ge_half._simp_1_1.{u} : ∀ {α : Type u} [inst : PartialOrder.{u} α]
  [inst_1 : @OrderTop.{u} α (@Preorder.toLE.{u} α (@PartialOrder.toPreorder.{u} α inst))] {a : α},
  @Eq.{1} Prop
    (@LE.le.{u} α (@Preorder.toLE.{u} α (@PartialOrder.toPreorder.{u} α inst))
      (@Top.top.{u} α (@OrderTop.toTop.{u} α (@Preorder.toLE.{u} α (@PartialOrder.toPreorder.{u} α inst)) inst_1)) a)
    (@Eq.{u + 1} α a
      (@Top.top.{u} α (@OrderTop.toTop.{u} α (@Preorder.toLE.{u} α (@PartialOrder.toPreorder.{u} α inst)) inst_1))) :=
⋯
```

## `_private.BrownianMotion.Continuity.KolmogorovChentsovInequality.0.measure_add_ge_le_add_measure_ge_half._simp_1_2`

Command: `#print _private.BrownianMotion.Continuity.KolmogorovChentsovInequality.0.measure_add_ge_le_add_measure_ge_half._simp_1_2`

```lean
private theorem measure_add_ge_le_add_measure_ge_half._simp_1_2 : ∀ {a b : ENNReal},
  @Eq.{1} Prop
    (@Eq.{1} ENNReal (@HAdd.hAdd.{0, 0, 0} ENNReal ENNReal ENNReal (@instHAdd.{0} ENNReal ENNReal.instAdd) a b)
      (@Top.top.{0} ENNReal ENNReal.instTop))
    (Or (@Eq.{1} ENNReal a (@Top.top.{0} ENNReal ENNReal.instTop))
      (@Eq.{1} ENNReal b (@Top.top.{0} ENNReal ENNReal.instTop))) :=
⋯
```

## `_private.BrownianMotion.Gaussian.StochasticProcesses.0.subset_closure_dense_inter._proof_1_1`

Command: `#print _private.BrownianMotion.Gaussian.StochasticProcesses.0.subset_closure_dense_inter._proof_1_1`

```lean
private theorem subset_closure_dense_inter._proof_1_1.{u_1} : ∀ {α : Type u_1} {T' U : Set.{u_1} α} (t : Set.{u_1} α),
  @Set.Nonempty.{u_1} α
      (@Inter.inter.{u_1} (Set.{u_1} α) (@Set.instInter.{u_1} α) T'
        (@Inter.inter.{u_1} (Set.{u_1} α) (@Set.instInter.{u_1} α) t U)) →
    @Set.Nonempty.{u_1} α
      (@Inter.inter.{u_1} (Set.{u_1} α) (@Set.instInter.{u_1} α) t
        (@Inter.inter.{u_1} (Set.{u_1} α) (@Set.instInter.{u_1} α) T' U)) :=
⋯
```

## `Aesop.BuiltinRules.not_intro`

Command: `#print Aesop.BuiltinRules.not_intro`

```lean
theorem Aesop.BuiltinRules.not_intro : ∀ {P : Prop}, (P → False) → Not P :=
⋯
```

## `AmericanConvexity.Stopping.BoundedRule`

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

## `AmericanConvexity.Stopping.ambientNullAugmentation`

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
      (@MathFin.ItoLocalMartingale.nullsAlg.{u_1} Ω mΩ P) ⋯)
```

## `AmericanConvexity.Stopping.ambient_le_completion`

Command: `#print AmericanConvexity.Stopping.ambient_le_completion`

```lean
theorem AmericanConvexity.Stopping.ambient_le_completion.{u_1} : ∀ {Ω : Type u_1} [mΩ : MeasurableSpace.{u_1} Ω]
  (P : @MeasureTheory.Measure.{u_1} Ω mΩ),
  @LE.le.{u_1} (MeasurableSpace.{u_1} Ω) (@MeasurableSpace.instLE.{u_1} Ω) mΩ
    (@AmericanConvexity.Stopping.completedMeasurableSpace.{u_1} Ω mΩ P) :=
⋯
```

## `AmericanConvexity.Stopping.americanPutValue`

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

## `AmericanConvexity.Stopping.brownianFiltration`

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
  AmericanConvexity.Stopping.brownianFiltration._proof_1 (fun i => Real.measurableSpace) ⋯
  (@PartialOrder.toPreorder.{0} NNReal NNReal.instPartialOrder) ProbabilityTheory.brownian
  AmericanConvexity.Stopping.brownianFiltration._proof_2
```

## `AmericanConvexity.Stopping.brownianUsualAmericanPut`

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

## `AmericanConvexity.Stopping.brownianUsualExerciseBoundary`

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

## `AmericanConvexity.Stopping.brownianUsualFiltration`

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

## `AmericanConvexity.Stopping.brownian_filtered`

Command: `#print AmericanConvexity.Stopping.brownian_filtered`

```lean
theorem AmericanConvexity.Stopping.brownian_filtered : @ProbabilityTheory.IsFilteredPreBrownian.{0} (NNReal → Real)
  (@inferInstance.{1} (MeasurableSpace.{0} (NNReal → Real))
    (@MeasurableSpace.pi.{0, 0} NNReal (fun a => Real) fun a => Real.measurableSpace))
  ProbabilityTheory.brownian AmericanConvexity.Stopping.brownianFiltration ProbabilityTheory.gaussianLimit :=
⋯
```

## `AmericanConvexity.Stopping.completedAmbientFiltration`

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
    ⋯ ⋯
```

## `AmericanConvexity.Stopping.completedMeasurableSpace`

Command: `#print AmericanConvexity.Stopping.completedMeasurableSpace`

```lean
@[reducible] def AmericanConvexity.Stopping.completedMeasurableSpace.{u_1} : {Ω : Type u_1} →
  [mΩ : MeasurableSpace.{u_1} Ω] → @MeasureTheory.Measure.{u_1} Ω mΩ → MeasurableSpace.{u_1} Ω :=
fun {Ω} [mΩ : MeasurableSpace.{u_1} Ω] P =>
  @eventuallyMeasurableSpace.{u_1} Ω mΩ
    (@MeasureTheory.ae.{u_1, u_1} Ω (@MeasureTheory.Measure.{u_1} Ω mΩ) (@MeasureTheory.Measure.instFunLike.{u_1} Ω mΩ)
      ⋯ P)
    ⋯
```

## `AmericanConvexity.Stopping.completedMeasure`

Command: `#print AmericanConvexity.Stopping.completedMeasure`

```lean
def AmericanConvexity.Stopping.completedMeasure.{u_1} : {Ω : Type u_1} →
  [mΩ : MeasurableSpace.{u_1} Ω] →
    (P : @MeasureTheory.Measure.{u_1} Ω mΩ) →
      @MeasureTheory.Measure.{u_1} Ω (@AmericanConvexity.Stopping.completedMeasurableSpace.{u_1} Ω mΩ P) :=
fun {Ω} [mΩ : MeasurableSpace.{u_1} Ω] P => @MeasureTheory.Measure.completion.{u_1} Ω mΩ P
```

## `AmericanConvexity.Stopping.completion_isProbabilityMeasure`

Command: `#print AmericanConvexity.Stopping.completion_isProbabilityMeasure`

```lean
theorem AmericanConvexity.Stopping.completion_isProbabilityMeasure.{u_1} : ∀ {Ω : Type u_1}
  [mΩ : MeasurableSpace.{u_1} Ω] (P : @MeasureTheory.Measure.{u_1} Ω mΩ)
  [@MeasureTheory.IsProbabilityMeasure.{u_1} Ω mΩ P],
  @MeasureTheory.IsProbabilityMeasure.{u_1} Ω (@AmericanConvexity.Stopping.completedMeasurableSpace.{u_1} Ω mΩ P)
    (@AmericanConvexity.Stopping.completedMeasure.{u_1} Ω mΩ P) :=
⋯
```

## `AmericanConvexity.Stopping.exerciseSet`

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

## `AmericanConvexity.Stopping.exerciseThreshold`

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

## `AmericanConvexity.Stopping.exerciseValues`

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

## `AmericanConvexity.Stopping.putReward`

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

## `Asymptotics.IsEquivalent.rpow_of_nonneg`

Command: `#print Asymptotics.IsEquivalent.rpow_of_nonneg`

```lean
protected theorem Asymptotics.IsEquivalent.rpow_of_nonneg.{u_1} : ∀ {α : Type u_1} {t u : α → Real},
  @LE.le.{u_1} (α → Real) (@Pi.hasLe.{u_1, 0} α (fun a => Real) fun i => Real.instLE)
      (@OfNat.ofNat.{u_1} (α → Real) (nat_lit 0)
        (@Zero.toOfNat0.{u_1} (α → Real) (@Pi.instZero.{u_1, 0} α (fun a => Real) fun i => Real.instZero)))
      u →
    ∀ {l : Filter.{u_1} α},
      @Asymptotics.IsEquivalent.{u_1, 0} α Real
          (@NonUnitalSeminormedRing.toSeminormedAddCommGroup.{0} Real
            (@NonUnitalSeminormedCommRing.toNonUnitalSeminormedRing.{0} Real
              (@SeminormedCommRing.toNonUnitalSeminormedCommRing.{0} Real
                (@NormedCommRing.toSeminormedCommRing.{0} Real Real.normedCommRing))))
          l t u →
        ∀ {r : Real},
          @Asymptotics.IsEquivalent.{u_1, 0} α Real
            (@NonUnitalSeminormedRing.toSeminormedAddCommGroup.{0} Real
              (@NonUnitalSeminormedCommRing.toNonUnitalSeminormedRing.{0} Real
                (@SeminormedCommRing.toNonUnitalSeminormedCommRing.{0} Real
                  (@NormedCommRing.toSeminormedCommRing.{0} Real Real.normedCommRing))))
            l
            (@HPow.hPow.{u_1, 0, u_1} (α → Real) Real (α → Real)
              (@instHPow.{u_1, 0} (α → Real) Real
                (@Pi.instPow.{u_1, 0, 0} α Real (fun a => Real) fun i => Real.instPow))
              t r)
            (@HPow.hPow.{u_1, 0, u_1} (α → Real) Real (α → Real)
              (@instHPow.{u_1, 0} (α → Real) Real
                (@Pi.instPow.{u_1, 0, 0} α Real (fun a => Real) fun i => Real.instPow))
              u r) :=
⋯
```

## `L2.posSemidef_interMatrix._auto_1`

Command: `#print L2.posSemidef_interMatrix._auto_1`

```lean
meta def L2.posSemidef_interMatrix._auto_1 : Lean.Syntax :=
Lean.Syntax.node Lean.SourceInfo.none `Lean.Parser.Tactic.tacticSeq
  (@Array.push.{0} Lean.Syntax (@Array.empty.{0} Lean.Syntax)
    (Lean.Syntax.node Lean.SourceInfo.none `Lean.Parser.Tactic.tacticSeq1Indented
      (@Array.push.{0} Lean.Syntax (@Array.empty.{0} Lean.Syntax)
        (Lean.Syntax.node Lean.SourceInfo.none `null
          (@Array.push.{0} Lean.Syntax (@Array.empty.{0} Lean.Syntax)
            (Lean.Syntax.node Lean.SourceInfo.none `finiteness
              (@Array.push.{0} Lean.Syntax
                (@Array.push.{0} Lean.Syntax
                  (@Array.push.{0} Lean.Syntax (@Array.empty.{0} Lean.Syntax) (Lean.mkAtom "finiteness"))
                  (Lean.Syntax.node Lean.SourceInfo.none `null (@Array.empty.{0} Lean.Syntax)))
                (Lean.Syntax.node Lean.SourceInfo.none `null (@Array.empty.{0} Lean.Syntax)))))))))
```

## `MathFin.ItoLocalMartingale.nullsAlg`

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

## `MathFin.ItoLocalMartingale.nullsAlg_le`

Command: `#print MathFin.ItoLocalMartingale.nullsAlg_le`

```lean
theorem MathFin.ItoLocalMartingale.nullsAlg_le.{u_1} : ∀ {Ω : Type u_1} {m0 : MeasurableSpace.{u_1} Ω}
  {μ : @MeasureTheory.Measure.{u_1} Ω m0},
  @LE.le.{u_1} (MeasurableSpace.{u_1} Ω) (@MeasurableSpace.instLE.{u_1} Ω)
    (@MathFin.ItoLocalMartingale.nullsAlg.{u_1} Ω m0 μ) m0 :=
⋯
```

## `MathFin.discreteTaylorRemainder2D._proof_1`

Command: `#print MathFin.discreteTaylorRemainder2D._proof_1`

```lean
theorem MathFin.discreteTaylorRemainder2D._proof_1 : (@HAdd.hAdd.{0, 0, 0} Nat Nat Nat (@instHAdd.{0} Nat instAddNat)
    (@OfNat.ofNat.{0} Nat (nat_lit 1) (instOfNatNat (nat_lit 1)))
    (@OfNat.ofNat.{0} Nat (nat_lit 1) (instOfNatNat (nat_lit 1)))).AtLeastTwo :=
⋯
```

## `MeasureTheory.IsProjectiveLimit.hasLaw_restrict`

Command: `#print MeasureTheory.IsProjectiveLimit.hasLaw_restrict`

```lean
theorem MeasureTheory.IsProjectiveLimit.hasLaw_restrict.{u_2, u_3} : ∀ {ι : Type u_2} {X : ι → Type u_3}
  {mX : (i : ι) → MeasurableSpace.{u_3} (X i)}
  {μ : @MeasureTheory.Measure.{max u_2 u_3} ((i : ι) → X i) (@MeasurableSpace.pi.{u_2, u_3} ι X mX)}
  {P :
    (I : Finset.{u_2} ι) →
      @MeasureTheory.Measure.{max u_2 u_3}
        ((i : ↥I) →
          X
            (@Subtype.val.{u_2 + 1} ι
              (fun x =>
                @Membership.mem.{u_2, u_2} ι (Finset.{u_2} ι)
                  (@SetLike.instMembership.{u_2, u_2} (Finset.{u_2} ι) ι (@Finset.instSetLike.{u_2} ι)) I x)
              i))
        (@MeasurableSpace.pi.{u_2, u_3} (↥I)
          (fun i =>
            X
              (@Subtype.val.{u_2 + 1} ι
                (fun x =>
                  @Membership.mem.{u_2, u_2} ι (Finset.{u_2} ι)
                    (@SetLike.instMembership.{u_2, u_2} (Finset.{u_2} ι) ι (@Finset.instSetLike.{u_2} ι)) I x)
                i))
          fun a =>
          mX
            (@Subtype.val.{u_2 + 1} ι
              (fun x =>
                @Membership.mem.{u_2, u_2} ι (Finset.{u_2} ι)
                  (@SetLike.instMembership.{u_2, u_2} (Finset.{u_2} ι) ι (@Finset.instSetLike.{u_2} ι)) I x)
              a))},
  @MeasureTheory.IsProjectiveLimit.{u_2, u_3} ι X mX μ P →
    ∀ {I : Finset.{u_2} ι},
      @ProbabilityTheory.HasLaw.{max u_2 u_3, max u_2 u_3} ((i : ι) → X i)
        ((i : ↥I) →
          X
            (@Subtype.val.{u_2 + 1} ι
              (fun x =>
                @Membership.mem.{u_2, u_2} ι (Finset.{u_2} ι)
                  (@SetLike.instMembership.{u_2, u_2} (Finset.{u_2} ι) ι (@Finset.instSetLike.{u_2} ι)) I x)
              i))
        (@MeasurableSpace.pi.{u_2, u_3} ι X mX)
        (@MeasurableSpace.pi.{u_2, u_3} (↥I)
          (fun i =>
            X
              (@Subtype.val.{u_2 + 1} ι
                (fun x =>
                  @Membership.mem.{u_2, u_2} ι (Finset.{u_2} ι)
                    (@SetLike.instMembership.{u_2, u_2} (Finset.{u_2} ι) ι (@Finset.instSetLike.{u_2} ι)) I x)
                i))
          fun a =>
          mX
            (@Subtype.val.{u_2 + 1} ι
              (fun x =>
                @Membership.mem.{u_2, u_2} ι (Finset.{u_2} ι)
                  (@SetLike.instMembership.{u_2, u_2} (Finset.{u_2} ι) ι (@Finset.instSetLike.{u_2} ι)) I x)
              a))
        (@Finset.restrict.{u_2, u_3} ι X I) (P I) μ :=
⋯
```

## `MeasureTheory.projectiveLimit.eq_1`

Command: `#print MeasureTheory.projectiveLimit.eq_1`

```lean
@[backward_defeq] theorem MeasureTheory.projectiveLimit.eq_1.{u_1, u_2} : ∀ {ι : Type u_1} {α : ι → Type u_2}
  [inst : (i : ι) → MeasurableSpace.{u_2} (α i)] [inst_1 : (i : ι) → TopologicalSpace.{u_2} (α i)]
  [inst_2 : ∀ (i : ι), @BorelSpace.{u_2} (α i) (inst_1 i) (inst i)]
  [inst_3 : ∀ (i : ι), @PolishSpace.{u_2} (α i) (inst_1 i)]
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
                    (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} ι) ι (@Finset.instSetLike.{u_1} ι)) J x)
                j))
          fun a =>
          inst
            (@Subtype.val.{u_1 + 1} ι
              (fun x =>
                @Membership.mem.{u_1, u_1} ι (Finset.{u_1} ι)
                  (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} ι) ι (@Finset.instSetLike.{u_1} ι)) J x)
              a)))
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
  (hP : @MeasureTheory.IsProjectiveMeasureFamily.{u_1, u_2} ι α inst P),
  @Eq.{(max u_1 u_2) + 1}
    (@MeasureTheory.Measure.{max u_1 u_2} ((i : ι) → α i) (@MeasurableSpace.pi.{u_1, u_2} ι α inst))
    (@MeasureTheory.projectiveLimit.{u_1, u_2} ι α inst inst_1 inst_2 inst_3 P inst_4 hP)
    (@MeasureTheory.AddContent.measure.{max u_1 u_2} ((i : ι) → α i)
      (@MeasureTheory.measurableCylinders.{u_2, u_1} ι α inst) (@MeasurableSpace.pi.{u_1, u_2} ι α inst)
      (@MeasureTheory.projectiveFamilyContent.{u_1, u_2} ι α inst P hP) ⋯ ⋯ ⋯) :=
⋯
```

## `MeasureTheory.projectiveLimitWithWeakestHypotheses._proof_1`

Command: `#print MeasureTheory.projectiveLimitWithWeakestHypotheses._proof_1`

```lean
theorem MeasureTheory.projectiveLimitWithWeakestHypotheses._proof_1.{u_1, u_2} : ∀ {ι : Type u_2} {α : ι → Type u_1}
  [inst : (i : ι) → MeasurableSpace.{u_1} (α i)],
  @LE.le.{max u_1 u_2} (MeasurableSpace.{max u_2 u_1} ((i : ι) → α i))
    (@Preorder.toLE.{max u_1 u_2} (MeasurableSpace.{max u_2 u_1} ((i : ι) → α i))
      (@PartialOrder.toPreorder.{max u_1 u_2} (MeasurableSpace.{max u_2 u_1} ((i : ι) → α i))
        (@MeasurableSpace.instPartialOrder.{max u_1 u_2} ((i : ι) → α i))))
    (@MeasurableSpace.pi.{u_2, u_1} ι α inst)
    (@MeasurableSpace.generateFrom.{max u_2 u_1} ((i : ι) → α i)
      (@MeasureTheory.measurableCylinders.{u_1, u_2} ι α inst)) :=
⋯
```

## `Metric.IsSeparated.disjoint_closedBall`

Command: `#print Metric.IsSeparated.disjoint_closedBall`

```lean
theorem Metric.IsSeparated.disjoint_closedBall.{u_1} : ∀ {E : Type u_1} [inst : PseudoEMetricSpace.{u_1} E]
  {s : Set.{u_1} E} {ε : ENNReal},
  @Metric.IsSeparated.{u_1} E inst ε s →
    @Set.PairwiseDisjoint.{u_1, u_1} (Set.{u_1} E) E
      (@CompletePartialOrder.toPartialOrder.{u_1} (Set.{u_1} E)
        (@CompleteLattice.toCompletePartialOrder.{u_1} (Set.{u_1} E)
          (@CompleteBooleanAlgebra.toCompleteLattice.{u_1} (Set.{u_1} E)
            (@CompleteAtomicBooleanAlgebra.toCompleteBooleanAlgebra.{u_1} (Set.{u_1} E)
              (@Set.instCompleteAtomicBooleanAlgebra.{u_1} E)))))
      (@CompletePartialOrder.toOrderBot.{u_1} (Set.{u_1} E)
        (@CompleteLattice.toCompletePartialOrder.{u_1} (Set.{u_1} E)
          (@CompleteBooleanAlgebra.toCompleteLattice.{u_1} (Set.{u_1} E)
            (@CompleteAtomicBooleanAlgebra.toCompleteBooleanAlgebra.{u_1} (Set.{u_1} E)
              (@Set.instCompleteAtomicBooleanAlgebra.{u_1} E)))))
      s fun x =>
      @Metric.closedEBall.{u_1} E inst x
        (@HDiv.hDiv.{0, 0, 0} ENNReal ENNReal ENNReal
          (@instHDiv.{0} ENNReal (@DivInvMonoid.toDiv.{0} ENNReal ENNReal.instDivInvMonoid)) ε
          (@OfNat.ofNat.{0} ENNReal (nat_lit 2)
            (@instOfNatAtLeastTwo.{0} ENNReal (nat_lit 2)
              (@AddMonoidWithOne.toNatCast.{0} ENNReal
                (@AddCommMonoidWithOne.toAddMonoidWithOne.{0} ENNReal ENNReal.instAddCommMonoidWithOne))
              ⋯))) :=
⋯
```

## `Metric.nonempty_closedEBall._simp_1`

Command: `#print Metric.nonempty_closedEBall._simp_1`

```lean
theorem Metric.nonempty_closedEBall._simp_1.{u_1} : ∀ {E : Type u_1} [inst : PseudoEMetricSpace.{u_1} E] {x : E}
  {r : ENNReal}, @Eq.{1} Prop (@Set.Nonempty.{u_1} E (@Metric.closedEBall.{u_1} E inst x r)) True :=
⋯
```

## `Module.finrank_ne_zero._simp_1`

Command: `#print Module.finrank_ne_zero._simp_1`

```lean
theorem Module.finrank_ne_zero._simp_1.{u_1, u_2} : ∀ {R : Type u_1} {M : Type u_2} [inst : Ring.{u_1} R]
  [inst_1 : AddCommGroup.{u_2} M]
  [inst_2 :
    @_root_.Module.{u_1, u_2} R M (@Ring.toSemiring.{u_1} R inst) (@AddCommGroup.toAddCommMonoid.{u_2} M inst_1)]
  [@StrongRankCondition.{u_1} R (@Ring.toSemiring.{u_1} R inst)]
  [@Module.Finite.{u_1, u_2} R M (@Ring.toSemiring.{u_1} R inst) (@AddCommGroup.toAddCommMonoid.{u_2} M inst_1) inst_2]
  [@IsDomain.{u_1} R (@Ring.toSemiring.{u_1} R inst)]
  [@Module.IsTorsionFree.{u_1, u_2} R M (@Ring.toSemiring.{u_1} R inst) (@AddCommGroup.toAddCommMonoid.{u_2} M inst_1)
      inst_2]
  [h : Nontrivial.{u_2} M],
  @Eq.{1} Prop
    (@Eq.{1} Nat
      (@Module.finrank.{u_1, u_2} R M (@Ring.toSemiring.{u_1} R inst) (@AddCommGroup.toAddCommMonoid.{u_2} M inst_1)
        inst_2)
      (@OfNat.ofNat.{0} Nat (nat_lit 0) (instOfNatNat (nat_lit 0))))
    False :=
⋯
```

## `ProbabilityTheory.Cp._proof_1`

Command: `#print ProbabilityTheory.Cp._proof_1`

```lean
theorem ProbabilityTheory.Cp._proof_1 : (@HAdd.hAdd.{0, 0, 0} Nat Nat Nat (@instHAdd.{0} Nat instAddNat)
    (@OfNat.ofNat.{0} Nat (nat_lit 1) (instOfNatNat (nat_lit 1)))
    (@OfNat.ofNat.{0} Nat (nat_lit 1) (instOfNatNat (nat_lit 1)))).AtLeastTwo :=
⋯
```

## `ProbabilityTheory.Cp.eq_1`

Command: `#print ProbabilityTheory.Cp.eq_1`

```lean
@[backward_defeq] theorem ProbabilityTheory.Cp.eq_1 : ∀ (d p q : Real),
  @Eq.{1} ENNReal (ProbabilityTheory.Cp d p q)
    (@Max.max.{0} ENNReal ENNReal.instMax
      (@HDiv.hDiv.{0, 0, 0} ENNReal ENNReal ENNReal
        (@instHDiv.{0} ENNReal (@DivInvMonoid.toDiv.{0} ENNReal ENNReal.instDivInvMonoid))
        (@OfNat.ofNat.{0} ENNReal (nat_lit 1) (@One.toOfNat1.{0} ENNReal ENNReal.instOne))
        (@HPow.hPow.{0, 0, 0} ENNReal Real ENNReal (@instHPow.{0, 0} ENNReal Real ENNReal.instPowReal)
          (@HSub.hSub.{0, 0, 0} ENNReal ENNReal ENNReal (@instHSub.{0} ENNReal ENNReal.instSub)
            (@HPow.hPow.{0, 0, 0} ENNReal Real ENNReal (@instHPow.{0, 0} ENNReal Real ENNReal.instPowReal)
              (@OfNat.ofNat.{0} ENNReal (nat_lit 2)
                (@instOfNatAtLeastTwo.{0} ENNReal (nat_lit 2)
                  (@AddMonoidWithOne.toNatCast.{0} ENNReal
                    (@AddCommMonoidWithOne.toAddMonoidWithOne.{0} ENNReal ENNReal.instAddCommMonoidWithOne))
                  ProbabilityTheory.Cp._proof_1))
              (@HDiv.hDiv.{0, 0, 0} Real Real Real
                (@instHDiv.{0} Real (@DivInvMonoid.toDiv.{0} Real Real.instDivInvMonoid))
                (@HSub.hSub.{0, 0, 0} Real Real Real (@instHSub.{0} Real Real.instSub) q d) p))
            (@OfNat.ofNat.{0} ENNReal (nat_lit 1) (@One.toOfNat1.{0} ENNReal ENNReal.instOne)))
          p))
      (@HDiv.hDiv.{0, 0, 0} ENNReal ENNReal ENNReal
        (@instHDiv.{0} ENNReal (@DivInvMonoid.toDiv.{0} ENNReal ENNReal.instDivInvMonoid))
        (@OfNat.ofNat.{0} ENNReal (nat_lit 1) (@One.toOfNat1.{0} ENNReal ENNReal.instOne))
        (@HSub.hSub.{0, 0, 0} ENNReal ENNReal ENNReal (@instHSub.{0} ENNReal ENNReal.instSub)
          (@HPow.hPow.{0, 0, 0} ENNReal Real ENNReal (@instHPow.{0, 0} ENNReal Real ENNReal.instPowReal)
            (@OfNat.ofNat.{0} ENNReal (nat_lit 2)
              (@instOfNatAtLeastTwo.{0} ENNReal (nat_lit 2)
                (@AddMonoidWithOne.toNatCast.{0} ENNReal
                  (@AddCommMonoidWithOne.toAddMonoidWithOne.{0} ENNReal ENNReal.instAddCommMonoidWithOne))
                ProbabilityTheory.Cp._proof_1))
            (@HSub.hSub.{0, 0, 0} Real Real Real (@instHSub.{0} Real Real.instSub) q d))
          (@OfNat.ofNat.{0} ENNReal (nat_lit 1) (@One.toOfNat1.{0} ENNReal ENNReal.instOne))))) :=
⋯
```

## `ProbabilityTheory.HasLaw.IsPreBrownianReal`

Command: `#print ProbabilityTheory.HasLaw.IsPreBrownianReal`

```lean
theorem ProbabilityTheory.HasLaw.IsPreBrownianReal.{u_2} : ∀ {Ω : Type u_2} {mΩ : MeasurableSpace.{u_2} Ω}
  {X : NNReal → Ω → Real} {P : @MeasureTheory.Measure.{u_2} Ω mΩ},
  @ProbabilityTheory.HasLaw.{u_2, 0} Ω (NNReal → Real) mΩ
      (@MeasurableSpace.pi.{0, 0} NNReal (fun a => Real) fun a => Real.measurableSpace) (fun ω x => X x ω)
      ProbabilityTheory.gaussianLimit P →
    @ProbabilityTheory.IsPreBrownianReal.{u_2} Ω mΩ X P :=
⋯
```

## `ProbabilityTheory.IsAEKolmogorovProcess.lintegral_sup_rpow_edist_eq_zero'`

Command: `#print ProbabilityTheory.IsAEKolmogorovProcess.lintegral_sup_rpow_edist_eq_zero'`

```lean
theorem ProbabilityTheory.IsAEKolmogorovProcess.lintegral_sup_rpow_edist_eq_zero'.{u_1, u_2, u_3} : ∀ {T : Type u_1}
  {Ω : Type u_2} {E : Type u_3} [inst : PseudoEMetricSpace.{u_1} T] {mΩ : MeasurableSpace.{u_2} Ω}
  [inst_1 : PseudoEMetricSpace.{u_3} E] {p q : Real} {M : NNReal} {P : @MeasureTheory.Measure.{u_2} Ω mΩ}
  {X : T → Ω → E},
  @ProbabilityTheory.IsAEKolmogorovProcess.{u_1, u_2, u_3} T Ω E inst mΩ inst_1 X P p q M →
    ∀ {J : Set.{u_1} T},
      @Set.Countable.{u_1} T J →
        ∀ {δ : ENNReal},
          (∀ (s : @Set.Elem.{u_1} T J)
              (t :
                @Subtype.{u_1 + 1} (@Set.Elem.{u_1} T J) fun t =>
                  @LE.le.{0} ENNReal ENNReal.instLE
                    (@EDist.edist.{u_1} (@Set.Elem.{u_1} T J)
                      (@WeakPseudoEMetricSpace.toEDist.{u_1} (@Set.Elem.{u_1} T J)
                        (@instTopologicalSpaceSubtype.{u_1} T
                          (fun x => @Membership.mem.{u_1, u_1} T (Set.{u_1} T) (@Set.instMembership.{u_1} T) J x)
                          (@UniformSpace.toTopologicalSpace.{u_1} T (@PseudoEMetricSpace.toUniformSpace.{u_1} T inst)))
                        (@instWeakPseudoEMetricSpaceSubtype.{u_1} T
                          (fun x => @Membership.mem.{u_1, u_1} T (Set.{u_1} T) (@Set.instMembership.{u_1} T) J x)
                          (@UniformSpace.toTopologicalSpace.{u_1} T (@PseudoEMetricSpace.toUniformSpace.{u_1} T inst))
                          (@PseudoEMetricSpace.toWeakPseudoEMetricSpace.{u_1} T inst)))
                      s t)
                    δ),
              @Eq.{1} ENNReal
                (@EDist.edist.{u_1} (@Set.Elem.{u_1} T J)
                  (@WeakPseudoEMetricSpace.toEDist.{u_1} (@Set.Elem.{u_1} T J)
                    (@instTopologicalSpaceSubtype.{u_1} T
                      (fun x => @Membership.mem.{u_1, u_1} T (Set.{u_1} T) (@Set.instMembership.{u_1} T) J x)
                      (@UniformSpace.toTopologicalSpace.{u_1} T (@PseudoEMetricSpace.toUniformSpace.{u_1} T inst)))
                    (@instWeakPseudoEMetricSpaceSubtype.{u_1} T
                      (fun x => @Membership.mem.{u_1, u_1} T (Set.{u_1} T) (@Set.instMembership.{u_1} T) J x)
                      (@UniformSpace.toTopologicalSpace.{u_1} T (@PseudoEMetricSpace.toUniformSpace.{u_1} T inst))
                      (@PseudoEMetricSpace.toWeakPseudoEMetricSpace.{u_1} T inst)))
                  s
                  (@Subtype.val.{u_1 + 1} (@Set.Elem.{u_1} T J)
                    (fun t =>
                      @LE.le.{0} ENNReal ENNReal.instLE
                        (@EDist.edist.{u_1} (@Set.Elem.{u_1} T J)
                          (@WeakPseudoEMetricSpace.toEDist.{u_1} (@Set.Elem.{u_1} T J)
                            (@instTopologicalSpaceSubtype.{u_1} T
                              (fun x => @Membership.mem.{u_1, u_1} T (Set.{u_1} T) (@Set.instMembership.{u_1} T) J x)
                              (@UniformSpace.toTopologicalSpace.{u_1} T
                                (@PseudoEMetricSpace.toUniformSpace.{u_1} T inst)))
                            (@instWeakPseudoEMetricSpaceSubtype.{u_1} T
                              (fun x => @Membership.mem.{u_1, u_1} T (Set.{u_1} T) (@Set.instMembership.{u_1} T) J x)
                              (@UniformSpace.toTopologicalSpace.{u_1} T
                                (@PseudoEMetricSpace.toUniformSpace.{u_1} T inst))
                              (@PseudoEMetricSpace.toWeakPseudoEMetricSpace.{u_1} T inst)))
                          s t)
                        δ)
                    t))
                (@OfNat.ofNat.{0} ENNReal (nat_lit 0) (@Zero.toOfNat0.{0} ENNReal ENNReal.instZero))) →
            @Eq.{1} ENNReal
              (@MeasureTheory.lintegral.{u_2} Ω mΩ P fun ω =>
                ⨆ s,
                  ⨆ t,
                    @HPow.hPow.{0, 0, 0} ENNReal Real ENNReal (@instHPow.{0, 0} ENNReal Real ENNReal.instPowReal)
                      (@EDist.edist.{u_3} E
                        (@WeakPseudoEMetricSpace.toEDist.{u_3} E
                          (@UniformSpace.toTopologicalSpace.{u_3} E (@PseudoEMetricSpace.toUniformSpace.{u_3} E inst_1))
                          (@PseudoEMetricSpace.toWeakPseudoEMetricSpace.{u_3} E inst_1))
                        (X
                          (@Subtype.val.{u_1 + 1} T
                            (fun x => @Membership.mem.{u_1, u_1} T (Set.{u_1} T) (@Set.instMembership.{u_1} T) J x) s)
                          ω)
                        (X
                          (@Subtype.val.{u_1 + 1} T
                            (fun x => @Membership.mem.{u_1, u_1} T (Set.{u_1} T) (@Set.instMembership.{u_1} T) J x)
                            (@Subtype.val.{u_1 + 1} (@Set.Elem.{u_1} T J)
                              (fun t =>
                                @LE.le.{0} ENNReal ENNReal.instLE
                                  (@EDist.edist.{u_1} (@Set.Elem.{u_1} T J)
                                    (@WeakPseudoEMetricSpace.toEDist.{u_1} (@Set.Elem.{u_1} T J)
                                      (@instTopologicalSpaceSubtype.{u_1} T
                                        (fun x =>
                                          @Membership.mem.{u_1, u_1} T (Set.{u_1} T) (@Set.instMembership.{u_1} T) J x)
                                        (@UniformSpace.toTopologicalSpace.{u_1} T
                                          (@PseudoEMetricSpace.toUniformSpace.{u_1} T inst)))
                                      (@instWeakPseudoEMetricSpaceSubtype.{u_1} T
                                        (fun x =>
                                          @Membership.mem.{u_1, u_1} T (Set.{u_1} T) (@Set.instMembership.{u_1} T) J x)
                                        (@UniformSpace.toTopologicalSpace.{u_1} T
                                          (@PseudoEMetricSpace.toUniformSpace.{u_1} T inst))
                                        (@PseudoEMetricSpace.toWeakPseudoEMetricSpace.{u_1} T inst)))
                                    s t)
                                  δ)
                              t))
                          ω))
                      p)
              (@OfNat.ofNat.{0} ENNReal (nat_lit 0) (@Zero.toOfNat0.{0} ENNReal ENNReal.instZero)) :=
⋯
```

## `ProbabilityTheory.IsFilteredPreBrownian.mk`

Command: `#print ProbabilityTheory.IsFilteredPreBrownian.mk`

```lean
constructor ProbabilityTheory.IsFilteredPreBrownian.mk.{u_2} : ∀ {Ω : Type u_2} {mΩ : MeasurableSpace.{u_2} Ω}
  {X : NNReal → Ω → Real}
  {𝓕 : @MeasureTheory.Filtration.{u_2, 0} Ω NNReal (@PartialOrder.toPreorder.{0} NNReal NNReal.instPartialOrder) mΩ}
  {P : @MeasureTheory.Measure.{u_2} Ω mΩ},
  @ProbabilityTheory.IsPreBrownianReal.{u_2} Ω mΩ X P →
    @MeasureTheory.StronglyAdapted.{u_2, 0, 0} Ω NNReal mΩ (@PartialOrder.toPreorder.{0} NNReal NNReal.instPartialOrder)
        (fun i => Real)
        (fun i =>
          @UniformSpace.toTopologicalSpace.{0} Real (@PseudoMetricSpace.toUniformSpace.{0} Real Real.pseudoMetricSpace))
        𝓕 X →
      (∀ (s t : NNReal),
          @LE.le.{0} NNReal (@Preorder.toLE.{0} NNReal (@PartialOrder.toPreorder.{0} NNReal NNReal.instPartialOrder)) s
              t →
            @ProbabilityTheory.Indep.{u_2} Ω
              (@MeasurableSpace.comap.{u_2, 0} Ω Real
                (@HSub.hSub.{u_2, u_2, u_2} (Ω → Real) (Ω → Real) (Ω → Real)
                  (@instHSub.{u_2} (Ω → Real) (@Pi.instSub.{u_2, 0} Ω (fun a => Real) fun i => Real.instSub)) (X t)
                  (X s))
                (@inferInstance.{1} (MeasurableSpace.{0} Real) Real.measurableSpace))
              (@MeasureTheory.Filtration.seq.{u_2, 0} Ω NNReal
                (@PartialOrder.toPreorder.{0} NNReal NNReal.instPartialOrder) mΩ 𝓕 s)
              mΩ P) →
        @ProbabilityTheory.IsFilteredPreBrownian.{u_2} Ω mΩ X 𝓕 P
```

## `ProbabilityTheory.IsKolmogorovProcess.ae_iSup_rpow_edist_div_lt_top`

Command: `#print ProbabilityTheory.IsKolmogorovProcess.ae_iSup_rpow_edist_div_lt_top`

```lean
theorem ProbabilityTheory.IsKolmogorovProcess.ae_iSup_rpow_edist_div_lt_top.{u_1, u_2, u_3} : ∀ {T : Type u_1}
  {Ω : Type u_2} {E : Type u_3} {mΩ : MeasurableSpace.{u_2} Ω} {X : T → Ω → E} {c : ENNReal} {d p q : Real}
  {M β : NNReal} {P : @MeasureTheory.Measure.{u_2} Ω mΩ} {U : Set.{u_1} T} [inst : PseudoEMetricSpace.{u_1} T]
  [inst_1 : PseudoEMetricSpace.{u_3} E] [inst_2 : MeasurableSpace.{u_3} E]
  [@BorelSpace.{u_3} E (@UniformSpace.toTopologicalSpace.{u_3} E (@PseudoEMetricSpace.toUniformSpace.{u_3} E inst_1))
      inst_2],
  @HasBoundedCoveringNumber.{u_1} T inst U c d →
    @ProbabilityTheory.IsKolmogorovProcess.{u_1, u_2, u_3} T Ω E inst mΩ inst_1 X P p q M →
      @Ne.{1} ENNReal c (@Top.top.{0} ENNReal ENNReal.instTop) →
        @LT.lt.{0} Real Real.instLT (@OfNat.ofNat.{0} Real (nat_lit 0) (@Zero.toOfNat0.{0} Real Real.instZero)) d →
          @LT.lt.{0} Real Real.instLT d q →
            @LT.lt.{0} NNReal (@Preorder.toLT.{0} NNReal (@PartialOrder.toPreorder.{0} NNReal NNReal.instPartialOrder))
                (@OfNat.ofNat.{0} NNReal (nat_lit 0) (@Zero.toOfNat0.{0} NNReal NNReal.instZero)) β →
              @LT.lt.{0} Real Real.instLT (↑β)
                  (@HDiv.hDiv.{0, 0, 0} Real Real Real
                    (@instHDiv.{0} Real (@DivInvMonoid.toDiv.{0} Real Real.instDivInvMonoid))
                    (@HSub.hSub.{0, 0, 0} Real Real Real (@instHSub.{0} Real Real.instSub) q d) p) →
                ∀ {T' : Set.{u_1} T},
                  @Set.Countable.{u_1} T T' →
                    @LE.le.{u_1} (Set.{u_1} T) (@Set.instLE.{u_1} T) T' U →
                      @Filter.Eventually.{u_2} Ω
                        (fun ω =>
                          @LT.lt.{0} ENNReal
                            (@Preorder.toLT.{0} ENNReal (@PartialOrder.toPreorder.{0} ENNReal ENNReal.instPartialOrder))
                            (⨆ s,
                              ⨆ t,
                                @HDiv.hDiv.{0, 0, 0} ENNReal ENNReal ENNReal
                                  (@instHDiv.{0} ENNReal (@DivInvMonoid.toDiv.{0} ENNReal ENNReal.instDivInvMonoid))
                                  (@HPow.hPow.{0, 0, 0} ENNReal Real ENNReal
                                    (@instHPow.{0, 0} ENNReal Real ENNReal.instPowReal)
                                    (@EDist.edist.{u_3} E
                                      (@WeakPseudoEMetricSpace.toEDist.{u_3} E
                                        (@UniformSpace.toTopologicalSpace.{u_3} E
                                          (@PseudoEMetricSpace.toUniformSpace.{u_3} E inst_1))
                                        (@PseudoEMetricSpace.toWeakPseudoEMetricSpace.{u_3} E inst_1))
                                      (X
                                        (@Subtype.val.{u_1 + 1} T
                                          (fun x =>
                                            @Membership.mem.{u_1, u_1} T (Set.{u_1} T) (@Set.instMembership.{u_1} T) T'
                                              x)
                                          s)
                                        ω)
                                      (X
                                        (@Subtype.val.{u_1 + 1} T
                                          (fun x =>
                                            @Membership.mem.{u_1, u_1} T (Set.{u_1} T) (@Set.instMembership.{u_1} T) T'
                                              x)
                                          t)
                                        ω))
                                    p)
                                  (@HPow.hPow.{0, 0, 0} ENNReal Real ENNReal
                                    (@instHPow.{0, 0} ENNReal Real ENNReal.instPowReal)
                                    (@EDist.edist.{u_1} (@Set.Elem.{u_1} T T')
                                      (@WeakPseudoEMetricSpace.toEDist.{u_1} (@Set.Elem.{u_1} T T')
                                        (@instTopologicalSpaceSubtype.{u_1} T
                                          (fun x =>
                                            @Membership.mem.{u_1, u_1} T (Set.{u_1} T) (@Set.instMembership.{u_1} T) T'
                                              x)
                                          (@UniformSpace.toTopologicalSpace.{u_1} T
                                            (@PseudoEMetricSpace.toUniformSpace.{u_1} T inst)))
                                        (@instWeakPseudoEMetricSpaceSubtype.{u_1} T
                                          (fun x =>
                                            @Membership.mem.{u_1, u_1} T (Set.{u_1} T) (@Set.instMembership.{u_1} T) T'
                                              x)
                                          (@UniformSpace.toTopologicalSpace.{u_1} T
                                            (@PseudoEMetricSpace.toUniformSpace.{u_1} T inst))
                                          (@PseudoEMetricSpace.toWeakPseudoEMetricSpace.{u_1} T inst)))
                                      s t)
                                    (@HMul.hMul.{0, 0, 0} Real Real Real (@instHMul.{0} Real Real.instMul) (↑β) p)))
                            (@Top.top.{0} ENNReal ENNReal.instTop))
                        (@MeasureTheory.ae.{u_2, u_2} Ω (@MeasureTheory.Measure.{u_2} Ω mΩ)
                          (@MeasureTheory.Measure.instFunLike.{u_2} Ω mΩ) ⋯ P) :=
⋯
```

## `ProbabilityTheory.IsKolmogorovProcess.measurableSet_holderSet`

Command: `#print ProbabilityTheory.IsKolmogorovProcess.measurableSet_holderSet`

```lean
theorem ProbabilityTheory.IsKolmogorovProcess.measurableSet_holderSet.{u_1, u_2, u_3} : ∀ {T : Type u_1} {Ω : Type u_2}
  {E : Type u_3} {mΩ : MeasurableSpace.{u_2} Ω} {X : T → Ω → E} {p q : Real} {M β : NNReal}
  {P : @MeasureTheory.Measure.{u_2} Ω mΩ} {U : Set.{u_1} T} [inst : PseudoEMetricSpace.{u_1} T]
  [inst_1 : PseudoEMetricSpace.{u_3} E],
  @ProbabilityTheory.IsKolmogorovProcess.{u_1, u_2, u_3} T Ω E inst mΩ inst_1 X P p q M →
    ∀ {T' : Set.{u_1} T},
      @Set.Countable.{u_1} T T' →
        @MeasurableSet.{u_2} Ω mΩ (@ProbabilityTheory.holderSet.{u_1, u_2, u_3} T Ω E inst inst_1 X T' p (↑β) U) :=
⋯
```

## `ProbabilityTheory.IsKolmogorovProcess.tendstoInMeasure`

Command: `#print ProbabilityTheory.IsKolmogorovProcess.tendstoInMeasure`

```lean
theorem ProbabilityTheory.IsKolmogorovProcess.tendstoInMeasure.{u_1, u_2, u_3} : ∀ {T : Type u_1} {Ω : Type u_2}
  {E : Type u_3} {mΩ : MeasurableSpace.{u_2} Ω} {X : T → Ω → E} {p q : Real} {M : NNReal}
  {P : @MeasureTheory.Measure.{u_2} Ω mΩ} [inst : PseudoEMetricSpace.{u_1} T] [inst_1 : PseudoEMetricSpace.{u_3} E],
  @ProbabilityTheory.IsKolmogorovProcess.{u_1, u_2, u_3} T Ω E inst mΩ inst_1 X P p q M →
    @LT.lt.{0} Real Real.instLT (@OfNat.ofNat.{0} Real (nat_lit 0) (@Zero.toOfNat0.{0} Real Real.instZero)) q →
      ∀ {T' : Set.{u_1} T} {u : Nat → @Set.Elem.{u_1} T T'} {t : T},
        @Filter.Tendsto.{0, u_1} Nat T
            (fun n =>
              @Subtype.val.{u_1 + 1} T
                (fun x => @Membership.mem.{u_1, u_1} T (Set.{u_1} T) (@Set.instMembership.{u_1} T) T' x) (u n))
            (@Filter.atTop.{0} Nat Nat.instPreorder)
            (@nhds.{u_1} T (@UniformSpace.toTopologicalSpace.{u_1} T (@PseudoEMetricSpace.toUniformSpace.{u_1} T inst))
              t) →
          @MeasureTheory.TendstoInMeasure.{u_2, 0, u_3} Ω Nat E
            (@WeakPseudoEMetricSpace.toEDist.{u_3} E
              (@UniformSpace.toTopologicalSpace.{u_3} E (@PseudoEMetricSpace.toUniformSpace.{u_3} E inst_1))
              (@PseudoEMetricSpace.toWeakPseudoEMetricSpace.{u_3} E inst_1))
            mΩ P
            (fun n =>
              X
                (@Subtype.val.{u_1 + 1} T
                  (fun x => @Membership.mem.{u_1, u_1} T (Set.{u_1} T) (@Set.instMembership.{u_1} T) T' x) (u n)))
            (@Filter.atTop.{0} Nat Nat.instPreorder) (X t) :=
⋯
```

## `ProbabilityTheory.IsLimitOfIndicator.indicatorProcess`

Command: `#print ProbabilityTheory.IsLimitOfIndicator.indicatorProcess`

```lean
theorem ProbabilityTheory.IsLimitOfIndicator.indicatorProcess.{u_1, u_2, u_3} : ∀ {T : Type u_1} {Ω : Type u_2}
  {E : Type u_3} {mΩ : MeasurableSpace.{u_2} Ω} {P : @MeasureTheory.Measure.{u_2} Ω mΩ} {U : Set.{u_1} T}
  [inst : PseudoEMetricSpace.{u_3} E] [hE : Nonempty.{u_3 + 1} E] [inst_1 : TopologicalSpace.{u_1} T]
  [inst_2 : @SecondCountableTopology.{u_1} T inst_1] {Y X : T → Ω → E},
  @ProbabilityTheory.IsLimitOfIndicator.{u_1, u_2, u_3} T Ω E mΩ inst hE inst_1 inst_2 Y X P U →
    ∀ (A : Set.{u_2} Ω),
      @MeasurableSet.{u_2} Ω mΩ A →
        @Filter.Eventually.{u_2} Ω
            (fun ω => @Membership.mem.{u_2, u_2} Ω (Set.{u_2} Ω) (@Set.instMembership.{u_2} Ω) A ω)
            (@MeasureTheory.ae.{u_2, u_2} Ω (@MeasureTheory.Measure.{u_2} Ω mΩ)
              (@MeasureTheory.Measure.instFunLike.{u_2} Ω mΩ) ⋯ P) →
          @ProbabilityTheory.IsLimitOfIndicator.{u_1, u_2, u_3} T Ω E mΩ inst hE inst_1 inst_2
            (fun t => @ProbabilityTheory.indicatorProcess.{u_1, u_2, u_3} T Ω E hE Y A t) X P U :=
⋯
```

## `ProbabilityTheory.IsLimitOfIndicator.measurable`

Command: `#print ProbabilityTheory.IsLimitOfIndicator.measurable`

```lean
theorem ProbabilityTheory.IsLimitOfIndicator.measurable.{u_1, u_2, u_3} : ∀ {T : Type u_1} {Ω : Type u_2} {E : Type u_3}
  {mΩ : MeasurableSpace.{u_2} Ω} {P : @MeasureTheory.Measure.{u_2} Ω mΩ} {U : Set.{u_1} T}
  [inst : PseudoEMetricSpace.{u_3} E] [hE : Nonempty.{u_3 + 1} E] [inst_1 : TopologicalSpace.{u_1} T]
  [inst_2 : @SecondCountableTopology.{u_1} T inst_1] [inst_3 : MeasurableSpace.{u_3} E]
  [@BorelSpace.{u_3} E (@UniformSpace.toTopologicalSpace.{u_3} E (@PseudoEMetricSpace.toUniformSpace.{u_3} E inst))
      inst_3]
  {Y X : T → Ω → E},
  (∀ (t : T), @Measurable.{u_2, u_3} Ω E mΩ inst_3 (X t)) →
    @ProbabilityTheory.IsLimitOfIndicator.{u_1, u_2, u_3} T Ω E mΩ inst hE inst_1 inst_2 Y X P U →
      ∀ (t : T), @Measurable.{u_2, u_3} Ω E mΩ inst_3 (Y t) :=
⋯
```

## `ProbabilityTheory.IsLimitOfIndicator.measurable_edist`

Command: `#print ProbabilityTheory.IsLimitOfIndicator.measurable_edist`

```lean
theorem ProbabilityTheory.IsLimitOfIndicator.measurable_edist.{u_2, u_3, u_4} : ∀ {Ω : Type u_2} {E : Type u_3}
  {mΩ : MeasurableSpace.{u_2} Ω} {P : @MeasureTheory.Measure.{u_2} Ω mΩ} [inst : PseudoEMetricSpace.{u_3} E]
  [hE : Nonempty.{u_3 + 1} E] {T : Type u_4} [inst_1 : PseudoEMetricSpace.{u_4} T]
  [inst_2 :
    @SecondCountableTopology.{u_4} T
      (@UniformSpace.toTopologicalSpace.{u_4} T (@PseudoEMetricSpace.toUniformSpace.{u_4} T inst_1))]
  [inst_3 : MeasurableSpace.{u_3} E]
  [@BorelSpace.{u_3} E (@UniformSpace.toTopologicalSpace.{u_3} E (@PseudoEMetricSpace.toUniformSpace.{u_3} E inst))
      inst_3]
  {Y X Z X' : T → Ω → E} {U₁ U₂ : Set.{u_4} T},
  (∀ (t : T), @Measurable.{u_2, u_3} Ω E mΩ inst_3 (X t)) →
    (∀ (t : T), @Measurable.{u_2, u_3} Ω E mΩ inst_3 (X' t)) →
      (∀ (i j : T),
          @Measurable.{u_2, u_3} Ω (Prod.{u_3, u_3} E E) mΩ
            (@borel.{u_3} (Prod.{u_3, u_3} E E)
              (@instTopologicalSpaceProd.{u_3, u_3} E E
                (@UniformSpace.toTopologicalSpace.{u_3} E (@PseudoEMetricSpace.toUniformSpace.{u_3} E inst))
                (@UniformSpace.toTopologicalSpace.{u_3} E (@PseudoEMetricSpace.toUniformSpace.{u_3} E inst))))
            fun ω => @Prod.mk.{u_3, u_3} E E (X i ω) (X' j ω)) →
        @ProbabilityTheory.IsLimitOfIndicator.{u_4, u_2, u_3} T Ω E mΩ inst hE
            (@UniformSpace.toTopologicalSpace.{u_4} T (@PseudoEMetricSpace.toUniformSpace.{u_4} T inst_1)) inst_2 Y X P
            U₁ →
          @ProbabilityTheory.IsLimitOfIndicator.{u_4, u_2, u_3} T Ω E mΩ inst hE
              (@UniformSpace.toTopologicalSpace.{u_4} T (@PseudoEMetricSpace.toUniformSpace.{u_4} T inst_1)) inst_2 Z X'
              P U₂ →
            ∀ (s t : T),
              @Measurable.{u_2, 0} Ω ENNReal mΩ ENNReal.measurableSpace fun ω =>
                @EDist.edist.{u_3} E
                  (@WeakPseudoEMetricSpace.toEDist.{u_3} E
                    (@UniformSpace.toTopologicalSpace.{u_3} E (@PseudoEMetricSpace.toUniformSpace.{u_3} E inst))
                    (@PseudoEMetricSpace.toWeakPseudoEMetricSpace.{u_3} E inst))
                  (Y s ω) (Z t ω) :=
⋯
```

## `ProbabilityTheory.IsLimitOfIndicator.measurable_pair`

Command: `#print ProbabilityTheory.IsLimitOfIndicator.measurable_pair`

```lean
theorem ProbabilityTheory.IsLimitOfIndicator.measurable_pair.{u_2, u_3, u_4} : ∀ {Ω : Type u_2} {E : Type u_3}
  {mΩ : MeasurableSpace.{u_2} Ω} {P : @MeasureTheory.Measure.{u_2} Ω mΩ} [inst : PseudoEMetricSpace.{u_3} E]
  [hE : Nonempty.{u_3 + 1} E] {T : Type u_4} [inst_1 : PseudoEMetricSpace.{u_4} T]
  [inst_2 :
    @SecondCountableTopology.{u_4} T
      (@UniformSpace.toTopologicalSpace.{u_4} T (@PseudoEMetricSpace.toUniformSpace.{u_4} T inst_1))]
  [inst_3 : MeasurableSpace.{u_3} E]
  [@BorelSpace.{u_3} E (@UniformSpace.toTopologicalSpace.{u_3} E (@PseudoEMetricSpace.toUniformSpace.{u_3} E inst))
      inst_3]
  {Y X Z X' : T → Ω → E} {U₁ U₂ : Set.{u_4} T},
  (∀ (t : T), @Measurable.{u_2, u_3} Ω E mΩ inst_3 (X t)) →
    (∀ (t : T), @Measurable.{u_2, u_3} Ω E mΩ inst_3 (X' t)) →
      (∀ (i j : T),
          @Measurable.{u_2, u_3} Ω (Prod.{u_3, u_3} E E) mΩ
            (@borel.{u_3} (Prod.{u_3, u_3} E E)
              (@instTopologicalSpaceProd.{u_3, u_3} E E
                (@UniformSpace.toTopologicalSpace.{u_3} E (@PseudoEMetricSpace.toUniformSpace.{u_3} E inst))
                (@UniformSpace.toTopologicalSpace.{u_3} E (@PseudoEMetricSpace.toUniformSpace.{u_3} E inst))))
            fun ω => @Prod.mk.{u_3, u_3} E E (X i ω) (X' j ω)) →
        @ProbabilityTheory.IsLimitOfIndicator.{u_4, u_2, u_3} T Ω E mΩ inst hE
            (@UniformSpace.toTopologicalSpace.{u_4} T (@PseudoEMetricSpace.toUniformSpace.{u_4} T inst_1)) inst_2 Y X P
            U₁ →
          @ProbabilityTheory.IsLimitOfIndicator.{u_4, u_2, u_3} T Ω E mΩ inst hE
              (@UniformSpace.toTopologicalSpace.{u_4} T (@PseudoEMetricSpace.toUniformSpace.{u_4} T inst_1)) inst_2 Z X'
              P U₂ →
            ∀ (s t : T),
              @Measurable.{u_2, u_3} Ω (Prod.{u_3, u_3} E E) mΩ
                (@borel.{u_3} (Prod.{u_3, u_3} E E)
                  (@instTopologicalSpaceProd.{u_3, u_3} E E
                    (@UniformSpace.toTopologicalSpace.{u_3} E (@PseudoEMetricSpace.toUniformSpace.{u_3} E inst))
                    (@UniformSpace.toTopologicalSpace.{u_3} E (@PseudoEMetricSpace.toUniformSpace.{u_3} E inst))))
                fun ω => @Prod.mk.{u_3, u_3} E E (Y s ω) (Z t ω) :=
⋯
```

## `ProbabilityTheory.IsPreBrownianReal.continuous_mk`

Command: `#print ProbabilityTheory.IsPreBrownianReal.continuous_mk`

```lean
theorem ProbabilityTheory.IsPreBrownianReal.continuous_mk.{u_2} : ∀ {Ω : Type u_2} {mΩ : MeasurableSpace.{u_2} Ω}
  {X : NNReal → Ω → Real} {P : @MeasureTheory.Measure.{u_2} Ω mΩ}
  (h : @ProbabilityTheory.IsPreBrownianReal.{u_2} Ω mΩ X P) (ω : Ω),
  @Continuous.{0, 0} NNReal Real NNReal.instTopologicalSpace
    (@UniformSpace.toTopologicalSpace.{0} Real (@PseudoMetricSpace.toUniformSpace.{0} Real Real.pseudoMetricSpace))
    fun x => @ProbabilityTheory.IsPreBrownianReal.mk.{u_2} Ω mΩ P X h x ω :=
⋯
```

## `ProbabilityTheory.IsPreBrownianReal.exists_continuous_modification`

Command: `#print ProbabilityTheory.IsPreBrownianReal.exists_continuous_modification`

```lean
theorem ProbabilityTheory.IsPreBrownianReal.exists_continuous_modification.{u_2} : ∀ {Ω : Type u_2}
  {mΩ : MeasurableSpace.{u_2} Ω} {X : NNReal → Ω → Real} {P : @MeasureTheory.Measure.{u_2} Ω mΩ},
  @ProbabilityTheory.IsPreBrownianReal.{u_2} Ω mΩ X P →
    ∃ Y,
      And (∀ (t : NNReal), @Measurable.{u_2, 0} Ω Real mΩ Real.measurableSpace (Y t))
        (And
          (∀ (t : NNReal),
            @Filter.EventuallyEq.{u_2, 0} Ω Real
              (@MeasureTheory.ae.{u_2, u_2} Ω (@MeasureTheory.Measure.{u_2} Ω mΩ)
                (@MeasureTheory.Measure.instFunLike.{u_2} Ω mΩ) ⋯ P)
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
                          (@instOfNatAtLeastTwo.{0} Real (nat_lit 2) Real.instNatCast ⋯))
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
                        C β (fun x => Y x ω) U))) :=
⋯
```

## `ProbabilityTheory.IsPreBrownianReal.isAEKolmogorovProcess`

Command: `#print ProbabilityTheory.IsPreBrownianReal.isAEKolmogorovProcess`

```lean
theorem ProbabilityTheory.IsPreBrownianReal.isAEKolmogorovProcess.{u_2} : ∀ {Ω : Type u_2}
  {mΩ : MeasurableSpace.{u_2} Ω} {X : NNReal → Ω → Real} {P : @MeasureTheory.Measure.{u_2} Ω mΩ} {n : Nat},
  @LT.lt.{0} Nat instLTNat (@OfNat.ofNat.{0} Nat (nat_lit 0) (instOfNatNat (nat_lit 0))) n →
    @ProbabilityTheory.IsPreBrownianReal.{u_2} Ω mΩ X P →
      @ProbabilityTheory.IsAEKolmogorovProcess.{0, u_2, 0} NNReal Ω Real
        (@EMetricSpace.toPseudoEMetricSpace.{0} NNReal (@MetricSpace.toEMetricSpace.{0} NNReal instMetricSpaceNNReal))
        mΩ (@EMetricSpace.toPseudoEMetricSpace.{0} Real (@MetricSpace.toEMetricSpace.{0} Real Real.metricSpace)) X P
        (@HMul.hMul.{0, 0, 0} Real Real Real (@instHMul.{0} Real Real.instMul)
          (@OfNat.ofNat.{0} Real (nat_lit 2) (@instOfNatAtLeastTwo.{0} Real (nat_lit 2) Real.instNatCast ⋯))
          (@Nat.cast.{0} Real Real.instNatCast n))
        (@Nat.cast.{0} Real Real.instNatCast n)
        (@Nat.cast.{0} NNReal
          (@AddMonoidWithOne.toNatCast.{0} NNReal
            (@AddCommMonoidWithOne.toAddMonoidWithOne.{0} NNReal
              (@NonAssocSemiring.toAddCommMonoidWithOne.{0} NNReal
                (@Semiring.toNonAssocSemiring.{0} NNReal NNReal.instSemiring))))
          (@HSub.hSub.{0, 0, 0} Nat Nat Nat (@instHSub.{0} Nat instSubNat)
              (@HMul.hMul.{0, 0, 0} Nat Nat Nat (@instHMul.{0} Nat instMulNat)
                (@OfNat.ofNat.{0} Nat (nat_lit 2) (instOfNatNat (nat_lit 2))) n)
              (@OfNat.ofNat.{0} Nat (nat_lit 1) (instOfNatNat (nat_lit 1)))).doubleFactorial) :=
⋯
```

## `ProbabilityTheory.IsPreBrownianReal.isBrownianReal_mk`

Command: `#print ProbabilityTheory.IsPreBrownianReal.isBrownianReal_mk`

```lean
theorem ProbabilityTheory.IsPreBrownianReal.isBrownianReal_mk.{u_2} : ∀ {Ω : Type u_2} {mΩ : MeasurableSpace.{u_2} Ω}
  {P : @MeasureTheory.Measure.{u_2} Ω mΩ} {X : NNReal → Ω → Real}
  (h : @ProbabilityTheory.IsPreBrownianReal.{u_2} Ω mΩ X P),
  @ProbabilityTheory.IsBrownianReal.{u_2} Ω mΩ (@ProbabilityTheory.IsPreBrownianReal.mk.{u_2} Ω mΩ P X h) P :=
⋯
```

## `ProbabilityTheory.IsPreBrownianReal.isFilteredPreBrownian`

Command: `#print ProbabilityTheory.IsPreBrownianReal.isFilteredPreBrownian`

```lean
theorem ProbabilityTheory.IsPreBrownianReal.isFilteredPreBrownian.{u_2} : ∀ {Ω : Type u_2}
  {mΩ : MeasurableSpace.{u_2} Ω} {X : NNReal → Ω → Real} {P : @MeasureTheory.Measure.{u_2} Ω mΩ},
  @ProbabilityTheory.IsPreBrownianReal.{u_2} Ω mΩ X P →
    ∀ (hX : ∀ (t : NNReal), @Measurable.{u_2, 0} Ω Real mΩ Real.measurableSpace (X t)),
      @ProbabilityTheory.IsFilteredPreBrownian.{u_2} Ω mΩ X
        (@MeasureTheory.Filtration.natural.{u_2, 0, 0} Ω NNReal mΩ (fun i => Real)
          (fun i =>
            @UniformSpace.toTopologicalSpace.{0} Real
              (@PseudoMetricSpace.toUniformSpace.{0} Real Real.pseudoMetricSpace))
          ⋯ (fun i => Real.measurableSpace) ⋯ (@PartialOrder.toPreorder.{0} NNReal NNReal.instPartialOrder) X ⋯)
        P :=
⋯
```

## `ProbabilityTheory.IsPreBrownianReal.measurable_mk`

Command: `#print ProbabilityTheory.IsPreBrownianReal.measurable_mk`

```lean
theorem ProbabilityTheory.IsPreBrownianReal.measurable_mk.{u_2} : ∀ {Ω : Type u_2} {mΩ : MeasurableSpace.{u_2} Ω}
  {X : NNReal → Ω → Real} {P : @MeasureTheory.Measure.{u_2} Ω mΩ}
  (h : @ProbabilityTheory.IsPreBrownianReal.{u_2} Ω mΩ X P) (t : NNReal),
  @Measurable.{u_2, 0} Ω Real mΩ Real.measurableSpace (@ProbabilityTheory.IsPreBrownianReal.mk.{u_2} Ω mΩ P X h t) :=
⋯
```

## `ProbabilityTheory.IsPreBrownianReal.memHolder_mk`

Command: `#print ProbabilityTheory.IsPreBrownianReal.memHolder_mk`

```lean
theorem ProbabilityTheory.IsPreBrownianReal.memHolder_mk.{u_2} : ∀ {Ω : Type u_2} {mΩ : MeasurableSpace.{u_2} Ω}
  {X : NNReal → Ω → Real} {P : @MeasureTheory.Measure.{u_2} Ω mΩ}
  (h : @ProbabilityTheory.IsPreBrownianReal.{u_2} Ω mΩ X P) (ω : Ω) (t β : NNReal),
  @LT.lt.{0} NNReal (@Preorder.toLT.{0} NNReal (@PartialOrder.toPreorder.{0} NNReal NNReal.instPartialOrder))
      (@OfNat.ofNat.{0} NNReal (nat_lit 0) (@Zero.toOfNat0.{0} NNReal NNReal.instZero)) β →
    @LT.lt.{0} NNReal (@Preorder.toLT.{0} NNReal (@PartialOrder.toPreorder.{0} NNReal NNReal.instPartialOrder)) β
        (@Inv.inv.{0} NNReal NNReal.instInv
          (@OfNat.ofNat.{0} NNReal (nat_lit 2)
            (@instOfNatAtLeastTwo.{0} NNReal (nat_lit 2)
              (@AddMonoidWithOne.toNatCast.{0} NNReal
                (@AddCommMonoidWithOne.toAddMonoidWithOne.{0} NNReal
                  (@NonAssocSemiring.toAddCommMonoidWithOne.{0} NNReal
                    (@Semiring.toNonAssocSemiring.{0} NNReal NNReal.instSemiring))))
              ⋯))) →
      ∃ U,
        And
          (@Membership.mem.{0, 0} (Set.{0} NNReal) (Filter.{0} NNReal) (@Filter.instMembership.{0} NNReal)
            (@nhds.{0} NNReal NNReal.instTopologicalSpace t) U)
          (∃ C,
            @HolderOnWith.{0, 0} NNReal Real
              (@EMetricSpace.toPseudoEMetricSpace.{0} NNReal
                (@MetricSpace.toEMetricSpace.{0} NNReal instMetricSpaceNNReal))
              (@EMetricSpace.toPseudoEMetricSpace.{0} Real (@MetricSpace.toEMetricSpace.{0} Real Real.metricSpace)) C β
              (fun x => @ProbabilityTheory.IsPreBrownianReal.mk.{u_2} Ω mΩ P X h x ω) U) :=
⋯
```

## `ProbabilityTheory.IsPreBrownianReal.mk`

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
                (@MeasureTheory.Measure.instFunLike.{u_2} Ω mΩ) ⋯ P)
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
    ⋯
```

## `ProbabilityTheory.IsPreBrownianReal.mk_ae_eq`

Command: `#print ProbabilityTheory.IsPreBrownianReal.mk_ae_eq`

```lean
theorem ProbabilityTheory.IsPreBrownianReal.mk_ae_eq.{u_2} : ∀ {Ω : Type u_2} {mΩ : MeasurableSpace.{u_2} Ω}
  {X : NNReal → Ω → Real} {P : @MeasureTheory.Measure.{u_2} Ω mΩ}
  (h : @ProbabilityTheory.IsPreBrownianReal.{u_2} Ω mΩ X P) (t : NNReal),
  @Filter.EventuallyEq.{u_2, 0} Ω Real
    (@MeasureTheory.ae.{u_2, u_2} Ω (@MeasureTheory.Measure.{u_2} Ω mΩ) (@MeasureTheory.Measure.instFunLike.{u_2} Ω mΩ)
      ⋯ P)
    (@ProbabilityTheory.IsPreBrownianReal.mk.{u_2} Ω mΩ P X h t) (X t) :=
⋯
```

## `ProbabilityTheory.constL._proof_1`

Command: `#print ProbabilityTheory.constL._proof_1`

```lean
theorem ProbabilityTheory.constL._proof_1 : (@HAdd.hAdd.{0, 0, 0} Nat Nat Nat (@instHAdd.{0} Nat instAddNat)
    (@OfNat.ofNat.{0} Nat (nat_lit 1) (instOfNatNat (nat_lit 1)))
    (@OfNat.ofNat.{0} Nat (nat_lit 1) (instOfNatNat (nat_lit 1)))).AtLeastTwo :=
⋯
```

## `ProbabilityTheory.constL._proof_2`

Command: `#print ProbabilityTheory.constL._proof_2`

```lean
theorem ProbabilityTheory.constL._proof_2 : (@HAdd.hAdd.{0, 0, 0} Nat Nat Nat (@instHAdd.{0} Nat instAddNat)
    (@OfNat.ofNat.{0} Nat (nat_lit 4) (instOfNatNat (nat_lit 4)))
    (@OfNat.ofNat.{0} Nat (nat_lit 1) (instOfNatNat (nat_lit 1)))).AtLeastTwo :=
⋯
```

## `ProbabilityTheory.constL._proof_3`

Command: `#print ProbabilityTheory.constL._proof_3`

```lean
theorem ProbabilityTheory.constL._proof_3 : (@HAdd.hAdd.{0, 0, 0} Nat Nat Nat (@instHAdd.{0} Nat instAddNat)
    (@OfNat.ofNat.{0} Nat (nat_lit 3) (instOfNatNat (nat_lit 3)))
    (@OfNat.ofNat.{0} Nat (nat_lit 1) (instOfNatNat (nat_lit 1)))).AtLeastTwo :=
⋯
```

## `ProbabilityTheory.gaussianLimit._proof_1`

Command: `#print ProbabilityTheory.gaussianLimit._proof_1`

```lean
theorem ProbabilityTheory.gaussianLimit._proof_1 : ∀ (i : NNReal),
  @PolishSpace.{0} Real
    (@UniformSpace.toTopologicalSpace.{0} Real (@PseudoMetricSpace.toUniformSpace.{0} Real Real.pseudoMetricSpace)) :=
⋯
```

## `ProbabilityTheory.gaussianLimit._proof_2`

Command: `#print ProbabilityTheory.gaussianLimit._proof_2`

```lean
theorem ProbabilityTheory.gaussianLimit._proof_2 : ∀ (i : Finset.{0} NNReal),
  @MeasureTheory.IsFiniteMeasure.{0} (↥i → Real)
    (@MeasurableSpace.pi.{0, 0} (↥i) (fun a => Real) fun a => Real.measurableSpace)
    (ProbabilityTheory.gaussianProjectiveFamily i) :=
⋯
```

## `ProbabilityTheory.gaussianProjectiveFamily._proof_1`

Command: `#print ProbabilityTheory.gaussianProjectiveFamily._proof_1`

```lean
theorem ProbabilityTheory.gaussianProjectiveFamily._proof_1 : (@HAdd.hAdd.{0, 0, 0} Nat Nat Nat
    (@instHAdd.{0} Nat instAddNat) (@OfNat.ofNat.{0} Nat (nat_lit 1) (instOfNatNat (nat_lit 1)))
    (@OfNat.ofNat.{0} Nat (nat_lit 1) (instOfNatNat (nat_lit 1)))).AtLeastTwo :=
⋯
```

## `ProbabilityTheory.gaussianProjectiveFamily.eq_1`

Command: `#print ProbabilityTheory.gaussianProjectiveFamily.eq_1`

```lean
@[backward_defeq] theorem ProbabilityTheory.gaussianProjectiveFamily.eq_1 : ∀ (I : Finset.{0} NNReal),
  @Eq.{1}
    (@MeasureTheory.Measure.{0} (↥I → Real)
      (@MeasurableSpace.pi.{0, 0} (↥I) (fun a => Real) fun a => Real.measurableSpace))
    (ProbabilityTheory.gaussianProjectiveFamily I)
    (@MeasureTheory.Measure.map.{0, 0}
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
        (ProbabilityTheory.brownianCovMatrix I))) :=
⋯
```

## `Set.Finite.lt_iInf_iff`

Command: `#print Set.Finite.lt_iInf_iff`

```lean
theorem Set.Finite.lt_iInf_iff.{u_3, u_4} : ∀ {α : Type u_3} {ι : Type u_4} [inst : CompleteLinearOrder.{u_3} α]
  {s : Set.{u_4} ι} {f : ι → α},
  @Set.Nonempty.{u_4} ι s →
    @Set.Finite.{u_4} ι s →
      ∀ {a : α},
        Iff
          (@LT.lt.{u_3} α
            (@Preorder.toLT.{u_3} α
              (@PartialOrder.toPreorder.{u_3} α
                (@CompletePartialOrder.toPartialOrder.{u_3} α
                  (@CompleteLattice.toCompletePartialOrder.{u_3} α
                    (@CompletelyDistribLattice.toCompleteLattice.{u_3} α
                      (@CompleteLinearOrder.toCompletelyDistribLattice.{u_3} α inst))))))
            a (⨅ i, ⨅ (_ : @Membership.mem.{u_4, u_4} ι (Set.{u_4} ι) (@Set.instMembership.{u_4} ι) s i), f i))
          (∀ (x : ι),
            @Membership.mem.{u_4, u_4} ι (Set.{u_4} ι) (@Set.instMembership.{u_4} ι) s x →
              @LT.lt.{u_3} α
                (@Preorder.toLT.{u_3} α
                  (@PartialOrder.toPreorder.{u_3} α
                    (@CompletePartialOrder.toPartialOrder.{u_3} α
                      (@CompleteLattice.toCompletePartialOrder.{u_3} α
                        (@CompletelyDistribLattice.toCompleteLattice.{u_3} α
                          (@CompleteLinearOrder.toCompletelyDistribLattice.{u_3} α inst))))))
                a (f x)) :=
⋯
```

## `Set.FiniteExhaustion.subset`

Command: `#print Set.FiniteExhaustion.subset`

```lean
theorem Set.FiniteExhaustion.subset.{u_1} : ∀ {α : Type u_1} {s : Set.{u_1} α} (K : @Set.FiniteExhaustion.{u_1} α s)
  (n : Nat),
  @LE.le.{u_1} (Set.{u_1} α) (@Set.instLE.{u_1} α)
    (@DFunLike.coe.{u_1 + 1, 1, u_1 + 1} (@Set.FiniteExhaustion.{u_1} α s) Nat (fun x => Set.{u_1} α)
      (@Set.FiniteExhaustion.instFunLikeNat.{u_1} α s) K n)
    s :=
⋯
```

## `_private.KolmogorovExtension4.KolmogorovExtension.0.MeasureTheory.exists_compact._proof_1_1`

Command: `#print _private.KolmogorovExtension4.KolmogorovExtension.0.MeasureTheory.exists_compact._proof_1_1`

```lean
private theorem MeasureTheory.exists_compact._proof_1_1.{u_1, u_2} : ∀ {ι : Type u_1} {α : ι → Type u_2}
  [inst : (i : ι) → MeasurableSpace.{u_2} (α i)]
  {P :
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
                    (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} ι) ι (@Finset.instSetLike.{u_1} ι)) J x)
                j))
          fun a =>
          inst
            (@Subtype.val.{u_1 + 1} ι
              (fun x =>
                @Membership.mem.{u_1, u_1} ι (Finset.{u_1} ι)
                  (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} ι) ι (@Finset.instSetLike.{u_1} ι)) J x)
              a))}
  (J : Finset.{u_1} ι)
  (A :
    Set.{max u_1 u_2}
      ((i : ↥J) →
        α
          (@Subtype.val.{u_1 + 1} ι
            (fun x =>
              @Membership.mem.{u_1, u_1} ι (Finset.{u_1} ι)
                (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} ι) ι (@Finset.instSetLike.{u_1} ι)) J x)
            i)))
  (ε : ENNReal),
  @LT.lt.{0} ENNReal (@Preorder.toLT.{0} ENNReal (@PartialOrder.toPreorder.{0} ENNReal ENNReal.instPartialOrder))
      (@OfNat.ofNat.{0} ENNReal (nat_lit 0) (@Zero.toOfNat0.{0} ENNReal ENNReal.instZero)) ε →
    @Eq.{1} ENNReal
        (@DFunLike.coe.{max (u_1 + 1) (u_2 + 1), max (u_1 + 1) (u_2 + 1), 1}
          (@MeasureTheory.Measure.{max u_1 u_2}
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
                        (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} ι) ι (@Finset.instSetLike.{u_1} ι)) J x)
                    j))
              fun a =>
              inst
                (@Subtype.val.{u_1 + 1} ι
                  (fun x =>
                    @Membership.mem.{u_1, u_1} ι (Finset.{u_1} ι)
                      (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} ι) ι (@Finset.instSetLike.{u_1} ι)) J x)
                  a)))
          (Set.{max u_1 u_2}
            ((j : ↥J) →
              α
                (@Subtype.val.{u_1 + 1} ι
                  (fun x =>
                    @Membership.mem.{u_1, u_1} ι (Finset.{u_1} ι)
                      (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} ι) ι (@Finset.instSetLike.{u_1} ι)) J x)
                  j)))
          (fun x => ENNReal)
          (@MeasureTheory.Measure.instFunLike.{max u_1 u_2}
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
                        (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} ι) ι (@Finset.instSetLike.{u_1} ι)) J x)
                    j))
              fun a =>
              inst
                (@Subtype.val.{u_1 + 1} ι
                  (fun x =>
                    @Membership.mem.{u_1, u_1} ι (Finset.{u_1} ι)
                      (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} ι) ι (@Finset.instSetLike.{u_1} ι)) J x)
                  a)))
          (P J) A)
        (@OfNat.ofNat.{0} ENNReal (nat_lit 0) (@Zero.toOfNat0.{0} ENNReal ENNReal.instZero)) →
      @LE.le.{0} ENNReal ENNReal.instLE
        (@DFunLike.coe.{max (u_1 + 1) (u_2 + 1), max (u_1 + 1) (u_2 + 1), 1}
          (@MeasureTheory.Measure.{max u_1 u_2}
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
                        (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} ι) ι (@Finset.instSetLike.{u_1} ι)) J x)
                    j))
              fun a =>
              inst
                (@Subtype.val.{u_1 + 1} ι
                  (fun x =>
                    @Membership.mem.{u_1, u_1} ι (Finset.{u_1} ι)
                      (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} ι) ι (@Finset.instSetLike.{u_1} ι)) J x)
                  a)))
          (Set.{max u_1 u_2}
            ((j : ↥J) →
              α
                (@Subtype.val.{u_1 + 1} ι
                  (fun x =>
                    @Membership.mem.{u_1, u_1} ι (Finset.{u_1} ι)
                      (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} ι) ι (@Finset.instSetLike.{u_1} ι)) J x)
                  j)))
          (fun x => ENNReal)
          (@MeasureTheory.Measure.instFunLike.{max u_1 u_2}
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
                        (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} ι) ι (@Finset.instSetLike.{u_1} ι)) J x)
                    j))
              fun a =>
              inst
                (@Subtype.val.{u_1 + 1} ι
                  (fun x =>
                    @Membership.mem.{u_1, u_1} ι (Finset.{u_1} ι)
                      (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} ι) ι (@Finset.instSetLike.{u_1} ι)) J x)
                  a)))
          (P J) A)
        ε :=
⋯
```

## `_private.KolmogorovExtension4.RegularContent.0.MeasureTheory.tendsto_zero_of_regular_addContent._simp_1_1`

Command: `#print _private.KolmogorovExtension4.RegularContent.0.MeasureTheory.tendsto_zero_of_regular_addContent._simp_1_1`

```lean
private theorem MeasureTheory.tendsto_zero_of_regular_addContent._simp_1_1.{u_1, u_5} : ∀ {α : Type u_1} {ι : Sort u_5}
  {s : Set.{u_1} α} {t : ι → Set.{u_1} α},
  @Eq.{1} Prop (@LE.le.{u_1} (Set.{u_1} α) (@Set.instLE.{u_1} α) s (⋂ i, t i))
    (∀ (i : ι), @LE.le.{u_1} (Set.{u_1} α) (@Set.instLE.{u_1} α) s (t i)) :=
⋯
```

## `_private.KolmogorovExtension4.RegularContent.0.MeasureTheory.tendsto_zero_of_regular_addContent._simp_1_3`

Command: `#print _private.KolmogorovExtension4.RegularContent.0.MeasureTheory.tendsto_zero_of_regular_addContent._simp_1_3`

```lean
private theorem MeasureTheory.tendsto_zero_of_regular_addContent._simp_1_3.{u} : ∀ {α : Type u} (s : Set.{u} α),
  @Eq.{1} Prop
    (@LE.le.{u} (Set.{u} α) (@Set.instLE.{u} α)
      (@EmptyCollection.emptyCollection.{u} (Set.{u} α) (@Set.instEmptyCollection.{u} α)) s)
    True :=
⋯
```

## `_private.KolmogorovExtension4.RegularContent.0.MeasureTheory.tendsto_zero_of_regular_addContent._simp_1_4`

Command: `#print _private.KolmogorovExtension4.RegularContent.0.MeasureTheory.tendsto_zero_of_regular_addContent._simp_1_4`

```lean
private theorem MeasureTheory.tendsto_zero_of_regular_addContent._simp_1_4 : ∀ {a b : Nat},
  @Eq.{1} Prop
    (@Membership.mem.{0, 0} Nat (Finset.{0} Nat)
      (@SetLike.instMembership.{0, 0} (Finset.{0} Nat) Nat (@Finset.instSetLike.{0} Nat)) (Finset.range b.succ) a)
    (@LE.le.{0} Nat instLENat a b) :=
⋯
```

## `_private.BrownianMotion.Auxiliary.MeasureTheory.0.InnerProductSpace.volume_closedBall_div._simp_1_1`

Command: `#print _private.BrownianMotion.Auxiliary.MeasureTheory.0.InnerProductSpace.volume_closedBall_div._simp_1_1`

```lean
private theorem InnerProductSpace.volume_closedBall_div._simp_1_1 : ∀ (x : ENNReal) (n : Nat),
  @Eq.{1} ENNReal
    (@HPow.hPow.{0, 0, 0} ENNReal Nat ENNReal
      (@instHPow.{0, 0} ENNReal Nat
        (@NPow.toPow.{0} ENNReal
          (@Monoid.toNPow.{0} ENNReal
            (@Semiring.toMonoid.{0} ENNReal (@CommSemiring.toSemiring.{0} ENNReal ENNReal.instCommSemiring)))))
      x n)
    (@HPow.hPow.{0, 0, 0} ENNReal Real ENNReal (@instHPow.{0, 0} ENNReal Real ENNReal.instPowReal) x
      (@Nat.cast.{0} Real Real.instNatCast n)) :=
⋯
```

## `_private.BrownianMotion.Auxiliary.Metric.0.Metric.closedEBall_add_closedEBall._simp_1_1`

Command: `#print _private.BrownianMotion.Auxiliary.Metric.0.Metric.closedEBall_add_closedEBall._simp_1_1`

```lean
private theorem Metric.closedEBall_add_closedEBall._simp_1_1 : ∀ {p q : Prop},
  @Eq.{1} Prop (Not (Or p q)) (And (Not p) (Not q)) :=
⋯
```

## `_private.BrownianMotion.Auxiliary.Topology.0.HolderOnWith.mono_right'._simp_1_1`

Command: `#print _private.BrownianMotion.Auxiliary.Topology.0.HolderOnWith.mono_right'._simp_1_1`

```lean
private theorem HolderOnWith.mono_right'._simp_1_1.{u_1, u_2} : ∀ {X : Type u_1} {Y : Type u_2}
  [inst : PseudoEMetricSpace.{u_1} X] [inst_1 : PseudoEMetricSpace.{u_2} Y] {C r : NNReal} {f : X → Y}
  {s : Set.{u_1} X},
  @Eq.{1} Prop (@HolderOnWith.{u_1, u_2} X Y inst inst_1 C r f s)
    (@HolderWith.{u_1, u_2} (@Set.Elem.{u_1} X s) Y
      (@instPseudoEMetricSpaceSubtype.{u_1} X
        (fun x => @Membership.mem.{u_1, u_1} X (Set.{u_1} X) (@Set.instMembership.{u_1} X) s x) inst)
      inst_1 C r (@Set.restrict.{u_1, u_2} X (fun a => Y) s f)) :=
⋯
```

## `_private.BrownianMotion.Continuity.HasBoundedInternalCoveringNumber.0.HasBoundedCoveringNumber.subset._simp_1_1`

Command: `#print _private.BrownianMotion.Continuity.HasBoundedInternalCoveringNumber.0.HasBoundedCoveringNumber.subset._simp_1_1`

```lean
private theorem HasBoundedCoveringNumber.subset._simp_1_1.{u_1} : ∀ {R : Type u_1} [inst : AddMonoidWithOne.{u_1} R]
  [@CharZero.{u_1} R inst] (n : Nat) [inst_2 : n.AtLeastTwo],
  @Eq.{1} Prop
    (@Eq.{u_1 + 1} R
      (@OfNat.ofNat.{u_1} R n (@instOfNatAtLeastTwo.{u_1} R n (@AddMonoidWithOne.toNatCast.{u_1} R inst) inst_2))
      (@OfNat.ofNat.{u_1} R (nat_lit 0)
        (@Zero.toOfNat0.{u_1} R
          (@AddZero.toZero.{u_1} R
            (@AddZeroClass.toAddZero.{u_1} R
              (@AddMonoid.toAddZeroClass.{u_1} R (@AddMonoidWithOne.toAddMonoid.{u_1} R inst)))))))
    False :=
⋯
```

## `_private.BrownianMotion.Continuity.IsKolmogorovProcess.0.ProbabilityTheory.finite_set_bound_of_edist_le_of_diam_le._simp_1_1`

Command: `#print _private.BrownianMotion.Continuity.IsKolmogorovProcess.0.ProbabilityTheory.finite_set_bound_of_edist_le_of_diam_le._simp_1_1`

```lean
private theorem ProbabilityTheory.finite_set_bound_of_edist_le_of_diam_le._simp_1_1 : ∀ (x : ENNReal),
  @Eq.{1} Prop
    (@Eq.{1} NNReal x.toNNReal (@OfNat.ofNat.{0} NNReal (nat_lit 0) (@Zero.toOfNat0.{0} NNReal NNReal.instZero)))
    (Or (@Eq.{1} ENNReal x (@OfNat.ofNat.{0} ENNReal (nat_lit 0) (@Zero.toOfNat0.{0} ENNReal ENNReal.instZero)))
      (@Eq.{1} ENNReal x (@Top.top.{0} ENNReal ENNReal.instTop))) :=
⋯
```

## `_private.BrownianMotion.Continuity.IsKolmogorovProcess.0.ProbabilityTheory.finite_set_bound_of_edist_le_of_diam_le._simp_1_2`

Command: `#print _private.BrownianMotion.Continuity.IsKolmogorovProcess.0.ProbabilityTheory.finite_set_bound_of_edist_le_of_diam_le._simp_1_2`

```lean
private theorem ProbabilityTheory.finite_set_bound_of_edist_le_of_diam_le._simp_1_2.{u_1} : ∀ {α : Type u_1}
  {s : Set.{u_1} α} (h : @Set.Finite.{u_1} α s),
  @Eq.{1} ENat (@Nat.cast.{0} ENat ENat.instNatCast (@Finset.card.{u_1} α (@Set.Finite.toFinset.{u_1} α s h)))
    (@Set.encard.{u_1} α s) :=
⋯
```

## `_private.BrownianMotion.Continuity.IsKolmogorovProcess.0.ProbabilityTheory.finite_set_bound_of_edist_le_of_diam_le._simp_1_3`

Command: `#print _private.BrownianMotion.Continuity.IsKolmogorovProcess.0.ProbabilityTheory.finite_set_bound_of_edist_le_of_diam_le._simp_1_3`

```lean
private theorem ProbabilityTheory.finite_set_bound_of_edist_le_of_diam_le._simp_1_3.{u_1} : ∀ {ι : Sort u_1}
  {f : ι → ENNReal},
  @Eq.{1} Prop
    (@Eq.{1} ENNReal (⨆ i, f i) (@OfNat.ofNat.{0} ENNReal (nat_lit 0) (@Zero.toOfNat0.{0} ENNReal ENNReal.instZero)))
    (∀ (i : ι),
      @Eq.{1} ENNReal (f i) (@OfNat.ofNat.{0} ENNReal (nat_lit 0) (@Zero.toOfNat0.{0} ENNReal ENNReal.instZero))) :=
⋯
```

## `_private.BrownianMotion.Continuity.IsKolmogorovProcess.0.ProbabilityTheory.finite_set_bound_of_edist_le_of_diam_le._simp_1_4`

Command: `#print _private.BrownianMotion.Continuity.IsKolmogorovProcess.0.ProbabilityTheory.finite_set_bound_of_edist_le_of_diam_le._simp_1_4`

```lean
private theorem ProbabilityTheory.finite_set_bound_of_edist_le_of_diam_le._simp_1_4 : ∀ {x : ENNReal} {y : Real},
  @Eq.{1} Prop
    (@Eq.{1} ENNReal (@HPow.hPow.{0, 0, 0} ENNReal Real ENNReal (@instHPow.{0, 0} ENNReal Real ENNReal.instPowReal) x y)
      (@OfNat.ofNat.{0} ENNReal (nat_lit 0) (@Zero.toOfNat0.{0} ENNReal ENNReal.instZero)))
    (Or
      (And (@Eq.{1} ENNReal x (@OfNat.ofNat.{0} ENNReal (nat_lit 0) (@Zero.toOfNat0.{0} ENNReal ENNReal.instZero)))
        (@LT.lt.{0} Real Real.instLT (@OfNat.ofNat.{0} Real (nat_lit 0) (@Zero.toOfNat0.{0} Real Real.instZero)) y))
      (And (@Eq.{1} ENNReal x (@Top.top.{0} ENNReal ENNReal.instTop))
        (@LT.lt.{0} Real Real.instLT y (@OfNat.ofNat.{0} Real (nat_lit 0) (@Zero.toOfNat0.{0} Real Real.instZero))))) :=
⋯
```

## `_private.BrownianMotion.Continuity.IsKolmogorovProcess.0.ProbabilityTheory.finite_set_bound_of_edist_le_of_diam_le._simp_1_5`

Command: `#print _private.BrownianMotion.Continuity.IsKolmogorovProcess.0.ProbabilityTheory.finite_set_bound_of_edist_le_of_diam_le._simp_1_5`

```lean
private theorem ProbabilityTheory.finite_set_bound_of_edist_le_of_diam_le._simp_1_5.{u_1} : ∀ {G : Type u_1}
  [inst : Semigroup.{u_1} G] (a b c : G),
  @Eq.{u_1 + 1} G
    (@HMul.hMul.{u_1, u_1, u_1} G G G (@instHMul.{u_1} G (@Semigroup.toMul.{u_1} G inst)) a
      (@HMul.hMul.{u_1, u_1, u_1} G G G (@instHMul.{u_1} G (@Semigroup.toMul.{u_1} G inst)) b c))
    (@HMul.hMul.{u_1, u_1, u_1} G G G (@instHMul.{u_1} G (@Semigroup.toMul.{u_1} G inst))
      (@HMul.hMul.{u_1, u_1, u_1} G G G (@instHMul.{u_1} G (@Semigroup.toMul.{u_1} G inst)) a b) c) :=
⋯
```

## `_private.BrownianMotion.Continuity.IsKolmogorovProcess.0.ProbabilityTheory.finite_set_bound_of_edist_le_of_le_diam._simp_1_1`

Command: `#print _private.BrownianMotion.Continuity.IsKolmogorovProcess.0.ProbabilityTheory.finite_set_bound_of_edist_le_of_le_diam._simp_1_1`

```lean
private theorem ProbabilityTheory.finite_set_bound_of_edist_le_of_le_diam._simp_1_1 : ∀ (x : ENNReal),
  @Eq.{1} Prop
    (@Eq.{1} NNReal x.toNNReal (@OfNat.ofNat.{0} NNReal (nat_lit 0) (@Zero.toOfNat0.{0} NNReal NNReal.instZero)))
    (Or (@Eq.{1} ENNReal x (@OfNat.ofNat.{0} ENNReal (nat_lit 0) (@Zero.toOfNat0.{0} ENNReal ENNReal.instZero)))
      (@Eq.{1} ENNReal x (@Top.top.{0} ENNReal ENNReal.instTop))) :=
⋯
```

## `_private.BrownianMotion.Continuity.IsKolmogorovProcess.0.ProbabilityTheory.finite_set_bound_of_edist_le_of_le_diam._simp_1_2`

Command: `#print _private.BrownianMotion.Continuity.IsKolmogorovProcess.0.ProbabilityTheory.finite_set_bound_of_edist_le_of_le_diam._simp_1_2`

```lean
private theorem ProbabilityTheory.finite_set_bound_of_edist_le_of_le_diam._simp_1_2.{u_1} : ∀ {α : Type u_1}
  {s : Set.{u_1} α} (h : @Set.Finite.{u_1} α s),
  @Eq.{1} ENat (@Nat.cast.{0} ENat ENat.instNatCast (@Finset.card.{u_1} α (@Set.Finite.toFinset.{u_1} α s h)))
    (@Set.encard.{u_1} α s) :=
⋯
```

## `_private.BrownianMotion.Continuity.IsKolmogorovProcess.0.ProbabilityTheory.finite_set_bound_of_edist_le_of_le_diam._simp_1_3`

Command: `#print _private.BrownianMotion.Continuity.IsKolmogorovProcess.0.ProbabilityTheory.finite_set_bound_of_edist_le_of_le_diam._simp_1_3`

```lean
private theorem ProbabilityTheory.finite_set_bound_of_edist_le_of_le_diam._simp_1_3.{u_1} : ∀ {G : Type u_1}
  [inst : Semigroup.{u_1} G] (a b c : G),
  @Eq.{u_1 + 1} G
    (@HMul.hMul.{u_1, u_1, u_1} G G G (@instHMul.{u_1} G (@Semigroup.toMul.{u_1} G inst)) a
      (@HMul.hMul.{u_1, u_1, u_1} G G G (@instHMul.{u_1} G (@Semigroup.toMul.{u_1} G inst)) b c))
    (@HMul.hMul.{u_1, u_1, u_1} G G G (@instHMul.{u_1} G (@Semigroup.toMul.{u_1} G inst))
      (@HMul.hMul.{u_1, u_1, u_1} G G G (@instHMul.{u_1} G (@Semigroup.toMul.{u_1} G inst)) a b) c) :=
⋯
```

## `_private.BrownianMotion.Continuity.IsKolmogorovProcess.0.ProbabilityTheory.finite_set_bound_of_edist_le_of_le_diam'._simp_1_1`

Command: `#print _private.BrownianMotion.Continuity.IsKolmogorovProcess.0.ProbabilityTheory.finite_set_bound_of_edist_le_of_le_diam'._simp_1_1`

```lean
private theorem ProbabilityTheory.finite_set_bound_of_edist_le_of_le_diam'._simp_1_1.{u_1} : ∀ {G : Type u_1}
  [inst : Semigroup.{u_1} G] (a b c : G),
  @Eq.{u_1 + 1} G
    (@HMul.hMul.{u_1, u_1, u_1} G G G (@instHMul.{u_1} G (@Semigroup.toMul.{u_1} G inst)) a
      (@HMul.hMul.{u_1, u_1, u_1} G G G (@instHMul.{u_1} G (@Semigroup.toMul.{u_1} G inst)) b c))
    (@HMul.hMul.{u_1, u_1, u_1} G G G (@instHMul.{u_1} G (@Semigroup.toMul.{u_1} G inst))
      (@HMul.hMul.{u_1, u_1, u_1} G G G (@instHMul.{u_1} G (@Semigroup.toMul.{u_1} G inst)) a b) c) :=
⋯
```

## `_private.BrownianMotion.Continuity.IsKolmogorovProcess.0.ProbabilityTheory.finite_set_bound_of_edist_le_of_le_diam'._simp_1_2`

Command: `#print _private.BrownianMotion.Continuity.IsKolmogorovProcess.0.ProbabilityTheory.finite_set_bound_of_edist_le_of_le_diam'._simp_1_2`

```lean
private theorem ProbabilityTheory.finite_set_bound_of_edist_le_of_le_diam'._simp_1_2.{u_1} : ∀ {R : Type u_1}
  [inst : AddMonoidWithOne.{u_1} R] [@CharZero.{u_1} R inst] (n : Nat) [inst_2 : n.AtLeastTwo],
  @Eq.{1} Prop
    (@Eq.{u_1 + 1} R
      (@OfNat.ofNat.{u_1} R n (@instOfNatAtLeastTwo.{u_1} R n (@AddMonoidWithOne.toNatCast.{u_1} R inst) inst_2))
      (@OfNat.ofNat.{u_1} R (nat_lit 0)
        (@Zero.toOfNat0.{u_1} R
          (@AddZero.toZero.{u_1} R
            (@AddZeroClass.toAddZero.{u_1} R
              (@AddMonoid.toAddZeroClass.{u_1} R (@AddMonoidWithOne.toAddMonoid.{u_1} R inst)))))))
    False :=
⋯
```

## `_private.BrownianMotion.Continuity.IsKolmogorovProcess.0.ProbabilityTheory.finite_set_bound_of_edist_le_of_le_diam'._simp_1_3`

Command: `#print _private.BrownianMotion.Continuity.IsKolmogorovProcess.0.ProbabilityTheory.finite_set_bound_of_edist_le_of_le_diam'._simp_1_3`

```lean
private theorem ProbabilityTheory.finite_set_bound_of_edist_le_of_le_diam'._simp_1_3.{u_3} : ∀ {α : Type u_3}
  [inst : Semiring.{u_3} α] [inst_1 : PartialOrder.{u_3} α] [@IsOrderedRing.{u_3} α inst inst_1] [Nontrivial.{u_3} α]
  {n : Nat},
  @Eq.{1} Prop
    (@LT.lt.{u_3} α (@Preorder.toLT.{u_3} α (@PartialOrder.toPreorder.{u_3} α inst_1))
      (@OfNat.ofNat.{u_3} α (nat_lit 0)
        (@Zero.toOfNat0.{u_3} α (@MulZeroClass.toZero.{u_3} α (@instMulZeroClassOfSemiring.{u_3} α inst))))
      (@Nat.cast.{u_3} α
        (@AddMonoidWithOne.toNatCast.{u_3} α
          (@AddCommMonoidWithOne.toAddMonoidWithOne.{u_3} α
            (@NonAssocSemiring.toAddCommMonoidWithOne.{u_3} α (@Semiring.toNonAssocSemiring.{u_3} α inst))))
        n))
    (@LT.lt.{0} Nat instLTNat (@OfNat.ofNat.{0} Nat (nat_lit 0) (instOfNatNat (nat_lit 0))) n) :=
⋯
```

## `_private.BrownianMotion.Continuity.IsKolmogorovProcess.0.ProbabilityTheory.finite_set_bound_of_edist_le_of_le_diam'._simp_1_4`

Command: `#print _private.BrownianMotion.Continuity.IsKolmogorovProcess.0.ProbabilityTheory.finite_set_bound_of_edist_le_of_le_diam'._simp_1_4`

```lean
private theorem ProbabilityTheory.finite_set_bound_of_edist_le_of_le_diam'._simp_1_4.{u_1} : ∀ {α : Type u_1}
  [inst : LinearOrder.{u_1} α] {a b : α},
  @Eq.{1} Prop
    (Not
      (@LT.lt.{u_1} α
        (@Preorder.toLT.{u_1} α (@PartialOrder.toPreorder.{u_1} α (@LinearOrder.toPartialOrder.{u_1} α inst))) a b))
    (@LE.le.{u_1} α
      (@Preorder.toLE.{u_1} α (@PartialOrder.toPreorder.{u_1} α (@LinearOrder.toPartialOrder.{u_1} α inst))) b a) :=
⋯
```

## `_private.BrownianMotion.Continuity.IsKolmogorovProcess.0.ProbabilityTheory.finite_set_bound_of_edist_le_of_le_diam'._simp_1_5`

Command: `#print _private.BrownianMotion.Continuity.IsKolmogorovProcess.0.ProbabilityTheory.finite_set_bound_of_edist_le_of_le_diam'._simp_1_5`

```lean
private theorem ProbabilityTheory.finite_set_bound_of_edist_le_of_le_diam'._simp_1_5.{u_1} : ∀ {α : Type u_1} {a : α}
  [inst : PartialOrder.{u_1} α] [inst_1 : Zero.{u_1} α]
  [@IsBotZeroClass.{u_1} α (@Preorder.toLE.{u_1} α (@PartialOrder.toPreorder.{u_1} α inst)) inst_1],
  @Eq.{1} Prop
    (@LE.le.{u_1} α (@Preorder.toLE.{u_1} α (@PartialOrder.toPreorder.{u_1} α inst)) a
      (@OfNat.ofNat.{u_1} α (nat_lit 0) (@Zero.toOfNat0.{u_1} α inst_1)))
    (@Eq.{u_1 + 1} α a (@OfNat.ofNat.{u_1} α (nat_lit 0) (@Zero.toOfNat0.{u_1} α inst_1))) :=
⋯
```

## `_private.BrownianMotion.Continuity.IsKolmogorovProcess.0.ProbabilityTheory.finite_set_bound_of_edist_le_of_le_diam'._simp_1_6`

Command: `#print _private.BrownianMotion.Continuity.IsKolmogorovProcess.0.ProbabilityTheory.finite_set_bound_of_edist_le_of_le_diam'._simp_1_6`

```lean
private theorem ProbabilityTheory.finite_set_bound_of_edist_le_of_le_diam'._simp_1_6 : ∀ {n : ENat},
  @Eq.{1} Prop (@Eq.{1} Nat n.toNat (@OfNat.ofNat.{0} Nat (nat_lit 0) (instOfNatNat (nat_lit 0))))
    (Or
      (@Eq.{1} ENat n
        (@OfNat.ofNat.{0} ENat (nat_lit 0)
          (@Zero.toOfNat0.{0} ENat
            (@MulZeroClass.toZero.{0} ENat
              (@instMulZeroClassOfSemiring.{0} ENat (@CommSemiring.toSemiring.{0} ENat instCommSemiringENat))))))
      (@Eq.{1} ENat n (@Top.top.{0} ENat instTopENat))) :=
⋯
```

## `_private.BrownianMotion.Continuity.IsKolmogorovProcess.0.ProbabilityTheory.finite_set_bound_of_edist_le_of_le_diam'._simp_1_7`

Command: `#print _private.BrownianMotion.Continuity.IsKolmogorovProcess.0.ProbabilityTheory.finite_set_bound_of_edist_le_of_le_diam'._simp_1_7`

```lean
private theorem ProbabilityTheory.finite_set_bound_of_edist_le_of_le_diam'._simp_1_7 : ∀ (x : ENNReal) (z : Real),
  @Eq.{1} Real
    (@HPow.hPow.{0, 0, 0} ENNReal Real ENNReal (@instHPow.{0, 0} ENNReal Real ENNReal.instPowReal) x z).toReal
    (@HPow.hPow.{0, 0, 0} Real Real Real (@instHPow.{0, 0} Real Real Real.instPow) x.toReal z) :=
⋯
```

## `_private.BrownianMotion.Continuity.IsKolmogorovProcess.0.ProbabilityTheory.lintegral_sup_cover_eq_of_lt_iInf_dist._simp_1_1`

Command: `#print _private.BrownianMotion.Continuity.IsKolmogorovProcess.0.ProbabilityTheory.lintegral_sup_cover_eq_of_lt_iInf_dist._simp_1_1`

```lean
private theorem ProbabilityTheory.lintegral_sup_cover_eq_of_lt_iInf_dist._simp_1_1.{u_1} : ∀ {α : Type u_1} {a : α}
  [inst : PartialOrder.{u_1} α] [inst_1 : Zero.{u_1} α]
  [@IsBotZeroClass.{u_1} α (@Preorder.toLE.{u_1} α (@PartialOrder.toPreorder.{u_1} α inst)) inst_1],
  @Eq.{1} Prop
    (@LE.le.{u_1} α (@Preorder.toLE.{u_1} α (@PartialOrder.toPreorder.{u_1} α inst)) a
      (@OfNat.ofNat.{u_1} α (nat_lit 0) (@Zero.toOfNat0.{u_1} α inst_1)))
    (@Eq.{u_1 + 1} α a (@OfNat.ofNat.{u_1} α (nat_lit 0) (@Zero.toOfNat0.{u_1} α inst_1))) :=
⋯
```

## `_private.BrownianMotion.Continuity.IsKolmogorovProcess.0.ProbabilityTheory.lintegral_sup_cover_eq_of_lt_iInf_dist._simp_1_2`

Command: `#print _private.BrownianMotion.Continuity.IsKolmogorovProcess.0.ProbabilityTheory.lintegral_sup_cover_eq_of_lt_iInf_dist._simp_1_2`

```lean
private theorem ProbabilityTheory.lintegral_sup_cover_eq_of_lt_iInf_dist._simp_1_2.{u_1, u_3, u_4} : ∀ {α : Type u_1}
  {F : Type u_3} [inst : FunLike.{u_3 + 1, u_1 + 1, 1} F (Set.{u_1} α) ENNReal]
  [inst_1 : @MeasureTheory.OuterMeasureClass.{u_3, u_1} F α inst] {μ : F} {ι : Sort u_4} [Countable.{u_4} ι]
  {p : α → ι → Prop},
  @Eq.{1} Prop (∀ (i : ι), @Filter.Eventually.{u_1} α (fun a => p a i) (@MeasureTheory.ae.{u_1, u_3} α F inst inst_1 μ))
    (@Filter.Eventually.{u_1} α (fun a => ∀ (i : ι), p a i) (@MeasureTheory.ae.{u_1, u_3} α F inst inst_1 μ)) :=
⋯
```

## `_private.BrownianMotion.Continuity.IsKolmogorovProcess.0.ProbabilityTheory.lintegral_sup_rpow_edist_cover_of_dist_le._proof_1_1`

Command: `#print _private.BrownianMotion.Continuity.IsKolmogorovProcess.0.ProbabilityTheory.lintegral_sup_rpow_edist_cover_of_dist_le._proof_1_1`

```lean
private theorem ProbabilityTheory.lintegral_sup_rpow_edist_cover_of_dist_le._proof_1_1.{u_1} : ∀ {T : Type u_1}
  {C : Finset.{u_1} T},
  @LE.le.{0} Nat instLENat (@OfNat.ofNat.{0} Nat (nat_lit 1) (instOfNatNat (nat_lit 1))) (@Finset.card.{u_1} T C).log2 →
    Not
        (@LE.le.{0} Nat instLENat
          (@HAdd.hAdd.{0, 0, 0} Nat Nat Nat (@instHAdd.{0} Nat instAddNat)
            (@OfNat.ofNat.{0} Nat (nat_lit 1) (instOfNatNat (nat_lit 1))) (@Finset.card.{u_1} T C).log2)
          (@HMul.hMul.{0, 0, 0} Nat Nat Nat (@instHMul.{0} Nat instMulNat)
            (@OfNat.ofNat.{0} Nat (nat_lit 2) (instOfNatNat (nat_lit 2))) (@Finset.card.{u_1} T C).log2)) →
      False :=
⋯
```

## `_private.BrownianMotion.Continuity.IsKolmogorovProcess.0.ProbabilityTheory.lintegral_sup_rpow_edist_cover_of_dist_le._proof_1_2`

Command: `#print _private.BrownianMotion.Continuity.IsKolmogorovProcess.0.ProbabilityTheory.lintegral_sup_rpow_edist_cover_of_dist_le._proof_1_2`

```lean
private theorem ProbabilityTheory.lintegral_sup_rpow_edist_cover_of_dist_le._proof_1_2.{u_1} : ∀ {T : Type u_1}
  {C : Finset.{u_1} T},
  @Ne.{1} Nat (@Finset.card.{u_1} T C) (@OfNat.ofNat.{0} Nat (nat_lit 0) (instOfNatNat (nat_lit 0))) →
    Not (@Eq.{1} Nat (@Finset.card.{u_1} T C) (@OfNat.ofNat.{0} Nat (nat_lit 1) (instOfNatNat (nat_lit 1)))) →
      Not
          (@LE.le.{0} Nat instLENat
            (@HPow.hPow.{0, 0, 0} Nat Nat Nat (@instHPow.{0, 0} Nat Nat (@instPowNat.{0} Nat instNatPowNat))
              (@OfNat.ofNat.{0} Nat (nat_lit 2) (instOfNatNat (nat_lit 2)))
              (@OfNat.ofNat.{0} Nat (nat_lit 1) (instOfNatNat (nat_lit 1))))
            (@Finset.card.{u_1} T C)) →
        False :=
⋯
```

## `_private.BrownianMotion.Continuity.IsKolmogorovProcess.0.ProbabilityTheory.lintegral_sup_rpow_edist_cover_rescale._simp_1_1`

Command: `#print _private.BrownianMotion.Continuity.IsKolmogorovProcess.0.ProbabilityTheory.lintegral_sup_rpow_edist_cover_rescale._simp_1_1`

```lean
private theorem ProbabilityTheory.lintegral_sup_rpow_edist_cover_rescale._simp_1_1.{u_1} : ∀ {α : Type u_1}
  [inst : AddMonoidWithOne.{u_1} α] [inst_1 : PartialOrder.{u_1} α]
  [@AddLeftMono.{u_1} α
      (@AddSemigroup.toAdd.{u_1} α (@AddMonoid.toAddSemigroup.{u_1} α (@AddMonoidWithOne.toAddMonoid.{u_1} α inst)))
      (@Preorder.toLE.{u_1} α (@PartialOrder.toPreorder.{u_1} α inst_1))]
  [@ZeroLEOneClass.{u_1} α
      (@AddZero.toZero.{u_1} α
        (@AddZeroClass.toAddZero.{u_1} α
          (@AddMonoid.toAddZeroClass.{u_1} α (@AddMonoidWithOne.toAddMonoid.{u_1} α inst))))
      (@AddMonoidWithOne.toOne.{u_1} α inst) (@Preorder.toLE.{u_1} α (@PartialOrder.toPreorder.{u_1} α inst_1))]
  [@CharZero.{u_1} α inst] {m n : Nat},
  @Eq.{1} Prop
    (@LE.le.{u_1} α (@Preorder.toLE.{u_1} α (@PartialOrder.toPreorder.{u_1} α inst_1))
      (@Nat.cast.{u_1} α (@AddMonoidWithOne.toNatCast.{u_1} α inst) m)
      (@Nat.cast.{u_1} α (@AddMonoidWithOne.toNatCast.{u_1} α inst) n))
    (@LE.le.{0} Nat instLENat m n) :=
⋯
```

## `_private.BrownianMotion.Continuity.IsKolmogorovProcess.0.ProbabilityTheory.lintegral_sup_rpow_edist_cover_rescale._simp_1_2`

Command: `#print _private.BrownianMotion.Continuity.IsKolmogorovProcess.0.ProbabilityTheory.lintegral_sup_rpow_edist_cover_rescale._simp_1_2`

```lean
private theorem ProbabilityTheory.lintegral_sup_rpow_edist_cover_rescale._simp_1_2 : ∀ {m n : ENat},
  @Eq.{1} Prop (@LE.le.{0} ENNReal ENNReal.instLE ↑m ↑n) (@LE.le.{0} ENat instLEENat m n) :=
⋯
```

## `_private.BrownianMotion.Continuity.IsKolmogorovProcess.0.ProbabilityTheory.lintegral_sup_rpow_edist_le_card_mul_rpow_of_dist_le._simp_1_1`

Command: `#print _private.BrownianMotion.Continuity.IsKolmogorovProcess.0.ProbabilityTheory.lintegral_sup_rpow_edist_le_card_mul_rpow_of_dist_le._simp_1_1`

```lean
private theorem ProbabilityTheory.lintegral_sup_rpow_edist_le_card_mul_rpow_of_dist_le._simp_1_1.{u_1} : ∀
  {G : Type u_1} [inst : Semigroup.{u_1} G] (a b c : G),
  @Eq.{u_1 + 1} G
    (@HMul.hMul.{u_1, u_1, u_1} G G G (@instHMul.{u_1} G (@Semigroup.toMul.{u_1} G inst)) a
      (@HMul.hMul.{u_1, u_1, u_1} G G G (@instHMul.{u_1} G (@Semigroup.toMul.{u_1} G inst)) b c))
    (@HMul.hMul.{u_1, u_1, u_1} G G G (@instHMul.{u_1} G (@Semigroup.toMul.{u_1} G inst))
      (@HMul.hMul.{u_1, u_1, u_1} G G G (@instHMul.{u_1} G (@Semigroup.toMul.{u_1} G inst)) a b) c) :=
⋯
```

## `_private.BrownianMotion.Continuity.IsKolmogorovProcess.0.ProbabilityTheory.lintegral_sup_rpow_edist_le_of_minimal_cover_two._simp_1_1`

Command: `#print _private.BrownianMotion.Continuity.IsKolmogorovProcess.0.ProbabilityTheory.lintegral_sup_rpow_edist_le_of_minimal_cover_two._simp_1_1`

```lean
private theorem ProbabilityTheory.lintegral_sup_rpow_edist_le_of_minimal_cover_two._simp_1_1.{u_1} : ∀ {G : Type u_1}
  [inst : Semigroup.{u_1} G] (a b c : G),
  @Eq.{u_1 + 1} G
    (@HMul.hMul.{u_1, u_1, u_1} G G G (@instHMul.{u_1} G (@Semigroup.toMul.{u_1} G inst)) a
      (@HMul.hMul.{u_1, u_1, u_1} G G G (@instHMul.{u_1} G (@Semigroup.toMul.{u_1} G inst)) b c))
    (@HMul.hMul.{u_1, u_1, u_1} G G G (@instHMul.{u_1} G (@Semigroup.toMul.{u_1} G inst))
      (@HMul.hMul.{u_1, u_1, u_1} G G G (@instHMul.{u_1} G (@Semigroup.toMul.{u_1} G inst)) a b) c) :=
⋯
```

## `_private.BrownianMotion.Continuity.IsKolmogorovProcess.0.ProbabilityTheory.lintegral_sup_rpow_edist_le_of_minimal_cover_two._simp_1_11`

Command: `#print _private.BrownianMotion.Continuity.IsKolmogorovProcess.0.ProbabilityTheory.lintegral_sup_rpow_edist_le_of_minimal_cover_two._simp_1_11`

```lean
private theorem ProbabilityTheory.lintegral_sup_rpow_edist_le_of_minimal_cover_two._simp_1_11 : ∀ (x : ENNReal)
  (n : Int),
  @Eq.{1} ENNReal
    (@HPow.hPow.{0, 0, 0} ENNReal Int ENNReal
      (@instHPow.{0, 0} ENNReal Int
        (@ZPow.toPow.{0} ENNReal (@DivInvMonoid.toZPow.{0} ENNReal ENNReal.instDivInvMonoid)))
      x n)
    (@HPow.hPow.{0, 0, 0} ENNReal Real ENNReal (@instHPow.{0, 0} ENNReal Real ENNReal.instPowReal) x
      (@Int.cast.{0} Real Real.instIntCast n)) :=
⋯
```

## `_private.BrownianMotion.Continuity.IsKolmogorovProcess.0.ProbabilityTheory.lintegral_sup_rpow_edist_le_of_minimal_cover_two._simp_1_2`

Command: `#print _private.BrownianMotion.Continuity.IsKolmogorovProcess.0.ProbabilityTheory.lintegral_sup_rpow_edist_le_of_minimal_cover_two._simp_1_2`

```lean
private theorem ProbabilityTheory.lintegral_sup_rpow_edist_le_of_minimal_cover_two._simp_1_2.{u_1} : ∀ {R : Type u_1}
  [inst : AddMonoidWithOne.{u_1} R] [@CharZero.{u_1} R inst] (n : Nat) [inst_2 : n.AtLeastTwo],
  @Eq.{1} Prop
    (@Eq.{u_1 + 1} R
      (@OfNat.ofNat.{u_1} R n (@instOfNatAtLeastTwo.{u_1} R n (@AddMonoidWithOne.toNatCast.{u_1} R inst) inst_2))
      (@OfNat.ofNat.{u_1} R (nat_lit 0)
        (@Zero.toOfNat0.{u_1} R
          (@AddZero.toZero.{u_1} R
            (@AddZeroClass.toAddZero.{u_1} R
              (@AddMonoid.toAddZeroClass.{u_1} R (@AddMonoidWithOne.toAddMonoid.{u_1} R inst)))))))
    False :=
⋯
```

## `_private.BrownianMotion.Continuity.IsKolmogorovProcess.0.ProbabilityTheory.lintegral_sup_rpow_edist_le_of_minimal_cover_two_of_le_one._simp_1_1`

Command: `#print _private.BrownianMotion.Continuity.IsKolmogorovProcess.0.ProbabilityTheory.lintegral_sup_rpow_edist_le_of_minimal_cover_two_of_le_one._simp_1_1`

```lean
private theorem ProbabilityTheory.lintegral_sup_rpow_edist_le_of_minimal_cover_two_of_le_one._simp_1_1.{u_1} : ∀
  {G : Type u_1} [inst : Semigroup.{u_1} G] (a b c : G),
  @Eq.{u_1 + 1} G
    (@HMul.hMul.{u_1, u_1, u_1} G G G (@instHMul.{u_1} G (@Semigroup.toMul.{u_1} G inst)) a
      (@HMul.hMul.{u_1, u_1, u_1} G G G (@instHMul.{u_1} G (@Semigroup.toMul.{u_1} G inst)) b c))
    (@HMul.hMul.{u_1, u_1, u_1} G G G (@instHMul.{u_1} G (@Semigroup.toMul.{u_1} G inst))
      (@HMul.hMul.{u_1, u_1, u_1} G G G (@instHMul.{u_1} G (@Semigroup.toMul.{u_1} G inst)) a b) c) :=
⋯
```

## `_private.BrownianMotion.Continuity.IsKolmogorovProcess.0.ProbabilityTheory.lintegral_sup_rpow_edist_le_of_minimal_cover_two_of_le_one._simp_1_2`

Command: `#print _private.BrownianMotion.Continuity.IsKolmogorovProcess.0.ProbabilityTheory.lintegral_sup_rpow_edist_le_of_minimal_cover_two_of_le_one._simp_1_2`

```lean
private theorem ProbabilityTheory.lintegral_sup_rpow_edist_le_of_minimal_cover_two_of_le_one._simp_1_2.{u_1} : ∀
  {R : Type u_1} [inst : AddMonoidWithOne.{u_1} R] [@CharZero.{u_1} R inst] (n : Nat) [inst_2 : n.AtLeastTwo],
  @Eq.{1} Prop
    (@Eq.{u_1 + 1} R
      (@OfNat.ofNat.{u_1} R n (@instOfNatAtLeastTwo.{u_1} R n (@AddMonoidWithOne.toNatCast.{u_1} R inst) inst_2))
      (@OfNat.ofNat.{u_1} R (nat_lit 0)
        (@Zero.toOfNat0.{u_1} R
          (@AddZero.toZero.{u_1} R
            (@AddZeroClass.toAddZero.{u_1} R
              (@AddMonoid.toAddZeroClass.{u_1} R (@AddMonoidWithOne.toAddMonoid.{u_1} R inst)))))))
    False :=
⋯
```

## `_private.BrownianMotion.Continuity.IsKolmogorovProcess.0.ProbabilityTheory.lintegral_sup_rpow_edist_le_sum._proof_1_2`

Command: `#print _private.BrownianMotion.Continuity.IsKolmogorovProcess.0.ProbabilityTheory.lintegral_sup_rpow_edist_le_sum._proof_1_2`

```lean
private theorem ProbabilityTheory.lintegral_sup_rpow_edist_le_sum._proof_1_2 : ∀ {k m : Nat},
  @LE.le.{0} Nat instLENat m k →
    ∀ (i : Nat),
      @LT.lt.{0} Nat instLTNat i (@HSub.hSub.{0, 0, 0} Nat Nat Nat (@instHSub.{0} Nat instSubNat) k m) →
        Not (@LT.lt.{0} Nat instLTNat (@HAdd.hAdd.{0, 0, 0} Nat Nat Nat (@instHAdd.{0} Nat instAddNat) m i) k) →
          False :=
⋯
```

## `_private.BrownianMotion.Continuity.IsKolmogorovProcess.0.ProbabilityTheory.lintegral_sup_rpow_edist_le_sum._simp_1_1`

Command: `#print _private.BrownianMotion.Continuity.IsKolmogorovProcess.0.ProbabilityTheory.lintegral_sup_rpow_edist_le_sum._simp_1_1`

```lean
private theorem ProbabilityTheory.lintegral_sup_rpow_edist_le_sum._simp_1_1 : ∀ {n m : Nat},
  @Eq.{1} Prop
    (@Membership.mem.{0, 0} Nat (Finset.{0} Nat)
      (@SetLike.instMembership.{0, 0} (Finset.{0} Nat) Nat (@Finset.instSetLike.{0} Nat)) (Finset.range n) m)
    (@LT.lt.{0} Nat instLTNat m n) :=
⋯
```

## `_private.BrownianMotion.Continuity.IsKolmogorovProcess.0.ProbabilityTheory.lintegral_sup_rpow_edist_le_sum_of_le_one._proof_1_2`

Command: `#print _private.BrownianMotion.Continuity.IsKolmogorovProcess.0.ProbabilityTheory.lintegral_sup_rpow_edist_le_sum_of_le_one._proof_1_2`

```lean
private theorem ProbabilityTheory.lintegral_sup_rpow_edist_le_sum_of_le_one._proof_1_2 : ∀ {k m : Nat},
  @LE.le.{0} Nat instLENat m k →
    ∀ (i : Nat),
      @LT.lt.{0} Nat instLTNat i (@HSub.hSub.{0, 0, 0} Nat Nat Nat (@instHSub.{0} Nat instSubNat) k m) →
        Not (@LT.lt.{0} Nat instLTNat (@HAdd.hAdd.{0, 0, 0} Nat Nat Nat (@instHAdd.{0} Nat instAddNat) m i) k) →
          False :=
⋯
```

## `_private.BrownianMotion.Continuity.IsKolmogorovProcess.0.ProbabilityTheory.lintegral_sup_rpow_edist_le_sum_of_le_one._simp_1_1`

Command: `#print _private.BrownianMotion.Continuity.IsKolmogorovProcess.0.ProbabilityTheory.lintegral_sup_rpow_edist_le_sum_of_le_one._simp_1_1`

```lean
private theorem ProbabilityTheory.lintegral_sup_rpow_edist_le_sum_of_le_one._simp_1_1 : ∀ {n m : Nat},
  @Eq.{1} Prop
    (@Membership.mem.{0, 0} Nat (Finset.{0} Nat)
      (@SetLike.instMembership.{0, 0} (Finset.{0} Nat) Nat (@Finset.instSetLike.{0} Nat)) (Finset.range n) m)
    (@LT.lt.{0} Nat instLTNat m n) :=
⋯
```

## `_private.BrownianMotion.Continuity.IsKolmogorovProcess.0.ProbabilityTheory.lintegral_sup_rpow_edist_succ._proof_1_1`

Command: `#print _private.BrownianMotion.Continuity.IsKolmogorovProcess.0.ProbabilityTheory.lintegral_sup_rpow_edist_succ._proof_1_1`

```lean
private theorem ProbabilityTheory.lintegral_sup_rpow_edist_succ._proof_1_1.{u_1} : ∀ {T : Type u_1}
  [inst : PseudoEMetricSpace.{u_1} T] {C : Nat → Finset.{u_1} T} {j k : Nat},
  @LT.lt.{0} Nat instLTNat j k →
    (@Function.Injective.{u_1 + 1, u_1 + 1}
        (↥(C
            (@HAdd.hAdd.{0, 0, 0} Nat Nat Nat (@instHAdd.{0} Nat instAddNat) j
              (@OfNat.ofNat.{0} Nat (nat_lit 1) (instOfNatNat (nat_lit 1))))))
        (Prod.{u_1, u_1} T T) fun x =>
        @Prod.mk.{u_1, u_1} T T
          (@chainingSequence.{u_1} T inst C
            (@Subtype.val.{u_1 + 1} T
              (fun x =>
                @Membership.mem.{u_1, u_1} T (Finset.{u_1} T)
                  (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} T) T (@Finset.instSetLike.{u_1} T))
                  (C
                    (@HAdd.hAdd.{0, 0, 0} Nat Nat Nat (@instHAdd.{0} Nat instAddNat) j
                      (@OfNat.ofNat.{0} Nat (nat_lit 1) (instOfNatNat (nat_lit 1)))))
                  x)
              x)
            (@HAdd.hAdd.{0, 0, 0} Nat Nat Nat (@instHAdd.{0} Nat instAddNat) j
              (@OfNat.ofNat.{0} Nat (nat_lit 1) (instOfNatNat (nat_lit 1))))
            j)
          (@Subtype.val.{u_1 + 1} T
            (fun x =>
              @Membership.mem.{u_1, u_1} T (Finset.{u_1} T)
                (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} T) T (@Finset.instSetLike.{u_1} T))
                (C
                  (@HAdd.hAdd.{0, 0, 0} Nat Nat Nat (@instHAdd.{0} Nat instAddNat) j
                    (@OfNat.ofNat.{0} Nat (nat_lit 1) (instOfNatNat (nat_lit 1)))))
                x)
            x)) →
      Not
          (@LE.le.{0} Nat instLENat
            (@HAdd.hAdd.{0, 0, 0} Nat Nat Nat (@instHAdd.{0} Nat instAddNat) j
              (@OfNat.ofNat.{0} Nat (nat_lit 1) (instOfNatNat (nat_lit 1))))
            k) →
        False :=
⋯
```

## `_private.BrownianMotion.Continuity.IsKolmogorovProcess.0.ProbabilityTheory.lintegral_sup_rpow_edist_succ._proof_1_2`

Command: `#print _private.BrownianMotion.Continuity.IsKolmogorovProcess.0.ProbabilityTheory.lintegral_sup_rpow_edist_succ._proof_1_2`

```lean
private theorem ProbabilityTheory.lintegral_sup_rpow_edist_succ._proof_1_2.{u_1} : ∀ {T : Type u_1}
  [inst : PseudoEMetricSpace.{u_1} T] {C : Nat → Finset.{u_1} T} {j : Nat} {k : Nat},
  (@Function.Injective.{u_1 + 1, u_1 + 1}
      (↥(C
          (@HAdd.hAdd.{0, 0, 0} Nat Nat Nat (@instHAdd.{0} Nat instAddNat) j
            (@OfNat.ofNat.{0} Nat (nat_lit 1) (instOfNatNat (nat_lit 1))))))
      (Prod.{u_1, u_1} T T) fun x =>
      @Prod.mk.{u_1, u_1} T T
        (@chainingSequence.{u_1} T inst C
          (@Subtype.val.{u_1 + 1} T
            (fun x =>
              @Membership.mem.{u_1, u_1} T (Finset.{u_1} T)
                (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} T) T (@Finset.instSetLike.{u_1} T))
                (C
                  (@HAdd.hAdd.{0, 0, 0} Nat Nat Nat (@instHAdd.{0} Nat instAddNat) j
                    (@OfNat.ofNat.{0} Nat (nat_lit 1) (instOfNatNat (nat_lit 1)))))
                x)
            x)
          (@HAdd.hAdd.{0, 0, 0} Nat Nat Nat (@instHAdd.{0} Nat instAddNat) j
            (@OfNat.ofNat.{0} Nat (nat_lit 1) (instOfNatNat (nat_lit 1))))
          j)
        (@Subtype.val.{u_1 + 1} T
          (fun x =>
            @Membership.mem.{u_1, u_1} T (Finset.{u_1} T)
              (@SetLike.instMembership.{u_1, u_1} (Finset.{u_1} T) T (@Finset.instSetLike.{u_1} T))
              (C
                (@HAdd.hAdd.{0, 0, 0} Nat Nat Nat (@instHAdd.{0} Nat instAddNat) j
                  (@OfNat.ofNat.{0} Nat (nat_lit 1) (instOfNatNat (nat_lit 1)))))
              x)
          x)) →
    Not
        (@LE.le.{0} Nat instLENat j
          (@HAdd.hAdd.{0, 0, 0} Nat Nat Nat (@instHAdd.{0} Nat instAddNat) j
            (@OfNat.ofNat.{0} Nat (nat_lit 1) (instOfNatNat (nat_lit 1))))) →
      False :=
⋯
```

## `_private.BrownianMotion.Continuity.KolmogorovChentsov.0.Dense.holderOnWith_extend._simp_1_1`

Command: `#print _private.BrownianMotion.Continuity.KolmogorovChentsov.0.Dense.holderOnWith_extend._simp_1_1`

```lean
private theorem Dense.holderOnWith_extend._simp_1_1.{u_1, u_2} : ∀ {α : Type u_1} {β : Type u_2} {f : α → β}
  {l : Filter.{u_2} β} {p : α → Prop},
  @Eq.{1} Prop (@Filter.Eventually.{u_1} α (fun a => p a) (@Filter.comap.{u_1, u_2} α β f l))
    (@Filter.Eventually.{u_2} β (fun b => ∀ (a : α), @Eq.{u_2 + 1} β (f a) b → p a) l) :=
⋯
```

## `_private.BrownianMotion.Continuity.KolmogorovChentsov.0.Dense.holderOnWith_extend._simp_1_2`

Command: `#print _private.BrownianMotion.Continuity.KolmogorovChentsov.0.Dense.holderOnWith_extend._simp_1_2`

```lean
private theorem Dense.holderOnWith_extend._simp_1_2.{u} : ∀ {α : Sort u} {p : α → Prop}
  {q : (@Subtype.{u} α fun a => p a) → Prop},
  @Eq.{1} Prop (∀ (x : @Subtype.{u} α fun a => p a), q x)
    (∀ (a : α) (b : p a), q (@Subtype.mk.{u} α (fun a => p a) a b)) :=
⋯
```

## `_private.BrownianMotion.Continuity.KolmogorovChentsov.0.Dense.holderOnWith_extend._simp_1_3`

Command: `#print _private.BrownianMotion.Continuity.KolmogorovChentsov.0.Dense.holderOnWith_extend._simp_1_3`

```lean
private theorem Dense.holderOnWith_extend._simp_1_3.{u} : ∀ {α : Type u} {p q : α → Prop} {f : Filter.{u} α},
  @Eq.{1} Prop (@Filter.Eventually.{u} α (fun x => And (p x) (q x)) f)
    (And (@Filter.Eventually.{u} α (fun x => p x) f) (@Filter.Eventually.{u} α (fun x => q x) f)) :=
⋯
```

## `_private.BrownianMotion.Continuity.KolmogorovChentsov.0.Dense.holderOnWith_extend._simp_1_6`

Command: `#print _private.BrownianMotion.Continuity.KolmogorovChentsov.0.Dense.holderOnWith_extend._simp_1_6`

```lean
private theorem Dense.holderOnWith_extend._simp_1_6.{u_1} : ∀ {α : Type u_1} [inst : LE.{u_1} α] {x y : α},
  @Eq.{1} Prop (@GE.ge.{u_1} α inst x y) (@LE.le.{u_1} α inst y x) :=
⋯
```

## `_private.BrownianMotion.Continuity.KolmogorovChentsov.0.Dense.holderOnWith_extend.match_1_4`

Command: `#print _private.BrownianMotion.Continuity.KolmogorovChentsov.0.Dense.holderOnWith_extend.match_1_4`

```lean
private def Dense.holderOnWith_extend.match_1_4.{u_1} : ∀ {X : Type u_1} {s U : Set.{u_1} X}
  (z :
    Prod.{u_1, u_1}
      (@Subtype.{u_1 + 1} X fun x => @Membership.mem.{u_1, u_1} X (Set.{u_1} X) (@Set.instMembership.{u_1} X) s x)
      (@Subtype.{u_1 + 1} X fun x => @Membership.mem.{u_1, u_1} X (Set.{u_1} X) (@Set.instMembership.{u_1} X) s x))
  (motive :
    And
        (@Membership.mem.{u_1, u_1} X (Set.{u_1} X) (@Set.instMembership.{u_1} X) U
          (@Subtype.val.{u_1 + 1} X
            (fun x => @Membership.mem.{u_1, u_1} X (Set.{u_1} X) (@Set.instMembership.{u_1} X) s x)
            (@Prod.fst.{u_1, u_1} (@Set.Elem.{u_1} X s) (@Set.Elem.{u_1} X s) z)))
        (@Membership.mem.{u_1, u_1} X (Set.{u_1} X) (@Set.instMembership.{u_1} X) U
          (@Subtype.val.{u_1 + 1} X
            (fun x => @Membership.mem.{u_1, u_1} X (Set.{u_1} X) (@Set.instMembership.{u_1} X) s x)
            (@Prod.snd.{u_1, u_1} (@Set.Elem.{u_1} X s) (@Set.Elem.{u_1} X s) z))) →
      Prop)
  (h :
    And
      (@Membership.mem.{u_1, u_1} X (Set.{u_1} X) (@Set.instMembership.{u_1} X) U
        (@Subtype.val.{u_1 + 1} X
          (fun x => @Membership.mem.{u_1, u_1} X (Set.{u_1} X) (@Set.instMembership.{u_1} X) s x)
          (@Prod.fst.{u_1, u_1} (@Set.Elem.{u_1} X s) (@Set.Elem.{u_1} X s) z)))
      (@Membership.mem.{u_1, u_1} X (Set.{u_1} X) (@Set.instMembership.{u_1} X) U
        (@Subtype.val.{u_1 + 1} X
          (fun x => @Membership.mem.{u_1, u_1} X (Set.{u_1} X) (@Set.instMembership.{u_1} X) s x)
          (@Prod.snd.{u_1, u_1} (@Set.Elem.{u_1} X s) (@Set.Elem.{u_1} X s) z)))),
  (∀
      (hz₁ :
        @Membership.mem.{u_1, u_1} X (Set.{u_1} X) (@Set.instMembership.{u_1} X) U
          (@Subtype.val.{u_1 + 1} X
            (fun x => @Membership.mem.{u_1, u_1} X (Set.{u_1} X) (@Set.instMembership.{u_1} X) s x)
            (@Prod.fst.{u_1, u_1} (@Set.Elem.{u_1} X s) (@Set.Elem.{u_1} X s) z)))
      (hz₂ :
        @Membership.mem.{u_1, u_1} X (Set.{u_1} X) (@Set.instMembership.{u_1} X) U
          (@Subtype.val.{u_1 + 1} X
            (fun x => @Membership.mem.{u_1, u_1} X (Set.{u_1} X) (@Set.instMembership.{u_1} X) s x)
            (@Prod.snd.{u_1, u_1} (@Set.Elem.{u_1} X s) (@Set.Elem.{u_1} X s) z))),
      motive ⋯) →
    motive h :=
⋯
```

## `_private.BrownianMotion.Continuity.KolmogorovChentsov.0.Measurable.measurableSet_edist_eqOn_zero_of_continuous._simp_1_1`

Command: `#print _private.BrownianMotion.Continuity.KolmogorovChentsov.0.Measurable.measurableSet_edist_eqOn_zero_of_continuous._simp_1_1`

```lean
private theorem Measurable.measurableSet_edist_eqOn_zero_of_continuous._simp_1_1.{u} : ∀ {α : Sort u} {p : α → Prop}
  {q : (@Subtype.{u} α fun a => p a) → Prop},
  @Eq.{1} Prop (∀ (x : @Subtype.{u} α fun a => p a), q x)
    (∀ (a : α) (b : p a), q (@Subtype.mk.{u} α (fun a => p a) a b)) :=
⋯
```

## `_private.BrownianMotion.Continuity.KolmogorovChentsov.0.Measurable.measurableSet_edist_eq_zero_of_continuous._simp_1_1`

Command: `#print _private.BrownianMotion.Continuity.KolmogorovChentsov.0.Measurable.measurableSet_edist_eq_zero_of_continuous._simp_1_1`

```lean
private theorem Measurable.measurableSet_edist_eq_zero_of_continuous._simp_1_1.{u} : ∀ {α : Sort u} {p : α → Prop}
  {q : (@Subtype.{u} α fun a => p a) → Prop},
  @Eq.{1} Prop (∀ (x : @Subtype.{u} α fun a => p a), q x)
    (∀ (a : α) (b : p a), q (@Subtype.mk.{u} α (fun a => p a) a b)) :=
⋯
```

## `_private.BrownianMotion.Continuity.KolmogorovChentsov.0.ProbabilityTheory.ae_mem_holderSet._simp_1_1`

Command: `#print _private.BrownianMotion.Continuity.KolmogorovChentsov.0.ProbabilityTheory.ae_mem_holderSet._simp_1_1`

```lean
private theorem ProbabilityTheory.ae_mem_holderSet._simp_1_1.{u_1, u_3, u_4} : ∀ {α : Type u_1} {F : Type u_3}
  [inst : FunLike.{u_3 + 1, u_1 + 1, 1} F (Set.{u_1} α) ENNReal]
  [inst_1 : @MeasureTheory.OuterMeasureClass.{u_3, u_1} F α inst] {μ : F} {ι : Sort u_4} [Countable.{u_4} ι]
  {p : α → ι → Prop},
  @Eq.{1} Prop (@Filter.Eventually.{u_1} α (fun a => ∀ (i : ι), p a i) (@MeasureTheory.ae.{u_1, u_3} α F inst inst_1 μ))
    (∀ (i : ι), @Filter.Eventually.{u_1} α (fun a => p a i) (@MeasureTheory.ae.{u_1, u_3} α F inst inst_1 μ)) :=
⋯
```

## `_private.BrownianMotion.Continuity.KolmogorovChentsov.0.ProbabilityTheory.edist_modification_holderModification._simp_1_3`

Command: `#print _private.BrownianMotion.Continuity.KolmogorovChentsov.0.ProbabilityTheory.edist_modification_holderModification._simp_1_3`

```lean
private theorem ProbabilityTheory.edist_modification_holderModification._simp_1_3.{u} : ∀ {α : Type u} (x : α)
  (a b : Set.{u} α),
  @Eq.{1} Prop
    (@Membership.mem.{u, u} α (Set.{u} α) (@Set.instMembership.{u} α)
      (@Inter.inter.{u} (Set.{u} α) (@Set.instInter.{u} α) a b) x)
    (And (@Membership.mem.{u, u} α (Set.{u} α) (@Set.instMembership.{u} α) a x)
      (@Membership.mem.{u, u} α (Set.{u} α) (@Set.instMembership.{u} α) b x)) :=
⋯
```

## `_private.BrownianMotion.Continuity.KolmogorovChentsov.0.ProbabilityTheory.edist_modification_holderModification._simp_1_4`

Command: `#print _private.BrownianMotion.Continuity.KolmogorovChentsov.0.ProbabilityTheory.edist_modification_holderModification._simp_1_4`

```lean
private theorem ProbabilityTheory.edist_modification_holderModification._simp_1_4 : ∀ {a b c : Prop},
  @Eq.{1} Prop (And a b → c) (a → b → c) :=
⋯
```

## `_private.BrownianMotion.Continuity.KolmogorovChentsov.0.ProbabilityTheory.exists_modification_holder'''._proof_1_5`

Command: `#print _private.BrownianMotion.Continuity.KolmogorovChentsov.0.ProbabilityTheory.exists_modification_holder'''._proof_1_5`

```lean
private theorem ProbabilityTheory.exists_modification_holder'''._proof_1_5 : ∀ {n : Nat} (m : Nat),
  @LE.le.{0} Nat instLENat n
      (@HAdd.hAdd.{0, 0, 0} Nat Nat Nat (@instHAdd.{0} Nat instAddNat) m
        (@OfNat.ofNat.{0} Nat (nat_lit 1) (instOfNatNat (nat_lit 1)))) →
    Not (@LE.le.{0} Nat instLENat n m) →
      Not
          (@Eq.{1} Nat n
            (@HAdd.hAdd.{0, 0, 0} Nat Nat Nat (@instHAdd.{0} Nat instAddNat) m
              (@OfNat.ofNat.{0} Nat (nat_lit 1) (instOfNatNat (nat_lit 1))))) →
        False :=
⋯
```

## `_private.BrownianMotion.Continuity.KolmogorovChentsov.0.ProbabilityTheory.exists_modification_holder'''._simp_1_4`

Command: `#print _private.BrownianMotion.Continuity.KolmogorovChentsov.0.ProbabilityTheory.exists_modification_holder'''._simp_1_4`

```lean
private theorem ProbabilityTheory.exists_modification_holder'''._simp_1_4.{u_1} : ∀ {α : Type u_1} {a : α}
  [inst : PartialOrder.{u_1} α] [inst_1 : Zero.{u_1} α]
  [@IsBotZeroClass.{u_1} α (@Preorder.toLE.{u_1} α (@PartialOrder.toPreorder.{u_1} α inst)) inst_1],
  @Eq.{1} Prop
    (@LE.le.{u_1} α (@Preorder.toLE.{u_1} α (@PartialOrder.toPreorder.{u_1} α inst)) a
      (@OfNat.ofNat.{u_1} α (nat_lit 0) (@Zero.toOfNat0.{u_1} α inst_1)))
    (@Eq.{u_1 + 1} α a (@OfNat.ofNat.{u_1} α (nat_lit 0) (@Zero.toOfNat0.{u_1} α inst_1))) :=
⋯
```

## `_private.BrownianMotion.Continuity.KolmogorovChentsov.0.ProbabilityTheory.exists_modification_holder'''._simp_1_6`

Command: `#print _private.BrownianMotion.Continuity.KolmogorovChentsov.0.ProbabilityTheory.exists_modification_holder'''._simp_1_6`

```lean
private theorem ProbabilityTheory.exists_modification_holder'''._simp_1_6.{u} : ∀ {α : Type u} (x : α)
  (a b : Set.{u} α),
  @Eq.{1} Prop
    (@Membership.mem.{u, u} α (Set.{u} α) (@Set.instMembership.{u} α)
      (@Inter.inter.{u} (Set.{u} α) (@Set.instInter.{u} α) a b) x)
    (And (@Membership.mem.{u, u} α (Set.{u} α) (@Set.instMembership.{u} α) a x)
      (@Membership.mem.{u, u} α (Set.{u} α) (@Set.instMembership.{u} α) b x)) :=
⋯
```

## `_private.BrownianMotion.Continuity.KolmogorovChentsov.0.ProbabilityTheory.exists_modification_holder'''._simp_1_7`

Command: `#print _private.BrownianMotion.Continuity.KolmogorovChentsov.0.ProbabilityTheory.exists_modification_holder'''._simp_1_7`

```lean
private theorem ProbabilityTheory.exists_modification_holder'''._simp_1_7.{u, v} : ∀ {α : Type u} {ι : Sort v} {x : α}
  {s : ι → Set.{u} α},
  @Eq.{1} Prop (@Membership.mem.{u, u} α (Set.{u} α) (@Set.instMembership.{u} α) (⋂ i, s i) x)
    (∀ (i : ι), @Membership.mem.{u, u} α (Set.{u} α) (@Set.instMembership.{u} α) (s i) x) :=
⋯
```

## `_private.BrownianMotion.Continuity.KolmogorovChentsov.0.ProbabilityTheory.exists_modification_holder'''._simp_1_8`

Command: `#print _private.BrownianMotion.Continuity.KolmogorovChentsov.0.ProbabilityTheory.exists_modification_holder'''._simp_1_8`

```lean
private theorem ProbabilityTheory.exists_modification_holder'''._simp_1_8.{u} : ∀ {α : Type u} {p q : α → Prop}
  {f : Filter.{u} α},
  @Eq.{1} Prop (@Filter.Eventually.{u} α (fun x => And (p x) (q x)) f)
    (And (@Filter.Eventually.{u} α (fun x => p x) f) (@Filter.Eventually.{u} α (fun x => q x) f)) :=
⋯
```

## `_private.BrownianMotion.Continuity.KolmogorovChentsov.0.ProbabilityTheory.exists_modification_holder'''._simp_1_9`

Command: `#print _private.BrownianMotion.Continuity.KolmogorovChentsov.0.ProbabilityTheory.exists_modification_holder'''._simp_1_9`

```lean
private theorem ProbabilityTheory.exists_modification_holder'''._simp_1_9.{u_1, u_3, u_4} : ∀ {α : Type u_1}
  {F : Type u_3} [inst : FunLike.{u_3 + 1, u_1 + 1, 1} F (Set.{u_1} α) ENNReal]
  [inst_1 : @MeasureTheory.OuterMeasureClass.{u_3, u_1} F α inst] {μ : F} {ι : Sort u_4} [Countable.{u_4} ι]
  {p : α → ι → Prop},
  @Eq.{1} Prop (@Filter.Eventually.{u_1} α (fun a => ∀ (i : ι), p a i) (@MeasureTheory.ae.{u_1, u_3} α F inst inst_1 μ))
    (∀ (i : ι), @Filter.Eventually.{u_1} α (fun a => p a i) (@MeasureTheory.ae.{u_1, u_3} α F inst inst_1 μ)) :=
⋯
```

## `_private.BrownianMotion.Continuity.KolmogorovChentsov.0.ProbabilityTheory.exists_modification_holder'''.match_1_2`

Command: `#print _private.BrownianMotion.Continuity.KolmogorovChentsov.0.ProbabilityTheory.exists_modification_holder'''.match_1_2`

```lean
private def ProbabilityTheory.exists_modification_holder'''.match_1_2 : ∀ {d p q : Real}
  (motive :
    (∃ a,
        And (@LT.lt.{0} Real Real.instLT (@OfNat.ofNat.{0} Real (nat_lit 0) (@Zero.toOfNat0.{0} Real Real.instZero)) a)
          (@LT.lt.{0} Real Real.instLT a
            (@HDiv.hDiv.{0, 0, 0} Real Real Real
              (@instHDiv.{0} Real (@DivInvMonoid.toDiv.{0} Real Real.instDivInvMonoid))
              (@HSub.hSub.{0, 0, 0} Real Real Real (@instHSub.{0} Real Real.instSub) q d) p))) →
      Prop)
  (x :
    ∃ a,
      And (@LT.lt.{0} Real Real.instLT (@OfNat.ofNat.{0} Real (nat_lit 0) (@Zero.toOfNat0.{0} Real Real.instZero)) a)
        (@LT.lt.{0} Real Real.instLT a
          (@HDiv.hDiv.{0, 0, 0} Real Real Real (@instHDiv.{0} Real (@DivInvMonoid.toDiv.{0} Real Real.instDivInvMonoid))
            (@HSub.hSub.{0, 0, 0} Real Real Real (@instHSub.{0} Real Real.instSub) q d) p))),
  (∀ (β₀' : Real)
      (hβ₀_pos' :
        @LT.lt.{0} Real Real.instLT (@OfNat.ofNat.{0} Real (nat_lit 0) (@Zero.toOfNat0.{0} Real Real.instZero)) β₀')
      (hβ₀_lt' :
        @LT.lt.{0} Real Real.instLT β₀'
          (@HDiv.hDiv.{0, 0, 0} Real Real Real (@instHDiv.{0} Real (@DivInvMonoid.toDiv.{0} Real Real.instDivInvMonoid))
            (@HSub.hSub.{0, 0, 0} Real Real Real (@instHSub.{0} Real Real.instSub) q d) p)),
      motive ⋯) →
    motive x :=
⋯
```

## `_private.BrownianMotion.Continuity.KolmogorovChentsov.0.ProbabilityTheory.holderOnWith_of_mem_holderSet._simp_1_1`

Command: `#print _private.BrownianMotion.Continuity.KolmogorovChentsov.0.ProbabilityTheory.holderOnWith_of_mem_holderSet._simp_1_1`

```lean
private theorem ProbabilityTheory.holderOnWith_of_mem_holderSet._simp_1_1 : ∀ {x : ENNReal} {y : Real},
  @Eq.{1} Prop
    (@Eq.{1} ENNReal (@HPow.hPow.{0, 0, 0} ENNReal Real ENNReal (@instHPow.{0, 0} ENNReal Real ENNReal.instPowReal) x y)
      (@Top.top.{0} ENNReal ENNReal.instTop))
    (Or
      (And (@Eq.{1} ENNReal x (@OfNat.ofNat.{0} ENNReal (nat_lit 0) (@Zero.toOfNat0.{0} ENNReal ENNReal.instZero)))
        (@LT.lt.{0} Real Real.instLT y (@OfNat.ofNat.{0} Real (nat_lit 0) (@Zero.toOfNat0.{0} Real Real.instZero))))
      (And (@Eq.{1} ENNReal x (@Top.top.{0} ENNReal ENNReal.instTop))
        (@LT.lt.{0} Real Real.instLT (@OfNat.ofNat.{0} Real (nat_lit 0) (@Zero.toOfNat0.{0} Real Real.instZero)) y))) :=
⋯
```

## `_private.BrownianMotion.Continuity.KolmogorovChentsov.0.ProbabilityTheory.holderOnWith_of_mem_holderSet._simp_1_2`

Command: `#print _private.BrownianMotion.Continuity.KolmogorovChentsov.0.ProbabilityTheory.holderOnWith_of_mem_holderSet._simp_1_2`

```lean
private theorem ProbabilityTheory.holderOnWith_of_mem_holderSet._simp_1_2 : ∀ {r : NNReal},
  @Eq.{1} Prop
    (@LT.lt.{0} Real Real.instLT (@OfNat.ofNat.{0} Real (nat_lit 0) (@Zero.toOfNat0.{0} Real Real.instZero)) ↑r)
    (@LT.lt.{0} NNReal (@Preorder.toLT.{0} NNReal (@PartialOrder.toPreorder.{0} NNReal NNReal.instPartialOrder))
      (@OfNat.ofNat.{0} NNReal (nat_lit 0) (@Zero.toOfNat0.{0} NNReal NNReal.instZero)) r) :=
⋯
```

## `_private.BrownianMotion.Continuity.KolmogorovChentsov.0.ProbabilityTheory.holderOnWith_of_mem_holderSet._simp_1_3`

Command: `#print _private.BrownianMotion.Continuity.KolmogorovChentsov.0.ProbabilityTheory.holderOnWith_of_mem_holderSet._simp_1_3`

```lean
private theorem ProbabilityTheory.holderOnWith_of_mem_holderSet._simp_1_3 : ∀ {p q : Prop},
  @Eq.{1} Prop (Not (Or p q)) (And (Not p) (Not q)) :=
⋯
```

## `_private.BrownianMotion.Continuity.KolmogorovChentsov.0.ProbabilityTheory.holderOnWith_of_mem_holderSet._simp_1_4`

Command: `#print _private.BrownianMotion.Continuity.KolmogorovChentsov.0.ProbabilityTheory.holderOnWith_of_mem_holderSet._simp_1_4`

```lean
private theorem ProbabilityTheory.holderOnWith_of_mem_holderSet._simp_1_4 : ∀ {a b : Prop},
  @Eq.{1} Prop (Not (And a b)) (a → Not b) :=
⋯
```

## `_private.BrownianMotion.Continuity.KolmogorovChentsov.0.ProbabilityTheory.holderOnWith_of_mem_holderSet._simp_1_5`

Command: `#print _private.BrownianMotion.Continuity.KolmogorovChentsov.0.ProbabilityTheory.holderOnWith_of_mem_holderSet._simp_1_5`

```lean
private theorem ProbabilityTheory.holderOnWith_of_mem_holderSet._simp_1_5.{u_1} : ∀ {α : Type u_1}
  [inst : LinearOrder.{u_1} α] {a b : α},
  @Eq.{1} Prop
    (Not
      (@LT.lt.{u_1} α
        (@Preorder.toLT.{u_1} α (@PartialOrder.toPreorder.{u_1} α (@LinearOrder.toPartialOrder.{u_1} α inst))) a b))
    (@LE.le.{u_1} α
      (@Preorder.toLE.{u_1} α (@PartialOrder.toPreorder.{u_1} α (@LinearOrder.toPartialOrder.{u_1} α inst))) b a) :=
⋯
```

## `_private.BrownianMotion.Continuity.KolmogorovChentsov.0.ProbabilityTheory.holderOnWith_of_mem_holderSet._simp_1_6`

Command: `#print _private.BrownianMotion.Continuity.KolmogorovChentsov.0.ProbabilityTheory.holderOnWith_of_mem_holderSet._simp_1_6`

```lean
private theorem ProbabilityTheory.holderOnWith_of_mem_holderSet._simp_1_6 : ∀ {q : NNReal},
  @Eq.{1} Prop
    (@LE.le.{0} Real Real.instLE (@OfNat.ofNat.{0} Real (nat_lit 0) (@Zero.toOfNat0.{0} Real Real.instZero)) ↑q) True :=
⋯
```

## `_private.BrownianMotion.Continuity.KolmogorovChentsov.0.ProbabilityTheory.holderOnWith_of_mem_holderSet._simp_1_7`

Command: `#print _private.BrownianMotion.Continuity.KolmogorovChentsov.0.ProbabilityTheory.holderOnWith_of_mem_holderSet._simp_1_7`

```lean
private theorem ProbabilityTheory.holderOnWith_of_mem_holderSet._simp_1_7.{u_1} : ∀ {α : Type u_1} {a : α}
  [inst : PartialOrder.{u_1} α] [inst_1 : Zero.{u_1} α]
  [@IsBotZeroClass.{u_1} α (@Preorder.toLE.{u_1} α (@PartialOrder.toPreorder.{u_1} α inst)) inst_1],
  @Eq.{1} Prop
    (@LE.le.{u_1} α (@Preorder.toLE.{u_1} α (@PartialOrder.toPreorder.{u_1} α inst)) a
      (@OfNat.ofNat.{u_1} α (nat_lit 0) (@Zero.toOfNat0.{u_1} α inst_1)))
    (@Eq.{u_1 + 1} α a (@OfNat.ofNat.{u_1} α (nat_lit 0) (@Zero.toOfNat0.{u_1} α inst_1))) :=
⋯
```

## `_private.BrownianMotion.Continuity.KolmogorovChentsov.0.ProbabilityTheory.indistinguishable_of_edist_modification_on.match_1_1`

Command: `#print _private.BrownianMotion.Continuity.KolmogorovChentsov.0.ProbabilityTheory.indistinguishable_of_edist_modification_on.match_1_1`

```lean
private def ProbabilityTheory.indistinguishable_of_edist_modification_on.match_1_1.{u_1} : ∀ {T : Type u_1}
  [inst : TopologicalSpace.{u_1} T] (motive : @TopologicalSpace.SeparableSpace.{u_1} T inst → Prop)
  (x : @TopologicalSpace.SeparableSpace.{u_1} T inst),
  (∀ (D : Set.{u_1} T) (D_countable : @Set.Countable.{u_1} T D) (D_dense : @Dense.{u_1} T inst D), motive ⋯) →
    motive x :=
⋯
```

## `_private.BrownianMotion.Continuity.KolmogorovChentsov.0.UniformContinuousOn.exists_tendsto._proof_1_11`

Command: `#print _private.BrownianMotion.Continuity.KolmogorovChentsov.0.UniformContinuousOn.exists_tendsto._proof_1_11`

```lean
private theorem UniformContinuousOn.exists_tendsto._proof_1_11.{u_1} : ∀ {α : Type u_1} {s t : Set.{u_1} α},
  Or
    (And
      (@LE.le.{u_1}
        (Set.{u_1}
          (@Subtype.{u_1 + 1} α fun x => @Membership.mem.{u_1, u_1} α (Set.{u_1} α) (@Set.instMembership.{u_1} α) s x))
        (@Set.instLE.{u_1}
          (@Subtype.{u_1 + 1} α fun x => @Membership.mem.{u_1, u_1} α (Set.{u_1} α) (@Set.instMembership.{u_1} α) s x))
        (@Set.preimage.{u_1, u_1}
          (@Subtype.{u_1 + 1} α fun x => @Membership.mem.{u_1, u_1} α (Set.{u_1} α) (@Set.instMembership.{u_1} α) s x) α
          (@Subtype.val.{u_1 + 1} α fun x =>
            @Membership.mem.{u_1, u_1} α (Set.{u_1} α) (@Set.instMembership.{u_1} α) s x)
          t)
        (@setOf.{u_1}
          (@Subtype.{u_1 + 1} α fun x => @Membership.mem.{u_1, u_1} α (Set.{u_1} α) (@Set.instMembership.{u_1} α) s x)
          fun x =>
          @Membership.mem.{u_1, u_1} α (Set.{u_1} α) (@Set.instMembership.{u_1} α) t
            (@Subtype.val.{u_1 + 1} α
              (fun x => @Membership.mem.{u_1, u_1} α (Set.{u_1} α) (@Set.instMembership.{u_1} α) s x) x)))
      (@LE.le.{u_1}
        (Set.{u_1}
          (@Subtype.{u_1 + 1} α fun x => @Membership.mem.{u_1, u_1} α (Set.{u_1} α) (@Set.instMembership.{u_1} α) s x))
        (@Set.instLE.{u_1}
          (@Subtype.{u_1 + 1} α fun x => @Membership.mem.{u_1, u_1} α (Set.{u_1} α) (@Set.instMembership.{u_1} α) s x))
        (@Set.preimage.{u_1, u_1}
          (@Subtype.{u_1 + 1} α fun x => @Membership.mem.{u_1, u_1} α (Set.{u_1} α) (@Set.instMembership.{u_1} α) s x) α
          (@Subtype.val.{u_1 + 1} α fun x =>
            @Membership.mem.{u_1, u_1} α (Set.{u_1} α) (@Set.instMembership.{u_1} α) s x)
          t)
        (@setOf.{u_1}
          (@Subtype.{u_1 + 1} α fun x => @Membership.mem.{u_1, u_1} α (Set.{u_1} α) (@Set.instMembership.{u_1} α) s x)
          fun x =>
          @Membership.mem.{u_1, u_1} α (Set.{u_1} α) (@Set.instMembership.{u_1} α) t
            (@Subtype.val.{u_1 + 1} α
              (fun x => @Membership.mem.{u_1, u_1} α (Set.{u_1} α) (@Set.instMembership.{u_1} α) s x) x))))
    (Or
      (@Eq.{u_1 + 1}
        (Set.{u_1}
          (@Subtype.{u_1 + 1} α fun x => @Membership.mem.{u_1, u_1} α (Set.{u_1} α) (@Set.instMembership.{u_1} α) s x))
        (@Set.preimage.{u_1, u_1}
          (@Subtype.{u_1 + 1} α fun x => @Membership.mem.{u_1, u_1} α (Set.{u_1} α) (@Set.instMembership.{u_1} α) s x) α
          (@Subtype.val.{u_1 + 1} α fun x =>
            @Membership.mem.{u_1, u_1} α (Set.{u_1} α) (@Set.instMembership.{u_1} α) s x)
          t)
        (@EmptyCollection.emptyCollection.{u_1}
          (Set.{u_1}
            (@Subtype.{u_1 + 1} α fun x =>
              @Membership.mem.{u_1, u_1} α (Set.{u_1} α) (@Set.instMembership.{u_1} α) s x))
          (@Set.instEmptyCollection.{u_1}
            (@Subtype.{u_1 + 1} α fun x =>
              @Membership.mem.{u_1, u_1} α (Set.{u_1} α) (@Set.instMembership.{u_1} α) s x))))
      (@Eq.{u_1 + 1}
        (Set.{u_1}
          (@Subtype.{u_1 + 1} α fun x => @Membership.mem.{u_1, u_1} α (Set.{u_1} α) (@Set.instMembership.{u_1} α) s x))
        (@Set.preimage.{u_1, u_1}
          (@Subtype.{u_1 + 1} α fun x => @Membership.mem.{u_1, u_1} α (Set.{u_1} α) (@Set.instMembership.{u_1} α) s x) α
          (@Subtype.val.{u_1 + 1} α fun x =>
            @Membership.mem.{u_1, u_1} α (Set.{u_1} α) (@Set.instMembership.{u_1} α) s x)
          t)
        (@EmptyCollection.emptyCollection.{u_1}
          (Set.{u_1}
            (@Subtype.{u_1 + 1} α fun x =>
              @Membership.mem.{u_1, u_1} α (Set.{u_1} α) (@Set.instMembership.{u_1} α) s x))
          (@Set.instEmptyCollection.{u_1}
            (@Subtype.{u_1 + 1} α fun x =>
              @Membership.mem.{u_1, u_1} α (Set.{u_1} α) (@Set.instMembership.{u_1} α) s x))))) :=
⋯
```

## `_private.BrownianMotion.Continuity.KolmogorovChentsov.0.UniformContinuousOn.exists_tendsto._simp_1_1`

Command: `#print _private.BrownianMotion.Continuity.KolmogorovChentsov.0.UniformContinuousOn.exists_tendsto._simp_1_1`

```lean
private theorem UniformContinuousOn.exists_tendsto._simp_1_1.{u_1, u_2} : ∀ {α : Type u_1} {β : Type u_2}
  {g : Filter.{u_2} β} {m : α → β} {s : Set.{u_1} α},
  @Eq.{1} Prop
    (@Membership.mem.{u_1, u_1} (Set.{u_1} α) (Filter.{u_1} α) (@Filter.instMembership.{u_1} α)
      (@Filter.comap.{u_1, u_2} α β m g) s)
    (∃ t,
      And (@Membership.mem.{u_2, u_2} (Set.{u_2} β) (Filter.{u_2} β) (@Filter.instMembership.{u_2} β) g t)
        (@LE.le.{u_1} (Set.{u_1} α) (@Set.instLE.{u_1} α) (@Set.preimage.{u_1, u_2} α β m t) s)) :=
⋯
```

## `_private.BrownianMotion.Continuity.KolmogorovChentsov.0.UniformContinuousOn.exists_tendsto._simp_1_10`

Command: `#print _private.BrownianMotion.Continuity.KolmogorovChentsov.0.UniformContinuousOn.exists_tendsto._simp_1_10`

```lean
private theorem UniformContinuousOn.exists_tendsto._simp_1_10.{u_1, u_2} : ∀ {α : Type u_1} {β : Type u_2}
  {s s₁ : Set.{u_1} α} {t t₁ : Set.{u_2} β},
  @Eq.{1} Prop
    (@LE.le.{max u_1 u_2} (Set.{max u_2 u_1} (Prod.{u_1, u_2} α β)) (@Set.instLE.{max u_1 u_2} (Prod.{u_1, u_2} α β))
      (@SProd.sprod.{u_1, u_2, max u_1 u_2} (Set.{u_1} α) (Set.{u_2} β) (Set.{max u_2 u_1} (Prod.{u_1, u_2} α β))
        (@Set.instSProd.{u_1, u_2} α β) s t)
      (@SProd.sprod.{u_1, u_2, max u_1 u_2} (Set.{u_1} α) (Set.{u_2} β) (Set.{max u_2 u_1} (Prod.{u_1, u_2} α β))
        (@Set.instSProd.{u_1, u_2} α β) s₁ t₁))
    (Or
      (And (@LE.le.{u_1} (Set.{u_1} α) (@Set.instLE.{u_1} α) s s₁)
        (@LE.le.{u_2} (Set.{u_2} β) (@Set.instLE.{u_2} β) t t₁))
      (Or
        (@Eq.{u_1 + 1} (Set.{u_1} α) s
          (@EmptyCollection.emptyCollection.{u_1} (Set.{u_1} α) (@Set.instEmptyCollection.{u_1} α)))
        (@Eq.{u_2 + 1} (Set.{u_2} β) t
          (@EmptyCollection.emptyCollection.{u_2} (Set.{u_2} β) (@Set.instEmptyCollection.{u_2} β))))) :=
⋯
```

## `_private.BrownianMotion.Continuity.KolmogorovChentsov.0.UniformContinuousOn.exists_tendsto._simp_1_2`

Command: `#print _private.BrownianMotion.Continuity.KolmogorovChentsov.0.UniformContinuousOn.exists_tendsto._simp_1_2`

```lean
private theorem UniformContinuousOn.exists_tendsto._simp_1_2.{u_1} : ∀ {α : Sort u_1} {p : α → Prop}
  {q : (∃ x, p x) → Prop}, @Eq.{1} Prop (∀ (h : ∃ x, p x), q h) (∀ (x : α) (h : p x), q ⋯) :=
⋯
```

## `_private.BrownianMotion.Continuity.KolmogorovChentsov.0.UniformContinuousOn.exists_tendsto._simp_1_3`

Command: `#print _private.BrownianMotion.Continuity.KolmogorovChentsov.0.UniformContinuousOn.exists_tendsto._simp_1_3`

```lean
private theorem UniformContinuousOn.exists_tendsto._simp_1_3 : ∀ {a b c : Prop},
  @Eq.{1} Prop (And a b → c) (a → b → c) :=
⋯
```

## `_private.BrownianMotion.Continuity.KolmogorovChentsov.0.UniformContinuousOn.exists_tendsto._simp_1_4`

Command: `#print _private.BrownianMotion.Continuity.KolmogorovChentsov.0.UniformContinuousOn.exists_tendsto._simp_1_4`

```lean
private theorem UniformContinuousOn.exists_tendsto._simp_1_4.{u_3} : ∀ {α : Type u_3} [inst : Preorder.{u_3} α]
  [@IsDirectedOrder.{u_3} α (@Preorder.toLE.{u_3} α inst)] {p : α → Prop} [Nonempty.{u_3 + 1} α],
  @Eq.{1} Prop (@Filter.Eventually.{u_3} α (fun x => p x) (@Filter.atTop.{u_3} α inst))
    (∃ a, ∀ (b : α), @LE.le.{u_3} α (@Preorder.toLE.{u_3} α inst) a b → p b) :=
⋯
```

## `_private.BrownianMotion.Continuity.KolmogorovChentsov.0.UniformContinuousOn.exists_tendsto._simp_1_5`

Command: `#print _private.BrownianMotion.Continuity.KolmogorovChentsov.0.UniformContinuousOn.exists_tendsto._simp_1_5`

```lean
private theorem UniformContinuousOn.exists_tendsto._simp_1_5.{u, v} : ∀ {α : Type u} {β : Type v} {s : Set.{u} α}
  {t : Set.{v} β} {p : Prod.{u, v} α β},
  @Eq.{1} Prop
    (@Membership.mem.{max u v, max u v} (Prod.{u, v} α β) (Set.{max v u} (Prod.{u, v} α β))
      (@Set.instMembership.{max u v} (Prod.{u, v} α β))
      (@SProd.sprod.{u, v, max u v} (Set.{u} α) (Set.{v} β) (Set.{max v u} (Prod.{u, v} α β))
        (@Set.instSProd.{u, v} α β) s t)
      p)
    (And (@Membership.mem.{u, u} α (Set.{u} α) (@Set.instMembership.{u} α) s (@Prod.fst.{u, v} α β p))
      (@Membership.mem.{v, v} β (Set.{v} β) (@Set.instMembership.{v} β) t (@Prod.snd.{u, v} α β p))) :=
⋯
```

## `_private.BrownianMotion.Continuity.KolmogorovChentsov.0.UniformContinuousOn.exists_tendsto._simp_1_6`

Command: `#print _private.BrownianMotion.Continuity.KolmogorovChentsov.0.UniformContinuousOn.exists_tendsto._simp_1_6`

```lean
private theorem UniformContinuousOn.exists_tendsto._simp_1_6.{u_1, u_2} : ∀ {α : Type u_1} {β : Type u_2}
  {p : Prod.{u_1, u_2} α β → Prop},
  @Eq.{1} Prop (∀ (x : Prod.{u_1, u_2} α β), p x) (∀ (a : α) (b : β), p (@Prod.mk.{u_1, u_2} α β a b)) :=
⋯
```

## `_private.BrownianMotion.Continuity.KolmogorovChentsov.0.UniformContinuousOn.exists_tendsto._simp_1_7`

Command: `#print _private.BrownianMotion.Continuity.KolmogorovChentsov.0.UniformContinuousOn.exists_tendsto._simp_1_7`

```lean
private theorem UniformContinuousOn.exists_tendsto._simp_1_7.{u_1, u_2} : ∀ {α : Type u_1} {β : Type u_2}
  {p : Prod.{u_1, u_2} α β → Prop}, @Eq.{1} Prop (∃ x, p x) (∃ a b, p (@Prod.mk.{u_1, u_2} α β a b)) :=
⋯
```

## `_private.BrownianMotion.Continuity.KolmogorovChentsov.0.UniformContinuousOn.exists_tendsto._simp_1_8`

Command: `#print _private.BrownianMotion.Continuity.KolmogorovChentsov.0.UniformContinuousOn.exists_tendsto._simp_1_8`

```lean
private theorem UniformContinuousOn.exists_tendsto._simp_1_8.{u_2, u_3} : ∀ {α : Type u_2} {β : Type u_3}
  [inst : LE.{u_2} α] [inst_1 : LE.{u_3} β] {a₁ a₂ : α} {b₁ b₂ : β},
  @Eq.{1} Prop
    (@LE.le.{max u_2 u_3} (Prod.{u_2, u_3} α β) (@Prod.instLE_mathlib.{u_2, u_3} α β inst inst_1)
      (@Prod.mk.{u_2, u_3} α β a₁ b₁) (@Prod.mk.{u_2, u_3} α β a₂ b₂))
    (And (@LE.le.{u_2} α inst a₁ a₂) (@LE.le.{u_3} β inst_1 b₁ b₂)) :=
⋯
```

## `_private.BrownianMotion.Continuity.KolmogorovChentsov.0.UniformContinuousOn.exists_tendsto._simp_1_9`

Command: `#print _private.BrownianMotion.Continuity.KolmogorovChentsov.0.UniformContinuousOn.exists_tendsto._simp_1_9`

```lean
private theorem UniformContinuousOn.exists_tendsto._simp_1_9.{u} : ∀ {α : Type u} {s : Set.{u} α} {f : Filter.{u} α},
  @Eq.{1} Prop
    (@LE.le.{u} (Filter.{u} α)
      (@Preorder.toLE.{u} (Filter.{u} α) (@PartialOrder.toPreorder.{u} (Filter.{u} α) (@Filter.instPartialOrder.{u} α)))
      f (@Filter.principal.{u} α s))
    (@Membership.mem.{u, u} (Set.{u} α) (Filter.{u} α) (@Filter.instMembership.{u} α) f s) :=
⋯
```

## `_private.BrownianMotion.Continuity.KolmogorovChentsovInequality.0.ProbabilityTheory.constL_lt_top._proof_1_17`

Command: `#print _private.BrownianMotion.Continuity.KolmogorovChentsovInequality.0.ProbabilityTheory.constL_lt_top._proof_1_17`

```lean
private theorem ProbabilityTheory.constL_lt_top._proof_1_17 : ∀ {d : Real} (k n : Nat),
  @LE.le.{0} Real Real.instLE (@OfNat.ofNat.{0} Real (nat_lit 0) (@Zero.toOfNat0.{0} Real Real.instZero))
      (@HAdd.hAdd.{0, 0, 0} Real Real Real (@instHAdd.{0} Real Real.instAdd)
        (@HMul.hMul.{0, 0, 0} Real Real Real (@instHMul.{0} Real Real.instMul) (@Nat.cast.{0} Real Real.instNatCast k)
          d)
        (@HMul.hMul.{0, 0, 0} Real Real Real (@instHMul.{0} Real Real.instMul)
          (@OfNat.ofNat.{0} Real (nat_lit 2) (@instOfNatAtLeastTwo.{0} Real (nat_lit 2) Real.instNatCast ⋯)) d)) →
    @LE.le.{0} Real (@Preorder.toLE.{0} Real Real.instPreorder)
      (@HMul.hMul.{0, 0, 0} Real Real Real (@instHMul.{0} Real Real.instMul) d
        (@NatCast.natCast.{0} Real
          (@AddMonoidWithOne.toNatCast.{0} Real
            (@AddGroupWithOne.toAddMonoidWithOne.{0} Real (@Ring.toAddGroupWithOne.{0} Real Real.instRing)))
          n))
      (@HMul.hMul.{0, 0, 0} Real Real Real (@instHMul.{0} Real Real.instMul)
        (@HAdd.hAdd.{0, 0, 0} Real Real Real (@instHAdd.{0} Real Real.instAdd)
          (@HAdd.hAdd.{0, 0, 0} Real Real Real (@instHAdd.{0} Real Real.instAdd)
            (@NatCast.natCast.{0} Real Real.instNatCast n) (@NatCast.natCast.{0} Real Real.instNatCast k))
          (@OfNat.ofNat.{0} Real (nat_lit 2) (@instOfNatAtLeastTwo.{0} Real (nat_lit 2) Real.instNatCast ⋯)))
        d) :=
⋯
```

## `_private.BrownianMotion.Continuity.KolmogorovChentsovInequality.0.ProbabilityTheory.constL_lt_top._simp_1_10`

Command: `#print _private.BrownianMotion.Continuity.KolmogorovChentsovInequality.0.ProbabilityTheory.constL_lt_top._simp_1_10`

```lean
private theorem ProbabilityTheory.constL_lt_top._simp_1_10.{u_1} : ∀ {α : Type u_1} [inst : DivisionCommMonoid.{u_1} α]
  (a b c d : α),
  @Eq.{u_1 + 1} α
    (@HDiv.hDiv.{u_1, u_1, u_1} α α α
      (@instHDiv.{u_1} α
        (@DivInvMonoid.toDiv.{u_1} α
          (@DivisionMonoid.toDivInvMonoid.{u_1} α (@DivisionCommMonoid.toDivisionMonoid.{u_1} α inst))))
      (@HMul.hMul.{u_1, u_1, u_1} α α α
        (@instHMul.{u_1} α
          (@MulOne.toMul.{u_1} α
            (@MulOneClass.toMulOne.{u_1} α
              (@Monoid.toMulOneClass.{u_1} α
                (@DivInvMonoid.toMonoid.{u_1} α
                  (@DivisionMonoid.toDivInvMonoid.{u_1} α (@DivisionCommMonoid.toDivisionMonoid.{u_1} α inst)))))))
        a c)
      (@HMul.hMul.{u_1, u_1, u_1} α α α
        (@instHMul.{u_1} α
          (@MulOne.toMul.{u_1} α
            (@MulOneClass.toMulOne.{u_1} α
              (@Monoid.toMulOneClass.{u_1} α
                (@DivInvMonoid.toMonoid.{u_1} α
                  (@DivisionMonoid.toDivInvMonoid.{u_1} α (@DivisionCommMonoid.toDivisionMonoid.{u_1} α inst)))))))
        b d))
    (@HMul.hMul.{u_1, u_1, u_1} α α α
      (@instHMul.{u_1} α
        (@MulOne.toMul.{u_1} α
          (@MulOneClass.toMulOne.{u_1} α
            (@Monoid.toMulOneClass.{u_1} α
              (@DivInvMonoid.toMonoid.{u_1} α
                (@DivisionMonoid.toDivInvMonoid.{u_1} α (@DivisionCommMonoid.toDivisionMonoid.{u_1} α inst)))))))
      (@HDiv.hDiv.{u_1, u_1, u_1} α α α
        (@instHDiv.{u_1} α
          (@DivInvMonoid.toDiv.{u_1} α
            (@DivisionMonoid.toDivInvMonoid.{u_1} α (@DivisionCommMonoid.toDivisionMonoid.{u_1} α inst))))
        a b)
      (@HDiv.hDiv.{u_1, u_1, u_1} α α α
        (@instHDiv.{u_1} α
          (@DivInvMonoid.toDiv.{u_1} α
            (@DivisionMonoid.toDivInvMonoid.{u_1} α (@DivisionCommMonoid.toDivisionMonoid.{u_1} α inst))))
        c d)) :=
⋯
```

## `_private.BrownianMotion.Continuity.KolmogorovChentsovInequality.0.ProbabilityTheory.constL_lt_top._simp_1_15`

Command: `#print _private.BrownianMotion.Continuity.KolmogorovChentsovInequality.0.ProbabilityTheory.constL_lt_top._simp_1_15`

```lean
private theorem ProbabilityTheory.constL_lt_top._simp_1_15 : ∀ (x : ENNReal) (z : Real),
  @Eq.{1} Real
    (@HPow.hPow.{0, 0, 0} ENNReal Real ENNReal (@instHPow.{0, 0} ENNReal Real ENNReal.instPowReal) x z).toReal
    (@HPow.hPow.{0, 0, 0} Real Real Real (@instHPow.{0, 0} Real Real Real.instPow) x.toReal z) :=
⋯
```

## `_private.BrownianMotion.Continuity.KolmogorovChentsovInequality.0.ProbabilityTheory.constL_lt_top._simp_1_16`

Command: `#print _private.BrownianMotion.Continuity.KolmogorovChentsovInequality.0.ProbabilityTheory.constL_lt_top._simp_1_16`

```lean
private theorem ProbabilityTheory.constL_lt_top._simp_1_16.{u_3} : ∀ {α : Type u_3} [inst : Semiring.{u_3} α]
  [inst_1 : PartialOrder.{u_3} α] [@IsOrderedRing.{u_3} α inst inst_1] [Nontrivial.{u_3} α] {n : Nat}
  [inst_4 : n.AtLeastTwo],
  @Eq.{1} Prop
    (@LT.lt.{u_3} α (@Preorder.toLT.{u_3} α (@PartialOrder.toPreorder.{u_3} α inst_1))
      (@OfNat.ofNat.{u_3} α (nat_lit 0)
        (@Zero.toOfNat0.{u_3} α (@MulZeroClass.toZero.{u_3} α (@instMulZeroClassOfSemiring.{u_3} α inst))))
      (@OfNat.ofNat.{u_3} α n
        (@instOfNatAtLeastTwo.{u_3} α n
          (@AddMonoidWithOne.toNatCast.{u_3} α
            (@AddCommMonoidWithOne.toAddMonoidWithOne.{u_3} α
              (@NonAssocSemiring.toAddCommMonoidWithOne.{u_3} α (@Semiring.toNonAssocSemiring.{u_3} α inst))))
          inst_4)))
    True :=
⋯
```

## `_private.BrownianMotion.Continuity.KolmogorovChentsovInequality.0.ProbabilityTheory.constL_lt_top._simp_1_7`

Command: `#print _private.BrownianMotion.Continuity.KolmogorovChentsovInequality.0.ProbabilityTheory.constL_lt_top._simp_1_7`

```lean
private theorem ProbabilityTheory.constL_lt_top._simp_1_7.{u_3} : ∀ {G₀ : Type u_3} [inst : GroupWithZero.{u_3} G₀]
  [inst_1 : PartialOrder.{u_3} G₀]
  [@MulPosReflectLT.{u_3} G₀
      (@MulZeroClass.toMul.{u_3} G₀
        (@MulZeroOneClass.toMulZeroClass.{u_3} G₀
          (@MonoidWithZero.toMulZeroOneClass.{u_3} G₀ (@GroupWithZero.toMonoidWithZero.{u_3} G₀ inst))))
      (@MulZeroClass.toZero.{u_3} G₀
        (@MulZeroOneClass.toMulZeroClass.{u_3} G₀
          (@MonoidWithZero.toMulZeroOneClass.{u_3} G₀ (@GroupWithZero.toMonoidWithZero.{u_3} G₀ inst))))
      (@PartialOrder.toPreorder.{u_3} G₀ inst_1)]
  {a b c : G₀},
  @LT.lt.{u_3} G₀ (@Preorder.toLT.{u_3} G₀ (@PartialOrder.toPreorder.{u_3} G₀ inst_1))
      (@OfNat.ofNat.{u_3} G₀ (nat_lit 0)
        (@Zero.toOfNat0.{u_3} G₀
          (@MulZeroClass.toZero.{u_3} G₀
            (@MulZeroOneClass.toMulZeroClass.{u_3} G₀
              (@MonoidWithZero.toMulZeroOneClass.{u_3} G₀ (@GroupWithZero.toMonoidWithZero.{u_3} G₀ inst))))))
      c →
    @Eq.{1} Prop
      (@LT.lt.{u_3} G₀ (@Preorder.toLT.{u_3} G₀ (@PartialOrder.toPreorder.{u_3} G₀ inst_1))
        (@HMul.hMul.{u_3, u_3, u_3} G₀ G₀ G₀
          (@instHMul.{u_3} G₀
            (@MulZeroClass.toMul.{u_3} G₀
              (@MulZeroOneClass.toMulZeroClass.{u_3} G₀
                (@MonoidWithZero.toMulZeroOneClass.{u_3} G₀ (@GroupWithZero.toMonoidWithZero.{u_3} G₀ inst)))))
          a c)
        b)
      (@LT.lt.{u_3} G₀ (@Preorder.toLT.{u_3} G₀ (@PartialOrder.toPreorder.{u_3} G₀ inst_1)) a
        (@HDiv.hDiv.{u_3, u_3, u_3} G₀ G₀ G₀
          (@instHDiv.{u_3} G₀ (@DivInvMonoid.toDiv.{u_3} G₀ (@GroupWithZero.toDivInvMonoid.{u_3} G₀ inst))) b c)) :=
⋯
```

## `_private.BrownianMotion.Continuity.KolmogorovChentsovInequality.0.ProbabilityTheory.countable_kolmogorov_chentsov._simp_1_1`

Command: `#print _private.BrownianMotion.Continuity.KolmogorovChentsovInequality.0.ProbabilityTheory.countable_kolmogorov_chentsov._simp_1_1`

```lean
private theorem ProbabilityTheory.countable_kolmogorov_chentsov._simp_1_1.{u_1, u_2, u_3} : ∀ {α : Type u_1}
  {β : Type u_2} {γ : Type u_3} [inst : CompleteLattice.{u_1} α] {f : β → γ → α} {s : Set.{u_2} β} {t : Set.{u_3} γ},
  @Eq.{u_1 + 1} α
    (⨆ a,
      ⨆ (_ : @Membership.mem.{u_2, u_2} β (Set.{u_2} β) (@Set.instMembership.{u_2} β) s a),
        ⨆ b, ⨆ (_ : @Membership.mem.{u_3, u_3} γ (Set.{u_3} γ) (@Set.instMembership.{u_3} γ) t b), f a b)
    (⨆ x,
      ⨆ (_ :
        @Membership.mem.{max u_2 u_3, max u_2 u_3} (Prod.{u_2, u_3} β γ) (Set.{max u_3 u_2} (Prod.{u_2, u_3} β γ))
          (@Set.instMembership.{max u_2 u_3} (Prod.{u_2, u_3} β γ))
          (@SProd.sprod.{u_2, u_3, max u_2 u_3} (Set.{u_2} β) (Set.{u_3} γ) (Set.{max u_3 u_2} (Prod.{u_2, u_3} β γ))
            (@Set.instSProd.{u_2, u_3} β γ) s t)
          x),
        f (@Prod.fst.{u_2, u_3} β γ x) (@Prod.snd.{u_2, u_3} β γ x)) :=
⋯
```

## `_private.BrownianMotion.Continuity.KolmogorovChentsovInequality.0.ProbabilityTheory.countable_kolmogorov_chentsov._simp_1_2`

Command: `#print _private.BrownianMotion.Continuity.KolmogorovChentsovInequality.0.ProbabilityTheory.countable_kolmogorov_chentsov._simp_1_2`

```lean
private theorem ProbabilityTheory.countable_kolmogorov_chentsov._simp_1_2.{u, v} : ∀ {α : Type u} {ι : Sort v} {x : α}
  {s : ι → Set.{u} α},
  @Eq.{1} Prop (@Membership.mem.{u, u} α (Set.{u} α) (@Set.instMembership.{u} α) (⋃ i, s i) x)
    (∃ i, @Membership.mem.{u, u} α (Set.{u} α) (@Set.instMembership.{u} α) (s i) x) :=
⋯
```

## `_private.BrownianMotion.Continuity.KolmogorovChentsovInequality.0.ProbabilityTheory.countable_kolmogorov_chentsov._simp_1_3`

Command: `#print _private.BrownianMotion.Continuity.KolmogorovChentsovInequality.0.ProbabilityTheory.countable_kolmogorov_chentsov._simp_1_3`

```lean
private theorem ProbabilityTheory.countable_kolmogorov_chentsov._simp_1_3.{u_1, u_8} : ∀ {α : Type u_1}
  [inst : CompleteLattice.{u_1} α] {ι : Type u_8} (s : Set.{u_8} ι) (f : ι → α),
  @Eq.{u_1 + 1} α (⨆ t, ⨆ (_ : @Membership.mem.{u_8, u_8} ι (Set.{u_8} ι) (@Set.instMembership.{u_8} ι) s t), f t)
    (⨆ i,
      f
        (@Subtype.val.{u_8 + 1} ι
          (fun x => @Membership.mem.{u_8, u_8} ι (Set.{u_8} ι) (@Set.instMembership.{u_8} ι) s x) i)) :=
⋯
```

## `_private.BrownianMotion.Continuity.KolmogorovChentsovInequality.0.ProbabilityTheory.finite_kolmogorov_chentsov._simp_1_13`

Command: `#print _private.BrownianMotion.Continuity.KolmogorovChentsovInequality.0.ProbabilityTheory.finite_kolmogorov_chentsov._simp_1_13`

```lean
private theorem ProbabilityTheory.finite_kolmogorov_chentsov._simp_1_13 : ∀ (x : ENNReal) (z : Real),
  @Eq.{1} Real
    (@HPow.hPow.{0, 0, 0} ENNReal Real ENNReal (@instHPow.{0, 0} ENNReal Real ENNReal.instPowReal) x z).toReal
    (@HPow.hPow.{0, 0, 0} Real Real Real (@instHPow.{0, 0} Real Real Real.instPow) x.toReal z) :=
⋯
```

## `_private.BrownianMotion.Continuity.KolmogorovChentsovInequality.0.ProbabilityTheory.finite_kolmogorov_chentsov._simp_1_14`

Command: `#print _private.BrownianMotion.Continuity.KolmogorovChentsovInequality.0.ProbabilityTheory.finite_kolmogorov_chentsov._simp_1_14`

```lean
private theorem ProbabilityTheory.finite_kolmogorov_chentsov._simp_1_14 : ∀ {a : ENNReal},
  @Eq.{1} Prop
    (@LT.lt.{0} NNReal (@Preorder.toLT.{0} NNReal (@PartialOrder.toPreorder.{0} NNReal NNReal.instPartialOrder))
      (@OfNat.ofNat.{0} NNReal (nat_lit 0) (@Zero.toOfNat0.{0} NNReal NNReal.instZero)) a.toNNReal)
    (And
      (@LT.lt.{0} ENNReal (@Preorder.toLT.{0} ENNReal (@PartialOrder.toPreorder.{0} ENNReal ENNReal.instPartialOrder))
        (@OfNat.ofNat.{0} ENNReal (nat_lit 0) (@Zero.toOfNat0.{0} ENNReal ENNReal.instZero)) a)
      (@LT.lt.{0} ENNReal (@Preorder.toLT.{0} ENNReal (@PartialOrder.toPreorder.{0} ENNReal ENNReal.instPartialOrder)) a
        (@Top.top.{0} ENNReal ENNReal.instTop))) :=
⋯
```

## `_private.BrownianMotion.Continuity.KolmogorovChentsovInequality.0.ProbabilityTheory.finite_kolmogorov_chentsov._simp_1_15`

Command: `#print _private.BrownianMotion.Continuity.KolmogorovChentsovInequality.0.ProbabilityTheory.finite_kolmogorov_chentsov._simp_1_15`

```lean
private theorem ProbabilityTheory.finite_kolmogorov_chentsov._simp_1_15 : ∀ {r : NNReal},
  @Eq.{1} Prop
    (@LE.le.{0} Real Real.instLE (@OfNat.ofNat.{0} Real (nat_lit 1) (@One.toOfNat1.{0} Real Real.instOne)) ↑r)
    (@LE.le.{0} NNReal (@Preorder.toLE.{0} NNReal (@PartialOrder.toPreorder.{0} NNReal NNReal.instPartialOrder))
      (@OfNat.ofNat.{0} NNReal (nat_lit 1) (@One.toOfNat1.{0} NNReal NNReal.instOne)) r) :=
⋯
```

## `_private.BrownianMotion.Continuity.KolmogorovChentsovInequality.0.ProbabilityTheory.finite_kolmogorov_chentsov._simp_1_2`

Command: `#print _private.BrownianMotion.Continuity.KolmogorovChentsovInequality.0.ProbabilityTheory.finite_kolmogorov_chentsov._simp_1_2`

```lean
private theorem ProbabilityTheory.finite_kolmogorov_chentsov._simp_1_2.{u_1} : ∀ {α : Type u_1} {a : ENNReal}
  {f : α → ENNReal},
  @Eq.{1} ENNReal
    (@HMul.hMul.{0, 0, 0} ENNReal ENNReal ENNReal
      (@instHMul.{0} ENNReal
        (@Distrib.toMul.{0} ENNReal
          (@instDistribOfSemiring.{0} ENNReal (@CommSemiring.toSemiring.{0} ENNReal ENNReal.instCommSemiring))))
      a
      (@tsum.{0, u_1} ENNReal α ENNReal.instAddCommMonoid ENNReal.instTopologicalSpace (fun i => f i)
        (SummationFilter.unconditional.{u_1} α)))
    (@tsum.{0, u_1} ENNReal α ENNReal.instAddCommMonoid ENNReal.instTopologicalSpace
      (fun i =>
        @HMul.hMul.{0, 0, 0} ENNReal ENNReal ENNReal
          (@instHMul.{0} ENNReal
            (@Distrib.toMul.{0} ENNReal
              (@instDistribOfSemiring.{0} ENNReal (@CommSemiring.toSemiring.{0} ENNReal ENNReal.instCommSemiring))))
          a (f i))
      (SummationFilter.unconditional.{u_1} α)) :=
⋯
```

## `_private.BrownianMotion.Continuity.KolmogorovChentsovInequality.0.ProbabilityTheory.finite_kolmogorov_chentsov._simp_1_3`

Command: `#print _private.BrownianMotion.Continuity.KolmogorovChentsovInequality.0.ProbabilityTheory.finite_kolmogorov_chentsov._simp_1_3`

```lean
private theorem ProbabilityTheory.finite_kolmogorov_chentsov._simp_1_3.{u_1} : ∀ {α : Type u_1} [inst : LE.{u_1} α]
  {x y : α}, @Eq.{1} Prop (@GE.ge.{u_1} α inst x y) (@LE.le.{u_1} α inst y x) :=
⋯
```

## `_private.BrownianMotion.Continuity.KolmogorovChentsovInequality.0.ProbabilityTheory.finite_kolmogorov_chentsov._simp_1_4`

Command: `#print _private.BrownianMotion.Continuity.KolmogorovChentsovInequality.0.ProbabilityTheory.finite_kolmogorov_chentsov._simp_1_4`

```lean
private theorem ProbabilityTheory.finite_kolmogorov_chentsov._simp_1_4 : ∀ {x : ENNReal} {y : Real},
  @Eq.{1} Prop
    (@Eq.{1} ENNReal (@HPow.hPow.{0, 0, 0} ENNReal Real ENNReal (@instHPow.{0, 0} ENNReal Real ENNReal.instPowReal) x y)
      (@OfNat.ofNat.{0} ENNReal (nat_lit 0) (@Zero.toOfNat0.{0} ENNReal ENNReal.instZero)))
    (Or
      (And (@Eq.{1} ENNReal x (@OfNat.ofNat.{0} ENNReal (nat_lit 0) (@Zero.toOfNat0.{0} ENNReal ENNReal.instZero)))
        (@LT.lt.{0} Real Real.instLT (@OfNat.ofNat.{0} Real (nat_lit 0) (@Zero.toOfNat0.{0} Real Real.instZero)) y))
      (And (@Eq.{1} ENNReal x (@Top.top.{0} ENNReal ENNReal.instTop))
        (@LT.lt.{0} Real Real.instLT y (@OfNat.ofNat.{0} Real (nat_lit 0) (@Zero.toOfNat0.{0} Real Real.instZero))))) :=
⋯
```

## `_private.BrownianMotion.Continuity.KolmogorovChentsovInequality.0.ProbabilityTheory.finite_kolmogorov_chentsov._simp_1_5`

Command: `#print _private.BrownianMotion.Continuity.KolmogorovChentsovInequality.0.ProbabilityTheory.finite_kolmogorov_chentsov._simp_1_5`

```lean
private theorem ProbabilityTheory.finite_kolmogorov_chentsov._simp_1_5.{u_1} : ∀ {R : Type u_1}
  [inst : AddMonoidWithOne.{u_1} R] [@CharZero.{u_1} R inst] (n : Nat) [inst_2 : n.AtLeastTwo],
  @Eq.{1} Prop
    (@Eq.{u_1 + 1} R
      (@OfNat.ofNat.{u_1} R n (@instOfNatAtLeastTwo.{u_1} R n (@AddMonoidWithOne.toNatCast.{u_1} R inst) inst_2))
      (@OfNat.ofNat.{u_1} R (nat_lit 0)
        (@Zero.toOfNat0.{u_1} R
          (@AddZero.toZero.{u_1} R
            (@AddZeroClass.toAddZero.{u_1} R
              (@AddMonoid.toAddZeroClass.{u_1} R (@AddMonoidWithOne.toAddMonoid.{u_1} R inst)))))))
    False :=
⋯
```

## `_private.BrownianMotion.Continuity.KolmogorovChentsovInequality.0.ProbabilityTheory.finite_kolmogorov_chentsov._simp_1_6`

Command: `#print _private.BrownianMotion.Continuity.KolmogorovChentsovInequality.0.ProbabilityTheory.finite_kolmogorov_chentsov._simp_1_6`

```lean
private theorem ProbabilityTheory.finite_kolmogorov_chentsov._simp_1_6 : ∀ {n : Nat} [inst : n.AtLeastTwo],
  @Eq.{1} Prop
    (@Eq.{1} ENNReal
      (@OfNat.ofNat.{0} ENNReal n
        (@instOfNatAtLeastTwo.{0} ENNReal n
          (@AddMonoidWithOne.toNatCast.{0} ENNReal
            (@AddCommMonoidWithOne.toAddMonoidWithOne.{0} ENNReal ENNReal.instAddCommMonoidWithOne))
          inst))
      (@Top.top.{0} ENNReal ENNReal.instTop))
    False :=
⋯
```

## `_private.BrownianMotion.Continuity.KolmogorovChentsovInequality.0.ProbabilityTheory.finite_kolmogorov_chentsov._simp_1_8`

Command: `#print _private.BrownianMotion.Continuity.KolmogorovChentsovInequality.0.ProbabilityTheory.finite_kolmogorov_chentsov._simp_1_8`

```lean
private theorem ProbabilityTheory.finite_kolmogorov_chentsov._simp_1_8 : ∀ (x : ENNReal),
  @Eq.{1} Prop
    (@Eq.{1} NNReal x.toNNReal (@OfNat.ofNat.{0} NNReal (nat_lit 0) (@Zero.toOfNat0.{0} NNReal NNReal.instZero)))
    (Or (@Eq.{1} ENNReal x (@OfNat.ofNat.{0} ENNReal (nat_lit 0) (@Zero.toOfNat0.{0} ENNReal ENNReal.instZero)))
      (@Eq.{1} ENNReal x (@Top.top.{0} ENNReal ENNReal.instTop))) :=
⋯
```

## `_private.BrownianMotion.Continuity.KolmogorovChentsovInequality.0.ProbabilityTheory.lintegral_div_edist_le_sum_integral_edist_le._proof_1_2`

Command: `#print _private.BrownianMotion.Continuity.KolmogorovChentsovInequality.0.ProbabilityTheory.lintegral_div_edist_le_sum_integral_edist_le._proof_1_2`

```lean
private theorem ProbabilityTheory.lintegral_div_edist_le_sum_integral_edist_le._proof_1_2.{u_1} : ∀ {T : Type u_1}
  {U : Set.{u_1} T} [inst : PseudoEMetricSpace.{u_1} T] (k : Nat),
  @Eq.{1} ENNReal
    (@HMul.hMul.{0, 0, 0} ENNReal ENNReal ENNReal
      (@instHMul.{0} ENNReal
        (@CommMagma.toMul.{0} ENNReal
          (@NonUnitalNonAssocCommSemiring.toCommMagma.{0} ENNReal
            (@NonUnitalCommSemiring.toNonUnitalNonAssocCommSemiring.{0} ENNReal
              (@CommSemiring.toNonUnitalCommSemiring.{0} ENNReal ENNReal.instCommSemiring)))))
      (@HAdd.hAdd.{0, 0, 0} ENNReal ENNReal ENNReal (@instHAdd.{0} ENNReal ENNReal.instAdd)
        (@Metric.ediam.{u_1} T inst U)
        (@OfNat.ofNat.{0} ENNReal (nat_lit 1) (@One.toOfNat1.{0} ENNReal ENNReal.instOne)))
      (@HMul.hMul.{0, 0, 0} ENNReal ENNReal ENNReal
        (@instHMul.{0} ENNReal
          (@CommMagma.toMul.{0} ENNReal
            (@NonUnitalNonAssocCommSemiring.toCommMagma.{0} ENNReal
              (@NonUnitalCommSemiring.toNonUnitalNonAssocCommSemiring.{0} ENNReal
                (@CommSemiring.toNonUnitalCommSemiring.{0} ENNReal ENNReal.instCommSemiring)))))
        (@Inv.inv.{0} ENNReal ENNReal.instInv
          (@OfNat.ofNat.{0} ENNReal (nat_lit 2)
            (@instOfNatAtLeastTwo.{0} ENNReal (nat_lit 2)
              (@AddMonoidWithOne.toNatCast.{0} ENNReal
                (@AddCommMonoidWithOne.toAddMonoidWithOne.{0} ENNReal ENNReal.instAddCommMonoidWithOne))
              ⋯)))
        (@HPow.hPow.{0, 0, 0} ENNReal Nat ENNReal
          (@instHPow.{0, 0} ENNReal Nat
            (@NPow.toPow.{0} ENNReal
              (@Monoid.toNPow.{0} ENNReal
                (@Semiring.toMonoid.{0} ENNReal (@CommSemiring.toSemiring.{0} ENNReal ENNReal.instCommSemiring)))))
          (@Inv.inv.{0} ENNReal ENNReal.instInv
            (@OfNat.ofNat.{0} ENNReal (nat_lit 2)
              (@instOfNatAtLeastTwo.{0} ENNReal (nat_lit 2)
                (@AddMonoidWithOne.toNatCast.{0} ENNReal
                  (@AddCommMonoidWithOne.toAddMonoidWithOne.{0} ENNReal ENNReal.instAddCommMonoidWithOne))
                ⋯)))
          k)))
    (@HMul.hMul.{0, 0, 0} ENNReal ENNReal ENNReal
      (@instHMul.{0} ENNReal
        (@Distrib.toMul.{0} ENNReal
          (@instDistribOfSemiring.{0} ENNReal (@CommSemiring.toSemiring.{0} ENNReal ENNReal.instCommSemiring))))
      (@Inv.inv.{0} ENNReal ENNReal.instInv
        (@OfNat.ofNat.{0} ENNReal (nat_lit 2)
          (@instOfNatAtLeastTwo.{0} ENNReal (nat_lit 2)
            (@AddMonoidWithOne.toNatCast.{0} ENNReal
              (@AddCommMonoidWithOne.toAddMonoidWithOne.{0} ENNReal ENNReal.instAddCommMonoidWithOne))
            ⋯)))
      (@HMul.hMul.{0, 0, 0} ENNReal ENNReal ENNReal
        (@instHMul.{0} ENNReal
          (@CommMagma.toMul.{0} ENNReal
            (@NonUnitalNonAssocCommSemiring.toCommMagma.{0} ENNReal
              (@NonUnitalCommSemiring.toNonUnitalNonAssocCommSemiring.{0} ENNReal
                (@CommSemiring.toNonUnitalCommSemiring.{0} ENNReal ENNReal.instCommSemiring)))))
        (@HAdd.hAdd.{0, 0, 0} ENNReal ENNReal ENNReal (@instHAdd.{0} ENNReal ENNReal.instAdd)
          (@Metric.ediam.{u_1} T inst U)
          (@OfNat.ofNat.{0} ENNReal (nat_lit 1) (@One.toOfNat1.{0} ENNReal ENNReal.instOne)))
        (@HPow.hPow.{0, 0, 0} ENNReal Nat ENNReal
          (@instHPow.{0, 0} ENNReal Nat
            (@NPow.toPow.{0} ENNReal
              (@Monoid.toNPow.{0} ENNReal
                (@Semiring.toMonoid.{0} ENNReal (@CommSemiring.toSemiring.{0} ENNReal ENNReal.instCommSemiring)))))
          (@Inv.inv.{0} ENNReal ENNReal.instInv
            (@OfNat.ofNat.{0} ENNReal (nat_lit 2)
              (@instOfNatAtLeastTwo.{0} ENNReal (nat_lit 2)
                (@AddMonoidWithOne.toNatCast.{0} ENNReal
                  (@AddCommMonoidWithOne.toAddMonoidWithOne.{0} ENNReal ENNReal.instAddCommMonoidWithOne))
                ⋯)))
          k))) :=
⋯
```

## `_private.BrownianMotion.Continuity.KolmogorovChentsovInequality.0.ProbabilityTheory.lintegral_div_edist_le_sum_integral_edist_le._simp_1_3`

Command: `#print _private.BrownianMotion.Continuity.KolmogorovChentsovInequality.0.ProbabilityTheory.lintegral_div_edist_le_sum_integral_edist_le._simp_1_3`

```lean
private theorem ProbabilityTheory.lintegral_div_edist_le_sum_integral_edist_le._simp_1_3.{u} : ∀ {α : Type u}
  [inst : PartialOrder.{u} α] [inst_1 : @OrderTop.{u} α (@Preorder.toLE.{u} α (@PartialOrder.toPreorder.{u} α inst))]
  {a : α},
  @Eq.{1} Prop
    (@Ne.{u + 1} α a
      (@Top.top.{u} α (@OrderTop.toTop.{u} α (@Preorder.toLE.{u} α (@PartialOrder.toPreorder.{u} α inst)) inst_1)))
    (@LT.lt.{u} α (@Preorder.toLT.{u} α (@PartialOrder.toPreorder.{u} α inst)) a
      (@Top.top.{u} α (@OrderTop.toTop.{u} α (@Preorder.toLE.{u} α (@PartialOrder.toPreorder.{u} α inst)) inst_1))) :=
⋯
```

## `_private.BrownianMotion.Continuity.KolmogorovChentsovInequality.0.ProbabilityTheory.lintegral_div_edist_le_sum_integral_edist_le.match_1_4`

Command: `#print _private.BrownianMotion.Continuity.KolmogorovChentsovInequality.0.ProbabilityTheory.lintegral_div_edist_le_sum_integral_edist_le.match_1_4`

```lean
private def ProbabilityTheory.lintegral_div_edist_le_sum_integral_edist_le.match_1_4.{u_1} : ∀ {T : Type u_1}
  {J : Set.{u_1} T} (motive : @Set.Elem.{u_1} T J → Prop) (h : @Set.Elem.{u_1} T J),
  (∀ (t : T) (ht : @Membership.mem.{u_1, u_1} T (Set.{u_1} T) (@Set.instMembership.{u_1} T) J t),
      motive
        (@Subtype.mk.{u_1 + 1} T (fun x => @Membership.mem.{u_1, u_1} T (Set.{u_1} T) (@Set.instMembership.{u_1} T) J x)
          t ht)) →
    motive h :=
⋯
```

## `_private.BrownianMotion.Continuity.KolmogorovChentsovInequality.0.ProbabilityTheory.lintegral_div_edist_le_sum_integral_edist_le.match_1_6`

Command: `#print _private.BrownianMotion.Continuity.KolmogorovChentsovInequality.0.ProbabilityTheory.lintegral_div_edist_le_sum_integral_edist_le.match_1_6`

```lean
private def ProbabilityTheory.lintegral_div_edist_le_sum_integral_edist_le.match_1_6 : ∀ (motive : Nat → Prop)
  (x : Nat),
  (@Eq.{1} Nat x (@OfNat.ofNat.{0} Nat (nat_lit 0) (instOfNatNat (nat_lit 0))) →
      motive (@OfNat.ofNat.{0} Nat (nat_lit 0) (instOfNatNat (nat_lit 0)))) →
    (∀ (k : Nat), @Eq.{1} Nat x k.succ → motive k.succ) → motive x :=
⋯
```

## `_private.BrownianMotion.Continuity.LimitModification.0.Measurable.of_edist_eq_zero._simp_1_1`

Command: `#print _private.BrownianMotion.Continuity.LimitModification.0.Measurable.of_edist_eq_zero._simp_1_1`

```lean
private theorem Measurable.of_edist_eq_zero._simp_1_1.{u, v} : ∀ {α : Type u} {β : Type v} {f : α → β} {s : Set.{v} β}
  {a : α},
  @Eq.{1} Prop (@Membership.mem.{u, u} α (Set.{u} α) (@Set.instMembership.{u} α) (@Set.preimage.{u, v} α β f s) a)
    (@Membership.mem.{v, v} β (Set.{v} β) (@Set.instMembership.{v} β) s (f a)) :=
⋯
```

## `_private.BrownianMotion.Gaussian.Moment.0.ProbabilityTheory.centralMoment_two_mul_gaussianReal._proof_1_27`

Command: `#print _private.BrownianMotion.Gaussian.Moment.0.ProbabilityTheory.centralMoment_two_mul_gaussianReal._proof_1_27`

```lean
private theorem ProbabilityTheory.centralMoment_two_mul_gaussianReal._proof_1_27 : ∀ (n : Nat),
  Not (@Eq.{1} Nat n (@OfNat.ofNat.{0} Nat (nat_lit 0) (instOfNatNat (nat_lit 0)))) →
    Not (@LE.le.{0} Nat instLENat (@OfNat.ofNat.{0} Nat (nat_lit 1) (instOfNatNat (nat_lit 1))) n) → False :=
⋯
```

## `_private.BrownianMotion.Gaussian.Moment.0.ProbabilityTheory.centralMoment_two_mul_gaussianReal._simp_1_1`

Command: `#print _private.BrownianMotion.Gaussian.Moment.0.ProbabilityTheory.centralMoment_two_mul_gaussianReal._simp_1_1`

```lean
private theorem ProbabilityTheory.centralMoment_two_mul_gaussianReal._simp_1_1.{u_3} : ∀ {α : Type u_3}
  [inst : Semiring.{u_3} α] [inst_1 : PartialOrder.{u_3} α] [@IsOrderedRing.{u_3} α inst inst_1] (n : Nat)
  [inst_3 : n.AtLeastTwo],
  @Eq.{1} Prop
    (@LE.le.{u_3} α (@Preorder.toLE.{u_3} α (@PartialOrder.toPreorder.{u_3} α inst_1))
      (@OfNat.ofNat.{u_3} α (nat_lit 0)
        (@Zero.toOfNat0.{u_3} α (@MulZeroClass.toZero.{u_3} α (@instMulZeroClassOfSemiring.{u_3} α inst))))
      (@OfNat.ofNat.{u_3} α n
        (@instOfNatAtLeastTwo.{u_3} α n
          (@AddMonoidWithOne.toNatCast.{u_3} α
            (@AddCommMonoidWithOne.toAddMonoidWithOne.{u_3} α
              (@NonAssocSemiring.toAddCommMonoidWithOne.{u_3} α (@Semiring.toNonAssocSemiring.{u_3} α inst))))
          inst_3)))
    True :=
⋯
```

## `_private.BrownianMotion.Gaussian.Moment.0.ProbabilityTheory.centralMoment_two_mul_gaussianReal._simp_1_10`

Command: `#print _private.BrownianMotion.Gaussian.Moment.0.ProbabilityTheory.centralMoment_two_mul_gaussianReal._simp_1_10`

```lean
private theorem ProbabilityTheory.centralMoment_two_mul_gaussianReal._simp_1_10.{u_1} : ∀ {M₀ : Type u_1}
  [inst : MulZeroClass.{u_1} M₀]
  [@IsLeftCancelMulZero.{u_1} M₀ (@MulZeroClass.toMul.{u_1} M₀ inst) (@MulZeroClass.toZero.{u_1} M₀ inst)] {a b c : M₀},
  @Eq.{1} Prop
    (@Eq.{u_1 + 1} M₀ (@HMul.hMul.{u_1, u_1, u_1} M₀ M₀ M₀ (@instHMul.{u_1} M₀ (@MulZeroClass.toMul.{u_1} M₀ inst)) a b)
      (@HMul.hMul.{u_1, u_1, u_1} M₀ M₀ M₀ (@instHMul.{u_1} M₀ (@MulZeroClass.toMul.{u_1} M₀ inst)) a c))
    (Or (@Eq.{u_1 + 1} M₀ b c)
      (@Eq.{u_1 + 1} M₀ a
        (@OfNat.ofNat.{u_1} M₀ (nat_lit 0) (@Zero.toOfNat0.{u_1} M₀ (@MulZeroClass.toZero.{u_1} M₀ inst))))) :=
⋯
```

## `_private.BrownianMotion.Gaussian.Moment.0.ProbabilityTheory.centralMoment_two_mul_gaussianReal._simp_1_11`

Command: `#print _private.BrownianMotion.Gaussian.Moment.0.ProbabilityTheory.centralMoment_two_mul_gaussianReal._simp_1_11`

```lean
private theorem ProbabilityTheory.centralMoment_two_mul_gaussianReal._simp_1_11 : ∀ {x : Real},
  @LE.le.{0} Real Real.instLE (@OfNat.ofNat.{0} Real (nat_lit 0) (@Zero.toOfNat0.{0} Real Real.instZero)) x →
    @Eq.{1} Prop (@Eq.{1} Real x.sqrt (@OfNat.ofNat.{0} Real (nat_lit 0) (@Zero.toOfNat0.{0} Real Real.instZero)))
      (@Eq.{1} Real x (@OfNat.ofNat.{0} Real (nat_lit 0) (@Zero.toOfNat0.{0} Real Real.instZero))) :=
⋯
```

## `_private.BrownianMotion.Gaussian.Moment.0.ProbabilityTheory.centralMoment_two_mul_gaussianReal._simp_1_12`

Command: `#print _private.BrownianMotion.Gaussian.Moment.0.ProbabilityTheory.centralMoment_two_mul_gaussianReal._simp_1_12`

```lean
private theorem ProbabilityTheory.centralMoment_two_mul_gaussianReal._simp_1_12.{u_1} : ∀ {R : Type u_1}
  [inst : AddMonoidWithOne.{u_1} R] [@CharZero.{u_1} R inst] (n : Nat) [inst_2 : n.AtLeastTwo],
  @Eq.{1} Prop
    (@Eq.{u_1 + 1} R
      (@OfNat.ofNat.{u_1} R n (@instOfNatAtLeastTwo.{u_1} R n (@AddMonoidWithOne.toNatCast.{u_1} R inst) inst_2))
      (@OfNat.ofNat.{u_1} R (nat_lit 0)
        (@Zero.toOfNat0.{u_1} R
          (@AddZero.toZero.{u_1} R
            (@AddZeroClass.toAddZero.{u_1} R
              (@AddMonoid.toAddZeroClass.{u_1} R (@AddMonoidWithOne.toAddMonoid.{u_1} R inst)))))))
    False :=
⋯
```

## `_private.BrownianMotion.Gaussian.Moment.0.ProbabilityTheory.centralMoment_two_mul_gaussianReal._simp_1_13`

Command: `#print _private.BrownianMotion.Gaussian.Moment.0.ProbabilityTheory.centralMoment_two_mul_gaussianReal._simp_1_13`

```lean
private theorem ProbabilityTheory.centralMoment_two_mul_gaussianReal._simp_1_13 : ∀ {r : NNReal},
  @Eq.{1} Prop (@Eq.{1} Real (↑r) (@OfNat.ofNat.{0} Real (nat_lit 0) (@Zero.toOfNat0.{0} Real Real.instZero)))
    (@Eq.{1} NNReal r (@OfNat.ofNat.{0} NNReal (nat_lit 0) (@Zero.toOfNat0.{0} NNReal NNReal.instZero))) :=
⋯
```

## `_private.BrownianMotion.Gaussian.Moment.0.ProbabilityTheory.centralMoment_two_mul_gaussianReal._simp_1_14`

Command: `#print _private.BrownianMotion.Gaussian.Moment.0.ProbabilityTheory.centralMoment_two_mul_gaussianReal._simp_1_14`

```lean
private theorem ProbabilityTheory.centralMoment_two_mul_gaussianReal._simp_1_14.{u_2} : ∀ {G₀ : Type u_2}
  [inst : GroupWithZero.{u_2} G₀] {a : G₀},
  @Eq.{1} Prop
    (@Eq.{u_2 + 1} G₀
      (@Inv.inv.{u_2} G₀
        (@InvOneClass.toInv.{u_2} G₀
          (@DivInvOneMonoid.toInvOneClass.{u_2} G₀
            (@DivisionMonoid.toDivInvOneMonoid.{u_2} G₀ (@GroupWithZero.toDivisionMonoid.{u_2} G₀ inst))))
        a)
      (@OfNat.ofNat.{u_2} G₀ (nat_lit 0)
        (@Zero.toOfNat0.{u_2} G₀
          (@MulZeroClass.toZero.{u_2} G₀
            (@MulZeroOneClass.toMulZeroClass.{u_2} G₀
              (@MonoidWithZero.toMulZeroOneClass.{u_2} G₀ (@GroupWithZero.toMonoidWithZero.{u_2} G₀ inst)))))))
    (@Eq.{u_2 + 1} G₀ a
      (@OfNat.ofNat.{u_2} G₀ (nat_lit 0)
        (@Zero.toOfNat0.{u_2} G₀
          (@MulZeroClass.toZero.{u_2} G₀
            (@MulZeroOneClass.toMulZeroClass.{u_2} G₀
              (@MonoidWithZero.toMulZeroOneClass.{u_2} G₀ (@GroupWithZero.toMonoidWithZero.{u_2} G₀ inst))))))) :=
⋯
```

## `_private.BrownianMotion.Gaussian.Moment.0.ProbabilityTheory.centralMoment_two_mul_gaussianReal._simp_1_15`

Command: `#print _private.BrownianMotion.Gaussian.Moment.0.ProbabilityTheory.centralMoment_two_mul_gaussianReal._simp_1_15`

```lean
private theorem ProbabilityTheory.centralMoment_two_mul_gaussianReal._simp_1_15.{u_1} : ∀ {M₀ : Type u_1}
  [inst : MonoidWithZero.{u_1} M₀] {a : M₀} {n : Nat}
  [@IsReduced.{u_1} M₀
      (@MulZeroClass.toZero.{u_1} M₀
        (@MulZeroOneClass.toMulZeroClass.{u_1} M₀ (@MonoidWithZero.toMulZeroOneClass.{u_1} M₀ inst)))
      (@NPow.toPow.{u_1} M₀ (@Monoid.toNPow.{u_1} M₀ (@MonoidWithZero.toMonoid.{u_1} M₀ inst)))],
  @Ne.{1} Nat n (@OfNat.ofNat.{0} Nat (nat_lit 0) (instOfNatNat (nat_lit 0))) →
    @Eq.{1} Prop
      (@Eq.{u_1 + 1} M₀
        (@HPow.hPow.{u_1, 0, u_1} M₀ Nat M₀
          (@instHPow.{u_1, 0} M₀ Nat
            (@NPow.toPow.{u_1} M₀ (@Monoid.toNPow.{u_1} M₀ (@MonoidWithZero.toMonoid.{u_1} M₀ inst))))
          a n)
        (@OfNat.ofNat.{u_1} M₀ (nat_lit 0)
          (@Zero.toOfNat0.{u_1} M₀
            (@MulZeroClass.toZero.{u_1} M₀
              (@MulZeroOneClass.toMulZeroClass.{u_1} M₀ (@MonoidWithZero.toMulZeroOneClass.{u_1} M₀ inst))))))
      (@Eq.{u_1 + 1} M₀ a
        (@OfNat.ofNat.{u_1} M₀ (nat_lit 0)
          (@Zero.toOfNat0.{u_1} M₀
            (@MulZeroClass.toZero.{u_1} M₀
              (@MulZeroOneClass.toMulZeroClass.{u_1} M₀ (@MonoidWithZero.toMulZeroOneClass.{u_1} M₀ inst)))))) :=
⋯
```

## `_private.BrownianMotion.Gaussian.Moment.0.ProbabilityTheory.centralMoment_two_mul_gaussianReal._simp_1_16`

Command: `#print _private.BrownianMotion.Gaussian.Moment.0.ProbabilityTheory.centralMoment_two_mul_gaussianReal._simp_1_16`

```lean
private theorem ProbabilityTheory.centralMoment_two_mul_gaussianReal._simp_1_16.{u_1} : ∀ {M₀ : Type u_1}
  [inst : MulZeroClass.{u_1} M₀]
  [@IsRightCancelMulZero.{u_1} M₀ (@MulZeroClass.toMul.{u_1} M₀ inst) (@MulZeroClass.toZero.{u_1} M₀ inst)]
  {a b c : M₀},
  @Eq.{1} Prop
    (@Eq.{u_1 + 1} M₀ (@HMul.hMul.{u_1, u_1, u_1} M₀ M₀ M₀ (@instHMul.{u_1} M₀ (@MulZeroClass.toMul.{u_1} M₀ inst)) a c)
      (@HMul.hMul.{u_1, u_1, u_1} M₀ M₀ M₀ (@instHMul.{u_1} M₀ (@MulZeroClass.toMul.{u_1} M₀ inst)) b c))
    (Or (@Eq.{u_1 + 1} M₀ a b)
      (@Eq.{u_1 + 1} M₀ c
        (@OfNat.ofNat.{u_1} M₀ (nat_lit 0) (@Zero.toOfNat0.{u_1} M₀ (@MulZeroClass.toZero.{u_1} M₀ inst))))) :=
⋯
```

## `_private.BrownianMotion.Gaussian.Moment.0.ProbabilityTheory.centralMoment_two_mul_gaussianReal._simp_1_17`

Command: `#print _private.BrownianMotion.Gaussian.Moment.0.ProbabilityTheory.centralMoment_two_mul_gaussianReal._simp_1_17`

```lean
private theorem ProbabilityTheory.centralMoment_two_mul_gaussianReal._simp_1_17 : ∀ (x : Real),
  @Eq.{1} Prop (@Eq.{1} Real (Real.exp x) (@OfNat.ofNat.{0} Real (nat_lit 0) (@Zero.toOfNat0.{0} Real Real.instZero)))
    False :=
⋯
```

## `_private.BrownianMotion.Gaussian.Moment.0.ProbabilityTheory.centralMoment_two_mul_gaussianReal._simp_1_19`

Command: `#print _private.BrownianMotion.Gaussian.Moment.0.ProbabilityTheory.centralMoment_two_mul_gaussianReal._simp_1_19`

```lean
private theorem ProbabilityTheory.centralMoment_two_mul_gaussianReal._simp_1_19.{u_1} : ∀ {G : Type u_1}
  [inst : DivInvMonoid.{u_1} G] (a : G) (n : Nat),
  @Eq.{u_1 + 1} G
    (@HPow.hPow.{u_1, 0, u_1} G Nat G
      (@instHPow.{u_1, 0} G Nat (@NPow.toPow.{u_1} G (@Monoid.toNPow.{u_1} G (@DivInvMonoid.toMonoid.{u_1} G inst)))) a
      n)
    (@HPow.hPow.{u_1, 0, u_1} G Int G
      (@instHPow.{u_1, 0} G Int (@ZPow.toPow.{u_1} G (@DivInvMonoid.toZPow.{u_1} G inst))) a
      (@Nat.cast.{0} Int instNatCastInt n)) :=
⋯
```

## `_private.BrownianMotion.Gaussian.Moment.0.ProbabilityTheory.centralMoment_two_mul_gaussianReal._simp_1_2`

Command: `#print _private.BrownianMotion.Gaussian.Moment.0.ProbabilityTheory.centralMoment_two_mul_gaussianReal._simp_1_2`

```lean
private theorem ProbabilityTheory.centralMoment_two_mul_gaussianReal._simp_1_2.{u, v} : ∀ {α : Type u} {β : Type v}
  (f : α → β) (s : Set.{u} α) (y : β),
  @Eq.{1} Prop (@Membership.mem.{v, v} β (Set.{v} β) (@Set.instMembership.{v} β) (@Set.image.{u, v} α β f s) y)
    (∃ x, And (@Membership.mem.{u, u} α (Set.{u} α) (@Set.instMembership.{u} α) s x) (@Eq.{v + 1} β (f x) y)) :=
⋯
```

## `_private.BrownianMotion.Gaussian.Moment.0.ProbabilityTheory.centralMoment_two_mul_gaussianReal._simp_1_21`

Command: `#print _private.BrownianMotion.Gaussian.Moment.0.ProbabilityTheory.centralMoment_two_mul_gaussianReal._simp_1_21`

```lean
private theorem ProbabilityTheory.centralMoment_two_mul_gaussianReal._simp_1_21.{u_1} : ∀ {G : Type u_1}
  [inst : Semigroup.{u_1} G] (a b c : G),
  @Eq.{u_1 + 1} G
    (@HMul.hMul.{u_1, u_1, u_1} G G G (@instHMul.{u_1} G (@Semigroup.toMul.{u_1} G inst)) a
      (@HMul.hMul.{u_1, u_1, u_1} G G G (@instHMul.{u_1} G (@Semigroup.toMul.{u_1} G inst)) b c))
    (@HMul.hMul.{u_1, u_1, u_1} G G G (@instHMul.{u_1} G (@Semigroup.toMul.{u_1} G inst))
      (@HMul.hMul.{u_1, u_1, u_1} G G G (@instHMul.{u_1} G (@Semigroup.toMul.{u_1} G inst)) a b) c) :=
⋯
```

## `_private.BrownianMotion.Gaussian.Moment.0.ProbabilityTheory.centralMoment_two_mul_gaussianReal._simp_1_25`

Command: `#print _private.BrownianMotion.Gaussian.Moment.0.ProbabilityTheory.centralMoment_two_mul_gaussianReal._simp_1_25`

```lean
private theorem ProbabilityTheory.centralMoment_two_mul_gaussianReal._simp_1_25.{u_1, u_6} : ∀ {α : Type u_1}
  {m : MeasurableSpace.{u_1} α} {μ : @MeasureTheory.Measure.{u_1} α m} {L : Type u_6} [inst : RCLike.{u_6} L] (r : L)
  (f : α → L),
  @Eq.{u_6 + 1} L
    (@HMul.hMul.{u_6, u_6, u_6} L L L
      (@instHMul.{u_6} L
        (@Distrib.toMul.{u_6} L
          (@instDistribOfSemiring.{u_6} L
            (@DivisionSemiring.toSemiring.{u_6} L
              (@Semifield.toDivisionSemiring.{u_6} L
                (@Field.toSemifield.{u_6} L
                  (@NormedField.toField.{u_6} L
                    (@DenselyNormedField.toNormedField.{u_6} L (@RCLike.toDenselyNormedField.{u_6} L inst)))))))))
      r
      (@MeasureTheory.integral.{u_1, u_6} α L
        (@NonUnitalNormedRing.toNormedAddCommGroup.{u_6} L
          (@NonUnitalNormedCommRing.toNonUnitalNormedRing.{u_6} L
            (@NormedCommRing.toNonUnitalNormedCommRing.{u_6} L
              (@NormedField.toNormedCommRing.{u_6} L
                (@DenselyNormedField.toNormedField.{u_6} L (@RCLike.toDenselyNormedField.{u_6} L inst))))))
        (@NormedAlgebra.toNormedSpace.{0, u_6} Real L Real.normedField
          (@SeminormedCommRing.toSeminormedRing.{u_6} L
            (@NormedCommRing.toSeminormedCommRing.{u_6} L
              (@NormedField.toNormedCommRing.{u_6} L
                (@DenselyNormedField.toNormedField.{u_6} L (@RCLike.toDenselyNormedField.{u_6} L inst)))))
          (@RCLike.toNormedAlgebra.{u_6} L inst))
        m μ fun a => f a))
    (@MeasureTheory.integral.{u_1, u_6} α L
      (@NonUnitalNormedRing.toNormedAddCommGroup.{u_6} L
        (@NonUnitalNormedCommRing.toNonUnitalNormedRing.{u_6} L
          (@NormedCommRing.toNonUnitalNormedCommRing.{u_6} L
            (@NormedField.toNormedCommRing.{u_6} L
              (@DenselyNormedField.toNormedField.{u_6} L (@RCLike.toDenselyNormedField.{u_6} L inst))))))
      (@NormedAlgebra.toNormedSpace.{0, u_6} Real L Real.normedField
        (@SeminormedCommRing.toSeminormedRing.{u_6} L
          (@NormedCommRing.toSeminormedCommRing.{u_6} L
            (@NormedField.toNormedCommRing.{u_6} L
              (@DenselyNormedField.toNormedField.{u_6} L (@RCLike.toDenselyNormedField.{u_6} L inst)))))
        (@RCLike.toNormedAlgebra.{u_6} L inst))
      m μ fun a =>
      @HMul.hMul.{u_6, u_6, u_6} L L L
        (@instHMul.{u_6} L
          (@Distrib.toMul.{u_6} L
            (@instDistribOfSemiring.{u_6} L
              (@DivisionSemiring.toSemiring.{u_6} L
                (@Semifield.toDivisionSemiring.{u_6} L
                  (@Field.toSemifield.{u_6} L
                    (@NormedField.toField.{u_6} L
                      (@DenselyNormedField.toNormedField.{u_6} L (@RCLike.toDenselyNormedField.{u_6} L inst)))))))))
        r (f a)) :=
⋯
```

## `_private.BrownianMotion.Gaussian.Moment.0.ProbabilityTheory.centralMoment_two_mul_gaussianReal._simp_1_26`

Command: `#print _private.BrownianMotion.Gaussian.Moment.0.ProbabilityTheory.centralMoment_two_mul_gaussianReal._simp_1_26`

```lean
private theorem ProbabilityTheory.centralMoment_two_mul_gaussianReal._simp_1_26.{u} : ∀ {α : Type u}
  [inst : AddGroup.{u} α] [inst_1 : LE.{u} α]
  [@AddRightMono.{u} α
      (@AddZero.toAdd.{u} α
        (@AddZeroClass.toAddZero.{u} α
          (@AddMonoid.toAddZeroClass.{u} α (@SubNegMonoid.toAddMonoid.{u} α (@AddGroup.toSubNegMonoid.{u} α inst)))))
      inst_1]
  {a b : α},
  @Eq.{1} Prop
    (@LE.le.{u} α inst_1
      (@OfNat.ofNat.{u} α (nat_lit 0)
        (@Zero.toOfNat0.{u} α
          (@NegZeroClass.toZero.{u} α
            (@SubNegZeroMonoid.toNegZeroClass.{u} α
              (@SubtractionMonoid.toSubNegZeroMonoid.{u} α (@AddGroup.toSubtractionMonoid.{u} α inst))))))
      (@HSub.hSub.{u, u, u} α α α (@instHSub.{u} α (@SubNegMonoid.toSub.{u} α (@AddGroup.toSubNegMonoid.{u} α inst))) a
        b))
    (@LE.le.{u} α inst_1 b a) :=
⋯
```

## `_private.BrownianMotion.Gaussian.Moment.0.ProbabilityTheory.centralMoment_two_mul_gaussianReal._simp_1_3`

Command: `#print _private.BrownianMotion.Gaussian.Moment.0.ProbabilityTheory.centralMoment_two_mul_gaussianReal._simp_1_3`

```lean
private theorem ProbabilityTheory.centralMoment_two_mul_gaussianReal._simp_1_3.{u_1} : ∀ {α : Type u_1}
  [inst : Preorder.{u_1} α] {b x : α},
  @Eq.{1} Prop (@Membership.mem.{u_1, u_1} α (Set.{u_1} α) (@Set.instMembership.{u_1} α) (@Set.Ioi.{u_1} α inst b) x)
    (@LT.lt.{u_1} α (@Preorder.toLT.{u_1} α inst) b x) :=
⋯
```

## `_private.BrownianMotion.Gaussian.Moment.0.ProbabilityTheory.centralMoment_two_mul_gaussianReal._simp_1_4`

Command: `#print _private.BrownianMotion.Gaussian.Moment.0.ProbabilityTheory.centralMoment_two_mul_gaussianReal._simp_1_4`

```lean
private theorem ProbabilityTheory.centralMoment_two_mul_gaussianReal._simp_1_4.{u_3} : ∀ {α : Type u_3}
  [inst : Semiring.{u_3} α] [inst_1 : PartialOrder.{u_3} α] [@IsOrderedRing.{u_3} α inst inst_1] [Nontrivial.{u_3} α]
  {n : Nat} [inst_4 : n.AtLeastTwo],
  @Eq.{1} Prop
    (@LT.lt.{u_3} α (@Preorder.toLT.{u_3} α (@PartialOrder.toPreorder.{u_3} α inst_1))
      (@OfNat.ofNat.{u_3} α (nat_lit 0)
        (@Zero.toOfNat0.{u_3} α (@MulZeroClass.toZero.{u_3} α (@instMulZeroClassOfSemiring.{u_3} α inst))))
      (@OfNat.ofNat.{u_3} α n
        (@instOfNatAtLeastTwo.{u_3} α n
          (@AddMonoidWithOne.toNatCast.{u_3} α
            (@AddCommMonoidWithOne.toAddMonoidWithOne.{u_3} α
              (@NonAssocSemiring.toAddCommMonoidWithOne.{u_3} α (@Semiring.toNonAssocSemiring.{u_3} α inst))))
          inst_4)))
    True :=
⋯
```

## `_private.BrownianMotion.Gaussian.Moment.0.ProbabilityTheory.centralMoment_two_mul_gaussianReal._simp_1_5`

Command: `#print _private.BrownianMotion.Gaussian.Moment.0.ProbabilityTheory.centralMoment_two_mul_gaussianReal._simp_1_5`

```lean
private theorem ProbabilityTheory.centralMoment_two_mul_gaussianReal._simp_1_5.{u} : ∀ {R : Type u}
  [inst : Semiring.{u} R] [inst_1 : LinearOrder.{u} R] {b c : R}
  [@PosMulStrictMono.{u} R (@Distrib.toMul.{u} R (@instDistribOfSemiring.{u} R inst))
      (@MulZeroClass.toZero.{u} R (@instMulZeroClassOfSemiring.{u} R inst))
      (@PartialOrder.toPreorder.{u} R
        (@SemilatticeInf.toPartialOrder.{u} R
          (@Lattice.toSemilatticeInf.{u} R
            (@DistribLattice.toLattice.{u} R (@instDistribLatticeOfLinearOrder.{u} R inst_1)))))],
  @LT.lt.{u} R
      (@Preorder.toLT.{u} R
        (@PartialOrder.toPreorder.{u} R
          (@SemilatticeInf.toPartialOrder.{u} R
            (@Lattice.toSemilatticeInf.{u} R
              (@DistribLattice.toLattice.{u} R (@instDistribLatticeOfLinearOrder.{u} R inst_1))))))
      (@OfNat.ofNat.{u} R (nat_lit 0)
        (@Zero.toOfNat0.{u} R (@MulZeroClass.toZero.{u} R (@instMulZeroClassOfSemiring.{u} R inst))))
      c →
    @Eq.{1} Prop
      (@LE.le.{u} R
        (@Preorder.toLE.{u} R
          (@PartialOrder.toPreorder.{u} R
            (@SemilatticeInf.toPartialOrder.{u} R
              (@Lattice.toSemilatticeInf.{u} R
                (@DistribLattice.toLattice.{u} R (@instDistribLatticeOfLinearOrder.{u} R inst_1))))))
        (@OfNat.ofNat.{u} R (nat_lit 0)
          (@Zero.toOfNat0.{u} R (@MulZeroClass.toZero.{u} R (@instMulZeroClassOfSemiring.{u} R inst))))
        (@HMul.hMul.{u, u, u} R R R (@instHMul.{u} R (@Distrib.toMul.{u} R (@instDistribOfSemiring.{u} R inst))) c b))
      (@LE.le.{u} R
        (@Preorder.toLE.{u} R
          (@PartialOrder.toPreorder.{u} R
            (@SemilatticeInf.toPartialOrder.{u} R
              (@Lattice.toSemilatticeInf.{u} R
                (@DistribLattice.toLattice.{u} R (@instDistribLatticeOfLinearOrder.{u} R inst_1))))))
        (@OfNat.ofNat.{u} R (nat_lit 0)
          (@Zero.toOfNat0.{u} R (@MulZeroClass.toZero.{u} R (@instMulZeroClassOfSemiring.{u} R inst))))
        b) :=
⋯
```

## `_private.BrownianMotion.Gaussian.Moment.0.ProbabilityTheory.centralMoment_two_mul_gaussianReal._simp_1_6`

Command: `#print _private.BrownianMotion.Gaussian.Moment.0.ProbabilityTheory.centralMoment_two_mul_gaussianReal._simp_1_6`

```lean
private theorem ProbabilityTheory.centralMoment_two_mul_gaussianReal._simp_1_6 : ∀ {q : NNReal},
  @Eq.{1} Prop
    (@LE.le.{0} Real Real.instLE (@OfNat.ofNat.{0} Real (nat_lit 0) (@Zero.toOfNat0.{0} Real Real.instZero)) ↑q) True :=
⋯
```

## `_private.BrownianMotion.Gaussian.Moment.0.ProbabilityTheory.centralMoment_two_mul_gaussianReal._simp_1_7`

Command: `#print _private.BrownianMotion.Gaussian.Moment.0.ProbabilityTheory.centralMoment_two_mul_gaussianReal._simp_1_7`

```lean
private theorem ProbabilityTheory.centralMoment_two_mul_gaussianReal._simp_1_7.{u_2} : ∀ {M₀ : Type u_2}
  [inst : MonoidWithZero.{u_2} M₀] [inst_1 : Preorder.{u_2} M₀] {a : M₀}
  [@ZeroLEOneClass.{u_2} M₀
      (@MulZeroClass.toZero.{u_2} M₀
        (@MulZeroOneClass.toMulZeroClass.{u_2} M₀ (@MonoidWithZero.toMulZeroOneClass.{u_2} M₀ inst)))
      (@MulOne.toOne.{u_2} M₀
        (@MulOneClass.toMulOne.{u_2} M₀
          (@MulZeroOneClass.toMulOneClass.{u_2} M₀ (@MonoidWithZero.toMulZeroOneClass.{u_2} M₀ inst))))
      (@Preorder.toLE.{u_2} M₀ inst_1)]
  [@PosMulMono.{u_2} M₀
      (@MulZeroClass.toMul.{u_2} M₀
        (@MulZeroOneClass.toMulZeroClass.{u_2} M₀ (@MonoidWithZero.toMulZeroOneClass.{u_2} M₀ inst)))
      (@MulZeroClass.toZero.{u_2} M₀
        (@MulZeroOneClass.toMulZeroClass.{u_2} M₀ (@MonoidWithZero.toMulZeroOneClass.{u_2} M₀ inst)))
      inst_1],
  @LE.le.{u_2} M₀ (@Preorder.toLE.{u_2} M₀ inst_1)
      (@OfNat.ofNat.{u_2} M₀ (nat_lit 0)
        (@Zero.toOfNat0.{u_2} M₀
          (@MulZeroClass.toZero.{u_2} M₀
            (@MulZeroOneClass.toMulZeroClass.{u_2} M₀ (@MonoidWithZero.toMulZeroOneClass.{u_2} M₀ inst)))))
      a →
    ∀ (n : Nat),
      @Eq.{1} Prop
        (@LE.le.{u_2} M₀ (@Preorder.toLE.{u_2} M₀ inst_1)
          (@OfNat.ofNat.{u_2} M₀ (nat_lit 0)
            (@Zero.toOfNat0.{u_2} M₀
              (@MulZeroClass.toZero.{u_2} M₀
                (@MulZeroOneClass.toMulZeroClass.{u_2} M₀ (@MonoidWithZero.toMulZeroOneClass.{u_2} M₀ inst)))))
          (@HPow.hPow.{u_2, 0, u_2} M₀ Nat M₀
            (@instHPow.{u_2, 0} M₀ Nat
              (@NPow.toPow.{u_2} M₀ (@Monoid.toNPow.{u_2} M₀ (@MonoidWithZero.toMonoid.{u_2} M₀ inst))))
            a n))
        True :=
⋯
```

## `_private.BrownianMotion.Gaussian.Moment.0.ProbabilityTheory.centralMoment_two_mul_gaussianReal._simp_1_8`

Command: `#print _private.BrownianMotion.Gaussian.Moment.0.ProbabilityTheory.centralMoment_two_mul_gaussianReal._simp_1_8`

```lean
private theorem ProbabilityTheory.centralMoment_two_mul_gaussianReal._simp_1_8.{u_1, u_2} : ∀ {α : Type u_1}
  {β : Type u_2} {s : Set.{u_1} α} {t : Set.{u_2} β} {f : α → β},
  @Eq.{1} Prop (@LE.le.{u_2} (Set.{u_2} β) (@Set.instLE.{u_2} β) (@Set.image.{u_1, u_2} α β f s) t)
    (@LE.le.{u_1} (Set.{u_1} α) (@Set.instLE.{u_1} α) s (@Set.preimage.{u_1, u_2} α β f t)) :=
⋯
```

## `_private.BrownianMotion.Gaussian.Moment.0.ProbabilityTheory.centralMoment_two_mul_gaussianReal._simp_1_9`

Command: `#print _private.BrownianMotion.Gaussian.Moment.0.ProbabilityTheory.centralMoment_two_mul_gaussianReal._simp_1_9`

```lean
private theorem ProbabilityTheory.centralMoment_two_mul_gaussianReal._simp_1_9.{u, v} : ∀ {α : Type u} {β : Type v}
  {f : α → β} {s : Set.{v} β} {a : α},
  @Eq.{1} Prop (@Membership.mem.{u, u} α (Set.{u} α) (@Set.instMembership.{u} α) (@Set.preimage.{u, v} α β f s) a)
    (@Membership.mem.{v, v} β (Set.{v} β) (@Set.instMembership.{v} β) s (f a)) :=
⋯
```

## `_private.BrownianMotion.Gaussian.ProjectiveLimit.0.L2.posSemidef_interMatrix._simp_1_1`

Command: `#print _private.BrownianMotion.Gaussian.ProjectiveLimit.0.L2.posSemidef_interMatrix._simp_1_1`

```lean
private theorem L2.posSemidef_interMatrix._simp_1_1.{u_1} : ∀ {α : Type u_1} {m : MeasurableSpace.{u_1} α}
  {μ : @MeasureTheory.Measure.{u_1} α m} {s t : Set.{u_1} α} (hs : @MeasurableSet.{u_1} α m s)
  (ht : @MeasurableSet.{u_1} α m t)
  (hμs :
    autoParam.{0}
      (@Ne.{1} ENNReal
        (@DFunLike.coe.{u_1 + 1, u_1 + 1, 1} (@MeasureTheory.Measure.{u_1} α m) (Set.{u_1} α) (fun x => ENNReal)
          (@MeasureTheory.Measure.instFunLike.{u_1} α m) μ s)
        (@Top.top.{0} ENNReal ENNReal.instTop))
      MeasureTheory.L2.real_inner_indicatorConstLp_one_indicatorConstLp_one._auto_1)
  (hμt :
    autoParam.{0}
      (@Ne.{1} ENNReal
        (@DFunLike.coe.{u_1 + 1, u_1 + 1, 1} (@MeasureTheory.Measure.{u_1} α m) (Set.{u_1} α) (fun x => ENNReal)
          (@MeasureTheory.Measure.instFunLike.{u_1} α m) μ t)
        (@Top.top.{0} ENNReal ENNReal.instTop))
      MeasureTheory.L2.real_inner_indicatorConstLp_one_indicatorConstLp_one._auto_3),
  @Eq.{1} Real (@MeasureTheory.Measure.real.{u_1} α m μ (@Inter.inter.{u_1} (Set.{u_1} α) (@Set.instInter.{u_1} α) s t))
    (@Inner.inner.{0, u_1} Real
      (↥(@MeasureTheory.Lp.{0, u_1} α Real m Real.normedAddCommGroup
          (@OfNat.ofNat.{0} ENNReal (nat_lit 2)
            (@instOfNatAtLeastTwo.{0} ENNReal (nat_lit 2)
              (@AddMonoidWithOne.toNatCast.{0} ENNReal
                (@AddCommMonoidWithOne.toAddMonoidWithOne.{0} ENNReal ENNReal.instAddCommMonoidWithOne))
              ⋯))
          μ))
      (@MeasureTheory.L2.instInnerSubtypeAEEqFunMemAddSubgroupLpOfNatENNReal.{u_1, 0, 0} α Real Real Real.instRCLike m μ
        Real.normedAddCommGroup (@RCLike.toInnerProductSpaceReal.{0} Real Real.instRCLike))
      (@MeasureTheory.indicatorConstLp.{u_1, 0} α Real m μ Real.normedAddCommGroup s
        (@OfNat.ofNat.{0} ENNReal (nat_lit 2)
          (@instOfNatAtLeastTwo.{0} ENNReal (nat_lit 2)
            (@AddMonoidWithOne.toNatCast.{0} ENNReal
              (@AddCommMonoidWithOne.toAddMonoidWithOne.{0} ENNReal ENNReal.instAddCommMonoidWithOne))
            ⋯))
        hs hμs (@OfNat.ofNat.{0} Real (nat_lit 1) (@One.toOfNat1.{0} Real Real.instOne)))
      (@MeasureTheory.indicatorConstLp.{u_1, 0} α Real m μ Real.normedAddCommGroup t
        (@OfNat.ofNat.{0} ENNReal (nat_lit 2)
          (@instOfNatAtLeastTwo.{0} ENNReal (nat_lit 2)
            (@AddMonoidWithOne.toNatCast.{0} ENNReal
              (@AddCommMonoidWithOne.toAddMonoidWithOne.{0} ENNReal ENNReal.instAddCommMonoidWithOne))
            ⋯))
        ht hμt (@OfNat.ofNat.{0} Real (nat_lit 1) (@One.toOfNat1.{0} Real Real.instOne)))) :=
⋯
```

## `AmericanConvexity.Stopping.BoundedRule.mk`

Command: `#print AmericanConvexity.Stopping.BoundedRule.mk`

```lean
constructor AmericanConvexity.Stopping.BoundedRule.mk.{u_1} : {Ω : Type u_1} →
  [inst : MeasurableSpace.{u_1} Ω] →
    {𝓕 :
        @MeasureTheory.Filtration.{u_1, 0} Ω NNReal (@PartialOrder.toPreorder.{0} NNReal NNReal.instPartialOrder)
          inst} →
      {T : NNReal} →
        (time : Ω → NNReal) →
          (@MeasureTheory.IsStoppingTime.{u_1, 0} Ω NNReal inst
              (@PartialOrder.toPreorder.{0} NNReal NNReal.instPartialOrder) 𝓕 fun ω =>
              @WithTop.some.{0} NNReal (time ω)) →
            (∀ (ω : Ω),
                @LE.le.{0} NNReal
                  (@Preorder.toLE.{0} NNReal (@PartialOrder.toPreorder.{0} NNReal NNReal.instPartialOrder)) (time ω)
                  T) →
              @AmericanConvexity.Stopping.BoundedRule.{u_1} Ω inst 𝓕 T
```

## `AmericanConvexity.Stopping.BoundedRule.time`

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

## `AmericanConvexity.Stopping.brownianFiltration._proof_1`

Command: `#print AmericanConvexity.Stopping.brownianFiltration._proof_1`

```lean
theorem AmericanConvexity.Stopping.brownianFiltration._proof_1 : ∀ (i : NNReal),
  @TopologicalSpace.MetrizableSpace.{0} Real
    (@UniformSpace.toTopologicalSpace.{0} Real
      (@PseudoEMetricSpace.toUniformSpace.{0} Real
        (@EMetricSpace.toPseudoEMetricSpace.{0} Real (@MetricSpace.toEMetricSpace.{0} Real Real.metricSpace)))) :=
⋯
```

## `AmericanConvexity.Stopping.brownianFiltration._proof_2`

Command: `#print AmericanConvexity.Stopping.brownianFiltration._proof_2`

```lean
theorem AmericanConvexity.Stopping.brownianFiltration._proof_2 : ∀ (t : NNReal),
  @MeasureTheory.StronglyMeasurable.{0, 0} (NNReal → Real) Real
    (@UniformSpace.toTopologicalSpace.{0} Real (@PseudoMetricSpace.toUniformSpace.{0} Real Real.pseudoMetricSpace))
    (@MeasurableSpace.pi.{0, 0} NNReal (fun a => Real) fun a => Real.measurableSpace) (ProbabilityTheory.brownian t) :=
⋯
```

## `AmericanConvexity.Stopping.completedAmbientFiltration._proof_1`

Command: `#print AmericanConvexity.Stopping.completedAmbientFiltration._proof_1`

```lean
theorem AmericanConvexity.Stopping.completedAmbientFiltration._proof_1.{u_1} : ∀ {Ω : Type u_1}
  [mΩ : MeasurableSpace.{u_1} Ω]
  (𝓕 : @MeasureTheory.Filtration.{u_1, 0} Ω NNReal (@PartialOrder.toPreorder.{0} NNReal NNReal.instPartialOrder) mΩ)
  (x x_1 : NNReal),
  @LE.le.{0} NNReal (@Preorder.toLE.{0} NNReal (@PartialOrder.toPreorder.{0} NNReal NNReal.instPartialOrder)) x x_1 →
    @LE.le.{u_1} (MeasurableSpace.{u_1} Ω) (@MeasurableSpace.instLE.{u_1} Ω)
      (@MeasureTheory.Filtration.seq.{u_1, 0} Ω NNReal (@PartialOrder.toPreorder.{0} NNReal NNReal.instPartialOrder) mΩ
        𝓕 x)
      (@MeasureTheory.Filtration.seq.{u_1, 0} Ω NNReal (@PartialOrder.toPreorder.{0} NNReal NNReal.instPartialOrder) mΩ
        𝓕 x_1) :=
⋯
```

## `AmericanConvexity.Stopping.completedAmbientFiltration._proof_2`

Command: `#print AmericanConvexity.Stopping.completedAmbientFiltration._proof_2`

```lean
theorem AmericanConvexity.Stopping.completedAmbientFiltration._proof_2.{u_1} : ∀ {Ω : Type u_1}
  [mΩ : MeasurableSpace.{u_1} Ω] (P : @MeasureTheory.Measure.{u_1} Ω mΩ)
  (𝓕 : @MeasureTheory.Filtration.{u_1, 0} Ω NNReal (@PartialOrder.toPreorder.{0} NNReal NNReal.instPartialOrder) mΩ)
  (t : NNReal),
  @LE.le.{u_1} (MeasurableSpace.{u_1} Ω)
    (@Preorder.toLE.{u_1} (MeasurableSpace.{u_1} Ω)
      (@PartialOrder.toPreorder.{u_1} (MeasurableSpace.{u_1} Ω) (@MeasurableSpace.instPartialOrder.{u_1} Ω)))
    (@MeasureTheory.Filtration.seq.{u_1, 0} Ω NNReal (@PartialOrder.toPreorder.{0} NNReal NNReal.instPartialOrder) mΩ 𝓕
      t)
    (@AmericanConvexity.Stopping.completedMeasurableSpace.{u_1} Ω mΩ P) :=
⋯
```

## `AmericanConvexity.Stopping.completedMeasurableSpace._proof_1`

Command: `#print AmericanConvexity.Stopping.completedMeasurableSpace._proof_1`

```lean
theorem AmericanConvexity.Stopping.completedMeasurableSpace._proof_1.{u_1} : ∀ {Ω : Type u_1}
  [mΩ : MeasurableSpace.{u_1} Ω] (P : @MeasureTheory.Measure.{u_1} Ω mΩ),
  @CountableInterFilter.{u_1} Ω
    (@MeasureTheory.ae.{u_1, u_1} Ω (@MeasureTheory.Measure.{u_1} Ω mΩ) (@MeasureTheory.Measure.instFunLike.{u_1} Ω mΩ)
      ⋯ P) :=
⋯
```

## `MeasureTheory.Measure.IsAddLeftInvariant.measure_closedBall_const'`

Command: `#print MeasureTheory.Measure.IsAddLeftInvariant.measure_closedBall_const'`

```lean
theorem MeasureTheory.Measure.IsAddLeftInvariant.measure_closedBall_const'.{u_1} : ∀ {G : Type u_1}
  [inst : AddGroup.{u_1} G] [inst_1 : PseudoEMetricSpace.{u_1} G] [inst_2 : MeasurableSpace.{u_1} G]
  [@OpensMeasurableSpace.{u_1} G
      (@UniformSpace.toTopologicalSpace.{u_1} G (@PseudoEMetricSpace.toUniformSpace.{u_1} G inst_1)) inst_2]
  (μ : @MeasureTheory.Measure.{u_1} G inst_2)
  [@MeasureTheory.Measure.IsAddLeftInvariant.{u_1} G inst_2
      (@AddZero.toAdd.{u_1} G
        (@AddZeroClass.toAddZero.{u_1} G
          (@AddMonoid.toAddZeroClass.{u_1} G
            (@SubNegMonoid.toAddMonoid.{u_1} G (@AddGroup.toSubNegMonoid.{u_1} G inst)))))
      μ]
  [@IsIsometricVAdd.{u_1, u_1} G G inst_1
      (@instVAddOfAdd.{u_1} G
        (@AddZero.toAdd.{u_1} G
          (@AddZeroClass.toAddZero.{u_1} G
            (@AddMonoid.toAddZeroClass.{u_1} G
              (@SubNegMonoid.toAddMonoid.{u_1} G (@AddGroup.toSubNegMonoid.{u_1} G inst))))))]
  [@MeasurableAdd.{u_1} G inst_2
      (@AddZero.toAdd.{u_1} G
        (@AddZeroClass.toAddZero.{u_1} G
          (@AddMonoid.toAddZeroClass.{u_1} G
            (@SubNegMonoid.toAddMonoid.{u_1} G (@AddGroup.toSubNegMonoid.{u_1} G inst)))))]
  (a b : G) (r : ENNReal),
  @Eq.{1} ENNReal
    (@DFunLike.coe.{u_1 + 1, u_1 + 1, 1} (@MeasureTheory.Measure.{u_1} G inst_2) (Set.{u_1} G) (fun x => ENNReal)
      (@MeasureTheory.Measure.instFunLike.{u_1} G inst_2) μ (@Metric.closedEBall.{u_1} G inst_1 a r))
    (@DFunLike.coe.{u_1 + 1, u_1 + 1, 1} (@MeasureTheory.Measure.{u_1} G inst_2) (Set.{u_1} G) (fun x => ENNReal)
      (@MeasureTheory.Measure.instFunLike.{u_1} G inst_2) μ (@Metric.closedEBall.{u_1} G inst_1 b r)) :=
⋯
```

## `ProbabilityTheory.IsPreBrownianReal.mk._proof_1`

Command: `#print ProbabilityTheory.IsPreBrownianReal.mk._proof_1`

```lean
theorem ProbabilityTheory.IsPreBrownianReal.mk._proof_1 : (@HAdd.hAdd.{0, 0, 0} Nat Nat Nat
    (@instHAdd.{0} Nat instAddNat) (@OfNat.ofNat.{0} Nat (nat_lit 1) (instOfNatNat (nat_lit 1)))
    (@OfNat.ofNat.{0} Nat (nat_lit 1) (instOfNatNat (nat_lit 1)))).AtLeastTwo :=
⋯
```

## `_private.BrownianMotion.Continuity.IsKolmogorovProcess.0.ProbabilityTheory.IsAEKolmogorovProcess.lintegral_sup_rpow_edist_eq_zero'._simp_1_1`

Command: `#print _private.BrownianMotion.Continuity.IsKolmogorovProcess.0.ProbabilityTheory.IsAEKolmogorovProcess.lintegral_sup_rpow_edist_eq_zero'._simp_1_1`

```lean
private theorem ProbabilityTheory.IsAEKolmogorovProcess.lintegral_sup_rpow_edist_eq_zero'._simp_1_1.{u_1, u_3, u_4} : ∀
  {α : Type u_1} {F : Type u_3} [inst : FunLike.{u_3 + 1, u_1 + 1, 1} F (Set.{u_1} α) ENNReal]
  [inst_1 : @MeasureTheory.OuterMeasureClass.{u_3, u_1} F α inst] {μ : F} {ι : Sort u_4} [Countable.{u_4} ι]
  {p : α → ι → Prop},
  @Eq.{1} Prop (@Filter.Eventually.{u_1} α (fun a => ∀ (i : ι), p a i) (@MeasureTheory.ae.{u_1, u_3} α F inst inst_1 μ))
    (∀ (i : ι), @Filter.Eventually.{u_1} α (fun a => p a i) (@MeasureTheory.ae.{u_1, u_3} α F inst inst_1 μ)) :=
⋯
```

## `_private.BrownianMotion.Continuity.KolmogorovChentsov.0.ProbabilityTheory.IsKolmogorovProcess.measurableSet_holderSet._simp_1_1`

Command: `#print _private.BrownianMotion.Continuity.KolmogorovChentsov.0.ProbabilityTheory.IsKolmogorovProcess.measurableSet_holderSet._simp_1_1`

```lean
private theorem ProbabilityTheory.IsKolmogorovProcess.measurableSet_holderSet._simp_1_1 : ∀ {b a : Prop},
  @Eq.{1} Prop (b → a) (Or a (Not b)) :=
⋯
```

## `_private.BrownianMotion.Continuity.LimitModification.0.ProbabilityTheory.IsLimitOfIndicator.indicatorProcess._simp_1_3`

Command: `#print _private.BrownianMotion.Continuity.LimitModification.0.ProbabilityTheory.IsLimitOfIndicator.indicatorProcess._simp_1_3`

```lean
private theorem ProbabilityTheory.IsLimitOfIndicator.indicatorProcess._simp_1_3.{u} : ∀ {α : Type u} (x : α)
  (a b : Set.{u} α),
  @Eq.{1} Prop
    (@Membership.mem.{u, u} α (Set.{u} α) (@Set.instMembership.{u} α)
      (@Inter.inter.{u} (Set.{u} α) (@Set.instInter.{u} α) a b) x)
    (And (@Membership.mem.{u, u} α (Set.{u} α) (@Set.instMembership.{u} α) a x)
      (@Membership.mem.{u, u} α (Set.{u} α) (@Set.instMembership.{u} α) b x)) :=
⋯
```

## `_private.BrownianMotion.Continuity.LimitModification.0.ProbabilityTheory.IsLimitOfIndicator.measurable_pair._simp_1_3`

Command: `#print _private.BrownianMotion.Continuity.LimitModification.0.ProbabilityTheory.IsLimitOfIndicator.measurable_pair._simp_1_3`

```lean
private theorem ProbabilityTheory.IsLimitOfIndicator.measurable_pair._simp_1_3.{u} : ∀ {α : Type u} (x : α),
  @Eq.{1} Prop
    (@Membership.mem.{u, u} α (Set.{u} α) (@Set.instMembership.{u} α)
      (@EmptyCollection.emptyCollection.{u} (Set.{u} α) (@Set.instEmptyCollection.{u} α)) x)
    False :=
⋯
```

## `_private.BrownianMotion.Continuity.LimitModification.0.ProbabilityTheory.IsLimitOfIndicator.measurable_pair._simp_1_4`

Command: `#print _private.BrownianMotion.Continuity.LimitModification.0.ProbabilityTheory.IsLimitOfIndicator.measurable_pair._simp_1_4`

```lean
private theorem ProbabilityTheory.IsLimitOfIndicator.measurable_pair._simp_1_4.{u_1} : ∀ {α : Type u_1}
  [inst : LinearOrder.{u_1} α] [inst_1 : Zero.{u_1} α]
  [@IsBotZeroClass.{u_1} α
      (@Preorder.toLE.{u_1} α
        (@PartialOrder.toPreorder.{u_1} α
          (@SemilatticeInf.toPartialOrder.{u_1} α
            (@Lattice.toSemilatticeInf.{u_1} α
              (@DistribLattice.toLattice.{u_1} α (@instDistribLatticeOfLinearOrder.{u_1} α inst))))))
      inst_1]
  {a b : α},
  @Eq.{1} Prop
    (@Eq.{u_1 + 1} α
      (@Max.max.{u_1} α
        (@SemilatticeSup.toMax.{u_1} α
          (@Lattice.toSemilatticeSup.{u_1} α
            (@DistribLattice.toLattice.{u_1} α (@instDistribLatticeOfLinearOrder.{u_1} α inst))))
        a b)
      (@OfNat.ofNat.{u_1} α (nat_lit 0) (@Zero.toOfNat0.{u_1} α inst_1)))
    (And (@Eq.{u_1 + 1} α a (@OfNat.ofNat.{u_1} α (nat_lit 0) (@Zero.toOfNat0.{u_1} α inst_1)))
      (@Eq.{u_1 + 1} α b (@OfNat.ofNat.{u_1} α (nat_lit 0) (@Zero.toOfNat0.{u_1} α inst_1)))) :=
⋯
```

## `_private.BrownianMotion.Gaussian.BrownianMotion.0.ProbabilityTheory.IsPreBrownianReal.exists_continuous_modification._proof_1_2`

Command: `#print _private.BrownianMotion.Gaussian.BrownianMotion.0.ProbabilityTheory.IsPreBrownianReal.exists_continuous_modification._proof_1_2`

```lean
private theorem ProbabilityTheory.IsPreBrownianReal.exists_continuous_modification._proof_1_2 : ∀ (n : Nat),
  Not
      (@LT.lt.{0} Nat instLTNat (@OfNat.ofNat.{0} Nat (nat_lit 1) (instOfNatNat (nat_lit 1)))
        (@HAdd.hAdd.{0, 0, 0} Nat Nat Nat (@instHAdd.{0} Nat instAddNat) n
          (@OfNat.ofNat.{0} Nat (nat_lit 2) (instOfNatNat (nat_lit 2))))) →
    False :=
⋯
```

## `_private.BrownianMotion.Gaussian.BrownianMotion.0.ProbabilityTheory.IsPreBrownianReal.isAEKolmogorovProcess._simp_1_1`

Command: `#print _private.BrownianMotion.Gaussian.BrownianMotion.0.ProbabilityTheory.IsPreBrownianReal.isAEKolmogorovProcess._simp_1_1`

```lean
private theorem ProbabilityTheory.IsPreBrownianReal.isAEKolmogorovProcess._simp_1_1.{u} : ∀ {α : Type u}
  [inst : PseudoMetricSpace.{u} α] {x y : α},
  @Eq.{1} Prop
    (@LE.le.{0} Real Real.instLE (@OfNat.ofNat.{0} Real (nat_lit 0) (@Zero.toOfNat0.{0} Real Real.instZero))
      (@Dist.dist.{u} α (@PseudoMetricSpace.toDist.{u} α inst) x y))
    True :=
⋯
```
