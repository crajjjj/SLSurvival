Scriptname _SNFoodSpoilage extends ReferenceAlias 

;====================================================================================

MiscObject Property _SNEmptyMiscItem Auto
MiscObject Property _SNSpoiledFood Auto

Keyword Property ActorTypeNPC Auto

_SNQuestScript Property _SNQuest Auto

String[] OriginalNameList
String Spoil_1
String Spoil_2
String Spoil_3
String Spoil_4
String Spoil_5
String Spoil_6

Float[] TimeStampList
Float RawDecayRate = 3.0
Float LightDecayRate = 1.0
Float MedHeavyDecayRate = 2.0

Int CleanUpCount
Int ActionCount

Bool InTheCold
Bool SearchDelay
Bool DisplayPercent
Bool RenamingBack
Bool RenameInInventory

Actor targ

;====================================================================================

Function CleanUp(Form[] FoodArray, String[] NameArray)
	Int i = 0
	While i < FoodArray.Length
		If FoodArray[i] != None && targ.GetItemCount(FoodArray[i]) == 0
			FoodArray[i] = None
			NameArray[i] = ""
		EndIf
		i += 1
	EndWhile
EndFunction

Int Function IsFood(Form Food)
	If _SNQuest._SNFood_RawList.HasForm(Food)
		Return 0
	ElseIf _SNQuest._SNFood_LightList.HasForm(Food)
		Return 1
	ElseIf _SNQuest._SNFood_MedList.HasForm(Food) || _SNQuest._SNFood_SoupList.HasForm(Food)
		Return 2
	ElseIf _SNQuest._SNFood_HeavyList.HasForm(Food)
		Return 3
	EndIf
	Return -1
EndFunction

Int Function FormIndex(Form[] MyArray, Form MyForm)
	Int i = 0
	While i < MyArray.Length
		If MyArray[i] == MyForm
			Return i
		Else
			i += 1
		EndIf
	EndWhile
	Return -1
EndFunction

Function RenameNew(Form[] FoodArray, String[] NameArray)
	Int i = 0
	While i < FoodArray.Length
		If FoodArray[i] != None
			;NameArray[i] = FoodArray[i].GetName()
			If DisplayPercent
				If _SNQuest.SatiationList[i] < 101.0
					FoodArray[i].SetName(NameArray[i] + " (" + Round(_SNQuest.SatiationList[i]) + "%)")
				Else
					FoodArray[i].SetName(NameArray[i] + " (" + Spoil_6 + ")")
				EndIf
			Else
				Float CurrentSatiation = _SNQuest.SatiationList[i]
				If CurrentSatiation == 101.0
					FoodArray[i].SetName(NameArray[i] + " (" + Spoil_6 + ")")
				ElseIf CurrentSatiation == 100.0
				ElseIf CurrentSatiation >= 80.0
					FoodArray[i].SetName(NameArray[i] + " (" + Spoil_1 + ")")
				ElseIf CurrentSatiation >= 60.0
					FoodArray[i].SetName(NameArray[i] + " (" + Spoil_2 + ")")
				ElseIf CurrentSatiation >= 40.0
					FoodArray[i].SetName(NameArray[i] + " (" + Spoil_3 + ")")
				ElseIf CurrentSatiation >= 20.0
					FoodArray[i].SetName(NameArray[i] + " (" + Spoil_4 + ")")
				Else
					FoodArray[i].SetName(NameArray[i] + " (" + Spoil_5 + ")")
				EndIf
			EndIf
		EndIf
		i += 1
	EndWhile
EndFunction

Function RenameOld(Form[] FoodArray, String[] NameArray)
	Int i = 0
	While i < FoodArray.Length
		If FoodArray[i] != None
			FoodArray[i].SetName(NameArray[i])
		EndIf
		i += 1
	EndWhile
EndFunction

Function FixFoodName(Form[] FoodArray, String[] NameArray)
	Int i = 0
	While i < FoodArray.Length
		If FoodArray[i] != None
			NameArray[i] = FoodArray[i].GetName()
		Else
			NameArray[i] = ""
		EndIf
		i += 1
	EndWhile
