Scriptname _SLS_NoParaFactRemove extends activemagiceffect  

Faction Property SexlabAnimatingFaction Auto
Faction Property _SLS_NoParalyzeFact Auto

Event OnEffectFinish(Actor akTarget, Actor akCaster)
	If !akTarget.IsInFaction(SexlabAnimatingFaction)
		akTarget.RemoveFromFaction(_SLS_NoParalyzeFact)
	EndIf
EndEvent
