# Bikini Armors & EXP

SexLab Survival integrates with **The Amazing World of Bikini Armor** (TAWOBA / BikiniArmors) so that skimpy, revealing armor is treated as exactly that in-world: barely-there protection worn by a woman who has few other options. It also lets you re-tune how fast skills level. Both live on the **Bikini Armors & Exp** MCM page.

## Bikini armor rating

Bikini and skimpy armors keep the *look* of protective gear but give only a fraction of the defence a full set would. SLS scales a bikini armor's rating down to a share of its original value — selectable tiers of **100%, 75%, 50%, 25%, 10% or 5%** of the record's base armor rating (**armor rating as % of original**).

This is a deliberate trade. Skimpy armor is light, cheap and everywhere, but it leaves you exposed — both to weapons and to the [Misogyny & Inequality](misogyny.md) systems that read how you are dressed. Wearing a bikini is not just a defence choice; it signals exposure, and the world reacts to it.

!!! tip "Protection vs. reality"
    A bikini set will not carry you through a hard fight the way real plate would. If you choose it, you are choosing mobility and availability over survivability — and accepting the exposure consequences that come with it.

### BuildBikinis

SLS needs to know which of your installed armor records actually *are* bikini armors. The **BuildBikinis** process scans the installed bikini-armor plugins and builds that list so the rating reduction can be applied to the right items.

!!! note "Housekeeping detail"
    Skyrim tolerates only a limited number of armor entries per pass, and missing plugin entries can trigger a "255 armors" warning. SLS parks entries from absent plugins into a JSON file so the scan stays under that ceiling. This is internal bookkeeping — you do not need to manage it, but it explains why some parked entries appear disabled.

### Bikini breakdown (optional patch)

SLS can make ordinary armor **break down** into TAWoBA bikini pieces under stress. The armor-break configs and meshes ship as the optional **Bikini Armor Break (TAWoBA)** FOMOD component and require **The Amazing World of Bikini Armors REMASTERED**. Install that patch during setup if you want listed armors to shed into bikini parts rather than simply reducing in rating.

## Exp — skill experience tuning

The **Exp** options let SLS scale how much skill experience you gain. Survival in this Skyrim is meant to be slow and hard-won, so you can dial experience gain up or down to match the pace you want — a lower multiplier makes every level a longer, grimmer road; a higher one softens the grind.

Set the multiplier to taste in the MCM rather than expecting a fixed rate; the exact scaling is configurable.

!!! note
    Both the bikini armor rating tiers and the experience scaling live on the **Bikini Armors & Exp** MCM page. Run **BuildBikinis** there after changing your bikini-armor plugins.
