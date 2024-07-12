Scriptname _JSW_SUB_SpellHandler extends Quest

_JSW_BB_Storage				Property	Storage				Auto	; Storage data helper
_JSW_BB_Utility				Property	Util				Auto	; Independent helper functions

_JSW_SUB_GVHolderScript		Property	GVHolder			Auto	;
; 2.14
_JSW_SUB_MiscUtilQuest		Property	FMMiscUtil			Auto	; 

Actor			Property	PlayerRef					Auto	; Reference to the player. Game.GetPlayer() is slow
Faction			Property	_JSW_SUB_SexLabSLSOFaction	Auto	;
Faction			Property	_JSW_SUB_OStimFaction		Auto
Faction			Property	_JSW_SUB_FGFaction			Auto
Faction			Property	GenericFaction				Auto	; faction for tracked actors
Faction			PRoperty	PlayerRelatedFac			Auto	; 

Perk			Property	_JSW_SUB_MEHolder			Auto	; the spell which applies the MEs that registers for external events

Spell			Property	_JSW_SUB_EventSpell			Auto
Spell			Property	CellScanSpell				Auto

function	SpellHandlerUnregister()

	GoToState("")
	UnregisterForAllModEvents()
	playerRef.RemovePerk(_JSW_SUB_MEHolder)
	playerRef.RemoveSpell(_JSW_SUB_EventSpell)
	playerRef.RemoveFromFaction(_JSW_SUB_SexLabSLSOFaction)
	playerRef.RemoveFromFaction(_JSW_SUB_OStimFaction)
	playerRef.RemoveFromFaction(_JSW_SUB_FGFaction)

endFunction

bool	function	SpellHandlerListener()
{runs on start}

	RegisterForModEvent("FertilityModeActorsUpdated", "SetFMActorFactions")
	RegisterForModEvent("FertilityModeAbort", "FMAbortionEvent")
	RegisterForModEvent("FertilityModeDamageMessage", "FMFetusLoseHealth")
	RegisterForModEvent("FertilityModeFertilityBuff", "FMApplyFertilityBuff")
	RegisterForModEvent("FertilityModeFertilityDebuff", "FMApplyFertilityDebuff")
	RegisterForModEvent("FertilityModeSpermRemoval", "FMDecopulate")
	; 2.26
	RegisterForModEvent("FMSetSingleActorFaction", "FMSetSingleActorFactionEvent")
	playerRef.AddPerk(_JSW_SUB_MEHolder)
	playerRef.AddSpell(_JSW_SUB_EventSpell, false)
	if ((Game.GetModByName("SLSO.esp") != 255) || (Game.GetModByName("SexLab.esm") != 255))
		playerRef.SetFactionRank(_JSW_SUB_SexLabSLSOFaction, 0)
	endIf
	if (Game.GetModByName("OStim.esp") != 255)
		playerRef.SetFactionRank(_JSW_SUB_OStimFaction, 0)
	endIf
	if (Game.GetModByName("FlowerGirls SE.esm") != 255)
		playerRef.SetFactionRank(_JSW_SUB_FGFaction, 0)
	endIf
	if !GVHolder.MiscarriageEnabled
		GoToState("NoMiscarriage")
	else
		GoToState("")
	endIf
	return true

endFunction

function	MiscarriageState()

	if GVHolder.MiscarriageEnabled
		GoToState("")
	else
		GoToState("NoMiscarriage")
	endIf

endFunction

state	NoMiscarriage

	event	FMFetusLoseHealth()

		if (GVHolder.Enabled && GVHolder.MiscarriageEnabled)
			GoToState("")
		endIf

	endEvent

endState

