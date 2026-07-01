# Internals

A single reference for how SexLab Survival is built — for anyone reading the source, patching it, or wiring in a new optional mod. SLS is **pure Papyrus**: no SKSE plugin of its own, just Creation Kit forms plus ~800 `.psc` scripts, one plugin, and a packed archive.

## What ships

| File | Role |
|------|------|
| `SL Survival.esp` | The main plugin — all forms, quests, dialogue, magic effects, and the **CK-filled script properties** that bind scripts to forms. |
| `SL Survival.bsa` | Packed assets (scripts, meshes, textures, sound, SEQ). |
| `scripts/` | Compiled `*.pex`, loaded **loose** over the BSA. |
| `scripts/source/` | The `*.psc` sources — **this is where you edit**. |
| `interface/` | MCM translation files and UI. |
| `skyrimse.ppj` | Papyrus project file: the full 54-folder import list and packaging config. |
| `fomod/` | The FOMOD installer definition (optional patches). |
| `dependencies/` | Bundled `.psc` sources for every imported external mod — **compile-time only**. |

!!! warning "The BSA name must match the plugin"
    The packaged archive **must** be named `SL Survival.bsa` (matching `SL Survival.esp`), not `SLSurvival.bsa`. If the names don't match, the engine won't load the archive — no scripts load and the MCM silently vanishes.

## How the code is organized

Nearly everything falls into one of a few naming buckets:

| Prefix | Meaning |
|--------|---------|
| `_SLS_Interface*` | Adapter **quest** — a state machine that gates on whether an external mod is installed. |
| `_SLS_Int*` | Hidden **global** wrappers around one external mod's API. |
| `_SLS_*` / `sls_*` | SLS gameplay scripts (quests, aliases, magic effects, triggers). |
| `tif__<formid>` | CK-generated **Topic Info Fragment** (dialogue). ~502 of these. |
| `pf__*` / `prkf__*` / `qf__*` | CK-generated Package / Perk / Quest fragments. |

!!! danger "Don't hand-author the CK-generated fragments"
    `tif__*`, `pf__*`, `prkf__*`, and `qf__*` are owned by the Creation Kit — it regenerates and renames them. Edit them only with a clear reason.

!!! note "Don't delete CK-filled properties"
    Many script properties are filled through the Creation Kit and stored in `SL Survival.esp`. **Do not delete such a property from a `.psc` even if it looks unused** — removing it breaks the form binding and the whole script fails to load. To truly remove one you must also clear it on the form in the CK. When in doubt, leave it as dead weight.

## Adapter architecture (the important part)

SLS integrates with dozens of optional mods (Frostfall, Devious Devices, Creature Framework, Milk Mod Economy, SunHelm, …). Any of them may be absent on a given setup, yet SLS must load and run regardless. It does this by putting **every hard reference to an external mod behind an adapter pair**:

- **`_SLS_IntXxx.psc`** — `Scriptname _SLS_IntXxx Hidden`, only `Global` functions. This is the **only** place the external mod's concrete types/scripts are named (`FrostUtil`, `CampUtil`, `CreatureFrameworkConfig`, …). Thin one-line wrappers.
- **`_SLS_InterfaceXxx.psc`** — `extends Quest`. A two-state machine:
    - empty state `""` — the mod is treated as *not installed*; every method is a safe no-op returning a default;
    - `"Installed"` state — every method delegates to the matching `_SLS_IntXxx` global.

    `PlayerLoadsGame()` flips the state on `Game.GetModByName("Xxx.esm"/".esp")`.

!!! info "Why the split — properties resolve at load, globals resolve at call"
    A script-level **property** typed to an external script resolves at **script load**; if the type is missing, the *entire script fails to load*. A **global function call** resolves **lazily, at call time**. Keeping every hard external reference inside `_SLS_IntXxx` globals — only ever called from the Interface's `"Installed"` state — lets SLS load and run no matter which optional mods are present.

    This also explains the state routing: a function defined **only** in the empty state still runs while the quest is in a named state (the empty state is the default), and a **self-call** inside it dispatches to the **current** state's override. That is exactly how `_SLS_Interface*` routes a call through `"Installed"` into the `Int` globals.

```papyrus
Scriptname _SLS_InterfaceXxx extends Quest

Bool Function IsThing()      ; empty state = not installed
    Return false
EndFunction

Event PlayerLoadsGame()
    If Game.GetModByName("Xxx.esp") != 255
        GotoState("Installed")
    Else
        GotoState("")
    EndIf
EndEvent

State Installed
    Bool Function IsThing()
        Return _SLS_IntXxx.IsThing()   ; delegates to the global
    EndFunction
EndState
```

### The recurring bug: external scripts get renamed across versions

`_SLS_IntXxx` casts the external mod's config quest to a **specific script name**. If the player has a **newer version** where that script was renamed, the cast silently returns `None`, you get `warning: Assigning None to a non-object variable "::temp1"` in the Papyrus log, and the integration breaks **quietly** — reads return 0, writes no-op, no crash.

!!! example "Real fix from this repo"
    `_SLS_IntCf` cast to `CFConfigMenu` (old Creature Framework), but CF v4 ships `CreatureFrameworkConfig`. The cast returned `None` and creature integration silently died. Fix = update the cast **and guard it** so a future mismatch can't corrupt state:

    ```papyrus
    CreatureFrameworkConfig q = quest as CreatureFrameworkConfig
    If q          ; guard the cast
        ; safe to use q
    EndIf
    ```

