Scriptname _SLS_InterfaceSlax extends Quest  

Int Property SlaVersion = -1 Auto Hidden
Int Property SlaFrameworkVersion = -1 Auto Hidden ; packed framework version; >= 30200000 means SLA NG 3.2.0+ (SloangNative dynamic effects available)

String Property ArousalEffectId = "SLS_AROUSAL" Auto Hidden ; seed channel: a decaying starting-arousal bump
Float Property ArousalHalfLifeDays = 0.0833 Auto Hidden ; seed decay half-life ~2 in-game hours (game days)

String Property TeaseEffectId = "SLS_TEASE" Auto Hidden ; tease channel (teasemyself, sex-scene minimum): a decaying bump
Float Property TeaseHalfLifeDays = 0.0417 Auto Hidden ; tease decay half-life ~1 in-game hour (game days)

String Property FondleEffectId = "SLS_FONDLE" Auto Hidden ; fondle channel: a decaying bump, capped so fondling alone can't max arousal
Float Property FondleCap = 80.0 Auto Hidden ; fondling alone cannot push arousal past this ceiling
Float Property FondleHalfLifeDays = 0.0833 Auto Hidden ; fondle decay half-life ~2 in-game hours (lingers through the scene, then fades)

Quest SlaConfigQuest
Quest sla_FrameworkQuest
Quest sla_InternalQuest

Keyword Property SLA_HasStockings Auto Hidden
Keyword Property SlaBikiniKeyword Auto Hidden
Keyword Property _SLS_UnusedDummyKw Auto

Faction Property sla_Arousal Auto Hidden

Event OnInit()
	RegisterForModEvent("_SLS_Int_PlayerLoadsGame", "On_SLS_Int_PlayerLoadsGame")
EndEvent

Event On_SLS_Int_PlayerLoadsGame(string eventName, string strArg, float numArg, Form sender)
	PlayerLoadsGame()
EndEvent

Function PlayerLoadsGame()
	If Game.GetModByName("SexLabAroused.esm") != 255
		If GetState() != "Installed"
			GoToState("Installed")
		EndIf
	
	Else
		If GetState() != ""
			GoToState("")
		EndIf
	EndIf
	If GetState() == "Installed"
		SlaVersion = GetVersion()
		; Re-read here too (not only in OnEndState): on a save that was already "Installed" before this
		; update, no state transition fires, so OnEndState wouldn't run and SlaFrameworkVersion would
		; stay -1. sla_FrameworkQuest persists across saves, so it's resolved by the time we get here.
		If sla_FrameworkQuest
			SlaFrameworkVersion = _SLS_IntSlax.GetFrameworkVersion(sla_FrameworkQuest)
		EndIf
	Else
		SlaVersion = -1
		SlaFrameworkVersion = -1
	EndIf
EndFunction

Function RestartInterface()
	GoToState("")
	Utility.Wait(2.0)
	PlayerLoadsGame()
EndFunction

Event OnEndState()	
	Utility.Wait(5.0) ; Wait before entering active state to help avoid making function calls to scripts that may not have initialized yet.
	SlaConfigQuest = Game.GetFormFromFile(0x01C6E0, "SexLabAroused.esm") as Quest
	sla_FrameworkQuest = Game.GetFormFromFile(0x04290F, "SexLabAroused.esm") as Quest
	sla_InternalQuest = Game.GetFormFromFile(0x083137, "SexLabAroused.esm") as Quest
	sla_Arousal = Game.GetFormFromFile(0x03FC36, "SexLabAroused.esm") as Faction
	If sla_FrameworkQuest
		SlaFrameworkVersion = _SLS_IntSlax.GetFrameworkVersion(sla_FrameworkQuest)
	Else
		SlaFrameworkVersion = -1
	EndIf
	If GetVersion() >= 29
		SlaBikiniKeyword = Game.GetFormFromFile(0x08E854, "SexLabAroused.esm") as Keyword
		SLA_HasStockings = Game.GetFormFromFile(0x08FEA3, "SexLabAroused.esm") as Keyword
	Else
		SlaBikiniKeyword = _SLS_UnusedDummyKw
		SLA_HasStockings = _SLS_UnusedDummyKw
	EndIf
