Scriptname _MA_RippedClothes extends ObjectReference  

Event OnEquipped(Actor akActor)
	If akActor == PlayerRef
		PlayerRef.UnEquipItem(_MA_TornClothes)
		Debug.Notification("These clothes are so torn they just slip from your body")
	EndIf
EndEvent

Event OnContainerChanged(ObjectReference akNewContainer, ObjectReference akOldContainer)
	If akNewContainer == TaarieRef
		; Only trade one item
		If Utility.IsInMenuMode()
			Input.TapKey(15)
		EndIf
	EndIf
EndEvent

Actor Property TaarieRef Auto
Actor Property PlayerRef  Auto  
Armor Property _MA_TornClothes  Auto  