When touching an `_SLS_IntXxx`, verify the cast target against the script actually attached to the form in `dependencies/<that mod>/Scripts/Source/` — that folder is the source of truth for the external API a given `_SLS_Int*` may call.

### Adding a new integration

1. **Confirm the external API** against `dependencies/<mod>/Scripts/Source/` — the exact script name and signatures. Don't trust an old forum post.
2. **Write `_SLS_IntXxx`** — `Hidden`, `Global` only, external type named *only* here, **every cast guarded** with `If`.
3. **Write `_SLS_InterfaceXxx`** — empty state returns safe defaults; `State Installed` delegates to the globals (signatures must match exactly); `PlayerLoadsGame()` flips state on `GetModByName`.
4. **Attach** the Interface to a quest in `SL Survival.esp` and fill any properties (SLS forms — **never** external types) in the CK.
5. **Call through the Interface** from gameplay code, never the `Int` directly and never the external mod.
6. **Compile** the two scripts and confirm `0 error(s), 0 warning(s)`; check the Papyrus log for the `::temp1` warning that signals a wrong cast target.

> The rule: never reference an external mod's type as a property. Wrap it in an `_SLS_IntXxx` global, gate it behind an `_SLS_InterfaceXxx` `"Installed"` state, and guard every cast.

## Papyrus gotchas

The language quirks that bite everyone working in this codebase — most are silent, the compiler won't warn you.

- **No `break`/`continue`.** Use flags or an early `Return`. Only `if/elseif/else` and `while`; no for-loops, switch, or do-while.
- **Locals are function-scoped, not block-scoped** — declaring the same name in two sibling `if` branches is a compile error; hoist it. Variables inside a `while` **persist across iterations**; initialize explicitly.
- **Script-level** variables initialize only with **literals**; function-level can use expressions.
- **The `None` trap:** reading a property/method off `None` yields `None` and logs `Assigning None to a non-object variable "::tempN"`. Always guard external casts (`Foo f = q as Foo` then `If f`).
- **Arrays:** max 128 elements, size must be an integer literal. `array[i] += 5` does **not** compile — write `array[i] = array[i] + 5`. No arrays of arrays. `Find()`/SKSE string funcs are case-insensitive; `==` on strings is case-sensitive.
- **Threading:** one thread per script instance; **any** external call (even `Debug.Trace()` or a property read on another object) unlocks the script, so post-call state may be stale. Own-variable/array ops don't unlock.
- **Misc:** the compiler doesn't check all paths for return values; `parent.Func()` calls one level up, not necessarily the base; unary minus needs spaces (`x = y - 1`, not `x = y-1`).
- **Conventions:** keep edits ASCII unless the file already has non-ASCII; comments explain *why* (a hidden constraint / version workaround), not *what*.

## Building from source

SLS compiles with the **Skyrim SE Papyrus compiler**. Sources live in `scripts/source/*.psc`; compiled `*.pex` go to `scripts/` (loaded loose over the BSA).

!!! danger "You must pass the project's *entire* import list"
    SLS scripts transitively pull in SexLab / Devious Devices / FNIS types (`MfgConsoleFunc`, `FNIS_aa`, `NiOverride`, …). A short import list fails type resolution on dependencies you never touched. The reliable way to get all 54 import folders is to read them straight out of `skyrimse.ppj`.

Working single-file recompile (PowerShell, from the project root):

```powershell
[xml]$ppj = Get-Content "skyrimse.ppj"
$vars = @{ '@ImportsFolder'='.\scripts\source'; '@SkyrimScripts'='C:\SteamLibrary\steamapps\common\Skyrim Special Edition\Data\Source\Scripts' }
$imports = $ppj.PapyrusProject.Imports.Import | ForEach-Object {
  $v = $_; foreach ($k in $vars.Keys) { $v = $v -replace [regex]::Escape($k), $vars[$k] }; $v
}
$compiler = "C:\SteamLibrary\steamapps\common\Skyrim Special Edition\Papyrus Compiler\PapyrusCompiler.exe"
& $compiler "_SLS_IntCf.psc" -f="TESV_Papyrus_Flags.flg" -i="$(($imports -join ';'))" -o="scripts"
```

- Replace `_SLS_IntCf.psc` with the script you're compiling; adjust the two paths in `$vars` to your install.
- Output `.pex` lands in `scripts/`. A clean result reads `0 error(s), 0 warning(s)`.
- `TESV_Papyrus_Flags.flg` resolves via the vanilla `@SkyrimScripts` import path, not the project root.
- Full build / BSA packaging is done via the `.ppj` (`Package="true"`, `Zip="true"`) — only when packaging a release.

### Editing these docs

This site is [MkDocs Material](https://squidfunk.github.io/mkdocs-material/) under `docs/`, published to GitHub Pages by `.github/workflows/docs.yml` on every push to `main` touching `docs/**` or `mkdocs.yml`. Preview locally:

```bash
pip install mkdocs-material
mkdocs serve            # live preview at http://127.0.0.1:8000
mkdocs build --strict   # what CI runs; fails on broken links
```
