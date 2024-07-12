Scriptname iDDeResMaskScr Extends zadEquipScript

Keyword Property iSUmKwdTypeMech Auto

Keyword[] Function GetDefEquipConflictingDevices()
	Keyword[] kws = NEW Keyword[2]
		kws[0] = libs.zad_DeviousGag
		kws[1] = libs.zad_DeviousBlindfold
	RETURN kws
EndFunction

STRING[] Function GetDefStruggleIdles()
	STRING[] sIdles = NEW STRING[1]
		sIdles[0] = "ft_struggle_head_1"
	RETURN sIdles
EndFunction

INT iBusy = 0

Function SetDefaults()
	If (struggleIdles.Length < 1) ;only overwrite them if they are not already manually set in CK
		struggleIdles = GetDefStruggleIdles()
	EndIf
	If (EquipConflictingDevices.Length < 1)
		EquipConflictingDevices = GetDefEquipConflictingDevices()
	EndIf
	NumberOfKeysNeeded = 1	
	If (!LockAccessDifficulty)
		LockAccessDifficulty = 15
	EndIf
	If (!KeyBreakChance)
		KeyBreakChance = 16.6
	EndIf
	If (!LockJamChance)
		LockJamChance = 16.6
	EndIf
	If (!BaseEscapeChance)
		BaseEscapeChance = 20.0
	EndIf
	If (!LockPickEscapeChance)
		LockPickEscapeChance = 16.6
	EndIf
EndFunction

Event OnEquipped(Actor akActor)
	SetDefaults()
	Parent.OnEquipped(akActor)
EndEvent

INT Function OnContainerChangedFilter(ObjectReference akNewContainer, ObjectReference akOldContainer)
	If (!akNewContainer && akOldContainer && deviceRendered.HasKeyword(iSUmKwdTypeMech))
		Actor akActor = (akOldContainer AS Actor)
		If (!akActor.IsEquipped(deviceInventory) && !akActor.IsEquipped(deviceRendered))
			libs.Log(deviceName+ " dropped.")
			Self.Delete()
			RETURN 1
		EndIf
	EndIf
	RETURN Parent.OnContainerChangedFilter(akNewContainer, akOldContainer)
EndFunction
