import Lean

/-!
Get the source code of the current file in the `CommandElabM` monad.
-/

open Lean Elab Command

def foo : CommandElabM String := do
  let ctx ← readThe Context
  return ctx.fileMap.source

#eval foo