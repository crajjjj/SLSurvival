# Adapter Architecture

This is the single most important thing to understand about SexLab Survival's codebase. If you only read one author page, read this one.

SLS integrates with **dozens** of optional mods — Frostfall, Devious Devices, Creature Framework, Milk Mod Economy, SunHelm, and many more. Any of them may be absent on a given player's setup. SLS has to load and run correctly regardless. It achieves that by putting **every hard reference to an external mod behind an adapter pair**.

## The pair

Each optional-mod integration is split into two scripts:

- **`_SLS_IntXxx.psc`** — `Scriptname _SLS_IntXxx Hidden`, containing only `Global` functions. This is the **only** place that names the external mod's concrete types/scripts (`FrostUtil`, `CampUtil`, `CreatureFrameworkConfig`, …). The functions are thin one-line wrappers. There are ~58 of these.
- **`_SLS_InterfaceXxx.psc`** — `extends Quest`. A two-state machine:
    - the **empty state `""`** — the mod is treated as *not installed*; every method is a safe no-op returning a default;
    - the **`"Installed"` state** — every method delegates to the matching `_SLS_IntXxx` global.

    `PlayerLoadsGame()` flips the state based on `Game.GetModByName("Xxx.esm")`/`.esp`. There are ~29 of these.

## Why the split — the crucial detail

!!! info "Properties resolve at load; globals resolve at call"
    A **script-level property** typed to an external script resolves at **script load**. If that type is missing, the *entire script fails to load* — and everything depending on it breaks.

    A **global function call** resolves **lazily, at call time**.

So SLS keeps every hard external reference inside `_SLS_IntXxx` **globals**, and only ever *calls* them from the `"Installed"` state of the Interface. If the mod is absent, the Interface simply never leaves the empty state, the globals are never called, and nothing tries to resolve the missing type. SLS loads and runs no matter which optional mods are present.

This is also why the empty/`"Installed"` state routing works the way it does: an event or function defined **only** in the empty state still runs while the quest is in a named state (the empty state is the default). A **self-call** inside such a function dispatches to the **current** state's override. That is exactly how the Interface routes a call through `"Installed"` down into the `Int` globals.

## Anatomy of an Interface

```papyrus
Scriptname _SLS_InterfaceXxx extends Quest

; Empty state = mod not installed. Safe no-ops / defaults.
Bool Function IsThing()
    Return false
EndFunction

Event PlayerLoadsGame()
    If Game.GetModByName("Xxx.esp") != 255
        GotoState("Installed")
    Else
        GotoState("")
    EndIf
EndEvent

State Installed
    Bool Function IsThing()
        Return _SLS_IntXxx.IsThing()   ; delegates to the global
    EndFunction
EndState
```

And the `Int` half:

```papyrus
Scriptname _SLS_IntXxx Hidden

Bool Function IsThing() Global
    XxxConfigQuest q = Game.GetFormFromFile(0x123, "Xxx.esp") as XxxConfigQuest
    ; XxxConfigQuest is the ONLY place the external type is named
    Return q.SomeValue
EndFunction
```

## The recurring bug: external scripts get renamed across versions

`_SLS_IntXxx` casts the external mod's MCM/config quest to a **specific script name**. If the player has a **newer version** of that mod where the script was renamed, the cast silently returns `None`. You then get:

```
warning: Assigning None to a non-object variable "::temp1"
```

in the Papyrus log, and the integration breaks **quietly** — reads return 0, writes no-op, no crash.

!!! example "Real fix from this repo"
    `_SLS_IntCf` cast to `CFConfigMenu` (old Creature Framework), but CF v4 ships `CreatureFrameworkConfig`. The cast returned `None` and creature integration silently died.

    The fix: update the cast to the installed mod's script name **and guard it** so a future mismatch can't corrupt state:

    ```papyrus
    CreatureFrameworkConfig q = quest as CreatureFrameworkConfig
    If q                       ; guard the cast
        ; safe to use q
    EndIf
    ```

When you touch any `_SLS_IntXxx`, **verify the cast target against the script actually attached to the form** in `dependencies/<that mod>/Scripts/Source/`. The `dependencies/` folder is the source of truth for what external API a given `_SLS_Int*` is allowed to call — grep there to confirm a function or script name exists before relying on it.

## The rule

> Never reference an external mod's type as a property. Wrap it in an `_SLS_IntXxx` global, gate it behind an `_SLS_InterfaceXxx` `"Installed"` state, and guard every cast.

Ready to wire in a new mod? See [Adding an Integration](adding-an-integration.md).
