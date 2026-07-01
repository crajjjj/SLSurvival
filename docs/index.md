# SexLab Survival

A large Skyrim SE gameplay and survival overhaul. It layers a web of interlocking pressures on the player — needs, licences, tolls, misogyny, trauma — and ties them together with **dozens of optional LoversLab and survival mods** through a consistent adapter layer, so the mod keeps running no matter which of those you happen to have installed.

SexLab Survival is **pure Papyrus** — it ships no SKSE plugin of its own. Everything is driven by scripts, a single plugin (`SL Survival.esp`), and a packed archive of assets.

!!! warning "Adult content"
    SexLab Survival is a mature (18+) mod built on the SexLab framework. It depends on adult mods from [LoversLab](https://www.loverslab.com/files/file/5914-sexlab-survival/) and is not available on the Nexus. These docs describe gameplay systems and configuration; install the mod only where that is appropriate.

These docs are split into two tracks. Pick the one that fits you.

## For Players

Install it, play it, configure it. Start here if you just want to use the mod.

- [Getting Started](players/getting-started.md) — requirements, load order, and "it doesn't show up in the MCM" fixes
- [Needs & Survival](players/needs.md) — hunger, thirst, warmth and how SLS layers on SunHelm / Frostfall / iNeed
- [Licences](players/licences.md) — the permit system: weapons, dress, magic, freedom and how to buy them
- [Tolls, Eviction & Gates](players/tolls-eviction-gates.md) — city gate tolls, inn eviction, and paying your way in
- [Misogyny & Inequality](players/misogyny.md) — how the world treats a woman with no licences
- [Sex, Trauma & Effects](players/sex-and-effects.md) — sex experience, corruption, ahegao, trauma and arousal effects
- [Cum & Bukkake](players/cum.md) — cum layering, visibility, cleaning up, and the social consequences
- [Bikini Armors & EXP](players/bikini-armors.md) — the bikini-armor rating system and skill EXP tuning
- [Begging & Kennel](players/begging-kennel.md) — earning coin the hard way, and the kennel
- [Stashes, Pickpocket & Dismemberment](players/stashes-pickpocket.md) — hidden stashes, pickpocket rules, and the grimmer penalties
- [Mod Integrations](players/integrations.md) — the full list of supported optional mods and what each unlocks
- [MCM Reference](players/mcm-reference.md) — every MCM page at a glance

## For Mod Authors

Understand how SLS is built, or extend it without breaking the whole thing.

- [Overview](authors/overview.md) — the plugin, the BSA, and where everything lives in the source tree
- [Adapter Architecture](authors/adapter-architecture.md) — the `_SLS_Int*` / `_SLS_Interface*` pair pattern that lets SLS survive missing mods **(read this first)**
- [Adding an Integration](authors/adding-an-integration.md) — a step-by-step recipe for wiring in a new optional mod
- [Papyrus Gotchas](authors/papyrus-gotchas.md) — the language quirks that bite everyone working in this codebase
- [Building from Source](authors/building.md) — the Papyrus compiler, the single-file recompile trick, and packaging

---

The changelog and downloads live on the [LoversLab file page](https://www.loverslab.com/files/file/5914-sexlab-survival/). Source is on [GitHub](https://github.com/crajjjj/SLSurvival).
