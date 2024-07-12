Scriptname SLSF_NpcInitialization extends activemagiceffect  

SLSF_Configuration Property Config Auto
SLSF_Utility Property SLSFUtility Auto

Actor Subject

Event OnEffectStart(Actor akTarget, Actor akCaster)
	Subject = akTarget
	If !akTarget.IsChild()
		SLSFUtility.InitializeSubject(Subject)
		SLSFUtility.ApplyShameEffect(Subject)
		SLSFUtility.UpdateFameCommentStats(Subject)
	Endif
EndEvent
