Scriptname _SLS_CumFillSound extends activemagiceffect  

Event OnEffectStart(Actor akTarget, Actor akCaster)
	DoCumFillSound(akTarget, LoadSize = Self.GetMagnitude())
	Self.Dispel()
EndEvent

Function DoCumFillSound(Actor akTarget, Float LoadSize)
	Float FillAmount = 1.0
	While LoadSize > 0.0
		_SLS_CumFillSM.Play(akTarget)
		LoadSize -= FillAmount
		FillAmount = FillAmount * 3.0 ; Increase the amount filled each iteration so it doesn't go on too long. This should give Big: 2 swallows, massive: 3 etc
		If LoadSize > 0.0
			Utility.Wait(2.0 + Utility.RandomFloat(-0.2, 0.2))
		EndIf
	EndWhile
EndFunction

Sound Property _SLS_CumFillSM Auto