EndFunction

Function RenameNewSingle(Form FoodItem, String NameItem, Float SatiationItem)
	If DisplayPercent
		If SatiationItem < 101.0
			FoodItem.SetName(NameItem + " (" + Round(SatiationItem) + "%)")
		Else
			FoodItem.SetName(NameItem + " (" + Spoil_6 + ")")
		EndIf
	Else
		Float CurrentSatiation = SatiationItem
		If CurrentSatiation == 101.0
			FoodItem.SetName(NameItem + " (" + Spoil_6 + ")")
		ElseIf CurrentSatiation == 100.0
		ElseIf CurrentSatiation >= 80.0
			FoodItem.SetName(NameItem + " (" + Spoil_1 + ")")
		ElseIf CurrentSatiation >= 60.0
			FoodItem.SetName(NameItem + " (" + Spoil_2 + ")")
		ElseIf CurrentSatiation >= 40.0
			FoodItem.SetName(NameItem + " (" + Spoil_3 + ")")
		ElseIf CurrentSatiation >= 20.0
			FoodItem.SetName(NameItem + " (" + Spoil_4 + ")")
		Else
			FoodItem.SetName(NameItem + " (" + Spoil_5 + ")")
		EndIf
	EndIf
EndFunction

Function FoodDecay(Form[] FoodArray, Float[] ValueArray)
	Int i = 0
	While i < FoodArray.Length
		If FoodArray[i] != None && ((_SNQuest.TimeUpdate > TimeStampList[i]) || ValueArray[i] < 100.0)
			If ValueArray[i] >= 0.5
				Int FoodType = IsFood(FoodArray[i])
				If FoodType == 0
					If ValueArray[i] < 101.0
						ValueArray[i] = ValueArray[i] - ((RawDecayRate / 2.0) * (_SNQuest.TimeUpdate - TimeStampList[i]) * 24.0)						
					EndIf
				ElseIf FoodType == 1
					ValueArray[i] = ValueArray[i] - (LightDecayRate * (_SNQuest.TimeUpdate - TimeStampList[i]) * 24.0)
				Else
					ValueArray[i] = ValueArray[i] - (MedHeavyDecayRate * (_SNQuest.TimeUpdate - TimeStampList[i]) * 24.0)
				EndIf
				;Debug.Notification(_SNQuest.TimeUpdate + " - " + TimeStampList[i] + " = " + (_SNQuest.TimeUpdate - TimeStampList[i]) * 24.0)				;DEBUG
				TimeStampList[i] = _SNQuest.TimeUpdate
				If ValueArray[i] < 0.5
					Int SpoiledCount = targ.GetItemCount(FoodArray[i])
					targ.RemoveItem(FoodArray[i], SpoiledCount, true)
					targ.AddItem(_SNSpoiledFood, SpoiledCount, true)
					Debug.Notification(FoodArray[i].GetName() + _SNQuest.SpoilText)
				EndIf
			Else
				Int SpoiledCount = targ.GetItemCount(FoodArray[i])
				targ.RemoveItem(FoodArray[i], SpoiledCount, true)
				targ.AddItem(_SNSpoiledFood, SpoiledCount, true)
				Debug.Notification(FoodArray[i].GetName() + _SNQuest.SpoilText)
			EndIf
		EndIf
		i += 1
	EndWhile
EndFunction	

Function AddFood(Form Food, Float Expire, Float Value)
	Int i = 0
	While i < _SNQuest.FoodInventoryList.Length
		If _SNQuest.FoodInventoryList[i] == None
			_SNQuest.FoodInventoryList[i] = Food
			OriginalNameList[i] = Food.GetName()
			TimeStampList[i] = Expire
			_SNQuest.SatiationList[i] = Value
			If RenameInInventory
				RenameNewSingle(_SNQuest.FoodInventoryList[i], OriginalNameList[i], _SNQuest.SatiationList[i])
				targ.AddItem(_SNEmptyMiscItem, 1, true)
				targ.RemoveItem(_SNEmptyMiscItem, 1, true)
			EndIf
			Return
		Else
			i += 1
		EndIf
	EndWhile
EndFunction

