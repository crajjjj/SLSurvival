Scriptname iDDeResCatSuitScr Extends zadEquipScript

Function SetDefaults()
	NumberOfKeysNeeded = 1
	If (!CatastrophicFailureChance)
		CatastrophicFailureChance = 10
	EndIf
	If (!CutDeviceEscapeChance)
		CutDeviceEscapeChance = 20
	EndIf
	If (!LockAccessDifficulty)
		LockAccessDifficulty = 1
	EndIf
	If (!KeyBreakChance)
		KeyBreakChance = 6.6
	EndIf
	If (!LockJamChance)
		LockJamChance = 16.6
	EndIf
	If (!BaseEscapeChance)
		BaseEscapeChance = 22.2
	EndIf
	If (!LockPickEscapeChance)
		LockPickEscapeChance = 16.6
	EndIf
EndFunction

Event OnEquipped(Actor akActor)
	SetDefaults()
	Parent.OnEquipped(akActor)
EndEvent

