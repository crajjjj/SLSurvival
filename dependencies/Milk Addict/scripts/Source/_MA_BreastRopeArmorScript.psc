Scriptname _MA_BreastRopeArmorScript extends ObjectReference  

Bool IsRopeEquipped = false
Bool InProgress = false
Actor TargetActor
ObjectReference RopeObjRef

Event OnEquipped(Actor akActor)
	If !akActor.HasSpell(_MA_BreastRopeSpell)
		akActor.AddSpell(_MA_BreastRopeSpell, false)
		IsRopeEquipped = true
		TargetActor = akActor
		GoToState("IgnoreUnequips")
		RopeObjRef = akActor.DropObject(WhatIAm)
		akActor.AddItem(RopeObjRef, 1, true)
		akActor.EquipItem(WhatIAm, false, true)
		GoToState("")
	EndIf
EndEvent

Event OnUnequipped(Actor akActor)
	Utility.Wait(1.0)
	If !akActor.WornHasKeyword(_MA_BreastRope) && IsRopeEquipped
		If akActor == PlayerRef
			Debug.Notification("You carefully cut the rope from around your aching breasts")
		EndIf
		akActor.RemoveSpell(_MA_BreastRopeSpell)
		akActor.RemoveItem(WhatIAm, 1)
		IsRopeEquipped = false
		TargetActor = None
	EndIf
EndEvent

Event OnContainerChanged(ObjectReference akNewContainer, ObjectReference akOldContainer)
	If akOldContainer == TargetActor && IsRopeEquipped
		TargetActor.AddItem(RopeObjRef, 1, true)
		TargetActor.EquipItem(WhatIAm, false, true)
	EndIf
	If akNewContainer as Actor && !InProgress && akNewContainer != None
		InProgress = true
		Int Rope1Count = akNewContainer.GetItemCount(BreastRope1)
		Int Rope2Count = akNewContainer.GetItemCount(BreastRope2)
		While Rope1Count + Rope2Count > 2
			InProgress = true
			If Rope2Count > 0
				akNewContainer.RemoveItem(BreastRope2, 1)
			Else
				akNewContainer.RemoveItem(BreastRope1, 1)
			EndIf
			Debug.Notification("The ropes are too bulky to carry more than two")
			Rope1Count = akNewContainer.GetItemCount(BreastRope1)
			Rope2Count = akNewContainer.GetItemCount(BreastRope2)
		EndWhile
		InProgress = false
	EndIf
EndEvent

State IgnoreUnequips
	Event OnUnequipped(Actor akActor)
	EndEvent
EndState

Actor Property PlayerRef Auto

Spell Property _MA_BreastRopeSpell Auto

Armor Property WhatIAm Auto
Armor Property BreastRope1 Auto
Armor Property BreastRope2 Auto

Keyword Property _MA_BreastRope Auto
