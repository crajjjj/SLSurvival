Scriptname iDDeResArmShScr Extends zadRestraintArmsScript 

STRING[] Function GetDefStruggleIdles()
	STRING[] sIdles = NEW STRING[5]
		sIdles[0] = "DDRegArmbStruggle01"
		sIdles[1] = "DDRegArmbStruggle02"
		sIdles[2] = "DDRegArmbStruggle03"
		sIdles[3] = "DDRegArmbStruggle04"
		sIdles[4] = "DDRegArmbStruggle05"
	RETURN sIdles
EndFunction

STRING[] Function GetDefStruggleIdlesHob()
	STRING[] sIdles = NEW STRING[2]
		sIdles[0] = "DDHobArmbStruggle01"
		sIdles[1] = "DDHobArmbStruggle02"
	RETURN sIdles
EndFunction

Keyword[] Function GetDefEquipConflictingDevices()
	Keyword[] kws = NEW Keyword[1]
		kws[0] = libs.zad_DeviousHeavyBondage
	RETURN kws
EndFunction

Function SetDefaults()
	If (struggleIdles.Length < 1) 
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
		LockAccessDifficulty = 33.3
	EndIf
	If (!KeyBreakChance)
		KeyBreakChance = 6.6
	EndIf
	If (!LockJamChance)
		LockJamChance = 6.6
	EndIf
	If (!BaseEscapeChance)
		BaseEscapeChance = 10.0
	EndIf
	If (!LockPickEscapeChance)
		LockPickEscapeChance = 16.6
	EndIf
EndFunction

Event OnEquipped(Actor akActor)
	SetDefaults()
	Parent.OnEquipped(akActor)
EndEvent




