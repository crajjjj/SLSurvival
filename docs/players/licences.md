# Licences

Licences are the signature SexLab Survival system. In this version of Skyrim a woman is not simply free to carry a sword, wear clothes, cast a spell or run a shop — she must **buy a permit** for the privilege. It is the mechanical spine of the mod's [misogyny and inequality](misogyny.md) theme: ordinary actions become paperwork, and paperwork costs coin.

## How it works

- **You buy licences** from officials and vendors — the sort of people who can issue or sell a permit. Each licence type covers one category of behaviour.
- **Lacking a licence gets you noticed.** Guards harass women who are doing something they have no permit for, and confiscation follows: a woman carrying a weapon with no arms permit can have it taken; a naked woman with no dress permit is fair game for harassment.
- **Licences can expire.** A permit you bought is not forever — let it lapse and you are back to being unlicensed, with all the attention that brings. Keep an eye on your permits before walking into a guarded city.

## Licence types

SLS issues a permit for nearly everything a free person would take for granted. Each is a separate licence with its own price and expiry:

| Licence | Covers |
|---------|--------|
| **Weapon** | Carrying or drawing a weapon |
| **Armor** | Wearing armour |
| **Clothes** | Wearing clothing at all |
| **Bikini** | Wearing bikini / skimpy armor (see [Bikini Armors](bikini-armors.md)) |
| **Magic** | Casting spells |
| **Whore** | Selling sex / prostitution |
| **Curfew** | Being out and about after curfew |
| **Freedom** | Moving and acting as an unattached free woman |
| **Property** | Owning a home or property |

!!! note "Clothes, armour and bikini are separate permits"
    Being "dressed" isn't one licence — clothing, armour and skimpy/bikini armor are each licensed on their own. A woman can be permitted to wear a bikini but not full armour, and each permit expires independently.

## How you gain access to licences

Being able to *buy* a permit is itself gated. The **Licence Style** setting (on the **Licences 1** MCM page) decides how each licence type becomes available to you in the first place. There are four styles:

| Style | How licences unlock |
|-------|---------------------|
| **Default** | Every licence type is available from the start. If you have the coin — and the official issuing it doesn't have some small problem for you to resolve first — you can buy any permit straight away. Thane status is irrelevant here. |
| **Thaneship Choice** | You start with no licences available. On becoming **thane** of one of the five walled cities (Whiterun, Solitude, Markarth, Windhelm, Riften) you earn the right to unlock **one licence type of your choosing** — talk to a quartermaster to pick it. Five thaneships, so up to five types over a playthrough. |
| **Thaneship Random** | As above, but each thaneship unlocks a **random** licence type instead of one you choose. |
| **Unlock** | No thane titles involved — each licence type must first be unlocked by paying a steep one-off **Licence Unlock Cost** before you can buy permits of that type. |

!!! note "Thane titles only matter under the two Thaneship styles"
    Earning a thaneship unlocks licence access **only** when the style is set to **Thaneship Choice** or **Thaneship Random**. Under **Default** every type is already open, and under **Unlock** you pay to unlock instead — so becoming a thane has no effect on licences in either of those.

!!! tip "Bikini before armour"
    The **Bikini licence first** option (Thaneship styles only) forces the bikini permit to be awarded before the full armour permit — under *Choice* you must pick bikini first before full armour can be chosen; under *Random* full armour only enters the pool once you already hold the bikini licence.

!!! warning "Being caught unlicensed compounds"
    Confiscation, harassment and the fines that follow feed the wider economy. Losing a confiscated weapon or paying your way out of trouble drains the same coin you need for [tolls and inn rooms](tolls-eviction-gates.md) — so an expired permit can snowball fast.

!!! tip "Buy before you enter"
    Guards are concentrated at city gates and inside walls. Sort your permits *before* passing a gate, not after a guard has already flagged you.

## Configuring

The licence system spans two MCM pages, **Licences 1** and **Licences 2**. The **Licence Style** dropdown (Licences 1) chooses how permits become available — Default, Thaneship Choice, Thaneship Random or Unlock, described above. Which permits are required, what they cost, how long they last before expiring, the Licence Unlock Cost (used by the *Unlock* style) and the bikini-first option all live there too. If you want a lighter run, raise licence durations, lower their prices, or disable individual licence types on those pages. To play without the system at all, switch the licence requirements off there rather than uninstalling — the rest of SLS keeps working.

!!! warning "Changing style resets your unlocks"
    Switching Licence Style while you already hold licences under a *Thaneship* style resets and re-locks everything. Under *Choice* you'll have to pick your licences at a quartermaster again; under *Random* new random licences are rolled. The MCM warns you before it applies the change.
