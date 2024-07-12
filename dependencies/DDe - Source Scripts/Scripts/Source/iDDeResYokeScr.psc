ScriptName iDDeResYokeScr Extends zadYokeScript

STRING[] Function GetDefStruggleIdles()
	STRING[] sIdles = NEW STRING[5]
		sIdles[0] = "DDRegYokeStruggle01"
		sIdles[1] = "DDRegYokeStruggle02"
		sIdles[2] = "DDRegYokeStruggle03"
		sIdles[3] = "DDRegYokeStruggle04"
		sIdles[4] = "DDRegYokeStruggle05"
	RETURN sIdles
EndFunction

STRING[] Function GetDefStruggleIdlesHob()
	STRING[] sIdles = NEW STRING[2]
		sIdles[0] = "DDHobYokeStruggle01"
		sIdles[1] = "DDHobYokeStruggle02"
	RETURN sIdles
EndFunction

Keyword[] Function GetDefEquipConflictingDevices ()
	Keyword[] kws = NEW Keyword[1]
		kws[0] = libs.zad_DeviousHeavyBondage
	RETURN kws
EndFunction 

Function SetDefaults()
	If (struggleIdles.Length < 1) ;only overwrite them if they are not already manually set in CK
		struggleIdles = GetDefStruggleIdles()
	EndIf
	If (struggleIdlesHob.Length < 1)
		struggleIdlesHob = GetDefStruggleIdlesHob()
	EndIf
	If (EquipConflictingDevices.Length < 1)
		EquipConflictingDevices = GetDefEquipConflictingDevices()
	EndIf
	NumberOfKeysNeeded = 2	
	If (!LockAccessDifficulty)
		LockAccessDifficulty = 95
	EndIf
	If (!KeyBreakChance)
		KeyBreakChance = 26.6
	EndIf
	If (!LockJamChance)
		LockJamChance = 16.6
	EndIf
	If (!BaseEscapeChance)
		BaseEscapeChance = 5.0
	EndIf
	If (!LockPickEscapeChance)
		LockPickEscapeChance = 6.6
	EndIf
EndFunction

Event OnEquipped(Actor akActor)
	SetDefaults()
	Parent.OnEquipped(akActor)
EndEvent

