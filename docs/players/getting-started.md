# Getting Started

SexLab Survival (SLS) is a large survival and gameplay overhaul built on the SexLab framework. This page covers what you need, how to install it, and what to expect on first launch.

!!! warning "Adult content"
    SLS is an adult (18+) mod. It depends on the SexLab framework and other LoversLab mods and includes explicit sexual content. Do not install it unless you are of legal age and understand what SexLab adds to your game.

!!! danger "Start a new game"
    SLS is extremely script-heavy. Adding it (or any large scripted mod) mid-playthrough can leave stale scripts, half-initialised quests, and broken state baked into your save. **Start a new game** after installing. If you must test on an existing save, expect problems and keep a backup.

## Requirements

SLS is built on a core stack of framework mods. All of these must be installed and working before SLS will function:

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
3. Install SLS. The base mod (`SL Survival.esp` + `SL Survival.bsa` + meshes/textures/SKSE) is always installed; the **FOMOD installer** then offers a "Select Any" group of optional patches — check the ones matching your setup:
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
4. **Confirm the SLS scripts actually loaded.** Check that the mod's BSA is named correctly and that its scripts are present. If scripts didn't load, the MCM can't register.
5. **Check the Papyrus log.** Enable Papyrus logging and look for errors referencing SLS or its dependencies — missing masters, `None` casts, or unresolved types point at the real problem.

!!! tip "Still stuck?"
    Compare your installed dependency versions against the [LoversLab file page](https://www.loverslab.com/files/file/5914-sexlab-survival/). A version mismatch on a core framework is a common cause of silent failures.
