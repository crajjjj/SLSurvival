Scriptname	_JSW_SUB_MiscUtilQuest	extends	Quest

_JSW_SUB_GVHolderScript				Property	GVHolder	Auto
_JSW_SUB_HandlerQuestAliasScript	Property	Handler		Auto	; The primary tracking script

Actor			Property	PlayerRef				Auto	; Reference to the player. Game.GetPlayer() is slow

Faction			Property	GenericFaction			Auto	;

Keyword			Property	FertilityKeyword		Auto	; keyword for fertility altering effects

MagicEffect		Property	EffectContraception		Auto	; Magic effect for decreased fertility
MagicEffect		Property	EffectFertility			Auto	; Magic effect for increased fertility

Perk			Property	FemaleCyclePerk			Auto	; pulled my head outta may ass, only need 1.

float			percent
int				stateID		=		-1

function PlayerLoadedGame()

	UnregisterForAllModEvents()
	UpdateWidgetKey()
	RegisterForModEvent("FMPUpdateWidgetContent", "OnUpdateWidgetContent")
	RegisterForModEvent("FMPPlayerFactStat", "OnFMPPlayFactStat")

endFunction

function UpdateWidgetKey()

	UnregisterForAllKeys()
	; 2.23
	if GVHolder.MapWidgetKey
		RegisterForKey(GVHolder.WidgetHotKey)
	endIF

endFunction

event OnKeyDown(int keyCode)
{Handles the status widget hotkey}

    if !Utility.IsInMenuMode()
		GVHolder.WidgetShown = !GVHolder.WidgetShown
		OnUpdateWidgetContent()
    endIf

endEvent

event OnUpdateWidgetContent()

	int handle = ModEvent.Create("FMPatchWidgetUpdate")
	;	float newAlpha = 0.0, string textString = " ", int stateID = 0, float percent = 0.0, float newX = 10.0, float newY = 900.0
	if handle
		int aIndex = Handler.Storage.TrackedActors.Find(playerRef as form)
		if ((Handler.Util.GetActorGender(playerRef) == 1) && (aIndex != -1) && GVHolder.Enabled)
			ModEvent.PushFloat(handle, (100.0 * GVHolder.WidgetShown as float))
			stateID = GetActorStateID(aIndex)
			ModEvent.PushString(handle, MakePlayerString(aIndex))
			ModEvent.PushInt(handle, stateID)
			ModEvent.PushFloat(handle, percent); percent
		else
			ModEvent.PushFloat(handle, 0.0)
			ModEvent.PushString(handle, " ")
			ModEvent.PushInt(handle, 2)
			ModEvent.PushFloat(handle, 0.0)
		endIf
		ModEvent.PushFloat(handle, GVHolder.WidgetLeft as float)
		ModEvent.PushFloat(handle, GVHolder.WidgetTop as float)
		ModEvent.Send(handle)
	endIf
	ModEvent.Send(ModEvent.Create("FMPPlayerFactStat"))

endEvent

