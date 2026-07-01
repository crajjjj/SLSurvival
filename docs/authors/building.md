# Building from Source

SexLab Survival compiles with the **Skyrim SE Papyrus compiler**. Sources live in `scripts/source/*.psc`; compiled `*.pex` go to `scripts/` (loaded loose over the BSA). The project file `skyrimse.ppj` defines the full import list — **54 import folders**, mostly bundled under `dependencies/`.

## The #1 pain point: compiling a single changed script

You cannot compile one SLS script with a bare import list. SLS scripts transitively pull in SexLab / Devious Devices / FNIS types (`MfgConsoleFunc`, `FNIS_aa`, `NiOverride`, …). A short import list fails **type resolution on dependencies you never touched**.

!!! danger "You must pass the project's *entire* import list"
    Type resolution needs every one of the 54 import folders, even when your edit only touches one script. The reliable way to get them all is to read them straight out of `skyrimse.ppj`.

## Working single-file recompile

Run this from the project root in PowerShell. It parses the import list out of `skyrimse.ppj`, expands the two path variables, and compiles one script:

```powershell
[xml]$ppj = Get-Content "skyrimse.ppj"
$vars = @{ '@ImportsFolder'='.\scripts\source'; '@SkyrimScripts'='C:\SteamLibrary\steamapps\common\Skyrim Special Edition\Data\Source\Scripts' }
$imports = $ppj.PapyrusProject.Imports.Import | ForEach-Object {
  $v = $_; foreach ($k in $vars.Keys) { $v = $v -replace [regex]::Escape($k), $vars[$k] }; $v
}
$compiler = "C:\SteamLibrary\steamapps\common\Skyrim Special Edition\Papyrus Compiler\PapyrusCompiler.exe"
& $compiler "_SLS_IntCf.psc" -f="TESV_Papyrus_Flags.flg" -i="$(($imports -join ';'))" -o="scripts"
```

Notes:

- Replace `_SLS_IntCf.psc` with the script you're compiling, and adjust the two paths in `$vars` to your install.
- Output `.pex` lands in `scripts/`.
- `TESV_Papyrus_Flags.flg` is resolved via the vanilla `@SkyrimScripts` import path, **not** the project root.
- A clean result reads `0 error(s), 0 warning(s)`. Always confirm this after fixing an `_SLS_Int*` / `_SLS_Interface*` bug.

## `dependencies/` is compile-time only

The `.psc` sources under `dependencies/` exist **only** so the compiler can resolve external types. They are not part of SLS's runtime and are not shipped. They're also the **source of truth** for what external API a given `_SLS_Int*` may call — grep there to confirm a script or function name exists before you rely on it. See [Adding an Integration](adding-an-integration.md).

## Full build & packaging

Compiling the whole project and building the BSA is done via the `.ppj` (`Package="true"`, `Zip="true"`) in the normal toolchain — do that only when you specifically intend to package a release, not for iterating on one script.

!!! warning "BSA name must match the plugin"
    The packaged archive must be named `SL Survival.bsa` to match `SL Survival.esp`. A mismatched name (e.g. `SLSurvival.bsa`) means the engine never loads the archive — no scripts, and the MCM silently disappears.

## Editing the docs

This documentation site is separate from the game build. It's an [MkDocs Material](https://squidfunk.github.io/mkdocs-material/) site under `docs/`, published to GitHub Pages by `.github/workflows/docs.yml` on every push to `main` that touches `docs/**` or `mkdocs.yml`.

To preview locally:

```bash
pip install mkdocs-material
mkdocs serve      # live preview at http://127.0.0.1:8000
mkdocs build --strict   # what CI runs; fails on broken links
```
