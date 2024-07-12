Scriptname PAF_MagicEffectScript extends activemagiceffect  


Event OnEffectStart(Actor akTarget, Actor akCaster)
	
	PAF_MainQuestScript.GetApi().VictimActor = akTarget
	
EndEvent