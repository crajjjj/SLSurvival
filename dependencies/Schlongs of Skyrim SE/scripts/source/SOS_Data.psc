Scriptname SOS_Data

Int Function Add(Form obj, String listName, Form value) Global
	Return SOS_SKSE.FormListAdd(obj, listName, value, allowDuplicate = false)
EndFunction

Int Function Remove(Form obj, String listName, Form value) Global
	Return SOS_SKSE.FormListRemove(obj, listName, value, allInstances = true)
EndFunction

; ConcealingArmors ========================================================

Int Function AddConcealingArmor(Armor akArmor) Global
	Return Add(None, "SOS_ConcealingArmors", akArmor)
EndFunction
Int Function ClearConcealingArmors() Global
	Return SOS_SKSE.FormListClear(None, "SOS_ConcealingArmors")
EndFunction
Int Function CountConcealingArmors() Global
	Return SOS_SKSE.FormListCount(None, "SOS_ConcealingArmors")
EndFunction
Int Function FindConcealingArmor(Armor akArmor) Global
	Return SOS_SKSE.FormListFind(None, "SOS_ConcealingArmors", akArmor)
EndFunction
Armor Function GetConcealingArmor(Int i) Global
	Return SOS_SKSE.FormListGet(None, "SOS_ConcealingArmors", i) as Armor
EndFunction
Int Function RemoveConcealingArmor(Armor akArmor) Global
	Return SOS_SKSE.FormListRemove(None, "SOS_ConcealingArmors", akArmor)
EndFunction

; RevealingArmors ========================================================

Int Function AddRevealingArmor(Armor akArmor) Global
	Return Add(None, "SOS_RevealingArmors", akArmor)
EndFunction
Int Function ClearRevealingArmors() Global
	Return SOS_SKSE.FormListClear(None, "SOS_RevealingArmors")
EndFunction
Int Function CountRevealingArmors() Global
	Return SOS_SKSE.FormListCount(None, "SOS_RevealingArmors")
EndFunction
Int Function FindRevealingArmor(Armor akArmor) Global
	Return SOS_SKSE.FormListFind(None, "SOS_RevealingArmors", akArmor)
EndFunction
Armor Function GetRevealingArmor(Int i) Global
	Return SOS_SKSE.FormListGet(None, "SOS_RevealingArmors", i) as Armor
EndFunction
Int Function RemoveRevealingArmor(Armor akArmor) Global
	Return SOS_SKSE.FormListRemove(None, "SOS_RevealingArmors", akArmor)
EndFunction

; Addons ========================================================

Int Function AddAddon(SOS_AddonQuest_Script addon) Global
	Return Add(None, "SOS_Addons", addon)
EndFunction
Int Function ClearAddons() Global
	Return SOS_SKSE.FormListClear(None, "SOS_Addons")
EndFunction
Int Function CountAddons() Global
	Return SOS_SKSE.FormListCount(None, "SOS_Addons")
EndFunction
Int Function FindAddon(Form addon) Global
	Return SOS_SKSE.FormListFind(None, "SOS_Addons", addon)
EndFunction
SOS_AddonQuest_Script Function GetAddon(Int i) Global
	Return SOS_SKSE.FormListGet(None, "SOS_Addons", i) as SOS_AddonQuest_Script
EndFunction
Int Function RemoveAddon(SOS_AddonQuest_Script addon) Global
	Return Remove(None, "SOS_Addons", addon)
EndFunction

; KnownRaces ========================================================

Int Function AddKnownRace(Form aRace) Global
	Return Add(None, "SOS_KnownCompatibleRaces", aRace)
EndFunction
Int Function ClearKnownRaces() Global
	Return SOS_SKSE.FormListClear(None, "SOS_KnownCompatibleRaces")
EndFunction
Int Function CountKnownRaces() Global
	Return SOS_SKSE.FormListCount(None, "SOS_KnownCompatibleRaces")
EndFunction
Int Function FindKnownRace(Race aRace) Global
	Return SOS_SKSE.FormListFind(None, "SOS_KnownCompatibleRaces", aRace)
EndFunction

; CompatibleRaces ========================================================

Int Function AddCompatibleRace(SOS_AddonQuest_Script addon, Form aRace) Global
	Return Add(addon, "SOS_CompatibleRaces", aRace)
EndFunction
Int Function ClearCompatibleRaces(Form addon) Global
	Return SOS_SKSE.FormListClear(addon, "SOS_CompatibleRaces")
EndFunction
Int Function CountCompatibleRaces(Form addon) Global
	Return SOS_SKSE.FormListCount(addon, "SOS_CompatibleRaces")
EndFunction
Int Function FindCompatibleRace(Form addon, Race aRace) Global
	Return SOS_SKSE.FormListFind(addon, "SOS_CompatibleRaces", aRace)
EndFunction
Race Function GetCompatibleRace(Form addon, Int i) Global
	Return SOS_SKSE.FormListGet(addon, "SOS_CompatibleRaces", i) as Race
EndFunction

; EnabledRaces ========================================================

Int Function AddEnabledRace(Form addon, Form aRace) Global
	Return Add(addon, "SOS_EnabledRaces", aRace)
EndFunction
Int Function ClearEnabledRaces(Form addon) Global
	Return SOS_SKSE.FormListClear(addon, "SOS_EnabledRaces")
EndFunction
Int Function FindEnabledRace(Form addon, Race aRace) Global
	Return SOS_SKSE.FormListFind(addon, "SOS_EnabledRaces", aRace)
EndFunction
Race Function GetEnabledRace(Form addon, Int i) Global
	Return SOS_SKSE.FormListGet(addon, "SOS_EnabledRaces", i) as Race