EndEvent

Bool Function GetIsInterfaceActive()
	Return GetState() as Bool
	;/
	If GetState() == "Installed"
		Return true
	EndIf
	Return false
	/;
EndFunction

State Installed
	Int Function GetVersion()
		Return _SLS_IntSlax.GetVersion(SlaConfigQuest)
	EndFunction
	
	Bool Function WornHasBikiniKeyword(Actor akActor)
		If SlaVersion >= 29
			Return akActor.WornHasKeyword(SlaBikiniKeyword)
		EndIf
		Return false
	EndFunction
	
	Bool Function IsWearingStockings(Actor akActor)
		Return akActor.WornHasKeyword(SLA_HasStockings)
	EndFunction
	
	Int Function GetActorArousal(Actor who) ; Live arousal (0-100) from the framework API; preferred over reading the sla_Arousal faction rank
		Return _SLS_IntSlax.GetActorArousal(sla_FrameworkQuest, who)
	EndFunction
	
	Int Function SetActorExposure(Actor who, Int newActorExposure)
		Return _SLS_IntSlax.SetActorExposure(sla_InternalQuest, who, newActorExposure)
	EndFunction

	; Give `who` a starting arousal of `amount`. On SLA NG 3.2.0+ this lands in SLS's own decaying
	; SLS_AROUSAL effect via SloangNative, so it fades over time and never touches the shared exposure
	; channel. On older forks (no SloangNative) it falls back to the legacy write.
	Int Function SeedArousal(Actor who, Int amount)
		If SlaFrameworkVersion >= 30200000
			_SLS_IntSlax.ModDecayingArousalEffect(who, ArousalEffectId, amount as Float, ArousalHalfLifeDays)
			Return amount
		EndIf
		Return _SLS_IntSlax.SetActorExposure(sla_InternalQuest, who, amount)
	EndFunction

	; Tease nudge for `who` (teasemyself, sex-scene minimum): a DECAYING bump that fades on its own.
	; On SLA NG 3.2.0+ it goes to the SLS_TEASE channel; older forks fall back to the legacy write.
	Function TeaseArousal(Actor who, Float amount)
		If SlaFrameworkVersion >= 30200000
			_SLS_IntSlax.ModDecayingArousalEffect(who, TeaseEffectId, amount, TeaseHalfLifeDays)
		Else
			_SLS_IntSlax.SetActorExposure(sla_InternalQuest, who, _SLS_IntSlax.GetActorArousal(sla_FrameworkQuest, who) + (amount as Int))
		EndIf
	EndFunction

	; Fondle nudge for `who`: a DECAYING bump on the SLS_FONDLE channel, capped at FondleCap so fondling
	; alone can't max arousal. Applied once when creature sex starts; fades on its own afterwards (no
	; clear needed). Older forks fall back to the legacy exposure write.
	Function FondleArousal(Actor who, Float amount)
		If SlaFrameworkVersion >= 30200000
			_SLS_IntSlax.ModDecayingArousalEffect(who, FondleEffectId, amount, FondleHalfLifeDays, FondleCap)
		Else
			_SLS_IntSlax.SetActorExposure(sla_InternalQuest, who, _SLS_IntSlax.GetActorArousal(sla_FrameworkQuest, who) + (amount as Int))
		EndIf
	EndFunction
EndState

Int Function GetVersion()
	Return -1
EndFunction

Bool Function WornHasBikiniKeyword(Actor akActor)
	Return false
EndFunction

Bool Function IsWearingStockings(Actor akActor)
	Return false
EndFunction

Int Function GetActorArousal(Actor who) ; SLA absent: no arousal to read
	Return 0
EndFunction

Int Function SetActorExposure(Actor who, Int newActorExposure)
	Return 0
EndFunction

Int Function SeedArousal(Actor who, Int amount) ; SLA absent: nothing to seed
	Return 0
EndFunction

Function TeaseArousal(Actor who, Float amount) ; SLA absent: nothing to do
EndFunction

Function FondleArousal(Actor who, Float amount) ; SLA absent: nothing to do
EndFunction
