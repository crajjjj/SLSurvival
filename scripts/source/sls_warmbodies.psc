Scriptname SLS_WarmBodies extends activemagiceffect  

Event OnEffectStart(Actor akTarget, Actor akCaster)
	RegisterForModEvent("HookAnimationEnd", "OnAnimationEnd")
	RegisterForSingleUpdate(3.0)
EndEvent

Event OnUpdate()
	; Negative exposure = warmer, and the MCM already stores WarmBodies negative (its slider sets -value).
	; 0.800 negated it once more, so Warm Bodies chilled the player.
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
