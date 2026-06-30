# SexLab Survival — Project Notes for Claude

Large Skyrim SE gameplay/survival overhaul mod. Pure **Papyrus** (`.psc` → `.pex`), no SKSE plugin of its own. ~812 source scripts. Heavily integrates with dozens of optional LoversLab/survival mods through a consistent adapter layer (see *Adapter Architecture* — it is the most important thing in this project).

Current version: **0.685** (`meta.ini`).

## Git Commits
Do **not** include a `Co-Authored-By` trailer in commit messages. Commits should look authored solely by the user (matches the convention in the user's other Skyrim mods).

## Build

Compiled with the Skyrim SE Papyrus compiler. Project file: `skyrimse.ppj` (defines the full import list — 54 import folders, mostly bundled under `dependencies/`).

**The #1 project pain point is compiling a single changed script** (see the "Unable to compile SLS script" thread linked in `readme.md`). A bare import list fails because SLS scripts transitively pull in SexLab/DD/FNIS types (`MfgConsoleFunc`, `FNIS_aa`, `NiOverride`, …). You **must** pass the project's *entire* import list or type resolution fails on dependencies you never touched.

Working single-file recompile (PowerShell, run from project root):

```powershell
[xml]$ppj = Get-Content "skyrimse.ppj"
$vars = @{ '@ImportsFolder'='.\scripts\source'; '@SkyrimScripts'='C:\SteamLibrary\steamapps\common\Skyrim Special Edition\Data\Source\Scripts' }
$imports = $ppj.PapyrusProject.Imports.Import | ForEach-Object {
  $v = $_; foreach ($k in $vars.Keys) { $v = $v -replace [regex]::Escape($k), $vars[$k] }; $v
}
$compiler = "C:\SteamLibrary\steamapps\common\Skyrim Special Edition\Papyrus Compiler\PapyrusCompiler.exe"
& $compiler "_SLS_IntCf.psc" -f="TESV_Papyrus_Flags.flg" -i="$(($imports -join ';'))" -o="scripts"
```

- Output `.pex` goes to `scripts/`. Source lives in `scripts/source/`.
- `TESV_Papyrus_Flags.flg` is resolved via the vanilla `@SkyrimScripts` import path, not the project root.
- Compiling the whole project / building the BSA is done via the `.ppj` (`Package="true"`, `Zip="true"`) in the user's normal toolchain — only do that when asked.

## Adapter Architecture (read this first)

Every optional-mod integration is split into a **pair**, so SLS keeps working when the other mod is absent:

- **`_SLS_IntXxx.psc`** — `Scriptname _SLS_IntXxx Hidden`, only `Global` functions. These are the *only* place that references the external mod's concrete types/scripts (e.g. `FrostUtil`, `CampUtil`, `CreatureFrameworkConfig`). Thin one-line wrappers. 58 of these.
- **`_SLS_InterfaceXxx.psc`** — `extends Quest`. Holds a two-state machine: empty state `""` (mod not installed → all methods are safe no-ops returning defaults) and `"Installed"` (delegates to the `_SLS_IntXxx` globals). `PlayerLoadsGame()` flips state based on `Game.GetModByName("Xxx.esm/.esp")`. 29 of these.

Why the split: a script-level **property** typed to an external script resolves at *script load* — if the type is missing the whole script fails to load. A **global function call** resolves *lazily at call time*. Putting every hard reference behind `_SLS_IntXxx` globals, gated by the Interface's `"Installed"` state, lets SLS load and run regardless of which optional mods are present.

### Gotcha: external scripts get renamed across versions
`_SLS_IntXxx` casts the external mod's MCM/config quest to a specific script name. If the user has a **newer version** of that mod where the script was renamed, the cast silently returns `None`, you get a `warning: Assigning None to a non-object variable "::temp1"` in the Papyrus log, and the integration breaks quietly (reads return 0, writes no-op). Real example fixed in this repo: `_SLS_IntCf` cast to `CFConfigMenu` (old CF) but CF v4 ships `CreatureFrameworkConfig`. Fix = update the cast to the installed mod's script name **and** guard the cast (`If (q as Type)`) so a future mismatch can't corrupt state. When touching an `_SLS_IntXxx`, verify the cast target against the script actually attached to the form in `dependencies/<that mod>/Scripts/Source/`.

## Naming Conventions

| Prefix | Meaning |
|--------|---------|
| `_SLS_Interface*` | Adapter quest (state machine, mod-presence gating) |
| `_SLS_Int*` | Hidden global wrappers around one external mod's API |
| `_SLS_*` / `sls_*` | SLS gameplay scripts (quests, aliases, magic effects, triggers) |
| `tif__<formid>` | CK-generated **Topic Info Fragment** (dialogue). 502 of these — do not hand-author; the Creation Kit owns them |
| `pf__*` / `prkf__*` / `qf__*` | CK-generated Package / Perk / Quest fragments |

Treat `tif__*`, `pf__*`, `prkf__*`, `qf__*` as machine-generated. Edit only with a clear reason; the CK regenerates and renames them.

## Important: CK-Filled Properties

Script properties filled via the Creation Kit in `SL Survival.esp` must **not** be removed from `.psc` files even if unused in code — removing them breaks the form binding and the script fails to load. To truly remove one you must also clear it in the ESP. When in doubt, leave it as dead weight.

## Papyrus Language Notes

### Control flow
- No `break` or `continue` — use flags or early `return`.
- Only `if/elseif/else/endif` and `while/endwhile`. No for-loops, switch, or do-while.
- `||` and `&&` short-circuit.

### Variables & types
- Base types `Bool`, `Int`, `Float`, `String`, plus object refs and arrays. Value types copy on assignment; objects/arrays are by reference.
- Locals are **function-scoped, not block-scoped** — declaring the same name in sibling `if` branches is a compile error; hoist it.
- Variables inside `while` loops persist across iterations (not reset). Initialize explicitly.
- Script-level variables initialize only with **literals**; function-level can use expressions.
- Reading a property/method off a `None` object yields `None` and logs `Assigning None to ::tempN` — always guard external casts (`Foo f = q as Foo` then `If f`).

### Arrays
- Max 128 elements; size must be an integer literal (`new int[128]`), not a variable.
- `array[i] += 5` does **not** compile — write `array[i] = array[i] + 5`.
- No arrays of arrays. Passed/assigned by reference.
- `Find()`/`RFind()` and SKSE string funcs are case-insensitive; `==` string comparison is case-sensitive.

### States & dispatch
- A script is in one state at a time; `GotoState("")` returns to the empty state. Call `GotoState()` *before* external calls (threading safety).
- State-overridable function/event signatures must exactly match the empty-state definition.
- An event/function defined **only** in the empty state still runs while in a named state (the empty state is the default). A *self*-call inside it dispatches to the **current** state's override — this is exactly how `_SLS_Interface*` routes through `"Installed"`.

### Threading
- One thread per script instance. **Any** external call (including `Debug.Trace()` or a property read on another object) unlocks the script — local assumptions about state may be stale after it returns. Own-variable/array ops do not unlock.

### Misc gotchas
- The compiler does not check all paths for return values — missing returns are undefined behavior.
- `parent.Func()` calls one level up, not necessarily the base.
- Unary minus needs spaces: `x = y - 1`, not `x = y-1`.

## Code Conventions
- Keep edits ASCII unless the file already contains non-ASCII.
- Comments explain *why* (a hidden constraint, an invariant, a mod-version workaround), not *what*.
- After fixing an `_SLS_Int*`/`_SLS_Interface*` bug, recompile just that script (see *Build*) and confirm `0 error(s), 0 warning(s)`.

## Project Structure

```
SL Survival.esp        Main plugin (forms, quests, dialogue, CK-filled properties)
SLSurvival.bsa         Packed assets
skyrimse.ppj           Papyrus project (import list, packaging config)
scripts/               Compiled *.pex (loose, loaded over the BSA)
scripts/source/        *.psc sources (812) — edit here
interface/             MCM translations, UI
seq/  sound/  meshes/  textures/   Game assets
dependencies/          Bundled *.psc sources for every imported mod (compile-time only)
Build/                 Zip output target
readme.md              Dev-env links + terse change notes
```

`dependencies/` is the source-of-truth for what external API a given `_SLS_Int*` is allowed to call — grep there to confirm a function/script name exists before relying on it.
