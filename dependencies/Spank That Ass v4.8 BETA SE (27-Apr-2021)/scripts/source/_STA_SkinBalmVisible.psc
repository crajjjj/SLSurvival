Scriptname _STA_SkinBalmVisible extends activemagiceffect  

Event OnEffectStart(Actor akTarget, Actor akCaster)
	If Self.GetMagnitude() <= 0.0
		Self.Dispel()
	EndIf
EndEvent