string function MakePlayerString(int actorIndex)

		string added = ""
		string textString = "Unknown"
		percent = 0.0
		float cycleDay = Handler.Storage.DayOfCycle[actorIndex] as float
		float now = GVHolder.GVGameDaysPassed.GetValue()

		if (Handler.Storage.LastOvulation[actorIndex] != 0.0)
			added += "(*)"
		endIf
		if Handler.Storage.LastInsemination[actorIndex]
			added += "(!)"
		endIf

		if (stateID == 0)
			; Ovulation phase, pre-actual ovulation
			textString = "Pre-Fertile " + added
			if (cycleDay == 2.0)	; should only happen on the 7-day cycle
				percent = 0.5
			else
			; 1.55 revised
				percent = ((cycleDay - GVHolder.OvulationBegin) / (Handler.Storage.FMValues[1] - GVHolder.OvulationBegin + 1)) as float
			endIf
		elseIf (stateID == 1)
			if playerRef.HasEffectKeyword(FertilityKeyword)
				if playerRef.HasMagicEffect(EffectContraception)
					added += "(-)"
				else
					added += "(+)"
				endIf
			endIf
			textString = added + "Conception Chance: " + MakeFertilityString(actorIndex, now, 0, -1)
			percent = Handler.Storage.LastOvulation[actorIndex]
		elseIf (stateID == 2)
			; Luteal phase, ovulation phase, post egg die-off
			textString = "Not Fertile " + added
			percent = ((cycleDay - Handler.Storage.FMValues[1]) / (GVHolder.CycleDuration - Handler.Storage.FMValues[1]))
		elseIf (stateID == 3)
			; Menstruation
			textString = "Not Fertile"
			percent = cycleDay / (GVHolder.OvulationBegin - 1) as float
		elseIf (stateID == 4 || stateID == 5 || stateID == 6 || stateID == 20)
			; Pregnant
			if Handler.Storage.FMValues[7]
				textString = "Pregnancy Day: " + ((now - Handler.Storage.LastConception[actorIndex]) as int)
			else
				textString = "Baby Health: " + ((Handler.Storage.BabyHealth as float / 105.0) * 100 as int) + "%"
			endIf
			percent = (now - Handler.Storage.LastConception[actorIndex]) / GVHolder.PregnancyDuration
		; 1.59 new stateId
		elseIf (stateID == 7)
			textString = "Not Fertile"
			percent = (cycleDay / GVHolder.CycleDuration)
		elseIf (stateID == 8)
			; Recovery
			textString = "Not Fertile"
			percent = (now - Handler.Storage.LastBirth[actorIndex]) / GVHolder.RecoveryDuration
		endIf
		; added 1.41 since exact dates may fluctuate, we could exceed 100%
		if (percent > 1.0)
			percent = 1.0
		endIf
		return textString

endFunction

string function MakeFertilityString(int actorindex, float now, int sprmCount, int TBTA)
{saves duplicating work}

	if (actorindex == -1)
		return " "
	endif
	int fertility = CalculateFertility(actorIndex, now)
	string returnString
	if (Math.LogicalAnd(fertility, 0x00030000) == 0)	; no fertility magic effect
		returnString = Math.LogicalAnd(fertility, 0x0000007F) + "%"
	elseIf Math.LogicalAnd(fertility, 0x00010000)	; contraception effect
		fertility = Math.LogicalAnd(fertility, 0x0000007F)
		float newFertility = (((fertility * fertility) as float) / 100.0)
		returnString = (newFertility as int) + "." + (((newFertility - ((newFertility as int) as float)) * 100.0) as int) + "%"
	else	; fertility effect
		fertility = Math.LogicalAnd(fertility, 0x0000007F)
		returnString = (((fertility * 2) - Math.Pow((fertility / 10), 2)) as int) + "%"
	endIf
	if (TBTA != -1)
		returnString += "] " + TBTA
	endIf
	if (sprmCount != 0)
		returnString = sprmCount + "[" + returnString
	endIf
	return returnString
endFunction

