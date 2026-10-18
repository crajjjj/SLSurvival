# SexLab Survival — Project Notes for Claude

Large Skyrim SE gameplay/survival overhaul mod. Written in **Papyrus** (`.psc` → `.pex`), plus a small optional SKSE plugin (`plugin/`, see *Native plugin*). ~812 source scripts. Heavily integrates with dozens of optional LoversLab/survival mods through a consistent adapter layer (see *Adapter Architecture* — it is the most important thing in this project).

Current version: **0.800** (`meta.ini`).

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
- Compiling the whole project / packaging is done via the `.ppj` in the user's normal toolchain — only do that when asked. The patch build uses `Package="false"` (no BSA; loose scripts) + `Zip="true"`; a standalone build sets `Package="true"` to pack `SL Survival.bsa`.

### Release zip

**Preferred path:** the user's toolchain runs Pyro on the `.ppj`, which drops `Build/SLSurvival patch.zip` (unversioned `@ModName`). If that file exists and is *current* — newer than the latest shipped-file change, correct entry count, `fomod/info.xml` inside reports the version being released — just copy/rename it to the versioned name. Pyro's zlib deflate is ~2% tighter than .NET's; the archives are otherwise interchangeable.

**Fallback (Pyro output absent or stale):** build from the **`<ZipFiles>` manifest in `skyrimse.ppj`** — read the `<Match In="...">pattern</Match>` and `<Include>` entries from the ppj rather than hardcoding a file list, so manifest changes flow into the build automatically. Pyro isn't on PATH for Claude; build the archive directly (PowerShell `System.IO.Compression`, entry paths relative to the project root with forward slashes, `CompressionLevel.SmallestSize`). Manifest semantics: `Match In="scripts"` with `*.pex` catches top-level `.pex` only (`scripts/source` has no pex), the other `Match` folders are recursive.

Either way the output is `Build/SLSurvival patch X.YYY.zip` (GitHub dot-normalizes the name on upload — expected). Sanity-check: `fomod/info.xml` inside the zip must report the released version, and the entry count should only change when files were actually added/removed (0.707–0.709 are all 1099 entries).

## Native plugin (`plugin/`)

`SLSurvival.dll` (CommonLibSSE-NG v7.1.0 submodule at `plugin/lib/commonlibsse-ng`, GPL-3.0+ with exceptions; xmake 3.0, VS 2022) takes over SLS's costliest Papyrus paths. Build with `plugin\build.ps1`: it stamps the version from `fomod/info.xml` (X.YYY becomes X.(YYY/100).(YYY%100), because a packed SKSE version has 8 bits of minor) and copies the DLL to `SKSE/Plugins/`, which the FOMOD and the ppj zip ship. The folder is `plugin/`, not `skse/`: Windows folds that onto the shipped `SKSE/` folder. `plugin/xmake.lua` re-points the commonlib rule's install into `plugin/build` and the build script unsets `XSE_TES5_MODS_PATH`, or every build drops a folder into the live MO2 mods directory.

Natives live in the Hidden script `_SLS_Native` (`GetAPIVersion`, `FillQuestAliases`, `HasContraband`). Rules:
- SLS must run without the DLL: every caller checks `_SLS_Native.IsLoaded()` and keeps its Papyrus path. Unbound natives log an error per call.
- A native that reproduces Papyrus logic is a twin: `HasContraband` = `_SLS_LicenceUtil.ActorHasArmor`/`HasWeapon`/`HasMagicItem`/`HasClothes`. Change both or neither.
- Never change a released native's signature (strict arity in the VM); add a new one and bump `API_VERSION` in `plugin/src/Papyrus.cpp`.
- Natives touching game state register with "callable from tasklets" false, so they run on the main thread.
- Never return an empty vector to Papyrus (it arrives as None); `FillQuestAliases` always returns one entry per alias.

Not done yet: the equip fan-out (one player equip wakes up to 18 SLS scripts). It needs either the per-script handlers moved behind one dispatcher (a large Papyrus change) or a filter on the VM's event dispatch.

## Versioning (bumping the release)

Only bump when the **current** version is git-tagged (released); if it's untagged, fold new changes into the existing version and just commit (see the global "don't double-bump" rule). Bumping to `X.YYY` means updating **four** places — the first three are the release marker, the fourth is the *in-game* version:

1. `meta.ini` → `version=X.YYY.0.0`. **Gitignored** (MO2 per-mod metadata) — update it locally so MO2 shows the right version, but it won't appear in the commit.
2. `fomod/info.xml` → `<Version>X.YYY</Version>`. Tracked; this is the real committed release marker.
3. `CLAUDE.md` → the "Current version" line at the top of this file.
4. `scripts/source/sls_main.psc` → the in-game `Version` float (this is what the **MCM** displays via `Main.Version`, and it doubles as the save-migration counter). Easy to forget — `0.701`/`0.702` did, so the MCM read `0.700` for three releases. To move it:
   - `OnInit`: set the new-game baseline `Version = X.YYY`.
   - End of `VersionCheck()`: add a stamp gate **outside** the `If Version < 0.700` wrapper — `If Version < X.YYY` / `UpdateVersion(X.YYY)` / `EndIf` — so existing saves also update the displayed version. Put *real* data-migration work for the release **inside** its own gate here only if the release needs it; a pure version bump just needs the stamp.
   - Recompile `sls_main.pex` (see *Build*) and confirm `0 error(s), 0 warning(s)`.

Skip step 4 if you deliberately want the MCM version to lag (script-only hotfix with no migration) — but the default is to keep it in sync. Don't create the `X.YYY` git tag yourself; tagging is the user's "this shipped" signal.

## Adapter Architecture (read this first)

Every optional-mod integration is split into a **pair**, so SLS keeps working when the other mod is absent:

- **`_SLS_IntXxx.psc`** — `Scriptname _SLS_IntXxx Hidden`, only `Global` functions. These are the *only* place that references the external mod's concrete types/scripts (e.g. `FrostUtil`, `CampUtil`, `CreatureFrameworkConfig`). Thin one-line wrappers. 59 of these. (Exception: `_SLS_IntAudioUtil` wraps an SKSE-only plugin with no plugin file, so it has no Interface quest — each wrapper self-guards on `SKSE.GetPluginVersion`, like `_SLS_IntSlpp`.)
- **`_SLS_InterfaceXxx.psc`** — `extends Quest`. Holds a two-state machine: empty state `""` (mod not installed → all methods are safe no-ops returning defaults) and `"Installed"` (delegates to the `_SLS_IntXxx` globals). `PlayerLoadsGame()` flips state based on `Game.GetModByName("Xxx.esm/.esp")`. 29 of these.

Why the split: a script-level **property** typed to an external script resolves at *script load* — if the type is missing the whole script fails to load. A **global function call** resolves *lazily at call time*. Putting every hard reference behind `_SLS_IntXxx` globals, gated by the Interface's `"Installed"` state, lets SLS load and run regardless of which optional mods are present.

### Gotcha: external scripts get renamed across versions
`_SLS_IntXxx` casts the external mod's MCM/config quest to a specific script name. If the user has a **newer version** of that mod where the script was renamed, the cast silently returns `None`, you get a `warning: Assigning None to a non-object variable "::temp1"` in the Papyrus log, and the integration breaks quietly (reads return 0, writes no-op). Real example fixed in this repo: `_SLS_IntCf` cast to `CFConfigMenu` (old CF) but CF v4 ships `CreatureFrameworkConfig`. Fix = update the cast to the installed mod's script name **and** guard the cast (`If (q as Type)`) so a future mismatch can't corrupt state. When touching an `_SLS_IntXxx`, verify the cast target against the script actually attached to the form in `dependencies/<that mod>/Scripts/Source/`.

### Gotcha: SexLab P+ has two interaction APIs
P+ 2.19 removed the 2.17.1 - 2.18 collision API (`CTYPE_*`, `HasInteractionType`, `GetPartnerByType`) in favour of per-actor InterType flags. `_SLS_IntSlpp` carries both paths and picks one by the `SexLabUtil` DLL version (`HasInterTypeApi()`, 2.19.0.0 = 34799616). The 2.19 functions are declared as stubs at the end of the bundled `dependencies/SexLab Framework PPLUS/Source/Scripts/SexLabThread.psc`, which is otherwise a 2.18-era header: keep that block when refreshing the header, and use literal 2.19 InterType indices in the 2.19 path, because the header's property values are still 2.18's.

### Gotcha: the plugin carries no vanilla-record copies (SkyPatcher)
Since 0.800 `SL Survival.esp` no longer overrides the vanilla records SLS only adds to: the 21 playable and vampire races (Inequality ability), 97 merchant/treasure chests, 6 VendorGold lists, the travelling merchant, plus stale copies of Iron Dagger, WEQuestNode and an empty Riften cell. Those were LE-era copies that reverted USSEP/DLC edits because SLS loads late. The additions live in `SKSE/Plugins/SkyPatcher/{race,container,leveledList,npc}/SLS SkyPatcher Patch/SL Survival.esp.ini`, applied to whichever record wins, so SkyPatcher is a requirement. Add to a vanilla list there, never by overriding the record in the plugin. The cut was byte surgery on the 0.716 plugin (every other record byte-identical, masters unchanged), not a re-save; prefer the same for future plugin cleanups over a tool re-serialisation. `seq/SL Survival.seq` lists the plugin's own start-game-enabled quests: regenerate it when one is added.

