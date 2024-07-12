Scriptname SLS_WarmBodies extends activemagiceffect  

Event OnEffectStart(Actor akTarget, Actor akCaster)
	RegisterForModEvent("HookAnimationEnd", "OnAnimationEnd")
	RegisterForSingleUpdate(3.0)
EndEvent

Event OnUpdate()
	Frostfall.ModExposure(Menu.WarmBodies)
	If Self
		RegisterForSingleUpdate(3.0)
	EndIf
EndEvent

Event OnAnimationEnd(int tid, bool HasPlayer)
	If HasPlayer
		UnregisterForUpdate()
		Self.Dispel()
	EndIf
EndEvent

SLS_Mcm Property Menu Auto
_SLS_InterfaceFrostfall Property Frostfall Auto
