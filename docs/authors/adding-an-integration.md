# Adding an Integration

This is the recipe for wiring a new optional mod into SexLab Survival without making SLS depend on it. Read [Adapter Architecture](adapter-architecture.md) first — this page assumes you understand the `_SLS_Int*` / `_SLS_Interface*` pair and *why* it exists.

## 1. Confirm the external API

Before writing a line, find out what you're actually allowed to call.

- The bundled sources under `dependencies/<that mod>/Scripts/Source/` are the **source of truth** for that mod's API. Grep there to confirm the exact **script name** and **function signatures** exist.
- Identify the concrete script attached to the form you need (usually the mod's MCM/config quest). This name is what your `Int` will cast to — and the thing most likely to have been renamed in a newer version of that mod.

!!! warning
    Do not trust the script name from an old forum post or an older copy of the mod. Verify it against the version in `dependencies/`.

## 2. Write the `_SLS_IntXxx` globals

Create `scripts/source/_SLS_IntXxx.psc`:

```papyrus
Scriptname _SLS_IntXxx Hidden

; The ONLY place XxxConfigQuest (the external type) is ever named.
Float Function GetSomeValue() Global
    XxxConfigQuest q = Game.GetFormFromFile(0x000800, "Xxx.esp") as XxxConfigQuest
    If q                       ; ALWAYS guard the cast
        Return q.someValue
    EndIf
    Return 0.0
EndFunction
```

Rules:

- `Hidden`, only `Global` functions.
- Keep each function a thin one-line wrapper over the external call.
- **Guard every cast** (`If q`). A silent `None` here is how integrations break quietly when the external mod is updated — see the CF v4 example on the [architecture page](adapter-architecture.md#the-recurring-bug-external-scripts-get-renamed-across-versions).

## 3. Write the `_SLS_InterfaceXxx` quest

Create `scripts/source/_SLS_InterfaceXxx.psc`:

```papyrus
Scriptname _SLS_InterfaceXxx extends Quest

; Empty state: mod NOT installed. Every method a safe no-op / default.
Float Function GetSomeValue()
    Return 0.0
EndFunction

Event PlayerLoadsGame()
    If Game.GetModByName("Xxx.esp") != 255
        GotoState("Installed")
    Else
        GotoState("")
    EndIf
EndEvent

State Installed
    Float Function GetSomeValue()
        Return _SLS_IntXxx.GetSomeValue()
    EndFunction
EndState
```

Rules:

- Method signatures in `State Installed` must **exactly match** the empty-state definitions.
- The empty state returns safe defaults so callers never need to know whether the mod is present.
- Never type a **property** to the external script here (or anywhere). That would resolve at load and defeat the whole design.

## 4. Attach and fill in the CK

- Attach `_SLS_InterfaceXxx` to a quest in `SL Survival.esp`.
- Fill any properties (SLS forms — never external types) via the Creation Kit.
- Remember: CK-filled properties must not be deleted from the `.psc` later without also clearing them on the form. See [Overview](overview.md#a-note-on-ck-filled-properties).

## 5. Call it from gameplay code

From SLS gameplay scripts, call **through the Interface**, never the `Int` directly and never the external mod:

```papyrus
Float v = SLS.XxxInterface.GetSomeValue()   ; safe whether or not Xxx is installed
```

## 6. Compile and verify

Recompile just the two new scripts (see [Building from Source](building.md)) and confirm `0 error(s), 0 warning(s)`. Then in-game, check the Papyrus log for the tell-tale `Assigning None to a non-object variable "::temp1"` — if you see it, your cast target name is wrong for the installed version of the mod.

## Checklist

- [ ] Verified the external script name + signatures against `dependencies/`
- [ ] `_SLS_IntXxx`: `Hidden`, `Global` only, external type named **only** here
- [ ] Every cast guarded with `If`
- [ ] `_SLS_InterfaceXxx`: empty state = safe defaults, `Installed` state delegates
- [ ] `PlayerLoadsGame()` flips state on `GetModByName`
- [ ] No property anywhere is typed to the external script
- [ ] Compiles clean; no `::temp1` warning in the Papyrus log
