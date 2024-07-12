Scriptname SOS_AddonQuest_Script extends Quest  

;----------ADDON PROPERTIES----------

FormList Property SOS_Addon_CompatibleRaces Auto
FormList Property SOS_Addon_RaceSizes Auto
FormList Property SOS_Addon_RaceProbabilities Auto
FormList Property SOS_Addon_Schlonged Auto

Faction Property SOS_Addon_Faction Auto
Armor Property SOS_Addon_Genitals Auto
Potion Property SOS_Addon_Potion Auto
GlobalVariable Property SOS_Addon_Gender Auto

GlobalVariable Property SOS_Addon_Bone_GenBase Auto
GlobalVariable Property SOS_Addon_Bone_GenScrotum Auto
GlobalVariable Property SOS_Addon_Bone_Gen01 Auto
GlobalVariable Property SOS_Addon_Bone_Gen02 Auto
GlobalVariable Property SOS_Addon_Bone_Gen03 Auto
GlobalVariable Property SOS_Addon_Bone_Gen04 Auto
GlobalVariable Property SOS_Addon_Bone_Gen05 Auto
GlobalVariable Property SOS_Addon_Bone_Gen06 Auto

;----------SOS CORE PROPERTIES----------

FormList Property SOS_Addons Auto

;----------EVENTS----------

Event OnInit()
	If !SelfCheck()
		Debug.MessageBox("SOS Addon '" + self.GetName() + "' is dirty, plese notify the Addon author to fix it.\nIn order to prevent data corruption it was not loaded!") ; todo translate
		Return
	EndIf

	RegisterAddon()

EndEvent

Function RegisterAddon()
	
	; initialize all compatible races as enabled
	int i = 0
	int raceCount = SOS_Addon_CompatibleRaces.GetSize()
	while(i < raceCount)
		Form aRace = SOS_Addon_CompatibleRaces.GetAt(i)
		SOS_Data.AddCompatibleRace(self, aRace)
		SOS_Data.AddEnabledRace(self, aRace)
		SOS_Data.AddKnownRace(aRace)
		SOS_Data.AddRaceSize(self, (SOS_Addon_RaceSizes.GetAt(i) as GlobalVariable).GetValueInt())
		SOS_Data.AddRaceProbability(self, (SOS_Addon_RaceProbabilities.GetAt(i) as GlobalVariable).GetValue())
		i += 1
	endwhile
	
	SOS_Data.AddFaction(self, SOS_Addon_Faction)
	SOS_Data.SetGender(self, SOS_Addon_Gender.GetValueInt())
	SOS_Data.AddGenitalArmor(self, SOS_Addon_Genitals)
	
	SOS_Data.AddAddon(self)
	SOS_Addons.AddForm(self)

	SOS_Data.AddBone(self, SOS_Addon_Bone_GenBase.GetValue())
	SOS_Data.AddBone(self, SOS_Addon_Bone_GenScrotum.GetValue())
	SOS_Data.AddBone(self, SOS_Addon_Bone_Gen01.GetValue())
	SOS_Data.AddBone(self, SOS_Addon_Bone_Gen02.GetValue())
	SOS_Data.AddBone(self, SOS_Addon_Bone_Gen03.GetValue())
	SOS_Data.AddBone(self, SOS_Addon_Bone_Gen04.GetValue())
	SOS_Data.AddBone(self, SOS_Addon_Bone_Gen05.GetValue())
	SOS_Data.AddBone(self, SOS_Addon_Bone_Gen06.GetValue())

	Debug.Notification("SOS Addon " + GetAddonName() + " loaded!") ; todo translate
	
EndFunction

