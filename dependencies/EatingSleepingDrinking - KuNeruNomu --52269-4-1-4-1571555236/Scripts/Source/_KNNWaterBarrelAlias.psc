scriptName _KNNWaterBarrelAlias extends ReferenceAlias

Message Property WBMsg auto
GlobalVariable Property _KNNWaterBarrelCapacity auto
GlobalVariable Property _KNNWaterBarrelResetDayPassed auto
float waterAmount = 0.0
float blockingTime = 0.0

Function ResetWaterAmount()
	waterAmount = _KNNWaterBarrelCapacity.GetValue()
	blockingTime = 0.0
EndFunction

Event OnActivate(ObjectReference akActionRef)
	if Game.GetPlayer() != akActionRef
		return
	elseIf KNNPlugin_Utility.IsTeammateFavor()
		return
	endIf
	int index = 1
	if Game.GetPlayer().IsWeaponDrawn()
		index = WBMsg.Show()
	endIf
	if 1 == index
		float thirst = 2880.0 - KNNPlugin_Utility.GetBasicNeeds("Thirsty")
		if 0.0 < thirst
			if waterAmount < thirst
				thirst = waterAmount
			endIf
		else
			if 750.0 > waterAmount
				thirst = waterAmount
			else
				thirst = 750.0
			endIf
		endIf
		if 0.1 < thirst
			KNNPlugin_Utility.ModBasicNeeds("Thirsty", thirst)
			waterAmount = waterAmount - thirst
			if (GetOwningQuest() as _KNNWaterBarrelQuest).IsShowMessage()
				int iWater = waterAmount as Int
				Debug.Notification(GetReference().GetBaseObject().GetName() + " @" + iWater + "/" + _KNNWaterBarrelCapacity.GetValueInt())
			endIf
			if 0.1 > waterAmount
				GoToState("BUSY")
			;else
			;	GoToState("READY")
			;	blockingTime = Utility.GetCurrentGameTime()
			endIf
			(GetOwningQuest() as _KNNWaterBarrelQuest).PlayerDrinkingAnimation()
		endIf
	elseIf 2 == index
		GoToState("BUSY")
	elseIf 3 == index
		ResetWaterAmount()
		(GetOwningQuest() as _KNNWaterBarrelQuest).RemoveWaterBarrel(self)
		;ObjectReference ref = GetReference()			
		;if ref
		;	ResetWaterAmount()
		;	ref.Disable()
		;	ref.Delete()
		;	clear()
		;endIf
	endIf
EndEvent

;never fire
;Event OnReset()
;	ResetWaterAmount()
;EndEvent

;State READY
;	Event OnCellAttach()
;		if _KNNWaterBarrelResetDayPassed.GetValue() / 0.5 < Utility.GetCurrentGameTime() - blockingTime
;			GoToState("")
;			waterAmount = _KNNWaterBarrelCapacity.GetValue()
;		endIf
;	EndEvent
;EndState

State BUSY
	Event OnBeginState()
		ObjectReference ref = GetReference()
		if ref
			ref.SetDestroyed(true)
			waterAmount = 0.0
			blockingTime = Utility.GetCurrentGameTime()
		endIf		
	EndEvent

	Event OnCellAttach()
		if _KNNWaterBarrelResetDayPassed.GetValue() < Utility.GetCurrentGameTime() - blockingTime
			ObjectReference ref = GetReference()
			if ref
				GoToState("")
				;Debug.Notification("Restore Water Barrel")
				ref.SetDestroyed(false)
				waterAmount = _KNNWaterBarrelCapacity.GetValue()
			endIf
		endIf
	EndEvent
EndState