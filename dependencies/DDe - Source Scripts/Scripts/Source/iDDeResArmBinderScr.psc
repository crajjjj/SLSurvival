ScriptName iDDeResArmBinderScr Extends zadEquipScript

iDDeMain Property iDDe Auto

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
		LockAccessDifficulty = 75
	EndIf
	If (!KeyBreakChance)
		KeyBreakChance = 6.6
	EndIf
	If (!LockJamChance)
		LockJamChance = 6.6
	EndIf
	If (!BaseEscapeChance)
		BaseEscapeChance = 15.0
	EndIf
	If (!LockPickEscapeChance)
		LockPickEscapeChance = 6.6
	EndIf
EndFunction

Event OnEquipped(Actor akActor)
	SetDefaults()
	Parent.OnEquipped(akActor)
		If (iDDe.iDDeBlockActArm)
			akActor.AddPerk(iDDe.iDDe_PerkHeavyBondage)
		EndIf
EndEvent
;Function OnEquippedPost(actor akActor)
;	akActor.UnequipItemSlot(36) ; Unequip ring to avoid clipping
;	Parent.OnEquippedPost(akActor)
;EndFunction

Event OnUnequipped(Actor akActor)
	Parent.OnUnequipped(akActor)
		If (!akActor.WornHasKeyword(libs.zad_DeviousBondageMittens) && !akActor.WornHasKeyword(libs.zad_DeviousHeavyBondage) && akActor.HasPerk(iDDe.iDDe_PerkHeavyBondage))
			akActor.RemovePerk(iDDe.iDDe_PerkHeavyBondage)	
		EndIf 
EndEvent


