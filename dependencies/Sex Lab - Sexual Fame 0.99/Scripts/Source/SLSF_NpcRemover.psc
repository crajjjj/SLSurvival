Scriptname SLSF_NpcRemover extends activemagiceffect  

SLSF_Configuration Property Config Auto
SLSF_Utility Property SLSFUtility Auto

Actor Subject

Event OnEffectStart(Actor akTarget, Actor akCaster)
	Subject = akTarget
	If akTarget.IsChild()
		If Config.ChildRemover
			SLSFUtility.RemoveChild(akTarget)
			SLSFUtility.ShowTutorialInfo(2)
		EndIf
	EndIf
EndEvent
