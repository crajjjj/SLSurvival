Scriptname _STA_InterfaceKicker extends ReferenceAlias

Event OnPlayerLoadGame()
	SendIntEvent()
EndEvent

Function SendIntEvent()
	Int LoadEvent = ModEvent.Create("_STA_Int_PlayerLoadsGame")
	If (LoadEvent)
		ModEvent.Send(LoadEvent)
	EndIf
EndFunction
