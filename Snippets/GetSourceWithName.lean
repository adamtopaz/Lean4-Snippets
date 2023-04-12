import Lean.Elab.Command
import Lean.Server.GoTo
import Lean.Server.FileWorker
import Snippets.GetCurrentSource

/-!
Get the source code of the current file in the `CommandElabM` monad.
-/

open Lean Elab Command Server

def foo' (nm : Name) : CommandElabM System.FilePath := do
  let sp ← getBuiltinSearchPath (← findSysroot)
  let some modName ← (findModuleOf? nm) 
    | throwError m!"No module found with name {nm}"
  let some e ← (sp.findModuleWithExt "lean" modName) 
    | throwError m!"Failed to fetch URI of module with name {modName}"
  return e

#eval foo' `foo