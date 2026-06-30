Scriptname sr_expelcumscript extends ActiveMagicEffect  

sr_infDeflateAbility Property deflate auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	deflate.SpermOutStart()
	;Debug.notification("Spell Fired")
	;press E to stop
EndEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)
	deflate.SpermOutStop()
EndEvent