EndFunction
Int Function RemoveEnabledRace(Form addon, Race aRace) Global
	Return Remove(addon, "SOS_EnabledRaces", aRace)
EndFunction

; RaceSizes ========================================================

Int Function AddRaceSize(Form addon, Int raceSize) Global
	Return SOS_SKSE.IntListAdd(addon, "SOS_RaceSizes", raceSize)
EndFunction
Int Function ClearRaceSizes(Form addon) Global
	Return SOS_SKSE.IntListClear(addon, "SOS_RaceSizes")
EndFunction
Int Function CountRaceSizes(Form addon) Global
	Return SOS_SKSE.IntListCount(addon, "SOS_RaceSizes")
EndFunction
Int Function GetRaceSize(Form addon, int i) Global
	Return SOS_SKSE.IntListGet(addon, "SOS_RaceSizes", i)
EndFunction
Int Function SetRaceSize(Form addon, Int i, Int raceSize) Global
	Return SOS_SKSE.IntListSet(addon, "SOS_RaceSizes", i, raceSize)
EndFunction

; RaceProbabilities ========================================================

Int Function AddRaceProbability(Form addon, Float raceProbability) Global
	Return SOS_SKSE.FloatListAdd(addon, "SOS_RaceProbabilities", raceProbability)
EndFunction
Int Function ClearRaceProbabilities(Form addon) Global
	Return SOS_SKSE.FloatListClear(addon, "SOS_RaceProbabilities")
EndFunction
Int Function CountRaceProbabilities(Form addon) Global
	Return SOS_SKSE.FloatListCount(addon, "SOS_RaceProbabilities")
EndFunction
Float Function GetRaceProbability(Form addon, int i) Global
	Return SOS_SKSE.FloatListGet(addon, "SOS_RaceProbabilities", i)
EndFunction
Float Function SetRaceProbability(Form addon, Int i, Float raceProbability) Global
	Return SOS_SKSE.FloatListSet(addon, "SOS_RaceProbabilities", i, raceProbability)
EndFunction

; Factions ========================================================

Int Function AddFaction(Form addon, Form aFaction) Global
	Return Add(addon, "SOS_Factions", aFaction)
EndFunction
Int Function ClearFaction(Form addon) Global
	Return SOS_SKSE.FormListClear(addon, "SOS_Factions")
EndFunction
Faction Function GetFaction(Form addon) Global
	Return SOS_SKSE.FormListGet(addon, "SOS_Factions", 0) as Faction
EndFunction

; Genders ========================================================

Int Function SetGender(Form addon, Int gender) Global
	Return SOS_SKSE.SetIntValue(addon, "SOS_Genders", gender)
EndFunction
Int Function ClearGender(Form addon) Global
	Return SOS_SKSE.UnsetIntValue(addon, "SOS_Genders") as Int
EndFunction
Int Function GetGender(Form addon) Global
	Return SOS_SKSE.GetIntValue(addon, "SOS_Genders")
EndFunction

; Schlonged ========================================================

Int Function AddSchlonged(Form addon, Actor akActor) Global
	Return Add(addon, "SOS_Schlonged", akActor)
EndFunction
Int Function ClearSchlongeds(Form addon) Global
	Return SOS_SKSE.FormListClear(addon, "SOS_Schlonged")
EndFunction
Int Function CountSchlongeds(Form addon) Global
	Return SOS_SKSE.FormListCount(addon, "SOS_Schlonged")
EndFunction
Int Function FindSchlonged(Form addon, Actor akActor) Global
	Return SOS_SKSE.FormListFind(addon, "SOS_Schlonged", akActor)
EndFunction
Actor Function GetSchlonged(Form addon, Int i) Global
	Return SOS_SKSE.FormListGet(addon, "SOS_Schlonged", i) as Actor
EndFunction
Int Function RemoveSchlonged(Form addon, Actor akActor) Global
	Return Remove(addon, "SOS_Schlonged", akActor)
EndFunction

; GenitalArmors ========================================================

Int Function AddGenitalArmor(Form addon, Armor akArmor) Global
	Return Add(addon, "SOS_GenitalArmors", akArmor)
EndFunction
Int Function ClearGenitalArmor(Form addon) Global
	Return SOS_SKSE.FormListClear(addon, "SOS_GenitalArmors")
EndFunction
Armor Function GetGenitalArmor(Form addon) Global
	Return SOS_SKSE.FormListGet(addon, "SOS_GenitalArmors", 0) as Armor
EndFunction

; Bones ========================================================

Int Function AddBone(Form addon, Float bone) Global
	Return SOS_SKSE.FloatListAdd(addon, "SOS_Bones", bone, true)
EndFunction
Int Function ClearBones(Form addon) Global
	Return SOS_SKSE.FloatListClear(addon, "SOS_Bones")
EndFunction
Int Function CountBones(Form addon) Global
	Return SOS_SKSE.FloatListCount(addon, "SOS_Bones")
EndFunction
Float Function GetBone(Form addon, Int i) Global
	Return SOS_SKSE.FloatListGet(addon, "SOS_Bones", i)
EndFunction

; Blacklist ========================================================

Int Function AddBlacklisted(Actor akActor) Global
	Return Add(None, "SOS_Blacklist", akActor)
EndFunction
Int Function ClearBlacklist() Global
	Return SOS_SKSE.FormListClear(None, "SOS_Blacklist")
EndFunction
Int Function FindBlacklisted(Actor akActor) Global
	Return SOS_SKSE.FormListFind(None, "SOS_Blacklist", akActor)
EndFunction
Int Function RemoveBlacklisted(Actor akActor) Global
	Return Remove(None, "SOS_Blacklist", akActor)
EndFunction
