Scriptname _SNSaltPreservation extends activemagiceffect  

;====================================================================================

_SNQuestScript Property _SNQuest Auto

Bool Property Drunk Auto
Bool Property InWater Auto

Actor targ

;====================================================================================

Event OnEffectStart(Actor akTarget, Actor akCaster)
	targ = akTarget
	If Drunk
		GoToState("Drunk")
	ElseIf InWater
		GoToState("Refill")	
	Else
		GoToState("Alive")
	EndIf
EndEvent

;====================================================================================

State Drunk

	Event OnBeginState()
		RegisterForSingleUpdate(Utility.RandomInt(1, 60))
	EndEvent

	Event OnUpdate()
		targ.PushActorAway(targ, 0)
		targ.ApplyHavokImpulse(targ.GetAngleX(), targ.GetAngleY(), -0.3, 125)
		RegisterForSingleUpdate(Utility.RandomInt(1, 60))
	EndEvent

EndState

;====================================================================================

State Refill

	Event OnBeginState()
		_SNQuest.IsInWater = True
		If _SNQuest.AutoRefill
			Location CurrentLoc = targ.GetCurrentLocation()
			If CurrentLoc
				If _SNQuest.IsSafeLocation(CurrentLoc) && _SNQuest.Refill(targ)
					_SNQuest._SNWaterskinWaterBodyRefillLP.Play(targ)
				EndIf
			ElseIf _SNQuest.Refill(targ)
				_SNQuest._SNWaterskinWaterBodyRefillLP.Play(targ)
			EndIf
		EndIf
	EndEvent
	
	Event OnEffectFinish(Actor akTarget, Actor akCaster)
		Utility.Wait(0.5)
		_SNQuest.IsInWater = False
	EndEvent

EndState

;====================================================================================

Function WCCheck()
	If _SNQuest.InTheCold
		If _SNQuest.InTheCold.GetValue() as Int == 1 && _SNQuest.InTheColdTimed.GetValue() as Int == 0
			RegisterForSingleUpdateGameTime(3.0)
		Else
			RegisterForSingleUpdateGameTime(1.0)
		EndIf
	Else
		RegisterForSingleUpdateGameTime(2.0)
	EndIf
EndFunction

State Alive

	Event OnBeginState()
		WCCheck()
	EndEvent

	Event OnUpdateGameTime()
		Utility.Wait(2.0)
		targ.RemoveItem(_SNQuest._SNSnowPile, Utility.RandomInt(1, targ.GetItemCount(_SNQuest._SNSnowPile) as Int), true)
		If targ == _SNQuest.PlayerRef
			Debug.Notification(_SNQuest.SnowDecayText)
		ElseIf _SNQuest.SKSEVersion > 0.0
			Debug.Notification(targ.GetBaseObject().GetName() + _SNQuest.FollowerSnowDecayText_1)
		EndIf
		WCCheck()
	EndEvent

	Event OnEffectFinish(Actor akTarget, Actor akCaster)
		GoToState("Dead")
	EndEvent

EndState

State Dead
EndState