Function RemoveFood(Form Food)
	Int i = 0
	While i < _SNQuest.FoodInventoryList.Length	
		If _SNQuest.FoodInventoryList[i] == Food
			_SNQuest.FoodInventoryList[i] = None
			OriginalNameList[i] = ""
			Return
		Else
			i += 1
		EndIf
	EndWhile
EndFunction

Int Function Round(Float i)
	If (i - (i as Int)) < 0.5
		Return (i as Int)
	Else
		Return (Math.Ceiling(i) as Int)
	EndIf
EndFunction

;====================================================================================

Event OnInit()
	targ = _SNQuest.PlayerRef
	Spoil_1 = _SNQuest.Spoil_1
	Spoil_2 = _SNQuest.Spoil_2
	Spoil_3 = _SNQuest.Spoil_3
	Spoil_4 = _SNQuest.Spoil_4
	Spoil_5 = _SNQuest.Spoil_5
	Spoil_6 = _SNQuest.Spoil_6
	AddInventoryEventFilter(_SNQuest._SNFood_RawList)
	AddInventoryEventFilter(_SNQuest._SNFood_LightList)
	AddInventoryEventFilter(_SNQuest._SNFood_SoupList)
	AddInventoryEventFilter(_SNQuest._SNFood_MedList)
	AddInventoryEventFilter(_SNQuest._SNFood_HeavyList)
	_SNQuest.FoodInventoryList = New Form[128]
	TimeStampList = New Float[128]
	_SNQuest.SatiationList = New Float[128]
	OriginalNameList = New String[128]
	RegisterForMenu("InventoryMenu")
	RegisterForSingleUpdateGameTime(1.0)
EndEvent

Event OnPlayerLoadGame()
	Spoil_1 = _SNQuest.Spoil_1
	Spoil_2 = _SNQuest.Spoil_2
	Spoil_3 = _SNQuest.Spoil_3
	Spoil_4 = _SNQuest.Spoil_4
	Spoil_5 = _SNQuest.Spoil_5
	Spoil_6 = _SNQuest.Spoil_6
	RegisterForMenu("InventoryMenu")
	FixFoodName(_SNQuest.FoodInventoryList, OriginalNameList)
EndEvent

Event OnMenuOpen(String MenuName)
	DisplayPercent = _SNQuest.DisplayPercent
	If !RenamingBack
		RenameInInventory = True
		RenameNew(_SNQuest.FoodInventoryList, OriginalNameList)
		targ.AddItem(_SNEmptyMiscItem, 1, true)
		targ.RemoveItem(_SNEmptyMiscItem, 1, true)
		
	EndIf
EndEvent

Event OnMenuClose(String MenuName)
	RenameInInventory = False
	RenamingBack = True
	RenameOld(_SNQuest.FoodInventoryList, OriginalNameList)
	Utility.Wait(0.25)
	RenamingBack = False
EndEvent

