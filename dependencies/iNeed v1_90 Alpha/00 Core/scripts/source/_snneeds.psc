Scriptname _SNNeeds extends activemagiceffect  

;====================================================================================

Armor Property _SNWaterskinEquipLeft Auto
Armor Property _SNWaterskinEquipRight Auto
Armor Property _SNWaterskinEquipBack Auto
Armor Waterskin

Float HungerChange
Float FatigueChange
Float ThirstChange
Float HungerRandom
Float FatigueRandom
Float ThirstRandom
Float TimeStart

Int TimePassed
Int AdrenalineCount
Int DrunkAlcoholCount

Quest Property _SNDialogueQuest Auto

_SNQuestScript Property _SNQuest Auto

Bool Property ScanFood Auto
Bool Property WaterskinEquip Auto

Actor targ

Import Utility
Import Math

;====================================================================================

Int Function Round(Float i)
	If (i - (i as Int)) < 0.5
		Return (i as Int)
	Else
		Return (Math.Ceiling(i) as Int)
	EndIf
EndFunction

Function CalcRecentFood()
EndFunction

Float Function StomachRotCheck()
	Float SatiationMult = 1.0
	Int HasSalmonella = _SNQuest.HasSalmonella
	If HasSalmonella == 1
		SatiationMult = 0.9
	ElseIf HasSalmonella == 2
		SatiationMult = 0.8
	ElseIf HasSalmonella == 3
		SatiationMult = 0.6
	ElseIf HasSalmonella == 4
		SatiationMult = 0.2
	EndIf
	Return SatiationMult
EndFunction

Float Function NeedsCheck(GlobalVariable NeedsPenaltyVar)
	Float NeedsMult = 1.0
	Int NeedsPenalty = NeedsPenaltyVar.GetValue() as Int
	If NeedsPenalty == -2
		NeedsMult = 1.08
	ElseIf NeedsPenalty == 1
		NeedsMult = 0.95
	ElseIf NeedsPenalty == 2
		NeedsMult = 0.90
	ElseIf NeedsPenalty == 3
		NeedsMult = 0.80
	EndIf
	Return NeedsMult
EndFunction

Function NormalNeeds()
	If targ.HasSpell(_SNQuest._SNAdrenalineSpell)
		HungerChange = -_SNQuest.HungerRate * TimePassed / 2.0
		ThirstChange = -_SNQuest.ThirstRate * TimePassed / 2.0
		FatigueChange = -_SNQuest.FatigueRate * TimePassed / 2.0
	Else
		If targ.HasSpell(_SNQuest._SNWearySpell)
			Float TimeInAdrenaline = _SNQuest.TimeInAdrenaline
			Int TimeInWeary = Round(TimeInAdrenaline / 2.0)
			Int TimeNoWeary
			If TimePassed > TimeInWeary
				TimeNoWeary = TimePassed - TimeInWeary
				TimePassed = (TimeInWeary * 2) + TimeNoWeary
				_SNQuest.TimeInAdrenaline = 0
			Else
				TimePassed = TimePassed * 2
				_SNQuest.TimeInAdrenaline = TimeInAdrenaline - TimePassed
			EndIf
		EndIf
		HungerChange = -_SNQuest.HungerRate * TimePassed
		ThirstChange = -_SNQuest.ThirstRate * TimePassed
		FatigueChange = -_SNQuest.FatigueRate * TimePassed
	EndIf
	;Debug.Notification("H: "+HungerChange+" T: "+ThirstChange+" F: "+FatigueChange)								;DEBUG
EndFunction

Event OnEffectStart(Actor akTarget, Actor akCaster)
	targ = akTarget
	If ScanFood
		GoToState("ScanFood")
	ElseIf WaterskinEquip
		GoToState("WaterskinEquip")
	Else
		_SNDialogueQuest.Start()
		GoToState("Alive")
	EndIf
EndEvent

;====================================================================================

