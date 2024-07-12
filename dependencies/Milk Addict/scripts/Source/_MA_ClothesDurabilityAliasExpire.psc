Scriptname _MA_ClothesDurabilityAliasExpire extends ReferenceAlias  

Actor Property PlayerRef Auto
ObjectReference Property _MA_GarbageDisposal Auto

ObjectReference WhereIAm = None
Float Property LastEquipped = 0.0 Auto

Event OnContainerChanged(ObjectReference akNewContainer, ObjectReference akOldContainer)
	;Debug.Messagebox("akNewContainer: " + akNewContainer + ". akOldContainer: " + akOldContainer)
	WhereIAm = akNewContainer

	If WhereIAm != PlayerRef
		RegisterForSingleUpdateGameTime(24.0)
	Else
		UnregisterForUpdateGameTime()
	EndIf
EndEvent

Event OnUpdateGameTime()
	If WhereIAm != PlayerRef
		 RecycleAlias()
	EndIf
EndEvent

Function RecycleAlias()
	Debug.Trace("_MA_: Recycled RefAlias to: " + self.GetReference().GetBaseObject().GetName())
	StorageUtil.FormListRemove(none, "_MA_ClothesDurabilityList", Self.GetReference(), allInstances = false)
	StorageUtil.UnsetIntValue(self.GetReference(), "_MA_ClothesDurability")
	LastEquipped = 0.0
	UnregisterForUpdateGameTime()
	_MA_GarbageDisposal.RemoveItem(Self.GetReference().GetBaseObject())
	Self.Clear()
EndFunction

Event OnEquipped(Actor akActor)
	If akActor == PlayerRef
		LastEquipped = Utility.GetCurrentGameTime()
	EndIf
endEvent