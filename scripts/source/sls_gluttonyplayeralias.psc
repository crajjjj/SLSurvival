Scriptname SLS_GluttonyPlayerAlias extends ReferenceAlias  

SLS_GluttonyInflationScript Property Gluttony Auto

Keyword Property VendorItemFood Auto

Bool EatCooldown = false

Event OnObjectEquipped(Form akBaseObject, ObjectReference akReference)
	If akBaseObject as Potion
		If akBaseObject.HasKeyword(VendorItemFood)
			EatCooldown = true
			UpdateScale()
		EndIf
	EndIf
EndEvent

Function UpdateScale()
	GoToState("InProgress")
	While EatCooldown
		EatCooldown = false
		Utility.Wait(3.0)
	EndWhile
	Gluttony.BellyScaleUpdate()
	GoToState("")
EndFunction

State InProgress
	Event OnObjectEquipped(Form akBaseObject, ObjectReference akReference)
		EatCooldown = true
	EndEvent
EndState
