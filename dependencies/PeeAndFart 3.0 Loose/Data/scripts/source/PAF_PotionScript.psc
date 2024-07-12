Scriptname PAF_PotionScript extends activemagiceffect

PAF_MainQuestScript property PAF_MainQuest auto

Potion property PAF_PeePotionPotion auto
Potion property PAF_PoopPotionPotion auto
Potion property PAF_PeePotionCookedPotion auto
Potion property PAF_PoopPotionCookedPotion auto
Ingredient property PAF_DriedPee auto
Ingredient property SaltPile auto

Potion property PotionType auto

Event OnEffectStart(Actor akTarget, Actor akCaster)	
	if (PotionType == PAF_PeePotionPotion)
		akTarget.AddItem(SaltPile, 1)
		akTarget.AddItem(PAF_MainQuest.WineBottle01AEmpty, 1)
	elseif (PotionType == PAF_PeePotionCookedPotion)
		akTarget.AddItem(PAF_DriedPee, 1)
		akTarget.AddItem(PAF_MainQuest.WineBottle01AEmpty, 1)
	elseif (PotionType == PAF_PoopPotionCookedPotion)		
		akTarget.AddItem(PAF_MainQuest.WineBottle01AEmpty, 1)		
	endif
EndEvent

