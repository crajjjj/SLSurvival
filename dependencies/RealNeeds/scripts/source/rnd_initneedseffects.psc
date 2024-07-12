Scriptname RND_InitNeedsEffects extends activemagiceffect  

Spell Property Rested Auto
Spell Property WellRested Auto
Spell Property MarriageRested Auto

Spell Property RND_CheckNeedsSpell Auto
Spell Property RND_DrinkFromWaterSource Auto
Spell Property RND_CustomFoodSpell Auto
Spell Property RND_RestSpell Auto
Spell Property RND_WidgetSpell Auto

Spell Property RND_HungerSpell02 Auto
Spell Property RND_ThirstSpell01 Auto
Spell Property RND_InebriationSpell00 Auto
Spell Property RND_SleepSpell00 Auto

Spell Property RND_WeightSpell00 Auto
Spell Property RND_WeightSpell01 Auto
Spell Property RND_WeightSpell02 Auto
Spell Property RND_WeightSpell03 Auto
Spell Property RND_WeightSpell04 Auto

GlobalVariable Property RND_HidePowers Auto

GlobalVariable Property RND_HungerPoints Auto
GlobalVariable Property RND_ThirstPoints Auto
GlobalVariable Property RND_InebriationPoints Auto
GlobalVariable Property RND_SleepPoints Auto

GlobalVariable Property RND_HungerLevel02 Auto
GlobalVariable Property RND_ThirstLevel01 Auto
GlobalVariable Property RND_InebriationLevel00 Auto
GlobalVariable Property RND_SleepLevel00 Auto
GlobalVariable Property RND_DisableWeightGlobal Auto

event OnEffectStart(Actor akTarget, Actor akCaster)

		Actor Player = Game.GetPlayer()
		Float PlayerWeight = Player.GetActorBase().GetWeight() as Float
		RND_HungerPoints.SetValue(RND_HungerLevel02.GetValue())
		RND_ThirstPoints.SetValue(RND_ThirstLevel01.GetValue())
		RND_SleepPoints.SetValue(RND_SleepLevel00.GetValue())
		RND_InebriationPoints.SetValue(RND_InebriationLevel00.GetValue())
		
		Player.removeSpell(Rested)
		Player.removeSpell(WellRested)
		Player.removeSpell(MarriageRested)
		; add check needs spell
		if RND_HidePowers.GetValue() == 0
			Player.addSpell(RND_CheckNeedsSpell)
			Player.addSpell(RND_DrinkFromWaterSource)
			Player.addSpell(RND_CustomFoodSpell)
			Player.addSpell(RND_RestSpell)
			Player.addSpell(RND_WidgetSpell)
		endif
		; sleep affects all, include vampires
		Player.addSpell(RND_SleepSpell00, false)
		if RND_DisableWeightGlobal.GetValue() == 1
			if PlayerWeight <= 100.0 && PlayerWeight > 80.0
				Player.addSpell(RND_WeightSpell00, false)
			elseif PlayerWeight <= 80.0 && PlayerWeight > 60.0
				Player.addSpell(RND_WeightSpell01, false)
			elseif PlayerWeight <= 60.0 && PlayerWeight > 40.0
				Player.addSpell(RND_WeightSpell02, false)
			elseif PlayerWeight <= 40.0 && PlayerWeight > 20.0
				Player.addSpell(RND_WeightSpell03, false)
			elseif PlayerWeight <= 20.0 && PlayerWeight > 0.0
				Player.addSpell(RND_WeightSpell04, false)		
			endif
		endIf	
		if !isVampire()
			Player.addSpell(RND_HungerSpell02, false)
			Player.addSpell(RND_ThirstSpell01, false)
			Player.addSpell(RND_InebriationSpell00, false)
		endif

endEvent

Spell Property VampireVampirism Auto
Spell Property VampirePoisonResist Auto
GlobalVariable Property RND_MortalVamp Auto
PlayerVampireQuestScript Property PlayerVampireQuest Auto

bool Function isVampire()

	if RND_MortalVamp.GetValue() == 1
		Return False
	endif
	
	if PlayerVampireQuest.VampireStatus != 0	
		Return True
	elseif Game.GetPlayer().HasSpell(VampireVampirism) || Game.GetPlayer().HasSpell(VampirePoisonResist)
		Return True
	else	
		Return False
	endif
	
EndFunction

