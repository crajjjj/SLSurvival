Scriptname _SNManualRefill extends ObjectReference  

;====================================================================================

_SNQuestScript Property _SNQuest Auto

Bool Property Salt Auto

;====================================================================================

Function SaltWater(Actor target)
	Int SaltOption = _SNQuest._SNWaterSaltMsg.Show()
	If SaltOption == 0
		_SNQuest._SNWaterskinEmptyLP.Play(target)
		target.RemoveItem(_SNQuest._SNWaterSkin_Salt, 1, true)
		target.AddItem(_SNQuest._SNWaterskin_0, 1)
	EndIf
EndFunction

Event OnEquipped(Actor akActor)
	Actor targ = _SNQuest.PlayerRef
	;Debug.Notification(targ.GetPositionX() as Int+", "+targ.GetPositionY() as Int)
	If akActor == targ
		If !Salt
			If _SNQuest.IsInWater
				If !_SNQuest.IsInSaltWater()
					Location CurrentLoc = targ.GetCurrentLocation()
					If CurrentLoc
						If _SNQuest.IsSafeLocation(CurrentLoc)
							_SNQuest.RefillNDrink()
						Else
							_SNQuest.RefillUnknown(targ)
						EndIf
					Else
						If !_SNQuest.IsInWarmWater
							_SNQuest.RefillNDrink()
						Else
							_SNQuest.RefillUnknown(targ)
						EndIf
					EndIf
				Else
					If !_SNQuest.PlayRefillAnim()
						_SNQuest._SNWaterskinWaterBodyRefillLP.Play(targ)
					EndIf
					targ.RemoveItem(_SNQuest._SNWaterSkin_0, 1, true)
					targ.AddItem(_SNQuest._SNWaterskin_Salt, 1)
				EndIf
			Else
				Debug.Notification(_SNQuest.NoWaterSourceText)
			EndIf
		Else
			SaltWater(targ)
		EndIf
	EndIf
	Utility.Wait(0.5)
EndEvent