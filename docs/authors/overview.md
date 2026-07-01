# Overview

SexLab Survival is a **pure Papyrus** mod. There is no SKSE plugin of its own — everything is scripts, one plugin, and a packed archive of assets. If you have worked on a C++/CommonLibSSE mod, set that mental model aside: the entire mod is Creation Kit forms plus ~800 `.psc` scripts.

## What ships

| File | Role |
|------|------|
| `SL Survival.esp` | The main plugin — all forms, quests, dialogue, magic effects, and the **CK-filled script properties** that bind scripts to forms. |
| `SL Survival.bsa` | Packed assets (scripts, meshes, textures, sound, SEQ). |
| `scripts/` | Compiled `*.pex`, loaded **loose** over the BSA. |
| `scripts/source/` | The `*.psc` sources — **this is where you edit** (812 scripts). |
| `interface/` | MCM translation files and UI. |
| `skyrimse.ppj` | Papyrus project file: the full 54-folder import list and packaging config. |
| `fomod/` | The FOMOD installer definition (optional patches). |
| `dependencies/` | Bundled `.psc` sources for every imported external mod — **compile-time only**. |

!!! warning "The BSA name must match the plugin"
    The packaged archive **must** be named `SL Survival.bsa` (matching `SL Survival.esp`), not `SLSurvival.bsa`. If the names don't match, the engine won't load the archive — no scripts load and the MCM silently vanishes.

## Source tree at a glance

```
SL Survival.esp        Main plugin (forms, quests, dialogue, CK-filled properties)
SL Survival.bsa        Packed assets
skyrimse.ppj           Papyrus project (import list, packaging config)
scripts/               Compiled *.pex (loose, loaded over the BSA)
scripts/source/        *.psc sources (812) — edit here
interface/             MCM translations, UI
seq/  sound/  meshes/  textures/   Game assets
dependencies/          Bundled *.psc sources for every imported mod (compile-time only)
fomod/                 FOMOD installer with optional patches
Build/                 Zip output target
```

## How the code is organized

Nearly everything in SLS falls into one of a few naming buckets:

| Prefix | Meaning |
|--------|---------|
| `_SLS_Interface*` | Adapter **quest** — a state machine that gates on whether an external mod is installed. |
| `_SLS_Int*` | Hidden **global** wrappers around one external mod's API. |
| `_SLS_*` / `sls_*` | SLS gameplay scripts (quests, aliases, magic effects, triggers). |
| `tif__<formid>` | CK-generated **Topic Info Fragment** (dialogue). ~502 of these. |
| `pf__*` / `prkf__*` / `qf__*` | CK-generated Package / Perk / Quest fragments. |

The `_SLS_Interface*` / `_SLS_Int*` pair is the heart of the mod's resilience and the first thing to understand — see [Adapter Architecture](adapter-architecture.md).

!!! danger "Don't hand-author the CK-generated fragments"
    `tif__*`, `pf__*`, `prkf__*`, and `qf__*` are owned by the Creation Kit. It regenerates and renames them. Edit them only with a clear reason.

## A note on CK-filled properties

Many script properties are filled through the Creation Kit and stored in `SL Survival.esp`. **Do not delete such a property from a `.psc` even if it looks unused** — removing it breaks the form binding and the whole script fails to load. To truly remove one you must also clear it on the form in the CK. When in doubt, leave it as dead weight.
