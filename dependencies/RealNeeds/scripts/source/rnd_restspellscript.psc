Scriptname RND_RestSpellScript extends activemagiceffect

Actor Property PlayerREF Auto
GlobalVariable Property RND_SleepPoIntsPerHour Auto

Idle Property DefaultSheathe auto
Int DefaultSleepPoints

Event OnEffectStart(Actor akTarget, Actor akCaster)

	Int WaitKey = Input.GetMappedKey("Wait") as Int
	DefaultSleepPoints = RND_SleepPointsPerHour.GetValue() as Int
	game.ForceThirdPerson()
	If PlayerREF.IsInCombat() == false
		PlayerREF.playIdle(DefaultSheathe)
		RND_SleepPointsPerHour.SetValue(RND_SleepPointsPerHour.GetValue() / 2)
		Utility.Wait(2.0)
		If PlayerREF.GetSitState() == 3
			input.TapKey(WaitKey)
			Rest()
		Else
			debug.sendAnimationEvent(PlayerREF as objectreference, "IdleSitCrossleggedEnter")
			Utility.Wait(2.0)
			input.TapKey(WaitKey)
			Rest()
		EndIf
	EndIf

EndEvent

Function Rest()

	PlayerREF.RestoreActorValue("health", 1000)		
	debug.sendAnimationEvent(PlayerREF, "Idlechairexitstart")
	RND_SleepPointsPerHour.SetValue(DefaultSleepPoints)
	
EndFunction	