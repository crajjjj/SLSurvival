Scriptname _SLS_AmpHelplessFolEquipUpdate extends ReferenceAlias  

Function LoadAlias(Actor akActor)
	Self.ForceRefTo(akActor)
	RegisterForSingleUpdateGameTime(3.0)
EndFunction

Event OnUpdateGameTime()
	Actor akActor = Self.GetReference() as Actor
	If akActor
		StorageUtil.UnsetIntValue(akActor, "_SLS_AmpFollowerWillNotEquip")
	EndIf
	Self.Clear()
	UnRegisterForUpdateGameTime()
EndEvent
