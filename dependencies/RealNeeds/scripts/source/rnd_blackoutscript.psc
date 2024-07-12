Scriptname RND_BlackoutScript extends activemagiceffect  
{blackout and wake up 4 hours later}

Event OnEffectStart(Actor akTarget, Actor akCaster)

	if RND_DrunkBlackout.getValue() == 1
		Return
	else
		RND_DrunkBlackout.SetValue(1)
	endif

	Actor Player = Game.GetPlayer()
	
	; stop pc meddling
	Game.DisablePlayerControls()
		
	if RND_AnimInebriation.GetValue() == 1
		if !Player.GetAnimationVariableInt("i1stPerson") == 1
			Player.PlayIdle(IdleDrunkStart)
			Utility.Wait(10)
			Player.PlayIdle(IdleDrunkStop)
		endif
	endif

	Player.PushActorAway(Player, 0)
	Player.ApplyHavokImpulse(Player.GetAngleX(), Player.GetAngleY(), -0.5, 100)

	; fade out
	RND_FadeOut.Apply()
	Utility.Wait(1)
	RND_FadeOut.PopTo(RND_Black)
	
	if RND_SleepPoints.GetValue() > RND_SleepLevel03.GetValue()
		RND_SleepPoints.SetValue(RND_SleepLevel03.GetValue())
	endif

	; move time forward
	GameHour.SetValue(GameHour.GetValue() + Utility.RandomInt(3,5))		
	Game.EnablePlayerControls()
	
	; fade in
	Utility.Wait(10)
	RND_Black.PopTo(RND_FadeIn)
	
	RND_DrunkBlackout.SetValue(0)

	if RND_InebriationPoints.GetValue() > RND_InebriationLevel03.GetValue()
		if RND_AnimInebriation.GetValue() == 1 && Player.GetAnimationVariableInt("i1stPerson") != 1
			if Player.PlayIdle(IdleDrunkStart)
				bool loop = True
				int count = 0
				while loop == True
					if RND_InebriationPoints.GetValue() < RND_InebriationLevel02.GetValue()
						if Player.PlayIdle(IdleDrunkStop)
							loop = False
						endif
						count += 1
						if count >= 10
							loop = False
						endif
					endif
					Utility.Wait(5)
				endWhile
			endif
		endif
	endif

EndEvent

Idle Property IdleDrunkStart Auto
Idle Property IdleDrunkStop Auto

ImageSpaceModifier Property RND_FadeOut Auto
ImageSpaceModifier Property RND_FadeIn Auto
ImageSpaceModifier Property RND_Black Auto

GlobalVariable Property GameHour Auto
GlobalVariable Property RND_DrunkBlackout Auto

GlobalVariable Property RND_AnimInebriation Auto
GlobalVariable Property RND_InebriationPoints Auto
GlobalVariable Property RND_InebriationLevel02 Auto
GlobalVariable Property RND_InebriationLevel03 Auto

GlobalVariable Property RND_SleepPoints Auto
GlobalVariable Property RND_SleepLevel03 Auto
