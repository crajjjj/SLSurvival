Scriptname SLSF_ShameEffect extends activemagiceffect  

SLSF_Utility Property SLSFUtility Auto

Actor Subject

Event OnEffectStart(Actor akTarget, Actor akCaster)
	Subject = akTarget
	RegisterForAnimationEvent(Subject, "IdleStop")
	SLSFUtility.ApplyShameEffect(Subject)
EndEvent

Event OnAnimationEvent(ObjectReference akSource, string asEventName)
 	If akSource == Subject
		If asEventName == "IdleStop"
			SLSFUtility.ApplyShameEffect(Subject)
		EndIf
	EndIf
EndEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)
	Utility.Wait(0.1)
	SLSFUtility.ApplyShameEffect(Subject)
EndEvent