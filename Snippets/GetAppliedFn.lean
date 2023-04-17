import Mathlib.Lean.Expr.Basic

open Lean Meta

def Lean.Meta.getAppliedFn (nm : Name) : MetaM (List (Name × ConstantInfo)) := do
  let cs := (← getEnv).constants.toList
  return cs.filter (fun c => c.snd.type.getForallBody.getAppFnArgs.fst == nm)

#eval show MetaM Unit from do
  let list ← Lean.Meta.getAppliedFn `Decidable
  for l in list do 
    IO.println s!"{l.1} : {← ppExpr l.2.type}"