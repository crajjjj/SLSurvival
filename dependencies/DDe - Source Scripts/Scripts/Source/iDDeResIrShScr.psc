Scriptname iDDeResIrShScr Extends zadRestraintScript 

STRING[] Function GetBoundStruggleIdles()
	STRING[] sIdles = NEW STRING[5]
		sIdles[0] = "DDRegArmbStruggle01"
		sIdles[1] = "DDRegArmbStruggle02"
		sIdles[2] = "DDRegArmbStruggle03"
		sIdles[3] = "DDRegArmbStruggle04"
		sIdles[4] = "DDRegArmbStruggle05"
	RETURN sIdles
EndFunction

STRING[] Function GetBoundStruggleIdlesHob()
	STRING[] sIdles = NEW STRING[2]
		sIdles[0] = "DDHobArmbStruggle01"
		sIdles[1] = "DDHobArmbStruggle02"
	RETURN sIdles
EndFunction

Keyword[] Function GetEquipConflictingDevices()
	Keyword[] kws = NEW Keyword[3]
		kws[0] = libs.zad_DeviousArmbinderElbow
		kws[1] = libs.zad_DeviousYoke
		kws[2] = libs.zad_DeviousPetSuit
	RETURN kws
EndFunction

Function SetDefaults()
	If (struggleIdles.Length < 1) 
		struggleIdles = GetBoundStruggleIdles()
	EndIf
	If (struggleIdlesHob.Length < 1)
		struggleIdlesHob = GetBoundStruggleIdlesHob()
	EndIf
	If (EquipConflictingDevices.Length < 1)
		EquipConflictingDevices = GetEquipConflictingDevices()
	EndIf
EndFunction

Event OnEquipped(Actor akActor)
	SetDefaults()
	Parent.OnEquipped(akActor)
EndEvent




