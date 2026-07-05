# Getting Started

SexLab Survival (SLS) is a large survival and gameplay overhaul built on the SexLab framework. This page covers what you need, how to install it, and what to expect on first launch.

!!! warning "Adult content"
    SLS is an adult (18+) mod. It depends on the SexLab framework and other LoversLab mods and includes explicit sexual content. Do not install it unless you are of legal age and understand what SexLab adds to your game.

!!! danger "New to SLS? Start a new game"
    SLS is extremely script-heavy, and adding it to a save that never had it can bake stale scripts and half-initialised quests into that save. Installing SexLab Survival for the first time? **Start a new game.**

    **Updating an existing SLS install with this patch is fine on your current save** — it's a script/plugin update, and SLS migrates its own state on load. Back up first, as with any mod update.

## Requirements

SLS is built on a core stack of framework mods. All of these must be installed and working before SLS will function:

!!! danger "This release is a patch over the original SexLab Survival"
    This build ships only SexLab Survival's own plugin, scripts and data. **Monoman1's original SexLab Survival supplies the textures, meshes and sound** and must be installed **first, below this patch** in your mod manager so this patch's files win. Get the original from the [SexLab Survival forum thread](https://www.loverslab.com/topic/99955-sexlab-survival/) (download in the posts). Without it you will see missing meshes and purple textures.

| Dependency | Purpose |
|------------|---------|
| SexLab framework | Core animation/scene framework SLS is built on |
| SexLab Aroused (SLA) | Arousal tracking used across SLS mechanics |
| Devious Devices | Restraints/bondage devices |
| ZaZ Animation Pack (ZAP) | Animations and bondage furniture |
| FNIS **or** Nemesis | Animation behaviour generation (run one after install) |
| SkyUI / MCM | Required for the SLS configuration menu |
| PapyrusUtil / StorageUtil | Data storage backend SLS relies on |

Beyond the core stack, SLS integrates with **dozens of optional** survival and LoversLab mods. Each integration activates only if that mod is present, so missing ones are safely ignored. See [Mod Integrations](integrations.md) for the full list of what each optional mod unlocks.

!!! note "The LoversLab page is authoritative"
    Exact required versions and the complete dependency list evolve between releases. Always treat the [SexLab Survival LoversLab file page](https://www.loverslab.com/files/file/5914-sexlab-survival/) as the authoritative requirement list and install its listed versions.

## Installation

1. Use a **mod manager** — Mod Organizer 2 (MO2) is recommended. Manual installation is not supported.
2. Install all core dependencies above (and any optional integrations you want) first.
3. Install Monoman1's original **[SexLab Survival](https://www.loverslab.com/topic/99955-sexlab-survival/)** (from the thread posts) — it supplies the textures, meshes and sound. Then install **this patch** and place it **below the original** (higher priority) so its updated scripts and plugin win. The patch's base files (`SL Survival.esp`, loose scripts, MCM translations, SKSE data) are always installed; the **FOMOD installer** then offers a "Select Any" group of optional patches — check the ones matching your setup:
    - **SunHelm Survival Patch** — needs/fatigue/sleep integration; requires SunHelm Survival. Leave unchecked if you use iNeed/Frostfall/RND instead.
    - **Bikini Armor Break (TAWoBA)** — armor-break configs/meshes; requires The Amazing World of Bikini Armors REMASTERED.
    - **Animal Friend Teammates** — tamed animals follow and fight as teammates (off by default; can be unreliable).
    - **Battle Wound / Bruise Textures** — extra bruise body-overlay textures for the wound system.
4. **Run FNIS or Nemesis** after installing SLS (and any time you add or remove animation mods). Skipping this leaves animations broken.
5. Launch the game through your mod manager.

!!! tip "Check your load order"
    Let your mod manager sort the load order, and resolve any reported conflicts or missing masters before launching. A missing master will prevent the game (and SLS) from loading correctly.

## First Launch

SLS is script-heavy and registers a lot of content on startup.

- On a fresh save, wait for the **MCM to register** — this can take a minute or two. You'll normally see a notification when SexLab Survival is added to the MCM.
- **Configure the MCM before playing.** Set your options first; some systems assume you've reviewed their settings. See the [MCM Reference](mcm-reference.md) for a page-by-page overview.
- Give the game a moment to settle after loading before diving into gameplay, especially on the first load.

## Troubleshooting: "SexLab Survival doesn't appear in the MCM"

If the SLS entry is missing from your MCM list, work through these in order:

1. **Wait longer.** On a heavy load order the MCM can take a couple of minutes to populate. Then **save and reload** — this often forces late-registering menus to appear.
2. **Confirm SkyUI is installed and working.** No SkyUI means no MCM at all.
3. **Confirm PapyrusUtil / StorageUtil is installed.** SLS depends on it; if it's missing, scripts fail to initialise.
4. **Confirm this patch overrides the original.** Its loose scripts must win over the original SexLab Survival's — place this patch **below** the original (higher priority) in your mod manager. If the original's older scripts load instead, the MCM and fixes won't appear.
5. **Check the Papyrus log.** Enable Papyrus logging and look for errors referencing SLS or its dependencies — missing masters, `None` casts, or unresolved types point at the real problem.

!!! tip "Still stuck?"
    Compare your installed dependency versions against the [LoversLab file page](https://www.loverslab.com/files/file/5914-sexlab-survival/). A version mismatch on a core framework is a common cause of silent failures.
