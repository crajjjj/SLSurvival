Scriptname _MA_AddictItemAdded extends ReferenceAlias  

Bool Cooldown = false

Event OnInit()
	Cooldown = false
	If !Menu.InvoluntaryActions
		GoToState("InActive")
	EndIf
EndEvent

Event OnItemAdded(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akSourceContainer)
	If akBaseItem as Potion
		If akBaseItem.HasKeyword(MME_Milk)
			Debug.Trace("_MA_: _MA_AddictItemAdded - " + akBaseItem.GetName())
			If !Cooldown
				Cooldown = true
				TryAutoAction(akBaseItem)
			EndIf
		ElseIf JsonUtil.FormListHas("Milk Addict/Food.json", "FoodList", akBaseItem)
			If !Cooldown
				Cooldown = true
				TryAutoAction(akBaseItem)
			EndIf
		EndIf
	EndIf
EndEvent

State InActive
	Event OnItemAdded(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akSourceContainer)
	
	EndEvent
EndState

Function TryAutoAction(Form akBaseObject)
	Debug.Trace("_MA_: _MA_AddictItemAdded - TryAutoAction")
	If Init.ClearToTryAutoAction()
		Init.AddictEquipMilk(akBaseObject)
	EndIf
	Utility.WaitMenuMode(1.0)
	Cooldown = false
EndFunction

Keyword Property MME_Milk Auto

Actor Property PlayerRef Auto

_MA_Init Property Init Auto
_MA_Mcm Property Menu Auto

