import Lean

elab "fooTac" : tactic => do
  let some nm ← Lean.Elab.Term.getDeclName? | IO.println "error"
  IO.println nm
  Lean.Elab.Tactic.evalTactic <| ← `(tactic|sorry)

elab "fooTerm" : term => do
  let some nm ← Lean.Elab.Term.getDeclName? | throwError "error"
  IO.println nm
  Lean.Elab.Term.elabTerm (← `(term|sorry)) none

def foo : Nat := by fooTac
def bar : Nat := fooTerm