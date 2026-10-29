# Mod Integrations

SexLab Survival's signature design is that it plays well with a large ecosystem of optional survival and LoversLab mods. Every one of these integrations is **dormant until SLS detects the other mod** — if a supported mod is present its features light up; if it's absent SLS quietly skips it, with no broken quests and no missing-master errors from the integration itself.

!!! note "How this works under the hood"
    Each integration is gated behind a mod-presence check (`Game.GetModByName(...)`) and, for most, a paired adapter layer. The technical design is documented on the [Internals](../internals.md#adapter-architecture-the-important-part) page.

You don't need any of these. Install the ones you want and SLS adapts.

## Survival & needs

| Mod | What it unlocks |
|-----|-----------------|
| Frostfall | Cold/exposure gating feeds SLS; surfaced on the **Frostfall & Door Knocking** MCM page |
| iNeed | Hunger/thirst needs drive SLS consequences |
| Realistic Needs and Diseases (RND) | Needs source SLS reads |
| Eating Sleeping Drinking | Needs source SLS reads |
| SunHelm Survival | Needs/fatigue/sleep integration. Needs the **SunHelm Survival Patch** FOMOD option, which installs the patch plugin that connects SLS's SunHelm adapter. Warmth from sex, cum and milk reaches SunHelm's cold without it (**Frostfall & Door Knocking** MCM page) |
| Creation Club Survival Mode | Hunger, exhaustion and cold, while Survival Mode is switched on: swallowed cum feeds you, drugs and bondage furniture tire you, sleeping conditions (the cold included) cap your rest, hunger drives the belly and begging, and sex, skooma and milk warm you. Survival Mode has no thirst, so thirst options do nothing with it |
| WetFunction NG | Cum and milk leaks make you wet, and getting drenched can ruin carried licences and counts for the kennel bucket (Frostfall-only before) |
| Campfire | Enables camping actions in the SLS survival wheel menu |
| Private Needs - Orgasm | **Private Needs** on the action wheel (Actions) opens Private Needs' own pee or poop menu, the one its Universal key opens |
| Hunterborn | Hunting/harvest integration (hunter's cache) |

## Devious devices & bondage

| Mod | What it unlocks |
|-----|-----------------|
| Devious Devices (Expansion) | Restraints drive licences, tolls, begging and device-slot logic |
| Deviously Cursed Loot | Cursed-loot events are tracked and interact with SLS |
| Devious Followers | Follower debt/will and resistance-loss mechanics |
| ZaZ Animation Pack | Faction and bondage-furniture effects |
| Amputator Framework | Optional visual-effects framework support |

## Sex frameworks, arousal & scenes

| Mod | What it unlocks |
|-----|-----------------|
| SexLab Aroused | Arousal state drives many SLS effects and NPC reactions |
| Advanced Nudity Detection (AND) | Naked/exposed detection uses AND's rendered-coverage verdict (transparent and skimpy outfits count) for cat calls and the cover-myself mechanics, including the bra/underwear tier and pubic visibility |
| Modesty Toggle | Lets Cover Myself own the nude cover animations. Without it the OAR covering movesets keep playing over your choice, so uncover never visibly works — see [Cover Myself](#cover-myself-and-the-nude-cover-animations) |
| SexLab Separate Orgasm (SLSO) | Orgasm framework used by the "must orgasm" rules |
| SexLab P+ | Takes SLSO's place where P+ has it built in, Compulsive Sex included (it raises enjoyment through P+ instead of tapping SLSO's key) |
| SexLab - Sexual Fame [SLSF] | Sexual-fame reputation feeds SLS |
| SLSF Reloaded | Whore, slut, submissive, bestiality and airhead fame at your current location; the old SLSF `.esm` is not needed |
| Apropos 2 | Wear-and-tear scene descriptions |
| SexLab Dialogues | Extra dialogue/rest effect |
| Creature Framework | Creature mod framework support |
| SlaveTats (and tattoo add-ons) | Tattoo/overlay integration for SLS-applied body marks. With SlaveTats NG and the **SlaveTats Pack** FOMOD option, SLS applies its own overlays (wounds, spank marks, collar, curse marks) through SlaveTats, with UBE variants and hand-print spank marks |

## Body, cum & scaling

| Mod | What it unlocks |
|-----|-----------------|
| SexLab Inflation Framework (SLIF) | Coordinated belly/breast/ass scaling (see **SLIF Max Scaling** in the MCM) |
| Schlongs of Skyrim (SOS) | Genital state/scaling integration |
| Fill Her Up (FHU) | Cum-inflation visuals tie into the [Cum](cum.md) system |
| SPH - Skyrim Pubic Hair | **Shave** on the action wheel (Actions) starts SPH's own shaving: it needs SPH's razor and shaving cream, and not with your hands tied |

## Milk & drugs

| Mod | What it unlocks |
|-----|-----------------|
| Milk Mod Economy (MME) | Lactation/milking recognised; milk offered/demanded in tolls |
| Milk Addict | Milk-addiction pool integration |
| SexLab Skooma Whore | Drug lists power forced-drugging and drug toll demands |
| Soulgem Oven IV - Insemination Fantasies | Gem incubation and milk levels shown in the status menu; incubation progress lengthens animal-breeding cooloff |

## Prostitution & captivity

| Mod | What it unlocks |
|-----|-----------------|
| Slaverun Reloaded | Optional town-rules content integration |
| Simple Slavery | Handoff integration for certain failure outcomes |
| Sanguine's Debauchery | Handoff integration as an alternative outcome |
| TDF Aggressive Prostitution | Dancing offered as a toll payment |
| SexLab Pay Crime (Pay Sex Crime) | Pay off bounties with sex |
| Paradise Halls | Faction recognised |
| Sexy Bandit Captives | Captor faction recognised |

## Fertility, followers & flavour

| Mod | What it unlocks |
|-----|-----------------|
| Fertility Mode **or** Beeing Female | Pregnancy/fertility state; provides the "Fertility" drug used in toll drug events |
| Player Succubus Quest (PSQ) | Succubus state integration |
| Extensible Follower Framework (EFF) | Follower framework support (e.g. followers stealing gold) |
| FNIS Sexy Move | Walk-style integration |
| Spank That Ass | Spanking integration |
| SL Widgets | **Track Npc** on the action wheel (Actions > More Actions) adds the NPC you are looking at to SL Widgets' NPC tracking, or takes them off, like SL Widgets' own hotkey |
| AudioUtil (+ a voice pack, e.g. SLO VE) | Moan prompts, trauma/trip pain squeaks and cum-swallow reactions play through your voice pack — gag-muffled and lipsynced — instead of the stock sounds; moan prompts work even without DD, and a masochist PC (Spank That Ass "Likes"/"Loves" pain) moans instead of squeaking when slapped. Screams for help, NPC catcalls and clothes-strip gasps are lipsynced; cum-addict daydream moans come from the NPC's own voice pack. Two sliders on the **Trauma** page (General) control the volume of SLS-played voice and SFX separately from the voice-pack mod's own sliders |
| yps Immersive Fashion | Piercings/hair/nails (requires the tweak version) |
| Simply Knock **or** Simpler Knock | Beg the owner of a locked house for a night's stay through the door: the price is an armbinder and a door locked behind you, and when you leave there is a chance of being sold (Simple Slavery) or kept (SD+). Pick the matching **Door Knocking** option in the installer, which preselects the knock mod you have (Simpler Knock also wants Papyrus Extender to find the house's inside door); SLS needs neither (**Frostfall & Door Knocking** MCM page) |
| JKs Skyrim | Adds the extra Riften gate as a toll door |
| Missives | No gameplay link. Its Markarth noticeboard stands where SLS's toll desk is by the city gate; the **Missives Placement Fix** installer option moves the board along the wall and a little out into the walkway, and shifts the toll collector's starting spot to make room |
| Dawnguard | Adds a voice type used in creature-race handling |

!!! note "The list evolves"
    Supported mods and their required versions change between SLS releases, and this table reflects the integrations present in the current source. Treat the [SexLab Survival LoversLab page](https://www.loverslab.com/files/file/5914-sexlab-survival/) as the authoritative, current list.

## Cover Myself and the nude cover animations

If you run nude cover animations — Dynamic Feminine Female Modesty (the `KP_nude*` OAR replacers), or the condition overrides AND ships for them — they replace your walk and idle with a covering pose whenever the game decides you are being modest. That is decided by OAR conditions, entirely outside SLS, so it used to fight the **Cover Myself** key: pressing uncover stopped the SLS pose but the covering moveset kept playing underneath, and you never actually looked uncovered.

Install **Modesty Toggle** to resolve it. While Cover Myself owns covering (you are naked and the mechanic is enabled), SLS asks Modesty Toggle — through its own public API — to hold manual control and force expose, so the movesets stand down and your key genuinely decides whether you are covered. When you dress, your previous setting is handed back and control is released.

Notes:

- **Nothing is taken from you.** A manual force-cover or force-expose set with Modesty Toggle's hotkeys is saved before SLS takes over and restored afterwards, so it survives a strip/dress cycle.
- **AND is unaffected.** Modesty ranks, comments and corruption keep progressing exactly as before — only the animations yield.
- **It is optional.** Without Modesty Toggle, SLS falls back to the `NoModesty` keyword, which some setups ignore; and with Cover Myself mechanics switched off in the MCM, SLS never touches any of this.

## Toggling integrations

Detected integrations are surfaced and toggled on the **Interfaces** page of the SLS MCM. See the [MCM Reference](mcm-reference.md) for where each control lives.
