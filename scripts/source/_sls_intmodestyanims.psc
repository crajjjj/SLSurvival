Scriptname _SLS_IntModestyAnims Hidden
{Suppress/restore the "Dynamic Feminine Female Modesty" OAR cover movesets (including the
condition overrides shipped by Advanced Nudity Detection) so the CoverMyself quest's
cover/uncover choice actually shows on the player.

Preferred lever: Modesty Toggle (ModestyToggle.esp). Its force-expose factions gate every
KP_nude* submod at the top level (AND[NOT IsInFaction 0x902, NOT IsInFaction 0x903]), so
putting the player in them stands the whole moveset down. The factions are written directly
rather than through the mod's ModestyToggle_SetModesty event: the event proved undeliverable
in testing (sent but never handled, silently), and a direct faction write is synchronous and
verifiable. FormIDs 0x900-0x903 mirror ModestyToggle's own script, which resolves them the
same way - if that esp is ever compacted its own hotkeys break identically, so hardcoding
adds no new fragility. This does not touch AND's modesty-rank progression.

Fallback without Modesty Toggle: the NoModesty ref keyword (the anim pack's own opt-out,
checked as NOT HasKeyword in its Master preset), added via PO3. Runtime ref keywords proved
unreliable with OAR's HasKeyword in testing, which is why the factions are the primary path.
Resolved by name at runtime: None (= no-op) when no modesty-anim mod is installed.

Suppression state persists in the save (factions / PO3 cosave keywords), so every Suppress
must be paired with a Restore when the CoverMyself quest stops, or the movesets stay dead
for the rest of the save. Restore clears both levers regardless of which one Suppress used,
so it stays idempotent if Modesty Toggle is added or removed mid-save.}

Function SuppressCoverAnims(Actor akActor) Global
	If Game.GetModByName("ModestyToggle.esp") != 255
		Faction TopOff = Game.GetFormFromFile(0x902, "ModestyToggle.esp") as Faction
		Faction BotOff = Game.GetFormFromFile(0x903, "ModestyToggle.esp") as Faction
		If TopOff && BotOff
			; Mirror ModestyToggle's ApplyTopState/ApplyBotState(-1): clear any manual
			; force-cover first, then force exposure on both halves
			akActor.RemoveFromFaction(Game.GetFormFromFile(0x900, "ModestyToggle.esp") as Faction)
			akActor.RemoveFromFaction(Game.GetFormFromFile(0x901, "ModestyToggle.esp") as Faction)
			akActor.AddToFaction(TopOff)
			akActor.AddToFaction(BotOff)
		Else
			Debug.Trace("_SLS_: ModestyAnims - ModestyToggle.esp present but force-expose factions did not resolve", 2)
		EndIf
	Else
		Keyword NoModestyKw = Keyword.GetKeyword("NoModesty")
		If NoModestyKw
			PO3_SKSEFunctions.AddKeywordToRef(akActor, NoModestyKw)
		EndIf
	EndIf
EndFunction

Function RestoreCoverAnims(Actor akActor) Global
	If Game.GetModByName("ModestyToggle.esp") != 255
		Faction TopOff = Game.GetFormFromFile(0x902, "ModestyToggle.esp") as Faction
		Faction BotOff = Game.GetFormFromFile(0x903, "ModestyToggle.esp") as Faction
		If TopOff && BotOff
			akActor.RemoveFromFaction(TopOff)
			akActor.RemoveFromFaction(BotOff)
		EndIf
	EndIf
	Keyword NoModestyKw = Keyword.GetKeyword("NoModesty")
	If NoModestyKw
		PO3_SKSEFunctions.RemoveKeywordFromRef(akActor, NoModestyKw)
	EndIf
EndFunction
