Scriptname _SLS_DebugGetActorVoiceType extends activemagiceffect  

Event OnEffectStart(Actor akTarget, Actor akCaster)
	If akTarget
		Debug.Messagebox("Target: " + akTarget.GetActorBase().GetName() + "\nVoice : " + akTarget.GetVoiceType())
	EndIf
EndEvent
