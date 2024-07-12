Scriptname RND_FillWaterBottleB extends activemagiceffect  

Idle Property IdlePickup_Ground Auto
GlobalVariable Property RND_AnimRefill  Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)

	Actor Player = Game.GetPlayer()

	if Game.FindClosestReferenceOfAnyTypeInListFromRef(RND_WaterfallList, Player, 90.0)
		
		Player.AddItem(RND_BottledWater, 1)		
		if RND_AnimRefill.GetValue() == 1
			if !Player.IsWeaponDrawn() && !Player.GetAnimationVariableInt("i1stPerson") == 1
				Player.PlayIdle(IdlePickup_Ground)
			endif
		endif	
	else
		Player.AddItem(RND_EmptyBottle, 1)
	endif
	
EndEvent

Potion Property RND_EmptyBottle Auto
Potion Property RND_BottledWater Auto

FormList Property RND_WaterfallList Auto
