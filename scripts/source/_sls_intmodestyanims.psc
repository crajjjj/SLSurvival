Scriptname _SLS_IntModestyAnims Hidden
{Suppress/restore the "Dynamic Feminine Female Modesty" OAR cover movesets (including the
condition overrides shipped by Advanced Nudity Detection) so the CoverMyself quest's
cover/uncover choice actually shows on the player.

Preferred lever: Modesty Toggle (ModestyToggle.esp), driven through its OWN public API rather
than by writing its factions behind its back:
  ModestyToggle_SetPlayerLock(float hours)  - hold the player's manual toggles while another
      mod owns the state (negative = until released, 0 = release). Its own comment notes that
      incoming SetModesty events are deliberately NOT blocked by the lock, precisely so the
      locking mod can keep driving the state.
  ModestyToggle_SetModesty(Form, int top, int bot) - 1 force cover, -1 force expose, 0 default,
      2 leave that half alone.
Going through the API means ModestyToggle applies its own state transitions and fires its
ModestyToggle_ModestyChanged event, so anything else listening stays in sync - none of which
happens if we poke the factions directly.

The player's prior top/bottom state is snapshotted before we take over and handed back on
release, so a manual force-cover/expose set with its hotkeys survives a strip/dress cycle. The
snapshot is taken ONCE per suppression: CoverMyself re-asserts Suppress on every game load, and
re-snapshotting there would capture our own forced state and "restore" to it forever.

Fallback without Modesty Toggle: the NoModesty ref keyword (the anim pack's own opt-out,
checked as NOT HasKeyword in its Master preset), added via PO3. Resolved by name at runtime, so
it is None (= no-op) when no modesty-anim mod is installed.

Either way the rule is the same: only ever release what we took. The lock is released and the
state restored only when our own snapshot flag says we were the ones who set them, so we can
never drop another mod's lock or clear a NoModesty keyword owned by KID rules or an outfit mod
(PO3 ref keywords persist in the cosave, so a stray removal would be permanent).}

Function SuppressCoverAnims(Actor akActor) Global
	If Game.GetModByName("ModestyToggle.esp") != 255
		; Snapshot once - re-asserting on load must not overwrite it with our own forced state
		If StorageUtil.GetIntValue(akActor, "_SLS_ModestyHeld", 0) == 0
			StorageUtil.SetIntValue(akActor, "_SLS_ModestySnapTop", GetToggleState(akActor, true))
			StorageUtil.SetIntValue(akActor, "_SLS_ModestySnapBot", GetToggleState(akActor, false))
			StorageUtil.SetIntValue(akActor, "_SLS_ModestyHeld", 1)
			SendPlayerLock(-1.0) ; hold manual toggles until we release
		EndIf
		SendSetModesty(akActor, -1, -1) ; force expose both halves
	Else
		Keyword NoModestyKw = Keyword.GetKeyword("NoModesty")
		If NoModestyKw
			PO3_SKSEFunctions.AddKeywordToRef(akActor, NoModestyKw)
		EndIf
	EndIf
EndFunction

Function RestoreCoverAnims(Actor akActor) Global
	If Game.GetModByName("ModestyToggle.esp") != 255
		; Only hand back a state we actually took over, or we would be clearing someone
		; else's lock and overwriting a modesty state we never owned
		If StorageUtil.GetIntValue(akActor, "_SLS_ModestyHeld", 0) == 1
			SendSetModesty(akActor, StorageUtil.GetIntValue(akActor, "_SLS_ModestySnapTop", 0), StorageUtil.GetIntValue(akActor, "_SLS_ModestySnapBot", 0))
			StorageUtil.SetIntValue(akActor, "_SLS_ModestyHeld", 0)
			SendPlayerLock(0.0) ; release
		EndIf
	Else
		Keyword NoModestyKw = Keyword.GetKeyword("NoModesty")
		If NoModestyKw
			PO3_SKSEFunctions.RemoveKeywordFromRef(akActor, NoModestyKw)
		EndIf
	EndIf
EndFunction

Int Function GetToggleState(Actor akActor, Bool abTop) Global
	{Read one half of ModestyToggle's state the same way its own GetTopState/GetBotState do:
	force-cover faction wins over force-expose, else default. Reading is synchronous, unlike
	the event API, so the snapshot is always taken from the real current state.}
	Int CoverId = 0x901
	Int ExposeId = 0x903
	If abTop
		CoverId = 0x900
		ExposeId = 0x902
	EndIf
	Faction Cover = Game.GetFormFromFile(CoverId, "ModestyToggle.esp") as Faction
	If Cover && akActor.IsInFaction(Cover)
		Return 1
	EndIf
	Faction Expose = Game.GetFormFromFile(ExposeId, "ModestyToggle.esp") as Faction
	If Expose && akActor.IsInFaction(Expose)
		Return -1
	EndIf
	Return 0
EndFunction

Function SendSetModesty(Actor akActor, Int aiTop, Int aiBot) Global
	Int Handle = ModEvent.Create("ModestyToggle_SetModesty")
	If Handle
		ModEvent.PushForm(Handle, akActor as Form)
		ModEvent.PushInt(Handle, aiTop)
		ModEvent.PushInt(Handle, aiBot)
		ModEvent.Send(Handle)
	EndIf
EndFunction

Function SendPlayerLock(Float afHours) Global
	Int Handle = ModEvent.Create("ModestyToggle_SetPlayerLock")
	If Handle
		ModEvent.PushFloat(Handle, afHours)
		ModEvent.Send(Handle)
	EndIf
EndFunction