Event OnItemAdded(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akSourceContainer)
	Int FoodType = IsFood(akBaseItem)
	If !_SNQuest._SNFood_NoSpoilList.HasForm(akBaseItem) && FoodType > -1 && FormIndex(_SNQuest.FoodInventoryList, akBaseItem) == -1
		Float InitialState
		Bool FoundInWorld
		Bool RandomSpoilage
		Location CurrentLoc
		If !SearchDelay
			CurrentLoc = targ.GetCurrentLocation()
			If akSourceContainer
				If akSourceContainer.GetVoiceType() && FoodType != 0
					RandomSpoilage = True
				EndIf
			ElseIf !_SNQuest.IsCooking && FoodType != 0
				RandomSpoilage = True
				FoundInWorld = True
			EndIf
			SearchDelay = True
			RegisterForSingleUpdate(3.0)
		EndIf
		If RandomSpoilage && CurrentLoc && !CurrentLoc.HasKeyword(_SNQuest.LocTypeDwelling) && !CurrentLoc.HasKeyword(_SNQuest.LocTypeHabitation)
			If FoodType == 0 && FoundInWorld
				InitialState = Utility.RandomFloat(50.0, 150.0)
				If InitialState < 75.0
					InitialState = Utility.RandomFloat(50.0, 150.0)
				EndIf
			Else
				InitialState = Utility.RandomFloat(75.0, 175.0)
			EndIf
			If InitialState >= 100.0
				InitialState = 100.0
			EndIf
		Else
			If FoodType == 0 && _SNQuest.HarmfulRaw && akSourceContainer && akSourceContainer.HasKeyword(ActorTypeNPC)
				InitialState = Utility.RandomInt(100, 101) as Float
			Else
				InitialState = 100.0
			EndIf
		EndIf
		
		If InitialState == 100.0
			If FoodType == 0
				AddFood(akBaseItem, Utility.GetCurrentGameTime() + Utility.RandomFloat(_SNQuest.RawFreshness - 0.1, _SNQuest.RawFreshness + 0.1), InitialState)
			ElseIf FoodType == 1
				If _SNQuest.IsCooking
					AddFood(akBaseItem, Utility.GetCurrentGameTime() + Utility.RandomFloat(_SNQuest.LightFreshness, _SNQuest.LightFreshness + 1.0), InitialState)
				Else
					AddFood(akBaseItem, Utility.GetCurrentGameTime() + Utility.RandomFloat(_SNQuest.LightFreshness - 1.0, _SNQuest.LightFreshness + 1.0), InitialState)
				EndIf
			ElseIf FoodType == 2
				If _SNQuest.IsCooking
					AddFood(akBaseItem, Utility.GetCurrentGameTime() + Utility.RandomFloat(_SNQuest.MedFreshness, _SNQuest.MedFreshness + 0.2), InitialState)
				Else
					AddFood(akBaseItem, Utility.GetCurrentGameTime() + Utility.RandomFloat(_SNQuest.MedFreshness - 0.2, _SNQuest.MedFreshness + 0.2), InitialState)
				EndIf
			Else
				If _SNQuest.IsCooking
					AddFood(akBaseItem, Utility.GetCurrentGameTime() + Utility.RandomFloat(_SNQuest.HeavyFreshness, _SNQuest.HeavyFreshness + 0.15), InitialState)
				Else
					AddFood(akBaseItem, Utility.GetCurrentGameTime() + Utility.RandomFloat(_SNQuest.HeavyFreshness - 0.15, _SNQuest.HeavyFreshness + 0.15), InitialState)
				EndIf
			EndIf
		Else
			AddFood(akBaseItem, _SNQuest.TimeUpdate, InitialState)
		EndIf
	EndIf
	Utility.Wait(0.1)
EndEvent

Event OnItemRemoved(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akDestContainer)
	Utility.Wait(10.0)
	If targ.GetItemCount(akBaseItem) == 0
		RemoveFood(akBaseItem)
	EndIf
EndEvent

Event OnUpdate()
	SearchDelay = False
EndEvent

Event OnUpdateGameTime()
	If _SNQuest.EnableMod
		If CleanUpCount > 22
			CleanUp(_SNQuest.FoodInventoryList, OriginalNameList)
			CleanUpCount = 0
		Else
			CleanUpCount += _SNQuest.TimePassed
		EndIf
		Utility.Wait(1.0)
		If _SNQuest.InTheCold && _SNQuest.InTheCold.GetValue() as Int == 1 && _SNQuest.InTheColdTimed.GetValue() as Int == 0
			If InTheCold
				RawDecayRate = 1.0
				LightDecayRate = 0.33
				MedHeavyDecayRate = 0.67
			Else
				RawDecayRate = 1.5
				LightDecayRate = 0.5
				MedHeavyDecayRate = 1.0
			EndIf
			InTheCold = True
		Else
			If !InTheCold
				RawDecayRate = 3.0
				LightDecayRate = 1.0
				MedHeavyDecayRate = 2.0
			Else
				RawDecayRate = 2.25
				LightDecayRate = 0.75
				MedHeavyDecayRate = 1.5
			EndIf
			InTheCold = False
		EndIf
		FoodDecay(_SNQuest.FoodInventoryList, _SNQuest.SatiationList)
	EndIf
	RegisterForSingleUpdateGameTime(1.0)
EndEvent