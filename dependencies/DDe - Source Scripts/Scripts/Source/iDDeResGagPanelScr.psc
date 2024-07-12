ScriptName iDDeResGagPanelScr Extends zadGagPanelScript

STRING[] Function GetDefStruggleIdles()
	STRING[] sIdles = NEW STRING[1]
		sIdles[0] = "ft_struggle_gag_1"
	RETURN sIdles
EndFunction

Function SetDefaults()
	If (struggleIdles.Length < 1) 
		struggleIdles = GetDefStruggleIdles()
	EndIf
	If (!LockAccessDifficulty)
		LockAccessDifficulty = 15.6
	EndIf
	If (!KeyBreakChance)
		KeyBreakChance = 25.6
	EndIf
	If (!LockJamChance)
		LockJamChance = 33.3
	EndIf
	If (!BaseEscapeChance)
		BaseEscapeChance = 15.6
	EndIf
	If (!LockPickEscapeChance)
		LockPickEscapeChance = 15.6
	EndIf
EndFunction

Event OnEquipped(Actor akActor)
	SetDefaults()
	Parent.OnEquipped(akActor)
EndEvent


