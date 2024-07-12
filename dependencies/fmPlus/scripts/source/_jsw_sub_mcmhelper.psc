Scriptname _JSW_SUB_MCMHelper extends Quest

_JSW_SUB_GVAlias		Property	GVAlias			Auto	; 
_JSW_BB_Utility			Property	Util			Auto	; Independent helper functions
_JSW_BB_Storage			Property	Storage			Auto	; Storage data helper
_JSW_SUB_MiscUtilQuest	Property	FMMiscUtil		Auto	; script to calculate conception chance and stuff

Actor 			Property 	PlayerRef  				Auto	; Reference to the player. Game.GetPlayer() is slow

Faction			Property	CycleBuffFaction	 	Auto	; 10% buff/debuff

Keyword			Property	FertilityKeyword		Auto	; keyword for fertility altering effects

MagicEffect		Property	EffectContraception		Auto	; Magic effect for decreased fertility
MagicEffect		Property	EffectFertility			Auto	; Magic effect for increased fertility

int[]			Property	returnList				Auto	; the list of filtered actors 
int		lastFilterType = 7
int		STALength

function ReallyCountActors(int filterType)
;	return returnList
endFunction

function UpdateTheFactions(int percent)
endFunction

event OnUpdate()

	UnregisterforUpdate()
	returnList = Utility.ResizeIntArray(returnList, 0)
	lastFilterType = 7
	
endEvent

function UpdateFactions(int percent)

	GoToState("UpdateBuffFactions")
	UpdateTheFactions(percent)

endFunction

; 1.64
string function GenerateFirstString(int actorIndex, string preString, int someDay, string postString)

	return (prestring + someDay + "]" + postString + (Storage.TrackedActors[actorIndex] as objectReference).GetDisplayName() + "(" + Storage.LastMotherLocation[actorIndex] + ")")

endFunction

function CountFilteredActors(int filterType)
{returns how many tracked actors based on the filter}

	UnregisterforUpdate()
	if (filterType == 12)	; males
		STALength = Math.LogicalAnd(Storage.TrackedFathers.Length, 0x00000FFF)
	else
		STALength = Math.LogicalAnd(Storage.TrackedActors.Length, 0x00000FFF)
	endIf
	if (STALength < 1)
		OnUpdate()
		return
	endIf
	if ((lastFilterType == filterType) && (returnList.Length > 0))
		RegisterForSingleUpdate(30.0)
		return
	endIf
	UnregisterforUpdate()
	GoToState("Filter" + filterType)
	lastFilterType = filterType
	ReallyCountActors(filterType)
	RegisterForSingleUpdate(30.0)

endFunction

State Filter0	;	All (unfiltered)

	function ReallyCountActors(int filterType)

		returnList = Utility.ResizeIntArray(returnList, STALength)
		int index = 0
		while (index < STALength)
			if (Storage.TrackedActors[index] as actor)
				returnList[filterType] = index
				filterType += 1
			endIf
			index += 1
		endWhile
		GoToState("")
		returnList = Utility.ResizeIntArray(returnList, filterType)

	endFunction

endState

State Filter1	;	All Unique

	function ReallyCountActors(int filterType)

		returnList = Utility.ResizeIntArray(returnList, STALength)
		int index = 0
		filterType = 0
		while (index < STALength)
			if (Storage.TrackedActors[index] as actor)
				; 2.25
;				if (Storage.TrackedActors[index] as actor).GetLeveledActorBase().IsUnique()
				if (Storage.ATFlags[index] != -1)
					returnList[filterType] = index
					filterType += 1
				endIf
			endIf
			index += 1
		endWhile
		GoToState("")
		returnList = Utility.ResizeIntArray(returnList, filterType)

	endFunction

endState

State Filter2	;	Ovulating

	function ReallyCountActors(int filterType)

		returnList = Utility.ResizeIntArray(returnList, STALength)
		int index = 0
		filterType = 0
		while (index < STALength)
			if (Storage.TrackedActors[index] as actor) && (Storage.LastOvulation[index] != 0.0)
				returnList[filterType] = index
				filterType += 1
			endIf
			index += 1
		endWhile
		GoToState("")
		returnList = Utility.ResizeIntArray(returnList, filterType)

	endFunction

endState

