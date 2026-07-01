# Needs & Survival

SexLab Survival does not ship a full hunger/thirst/warmth system of its own. Instead it **layers extra pressure and consequences on top of whichever needs mod you already run**, and adapts to it through its interface layer. If no needs mod is installed, the survival hooks that depend on one simply stay quiet.

## What SLS integrates with

SLS detects and drives the needs mod you have installed — you do not pick one in SLS, it follows what is in your load order:

- **iNeed**
- **Realistic Needs and Diseases (RND)**
- **Eating Sleeping Drinking**
- **Frostfall** — cold/warmth, with its own config surfaced under the **Frostfall & Simply Knock** MCM page
- **SunHelm Survival** — supported through the **optional FOMOD patch** (the "SunHelm Survival Patch" component), not the base install

See [Mod Integrations](integrations.md) for the authoritative list of supported needs mods and what each one unlocks.

## What SLS adds on top

Rather than *tracking* hunger and thirst, SLS makes them **harder to satisfy** and **more punishing when ignored**:

- **Scaled consumption.** Options like **2x More 'Food'** and **2x More 'Water'** multiply how much you must eat and drink to stay level. A woman surviving alone in this Skyrim spends more of her day just keeping fed.
- **Hunger stages.** As you go without food you drop through named stages — **Satisfied → Peckish → Hungry → Starving → Ravenous** — each carrying heavier effects than the last.
- **Barefoot penalties.** Going without shoes applies a movement-speed debuff and can cause staggering on rough ground.
- **Steep-fall damage.** Descending steep terrain deals extra damage, discouraging reckless cross-country shortcuts.
- **Movement and carry floors.** Minimum-speed and minimum-carry-weight floors stop other penalties from stacking you into complete immobility.
- **Gold weight.** Coin carries weight, so hoarding gold competes with food, water and gear for encumbrance — and ties into the wider [tolls and begging economy](tolls-eviction-gates.md).

!!! tip "It stacks with the base needs mod"
    These are *additions*. Your underlying needs mod still governs the core hunger/thirst/cold meters; SLS raises the cost of meeting them and adds the barefoot, fall, floor and gold-weight consequences around them.

!!! warning "No needs mod, no scaling"
    The consumption multipliers and hunger stages need a supported needs mod to hook into. Without one installed, those specific options have nothing to scale — the barefoot, fall-damage and gold-weight pressures still apply.

## Configuring

Everything here lives on the **Needs** MCM page, with cold/warmth handling on the **Frostfall & Simply Knock** page. Every consequence — the consumption multipliers, the barefoot debuff, steep-fall damage, the speed and carry floors, and gold weight — can be tuned or switched off there. If a survival pressure is more than you want, turn it down or disable it on those pages rather than uninstalling the underlying needs mod.
