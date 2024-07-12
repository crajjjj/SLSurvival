Scriptname _STA_SkinBalmBegin extends activemagiceffect  

_STA_SpankUtil Property SpankUtil Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	SpankUtil.BeginBalm()
EndEvent