### Gotcha: SunHelm lives in the core scripts
The SunHelm adapter (`_SLS_IntShs`/`_SLS_InterfaceShs`) and `_SLS_Needs`'s `State Shs` ship in the base scripts since 0.800; the optional SunHelm patch is only `SL Survival Sunhelm Patch.esp` (fills `_SLS_Needs.Shs`, adds `_SLS_InterfaceShsQuest`) plus its `SleepDepriv.json`. `PickNeedsState` takes `Shs` only when that property is filled. Creation Club Survival Mode (`State Ccs`, `_SLS_IntCcs`) is picked on its plugin, which every AE install has: each Ccs function checks the Survival Mode switch itself and acts like the empty state while it is off, because a new game picks the state before the player answers Survival Mode's prompt. `dependencies/WetFunction NG` is a hand-written compile-only header (signatures read off a compiled call site), not the mod's source.

### Gotcha: UBE overlays need their own textures
UBE 2.0 races use a different UV layout (body, hands and feet share one atlas; the head has its own), so an overlay drawn for the vanilla/CBBE layout lands in the wrong place on them. Wounds pick `BattleWounds_UBE` in `_SLS_Trauma` (0.719); every other SLS overlay goes through `sls_utility.OverlayTextureFor`, which swaps `\SL Survival\<file>.dds` for `\SL Survival\UBE\<Area>\<file>.dds` on a UBE-race actor when that file is installed (0.800), and removal/lookup match either copy. Both sets ship in the optional `optional/BattleWoundsUBE`. On the SlaveTats path, SlaveTats NG's UBE build prefixes `UBE\` itself, so the SlaveTats Pack carries `slavetats/UBE/...` copies. A new overlay needs a UBE copy per area it can go on: `tools/ube/convert.py` bakes them with Grognak's UBE_Tex_Convert blend (not bundled) through Blender, and writes a blank texture for an area the overlay paints nothing on.

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

## Dialogue Authoring (Creation Kit)

- **Never use angle brackets in player dialogue prompts.** Player choice text like `<Walk away>` renders as **invisible/blank dialogue** in-game — the engine treats `<...>` as markup and eats it. Use square brackets instead: `[Walk away]`. This text lives in the plugin's DIAL/INFO records (edit in the CK), not in the `.psc` sources, so it can't be fixed by recompiling — fix it on the topic in `SL Survival.esp`.

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
- Keep edits ASCII in code and data files (`.psc`, `.json`, `.yml`, `.xml`) unless the file already contains non-ASCII. Markdown prose (`docs/**`, `README.md`) may use typographic punctuation (em dash, ellipsis, arrows).
- Comments explain *why* (a hidden constraint, an invariant, a mod-version workaround), not *what*.
- After fixing an `_SLS_Int*`/`_SLS_Interface*` bug, recompile just that script (see *Build*) and confirm `0 error(s), 0 warning(s)`.

## Project Structure

```
SL Survival.esp        Main plugin (forms, quests, dialogue, CK-filled properties)
SL Survival.bsa        Packed assets (standalone build only; the patch ships loose scripts)
skyrimse.ppj           Papyrus project (import list, packaging config)
scripts/               Compiled *.pex (loose; the patch ships these, overriding the original)
scripts/source/        *.psc sources (~820), edit here
interface/             MCM translations, UI
seq/                   SL Survival.seq (shipped: the original's predates a third of the start-game quests)
sound/  meshes/  textures/   Game assets (inherited from the original mod, not shipped by the patch)
SKSE/Plugins/          StorageUtilData JSON, SkyPatcher INIs, AudioUtil config (shipped)
optional/              FOMOD optional patches, one folder each (see fomod/ModuleConfig.xml)
plugin/                SLSurvival.dll source (C++, xmake; see Native plugin)
dependencies/          Bundled *.psc sources for every imported mod (compile-time only)
docs/                  MkDocs player guide + internals (published to GitHub Pages)
mkdocs.yml             MkDocs Material site config (nav, theme, extensions)
.github/workflows/     CI — docs.yml builds and deploys the docs site
Build/                 Zip output target
README.md              Public landing page — badges, download, docs links
```

`dependencies/` is the source-of-truth for what external API a given `_SLS_Int*` is allowed to call — grep there to confirm a function/script name exists before relying on it.
