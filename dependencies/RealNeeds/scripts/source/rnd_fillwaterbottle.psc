Scriptname RND_FillWaterBottle extends activemagiceffect  

Idle Property IdlePickup_Ground Auto
GlobalVariable Property RND_AnimRefill  Auto

RND_PlayerScript Property RND_Player Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)

	Actor Player = Game.GetPlayer()

	if RND_Player.isInSeawater()
		Player.addItem(RND_Seawater, 1)	
	else
		Player.addItem(RND_BottledWater, 1)
	endif

	if RND_AnimRefill.GetValue() == 1
		if !Player.IsWeaponDrawn() && !Player.GetAnimationVariableInt("i1stPerson") == 1
			Player.PlayIdle(IdlePickup_Ground)
		endif
	endif
	
EndEvent

Potion Property RND_Seawater Auto

Potion Property RND_BottledWater Auto

