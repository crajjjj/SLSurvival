# Mod Integrations

SexLab Survival's signature design is that it plays well with a large ecosystem of optional survival and LoversLab mods. Every one of these integrations is **dormant until SLS detects the other mod** — if a supported mod is present its features light up; if it's absent SLS quietly skips it, with no broken quests and no missing-master errors from the integration itself.

!!! note "How this works under the hood"
    Each integration is gated behind a mod-presence check (`Game.GetModByName(...)`) and, for most, a paired adapter layer. The technical design is documented on the [Internals](../internals.md#adapter-architecture-the-important-part) page.

You don't need any of these. Install the ones you want and SLS adapts.

## Survival & needs

| Mod | What it unlocks |
|-----|-----------------|
| Frostfall | Cold/exposure gating feeds SLS; surfaced on the **Frostfall & Simply Knock** MCM page |
| iNeed | Hunger/thirst needs drive SLS consequences |
| Realistic Needs and Diseases (RND) | Needs source SLS reads |
| Eating Sleeping Drinking | Needs source SLS reads |
| SunHelm Survival | Needs/fatigue/sleep integration — installed via the **optional FOMOD patch** (not the base scripts) |
| Campfire | Enables camping actions in the SLS survival wheel menu |
| Hunterborn | Hunting/harvest integration (hunter's cache) |

## Devious devices & bondage

| Mod | What it unlocks |
|-----|-----------------|
| Devious Devices (Expansion) | Restraints drive licences, tolls, begging and device-slot logic |
| Deviously Cursed Loot | Cursed-loot events are tracked and interact with SLS |
| Devious Followers | Follower debt/will and resistance-loss mechanics |
| ZaZ Animation Pack | Slave factions and bondage furniture effects |
| Amputator Framework | Optional visual-effects framework support |

## Sex frameworks, arousal & scenes

| Mod | What it unlocks |
|-----|-----------------|
| SexLab Aroused | Arousal state drives many SLS effects and NPC reactions |
| SexLab Separate Orgasm (SLSO) | Orgasm framework used by the "must orgasm" rules |
| SexLab - Sexual Fame [SLSF] | Sexual-fame reputation feeds SLS |
| Apropos 2 | Wear-and-tear scene descriptions |
| SexLab Dialogues | Extra dialogue/rest effect |
| Creature Framework | Creature mod framework support |
| SlaveTats | Tattoo/overlay integration for SLS-applied body marks |
| Rape Tattoos | Tattoo integration |

## Body, cum & scaling

| Mod | What it unlocks |
|-----|-----------------|
| SexLab Inflation Framework (SLIF) | Coordinated belly/breast/ass scaling (see **SLIF Max Scaling** in the MCM) |
| Schlongs of Skyrim (SOS) | Genital state/scaling integration |
| Fill Her Up (FHU) | Cum-inflation visuals tie into the [Cum](cum.md) system |

## Milk & drugs

| Mod | What it unlocks |
|-----|-----------------|
| Milk Mod Economy (MME) | Lactation/milking recognised; milk offered/demanded in tolls |
| Milk Addict | Milk-addiction pool integration |
| SexLab Skooma Whore | Drug lists power forced-drugging and drug toll demands |
| Soulgem Oven | Adapter exists but is **deliberately left disabled** in the current build |

## Slavery & prostitution

| Mod | What it unlocks |
|-----|-----------------|
| Slaverun Reloaded | Slavery-themed content integration |
| Simple Slavery | Handoff integration for certain failure outcomes |
| Sanguine's Debauchery | Handoff integration as an alternative outcome |
| TDF Aggressive Prostitution | Dancing offered as a toll payment |
| SexLab Pay Crime (Pay Sex Crime) | Pay off bounties with sex |
| Paradise Halls | Slave faction recognised |
| Sexy Bandit Captives | Captor faction recognised |

## Fertility, followers & flavour

| Mod | What it unlocks |
|-----|-----------------|
| Fertility Mode **or** Beeing Female | Pregnancy/fertility state; provides the "Fertility" drug used in toll drug events |
| Player Succubus Quest (PSQ) | Succubus state integration |
| Extensible Follower Framework (EFF) | Follower framework support (e.g. followers stealing gold) |
| FNIS Sexy Move | Walk-style integration |
| Spank That Ass | Spanking integration |
| yps Immersive Fashion | Piercings/hair/nails (requires the tweak version) |
| Simply Knock | Knock-to-enter / trespassing handling (**Frostfall & Simply Knock** MCM page) |
| JKs Skyrim | Adds the extra Riften gate as a toll door |
| Dawnguard | Adds a voice type used in creature-race handling |

!!! note "The list evolves"
    Supported mods and their required versions change between SLS releases, and this table reflects the integrations present in the current source. Treat the [SexLab Survival LoversLab page](https://www.loverslab.com/files/file/5914-sexlab-survival/) as the authoritative, current list.

## Toggling integrations

Detected integrations are surfaced and toggled on the **Interfaces** page of the SLS MCM. See the [MCM Reference](mcm-reference.md) for where each control lives.
