ScriptName iDDeResGagScr Extends zadGagScript

Keyword Property iSUmKwdTypeMech Auto

STRING[] Function GetDefStruggleIdles()
	STRING[] sIdles = NEW STRING[1]
		sIdles[0] = "ft_struggle_gag_1"
	RETURN sIdles
EndFunction

Function SetDefaults()
	If (struggleIdles.Length < 1) ;only overwrite them if they are not already manually set in CK
		struggleIdles = GetDefStruggleIdles()
	EndIf
	If (!LockAccessDifficulty)
		LockAccessDifficulty = 15
	EndIf
	If (!KeyBreakChance)
		KeyBreakChance = 25.6
	EndIf
	If (!LockJamChance)
		LockJamChance = 33.3
	EndIf
	If (!BaseEscapeChance)
		BaseEscapeChance = 15.0
	EndIf
	If (!LockPickEscapeChance)
		LockPickEscapeChance = 15.6
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




