Scriptname _STA_SpankedNpcEffectExpire extends activemagiceffect  

MagicEffect Property _STA_SpankedNpcMgef Auto

_STA_SpankUtil Property SpankUtil Auto

Event OnEffectFinish(Actor akTarget, Actor akCaster)
	Utility.Wait(0.5)
	If !akTarget.HasMagicEffect(_STA_SpankedNpcMgef)	
		SpankUtil.PlayerSpankedNpcEnd(akTarget)
	EndIf
EndEvent