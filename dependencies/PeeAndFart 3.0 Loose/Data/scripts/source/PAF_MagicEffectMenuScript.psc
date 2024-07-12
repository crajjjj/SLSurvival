Scriptname PAF_MagicEffectMenuScript extends activemagiceffect  


Event OnEffectStart(Actor akTarget, Actor akCaster)
	
	PAF_MainQuestScript.GetApi().OnKeyUp(PAF_MainQuestScript.GetApi().PAF_MCMQuest.PAF_MenuKey, 0.1)
	
EndEvent