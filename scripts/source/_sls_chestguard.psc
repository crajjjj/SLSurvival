Scriptname _SLS_ChestGuard extends ObjectReference  

Event OnReset()
	;Debug.Messagebox("Reset\n" + Self)
	IsHarvested = false
EndEvent

Event OnActivate(ObjectReference akActionRef)
	If akActionRef == PlayerRef
		If Self.GetBaseObject() as Container
			TriggerChestGuards()

		Else
			If !IsHarvested
			;	Debug.Messagebox("Is not harvested")
				TriggerChestGuards()
				IsHarvested = true
			;Else
			;	Debug.Messagebox("Is harvested")
			EndIf
		EndIf
	EndIf
EndEvent

Function TriggerChestGuards()
	_SLS_ChestGuardsGiant.Stop()
	_SLS_ChestGuardsGiant.Start()
EndFunction

Bool IsHarvested = false

Actor Property PlayerRef Auto

Quest Property _SLS_ChestGuardsGiant Auto
