Scriptname SLS_MilkLeakWet extends activemagiceffect  

Event OnEffectStart(Actor akTarget, Actor akCaster)
	RegisterForSingleUpdate(3.0)
EndEvent

Event OnUpdate()
	Frostfall.ModWetness(50.0)
	If PlayerRef.HasMagicEffect(Init.MME_LeakingMilk)
		RegisterForSingleUpdate(3.0)
	Else
		Self.Dispel()
	EndIf
EndEvent

Actor Property PlayerRef Auto
SLS_Init Property Init Auto
_SLS_InterfaceFrostfall Property Frostfall Auto