State Alive

	Event OnBeginState()
		_SNQuest.TimeUpdate = GetCurrentGameTime()
		TimeStart = _SNQuest.TimeUpdate
		RegisterForSleep()
		RegisterForSingleUpdateGameTime(1.0)
	EndEvent

	Event OnUpdateGameTime()
		Utility.Wait(0.5)
		_SNQuest.TimeUpdate = GetCurrentGameTime()
		TimePassed = Round((_SNQuest.TimeUpdate - TimeStart) * 24.0)
		If TimePassed > 1
			_SNQuest.OnUpdate()
		EndIf
		
		Bool IsVampire = targ.HasKeyword(_SNQuest.Vampire)
		Int VampireType = _SNQuest._SNVampWereToggle.GetValue() as Int
		
		HungerRandom = Utility.RandomFloat(-1.0, 1.0) * TimePassed
		ThirstRandom = Utility.RandomFloat(-1.0, 1.0) * TimePassed
		FatigueRandom = Utility.RandomFloat(-0.5, 0.5) * TimePassed

		HungerChange = -6.5 * TimePassed
		ThirstChange = -6.5 * TimePassed
		If _SNQuest.JustSlept
			If IsVampire && VampireType != 0
				If VampireType == 1
					FatigueChange = 6.0 * TimePassed
				Else
					FatigueChange = -_SNQuest.FatigueRate * TimePassed
				EndIf
			Else
				FatigueChange = 12.5 * TimePassed * StomachRotCheck() * NeedsCheck(_SNQuest._SNHungerPenalty) * NeedsCheck(_SNQuest._SNThirstPenalty)
				If _SNQuest.IsBedRoll && !Game.FindClosestReferenceOfAnyTypeInListFromRef(_SNQuest._SNTentList, targ, 384.0)
					FatigueChange = FatigueChange * 0.85
				EndIf
				If _SNQuest.IsUnsafeLocation()
					FatigueChange = FatigueChange * 0.85
				EndIf
				;Debug.Notification("IsBedRoll: "+_SNQuest.IsBedRoll+" IsDungeon: "+_SNQuest.IsDungeonLocation(CurrentLoc))																						;DEBUG
			EndIf
		Else
			If TimePassed > 13
				HungerChange = -3.5 * TimePassed
				ThirstChange = -3.5 * TimePassed
			EndIf
			If _SNQuest.CarriageFastTravel
				If IsVampire && VampireType != 0
					If VampireType == 1
						FatigueChange = 1.5 * TimePassed
					Else
						FatigueChange = -_SNQuest.FatigueRate * TimePassed
					EndIf
				Else
					FatigueChange = 3.0 * TimePassed * StomachRotCheck() * NeedsCheck(_SNQuest._SNHungerPenalty) * NeedsCheck(_SNQuest._SNThirstPenalty)
					Debug.Notification(_SNQuest.RestText)
				EndIf
			ElseIf TimePassed > 1 && _SNQuest.IsSitting
				If IsVampire && VampireType != 0
					If VampireType == 1
						FatigueChange = 2.0 * TimePassed
					Else
						FatigueChange = -_SNQuest.FatigueRate * TimePassed
					EndIf
				Else
					FatigueChange = 4.5 * TimePassed * StomachRotCheck() * NeedsCheck(_SNQuest._SNHungerPenalty) * NeedsCheck(_SNQuest._SNThirstPenalty)			
				EndIf
			Else
				NormalNeeds()
			EndIf
		EndIf
		
		If targ.GetActorBase().GetSex() as Int == 0
			_SNQuest.IsMale = True
		Else
			_SNQuest.IsMale = False
		EndIf
		
		_SNQuest.TimePassed = TimePassed
		TimeStart = _SNQuest.TimeUpdate

		If IsVampire && VampireType == 1
			If !_SNQuest.CarriageFastTravel
				_SNQuest.ModFatigue((FatigueChange / 2.0) + FatigueRandom)
				_SNQuest.ModHunger(0.0)
			EndIf
		ElseIf _SNQuest.IsWerewolf
			_SNQuest.ModThirst(ThirstChange + ThirstRandom)
			_SNQuest.ModHunger(HungerChange + HungerRandom)
		Else
			_SNQuest.ModFatigue(FatigueChange + FatigueRandom)
			If _SNQuest.DrunkAlcohol > 0
				_SNQuest.ModThirst(ThirstChange + ThirstRandom - 17.5)
				If _SNQuest.DrunkAlcohol > 1
					_SNQuest.DrunkAlcohol = 0
				Else
					_SNQuest.DrunkAlcohol += 1
				EndIf
			Else
				_SNQuest.ModThirst(ThirstChange + ThirstRandom)
			EndIf
			_SNQuest.ModHunger(HungerChange + HungerRandom)
		EndIf
		RegisterForSingleUpdateGameTime(1.0)
		RegisterForSingleUpdate(2.5)
		RegisterForSleep()
	EndEvent

	Event OnSleepStart(float afSleepStartTime, float afDesiredSleepEndTime)
		OnSleepStop(false)
		TimeStart = GetCurrentGameTime()
	EndEvent

	Event OnSleepStop(bool abInterrupted)
		_SNQuest.JustSlept = True
		_SNQuest.OnUpdate()
	EndEvent

	Event OnUpdate()
		_SNQuest.JustSlept = False
	EndEvent

	Event OnEffectFinish(Actor akTarget, Actor akCaster)
		GoToState("Dead")
	EndEvent

EndState

;====================================================================================

State WaterskinEquip

	Event OnBeginState()
		RegisterForSingleUpdate(2.5)
	EndEvent
	
	Event OnUpdate()
		Int WaterskinPos = _SNQuest._SNWaterskinEquipToggle.GetValue() as Int
		If WaterskinPos == 1
			Waterskin = _SNWaterskinEquipRight
		ElseIf WaterskinPos == 2
			Waterskin = _SNWaterskinEquipLeft
		Else
			Waterskin = _SNWaterskinEquipBack
		EndIf
		If _SNQuest.SKSEVersion > 0.0
			If !targ.GetWornForm(0x00080000)	;slot 49
				targ.AddItem(Waterskin, 1, true)
				targ.EquipItem(Waterskin, false, true)
			Else
				GoToState("Dead")			
			EndIf
		Else
			targ.AddItem(Waterskin, 1, true)
			targ.EquipItem(Waterskin, false, true)
		EndIf	
	EndEvent

	Event OnEffectFinish(Actor akTarget, Actor akCaster)
		If targ
			If targ == _SNQuest.PlayerRef
				targ.RemoveItem(_SNWaterskinEquipBack, targ.GetItemCount(_SNWaterskinEquipBack) as Int, true)
				targ.RemoveItem(_SNWaterskinEquipRight, targ.GetItemCount(_SNWaterskinEquipRight) as Int, true)
				targ.RemoveItem(_SNWaterskinEquipLeft, targ.GetItemCount(_SNWaterskinEquipLeft) as Int, true)
			ElseIf Waterskin
				targ.RemoveItem(Waterskin)
			EndIf
		EndIf
		GoToState("Dead")
	EndEvent

EndState

;====================================================================================

State ScanFood

	Event OnBeginState()
		_SNQuest.ScanFood()
	EndEvent

	Event OnLocationChange(Location akOldLoc, Location akNewLoc)
		Utility.Wait(1.0)
		If targ.IsInInterior()
			_SNQuest.ScanFood()
		EndIf
	EndEvent

	Event OnEffectFinish(Actor akTarget, Actor akCaster)
		GoToState("Dead")
	EndEvent

EndState

State Dead
EndState