State Filter3	;	Pregnant

	function ReallyCountActors(int filterType)

		returnList = Utility.ResizeIntArray(returnList, STALength)
		int index = 0
		filterType = 0
		while (index < STALength)
			if (Storage.TrackedActors[index] as actor) && (Storage.LastConception[index] != 0.0)
				returnList[filterType] = index
				filterType += 1
			endIf
			index += 1
		endWhile
		GoToState("")
		returnList = Utility.ResizeIntArray(returnList, filterType)

	endFunction

endState

State Filter4	;	Not Pregnant

	function ReallyCountActors(int filterType)

		returnList = Utility.ResizeIntArray(returnList, STALength)
		int index = 0
		filterType = 0
		while (index < STALength)
			if (Storage.TrackedActors[index] as actor) && (Storage.LastConception[index] == 0.0)
				returnList[filterType] = index
				filterType += 1
			endIf
			index += 1
		endWhile
		GoToState("")
		returnList = Utility.ResizeIntArray(returnList, filterType)

	endFunction

endState

State Filter5	;	player-related

	function ReallyCountActors(int filterType)

		returnList = Utility.ResizeIntArray(returnList, STALength)
		form playerRefForm = playerRef as form
		int index = 0
		filterType = 0
		while (index < STALength)
			; 2.26
;			if (Storage.TrackedActors[index] as actor) && (Storage.CurrentFatherForm[index] == playerRefForm)
			if (Storage.TrackedActors[index] as actor) && ((Storage.CurrentFatherForm[index] == playerRefForm) || (Storage.LastFatherForm[index] == playerRefForm))
				returnList[filterType] = index
				filterType += 1
			endIf
			index += 1
		endWhile
		GoToState("")
		returnList = Utility.ResizeIntArray(returnList, filterType)

	endFunction

endState

State Filter12	;	males

	function ReallyCountActors(int filterType)

		returnList = Utility.ResizeIntArray(returnList, STALength)
		int index = 0
		filterType = 0
		while (index < STALength)
			if (Storage.TrackedFathers[index] as actor)
				returnList[filterType] = index
				filterType += 1
			endIf
			index += 1
		endWhile
		GoToState("")
		returnList = Utility.ResizeIntArray(returnList, filterType)

	endFunction

endState

state UpdateBuffFactions

	function UpdateTheFactions(int percent)
	{applies correct faction to character based on slider setting}

		GoToState("")
		PlayerRef.SetFactionRank(CycleBuffFaction, percent)
		FMMiscUtil.UpdateCyclePerks(Util.GetActorGender(playerRef) == 1)
		; 1.58 make updatecontent not gender conditional
		if GVAlias.GVHolder.Enabled
			ModEvent.Send(ModEvent.Create("FMPUpdateWidgetContent"))
			ModEvent.Send(ModEvent.Create("FMPPlayerFactStat"))
		endIf
	endFunction

endState

string	function	GetThatString(string formToGet)

	if formToGet == ""
		return ""
	endIf
	int formID = 0
	int iterations = 0
		;/	you *have to* count up from zero in interations otherwise it will scramble the FormID sequence	/;
	while (iterations < 3)
		; the first ShiftLeft is useless, but it is needed for subsequent ones to prevent mangling the FormID
		formID = Math.LeftShift(formID, 4)
		int tempInt = StringUtil.AsOrd(StringUtil.GetNthChar(formToGet, iterations))
		;	letters will return AsOrd value = (Hex Value + 55)
		if tempInt > 63
			tempInt -= 55
		else
			; numerals return AsOrd value = (Hex Value + 48)
			tempInt -= 48
		endIf
		formID = Math.LogicalOR(formID, tempInt)
		iterations += 1
	endWhile
	;/	GetMeMyForm() is custom, similar to GetFormFromFile in parameters, but has error-checking for out-of-bounds
		FormIDs in ESL plugins.  Requires SKSE	/;
	if !((Math.LogicalAnd(0xFFFFF000, formID) != 0) || (Math.LogicalAnd(0x00000800, formID) == 0))
		form theForm = GVAlias.GVHolder.GetMeMyForm(formID, "Fertility Mode 3 Fixes and Updates.esp")
		if theForm
			return theForm.GetName()
		else
			Debug.Trace("FM+ : Erroneous FormID " + formId + " attempted by MCM script.  State: " + formToGet)
		endIf
	endIf
	return ""

endFunction
