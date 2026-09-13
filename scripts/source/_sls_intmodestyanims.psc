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
for the rest of the save. Restore mirrors whichever lever Suppress used and touches nothing
else: it never clears ModestyToggle's manual force-cover factions, and never clears the
NoModesty keyword on a setup where the factions were the lever - both are state other mods
and the player own, and PO3 ref keywords persist in the cosave, so a stray removal is
permanent. The cost of that restraint is only that switching Modesty Toggle in or out
mid-save can strand the other lever, which a single dress/undress cycle clears.}

Function SuppressCoverAnims(Actor akActor) Global
	If Game.GetModByName("ModestyToggle.esp") != 255
		Faction TopOff = Game.GetFormFromFile(0x902, "ModestyToggle.esp") as Faction
		Faction BotOff = Game.GetFormFromFile(0x903, "ModestyToggle.esp") as Faction
		If TopOff && BotOff
			; Only ever add our own lever. ModestyToggle's manual force-COVER factions
			; (0x900/0x901) belong to the player's hotkey choices - deliberately left alone,
			; so a manual setting survives a strip/dress cycle. Suppression still holds with
			; both set: the submods gate on NOT IsInFaction(0x902/0x903) at the top level.
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
	Else
		; Mirrors the Suppress branch exactly: only clear the keyword when the keyword is the
		; lever we actually used. NoModesty is shared ecosystem state (KID rules, NoModesty DD,
		; outfit mods all set it) - clearing it unconditionally would delete another mod's
		; keyword off the player, permanently, since PO3 ref keywords persist in the cosave.
		Keyword NoModestyKw = Keyword.GetKeyword("NoModesty")
		If NoModestyKw
			PO3_SKSEFunctions.RemoveKeywordFromRef(akActor, NoModestyKw)
		EndIf
	EndIf
EndFunction
