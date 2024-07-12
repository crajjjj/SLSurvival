Scriptname iDDeResHoodScr Extends zadEquipScript

Keyword Property iSUmKwdTypeMech Auto

STRING[] Function GetDefStruggleIdles()
	STRING[] sIdles = NEW STRING[1]
		sIdles[0] = "ft_struggle_head_1"
	RETURN sIdles
EndFunction

Function SetDefaults()
	If (struggleIdles.Length < 1) ;only overwrite them if they are not already manually set in CK
		struggleIdles = GetDefStruggleIdles()
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