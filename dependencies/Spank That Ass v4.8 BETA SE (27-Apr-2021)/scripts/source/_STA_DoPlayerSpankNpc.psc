Scriptname _STA_DoPlayerSpankNpc extends activemagiceffect  

_STA_SpankUtil Property SpankUtil Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	SpankUtil.PlayerSpanksNpc(akTarget)
EndEvent