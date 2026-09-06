import AmericanConvexity.Stopping.UsualBrownianValue

/-! Reproducible elaborated dependency dump. Stops at Mathlib and Lean/core
modules, not at namespace spellings. Includes construction proof dependencies.
AUDIT_START and AUDIT_COUNT select a reproducible output chunk. -/

set_option pp.explicit true
set_option pp.fullNames true
-- This appendix prints every declaration, but suppresses proof terms. The
-- companion ElaboratedValueAudit.lean prints the semantic spine with proofs.
set_option pp.proofs false
set_option pp.proofs.threshold 0
set_option pp.deepTerms true
set_option pp.universes true
set_option format.width 120
set_option pp.maxSteps 100000000
set_option maxRecDepth 100000
set_option maxHeartbeats 0

open Lean Elab Command

elab "#recursive_value_print" : command => do
  let env ← getEnv
  let roots := #[`AmericanConvexity.Stopping.brownianUsualAmericanPut,
    `AmericanConvexity.Stopping.brownianUsualExerciseBoundary,
    `AmericanConvexity.Stopping.completion_isProbabilityMeasure,
    `ProbabilityTheory.IsProbabilityMeasure_gaussianLimit,
    `ProbabilityTheory.isBrownianReal_brownian,
    `AmericanConvexity.Stopping.brownian_filtered]
  let mut pending := roots
  let mut seen : Std.HashSet Name := {}
  let mut selected : Array Name := #[]
  let mut frontier : Std.HashSet Name := {}
  while !pending.isEmpty do
    let n := pending.back!
    pending := pending.pop
    if seen.contains n then continue
    seen := seen.insert n
    let some ci := env.find? n | throwError "Missing declaration: {n}"
    let owner := match env.getModuleIdxFor? n with
      | some idx => env.header.moduleNames[idx.toNat]!
      | none => Name.anonymous
    let upstream := !owner.isAnonymous && !((`Mathlib).isPrefixOf owner ||
      (`Init).isPrefixOf owner || (`Lean).isPrefixOf owner)
    if !upstream then
      frontier := frontier.insert n
      continue
    selected := selected.push n
    pending := pending ++ ci.getUsedConstantsAsSet.toArray
    match ci with
    | .inductInfo v => pending := pending ++ v.all.toArray ++ v.ctors.toArray
    | .ctorInfo v => pending := pending.push v.induct
    | .recInfo v => pending := pending ++ v.all.toArray
    | .defnInfo v => pending := pending ++ v.all.toArray
    | .thmInfo v => pending := pending ++ v.all.toArray
    | _ => pure ()
  selected := selected.qsort Name.lt
  let start := ((← IO.getEnv "AUDIT_START").getD "0").toNat!
  let count := ((← IO.getEnv "AUDIT_COUNT").getD "0").toNat!
  logInfo m!"AUDIT_TOTAL {selected.size} FRONTIER {frontier.size}"
  if count == 0 then
    for n in selected do
      let owner := match env.getModuleIdxFor? n with
        | some idx => env.header.moduleNames[idx.toNat]!
        | none => Name.anonymous
      logInfo m!"AUDIT_NODE {n} {owner}"
    for n in frontier.toArray.qsort Name.lt do
      let owner := match env.getModuleIdxFor? n with
        | some idx => env.header.moduleNames[idx.toNat]!
        | none => Name.anonymous
      logInfo m!"AUDIT_FRONTIER {n} {owner}"
  else
    for n in selected.extract start (min selected.size (start + count)) do
      logInfo m!"AUDIT_BEGIN {n}"
      elabCommand (← `(#print $(mkIdent n)))
      logInfo m!"AUDIT_END {n}"

#recursive_value_print
