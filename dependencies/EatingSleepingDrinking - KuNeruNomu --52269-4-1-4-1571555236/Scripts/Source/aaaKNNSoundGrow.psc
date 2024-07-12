Scriptname aaaKNNSoundGrow extends ActiveMagicEffect

Sound Property aaaKNNGrowl auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	;Debug.Notification("OnEffectStart")
	aaaKNNGrowl.Play(akTarget)
EndEvent