bool Function SelfCheck()
	{Ensures that the mod author did not forget to set any property in the CK which could lead to abortion midway during initialization leaving the formlists messed up and therefore breaking all other addons}
	
	String addonName = self.GetName()
	
	; addon preference collections
	if(!(SOS_Addon_CompatibleRaces && SOS_Addon_EnabledRaces && SOS_Addon_RaceSizes && SOS_Addon_RaceProbabilities))
		Debug.Trace("SOS: dirty addon '" + addonName + "' settings collection references")
		return false
	else
		int raceCount = SOS_Addon_CompatibleRaces.GetSize()
		if(raceCount < 1 || SOS_Addon_EnabledRaces.GetSize() > 0 || SOS_Addon_RaceSizes.GetSize() != raceCount || SOS_Addon_RaceProbabilities.GetSize() != raceCount)
			Debug.Trace("SOS: dirty addon '" + addonName + "' settings collection content (" + raceCount + ", " + SOS_Addon_EnabledRaces.GetSize() + ", " + SOS_Addon_RaceSizes.GetSize() + "," + SOS_Addon_RaceProbabilities.GetSize() + ")")
			return false
		endif
	endif
	
	; addon assets
	if(!(SOS_Addon_Faction && SOS_Addon_Genitals && SOS_Addon_Potion && SOS_Addon_Gender && SOS_Addon_Schlonged))
		Debug.Trace("SOS: dirty addon '" + addonName + "' asset references")
		return false
	endif

	; addon subshape globals
	if(!(SOS_Addon_Bone_GenBase && SOS_Addon_Bone_GenScrotum && SOS_Addon_Bone_Gen01 && SOS_Addon_Bone_Gen02 && SOS_Addon_Bone_Gen03 && SOS_Addon_Bone_Gen04 && SOS_Addon_Bone_Gen05 && SOS_Addon_Bone_Gen06))
		Debug.Trace("SOS: dirty addon '" + addonName + "' subshape global references")
		return false
	endif
	
	; sos core esm references
	If !SOS_Addons
		Debug.Trace("SOS: dirty addon '" + addonName + "' core esm references")
		Return False
	EndIf
	
	return true
EndFunction

Function UnregisterAddon()
	{Tries to remove itself from everywhere it has put itself durint the init}
	
	Debug.Trace("SOS: trying to remove everything added by the " + self.GetName() + " addon")
	
	SOS_Data.ClearCompatibleRaces(self)
	SOS_Data.ClearEnabledRaces(self)
	SOS_Data.ClearRaceSizes(self)
	SOS_Data.ClearRaceProbabilities(self)
	SOS_Data.ClearFaction(self)
	SOS_Data.ClearGender(self)
	SOS_Data.ClearSchlongeds(self)
	SOS_Data.ClearGenitalArmor(self)

	SOS_Data.RemoveAddon(self)
	SOS_Addons.RemoveAddedForm(self)
	
	Debug.Trace("SOS: unregistration of " + self.GetName() + " addon hopefully complete")
	Debug.Notification("SOS Addon " + self.GetName() + " unregistered!") ; todo translate
EndFunction

String Function GetAddonName()
	; by convention the name of the Faction is unique and describes the schlong type as short and precise as possible, prefixed with "SOS "
	Return StringUtil.Substring(SOS_Addon_Faction.GetName(), 4)
EndFunction

String Function GetName()
	Return GetAddonName()
EndFunction

; DEPRECATED PROPERTIES

FormList Property SOS_AddonLock Auto
FormList Property SOS_CompatibleRaces Auto
FormList Property SOS_EnabledRaces Auto
FormList Property SOS_RaceSizes Auto
FormList Property SOS_RaceProbabilities Auto
FormList Property SOS_Factions Auto
FormList Property SOS_GenitalArmors Auto
FormList Property SOS_Genders Auto
FormList Property SOS_ShapePotions Auto
FormList Property SOS_Bone_GenBase Auto
FormList Property SOS_Bone_GenScrotum Auto
FormList Property SOS_Bone_Gen01 Auto
FormList Property SOS_Bone_Gen02 Auto
FormList Property SOS_Bone_Gen03 Auto
FormList Property SOS_Bone_Gen04 Auto
FormList Property SOS_Bone_Gen05 Auto
FormList Property SOS_Bone_Gen06 Auto
FormList Property SOS_Schlonged Auto
LeveledItem Property SOS_LItemShapePotions Auto
FormList Property SOS_Addon_EnabledRaces Auto
