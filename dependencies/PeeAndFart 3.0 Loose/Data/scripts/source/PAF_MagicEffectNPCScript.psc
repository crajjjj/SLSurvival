Scriptname PAF_MagicEffectNPCScript extends activemagiceffect  

Event OnEffectStart(Actor akTarget, Actor akCaster)	
	PAF_MainQuestScript.GetApi().PAF_NPCQuest.AddActor(akTarget)
EndEvent