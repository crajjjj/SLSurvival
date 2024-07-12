Scriptname _MA_DroppedClothesContainerTrack extends ReferenceAlias

; Do I really need to track what contains an object reference this way....?

ObjectReference Property WhereIAm Auto
Actor Property PlayerRef Auto

Event OnContainerChanged(ObjectReference akNewContainer, ObjectReference akOldContainer)
	WhereIAm = akNewContainer
	If WhereIAm == PlayerRef
		Int SlotMask = (Self.GetReference().GetBaseObject() as Armor).GetSlotMask()
		If Math.LogicalAnd(SlotMask, 4) == 4 ; Body
			_MA_ClothesSearchBodyScript.ShutdownTrigger()
		ElseIf Math.LogicalAnd(SlotMask, 128) == 128 ; Feet
			_MA_ClothesSearchFeetScript.ShutdownTrigger()
		ElseIf Math.LogicalAnd(SlotMask, 8) == 8 ; Hands
			_MA_ClothesSearchHandsScript.ShutdownTrigger()
		ElseIf Math.LogicalAnd(SlotMask, 2) == 2 ; Hair
			_MA_ClothesSearchHeadScript.ShutdownTrigger()
		EndIf
	EndIf
EndEvent

_MA_ClothesSearch Property _MA_ClothesSearchBodyScript Auto
_MA_ClothesSearch Property _MA_ClothesSearchFeetScript Auto
_MA_ClothesSearch Property _MA_ClothesSearchHandsScript Auto
_MA_ClothesSearch Property _MA_ClothesSearchHeadScript Auto