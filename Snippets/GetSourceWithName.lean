import Lean.Elab.Command
import Lean.Server.GoTo
import Lean.Server.FileWorker
import Snippets.GetCurrentSource

/-!
Get the source code of the current file in the `CommandElabM` monad.
NOTE: Still WIP
-/

open Lean Elab Command Server

def foo' (pkg : String) : CommandElabM System.FilePath := do
  let sp ← initSrcSearchPath (← findSysroot)
  IO.println sp
  let root? ← sp.findM? fun p =>
    (p / pkg).isDir <||> ((p / pkg).withExtension "lean").pathExists
  if let some root := root? then return root
  throwError s!"Could not find {pkg} directory. {
    ""}Make sure the LEAN_SRC_PATH environment variable is set correctly."
  /-
  let some modName ← (findModuleOf? nm) 
    | throwError m!"No module found with name {nm}"
  let some e ← (sp.findWithExt "lean" modName) 
    | throwError m!"Failed to fetch URI of module with name {modName}"
  let ee ← IO.FS.realPath e
  return ee
  -/
  return ""

#eval foo' "Snippets"