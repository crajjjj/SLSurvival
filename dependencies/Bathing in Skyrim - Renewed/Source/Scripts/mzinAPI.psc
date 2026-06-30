Scriptname mzinAPI Hidden

; ----------------------------------------------------------------------------------------------------
; -------------------------------------------------- API
; ----------------------------------------------------------------------------------------------------

; Get - Mod Version
string Function GetModVersion() Global
    return "2.7.9"
EndFunction

; Get - Config Version
Int Function GetConfigVersion() Global
	return 22
EndFunction

; Get - Script Version
int Function GetVersion() Global
	return 0x02070922 ; 0x01020304
EndFunction

; Get - Mod Name
string Function GetModName(bool cache = true) Global
	if cache
		return GetMCM().modname
	else
		return "Bathing in Skyrim - Renewed"
	endIf
EndFunction

; Get - Mod State
float Function GetModState() Global
    return GetMCM().BathingInSkyrimEnabled.GetValue()
EndFunction

; Get - Utility
mzinUtility Function GetUtility() Global
	return Quest.GetQuest("mzinUtilityQuest") as mzinUtility
EndFunction

; Get - MCM
mzinBatheMCMMenu Function GetMCM() Global
	return Quest.GetQuest("mzinBatheMCMQuest") as mzinBatheMCMMenu
EndFunction

; Get - Core
mzinBatheQuest Function GetBatheQuest() Global
	return Quest.GetQuest("mzinBatheQuest") as mzinBatheQuest
EndFunction

; Bool - IsActorInWater
Bool Function IsActorInWater(Actor akActor) global
	mzinBatheQuest BatheQuest = GetBatheQuest()
	return BatheQuest.IsInWater(akActor) || BatheQuest.IsUnderWaterfall(akActor)
EndFunction