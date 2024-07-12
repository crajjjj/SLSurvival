Scriptname _SLS_HighlightItemsBoost extends activemagiceffect  

Event OnEffectStart(Actor akTarget, Actor akCaster)
	_SLS_HighlightVisionCount.SetValue(100.0)
	_SLS_HighlightVisionRange.SetValue(2048.0)
EndEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)
	_SLS_HighlightVisionCount.SetValue(5.0)
	_SLS_HighlightVisionRange.SetValue(512.0)
EndEvent

GlobalVariable Property _SLS_HighlightVisionCount Auto
GlobalVariable Property _SLS_HighlightVisionRange Auto
