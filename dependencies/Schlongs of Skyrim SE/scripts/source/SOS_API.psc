Scriptname SOS_API extends Form

SOS_SetupQuest_Script Property SOS Auto

Int Property MIN_SIZE = 4 Auto Hidden
Int Property MAX_SIZE = 20 Auto Hidden

SOS_API Function Get() Global
{
	Returns an instance of this script
}
	Return Game.GetFormFromFile(0x1eda4, "Schlongs of Skyrim.esp") as SOS_API
EndFunction

Bool Function IsSchlonged(Actor akActor)
{
	Returns true if the actor has a schlong
}
	If akActor
		Return akActor.IsInFaction(SOS.SOS_SchlongifiedFaction)
	EndIf
	Return False
EndFunction

Int Function GetSize(Actor akActor)
{
	Returns the size of the schlong of akActor
	@param akActor that must be already schlonged
	@returns the size (1-20), or -1 if akActor is not an actor or is not schlonged
}
	If IsSchlonged(akActor)
		Return akActor.getFactionRank(SOS.SOS_SchlongifiedFaction)
	EndIf
	Return -1
EndFunction

Bool Function SetSize(Actor akActor, Int size)
{
	Changes the size of the schlong of akActor
	@param akActor that must be already schlonged
	@param size range (1-20)
	@returns true if the actor was schlonged and it was a valid size
}
	If akActor && size > 0 && size < 21
		Form addon = GetSchlong(akActor)
		If addon
			SOS.SetSchlongSize(addon, akActor, size)
			Return True
		EndIf
	EndIf
	Return False
EndFunction

Form Function GetSchlong(Actor akActor)
{
	Gets the current schlong of akActor
	@returns an instance of the SOS_AddonQuest_Script if actor is valid and have a schlong, otherwise None
}
	If akActor
		Return SOS.GetActiveAddon(akActor)
	EndIf
	Return None
EndFunction

Bool Function SetSchlong(Actor akActor, Form addon)
{
	Sets the current schlong to akActor
	If the actor is already schlongified the schlong size will be maintained, otherwise size 1
	@param akActor the actor
	@param addon the schlong to set, must be an instance of SOS_AddonQuest_Script
	@returns true if the actor got the new schlong, false if the arguments are invalid
}
	If akActor && addon as SOS_AddonQuest_Script
		SOS.SetSchlong(akActor, addon, Utility.IsInMenuMode())
		Return True
	EndIf
	Return False
EndFunction

Bool Function RemoveSchlong(Actor akActor)
{
	Removes the current schlong from akActor and prevents him from getting a new one
	@returns true if the argument is valid
}
	If akActor
		Form addon = GetSchlong(akActor)
		If addon
			SOS.RemoveSchlongFromActor(addon, akActor)
		EndIf
		SOS_Data.AddBlacklisted(akActor)
		Return True
	EndIf
	Return False
EndFunction

Form Function FindSchlongByName(String name)
{
	Finds a schlong by its name. For example, "Smurf Average".
	The schlong name is by convention the name of the schlong faction, without the "SOS " prefix.
	These are the names you see in SOS MCM menu
	@returns an instance of the SOS_AddonQuest_Script if found, otherwise None
}
	int i = SOS_Data.CountAddons()
	While i > 0
		i-= 1
		If name == SOS_Data.GetAddon(i).GetAddonName()
			Return SOS_Data.GetAddon(i)
		EndIf
	EndWhile
	Return None
EndFunction

Int Function GetMinSchlongSize()
{
	@return the "Min schlong size" MCM setting 
}
	Return SOS.config.iMinSchlongSize
EndFunction

Bool Function SetMinSchlongSize(Int minSize)
{
	Modifies the "Min schlong size" MCM setting
	@param maxSize the size to set. Must be between 1 and 7
	@return true if the argument was valid and the setting was changed succesfully
}
	If minSize > 0 && minSize < 8
		SOS.config.iMinSchlongSize = minSize
		Return true
	EndIf
	Return false
EndFunction

Int Function GetMaxSchlongSize()
{
	@return the "Max schlong size" MCM setting 
}
	Return SOS.config.iMaxSchlongSize
EndFunction

Bool Function SetMaxSchlongSize(Int maxSize)
{
	Modifies the "Max schlong size" MCM setting
	@param maxSize the size to set. Must be between 0 and 20
	@return true if the argument was valid and the setting was changed succesfully
}
	If maxSize > 0 && maxSize < 21
		SOS.config.iMaxSchlongSize = maxSize
		Return true
	EndIf
	Return false
EndFunction

Float Function GetGlobalSchlongSizeBoostFactor()
{
	@return the "Schlong size multiplier" MCM setting 
}
	Return SOS.config.fGlobalSchlongSizeBoostFactor
EndFunction

Bool Function SetGlobalSchlongSizeBoostFactor(Float factor)
{
	Modifies the "Schlong size multiplier" MCM setting
	@param factor the value to set. Must be greater than -50
	@return true if the argument was valid and the setting was changed succesfully
}
	If factor >= -50
		SOS.config.fGlobalSchlongSizeBoostFactor = factor
		SOS.SendModEvent("ReSchlongify", "ScaleSchlongs")
		Return true
	EndIf
	Return false
EndFunction

;Bool Function RequestSchlongedActors(String callbackEvent)
;	If callbackEvent != ""
;		SendModEvent("ReSchlongify", callbackEvent)
;		Return true
;	EndIf
;	Return False
;EndFunction

Bool Function AddRace(Race aRace)
	Bool result = False
	int i = SOS_Data.CountAddons()
	; loop installed addons
	While i > 0
		i-= 1
		Bool added = AddRaceToAddon(aRace, SOS_Data.GetAddon(i))
		If added
			result = True
		EndIf
	EndWhile
	Return result
EndFunction

Bool Function AddRaceToAddon(Race aRace, SOS_AddonQuest_Script addon)
	Bool result = False
	If aRace && SOS_Data.FindCompatibleRace(addon, aRace) == -1
		; add the custom race to this addon with default values
		SOS_Data.AddCompatibleRace(addon, aRace)
		SOS_Data.AddEnabledRace(addon, aRace)
		SOS_Data.AddRaceSize(addon, 0)
		SOS_Data.AddRaceProbability(addon, 10.0)
		SOS_Data.AddKnownRace(aRace)
		result = True
	EndIf
	Return result
EndFunction
