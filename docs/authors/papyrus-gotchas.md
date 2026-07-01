# Papyrus Gotchas

Papyrus is not like the languages you're used to. These are the quirks that bite everyone working in the SLS codebase. Most of them are silent — the compiler won't warn you.

## Control flow

- **No `break`, no `continue`.** Use flags or an early `Return`.
- Only `if/elseif/else/endif` and `while/endwhile`. **No** for-loops, switch, or do-while.
- `||` and `&&` short-circuit — safe to guard a call with `If x && x.Method()`.

## Variables & types

- **Locals are function-scoped, not block-scoped.** Declaring the same name in two sibling `if` branches is a *compile error* — hoist the declaration above the branches.
- Variables inside a `while` loop **persist across iterations** (they are not reset). Initialize explicitly each pass if you need a fresh value.
- **Script-level** variables initialize only with **literals**. Function-level variables can use expressions.
- Value types (`Bool`/`Int`/`Float`/`String`) copy on assignment. Object refs and arrays are **by reference**.

## The `None` trap

Reading a property or method off a `None` object yields `None` and logs:

```
Assigning None to a non-object variable "::tempN"
```

This is the same warning that signals a broken integration cast — see [Adapter Architecture](adapter-architecture.md#the-recurring-bug-external-scripts-get-renamed-across-versions). **Always guard external casts:**

```papyrus
Foo f = q as Foo
If f
    ; safe to use f
EndIf
```

## Arrays

- Max **128** elements. The size must be an **integer literal** (`new int[128]`), never a variable.
- `array[i] += 5` **does not compile** — write `array[i] = array[i] + 5`.
- No arrays of arrays. Arrays are passed and assigned by reference.
- `Find()` / `RFind()` and the SKSE string funcs are **case-insensitive**; but `==` string comparison is **case-sensitive**.

## States & dispatch

This is the mechanism the whole adapter layer relies on:

- A script is in exactly one state at a time. `GotoState("")` returns to the empty state.
- A state-overridable function/event signature must **exactly match** the empty-state definition.
- An event/function defined **only** in the empty state still runs while the script is in a named state (the empty state is the default). A **self-call** inside it dispatches to the **current** state's override — this is precisely how `_SLS_Interface*` routes through `"Installed"`.
- Call `GotoState()` *before* external calls, for threading safety.

## Threading

- One thread per script instance.
- **Any** external call — including `Debug.Trace()` or a property read on another object — **unlocks** the script. Local assumptions about state may be stale after it returns. Own-variable and array operations do *not* unlock.

## Misc

- The compiler does **not** check all paths for return values — a missing return is undefined behavior.
- `parent.Func()` calls one level up, not necessarily the base script.
- **Unary minus needs spaces:** `x = y - 1`, not `x = y-1`.

## House conventions

- Keep edits **ASCII** unless the file already contains non-ASCII.
- Comments explain **why** (a hidden constraint, an invariant, a mod-version workaround), not *what*.
- After fixing an `_SLS_Int*` / `_SLS_Interface*` bug, recompile just that script and confirm `0 error(s), 0 warning(s)`.
