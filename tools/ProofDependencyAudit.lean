import Lean
import Lean.Replay

/-! Standalone audit executable, not part of the mathematical proof.

Usage: lake env lean --run tools/ProofDependencyAudit.lean REPORT.json [--replay]

Walks actual declaration types and bodies rather than import lists or cached
axiom summaries. Includes mutual inductive blocks and constructors needed for
kernel replay. With --replay, checks the collected closure in an empty kernel
environment at trust level zero, using Lean's own replay implementation.
This is not an independent kernel implementation or semantic review.
-/

open Lean

def auditRoots : Array Name := #[
  `AmericanPutConvexity.Stopping.brownianUsualBoundary_classical_curvature,
  `AmericanPutConvexity.Stopping.brownianAEBoundary_classical_curvature,
  `AmericanPutConvexity.Stopping.canonicalStraightDifference_superlevel_interval]

def allowedAxioms : Array Name := #[`propext, `Classical.choice, `Quot.sound]

def extraBlockNames (ci : ConstantInfo) : Array Name :=
  match ci with
  | .inductInfo v => v.all.toArray ++ v.ctors.toArray
  | .ctorInfo v => #[v.induct]
  | .recInfo v => v.all.toArray
  | .thmInfo v => v.all.toArray
  | .defnInfo v => v.all.toArray
  | _ => #[]

def ownerName (env : Environment) (n : Name) : Name :=
  match env.getModuleIdxFor? n with
  | some idx => env.header.moduleNames[idx.toNat]!
  | none => .anonymous

def constantKind (ci : ConstantInfo) : String :=
  match ci with
  | .axiomInfo _ => "axiom"
  | .thmInfo _ => "theorem"
  | .defnInfo _ => "definition"
  | .opaqueInfo _ => "opaque"
  | .inductInfo _ => "inductive"
  | .ctorInfo _ => "constructor"
  | .recInfo _ => "recursor"
  | .quotInfo _ => "quotient"

def collectClosure (env : Environment) (roots : Array Name := auditRoots) :
    IO (Std.HashMap Name ConstantInfo) := do
  let mut pending := roots
  let mut seen : Std.HashMap Name ConstantInfo := {}
  while !pending.isEmpty do
    let n := pending.back!
    pending := pending.pop
    if seen.contains n then continue
    let some ci := env.toKernelEnv.find? n
      | throw (IO.userError s!"Missing declaration body/type: {n}")
    if ci.isUnsafe || ci.isPartial then
      throw (IO.userError s!"Unsafe or partial declaration in proof closure: {n}")
    if let .axiomInfo _ := ci then
      unless allowedAxioms.contains n do
        throw (IO.userError s!"Unapproved axiom in proof closure: {n}")
    seen := seen.insert n ci
    pending := pending ++ ci.getUsedConstantsAsSet.toArray ++ extraBlockNames ci
  return seen

def requireFailure (label : String) (action : IO Unit) : IO Unit := do
  let rejected ← try
    action
    pure false
  catch _ => pure true
  unless rejected do throw (IO.userError s!"Audit self-test did not reject {label}")

def selfTest (env : Environment) : IO Unit := do
  requireFailure "missing declaration" do
    discard <| collectClosure env #[`ProofDependencyAudit.MissingDeclaration]
  requireFailure "sorry axiom" do
    discard <| collectClosure env #[`sorryAx]
  let base ← collectClosure env #[`True.intro, `False]
  let invalid : ConstantInfo := .thmInfo {
    name := `ProofDependencyAudit.InvalidTheorem
    levelParams := []
    type := mkConst `False
    value := mkConst `True.intro
    all := [`ProofDependencyAudit.InvalidTheorem] }
  requireFailure "false proof term" do
    discard <| (← mkEmptyEnvironment).replay (base.insert invalid.name invalid)
  IO.println "Audit negative controls passed (missing declaration, sorry axiom, false proof term)."

def gitRevision (path : String) : IO String := do
  let result ← IO.Process.output { cmd := "git", args := #["-C",path,"rev-parse","HEAD"] }
  unless result.exitCode == 0 do throw (IO.userError result.stderr)
  return result.stdout.trimAscii.toString

unsafe def main (args : List String) : IO UInt32 := do
  let reportPath :: flags := args
    | throw (IO.userError "Usage: REPORT.json [--replay]")
  unless flags.all (· == "--replay") do
    throw (IO.userError "Unknown audit option")
  initSearchPath (← findSysroot)
  withImportModules #[{ module := `AmericanPutConvexity.Stopping.AEHorizonCurvature }] {} fun env => do
    selfTest env
    let closure ← collectClosure env
    let names := closure.toArray.map Prod.fst |>.qsort Name.lt
    let axioms := names.filter fun n => match closure[n]! with
      | .axiomInfo _ => true
      | _ => false
    let mut owners : Std.HashMap String Nat := {}
    let mut upstream : Array Json := #[]
    let mut frontier : Array Json := #[]
    for n in names do
      let owner := ownerName env n
      owners := owners.insert owner.toString ((owners[owner.toString]?.getD 0)+1)
      if (`MathFin).isPrefixOf owner || (`BrownianMotion).isPrefixOf owner then
        upstream := upstream.push (Json.mkObj [
          ("name", toJson n.toString), ("module", toJson owner.toString),
          ("kind", toJson (constantKind closure[n]!))])
      if (`AmericanPutConvexity).isPrefixOf owner then
        for dep in closure[n]!.getUsedConstantsAsSet.toArray.qsort Name.lt do
          let depOwner := ownerName env dep
          if (`MathFin).isPrefixOf depOwner || (`BrownianMotion).isPrefixOf depOwner then
            frontier := frontier.push (Json.mkObj [
              ("from", toJson n.toString), ("target", toJson dep.toString),
              ("target_module", toJson depOwner.toString),
              ("kind", toJson (constantKind closure[dep]!))])
    IO.println s!"Collected {closure.size} declarations; {upstream.size} MathFin/Brownian declarations."
    IO.println s!"Axioms: {axioms.map Name.toString}"
    let replay := flags.contains "--replay"
    if replay then
      IO.println "Replaying the full collected proof closure into an empty kernel environment..."
      discard <| (← mkEmptyEnvironment).replay closure
      IO.println "Fresh kernel replay passed."
    let modules := owners.toArray.qsort (fun a b => a.1 < b.1)
    let report := Json.mkObj [
      ("schema_version", toJson (1 : Nat)),
      ("lean_version", toJson Lean.versionString),
      ("project_revision", toJson (← gitRevision ".")),
      ("mathfin_revision", toJson (← gitRevision ".lake/packages/MathFin")),
      ("brownian_revision", toJson (← gitRevision ".lake/packages/BrownianMotion")),
      ("mathlib_revision", toJson (← gitRevision ".lake/packages/mathlib")),
      ("negative_controls_passed", toJson true),
      ("roots", toJson (auditRoots.map Name.toString)),
      ("method", toJson "transitive type/body walk, including mutual blocks"),
      ("declaration_count", toJson closure.size),
      ("axioms", toJson (axioms.map Name.toString)),
      ("fresh_kernel_replay_passed", toJson replay),
      ("upstream_declarations", toJson upstream),
      ("project_upstream_edges", toJson frontier),
      ("modules", toJson (modules.map fun (m,n) => Json.mkObj [
        ("module", toJson m), ("declaration_count", toJson n)]))]
    IO.FS.writeFile reportPath (report.pretty ++ "\n")
    IO.println s!"Wrote {reportPath}"
  return 0
