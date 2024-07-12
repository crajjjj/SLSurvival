Scriptname _MA_ClothesSearch extends ObjectReference

Event OnTriggerEnter(ObjectReference akActionRef)
	If akActionRef == PlayerRef
		InTrigger += 1
		ClothesFound = false
		If Count != 0 ; Not first time in trigger
			Debug.Notification("I'm certain my " + LostItem.GetBaseObject().GetName() + " is around here somewhere")
		EndIf
		Count += 1
		
		While PlayerRef.IsInCombat()
			Utility.Wait(2)
		EndWhile

		Int Timer = TimeToFindClothes
		While Timer > 0 && InTrigger > 0 && !ClothesFound
			Timer -=1
			If PlayerRef.IsInCombat()
				Timer = TimeToFindClothes
			EndIf
			Utility.Wait(1.0)
		EndWhile
		If InTrigger && !ClothesFound
			PlayerRef.AddItem(LostItem, 1, true)
			Debug.Notification("There's my " + LostItem.GetBaseObject().GetName())
			Count = 0
		EndIf
	EndIf
EndEvent

Event OnTriggerLeave(ObjectReference akActionRef)
	If akActionRef == PlayerRef
		InTrigger -= 1
		If LostItem != None
			If PlayerRef.IsInCombat()
				Debug.Notification(LostItem.GetBaseObject().GetName() + " isn't worth dying for")
			Else
				Debug.Notification(LostItem.GetBaseObject().GetName() + " isn't worth the hassle")
			EndIf
		EndIf
	EndIf
EndEvent

Function ResetLostItem (ObjectReference NewLostItem)
	If LostItem != None && LostItem.GetBaseObject() != _MA_TornClothes
		_MA_TornOverflow.AddItem(LostItem.GetBaseObject(), 1)
	EndIf
	InTrigger = 0
	LostItem = NewLostItem
	Count = 0
	TimeToFindClothes = Menu.TimeToFindClothes
EndFunction

Function ShutdownTrigger() ; Item found already
	LostItem = None
	ClothesFound = True
	Count = 0
	InTrigger = 0
	Self.Disable()
EndFunction

Bool ClothesFound = false
Int TimeToFindClothes = 10
Int Count = 0
Int InTrigger = 0
ObjectReference Property LostItem Auto
ObjectReference Property _MA_TornOverflow Auto  
Actor Property PlayerRef Auto
Armor Property _MA_TornClothes Auto
_MA_Mcm Property Menu Auto
