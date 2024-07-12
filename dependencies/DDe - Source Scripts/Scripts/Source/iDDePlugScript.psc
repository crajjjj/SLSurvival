ScriptName iDDePlugScript Extends zadPlugScript

Keyword[] Function GetDefEquipConflictingDevices()
	Keyword[] kws = NEW Keyword[2]
		kws[0] = libs.zad_DeviousBelt
		kws[1] = libs.zad_DeviousHarness
	RETURN kws
EndFunction

Function SetDefaults()
	If (EquipConflictingDevices.Length < 1)
		EquipConflictingDevices = GetDefEquipConflictingDevices()
	EndIf
	If (UnEquipConflictingDevices.Length < 1)
		UnEquipConflictingDevices = GetDefEquipConflictingDevices()
	EndIf
EndFunction

Event OnEquipped(Actor akActor)
	SetDefaults()
	Parent.OnEquipped(akActor)
EndEvent
