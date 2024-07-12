Scriptname PAF_MagicEffectPoopScript extends activemagiceffect  


Event OnEffectStart(Actor akTarget, Actor akCaster)
	
	PAF_MainQuestScript.GetApi().OnKeyUp(PAF_MainQuestScript.GetApi().PAF_MCMQuest.PAF_ActionKey, 2.0)
	
EndEvent