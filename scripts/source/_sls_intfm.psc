Scriptname _SLS_IntFm  Hidden 

Bool Function GetIsPregnant(Quest FmQuest, Actor akActor) Global
	Int Index = (FmQuest as _JSW_BB_Storage).TrackedActors.Find(akActor)
	If Index >= 0
		If (FmQuest as _JSW_BB_Storage).LastConception[Index] > 0.0
			Return true
		EndIf
	EndIf
	Return false
EndFunction

Bool Function GetGaveBirth(Quest FmQuest, Actor akActor) Global
	Int Index = (FmQuest as _JSW_BB_Storage).TrackedActors.Find(akActor)
	If Index >= 0
		If (FmQuest as _JSW_BB_Storage).LastBirth[Index] > 0.0
			Return true
		EndIf
	EndIf
	Return false
EndFunction

Race Function GetPregnancyRace(Quest FmQuest, Actor PregnantActor) Global
	If GetIsPregnant(FmQuest, PregnantActor)
		Int Index = (FmQuest as _JSW_BB_Storage).TrackedActors.Find(PregnantActor)
		If Index >= 0
			Int RaceId = (FmQuest as _JSW_BB_Storage).FatherRaceId[Index]
			If RaceId > -1
				Return Game.GetForm(RaceId) as Race
			EndIf
		EndIf
	EndIf
	Return None
EndFunction
