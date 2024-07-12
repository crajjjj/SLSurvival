Scriptname PAF_DDQuestScript extends Quest

Form DD

Keyword Property zad_PermitOral Auto
Keyword Property zad_PermitAnal Auto
Keyword Property zad_PermitVaginal Auto


function InitDDQuest()
	
	DD = Game.GetFormFromFile(0x0000f624, "Devious Devices - Integration.esm")
	DisplayMessage("PAF: DD Integration loaded")
endFunction

string function GetDDVersion()

	return (Game.GetFormFromFile(0x0000f624, "Devious Devices - Integration.esm") as zadLibs).GetVersionString()
	;return "not installed"
	
endFunction

bool function HasArmbinder(Actor a_actor)
	if (DD != none)
		return ((DD as zadLibs).GetWornDevice(a_actor, (DD as zadLibs).zad_DeviousArmbinder) != none) || ((DD as zadLibs).GetWornDevice(a_actor, (DD as zadLibs).zad_DeviousYoke) != none)
	endif
	return false	
endFunction

bool function IsAnalPlugged(Actor a_actor)
	if (DD != none)		
		return (DD as zadLibs).GetWornDevice(a_actor, (DD as zadLibs).zad_DeviousPlugAnal) != none		
	endif
	return false
endFunction

bool function IsGagged(Actor a_actor)	
	if (DD != none)
		Armor gag = (DD as zadLibs).GetWornDevice(a_actor, (DD as zadLibs).zad_DeviousGag)
		if (gag != none)
			if ((DD as zadLibs).GetWornDevice(a_actor, (DD as zadLibs).zad_PermitOral) != none)
				return false
			endif		
			return true
		endif
	endif
	return false
endFunction

bool function HasDeviousBelt(Actor a_actor)
	if (DD != none)
		Armor belt = (DD as zadLibs).GetWornDevice(a_actor, (DD as zadLibs).zad_PermitAnal)
		if (belt != none)
			belt = (DD as zadLibs).GetWornDevice(a_actor, (DD as zadLibs).zad_DeviousBelt)
			if (belt != none)
				return false
			endif		
			return true
		endif
	endif
	return false
endFunction

function DisplayMessage(string msg)
	Debug.Notification(msg)
endFunction