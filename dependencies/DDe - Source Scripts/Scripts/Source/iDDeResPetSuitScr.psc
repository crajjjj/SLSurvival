ScriptName iDDeResPetSuitScr Extends zadEquipScript

iDDeMain Property iDDe Auto

Keyword[] Function GetDefEquipConflictingDevices()
	Keyword[] kws = NEW Keyword[1]
		kws[0] = libs.zad_DeviousHeavyBondage
	RETURN kws
EndFunction

Function SetDefaults()
	If (EquipConflictingDevices.Length < 1)
		EquipConflictingDevices = GetDefEquipConflictingDevices()
	EndIf
EndFunction

Event OnEquipped(Actor akActor)
	SetDefaults()
	Parent.OnEquipped(akActor)
		If (iDDe.iDDeBlockActArm)
			akActor.AddPerk(iDDe.iDDe_PerkHeavyBondage)
		EndIf
EndEvent
Event OnUnequipped(Actor akActor)
	Parent.OnUnequipped(akActor)
		If (!akActor.WornHasKeyword(libs.zad_DeviousBondageMittens) && !akActor.WornHasKeyword(libs.zad_DeviousHeavyBondage) && akActor.HasPerk(iDDe.iDDe_PerkHeavyBondage))
			akActor.RemovePerk(iDDe.iDDe_PerkHeavyBondage)	
		EndIf 
EndEvent

