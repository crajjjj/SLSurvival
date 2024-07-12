ScriptName iDDeResElbowBinderScr Extends zadEquipScript

iDDeMain Property iDDe Auto

STRING[] Function GetDefStruggleIdles()
	STRING[] sIdles = NEW STRING[5]
		sIdles[0] = "DDRegElbStruggle01"
		sIdles[1] = "DDRegElbStruggle02"
		sIdles[2] = "DDRegElbStruggle03"
		sIdles[3] = "DDRegElbStruggle04"
		sIdles[4] = "DDRegElbStruggle05"
	RETURN sIdles
EndFunction

STRING[] Function GetDefStruggleIdlesHob()
	STRING[] sIdles = NEW STRING[2]
		sIdles[0] = "DDHobElbStruggle01"
		sIdles[1] = "DDHobElbStruggle02"
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
		LockAccessDifficulty = 95
	EndIf
	If (!KeyBreakChance)
		KeyBreakChance = 25.0
	EndIf
	If (!LockJamChance)
		LockJamChance = 33.3
	EndIf
	If (!BaseEscapeChance)
		BaseEscapeChance = 5.0
	EndIf
	If (!LockPickEscapeChance)
		LockPickEscapeChance = 6.6
	EndIf
	If (!EscapeCooldown)
		EscapeCooldown = 0.6
	EndIf
	If (!UnlockCooldown)
		UnlockCooldown = 0.6
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
	;akActor.UnequipItemSlot(36) ; Unequip ring to avoid clipping
	;Parent.OnEquippedPost(akActor)
;EndFunction

Event OnUnequipped(Actor akActor)
	Parent.OnUnequipped(akActor)
		If (!akActor.WornHasKeyword(libs.zad_DeviousBondageMittens) && !akActor.WornHasKeyword(libs.zad_DeviousHeavyBondage) && akActor.HasPerk(iDDe.iDDe_PerkHeavyBondage))
			akActor.RemovePerk(iDDe.iDDe_PerkHeavyBondage)	
		EndIf 
EndEvent