int function CalculateFertility(int recycleInt, float spermAge = 0.0)
{calculates the actor's fertility}

	actor akActor = Handler.Storage.TrackedActors[recycleInt] as Actor
	if !akActor
		return 0
	endIf
	if !spermAge; well, ok it's not quite spermAge yet, but it will be....
		spermAge = GVHolder.GVGameDaysPassed.GetValue()
	endIf
	int spermCount = Handler.Storage.SpermCount[recycleInt]
	spermAge -= Handler.Storage.LastInsemination[recycleInt]
	if ((Handler.Storage.LastOvulation[recycleInt] == 0.0) || (spermCount == 0) || (spermAge < 0.125))
		return 0	; there's no egg, or no sperm, or the sperm need more time to reach the egg
	endIf
	; above here, recycleInt is the array index, below it's fertility
	recycleInt = GVHolder.ConceptionChance
	; this is very much a WIP
	recycleInt += ((spermCount / 100) * (spermAge + 0.5)) as int
	if (recycleInt < 1)
		return 0
	elseif (spermAge > (GVHolder.SpermLife as float - 1.0)); sperm life
		; 1.55 use shift
		recycleInt = Math.RightShift(recycleInt, 2)		; quartered for geriatric sperm
	endIf
	; 1.55 added check for > 100 to prevent overflow into fertility flags
	if (recycleInt > 100)
		recycleInt = 100
	endIf
	if akActor.HasEffectKeyword(FertilityKeyword)
		if akActor.HasMagicEffect(EffectContraception)
			; changes in 1.55
			recycleInt = Math.LogicalOr(recycleInt, 0x00010000)	; set 17th bit
		;/ if they have the keyword, but not the contraception then by
		process of elimination they must have fetility effect /;
		else
			recycleInt = Math.LogicalOr(recycleInt, 0x00020000)	; set 18th bit
		endIf
	endIf
	return recycleInt

endFunction

event OnFMPPlayFactStat()
{Updates the current cycle buff and debuff status for the player}

	RegisterForModEvent("FMPPlayerFactStat", "OnFMPPlayFactStat")
	if ((stateId == -1) && (Handler.Util.GetActorGender(playerRef) == 1) && GVHolder.Enabled)
		stateId = GetActorStateID(Handler.Storage.TrackedActors.Find(playerRef as form))
	endIf
	if stateID == -1
		playerRef.RemoveFromFaction(GenericFaction)
	elseIf ((stateID == 4) || (stateID == 5) || (stateID == 6) || (stateID == 20))
		int index = Handler.Storage.TrackedActors.Find(PlayerRef as form)
		if (index == -1)
			return
		endIf
		index = Math.LogicalAnd((((GVHolder.GVGameDaysPassed.GetValue() - Handler.Storage.LastConception[index]) / GVHolder.PregnancyDuration as float) * 100.0) as int, 0x0000007F)
		PlayerRef.SetFactionRank(GenericFaction, index)
	elseIf (stateID == 8)
		int index = Handler.Storage.TrackedActors.Find(PlayerRef as form)
		if (index == -1)
			return
		endIf
		index = Math.LogicalAnd((((GVHolder.GVGameDaysPassed.GetValue() - Handler.Storage.LastBirth[index]) / GVHolder.RecoveryDuration as float) * 36.0) as int, 0x0000003F)
		if (index > 36)
			index = 36
		endIf
		playerRef.SetFactionRank(GenericFaction, (-85 - index))
	else
		; 2.14 I'm apparently an idiot
;		PlayerRef.SetFactionRank(GenericFaction, ((stateId * -5) - 5))
		PlayerRef.SetFactionRank(GenericFaction, ((stateId * -10) - 5))
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
int function GetActorStateID(int actorIndex = -1)
{calculate the StateID for the two functions that need that info}

	if (actorIndex == -1)
		return -1
	endIf
	int cycleDay = Handler.Storage.DayOfCycle[actorIndex]
	;/	as of 1.41, day of cycle is "frozen" during pregnancy or recovery, so pregnancy
		and recovery checks *must* come before anything based on day of cycle /;

	if Handler.Storage.LastConception[actorIndex]
        int pregnantDay = (GVHolder.GVGameDaysPassed.GetValue() - Handler.Storage.LastConception[actorIndex]) as int

        if (pregnantDay < (Handler.Storage.FMValues[0] + 1))
            return 4	; first trimester
        elseIf (pregnantDay < (Handler.Storage.FMValues[0] * 2 + 1))
            return 5	; second trimester
		; edit 1.43: changed the below on purpose to state=20 a day sooner
        elseIf (pregnantDay < (Handler.Storage.FMValues[0] * 3))
            return 6	; third trimester
        else
            return 20	; full-term pregnancy
        endIf
    elseIf (Handler.Storage.TimesDelivered[actorIndex] && ((GVHolder.GVGameDaysPassed.GetValue() - Handler.Storage.LastBirth[actorIndex]) < (GVHolder.RecoveryDuration)))
        return 8	; recovery from birth
    elseIf (cycleDay < GVHolder.OvulationBegin)
        return 3	; menstruation
	elseIf (Handler.Storage.LastOvulation[actorIndex] != 0.0)
		return 1	; ovulation phase, with egg
		; changed 1.43
		; changed 1.5.1 added +2
    elseIf (cycleDay < (Handler.Storage.FMValues[1] + 2))
		; 1.59 added stateID 7
		if (Handler.Storage.OvulationBlock[actorIndex] > 0)
			return 7	; ovulation is blocked this cycle
		else
			return 0	; ovulation phase, before egg
		endIf
	endIf
	return 2		; luteal - ovulation phase, after egg has died

endFunction

function UpdateCyclePerks(bool female = false)
{passes along request from MCM to update player perks}

	PlayerRef.RemovePerk(FemaleCyclePerk)
	if female
		PlayerRef.AddPerk(FemaleCyclePerk)
	endIf
	; 1.58
	stateId = -1
	OnFMPPlayFactStat()

endFunction
