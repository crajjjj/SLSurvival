Scriptname SLS_SwimCleanCum extends activemagiceffect  

Int Timer

Event OnEffectStart(Actor akTarget, Actor akCaster)
	Timer = Math.Floor(Menu.SwimCumClean / 2)
	RegisterForModEvent("Frostfall_OnPlayerStopSwimming", "Frostfall_OnPlayerStopSwimming")
	RegisterForSingleUpdate(2.0)
EndEvent

Event Frostfall_OnPlayerStopSwimming()
	Self.Dispel()
EndEvent

Event OnUpdate()
	RegisterForSingleUpdate(2.0)
	If PlayerRef.IsSwimming()
		If PlayerRef.GetWornForm(0x00000004) == None
			Timer -= 1
		EndIf
	EndIf
	
	If Timer <=0
		SexLab.ClearCum(PlayerRef)
		Debug.Notification("The water cleans your body")
		Debug.Trace("SLS_: Swim naked - Cum cleared")
		Self.Dispel()
	EndIf
EndEvent

Actor Property PlayerRef Auto
SexLabFramework Property SexLab Auto
SLS_Mcm Property Menu Auto