event	FMFetusLoseHealth()
{when the mother's body takes damage, so may the fetus}

	RegisterForModEvent("FertilityModeDamageMessage", "FMFetusLoseHealth")
	if (!GVHolder.Enabled || !GVHolder.MiscarriageEnabled)
		GoToState("NoMiscarriage")
		return ; FM isn't enabled
	endIf
	int index = Storage.TrackedActors.Find(playerRef as form)
	if ((index != -1) && (Storage.LastConception[index] != 0.0))
		index = ((Utility.RandomInt() / 10) as int + 1)
		Storage.BabyHealth -= index
		if GVHolder.VerboseMode
			Debug.Notification("Damage to a mother's body may harm her unborn child! " + index)
		endIf
		ModEvent.Send(ModEvent.Create("FMPUpdateWidgetContent"))
	endIf

endEvent

;	0 : ovulation phase, before egg
;	1 : ovulation phase, with egg
;	2 : luteal - ovulation phase, after egg has died
;	3 : menstruation
;	4 : first trimester
;	5 : second trimester
;	6 : third trimester
;	7 : ovulation is blocked this cycle
;	8 : recovery from birth
;	20: full-term pregnancy
event	SetFMActorFactions(bool clearAll = false)
{Run after the normal actor update finishes, this updates tracked actor factions}

	int index = Math.LogicalAnd(Storage.TrackedActors.Length, 0x00000FFF)
	actor thisActor
	float pregDuration = GVHolder.PregnancyDuration as float
	float now = GVHolder.GVGameDaysPassed.GetValue()
	; new 2.14
	float recoverDuration = GVHolder.RecoveryDuration as float
	int stateID = -1
	int rank
	while (index > 0)
		index -= 1
		thisActor = Storage.TrackedActors[index] as actor
		if thisActor
			if clearAll
				thisActor.SetFactionRank(GenericFaction, 0)
			else
				stateID = FMMiscUtil.GetActorStateID(index)
				if stateID == -1
					thisActor.RemoveFromFaction(GenericFaction)
				elseIf ((stateID == 4) || (stateID == 5) || (stateID == 6) || (stateID == 20))
					rank = Math.LogicalAnd((((now - Storage.LastConception[index]) / pregDuration) * 100.0) as int, 	0x0000007F)
					thisActor.SetFactionRank(GenericFaction, rank)
				elseIf (stateID == 8)
					rank = Math.LogicalAnd((((now - Storage.LastBirth[index]) / recoverDuration) * 36.0) as int, 0x0000003F)
					if (rank > 36)
						rank = 36
					endIf
					thisActor.SetFactionRank(GenericFaction, (-85 - rank))
				else
					thisActor.SetFactionRank(GenericFaction, ((stateId * -10) - 5))
				endIf
				stateID = -1
			endIf
			thisActor = none
		endIf
;/	2.14 rewrite all this
			if !clearAll && (Storage.LastOvulation[index] != 0.0)		; they're ovulating
				thisActor.SetFactionRank(GenericFaction, -15)
			elseIf !clearAll && (Storage.LastConception[index] != 0.0)	; they're pregnant
				thisActor.SetFactionRank(GenericFaction, Math.LogicalAnd((((now - Storage.LastConception[index]) / pregDuration) * 100.0) as int, 0x0000007F))
			else											; they're neither
				thisActor.SetFactionRank(GenericFaction, 0)
			endIf
			thisActor = none/;
	endWhile
	; send mod event to let any listeners know we're done
	SendModEvent("FM_ActorFactionsSet", "", 0.0)
	SendModEvent("FMPlusDoMorph", "", 0.0)
	if !playerRef.HasSpell(CellScanSpell as form)
		playerRef.AddSpell(CellScanSpell, false)
	endIf

endEvent

event	FMSetSingleActorFactionEvent(string EventName, string unused, float indexFloat, form thisActor)

	RegisterForModEvent("FMSetSingleActorFaction", "FMSetSingleActorFactionEvent")
	int index = indexFloat as int
	thisActor = Storage.TrackedActors[index]
	if thisActor as actor
		int stateID = FMMiscUtil.GetActorStateID(index)
		if stateID == -1
			(thisActor as actor).RemoveFromFaction(GenericFaction)
		elseIf ((stateID == 4) || (stateID == 5) || (stateID == 6) || (stateID == 20))
			int rank = Math.LogicalAnd((((GVHolder.GVGameDaysPassed.GetValue() - Storage.LastConception[index]) / \
				(GVHolder.PregnancyDuration as float)) * 100.0) as int, 	0x0000007F)
			(thisActor as actor).SetFactionRank(GenericFaction, rank)
		elseIf (stateID == 8)
			int rank = Math.LogicalAnd((((GVHolder.GVGameDaysPassed.GetValue() - Storage.LastBirth[index]) / \
				(GVHolder.RecoveryDuration as float)) * 36.0) as int, 0x0000003F)
			if (rank > 36)
				rank = 36
			endIf
			(thisActor as actor).SetFactionRank(GenericFaction, (-85 - rank))
		else
			(thisActor as actor).SetFactionRank(GenericFaction, ((stateId * -10) - 5))
		endIf
	endIf

endEvent

event	FMAbortionEvent(form target = none)
{consolidating all abortion events into one place}

	if (!target || !GVHolder.Enabled)
		return
	endIf
	int index = Storage.TrackedActors.Find(target)
	if (index == -1)
		return
	endIf
	; clear all generic index info
	Storage.LastConception[index] = 0.0
	; 2.20 I'm fairly certain no sperm would survive an abortion...
	Storage.LastInsemination[index] = 0.0
	Storage.SpermCount[index] = 0
	; 2.08
	Storage.LastFatherForm[index] = none
	Storage.CurrentFatherForm[index] = none
	Storage.OvulationBlock[index] = 1
	Util.UpdateNPCFactions(target as actor, index)
	; player-specific stuff
	if (target == playerRef as form)
		Storage.BabyHealth = 105
		ModEvent.Send(ModEvent.Create("FMPUpdateWidgetContent"))
;	endIf
	; 2.26
	else
		FMSetSingleActorFactionEvent("", "", index, target)
	endIf
	Util.ClearBellyBreastScale(target as actor)

endEvent

event	FMDecopulate(form target = none)
{new event 1.57 to handle sperm removal duties}

	if (!target || !GVHolder.Enabled)
		return ; invalid
	endIf
	int index = Storage.TrackedActors.Find(target)
	if (index == -1)
		return ; not tracked
	endIf
	Storage.LastInsemination[index] = 0.0
	Storage.SpermCount[index] = 0
	; only clear father info if actor is not pregnant!
	if Storage.LastConception[index] == 0.0
		Storage.CurrentFatherForm[index] = none
;		Storage.FatherRaceId[index] = -1
		; 2.15
		Storage.CurrentFatherRace[index] = none
	else	; if they are pregnant, ensure they're not also ovulating
		Storage.LastOvulation[index] = 0.0
	endIf
	if (target as actor == playerRef)
		ModEvent.Send(ModEvent.Create("FMPUpdateWidgetContent"))
;	endIf
	; 2.26
	else
		FMSetSingleActorFactionEvent("", "", index, target)
	endIf

endEvent

event	FMApplyFertilityBuff(form akTarget = none)
{applies fertility buff to target}

	if (!akTarget || !GVHolder.Enabled)
		return ; FM is disabled or invalid actor
	endIf
	if (Util.GetActorGender(akTarget as actor) == 0)
		int index = Storage.TrackedFathers.Find(akTarget)
		if (index == -1)
			return ; not tracked
		else
			Storage.RefractoryPeriod[index] = 0 ; fill balls
		endIf
	elseIf (akTarget as actor == playerRef)
		ModEvent.Send(ModEvent.Create("FMPUpdateWidgetContent"))
	endIf

endEvent

event	FMApplyFertilityDebuff(form akTarget = none)
{applies fertility debuff to target}

	if (!akTarget || !GVHolder.Enabled)
		return ; FM is diabled or invalid actor
	endIf
	if (Util.GetActorGender(akTarget as actor) == 0)
		int index = Storage.TrackedFathers.Find(akTarget)
		if (index == -1)
			return ; not tracked
		else
			Storage.RefractoryPeriod[index] = Storage.FMValues[11] ; drain balls
		endIf
	elseIf (akTarget as actor == playerRef)
		ModEvent.Send(ModEvent.Create("FMPUpdateWidgetContent"))
	endIf

endEvent
